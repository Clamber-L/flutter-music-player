import 'package:flutter/material.dart';
import 'package:flutter_music_player/common/widgets/button.dart';

enum Status {
  LOADING, // 加载中
  LOADED, // 加载完成后的一个状态
  EMPTY, // 加载成功，但是没有数据
  TIMEOUT, // 网络请求超时
  FAILED, // 加载失败
  NETWORK_ERROR, // 网络异常
}

class StatusView extends StatefulWidget {
  final Status status;
  final VoidCallback? retry;
  final WidgetBuilder? builder;
  final StatusViewController? controller;

  StatusView({
    this.status = Status.LOADING,
    this.retry,
    this.builder,
    this.controller,
  }) : super(key: controller?._key);

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  late Status _status;

  @override
  void initState() {
    super.initState();
    _status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return switch (_status) {
      Status.LOADING => _loadingView(),
      Status.EMPTY => _emptyView(),
      Status.FAILED => _failedView(),
      Status.TIMEOUT => _timeoutView(),
      Status.NETWORK_ERROR => _networkErrorView(),
      Status.LOADED => widget.builder?.call(context) ?? const SizedBox.shrink(),
    };
  }

  void _changeStatus(Status status) {
    if (_status != status) {
      setState(() => _status = status);
    }
  }

  Widget _baseView(List<Widget> items) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _loadingView() {
    return _baseView(<Widget>[
      const SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(color: Colors.red),
      ),
      const SizedBox(height: 10),
      const Text("加载中，请稍后", style: TextStyle(color: Colors.grey)),
    ]);
  }

  Widget _timeoutView() {
    return _baseView([
      const Icon(Icons.timelapse_outlined, size: 48, color: Colors.grey),
      const Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Text("请求超时，请重新加载试一试", style: TextStyle(color: Colors.grey)),
      ),
      _retryButton(),
    ]);
  }

  /// NETWOR_ERROR 对应的网络异常视图
  Widget _networkErrorView() {
    return _baseView([
      const Icon(Icons.network_check, size: 48, color: Colors.grey),
      const Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Text("网络异常，请确保您的网络正常", style: TextStyle(color: Colors.grey)),
      ),
      _retryButton(),
    ]);
  }

  /// EMPTY 对应的空视图
  Widget _emptyView() {
    return _baseView([
      const Icon(Icons.hourglass_empty, size: 48, color: Colors.grey),
      const Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Text("暂无更多数据，请重新加载试一试", style: TextStyle(color: Colors.grey)),
      ),
      _retryButton(),
    ]);
  }

  /// FAILED 对应的加载失败视图
  Widget _failedView() {
    return _baseView([
      const Icon(Icons.data_exploration, size: 48, color: Colors.grey),
      const Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Text("加载失败，请重新加载试一试", style: TextStyle(color: Colors.grey)),
      ),
      _retryButton(),
    ]);
  }

  /// 重试按钮，通过这个按钮我们可以将其点击事件绑定到外部的重试回调函数上
  Widget _retryButton() {
    return Button(
      text: "重新加载",
      icon: const Icon(Icons.refresh, size: 16),
      onTap: widget.retry, // 绑定重试回调函数
    );
  }
}

class StatusViewController {
  // 通过_globalKey 就可以调用_StatusViewState中的方法
  final GlobalKey<_StatusViewState> _key = GlobalKey();

  bool get isReady => _key.currentState != null && _key.currentState!.mounted;

  _StatusViewState? get _state => isReady ? _key.currentState : null;

  void showLoading() => _state?._changeStatus(Status.LOADING);
  void showFailed() => _state?._changeStatus(Status.FAILED);
  void showEmpty() => _state?._changeStatus(Status.EMPTY);
  void showNetworkError() => _state?._changeStatus(Status.NETWORK_ERROR);
  void showTimeout() => _state?._changeStatus(Status.TIMEOUT);
  void loaded() => _state?._changeStatus(Status.LOADED);
}
