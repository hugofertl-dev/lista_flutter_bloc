part of 'milista_bloc.dart';

class MilistaState {
  final bool isWorking;
  final List<Item> lstLista;
  final String accion;
  final String idActualizado;

  MilistaState(
      {this.isWorking = false,
      List<Item>? lstLista,
      this.accion = '',
      this.idActualizado = ''})
      : lstLista = lstLista ?? [];

  MilistaState copyWith(
          {bool? isWorking,
          List<Item>? lstLista,
          String? accion,
          String? idActualizado}) =>
      MilistaState(
        isWorking: isWorking ?? this.isWorking,
        lstLista: lstLista ?? this.lstLista,
        accion: accion ?? this.accion,
        idActualizado: idActualizado ?? this.idActualizado,
      );

  MilistaState iniState() => MilistaState();
}
