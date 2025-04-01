Return-Path: <linux-pci+bounces-25080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B6A77F1B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8104A188F01A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84920AF84;
	Tue,  1 Apr 2025 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R48QtlZj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760E20AF92;
	Tue,  1 Apr 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521797; cv=none; b=pz1o6aO+DejM0IkusTfiC+eI2SsZFTQt/QOb3clGmDiFnfc/rPg0Ohfpy0ieZNZYYHnl/35pMVmcH3u5EDtYAlxcHVCAXSXdiq+89r2vV14KnF7NHT+vAkT4wtriYE1o3dAKvS3N5CMm32BL0WOX7/TrIKbADajOHK4dcVSy5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521797; c=relaxed/simple;
	bh=xKgkCLkKfYwa70Vqlgkw8ZfmHYnSeCmrJ7cFXTNhC/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka5jtJxT2gOvAvllM0f1ckJWNARgQpWF1NeTJGyVq4ohhBbwXvbPjono2CobVuyQ2rD4/w8yVD4j45TYJj6rnKCZjtNHLsTTY+aoiZ1bQeEnCHVv864SX1pT7Lc7PVmQWnvCL3mSWrs74t3qgRFXU+mpWY+6aNljbRIizkQIblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R48QtlZj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521796; x=1775057796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xKgkCLkKfYwa70Vqlgkw8ZfmHYnSeCmrJ7cFXTNhC/I=;
  b=R48QtlZjtz6mvoLH1rrzOHNMXiKFGlTUkswQ7DlQ+sGRtFgYkxtcEELw
   vVKRHvDztBcUgI9w4WYKXV+JOXcPbarYBnwks3s6JWJ4pnzXl2KErD6dk
   lodC3SVa2ZIuWRWMuV5m+AWCbQcvl+SA51JgjxfX7OMnvGDobUCIvzv1D
   i320be4SxeTuntJxnf91NBI52nJrAlF5B2bzIuZ4RsNU6CB2xlRA7WTPT
   iCT9IreSHGkKwKVcP6wz7UFg6LygctVB/vFeec26YdqJSqmcFxJ01g++z
   Nyo+4ZcAnYMu90DO6kBgLfmlwyNKlhacJPg76aLRUUy7+j/eGE2mVBRlC
   g==;
X-CSE-ConnectionGUID: rGL+PSCLTiWdQtS7tsCR2w==
X-CSE-MsgGUID: AGIBJ5eLRdKau16Duf1IRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324926"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324926"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:31 -0700
X-CSE-ConnectionGUID: y1SxeoRtSbWcHn7jYDYxVw==
X-CSE-MsgGUID: 7EuT3IHJRtSuUJ4MwScQmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410946"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:27 -0700
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
	anshuman.gupta@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH 07/12] drm/xe/vrsr: Enable VRSR on default VGA boot device
Date: Tue,  1 Apr 2025 21:02:20 +0530
Message-ID: <20250401153225.96379-8-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401153225.96379-1-anshuman.gupta@intel.com>
References: <20250401153225.96379-1-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Badal Nilawar <badal.nilawar@intel.com>

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
index 23937ed3b33d..a7a50f48f1c5 100644
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
index abb5099475cb..364b937e0ded 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -8,6 +8,7 @@
 #include <linux/fault-inject.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
+#include <linux/vgaarb.h>
 
 #include <drm/drm_managed.h>
 #include <drm/ttm/ttm_placement.h>
@@ -300,6 +301,7 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
 
 static void xe_pm_vrsr_init(struct xe_device *xe)
 {
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 	int ret;
 
 	/* Check if platform support d3cold vrsr */
@@ -309,6 +311,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
 	if (!xe_pm_vrsr_capable(xe))
 		return;
 
+	if (pdev != vga_default_device() || !xe_display_connected(xe))
+		return;
+
 	/*
 	 * If the VRSR initialization fails, the device will proceed with the regular
 	 * D3 Cold flow
-- 
2.43.0


