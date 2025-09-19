Return-Path: <linux-pci+bounces-36484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F7B89DEB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09481B203C8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED1313541;
	Fri, 19 Sep 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnKqz9ln"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC7311598
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291760; cv=none; b=uWPMpjyj/DP9FANUVQWuDIltk/lPftDiShgXFfFXFu82zNTQrRvOD5gJZnci726PXyhUjfMW32FgH2zzOV1phC2CAfkMQU70O8kOAKM9cK9hNQnxaLQfKqIVxzGdPCuFRn0S5KUhIzSSRryNQ+OM0J0nv99ob1y05in8fY314as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291760; c=relaxed/simple;
	bh=UT3LP10GIv09NH60vo+16gFkCbLr6XpSF3y9hJk4Gpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXlv+BtEXmTh44FHD83oUTjZloL4vZuVfE6hBtPcPL12R7SQUqJnfNcmF4W6uwuHExEltXZbumZj66Qh5o/a9JDrMe8AVuQcv+HQuwrrpcsWDW7RaEAVwOiIFSQC85QZWHVqA+DElP6wjOKS8hdq1BfUSq2uzW1frZZyREUA0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnKqz9ln; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291758; x=1789827758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UT3LP10GIv09NH60vo+16gFkCbLr6XpSF3y9hJk4Gpc=;
  b=RnKqz9lnnVcH6WBdl+dlyzmcHXc6rn3lvoSDvd8XD9PwMid8wn3JqG3r
   hnj3AWKzqTZW6rkBc7eJB+GL3wyiQ7ewF3h/h1PxhaWGMdgXQ3EeCHW+F
   u2UvnwD4L1vANSB3xSJ7Ij4YcjBrZ2yeeZkLymlX+FcV7sB1NPiJ5t1SB
   nnS0jNajEuM+4wN/xXpmNf/88HVBbr6ALK2p+1uOHBKSK4bAI0VG6p99I
   4Z2sNaUcj7WScSX3et65KILCyMCUUyKKUFPreZNtTi2r9N8xAqhxpNbTI
   vvqMQVnd70deFpDeic32DamlfO2jvvG9+pck3zEVQ8GhFRYP16y6q8a8O
   g==;
X-CSE-ConnectionGUID: xXfI0oV9Rdexqu+2p3Y5yA==
X-CSE-MsgGUID: DJSkxOQuRDGOMx+By7MDcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750506"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750506"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:36 -0700
X-CSE-ConnectionGUID: 6wERUOh3RYu/C17RNlvC2g==
X-CSE-MsgGUID: drD+kJKoQt2h5OeGJCtXVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176654996"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 03/27] coco/tdx-host: Support Link TSM for TDX host
Date: Fri, 19 Sep 2025 07:22:12 -0700
Message-ID: <20250919142237.418648-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@linux.intel.com>

Register a Link TSM instance to support host side TSM operations for
TDISP, when the TDX Connect support bit is set by TDX Module in
tdx_feature0.

This is the main purpose of an independent tdx-host module out of TDX
core. Recall that a TEE Security Manager (TSM) is a platform agent that
speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
devices and manages private memory resources for the platform. An
independent tdx-host module allows for device-security enumeration and
initialization flows to be deferred from other TDX Module initialization
requirements. Crucially, when / if TDX Module init moves earlier in x86
initialization flow this driver is still guaranteed to run after IOMMU
and PCI init (i.e. subsys_initcall() vs device_initcall()).

The ability to unload the module, or unbind the driver is also useful
for debug and coarse grained transitioning between PCI TSM operation and
PCI CMA operation (native kernel PCI device authentication).

For now this is the basic boilerplate with operation flows to be added
later.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx.h            |   1 +
 drivers/virt/coco/tdx-host/Kconfig    |   6 ++
 drivers/virt/coco/tdx-host/tdx-host.c | 145 +++++++++++++++++++++++++-
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 4ce3a302d9ba..166795e34c8f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -126,6 +126,7 @@ int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TDXCONNECT	BIT_ULL(6)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 
 const struct tdx_sys_info *tdx_get_sysinfo(void);
diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index bf6be0fc0879..026b7d5ea4fa 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -8,3 +8,9 @@ config TDX_HOST_SERVICES
 
 	  Say y or m if enabling support for confidential virtual machine
 	  support (CONFIG_INTEL_TDX_HOST). The module is called tdx_host.ko
+
+config TDX_CONNECT
+	bool
+	depends on TDX_HOST_SERVICES
+	depends on PCI_TSM
+	default TDX_HOST_SERVICES
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 49c205913ef6..41813ba352d0 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -8,7 +8,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pci.h>
+#include <linux/pci-tsm.h>
 #include <linux/sysfs.h>
+#include <linux/tsm.h>
 #include <linux/device/faux.h>
 #include <asm/cpu_device_id.h>
 #include <asm/tdx.h>
@@ -20,6 +23,146 @@ static const struct x86_cpu_id tdx_host_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
 
