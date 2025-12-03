import 'package:flutter/material.dart';
import '../models/drone.dart';
import '../theme/app_theme.dart';

class DroneDetailScreen extends StatefulWidget {
  final Drone drone;

  const DroneDetailScreen({super.key, required this.drone});

  @override
  State<DroneDetailScreen> createState() => _DroneDetailScreenState();
}

class _DroneDetailScreenState extends State<DroneDetailScreen> {
  late DroneStatus currentStatus;
  bool isCameraActive = true;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.drone.status;
  }

  void _updateStatus(DroneStatus newStatus) {
    setState(() {
      currentStatus = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Command sent: ${newStatus.name.toUpperCase()}'),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drone.name.toUpperCase()),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Live Feed Placeholder
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Grid overlay effect
                  CustomPaint(
                    painter: GridPainter(),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isCameraActive
                              ? Icons.videocam
                              : Icons.videocam_off,
                          size: 48,
                          color: AppTheme.textSecondary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isCameraActive
                              ? 'LIVE FEED CONNECTED'
                              : 'FEED DISCONNECTED',
                          style: TextStyle(
                            color: AppTheme.textSecondary.withOpacity(0.5),
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // HUD Overlay
                  Positioned(
                    top: 16,
                    left: 16,
                    child: _buildHudTag('REC', Colors.red, animate: true),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: _buildHudTag(
                        'BAT ${widget.drone.batteryLevel}%',
                        widget.drone.batteryLevel > 20
                            ? AppTheme.successColor
                            : AppTheme.errorColor),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ALT: 120m',
                          style: GoogleFonts.shareTechMono(
                              color: AppTheme.primaryColor),
                        ),
                        Text(
                          'SPD: 12m/s',
                          style: GoogleFonts.shareTechMono(
                              color: AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      'GPS: ${widget.drone.latitude}, ${widget.drone.longitude}',
                      style: GoogleFonts.shareTechMono(
                          color: AppTheme.primaryColor, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Controls Area
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CURRENT STATUS',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentStatus.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: isCameraActive,
                        onChanged: (val) {
                          setState(() {
                            isCameraActive = val;
                          });
                        },
                        activeColor: AppTheme.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'QUICK COMMANDS',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        _buildCommandButton(
                          'PATROL',
                          Icons.radar,
                          DroneStatus.patrolling,
                          AppTheme.primaryColor,
                        ),
                        _buildCommandButton(
                          'RETURN HOME',
                          Icons.home,
                          DroneStatus.returning,
                          AppTheme.warningColor,
                        ),
                        _buildCommandButton(
                          'LAND NOW',
                          Icons.flight_land,
                          DroneStatus.idle,
                          AppTheme.secondaryColor,
                        ),
                        _buildCommandButton(
                          'EMERGENCY',
                          Icons.warning,
                          DroneStatus.alert,
                          AppTheme.errorColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHudTag(String text, Color color, {bool animate = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (animate)
            Container(
              margin: const EdgeInsets.only(right: 6),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          Text(
            text,
            style: GoogleFonts.shareTechMono(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommandButton(
      String label, IconData icon, DroneStatus targetStatus, Color color) {
    final isSelected = currentStatus == targetStatus;
    return Material(
      color: isSelected ? color.withOpacity(0.2) : AppTheme.surfaceColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _updateStatus(targetStatus),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? color : AppTheme.textSecondary,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : AppTheme.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryColor.withOpacity(0.1)
      ..strokeWidth = 1;

    const double gridSize = 40;

    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
import 'package:google_fonts/google_fonts.dart';
