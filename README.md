# 🛡️ AmarGuard

## AI-Powered Digital Safety Companion

<p align="center">

**UNDERSTAND BEFORE YOU TRUST.**

</p>

<p align="center">

<img src="https://img.shields.io/badge/Flutter-Mobile%20App-02569B?style=for-the-badge&logo=flutter&logoColor=white">
<img src="https://img.shields.io/badge/Dart-Application-0175C2?style=for-the-badge&logo=dart&logoColor=white">
<img src="https://img.shields.io/badge/Firebase-Backend%20Services-FFCA28?style=for-the-badge&logo=firebase&logoColor=black">
<img src="https://img.shields.io/badge/AI-Digital%20Safety-F5B51B?style=for-the-badge">
<img src="https://img.shields.io/badge/Platform-Android-34A853?style=for-the-badge&logo=android&logoColor=white">

</p>

---

# 📥 Download App

<p align="center">

<a href="https://github.com/mamun657/AmarGuard/releases/download/v1.0.0/AmarGuard.apk">   Download AmarGuard APK

</a>

</p>


---

# 📌 Project Overview

**AmarGuard** is a Bangla-first, AI-assisted digital safety and family protection platform designed to help users recognize potential digital threats and stay connected with their trusted family members.

Its core digital safety feature, **ScamShield**, analyzes suspicious messages to identify potential scam indicators and provide understandable risk insights. Alongside this, **Family Safety** enables consent-based family connections, location sharing, and access to available device-status information.

AmarGuard also incorporates **CareSignal AI**, a voice-assisted help-request workflow designed to support communication with approved family contacts.

The platform follows a user-centered safety approach:

```text
Detect
   ↓
Understand
   ↓
Explain
   ↓
Protect
```

AmarGuard aims to make digital interactions safer and family support more accessible through AI-assisted analysis and consent-based safety features.

---

# 🎯 Problem Statement

Digital fraud does not always start with a suspicious link.

Many risky interactions begin with normal-looking conversations involving:

* Urgent payment requests
* OTP or PIN requests
* Fake account warnings
* Impersonation
* Prize or reward claims
* Fake job offers
* Delivery scams
* Investment requests
* Authority claims
* Threatening language
* Requests for secrecy

Users often struggle to understand whether an interaction is genuinely risky and, more importantly, **why it is risky**.

Common problems include:

* Difficulty recognizing manipulation patterns
* Lack of understandable risk explanations
* Confusion caused by urgency or threats
* Difficulty evaluating suspicious messages
* Difficulty understanding unfamiliar links
* Lack of Bangla-first safety tools
* Uncertainty about what to do next

AmarGuard focuses on the interaction itself rather than only checking a single URL or phone number.

---

# 💡 Purpose

The purpose of AmarGuard is to provide an accessible digital safety layer that helps people:

* Understand suspicious interactions
* Recognize manipulation signals
* Analyze suspicious messages
* Check potentially risky links
* Analyze screenshots
* Analyze user-provided audio
* Understand why an interaction may be risky
* Make safer decisions before responding
* Access digital safety tools in English and বাংলা

The core philosophy is:

```text
Don't just detect the threat.

Understand the interaction.
```

---

# 🚀 Proposed Solution

AmarGuard provides a multimodal digital safety experience where users can bring different types of suspicious content into one platform.

```text
┌─────────────────────────────────────┐
│          AmarGuard App              │
│                                     │
│  Call / Audio                       │
│  Message                            │
│  Screenshot                         │
│  Link                               │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│       Context & Signal Extraction   │
│                                     │
│  Urgency                            │
│  Secrecy                            │
│  Payment Request                    │
│  OTP / PIN                          │
│  Impersonation                      │
│  Authority Claim                    │
│  Prize / Job / Delivery             │
│  Account Threat                     │
│  Suspicious URL                     │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│        Risk Intelligence Layer      │
│                                     │
│  ML Risk Model                      │
│  Explainability                     │
│  Context Analysis                   │
│  Knowledge Retrieval                │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│       Explanation & Guidance        │
│                                     │
│  Risk Signals                       │
│  Why It May Be Risky                │
│  Recommended Next Steps             │
│  Decision Support                   │
└─────────────────────────────────────┘
```

---

# ✨ Main Features

## 🔐 Authentication

AmarGuard uses Firebase Authentication to provide account-based access.

### Includes
- User registration and login
- Email/password authentication
- Firebase-backed authentication
- Account-based access to application features

---

## 👤 Guest Mode

AmarGuard provides guest access to selected safety-analysis workflows, allowing users to check suspicious content without creating an account.

---

## 📞 Call-Related Analysis

