Return-Path: <linux-pci+bounces-18313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183059EF2C5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B481417B43C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C8B23FA12;
	Thu, 12 Dec 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl3bYev3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA923FA0E;
	Thu, 12 Dec 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021373; cv=none; b=iP8mgw0Yd58o/tXTPCDx8vctG+OXKdMfQESwwfA6H2jdRKGg/Leed1yemz03LjBeEeo6MoifiOe0w2JLlhd2sS+SNY3/RFTNB/MfjazrxjSIvErpVX+78dLEAPZPLObD59EKJkUOZWaWW4o7q23bdVXYnoiGaNPPQ04VfDk+nNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021373; c=relaxed/simple;
	bh=R2rt0bwhMqs5GAkrBJYAkTytJdxhLtAmmdUfnXgG1DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOlVHJ9VbH0f/LHYN1kd0nrNRfwNkZLYzbA2yBcl63SeaRRJoJXcBkhij983m3CcvqI2EVKcRahgRB5jN9l80xBH3/GdrgqGS13y91w5D9FNwuToATMeWwhwdTfXoYJZ6KxYfS8sUMnUfhooiSEUQ9AJSt1vEthsA8iSP8S8vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl3bYev3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5437C4CED3;
	Thu, 12 Dec 2024 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021372;
	bh=R2rt0bwhMqs5GAkrBJYAkTytJdxhLtAmmdUfnXgG1DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kl3bYev3G8yrJUNHEkpBxw87TrxWMpzDgh0lBlqfPQVNBoXQ2F03j8KOlAXNlafGA
	 sr9Gn048n02388+CB/0ZW46qjAUErqmW07cBbeyxyM7TLIZnKvDEvnpUmPS+KnOQrS
	 1Q3OiELl3otpHjDnhWJXUF1HVTTsmWi2dDs5Wr5yL3qZnCHWOjkFJvWgGs33xQtHd6
	 f6HW4NoLWbY65BOIqK9rwSY85hgWCRH5UAZmcGcIPUA+93vq2oktc4NdX3gD8hBBx/
	 J++QcyPstuxQsrydcCpV6QHr1Xq6AToj8nrJrKjrHFPCDzVmS6aKUkdKWUwqt13MI6
	 Lo6dXMI5yyAuQ==
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
Subject: [PATCH v6 11/16] samples: rust: add Rust PCI sample driver
Date: Thu, 12 Dec 2024 17:33:42 +0100
Message-ID: <20241212163357.35934-12-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
References: <20241212163357.35934-1-dakr@kernel.org>
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
 samples/rust/rust_driver_pci.rs | 110 ++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 samples/rust/rust_driver_pci.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index e143969265aa..b15eb7c6b23f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18103,6 +18103,7 @@ F:	include/linux/of_pci.h
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
index 000000000000..94710b245834
--- /dev/null
+++ b/samples/rust/rust_driver_pci.rs
@@ -0,0 +1,110 @@
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
+    fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        dev_dbg!(
+            pdev.as_ref(),
+            "Probe Rust PCI driver sample (PCI ID: 0x{:x}, 0x{:x}).\n",
+            pdev.vendor_id(),
+            pdev.device_id()
+        );
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
2.47.1


