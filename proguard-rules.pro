# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
#基本不用动区域----------------------------------------------------
 #指定代码的压缩级别0-7(指定代码进行迭代优化的次数，在Android里面默认是5，这条指令也只有在可以优化时起作用。)
 -optimizationpasses 5
 #混淆时不使用大小写，混淆后的类名为小写
 -dontusemixedcaseclassnames
 #指定不去忽略非公共的库类(不跳过library中的非public的类)
 -dontskipnonpubliclibraryclasses
 #指定不去忽略非公共库的成员
 -dontskipnonpubliclibraryclassmembers
 #不进行预校验,不需要,可加快混淆速度。
 -dontpreverify
 #混淆时不记录日志
 -verbose
 #屏蔽警告
 -ignorewarnings
 #代码优化
 -dontshrink
 #不进行优化输入的类文件，建议使用此选项，
 -dontoptimize
 #保留注解不混淆
 -keepattributes *Annotation*,InnerClasses
 #避免混淆泛型,这在JSON实体映射时非常重要
 -keepattributes Signature
 #保留代码行号，方便异常信息的追踪
 -keepattributes SourceFile,LineNumberTable
 #指定混淆是采用的算法，后面的参数是一个过滤器
 #这个过滤器是谷歌推荐的算法，一般不做更改
 -optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
 #dump.txt文件列出apk包内所有的class的内部结构
 -dump class_files.txt
 #seeds.txt文件列出未混淆的类和成员
 -printseeds seeds.txt
 #unused.txt文件列出从apk中删除的代码
 -printusage unused.txt
 #mapping.txt文件列出混淆前后的映射
 -printmapping mapping.txt

 #优化时允许访问并修改有修饰符的类和类的成员，这可以提高优化步骤的结果。
 #比如，当内联一个公共的getter方法时，这也可能需要外地公共访问。
 #虽然java二进制规范不需要这个，要不然有的虚拟机处理这些代码会有问题。当有优化和使用-repackageclasses时才适用。
 #指示语：不能用这个指令处理库中的代码，因为有的类和类成员没有设计成public,而在api中可能变成public
 -allowaccessmodification
 #当有优化和使用-repackageclasses时才适用。
 -repackageclasses''


 #不需混淆的Android类
 #继承activity,application,service,broadcastReceiver,contentprovider....不进行混淆
 -keep public class * extends android.app.Fragment
 -keep public class * extends android.app.Activity
 -keep public class * extends android.app.Application
 -keep public class * extends android.app.Service
 -keep public class * extends android.content.BroadcastReceiver
 -keep public class * extends android.preference.Preference
 -keep public class * extends android.content.ContentProvider
 -keep public class * extends android.support.v4.**
 -keep public class * extends android.support.annotation.**
 -keep public class * extends android.support.v7.**
 -keep public class * extends android.app.backup.BackupAgentHelper
 -keep public class * extends android.view.View
 -keep public class * extends android.support.multidex.MultiDexApplication
 -keep public class com.google.vending.licensing.ILicensingService
 -keep public class com.android.vending.licensing.ILicensingService
 -keep class android.support.**{*;}##保留support下的所有类及其内部类


 #support-v4包
 -dontwarn android.supprot.v4.**
 -keep class android.support.v4.app.**{*;}
 -keep interface android.support.v4.app.**{*;}


 #support-v7包
 -dontwarn android.supprot.v7.**
 -keep class android.support.v7.internal.**{*;}
 -keep interface android.support.v7.internal.**{*;}
 -keep class android.support.v7.**{*;}


 #supportdesign
 -dontwarn android.supprot.design.**
 -keep class android.support.design.**{*;}
 -keep interface android.support.design.**{*;}
 -keep public class android.support.design.R$*{*;}

 #避免混淆自定义控件类的get/set方法和构造函数
 #因为属性动画需要有相应的setter和getter的方法实现，混淆了就无法工作了。
 -keep public class * extends android.view.View{
 *** get*();
 void set*(***);
    public<init>(android.content.Context);
    public<init>(android.content.Context,android.util.AttributeSet);
    public<init>(android.content.Context,android.util.AttributeSet,int);
 }
 -keepclasseswithmembers class * {
    public <init>(android.content.Context,android.util.AttributeSet);
    public <init>(android.content.Context,android.util.AttributeSet,int);
 }


 #关闭Log日志
 -assumenosideeffects class android.util.Log{
 public static boolean isLoggable(java.lang.String,int);
 public static int v(...);
 public static int i(...);
 public static int w(...);
 public static int d(...);
 public static int e(...);
 }

 #避免资源混淆
 -keep class **.R$*{*;}


 #这个主要是在layout中写的onclick方法android:onclick="onClick"，不进行混淆
 #表示不混淆Activity中参数是View的方法，因为有这样一种用法，在XML中配置android:onClick=”buttonClick”属性，
 #当用户点击该按钮时就会调用Activity中的buttonClick(Viewview)方法，如果这个方法被混淆的话就找不到了
 -keepclassmembers class * extends android.app.Activity{
    public void * (android.view.View);
 }


 #对于带有回调函数的onXXEvent、**On*Listener的，不能被混淆
 -keepclassmembers class *{
    void *(**On*Event);
    void *(**On*Listener);
 }


 #避免混淆枚举类
 -keepclassmembers enum *{
 public static **[]values();
 public static ** valueOf(java.lang.String);
 }


 #Natvie方法不混淆
 -keepclasseswithmembernames class *{
    native <methods>;
 }


 #表示不混淆Parcelable实现类中的CREATOR字段，
 #毫无疑问，CREATOR字段是绝对不能改变的，包括大小写都不能变，不然整个Parcelable工作机制都会失败。
 -keep class * implements android.os.Parcelable{
 public static final android.os.Parcelable$Creator *;
 }


 #这指定了继承Serizalizable的类的如下成员不被移除混淆
 -keepclassmembers class * implements java.io.Serializable{
     static final long serialVersionUID;
     private static final java.io.ObjectStreamField[] serialPersistentFields;
     !static!transient<fields>;
     private void writeObject(java.io.ObjectOutputStream);
     private void readObject(java.io.ObjectInputStream);
     java.lang.Object writeReplace();
     java.lang.Object readResolve();
 }


 #webView混淆配置
 -keepclassmembers class fqcn.of.javascript.interface.for.Webview{
 public*;
 }
 -keepclassmembers class * extends android.webkit.WebViewClient{
 public void *(android.webkit.WebView,java.lang.String,android.graphics.Bitmap);
 public boolean *(android.webkit.WebView,java.lang.String);
 }
 -keepclassmembers class * extends android.webkit.WebViewClient{
    public void * (android.webkit.WebView,jav.lang.String);
 }


 #保留我们自定义控件（继承自View）不被混淆
 -keep public class * extends android.view.View{
 ***get*();
 void set*(***);
 public<init>(android.content.Context);
 public<init>(android.content.Context,android.util.AttributeSet);
 public<init>(android.content.Context,android.util.AttributeSet,int);
 }


 #保持测试相关的代码
 -dontnote junit.framework.**
 -dontnote junit.runner.**
 -dontwarn android.test.**
 -dontwarn android.support.test.**
 -dontwarn org.junit.**


 #androidx
 -keep class com.google.android.material.**{*;}
 -keep class androidx.**{*;}
 -keep public class * extends androidx.**
 -keep interface androidx.**{*;}
 -dontwarn com.google.android.material.**
 -dontnote com.google.android.material.**
 -dontwarn androidx.**


 #kotlin
 -keep class kotlin.** {*;}
 -keep class kotlin.Metadata{*;}
 -dontwarn kotlin.**
 -keepclassmembers class **$WhenMappings{
 <fields>;
 }
 -keepclassmembers class kotlin.Metadata{
    public <methods>;
 }
 -assumenosideeffects class kotlin.jvm.internal.Intrinsics{
 static void checkParameterIsNotNull(java.lang.Object,java.lang.String);
 }


 #okhttp3
 -dontwarn com.squareup.okhttp3.**
 -keep class com.squareup.okhttp3.**{*;}
 -dontwarn okio.**


 #Retrofit
 -dontnote retrofit2.**
 -keep class retrofit2.**{*;}
 -keepattributes Signature
 -keepattributes Exceptions


 #Gson
 -keep class com.google.gson.**{*;}
 -keep class com.google.**{*;}
 -keep class sun.misc.Unsafe{*;}
 -keep class com.google.gson.stream.**{*;}
 -keep class com.google.gson.examples.android.model.**{*;}


 #JavaBean
 -keep class com.cmcc.armachineroom.**.*Bean{*;}
 -keep class com.cmcc.library.network.**{*;}


 #即构
 -keep class **.zego.**{*;}


 #Glide
 -keep public class * implements com.bumptech.glide.module.GlideModule
 -keep public class * extends com.bumptech.glide.module.AppGlideModule
 -keep public enum com.bumptech.glide.load.ImageHeaderParser$**{
    **[] $VALUES;
    public *;
 }
 -keep class com.bumptech.glide.load.data.ParcelFileDescriptorRewinder$InternalRewinder{
     ***rewind();
 }


 #Bugly
 -dontwarn com.tencent.bugly.**
 -keep public class com.tencent.bugly.**{*;}