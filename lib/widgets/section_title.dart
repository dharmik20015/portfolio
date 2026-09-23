import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class SectionTitle extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final bool isCenter;

  const SectionTitle({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = ThemeController.instance.accentColor;

    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Tag badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: accent.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '// $tag',
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: accent,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Title
        Text(
          title,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.outfit(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              subtitle!,
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
