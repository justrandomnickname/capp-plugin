import { registerPlugin } from '@capacitor/core';

import type { WebViewGeniePlugin } from './definitions';

const WebViewGenie = registerPlugin<WebViewGeniePlugin>('WebViewGenie', {});

export * from './definitions';
export { WebViewGenie };
