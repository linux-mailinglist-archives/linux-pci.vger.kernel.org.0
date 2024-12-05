Return-Path: <linux-pci+bounces-17803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4309E6073
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B450F2841BF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673B11C878E;
	Thu,  5 Dec 2024 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhdobYQi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9441C3C1F
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437417; cv=none; b=n8y2eY85SpBi6lJ6P4DK3H5M3q4PAdECOEhsfKwBn3lg18KEV7yYT/KRUx28AHY9/JM+TBD133MVwSSjBbB99v4LuYu0uXlg1MQ6vI5rBgkC/RLGpftNKucMezcrGnwl9Xy2quSyKIP1rnEwQPUo0c0D0HpJwo7+vhmhnNiiycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437417; c=relaxed/simple;
	bh=x9R4We0vG84yE6SsKyj5bY0hN4eya1nRs07Q5rgSMsE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StBZGCo+eVjuveGNS01gaZAGX5PXhGT12WQdF9xwlwwWxQYoTOoyGEhinYe57JRD0oInHrRYqce7OLDiuelagBR4EfIkzuwR4oJqpt6p2XYRvLrjZswmeXy85DBQPp6O/7UItBmuqcDZGBDMheDfOir7m80Rh3l+kK4NR1q0IXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhdobYQi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437415; x=1764973415;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x9R4We0vG84yE6SsKyj5bY0hN4eya1nRs07Q5rgSMsE=;
  b=MhdobYQiyifzkWvgBSqDNj+jYkDqRd/A1yb2wefM290Mn78orBXgGcDt
   ifDBwwIQdkEziC5TLOInHoH/k+LR4sg3BCP+EoPuLQEvuYWHsMsIkpQJj
   adbCsEh3510Q5dXHGBSiRIhIhHJYtFWb1w/VfOeDaDd9rL5a89OM3+pFH
   KnwWD7MmRYG+VjrMyXN5OtlKbWTs2Oikn4BIb/w5UzdxioilxebXeDgRw
   zvwlSwMq4MmtPsjLmWzQ1dQaseN/AZbgNHi4xzCq5dB4Cr4jAedrup93V
   c8SWe705OXglcuOUBEkEyxkgSQzWqE5MXGofoPmehjE9nhzAY81Av3t/C
   w==;
X-CSE-ConnectionGUID: VnNtaP4sRK+Yu+HRIwVpZA==
X-CSE-MsgGUID: 9cBgVCrtSyq4uhVGZphVVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33921140"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33921140"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:35 -0800
X-CSE-ConnectionGUID: u/fT3xYyS4as6CKj6zUaNw==
X-CSE-MsgGUID: 8b1uCHtTTsm5XZBrH9rEFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="93905577"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:34 -0800
Subject: [PATCH 03/11] coco/tsm: Introduce a class device for TEE Security
 Managers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Yilun Xu <yilun.xu@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 John Allen <john.allen@amd.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:23:33 -0800
Message-ID: <173343741358.1074769.14824760616956254302.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A "TSM" is a platform component that provides an API for securely
provisioning resources for a confidential guest (TVM) to consume. The
name originates from the PCI specification for platform agent that
carries out operations for PCIe TDISP (TEE Device Interface Security
Protocol).

Instances of this class device are parented by a device representing the
platform security capability like CONFIG_CRYPTO_DEV_CCP or
CONFIG_INTEL_TDX_HOST.

This class device interface is a frontend to the aspects of a TSM and
TEE I/O that are cross-architecture common. This includes mechanisms
like enumerating available platform TEE I/O capabilities and
provisioning connections between the platform TSM and device DSMs
(Device Security Manager (TDISP)).

