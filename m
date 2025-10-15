Return-Path: <linux-pci+bounces-38169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD94BDD4A3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E5E421E7B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0892E26FD84;
	Wed, 15 Oct 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJJDYOiq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4A2D23AD;
	Wed, 15 Oct 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515370; cv=none; b=G1QUgpKmOLJMv/Hg7KQ8fSLkZvNpPASBUDjw+mC/gxZuEjQe6FM4DV4q6LVqmsbW0kqvIrRROAAOjMqcGHxSY8NjTBCtMNb1gHsoVaYTaakNtwO7iNfdQudlE/yFj5g2lfhXJlD/EW/OPfqn2HtU2Oe2/eWjMhhkG1OIIOscl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515370; c=relaxed/simple;
	bh=0UVuwwmQkbWAw3LEvhz+aRJRJuTQwB+d7gAQweM7Xuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o9wC3K7xDcKKp9e3Y0sgkLTqwkpPBc3q7ghubtj/VLMaPyCFTTeYgBV1kYv51ra2Ob73e+3jyPQpqBh3mI52eDmeGtGxiAMZBrS+mujueqIvY4C/0wYWq0pmqKNMeF0U1N0PAOB8HwBXAXb1elXxX5EQM9L1BH4Li68OqIk/Evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJJDYOiq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515369; x=1792051369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UVuwwmQkbWAw3LEvhz+aRJRJuTQwB+d7gAQweM7Xuc=;
  b=hJJDYOiqr737FMrN7ykXn8kazilESL8QOnH+dHh+xAZO3KGNogeE4EUn
   iASget4yOf/0y13OW/aYXxvVvvBQeb4GtEkdrpl+MfcQJ8f6fIRP2l/lp
   896WQNJprp1xbWMjovi6QSfabfIpu5ZU80CY6pPYsurBRf0I7X2H3u06k
   5CpAHOrjC/h4HlR9RLMnTUClsQpfjZdsiaafqtKLQuTbkhLKPLm0xygik
   m2OoNb6ZTE8NXfWH9qJGAwQX9smYH/H7523GDh3DimEWyo5ln3jqV7k01
   cZmLWM/f9tQM8rcGeans1QYssIeyVZ1c16BMfop8fuwanDDf6BTyw2QVJ
   Q==;
X-CSE-ConnectionGUID: nyc9SKs1TtaPz5wFZgozdg==
X-CSE-MsgGUID: hwQOYOJfSGah4/5zz9oKuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891486"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891486"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:49 -0700
X-CSE-ConnectionGUID: Ow5o/Lm5RxmUFICkxcizlA==
X-CSE-MsgGUID: JmywIcLBRsydWwqzgWbbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805417"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:44 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v5 06/12] drm/xe/vrsr: Initialize VRSR feature
Date: Wed, 15 Oct 2025 13:37:04 +0530
Message-Id: <20251015080710.1468409-7-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015080710.1468409-1-badal.nilawar@intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the API xe_pm_vrsr_enable to initialize the VRSR feature,
requesting AUX power limit and PERST# assertion delay.

V2: Add retry mechanism while requesting AUX power limit
V3: Split xe_pm_vrsr_enable() into separate enable and
    disable functions

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
V3:
 - Drop unnecessary comments
---
 drivers/gpu/drm/xe/xe_device_types.h |   1 +
 drivers/gpu/drm/xe/xe_pcode_api.h    |   7 ++
 drivers/gpu/drm/xe/xe_pm.c           | 110 ++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_pm.h           |   2 +
 4 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index d94fee10d041..da81e1937918 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -7,6 +7,7 @@
 #define _XE_DEVICE_TYPES_H_
 
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
diff --git a/drivers/gpu/drm/xe/xe_pcode_api.h b/drivers/gpu/drm/xe/xe_pcode_api.h
index 92bfcba51e19..c9922cf43c07 100644
--- a/drivers/gpu/drm/xe/xe_pcode_api.h
+++ b/drivers/gpu/drm/xe/xe_pcode_api.h
@@ -65,6 +65,13 @@
 #define       FAN_TABLE				1
 #define       VR_CONFIG				2
 
+#define	  PCODE_D3_VRAM_SELF_REFRESH	0x71
+#define	    PCODE_D3_VRSR_SC_DISABLE	0x0
+#define	    PCODE_D3_VRSR_SC_ENABLE	0x1
+#define     PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY	0x2
+#define	    POWER_D3_VRSR_PERST_MASK	REG_GENMASK(31, 16)
+#define	    POWER_D3_VRSR_AUX_PL_MASK	REG_GENMASK(15, 0)
+
 #define   PCODE_FREQUENCY_CONFIG		0x6e
 /* Frequency Config Sub Commands (param1) */
 #define     PCODE_MBOX_FC_SC_READ_FUSED_P0	0x0
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index b9cd48359e6f..d95de9015ef5 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -5,6 +5,7 @@
 
 #include "xe_pm.h"
 
