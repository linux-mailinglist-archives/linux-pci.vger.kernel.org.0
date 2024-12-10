Return-Path: <linux-pci+bounces-18075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113409EBE5F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B1028592A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5B23D401;
	Tue, 10 Dec 2024 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB/24OQX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B83225A3E;
	Tue, 10 Dec 2024 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871094; cv=none; b=fzkiVYNdXWSe1RJoY7gI96mD7dy6rAWzCa480F9satrBtSo2D6ElLmlr6I4544KRXovgDnDJ7a4jjj5vaYuLGyHirpLz2bD+Vvy06xk7uXbuIolXT1UW44+lbAr6FsabN1wflduSsfu5xEQHiIZwozlfG5yINx484ncLdwtC9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871094; c=relaxed/simple;
	bh=0RjRP3npAXMurmOnYf92XqAAkD11QEaIC9uLAqqRCPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foeGih8SIiQroO4Pb3N9vLzfjp/49R5Ni0NZTUbWQB5fh5rybF371KsGHgSa9CoC6UG16+MF5BDPgjFyJJOme/IMFEI5IQ5G4ZKtoZGUdtN2hALdhTmxpUeEr4cr44T0nb48N/d1Nn+kAVW+WjXiuwU5WzB8qu5Q50Bra2Z4dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB/24OQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543E1C4CEDE;
	Tue, 10 Dec 2024 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871094;
	bh=0RjRP3npAXMurmOnYf92XqAAkD11QEaIC9uLAqqRCPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RB/24OQX+dZSeHKPOC8Xx2mwR8sxVkdlJURGS107P+9haVF53A9NOzoxU5NLlpDLE
	 Das2LBHWZm9uSuvjA3gkBtbygh27cW+YadXatAYAbFzf9NRDbFwa2hE8PAHY+T2viH
	 J0GJkP+g1fr42kGJiWBXQXB3o7mLH5uCrVmlnc4stxVoQwEalYulT68acOzMaV0KV9
	 OobvLQud3kff9qd0SUOABr7LY8EgPKcExVHj5JrSGgQUyAUbjnPT5rXiQmx78qOBZp
	 OHWadFIEUj3nt9FrYc8GzH8uQW1cAYatOwM3ipR9Ju8GashFIaNV2lcKlVIfnhHEjE
	 EH3wdYSLjRtSA==
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
Subject: [PATCH v5 15/16] samples: rust: add Rust platform sample driver
Date: Tue, 10 Dec 2024 23:46:42 +0100
Message-ID: <20241210224947.23804-16-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210224947.23804-1-dakr@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
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
index a4253abb114b..47b1a82dfdd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7037,6 +7037,7 @@ F:	rust/kernel/device_id.rs
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
index 000000000000..6ad59aa26eca
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
+    const OF_ID_TABLE: of::IdTable<Self::IdInfo> = &OF_TABLE;
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


