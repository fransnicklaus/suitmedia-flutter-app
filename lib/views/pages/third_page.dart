import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/third_page_viewmodel.dart';
import '../../models/user_model.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollChanged);

    // Fetch users when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ThirdPageViewModel>(context, listen: false);
      viewModel.fetchUsers();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChanged);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScrollChanged() {
    final viewModel = Provider.of<ThirdPageViewModel>(context, listen: false);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200 pixels from the bottom
      viewModel.loadMoreUsers();
    }
  }

  void _onUserSelected(UserModel user) {
    final viewModel = Provider.of<ThirdPageViewModel>(context, listen: false);
    viewModel.selectUser(user);
    Navigator.pop(context, user.name);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThirdPageViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Third Screen'),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await viewModel.refreshUsers();
            },
            child: _buildBody(),
          ),
        ),
      );
    });
  }

  Widget _buildBody() {
    final viewModel = Provider.of<ThirdPageViewModel>(context);
    if (viewModel.isLoading && !viewModel.hasUsers) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    if (viewModel.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              viewModel.errorMessage,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.refreshUsers,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (!viewModel.hasUsers) {
      return Center(
        child: Text(
          'No users found',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.users.length + 1, // Always add 1 for the footer
      itemBuilder: (context, index) {
        if (index == viewModel.users.length) {
          // Show loading indicator or "no more data" message
          return _buildFooterWidget();
        }

        final user = viewModel.users[index];
        return _buildUserCard(user);
      },
    );
  }

  Widget _buildLoadingIndicator() {
    final viewModel = Provider.of<ThirdPageViewModel>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: viewModel.isLoadingMore
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildFooterWidget() {
    final viewModel = Provider.of<ThirdPageViewModel>(context);
    if (viewModel.isLoadingMore) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    } else if (!viewModel.hasMoreData && viewModel.users.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            'No more users to load',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildUserCard(UserModel user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user.avatar),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        ),
        title: Text(
          user.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        subtitle: Text(
          user.email,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        onTap: () => _onUserSelected(user),
      ),
      // child: Card(
      //   child: ListTile(
      //     contentPadding: const EdgeInsets.all(16),
      //     leading: CircleAvatar(
      //       radius: 30,
      //       backgroundImage: NetworkImage(user.avatar),
      //       backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      //     ),
      //     title: Text(
      //       user.name,
      //       style: TextStyle(
      //         fontSize: 18,
      //         fontWeight: FontWeight.bold,
      //         color: Theme.of(context).colorScheme.primary,
      //       ),
      //     ),
      //     subtitle: Text(
      //       user.email,
      //       style: TextStyle(
      //         fontSize: 14,
      //         color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      //       ),
      //     ),

      //     onTap: () => _onUserSelected(user),
      //   ),
      // ),
    );
  }
}
