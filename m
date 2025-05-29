Return-Path: <linux-pci+bounces-28604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69781AC7C86
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120211BC248F
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D598E28E605;
	Thu, 29 May 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZMix/jL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B9207A08;
	Thu, 29 May 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517316; cv=none; b=TDzYWo3c3ZBzYPUNM4kjao7Q9kXJ8LwOziMHGvPQyth3IzR0XXtvCVcaqIe+iIuLa607fze7Hm2VnpNxXnCZXPgHtd86oTTAKzylTtGWyW1NqI3UBvxPm13y7ZSJZnTx1BPM+ypRbw9LUvyYSgObDzAcPv0njz9u1fgau4RJfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517316; c=relaxed/simple;
	bh=C34/4ysj5vZesiKl8Ggq9yK1/mADQlAym0DKFnAWprQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ih4Kj66yFRaNmJ9JAFIMu03l65HEV0kgZIWq5wg8BZL/LJVnyKbzfbjYioZzxcdhrJULvFah9QE3TqI2W8Qze78Zbv2nK+/fKtwVSUfbEJTZ6QMCoFkd7Z+ozYftXWf11vHfjXvrKuWv/7uopKOnrI8enij+XdYJtVKm6k+nkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZMix/jL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517315; x=1780053315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C34/4ysj5vZesiKl8Ggq9yK1/mADQlAym0DKFnAWprQ=;
  b=HZMix/jLHOcRAU4r5bzEm49lTsuUO3LRorWJT2qGcPES3iV59mJu4ex5
   jQntI/D59e65W+6hCoOrExYKZsERsxb5ykplnMOta2AXgEkka/FqlSZCC
   KkbkMN9wgkPaTnPlQ/icXURSyXOP+5rk/VyvYF04hwWALPnAPJsPRKCbI
   EzgQ239QiRPOxldNqQPGex3XR3bollww1RZInI+DsdcFd3nqFWtJ0RrBx
   vLQxrp71HCx+3c6YOozlgHM4fiSUnHdtroDYik/o49MzU1Xfbq6E80pj1
   xhI8qEWkt6AKCnma+yOqkgWd71/yHTLWdwGv8ZpcS4AhNcQOtCAY4CT0K
   A==;
X-CSE-ConnectionGUID: 16cuk6f8R4iJL+ASdH1oug==
X-CSE-MsgGUID: 3dmqdBpQRmycBgbjWasYfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68123173"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="68123173"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:15 -0700
X-CSE-ConnectionGUID: SbhsO5DXR6m6vtrsQx9VGA==
X-CSE-MsgGUID: qte8l0bxQp6LyDvK8jdKqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="143510540"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:11 -0700
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
Subject: [PATCH v4 08/11] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Date: Thu, 29 May 2025 16:46:51 +0530
Message-Id: <20250529111654.3140766-9-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529111654.3140766-1-badal.nilawar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
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
---
 drivers/gpu/drm/xe/display/xe_display.c |  6 +++---
 drivers/gpu/drm/xe/xe_device_types.h    |  5 +++--
 drivers/gpu/drm/xe/xe_pci.c             |  6 +++---
 drivers/gpu/drm/xe/xe_pm.c              | 16 ++++++++--------
 drivers/gpu/drm/xe/xe_pm.h              |  8 +++++++-
 5 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index b3da88b12b35..7ccd9b447ace 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -433,7 +433,7 @@ void xe_display_pm_runtime_suspend(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		xe_display_enable_d3cold(xe);
 		return;
 	}
@@ -459,7 +459,7 @@ void xe_display_pm_runtime_suspend_late(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed)
+	if (xe->d3cold.target_state)
 		xe_display_pm_suspend_late(xe);
 
 	/*
@@ -537,7 +537,7 @@ void xe_display_pm_runtime_resume(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		xe_display_disable_d3cold(xe);
 		return;
 	}
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 5f9a1a358468..48ca0d8c4c45 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -20,6 +20,7 @@
 #include "xe_memirq_types.h"
 #include "xe_oa_types.h"
 #include "xe_platform_types.h"
+#include "xe_pm.h"
 #include "xe_pmu_types.h"
 #include "xe_pt_types.h"
 #include "xe_sriov_types.h"
@@ -510,8 +511,8 @@ struct xe_device {
 		/** @d3cold.capable: Indicates if root port is d3cold capable */
 		bool capable;
 
-		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
-		bool allowed;
+		/** @d3cold.target_state: Indicates d3cold target state */
+		enum xe_d3_state target_state;
 
 		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
 		bool vrsr_capable;
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 46a99d6ef1a5..5ae1df345416 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -977,7 +977,7 @@ static int xe_pci_runtime_suspend(struct device *dev)
 
 	pci_save_state(pdev);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		d3cold_toggle(pdev, D3COLD_ENABLE);
 		pci_disable_device(pdev);
 		pci_ignore_hotplug(pdev);
@@ -1002,7 +1002,7 @@ static int xe_pci_runtime_resume(struct device *dev)
 
 	pci_restore_state(pdev);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = pci_enable_device(pdev);
 		if (err)
 			return err;
@@ -1018,7 +1018,7 @@ static int xe_pci_runtime_idle(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct xe_device *xe = pdev_to_xe_device(pdev);
 
-	xe_pm_d3cold_allowed_toggle(xe);
+	xe_pm_d3cold_target_state_toggle(xe);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index c84b9b3f7371..b86e95493cb5 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -606,7 +606,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
@@ -653,7 +653,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_rpm_lockmap_acquire(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_pcode_ready(xe, true);
 		if (err)
 			goto out;
@@ -676,7 +676,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_display_pm_runtime_resume(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_bo_restore_late(xe);
 		if (err)
 			goto out;
@@ -918,13 +918,13 @@ int xe_pm_set_vram_threshold(struct xe_device *xe, u32 threshold)
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
@@ -932,7 +932,7 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
 	int i;
 
 	if (!xe->d3cold.capable) {
-		xe->d3cold.allowed = false;
+		xe->d3cold.target_state = XE_D3HOT;
 		return;
 	}
 
@@ -947,9 +947,9 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
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
index ba550281b130..c6c2bd6187a5 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -12,6 +12,12 @@
 
 struct xe_device;
 
+enum xe_d3_state {
+	XE_D3HOT = 0,
+	XE_D3COLD_VRSR,
+	XE_D3COLD_OFF,
+};
+
 int xe_pm_suspend(struct xe_device *xe);
 int xe_pm_resume(struct xe_device *xe);
 
@@ -30,7 +36,7 @@ void xe_pm_runtime_get_noresume(struct xe_device *xe);
 bool xe_pm_runtime_resume_and_get(struct xe_device *xe);
 void xe_pm_assert_unbounded_bridge(struct xe_device *xe);
 int xe_pm_set_vram_threshold(struct xe_device *xe, u32 threshold);
-void xe_pm_d3cold_allowed_toggle(struct xe_device *xe);
+void xe_pm_d3cold_target_state_toggle(struct xe_device *xe);
 bool xe_rpm_reclaim_safe(const struct xe_device *xe);
 struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
 int xe_pm_module_init(void);
-- 
2.34.1


