// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_text_layout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomTextLayout {

 List<LineLayout> get lines; double get totalHeight; List<int> get paragraphIndexOfLine;
/// Create a copy of CustomTextLayout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomTextLayoutCopyWith<CustomTextLayout> get copyWith => _$CustomTextLayoutCopyWithImpl<CustomTextLayout>(this as CustomTextLayout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomTextLayout&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.totalHeight, totalHeight) || other.totalHeight == totalHeight)&&const DeepCollectionEquality().equals(other.paragraphIndexOfLine, paragraphIndexOfLine));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(lines),totalHeight,const DeepCollectionEquality().hash(paragraphIndexOfLine));

@override
String toString() {
  return 'CustomTextLayout(lines: $lines, totalHeight: $totalHeight, paragraphIndexOfLine: $paragraphIndexOfLine)';
}


}

/// @nodoc
abstract mixin class $CustomTextLayoutCopyWith<$Res>  {
  factory $CustomTextLayoutCopyWith(CustomTextLayout value, $Res Function(CustomTextLayout) _then) = _$CustomTextLayoutCopyWithImpl;
@useResult
$Res call({
 List<LineLayout> lines, double totalHeight, List<int> paragraphIndexOfLine
});




}
/// @nodoc
class _$CustomTextLayoutCopyWithImpl<$Res>
    implements $CustomTextLayoutCopyWith<$Res> {
  _$CustomTextLayoutCopyWithImpl(this._self, this._then);

  final CustomTextLayout _self;
  final $Res Function(CustomTextLayout) _then;

/// Create a copy of CustomTextLayout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lines = null,Object? totalHeight = null,Object? paragraphIndexOfLine = null,}) {
  return _then(_self.copyWith(
lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<LineLayout>,totalHeight: null == totalHeight ? _self.totalHeight : totalHeight // ignore: cast_nullable_to_non_nullable
as double,paragraphIndexOfLine: null == paragraphIndexOfLine ? _self.paragraphIndexOfLine : paragraphIndexOfLine // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomTextLayout].
extension CustomTextLayoutPatterns on CustomTextLayout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomTextLayout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomTextLayout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomTextLayout value)  $default,){
final _that = this;
switch (_that) {
case _CustomTextLayout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomTextLayout value)?  $default,){
final _that = this;
switch (_that) {
case _CustomTextLayout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LineLayout> lines,  double totalHeight,  List<int> paragraphIndexOfLine)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomTextLayout() when $default != null:
return $default(_that.lines,_that.totalHeight,_that.paragraphIndexOfLine);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LineLayout> lines,  double totalHeight,  List<int> paragraphIndexOfLine)  $default,) {final _that = this;
switch (_that) {
case _CustomTextLayout():
return $default(_that.lines,_that.totalHeight,_that.paragraphIndexOfLine);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LineLayout> lines,  double totalHeight,  List<int> paragraphIndexOfLine)?  $default,) {final _that = this;
switch (_that) {
case _CustomTextLayout() when $default != null:
return $default(_that.lines,_that.totalHeight,_that.paragraphIndexOfLine);case _:
  return null;

}
}

}

/// @nodoc


class _CustomTextLayout implements CustomTextLayout {
  const _CustomTextLayout({required final  List<LineLayout> lines, required this.totalHeight, required final  List<int> paragraphIndexOfLine}): _lines = lines,_paragraphIndexOfLine = paragraphIndexOfLine;
  

 final  List<LineLayout> _lines;
@override List<LineLayout> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  double totalHeight;
 final  List<int> _paragraphIndexOfLine;
@override List<int> get paragraphIndexOfLine {
  if (_paragraphIndexOfLine is EqualUnmodifiableListView) return _paragraphIndexOfLine;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paragraphIndexOfLine);
}


/// Create a copy of CustomTextLayout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomTextLayoutCopyWith<_CustomTextLayout> get copyWith => __$CustomTextLayoutCopyWithImpl<_CustomTextLayout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomTextLayout&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.totalHeight, totalHeight) || other.totalHeight == totalHeight)&&const DeepCollectionEquality().equals(other._paragraphIndexOfLine, _paragraphIndexOfLine));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_lines),totalHeight,const DeepCollectionEquality().hash(_paragraphIndexOfLine));

@override
String toString() {
  return 'CustomTextLayout(lines: $lines, totalHeight: $totalHeight, paragraphIndexOfLine: $paragraphIndexOfLine)';
}


}

/// @nodoc
abstract mixin class _$CustomTextLayoutCopyWith<$Res> implements $CustomTextLayoutCopyWith<$Res> {
  factory _$CustomTextLayoutCopyWith(_CustomTextLayout value, $Res Function(_CustomTextLayout) _then) = __$CustomTextLayoutCopyWithImpl;
@override @useResult
$Res call({
 List<LineLayout> lines, double totalHeight, List<int> paragraphIndexOfLine
});




}
/// @nodoc
class __$CustomTextLayoutCopyWithImpl<$Res>
    implements _$CustomTextLayoutCopyWith<$Res> {
  __$CustomTextLayoutCopyWithImpl(this._self, this._then);

  final _CustomTextLayout _self;
  final $Res Function(_CustomTextLayout) _then;

/// Create a copy of CustomTextLayout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lines = null,Object? totalHeight = null,Object? paragraphIndexOfLine = null,}) {
  return _then(_CustomTextLayout(
lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<LineLayout>,totalHeight: null == totalHeight ? _self.totalHeight : totalHeight // ignore: cast_nullable_to_non_nullable
as double,paragraphIndexOfLine: null == paragraphIndexOfLine ? _self._paragraphIndexOfLine : paragraphIndexOfLine // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
