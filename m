Return-Path: <linux-pci+bounces-15047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49E9AB86E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B84A1F239A4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D141CBEA6;
	Tue, 22 Oct 2024 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg3H2vw0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D96EEB3;
	Tue, 22 Oct 2024 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632751; cv=none; b=XyYca88mGa9JpWRWDkTMmncyDTMaATm8azYZwneWU9LsjoYzDi83VM8Rpq3cvBH2sFOD0x+8utdeh7KDgm+RZ5f9CxGagNqoiAIsNq0D9k9VI1dM96F3LYx3PzjBR/OCttK31VIUzRRV/JwMLXvcipAeGmiXRrZjvLYrOviANd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632751; c=relaxed/simple;
	bh=rOxR4WUfVjMy1NhFb39WJ/EoB4cu5XCeIn6U/5lLyMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqwqiUckADsl656MuO7yCk3yw5ZgWWGORp+pGecT8ACMVvltewHSlwEXJWwvjDn4VT1+V8bP7UBNftj1NKUWlqX42GvCKKqcDEL2ugTH5+kZg/jQ+Rxmr4Av1XxPMaf6W58To0LulZKTQDWPc75x9w/Nb3aPaxlpKRRuvT5zchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg3H2vw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB84C4CEC3;
	Tue, 22 Oct 2024 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632750;
	bh=rOxR4WUfVjMy1NhFb39WJ/EoB4cu5XCeIn6U/5lLyMI=;
	h=From:To:Cc:Subject:Date:From;
	b=jg3H2vw0NLbVsuqEuLxMRrsdKYp611hpXVbdH2QI3mI7foK8NLfDfuuqXTNxYw33O
	 FKRVd2FXIjK2VjbBwdUN785CGOB6NRvrwIZFGhZjVOsnntM1sSdBnuzZHL7sc2Uk0+
	 qShFJRcJEjjJLhy0KBkw8iPHNUqwrJr2jlIioA2n0eMIu17bI31sWX4ygsXV5yTYhz
	 id/R0SWgmK71MyITG+v4//KMhmQHkoYfgj+62DT3pCAGj80zgyTXqsziM+ckLW2sf3
	 ffIE/F4J7QDj5CD/GeBpTJls5gvAnB4Vy3+YX+hFdKxOD7344FJFSUeYitc/E9dChE
	 z2WTOy+BGr//A==
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
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 00/16] Device / Driver PCI / Platform Rust abstractions
Date: Tue, 22 Oct 2024 23:31:37 +0200
Message-ID: <20241022213221.2383-1-dakr@kernel.org>
X-Mailer: git-send-email 2.46.2
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
busses, the PCI and platfrom bus (with OF IDs) in order to provide some evidence
that the generalizations work as intended.

The patch series also includes two patches adding two driver samples, one PCI
driver and one platform driver.

The PCI bits are motivated by the Nova driver project [1], but are used by at
least one more OOT driver (rnvme [2]).

The platform bits, besides adding some more evidence to the base abstractions,
are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].

The patches of this series can also be [7], [8] and [9].

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
    and help with maintainance

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
  rust: add `io::Io` base type
  rust: add devres abstraction
  rust: pci: add basic PCI device / driver abstractions
  rust: pci: implement I/O mappable `pci::Bar`
  samples: rust: add Rust PCI sample driver
  rust: of: add `of::DeviceId` abstraction
  rust: platform: add basic platform device / driver abstractions
  samples: rust: add Rust platform sample driver

Wedson Almeida Filho (5):
  rust: init: introduce `Opaque::try_ffi_init`
  rust: introduce `InPlaceModule`
  rust: add rcu abstraction
  rust: add `Revocable` type
  rust: add `dev_*` print macros.

 MAINTAINERS                          |   8 +
 drivers/block/rnull.rs               |   2 +-
 rust/bindings/bindings_helper.h      |   3 +
 rust/helpers/device.c                |  10 +
 rust/helpers/helpers.c               |   5 +
 rust/helpers/io.c                    |  91 ++++++
 rust/helpers/pci.c                   |  18 ++
 rust/helpers/platform.c              |  13 +
 rust/helpers/rcu.c                   |  13 +
 rust/kernel/device.rs                | 319 +++++++++++++++++++-
 rust/kernel/device_id.rs             | 162 ++++++++++
 rust/kernel/devres.rs                | 180 +++++++++++
 rust/kernel/driver.rs                | 120 ++++++++
 rust/kernel/io.rs                    | 234 +++++++++++++++
 rust/kernel/lib.rs                   |  46 ++-
 rust/kernel/net/phy.rs               |   2 +-
 rust/kernel/of.rs                    |  63 ++++
 rust/kernel/pci.rs                   | 429 +++++++++++++++++++++++++++
 rust/kernel/platform.rs              | 217 ++++++++++++++
 rust/kernel/prelude.rs               |   2 +
 rust/kernel/revocable.rs             | 211 +++++++++++++
 rust/kernel/sync.rs                  |   1 +
 rust/kernel/sync/rcu.rs              |  52 ++++
 rust/kernel/types.rs                 |  20 +-
 rust/macros/module.rs                |  30 +-
 samples/rust/Kconfig                 |  21 ++
 samples/rust/Makefile                |   2 +
 samples/rust/rust_driver_pci.rs      | 109 +++++++
 samples/rust/rust_driver_platform.rs |  62 ++++
 samples/rust/rust_minimal.rs         |   2 +-
 samples/rust/rust_print.rs           |   2 +-
 31 files changed, 2421 insertions(+), 28 deletions(-)
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


base-commit: 15541c9263ce34ff95a06bc68f45d9bc5c990bcd
-- 
2.46.2


