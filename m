Return-Path: <linux-pci+bounces-2785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147C2841F57
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3EC283E75
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65BE60866;
	Tue, 30 Jan 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEnWuY4h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06338DEC
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606647; cv=none; b=awyLV6FBkk7yh6Awq/n74SG7J+j3a0Rhjbb8IqC2pTy7HE6EALN5tAGDKFJuZsMi5E8ECIMeYH0lU+Q5Y7FT81kNzl/LEllYnaeqKoPq/mKEqv5ZLlgFWQGl4BTddA4VDUjCC4V+2Tc5BNu0s+FZATvKJFRauFZD1mYFF0NiOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606647; c=relaxed/simple;
	bh=GkuAJg9CebG58qzZActEEIhXLKXqXyptorLfURmgRsE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeOp6zKV60u8F1ZhA6xdD4E5fRs2hkgqFjYYJj0StWZfVkh4wCpBFxPejFFh/MW23h7O4Wp/elJT7ZCjljStzeoHj2EdF7HKXp7IX2Jbz1WXbd54MuaxUYma+sbhEIlZcnqep+nTnFdzibGaCH01I1JAPRLM4gQCORh0U6dRThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEnWuY4h; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606646; x=1738142646;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkuAJg9CebG58qzZActEEIhXLKXqXyptorLfURmgRsE=;
  b=VEnWuY4h0P2tGwhEx9jSMduMyW0pRGjmMp/jBNVNuGKZ0F+Zc1nIc09Z
   QLStnt1SgmC0ZLzHZAeuMj7gs6mxg8HiyhDr+AuM7E49VDpYsVE77NT8P
   VzZCNrlPGsluzbcVsVIOJYi8fZqdaiyEj5QUVKp+2WK7UOpP9ggZSlb39
   ah5F/SB5MDwJF74e6oVv/CSrVm9gecce8yrEPOvf/S25GyOFQKEJHM9t1
   OT6oNUqOT9QIz2pmKkn25B0Uda92fJp9bZ2hcUgyuaNMGRE5gTNQCBFK/
   vrtGGl8jrvMIllehiltrSIX52vKeOoZxxXltxFseo/0yobJ+DlP6qgXol
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24699925"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24699925"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="788141877"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="788141877"
Received: from djayasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.72.104])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:24:03 -0800
Subject: [RFC PATCH 3/5] coco/tsm: Introduce a shared class device for TSMs
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Date: Tue, 30 Jan 2024 01:24:02 -0800
Message-ID: <170660664287.224441.947018257307932138.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A "tsm" is a platform component that provides an API for securely
provisioning resources for a confidential guest (TVM) to consume. "TSM"
also happens to be the acronym the PCI specification uses to define the
platform agent that carries out device-security operations. That
platform capability is commonly called TEE I/O. It is this arrival of
TEE I/O platforms that requires the "tsm" concept to grow from a
low-level arch-specific detail of TVM instantiation, to a frontend
interface to mediate device setup and interact with general purpose
kernel subsystems outside of arch/ like the PCI core.

Provide a virtual (as in /sys/devices/virtual) class device interface to
front all of the aspects of a TSM and TEE I/O that are
cross-architecture common. This includes mechanisms like enumerating
available platform TEE I/O capabilities and provisioning connections
between the platform TSM and device DSMs.

It is expected to handle hardware TSMs, like AMD SEV-SNP and ARM CCA
where there is a physical TEE coprocessor device running firmware, as
well as software TSMs like Intel TDX and RISC-V COVE, where there is a
privileged software module loaded at runtime.

