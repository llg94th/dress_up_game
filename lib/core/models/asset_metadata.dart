class AssetMetadata {
  final String originalPath;
  final String flutterPath;
  final double x;
  final double y;
  final double width;
  final double height;

  const AssetMetadata({
    required this.originalPath,
    required this.flutterPath,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory AssetMetadata.fromJson(Map<String, dynamic> json) {
    return AssetMetadata(
      originalPath: json['original_path'] as String,
      flutterPath: json['flutter_path'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }

  String get groupName {
    final parts = flutterPath.split('/');
    
    // Handle base_body_png (no subfolder)
    if (parts.length == 1) {
      final fileName = parts[0];
      if (fileName.startsWith('base_body')) {
        return 'base_body';
      }
      // For other single files, use the filename as group
      return fileName;
    }
    
    // For files in subfolders, use the folder name
    return parts.isNotEmpty ? parts[0] : '';
  }

  String get itemName {
    final parts = flutterPath.split('/');
    
    // For single files (like base_body_png), use the filename
    if (parts.length == 1) {
      return parts[0];
    }
    
    // For files in subfolders, use the filename
    return parts.length > 1 ? parts[1] : '';
  }
} 