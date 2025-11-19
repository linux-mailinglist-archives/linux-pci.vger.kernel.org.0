Return-Path: <linux-pci+bounces-41697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D4C713F9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 245BE34E15F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74832C31D;
	Wed, 19 Nov 2025 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR1aRkCH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFubLoJo"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5430DD14
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590776; cv=none; b=OuQ3mdFWezO26RK0cGzanz+A5FmrK9EgKlM9qN4D8VrbP/WQccrpKCX0Op1DJrGWOPm6vG2csp8VZzXSXM6UHuIK8FqgBSUB4ZgvuFzO6dP4vS0CToMR66Xu9eespyLr88F2T3KI/ke4b0HDl1PfQX+MLZ1JLHHjOfYjcgmEzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590776; c=relaxed/simple;
	bh=D99WhKJ/ghNL6aENXqMYUdXI5q5I1XP4JOCtNjQCfz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXlrt08QysinpciNIuZykfI6AaGW3K1RmgPmyTs2Vbg2RvAQuhn1QY9sNH7alFL0RDmXTgpCKiELu5TORy93Kspq+VrW2jg1LDKBSgmAz9qcN2hfuwRKBGOujCKhnVBWJCkbFv0iA5AI/FmId70HnJ2Jlx77JTLCh55N/pe300s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SR1aRkCH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFubLoJo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1vRHV6Homj57YBK4as5Vvxfa66arqOM/2yw45uMPyw=;
	b=SR1aRkCHRsebHJVdiZVloKFjD0quEGtufkGhbc0IuNM8Zl1F0uKr2FTLEPbwREC2Td/T8F
	Dozvgo1Q/xt/DcPbvH0IzCUR6wYvHwN9NANlb4YbOQDbqiS+mydPtLNL6cFjuaNZhWafi0
	IIgFQnP1Z/dwF5qle23k9Sl+wEKpVSo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-QXzZ3JKINq6ATFq3t5QveQ-1; Wed, 19 Nov 2025 17:19:29 -0500
X-MC-Unique: QXzZ3JKINq6ATFq3t5QveQ-1
X-Mimecast-MFC-AGG-ID: QXzZ3JKINq6ATFq3t5QveQ_1763590768
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88050708ac2so7134506d6.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590768; x=1764195568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1vRHV6Homj57YBK4as5Vvxfa66arqOM/2yw45uMPyw=;
        b=CFubLoJo1fnvfOUwFJHPdUyUOsH65+iipVR5y2IRzjzGjp4ILW+w3UaKTyRgpfovOT
         0cAW2l5DKh/eRSZDiCZCLqLU5+jUa0iz/naA3gop0DUopN3Njc1WzQv5TtLDoQvMIGp0
         fTOi5rFCl6prOhIwdghY4JVzA1iHogXoQyu18RkRiZghREQVMFHPwVR9Q09bHc/ITAQ5
         1xnHXHnxqEL6d7EJFfvFdcNtvh3P4rzZ8MwD9EFLwpaQxowTm6gV3+hvIvOWhMyPZZxi
         e+XEXnQuytKBioT6q7pr90l0olOUwO0Epn15Iv6a4Y5YwEXd+2ZCFi/2ZKMshp5RHRZZ
         f8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590768; x=1764195568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1vRHV6Homj57YBK4as5Vvxfa66arqOM/2yw45uMPyw=;
        b=uwbD3eyfTWo+aHMp0aTuEz8ynB7roOEXHjPiI9U3RFJ4dU+Y3FVAKym6XDoryU8Rp3
         PeVdUJ5UlKOOU78KqSXMceq1TILj3nI/f/MG/HxQ5gkr0nXCkN3VJs4h4cqFMH2SOJ72
         60gZymNQmiKXwL7/4otYUYNtGO+o/Ul5HnAZtLuYTMiOtGdR9ch1+k20SuuB07L3lvJb
         nB8H1Qci0V4uTty/QUSwb3Eut7AEBbJhxfclNU08Q8ityg6ODeALi4C97uZx592xZmy+
         MzZI2RKPQD/1j5weXkvIaqj4TMa3ZtNO1J2u5hp67+jRH7aL7+PEhbTHafPsGBgEjq4x
         0KOg==