AmarGuard supports analysis workflows for suspicious call-related interactions using supported, user-provided or consent-based audio.

The application does not silently record ordinary cellular calls. Audio availability and analysis depend on device support and the configured backend.

---

## 💬 Check Message - ScamShield

ScamShield helps users analyze suspicious messages and identify potential scam indicators.

### Signals include
- Urgency and secrecy
- Payment requests
- OTP/PIN or password requests
- Account threats
- Impersonation and authority claims
- Prize and reward claims
- Job and delivery-related claims
- Investment requests

The analysis provides risk indicators and safety guidance, not a guarantee that a message is fraudulent.

---

## 🔗 Check Link

Users can submit suspicious URLs for safety-oriented analysis.

The workflow aims to help users recognize potentially risky links and understand why they should be cautious before opening them.

---

## 📸 Scan Screenshot

Users can submit screenshots containing suspicious digital interactions, such as:

- Suspicious conversations
- Payment requests
- Account warnings
- Prize or job offers
- Delivery-related messages
- Social-media interactions

The feature is intended to help assess warning signs from visual context. Its accuracy depends on the supported image-analysis workflow.

---

## 🎙️ Analyze Audio

AmarGuard supports user-provided audio analysis through speech-transcription and AI-assisted workflows.

The intended processing approach is:

```text
Audio Input
    ↓
Speech Transcription
    ↓
Context Analysis
    ↓
Risk Signal Identification
    ↓
Safety Explanation
```

Supported languages and analysis quality depend on the configured transcription and AI services.

---

## 👨‍👩‍👧 Family Safety

AmarGuard includes consent-based family connection and safety-sharing features.

### Includes
- Family invitations and approval
- Authorized family connections
- Shared location visibility
- Available device-status information
- Battery information where supported

Location and device information are available according to sharing authorization, permissions, and device connectivity.

---

## 🆘 CareSignal AI

CareSignal AI provides a voice-assisted help-request workflow.

- Supports voice-based help requests.
- Uses speech transcription and AI-assisted intent understanding.
- Prepares assistance requests for approved family contacts.

Real-time push-notification delivery is still subject to backend and FCM integration verification.

## 🌐 English + বাংলা

AmarGuard is designed as a Bangla-first digital safety experience.

Users can switch between:

```text
English
   ↕
বাংলা
```

The selected language is persisted for future sessions.

---

# 🧠 Core Interaction Intelligence

AmarGuard focuses on **interaction-level risk signals**.

The system can represent structured signals such as:

```text
payment_request
otp_pin
password_request
urgency
secrecy
authority_claim
impersonation
prize_reward
job_offer
account_threat
delivery_claim
investment_request
emergency_claim
unknown_caller
money_amount
suspicious_url
escalation
```

These signals can contribute to an overall interaction-risk assessment.

---

# 📊 Interaction Risk Score

AmarGuard can represent the assessed risk of an interaction using a structured score.

Example:

```text
Interaction Risk Score

        91 / 100
```

The score represents an **interaction risk assessment**.

It should not be interpreted as:

```text
91% probability of fraud
```

The purpose of the score is to support user understanding and decision-making.

---

# 🔍 Explainable AI

AmarGuard is designed around explainability.

Instead of simply showing:

```text
HIGH RISK
```

the system can explain the signals behind the assessment.

Example:

```text
⚠ Urgent payment request

⚠ Requests sensitive information

⚠ Uses authority or threat language

⚠ Attempts to prevent verification
```

The goal is:

```text
Risk Score
     ↓
Why?
     ↓
Which Signals?
     ↓
What Should I Consider?
```

---

# 🤖 AI Architecture

The AmarGuard intelligence pipeline can combine multiple AI components.

```text
User Input
    │
    ├──────── Message
    ├──────── Screenshot
    ├──────── Link
    └──────── Audio
             │
             ▼
       Context Extraction
             │
             ▼
      Structured Risk Signals
             │
             ▼
       ML Risk Assessment
             │
             ▼
         Explainability
             │
             ▼
       Knowledge Retrieval
             │
             ▼
        AI Explanation
             │
             ▼
       Safety Guidance
```

### AI Components

* Speech-to-text
* Bangla/Banglish normalization
* Context extraction
* Structured risk signals
* XGBoost risk modeling
* SHAP explainability
* Retrieval-Augmented Generation
* Knowledge graph / GraphRAG
* LLM-powered explanations

---

# 🕸️ Threat Intelligence

An advanced AmarGuard intelligence layer can connect related threat patterns using a knowledge graph.

