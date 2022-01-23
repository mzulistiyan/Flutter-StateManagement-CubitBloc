import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_statemanagement/domain/core/user/model/user_response.dart';
import 'package:flutter_cubit_statemanagement/infrastructure/profile/profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profileb_event.dart';
part 'profileb_state.dart';
part 'profileb_bloc.freezed.dart';

class ProfilebBloc extends Bloc<ProfilebEvent, ProfilebState> {
  final ProfileRepository _profileRepository = ProfileRepository();
  @override
  ProfilebBloc() : super(const _Initial()) {
    on<ProfilebEvent>((event, emit) async {
      await event.map(
        started: (value) async {},
        getAllUserData: (value) async {
          emit(const ProfilebState.isLoading());
          //get data from API

          final _result = await _profileRepository.getAllUserData();

          //if error yield error state,
          //if success yield success state with data
          _result.fold(
            (l) => emit(ProfilebState.isError(l)),
            (r) => emit(ProfilebState.isSuccess(r)),
          );
        },
      );
    });
  }
}
