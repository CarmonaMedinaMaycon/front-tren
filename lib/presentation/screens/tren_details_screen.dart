import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tren_cubit.dart';
import '../cubit/tren_state.dart';
import '../../data/models/tren_model.dart';

class TrenDetailScreen extends StatelessWidget {
  final TrenModel tren;

  const TrenDetailScreen({Key? key, required this.tren}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tren.modelo),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditTrenDialog(context, tren),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modelo: ${tren.modelo}', style: Theme.of(context).textTheme.headlineMedium),
            Text('Fabricante: ${tren.fabricante}'),
            Text('Longuitud: ${tren.longuitud}'),
            Text('Capacidad: ${tren.capacidad.toString()}'),
          ],
        ),
      ),
    );
  }

  void _showEditTrenDialog(BuildContext context, TrenModel tren) {
    final _modeloController = TextEditingController(text: tren.modelo);
    final _fabricanteController = TextEditingController(text: tren.fabricante);
    final _longuitudController = TextEditingController(text: tren.longuitud);
    final _capacidadController = TextEditingController(text: tren.capacidad.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Tren'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),
              TextField(
                controller: _fabricanteController,
                decoration: const InputDecoration(labelText: 'Fabricante'),
              ),
              TextField(
                controller: _longuitudController,
                decoration: const InputDecoration(labelText: 'Longuitud'),
              ),
              TextField(
                controller: _capacidadController,
                decoration: const InputDecoration(labelText: 'Capacidad'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedTren = TrenModel(
                  id: tren.id,
                  modelo: _modeloController.text,
                  fabricante: _fabricanteController.text,
                  longuitud: _longuitudController.text,
                  capacidad: double.parse(_capacidadController.text),
                );
                BlocProvider.of<TrenCubit>(context).updateTren(updatedTren);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