+/*
+ * The scope of this pointer is for TDX Connect.
+ * Every feature should evaluate how to get tdx_sysinfo. TDX Connect expects no
+ * tdx_sysinfo change after TDX Module update so could cache it. TDX version
+ * sysfs expects change so should call tdx_get_sysinfo() every time.
+ *
+ * Maybe move TDX Connect to a separate file makes thing clearer.
+ */
+static const struct tdx_sys_info *tdx_sysinfo;
+
+struct tdx_link {
+	struct pci_tsm_pf0 pci;
+};
+
+static struct tdx_link *to_tdx_link(struct pci_tsm *tsm)
+{
+	return container_of(tsm, struct tdx_link, pci.base_tsm);
+}
+
+static int tdx_link_connect(struct pci_dev *pdev)
+{
+	return -ENXIO;
+}
+
+static void tdx_link_disconnect(struct pci_dev *pdev)
+{
+}
+
+static struct pci_tsm_ops tdx_link_ops;
+
+static struct pci_tsm *tdx_link_pf0_probe(struct tsm_dev *tsm_dev,
+					  struct pci_dev *pdev)
+{
+	int rc;
+
+	struct tdx_link *tlink __free(kfree) =
+		kzalloc(sizeof(*tlink), GFP_KERNEL);
+	if (!tlink)
+		return NULL;
+
+	rc = pci_tsm_pf0_constructor(pdev, &tlink->pci, tsm_dev->pci_ops);
+	if (rc)
+		return NULL;
+
+	return &no_free_ptr(tlink)->pci.base_tsm;
+}
+
+static void tdx_link_pf0_remove(struct pci_tsm *tsm)
+{
+	struct tdx_link *tlink = to_tdx_link(tsm);
+
+	pci_tsm_pf0_destructor(&tlink->pci);
+	kfree(tlink);
+}
+
+static struct pci_tsm *tdx_link_fn_probe(struct tsm_dev *tsm_dev,
+					 struct pci_dev *pdev)
+{
+	int rc;
+
+	struct pci_tsm *pci_tsm __free(kfree) =
+		kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
+	if (!pci_tsm)
+		return NULL;
+
+	rc = pci_tsm_link_constructor(pdev, pci_tsm, tsm_dev->pci_ops);
+	if (rc)
+		return NULL;
+
+	return no_free_ptr(pci_tsm);
+}
+
+static struct pci_tsm *tdx_link_probe(struct tsm_dev *tsm_dev, struct pci_dev *pdev)
+{
+	if (is_pci_tsm_pf0(pdev))
+		return tdx_link_pf0_probe(tsm_dev, pdev);
+
+	return tdx_link_fn_probe(tsm_dev, pdev);
+}
+
+static void tdx_link_remove(struct pci_tsm *tsm)
+{
+	if (is_pci_tsm_pf0(tsm->pdev)) {
+		tdx_link_pf0_remove(tsm);
+		return;
+	}
+
+	/* for sub-functions */
+	kfree(tsm);
+}
+
+static struct pci_tsm_ops tdx_link_ops = {
+	.probe = tdx_link_probe,
+	.remove = tdx_link_remove,
+	.connect = tdx_link_connect,
+	.disconnect = tdx_link_disconnect,
+};
+
+static struct tsm_dev *link_dev;
+
+static void unregister_link_tsm(void *data)
+{
+	tsm_unregister(link_dev);
+}
+
+static int tdx_connect_init(struct device *dev)
+{
+	struct tsm_dev *link;
+
+	if (!IS_ENABLED(CONFIG_TDX_CONNECT))
+		return 0;
+
+	tdx_sysinfo = tdx_get_sysinfo();
+	if (!tdx_sysinfo)
+		return -ENXIO;
+
+	if (!(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
+		return 0;
+
+	link = tsm_register(dev, &tdx_link_ops);
+	if (IS_ERR(link)) {
+		dev_err(dev, "failed to register TSM: (%pe)\n", link);
+		return PTR_ERR(link);
+	}
+
+	link_dev = link;
+
+	return devm_add_action_or_reset(dev, unregister_link_tsm, NULL);
+}
+
+static int tdx_host_probe(struct faux_device *fdev)
+{
+	/* Only support TDX Connect now. More TDX features could be added here. */
+	return tdx_connect_init(&fdev->dev);
+}
+
+static struct faux_device_ops tdx_host_ops = {
+	.probe = tdx_host_probe,
+};
+
 static struct faux_device *fdev;
 
 static int __init tdx_host_init(void)
@@ -34,7 +177,7 @@ static int __init tdx_host_init(void)
 	if (r)
 		return r;
 
-	fdev = faux_device_create(KBUILD_MODNAME, NULL, NULL);
+	fdev = faux_device_create(KBUILD_MODNAME, NULL, &tdx_host_ops);
 	if (!fdev)
 		return -ENODEV;
 
-- 
2.51.0


