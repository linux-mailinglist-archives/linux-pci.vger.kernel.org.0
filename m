Return-Path: <linux-pci+bounces-44635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C05DD1A4FC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18139307E247
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B92853EE;
	Tue, 13 Jan 2026 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fK+EQ8Db"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200B1B3925;
	Tue, 13 Jan 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321942; cv=none; b=SUQ1eFKBwmrzWsLucvzyKa+FjXfJFbTk52WviM8ISvU3dPxN+g+mfuTLnJZhjRNgTIA9RvC/5pJNQFMl3ccXN11aaryJLtk8opGt6EeBzX+hfhv/j8hwtkQJndNtdrdnhCwAgIbtFgfC2LM+1nHyhVHEqMrYCNyAbJd+/g4nyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321942; c=relaxed/simple;
	bh=7cNGG67qoH5SWkfxlzLiQ3+wl/tvwAkPVXnjQVVNpmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUwkH9MGAg1KNgu++YdMh+ncTzCHVPnGZLMVZzRk5HtKH3AtVFKcGRsS9LC5zYBujGpQbnuDqgJRJEJgm3T3T1KgsUXl+RgT3mqky0hyFrerOTf3Y1OEs5nohJDPrpMfXChVtTuGsHkjb6kmYSVpS1+XN45YHjMkaH3sfB9y5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fK+EQ8Db; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321940; x=1799857940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7cNGG67qoH5SWkfxlzLiQ3+wl/tvwAkPVXnjQVVNpmY=;
  b=fK+EQ8DbZ3CeMPZusgZLuN9jsoT34Dh+O9oVk6h7HEfadXvDBACiu6fa
   iQkJe+goG4M8lqvWBtnNt7KMEBwCAqfRHo7pB3aKva0+ArOn/OYdfvcMB
   pWu1z1bI/PClvRvqzH/AHys4F1O5DpSRoj7GLA8XdoU7MsDbTG1aD+NTe
   OqPvyLtd054aSB5jiOPyFFrCA47QzaGj0ScEZf0BTyw8xoP00BJIg+R3T
   svor0ixPu5i9HKHekTXlYr9EbTyd9UFIxpNxk5Ahp+91cvdr5u/0Peoox
   iR0HfpEGfiy+WHAR7D7WZ/RU5dj3E6l4z/x7VVV8MgcWKu8S7m3Ms+W1H
   g==;
X-CSE-ConnectionGUID: 3bS5OtuZRKm7yocto7Pb8Q==
X-CSE-MsgGUID: tDjWkQAQQ/COuKorlnhj2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521030"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521030"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:20 -0800
X-CSE-ConnectionGUID: Abp1VGbiRzitBpa3W792uw==
X-CSE-MsgGUID: uWA4rMqmQIWHgrFZ7y5neg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060142"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:15 -0800
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	karthik.poosa@intel.com,
	matthew.auld@intel.com,
	sk.anirban@intel.com,
	raag.jadav@intel.com
Subject: [PATCH v6 05/12] drm/xe/vrsr: Initialize VRSR feature
Date: Tue, 13 Jan 2026 22:12:06 +0530
Message-ID: <20260113164200.1151788-19-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113164200.1151788-14-badal.nilawar@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
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
 drivers/gpu/drm/xe/xe_device_types.h |   1 +
 drivers/gpu/drm/xe/xe_pcode_api.h    |   7 ++
 drivers/gpu/drm/xe/xe_pm.c           | 110 ++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_pm.h           |   2 +
 4 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 17a577772794..3b42400f8563 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -7,6 +7,7 @@
 #define _XE_DEVICE_TYPES_H_
 
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
diff --git a/drivers/gpu/drm/xe/xe_pcode_api.h b/drivers/gpu/drm/xe/xe_pcode_api.h
index 85cc7478b787..15687bb57c94 100644
--- a/drivers/gpu/drm/xe/xe_pcode_api.h
+++ b/drivers/gpu/drm/xe/xe_pcode_api.h
@@ -72,6 +72,13 @@
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
index 18a44b395559..3fe673f0f87d 100644
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
@@ -343,6 +345,112 @@ static bool xe_pm_vrsr_capable(struct xe_device *xe)
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
@@ -487,7 +595,7 @@ int xe_pm_init(struct xe_device *xe)
 		err = xe_pm_set_vram_threshold(xe, vram_threshold);
 		if (err)
 			goto err_unregister;
-		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
+		xe_pm_vrsr_init(xe);
 	}
 
 	xe_pm_runtime_init(xe);
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index 6b27039e7b2d..8c7fe8e4241d 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -54,4 +54,6 @@ DEFINE_GUARD_COND(xe_pm_runtime, _ioctl, xe_pm_runtime_get_ioctl(_T), _RET >= 0)
 DEFINE_GUARD(xe_pm_runtime_release_only, struct xe_device *,
 	     __xe_pm_runtime_noop(_T), xe_pm_runtime_put(_T));
 
+int xe_pm_vrsr_enable(struct xe_device *xe);
+void xe_pm_vrsr_disable(struct xe_device *xe);
 #endif
-- 
2.52.0


