import '../models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> fetchUser(String id);
}

class UserRepository implements IUserRepository {
  @override
  Future<UserModel> fetchUser(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Return dummy user data
    return UserModel(id: id, email: 'user@example.com', name: 'John Doe');
  }
}
