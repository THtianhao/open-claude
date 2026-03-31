export type ConnectorTextBlock = {
  type: 'connector_text'
  connector_text: string
}

export type ConnectorTextDelta = {
  type: 'connector_text_delta'
  connector_text: string
}

export function isConnectorTextBlock(value: unknown): value is ConnectorTextBlock {
  if (!value || typeof value !== 'object') return false
  const v = value as { type?: unknown; connector_text?: unknown }
  return v.type === 'connector_text' && typeof v.connector_text === 'string'
}
