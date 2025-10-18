# 📚 توثيق مشروع الدردشة بفلاटर + فايربيس (شرح تعليمي مبسّط)

هذا المستند يشرح مشروع الدردشة خطوة بخطوة باللغة العربية، مع أمثلة من الكود وطريقة التشغيل والتأمين والتنظيف. مناسب لشرح جامعي وللتطبيق العملي مع الطلاب.

## ✅ ما الذي ستتعلّمه؟

- إعداد Flutter + Firebase للمشروع
- تفعيل تسجيل الدخول بالإيميل وكلمة المرور
- حفظ بيانات المستخدمين في Firestore
- محادثات خاصة 1-إلى-1 مع تخزين الرسائل لحظيًا
- قواعد الأمان Firestore المناسبة للمشروع
- تشغيل التطبيق على أندرويد وiOS
- استكشاف الأخطاء وتنظيف المشروع/البيانات

---

## المتطلبات قبل البدء

- Flutter SDK (مُثبت على جهازك) — تأكد أن `flutter doctor` لا يظهر أخطاء حرجة
- حساب Firebase مجاني
- محرر كود (VS Code أو Android Studio)
- على macOS لتشغيل iOS: Xcode مُثبت وحساب مطوّر (للتجربة على جهاز فعلي)

اختياري (يوصَى به للمطورين):
- Node.js + Firebase CLI لإدارة القواعد والنشر: `npm i -g firebase-tools`

---

## لمحة عن بنية المشروع

```
lib/
├─ main.dart              // تهيئة Firebase وتوجيه الشاشات حسب حالة الدخول
├─ login_screen.dart      // شاشة تسجيل الدخول
├─ signup_screen.dart     // شاشة إنشاء حساب جديد + حفظ المستخدم في Firestore
├─ users_screen.dart      // قائمة المستخدمين + فتح محادثة خاصة
├─ chat_screen.dart       // شاشة محادثة خاصة 1-إلى-1
└─ user_data_fixer.dart   // أداة للتأكد/إصلاح بيانات المستخدم في Firestore

firestore.rules           // قواعد أمان Firestore الجاهزة
firebase.json             // إعدادات FlutterFire CLI
```

### تهيئة Firebase داخل التطبيق

في `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
```

تُقرأ الإعدادات من `lib/firebase_options.dart` (مولَّد بواسطة FlutterFire CLI). هذا المشروع مهيأ لِـ Android و iOS.

---

## تدفّق عمل التطبيق (User Flow)

1) المستخدم يفتح التطبيق → إن كان مسجّل دخولًا يُحوَّل مباشرة إلى قائمة المستخدمين؛ وإلا فسيظهر له نموذج تسجيل الدخول.
2) من قائمة المستخدمين يختار مستخدمًا آخر لبدء محادثة خاصة.
3) تُخزّن الرسائل لحظيًا في Firestore وتظهر فورًا لدى الطرفين.

هذا كله يتم عبر المكوّن `AuthWrapper` في `main.dart`:

```dart
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData && snapshot.data != null) {
          return const UsersScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
```

---

## نموذج البيانات في Firestore

```
users (collection)
  └─ {userId} (document)
      ├─ uid: String
      ├─ email: String
      └─ createdAt: Timestamp

private_chats (collection)
  └─ {chatId} (document)      // chatId = "uid1_uid2" بترتيب أبجدي
      └─ messages (subcollection)
          └─ {messageId} (document)
              ├─ text: String
              ├─ sender: String (UID)
              └─ timestamp: Timestamp
```

إنشاء chatId يتم بترتيب UIDs أبجديًا لضمان أن كلا الطرفين يفتحان نفس المحادثة دائمًا:

```dart
final currentUserId = _auth.currentUser!.uid;
final List<String> ids = [currentUserId, widget.otherUserId];
ids.sort();
_chatId = '${ids[0]}_${ids[1]}';
```

إرسال الرسالة في `chat_screen.dart`:

```dart
await _firestore
  .collection('private_chats')
  .doc(_chatId)
  .collection('messages')
  .add({
    'text': _messageController.text.trim(),
    'sender': _auth.currentUser!.uid,
    'timestamp': FieldValue.serverTimestamp(),
  });
```

---

## قواعد الأمان Firestore (هامة جدًا)

