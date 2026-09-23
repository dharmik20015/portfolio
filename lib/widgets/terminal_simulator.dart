import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class TerminalSimulator extends StatefulWidget {
  final VoidCallback? onHotReload;

  const TerminalSimulator({super.key, this.onHotReload});

  @override
  State<TerminalSimulator> createState() => _TerminalSimulatorState();
}

class _TerminalSimulatorState extends State<TerminalSimulator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  int _activeTab = 0; // 0: code, 1: terminal
  bool _isReloading = false;
  int _reloadCount = 42;
  String _typedText = '';
  Timer? _typeTimer;
  int _charIndex = 0;

  static const String _fullCode = '''class FlutterDeveloper extends Expert {
  final String name = "Dharmik Rakholiya";
  final int yearsExperience = 5;
  final List<String> coreStack = [
    "Flutter", "Dart", "Clean Arch",
    "Riverpod", "BLoC", "Supabase", "Firebase"
  ];

  @override
  Future<App> buildExceptionalProduct() async {
    return App(
      performance: "120 FPS Fluid",
      quality: "99.9% Crash Free",
      scalability: "Enterprise Grade",
    );
  }
}''';

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _startTyping();
  }

  void _startTyping() {
    _typeTimer = Timer.periodic(const Duration(milliseconds: 25), (timer) {
      if (_charIndex < _fullCode.length) {
        setState(() {
          _typedText = _fullCode.substring(0, _charIndex + 1);
          _charIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _typeTimer?.cancel();
    super.dispose();
  }

  void _triggerHotReload() {
    if (_isReloading) return;
    setState(() {
      _isReloading = true;
      _reloadCount++;
    });

    widget.onHotReload?.call();

    Future.delayed(const Duration(milliseconds: 650), () {
      if (mounted) {
        setState(() {
          _isReloading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final accent = ThemeController.instance.accentColor;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 580),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0A0F1A) : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accent.withValues(alpha: isDark ? 0.4 : 0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.18),
            blurRadius: 30,
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Terminal Top Titlebar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF070B12) : const Color(0xFF0F172A),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            child: Row(
              children: [
                // Window dots
                Container(
                  width: 11,
                  height: 11,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5F56),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 11,
                  height: 11,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFBD2E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 11,
                  height: 11,
                  decoration: const BoxDecoration(
                    color: Color(0xFF27C93F),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 18),
                // Tabs
                _buildTab(0, 'developer.dart', Icons.flutter_dash),
                const SizedBox(width: 8),
                _buildTab(1, 'terminal', Icons.terminal),
                const Spacer(),
                // Hot reload action button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _triggerHotReload,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _isReloading
                            ? AppColors.neonAmber.withValues(alpha: 0.25)
                            : ThemeController.instance.accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _isReloading
                              ? AppColors.neonAmber
                              : ThemeController.instance.accentColor.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bolt,
                            size: 14,
                            color: _isReloading ? AppColors.neonAmber : ThemeController.instance.accentColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _isReloading ? 'Reloading...' : 'Hot Reload',
                            style: GoogleFonts.firaCode(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _isReloading ? AppColors.neonAmber : ThemeController.instance.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content Area
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState:
                _activeTab == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: _buildCodeView(),
            secondChild: _buildTerminalView(),
          ),
          // Bottom Status Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF070B12) : const Color(0xFF0F172A),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, size: 13, color: AppColors.neonGreen),
                const SizedBox(width: 6),
                Text(
                  'Flutter 3.41.8 • Dart 3.11.5 • Null Safety Active',
                  style: GoogleFonts.firaCode(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const Spacer(),
                Text(
                  '⚡ Sync: $_reloadCount reloads',
                  style: GoogleFonts.firaCode(
                    fontSize: 11,
                    color: ThemeController.instance.accentColor.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon) {
    final isSelected = _activeTab == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 13,
                color: isSelected ? ThemeController.instance.accentColor : Colors.white.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 5),
              Text(
                label,
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeView() {
    final lines = _typedText.split('\n');
    return Container(
      padding: const EdgeInsets.all(16),
      height: 260,
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Line numbers
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                lines.length,
                (i) => Text(
                  '${i + 1} ',
                  style: GoogleFonts.firaCode(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Code text
            Expanded(
              child: RichText(
                text: _highlightDartCode(_typedText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTerminalView() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$ flutter run -d chrome --release',
            style: GoogleFonts.firaCode(
              fontSize: 13,
              color: AppColors.neonGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Launching lib/main.dart on Chrome in release mode...',
            style: GoogleFonts.firaCode(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '✓ Building browser app with CanvasKit renderer (1.4s)',
            style: GoogleFonts.firaCode(
              fontSize: 12,
              color: AppColors.poisonGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '✓ Initializing Dharmik\'s Portfolio at localhost:8080',
            style: GoogleFonts.firaCode(
              fontSize: 12,
              color: AppColors.neonGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '🔥 Flutter hot reload is connected and ready.',
            style: GoogleFonts.firaCode(
              fontSize: 12,
              color: AppColors.neonAmber,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                'ready > ',
                style: GoogleFonts.firaCode(
                  fontSize: 13,
                  color: AppColors.poisonGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FadeTransition(
                opacity: _pulseController,
                child: Container(
                  width: 8,
                  height: 15,
                  color: AppColors.poisonGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextSpan _highlightDartCode(String code) {
    final spans = <TextSpan>[];
    final regex = RegExp(
      r'(".*?")|(\bclass\b|\bextends\b|\bfinal\b|\bint\b|\bString\b|\bList\b|\bFuture\b|\breturn\b|\basync\b|\bstatic\b|\bconst\b)|(@\w+)|(\b\d+\b)',
    );

    int lastIndex = 0;
    for (final match in regex.allMatches(code)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: code.substring(lastIndex, match.start),
          style: GoogleFonts.firaCode(
            fontSize: 13,
            height: 1.5,
            color: const Color(0xFFE2E8F0),
          ),
        ));
      }

      final text = match.group(0)!;
      Color color = const Color(0xFFE2E8F0);

      if (text.startsWith('"')) {
        color = AppColors.neonGreen; // Strings
      } else if (text.startsWith('@')) {
        color = AppColors.neonAmber; // Annotations
      } else if (int.tryParse(text) != null) {
        color = AppColors.neonPink; // Numbers
      } else {
        color = AppColors.poisonGreen; // Keywords
      }

      spans.add(TextSpan(
        text: text,
        style: GoogleFonts.firaCode(
          fontSize: 13,
          height: 1.5,
          color: color,
          fontWeight: (color == AppColors.poisonGreen) ? FontWeight.w600 : FontWeight.normal,
        ),
      ));

      lastIndex = match.end;
    }

    if (lastIndex < code.length) {
      spans.add(TextSpan(
        text: code.substring(lastIndex),
        style: GoogleFonts.firaCode(
          fontSize: 13,
          height: 1.5,
          color: const Color(0xFFE2E8F0),
        ),
      ));
    }

    return TextSpan(children: spans);
  }
}
