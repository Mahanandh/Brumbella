# Brumbella

**Description:** A modern, cross-platform enterprise SaaS application featuring robust cloud architecture, built with Flutter and secured by Firebase backend infrastructure.

---

## 🛠 Tech Stack & Architecture

- **Frontend:** Flutter (Optimized for Web, Android, iOS, Windows, macOS, Linux)
- **State Management & UI:** Material Design 3, custom responsive constraints, flat borderless geometry
- **Backend & Services:** Firebase Core, Firebase Authentication (Phone OTP)
- **Tooling:** FlutterFire CLI, Dart SDK, Git/GitHub version control

---

## 🚀 What Has Been Implemented (Development Milestones)

### 1. Firebase Integration & CLI Setup
- Configured and linked the local Flutter project to the remote Firebase project (`brumbella`) using the FlutterFire CLI.
- Generated environment-specific configuration via `firebase_options.dart` and initialized Firebase asynchronously in `main.dart` using `WidgetsFlutterBinding.ensureInitialized()`.

### 2. Phone Authentication & Security Flow
- Implemented secure OTP verification workflow using `firebase_auth`.
- Handled Flutter Web-compatible reCAPTCHA and `ConfirmationResult` token management for seamless sign-in.
- Configured Firebase Console sign-in providers and SMS Region policies to support international validation.

### 3. UI/UX & Navigation Overhauls
- Built a dedicated OTP verification screen with 6-digit input masking and validation logic.
- Resolved critical routing bugs, fixing blank white screens on route pops by migrating the core architecture from a manual state switcher to robust `Navigator.push`/`Navigator.pop` stacks.
- Fixed missing `Scaffold`/`Material` ancestor layout errors on the Login and Registration screens to ensure proper `TextField` and forms rendering.

---

## 🗺 Visual Representation (Architecture & Auth Workflow)

```text
[ Flutter Web / Client App ]
       │
       ├── 1. Enter Phone Number (+91...)
       ├── 2. Trigger signInWithPhoneNumber() ──> [ Firebase Auth Service ]
       │                                                  │
       │                                        (Sends SMS OTP via Gateway)
       │                                                  │
       │<── 3. Return ConfirmationResult <────────────────┘
       │
       ├── 4. Navigate to OTP Verification Screen
       ├── 5. Enter 6-Digit Code & Confirm
       │
       └── 6. Verified User Session Established ──> [ Dashboard / Home ]
```

---

## 💻 Setup & Getting Started Guide

If you are cloning this repository for local development, follow these steps to initialize the environment:

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd Brumbella
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase CLI:**
   Ensure the FlutterFire CLI is active, then configure the project to link the cloud backend:
   ```bash
   dart pub global run flutterfire_cli:flutterfire configure --project=brumbella
   ```

4. **Run the application:**
   You can launch the project on your local Chrome browser (optimized for the current build):
   ```bash
   flutter run -d chrome
   ```
