import 'package:bloc/bloc.dart';
import '../../data/models/tren_model.dart';
import '../../data/repository/tren_repository.dart';
import 'tren_state.dart';

class TrenCubit extends Cubit<TrenState> {
  final TrenRepository trenRepository;

  TrenCubit({required this.trenRepository}) : super(TrenInitial());

  Future<void> createTren(TrenModel tren) async {
    try {
      emit(TrenLoading());
      await trenRepository.createTren(tren);
      final trenes = await trenRepository.getAllTrenes();
      emit(TrenSuccess(trenes: trenes));
    } catch (e) {
      emit(TrenError(message: e.toString()));
    }
  }

  Future<void> getTren(String id) async {
    try {
      emit(TrenLoading());
      final tren = await trenRepository.getTren(id);
      emit(TrenSuccess(trenes: [tren]));
    } catch (e) {
      emit(TrenError(message: e.toString()));
    }
  }

  Future<void> updateTren(TrenModel tren) async {
    try {
      emit(TrenLoading());
      await trenRepository.updateTren(tren);
      final trenes = await trenRepository.getAllTrenes();
      emit(TrenSuccess(trenes: trenes));
    } catch (e) {
      emit(TrenError(message: e.toString()));
    }
  }

  Future<void> deleteTren(String id) async {
    try {
      emit(TrenLoading());
      await trenRepository.deleteTren(id);
      final trenes = await trenRepository.getAllTrenes();
      emit(TrenSuccess(trenes: trenes));
    } catch (e) {
      emit(TrenError(message: e.toString()));
    }
  }

  Future<void> fetchAllTrenes() async {
    try {
      emit(TrenLoading());
      final trenes = await trenRepository.getAllTrenes();
      emit(TrenSuccess(trenes: trenes));
    } catch (e) {
      emit(TrenError(message: e.toString()));
    }
  }
}
