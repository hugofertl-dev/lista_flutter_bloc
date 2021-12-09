import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_bloc_ejemplo/bloc/milista_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MilistaBloc>().add(OnCargaMiLista());
  }

  @override
  Widget build(BuildContext context) {
    log('build......');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mi lista'),
        ),
        body: BlocBuilder<MilistaBloc, MilistaState>(
                          
          builder: (context, state) {
            if (state.isWorking) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: state.lstLista.length,
              itemBuilder: (BuildContext context, int index) {
                final item = state.lstLista[index];
                return BlocBuilder<MilistaBloc, MilistaState>(
                  buildWhen: (previous, current) => (current.accion == 'carga'),
                  builder: (context, state) {
                    return ListTile(
                      leading: Text(item.id),
                      title: Text(item.descripcion),
                      trailing: BlocBuilder<MilistaBloc, MilistaState>(
                        buildWhen: (previous, current) =>
                            (current.accion == 'carga' ||
                                current.accion == 'actualiza' &&
                                    current.idActualizado == item.id),
                        builder: (context, state) {
                          log(item.id);
                          return (item.puntaje == 0)
                              ? const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator())
                              : Text(item.puntaje.toString());
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
