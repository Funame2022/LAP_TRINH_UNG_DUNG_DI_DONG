# Lab F2 — Bố cục giao diện trong Flutter

**Sinh viên:** Nguyễn Thịnh Phú  
**MSSV:** 231A010025  
**Lớp:** 231A29032  
**Email:** phu231a010025@st.vhu.edu.vn

Ứng dụng Flutter Material 3 dựng lại màn hình đăng nhập Cổng thực hành LTDD.
Giao diện cuộn được; ở chiều rộng từ 700 px, form và thẻ hồ sơ chuyển sang hai
cột. Hồ sơ hiển thị thông tin sinh viên.

## Chạy trên Android Emulator

1. Cài Flutter SDK, Android Studio, Android SDK Platform-Tools, Android
   Emulator và một Android Virtual Device (AVD).
2. Mở Android Studio → Device Manager và khởi chạy một AVD. Xác nhận ADB liệt
   kê thiết bị ở trạng thái `device`:

   ```powershell
   adb devices
   ```

3. Mở thư mục `f2_layout` trong VS Code hoặc Android Studio, rồi chạy:

   ```powershell
   flutter doctor
   flutter pub get
   flutter devices
   flutter run -d emulator-5554
   ```

   Thay `emulator-5554` bằng ID xuất hiện trong `flutter devices` nếu khác.
   Nếu lệnh `flutter` không được nhận diện, thêm thư mục `flutter\bin` của
   Flutter SDK vào `PATH`, khởi động lại terminal, rồi chạy lại các lệnh.

### Thiết lập trên máy phát triển hiện tại

Flutter SDK được cài tại `G:\flutterSDKs\flutter`, AVD có tên `Pixel_4`. Từ
PowerShell:

```powershell
$env:Path = 'G:\flutterSDKs\flutter\bin;' + $env:Path
cd G:\F2_231A010025\f2_layout
flutter emulators --launch Pixel_4
flutter devices
flutter run -d emulator-5554
```

Chờ emulator khởi động và hiển thị trạng thái `device` trước khi chạy. Trạng
thái `offline` có nghĩa là máy ảo/ADB chưa sẵn sàng.

## Build và kiểm tra

```powershell
flutter analyze
flutter test
flutter build apk --debug
```

APK debug được tạo tại
`build\app\outputs\flutter-apk\app-debug.apk`. Cài APK khi emulator đang chạy:

```powershell
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

## Tương tác và giới hạn

- Chạm biểu tượng trên banner để đổi theme sáng/tối.
- Chạm biểu tượng con mắt để hiện hoặc ẩn mật khẩu.
- Checkbox ghi nhớ và nút đăng nhập có phản hồi trực quan.
- Quên mật khẩu, đăng nhập tài khoản trường và đăng ký hiện thông báo mô phỏng.
- Bài thực hành không kết nối dịch vụ xác thực, không lưu hoặc gửi dữ liệu nhập.