+#include <linux/delay.h>
 #include <linux/fault-inject.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -25,6 +26,7 @@
 #include "xe_irq.h"
 #include "xe_late_bind_fw.h"
 #include "xe_mmio.h"
+#include "xe_pcode_api.h"
 #include "xe_pcode.h"
 #include "xe_pxp.h"
 #include "xe_sriov_vf_ccs.h"
@@ -334,6 +336,112 @@ static bool xe_pm_vrsr_capable(struct xe_device *xe)
 	return val & VRAM_SR_SUPPORTED;
 }
 
+static int pci_acpi_aux_power_setup(struct xe_device *xe)
+{
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	int ret;
+	u32 uval;
+	u32 aux_pwr_limit;
+	u32 retry_interval;
+	u32 perst_delay;
+
+	ret = xe_pcode_read(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
+						  PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY, 0),
+			    &uval, NULL);
+	if (ret)
+		return ret;
+
+	aux_pwr_limit = REG_FIELD_GET(POWER_D3_VRSR_AUX_PL_MASK, uval);
+	perst_delay = REG_FIELD_GET(POWER_D3_VRSR_PERST_MASK, uval);
+
+	drm_dbg(&xe->drm, "Aux Power limit = %d mW\n", aux_pwr_limit);
+	drm_dbg(&xe->drm, "PERST# Assertion delay = %d microseconds\n", perst_delay);
+
+retry:
+	ret = pci_acpi_request_d3cold_aux_power(pdev, aux_pwr_limit, &retry_interval);
+
+	if (ret == -EAGAIN) {
+		drm_warn(&xe->drm, "D3cold Aux Power request needs retry interval: %d seconds\n",
+			 retry_interval);
+		msleep(retry_interval * 1000);
+		goto retry;
+	}
+
+	if (ret)
+		return ret;
+
+	ret = pci_acpi_add_perst_assertion_delay(pdev, perst_delay);
+
+	return ret;
+}
+
+static void xe_pm_vrsr_init(struct xe_device *xe)
+{
+	int ret;
+
+	if (!xe->info.has_vrsr)
+		return;
+
+	if (!xe_pm_vrsr_capable(xe))
+		return;
+
+	/*
+	 * If the VRSR initialization fails, the device will proceed with the regular
+	 * D3cold flow
+	 */
+	ret = pci_acpi_aux_power_setup(xe);
+	if (ret) {
+		drm_info(&xe->drm, "VRSR capable: No\n");
+		return;
+	}
+
+	xe->d3cold.vrsr_capable = true;
+	drm_info(&xe->drm, "VRSR capable: Yes\n");
+}
+
+/**
+ * xe_pm_vrsr_enable - Enable VRAM self refresh
+ * @xe: The xe device.
+ *
+ * Enable VRSR feature in D3cold path.
+ *
+ * Return: It returns 0 on success and errno on failure.
+ */
+int xe_pm_vrsr_enable(struct xe_device *xe)
+{
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+	int ret;
+
+	if (!xe->d3cold.vrsr_capable)
+		return -ENXIO;
+
+	drm_dbg(&xe->drm, "Enabling VRSR\n");
+
+	ret = xe_pcode_write(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
+						   PCODE_D3_VRSR_SC_ENABLE, 0), 0);
+	return ret;
+}
+
+/**
+ * xe_pm_vrsr_disable - Disable VRAM self refresh
+ * @xe: The xe device.
+ *
+ * Disable VRSR feature in D3cold path.
+ */
+void xe_pm_vrsr_disable(struct xe_device *xe)
+{
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+
+	if (!xe->d3cold.vrsr_capable)
+		return;
+
+	drm_dbg(&xe->drm, "Disabling VRSR\n");
+
+	xe_pcode_write(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
+					     PCODE_D3_VRSR_SC_DISABLE, 0), 0);
+}
+
 static void xe_pm_runtime_init(struct xe_device *xe)
 {
 	struct device *dev = xe->drm.dev;
@@ -478,7 +586,7 @@ int xe_pm_init(struct xe_device *xe)
 		err = xe_pm_set_vram_threshold(xe, vram_threshold);
 		if (err)
 			goto err_unregister;
-		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
+		xe_pm_vrsr_init(xe);
 	}
 
 	xe_pm_runtime_init(xe);
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index f7f89a18b6fc..3d5a8c4a4971 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -37,4 +37,6 @@ int xe_pm_block_on_suspend(struct xe_device *xe);
 void xe_pm_might_block_on_suspend(void);
 int xe_pm_module_init(void);
 
+int xe_pm_vrsr_enable(struct xe_device *xe);
+void xe_pm_vrsr_disable(struct xe_device *xe);
 #endif
-- 
2.34.1


