part of 'milista_bloc.dart';

abstract class MilistaEvent {}

class OnCargaMiLista extends MilistaEvent {
  OnCargaMiLista();
}

class OnActailizaPuntajeMiLista extends MilistaEvent {
  String id;
  OnActailizaPuntajeMiLista(this.id);
}
