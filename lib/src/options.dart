import 'dart:ui';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'map_view_settings.dart';

var DEFAULT_LOCATION = LatLng(55.7504461, 37.6174943);

/// Allows you to provide your map's starting properties for [initialZoom], [rotation]
/// and [center]. Alternatively you can provide [cameraConstraint] instead of [center].
/// If both, [center] and [cameraConstraint] are provided, bounds will take preference
/// over [center].
/// Zoom, pan boundary and interactivity constraints can be specified here too.
///
/// Callbacks for [onTap], [onLongPress] and [onPositionChanged] can be
/// registered here.
///
/// Through [crs] the Coordinate Reference System can be
/// defined, it defaults to [Epsg3857].
///
/// Checks if a coordinate is outside of the map's
/// defined boundaries.
///
/// If you download offline tiles dynamically, you can set [adaptiveBoundaries]
/// to true (make sure to pass [screenSize] and an external [controller]), which
/// will enforce panning/zooming to ensure there is never a need to display
/// tiles outside the boundaries set by [swPanBoundary] and [nePanBoundary].
class OpenMapOptions {
  final Crs? crs;
  final double? initialZoom;
  final double? rotation;

  /// Prints multi finger gesture winner Helps to fine adjust
  /// [rotationThreshold] and [pinchZoomThreshold] and [pinchMoveThreshold]
  /// Note: only takes effect if [enableMultiFingerGestureRace] is true
  final bool? debugMultiFingerGestureWinner;

  /// If true then [rotationThreshold] and [pinchZoomThreshold] and
  /// [pinchMoveThreshold] will race If multiple gestures win at the same time
  /// then precedence: [pinchZoomWinGestures] > [rotationWinGestures] >
  /// [pinchMoveWinGestures]
  final bool? enableMultiFingerGestureRace;

  /// Rotation threshold in degree default is 20.0 Map starts to rotate when
  /// [rotationThreshold] has been achieved or another multi finger gesture wins
  /// which allows [MultiFingerGesture.rotate] Note: if [interactiveFlags]
  /// doesn't contain [InteractiveFlag.rotate] or [enableMultiFingerGestureRace]
  /// is false then rotate cannot win
  final double? rotationThreshold;

  /// When [rotationThreshold] wins over [pinchZoomThreshold] and
  /// [pinchMoveThreshold] then [rotationWinGestures] gestures will be used. By
  /// default only [MultiFingerGesture.rotate] gesture will take effect see
  /// [MultiFingerGesture] for custom settings
  final int? rotationWinGestures;

  /// Pinch Zoom threshold default is 0.5 Map starts to zoom when
  /// [pinchZoomThreshold] has been achieved or another multi finger gesture
  /// wins which allows [MultiFingerGesture.pinchZoom] Note: if
  /// [interactiveFlags] doesn't contain [InteractiveFlag.pinchZoom] or
  /// [enableMultiFingerGestureRace] is false then zoom cannot win
  final double? pinchZoomThreshold;

  /// When [pinchZoomThreshold] wins over [rotationThreshold] and
  /// [pinchMoveThreshold] then [pinchZoomWinGestures] gestures will be used. By
  /// default [MultiFingerGesture.pinchZoom] and [MultiFingerGesture.pinchMove]
  /// gestures will take effect see [MultiFingerGesture] for custom settings
  final int? pinchZoomWinGestures;

  /// Pinch Move threshold default is 40.0 (note: this doesn't take any effect
  /// on drag) Map starts to move when [pinchMoveThreshold] has been achieved or
  /// another multi finger gesture wins which allows
  /// [MultiFingerGesture.pinchMove] Note: if [interactiveFlags] doesn't contain
  /// [InteractiveFlag.pinchMove] or [enableMultiFingerGestureRace] is false
  /// then pinch move cannot win
  final double? pinchMoveThreshold;

