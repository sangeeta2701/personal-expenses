import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moduel_4/chart.dart';
import 'package:moduel_4/transaction_list.dart';
// import 'package:moduel_4/transaction_list.dart';
import 'new_transaction.dat.dart';
import 'transaction.dart';
import 'chart.dart';

// DateTime now = DateTime.now();
// String formattedDate = DateFormat('dd-mm-yyyy').format(now);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple[200],
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New phone',
    //   amount: 89.99,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          // ignore: prefer_const_constructors
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  String titleInput;

  String amountInput;

  Widget _buildLandscapeContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ignore: prefer_const_constructors
        Text('Show Chart'),
        // ignore: prefer_const_constructors
        Switch(
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar) {
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
      child: Chart(_recentTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore_for_file: avoid_print

    print('build() MyHomePageState');
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      // ignore: prefer_const_constructors
      title: Text(
        "Personal Expenses",
        // style: TextStyle(fontFamily: 'Open Sans'),
      ),
      // ignore: prefer_const_constructors
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            // ignore: prefer_const_constructors
            icon: Icon(Icons.add))
      ],
    );

    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) _buildLandscapeContent(),
            if (!isLandscape) _buildPortraitContent(mediaQuery, appBar),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransaction),
                    )
                  : txListWidget

            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     child: Container(
            //       width: 100,
            //       // ignore: prefer_const_constructors
            //       child: Text('CHART!'),
            // //     ),
            //     color: Colors.blue,
            //     elevation: 5,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        // ignore: prefer_const_constructors
        child: Icon(Icons.add),
      ),
    );
  }
}
