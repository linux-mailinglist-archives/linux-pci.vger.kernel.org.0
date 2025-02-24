Return-Path: <linux-pci+bounces-22240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D796BA42854
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAD03BAB41
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEDE262D3D;
	Mon, 24 Feb 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BY/CmnMc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE12627F2;
	Mon, 24 Feb 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415824; cv=none; b=FDqkWvTOVNXy22CYHUeRrWjJt+9lIoY0RqntYwtLCfMVstLbY3nC7llN9iRyVqKNlmTrJuXA19PKVGdaCn69/nYH8fcPOIwbbU/Wdtf0NnecivHOmCj/l39dq8ppVToBl9jb/2+ZNax4J2RP+PbGc7xtpsN57yo0uGdYkzA+nBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415824; c=relaxed/simple;
	bh=+VSq8t/cjruGjXyrrBNMU0t1tehS5dyrGixCSIJlSag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6H0h2iKdWDismR56uN+oAqLYxu8r15dj/uTRnzny2pF8EPN1wUw6/O5ebQnWtZvn3Xp7S0GeqeR6GiYujby9Sar1D/ZBARFH5V6QyaSdu0QjWcAPT1wiMXCaqRw2OO+rqk2DnXBHdmvaXS5WYasECQaJlLgdb9+TFJ5qR5Jc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BY/CmnMc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740415823; x=1771951823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+VSq8t/cjruGjXyrrBNMU0t1tehS5dyrGixCSIJlSag=;
  b=BY/CmnMcpiQy4faceqOoOnj6k0+qYxtsZhtyVQB/SKk3ngnk/eYa6Ice
   JRItUcyILA3wE0uItte3DUGqbJ1H5bgYmMM3PuGOrka5F6c8j1PCv7HuC
   tbrxZXeFJzWPS45QuyT9et82QNXCp90emiglJ09gYWGLogGzmC701ZkP6
   v5R/anXYyy1umrW7ZL9M1Hp0w+dHKSscH8pd/p6pDJ5NhcnCoHewZXiV9
   9nY5sl77qA5QsAQRKYOfLsG+QD4zoe5G+yFlMYEzv8d+nAHKMfkXFsxJ1
   T5QCmerHIlTWVtgJQEhNMMCQPC0LyLyKXa1aTXmVUO9STSLBGbUeb21vX
   g==;
X-CSE-ConnectionGUID: nuXlQCOLTxK4+uLcxn6YpQ==
X-CSE-MsgGUID: OBIUJQy8RBalrcr9kZs08A==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41063200"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41063200"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:23 -0800
X-CSE-ConnectionGUID: J9CzIbvPRYWuC6dsnrMeqA==
X-CSE-MsgGUID: cZTvowkxQu+pkDcfGc/Vrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121032389"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:19 -0800
From: Anshuman Gupta <anshuman.gupta@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	badal.nilawar@intel.com,
	kam.nasim@intel.com,
	Anshuman Gupta <anshuman.gupta@intel.com>
Subject: [RFC 3/6] drm/xe/vrsr: Apis to init and enable VRSR feature
Date: Mon, 24 Feb 2025 22:18:46 +0530
Message-Id: <20250224164849.3746751-4-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224164849.3746751-1-anshuman.gupta@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Badal Nilawar <badal.nilawar@intel.com>

APIs to enable and initialize VRSR feature.

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  1 +
 drivers/gpu/drm/xe/xe_pcode_api.h    |  8 +++
 drivers/gpu/drm/xe/xe_pm.c           | 91 ++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_pm.h           |  3 +
 4 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index c2ab2c91c968..da7946b75cd5 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -7,6 +7,7 @@
 #define _XE_DEVICE_TYPES_H_
 
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
diff --git a/drivers/gpu/drm/xe/xe_pcode_api.h b/drivers/gpu/drm/xe/xe_pcode_api.h
index 2bae9afdbd35..17a90b2c6737 100644
--- a/drivers/gpu/drm/xe/xe_pcode_api.h
+++ b/drivers/gpu/drm/xe/xe_pcode_api.h
@@ -42,6 +42,14 @@
 #define	    POWER_SETUP_I1_SHIFT		6	/* 10.6 fixed point format */
 #define	    POWER_SETUP_I1_DATA_MASK		REG_GENMASK(15, 0)
 
