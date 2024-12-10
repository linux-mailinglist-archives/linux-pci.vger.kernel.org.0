Return-Path: <linux-pci+bounces-18060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5899EBE1B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FFC1889262
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82081F1918;
	Tue, 10 Dec 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDP15mUn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2D2451F1;
	Tue, 10 Dec 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870999; cv=none; b=NZx188Nj68jw+KnKcc2QERk7gpEVPjobAQYTh4Z8UIvp3T0TrQPTAA3lcLBpi5jl6ZSPgXfi/2aJ1YYIiEEd7zsptwLfiTi2s6eE+hFq/5XuQa1xa3iM82BLY3bwVmg0XTSvC5De7OtjvNLdNzMUPyMVX15FDYsq+YS9xdXboQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870999; c=relaxed/simple;
	bh=nIX0y56zebp5jRN+x8BWK2GgNagZtANp3+unoN6zImg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7mZSNnIaIOb1Kv871DSu4h0aL60P73eEIk6UlJDwZ6nLL31lp8p4Si2lAeBohxuiFxbl6ohCcVWDDPJrVZOvn06zailXuX2CHLQBLfZEHQJwqLwY8tSCiNK5HsJTCjBFAL4TX5yDeAxF4RGy+NjGUpZcRA4llM52FHAmQVrfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDP15mUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B00C4CED6;
	Tue, 10 Dec 2024 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733870999;
	bh=nIX0y56zebp5jRN+x8BWK2GgNagZtANp3+unoN6zImg=;
	h=From:To:Cc:Subject:Date:From;
	b=hDP15mUn+GsPm2rB3K8e6LPoAGBkLM3HD3ZbtGQbL8UlZFEI3GouMjtf7HCL5FSh2
	 jT8+frwz5Lj3SOd+tvB1SNeaoI+gzIUO5VhAZmrIwmwGsZqoMw+1NoVWH3D0TndT8Y
	 e0uXRaYRGU0gkQLkBEdE19+jSYtDmkfF5xGTng0GF0z8nz2IocKDf2P0tEQntIl2D9
	 OsdeukZaptq8cPzXb286YqN+235VIKUsjJ1JcKd7sK+52e64G2Jfcwv1OBqrgUuJ00
	 Evl7a2oaCN0m/+0Z4EGGS9A75mjzm8UMan5A2VUm2hGUVlFGsY2+4cSzqmwNZ7LEvz
	 LJ+v1vBgT7V0w==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com,
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 00/16] Device / Driver PCI / Platform Rust abstractions
Date: Tue, 10 Dec 2024 23:46:27 +0100
Message-ID: <20241210224947.23804-1-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements the necessary Rust abstractions to implement
device drivers in Rust.

This includes some basic generalizations for driver registration, handling of ID
tables, MMIO operations and device resource handling.

Those generalizations are used to implement device driver support for two
busses, the PCI and platform bus (with OF IDs) in order to provide some evidence
that the generalizations work as intended.

The patch series also includes two patches adding two driver samples, one PCI
driver and one platform driver.

The PCI bits are motivated by the Nova driver project [1], but are used by at
least one more OOT driver (rnvme [2]).

The platform bits, besides adding some more evidence to the base abstractions,
are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].

The patches of this series can also be [7], [8] and [9].

Changes in v5:
==============
- Opaque:
  - add `Opaque::pin_init`

- Revocable:
  - use const generic instead of bool in `revoke_internal`
  - don't open code things with `Opaque::try_ffi_init`, use
    `Opaque::pin_init` instead

- Driver:
  - fix `DriverOps` -> `RegistrationOps` in commit message
  - fix signature of `register` and `unregister` to take an
    `Opaque<T::RegType>` instead of a mutable reference
  - implement generic `driver::Adapter`

- ID table:
  - fix `module_device_table!` macro, according to commit 054a9cd395a7
   (modpost: rename alias symbol for MODULE_DEVICE_TABLE())

- PCI:
  - remove `pci::DeviceId` argument from probe()
  - provide `vendor_id` and `device_id` accessor functions
  - use `addr_of_mut!` for the device in probe()

