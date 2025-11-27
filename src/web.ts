import { WebPlugin } from '@capacitor/core';

import type { webviewgeniePlugin } from './definitions';

export class webviewgenieWeb extends WebPlugin implements webviewgeniePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
