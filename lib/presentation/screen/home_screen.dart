import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrd_app/bloc/presence/presence_bloc.dart';
import 'package:hrd_app/data/repository/presence_repository.dart';
import 'package:hrd_app/presentation/components/custom_loading.dart';
import 'package:hrd_app/utils/default_colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> presenced = [];
  late List<String> notPresenced;

  @override
  // ignore: must_call_super
  initState() {
    context.read<PresenceBloc>().add(GetPresence());
    getUser();
  }

  Future<void> getUser() async {
    PresenceRepository presenceRepository = PresenceRepository();
    final response = await presenceRepository.todayPresence();

    response.fold((l) => null, (r) {
      setState(() {
        presenced = r.data.presenced;
      });
    });
  }

  Map<String, String> getDateNow() {
    initializeDateFormatting('id');
    return {
      "day": DateFormat('EEEE', 'id').format(DateTime.now()),
      "date": DateFormat('dd MMMM yyyy', 'id').format(DateTime.now())
    };
  }

  @override
  Widget build(BuildContext context) {
    Stream<String> timeStream = Stream.periodic(
      const Duration(seconds: 1),
      (computationCount) => DateFormat.Hms().format(DateTime.now()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('HRD PT KAIA '),
        backgroundColor: kPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 100,
              color: kPrimary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder<String>(
                      stream: timeStream,
                      initialData: DateFormat.Hms().format(DateTime.now()),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getDateNow()['day'] ?? 'Day',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        getDateNow()['date'] ?? 'Date',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: kPrimary,
              child: TabBar(
                onTap: (value) {
                  context.read<PresenceBloc>().add(GetPresence());
                  setState(() {
                    presenced = context
                        .read<PresenceBloc>()
                        .state
                        .presences!
                        .data
                        .presenced;
                  });
                },
                tabs: const [
                  Tab(
                    icon: Icon(Icons.check),
                    text: 'Sudah Hadir',
                  ),
                  Tab(
                    icon: Icon(Icons.close),
                    text: 'Belum Hadir',
                  ),
                ],
              ),
            ),
            BlocBuilder<PresenceBloc, PresenceState>(builder: (context, state) {
              if (state.status == ClockedStatus.loading) {
                return Container(
                    padding: const EdgeInsets.only(top: 150),
                    child: CustLoading(
                      size: 40,
                      color: kPrimary,
                    ));
              } else {
                return Expanded(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: presenced.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ExpansionTile(
                              title: Text(presenced[index]),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount:
                            state.presences?.data.notPresenced.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                  state.presences?.data.notPresenced[index] ??
                                      ''),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