- OF:
  - move OF `IdTable` type alias from platform.rs to of.rs

- Platform:
  - use `addr_of_mut!` for the device in probe()
  - move generic OF code to `driver::Adapter`

- MISC:
  - rebase onto latest rust-next (-rc2)

Changes in v4:
==============
- Revocable
  - convert `Revocable::data` to `Opaque`
  - introduce `revoke_nosync`, which does not wait for an RCU grace period
  - fix minor typo

- Device ID
  - fix ID table export name to always be unique
  - remove `#![allow(stable_features)]`
  - move `#![allow(const_refs_to_cell)]` to the "stable in 1.83" list

- I/O
  - split `Io<SIZE>` in `IoRaw<SIZE>` and `Io<SIZE>`
  - add rust helper for ioremap() and iounmap() (needed by doctests)

- Devres
  - optimze `drop` by using `revoke_nosync` (we're guaranteed there are no more
    concurrent users, hence no need to wait for a full grace period)

- OF
  - rename "Open Firmware" -> "Device Tree / Open Firmware" (Rob)
  - remove unused C header reference
  - add TODO comment to loop in `DeviceId::new`
  - remove `DeviceId::compatible`; was only used in sample code
  - add missing `#[repr(transparent)]`
  - use #[cfg(CONFIG_OF)] for the relevant functions

- PCI
  - let Rust helper for pci_resource_len() return resource_size_t

- PCI Sample
  - remove unnecessary `from_le`

- Platform
  - fix example compatible string
  - add example for `platform::Driver`
  - rename `ID_TABLE` to `OF_ID_TABLE`
  - don't allow public use of `of_match_table`; convert to `of_id_info` to
    retrieve the `of::DeviceId` to gather the corresponding `IdInfo`
  - remove wrong example reference in the documentation of `platform::Driver`
  - remove `as_dev`, as we already implement `AsRef` for `platform::Device`

- Platform Sample
  - fix compatible string; add corresponding entry to drivers/of/unittest-data/tests-platform.dtsi
  - remove usage of `of_match_table`

- MISC
  - fix a few spelling mistakes
  - rebase onto rust-next (v6.13-rc1)

Changes in v3:
==============
- add commits for `Opaque::try_ffi_init` and `InPlaceModule`
- rename `DriverOps` to `RegistrationOps`
- rework device ID abstractions to get rid of almost all macro magic (thanks to
  Gary Guo for working this out!)
  - this is possible due to recently stabilized language features
- add modpost alias generation for device ID tables
  - unfortunately, this is the part that still requires some macro magic in the
    device ID abstractions
- PCI
  - represent the driver private data with the driver specific `Driver` instance
    and bind it's lifetime to the time of the driver being bound to a device
    - this allows us to handle class / subsystem registrations in a cleaner way
  - get rid of `Driver::remove`
    - Rust drivers should bind cleanup code to the `Drop` implementation of the
      corresponding structure instead and put it into their driver structure for
      automatic cleanup
  - add a sample PCI driver
- add abstractions for `struct of_device_id`
- add abstractions for the platform bus, including a sample driver
- update the MAINTAINERS file accordingly
  - currently this turns out a bit messy, but it should become better once the
    build system supports a treewide distribution of the kernel crate
  - I didn't add myself as maintainer, but (if requested) I'm willing to do so
    and help with maintenance

Changes in v2:
==============
- statically initialize driver structures (Greg)
- move base device ID abstractions to a separate source file (Greg)
- remove `DeviceRemoval` trait in favor of using a `Devres` callback to
  unregister drivers
- remove `device::Data`, we don't need this abstraction anymore now that we
  `Devres` to revoke resources and registrations
- pass the module name to `Module::init` and `InPlaceModule::init` in a separate
  patch
- rework of `Io` including compile time boundary checks (Miguel, Wedson)
- adjust PCI abstractions accordingly and implement a `module_pci_driver!` macro
- rework `pci::Bar` to support a const SIZE
- increase the total amount of Documentation, rephrase some safety comments and
  commit messages for less ambiguity
- fix compilation issues with some documentation examples

