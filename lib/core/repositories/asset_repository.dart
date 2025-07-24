import 'dart:convert';
import 'package:flutter/services.dart' hide AssetMetadata;
import '../models/asset_metadata.dart';

abstract class AssetRepository {
  Future<List<AssetMetadata>> loadMetadata();
  Future<Map<String, List<AssetMetadata>>> groupAssetsByType();
}

class AssetRepositoryImpl implements AssetRepository {
  @override
  Future<List<AssetMetadata>> loadMetadata() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/metadata.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      return jsonList
          .map((json) => AssetMetadata.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load metadata: $e');
    }
  }

  @override
  Future<Map<String, List<AssetMetadata>>> groupAssetsByType() async {
    final assets = await loadMetadata();
    final Map<String, List<AssetMetadata>> groupedAssets = {};

    for (final asset in assets) {
      final groupName = asset.groupName;
      if (groupName.isNotEmpty) {
        groupedAssets[groupName] ??= [];
        groupedAssets[groupName]!.add(asset);
      }
    }

    return groupedAssets;
  }
} 