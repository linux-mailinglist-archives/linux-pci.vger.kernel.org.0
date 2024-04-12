Return-Path: <linux-pci+bounces-6179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C78A2A30
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 11:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04159289908
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50A25381A;
	Fri, 12 Apr 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MP3XMpdD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060057863
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911944; cv=none; b=d0XsGO5wk4Moc+/dh+IDJxiGdtZ1nuRCc+6u0XOKwvht1FhUJwdmZ8p+NYBALd1qHatPtpjfP8+HLaxq6zbSlkmWJ/8srAe5sQsbxtpkzbax+903E3L25Ib8Daz7jDKF6OIjx+Ccd3VtQGnQ/+7f20+4IMVh44jqvrZz458ov3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911944; c=relaxed/simple;
	bh=jvwzkc4NJiqQPer3dGrkLLA+FbF5C2jPfbxxf6z4618=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncQWt2joFOta0qWNI8qSALbEH1S172etD4R3pShmDYeAxDZFICHmiW9sEeb7t+4U45czueVGVtTfzRGmUR49b9Okcm5TiExpFdyNWcWatRPZTVt7fGeeh5zmBLnrPwxTZD2DIX1Xa0Fr7aEryXMinZk5Z+yqPg64HJzol5uv8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MP3XMpdD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712911944; x=1744447944;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jvwzkc4NJiqQPer3dGrkLLA+FbF5C2jPfbxxf6z4618=;
  b=MP3XMpdDgk5/H4DkUFYsOlSHVb7R8wUij0Nek37nK29uKAcSq3/fPog8
   vuYGc4IyPe8I/hPVIgczCuHcz3N6b3F2efvB8OlwXtcXjjlrdo2wOFyJC
   RplBbvr0plaLAJGxBxx4t9LvUDCs9JvxoHC0b0Jks4p1+f2leHvlthyWp
   tW8wHSkweS3TYbdDp8cFwKIq9AUf1pWbgOqtPoGkv6EugST454IV3mocE
   8XupG24YOKwWoJSOLQScU5po9DdtHQHnx2703PETpMvq1gG1Cy6aviXeN
   FxyaWxRmUfdOxGg9bY6/Fz4yAljMm5nUf4MvcLiUIdA46qUi3WS7kgoV2
   g==;
X-CSE-ConnectionGUID: Vpf70/9ITDywwBVCkTZv2g==
X-CSE-MsgGUID: 9mdUIytoRgWs9NxNy2Bw2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12152279"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="12152279"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:52:23 -0700
X-CSE-ConnectionGUID: /ku+IJAsT8aI4rIHwWYQgw==
X-CSE-MsgGUID: qrcxVCH8Qu+RmjmEz8NdIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25718664"
Received: from aclausch-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.15.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:52:20 -0700
Subject: [RFC PATCH v2 6/6] tdx_tsm: TEE Security Manager driver for TDX
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: bhelgaas@google.com, kevin.tian@intel.com, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, lukas@wunner.de
Date: Fri, 12 Apr 2024 01:52:19 -0700
Message-ID: <171291193896.3532867.11285766993255838266.stgit@dwillia2-xfh.jf.intel.com>
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

Recall that a TEE Security Manager (TSM) is a platform agent that speaks
the TEE Device Interface Security Protocol (TDISP) to PCIe devices and
manages private memory resources for the platform. The tdx_tsm driver
loads against a device of the same name registered at TDX Module
initialization time. The device lives on the "tdx" bus which is a
virtual subsystem that hosts the TDX module sysfs ABI.

It allows for device-security enumeration and initialization flows to be
deferred from TDX Module init time. Crucially, when / if TDX Module
init moves earlier in x86 initialization flow this driver is still
guaranteed to run after IOMMU and PCI init (i.e. subsys_initcall() vs
device_initcall()).

The ability to unload the module, or unbind the driver is also useful
for debug and coarse grained transitioning between PCI TSM operation and
PCI CMA operation (native kernel PCI device authentication).

