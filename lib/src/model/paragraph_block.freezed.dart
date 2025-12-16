// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paragraph_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParagraphBlock {

 List<InlineElement> get inlineElements; TextAlign? get textAlign; TextDirection get textDirection; double get firstLineIndent; double get paragraphSpacing; int get minimumLines; double? get maxWidth; bool get isSectionEnd; bool get breakable; bool get enableRedLine; TextAlign? get containerAlignment; double get paddingLeft; double get paddingRight; double get paddingTop; double get paddingBottom;
/// Create a copy of ParagraphBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParagraphBlockCopyWith<ParagraphBlock> get copyWith => _$ParagraphBlockCopyWithImpl<ParagraphBlock>(this as ParagraphBlock, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParagraphBlock&&const DeepCollectionEquality().equals(other.inlineElements, inlineElements)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.textDirection, textDirection) || other.textDirection == textDirection)&&(identical(other.firstLineIndent, firstLineIndent) || other.firstLineIndent == firstLineIndent)&&(identical(other.paragraphSpacing, paragraphSpacing) || other.paragraphSpacing == paragraphSpacing)&&(identical(other.minimumLines, minimumLines) || other.minimumLines == minimumLines)&&(identical(other.maxWidth, maxWidth) || other.maxWidth == maxWidth)&&(identical(other.isSectionEnd, isSectionEnd) || other.isSectionEnd == isSectionEnd)&&(identical(other.breakable, breakable) || other.breakable == breakable)&&(identical(other.enableRedLine, enableRedLine) || other.enableRedLine == enableRedLine)&&(identical(other.containerAlignment, containerAlignment) || other.containerAlignment == containerAlignment)&&(identical(other.paddingLeft, paddingLeft) || other.paddingLeft == paddingLeft)&&(identical(other.paddingRight, paddingRight) || other.paddingRight == paddingRight)&&(identical(other.paddingTop, paddingTop) || other.paddingTop == paddingTop)&&(identical(other.paddingBottom, paddingBottom) || other.paddingBottom == paddingBottom));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(inlineElements),textAlign,textDirection,firstLineIndent,paragraphSpacing,minimumLines,maxWidth,isSectionEnd,breakable,enableRedLine,containerAlignment,paddingLeft,paddingRight,paddingTop,paddingBottom);

@override
String toString() {
  return 'ParagraphBlock(inlineElements: $inlineElements, textAlign: $textAlign, textDirection: $textDirection, firstLineIndent: $firstLineIndent, paragraphSpacing: $paragraphSpacing, minimumLines: $minimumLines, maxWidth: $maxWidth, isSectionEnd: $isSectionEnd, breakable: $breakable, enableRedLine: $enableRedLine, containerAlignment: $containerAlignment, paddingLeft: $paddingLeft, paddingRight: $paddingRight, paddingTop: $paddingTop, paddingBottom: $paddingBottom)';
}


}

