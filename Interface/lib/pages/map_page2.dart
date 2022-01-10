import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

import 'example_popup.dart';

class SimpleMapWithPopups extends StatelessWidget {
  final List<LatLng> _markerPositions = [
    LatLng(45.760696, 21.226788),
  ];

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  SimpleMapWithPopups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 16.0,
        center: LatLng(45.760696, 21.226788),
        // onTap: (_) => _popupLayerController
        //     .hideAllPopups(), // Hide popup when the map is tapped.
      ),
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            popupController: _popupLayerController,
            markers: _markers,
            markerRotateAlignment:
                PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            popupBuilder: (BuildContext context, Marker marker) =>
                ExamplePopup(marker),
          ),
        ),
      ],
    );
  }

  List<Marker> get _markers => _markerPositions
      .map(
        (markerPosition) => Marker(
          point: markerPosition,
          width: 40,
          height: 40,
          builder: (_) =>
              const Icon(Icons.location_on, size: 40, color: Colors.red),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ),
      )
      .toList();
}
