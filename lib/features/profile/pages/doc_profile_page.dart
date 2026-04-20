import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/utils/utils.dart';
import 'package:terra_agent/core/widgets/widgets.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN ENTRY — tabs: Documents / Localisation / Formation
// ═══════════════════════════════════════════════════════════════════════════════

class MyDocumentsPage extends StatefulWidget {
  const MyDocumentsPage({super.key});

  @override
  State<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends State<MyDocumentsPage>
    with TickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          Container(
            height: 26.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appColor, appColorSecondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.w, vertical: 1.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 5.w,
                          ),
                        ),
                      ).animate().fade(duration: 400.ms),
                      Gap(3.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mon dossier",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "Gérez vos documents et informations",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 9.5.sp,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 500.ms),
                    ],
                  ),
                ),

                Gap(2.h),

                // Tab bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: TabBar(
                      controller: _tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.w),
                        color: Colors.white,
                      ),
                      labelColor: appColor,
                      unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 9.5.sp),
                      unselectedLabelStyle:
                      TextStyle(fontSize: 9.5.sp),
                      tabs: [
                        _TabItem(
                            icon: Icons.folder_rounded,
                            label: "Documents"),
                        _TabItem(
                            icon: Icons.location_on_rounded,
                            label: "Localisation"),
                        _TabItem(
                            icon: Icons.school_rounded,
                            label: "Formation"),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 600.ms),

                Gap(2.h),

                // Content
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        topRight: Radius.circular(8.w),
                      ),
                    ),
                    child: TabBarView(
                      controller: _tab,
                      children: const [
                        _DocumentsTab(),
                        _LocationTab(),
                        _FormationTab(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 4.w),
        Gap(1.5.w),
        Text(label),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — DOCUMENTS
// ═══════════════════════════════════════════════════════════════════════════════

class _DocumentsTab extends StatefulWidget {
  const _DocumentsTab();

  @override
  State<_DocumentsTab> createState() => _DocumentsTabState();
}

class _DocumentsTabState extends State<_DocumentsTab> {
  File? _rectoCNI, _versoCNI;
  File? _rectoPermis, _versoPermis;
  File? _rectoDiplome, _versoDiplome;

  // Simulated existing server images (shown as asset placeholders)
  final bool _hasCNI = true;
  final bool _hasPermis = false;
  final bool _hasDiplome = true;

  Future<void> _pick(
      {required bool isRecto, required String type}) async {
    final picker = ImagePicker();
    final picked =
    await picker.pickImage(source: ImageSource.camera);
    if (picked == null) return;
    setState(() {
      switch (type) {
        case "cni":
          isRecto
              ? _rectoCNI = File(picked.path)
              : _versoCNI = File(picked.path);
          break;
        case "permis":
          isRecto
              ? _rectoPermis = File(picked.path)
              : _versoPermis = File(picked.path);
          break;
        case "diplome":
          isRecto
              ? _rectoDiplome = File(picked.path)
              : _versoDiplome = File(picked.path);
          break;
      }
    });
  }

  int get _uploadedCount => [
    _rectoCNI, _versoCNI,
    _rectoPermis, _versoPermis,
    _rectoDiplome, _versoDiplome,
  ].where((f) => f != null).length;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info banner
          Container(
            padding: EdgeInsets.all(3.5.w),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(3.w),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.tips_and_updates_rounded,
                    color: Colors.amber.shade700, size: 5.w),
                Gap(2.w),
                Expanded(
                  child: Text(
                    "Appuyez sur une photo pour la remplacer. Les nouvelles photos seront enregistrées après validation.",
                    style: TextStyle(
                        color: Colors.amber.shade800,
                        fontSize: 9.5.sp,
                        height: 1.5),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),

          Gap(2.5.h),

          _DocSection(
            title: "Pièce d'identité / Passeport",
            icon: Icons.badge_rounded,
            isRequired: true,
            hasExisting: _hasCNI,
            rectoFile: _rectoCNI,
            versoFile: _versoCNI,
            onPickRecto: () => _pick(isRecto: true, type: "cni"),
            onPickVerso: () => _pick(isRecto: false, type: "cni"),
            delay: 100,
          ),

          Gap(2.h),

          _DocSection(
            title: "Permis de conduire",
            icon: Icons.drive_eta_rounded,
            hasExisting: _hasPermis,
            rectoFile: _rectoPermis,
            versoFile: _versoPermis,
            onPickRecto: () => _pick(isRecto: true, type: "permis"),
            onPickVerso: () => _pick(isRecto: false, type: "permis"),
            delay: 200,
          ),

          Gap(2.h),

          _DocSection(
            title: "Dernier diplôme",
            icon: Icons.workspace_premium_rounded,
            hasExisting: _hasDiplome,
            rectoFile: _rectoDiplome,
            versoFile: _versoDiplome,
            onPickRecto: () =>
                _pick(isRecto: true, type: "diplome"),
            onPickVerso: () =>
                _pick(isRecto: false, type: "diplome"),
            delay: 300,
          ),

          Gap(3.h),

          if (_uploadedCount > 0)
            SubmitButton(
              "Enregistrer les modifications",
              onPressed: () async {
                SnackbarHelper.showSuccess(
                    context, "Documents mis à jour !");
              },
            ).animate().fadeIn(duration: 400.ms),

          Gap(4.h),
        ],
      ),
    );
  }
}

