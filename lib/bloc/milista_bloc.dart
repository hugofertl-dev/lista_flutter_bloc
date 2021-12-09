import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:lista_bloc_ejemplo/model/item.dart';

part 'milista_event.dart';
part 'milista_state.dart';

class MilistaBloc extends Bloc<MilistaEvent, MilistaState> {
  MilistaBloc() : super(MilistaState()) {
    on<OnCargaMiLista>(_onCargaMiLista);
    on<OnActailizaPuntajeMiLista>(_onActailizaPuntajeMiLista);
  }

  Future<void> _onCargaMiLista(OnCargaMiLista event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, accion: 'carga'));
    final List<Item> lista = [];

    for (int i = 0; i < 50; i++) {
      final item = Item(id: i.toString(), descripcion: 'Item $i', puntaje: 0);
      lista.add(item);
    }
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isWorking: false, lstLista: lista, accion: 'carga'));
    for (Item item in state.lstLista) {
      await Future.delayed(const Duration(seconds: 3));
      add(OnActailizaPuntajeMiLista(item.id));
    }
  }

  Future<void> _onActailizaPuntajeMiLista(
      OnActailizaPuntajeMiLista event, Emitter emit) async {
    final listaNew = state.lstLista.map((item) {
      if (item.id == event.id) {
        item.descripcion = 'actualizado ${item.descripcion}';
        item.puntaje = 10;
      }
      return item;
    }).toList();

    emit(state.copyWith(
        lstLista: listaNew, idActualizado: event.id, accion: 'actualiza'));
  }
}
