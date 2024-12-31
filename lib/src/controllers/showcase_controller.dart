import "export_controllers.dart";

class ShowcaseController extends ChangeNotifier {
  final List<ShowcaseItem> _items = [];
  bool _isPlaying = false;
  int _currentIndex = 0;
  Offset _currentOffset = Offset.zero;
  bool _showTooltip = false;
  
  List<ShowcaseItem> get items => _items;
  bool get isPlaying => _isPlaying;
  Offset get currentOffset => _currentOffset;
  bool get showTooltip => _showTooltip;
ToolTip get currentTooltip {
  if (_currentIndex < _items.length && _items[_currentIndex].tooltip != null) {
    return _items[_currentIndex].tooltip!;
  } else {
    return ToolTip(toolTipMessage: 'No tooltip available');
  }
}


  void addItem(ShowcaseItem item) {
    _items.add(item);
    notifyListeners();
  }
  
  void setItems(List<ShowcaseItem> items) {
    _items
      ..clear()
      ..addAll(items);
    notifyListeners();
  }
  
  void updateOffset(Offset offset) {
    _currentOffset = offset;
    notifyListeners();
  }
  
  void setShowTooltip(bool show) {
    _showTooltip = show;
    notifyListeners();
  }
  
  void next() {
    if (_currentIndex < _items.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }
  
  void reset() {
    _currentIndex = 0;
    _showTooltip = false;
    _currentOffset = Offset.zero;
    notifyListeners();
  }
}