ملف `firestore.rules` في المشروع يحتوي على القواعد المناسبة. هذا ملخّصها:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null; // أي مستخدم مسجّل دخول يمكنه قراءة كل المستخدمين
      allow create, update: if request.auth != null && request.auth.uid == userId; // يكتب فقط على وثيقته
      allow delete: if false;
    }

    match /private_chats/{chatId} {
      function isParticipant() {
        let userIds = chatId.split('_');
        return request.auth != null && request.auth.uid in userIds;
      }
      match /messages/{messageId} {
        allow read: if isParticipant();
        allow create: if isParticipant() &&
                       request.resource.data.sender == request.auth.uid &&
                       request.resource.data.keys().hasAll(['text','sender','timestamp']);
        allow update, delete: if false;
      }
    }
  }
}
```

نشر القواعد:
- من Firebase Console → Firestore → Rules → لصق القواعد → Publish
- أو عبر Firebase CLI: `firebase deploy --only firestore:rules`

ملاحظة: بدون نشر القواعد لن تعمل قراءة/كتابة البيانات كما تتوقع.

---

## شرح سريع لملفات الواجهات

1) `login_screen.dart`
- حقول Email/Password + تسجيل الدخول عبر FirebaseAuth
- معالجة أخطاء شائعة مثل user-not-found و wrong-password

2) `signup_screen.dart`
- إنشاء حساب جديد عبر FirebaseAuth
- حفظ بيانات المستخدم في `users/{uid}` مع `createdAt`
- استخدام `SetOptions(merge: true)` لضمان عدم فقدان بيانات سابقة

3) `users_screen.dart`
- يعرض جميع المستخدمين (عدا نفسك)
- زر Refresh للتحديث
- يحاول التأكد من وجود بياناتك في Firestore عبر `UserDataFixer.ensureUserDataExists()`
- عند الضغط على مستخدم → يفتح محادثة خاصة معه

4) `chat_screen.dart`
- بث حي للرسائل عبر `StreamBuilder` مرتبة تنازليًا بالتاريخ
- فقاعات دردشة ملوّنة بحسب المرسل (أنت/الطرف الآخر)
- عرض توقيت مبسّط HH:mm عند وجود `timestamp`

5) `user_data_fixer.dart`
- أداة فحص/إصلاح لبيانات المستخدم الحالي في Firestore
- تنشئ الوثيقة إذا لم تكن موجودة، وتُكمل الحقول الناقصة

---

## تشغيل المشروع

1) تثبيت الحزم:
```
flutter pub get
```
2) أندرويد: تأكد من وجود `android/app/google-services.json`

3) iOS: تأكد من وجود `ios/Runner/GoogleService-Info.plist`

4) شغّل التطبيق:
```
flutter run
```

إذا ظهرت مشكلة في منصّة معيّنة، أعد تشغيل `flutterfire configure` لتوليد `firebase_options.dart` عند اللزوم.

---

## استكشاف الأخطاء الشائعة

- Permission denied في Firestore: تأكد أنك نشرت القواعد أعلاه، وأن المستخدم مسجّل دخول.
- الرسائل لا تظهر: افحص أن `private_chats/{chatId}/messages` يتلقى وثائق جديدة، وأن `orderBy('timestamp', descending: true)` مع `serverTimestamp()` لا يعطي قيم null في البداية (الواجهة تتعامل معها).
- المستخدمون لا يظهرون: تأكد من وجود وثائق في `users`، وإذا كان لديك مستخدم قديم افتح `UsersScreen` ليتم الإصلاح التلقائي، ثم اضغط Refresh.
- تسجيل الدخول يفشل: تحقق من صحة الإيميل/كلمة المرور ورسائل الخطأ في الواجهة.

---

## ملحوظات تعليمية للمحاضِر

- اشرح للطلاب لماذا نستخدم chatId ثابتًا بترتيب أبجدي، وكيف يؤثر ذلك على الأمان وبساطة الاستعلام.
- ناقش قواعد الأمان وكيف تمنع الاطلاع على محادثات الآخرين.
- وضّح الفرق بين client SDK و Admin SDK (لماذا لا يمكن تعداد كل مستخدمي Auth من العميل؟).
- اقترح تحسينات: أسماء عرض وصور شخصية، مؤشرات الكتابة، إشعارات Push، مرفقات صور/فيديو.

---

## تنظيف المشروع والبيانات

راجع دليل التنظيف الكامل هنا:
- docs/CLEANUP_AR.md — تنظيف Flutter (build/Pods) + تنظيف بيانات Firebase (حذف مجموعات/مستخدمين) بأمان.

---

## موارد إضافية

- Flutter: https://docs.flutter.dev/
- Firebase Auth: https://firebase.google.com/docs/auth
- Firestore: https://firebase.google.com/docs/firestore