X-Gm-Message-State: AOJu0YzmuCuIZ5FHeeqnP9PF2X78ypx8bCcxdaScCHdpgs17gGhMzVMZ
	12vJ/GKy5rhinqIpKhDzu+DqIhjy99THoCPP6lM2bJX1DnjLLEhM/i0tlwt1829so2jkI7+rjiy
	MMGmdOfrR8qgQDjNNLvl4fcjOYnwj3XLJkX/NWJiFw8us3ZsOzQ0A4wFwq/bXiA==
X-Gm-Gg: ASbGncuGMRZpBhQjrWbzCSQq68Du6tX/awCn1LAI4CLLhzLtJi/MGNJXFZhwIWp6WE3
	35omGaP6nse9F9hfnG005+pT6trRYnTkhkpbDuvnIebo+vYi2ttfYfh9spdJJE7j3GcDqdt/tFJ
	ILF+LeP6HUEpz3AGPMgYHTQ03r0bE68Gizt3lDRA1OkBIqmbj2OHAbB4M9I5MuI7WSrlZWZ2rDk
	4TTjsZBnXSP4IrYtu1FS3btblH3+aG0khmbvzEB30fHGpn0IGnbYrRwOgpJWeSRyANDlayvs1lk
	cF9ZNVLSMxR7HuPNWUw+hzfvKwc+VuJHO49rr6lvSmmrcXrwP2gtpGqxGbOe9qGjcZLGhbGrBGM
	tU/UU+RLQpiSNIg==
X-Received: by 2002:ad4:5f48:0:b0:880:854:908f with SMTP id 6a1803df08f44-8846ee4d842mr9684696d6.38.1763590768218;
        Wed, 19 Nov 2025 14:19:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgX6yxrFC18TElkj+HEVHEmxQ6fPmK7tD7lfiINSPtKVxeJ6AWjy050Wgsa3odgLZhl31R4w==
X-Received: by 2002:ad4:5f48:0:b0:880:854:908f with SMTP id 6a1803df08f44-8846ee4d842mr9684146d6.38.1763590767686;
        Wed, 19 Nov 2025 14:19:27 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:27 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Wed, 19 Nov 2025 17:19:12 -0500
Subject: [PATCH 8/8] samples: rust: add SR-IOV driver sample
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251119-rust-pci-sriov-v1-8-883a94599a97@redhat.com>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
In-Reply-To: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Peter Colberg <pcolberg@redhat.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2

Add a new SR-IOV driver sample that demonstrates how to enable and
disable the Single Root I/O Virtualization capability for a PCI device.

The sample may be exercised using QEMU's 82576 (igb) emulation.

Link: https://www.qemu.org/docs/master/system/devices/igb.html
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 MAINTAINERS                       |   1 +
 samples/rust/Kconfig              |  11 ++++
 samples/rust/Makefile             |   1 +
 samples/rust/rust_driver_sriov.rs | 107 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b71ea515240a4c5db6d932efce5183386f3a3f79..f2b00c6d9feca43443d3618da32dce2c6ab8c569 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19945,6 +19945,7 @@ F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
