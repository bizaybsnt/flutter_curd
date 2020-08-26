import 'package:flutter/widgets.dart';

import 'base_bloc.dart';

// Type _getType<B>() => B;

class Provider<B extends BaseBloc> extends InheritedWidget {
  final B bloc;

  const Provider({
    Key key,
    this.bloc,
    Widget child,
  }) : super(key: key, child: child);
  @override
  bool updateShouldNotify(Provider<B> oldWidget) {
    return oldWidget.bloc != bloc;
  }

  static B of<B extends BaseBloc>(BuildContext context) {
    // final type = _getType<Provider<B>>();
    final Provider<B> provider = context.dependOnInheritedWidgetOfExactType();
    return provider.bloc;
  }
}

class BlocProvider<B extends BaseBloc> extends StatefulWidget {
  final B Function(BuildContext context, B bloc) builder;
  final Widget child;
  final closeBloc;

  const BlocProvider({Key key, this.builder, this.child, this.closeBloc = true})
      : super(key: key);
  @override
  _BlocProviderState<B> createState() => _BlocProviderState<B>();
}

class _BlocProviderState<B extends BaseBloc> extends State<BlocProvider<B>> {
  B bloc;

  @override
  void initState() {
    super.initState();
    if (widget.builder != null) {
      bloc = widget.builder(context, bloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      bloc: bloc,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (bloc != null && widget.closeBloc) bloc.onDispose();
    super.dispose();
  }
}
