import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  static const LatLng _center = LatLng(45.760696, 21.226788);
  Location _location = Location();
  late GoogleMapController _controller;
  bool addingNewMarker = false;

  List<Marker> markers = <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _location.onLocationChanged.listen(
      (location) => _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(location.latitude!, location.longitude!),
              zoom: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(target: _center),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: Set.from(markers),
              onTap: _handleTap,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              // add your floating action button
              child: FloatingActionButton(
                onPressed: () => {
                  setState(() => addingNewMarker = !addingNewMarker),
                  // addingNewMarker ? true : false,
                  print(addingNewMarker.toString()),
                },
                child: const Icon(Icons.add),
                backgroundColor: addingNewMarker ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );

    throw UnimplementedError();
  }

  _handleTap(LatLng tappedPoint) {
    setState(
      () {
        //markers = [];
        if (addingNewMarker) {
          markers.add(
            Marker(
                markerId: MarkerId(tappedPoint.toString()),
                position: tappedPoint,
                draggable: true,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                onDragEnd: (dragEndPosition) {
                  print(dragEndPosition);
                }),
          );
          addingNewMarker = !addingNewMarker;
        } else {
          print('button not pressed!');
        }
      },
    );
  }
}
