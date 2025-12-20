import {
  BuildType,
  CPP_OUTPUT_DIR,
  runPackageAction,
  CMAKE_TOOLS,
  getHostSysrootPath,
  SYSROOT,
  BuildConfiguration,
  LibraryInfo,
} from "../../../../src/providers/package.provider.ts";

import { join } from "node:path";
import { argv } from "node:process";

export const info: LibraryInfo = {
  name: "glad",
  outDir: "build",
  version: "4.6.0",
};

export const build = (cwd: string = process.cwd()): BuildType => {
  const HOST_SYSROOT = getHostSysrootPath();
  const CLANG = join(HOST_SYSROOT, "bin/clang.exe").replace(/\\/g, "/");
  const CLANGXX = join(HOST_SYSROOT, "bin/clang++.exe").replace(/\\/g, "/");
  const WINDRES = join(HOST_SYSROOT, "bin/llvm-windres.exe").replace(
    /\\/g,
    "/"
  );
  const AARCH64_WINDRES = join(
    HOST_SYSROOT,
    "bin/aarch64-w64-mingw32-windres.exe"
  ).replace(/\\/g, "/");

  return {
    type: "compilation",
    windows_x86_64: {
      configStep: `uv run glad --api gl:core=4.6 --out-path ${info.outDir} c`,
      buildStep: ``,
      installStep: ``,
    },
    windows_aarch64: {
      configStep: ``,
      buildStep: ``,
      installStep: ``,
    },
    linux_x86_64: {
      configStep: ``,
      buildStep: ``,
      installStep: ``,
    },
    linux_aarch64: {
      configStep: ``,
      buildStep: ``,
      installStep: ``,
    },
  } satisfies BuildType;
};

const args = argv.slice(2);
const [action = "help"] = args;

const buildConfig: BuildConfiguration = {
  info,
  build: build(),
};

await runPackageAction(action, process.cwd(), buildConfig);
