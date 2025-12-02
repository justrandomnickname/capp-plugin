# @justrandomnickname/webviewgenie

A Capacitor plugin for opening external URLs in a native WebView with customizable loading animations and navigation tracking.
Currently working only in IOS environment.
Android is on the way

## Features

- 🚀 Open URLs in a native iOS WebView (full-screen)
- 🎨 Customizable loading animations (7 different types)
- 🎯 URL navigation tracking
- 🧭 Built-in navigation toolbar with Back/Forward buttons
- ❌ Easy close button with localized labels
- 🌗 Automatic dark/light theme support
- 📱 Currently supports iOS only (Android coming soon)
- 🎭 Beautiful loading indicators powered by [SwiftfulLoadingIndicators](https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators)

## Install

```bash
npm install @justrandomnickname/webviewgenie
npx cap sync
```

## iOS Configuration

### Info.plist Requirements

✅ **Works out of the box for HTTPS URLs** - no additional configuration needed!

⚠️ **For HTTP URLs**, you need to add App Transport Security (ATS) settings to your `ios/App/App/Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <!-- Option 1: Allow all insecure loads (NOT recommended for production) -->
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    
    <!-- Option 2: Allow specific domains only (RECOMMENDED for production) -->
    <key>NSExceptionDomains</key>
    <dict>
        <key>yourdomain.com</key>
        <dict>
            <key>NSIncludesSubdomains</key>
            <true/>
            <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```

**Security Best Practice:** For production apps, always use Option 2 with specific domain exceptions instead of allowing all insecure loads.

## Usage

```typescript
import { WebViewGenie } from '@justrandomnickname/webviewgenie';

// Basic usage
await WebViewGenie.open({
  url: 'https://example.com'
});

// With custom loading animation
await WebViewGenie.open({
  url: 'https://example.com',
  ios: {
    animation: 'loadingThreeBalls',
    color: '#FF6B6B',
    size: 100,
    speed: 1.5
  }
});

// Listen for navigation events
await WebViewGenie.addListener('navigation', (info) => {
  console.log('Navigated to:', info.url);
  
  // Close webview when reaching a specific URL
  if (info.url.includes('success')) {
    WebViewGenie.close();
  }
});

// Close programmatically
await WebViewGenie.close();

// Remove listener when done
listener.remove();
```

## User Interface

The WebView includes a native toolbar with:
- **Close button** (localized to device language - "Done"/"Готово"/etc.)
- **Back button** - Navigate to previous page in WebView history
- **Forward button** - Navigate to next page in WebView history

The toolbar automatically adapts to the device's light/dark theme.

## API

<docgen-index>

* [`open(...)`](#open)
* [`close()`](#close)
* [`addListener('navigation', ...)`](#addlistenernavigation-)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### open(...)

```typescript
open(options: WebViewGenieOptions) => Promise<void>
```

Open the webview with the specified options.

| Param         | Type                                                                | Description     |
| ------------- | ------------------------------------------------------------------- | --------------- |
| **`options`** | <code><a href="#webviewgenieoptions">WebViewGenieOptions</a></code> | WebView options |

**Since:** 1.0.0

--------------------


### close()

```typescript
close() => Promise<void>
```

Close the webview.

**Since:** 1.0.0

--------------------


### addListener('navigation', ...)

```typescript
addListener(eventName: "navigation", listenerFunc: (info: { url: string; }) => void) => Promise<PluginListenerHandle>
```

Add an event listener for the navigation event. Fired when internal navigation occurs within the webview.
E.g ., when the user clicks a link inside the webview that navigates to a different URL.

| Param              | Type                                             | Description                                 |
| ------------------ | ------------------------------------------------ | ------------------------------------------- |
| **`eventName`**    | <code>'navigation'</code>                        | The name of the event to listen for.        |
| **`listenerFunc`** | <code>(info: { url: string; }) =&gt; void</code> | The function to call when the event occurs. |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 1.0.0

--------------------


### Interfaces


#### WebViewGenieOptions

| Prop      | Type                                                                      | Description                                              | Since |
| --------- | ------------------------------------------------------------------------- | -------------------------------------------------------- | ----- |
| **`url`** | <code>string</code>                                                       | The URL to load in the webview. E.g., https://google.com |       |
| **`ios`** | <code><a href="#webviewgenieiosoptions">WebViewGenieIOSOptions</a></code> | iOS specific options. Currently only iOS is supported.   | 1.0.0 |


#### WebViewGenieIOSOptions

iOS specific configuration for the WebView.

| Prop            | Type                                                      | Description                                                                                                                                                                                          | Since |
| --------------- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| **`animation`** | <code><a href="#animationtypes">AnimationTypes</a></code> | The animation type to use for the loading indicator. See more details at https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators/tree/main Plugin has been integrated directly by MIT license. | 1.0.0 |
| **`color`**     | <code>string</code>                                       | The color of the loading indicator, specified in hex format (e.g., #FF0000 for red).                                                                                                                 | 1.0.0 |
| **`size`**      | <code>number</code>                                       | The size of the loading indicator in points.                                                                                                                                                         | 1.0.0 |
| **`speed`**     | <code>number</code>                                       | The speed multiplier of the loading indicator animation (1.0 is normal speed).                                                                                                                       | 1.0.0 |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


### Type Aliases


#### AnimationTypes

The types of animations available for the loading indicator.
These correspond to the animations provided by the SwiftfulLoadingIndicators library.
currently only iOS is supported.
currently supported types are:
- loadingBar
- loadingCircleRunner
- loadingThreeBalls
- loadingThreeBallsRotation
- loadingThreeBallsBouncing
- loadingPulse
- loadingCircleBlinks

see more details at https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators/tree/main

<code>"loadingBar" | "loadingCircleRunner" | "loadingThreeBalls" | "loadingThreeBallsRotation" | "loadingThreeBallsBouncing" | "loadingPulse" | 'loadingCircleBlinks'</code>

</docgen-api>

## License

MIT

## Acknowledgments

This plugin integrates the [SwiftfulLoadingIndicators](https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators) library by Nick Sarno (@SwiftfulThinking) under the MIT License.

**SwiftfulLoadingIndicators License:**

```
MIT License

Copyright (c) 2023 Nick Sarno

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

Special thanks to Nick Sarno for creating these beautiful SwiftUI loading animations!
