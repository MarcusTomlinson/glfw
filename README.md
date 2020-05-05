```
./build-release.sh

cd release/myapp

flutter config --enable-linux-desktop
flutter pub get

FLUTTER_ENGINE_OUT_DIR=/path/to/engine/src/out/host_release_unopt

$FLUTTER_ENGINE_OUT_DIR/dart \
  $FLUTTER_ENGINE_OUT_DIR/frontend_server.dart.snapshot \
  --sdk-root $FLUTTER_ENGINE_OUT_DIR/flutter_patched_sdk/ \
  --target=flutter \
  --aot \
  --tfa \
  -Ddart.vm.product=true \
  --packages .packages \
  --output-dill build/kernel_snapshot.dill \
  package:myapp/main.dart

$FLUTTER_ENGINE_OUT_DIR/gen_snapshot \
  --causal_async_stacks \
  --deterministic \
  --snapshot_kind=app-aot-elf \
  --elf=build/app.so \
  build/kernel_snapshot.dill

cd ..

./flutter_glfw myapp /path/to/engine/src/third_party/icu/common/icudtl.dat
```
