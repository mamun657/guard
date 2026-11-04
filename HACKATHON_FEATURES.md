# CareSignal AI — Hackathon Feature Sheet

Everything in this document was built during the Meta Global AI Developer Hackathon 2026 and is
separable from the pre-existing AmarGuard product. The pre-existing product covered Firebase Auth,
Firestore family connections, GPS location sharing, member rename, member removal and EN/BN
localisation; none of that was rewritten.

## 1. What the feature does

A family member who feels lost, stranded or simply needs to reach a relative opens **CareSignal AI →
Need Help**, speaks a short request in Bengali, English or code-switched Bengali-English, and gets a
reviewable help report. Nothing is sent to the family until they confirm.

## 2. End-to-end flow

```
Need Help (Family Safety)
   → consent dialog (Meta AI processing permission)
   → push-to-talk recording (timer, stop / cancel)
   → WAV normalisation (mono 16-bit, 16 kHz or 24 kHz)
   → Meta Muse Voice Transcribe 1.0  (POST /asr/transcribe, PUSH_TO_TALK)
   → transcript review (editable, original kept separately)
   → Meta Muse Spark 1.3 tool-calling agent
   → AI assistance report
   → Confirm & Send (recipient picker + what-shares-what review)
   → Firestore helpRequests document
   → recipient Family Help Inbox
   → recipient acknowledges
   → sender sees the acknowledgement
```

## 3. Screens delivered

| Screen | File |
|---|---|
| CareSignal AI Home | `lib/features/family_safety/screens/caresignal_home_screen.dart` |
| Need Help Recording | `lib/features/family_safety/screens/caresignal_recording_screen.dart` |
| Voice Transcript Review | `lib/features/family_safety/screens/caresignal_transcript_screen.dart` |
| AI Processing | `lib/features/family_safety/screens/caresignal_processing_screen.dart` |
| AI Help Summary | `lib/features/family_safety/screens/caresignal_summary_screen.dart` |
| Family Help Inbox | `lib/features/family_safety/screens/caresignal_inbox_screen.dart` |
| Family Response Details | `lib/features/family_safety/screens/caresignal_response_screen.dart` |
| Shared CareSignal widgets | `lib/features/family_safety/screens/caresignal_widgets.dart` |

Confirm-and-send is implemented inside the AI Help Summary screen (recipient picker, "Send now"
confirmation dialog and the sent confirmation dialog) rather than as a separate route.

## 4. Visual identity

The existing AmarGuard Family Safety palette is reused unchanged:

| Role | Hex |
|---|---|
| Primary Teal | `#0D756D` |
| Dark Navy | `#13293D` |
| Mint | `#31BBAE` |
| Warm Gold | `#FFBE55` |
| Coral | `#F47767` |
| Ivory | `#FFF9EF` |

No new animation library was added — transitions use `MaterialPageRoute`, `CircularProgressIndicator`
and `RefreshIndicator` only.

## 5. Bilingual support

- Every new string lives in `lib/l10n/app_en.arb` and `lib/l10n/app_bn.arb`.
- The app language drives the AI language: `bn` stays Bengali, `en` uses the bilingual `bn-en` mode so
  code-switched speech is still handled.
- The original voice transcript is stored in `original_transcript`; the user-corrected text is stored in
  `user_confirmed_transcript`. The AI interpretation never overwrites either.

## 6. Agent tools (allowlisted, permission-checked)

| Tool | Returns |
|---|---|
| `get_current_user_identity` | Authenticated account identity and device id |
| `get_approved_family_contacts` | Only viewers with `active == true` on the caller's own device |
| `get_own_device_sharing_status` | Own device sharing state |
| `get_last_authorized_location` | Last known location, accuracy, capture time, freshness |
| `get_location_last_sync_time` | Last successful upload and heartbeat |
| `get_last_reported_battery` | Last reported battery level and charging flag |
| `get_connection_status` | Sharing state and recent-connectivity flag |

Every tool resolves its own Firestore path from the authenticated UID and the requested device id. The
model cannot pass a collection path, cannot read another account's data, and cannot widen its own
permissions. Unknown tool names raise an error instead of reaching Firestore.

## 7. Safety rules baked into the model prompt and the code

- Never invent coordinates, addresses, battery percentages, timestamps or connectivity
- Always call the location "last known location", never "live"
- Never claim the user is in danger, never diagnose, never risk-score, never contact emergency services
- Offline or low battery is reported as a fact, never as a danger conclusion
- If location sharing is stopped or revoked, no coordinates are disclosed
- If location is unavailable, the report says it is unavailable

## 8. Consent model

| Moment | What the user does |
|---|---|
| Before recording | Answers the Meta AI processing consent dialog |
| Before sending | Reviews transcript, summary, shared data and picks the recipient, then confirms |
| Recipient side | Acknowledges the request |

The backend independently rejects any transcription request whose `consent_to_process` flag is false,
and rejects any help request whose recipient is not an approved viewer.

## 9. Firestore schema addition

New collection `helpRequests`, one document per request:

```
requestId, senderUid, senderDeviceId, recipientUid, requestedAt (server timestamp),
language, originalMessage, originalTranscript, verifiedDataSnapshot, generatedSummary,
status ('sent' | 'acknowledged'), acknowledgedAt
```

Rules: only the sender and the intended recipient can read; only the sender can create and only for an
approved viewer of the sender's own device; only the recipient can acknowledge; privileged fields are
immutable on update; nobody can delete. Request ids are derived from a sender-scoped idempotency key,
so a repeated send reuses the same document instead of creating a duplicate alert.