/// @nodoc
abstract mixin class $ParagraphBlockCopyWith<$Res>  {
  factory $ParagraphBlockCopyWith(ParagraphBlock value, $Res Function(ParagraphBlock) _then) = _$ParagraphBlockCopyWithImpl;
@useResult
$Res call({
 List<InlineElement> inlineElements, TextAlign? textAlign, TextDirection textDirection, double firstLineIndent, double paragraphSpacing, int minimumLines, double? maxWidth, bool isSectionEnd, bool breakable, bool enableRedLine, TextAlign? containerAlignment, double paddingLeft, double paddingRight, double paddingTop, double paddingBottom
});




}
/// @nodoc
class _$ParagraphBlockCopyWithImpl<$Res>
    implements $ParagraphBlockCopyWith<$Res> {
  _$ParagraphBlockCopyWithImpl(this._self, this._then);

  final ParagraphBlock _self;
  final $Res Function(ParagraphBlock) _then;

/// Create a copy of ParagraphBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inlineElements = null,Object? textAlign = freezed,Object? textDirection = null,Object? firstLineIndent = null,Object? paragraphSpacing = null,Object? minimumLines = null,Object? maxWidth = freezed,Object? isSectionEnd = null,Object? breakable = null,Object? enableRedLine = null,Object? containerAlignment = freezed,Object? paddingLeft = null,Object? paddingRight = null,Object? paddingTop = null,Object? paddingBottom = null,}) {
  return _then(_self.copyWith(
inlineElements: null == inlineElements ? _self.inlineElements : inlineElements // ignore: cast_nullable_to_non_nullable
as List<InlineElement>,textAlign: freezed == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as TextAlign?,textDirection: null == textDirection ? _self.textDirection : textDirection // ignore: cast_nullable_to_non_nullable
as TextDirection,firstLineIndent: null == firstLineIndent ? _self.firstLineIndent : firstLineIndent // ignore: cast_nullable_to_non_nullable
as double,paragraphSpacing: null == paragraphSpacing ? _self.paragraphSpacing : paragraphSpacing // ignore: cast_nullable_to_non_nullable
as double,minimumLines: null == minimumLines ? _self.minimumLines : minimumLines // ignore: cast_nullable_to_non_nullable
as int,maxWidth: freezed == maxWidth ? _self.maxWidth : maxWidth // ignore: cast_nullable_to_non_nullable
as double?,isSectionEnd: null == isSectionEnd ? _self.isSectionEnd : isSectionEnd // ignore: cast_nullable_to_non_nullable
as bool,breakable: null == breakable ? _self.breakable : breakable // ignore: cast_nullable_to_non_nullable
as bool,enableRedLine: null == enableRedLine ? _self.enableRedLine : enableRedLine // ignore: cast_nullable_to_non_nullable
as bool,containerAlignment: freezed == containerAlignment ? _self.containerAlignment : containerAlignment // ignore: cast_nullable_to_non_nullable
as TextAlign?,paddingLeft: null == paddingLeft ? _self.paddingLeft : paddingLeft // ignore: cast_nullable_to_non_nullable
as double,paddingRight: null == paddingRight ? _self.paddingRight : paddingRight // ignore: cast_nullable_to_non_nullable
as double,paddingTop: null == paddingTop ? _self.paddingTop : paddingTop // ignore: cast_nullable_to_non_nullable
as double,paddingBottom: null == paddingBottom ? _self.paddingBottom : paddingBottom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ParagraphBlock].
extension ParagraphBlockPatterns on ParagraphBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParagraphBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParagraphBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParagraphBlock value)  $default,){
final _that = this;
switch (_that) {
case _ParagraphBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParagraphBlock value)?  $default,){
final _that = this;
switch (_that) {
case _ParagraphBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<InlineElement> inlineElements,  TextAlign? textAlign,  TextDirection textDirection,  double firstLineIndent,  double paragraphSpacing,  int minimumLines,  double? maxWidth,  bool isSectionEnd,  bool breakable,  bool enableRedLine,  TextAlign? containerAlignment,  double paddingLeft,  double paddingRight,  double paddingTop,  double paddingBottom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParagraphBlock() when $default != null:
return $default(_that.inlineElements,_that.textAlign,_that.textDirection,_that.firstLineIndent,_that.paragraphSpacing,_that.minimumLines,_that.maxWidth,_that.isSectionEnd,_that.breakable,_that.enableRedLine,_that.containerAlignment,_that.paddingLeft,_that.paddingRight,_that.paddingTop,_that.paddingBottom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<InlineElement> inlineElements,  TextAlign? textAlign,  TextDirection textDirection,  double firstLineIndent,  double paragraphSpacing,  int minimumLines,  double? maxWidth,  bool isSectionEnd,  bool breakable,  bool enableRedLine,  TextAlign? containerAlignment,  double paddingLeft,  double paddingRight,  double paddingTop,  double paddingBottom)  $default,) {final _that = this;
switch (_that) {
case _ParagraphBlock():
return $default(_that.inlineElements,_that.textAlign,_that.textDirection,_that.firstLineIndent,_that.paragraphSpacing,_that.minimumLines,_that.maxWidth,_that.isSectionEnd,_that.breakable,_that.enableRedLine,_that.containerAlignment,_that.paddingLeft,_that.paddingRight,_that.paddingTop,_that.paddingBottom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<InlineElement> inlineElements,  TextAlign? textAlign,  TextDirection textDirection,  double firstLineIndent,  double paragraphSpacing,  int minimumLines,  double? maxWidth,  bool isSectionEnd,  bool breakable,  bool enableRedLine,  TextAlign? containerAlignment,  double paddingLeft,  double paddingRight,  double paddingTop,  double paddingBottom)?  $default,) {final _that = this;
switch (_that) {
case _ParagraphBlock() when $default != null:
return $default(_that.inlineElements,_that.textAlign,_that.textDirection,_that.firstLineIndent,_that.paragraphSpacing,_that.minimumLines,_that.maxWidth,_that.isSectionEnd,_that.breakable,_that.enableRedLine,_that.containerAlignment,_that.paddingLeft,_that.paddingRight,_that.paddingTop,_that.paddingBottom);case _:
  return null;

}
}

}

/// @nodoc


class _ParagraphBlock implements ParagraphBlock {
  const _ParagraphBlock({required final  List<InlineElement> inlineElements, this.textAlign, this.textDirection = TextDirection.ltr, this.firstLineIndent = 0.0, this.paragraphSpacing = 0.0, this.minimumLines = 1, this.maxWidth, this.isSectionEnd = false, this.breakable = false, this.enableRedLine = true, this.containerAlignment, this.paddingLeft = 0.0, this.paddingRight = 0.0, this.paddingTop = 0.0, this.paddingBottom = 0.0}): _inlineElements = inlineElements;
  

 final  List<InlineElement> _inlineElements;
@override List<InlineElement> get inlineElements {
  if (_inlineElements is EqualUnmodifiableListView) return _inlineElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inlineElements);
}

@override final  TextAlign? textAlign;
@override@JsonKey() final  TextDirection textDirection;
@override@JsonKey() final  double firstLineIndent;
@override@JsonKey() final  double paragraphSpacing;
@override@JsonKey() final  int minimumLines;
@override final  double? maxWidth;
@override@JsonKey() final  bool isSectionEnd;
@override@JsonKey() final  bool breakable;
@override@JsonKey() final  bool enableRedLine;
@override final  TextAlign? containerAlignment;
@override@JsonKey() final  double paddingLeft;
@override@JsonKey() final  double paddingRight;
@override@JsonKey() final  double paddingTop;
@override@JsonKey() final  double paddingBottom;

/// Create a copy of ParagraphBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParagraphBlockCopyWith<_ParagraphBlock> get copyWith => __$ParagraphBlockCopyWithImpl<_ParagraphBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParagraphBlock&&const DeepCollectionEquality().equals(other._inlineElements, _inlineElements)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.textDirection, textDirection) || other.textDirection == textDirection)&&(identical(other.firstLineIndent, firstLineIndent) || other.firstLineIndent == firstLineIndent)&&(identical(other.paragraphSpacing, paragraphSpacing) || other.paragraphSpacing == paragraphSpacing)&&(identical(other.minimumLines, minimumLines) || other.minimumLines == minimumLines)&&(identical(other.maxWidth, maxWidth) || other.maxWidth == maxWidth)&&(identical(other.isSectionEnd, isSectionEnd) || other.isSectionEnd == isSectionEnd)&&(identical(other.breakable, breakable) || other.breakable == breakable)&&(identical(other.enableRedLine, enableRedLine) || other.enableRedLine == enableRedLine)&&(identical(other.containerAlignment, containerAlignment) || other.containerAlignment == containerAlignment)&&(identical(other.paddingLeft, paddingLeft) || other.paddingLeft == paddingLeft)&&(identical(other.paddingRight, paddingRight) || other.paddingRight == paddingRight)&&(identical(other.paddingTop, paddingTop) || other.paddingTop == paddingTop)&&(identical(other.paddingBottom, paddingBottom) || other.paddingBottom == paddingBottom));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_inlineElements),textAlign,textDirection,firstLineIndent,paragraphSpacing,minimumLines,maxWidth,isSectionEnd,breakable,enableRedLine,containerAlignment,paddingLeft,paddingRight,paddingTop,paddingBottom);

@override
String toString() {
  return 'ParagraphBlock(inlineElements: $inlineElements, textAlign: $textAlign, textDirection: $textDirection, firstLineIndent: $firstLineIndent, paragraphSpacing: $paragraphSpacing, minimumLines: $minimumLines, maxWidth: $maxWidth, isSectionEnd: $isSectionEnd, breakable: $breakable, enableRedLine: $enableRedLine, containerAlignment: $containerAlignment, paddingLeft: $paddingLeft, paddingRight: $paddingRight, paddingTop: $paddingTop, paddingBottom: $paddingBottom)';
}


}

