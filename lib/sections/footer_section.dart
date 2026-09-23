import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onScrollToTop;

  const FooterSection({super.key, required this.onScrollToTop});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = ThemeController.instance.accentColor;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          Divider(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo & copyright
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          gradient: ThemeController.instance.accentGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'DR',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Dharmik Rakholiya',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '© ${DateTime.now().year} Dharmik Rakholiya. Built with Flutter & Dart.',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: isDark ? AppColors.textDarkMuted : AppColors.textLightMuted,
                    ),
                  ),
                ],
              ),

              // Back to Top Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onScrollToTop,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: accent.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Top',
                          style: GoogleFonts.firaCode(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: accent,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_upward_rounded,
                          size: 16,
                          color: accent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
