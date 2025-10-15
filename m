Return-Path: <linux-pci+bounces-38171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA8BBDD4BE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22214F99CF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364B13957E;
	Wed, 15 Oct 2025 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRXJy1Kq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514622BEFF0;
	Wed, 15 Oct 2025 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515381; cv=none; b=mPOZllzTWuCiIVSTZyTo/QSASQftYrf3uzZjBjbdQp8P63RsWm/gThhdB1lLzdw0WHMFKMwHRh9dJiqv+CH5hrBf+HeehxY9prZs5wS5pJONUAOregcJy8dM/Oz5pXdGpZ5MGRcKALGFc98CPp3Udk/G8sT5vVzAoTzRCMFz66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515381; c=relaxed/simple;
	bh=x2kRDEO23eyomss8cdNRjVwv3knbjJt71nyYKTimWG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eibtr05TUf4+DUkUkkPP29U+8ylPDyi23h9ScTcgE2aT96yCAyfvtdeoeeOPM8itLDjfxJ8ZUypqcvLkNF7WcWimkstTMYBNa6be5d+raNtaAQISVSjPM1YyYzCp82/2Yri0LqsNIWAaL30VTSdwXLpbBn9p4nE9W6oi+ZLXO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRXJy1Kq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515380; x=1792051380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x2kRDEO23eyomss8cdNRjVwv3knbjJt71nyYKTimWG0=;
  b=XRXJy1KqCIsdvFax5fofjDSd4Bwj0d3Ao/Cs+UkmysN4qan/65VGL0ZT
   +C23LiYBYJA4zAQhLPLL7of6KrvMg+nqgwTeF8SBJh7imWH7gR29SxcLR
   VT+vbf8rdtYH2ickcqnonFrRkpMqAIOWrficgDeq3Hnv6hDaQKUgKj5hT
   nQnzHZWgip80i5sbelbmWTZvP9D4IUs6AkamhkIIVvsrjtcQ8hRiHGGuo
   11t6ycCIp/Z7CJSIFL55nBVJINf8nhj1E7GRuqYIAokejFSvGbQTSlgx3
   GBDRjwI31SADlWPYTemRqJ9QlGJIyHUVn6EdwZNlwITMnCmkNvEFJwgQX
   A==;
X-CSE-ConnectionGUID: AESzp+dRR3egx5quuYHcow==
X-CSE-MsgGUID: oi+1xCtXTl+dYGZLa5I+WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891503"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891503"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:59 -0700
X-CSE-ConnectionGUID: zy9RNNAeRNSs7fRsRMg7pQ==
X-CSE-MsgGUID: 2YKUKBNgQNWqmqtO2z2vzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805465"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:54 -0700
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
Subject: [PATCH v5 08/12] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Date: Wed, 15 Oct 2025 13:37:06 +0530
Message-Id: <20251015080710.1468409-9-badal.nilawar@intel.com>
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

From: Anshuman Gupta <anshuman.gupta@intel.com>

Add xe_d3_state enum to add support for VRAM Self Refresh
d3cold state.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>
---
V2: Rebased
---
 drivers/gpu/drm/xe/display/xe_display.c |  6 +++---
 drivers/gpu/drm/xe/xe_device_types.h    |  5 +++--
 drivers/gpu/drm/xe/xe_pci.c             |  6 +++---
 drivers/gpu/drm/xe/xe_pm.c              | 21 +++++++++++----------
 drivers/gpu/drm/xe/xe_pm.h              |  8 +++++++-
 5 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 205040f43ddd..35d09109462e 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -395,7 +395,7 @@ void xe_display_pm_runtime_suspend(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		xe_display_enable_d3cold(xe);
 		return;
 	}
@@ -421,7 +421,7 @@ void xe_display_pm_runtime_suspend_late(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed)
+	if (xe->d3cold.target_state)
 		xe_display_pm_suspend_late(xe);
 
 	/*
@@ -501,7 +501,7 @@ void xe_display_pm_runtime_resume(struct xe_device *xe)
 	if (!xe->info.probe_display)
 		return;
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		xe_display_disable_d3cold(xe);
 		return;
 	}
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index da81e1937918..a139f8aec33b 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -20,6 +20,7 @@
 #include "xe_memirq_types.h"
 #include "xe_oa_types.h"
 #include "xe_platform_types.h"
+#include "xe_pm.h"
 #include "xe_pmu_types.h"
 #include "xe_pt_types.h"
 #include "xe_sriov_pf_types.h"
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
index 0cc14ddd92de..eb60cf44c1d7 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1118,7 +1118,7 @@ static int xe_pci_runtime_suspend(struct device *dev)
 
 	pci_save_state(pdev);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		d3cold_toggle(pdev, D3COLD_ENABLE);
 		pci_disable_device(pdev);
 		pci_ignore_hotplug(pdev);
@@ -1143,7 +1143,7 @@ static int xe_pci_runtime_resume(struct device *dev)
 
 	pci_restore_state(pdev);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = pci_enable_device(pdev);
 		if (err)
 			return err;
@@ -1159,7 +1159,7 @@ static int xe_pci_runtime_idle(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct xe_device *xe = pdev_to_xe_device(pdev);
 
-	xe_pm_d3cold_allowed_toggle(xe);
+	xe_pm_d3cold_target_state_toggle(xe);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 61466bf0bba6..aa38dbe1e368 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -719,7 +719,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
@@ -771,7 +771,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	for_each_gt(gt, xe, id)
 		xe_gt_idle_disable_c6(gt);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_pcode_ready(xe, true);
 		if (err)
 			goto out;
@@ -787,7 +787,8 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			goto out;
 	}
 
-	xe_i2c_pm_resume(xe, xe->d3cold.allowed);
+	if (xe->d3cold.target_state != XE_D3HOT)
+		xe_i2c_pm_resume(xe, true);
 
 	xe_irq_resume(xe);
 
@@ -796,7 +797,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_display_pm_runtime_resume(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_bo_restore_late(xe);
 		if (err)
 			goto out;
@@ -807,7 +808,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	if (IS_VF_CCS_READY(xe))
 		xe_sriov_vf_ccs_register_context(xe);
 
-	if (xe->d3cold.allowed)
+	if (xe->d3cold.target_state != XE_D3HOT)
 		xe_late_bind_fw_load(&xe->late_bind);
 
 out:
@@ -1046,13 +1047,13 @@ int xe_pm_set_vram_threshold(struct xe_device *xe, u32 threshold)
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
@@ -1060,7 +1061,7 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
 	int i;
 
 	if (!xe->d3cold.capable) {
-		xe->d3cold.allowed = false;
+		xe->d3cold.target_state = XE_D3HOT;
 		return;
 	}
 
@@ -1075,9 +1076,9 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
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
index 3d5a8c4a4971..f6c09841b0ae 100644
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
 int xe_pm_block_on_suspend(struct xe_device *xe);
-- 
2.34.1


