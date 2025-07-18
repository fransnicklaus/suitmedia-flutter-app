class AppState {
  final String selectedUserName;
  final String currentUserName;
  final bool isLoading;
  final List<dynamic> users;
  final String errorMessage;

  AppState({
    this.selectedUserName = '',
    this.currentUserName = '',
    this.isLoading = false,
    this.users = const [],
    this.errorMessage = '',
  });

  AppState copyWith({
    String? selectedUserName,
    String? currentUserName,
    bool? isLoading,
    List<dynamic>? users,
    String? errorMessage,
  }) {
    return AppState(
      selectedUserName: selectedUserName ?? this.selectedUserName,
      currentUserName: currentUserName ?? this.currentUserName,
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