For now this is just the scaffolding for registering a TSM device sysfs
interface.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |   10 +++
 MAINTAINERS                               |    3 +
 drivers/virt/coco/Kconfig                 |    2 +
 drivers/virt/coco/Makefile                |    1 
 drivers/virt/coco/host/Kconfig            |    6 ++
 drivers/virt/coco/host/Makefile           |    6 ++
 drivers/virt/coco/host/tsm-core.c         |  113 +++++++++++++++++++++++++++++
 include/linux/tsm.h                       |    5 +
 8 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/virt/coco/host/Kconfig
 create mode 100644 drivers/virt/coco/host/Makefile
 create mode 100644 drivers/virt/coco/host/tsm-core.c

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
new file mode 100644
index 000000000000..7503f04a9eb9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -0,0 +1,10 @@
+What:		/sys/class/tsm/tsm0
+Date:		Dec, 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		"tsm0" is a singleton device that represents the generic
+		attributes of a platform TEE Security Manager. It is a child of
+		the platform TSM device. /sys/class/tsm/tsm0/uevent
+		signals when the PCI layer is able to support establishment of
+		link encryption and other device-security features coordinated
+		through the platform tsm.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c8f61662836..abaabbc39134 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23838,12 +23838,13 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
+TRUSTED (TEE) SECURITY MANAGER (TSM)
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	drivers/virt/coco/guest/
+F:	drivers/virt/coco/host/
 F:	include/linux/tsm.h
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 819a97e8ba99..14e7cf145d85 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -14,3 +14,5 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+
+source "drivers/virt/coco/host/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 885c9ef4e9fc..73f1b7bc5b11 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 obj-$(CONFIG_TSM_REPORTS)	+= guest/
+obj-y				+= host/
diff --git a/drivers/virt/coco/host/Kconfig b/drivers/virt/coco/host/Kconfig
new file mode 100644
index 000000000000..4fbc6ef34f12
--- /dev/null
+++ b/drivers/virt/coco/host/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) Common infrastructure and host drivers
+#
+config TSM
+	tristate
diff --git a/drivers/virt/coco/host/Makefile b/drivers/virt/coco/host/Makefile
new file mode 100644
index 000000000000..be0aba6007cd
--- /dev/null
+++ b/drivers/virt/coco/host/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) Common infrastructure and host drivers
+
+obj-$(CONFIG_TSM) += tsm.o
+tsm-y := tsm-core.o
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
new file mode 100644
index 000000000000..0ee738fc40ed
--- /dev/null
+++ b/drivers/virt/coco/host/tsm-core.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/tsm.h>
+#include <linux/rwsem.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/cleanup.h>
+
+static DECLARE_RWSEM(tsm_core_rwsem);
+static struct class *tsm_class;
+static struct tsm_subsys {
+	struct device dev;
+} *tsm_subsys;
+
+static struct tsm_subsys *
+alloc_tsm_subsys(struct device *parent, const struct attribute_group **groups)
+{
+	struct tsm_subsys *subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
+	struct device *dev;
+
+	if (!subsys)
+		return ERR_PTR(-ENOMEM);
+	dev = &subsys->dev;
+	dev->parent = parent;
+	dev->groups = groups;
+	dev->class = tsm_class;
+	device_initialize(dev);
+	return subsys;
+}
+
+static void put_tsm_subsys(struct tsm_subsys *subsys)
+{
+	if (!IS_ERR_OR_NULL(subsys))
+		put_device(&subsys->dev);
+}
+
+DEFINE_FREE(put_tsm_subsys, struct tsm_subsys *,
+	    if (!IS_ERR_OR_NULL(_T)) put_tsm_subsys(_T))
+struct tsm_subsys *tsm_register(struct device *parent,
+				const struct attribute_group **groups)
+{
+	struct device *dev;
+	int rc;
+
+	guard(rwsem_write)(&tsm_core_rwsem);
+	if (tsm_subsys) {
+		dev_warn(parent, "failed to register: %s already registered\n",
+			 dev_name(tsm_subsys->dev.parent));
+		return ERR_PTR(-EBUSY);
+	}
+
+	struct tsm_subsys *subsys __free(put_tsm_subsys) =
+		alloc_tsm_subsys(parent, groups);
+	if (IS_ERR(subsys))
+		return subsys;
+
+	dev = &subsys->dev;
+	rc = dev_set_name(dev, "tsm0");
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = device_add(dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	tsm_subsys = no_free_ptr(subsys);
+
+	return tsm_subsys;
+}
+EXPORT_SYMBOL_GPL(tsm_register);
+
+void tsm_unregister(struct tsm_subsys *subsys)
+{
+	guard(rwsem_write)(&tsm_core_rwsem);
+	if (!tsm_subsys || subsys != tsm_subsys) {
+		pr_warn("failed to unregister, not currently registered\n");
+		return;
+	}
+
+	device_unregister(&subsys->dev);
+	tsm_subsys = NULL;
+}
+EXPORT_SYMBOL_GPL(tsm_unregister);
+
+static void tsm_release(struct device *dev)
+{
+	struct tsm_subsys *subsys = container_of(dev, typeof(*subsys), dev);
+
+	kfree(subsys);
+}
+
+static int __init tsm_init(void)
+{
+	tsm_class = class_create("tsm");
+	if (IS_ERR(tsm_class))
+		return PTR_ERR(tsm_class);
+
+	tsm_class->dev_release = tsm_release;
+	return 0;
+}
+module_init(tsm_init)
+
+static void __exit tsm_exit(void)
+{
+	class_destroy(tsm_class);
+}
+module_exit(tsm_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TEE Security Manager core");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 431054810dca..1a97459fc23e 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <linux/device.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_32K
@@ -109,4 +110,8 @@ struct tsm_report_ops {
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
+struct tsm_subsys;
+struct tsm_subsys *tsm_register(struct device *parent,
+				const struct attribute_group **groups);
+void tsm_unregister(struct tsm_subsys *subsys);
 #endif /* __TSM_H */