+#define	  PCODE_D3_VRAM_SELF_REFRESH	0x71
+#define	    PCODE_D3_VRSR_SC_DISABLE	0x0
+#define	    PCODE_D3_VRSR_SC_ENABLE	0x1
+#define     PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY	0x2
+#define     PCODE_D3_VRSR_PERST_SHIFT	16
+#define	    POWER_D3_VRSR_PSERST_MASK	REG_GENMASK(31, 16)
+#define	    POWER_D3_VRSR_AUX_PL_MASK	REG_GENMASK(15, 0)
+
 #define   PCODE_FREQUENCY_CONFIG		0x6e
 /* Frequency Config Sub Commands (param1) */
 #define     PCODE_MBOX_FC_SC_READ_FUSED_P0	0x0
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index dead236355d8..32583651988f 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -23,6 +23,7 @@
 #include "xe_guc.h"
 #include "xe_irq.h"
 #include "xe_mmio.h"
+#include "xe_pcode_api.h"
 #include "xe_pcode.h"
 #include "xe_pxp.h"
 #include "regs/xe_regs.h"
@@ -85,6 +86,92 @@ static struct lockdep_map xe_pm_runtime_nod3cold_map = {
 };
 #endif
 
+/**
+ * xe_pm_init_vrsr - Initialize VRAM self refresh
+ * @xe: The xe device
+ *
+ * This function reads the AUX power and PERST assertion delay from pcode.
+ * Then request host BIOS via ACPI _DSM to grant required AUX power and PERST
+ * assertion delay.
+ *
+ * Return: returns 0 on success and errno on failure
+ */
+int xe_pm_init_vrsr(struct xe_device *xe)
+{
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct pci_dev *root_pdev;
+	int ret;
+	u32 uval;
+	u32 aux_pwr_limit;
+	u32 perst_delay;
+
+	root_pdev = pcie_find_root_port(pdev);
+	if (!root_pdev)
+		return -EINVAL;
+
+	/* Avoid Illegal Subcommand error */
+	if (xe->info.platform != XE_BATTLEMAGE)
+		return -ENXIO;
+
+	ret = xe_pcode_read(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
+			    PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY, 0),
+			    &uval, NULL);
+
+	if (ret)
+		return ret;
+
+	aux_pwr_limit = REG_FIELD_GET(POWER_D3_VRSR_AUX_PL_MASK, uval);
+	perst_delay = REG_FIELD_GET(POWER_D3_VRSR_PSERST_MASK, uval);
+
+	drm_dbg(&xe->drm, "AUX POWER LIMIT =%d\n", aux_pwr_limit);
+	drm_dbg(&xe->drm, "PERST Assertion delay =%d\n", perst_delay);
+
+	ret = pci_acpi_request_d3cold_aux_power(root_pdev, aux_pwr_limit);
+	if (ret)
+		goto vrsr;
+
+	ret = pci_acpi_add_perst_assertion_delay(root_pdev, perst_delay);
+	if (ret)
+		goto vrsr;
+
+	return ret;
+
+vrsr:
+	drm_err(&xe->drm, "ACPI DSM failed, VRSR is not capable\n");
+	xe->d3cold.vrsr_capable = false;
+	return ret;
+}
+
+/**
+ * xe_pm_enable_vrsr - Enable VRAM self refresh
+ * @xe: The xe device.
+ * @enable: true: Enable, false: Disable
+ *
+ * This function enables the VRSR feature in D3Cold path.
+ *
+ * Return: It returns 0 on success and errno on failure.
+ */
+int xe_pm_enable_vrsr(struct xe_device *xe, bool enable)
+{
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+	int ret;
+	u32 uval = 0;
+
+	/* Avoid Illegal Subcommand error */
+	if (xe->info.platform != XE_BATTLEMAGE)
+		return -ENXIO;
+
+	if (enable)
+		ret = xe_pcode_write(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
+				     PCODE_D3_VRSR_SC_ENABLE, 0), uval);
+	else
+		ret = xe_pcode_write(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
+				     PCODE_D3_VRSR_SC_DISABLE, 0), uval);
+
+	return ret;
+}
+
 /**
  * xe_rpm_reclaim_safe() - Whether runtime resume can be done from reclaim context
  * @xe: The xe device.
@@ -330,6 +417,10 @@ int xe_pm_init(struct xe_device *xe)
 			return err;
 
 		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
+		if (xe->d3cold.vrsr_capable) {
+			drm_dbg(&xe->drm, "vram sr capable\n");
+			xe_pm_init_vrsr(xe);
+		}
 	}
 
 	xe_pm_runtime_init(xe);
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index 998d1ed64556..c9f176912b46 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -35,4 +35,7 @@ bool xe_rpm_reclaim_safe(const struct xe_device *xe);
 struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
 int xe_pm_module_init(void);
 
+int xe_pm_init_vrsr(struct xe_device *xe);
+int xe_pm_enable_vrsr(struct xe_device *xe, bool enable);
+
 #endif
-- 
2.34.1


