Return-Path: <linux-pci+bounces-44637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D6D1A508
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A603089514
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE030AACE;
	Tue, 13 Jan 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFlpsBkI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20330AAC2;
	Tue, 13 Jan 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321950; cv=none; b=SNmSdAmWENTgro9g+pvDOu0/GYYzz3fYYSZQA9P+NHjiw4C72Nwa2ercpT93e2XTyG19yVqzt8DsmpwJyySuALRmEaFkRoc2zItviizkajV2vCiVxUJxqZKQlGebjrusmQ5I8faJGdM0MJCRz1nD76pVs+In22EoyoPdqg5+o1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321950; c=relaxed/simple;
	bh=mYrwNiA2k8xafq603ZILk7gxXgLvByt6C/KXs+s7d8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTXtqy1H7Gz9gDTqhCvidLncZzcei8wTf1STHyh9Kqk7edpBENALT6fDN2U7eIkM4NEkdrCJPDnjpdGcCT+u5pEJQoWTkHzgGswcdE2+8WjM6AfX4uT2YCgnJzkSr11TJo8kI12m4pVK+51wT3cZuVwwXe/CA0uVGG6XL/2a4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFlpsBkI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321949; x=1799857949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYrwNiA2k8xafq603ZILk7gxXgLvByt6C/KXs+s7d8Y=;
  b=aFlpsBkIJp3bW06OIXkwGyEwkpv7eyGdmembxroEXTAcc78oNCvaFLt6
   v8WJ6+9HAFEvym23QBZ0qzeP/l4q374QoTNi/lz/oDGVHZVlIYSHbXQwj
   F6dQYmQ62hXGBrzHUXMayAuNAbNJ6VzAH+sZcdS9OFp5r/IAhLybR1qZT
   rKPIVmPY9ArHwqVvraToF5FGRmFb8Vy3JVGjtq4OZ7i0s1u79ycjU+S8n
   p4GBmWv5hQluJ/RWlIOF6R8Cl+pLIlhv/QjTXqjNnme9FKPkpbYicYg/k
   DV0u51Ep4y1a0HOf7f1Ful0CtugwGvQiA3rQNNFR5jyu5AVO7YPyDLglc
   Q==;
X-CSE-ConnectionGUID: ShaG3R1rT62sTxlgBkaTwQ==
X-CSE-MsgGUID: JvgHbUrSS9eSz71/Zy6f9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521048"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521048"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:28 -0800
X-CSE-ConnectionGUID: 4UQdvRhzRVGNknMjDI72NA==
X-CSE-MsgGUID: hYr0dI/xQ3eTQayhyK5akw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060154"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:24 -0800
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
Subject: [PATCH v6 07/12] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Date: Tue, 13 Jan 2026 22:12:08 +0530
Message-ID: <20260113164200.1151788-21-badal.nilawar@intel.com>
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

From: Anshuman Gupta <anshuman.gupta@intel.com>

Add xe_d3_state enum to add support for VRAM Self Refresh
d3cold state.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c |  6 +++---
 drivers/gpu/drm/xe/xe_device_types.h    |  5 +++--
 drivers/gpu/drm/xe/xe_pci.c             |  6 +++---
 drivers/gpu/drm/xe/xe_pm.c              | 24 ++++++++++++------------
 drivers/gpu/drm/xe/xe_pm.h              |  8 +++++++-
 5 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 54ed39b257ad..b664bf58028a 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -401,7 +401,7 @@ void xe_display_pm_runtime_suspend(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		xe_display_enable_d3cold(xe);
 		return;
 	}
@@ -427,7 +427,7 @@ void xe_display_pm_runtime_suspend_late(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed)
+	if (xe->d3cold.target_state)
 		xe_display_pm_suspend_late(xe);
 
 	/*
@@ -507,7 +507,7 @@ void xe_display_pm_runtime_resume(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		xe_display_disable_d3cold(xe);
 		return;
 	}
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 3b42400f8563..7dc8c0e15aaa 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -22,6 +22,7 @@
 #include "xe_oa_types.h"
 #include "xe_pagefault_types.h"
 #include "xe_platform_types.h"
+#include "xe_pm.h"
 #include "xe_pmu_types.h"
 #include "xe_pt_types.h"
 #include "xe_sriov_pf_types.h"
@@ -574,8 +575,8 @@ struct xe_device {
 		/** @d3cold.capable: Indicates if root port is d3cold capable */
 		bool capable;
 
-		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
-		bool allowed;
+		/** @d3cold.target_state: Indicates d3cold target state */
+		enum xe_d3_state target_state;
 
 		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
 		bool vrsr_capable;
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 5c14e1978a72..e1de6b337f1f 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1201,7 +1201,7 @@ static int xe_pci_runtime_suspend(struct device *dev)
 
 	pci_save_state(pdev);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		d3cold_toggle(pdev, D3COLD_ENABLE);
 		pci_disable_device(pdev);
 		pci_ignore_hotplug(pdev);
