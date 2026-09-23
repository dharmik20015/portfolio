import 'package:flutter/material.dart';

class AppColors {
  // Dark Palette
  static const Color darkBg = Color(0xFF070B12);
  static const Color darkSurface = Color(0xFF0E1522);
  static const Color darkSurfaceLight = Color(0xFF162032);
  static const Color darkBorder = Color(0xFF1E2D44);
  static const Color darkBorderGlow = Color(0x3300F0FF);

  // Light Palette
  static const Color lightBg = Color(0xFFF6F8FD);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceLight = Color(0xFFF0F4F9);
  static const Color lightBorder = Color(0xFFDCE4EE);
  static const Color lightBorderGlow = Color(0x330066FF);

  // Neon & Brand Accents
  static const Color neonCyan = Color(0xFF00F0FF);
  static const Color neonPurple = Color(0xFF9D4EDD);
  static const Color neonPink = Color(0xFFFF007A);
  static const Color neonGreen = Color(0xFF00F5A0);
  static const Color neonAmber = Color(0xFFFFB703);
  static const Color neonBlue = Color(0xFF3A86FF);
  static const Color poisonGreen = Color(0xFF00FF66);
  static const Color poisonGreenDark = Color(0xFF042F1A);
  static const Color poisonGreenGlow = Color(0x6600FF66);

  // Text Colors Dark
  static const Color textDarkPrimary = Color(0xFFF1F5F9);
  static const Color textDarkSecondary = Color(0xFF94A3B8);
  static const Color textDarkMuted = Color(0xFF64748B);

  // Text Colors Light
  static const Color textLightPrimary = Color(0xFF0F172A);
  static const Color textLightSecondary = Color(0xFF475569);
  static const Color textLightMuted = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00F0FF), Color(0xFF7928CA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient poisonGradient = LinearGradient(
    colors: [Color(0xFF00FF66), Color(0xFF00E5FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF007A), Color(0xFF7928CA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [Color(0xFF00F5A0), Color(0xFF00B4D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardDarkGradient = LinearGradient(
    colors: [Color(0xCC0E1522), Color(0x99162032)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardLightGradient = LinearGradient(
    colors: [Color(0xF5FFFFFF), Color(0xEBF4F7FB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
