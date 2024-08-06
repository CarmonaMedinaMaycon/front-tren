import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/tren_repository.dart';
import '../cubit/tren_cubit.dart';
import '../cubit/tren_state.dart';
import '../../data/models/tren_model.dart';
import 'tren_details_screen.dart';

class TrenListView extends StatelessWidget {
  const TrenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrenCubit(
        trenRepository: RepositoryProvider.of<TrenRepository>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tren List'),
        ),
        body: const TrenListScreen(),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () => _showAddTrenDialog(context),
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  void _showAddTrenDialog(BuildContext context) {
    final _modeloController = TextEditingController();
    final _fabricanteController = TextEditingController();
    final _longuitudController = TextEditingController();
    final _capacidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Tren'),
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
                final capacidad = _capacidadController.text;
                final loguitud = _longuitudController.text;
                if (capacidad.isNotEmpty &&
                    double.tryParse(capacidad) != null &&
                    loguitud.isNotEmpty &&
                    double.tryParse(loguitud) != null) {
                  final tren = TrenModel(
                    id: '',
                    modelo: _modeloController.text,
                    fabricante: _fabricanteController.text,
                    longuitud: double.parse(_longuitudController.text),
                    capacidad: double.parse(capacidad),
                  );
                  BlocProvider.of<TrenCubit>(context).createTren(tren);
                  BlocProvider.of<TrenCubit>(context).fetchAllTrenes();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Por favor, ingresa un valor numérico válido para la capacidad.'),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class TrenListScreen extends StatelessWidget {
  const TrenListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trenCubit = BlocProvider.of<TrenCubit>(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            trenCubit.fetchAllTrenes();
          },
          child: const Text('Fetch Trenes'),
        ),
        Expanded(
          child: BlocBuilder<TrenCubit, TrenState>(
            builder: (context, state) {
              if (state is TrenLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TrenSuccess) {
                final trenes = state.trenes;
                return ListView.builder(
                  itemCount: trenes.length,
                  itemBuilder: (context, index) {
                    final tren = trenes[index];
                    return ListTile(
                      title: Text(tren.modelo),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fabricante: ${tren.fabricante}'),
                          Text('Longuitud: ${tren.longuitud}'),
                          Text('Capacidad: ${tren.capacidad.toString()}'),
                        ],
                      ),
                      onTap: () => _navigateToDetailScreen(context, tren),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            _showDeleteConfirmationDialog(context, tren.id!),
                      ),
                    );
                  },
                );
              } else if (state is TrenError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(
                  child: Text('Press the button to fetch trenes'));
            },
          ),
        ),
      ],
    );
  }

  void _navigateToDetailScreen(BuildContext context, TrenModel tren) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrenDetailScreen(tren: tren),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String trenId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this tren?'),
          actions: [
            TextButton(
              onPressed: () {
                BlocProvider.of<TrenCubit>(context).deleteTren(trenId);
                BlocProvider.of<TrenCubit>(context).fetchAllTrenes();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
