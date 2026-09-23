import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/neon_button.dart';
import '../widgets/section_title.dart';

class PlaygroundSection extends StatefulWidget {
  const PlaygroundSection({super.key});

  @override
  State<PlaygroundSection> createState() => _PlaygroundSectionState();
}

class _PlaygroundSectionState extends State<PlaygroundSection> {
  int _activeScreen = 0; // 0: Ticket Dispatch, 1: Live Telemetry, 2: Theme Studio
  double _animationSpeed = 1.0;
  Color _accentColor = AppColors.poisonGreen;

  // Mini App State
  int _ticketsResolved = 128;
  double _serverCpuLoad = 34.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 1050;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'LIVE FLUTTER PLAYGROUND',
            title: 'Interactive Widget Lab',
            subtitle:
                'Test-drive live Flutter components in real-time. Experience 60/120fps physics, reactive state updates, and dynamic theming.',
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 48),

          isMobile
              ? Column(
                  children: [
                    _buildDeviceFrame(isDark),
                    const SizedBox(height: 32),
                    _buildControlsPanel(isDark),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _buildControlsPanel(isDark)),
                    const SizedBox(width: 48),
                    Expanded(flex: 5, child: _buildDeviceFrame(isDark)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildControlsPanel(bool isDark) {
    return GlassContainer(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune_rounded, color: _accentColor, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Live Widget Inspector & Controls',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Mini App View Selector
          Text(
            'Select Simulated Module:',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildViewChip(0, 'Ticket CRM', Icons.confirmation_number_outlined),
              _buildViewChip(1, 'Infra Telemetry', Icons.query_stats_rounded),
              _buildViewChip(2, 'Theme Studio', Icons.palette_outlined),
            ],
          ),
          const SizedBox(height: 24),

          // Accent color switcher
          Text(
            'Dynamic Accent Glow:',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AppColors.poisonGreen,
              AppColors.neonPurple,
              AppColors.neonGreen,
              AppColors.neonPink,
              AppColors.neonAmber,
            ].map((col) {
              final isSelected = _accentColor == col;
              return GestureDetector(
                onTap: () => setState(() => _accentColor = col),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: col,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: col.withValues(alpha: isSelected ? 0.6 : 0.2),
                        blurRadius: 10,
                        spreadRadius: isSelected ? 2 : 0,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Slider for animation speed
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Animation Fluidity Multiplier:',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                ),
              ),
              Text(
                '${_animationSpeed.toStringAsFixed(1)}x',
                style: GoogleFonts.firaCode(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _accentColor,
                ),
              ),
            ],
          ),
          Slider(
            value: _animationSpeed,
            min: 0.5,
            max: 2.0,
            divisions: 6,
            activeColor: _accentColor,
            inactiveColor: isDark ? Colors.white10 : Colors.black12,
            onChanged: (val) => setState(() => _animationSpeed = val),
          ),
          const SizedBox(height: 12),

          // Metrics Pill
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0x330A0E17) : const Color(0x1A0F172A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _accentColor.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLabMetric('FPS', '120.0', AppColors.neonGreen),
                _buildLabMetric('Frame Time', '8.3ms', _accentColor),
                _buildLabMetric('Raster Cache', 'Optimal', AppColors.neonPurple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewChip(int index, String label, IconData icon) {
    final isSelected = _activeScreen == index;
    return GestureDetector(
      onTap: () => setState(() => _activeScreen = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? _accentColor.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? _accentColor : Colors.grey.withValues(alpha: 0.3),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: isSelected ? _accentColor : Colors.grey),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? _accentColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.firaCode(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDeviceFrame(bool isDark) {
    return Center(
      child: Container(
        width: 320,
        height: 580,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: _accentColor.withValues(alpha: 0.7),
            width: 3.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.3),
              blurRadius: 35,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(33),
          child: Column(
            children: [
              // Phone Notch / Speaker
              Container(
                height: 30,
                color: const Color(0xFF070B12),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              // App Screen Content
              Expanded(
                child: Container(
                  color: isDark ? const Color(0xFF0A0F1D) : const Color(0xFFF8FAFC),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: _getScreenWidget(isDark),
                  ),
                ),
              ),
              // Bottom Home Bar
              Container(
                height: 24,
                color: const Color(0xFF070B12),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getScreenWidget(bool isDark) {
    switch (_activeScreen) {
      case 0:
        return _buildTicketApp(isDark);
      case 1:
        return _buildTelemetryApp(isDark);
      case 2:
      default:
        return _buildThemeStudioApp(isDark);
    }
  }

  Widget _buildTicketApp(bool isDark) {
    return Padding(
      key: const ValueKey('ticket_app'),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Support CRM',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Online',
                  style: GoogleFonts.firaCode(fontSize: 10, color: _accentColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Quick KPI
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_accentColor.withValues(alpha: 0.2), AppColors.neonPurple.withValues(alpha: 0.2)],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _accentColor.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Resolved Tickets', style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey)),
                    Text(
                      '$_ticketsResolved',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: _accentColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.add_task_rounded),
                  color: _accentColor,
                  onPressed: () => setState(() => _ticketsResolved++),
                  tooltip: 'Resolve Ticket',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Active Queue',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                _buildTicketRow('TKT-9041', 'API latency in billing gateway', 'High', Colors.redAccent),
                _buildTicketRow('TKT-9042', 'Database lock on user session sync', 'Med', Colors.amber),
                _buildTicketRow('TKT-9043', 'Add export CSV report button', 'Low', Colors.green),
              ],
            ),
          ),
          NeonButton(
            text: 'Dispatch New SLA',
            isSmall: true,
            icon: Icons.send_rounded,
            glowColor: _accentColor,
            onPressed: () => setState(() => _ticketsResolved += 5),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketRow(String id, String desc, String priority, Color pColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: pColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(priority, style: GoogleFonts.firaCode(fontSize: 9, color: pColor)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              desc,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryApp(bool isDark) {
    return Padding(
      key: const ValueKey('telemetry_app'),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Infra Eye Telemetry',
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: _serverCpuLoad / 100,
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation<Color>(_accentColor),
                    backgroundColor: Colors.white10,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_serverCpuLoad.toInt()}%',
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: _accentColor,
                      ),
                    ),
                    Text('CPU Load', style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMiniCard('Memory', '3.4 GB', AppColors.neonPurple),
              _buildMiniCard('Latency', '24 ms', AppColors.neonGreen),
            ],
          ),
          const Spacer(),
          NeonButton(
            text: 'Simulate Load Burst',
            isSmall: true,
            icon: Icons.flash_on,
            glowColor: _accentColor,
            onPressed: () {
              setState(() {
                _serverCpuLoad = (_serverCpuLoad + 25) > 95 ? 35 : (_serverCpuLoad + 25);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(value, style: GoogleFonts.firaCode(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildThemeStudioApp(bool isDark) {
    return Padding(
      key: const ValueKey('theme_studio'),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.palette_rounded, size: 50, color: _accentColor),
          const SizedBox(height: 12),
          Text(
            'Material 3 Dynamic Canvas',
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Real-time color token computation with Flutter engine.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_accentColor, AppColors.neonPurple],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Interpolated Gradient Shader',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
