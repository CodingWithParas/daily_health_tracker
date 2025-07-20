# 📱 Daily Health Tracker

A comprehensive Flutter application built with GetX architecture that helps users track their daily health activities, view progress through interactive graphs, and manage their fitness routines with a clean, animated user interface.

## ✨ Features

- 🔐 **Google Authentication** - Secure sign-in with Google account
- 📊 **Interactive Graphs** - Visualize 7-day health data with fl_chart
- 🌐 **REST API Integration** - Fetch real-time activity logs and user data
- 📜 **Lazy Loading** - Infinite scroll pagination for activity logs
- ⏱️ **Countdown Timer** - Activity reminder timer with auto-refresh
- 🎨 **Smooth Animations** - Fade and scale effects throughout the app
- 📱 **Clean MVC Architecture** - Organized code structure with GetX

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: GetX
- **Architecture**: MVC (Model-View-Controller)
- **Charts**: fl_chart
- **Authentication**: google_sign_in
- **Routing**: GetX Navigation

## 📋 Prerequisites

Before running this project, make sure you have:

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Google account for authentication setup
- Internet connection for API calls

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/daily-health-tracker.git
cd daily-health-tracker
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Google Sign-In Setup

#### For Android:
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google Sign-In API
4. Create OAuth 2.0 credentials
5. Add your app's SHA-1 fingerprint
6. Download `google-services.json` and place it in `android/app/`

#### For iOS:
1. Download `GoogleService-Info.plist` from Firebase Console
2. Add it to `ios/Runner/`
3. Update `ios/Runner/Info.plist` with URL scheme

### 4. Run the Application
```bash
flutter run
```

## 📱 App Screenshots


## 🎯 Key Implementation Details

### GetX State Management
```dart
// Example Controller
class DashboardController extends GetxController {
  var isLoading = true.obs;
  var userData = UserModel().obs;
  
  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }
  
  void fetchUserData() async {
    // Implementation
  }
}
```

### REST API Integration
- **Activity Logs**: `https://jsonplaceholder.typicode.com/posts`
- **User Data**: `https://reqres.in/api/users`
- Custom pagination and error handling

### Lazy Loading Implementation
- Infinite scroll with GetX pagination
- Automatic loading indicators
- Error state management

### Animations
- Fade-in animations for screen transitions
- Scale animations for button interactions
- Loading animations for better UX

## 🧪 Testing

Run tests using:
```bash
flutter test
```

Test coverage includes:
- Unit tests for controllers
- Widget tests for UI components
- Integration tests for user flows

## 🚀 Build & Deployment

### Android APK
```bash
flutter build apk --release
```

### iOS Build
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 👨‍💻 Developer

**Your Name**
- Paras Sharma
- Email: parasdev221@gmail.com

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- GetX package for state management
- fl_chart for beautiful graphs
- Google Sign-In for authentication
- Open APIs for mock data

---

⭐ If you found this project helpful, please give it a star!