[1] https://gitlab.freedesktop.org/drm/nova/-/tree/nova-next
[2] https://github.com/metaspace/linux/tree/rnvme
[3] https://lore.kernel.org/all/20240930233257.1189730-1-lyude@redhat.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git/log/?h=rust/cpufreq-dt
[5] https://github.com/AsahiLinux/linux
[6] https://github.com/Fabo/linux/tree/fparent/rust-i2c
[7] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device
[8] https://github.com/Rust-for-Linux/linux/tree/staging/rust-pci
[9] https://github.com/Rust-for-Linux/linux/tree/staging/dev

Danilo Krummrich (14):
  rust: pass module name to `Module::init`
  rust: implement generic driver registration
  rust: implement `IdArray`, `IdTable` and `RawDeviceId`
  rust: types: add `Opaque::pin_init`
  rust: add `io::{Io, IoRaw}` base types
  rust: add devres abstraction
  rust: pci: add basic PCI device / driver abstractions
  rust: pci: implement I/O mappable `pci::Bar`
  samples: rust: add Rust PCI sample driver
  rust: of: add `of::DeviceId` abstraction
  rust: driver: implement `Adapter`
  rust: platform: add basic platform device / driver abstractions
  samples: rust: add Rust platform sample driver
  MAINTAINERS: add Danilo to DRIVER CORE

Wedson Almeida Filho (2):
  rust: add rcu abstraction
  rust: add `Revocable` type

 MAINTAINERS                                  |   9 +
 drivers/block/rnull.rs                       |   2 +-
 drivers/of/unittest-data/tests-platform.dtsi |   5 +
 rust/bindings/bindings_helper.h              |   3 +
 rust/helpers/device.c                        |  10 +
 rust/helpers/helpers.c                       |   5 +
 rust/helpers/io.c                            | 101 +++++
 rust/helpers/pci.c                           |  18 +
 rust/helpers/platform.c                      |  13 +
 rust/helpers/rcu.c                           |  13 +
 rust/kernel/device_id.rs                     | 165 +++++++
 rust/kernel/devres.rs                        | 179 ++++++++
 rust/kernel/driver.rs                        | 173 ++++++++
 rust/kernel/io.rs                            | 260 +++++++++++
 rust/kernel/lib.rs                           |  28 +-
 rust/kernel/net/phy.rs                       |   2 +-
 rust/kernel/of.rs                            |  60 +++
 rust/kernel/pci.rs                           | 438 +++++++++++++++++++
 rust/kernel/platform.rs                      | 193 ++++++++
 rust/kernel/revocable.rs                     | 223 ++++++++++
 rust/kernel/sync.rs                          |   1 +
 rust/kernel/sync/lock/global.rs              |   6 +-
 rust/kernel/sync/rcu.rs                      |  47 ++
 rust/kernel/types.rs                         |  11 +
 rust/macros/lib.rs                           |   6 +-
 rust/macros/module.rs                        |   7 +-
 samples/rust/Kconfig                         |  21 +
 samples/rust/Makefile                        |   2 +
 samples/rust/rust_driver_pci.rs              | 110 +++++
 samples/rust/rust_driver_platform.rs         |  49 +++
 samples/rust/rust_minimal.rs                 |   2 +-
 samples/rust/rust_print_main.rs              |   2 +-
 32 files changed, 2150 insertions(+), 14 deletions(-)
 create mode 100644 rust/helpers/device.c
 create mode 100644 rust/helpers/io.c
 create mode 100644 rust/helpers/pci.c
 create mode 100644 rust/helpers/platform.c
 create mode 100644 rust/helpers/rcu.c
 create mode 100644 rust/kernel/device_id.rs
 create mode 100644 rust/kernel/devres.rs
 create mode 100644 rust/kernel/driver.rs
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/of.rs
 create mode 100644 rust/kernel/pci.rs
 create mode 100644 rust/kernel/platform.rs
 create mode 100644 rust/kernel/revocable.rs
 create mode 100644 rust/kernel/sync/rcu.rs
 create mode 100644 samples/rust/rust_driver_pci.rs
 create mode 100644 samples/rust/rust_driver_platform.rs


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.47.0


