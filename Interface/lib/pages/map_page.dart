import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:proiect_dac/home_screen/my_home_page.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(45.760696, 21.226788),
                    zoom: 16,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      // attributionBuilder: (_) {
                      //   return const Text("© OpenStreetMap contributors");
                      // },
                    ),

                    // MarkerLayerOptions(
                    //   markers: [
                    //     Marker(
                    //       point: LatLng(45.760696, 21.226788),
                    //       builder: (context) => MarkerWithTooltip(
                    //         tooltip: "Yo MADAFAKA "
                    //             " Radu suge",
                    //         onTap: () => {},
                    //         child: const Icon(
                    //           Icons.location_on,
                    //           color: Colors.red,
                    //           size: 35,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              // const Flexible(
              //   child: MyHomePage(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarkerWithTooltip extends StatefulWidget {
  final Widget child;
  final String tooltip;
  final Function onTap;

  MarkerWithTooltip(
      {required this.child, required this.tooltip, required this.onTap});

  @override
  _MapMarkerState createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MarkerWithTooltip> {
  final key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          final dynamic tooltip = key.currentState;
          tooltip.ensureTooltipVisible();
          widget.onTap();
        },
        child: Tooltip(
          key: key,
          message: widget.tooltip,
          child: widget.child,
        ));
  }
}
