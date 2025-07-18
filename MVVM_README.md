# Flutter MVVM Architecture

This project implements the MVVM (Model-View-ViewModel) pattern for a Flutter application with three main screens.

## Project Structure

```
lib/
├── main.dart                    # App entry point and routing
├── models/                      # Data models
│   ├── user_model.dart         # User data model
│   └── app_state.dart          # Application state model
├── viewmodels/                  # ViewModels (Business Logic)
│   ├── first_page_viewmodel.dart
│   ├── second_page_viewmodel.dart
│   └── third_page_viewmodel.dart
├── views/                       # UI Layer
│   └── pages/
│       ├── first_page.dart     # Login/Name input screen
│       ├── second_page.dart    # Welcome screen
│       └── third_page.dart     # User list screen
└── services/                    # External services
    └── api_service.dart        # API communication
```

## MVVM Pattern Implementation

### Models
- **UserModel**: Represents user data with JSON serialization
- **AppState**: Manages application state across screens

### ViewModels
- **FirstPageViewModel**: Handles name input and palindrome checking logic
- **SecondPageViewModel**: Manages user data and navigation between screens
- **ThirdPageViewModel**: Handles user list fetching and selection

### Views
- **FirstPage**: Login screen with name input and palindrome checker
- **SecondPage**: Welcome screen displaying user name and selected user
- **ThirdPage**: User list screen fetching data from API

### Services
- **ApiService**: Handles HTTP requests to the ReqRes API

## Features

1. **First Screen**: 
   - Name input field
   - Palindrome checker with dialog results
   - Navigation to second screen

2. **Second Screen**:
   - Displays welcome message with user name
   - Shows selected user name
   - Navigation to user list

3. **Third Screen**:
   - Fetches users from ReqRes API
   - Pull-to-refresh functionality
   - User selection returns to second screen

## Key Benefits of MVVM

1. **Separation of Concerns**: UI logic is separated from business logic
2. **Testability**: ViewModels can be unit tested independently
3. **Maintainability**: Changes to business logic don't affect UI directly
4. **Reusability**: ViewModels can be reused across different views
5. **Data Binding**: Automatic UI updates when ViewModel state changes

## Dependencies

- `flutter/material.dart` - UI framework
- `http` - HTTP client for API calls
- `ChangeNotifier` - State management for ViewModels

## Usage

1. Run `flutter pub get` to install dependencies
2. Run `flutter run` to start the application
3. Navigate through the three screens using the provided buttons