  /// When [pinchMoveThreshold] wins over [rotationThreshold] and
  /// [pinchZoomThreshold] then [pinchMoveWinGestures] gestures will be used. By
  /// default [MultiFingerGesture.pinchMove] and [MultiFingerGesture.pinchZoom]
  /// gestures will take effect see [MultiFingerGesture] for custom settings
  final int? pinchMoveWinGestures;

  /// If true then the map will scroll when the user uses the scroll wheel on
  /// his mouse. This is supported on web and desktop, but might also work well
  /// on Android. A [Listener] is used to capture the onPointerSignal events.
  final bool? enableScrollWheel;

  final double? minZoom;
  final double? maxZoom;

  /// see [InteractiveFlag] for custom settings
  final int? interactiveFlags;

  final LatLngBounds? maxBounds;
  final bool? keepAlive;

  final LongPressCallback? onLongPress;
  final PositionCallback? onPositionChanged;
  final bool? slideOnBoundaries;
  final Size? screenSize;
  final bool? adaptiveBoundaries;
  final LatLng? _initialCenter;
  final InteractionOptions? interactionOptions;
  final CameraConstraint? _cameraConstraint;
  final LatLng? swPanBoundary;
  final LatLng? nePanBoundary;
  final CameraConstraint? cameraConstraint;

  LatLng? get center => _initialCenter;
  OpenMapOptions({
    this.interactionOptions,
    this.crs,
    this.initialZoom,
    this.rotation,
    this.cameraConstraint,
    this.debugMultiFingerGestureWinner,
    this.enableMultiFingerGestureRace,
    this.rotationThreshold,
    this.rotationWinGestures,
    this.pinchZoomThreshold,
    this.pinchZoomWinGestures,
    this.pinchMoveThreshold,
    this.pinchMoveWinGestures,
    this.enableScrollWheel,
    this.minZoom,
    this.maxZoom,
    this.interactiveFlags,
    this.maxBounds,
    this.keepAlive,
    this.onLongPress,
    this.onPositionChanged,
    this.slideOnBoundaries,
    this.screenSize,
    this.adaptiveBoundaries,
    LatLng? center,
    this.swPanBoundary,
    this.nePanBoundary,
  })  : _cameraConstraint = null,
        _initialCenter = center;

  OpenMapOptions.cameraConstraint({
    this.crs,
    this.initialZoom,
    this.interactionOptions,
    this.rotation,
    this.debugMultiFingerGestureWinner,
    this.enableMultiFingerGestureRace,
    this.rotationThreshold,
    this.rotationWinGestures,
    this.pinchZoomThreshold,
    this.pinchZoomWinGestures,
    this.pinchMoveThreshold,
    this.pinchMoveWinGestures,
    this.enableScrollWheel,
    this.minZoom,
    this.maxZoom,
    this.interactiveFlags,
    this.maxBounds,
    this.keepAlive,
    this.onLongPress,
    this.onPositionChanged,
    this.slideOnBoundaries,
    this.screenSize,
    this.adaptiveBoundaries,
    required this.cameraConstraint,
    this.swPanBoundary,
    this.nePanBoundary,
  })  : _initialCenter = null,
        _cameraConstraint = cameraConstraint;

  MapOptions create({
    required void Function()? onMapReady,
    required TapCallback onTap,
    OpenMapSettings? settings,
  }) {
    var def = settings?.defaultOptions?.create(
            onMapReady: onMapReady,
            onTap: onTap,
            settings: null) ??
        MapOptions(initialCenter: DEFAULT_LOCATION);
    return MapOptions(
      keepAlive:
          keepAlive ?? def.keepAlive,
      crs: crs ?? def.crs,
      initialCenter: _initialCenter ?? def.initialCenter,
      interactionOptions: interactionOptions ?? def.interactionOptions,
      cameraConstraint: _cameraConstraint ?? def.cameraConstraint,
      initialZoom: initialZoom ?? def.initialZoom,
      initialRotation: rotation ?? def.initialRotation,
      minZoom: minZoom ?? def.minZoom,
      maxZoom: maxZoom ?? def.maxZoom,
      onLongPress: onLongPress ?? def.onLongPress,
      onMapReady: onMapReady,
      onTap: onTap,
      onPositionChanged: onPositionChanged ?? def.onPositionChanged,
    );
  }

