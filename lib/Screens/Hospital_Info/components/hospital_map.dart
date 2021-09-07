import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalMap extends StatefulWidget {
  HospitalMap({Key key}) : super(key: key);

  @override
  _HospitalMapState createState() => _HospitalMapState();
}

class _HospitalMapState extends State<HospitalMap> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(1.4621383380654998, 103.74644319973177);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> allMarkers = [
    Marker(
      markerId: MarkerId('KPJ Johor Specialist Hospital'),
      draggable: false,
      position: LatLng(1.4794144833758742, 103.74143284529487),
      infoWindow: InfoWindow(title: "KPJ Johor Specialist Hospital"),
    ),
    Marker(
      markerId: MarkerId('PATHLAB Laboratory Malaysia'),
      draggable: false,
      position: LatLng(1.4826865111155134, 103.76323605187638),
      infoWindow: InfoWindow(title: "PATHLAB Laboratory Malaysia"),
    ),
    Marker(
      markerId: MarkerId('Pelangi Medical Centre'),
      draggable: false,
      position: LatLng(1.484242929843916, 103.77501593996631),
      infoWindow: InfoWindow(title: "Pelangi Medical Centre"),
    ),
    Marker(
      markerId: MarkerId('Columbia Asia Hospital - Tebrau'),
      draggable: false,
      position: LatLng(1.5002425027224788, 103.76571369579041),
      infoWindow: InfoWindow(title: "Columbia Asia Hospital - Tebrau"),
    ),
    Marker(
      markerId: MarkerId('Kempas Medical Centre'),
      draggable: false,
      position: LatLng(1.5220537500184772, 103.72450395346061),
      infoWindow: InfoWindow(title: "Kempas Medical Centre"),
    ),
    Marker(
      markerId: MarkerId('Hospital Permai Johor Bahru'),
      draggable: false,
      position: LatLng(1.521785100366822, 103.70660619763648),
      infoWindow: InfoWindow(title: "Hospital Permai Johor Bahru"),
    ),
    Marker(
      markerId: MarkerId('Gleneagles Hospital Medini Johor'),
      draggable: false,
      position: LatLng(1.42698678567431, 103.63666223996638),
      infoWindow: InfoWindow(title: "Gleneagles Hospital Medini Johor"),
    ),
    Marker(
      markerId: MarkerId('Hospital Pakar Skudai'),
      draggable: false,
      position: LatLng(1.5319271739206104, 103.66623285530694),
      infoWindow: InfoWindow(title: "Hospital Pakar Skudai"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    allMarkers.add(
      Marker(
        markerId: MarkerId('Pusat Pendermaan Darah Hospital Sultanah Aminah'),
        draggable: false,
        position: _center,
        infoWindow: InfoWindow(
            title: 'Pusat Pendermaan Darah Hospital Sultanah Aminah'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Map"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 13.5,
        ),
        mapType: MapType.normal,
        markers: Set<Marker>.of(allMarkers),
      ),
    );
  }
}
