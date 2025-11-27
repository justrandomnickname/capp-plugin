import { registerPlugin } from '@capacitor/core';

import type { webviewgeniePlugin } from './definitions';

const webviewgenie = registerPlugin<webviewgeniePlugin>('webviewgenie', {
  web: () => import('./web').then((m) => new m.webviewgenieWeb()),
});

export * from './definitions';
export { webviewgenie };
