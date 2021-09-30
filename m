Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5A41D0E3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 03:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbhI3BH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 21:07:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:24480 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347570AbhI3BHR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 21:07:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212330116"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="212330116"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:36 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="521027381"
Received: from yzhu3-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.37.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:34 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 5/6] x86/tdx: Add device filter support for x86 TDX guest platform
Date:   Wed, 29 Sep 2021 18:05:10 -0700
Message-Id: <20210930010511.3387967-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For Confidential VM guests like TDX, the host is untrusted and hence
the devices emulated by the host or any data coming from the host
cannot be trusted. So the drivers that interact with the outside world
have to be hardened and the allowed devices have to be filtered. More
details about the need for device/driver filter in confidential guest
can be found in article [1] titled "firewall for device drivers".

So use the "authorized" device attribute to allow only the trusted list
of the devices. Add support for cc_guest_dev_authorized() which can be
used by BUS drivers to consult the arch specific device allow list and
initialize the "authorized" attribute.  In order to deny probing for all
but the allowed list of devices @dev_default_authorization is set to
false.

The default audited list of drivers that a protected guest may trust
are:

 * virtio-blk
 * virtio-console
 * virtio-net
 * virtio-pci
 * virtio_rproc_serial

Add a new flag CC_ATTR_GUEST_DEVICE_FILTER to conditionally enable
device filter related code in generic drivers (using cc_platform_has()
API).

[1] - https://lwn.net/Articles/865918/

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h      |  9 ++++++
 arch/x86/kernel/Makefile        |  2 +-
 arch/x86/kernel/cc_platform.c   | 20 ++++++++++++
 arch/x86/kernel/cpu/intel.c     |  1 +
 arch/x86/kernel/tdx-filter.c    | 56 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c           |  2 ++
 include/linux/cc_platform.h     | 10 ++++++
 include/linux/device.h          | 11 +++++++
 include/uapi/linux/virtio_ids.h |  8 +++++
 9 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/tdx-filter.c

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 78d146e8a163..c18920703503 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,6 +5,7 @@
 
 #include <linux/cpufeature.h>
 #include <linux/types.h>
+#include <linux/device.h>
 #include <vdso/limits.h>
 #include <asm/vmx.h>
 
