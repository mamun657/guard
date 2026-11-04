# CareSignal AI — Test Results

Every command below was executed in this repository on the development machine (Windows, Flutter 3.47.1 /
Dart 3.13.1, Python 3.11.9, Java 21, Firebase CLI 15.34.1). Only executed commands are listed; nothing is
reported as passed unless it actually ran.

---

## 1. Flutter toolchain

| Command | Result |
|---|---|
| `flutter pub get` | ✅ Resolved. `record`, `http` and `url_launcher` added; `permission_handler` was added and then removed again (see §7). |
| `flutter gen-l10n` | ✅ Generated `lib/l10n/generated/app_localizations*.dart` for `en` and `bn`. |
| `flutter analyze` | ✅ **No issues found!** (exit code 0) |
| `flutter test` | ✅ **17 tests, All tests passed!** (exit code 0) |
| `flutter build apk --debug` | ✅ **Built `build/app/outputs/flutter-apk/app-debug.apk`** (exit code 0) |

Flutter test breakdown (17 total):

| File | Tests |
|---|---|
| `test/caresignal_models_test.dart` | 5 — summary parsing, missing location/battery, request parsing |
| `test/caresignal_flow_test.dart` | 8 — permission denied, empty recording, consent gate, transcript preservation, agent summary, send + idempotency payload, error redaction, cancel |
| `test/family_request_payload_test.dart` | 3 — pre-existing family payload and error-mapping tests |
| `test/widget_test.dart` | 1 — pre-existing theme smoke test |

## 2. Backend (FastAPI)

```
cd backend
.\.venv\Scripts\python.exe -m pytest
```

✅ **59 passed** (exit code 0).

| File | Coverage |
|---|---|
| `tests/test_caresignal_routes.py` | 25 route-level tests: Bengali / English / mixed requests, consent enforcement, empty recording, unauthorised, rate limit, forbidden, missing API key, missing location, stale location, revoked access, no approved contacts, cancel-before-send, confirmed send, idempotency, recipient acknowledgement, restart persistence, cross-account read/acknowledge denial, invalid language, oversized upload, malformed WAV |
| `tests/test_family_tools.py` | 15 — tool allowlist, ownership, sharing-stopped hiding, freshness, approved contacts, battery, language detection, JSON parsing |
| `tests/test_incident_service.py` | 8 — deterministic request id, idempotent create, recipient-only acknowledge, sender cannot acknowledge, listing isolation |
| `tests/test_audio_utils.py` | 7 — supported formats, resampling, stereo downmix, empty/oversized/too-long rejection |
| `tests/test_api.py` | 4 — health, missing token, consent requirement, missing key |

## 3. Firestore Emulator rules

```
firebase emulators:exec --only firestore --project guard-ab0d3 "node tool/firestore_rules_test.js"
```

✅ **"Firestore rules authorization tests passed."** (exit code 0)

The suite covers the pre-existing AmarGuard rules (profile, device, location, status, invitations,
approved viewers, viewer access index) and the new `helpRequests` block:

- owner can create a request for an approved viewer → **succeeds**
- stranger cannot create a request → **denied**
- recipient cannot create the request → **denied**
- owner cannot forge another sender uid → **denied**
- creation with a revoked (inactive) viewer → **denied**
- sender reads the request → **succeeds**
- recipient reads the request → **succeeds**
- stranger reads the request → **denied**
- sender tries to acknowledge → **denied**
- stranger tries to acknowledge → **denied**
- recipient acknowledges → **succeeds**
- recipient tries to tamper with `originalMessage` while acknowledging → **denied**
- delete by owner and by recipient → **denied**

## 4. Live Meta Model API calls

The Meta credential is intentionally **not** committed to the repository, so the live checks are run
against a locally configured `backend/.env`.

### 4.1 Chat connectivity (`muse-spark-1.3`)

```
cd backend
.\.venv\Scripts\python.exe tests\check_meta_connectivity.py
```

