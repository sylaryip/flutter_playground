import 'mixin_state.dart';
import 'mixin_state2.dart';

class Test with MixinState, MixinState2 {
  void printState() {
    print(state.value);
  }
}
