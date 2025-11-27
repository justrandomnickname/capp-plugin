import type { PluginListenerHandle } from "@capacitor/core";


/**
 * The types of animations available for the loading indicator.
 * These correspond to the animations provided by the SwiftfulLoadingIndicators library.
 * currently only iOS is supported.
 * currently supported types are:
 * - loadingBar
 * - loadingCircleRunner
 * - loadingThreeBalls
 * - loadingThreeBallsRotation
 * - loadingThreeBallsBouncing
 * - loadingPulse
 * - loadingCircleBlinks
 *
 * see more details at https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators/tree/main
 * @since 1.0.0
 */
export type AnimationTypes =
  | "loadingBar"
  | "loadingCircleRunner"
  | "loadingThreeBalls"
  | "loadingThreeBallsRotation"
  | "loadingThreeBallsBouncing"
  | "loadingPulse"
  | 'loadingCircleBlinks';

/**
 * iOS specific configuration for the WebView.
 * @since 1.0.0
 */
export interface WebViewGenieIOSOptions {
  /**
   * The animation type to use for the loading indicator.
   * See more details at https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators/tree/main
   * Plugin has been integrated directly by MIT license.
   * @since 1.0.0
   */
  animation?: AnimationTypes;
  /**
   * The color of the loading indicator, specified in hex format (e.g., #FF0000 for red).
   * @since 1.0.0
   */
  color?: string;
  /**
   * The size of the loading indicator in points.
   * @since 1.0.0
   */
  size?: number;
  /**
   * The speed multiplier of the loading indicator animation (1.0 is normal speed).
   * @since 1.0.0
   */
  speed?: number;
}

export interface WebViewGenieOptions {
  /**
   * The URL to load in the webview. E.g., https://google.com
   */
  url: string;
  /**
   * iOS specific options. Currently only iOS is supported.
   * @since 1.0.0
   */
  ios?: WebViewGenieIOSOptions;
}

export interface WebViewGeniePlugin {
  /**
   * Open the webview with the specified options.
   * @since 1.0.0
   * @param { WebViewGenieOptions } options WebView options
   * @returns { Promise<void> } A promise that resolves when the webview is opened.
   */
  open(options: WebViewGenieOptions): Promise<void>;
  /**
   * Close the webview.
   * @since 1.0.0
   * @returns { Promise<void> } A promise that resolves when the webview is closed.
   */
  close(): Promise<void>;
  /**
   * Add an event listener for the navigation event. Fired when internal navigation occurs within the webview.
   * E.g ., when the user clicks a link inside the webview that navigates to a different URL.
   * @since 1.0.0
   * @param { "navigation" } eventName The name of the event to listen for.
   * @param { (info: { url: string }) => void } listenerFunc The function to call when the event occurs.
   * @returns { Promise<PluginListenerHandle> } A promise that resolves with a handle to the listener.
   */
  addListener(
    eventName: "navigation",
    listenerFunc: (info: { url: string }) => void
  ): Promise<PluginListenerHandle>;
}