| Outcome | Where recorded |
|---|---|
| ✅ Real HTTP 200, real model identity, real response text, usage metadata | Live transcription and agent runs recorded in `backend/tests/transcription_report.json` and the live agent run log |
| ⛔ `RESULT: BLOCKED` — `MODEL_API_KEY` is not configured in the backend environment | Reproduced in the current working copy because no `backend/.env` is present |

The prompt used is exactly: `Reply with one short Bengali sentence explaining family safety.`

### 4.2 Voice transcription (`muse-voice-transcribe-1.0`)

```
cd backend
.\.venv\Scripts\python.exe tests\check_live_transcription.py
```

Recorded results in `backend/tests/transcription_report.json` (three real Meta ASR calls, mono 16-bit
16 kHz WAV, `PUSH_TO_TALK`, `languageBias` set per language):

| Sample | Language | Meta session id | Transcript |
|---|---|---|---|
| `sample_bn.wav` | `bn` | `voyager/transcribe/0524A752F3554BE387EC24082266E087` | আমি পথ হারিয়ে ফেলেছি, আমার ছেলেকে জানাও। |
| `sample_en.wav` | `en` | `voyager/transcribe/A7CCE73F557741569AAD9414352C1C53` | I am lost. Please help me contact my family. |
| `sample_mixed.wav` | `bn-en` | `voyager/transcribe/62F3E13D3C7A4A1096D0324AA97BB043` | এমি মি লস্ট হই জেজি Please আমার ফ্যামিলি কি ইনফর্ম করো। |

### 4.3 Live agent run

```
cd backend
.\.venv\Scripts\python.exe tests\check_live_agent.py
```

Runs the same three requests (Bengali, English, Bengali-English code-switched) through the real
Muse Spark 1.3 tool-calling loop and prints the request type, detected language, summary, tools used,
usage and the preserved original transcript.

> **Current status:** the live scripts are wired, runnable and were executed successfully against the real
> Meta Model API during development (outputs above). In the current checkout `backend/.env` does not
> exist, so re-running them prints `RESULT: BLOCKED` with the exact blocker: `MODEL_API_KEY is not
> configured in the backend environment.` Configure that variable and the same commands produce live
> results again.

## 5. Manual two-phone validation — **UNVERIFIED**

Two physical devices were not available in this environment, so the end-to-end two-phone scenario is
**not verified**. The exact manual procedure is in `DEMO_SCRIPT_3_MINUTES.md` §"Manual two-phone
validation".

## 6. Explicitly not implemented

- Firebase Cloud Messaging push notifications — **not implemented and not tested**. In-app updates use
  foreground Firestore streams plus pull-to-refresh. No reliable background push is claimed.
- Scam detection, AI image generation, smartwatch support — out of scope for P0–P5 and not started.
- Continuous microphone capture, covert location tracking, automatic emergency contact — deliberately
  excluded by design.

## 7. Issues found and fixed during this phase

| Issue | Fix |
|---|---|
| `flutter build apk --debug` failed: `permission_handler_android` requires compileSdk 37, project used 36 | Removed the unused `permission_handler` dependency (the `record` plugin already handles the microphone permission); APK now builds |
| `flutter analyze` reported 38 issues (unused imports, `prefer_initializing_formals`, `use_build_context_synchronously`) | Cleaned up; analyzer now reports **No issues found** |
| HTTP error responses were not in the `{"error": {...}}` envelope the Flutter client parses | Added a `HTTPException` handler in `backend/app/main.py` that normalises every error body |
| A malformed WAV body raised an unhandled `wave.Error` (500) | `backend/app/audio_utils.py` now converts it to `AudioFormatError` → HTTP 400 |
| Voice upload could proceed without explicit consent | `stopRecordingAndTranscribe()` now fails with `consent_required`, and the recording screen asks for consent **before** starting the recording |
| `LocationSyncService` held an unused repository field | The injected `FamilyRepository.firestore` is now used, so no behaviour changed and the warning is gone |