```text
Threat Pattern
      ↓
Manipulation Signal
      ↓
Interaction Context
      ↓
Risk Relationship
      ↓
Safety Guidance
```

A Neo4j-based knowledge graph can be used to represent relationships between threat patterns, signals, and safety guidance.

---

# 🏗️ System Architecture

```text
┌─────────────────────────────────────┐
│          Flutter Application        │
│                                     │
│  UI / Navigation                    │
│  Authentication                     │
│  Guest Mode                         │
│  Analysis Workflows                 │
│  English / বাংলা                    │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│       Application Services          │
│                                     │
│  Authentication                     │
│  User Profile                       │
│  Preferences                        │
│  Cloud Data                         │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│          AI Backend Layer           │
│                                     │
│  Speech Processing                  │
│  Context Extraction                 │
│  ML Risk Model                      │
│  Explainability                     │
│  RAG / LLM                          │
└──────────────────┬──────────────────┘
                   │
           ┌───────┴────────┐
           ▼                ▼
┌─────────────────┐ ┌─────────────────┐
│ Knowledge Layer │ │ Model Services  │
│                 │ │                 │
│ RAG / GraphRAG  │ │ XGBoost / SHAP  │
│ ThreatMesh      │ │ Speech / LLM    │
└─────────────────┘ └─────────────────┘
```

---

# 🔄 End-to-End Application Flow

```text
                    User
                     │
                     ▼
                  Onboarding
                     │
                     ▼
              Login / Guest Mode
                     │
                     ▼
                   Dashboard
                     │
         ┌───────────┼───────────┐
         │           │           │
         ▼           ▼           ▼
       Call        Message      Link
         │           │           │
         └───────────┼───────────┘
                     │
               Screenshot / Audio
                     │
                     ▼
              Context Extraction
                     │
                     ▼
              Risk Signal Analysis
                     │
                     ▼
               Risk Assessment
                     │
                     ▼
                Explanation
                     │
                     ▼
               Safety Guidance
                     │
                     ▼
                User Decision
```

---

# 📱 App Screenshots

## Onboarding


<p align="center">
  <img width="200" height="430" alt="AmarGuard Onboarding 1" src="https://github.com/user-attachments/assets/3dc9974e-5e5b-49c4-bda0-bcb83c98aaed" />
  <img width="200" height="430" alt="AmarGuard Onboarding 2" src="https://github.com/user-attachments/assets/97b45f22-d8cb-47cd-bf95-8e927f086e26" />
  <img width="200" height="430" alt="AmarGuard Onboarding 3" src="https://github.com/user-attachments/assets/0d06daff-f729-4507-a1c2-8e3fb02d3391" />
</p>

---
## Authentication

<p align="center">
  <img width="300" height="650" alt="AmarGuard Login" src="https://github.com/user-attachments/assets/cf40fdbc-1283-4e91-ab13-7f7067755c1c" />
  <img width="300" height="650" alt="AmarGuard Register" src="https://github.com/user-attachments/assets/dee584bd-b0be-4cf3-b21a-03393f8b07af" />
</p>

---

## Dashboard

<p align="center">
  <img width="300" height="650" alt="AmarGuard Dashboard 1" src="https://github.com/user-attachments/assets/2d2ddb6f-d36d-4d43-9a0f-75ade9ead2bb" />
  <img width="300" height="650" alt="AmarGuard Dashboard 2" src="https://github.com/user-attachments/assets/7a541bb0-79ec-47bc-9a35-bc89723d2067" />
</p>

---

## Profile & Language

<p align="center">
  <img width="300" height="650" alt="AmarGuard Profile" src="https://github.com/user-attachments/assets/030de9c2-d955-4183-96dc-6c28130d5cd8" />
  <img width="300" height="650" alt="AmarGuard Language" src="https://github.com/user-attachments/assets/2e4cd5ab-e7cf-4cd7-ad62-aca86904e793" />
</p>


---
## Family Invitation & Connection

<p align="center">
  <img width="300" height="650" alt="AmarGuard Family Invitation" src="https://github.com/user-attachments/assets/4e1abd0c-8f29-4b2c-a865-7e49991b6ad5" />
  <img width="300" height="650" alt="AmarGuard Enter Invitation Code" src="https://github.com/user-attachments/assets/2f7da178-a1ba-42c5-ac50-006d503857bd" />
</p>

---

## CareSignal AI

<p align="center">
  <img width="300" height="650" alt="AmarGuard CareSignal AI Help Request" src="https://github.com/user-attachments/assets/53ed1771-3112-41e5-aafd-669479789a01" />
  <img width="300" height="650" alt="AmarGuard CareSignal AI Help Request Details" src="https://github.com/user-attachments/assets/86af5040-f7f7-426e-b5ec-a9a81c368050" />
