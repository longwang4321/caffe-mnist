e:
cd E:\Python\Caffe\Build\x64\Release
caffe.exe train --solver=../../../examples/mnist/lenet_solver.prototxt >>../../../examples/mnist/caffe_train.log 2>&1
caffe.exe test --model=../../../examples/mnist/lenet_train_test.prototxt --weights=../../../examples/mnist/lenet_iter_5000.caffemodel >>../../../examples/mnist/caffe_test.log 2>&1
pause