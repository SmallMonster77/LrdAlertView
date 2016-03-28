# LrdAlertView
常见的几种APP弹框形式:<br>
演示如下图所示:<br>
![演示](http://lrdup888.qiniudn.com/%E5%B8%B8%E8%A7%81%E5%BC%B9%E7%AA%97%E6%95%88%E6%9E%9C.gif)

## 使用方法
clone下来的工程里面包含三个文件夹，对应着三种view，使用时需要导入masonry第三方库。<br>
block是当密码输入完成后调用的，text则为你输入的密码。<br>
你可以如下面代码类似去调用它：
```Objective-C
- (IBAction)pop:(id)sender {
    LrdPasswordAlertView *testView = [[LrdPasswordAlertView alloc] initWithFrame:self.view.bounds];
    testView.block = ^(NSString *text){
        NSLog(@"调用了block");
    };
    [testView pop];
}
```
值得注意的是，如果使用CameraView，需要实现UIImagePickerController的代理，详细使用请参考Demo。

喜欢就给颗星呗~ 

我的博客地址:[我的博客](http://www.lrdup.net "键盘上的舞者")