</p>

---

# 🛠️ Technology Stack

## 📱 Frontend

* Flutter
* Dart
* Material UI
* Shared Preferences
* Firebase Authentication
* Cloud Firestore

---

## 🔥 Firebase

Firebase is used for application services including:

* Authentication
* User profiles
* Cloud data
* Persistent preferences
* Future notification workflows

Firebase acts as the application service layer, while AI inference is handled separately.

---

## 🤖 AI & Machine Learning

* Python
* XGBoost
* SHAP
* Scikit-learn
* Speech-to-text
* LLMs
* Retrieval-Augmented Generation
* Knowledge Graph
* GraphRAG

---

## 🗄️ Data & Knowledge

* Firebase / Firestore
* ChromaDB
* Neo4j
* Structured threat-signal data
* Curated digital safety knowledge

---

# 📂 Flutter Project Structure

```text
lib/
│
├── main.dart
├── app.dart
│
├── core/
│   ├── theme/
│   ├── localization/
│   └── services/
│
├── features/
│   ├── onboarding/
│   ├── auth/
│   ├── dashboard/
│   ├── analyze/
│   ├── history/
│   ├── profile/
│   └── family_safety/
│
└── widgets/
```

---

# 🔐 Security & Privacy

AmarGuard is designed with digital safety and user privacy in mind.

Security principles include:

* Firebase authentication
* Protected user data
* Consent-based audio workflows
* Secure configuration
* No hardcoded secrets
* User-controlled analysis
* Minimal collection of sensitive information

> AmarGuard is a decision-support tool. Users should independently verify important claims and should never share OTPs, PINs, passwords, or financial credentials with untrusted parties.

---

# 📡 Connectivity

Cloud-based AI features require an internet connection through:

* Wi-Fi
* Mobile data

If both are unavailable, cloud AI services cannot be reached unless an on-device intelligence layer is available.

Future versions can explore more offline-capable safety workflows.

---

# ⚠️ Call Audio Limitation

Standard Flutter Android applications cannot universally and silently capture ordinary cellular call audio.

Therefore, AmarGuard's audio-analysis architecture focuses on:

* User-provided audio
* Consent-based recordings
* Supported VoIP/in-app audio
* Future Android-supported call-screening integrations

---

# 🧪 Testing & Verification

Important verification areas include:

```text
Application Launch
       ↓
Onboarding
       ↓
Authentication
       ↓
Guest Mode
       ↓
Dashboard
       ↓
Language Switching
       ↓
Profile
       ↓
Analysis Workflows
       ↓
Firebase Connectivity
       ↓
Android APK Installation
```

The Android release APK has been prepared for physical-device installation and GitHub distribution.

---

# 🚀 Getting Started

## 1. Clone Repository

```bash
git clone https://github.com/mamun657/AmarGuard.git
cd AmarGuard
```

---

## 2. Install Dependencies

```bash
flutter pub get
```

---

## 3. Check Flutter Environment

```bash
flutter doctor
```

---

## 4. Check Connected Devices

```bash
flutter devices
```

Or:

```bash
adb devices
```

---

## 5. Run Application

```bash
flutter run
```

For a specific device:

```bash
flutter run -d <device-id>
```
---

# 🌐 Localization

AmarGuard supports:

```text
English
বাংলা
```

The selected language is persisted and applied throughout the user interface.

---

# 🛣️ Future Roadmap

Potential future development includes:

* Advanced interaction-risk modeling
* Better Bangla/Banglish understanding
* Real-time threat intelligence
* Threat knowledge graph
* GraphRAG reasoning
* Expanded family safety
* Advanced audio analysis
* On-device AI
* Low-bandwidth optimization
* Supported call-screening integrations
* Telco-level safety integrations
* Expanded multilingual support

---

# 🎯 Product Philosophy

AmarGuard follows four core principles:

```text
DETECT
   ↓
UNDERSTAND
   ↓
EXPLAIN
   ↓
PROTECT
```

# AmarGuard is developed by **Mohammed Minul Islam**.

The project focuses on practical AI-powered digital safety tools with particular attention to:

* Bangla-first accessibility
* Explainable risk assessment
* Multimodal interaction analysis
* User decision support
* Responsible AI

---

# 📄 License

This project is currently intended for educational, research, demonstration, and product-development purposes.

Add the project's final license when the licensing decision is finalized.

---

# ⭐ Support the Project

If you find AmarGuard useful:

* ⭐ Star the repository
* 🐛 Report issues
* 💡 Suggest improvements
* 🤝 Contribute to the project

