import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class NeonButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isSmall;
  final Color? glowColor;

  const NeonButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.isPrimary = true,
    this.isSmall = false,
    this.glowColor,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = widget.glowColor ?? ThemeController.instance.accentColor;

    return MouseRegion(
      cursor: widget.onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isSmall ? 16 : 24,
            vertical: widget.isSmall ? 10 : 14,
          ),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? ThemeController.instance.accentGradient
                : null,
            color: widget.isPrimary
                ? null
                : (_isHovered
                    ? primaryColor.withValues(alpha: 0.15)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : (_isHovered
                      ? primaryColor
                      : primaryColor.withValues(alpha: 0.4)),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.35),
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -2.0, 0.0)
              : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: widget.isSmall ? 16 : 18,
                  color: widget.isPrimary ? Colors.black : primaryColor,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: GoogleFonts.outfit(
                  fontSize: widget.isSmall ? 13 : 15,
                  fontWeight: FontWeight.w700,
                  color: widget.isPrimary ? Colors.black : (isDark ? Colors.white : AppColors.textLightPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
