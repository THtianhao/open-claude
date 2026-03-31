export type EffortLevel = 'low' | 'medium' | 'high'

export type AnyZodRawShape = Record<string, unknown>
export type InferShape<T> = T extends Record<string, unknown> ? T : never

export type SdkMcpToolDefinition<T = unknown> = {
  name: string
  description?: string
  inputSchema?: T
}

export type McpSdkServerConfigWithInstance = {
  name?: string
  version?: string
  instance?: unknown
}

export type Options = Record<string, unknown>
export type InternalOptions = Record<string, unknown>
export type Query = AsyncIterable<unknown>
export type InternalQuery = AsyncIterable<unknown>
export type SDKSession = Record<string, unknown>
export type SDKSessionOptions = Record<string, unknown>
export type SessionMessage = Record<string, unknown>
export type ListSessionsOptions = Record<string, unknown>
export type GetSessionInfoOptions = Record<string, unknown>
export type GetSessionMessagesOptions = Record<string, unknown>
export type SessionMutationOptions = Record<string, unknown>
export type ForkSessionOptions = Record<string, unknown>
export type ForkSessionResult = Record<string, unknown>