For now this is just the scaffolding for registering a TSM device and/or
TSM-specific attribute groups.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |   12 +++
 drivers/virt/coco/tsm/Kconfig             |    7 ++
 drivers/virt/coco/tsm/Makefile            |    3 +
 drivers/virt/coco/tsm/class.c             |  100 +++++++++++++++++++++++++++++
 include/linux/tsm.h                       |    8 ++
 5 files changed, 130 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/virt/coco/tsm/class.c

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
new file mode 100644
index 000000000000..304b50b53e65
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -0,0 +1,12 @@
+What:		/sys/class/tsm/tsm0/host
+Date:		January 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) For hardware TSMs represented by a device in /sys/devices,
+		@host is a link to that device.
+		Links to hardware TSM sysfs ABIs:
+		- Documentation/ABI/testing/sysfs-driver-ccp
+
+		For software TSMs instantiated by a software module, @host is a
+		directory with attributes for that TSM, and those attributes are
+		documented below.
diff --git a/drivers/virt/coco/tsm/Kconfig b/drivers/virt/coco/tsm/Kconfig
index 69f04461c83e..595d86917462 100644
--- a/drivers/virt/coco/tsm/Kconfig
+++ b/drivers/virt/coco/tsm/Kconfig
@@ -5,3 +5,10 @@
 config TSM_REPORTS
 	select CONFIGFS_FS
 	tristate
+
+config ARCH_HAS_TSM
+	bool
+
+config TSM
+	depends on ARCH_HAS_TSM && SYSFS
+	tristate
diff --git a/drivers/virt/coco/tsm/Makefile b/drivers/virt/coco/tsm/Makefile
index b48504a3ccfd..f7561169faed 100644
--- a/drivers/virt/coco/tsm/Makefile
+++ b/drivers/virt/coco/tsm/Makefile
@@ -4,3 +4,6 @@
 
 obj-$(CONFIG_TSM_REPORTS) += tsm_reports.o
 tsm_reports-y := reports.o
+
+obj-$(CONFIG_TSM) += tsm.o
+tsm-y := class.o
diff --git a/drivers/virt/coco/tsm/class.c b/drivers/virt/coco/tsm/class.c
new file mode 100644
index 000000000000..a569fa6b09eb
--- /dev/null
+++ b/drivers/virt/coco/tsm/class.c
@@ -0,0 +1,100 @@
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
+struct class *tsm_class;
+struct tsm_subsys {
+	struct device dev;
+	const struct tsm_info *info;
+} *tsm_subsys;
+
+int tsm_register(const struct tsm_info *info)
+{
+	struct device *dev __free(put_device) = NULL;
+	struct tsm_subsys *subsys;
+	int rc;
+
+	guard(rwsem_write)(&tsm_core_rwsem);
+	if (tsm_subsys) {
+		pr_warn("failed to register: \"%s\", \"%s\" already registered\n",
+			info->name, tsm_subsys->info->name);
+		return -EBUSY;
+	}
+
+	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
+	if (!subsys)
+		return -ENOMEM;
+
+	subsys->info = info;
+	dev = &subsys->dev;
+	dev->class = tsm_class;
+	dev->groups = info->groups;
+	dev_set_name(dev, "tsm0");
+	rc = device_register(dev);
+	if (rc)
+		return rc;
+
+	if (info->host) {
+		rc = sysfs_create_link(&dev->kobj, &info->host->kobj, "host");
+		if (rc)
+			return rc;
+	}
+
+	/* don't auto-free @dev */
+	dev = NULL;
+	tsm_subsys = subsys;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_register);
+
+void tsm_unregister(const struct tsm_info *info)
+{
+	guard(rwsem_write)(&tsm_core_rwsem);
+	if (!tsm_subsys || info != tsm_subsys->info) {
+		pr_warn("failed to unregister: \"%s\", not currently registered\n",
+			info->name);
+		return;
+	}
+
+	if (info->host)
+		sysfs_remove_link(&tsm_subsys->dev.kobj, "host");
+	device_unregister(&tsm_subsys->dev);
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
+MODULE_DESCRIPTION("Trusted Security Module core device model");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 28753608fcf5..8cb8a661ba41 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,12 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 
+struct tsm_info {
+	const char *name;
+	struct device *host;
+	const struct attribute_group **groups;
+};
+
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_32K
 
@@ -66,4 +72,6 @@ extern const struct config_item_type tsm_report_extra_type;
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv,
 			const struct config_item_type *type);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
+int tsm_register(const struct tsm_info *info);
+void tsm_unregister(const struct tsm_info *info);
 #endif /* __TSM_H */


