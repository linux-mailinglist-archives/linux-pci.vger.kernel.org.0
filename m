Return-Path: <linux-pci+bounces-28347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367FFAC2A1C
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62087B26F9
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F86204C0F;
	Fri, 23 May 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii3PLHiA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E329A332;
	Fri, 23 May 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026816; cv=none; b=d1eaB426KRaubqbeSkbrG2w9Vritqcq16HSQaUJXYFNJxIfELZIc2kYZ+erE7CBJLR3PVFujycEfMx9WgRRn5dC2uacj/l6RZLMNp+r3HT7HQGovxa5MInoT4fN6FrsgM6c8Z5MtzrnQLGR9pj/G2m7Iu0I2eMVL95ST3OHllQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026816; c=relaxed/simple;
	bh=873J929uVhKxgx9Nzt4YTeekY9NUyNOpP4uG/ZPrMPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMD1OIJUq9u591BsVjCXiQi3J5dqBVXSvuveqKuuq5IZDadEOC0WlfxdsCH4ffoWHautx7fEKfnS4q0zrs/Q5guWBRBnyjh9BIKGUbIM3oQvSsGhBun8aa3t9IBQtzbOZXpLHwTYshgroxkivFUICxU69doHVLKVaY5Kulj0LfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii3PLHiA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026810; x=1779562810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=873J929uVhKxgx9Nzt4YTeekY9NUyNOpP4uG/ZPrMPA=;
  b=ii3PLHiAGxAuYdzUfABOIBpRScGs+C7NCPxVTkd7r/d1Sjla2guiZNRo
   XjlWbGBsi1BC6taeI9I8KCAMbcjPZpLDGyNXXxixasfXEZiyNxYHiavkA
   roYX33QOztOyg96Hk1jRMIas1x6fSv9xDmZ/V363dHgBYG17XtOpQa7F6
   zof+0zOdPzrMAWNk5rCFrSdPL26ABhctpMX7wWh/ue0pWkA97PEnwkqBg
   cNyDertqXlVTbvUhjmlsgTDMsYMEAmdcu98GEhKrYyP6FLqopUMA5wT5L
   atJYz27+pj9vZPhblswgbYQNT73sPSuRWWOsv6wuBr2VP13jVn2uTEkjx
   A==;
X-CSE-ConnectionGUID: TLni5GIvS92VU0DoJ1rf4A==
X-CSE-MsgGUID: ABROJC4FREmcC5zxpXtlww==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498538"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498538"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:10 -0700
X-CSE-ConnectionGUID: AIoy9JkURxKXNizMNs+Spw==
X-CSE-MsgGUID: 2TgAMN23RG2Cr5puas5CpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141758963"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:06 -0700
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
	uma.shankar@intel.com
Subject: [PATCH v3 06/11] drm/xe/vrsr: Initialize VRSR feature
Date: Sat, 24 May 2025 00:31:50 +0530
Message-Id: <20250523190155.2623462-7-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523190155.2623462-1-badal.nilawar@intel.com>
References: <20250523190155.2623462-1-badal.nilawar@intel.com>
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

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |   1 +
 drivers/gpu/drm/xe/xe_pcode_api.h    |   7 ++
 drivers/gpu/drm/xe/xe_pm.c           | 105 ++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_pm.h           |   1 +
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 3a15b3a252fd..5f9a1a358468 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -7,6 +7,7 @@
 #define _XE_DEVICE_TYPES_H_
 
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
diff --git a/drivers/gpu/drm/xe/xe_pcode_api.h b/drivers/gpu/drm/xe/xe_pcode_api.h
index 127d4d26c4cf..f54ef03799d4 100644
--- a/drivers/gpu/drm/xe/xe_pcode_api.h
+++ b/drivers/gpu/drm/xe/xe_pcode_api.h
@@ -43,6 +43,13 @@
 #define	    POWER_SETUP_I1_SHIFT		6	/* 10.6 fixed point format */
 #define	    POWER_SETUP_I1_DATA_MASK		REG_GENMASK(15, 0)
 
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
index c9395e62d21d..278f2eeeaab6 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -5,6 +5,7 @@
 
 #include "xe_pm.h"
 
+#include <linux/delay.h>
 #include <linux/fault-inject.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -23,6 +24,7 @@
 #include "xe_guc.h"
 #include "xe_irq.h"
 #include "xe_mmio.h"
+#include "xe_pcode_api.h"
 #include "xe_pcode.h"
 #include "xe_pxp.h"
 #include "xe_trace.h"
@@ -260,6 +262,107 @@ static bool xe_pm_vrsr_capable(struct xe_device *xe)
 	return val & VRAM_SR_SUPPORTED;
 }
 
+static int pci_acpi_aux_power_setup(struct xe_device *xe)
+{
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct pci_dev *root_pdev;
+	int ret;
+	u32 uval;
+	u32 aux_pwr_limit;
+	u32 retry_interval;
+	u32 perst_delay;
+
+	root_pdev = pcie_find_root_port(pdev);
+	if (!root_pdev)
+		return -EINVAL;
+
+	ret = xe_pcode_read(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
+			    PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY, 0),
+			    &uval, NULL);
+
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
+	ret = pci_acpi_request_d3cold_aux_power(root_pdev, aux_pwr_limit, &retry_interval);
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
+	ret = pci_acpi_add_perst_assertion_delay(root_pdev, perst_delay);
+
+	return ret;
+}
+
+static void xe_pm_vrsr_init(struct xe_device *xe)
+{
+	int ret;
+
+	/* Check if platform support D3Cold VRSR */
+	if (!xe->info.has_vrsr)
+		return;
+
+	if (!xe_pm_vrsr_capable(xe))
+		return;
+
+	/*
+	 * If the VRSR initialization fails, the device will proceed with the regular
+	 * D3Cold flow
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
+ * @enable: true: Enable, false: Disable
+ *
+ * This function enables the VRSR feature in D3Cold path.
+ *
+ * Return: It returns 0 on success and errno on failure.
+ */
+int xe_pm_vrsr_enable(struct xe_device *xe, bool enable)
+{
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+	int ret;
+	u32 uval = 0;
+
+	if (!xe->d3cold.vrsr_capable)
+		return -ENXIO;
+
+	drm_dbg(&xe->drm, "%s VRSR\n", enable ? "Enabling" : "Disabling");
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
 static void xe_pm_runtime_init(struct xe_device *xe)
 {
 	struct device *dev = xe->drm.dev;
@@ -374,7 +477,7 @@ int xe_pm_init(struct xe_device *xe)
 		err = xe_pm_set_vram_threshold(xe, vram_threshold);
 		if (err)
 			goto err_unregister;
-		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
+		xe_pm_vrsr_init(xe);
 	}
 
 	xe_pm_runtime_init(xe);
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index 59678b310e55..ba550281b130 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -35,4 +35,5 @@ bool xe_rpm_reclaim_safe(const struct xe_device *xe);
 struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
 int xe_pm_module_init(void);
 
+int xe_pm_vrsr_enable(struct xe_device *xe, bool enable);
 #endif
-- 
2.34.1


