import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;

    const LatLng _center = LatLng(45.760696, 21.226788);
    Location _location = Location();
    GoogleMapController _controller;

    List<Marker> markers = <Marker>[];

    _handleTap(LatLng) {}

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
                  onTap: _handleTap,
                )
              ],
            )));
  }
}
