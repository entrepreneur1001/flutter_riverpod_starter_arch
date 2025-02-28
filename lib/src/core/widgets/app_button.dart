import 'package:flutter/material.dart';
import 'package:starter_riverpod/src/core/core.dart';

class AppButton extends StatefulWidget {
  const AppButton(
    this.title, {
    super.key,
    this.onTap,
    this.titleColor,
    this.padding,
    this.isLoading = false,
    this.hasError = false,
    this.backgroundColor,
    this.verticalPadding,
  }) : _fontSize = 16;

  const AppButton.xSmallLabel(
    this.title, {
    super.key,
    this.onTap,
    this.titleColor,
    this.padding,
    this.isLoading = false,
    this.hasError = false,
    this.backgroundColor,
    this.verticalPadding,
  }) : _fontSize = 12;

  final VoidCallback? onTap;
  final String? title;
  final Color? titleColor;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final bool hasError;
  final Color? backgroundColor;
  final double? verticalPadding;
  final double _fontSize;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Color?> _animation;
  bool _loading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    _initAnimation();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AppButton oldWidget) {
    if (widget.isLoading != oldWidget.isLoading) {
      setState(() {
        _loading = widget.isLoading;
        _hasError = false;
      });
    }
    if (widget.hasError != oldWidget.hasError && widget.hasError) {
      _handleAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: _loading
            ? () {}
            : widget.onTap == null
                ? null
                : () {
                    FocusManager.instance.primaryFocus
                        ?.unfocus(); // Hide keyboard
                    widget.onTap?.call();
                  },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey.shade400;
              }
              if (states.contains(MaterialState.pressed)) {
                return (widget.backgroundColor ?? AppColors.primaryColor)
                    .withOpacity(0.8);
              }
              return _animation.value ??
                  widget.backgroundColor ??
                  AppColors.primaryColor;
            },
          ),
        ),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: _loading || _hasError
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding ?? 12.0,
              ),
              child: Text(
                widget.title!,
                style: TextStyle(
                  color: widget.titleColor ?? Colors.white,
                  fontSize: widget._fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          secondChild: Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding ?? 12.0,
            ),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          secondCurve: Curves.ease,
        ),
      ),
    );
  }

  void _initAnimation() {
    _animation = ColorTween(
      begin: widget.backgroundColor ?? AppColors.primaryColor,
      end: Colors.redAccent,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void _handleAnimation() {
    _controller.forward();
    setState(() {
      _hasError = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      _controller.reverse();
      setState(() {
        _loading = false;
        _hasError = false;
      });
    });
  }
}