@@ -1226,7 +1226,7 @@ static int xe_pci_runtime_resume(struct device *dev)
 
 	pci_restore_state(pdev);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = pci_enable_device(pdev);
 		if (err)
 			return err;
@@ -1242,7 +1242,7 @@ static int xe_pci_runtime_idle(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct xe_device *xe = pdev_to_xe_device(pdev);
 
-	xe_pm_d3cold_allowed_toggle(xe);
+	xe_pm_d3cold_target_state_toggle(xe);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index e7aa876ce9e0..ef7a686eb014 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -728,14 +728,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
 	}
 
 	for_each_gt(gt, xe, id) {
-		err = xe->d3cold.allowed ? xe_gt_suspend(gt) : xe_gt_runtime_suspend(gt);
+		err = xe->d3cold.target_state ? xe_gt_suspend(gt) : xe_gt_runtime_suspend(gt);
 		if (err)
 			goto out_resume;
 	}
@@ -777,7 +777,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_rpm_lockmap_acquire(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		for_each_gt(gt, xe, id)
 			xe_gt_idle_disable_c6(gt);
 
@@ -796,12 +796,12 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			goto out;
 	}
 
-	xe_i2c_pm_resume(xe, xe->d3cold.allowed);
+	xe_i2c_pm_resume(xe, xe->d3cold.target_state != XE_D3HOT);
 
 	xe_irq_resume(xe);
 
 	for_each_gt(gt, xe, id) {
-		err = xe->d3cold.allowed ? xe_gt_resume(gt) : xe_gt_runtime_resume(gt);
+		err = xe->d3cold.target_state ? xe_gt_resume(gt) : xe_gt_runtime_resume(gt);
 		if (err)
 			break;
 	}
@@ -814,7 +814,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	if (err)
 		goto out;
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_bo_restore_late(xe);
 		if (err)
 			goto out;
@@ -825,7 +825,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	if (IS_VF_CCS_READY(xe))
 		xe_sriov_vf_ccs_register_context(xe);
 
-	if (xe->d3cold.allowed)
+	if (xe->d3cold.target_state != XE_D3HOT)
 		xe_late_bind_fw_load(&xe->late_bind);
 
 out:
@@ -1085,13 +1085,13 @@ int xe_pm_set_vram_threshold(struct xe_device *xe, u32 threshold)
 }
 
 /**
- * xe_pm_d3cold_allowed_toggle - Check conditions to toggle d3cold.allowed
+ * xe_pm_d3cold_target_state_toggle - Check conditions to toggle target_state
  * @xe: xe device instance
  *
  * To be called during runtime_pm idle callback.
  * Check for all the D3Cold conditions ahead of runtime suspend.
  */
-void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
+void xe_pm_d3cold_target_state_toggle(struct xe_device *xe)
 {
 	struct ttm_resource_manager *man;
 	u32 total_vram_used_mb = 0;
@@ -1099,7 +1099,7 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
 	int i;
 
 	if (!xe->d3cold.capable) {
-		xe->d3cold.allowed = false;
+		xe->d3cold.target_state = XE_D3HOT;
 		return;
 	}
 
@@ -1114,9 +1114,9 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
 	mutex_lock(&xe->d3cold.lock);
 
 	if (total_vram_used_mb < xe->d3cold.vram_threshold)
-		xe->d3cold.allowed = true;
+		xe->d3cold.target_state = XE_D3COLD_OFF;
 	else
-		xe->d3cold.allowed = false;
+		xe->d3cold.target_state = XE_D3HOT;
 
 	mutex_unlock(&xe->d3cold.lock);
 }
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index 8c7fe8e4241d..cd7b4a9b2c05 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -13,6 +13,12 @@
 
 struct xe_device;
 
+enum xe_d3_state {
+	XE_D3HOT = 0,
+	XE_D3COLD_VRSR,
+	XE_D3COLD_OFF,
+};
+
 int xe_pm_suspend(struct xe_device *xe);
 int xe_pm_resume(struct xe_device *xe);
 
@@ -31,7 +37,7 @@ void xe_pm_runtime_get_noresume(struct xe_device *xe);
 bool xe_pm_runtime_resume_and_get(struct xe_device *xe);
 void xe_pm_assert_unbounded_bridge(struct xe_device *xe);
 int xe_pm_set_vram_threshold(struct xe_device *xe, u32 threshold);
-void xe_pm_d3cold_allowed_toggle(struct xe_device *xe);
+void xe_pm_d3cold_target_state_toggle(struct xe_device *xe);
 bool xe_rpm_reclaim_safe(const struct xe_device *xe);
 struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
 int xe_pm_block_on_suspend(struct xe_device *xe);
-- 
2.52.0


