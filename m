Return-Path: <linux-pci+bounces-28348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA4AC2A18
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B009A42462
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A544429AB07;
	Fri, 23 May 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLZqwulY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CE29AB04;
	Fri, 23 May 2025 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026816; cv=none; b=X8lRQFma5Cf5gwRHoYb+6WQftKQ2XmyTZ1vG47x4NgIcJ6Uqm44n3GO6FeVlrvTS9LTKB8nVFtaA4VJupuUu3DW9Rk0S2BtuPyKwidPxE+URZbiiZtPsKd5hRsOPXPIyooJx64eLlNSWwRX69CnlLt/iimr2+1MOvZPG+OXC1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026816; c=relaxed/simple;
	bh=b8/kMQ/FsDCaYXXWww0z3hlfMYO0pN/0TiF2OzI9tQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAC2onCoiZIqZvBAA2QsBx47IGHLzXUNKolvI9lispq7tPQ16dl7M/W+cNazhjZ5mxoZxldN0hSZdOYMfenK5fYX/Cl92Dd1m5zJxiHoxQve3GAjBgAj0Pd0yTiRQvvZuiNZdPgTz9saNOYoqPRcCV6TGW+0r/W+jxn5FU/+/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLZqwulY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026814; x=1779562814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b8/kMQ/FsDCaYXXWww0z3hlfMYO0pN/0TiF2OzI9tQY=;
  b=ZLZqwulYAIQzA3ZXSqsiFr8DS9pJAGHLrVfVqcLjlwaJ5bBGgI2NnXk1
   wSlgbmODzDplGkezzv2qTGz5GmNgSU10J6e1PDBQnJjlgI6Kav9KXRxj0
   hMus0btormkJF6qKAAdXBAjBXMTQS3TwwRTbDn+39aFEmF2iNfNUJu+u/
   PPgWn9IgwduScOZg43ELYVJwr5L7yrT1CZiI9LpKpBT3NKCL0r6SExYY8
   crxbOgbLrQwpRBz2d4dHVhYLNecJqBQtqXeFxn0OUObHijyhEgjdmQcz8
   d/xL0fkQWClMi22oRfbi9lhRctza6ovk2cYYt9bgNGKy7lRM4UXHrsPEX
   A==;
X-CSE-ConnectionGUID: kf8AgD7hSt2tUmvr6JLm0w==
X-CSE-MsgGUID: WvzgZMDyQJeUYqjyQ2vUBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498564"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:13 -0700
X-CSE-ConnectionGUID: OO2v4yrHSJ+Wn+zVD0ASAQ==
X-CSE-MsgGUID: vYZkvnNxRzap15N2ZuqyVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141758984"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:10 -0700
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
Subject: [PATCH v3 07/11] drm/xe/vrsr: Enable VRSR on default VGA boot device
Date: Sat, 24 May 2025 00:31:51 +0530
Message-Id: <20250523190155.2623462-8-badal.nilawar@intel.com>
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

The VRSR feature is to enhance the display screen refresh experience
when the device exits from the D3Cold state. Therefore, apply the VRSR
feature to the default VGA boot device and when a display is connected.

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/xe/display/xe_display.h |  2 ++
 drivers/gpu/drm/xe/xe_pm.c              |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 20c3bcd953b7..b3da88b12b35 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -88,6 +88,28 @@ static void display_destroy(struct drm_device *dev, void *dummy)
 	destroy_workqueue(xe->display.hotplug.dp_wq);
 }
 
+bool xe_display_connected(struct xe_device *xe)
+{
+	struct drm_connector *list_connector;
+	struct drm_connector_list_iter iter;
+	bool ret = false;
+
+	mutex_lock(&xe->drm.mode_config.mutex);
+	drm_connector_list_iter_begin(&xe->drm, &iter);
+
+	drm_for_each_connector_iter(list_connector, &iter) {
+		if (list_connector->status == connector_status_connected) {
+			ret = true;
+			break;
+		}
+	}
+
+	drm_connector_list_iter_end(&iter);
+	mutex_unlock(&xe->drm.mode_config.mutex);
+
+	return ret;
+}
+
 /**
  * xe_display_create - create display struct
  * @xe: XE device instance
diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
index 46e14f8dee28..a432790d6d34 100644
--- a/drivers/gpu/drm/xe/display/xe_display.h
+++ b/drivers/gpu/drm/xe/display/xe_display.h
@@ -39,6 +39,7 @@ void xe_display_pm_resume(struct xe_device *xe);
 void xe_display_pm_runtime_suspend(struct xe_device *xe);
 void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
 void xe_display_pm_runtime_resume(struct xe_device *xe);
+bool xe_display_connected(struct xe_device *xe);
 
 #else
 
@@ -71,5 +72,6 @@ static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_suspend_late(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
 
+static inline bool xe_display_connected(struct xe_device *xe) {}
 #endif /* CONFIG_DRM_XE_DISPLAY */
 #endif /* _XE_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 278f2eeeaab6..c84b9b3f7371 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -9,6 +9,7 @@
 #include <linux/fault-inject.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
+#include <linux/vgaarb.h>
 
 #include <drm/drm_managed.h>
 #include <drm/ttm/ttm_placement.h>
@@ -310,6 +311,7 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
 
 static void xe_pm_vrsr_init(struct xe_device *xe)
 {
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 	int ret;
 
 	/* Check if platform support D3Cold VRSR */
@@ -319,6 +321,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
 	if (!xe_pm_vrsr_capable(xe))
 		return;
 
+	if (pdev != vga_default_device() || !xe_display_connected(xe))
+		return;
+
 	/*
 	 * If the VRSR initialization fails, the device will proceed with the regular
 	 * D3Cold flow
-- 
2.34.1


