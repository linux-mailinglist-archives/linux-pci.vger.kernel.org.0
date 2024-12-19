Return-Path: <linux-pci+bounces-18800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00009F8134
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E116F40D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC21AB508;
	Thu, 19 Dec 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPT8E4Ww"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088619DF99;
	Thu, 19 Dec 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627949; cv=none; b=pfcJx/+YYLYwLOjRAn5K8j5R6YIFl03vKHR3oFYTZQihFZK9e8/8M2xeFijPaKVrr+vcAglTcJk4txxkHxszGVs+EfQn7LEUt2dln70gcK1Nu4e1DsBIEZJG8Erb5UyrcXEAMoknG4qTXU0fAwnjOjgxIPfmnjstt3pMKRDYS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627949; c=relaxed/simple;
	bh=LOb7MWk5UPFsG83IoGsAWBYQsT9Xp6ochHITt+Io330=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwQutOYI5oH05sG7F7M1gjVJMlYyL5Rkah9gQicCRHF0Z5dXPkyEvoVDcYeMMHa3QhfHy50u9asyNS4tVSptEh89kx8VqatAW7ugvSSRAi6jwYA1CkjzUEL3bpD9NvcNpP7/UxBItRU1fqv+uRS2fCvoNmp31mXy1giJyElc6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPT8E4Ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA0DC4CED6;
	Thu, 19 Dec 2024 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627949;
	bh=LOb7MWk5UPFsG83IoGsAWBYQsT9Xp6ochHITt+Io330=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPT8E4WwF9q+9W77+jyuQL0RsAvhq6Doz4K0jeCJjuJsZu0kD6Fl4MmDA8JbHcZA2
	 q0OtDKQyv+bvqRQT6J98yus22BhAkI6fGpKiSh/tlOLQfP8vs1yu7/B/ILg8uJBjEE
	 5GYWnmVqr6oyjUukKgdCHvetWbP8hoszpEYfFyUr2Lm+RzoMnqlatfPQwCEMMFY8S4
	 dSIgVPFdMlexZ4dadYiLJ1qs1kk/RS73+m5ZD/1Y3S9+cMHJl2lqPqdsooaGvYhzKX
	 XIlCNkU5NW+ssZisOlTcDPTwrW3z55nzQQJUBF1PBND1qHTZiKkRxm5oGsjdefmcaB
	 XIaNJYXBwb0QA==
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
Subject: [PATCH v7 11/16] samples: rust: add Rust PCI sample driver
Date: Thu, 19 Dec 2024 18:04:13 +0100
Message-ID: <20241219170425.12036-12-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219170425.12036-1-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
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
index 38d53b2f12d6..7cfcd5c6c8bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18105,6 +18105,7 @@ F:	include/linux/of_pci.h
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
index 000000000000..1fb6e44f3395
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
+        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
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


