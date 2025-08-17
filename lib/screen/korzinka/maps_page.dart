import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_storage/get_storage.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});
  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _mapController;
  LatLng _center = const LatLng(38.838303, 65.795153); // Default
  String _address = "Manzil aniqlanmoqda...";
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _loadLastSavedLocation();
    _determinePosition();
  }
  void _loadLastSavedLocation() {
    final lat = box.read('latitude');
    final lng = box.read('longitude');
    final addr = box.read('address');
    if (lat != null && lng != null && addr != null) {
      setState(() {
        _center = LatLng(lat, lng);
        _address = addr;
      });
    }
  }
  Future<void> _determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _center = LatLng(pos.latitude, pos.longitude);
    _mapController?.animateCamera(CameraUpdate.newLatLng(_center));
    _getAddressFromLatLng(_center);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _address = [
            place.locality,
            place.subLocality,
            place.street,
          ].where((e) => e != null && e.isNotEmpty).join(', ');
        });
      }
    } catch (_) {
      _loadLastSavedLocation();
    }
  }

  void _onCameraMove(CameraPosition pos) => _center = pos.target;

  void _onCameraIdle() => _getAddressFromLatLng(_center);

  void _saveLocation() {
    box.write('address', _address);
    box.write('latitude', _center.latitude);
    box.write('longitude', _center.longitude);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Manzil saqlandi ✅")),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yetkazib berish manzili"),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _center, zoom: 15),
            onMapCreated: (c) => _mapController = c,
            onCameraMove: _onCameraMove,
            onCameraIdle: _onCameraIdle,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          const Icon(Icons.location_on, size: 40, color: Colors.red),
          Positioned(
            bottom: 90,
            left: 20,
            right: 20,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _address,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check, color: Colors.white),
              label: const Text("Manzilni saqlash"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _saveLocation,
            ),
          ),
        ],
      ),
    );
  }
}
