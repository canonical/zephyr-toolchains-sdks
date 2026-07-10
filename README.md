# Zephyr Toolchain SDKs for Workshop

This is a **monorepository** of [Workshop](https://ubuntu.com/workshop/docs/)
SDKs that provide the Zephyr cross-compiler toolchains built from the
[zephyrproject-rtos/sdk-ng](https://github.com/zephyrproject-rtos/sdk-ng)
releases. Each subdirectory is a self-contained `sdkcraft` project that packages
one toolchain (or the SDK NG bundle) for a specific target architecture.

Every toolchain here needs the *companion* `zephyr-sdk-ng` SDK, which brings the
base directory tree structure for the toolchain installation directory

The base SDK is maintained separately in [`canonical/zephyr-sdk`](https://github.com/canonical/zephyr-sdk) and is **not**
part of this monorepo. Connect a toolchain from this repo to the base SDK to
target a specific architecture.

---

## Repository layout

Each directory is an independent SDK with its own `sdkcraft.yaml`, `README.md`,
`tests/`, and `renovate.json` is centralised at the repository root. All
toolchains track the same upstream `sdk-ng` release, so they are versioned and
released together (see [Versioning and branches](#versioning-and-branches)).

`zephyr-sdk-ng` is the SDK NG *bundle* (the minimal SDK NG distribution that
exposes the per-architecture toolchain mount points). The remaining directories
are the per-architecture toolchains:

| SDK directory | Target triple |
| --- | --- |
| [`zephyr-sdk-ng`](zephyr-sdk-ng/) | `sdk-ng bundle (minimal)` |
| [`zephyr-amd64-sdk`](zephyr-amd64-sdk/) | `x86_64-zephyr-elf` |
| [`zephyr-arc-sdk`](zephyr-arc-sdk/) | `arc-zephyr-elf` |
| [`zephyr-arc64-sdk`](zephyr-arc64-sdk/) | `arc64-zephyr-elf` |
| [`zephyr-arm-sdk`](zephyr-arm-sdk/) | `arm-zephyr-eabi` |
| [`zephyr-arm64-sdk`](zephyr-arm64-sdk/) | `aarch64-zephyr-elf` |
| [`zephyr-microblazeel-sdk`](zephyr-microblazeel-sdk/) | `microblazeel-zephyr-elf` |
| [`zephyr-mips-sdk`](zephyr-mips-sdk/) | `mips-zephyr-elf` |
| [`zephyr-nios2-sdk`](zephyr-nios2-sdk/) | `nios2-zephyr-elf` |
| [`zephyr-riscv64-sdk`](zephyr-riscv64-sdk/) | `riscv64-zephyr-elf` |
| [`zephyr-sparc-sdk`](zephyr-sparc-sdk/) | `sparc-zephyr-elf` |
| [`zephyr-xtensa-amd-acp-6-0-adsp-sdk`](zephyr-xtensa-amd-acp-6-0-adsp-sdk/) | `xtensa-amd_acp_6_0_adsp_zephyr-elf` |
| [`zephyr-xtensa-dc233c-sdk`](zephyr-xtensa-dc233c-sdk/) | `xtensa-dc233c_zephyr-elf` |
| [`zephyr-xtensa-espressif-esp32-sdk`](zephyr-xtensa-espressif-esp32-sdk/) | `xtensa-espressif_esp32_zephyr-elf` |
| [`zephyr-xtensa-espressif-esp32s2-sdk`](zephyr-xtensa-espressif-esp32s2-sdk/) | `xtensa-espressif_esp32s2_zephyr-elf` |
| [`zephyr-xtensa-espressif-esp32s3-sdk`](zephyr-xtensa-espressif-esp32s3-sdk/) | `xtensa-espressif_esp32s3_zephyr-elf` |
| [`zephyr-xtensa-intel-ace15-mtpm-sdk`](zephyr-xtensa-intel-ace15-mtpm-sdk/) | `xtensa-intel_ace15_mtpm_zephyr-elf` |
| [`zephyr-xtensa-intel-ace30-ptl-sdk`](zephyr-xtensa-intel-ace30-ptl-sdk/) | `xtensa-intel_ace30_ptl_zephyr-elf` |
| [`zephyr-xtensa-intel-tgl-adsp-sdk`](zephyr-xtensa-intel-tgl-adsp-sdk/) | `xtensa-intel_tgl_adsp_zephyr-elf` |
| [`zephyr-xtensa-mtk-mt8195-adsp-sdk`](zephyr-xtensa-mtk-mt8195-adsp-sdk/) | `xtensa-mtk_mt8195_adsp_zephyr-elf` |
| [`zephyr-xtensa-nxp-imx-adsp-sdk`](zephyr-xtensa-nxp-imx-adsp-sdk/) | `xtensa-nxp_imx_adsp_zephyr-elf` |
| [`zephyr-xtensa-nxp-imx8m-adsp-sdk`](zephyr-xtensa-nxp-imx8m-adsp-sdk/) | `xtensa-nxp_imx8m_adsp_zephyr-elf` |
| [`zephyr-xtensa-nxp-imx8ulp-adsp-sdk`](zephyr-xtensa-nxp-imx8ulp-adsp-sdk/) | `xtensa-nxp_imx8ulp_adsp_zephyr-elf` |
| [`zephyr-xtensa-nxp-rt500-adsp-sdk`](zephyr-xtensa-nxp-rt500-adsp-sdk/) | `xtensa-nxp_rt500_adsp_zephyr-elf` |
| [`zephyr-xtensa-nxp-rt600-adsp-sdk`](zephyr-xtensa-nxp-rt600-adsp-sdk/) | `xtensa-nxp_rt600_adsp_zephyr-elf` |
| [`zephyr-xtensa-nxp-rt700-hifi1-sdk`](zephyr-xtensa-nxp-rt700-hifi1-sdk/) | `xtensa-nxp_rt700_hifi1_zephyr-elf` |
| [`zephyr-xtensa-nxp-rt700-hifi4-sdk`](zephyr-xtensa-nxp-rt700-hifi4-sdk/) | `xtensa-nxp_rt700_hifi4_zephyr-elf` |
| [`zephyr-xtensa-sample-controller-sdk`](zephyr-xtensa-sample-controller-sdk/) | `xtensa-sample_controller_zephyr-elf` |
| [`zephyr-xtensa-sample-controller32-sdk`](zephyr-xtensa-sample-controller32-sdk/) | `xtensa-sample_controller32_zephyr-elf` |

---

## Versioning and branches

All SDKs in this repo track the same upstream `sdk-ng` release, so they share a
single set of **version branches**:

- `main` — development branch. `sdkcraft.yaml` versions here are placeholders.
- `0.17.*`, `1.0.*`, … — one branch per released `sdk-ng` line (for example
  `0.17.4`, `1.0.1`). The `sdkcraft.yaml` (or `VERSION`) files on these branches
  pin the exact `sdk-ng` version that every toolchain is built from.

Renovate opens a single, grouped pull request per version branch that bumps
**every** SDK to the matching `sdk-ng` release (see below). Merging that PR into
a version branch triggers a build-and-upload of every SDK.

---

## Continuous integration

The workflows in [`.github/workflows`](.github/workflows) discover the SDK
directories dynamically, so **adding or removing a toolchain requires no
workflow changes** — the `zephyr-sdk` base SDK is the only directory excluded.

- [`build.yml`](.github/workflows/build.yml) — on a pull request against a
  version branch, discovers the SDK directories that changed and runs
  `sdkcraft pack` (plus `sdkcraft test`) for each of them as a build matrix.
  Shared changes (CI or `renovate.json`) rebuild every SDK.
- [`upload.yml`](.github/workflows/upload.yml) — on a push to a version branch
  (or a manual `workflow_dispatch`), builds and uploads **every** SDK. It fans
  out over the directories and calls the shared
  [`canonical/sdkcraft-actions`](https://github.com/canonical/sdkcraft-actions)
  `upload.yml` reusable workflow with a per-directory `subdirectory` input,
  releasing each SDK to the `<branch>/stable` store track.
- [`renovate.yml`](.github/workflows/renovate.yml) /
  [`renovate-check.yml`](.github/workflows/renovate-check.yml) — run Renovate
  and validate the root `renovate.json`.

---

## Dependency updates (Renovate)

A single [`renovate.json`](renovate.json) at the repository root governs the
whole monorepo. Its custom managers scan **every** subdirectory:

- the inline `version: "…"` field of each `sdkcraft.yaml`, and
- any `VERSION` file (for SDKs not yet migrated to an inline version),

resolving each against `zephyrproject-rtos/sdk-ng` GitHub releases. Updates are
grouped into one pull request per version branch, and `packageRules` constrain
each base branch to its release line (`0.17.*` → `^0.17.`, `1.0.*` → `^1.0.`).
The base `zephyr-sdk` directory is excluded via `ignorePaths`.

---

## Adding a new toolchain SDK

1. Create a new `zephyr-<target>-sdk/` directory containing a `sdkcraft.yaml`
   (with an inline `version:` field), a `README.md`, and a `tests/` directory.
2. Point the toolchain part at the matching `sdk-ng` release asset, for example:

   ```yaml
   parts:
     toolchain:
       plugin: dump
       source: https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v$CRAFT_PROJECT_VERSION/toolchain_linux-x86_64_<target>.tar.xz
       source-type: tar
   ```

3. That's it — CI and Renovate pick the directory up automatically on the next
   run. No workflow or `renovate.json` edits are required.

---

## Reference workshop

A minimal workshop that connects the base SDK, the SDK NG bundle, and the `arm`
toolchain from this repo:

```yaml
# workshop.yaml
name: zephyr-firmware
base: ubuntu@24.04
sdks:
  - name: uv
    channel: latest/stable
  - name: zephyr
    channel: 4.4/stable
  - name: zephyr-sdk-ng
    channel: 1.0.1/stable
  - name: zephyr-arm
    channel: 1.0.1/stable
connections:
  - plug: zephyr:sdk-ng
    slot: zephyr-sdk-ng:sdk-ng
  - plug: zephyr-sdk-ng:arm
    slot: zephyr-arm:toolchain
  - plug: zephyr:venv
    slot: uv:venv
```

See each SDK's own `README.md` for target-specific details and the
[base Zephyr SDK README](https://github.com/canonical/zephyr-sdk) for the full
firmware build workflow.

---

## Documentation and guidance

- [Zephyr official documentation](https://docs.zephyrproject.org/latest/)
- [Workshop documentation](https://ubuntu.com/workshop/docs/)

---

## Community and support

- Zephyr community: [Zephyr GitHub](https://github.com/zephyrproject-rtos/zephyr)
- Zephyr community forum: [Zephyr Discord](https://chat.zephyrproject.org/)
- Workshop forum: [Discourse](https://discourse.ubuntu.com/)
- Please review our
  [Code of Conduct](https://ubuntu.com/community/ethos/code-of-conduct) before
  participating.

---

## Contributions

All contributions, including code, documentation updates, and issue reports,
are welcome!

- See each SDK's `CONTRIBUTING.md` for guidelines.
- Open issues or pull requests on the official repository.

---

## License and copyright

Copyright 2025 Canonical Ltd.

The Zephyr RTOS and the Zephyr SDK toolchains are licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