  OpenMapOptions copyWith({
    Crs? crs,
    double? zoom,
    double? rotation,
    CameraConstraint? cameraConstraint,
    bool? debugMultiFingerGestureWinner,
    bool? enableMultiFingerGestureRace,
    double? rotationThreshold,
    int? rotationWinGestures,
    double? pinchZoomThreshold,
    int? pinchZoomWinGestures,
    double? pinchMoveThreshold,
    int? pinchMoveWinGestures,
    bool? enableScrollWheel,
    double? minZoom,
    double? maxZoom,
    int? interactiveFlags,
    LatLngBounds? maxBounds,
    bool? keepAlive,
    LongPressCallback? onLongPress,
    PositionCallback? onPositionChanged,
    bool? slideOnBoundaries,
    Size? screenSize,
    bool? adaptiveBoundaries,
    LatLng? swPanBoundary,
    LatLng? nePanBoundary,
  }) {
    if (_cameraConstraint != null) {
      return OpenMapOptions(
        crs: crs ?? this.crs,
        initialZoom: zoom ?? this.initialZoom,
        rotation: rotation ?? this.rotation,
        debugMultiFingerGestureWinner:
            debugMultiFingerGestureWinner ?? this.debugMultiFingerGestureWinner,
        enableMultiFingerGestureRace:
            enableMultiFingerGestureRace ?? this.enableMultiFingerGestureRace,
        rotationThreshold: rotationThreshold ?? this.rotationThreshold,
        rotationWinGestures: rotationWinGestures ?? this.rotationWinGestures,
        pinchZoomThreshold: pinchZoomThreshold ?? this.pinchZoomThreshold,
        pinchZoomWinGestures: pinchZoomWinGestures ?? this.pinchZoomWinGestures,
        pinchMoveThreshold: pinchMoveThreshold ?? this.pinchMoveThreshold,
        pinchMoveWinGestures: pinchMoveWinGestures ?? this.pinchMoveWinGestures,
        enableScrollWheel: enableScrollWheel ?? this.enableScrollWheel,
        minZoom: minZoom ?? this.minZoom,
        maxZoom: maxZoom ?? this.maxZoom,
        interactiveFlags: interactiveFlags ?? this.interactiveFlags,
        maxBounds: maxBounds ?? this.maxBounds,
        keepAlive:
            keepAlive ?? this.keepAlive,
        onLongPress: onLongPress ?? this.onLongPress,
        onPositionChanged: onPositionChanged ?? this.onPositionChanged,
        slideOnBoundaries: slideOnBoundaries ?? this.slideOnBoundaries,
        screenSize: screenSize ?? this.screenSize,
        adaptiveBoundaries: adaptiveBoundaries ?? this.adaptiveBoundaries,
        cameraConstraint: _cameraConstraint!,
        swPanBoundary: swPanBoundary ?? this.swPanBoundary,
        nePanBoundary: nePanBoundary ?? this.nePanBoundary,
      );
    }
    return OpenMapOptions(
      crs: crs ?? this.crs,
      initialZoom: zoom ?? this.initialZoom,
      rotation: rotation ?? this.rotation,
      debugMultiFingerGestureWinner:
          debugMultiFingerGestureWinner ?? this.debugMultiFingerGestureWinner,
      enableMultiFingerGestureRace:
          enableMultiFingerGestureRace ?? this.enableMultiFingerGestureRace,
      rotationThreshold: rotationThreshold ?? this.rotationThreshold,
      rotationWinGestures: rotationWinGestures ?? this.rotationWinGestures,
      pinchZoomThreshold: pinchZoomThreshold ?? this.pinchZoomThreshold,
      pinchZoomWinGestures: pinchZoomWinGestures ?? this.pinchZoomWinGestures,
      pinchMoveThreshold: pinchMoveThreshold ?? this.pinchMoveThreshold,
      pinchMoveWinGestures: pinchMoveWinGestures ?? this.pinchMoveWinGestures,
      enableScrollWheel: enableScrollWheel ?? this.enableScrollWheel,
      minZoom: minZoom ?? this.minZoom,
      maxZoom: maxZoom ?? this.maxZoom,
      interactiveFlags: interactiveFlags ?? this.interactiveFlags,
      maxBounds: maxBounds ?? this.maxBounds,
      keepAlive:
          keepAlive ?? this.keepAlive,
      onLongPress: onLongPress ?? this.onLongPress,
      onPositionChanged: onPositionChanged ?? this.onPositionChanged,
      slideOnBoundaries: slideOnBoundaries ?? this.slideOnBoundaries,
      screenSize: screenSize ?? this.screenSize,
      adaptiveBoundaries: adaptiveBoundaries ?? this.adaptiveBoundaries,
      center: _initialCenter,
      swPanBoundary: swPanBoundary ?? this.swPanBoundary,
      nePanBoundary: nePanBoundary ?? this.nePanBoundary,
    );
  }

