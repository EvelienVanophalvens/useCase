import 'package:demo/bloc/user_bloc.dart';
import 'package:demo/bloc/user_event.dart';
import 'package:demo/bloc/user_state.dart';
import 'package:demo/models/user.dart';
import 'package:demo/repositories/user_repository.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository{}

void main(){
  group(UserBloc, (){
    late UserBloc userBloc;
    late UserModel user;
    late UserRepository userRepository;

    setUp((){
      user = UserModel(username: 'test', password: 'test');
      userRepository = MockUserRepository();
      userBloc = UserBloc(userRepository: userRepository);


    });

    blocTest(
      'emit [LoginSucces] when logging in with right data',
      build: () {
        when(() => userRepository.login(user.username, user.password))
            .thenAnswer((_) async => {
              'statusCode': 200,
              'body': '{"token": "fake_token"}',
            });
        return userBloc;
      },
      act:(bloc) => bloc.add(LoginEvent(user: user)),
      wait: const Duration(milliseconds: 3000),
      expect: () => [
        LoginLoading(),
        LoginSucces(),
      ],

    );

    blocTest(
      'emit [loginFailed] when logging in with wrong data',
      build: () {
        when(() => userRepository.login(user.username, user.password))
            .thenAnswer((_) async => {
              'statusCode': 400,
              'body': '{"token": "fake_token"}',
            });
        return userBloc;
      },
      act:(bloc) => bloc.add(LoginEvent(user: user)),
      wait: const Duration(milliseconds: 3000),
      expect: () => [
        LoginLoading(),
        LoginFailed("something went wrong"),
      ],
    );
  });
}