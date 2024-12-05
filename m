Return-Path: <linux-pci+bounces-17769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 768EC9E582E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 15:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3147B281EC1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F6218851;
	Thu,  5 Dec 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cChdmXGd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6217579;
	Thu,  5 Dec 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408147; cv=none; b=KtFK2WeDh1p8jS82G4sc+xBRFBqYx12Kjlt+GcWd8K7PzxriOM8pRkKoVDeyMxvfYKbByqSWToeJqCUdgXFyHZNvoCQwrddtnH6bWwdjLwOnc3JqjeAfgGoCyf0O9LfgoV8cJT6fZfr1BIU0RoVXGtgQwUy2qxVkWiz3sld3yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408147; c=relaxed/simple;
	bh=Dy0AOKEaGvg0o4zSFV8ZoWLPf9s5L2YbkQ6bOHtUYfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MA9EbUCFewDVzK8u9CGKrsaQru/qvhtbB9yUa4e0wk7WNF0Y1bYaBSu+jHpuVoCnV1tHMQts3Oswv//d/C6u7ltIaiD3ujn8Ih+z1KuPl2nrfYzSCm9BRQYLOku298Yr2jveamjqNhB1wvT8H4Xo8V7mwoRG0RcwFvLrd4p3wYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cChdmXGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4294BC4CED1;
	Thu,  5 Dec 2024 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733408147;
	bh=Dy0AOKEaGvg0o4zSFV8ZoWLPf9s5L2YbkQ6bOHtUYfs=;
	h=From:To:Cc:Subject:Date:From;
	b=cChdmXGd/E4euD4cGLuKgifiYGyiJ98HpjRMbH/6EYL2sgYUhB93C/2UDMWpQdDbO
	 0Xy2SM+AtKHCCYwVIkpZOv7ojF1Y5ltMz4Yn7zmgrbVA15w5OY2JpwVst2TnuUEDB2
	 xPXv+IhELnlHmSSAjxfl+H3o/4UieCb4K4266EkSRng++LSbnGzWoGuTbvvb/LTmVs
	 fTurUYoRfdXPw1j8oTGdZAvWvndslqOZXdETctNk7ILA7fUKkbIVB/eg2UgKGgIrzp
	 EgB4NvJlGBM4NPxNXWmiXAQrGSjB7C0nwEy1f42qM5mS/Ci8A8GHaLK+sdcnuNsSxn
	 lFm1LZORdn/Og==
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
Subject: [PATCH v4 00/13] Device / Driver PCI / Platform Rust abstractions
Date: Thu,  5 Dec 2024 15:14:31 +0100
Message-ID: <20241205141533.111830-1-dakr@kernel.org>
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


Danilo Krummrich (11):
  rust: pass module name to `Module::init`
  rust: implement generic driver registration
  rust: implement `IdArray`, `IdTable` and `RawDeviceId`
  rust: add `io::{Io, IoRaw}` base types
  rust: add devres abstraction
  rust: pci: add basic PCI device / driver abstractions
  rust: pci: implement I/O mappable `pci::Bar`
  samples: rust: add Rust PCI sample driver
  rust: of: add `of::DeviceId` abstraction
  rust: platform: add basic platform device / driver abstractions
  samples: rust: add Rust platform sample driver

Wedson Almeida Filho (2):
  rust: add rcu abstraction
  rust: add `Revocable` type

 MAINTAINERS                                  |   8 +
 drivers/block/rnull.rs                       |   2 +-
 drivers/of/unittest-data/tests-platform.dtsi |   5 +
 rust/bindings/bindings_helper.h              |   3 +
 rust/helpers/device.c                        |  10 +
 rust/helpers/helpers.c                       |   5 +
 rust/helpers/io.c                            | 101 +++++
 rust/helpers/pci.c                           |  18 +
 rust/helpers/platform.c                      |  13 +
 rust/helpers/rcu.c                           |  13 +
 rust/kernel/device_id.rs                     | 166 +++++++
 rust/kernel/devres.rs                        | 179 ++++++++
 rust/kernel/driver.rs                        | 120 ++++++
 rust/kernel/io.rs                            | 260 +++++++++++
 rust/kernel/lib.rs                           |  28 +-
 rust/kernel/net/phy.rs                       |   2 +-
 rust/kernel/of.rs                            |  57 +++
 rust/kernel/pci.rs                           | 429 +++++++++++++++++++
 rust/kernel/platform.rs                      | 222 ++++++++++
 rust/kernel/revocable.rs                     | 235 ++++++++++
 rust/kernel/sync.rs                          |   1 +
 rust/kernel/sync/lock/global.rs              |   6 +-
 rust/kernel/sync/rcu.rs                      |  47 ++
 rust/macros/lib.rs                           |   6 +-
 rust/macros/module.rs                        |   7 +-
 samples/rust/Kconfig                         |  21 +
 samples/rust/Makefile                        |   2 +
 samples/rust/rust_driver_pci.rs              | 109 +++++
 samples/rust/rust_driver_platform.rs         |  49 +++
 samples/rust/rust_minimal.rs                 |   2 +-
 samples/rust/rust_print_main.rs              |   2 +-
 31 files changed, 2114 insertions(+), 14 deletions(-)
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


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.47.0


