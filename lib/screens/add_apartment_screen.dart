import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staybay/models/apartment_model.dart';
import 'package:staybay/widgets/app_bottom_nav_bar.dart';
import '../services/apartment_service.dart';

class AddApartmentScreen extends StatefulWidget {
  static const String routeName = '/add';
  const AddApartmentScreen({super.key});

  @override
  State<AddApartmentScreen> createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _location = TextEditingController();
  final _price = TextEditingController();
  final _beds = TextEditingController();
  final _baths = TextEditingController();
  final _area = TextEditingController();
  final _desc = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImages = [];

  //nabil

  // for web preview caching 
  final Map<String, Uint8List> _webImageBytes = {};

  @override
  void dispose() {
    for (final c in [_title, _location, _price, _beds, _baths, _area, _desc]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(
        imageQuality: 85,
      );
      if (images == null || images.isEmpty) return;
      if (kIsWeb) {
        // preload bytes for smoother web preview
        for (final f in images) {
          final bytes = await f.readAsBytes();
          _webImageBytes[f.name] = bytes;
        }
      }
      setState(() => _pickedImages = [..._pickedImages, ...images]);
    } catch (e) {
      // fallback: single image (older platforms) or error
      final XFile? single = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (single != null) {
        if (kIsWeb) _webImageBytes[single.name] = await single.readAsBytes();
        setState(() => _pickedImages.add(single));
      }
    }
  }

  void _removeImageAt(int idx) {
    final removed = _pickedImages.removeAt(idx);
    if (kIsWeb) _webImageBytes.remove(removed.name);
    setState(() {});
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    double _parseDouble(String s) =>
        double.tryParse(s.replaceAll(',', '.')) ?? 0.0;
    int _parseInt(String s) => int.tryParse(s) ?? 0;



    // nabil

    // NOTE: you should upload images (to cloud/storage) and save URLs.
    final imagesPaths = kIsWeb
        ? _pickedImages.map((x) => x.name).toList()
        : _pickedImages.map((x) => x.path).toList();

    final apt = Apartment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _title.text.trim(),
      location: _location.text.trim(),
      pricePerNight: _parseDouble(_price.text),
      imagePath: imagesPaths.isNotEmpty
          ? imagesPaths.first
          : '', // first image as thumbnail
      rating: 0.0,
      reviewsCount: 0,
      beds: _parseInt(_beds.text),
      baths: _parseInt(_baths.text),
      areaSqft: _parseDouble(_area.text),
      ownerName: '', // set if you have current user
      amenities: <String>[],
      description: _desc.text.trim(),
      imagesPaths: imagesPaths,
    );

    ApartmentService.mockApartments.add(apt);

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppBottomNavBar.routeName, (route) => false);
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  Widget _field(
    TextEditingController c,
    String label,
    IconData icon, {
    TextInputType k = TextInputType.text,
    int maxLines = 1,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: c,
      keyboardType: k,
      maxLines: maxLines,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
      decoration: _dec(label, icon),
    ),
  );

  Widget _imagesPreview() {
    if (_pickedImages.isEmpty) {
      return GestureDetector(
        onTap: _pickImages,
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.grey.shade50,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.photo_library_outlined, size: 28),
                SizedBox(height: 6),
                Text('Add images'),
              ],
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _pickedImages.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          if (i == _pickedImages.length) {
            // add button at end
            return InkWell(
              onTap: _pickImages,
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Center(child: Icon(Icons.add_a_photo)),
              ),
            );
          }
          final file = _pickedImages[i];
          return Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
                clipBehavior: Clip.hardEdge,
                child: kIsWeb
                    ? (_webImageBytes[file.name] != null
                          ? Image.memory(
                              _webImageBytes[file.name]!,
                              fit: BoxFit.cover,
                            )
                          : FutureBuilder<Uint8List>(
                              future: file.readAsBytes(),
                              builder: (context, snap) {
                                if (snap.connectionState !=
                                    ConnectionState.done) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                _webImageBytes[file.name] = snap.data!;
                                return Image.memory(
                                  snap.data!,
                                  fit: BoxFit.cover,
                                );
                              },
                            ))
                    : Image.file(File(file.path), fit: BoxFit.cover),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: InkWell(
                  onTap: () => _removeImageAt(i),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Apartment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create a New Listing',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Fill the details below to add your apartment',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // images picker & preview
              _imagesPreview(),
              const SizedBox(height: 12),

              _field(_title, 'Apartment Title', Icons.home),
              _field(_location, 'Location', Icons.location_on),
              _field(
                _price,
                'Price per Night',
                Icons.attach_money,
                k: const TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      _beds,
                      'Beds',
                      Icons.bed,
                      k: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _field(
                      _baths,
                      'Baths',
                      Icons.bathtub,
                      k: TextInputType.number,
                    ),
                  ),
                ],
              ),
              _field(
                _area,
                'Area (sqft)',
                Icons.square_foot,
                k: const TextInputType.numberWithOptions(decimal: true),
              ),
              _field(_desc, 'Description', Icons.description, maxLines: 4),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Apartment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