@@ -69,6 +70,7 @@ enum tdx_map_type {
 
 void __init tdx_early_init(void);
 bool cpuid_has_tdx_guest(void);
+void __init tdx_filter_init(void);
 
 /* Helper function used to communicate with the TDX module */
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
@@ -96,6 +98,8 @@ int tdx_hcall_get_quote(u64 data);
 
 extern void (*tdx_event_notify_handler)(void);
 
+bool tdx_guest_dev_authorized(struct device *dev);
+
 /*
  * To support I/O port access in decompressor or early kernel init
  * code, since #VE exception handler cannot be used, use paravirt
@@ -169,6 +173,11 @@ static inline int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
 	return -ENODEV;
 }
 
+static inline bool tdx_guest_dev_authorized(struct device *dev)
+{
+	return dev->authorized;
+}
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3d8876f60d5b..2b6f7b0065f5 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -128,7 +128,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
-obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o tdx-filter.o
 
 obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 3fd2c628e028..3544ed78dd16 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,6 +11,9 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 #include <linux/processor.h>
+#include <linux/device.h>
+
+#include <asm/tdx.h>
 
 #include <asm/tdx.h>
 
@@ -24,3 +27,20 @@ bool cc_platform_has(enum cc_attr attr)
 	return false;
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
+
+/*
+ * cc_guest_dev_authorized() - Used to get ARCH specific authorized status
+ *			       of the given device.
+ * @dev			     - device structure
+ *
+ * Return True to allow the device or False to deny it.
+ *
+ */
+bool cc_guest_dev_authorized(struct device *dev)
+{
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_guest_dev_authorized(dev);
+
+	return dev->authorized;
+}
+EXPORT_SYMBOL_GPL(cc_guest_dev_authorized);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 7fbb7f6eb523..1d405750bc16 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -84,6 +84,7 @@ bool intel_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
 	case CC_ATTR_GUEST_SHARED_MAPPING_INIT:
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_DEVICE_FILTER:
 		return cpu_feature_enabled(X86_FEATURE_TDX_GUEST);
 	default:
 		return false;
diff --git a/arch/x86/kernel/tdx-filter.c b/arch/x86/kernel/tdx-filter.c
new file mode 100644
index 000000000000..534cc2cf5851
--- /dev/null
+++ b/arch/x86/kernel/tdx-filter.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Intel Corporation
+ */
+#define pr_fmt(fmt) "TDX: " fmt
+
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/cc_platform.h>
+#include <linux/export.h>
+#include <uapi/linux/virtio_ids.h>
+
+#include <asm/tdx.h>
+#include <asm/cmdline.h>
+
+/*
+ * Allow list for PCI bus
+ *
+ * NOTE: Device ID is duplicated here. But for small list
+ * of devices, it is easier to maintain the duplicated list
+ * here verses exporting the device ID table from the driver
+ * and use it.
+ */
+struct pci_device_id pci_allow_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_NET) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_BLOCK) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_CONSOLE) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_9P) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO1_ID_NET) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO1_ID_BLOCK) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO1_ID_CONSOLE) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO1_ID_9P) },
+	{ 0, },
+};
+
+bool tdx_guest_dev_authorized(struct device *dev)
+{
+	if (!dev_is_pci(dev))
+		return dev->authorized;
+
+	if (pci_match_id(pci_allow_ids, to_pci_dev(dev)))
+		return true;
+
+	return dev_default_authorization;
+}
+
+void __init tdx_filter_init(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
+		return;
+
+	dev_default_authorization = false;
+
+	pr_info("Enabled TDX guest device filter\n");
+}
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index aeeab647e62d..b1d660bd98c6 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -797,6 +797,8 @@ void __init tdx_early_init(void)
 
 	tdx_get_info();
 
+	tdx_filter_init();
+
 	pv_ops.irq.safe_halt = tdx_safe_halt;
 	pv_ops.irq.halt = tdx_halt;
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index d39370cfbda1..a0b608bba1ee 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -94,6 +94,16 @@ enum cc_attr {
 	 */
 	CC_ATTR_GUEST_SHARED_MAPPING_INIT,
 
+	/**
+	 * @CC_ATTR_GUEST_DEVICE_FILTER: Filter device enumeration as per
+	 * platform specific allow list.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and allows or
+	 * dis-allows device enumeration as per platform specific allow list.
+	 *
+	 * Examples include TDX guest.
+	 */
+	CC_ATTR_GUEST_DEVICE_FILTER,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
diff --git a/include/linux/device.h b/include/linux/device.h
index c97b1e59d23a..125590e80c35 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -990,4 +990,15 @@ extern long sysfs_deprecated;
 #define sysfs_deprecated 0
 #endif
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+bool cc_guest_dev_authorized(struct device *dev);
+#else
+static inline bool cc_guest_dev_authorized(struct device *dev)
+{
+	return dev->authorized;
+}
+#endif /* CONFIG_ARCH_HAS_CC_PLATFORM */
+#endif /* __ASSEMBLY__ */
+
 #endif /* _DEVICE_H_ */
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 80d76b75bccd..68c68d449ea5 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -81,4 +81,12 @@
 #define VIRTIO_TRANS_ID_RNG		1005 /* transitional virtio rng */
 #define VIRTIO_TRANS_ID_9P		1009 /* transitional virtio 9p console */
 
+/*
+ * Virtio IDS (for PCI rev ID > 1)
+ */
+#define VIRTIO1_ID_NET			1041 /* transitional virtio net */
+#define VIRTIO1_ID_BLOCK		1042 /* transitional virtio block */
+#define VIRTIO1_ID_CONSOLE		1043 /* transitional virtio console */
+#define VIRTIO1_ID_9P			1049 /* transitional virtio 9p console */
+
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.25.1

