# Instructions

1. **Fork this repository** to your own GitHub account
2. **Clone YOUR fork** (not this original repo)
3. Create a branch: `git checkout -b fix-bug-1`
4. Fix the bugs in your code
5. Commit and push to YOUR fork
6. **Create a Pull Request within YOUR fork** (from your feature branch to your fork's main)
7. Merge it in your fork

**⚠️ Do NOT create pull requests back to this original repository!**

<!-- This is a personal exercise. Each person should maintain their own fixed version.
setState() called in constructor: ShoppingCartState#d6605(lifecycle state: created, no widget, not mounted)
This happens when you call setState() on a State object for a widget that hasn't been inserted into the widget tree yet. It is not necessary to call setState() in the constructor, since the state is already assumed to be dirty when it is initially created.
package:flutter/src/widgets/framework.dart 1187:9            State.setState.<fn>
package:flutter/src/widgets/framework.dart 1198:6            State.setState
package:flutter_testing_lab/widgets/shopping_cart.dart 30:5  ShoppingCartState.addItem
test\cart_unit_test.dart 20:12                               main.<fn>.<fn> -->