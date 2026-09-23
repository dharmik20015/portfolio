import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class GlassContainer extends StatefulWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  final Color? surfaceColor;
  final bool hoverEffect;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 16.0,
    this.opacity = 0.05,
    this.borderRadius,
    this.padding,
    this.margin,
    this.borderColor,
    this.surfaceColor,
    this.hoverEffect = false,
    this.onTap,
  });

  @override
  State<GlassContainer> createState() => _GlassContainerState();
}

class _GlassContainerState extends State<GlassContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = widget.borderRadius ?? BorderRadius.circular(16);

    Color defaultBg = widget.surfaceColor ??
        (isDark
            ? AppColors.darkSurface.withValues(alpha: 0.65)
            : AppColors.lightSurface.withValues(alpha: 0.85));

    final accent = ThemeController.instance.accentColor;

    Color defaultBorder = widget.borderColor ??
        (isDark
            ? (_isHovered ? accent.withValues(alpha: 0.6) : AppColors.darkBorder)
            : (_isHovered ? accent.withValues(alpha: 0.6) : AppColors.lightBorder));

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      margin: widget.margin,
      transform: widget.hoverEffect && _isHovered
          ? Matrix4.translationValues(0.0, -4.0, 0.0)
          : Matrix4.identity(),
      decoration: BoxDecoration(
        color: defaultBg,
        borderRadius: radius,
        border: Border.all(
          color: defaultBorder,
          width: _isHovered ? 1.4 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: _isHovered && widget.hoverEffect
                ? accent.withValues(alpha: 0.22)
                : Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: _isHovered && widget.hoverEffect ? 24 : 12,
            offset: Offset(0, _isHovered && widget.hoverEffect ? 8 : 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(20),
            child: widget.child,
          ),
        ),
      ),
    );

    if (widget.onTap != null || widget.hoverEffect) {
      return MouseRegion(
        cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: content,
        ),
      );
    }

    return content;
  }
}
