Return-Path: <linux-pci+bounces-17779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D435F9E5852
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 15:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8AB165730
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FFE22258B;
	Thu,  5 Dec 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8zP1UI7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F421A431;
	Thu,  5 Dec 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408210; cv=none; b=f9/Gzu3uSv6y6YpvXB3HmeS0YvLK978yj8IWLgeeFyo7/eGxFP3YQJ4wfWCREKZD+oKYgWCgMW2yf1aww5WvnJqLH3qFazFoz84IcCXBJT7/LY6OpLmaIaYbkUTC8tXeTXHRwiHWvlPxIA50kTiXPG1znHaQQtgBobYMEPxMvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408210; c=relaxed/simple;
	bh=9lJ7gKW/axA9Y9tGKn4BNE3/DgwHFkjbttlWcj6o/JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCz8dZsVsAQl8d4rIoEFHrl2jQFX5rlkBeHQev0a8/XgCbJU3GocexU71BwBWoR1LI+Dg5bBDG+13O+SqF+ZW6KkKiDyz3UPhMkqUxo3G/CwPmm89NgXHR5fBAo0lEse7vHCmiYx+AjzktArwUrwU+qWe2YidG0PpBrC0NnoPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8zP1UI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7BBC4CED1;
	Thu,  5 Dec 2024 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733408209;
	bh=9lJ7gKW/axA9Y9tGKn4BNE3/DgwHFkjbttlWcj6o/JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8zP1UI7LMSD0Zyyyfzp0qgqJ6LG4W1uZwq9vbq4dYzLp3yQilAtTzqYtPfq8j40z
	 466bev1Y+I2phOQDReZhu/cWEZaO8hqwRN74pfVyradmE5pXR/5l0yb6uzpX/MSZdz
	 Qiwla0waO06FFYSC+lT/w+WImRt6EkVxeFRYLcFjFw+IaarpXxcE5Po9T1RKEIQKuK
	 16Fg0c4PJcd3hUppnSdWMsiTRyCvgrERTAH0qe/sE+w4ljIz3inQunQJfbmCT+Pqh7
	 PRQiTaumrFYa0ZytOVaBg1PUUW6h2Qjz1YoHDxf3S8wYMS8j+TirTgtzRsAwtAJTX2
	 dAETWoqecXj1g==
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
Subject: [PATCH v4 10/13] samples: rust: add Rust PCI sample driver
Date: Thu,  5 Dec 2024 15:14:41 +0100
Message-ID: <20241205141533.111830-11-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205141533.111830-1-dakr@kernel.org>
References: <20241205141533.111830-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit adds a sample Rust PCI driver for QEMU's "pci-testdev"
device. To enable this device QEMU has to be called with
`-device pci-testdev`.

The same driver shows how to use the PCI device / driver abstractions,
as well as how to request and map PCI BARs, including a short sequence of
MMIO operations.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                     |   1 +
 samples/rust/Kconfig            |  11 ++++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_pci.rs | 109 ++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 samples/rust/rust_driver_pci.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 041b0c1b476f..f97052d5f454 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18100,6 +18100,7 @@ F:	include/linux/of_pci.h
 F:	include/linux/pci*
 F:	include/uapi/linux/pci*
 F:	rust/kernel/pci.rs
+F:	samples/rust/rust_driver_pci.rs
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..6d468193cdd8 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -30,6 +30,17 @@ config SAMPLE_RUST_PRINT
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_PCI
+	tristate "PCI Driver"
+	depends on PCI
+	help
+	  This option builds the Rust PCI driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called driver_pci.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index c1a5c1655395..2f5b6bdb2fa5 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -3,6 +3,7 @@ ccflags-y += -I$(src)				# needed for trace events
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
new file mode 100644
index 000000000000..76d742189c00
--- /dev/null
+++ b/samples/rust/rust_driver_pci.rs
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust PCI driver sample (based on QEMU's `pci-testdev`).
+//!
+//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
+
+use kernel::{bindings, c_str, devres::Devres, pci, prelude::*};
+
+struct Regs;
+
+impl Regs {
+    const TEST: usize = 0x0;
+    const OFFSET: usize = 0x4;
+    const DATA: usize = 0x8;
+    const COUNT: usize = 0xC;
+    const END: usize = 0x10;
+}
+
+type Bar0 = pci::Bar<{ Regs::END }>;
+
+#[derive(Debug)]
+struct TestIndex(u8);
+
+impl TestIndex {
+    const NO_EVENTFD: Self = Self(0);
+}
+
+struct SampleDriver {
+    pdev: pci::Device,
+    bar: Devres<Bar0>,
+}
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    MODULE_PCI_TABLE,
+    <SampleDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::new(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        TestIndex::NO_EVENTFD
+    )]
+);
+
+impl SampleDriver {
+    fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
+        // Select the test.
+        bar.writeb(index.0, Regs::TEST);
+
+        let offset = u32::from_le(bar.readl(Regs::OFFSET)) as usize;
+        let data = bar.readb(Regs::DATA);
+
+        // Write `data` to `offset` to increase `count` by one.
+        //
+        // Note that we need `try_writeb`, since `offset` can't be checked at compile-time.
+        bar.try_writeb(data, offset)?;
+
+        Ok(bar.readl(Regs::COUNT))
+    }
+}
+
+impl pci::Driver for SampleDriver {
+    type IdInfo = TestIndex;
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe(
+        pdev: &mut pci::Device,
+        _id: &pci::DeviceId,
+        info: &Self::IdInfo,
+    ) -> Result<Pin<KBox<Self>>> {
+        dev_dbg!(pdev.as_ref(), "Probe Rust PCI driver sample.\n");
+
+        pdev.enable_device_mem()?;
+        pdev.set_master();
+
+        let bar = pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci"))?;
+
+        let drvdata = KBox::new(
+            Self {
+                pdev: pdev.clone(),
+                bar,
+            },
+            GFP_KERNEL,
+        )?;
+
+        let bar = drvdata.bar.try_access().ok_or(ENXIO)?;
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev data-match count: {}\n",
+            Self::testdev(info, &bar)?
+        );
+
+        Ok(drvdata.into())
+    }
+}
+
+impl Drop for SampleDriver {
+    fn drop(&mut self) {
+        dev_dbg!(self.pdev.as_ref(), "Remove Rust PCI driver sample.\n");
+    }
+}
+
+kernel::module_pci_driver! {
+    type: SampleDriver,
+    name: "rust_driver_pci",
+    author: "Danilo Krummrich",
+    description: "Rust PCI driver",
+    license: "GPL v2",
+}
-- 
2.47.0


