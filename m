Return-Path: <linux-pci+bounces-17782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C289E585E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 15:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC011884898
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C68621D589;
	Thu,  5 Dec 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT5X3/xV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C24218EB3;
	Thu,  5 Dec 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408229; cv=none; b=KIXGTSBJKUfL7CrYPGchgxcE6fZdZL0eqmVm3Qt4zy0zXQYjihart/q5s5o8vIVx/s33u006anEtv5aNRXxP5vsn6PcBd68sDLCfOq6MxYdmiuqUi8iSoXJZqtLZ+JzPtwDsxscJmuBtXmh95ZWTj5avRHMf1DsHpx9eKaOUmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408229; c=relaxed/simple;
	bh=fsQdz0uOY3RAQ4rMNOpTqBJdkc/b5ZHxcuQQNj6yVKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2nL+hPhS285aRURRejP+XCejoxS1DT6ke818fCI03AjOzau0PBD9sA7GAa4vaWa8tSV1sk2oTEW/tVfWE9Bvf4II8vCR5XlB4/r1JNkAwWWVymHK29BpUM6eH9klERA1z4hpSPsEqSr0qYkJ5OHzJZBiUxyrMH5Eds9hOlKhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT5X3/xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2260C4CEDD;
	Thu,  5 Dec 2024 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733408228;
	bh=fsQdz0uOY3RAQ4rMNOpTqBJdkc/b5ZHxcuQQNj6yVKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nT5X3/xVaG1myUIf1wLCdym2Y9V3Sf3p5wOv2x9IYsy9XnjjhQrpAVnz/eZPRLY82
	 BbYpb2ulLUxw4GhSOBuiMffANdbtK6aQyQX1AD3vOYOBv0KVekV0kL0OXXX6s3f7LE
	 OHLidjzdQScMnvBifMFdth5Abv4Cq0z6KN3kGDQ8eW5MRxOVUZTfB8ut9/OxE1aVQL
	 c9OrM68JTAN3Csz2VZSPUWZhLvZIsPUmO6rUGyIAELoVytYTZY/A8IiAxJD4csMDut
	 3WeVutfpdZwQQk8JSbzbaIEatUx1kliJfPxrENxvrlkFI+bymtaDcGjcE7N5FWyKVW
	 OETqWu4kpSEDg==
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
Subject: [PATCH v4 13/13] samples: rust: add Rust platform sample driver
Date: Thu,  5 Dec 2024 15:14:44 +0100
Message-ID: <20241205141533.111830-14-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205141533.111830-1-dakr@kernel.org>
References: <20241205141533.111830-1-dakr@kernel.org>
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
 MAINTAINERS                                  |  1 +
 drivers/of/unittest-data/tests-platform.dtsi |  5 ++
 samples/rust/Kconfig                         | 10 ++++
 samples/rust/Makefile                        |  1 +
 samples/rust/rust_driver_platform.rs         | 49 ++++++++++++++++++++
 5 files changed, 66 insertions(+)
 create mode 100644 samples/rust/rust_driver_platform.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 365fc48b7041..ae576c842c51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7035,6 +7035,7 @@ F:	rust/kernel/device_id.rs
 F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
 F:	rust/kernel/platform.rs
+F:	samples/rust/rust_driver_platform.rs
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index fa39611071b3..2caaf1c10ee6 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -33,6 +33,11 @@ dev@100 {
 					reg = <0x100>;
 				};
 			};
+
+			test-device@2 {
+				compatible = "test,rust-device";
+				reg = <0x2>;
+			};
 		};
 	};
 };
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
index 2f5b6bdb2fa5..761d13fff018 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -4,6 +4,7 @@ ccflags-y += -I$(src)				# needed for trace events
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
new file mode 100644
index 000000000000..2f0dbbe69e10
--- /dev/null
+++ b/samples/rust/rust_driver_platform.rs
@@ -0,0 +1,49 @@
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
+    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
+);
+
+impl platform::Driver for SampleDriver {
+    type IdInfo = Info;
+    const OF_ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
+
+    fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
+        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+
+        if let Some(info) = info {
+            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
+        }
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
2.47.0


