import 'dart:math';

import 'package:flutter/material.dart';

import 'controller.dart';

class DataViewScreen extends StatefulWidget {
  const DataViewScreen();

  @override
  State<DataViewScreen> createState() => _DataViewScreenState();
}

class _DataViewScreenState extends State<DataViewScreen> {
  final searchController = TextEditingController();
  late Future<List<String>> futureNumbersList;
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  bool loaded = false;

  late Future<List<dynamic>> apiData;
  @override
  void initState() {
    super.initState();
    apiData = Controller.getData();
    futureNumbersList = Controller().slowNumbers();
  }

@override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? data
          : data
              .where((item) =>
                  item['CITY'].toLowerCase().contains(text.toLowerCase()) 
                  // ||
                  // item['NAME'].toLowerCase().contains(text.toLowerCase())
              ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('D-Tree Phase 1 Exercise'),
        ),
      body: FutureBuilder<List<dynamic>>(
        future: apiData,
        builder: (context, snapshot) {
          return RefreshIndicator(
            child: _loadTable(snapshot),
            onRefresh: _pullRefresh,
          );
        },
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(snapshot.data[index]),
          );
        },);
    }
    else {
      return const Center(
        child: Text('Loading data...'),
      );
    }
  }

  Widget _loadTable(AsyncSnapshot snapshot) {
    if(snapshot.hasData) {
        if(!loaded) {
          data = snapshot.data;
          filteredData = data;
          loaded =true;
        }
      return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
        child: ListTile(
          leading: const Text("Filter by City", style: TextStyle(fontSize: 30),),
          trailing: ElevatedButton(child: const Text("Reload"), onPressed: (){
              _pullRefresh();
          },),
          title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Type City Name...',
            border: OutlineInputBorder(),
          ),
          onChanged: _onSearchTextChanged,
        ),),
      ),
      SizedBox(
        width: double.infinity,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('SURNAME'),
              numeric: true,
            ),
            DataColumn(
              label: Text('AGE'),
            ),

            DataColumn(
              label: Text('CITY'),
            ),
          ],
          rows: List.generate(filteredData.length, (index) {
            final item = filteredData[index];
            return DataRow(
              cells: [
                DataCell(Text(item['NAME'])),
                DataCell(Text(item['SURNAME'])),
                DataCell(Text(item['AGE'].toString())),
                DataCell(Text(item['CITY'])),
              ],
            );
          }),
        ),
      ),
    ]);
    }

    return const Center(
        child: Text('Loading data...'),
      );
  }

  Future<void> _pullRefresh() async {
    final newData = await Controller.getData();
    setState(() {
      searchController.clear();
      loaded = false;
      filteredData = newData;
    });
  }
}
