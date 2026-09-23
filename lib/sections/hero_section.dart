import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/neon_button.dart';
import '../widgets/terminal_simulator.dart';
import '../widgets/tilt_card.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onExploreProjects;
  final VoidCallback onContactMe;

  const HeroSection({
    super.key,
    required this.onExploreProjects,
    required this.onContactMe,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int _roleIndex = 0;
  Timer? _roleTimer;

  @override
  void initState() {
    super.initState();
    _roleTimer = Timer.periodic(const Duration(milliseconds: 2800), (timer) {
      if (mounted) {
        setState(() {
          _roleIndex = (_roleIndex + 1) % PortfolioData.rotatingRoles.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _roleTimer?.cancel();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLarge = screenWidth > 1050;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: isLarge ? 40 : 20,
        ),
      child: isLarge
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildLeftContent(isDark),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 5,
                  child: _buildRightVisual(isDark),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildRightVisual(isDark),
                const SizedBox(height: 36),
                _buildLeftContent(isDark, isCenter: true),
              ],
            ),
      ),
    );
  }

  Widget _buildLeftContent(bool isDark, {bool isCenter = false}) {
    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Status Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.neonGreen.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.neonGreen.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.neonGreen,
                  shape: BoxShape.circle,
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.3, 1.3), duration: 1000.ms),
              const SizedBox(width: 8),
              Text(
                'Available for Senior Flutter Roles & Projects',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.neonGreen,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 18),

        // Salutation
        Text(
          'Hello, World! I\'m',
          style: GoogleFonts.firaCode(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ThemeController.instance.accentColor,
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),
        const SizedBox(height: 8),

        // Name
        Text(
          PortfolioData.name,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
            height: 1.1,
            color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 12),

        // Rotating Role Title
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '> ',
              style: GoogleFonts.firaCode(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeController.instance.accentColor,
              ),
            ),
            Flexible(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  PortfolioData.rotatingRoles[_roleIndex],
                  key: ValueKey(_roleIndex),
                  textAlign: isCenter ? TextAlign.center : TextAlign.start,
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: ThemeController.instance.accentColor,
                  ),
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 18),

        // Bio short
        Text(
          'Architecting fluid 60/120fps cross-platform applications across Mobile, Web, and Desktop. '
          '5+ years turning complex enterprise requirements into high-performance, elegant Flutter solutions.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.outfit(
            fontSize: 16,
            height: 1.6,
            color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
          ),
        ).animate().fadeIn(delay: 500.ms),
        const SizedBox(height: 28),

        // Action Buttons
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            NeonButton(
              text: 'Explore Projects',
              icon: Icons.work_outline_rounded,
              onPressed: widget.onExploreProjects,
            ),
            NeonButton(
              text: 'Contact Dharmik',
              icon: Icons.chat_bubble_outline_rounded,
              isPrimary: false,
              onPressed: widget.onContactMe,
            ),
            NeonButton(
              text: 'Call +91 9328045023',
              icon: Icons.phone_in_talk_rounded,
              isPrimary: false,
              glowColor: AppColors.neonGreen,
              onPressed: () => _launchUrl('tel:+919328045023'),
            ),
          ],
        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.15, end: 0),
        const SizedBox(height: 28),

        // Social Icons Row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/dharmikrakholiya', isDark),
            const SizedBox(width: 14),
            _buildSocialIcon(FontAwesomeIcons.envelope, 'mailto:${PortfolioData.email}', isDark),
            const SizedBox(width: 14),
            _buildSocialIcon(FontAwesomeIcons.whatsapp, 'https://wa.me/919328045023', isDark),
            const SizedBox(width: 14),
            _buildSocialIcon(FontAwesomeIcons.locationDot, 'https://maps.google.com/?q=${PortfolioData.location}', isDark),
          ],
        ).animate().fadeIn(delay: 700.ms),
      ],
    );
  }

  Widget _buildRightVisual(bool isDark) {
    return Column(
      children: [
        // 3D Tilt Profile Card with glowing border
        TiltCard(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: isDark ? AppColors.cardDarkGradient : AppColors.cardLightGradient,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: ThemeController.instance.accentColor.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    PortfolioData.profileImage,
                    width: 320,
                    height: 380,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 320,
                        height: 380,
                        color: isDark ? AppColors.darkSurfaceLight : Colors.grey[200],
                        child: Icon(Icons.person, size: 100, color: ThemeController.instance.accentColor),
                      );
                    },
                  ),
                ),
                // Floating Experience Tag
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xDD070B12)
                          : const Color(0xEEFFFFFF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: ThemeController.instance.accentColor.withValues(alpha: 0.6),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildProfileMiniStat('5+', 'Years Exp', isDark),
                        Container(width: 1, height: 26, color: Colors.grey.withValues(alpha: 0.3)),
                        _buildProfileMiniStat('25+', 'CRMs & Apps', isDark),
                        Container(width: 1, height: 26, color: Colors.grey.withValues(alpha: 0.3)),
                        _buildProfileMiniStat('100%', 'Flutter', isDark),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 350.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
        const SizedBox(height: 24),
        // Live Terminal Simulator
        const TerminalSimulator().animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }

  Widget _buildProfileMiniStat(String number, String label, bool isDark) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: ThemeController.instance.accentColor,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(FaIconData icon, String url, bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurface.withValues(alpha: 0.9)
                : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
          child: FaIcon(
            icon,
            size: 16,
            color: ThemeController.instance.accentColor,
          ),
        ),
      ),
    );
  }
}
