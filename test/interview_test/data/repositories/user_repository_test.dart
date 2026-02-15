import 'package:flutter_deep/interview_test/data/models/user_model.dart';
import 'package:flutter_deep/interview_test/data/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserRepository', () {
    late UserRepository userRepository;

    setUp(() {
      userRepository = UserRepository();
    });

    group('fetchUser', () {
      test('returns user with correct id', () async {
        const userId = 'user123';
        final UserModel user = await userRepository.fetchUser(userId);

        expect(user.id, userId);
        expect(user.email, isNotEmpty);
        expect(user.name, isNotEmpty);
      });

      test('returns user with valid email', () async {
        final user = await userRepository.fetchUser('user456');

        expect(user.email, 'user@example.com');
      });

      test('returns user with valid name', () async {
        final user = await userRepository.fetchUser('user789');

        expect(user.name, 'John Doe');
      });

      test('returns consistent data on multiple calls', () async {
        const userId = 'consistent_user';
        final user1 = await userRepository.fetchUser(userId);
        final user2 = await userRepository.fetchUser(userId);

        expect(user1.id, user2.id);
        expect(user1.email, user2.email);
        expect(user1.name, user2.name);
      });

      test('handles different user ids', () async {
        final user1 = await userRepository.fetchUser('user_1');
        final user2 = await userRepository.fetchUser('user_2');

        expect(user1.id, 'user_1');
        expect(user2.id, 'user_2');
      });
    });
  });
}
