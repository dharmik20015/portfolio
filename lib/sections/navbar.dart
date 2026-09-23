import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/neon_button.dart';

class Navbar extends StatelessWidget {
  final Function(int) onNavItemSelected;
  final VoidCallback onOpenDrawer;

  const Navbar({
    super.key,
    required this.onNavItemSelected,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 1050;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface.withValues(alpha: 0.75)
                    : AppColors.lightSurface.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Brand Logo
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => onNavItemSelected(0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: ThemeController.instance.accentGradient,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'DR',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              text: 'Dharmik',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.textDarkPrimary
                                    : AppColors.textLightPrimary,
                              ),
                              children: [
                                TextSpan(
                                  text: '.dev',
                                  style: TextStyle(
                                    color: ThemeController.instance.accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Desktop Nav Links
                  if (!isMobile)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildNavItem('About', 1, isDark),
                            _buildNavItem('Skills', 2, isDark),
                            _buildNavItem('Projects', 3, isDark),
                            _buildNavItem('Widget Lab', 4, isDark),
                            _buildNavItem('Experience', 5, isDark),
                            _buildNavItem('Contact', 6, isDark),
                          ],
                        ),
                      ),
                    )
                  else
                    const Spacer(),
                  const SizedBox(width: 8),
                  // Theme Dark/Light Toggle
                  ListenableBuilder(
                    listenable: ThemeController.instance,
                    builder: (context, _) {
                      return IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) =>
                              RotationTransition(turns: anim, child: child),
                          child: Icon(
                            ThemeController.instance.isDarkMode
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            key: ValueKey(ThemeController.instance.isDarkMode),
                            color: isDark
                                ? AppColors.neonAmber
                                : AppColors.neonPurple,
                            size: 20,
                          ),
                        ),
                        onPressed: () => ThemeController.instance.toggleTheme(),
                        tooltip: 'Toggle Theme',
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  if (!isMobile)
                    NeonButton(
                      text: 'Hire Me',
                      icon: Icons.rocket_launch,
                      isSmall: true,
                      onPressed: () => onNavItemSelected(6),
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.menu_rounded),
                      onPressed: onOpenDrawer,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int index, bool isDark) {
    return _HoverNavItem(
      title: title,
      isDark: isDark,
      onTap: () => onNavItemSelected(index),
    );
  }
}

class _HoverNavItem extends StatefulWidget {
  final String title;
  final bool isDark;
  final VoidCallback onTap;

  const _HoverNavItem({
    required this.title,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<_HoverNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = ThemeController.instance.accentColor;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _isHovered
                      ? accent
                      : (widget.isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textLightSecondary),
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isHovered ? 16 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
