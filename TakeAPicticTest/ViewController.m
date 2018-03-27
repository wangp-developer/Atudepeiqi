//
//  ViewController.m
//  TakeAPicticTest
//
//  Created by DHgate on 26/3/18.
//  Copyright © 2018年 DHgate. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}
- (IBAction)TakePictureAction:(id)sender {
    //创建UIImagePickerController
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    //设置代理
    pickVC.delegate = self;
    pickVC.allowsEditing = YES;
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择获取图片方式" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //设置图片源类型
        pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //取出所有图片资源的相簿
        [self presentViewController:pickVC animated:YES completion:nil];
        
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"没有摄像头");
            return ;
        }
        //设置图片源类型
        pickVC.sourceType = UIImagePickerControllerSourceTypeCamera; //获取相机
        [self presentViewController:pickVC animated:YES completion:nil];
        
    }]];
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertC animated:YES completion:nil];
    NSLog(@"图像");
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSLog(@"info-------%@",info);
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _imageView.image = image;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {

        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];

}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
////    NSLog(@"-------%@",info);
////    UIImage *image = info[UIImagePickerControllerEditedImage];
//    _imageView.image = image;
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//
//        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    }
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"将拍照照片保存成功");
    
    UITapGestureRecognizer *tapGestrue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:tapGestrue];
    
    
}

- (void)tapGestureAction{
    UIImageView *windowImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height - self.view.bounds.size.width) / 2, self.view.bounds.size.width,self.view.bounds.size.width)];
    windowImageV.image = _imageView.image;
    
    [self.view.window addSubview:windowImageV];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