  OpenMapOptions copyWithBounds({
    required CameraConstraint cameraConstraint,
    Crs? crs,
    double? zoom,
    double? rotation,
    bool? debugMultiFingerGestureWinner,
    bool? enableMultiFingerGestureRace,
    double? rotationThreshold,
    int? rotationWinGestures,
    double? pinchZoomThreshold,
    int? pinchZoomWinGestures,
    double? pinchMoveThreshold,
    int? pinchMoveWinGestures,
    bool? enableScrollWheel,
    double? minZoom,
    double? maxZoom,
    int? interactiveFlags,
    LatLngBounds? maxBounds,
    bool? keepAlive,
    LongPressCallback? onLongPress,
    PositionCallback? onPositionChanged,
    bool? slideOnBoundaries,
    Size? screenSize,
    bool? adaptiveBoundaries,
    LatLng? swPanBoundary,
    LatLng? nePanBoundary,
  }) {
    return OpenMapOptions(
      crs: crs ?? this.crs,
      initialZoom: zoom ?? this.initialZoom,
      rotation: rotation ?? this.rotation,
      debugMultiFingerGestureWinner:
          debugMultiFingerGestureWinner ?? this.debugMultiFingerGestureWinner,
      enableMultiFingerGestureRace:
          enableMultiFingerGestureRace ?? this.enableMultiFingerGestureRace,
      rotationThreshold: rotationThreshold ?? this.rotationThreshold,
      rotationWinGestures: rotationWinGestures ?? this.rotationWinGestures,
      pinchZoomThreshold: pinchZoomThreshold ?? this.pinchZoomThreshold,
      pinchZoomWinGestures: pinchZoomWinGestures ?? this.pinchZoomWinGestures,
      pinchMoveThreshold: pinchMoveThreshold ?? this.pinchMoveThreshold,
      pinchMoveWinGestures: pinchMoveWinGestures ?? this.pinchMoveWinGestures,
      enableScrollWheel: enableScrollWheel ?? this.enableScrollWheel,
      minZoom: minZoom ?? this.minZoom,
      maxZoom: maxZoom ?? this.maxZoom,
      interactiveFlags: interactiveFlags ?? this.interactiveFlags,
      maxBounds: maxBounds ?? this.maxBounds,
      keepAlive:
          keepAlive ?? this.keepAlive,
      onLongPress: onLongPress ?? this.onLongPress,
      onPositionChanged: onPositionChanged ?? this.onPositionChanged,
      slideOnBoundaries: slideOnBoundaries ?? this.slideOnBoundaries,
      screenSize: screenSize ?? this.screenSize,
      adaptiveBoundaries: adaptiveBoundaries ?? this.adaptiveBoundaries,
      cameraConstraint: cameraConstraint,
      swPanBoundary: swPanBoundary ?? this.swPanBoundary,
      nePanBoundary: nePanBoundary ?? this.nePanBoundary,
    );
  }
}