For now this is the basic boilerplate with sysfs attributes and
operation flows to be added later.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/shared/tdx.h |    3 ++
 arch/x86/virt/vmx/tdx/tdx.c       |    9 ++++-
 drivers/virt/coco/host/Kconfig    |    6 +++
 drivers/virt/coco/host/Makefile   |    2 +
 drivers/virt/coco/host/tdx_tsm.c  |   68 +++++++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/coco/host/tdx_tsm.c

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fdfd41511b02..7cc5cfb65e8d 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -132,5 +132,8 @@ static __always_inline u64 hcall_func(u64 exit_reason)
         return exit_reason;
 }
 
+/* tdx_tsm driver interfaces */
+extern const struct bus_type tdx_subsys;
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e23bddf31daa..13b285e4e91e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1099,9 +1099,16 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
-static const struct bus_type tdx_subsys = {
+static int tdx_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	return add_uevent_var(env, "MODALIAS=%s", dev_name(dev));
+}
+
+const struct bus_type tdx_subsys = {
 	.name = "tdx",
+	.uevent = tdx_uevent,
 };
+EXPORT_SYMBOL_NS_GPL(tdx_subsys, TDX);
 
 struct tdx_tsm {
 	struct device dev;
diff --git a/drivers/virt/coco/host/Kconfig b/drivers/virt/coco/host/Kconfig
index 4fbc6ef34f12..2155507b8516 100644
--- a/drivers/virt/coco/host/Kconfig
+++ b/drivers/virt/coco/host/Kconfig
@@ -4,3 +4,9 @@
 #
 config TSM
 	tristate
+
+config TDX_TSM
+	depends on INTEL_TDX_HOST
+	select PCI_TSM
+	select TSM
+	tristate
diff --git a/drivers/virt/coco/host/Makefile b/drivers/virt/coco/host/Makefile
index be0aba6007cd..2612f17ec966 100644
--- a/drivers/virt/coco/host/Makefile
+++ b/drivers/virt/coco/host/Makefile
@@ -4,3 +4,5 @@
 
 obj-$(CONFIG_TSM) += tsm.o
 tsm-y := tsm-core.o
+
+obj-$(CONFIG_TDX_TSM) += tdx_tsm.o
diff --git a/drivers/virt/coco/host/tdx_tsm.c b/drivers/virt/coco/host/tdx_tsm.c
new file mode 100644
index 000000000000..95d1352589c9
--- /dev/null
+++ b/drivers/virt/coco/host/tdx_tsm.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+#include <linux/tsm.h>
+#include <linux/pci-tsm.h>
+#include <asm/tdx.h>
+
+static int tdx_tsm_add(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+static void tdx_tsm_del(struct pci_dev *pdev)
+{
+}
+
+static int tdx_tsm_exec(struct pci_dev *pdev, enum pci_tsm_cmd cmd)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct pci_tsm_ops tdx_pci_tsm_ops = {
+	.add = tdx_tsm_add,
+	.del = tdx_tsm_del,
+	.exec = tdx_tsm_exec,
+};
+
+static void unregister_tsm(void *subsys)
+{
+	tsm_unregister(subsys);
+}
+
+static int tdx_tsm_probe(struct device *dev)
+{
+	struct tsm_subsys *subsys;
+
+	subsys = tsm_register(dev, NULL, &tdx_pci_tsm_ops);
+	if (IS_ERR(subsys)) {
+		dev_err(dev, "failed to register TSM: (%pe)\n", subsys);
+		return PTR_ERR(subsys);
+	}
+
+	return devm_add_action_or_reset(dev, unregister_tsm, subsys);
+}
+
+static struct device_driver tdx_tsm_driver = {
+	.probe = tdx_tsm_probe,
+	.bus = &tdx_subsys,
+	.owner = THIS_MODULE,
+	.name = KBUILD_MODNAME,
+	.mod_name = KBUILD_MODNAME,
+};
+
+static int __init tdx_tsm_init(void)
+{
+	return driver_register(&tdx_tsm_driver);
+}
+module_init(tdx_tsm_init);
+
+static void __exit tdx_tsm_exit(void)
+{
+	driver_unregister(&tdx_tsm_driver);
+}
+module_exit(tdx_tsm_exit);
+
+MODULE_IMPORT_NS(TDX);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("tdx_tsm");
+MODULE_DESCRIPTION("TDX TEE Security Manager");


