# Flutter Users & Bookmarks App

This Users & Bookmarks App displays a list of users fetched from the given api. You can tap on a user to view their posts and bookmark any post you like. Bookmarked posts are saved locally and can be accessed anytime.

## ✨ Features

- Fetch and display users
- View user details and their posts
- Bookmark/unbookmark posts
- View bookmarked posts on a separate screen
- Clean and modern UI

## 📦 Dependencies

- flutter_bloc
- http
- shared_preferences

## 📂 Structure

- `models/` – Contains User and Post models
- `services/` – API service to fetch users and posts
- `blocs/` – BLoC files for user and bookmark state
- `screens/` – Home, User Detail, and Bookmarks UI screens
- `utils/` – Manages local data storage (e.g., bookmarks) using SharedPreferences

## 🚀 Getting Started

1. Run `flutter pub get`
2. Launch the app with `flutter run`
3. Explore the users, tap on one to view posts, and start bookmarking!

## 📌 Note

## 🔐 Login
1. Before accessing the app, a basic login screen is shown.
2. Username: admin
3. Password: admin123
(Credentials can be changed from the code in the login screen file.)

Data is fetched from:  
https://jsonplaceholder.typicode.com
