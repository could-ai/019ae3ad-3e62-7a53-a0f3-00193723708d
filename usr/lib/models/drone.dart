enum DroneStatus {
  idle,
  patrolling,
  returning,
  charging,
  alert,
  offline
}

class Drone {
  final String id;
  final String name;
  final DroneStatus status;
  final int batteryLevel;
  final String location;
  final double latitude;
  final double longitude;
  final String lastUpdate;
  final String videoFeedUrl;

  Drone({
    required this.id,
    required this.name,
    required this.status,
    required this.batteryLevel,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.lastUpdate,
    this.videoFeedUrl = '',
  });

  // Mock data factory
  static List<Drone> getMockDrones() {
    return [
      Drone(
        id: 'D-001',
        name: 'Alpha Sentinel',
        status: DroneStatus.patrolling,
        batteryLevel: 78,
        location: 'North Sector',
        latitude: 37.7749,
        longitude: -122.4194,
        lastUpdate: 'Just now',
      ),
      Drone(
        id: 'D-002',
        name: 'Bravo Guard',
        status: DroneStatus.charging,
        batteryLevel: 100,
        location: 'Base Station A',
        latitude: 37.7750,
        longitude: -122.4180,
        lastUpdate: '5 mins ago',
      ),
      Drone(
        id: 'D-003',
        name: 'Charlie Scout',
        status: DroneStatus.alert,
        batteryLevel: 45,
        location: 'East Perimeter',
        latitude: 37.7730,
        longitude: -122.4200,
        lastUpdate: '1 min ago',
      ),
      Drone(
        id: 'D-004',
        name: 'Delta Force',
        status: DroneStatus.idle,
        batteryLevel: 92,
        location: 'Base Station B',
        latitude: 37.7760,
        longitude: -122.4170,
        lastUpdate: '10 mins ago',
      ),
    ];
  }
}
