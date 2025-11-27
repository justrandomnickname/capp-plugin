export interface webviewgeniePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
