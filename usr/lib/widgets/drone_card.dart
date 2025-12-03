import 'package:flutter/material.dart';
import '../models/drone.dart';
import '../theme/app_theme.dart';

class DroneCard extends StatelessWidget {
  final Drone drone;
  final VoidCallback onTap;

  const DroneCard({
    super.key,
    required this.drone,
    required this.onTap,
  });

  Color _getStatusColor(DroneStatus status) {
    switch (status) {
      case DroneStatus.patrolling:
        return AppTheme.primaryColor;
      case DroneStatus.alert:
        return AppTheme.errorColor;
      case DroneStatus.charging:
        return AppTheme.successColor;
      case DroneStatus.returning:
        return AppTheme.warningColor;
      case DroneStatus.offline:
        return Colors.grey;
      default:
        return AppTheme.secondaryColor;
    }
  }

  IconData _getStatusIcon(DroneStatus status) {
    switch (status) {
      case DroneStatus.patrolling:
        return Icons.radar;
      case DroneStatus.alert:
        return Icons.warning_amber_rounded;
      case DroneStatus.charging:
        return Icons.battery_charging_full;
      case DroneStatus.returning:
        return Icons.flight_land;
      case DroneStatus.offline:
        return Icons.signal_wifi_off;
      default:
        return Icons.flight_takeoff;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(drone.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Icon(
                  _getStatusIcon(drone.status),
                  color: statusColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drone.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 14, color: AppTheme.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          drone.location,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drone.status.name.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.battery_std,
                        size: 16,
                        color: drone.batteryLevel < 20
                            ? AppTheme.errorColor
                            : AppTheme.successColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${drone.batteryLevel}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.chevron_right,
                    color: AppTheme.textSecondary.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
