# 🛋️ AR-Based Furniture Shopping App

An AR-powered mobile app to preview furniture in your real-world space using your phone’s camera. Built with Flutter and Node.js, it enhances buyer confidence in online furniture purchases.

---

## 📦 Project Structure

/Backend => Node.js backend (APIs, DB logic)
/lib => Flutter main app (UI, AR features)
/assets => 3D models, images
/web => Flutter web support
/test => App tests
/build => Web build output
pubspec.yaml => Flutter config

yaml
Copy
Edit

---

## 💻 Tech Stack

- **Frontend:** Flutter + ARKit/ARCore
- **Backend:** Node.js + Express
- **Database:** MongoDB Atlas
- **Storage:** Firebase Storage / AWS S3
- **Auth:** Firebase Auth
- **Hosting:** Firebase Hosting (for web frontend)

---

## 🚀 Features

- Real-time AR furniture placement
- AI-powered room measurement
- Add to cart & purchase flow
- 3D model uploads & cloud storage
- JWT-secured APIs

---

## 🛠️ Setup & Run

### Frontend

```bash
flutter pub get
flutter run
Backend
bash
Copy
Edit
cd Backend
npm install
npm start
🌐 Deployment — Firebase Hosting
Deploy Flutter Web App to Firebase
bash
Copy
Edit
# Build Flutter web output
flutter build web

# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Init Firebase project
firebase init

# Set public directory to "build/web" when prompted

# Deploy to Firebase
firebase deploy
🗺️ Roadmap
 Multi-furniture placement support

 Voice & AI-powered search

 Size-based furniture suggestions

🧑‍💻 Team Roles
Member	Responsibility
You	Flutter UI & AR integration
Biswas Reddy Jonnalagadda UI,AR Integration 
Meena Gurram Flutter Developer
Gowtham Jambugolam Backend Developer
