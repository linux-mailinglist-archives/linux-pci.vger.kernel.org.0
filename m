Return-Path: <linux-pci+bounces-6177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495C8A2A2E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 11:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775CB1C20AAD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361757894;
	Fri, 12 Apr 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq1n90H9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22F5788F
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911930; cv=none; b=PAqeVdTCdlGhytHANSmAXloPvTd8BO+t95JtPJTRLJpdsz8ZStqKRHIGi56yus5EDT7LfU0iC9prTi+1Lzl7AIc0LnO+QS1xjRpK9rcBR2NuDbqWerfhmRRqLnPESfrPfdICDysP8m/7OJZakoaa9uaANmJ6NJ76P2HvjyhzS3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911930; c=relaxed/simple;
	bh=QMT/SABd2qSIE80T0kNM7Hr1LLkjFJ+8UzVloQ6uoVM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLMnB/Setef3h8eRm/wNQDVh3GLqdCH9Yd75pZfuZ+GXzd47IiVtO22QaY8ziQtHMnk0SswQhgHlfEIJGtDX0wMz8Wr1bFIQ/YCzHHHFlYyVP2HYwzEe1yR5jtPtVfl6QLt8YFSnmCND5YtE6iOETXWmVC8u8W0PdECuatZPClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq1n90H9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712911929; x=1744447929;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMT/SABd2qSIE80T0kNM7Hr1LLkjFJ+8UzVloQ6uoVM=;
  b=Tq1n90H9CA2lcWqrshRP85kBbe6DZV8B+92fW39JSH3zugr7VaM8JOOr
   PlpaLyTiMCcYZJYHhz60l3K7SKg4xRoT8SkX0UqVRanh+lAGHRWGlqZHB
   5uxEk0IRJc5teFq2NpRryEpS8kl9U9SJxqIuitbzV5hXIzkClNBN3BzdM
   1M/WhHOSdZ5fHI9qUVjqAIHLdYz+WeGDjiekDlZv6ZS0DJ4RzUtvkIwD3
   sZb3kIzg1XEZWQEPKe0CIpIZJo0gZRyw8RILRsHpmUgOIZBq0r5oFcORG
   d9QTc7xHZzgtQht7zEWIzVMkscsLzLrVvGj+GPdpzhXGm7kiVBhH1Tp09
   A==;
X-CSE-ConnectionGUID: OgATlFvqS+udAn1gpQIz1w==
X-CSE-MsgGUID: WTI7/DHnQYOmSaa0S4ciTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8468354"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8468354"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:52:09 -0700
X-CSE-ConnectionGUID: k5FhqQPJQneskDuMMqTFvg==
X-CSE-MsgGUID: VKdiOoPmQIyBaHLAwADTfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21226753"
Received: from aclausch-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.15.202])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:52:08 -0700
Subject: [RFC PATCH v2 4/6] coco/tsm: Introduce a class device for TEE
 Security Managers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
 bhelgaas@google.com, kevin.tian@intel.com, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, lukas@wunner.de
Date: Fri, 12 Apr 2024 01:52:07 -0700
Message-ID: <171291192709.3532867.600578579081268094.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
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
Cc: Wu Hao <hao.wu@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS                       |    3 +
 drivers/virt/coco/Kconfig         |    2 +
 drivers/virt/coco/Makefile        |    1 
 drivers/virt/coco/host/Kconfig    |    6 ++
 drivers/virt/coco/host/Makefile   |    6 ++
 drivers/virt/coco/host/tsm-core.c |  113 +++++++++++++++++++++++++++++++++++++
 include/linux/tsm.h               |    5 ++
 7 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/coco/host/Kconfig
 create mode 100644 drivers/virt/coco/host/Makefile
 create mode 100644 drivers/virt/coco/host/tsm-core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 65beba4e704a..8d5bcd9d43ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22461,12 +22461,13 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
+TRUSTED (TEE) SECURITY MANAGER (TSM)
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm
 F:	drivers/virt/coco/guest/tsm_report.c
+F:	drivers/virt/coco/host/
 F:	include/linux/tsm.h
 
 TTY LAYER AND SERIAL DRIVERS
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 7c41e0abd423..ae92da620168 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -10,3 +10,5 @@ source "drivers/virt/coco/sev-guest/Kconfig"
 source "drivers/virt/coco/tdx-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+
+source "drivers/virt/coco/host/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 621111811a76..3557f556e782 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
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
index 9bbb1d130d01..2867c2ecbd11 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -4,6 +4,7 @@
 
 #include <linux/sizes.h>
 #include <linux/types.h>
+#include <linux/device.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_32K
@@ -66,4 +67,8 @@ extern const struct config_item_type tsm_report_extra_type;
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv,
 			const struct config_item_type *type);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
+struct tsm_subsys;
+struct tsm_subsys *tsm_register(struct device *parent,
+				const struct attribute_group **groups);
+void tsm_unregister(struct tsm_subsys *subsys);
 #endif /* __TSM_H */


