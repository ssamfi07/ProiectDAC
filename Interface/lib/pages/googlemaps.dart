import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:custom_info_window/custom_info_window.dart';

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
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  List<Marker> markers = <Marker>[];

  void _onMapCreated(GoogleMapController controller) async {
    _customInfoWindowController.googleMapController = controller;
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
              initialCameraPosition: CameraPosition(target: _center),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: Set.from(markers),
              onTap: _handleTap,
              onCameraMove: (position) {
                // _customInfoWindowController.hideInfoWindow!();
                _customInfoWindowController.onCameraMove!();
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 75,
              width: 150,
              offset: 50,
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
                draggable: addingNewMarker ? true : false,
                onTap: () {
                  _customInfoWindowController.addInfoWindow!(
                      GestureDetector(
                        onTap: _customInfoWindowController.hideInfoWindow!,
                        child: Container(
                          // color: Colors.green,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "title",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "description",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                tappedPoint.latitude.toString() +
                                    "   " +
                                    tappedPoint.longitude.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      tappedPoint);
                },
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
