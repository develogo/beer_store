import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool reverse;
  final bool loading;

  const AppButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.reverse = false,
    this.loading = false,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late Animation<double> _animation = Tween<double>(
    begin: 6,
    end: 24,
  ).chain(CurveTween(curve: Curves.elasticInOut)).animate(_controller);
  late Animation<double> _animation2 = Tween<double>(
    begin: 24,
    end: 6,
  ).chain(CurveTween(curve: Curves.elasticInOut)).animate(_controller);

  @override
  void initState() {
    super.initState();

    if (widget.loading) {
      // Cria um novo AnimationController com duração de 2 segundos
      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..repeat(reverse: true);

      // Define um Tween que interpola entre os valores 4 e 24
      final tween = Tween<double>(
        begin: 4,
        end: 24,
      ).chain(CurveTween(curve: Curves.elasticInOut));

      final tween2 = Tween<double>(
        begin: 24,
        end: 4,
      ).chain(CurveTween(curve: Curves.elasticInOut));

      // Cria uma animação que usa o Tween acima e o AnimationController
      _animation = tween.animate(_controller);
      _animation2 = tween2.animate(_controller);
    }
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.loading ? _controller : const AlwaysStoppedAnimation(0),
      builder: (context, child) {
        return TextButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: widget.reverse
                      ? Radius.circular(_animation.value)
                      : Radius.circular(_animation2.value),
                  bottomLeft: widget.reverse
                      ? Radius.circular(_animation.value)
                      : Radius.circular(_animation2.value),
                  topLeft: widget.reverse
                      ? Radius.circular(_animation2.value)
                      : Radius.circular(_animation.value),
                  bottomRight: widget.reverse
                      ? Radius.circular(_animation2.value)
                      : Radius.circular(_animation.value),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            ),
            child: widget.loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                : widget.child);
      },
    );
  }
}
