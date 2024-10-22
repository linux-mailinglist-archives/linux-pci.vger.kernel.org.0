Return-Path: <linux-pci+bounces-15063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622769AB8AE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23850284B53
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5400D1E8835;
	Tue, 22 Oct 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpaIAuxQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274611E8825;
	Tue, 22 Oct 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632841; cv=none; b=Q7/zJk66p/fSPwVDKhkrdh79De549eyl7W32b6mcM4BWyJrGJ6X75MEeb5FTu1U8/wjie+9h6w4W3t5JunEw3lb8Wiw44s2WlQVYSTNCl6yE88N/sHVzcjZLf5Dhin34NHfoXGwmT43n/+Q/Su2FVrHfy8eC/gSouMqouNou+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632841; c=relaxed/simple;
	bh=Z6xEblxHrjFI+8uux18RRvZlXbj60UUK+yfXOOiMVQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjoCli3P5NFF/tD0WMkRP7C8pPcex3GrUlj9Kr4xpsbIQrLVgUZ29GhwzBLIx/gHf/fO9WUwJO18RCSAYpeqfN9rFzjHBao0c7vzT9seiivBO4iE03ZrmNia7rNX80kgq6HKWO8Dxsaq5rWrNpOJh/ZikjX0FpybVfOkxOLJKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpaIAuxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C14C4CEC7;
	Tue, 22 Oct 2024 21:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632841;
	bh=Z6xEblxHrjFI+8uux18RRvZlXbj60UUK+yfXOOiMVQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpaIAuxQ7IdPOSXxPbqHTL5sFE/BHMRpR/0dprfssGCmrg1mxjRSxo6zvSL08LYE9
	 w7A4lJpoX2VF0dDE7TjEtg6txPXHQYjSkPUbghsDh+d3MSv/NNkgPjlDOM69CqLXo0
	 2NMqa7otl3U7N2PrarXUx4AH7RTyNdpWT8t41VEi164cb1pSFVmpjbMIuDVZJCLvZ8
	 3oZzYfl0kR4Pxwr/MLMBdcA8DWH8gc/ffNziOAX2xLMzCqhBKDPQWezuWExAyQDdBK
	 4SMMYZ6tSHbwoUy5DRqG+P7rvSCdVAS5itYom0/JKOOEpqnBpfKu84Ga9yNwM1CMqd
	 5YAA59SLqapzg==
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
Subject: [PATCH v3 16/16] samples: rust: add Rust platform sample driver
Date: Tue, 22 Oct 2024 23:31:53 +0200
Message-ID: <20241022213221.2383-17-dakr@kernel.org>
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

Add a sample Rust platform driver illustrating the usage of the platform
bus abstractions.

This driver probes through either a match of device / driver name or a
match within the OF ID table.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                          |  1 +
 samples/rust/Kconfig                 | 10 +++++
 samples/rust/Makefile                |  1 +
 samples/rust/rust_driver_platform.rs | 62 ++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+)
 create mode 100644 samples/rust/rust_driver_platform.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 173540375863..583b6588fd1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6986,6 +6986,7 @@ F:	rust/kernel/device_id.rs
 F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
 F:	rust/kernel/platform.rs
+F:	samples/rust/rust_driver_platform.rs
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 6d468193cdd8..70126b750426 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -41,6 +41,16 @@ config SAMPLE_RUST_DRIVER_PCI
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_PLATFORM
+	tristate "Platform Driver"
+	help
+	  This option builds the Rust Platform driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_platform.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b66767f4a62a..11fcb312ed36 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -3,5 +3,6 @@
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
new file mode 100644
index 000000000000..55caaaa4f216
--- /dev/null
+++ b/samples/rust/rust_driver_platform.rs
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust Platform driver sample.
+
+use kernel::{c_str, of, platform, prelude::*};
+
+struct SampleDriver {
+    pdev: platform::Device,
+}
+
+struct Info(u32);
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <SampleDriver as platform::Driver>::IdInfo,
+    [(
+        of::DeviceId::new(c_str!("redhat,rust-sample-platform-driver")),
+        Info(42)
+    )]
+);
+
+impl platform::Driver for SampleDriver {
+    type IdInfo = Info;
+    const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
+
+    fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
+        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+
+        match (Self::of_match_device(pdev), info) {
+            (Some(id), Some(info)) => {
+                dev_info!(
+                    pdev.as_ref(),
+                    "Probed by OF compatible match: '{}' with info: '{}'.\n",
+                    id.compatible(),
+                    info.0
+                );
+            }
+            _ => {
+                dev_info!(pdev.as_ref(), "Probed by name.\n");
+            }
+        };
+
+        let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
+
+        Ok(drvdata.into())
+    }
+}
+
+impl Drop for SampleDriver {
+    fn drop(&mut self) {
+        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver sample.\n");
+    }
+}
+
+kernel::module_platform_driver! {
+    type: SampleDriver,
+    name: "rust_driver_platform",
+    author: "Danilo Krummrich",
+    description: "Rust Platform driver",
+    license: "GPL v2",
+}
-- 
2.46.2