class _DocSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool hasExisting;
  final bool isRequired;
  final File? rectoFile;
  final File? versoFile;
  final VoidCallback onPickRecto;
  final VoidCallback onPickVerso;
  final int delay;

  const _DocSection({
    required this.title,
    required this.icon,
    required this.hasExisting,
    required this.rectoFile,
    required this.versoFile,
    required this.onPickRecto,
    required this.onPickVerso,
    this.isRequired = false,
    this.delay = 0,
  });

  bool get _hasNew => rectoFile != null || versoFile != null;
  bool get _isComplete =>
      (hasExisting || rectoFile != null) &&
          (hasExisting || versoFile != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
        border: Border.all(
          color: _hasNew
              ? appColor.withValues(alpha: 0.4)
              : hasExisting
              ? Colors.green.shade200
              : Colors.grey.shade200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: hasExisting
                      ? Colors.green.shade50
                      : appColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon,
                    color: hasExisting
                        ? Colors.green.shade600
                        : appColor,
                    size: 5.w),
              ),
              Gap(3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: appColorBlack)),
                        ),
                        if (isRequired)
                          _Badge(label: "Requis", color: Colors.red.shade400),
                        if (hasExisting && !_hasNew)
                          _Badge(
                              label: "✓ Enregistré",
                              color: Colors.green.shade600),
                        if (_hasNew)
                          _Badge(
                              label: "Modifié",
                              color: appColor),
                      ],
                    ),
                    Text(
                      hasExisting
                          ? "Appuyez pour remplacer"
                          : "Aucun document — ajoutez recto & verso",
                      style: TextStyle(
                          color: appColorBlack.withValues(alpha: 0.4),
                          fontSize: 9.5.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Gap(2.h),

          // Photo boxes
          Row(
            children: [
              Expanded(
                child: _DocPhotoBox(
                  label: "Recto",
                  file: rectoFile,
                  hasExisting: hasExisting,
                  onTap: onPickRecto,
                ),
              ),
              Gap(3.w),
              Expanded(
                child: _DocPhotoBox(
                  label: "Verso",
                  file: versoFile,
                  hasExisting: hasExisting,
                  onTap: onPickVerso,
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: delay),
    )
        .slideY(begin: 0.06, duration: const Duration(milliseconds: 400));
  }
}

class _DocPhotoBox extends StatelessWidget {
  final String label;
  final File? file;
  final bool hasExisting;
  final VoidCallback onTap;

  const _DocPhotoBox({
    required this.label,
    required this.file,
    required this.hasExisting,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = file != null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 22.w,
        decoration: BoxDecoration(
          color: hasFile
              ? Colors.transparent
              : hasExisting
              ? Colors.green.shade50
              : appColor.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(
            color: hasFile
                ? appColor.withValues(alpha: 0.5)
                : hasExisting
                ? Colors.green.shade300
                : Colors.grey.shade300,
            width: 1.5,
          ),
          image: hasFile
              ? DecorationImage(
              image: FileImage(file!), fit: BoxFit.cover)
              : null,
        ),
        child: hasFile
            ? Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(1.5.w),
            child: Container(
              padding: EdgeInsets.all(1.w),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Icon(Icons.check_rounded,
                  color: Colors.green, size: 3.5.w),
            ),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasExisting
                  ? Icons.edit_rounded
                  : Icons.add_a_photo_rounded,
              color: hasExisting
                  ? Colors.green.shade500
                  : appColor.withValues(alpha: 0.5),
              size: 6.w,
            ),
            Gap(0.5.h),
            Text(
              label,
              style: TextStyle(
                color: hasExisting
                    ? Colors.green.shade600
                    : appColorBlack.withValues(alpha: 0.4),
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1.5.w),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label,
          style: TextStyle(
              color: color,
              fontSize: 8.5.sp,
              fontWeight: FontWeight.w700)),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — LOCALISATION
// ═══════════════════════════════════════════════════════════════════════════════

class _LocationTab extends StatefulWidget {
  const _LocationTab();

  @override
  State<_LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<_LocationTab> {
  String? countryValue = "Ivory Coast";
  String? stateValue = "Abidjan";
  String? cityValue = "Cocody";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current location card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: appColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(4.w),
              border: Border.all(color: appColor.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.location_on_rounded,
                      color: appColor, size: 6.w),
                ),
                Gap(3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Localisation actuelle",
                        style: TextStyle(
                            color: appColorBlack.withValues(alpha: 0.5),
                            fontSize: 9.5.sp),
                      ),
                      Text(
                        [
                          if (cityValue?.isNotEmpty ?? false) cityValue!,
                          if (stateValue?.isNotEmpty ?? false) stateValue!,
                          if (countryValue?.isNotEmpty ?? false) countryValue!,
                        ].join(", "),
                        style: TextStyle(
                          color: appColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),

          Gap(3.h),

          // Section title
          Row(
            children: [
              Container(
                width: 1.w,
                height: 4.w,
                decoration: BoxDecoration(
                    color: appColor,
                    borderRadius: BorderRadius.circular(2)),
              ),
              Gap(2.w),
              Text("Modifier la localisation",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: appColorBlack)),
            ],
          ).animate().fadeIn(duration: 500.ms),

          Gap(2.h),

          SelectState(
            onCountryChanged: (v) => setState(() => countryValue = v),
            onStateChanged: (v) => setState(() => stateValue = v),
            onCityChanged: (v) => setState(() => cityValue = v),
          ).animate().fadeIn(duration: 600.ms),

          Gap(3.h),

          SubmitButton(
            "Enregistrer la localisation",
            onPressed: () async {
              if (countryValue?.isEmpty ?? true) {
                SnackbarHelper.showError(
                    context, "Veuillez sélectionner un pays");
                return;
              }
              SnackbarHelper.showSuccess(
                  context, "Localisation mise à jour !");
            },
          ).animate().fadeIn(duration: 700.ms),

          Gap(4.h),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — FORMATION & COMPÉTENCES
// ═══════════════════════════════════════════════════════════════════════════════

class _FormationTab extends StatefulWidget {
  const _FormationTab();

  @override
  State<_FormationTab> createState() => _FormationTabState();
}

class _FormationTabState extends State<_FormationTab> {
  String? _niveau = "Université";
  String? _diplome = "Licence";
  String? _langue = "Français";
  String? _experience = "Oui";
  String? _permis = "Non";

  static const _configs = [
    _DropConfig(
        key: 'niveau',
        label: "Niveau d'étude",
        icon: Icons.school_rounded,
        items: ["Primaire", "Secondaire", "Université", "Autres"]),
    _DropConfig(
        key: 'diplome',
        label: "Dernier diplôme",
        icon: Icons.workspace_premium_rounded,
        items: ["BEPC", "BAC", "Licence", "Master", "Doctorat"]),
    _DropConfig(
        key: 'langue',
        label: "Langue principale",
        icon: Icons.translate_rounded,
        items: ["Français", "Anglais", "Espagnol", "Autres"]),
    _DropConfig(
        key: 'experience',
        label: "Expérience terrain",
        icon: Icons.work_history_rounded,
        items: ["Oui", "Non"]),
    _DropConfig(
        key: 'permis',
        label: "Permis de conduire",
        icon: Icons.drive_eta_rounded,
        items: ["Oui", "Non"]),
  ];

  String? _get(String key) {
    switch (key) {
      case 'niveau':    return _niveau;
      case 'diplome':   return _diplome;
      case 'langue':    return _langue;
      case 'experience':return _experience;
      case 'permis':    return _permis;
      default:          return null;
    }
  }

  void _set(String key, String? val) {
    setState(() {
      switch (key) {
        case 'niveau':     _niveau = val; break;
        case 'diplome':    _diplome = val; break;
        case 'langue':     _langue = val; break;
        case 'experience': _experience = val; break;
        case 'permis':     _permis = val; break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary chips
          Wrap(
            spacing: 2.w,
            runSpacing: 1.5.w,
            children: _configs.map((c) {
              final val = _get(c.key);
              if (val == null) return const SizedBox.shrink();
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 3.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                  color: appColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.w),
                  border: Border.all(color: appColor.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(c.icon, color: appColor, size: 3.5.w),
                    Gap(1.5.w),
                    Text(val,
                        style: TextStyle(
                            color: appColor,
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              );
            }).toList(),
          ).animate().fadeIn(duration: 400.ms),

          Gap(3.h),

          Row(
            children: [
              Container(
                width: 1.w,
                height: 4.w,
                decoration: BoxDecoration(
                    color: appColor,
                    borderRadius: BorderRadius.circular(2)),
              ),
              Gap(2.w),
              Text("Modifier la formation",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: appColorBlack)),
            ],
          ).animate().fadeIn(duration: 500.ms),

          Gap(2.h),

          // Dropdowns
          ...List.generate(_configs.length, (i) {
            final c = _configs[i];
            final val = _get(c.key);
            return Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: DropdownButtonFormField<String>(
                initialValue: val,
                decoration: InputDecoration(
                  labelText: c.label,
                  labelStyle: TextStyle(
                      color: appColorBlack.withValues(alpha: 0.5),
                      fontSize: 11.sp),
                  filled: true,
                  fillColor: val != null
                      ? appColor.withValues(alpha: 0.05)
                      : Colors.grey.shade100,
                  prefixIcon: Icon(c.icon,
                      color: val != null
                          ? appColor
                          : appColorBlack.withValues(alpha: 0.3),
                      size: 5.w),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.w),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    borderSide: BorderSide(
                      color: val != null
                          ? appColor.withValues(alpha: 0.3)
                          : Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    borderSide:
                    BorderSide(color: appColor, width: 1.8),
                  ),
                  suffixIcon: val != null
                      ? Icon(Icons.check_circle_rounded,
                      color: appColor, size: 5.w)
                      : null,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w, vertical: 1.8.h),
                ),
                icon: val != null
                    ? const SizedBox.shrink()
                    : Icon(Icons.keyboard_arrow_down_rounded,
                    color: appColorBlack.withValues(alpha: 0.4)),
                items: c.items.map((v) => DropdownMenuItem(
                    value: v,
                    child: Text(v,
                        style: TextStyle(fontSize: 11.sp)))).toList(),
                onChanged: (v) => _set(c.key, v),
              )
                  .animate()
                  .fadeIn(
                duration: const Duration(milliseconds: 400),
                delay: Duration(milliseconds: 100 + i * 70),
              )
                  .slideY(begin: 0.06),
            );
          }),

          Gap(2.h),

          SubmitButton(
            "Enregistrer la formation",
            onPressed: () async {
              SnackbarHelper.showSuccess(
                  context, "Formation mise à jour !");
            },
          ).animate().fadeIn(duration: 600.ms),

          Gap(4.h),
        ],
      ),
    );
  }
}

class _DropConfig {
  final String key;
  final String label;
  final IconData icon;
  final List<String> items;
  const _DropConfig(
      {required this.key,
        required this.label,
        required this.icon,
        required this.items});
}