+F:	samples/rust/rust_driver_sriov.rs
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b66bed5d3f36d20302bf586dfdb002d39ed9796e..b6154b6cd91f1d733f05b7529f67a79fe032b50c 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -128,6 +128,17 @@ config SAMPLE_RUST_DRIVER_PLATFORM
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_SRIOV
+	tristate "SR-IOV Driver"
+	depends on PCI_IOV
+	help
+	  This option builds the Rust SR-IOV driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_sriov.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_USB
 	tristate "USB Driver"
 	depends on USB = y && BROKEN
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index f65885d1d62bf406b0db13121ef3e5b09829cfbc..a4c12c1200949d0233e08a34e86cea1ff72d0ad7 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_SRIOV)		+= rust_driver_sriov.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
diff --git a/samples/rust/rust_driver_sriov.rs b/samples/rust/rust_driver_sriov.rs
new file mode 100644
index 0000000000000000000000000000000000000000..a60d58d00a2d24883ddcb7236e525c448ae86b4f
--- /dev/null
+++ b/samples/rust/rust_driver_sriov.rs
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust SR-IOV driver sample based on QEMU's 82576 ([igb]) emulation.
+//!
+//! To make this driver probe, QEMU must be run with `-device igb`.
+//!
+//! Further, enable [vIOMMU] with interrupt remapping using, e.g.,
+//!
+//! `-M q35,accel=kvm,kernel-irqchip=split -device intel-iommu,intremap=on,caching-mode=on`
+//!
+//! and append `intel_iommu=on` to the guest kernel arguments.
+//!
+//! [igb]: https://www.qemu.org/docs/master/system/devices/igb.html
+//! [vIOMMU]: https://wiki.qemu.org/Features/VT-d
+
+use kernel::{device::Core, pci, prelude::*, sync::aref::ARef};
+
+#[pin_data(PinnedDrop)]
+struct SampleDriver {
+    pdev: ARef<pci::Device>,
+}
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    MODULE_PCI_TABLE,
+    <SampleDriver as pci::Driver>::IdInfo,
+    [
+        // E1000_DEV_ID_82576
+        (pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10c9), ()),
+        // E1000_DEV_ID_82576_VF
+        (pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10ca), ())
+    ]
+);
+
+#[vtable]
+impl pci::Driver for SampleDriver {
+    type IdInfo = ();
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+        pin_init::pin_init_scope(move || {
+            dev_info!(
+                pdev.as_ref(),
+                "Probe Rust SR-IOV driver sample (PCI ID: {}, 0x{:x}).\n",
+                pdev.vendor_id(),
+                pdev.device_id()
+            );
+
+            if pdev.is_virtfn() {
+                let physfn = pdev.physfn()?;
+                assert!(physfn.is_physfn());
+                dev_info!(
+                    pdev.as_ref(),
+                    "Parent device is PF (PCI ID: {}, 0x{:x}).\n",
+                    physfn.vendor_id(),
+                    physfn.device_id()
+                );
+            }
+
+            pdev.enable_device_mem()?;
+            pdev.set_master();
+
+            Ok(try_pin_init!(Self { pdev: pdev.into() }))
+        })
+    }
+
+    fn sriov_configure(pdev: &pci::Device<Core>, nr_virtfn: i32) -> Result<i32> {
+        assert!(pdev.is_physfn());
+
+        if nr_virtfn == 0 {
+            dev_info!(
+                pdev.as_ref(),
+                "Disable SR-IOV (PCI ID: {}, 0x{:x}).\n",
+                pdev.vendor_id(),
+                pdev.device_id()
+            );
+            pdev.disable_sriov();
+        } else {
+            dev_info!(
+                pdev.as_ref(),
+                "Enable SR-IOV (PCI ID: {}, 0x{:x}).\n",
+                pdev.vendor_id(),
+                pdev.device_id()
+            );
+            pdev.enable_sriov(nr_virtfn)?;
+        }
+
+        assert_eq!(pdev.num_vf(), nr_virtfn);
+        Ok(nr_virtfn)
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for SampleDriver {
+    fn drop(self: Pin<&mut Self>) {
+        dev_info!(self.pdev.as_ref(), "Remove Rust SR-IOV driver sample.\n");
+    }
+}
+
+kernel::module_pci_driver! {
+    type: SampleDriver,
+    name: "rust_driver_sriov",
+    authors: ["Peter Colberg"],
+    description: "Rust SR-IOV driver",
+    license: "GPL v2",
+}

-- 
2.51.1