/// @nodoc
abstract mixin class _$ParagraphBlockCopyWith<$Res> implements $ParagraphBlockCopyWith<$Res> {
  factory _$ParagraphBlockCopyWith(_ParagraphBlock value, $Res Function(_ParagraphBlock) _then) = __$ParagraphBlockCopyWithImpl;
@override @useResult
$Res call({
 List<InlineElement> inlineElements, TextAlign? textAlign, TextDirection textDirection, double firstLineIndent, double paragraphSpacing, int minimumLines, double? maxWidth, bool isSectionEnd, bool breakable, bool enableRedLine, TextAlign? containerAlignment, double paddingLeft, double paddingRight, double paddingTop, double paddingBottom
});




}
/// @nodoc
class __$ParagraphBlockCopyWithImpl<$Res>
    implements _$ParagraphBlockCopyWith<$Res> {
  __$ParagraphBlockCopyWithImpl(this._self, this._then);

  final _ParagraphBlock _self;
  final $Res Function(_ParagraphBlock) _then;

/// Create a copy of ParagraphBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inlineElements = null,Object? textAlign = freezed,Object? textDirection = null,Object? firstLineIndent = null,Object? paragraphSpacing = null,Object? minimumLines = null,Object? maxWidth = freezed,Object? isSectionEnd = null,Object? breakable = null,Object? enableRedLine = null,Object? containerAlignment = freezed,Object? paddingLeft = null,Object? paddingRight = null,Object? paddingTop = null,Object? paddingBottom = null,}) {
  return _then(_ParagraphBlock(
inlineElements: null == inlineElements ? _self._inlineElements : inlineElements // ignore: cast_nullable_to_non_nullable
as List<InlineElement>,textAlign: freezed == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as TextAlign?,textDirection: null == textDirection ? _self.textDirection : textDirection // ignore: cast_nullable_to_non_nullable
as TextDirection,firstLineIndent: null == firstLineIndent ? _self.firstLineIndent : firstLineIndent // ignore: cast_nullable_to_non_nullable
as double,paragraphSpacing: null == paragraphSpacing ? _self.paragraphSpacing : paragraphSpacing // ignore: cast_nullable_to_non_nullable
as double,minimumLines: null == minimumLines ? _self.minimumLines : minimumLines // ignore: cast_nullable_to_non_nullable
as int,maxWidth: freezed == maxWidth ? _self.maxWidth : maxWidth // ignore: cast_nullable_to_non_nullable
as double?,isSectionEnd: null == isSectionEnd ? _self.isSectionEnd : isSectionEnd // ignore: cast_nullable_to_non_nullable
as bool,breakable: null == breakable ? _self.breakable : breakable // ignore: cast_nullable_to_non_nullable
as bool,enableRedLine: null == enableRedLine ? _self.enableRedLine : enableRedLine // ignore: cast_nullable_to_non_nullable
as bool,containerAlignment: freezed == containerAlignment ? _self.containerAlignment : containerAlignment // ignore: cast_nullable_to_non_nullable
as TextAlign?,paddingLeft: null == paddingLeft ? _self.paddingLeft : paddingLeft // ignore: cast_nullable_to_non_nullable
as double,paddingRight: null == paddingRight ? _self.paddingRight : paddingRight // ignore: cast_nullable_to_non_nullable
as double,paddingTop: null == paddingTop ? _self.paddingTop : paddingTop // ignore: cast_nullable_to_non_nullable
as double,paddingBottom: null == paddingBottom ? _self.paddingBottom : paddingBottom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
