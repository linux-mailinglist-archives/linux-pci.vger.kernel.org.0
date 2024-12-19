Return-Path: <linux-pci+bounces-18804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D429F8153
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735CC168253
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632721C5F29;
	Thu, 19 Dec 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAVpJkrU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242D1C5CC9;
	Thu, 19 Dec 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627976; cv=none; b=ad140h/+jUexd1s3Jn4VS4uUxVBG0rGBj2s/T6rTxuai0njDAgsatOtw9ECbL+ytoduLf0QOqxxW1+ZswwD/rZWAaGyH4WGT7Rxkpj2kD73QJpWg+OAMZwaVYJ5HGWUqD2rQ78pmYvdXfZ2iLBAi5b/kPxb1P6pIyHJyhyWZd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627976; c=relaxed/simple;
	bh=oMDKSAAu0g8Huj60p7/hW45ADIHvnKFZOjuhN51ZuI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2vrojYcFazRCyenV4OX3RjZq02GfJ+av2xGAlJkt8j0WVO70n0QFBD273TbgEBddWX//YQYBCg3yERoUs47029OEf9CsKnn8/qOypfN1zp5kFNxZp7LTBqBLj7awh/jzNgYL4sLPOmPJ+DCvKxfwg8twpuh1Y2OgGTCXuKIpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAVpJkrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2317C4CECE;
	Thu, 19 Dec 2024 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627976;
	bh=oMDKSAAu0g8Huj60p7/hW45ADIHvnKFZOjuhN51ZuI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAVpJkrUDJ0+S0CuKCbyO0UYwNmuj+2ofu5DiyV0nu+k+LK6LQgdROVI37U2NuKG7
	 bQQHZnII9pgT7uSVJApxyeg/H02EArcVg8lSu3SoqJ44H2Ly3EFSER4fbNntVl9CrM
	 JJRWSN2k56RBS1EncJjbb6DzBlVB6gGkknDynmU/tHWbvcYxiwKCx8GM4Eea2VQX9a
	 vvkD4ehCjufLpbu0/b7SDLpy1LgNcp0GFyik382+OxtZka7Ro6Zkg9daVAbmBAezbm
	 7wUU50+8x5he2XatPOVskcy5UAz4KSYLZsfV6yseUapX+4XhgtxVbYV3nw13Cly6cQ
	 mkywQya9n7gQA==
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
Subject: [PATCH v7 15/16] samples: rust: add Rust platform sample driver
Date: Thu, 19 Dec 2024 18:04:17 +0100
Message-ID: <20241219170425.12036-16-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219170425.12036-1-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
index 798387acaefc..ed4b293b1baa 100644
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
index 000000000000..8120609e2940
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
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
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
2.47.1


