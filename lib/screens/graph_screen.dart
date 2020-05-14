import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:provider/provider.dart';

// import '../models/transaction_prov.dart';
// import '../models/key_and_item_prov.dart';

class GraphScreen extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GraphScreen(this.seriesList, this.animate);

  /// Creates a [PieChart] with sample data and no transition.
  // factory GraphScreen.withSampleData() {
  //   return new GraphScreen(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(80),
      child: charts.PieChart(seriesList,
          animate: animate,
          // Add an [ArcLabelDecorator] configured to render labels outside of the
          // arc with a leader line.
          //
          // Text style for inside / outside can be controlled independently by
          // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
          //
          // Example configuring different styles for inside/outside:
          //       new charts.ArcLabelDecorator(
          //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
          //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
          defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
            new charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.outside)
          ])),
    );
  }
}
