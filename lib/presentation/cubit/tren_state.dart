import 'package:equatable/equatable.dart';
import '../../data/models/tren_model.dart';

abstract class TrenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrenInitial extends TrenState {}

class TrenLoading extends TrenState {}

class TrenSuccess extends TrenState {
  final List<TrenModel> trenes;

  TrenSuccess({required this.trenes});

  @override
  List<Object?> get props => [trenes];
}

class TrenError extends TrenState {
  final String message;

  TrenError({required this.message});

  @override
  List<Object?> get props => [message];
}