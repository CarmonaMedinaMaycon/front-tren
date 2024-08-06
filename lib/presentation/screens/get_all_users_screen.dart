// class TrenListView extends StatelessWidget {
//   const TrenListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TrenCubit(
//         trenRepository: RepositoryProvider.of<TrenRepository>(context),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Tren List'),
//         ),
//         body: const TrenListScreen(),
//         floatingActionButton: Builder(
//           builder: (context) {
//             return FloatingActionButton(
//               onPressed: () => _showAddTrenDialog(context),
//               child: const Icon(Icons.add),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider(
//           create: (context) => TrenRepository(
//             apiUrl: 'https://wbjleyd813.execute-api.us-east-1.amazonaws.com/Prod/tren',
//           ),
//         ),
//       ],
//       child: BlocProvider(
//         create: (context) => TrenCubit(
//           trenRepository: RepositoryProvider.of<TrenRepository>(context),
//         ),
//         child: MaterialApp(
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//             useMaterial3: true,
//           ),
//           home: const TrenListView(),
//         ),
//       ),
//     );
//   }
// }
