Return-Path: <linux-pci+bounces-15060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480609AB89F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1271F225B4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE291E130F;
	Tue, 22 Oct 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAOmv1eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40161CDA12;
	Tue, 22 Oct 2024 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632825; cv=none; b=P7hcIVr0a4uShNTDrQeE0ZXkUzeASbobHsllhElgW+Qoxs56DDPzG5uYTjtacZJb8JLCwYD5Y+VefnT2Qqhe72nMvBeZ843qvcFMFuNsTMVA0CWoRkb683muLMsawyG5ijv9QE5P14BUVcCG0GqAOMlIneJrtU5ejZd6L+cw4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632825; c=relaxed/simple;
	bh=6138rNionixW1Bs1ip5f6yRQ69Wk/93MH3AWM5T2VKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzDarVhqE/kthxsQsFby6AtDFjQT5fNx9xBu8AAOEsA6inUut7lOvmwC7CK/CRhu0Ed5rN66K+sZzb0ON2grolohbtclFRb6YXrpmZfLGNXcVAybVoneJclAMv4iv6QDgQ0xM9UsamdZEQlU23I5GKgIpPQPIVHu/Rvl8YuTIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAOmv1eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5819FC4CEC3;
	Tue, 22 Oct 2024 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632824;
	bh=6138rNionixW1Bs1ip5f6yRQ69Wk/93MH3AWM5T2VKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAOmv1egUC1nf60pQO1WFALvzxr4r5BPVf8FpkOCM/iKR/qMEz5Fo/5nJpt9+xpwQ
	 5fBMECh+3nNb/f94WZ4dhFtdnaoXgMoqv2HvN2IdJMnH5vNW0SmWJFkwe7KJyAZEKC
	 rtb4DUDccq/EJouKlsyvW8ucN/w/1x2pJmhF5xFkaMKXVhLpTx+UVi5t0YOCCbGjnW
	 HjhAscHr6Gy+IwmxkMyqqjNuproDY73O8TzYBVPueY8re8UJPhp+CfFArpusFLVCJZ
	 DBzjuCINEz98xMl2XigbybLYa69o8efX+Sy1hQ/WY/It69ocxM1R+VWlWSFJQzJEXX
	 7MacxbvO9i9TA==
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
Subject: [PATCH v3 13/16] samples: rust: add Rust PCI sample driver
Date: Tue, 22 Oct 2024 23:31:50 +0200
Message-ID: <20241022213221.2383-14-dakr@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
index 2d00d3845b4a..d9c512a3e72b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17940,6 +17940,7 @@ F:	include/linux/of_pci.h
 F:	include/linux/pci*
 F:	include/uapi/linux/pci*
 F:	rust/kernel/pci.rs
+F:	samples/rust/rust_driver_pci.rs
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
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
index 03086dabbea4..b66767f4a62a 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -2,5 +2,6 @@
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
new file mode 100644
index 000000000000..d24dc1fde9e8
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
+        Ok(u32::from_le(bar.readl(Regs::COUNT)))
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
2.46.2


