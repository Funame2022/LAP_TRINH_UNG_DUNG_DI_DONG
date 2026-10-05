import 'package:f2_layout/main.dart';
import 'package:f2_layout/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the login form and the student profile', (tester) async {
    await tester.pumpWidget(const F2LayoutApp());

    expect(find.text('Đăng nhập hệ thống'), findsOneWidget);
    expect(find.text('Cổng thực hành LTDD'), findsOneWidget);
    expect(find.text('Nguyễn Thịnh Phú'), findsOneWidget);
    expect(find.text('MSSV: 231A010025'), findsOneWidget);
    expect(find.text('231A29032'), findsOneWidget);
    expect(find.text('phu231a010025@st.vhu.edu.vn'), findsOneWidget);
  });

  testWidgets('uses text input for the alphanumeric student ID', (
    tester,
  ) async {
    await tester.pumpWidget(const F2LayoutApp());

    final studentIdField = tester.widget<TextField>(
      find.byType(TextField).first,
    );
    expect(studentIdField.keyboardType, TextInputType.text);
    expect(find.text('Ví dụ: 231A010025'), findsOneWidget);
  });

  testWidgets('toggles password visibility', (tester) async {
    await tester.pumpWidget(const F2LayoutApp());

    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isTrue,
    );

    await tester.tap(find.byTooltip('Hiện mật khẩu'));
    await tester.pump();

    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isFalse,
    );
    expect(find.byTooltip('Ẩn mật khẩu'), findsOneWidget);
  });

  testWidgets('toggles the remember-login checkbox', (tester) async {
    await tester.pumpWidget(const F2LayoutApp());
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
  });

  testWidgets('shows a confirmation snackbar after login is tapped', (
    tester,
  ) async {
    await tester.pumpWidget(const F2LayoutApp());
    await tester.tap(find.text('ĐĂNG NHẬP'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.text('Đăng nhập mô phỏng thành công. Xin chào Phú!'),
      findsOneWidget,
    );
  });

  testWidgets('uses two columns at 1000 pixels', (tester) async {
    tester.view.physicalSize = const Size(1000, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const F2LayoutApp());

    expect(
      find.ancestor(of: find.byType(ProfileCard), matching: find.byType(Row)),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('switches layout at the 700-pixel viewport breakpoint', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    tester.view.physicalSize = const Size(699, 900);
    await tester.pumpWidget(const F2LayoutApp());
    expect(
      find.ancestor(of: find.byType(ProfileCard), matching: find.byType(Row)),
      findsNothing,
    );
    expect(tester.takeException(), isNull);

    tester.view.physicalSize = const Size(700, 900);
    await tester.pump();
    expect(
      find.ancestor(of: find.byType(ProfileCard), matching: find.byType(Row)),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps the narrow layout free of render exceptions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const F2LayoutApp());

    expect(
      find.ancestor(of: find.byType(ProfileCard), matching: find.byType(Row)),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps the form scrollable when the keyboard reduces height', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 780);
    tester.view.devicePixelRatio = 1;
    tester.view.viewInsets = const FakeViewPadding(bottom: 320);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);

    await tester.pumpWidget(const F2LayoutApp());
    await tester.tap(find.byType(TextField).first);
    await tester.pump();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('switches between light and dark themes', (tester) async {
    await tester.pumpWidget(const F2LayoutApp());
    expect(
      Theme.of(tester.element(find.byType(LoginPage))).brightness,
      Brightness.light,
    );

    await tester.tap(find.byTooltip('Chuyển chế độ sáng/tối'));
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.byType(LoginPage))).brightness,
      Brightness.dark,
    );
  });
}
