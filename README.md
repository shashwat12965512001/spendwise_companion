<div class="markdown prose w-full break-words dark:prose-invert dark">
  <hr data-start="2510" data-end="2513" class="">
  <h1 data-start="66" data-end="90" class="">🌐 Flutter WebView App</h1>
  <p data-start="92" data-end="182" class="">A simple Flutter app that loads a website using <code data-start="140"
      data-end="157">webview_flutter</code> and supports JavaScript.</p>
  <h2 data-start="184" data-end="198" class="">📌 Features</h2>
  <ul data-start="199" data-end="359">
    <li data-start="199" data-end="237" class="">
      <p data-start="201" data-end="237" class="">Displays a website inside a WebView.</p>
    </li>
    <li data-start="238" data-end="283" class="">
      <p data-start="240" data-end="283" class="">Supports JavaScript for full functionality.</p>
    </li>
    <li data-start="284" data-end="333" class="">
      <p data-start="286" data-end="333" class="">Customizable styling (e.g., margin at the top).</p>
    </li>
    <li data-start="334" data-end="359" class="">
      <p data-start="336" data-end="359" class="">Works on Android &amp; iOS.</p>
    </li>
  </ul>
  <h2 data-start="361" data-end="382" class="">🚀 Getting Started</h2>
  <h3 data-start="384" data-end="401" class="">Prerequisites</h3>
  <ul data-start="402" data-end="526">
    <li data-start="402" data-end="488" class="">
      <p data-start="404" data-end="488" class="">Flutter installed (<a data-start="423" data-end="487" rel="noopener"
          target="_new" class="cursor-pointer">Download Flutter</a>)</p>
    </li>
    <li data-start="489" data-end="499" class="">
      <p data-start="491" data-end="499" class="">Dart SDK</p>
    </li>
    <li data-start="500" data-end="526" class="">
      <p data-start="502" data-end="526" class="">Android Studio / VS Code</p>
    </li>
  </ul>
  <h3 data-start="528" data-end="544" class="">Installation</h3>
  <ol data-start="545" data-end="793">
    <li data-start="545" data-end="682" class="">
      <p data-start="548" data-end="569" class="">Clone the repository:</p>
      <pre class="!overflow-visible" data-start="573" data-end="682"><div class="contain-inline-size rounded-md border-[0.5px] border-token-border-medium relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute bottom-0 right-0 flex h-9 items-center pr-2"><div class="flex items-center rounded bg-token-sidebar-surface-primary px-2 font-sans text-xs text-token-text-secondary dark:bg-token-main-surface-secondary"><span class="" data-state="closed"></span><span class="" data-state="closed"></span></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="!whitespace-pre language-bash"><span><span>git </span><span><span class="hljs-built_in">clone</span></span><span> https://github.com/yourusername/flutter-webview-app.git
</span><span><span class="hljs-built_in">cd</span></span><span> flutter-webview-app
</span></span></code></div></div></pre>
    </li>
    <li data-start="683" data-end="744" class="">
      <p data-start="686" data-end="707" class="">Install dependencies:</p>
      <pre class="!overflow-visible" data-start="711" data-end="744"><div class="contain-inline-size rounded-md border-[0.5px] border-token-border-medium relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute bottom-0 right-0 flex h-9 items-center pr-2"><div class="flex items-center rounded bg-token-sidebar-surface-primary px-2 font-sans text-xs text-token-text-secondary dark:bg-token-main-surface-secondary"><span class="" data-state="closed"></span><span class="" data-state="closed"></span></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="!whitespace-pre language-bash"><span><span>flutter pub get
</span></span></code></div></div></pre>
    </li>
    <li data-start="745" data-end="793" class="">
      <p data-start="748" data-end="760" class="">Run the app:</p>
      <pre class="!overflow-visible" data-start="764" data-end="793"><div class="contain-inline-size rounded-md border-[0.5px] border-token-border-medium relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute bottom-0 right-0 flex h-9 items-center pr-2"><div class="flex items-center rounded bg-token-sidebar-surface-primary px-2 font-sans text-xs text-token-text-secondary dark:bg-token-main-surface-secondary"><span class="" data-state="closed"></span><span class="" data-state="closed"></span></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="!whitespace-pre language-bash"><span><span>flutter run
