Return-Path: <linux-pci+bounces-18302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BC9EF2BF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BC116F822
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDE42210DF;
	Thu, 12 Dec 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDdncNkb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E525216E3B;
	Thu, 12 Dec 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021292; cv=none; b=p/TiRMFPRWcLRtvd0RV8d1xVncaVEc76U1Nf96OfROmrzFG5Vfk2nfSDwzwivnoNjf6292VDzGcckx1BttBbvb8A66eZZet/Iyrbcfow9aEzciKDdsFyYTqqL37BZxTvugwR/LF1Dp659Egk3IDyyr5fY17NXNz3do2lJpB7ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021292; c=relaxed/simple;
	bh=DO2QYXMwRMXnmyGS3QWvp+O2rljVVxWwZLeT8AMk1jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqeC43m2woIY788JUuGj0bswd/sdxn/wBkP3k9VQKMzI2U9k2N7Si5SjxuW5cDaBDQyEj8A9XdXLfEVHV53M+GOtflnNb922gy70fQG+o85wuSvDuyopdbQNhcgqGQT33fJbITKGeiyZ+YbPDeS4Y3nPBi3yUAmQpoyzBa9WcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDdncNkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CC7C4CECE;
	Thu, 12 Dec 2024 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021292;
	bh=DO2QYXMwRMXnmyGS3QWvp+O2rljVVxWwZLeT8AMk1jE=;
	h=From:To:Cc:Subject:Date:From;
	b=SDdncNkbV9F/Lao+30otLxscJ/kmMRF9xGOxYOEC6UgEuN1jTjCvb29i6Hj1dGENI
	 VSPMbmob95+/6GhpNE6f3gvf2C49Qe0VLSGHtbnWaKc0Fo2+CDjuFv1yKfMFiy2SSb
	 JEPObdDMTIs/8Zxndb/0KiSKA/DSlARsX+2koXddXnaVelGYHS2rs2BiOyWn04nbu5
	 TBgeDLmn3PFrUPg4Oh3JbBS6mPNKFOUpk0oS/TXB1AAMKaSB9JYdqoHc4ahh3xQ0zw
	 P8VeJR6Hx4RuZoPTmj3Ulyo9PHOMhT1hsjUS7fxLAb8/6JjAu3pcBs1yllclmzovcG
	 PvMQolO0XctBw==
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
	chrisi.schrefl@gmail.com,
	paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	rcu@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 00/16] Device / Driver PCI / Platform Rust abstractions
Date: Thu, 12 Dec 2024 17:33:31 +0100
Message-ID: <20241212163357.35934-1-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
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

Changes in v6:
==============
- Module:
  - remove patch to pass the module name in `Module::init`
  - add a patch adding the `ModuleMetadata` trait to retreive the module name

- Driver:
  - generate module structure within `module_driver!`, such that we get a unique
    module type for which `ModuleMetadata` can be implemented to retreive the
    module name
  - let `Adapter::of_id_table` return `Option<of::IdTable<Self::IdInfo>>`

- Platform:
  - change type of `platform::Driver::OF_ID_TABLE` to `Option<of::IdTable>`

- RCU:
  - add RCU abstraction to MAINTAINERS file

- MISC:
  - pick up a couple of RBs

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
  rust: module: add trait `ModuleMetadata`
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

 MAINTAINERS                                  |  10 +
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
 rust/kernel/driver.rs                        | 174 ++++++++
 rust/kernel/io.rs                            | 260 +++++++++++
 rust/kernel/lib.rs                           |  20 +
 rust/kernel/of.rs                            |  60 +++
 rust/kernel/pci.rs                           | 438 +++++++++++++++++++
 rust/kernel/platform.rs                      | 198 +++++++++
 rust/kernel/revocable.rs                     | 223 ++++++++++
 rust/kernel/sync.rs                          |   1 +
 rust/kernel/sync/rcu.rs                      |  47 ++
 rust/kernel/types.rs                         |  11 +
 rust/macros/module.rs                        |   4 +
 samples/rust/Kconfig                         |  21 +
 samples/rust/Makefile                        |   2 +
 samples/rust/rust_driver_pci.rs              | 110 +++++
 samples/rust/rust_driver_platform.rs         |  49 +++
 26 files changed, 2140 insertions(+)
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
2.47.1


