# 유현건설 계측 모니터링 — 배포 가이드

## 빠른 시작

```bash
# 의존성 설치
flutter pub get

# 코드 검증
flutter analyze

# 웹 빌드 (가장 간단)
flutter build web

# 결과물: build/web/ 폴더 → 정적 호스팅에 업로드
```

---

## 사전 요구사항

- Flutter SDK 3.10.7 이상
- Android Studio / Xcode (모바일 빌드 시)
- 웹 배포 시: Chrome 또는 지원 브라우저

---

## 1. 웹 배포 (Web)

### 빌드

```bash
cd dashboard
flutter pub get
flutter build web
```

빌드 결과물: `build/web/` 폴더

### 배포 방법

#### A) 정적 호스팅 (Firebase, Vercel, Netlify, GitHub Pages 등)

1. `build/web` 폴더 내용을 호스팅 서비스에 업로드
2. SPA 라우팅: `index.html`로 폴백 설정 필요

**Firebase Hosting 예시:**
```bash
firebase init hosting  # build/web 선택
firebase deploy
```

**Vercel 예시:**
```bash
# vercel.json
{
  "buildCommand": "flutter build web",
  "outputDirectory": "build/web"
}
```

#### B) 자체 서버 (Nginx)

```nginx
server {
    listen 80;
    root /path/to/build/web;
    index index.html;
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

---

## 2. Android 배포 (APK/AAB)

### 디버그 APK (테스트용)

```bash
flutter build apk --debug
# 출력: build/app/outputs/flutter-apk/app-debug.apk
```

### 릴리즈 APK

```bash
flutter build apk --release
# 출력: build/app/outputs/flutter-apk/app-release.apk
```

### App Bundle (Play Store 제출용)

```bash
flutter build appbundle --release
# 출력: build/app/outputs/bundle/release/app-release.aab
```

**서명 설정:** `android/app/build.gradle`에서 `signingConfig` 설정 필요

---

## 3. iOS 배포

### 빌드

```bash
flutter build ios --release
```

Xcode에서 `ios/Runner.xcworkspace` 열어 Archive 후 App Store Connect 업로드

**필수:** Apple Developer 계정, 프로비저닝 프로파일

---

## 4. Windows 배포 (데스크톱)

```bash
flutter build windows --release
# 출력: build/windows/x64/runner/Release/
```

실행 파일: `dashboard.exe` (폴더 전체 배포 필요)

---

## 5. 버전 관리

`pubspec.yaml`:

```yaml
version: 1.0.0+1  # 1.0.0 = 버전명, 1 = 빌드번호
```

빌드 시 오버라이드:

```bash
flutter build apk --build-name=1.0.1 --build-number=2
```

---

## 6. 환경 변수 / 설정

- API URL 등은 `lib/core/config/` 또는 환경별 설정 파일로 분리 권장
- `--dart-define` 사용 예:

```bash
flutter build web --dart-define=API_URL=https://api.example.com
```

---

## 7. 체크리스트 (배포 전)

- [ ] `flutter analyze` 통과
- [ ] `flutter test` 통과 (테스트 작성 시)
- [ ] `pubspec.yaml` 버전 업데이트
- [ ] Android: `android/app/build.gradle` 서명 설정
- [ ] iOS: Bundle ID, 프로비저닝 프로파일 확인
- [ ] 웹: CORS, base href (`<base href="/">`) 확인
