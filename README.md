# Social App

A Flutter-based social media application that allows users to post, like, comment, and chat in real-time. This project integrates Firebase for backend services including authentication, Firestore database, storage, and notifications.

---

## Features

- **User Authentication**
  - Sign up, login, and logout
  - Firebase authentication

- **Posts**
  - Create, edit, and delete posts
  - Add images to posts
  - Like posts
  - Comment on posts in real-time

- **Notifications**
  - Real-time push notifications for likes and comments
  - Firebase Cloud Messaging (FCM)

- **Chats**
  - One-to-one messaging
  - Real-time chat updates

- **Profile**
  - Update profile image and cover photo
  - Edit user information (name, bio, phone)

- **UI/UX**
  - Responsive Flutter UI
  - Bouncing scroll and smooth navigation
  - Clean and organized layout

---

## Screens

1. **Feeds** – Home feed with posts
2. **Chats** – List of users for chatting
3. **New Post** – Create new post screen
4. **Settings** – Update profile and app settings
5. **Comments** – Add and view comments for a post
6. **Chat Details** – View chat messages with a user

---

## Technologies Used

- **Flutter & Dart** – Cross-platform mobile development
- **Firebase** – Backend services
  - Firestore (Database)
  - Firebase Storage (Media)
  - Firebase Authentication
  - Firebase Cloud Messaging
- **Bloc Pattern** – State management
- **Conditional Builder** – Dynamic UI updates
- **Image Picker** – Pick images from gallery or camera

---

## Folder Structure

```
social_App/
├─ android/
├─ ios/
├─ lib/
│  ├─ layout/
│  │  ├─ cubits/         # Bloc cubits
│  │  ├─ models/         # Data models
│  │  ├─ modules/        # Screens
│  │  └─ style/          # UI styling
│  │  └─ social_layout/  # Home
│  ├─ main.dart
│  ├─ widget.dart
│  ├─ cache_helper.dart
├─ pubspec.yaml
├─ README.md
└─ ...
```



## Author

**Abdul Hamid Shukri Al-Mashharawi**  
Gaza | +972 59 707 1296  
abdalmashharami@gmail.com

