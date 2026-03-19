# dioxus-ipc-bridge-macros

[![Crates.io](https://img.shields.io/crates/v/deckyfx-dioxus-ipc-bridge-macros.svg)](https://crates.io/crates/deckyfx-dioxus-ipc-bridge-macros)
[![License](https://img.shields.io/badge/license-MIT%2FApache--2.0-blue.svg)](LICENSE)

Procedural macros for [dioxus-ipc-bridge](https://github.com/deckyfx/LearningDioxus). Provides the `#[ipc_route]` attribute macro for ergonomic route handler definition.

## Installation

```toml
[dependencies]
deckyfx-dioxus-ipc-bridge = { version = "0.1" }
# Macros are re-exported via the prelude, no need to add this crate directly
```

The macro is re-exported through `dioxus_ipc_bridge::prelude::ipc_route`, so you typically don't need to depend on this crate directly.

## Usage

```rust
use dioxus_ipc_bridge::prelude::*;

#[ipc_route(GET, "/hello/:name")]
fn hello_handler(req: &EnrichedRequest) -> Result<IpcResponse, IpcError> {
    let name = req.path_param("name").unwrap();
    Ok(IpcResponse::ok(serde_json::json!({
        "message": format!("Hello, {}!", name)
    })))
}

// The macro generates a `HelloHandlerRoute` struct
// Use it with the router:
let router = IpcRouter::builder()
    .route("GET", "/hello/:name", Box::new(HelloHandlerRoute))
    .build();
```

## What the Macro Generates

Given this input:

```rust
#[ipc_route(POST, "/submit")]
fn submit_form(req: &EnrichedRequest) -> Result<IpcResponse, IpcError> {
    // ...
}
```

The macro generates:

1. **The original function** — kept as-is for direct use
2. **A handler struct** — `SubmitFormRoute` implementing `RouteHandler`
3. **Helper methods** on the struct:
   - `SubmitFormRoute::method()` → `"POST"`
   - `SubmitFormRoute::pattern()` → `"/submit"`
   - `SubmitFormRoute::register(&mut router)` — registers the route on a router

### Naming Convention

The struct name is derived from the function name by converting `snake_case` to `PascalCase` and appending `Route`:

| Function | Generated Struct |
|----------|-----------------|
| `hello_handler` | `HelloHandlerRoute` |
| `submit_form` | `SubmitFormRoute` |
| `get_user_by_id` | `GetUserByIdRoute` |

## License

Licensed under either of:

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## Related

- [dioxus-react-example](https://github.com/deckyfx/dioxus-react-example) - Complete working example app
- [dioxus-ipc-bridge](https://github.com/deckyfx/LearningDioxus) - Core IPC bridge library
- [dioxus-react-integration](https://github.com/deckyfx/LearningDioxus) - React container for Dioxus
- [dioxus-react-bridge](https://github.com/deckyfx/dioxus-react-bridge) - React hooks for IPC
