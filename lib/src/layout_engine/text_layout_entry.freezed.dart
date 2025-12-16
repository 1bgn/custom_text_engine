// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_layout_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TextLayoutEntry {

 ui.Paragraph get paragraph; double get width; double get height; double get baseline; List<ui.Rect> get rects;
/// Create a copy of TextLayoutEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextLayoutEntryCopyWith<TextLayoutEntry> get copyWith => _$TextLayoutEntryCopyWithImpl<TextLayoutEntry>(this as TextLayoutEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextLayoutEntry&&(identical(other.paragraph, paragraph) || other.paragraph == paragraph)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&const DeepCollectionEquality().equals(other.rects, rects));
}


@override
int get hashCode => Object.hash(runtimeType,paragraph,width,height,baseline,const DeepCollectionEquality().hash(rects));

@override
String toString() {
  return 'TextLayoutEntry(paragraph: $paragraph, width: $width, height: $height, baseline: $baseline, rects: $rects)';
}


}

/// @nodoc
abstract mixin class $TextLayoutEntryCopyWith<$Res>  {
  factory $TextLayoutEntryCopyWith(TextLayoutEntry value, $Res Function(TextLayoutEntry) _then) = _$TextLayoutEntryCopyWithImpl;
@useResult
$Res call({
 ui.Paragraph paragraph, double width, double height, double baseline, List<ui.Rect> rects
});




}
/// @nodoc
class _$TextLayoutEntryCopyWithImpl<$Res>
    implements $TextLayoutEntryCopyWith<$Res> {
  _$TextLayoutEntryCopyWithImpl(this._self, this._then);

  final TextLayoutEntry _self;
  final $Res Function(TextLayoutEntry) _then;

/// Create a copy of TextLayoutEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paragraph = null,Object? width = null,Object? height = null,Object? baseline = null,Object? rects = null,}) {
  return _then(_self.copyWith(
paragraph: null == paragraph ? _self.paragraph : paragraph // ignore: cast_nullable_to_non_nullable
as ui.Paragraph,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as double,rects: null == rects ? _self.rects : rects // ignore: cast_nullable_to_non_nullable
as List<ui.Rect>,
  ));
}

}


/// Adds pattern-matching-related methods to [TextLayoutEntry].
extension TextLayoutEntryPatterns on TextLayoutEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TextLayoutEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TextLayoutEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TextLayoutEntry value)  $default,){
final _that = this;
switch (_that) {
case _TextLayoutEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TextLayoutEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TextLayoutEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ui.Paragraph paragraph,  double width,  double height,  double baseline,  List<ui.Rect> rects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TextLayoutEntry() when $default != null:
return $default(_that.paragraph,_that.width,_that.height,_that.baseline,_that.rects);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ui.Paragraph paragraph,  double width,  double height,  double baseline,  List<ui.Rect> rects)  $default,) {final _that = this;
switch (_that) {
case _TextLayoutEntry():
return $default(_that.paragraph,_that.width,_that.height,_that.baseline,_that.rects);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ui.Paragraph paragraph,  double width,  double height,  double baseline,  List<ui.Rect> rects)?  $default,) {final _that = this;
switch (_that) {
case _TextLayoutEntry() when $default != null:
return $default(_that.paragraph,_that.width,_that.height,_that.baseline,_that.rects);case _:
  return null;

}
}

}

/// @nodoc


class _TextLayoutEntry implements TextLayoutEntry {
  const _TextLayoutEntry({required this.paragraph, required this.width, required this.height, required this.baseline, required final  List<ui.Rect> rects}): _rects = rects;
  

@override final  ui.Paragraph paragraph;
@override final  double width;
@override final  double height;
@override final  double baseline;
 final  List<ui.Rect> _rects;
@override List<ui.Rect> get rects {
  if (_rects is EqualUnmodifiableListView) return _rects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rects);
}


/// Create a copy of TextLayoutEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextLayoutEntryCopyWith<_TextLayoutEntry> get copyWith => __$TextLayoutEntryCopyWithImpl<_TextLayoutEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextLayoutEntry&&(identical(other.paragraph, paragraph) || other.paragraph == paragraph)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&const DeepCollectionEquality().equals(other._rects, _rects));
}


@override
int get hashCode => Object.hash(runtimeType,paragraph,width,height,baseline,const DeepCollectionEquality().hash(_rects));

@override
String toString() {
  return 'TextLayoutEntry(paragraph: $paragraph, width: $width, height: $height, baseline: $baseline, rects: $rects)';
}


}

/// @nodoc
abstract mixin class _$TextLayoutEntryCopyWith<$Res> implements $TextLayoutEntryCopyWith<$Res> {
  factory _$TextLayoutEntryCopyWith(_TextLayoutEntry value, $Res Function(_TextLayoutEntry) _then) = __$TextLayoutEntryCopyWithImpl;
@override @useResult
$Res call({
 ui.Paragraph paragraph, double width, double height, double baseline, List<ui.Rect> rects
});




}
/// @nodoc
class __$TextLayoutEntryCopyWithImpl<$Res>
    implements _$TextLayoutEntryCopyWith<$Res> {
  __$TextLayoutEntryCopyWithImpl(this._self, this._then);

  final _TextLayoutEntry _self;
  final $Res Function(_TextLayoutEntry) _then;

/// Create a copy of TextLayoutEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paragraph = null,Object? width = null,Object? height = null,Object? baseline = null,Object? rects = null,}) {
  return _then(_TextLayoutEntry(
paragraph: null == paragraph ? _self.paragraph : paragraph // ignore: cast_nullable_to_non_nullable
as ui.Paragraph,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as double,rects: null == rects ? _self._rects : rects // ignore: cast_nullable_to_non_nullable
as List<ui.Rect>,
  ));
}


}

// dart format on