</span></span></code></div></div></pre>
      </pre>
      <h2 data-start="1661" data-end="1679" class="">📦 Dependencies</h2>
      <p data-start="1680" data-end="1725" class="">Make sure to add this to your <code data-start="1710"
          data-end="1724">pubspec.yaml</code>:</p>
      <pre class="!overflow-visible" data-start="1726" data-end="1813"><div class="contain-inline-size rounded-md border-[0.5px] border-token-border-medium relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute bottom-0 right-0 flex h-9 items-center pr-2"><div class="flex items-center rounded bg-token-sidebar-surface-primary px-2 font-sans text-xs text-token-text-secondary dark:bg-token-main-surface-secondary"><span class="" data-state="closed"></span><span class="" data-state="closed"></span></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="!whitespace-pre language-yaml"><span><span><span class="hljs-attr">dependencies:</span></span><span>
  </span><span><span class="hljs-attr">flutter:</span></span><span>
    </span><span><span class="hljs-attr">sdk:</span></span><span> </span><span><span class="hljs-string">flutter</span></span><span>
  </span><span><span class="hljs-attr">webview_flutter:</span></span><span> </span><span><span class="hljs-string">latest_version</span></span><span>
</span></span></code></div></div></pre>
      <h2 data-start="1815" data-end="1835" class="">🛠️ Configuration</h2>
      <h3 data-start="1837" data-end="1858" class=""><strong data-start="1841" data-end="1858">Android Setup</strong>
      </h3>
      <p data-start="1859" data-end="1914" class="">Add this to <code data-start="1871"
          data-end="1913">android/app/src/main/AndroidManifest.xml</code>:</p>
      <pre class="!overflow-visible" data-start="1915" data-end="2056"><div class="contain-inline-size rounded-md border-[0.5px] border-token-border-medium relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute bottom-0 right-0 flex h-9 items-center pr-2"><div class="flex items-center rounded bg-token-sidebar-surface-primary px-2 font-sans text-xs text-token-text-secondary dark:bg-token-main-surface-secondary"><span class="" data-state="closed"></span><span class="" data-state="closed"></span></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="!whitespace-pre language-xml"><span><span><span class="hljs-tag">&lt;<span class="hljs-name">uses-permission</span></span></span><span> </span><span><span class="hljs-attr">android:name</span></span><span>=</span><span><span class="hljs-string">"android.permission.INTERNET"</span></span><span>/&gt;
</span><span><span class="hljs-tag">&lt;<span class="hljs-name">application</span></span></span><span>
    </span><span><span class="hljs-attr">android:usesCleartextTraffic</span></span><span>=</span><span><span class="hljs-string">"true"</span></span><span>&gt;
</span><span><span class="hljs-tag">&lt;/<span class="hljs-name">application</span></span></span><span>&gt;
</span></span></code></div></div></pre>
      <h3 data-start="2058" data-end="2075" class=""><strong data-start="2062" data-end="2075">iOS Setup</strong></h3>
      <p data-start="2076" data-end="2112" class="">Add this to <code data-start="2088"
          data-end="2111">ios/Runner/Info.plist</code>:</p>
      <pre class="!overflow-visible" data-start="2113" data-end="2222"><div class="contain-inline-size rounded-md border-[0.5px] border-token-border-medium relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute bottom-0 right-0 flex h-9 items-center pr-2"><div class="flex items-center rounded bg-token-sidebar-surface-primary px-2 font-sans text-xs text-token-text-secondary dark:bg-token-main-surface-secondary"><span class="" data-state="closed"></span><span class="" data-state="closed"></span></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="!whitespace-pre language-xml"><span><span><span class="hljs-tag">&lt;<span class="hljs-name">key</span></span></span><span>&gt;NSAppTransportSecurity</span><span><span class="hljs-tag">&lt;/<span class="hljs-name">key</span></span></span><span>&gt;
</span><span><span class="hljs-tag">&lt;<span class="hljs-name">dict</span></span></span><span>&gt;
    </span><span><span class="hljs-tag">&lt;<span class="hljs-name">key</span></span></span><span>&gt;NSAllowsArbitraryLoads</span><span><span class="hljs-tag">&lt;/<span class="hljs-name">key</span></span></span><span>&gt;
    </span><span><span class="hljs-tag">&lt;<span class="hljs-name">true</span></span></span><span>/&gt;
</span><span><span class="hljs-tag">&lt;/<span class="hljs-name">dict</span></span></span><span>&gt;
</span></span></code></div></div></pre>
      <h2 data-start="2224" data-end="2244" class="">🎯 Running on Web</h2>
      <p data-start="2245" data-end="2371" class="">This app currently runs only on <strong data-start="2277"
          data-end="2294">Android &amp; iOS</strong>. If you need WebView for Flutter Web, consider using <code
          data-start="2348" data-end="2370">flutter_inappwebview</code>.</p>
      <h2 data-start="2373" data-end="2391" class="">🤝 Contributing</h2>
      <p data-start="2392" data-end="2438" class="">Feel free to fork and submit pull requests! 🚀</p>
      <h2 data-start="2440" data-end="2453" class="">📜 License</h2>
      <p data-start="2454" data-end="2508" class="">This project is open-source under the <strong data-start="2492"
          data-end="2507">MIT License</strong>.</p>
      <hr data-start="2510" data-end="2513" class="">
</div>
