Return-Path: <linux-pci+bounces-25082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248EA77F26
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59EA16D29D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEC920B7E6;
	Tue,  1 Apr 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Od0yQyiJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916C20B207;
	Tue,  1 Apr 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521804; cv=none; b=X1VNHEuGIUKmDwrhzL77he6wYngOSCX+faFisNZvssWwFHhzrqvYUuF/kma6QorKFjjN/OJmpHtmPhqlV8+0rFbBPTl23aSmQ+rKAma8oyuWf2QcxGPPx4ZRmp/vy1RTKgV5CmuCQzZy+H0637RzOgC/OgjPA7/QfE959wz1QUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521804; c=relaxed/simple;
	bh=1nYYOsbM2dgPmuBaEHyM7ApLisPTSnbMMdUBq64ZrQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUVYfnWTriZMwz8fCfjmIGCQxBcmAC/NHKAGndlECuEi/z654JI2dMWpJrzQrZa/n9VqQr6DqrhlLNO9kLQnHtEznRUp1Mka0D+8QlA9KgY75le0PlU28q1HEA5d5LHBkn99pWZ4skDC9Bul8sg40zL37wWi0NL925KgpB7a4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Od0yQyiJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521803; x=1775057803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1nYYOsbM2dgPmuBaEHyM7ApLisPTSnbMMdUBq64ZrQk=;
  b=Od0yQyiJTeSITA/6kTE/XGrnQYGA7CrsBJA02TMOKgqHiIp0Fxx0dCPQ
   CeUBfL3iHujiMUgodo+5Tb/faKYvUSkWME61FS5UXDP/RxU4cfzoO9QO8
   VI5beswEn+zlAsBXYb2nl2Gkp4GxHw7GeUrCe3K88meXT790qK52jb7lo
   FRkWaIvSjHhTDltK9o8+SD5rwpKEF4jlVD61L/yzUrp5OiPsegBbDVmUL
   IQmIv742CKmUh+cNYtowjoc8VzLNTvNrHUaTIRCgk42mws7CHL9oFr4NO
   QlC/qeveq2vXIarkaV4hVrUa1UFSL88cvcIdEmigNZcIPBCr/qy5KSZhu
   A==;
X-CSE-ConnectionGUID: naiIFBePQhW0EJvTrQjIWA==
X-CSE-MsgGUID: uujg4OugRpyQUkIIPaogjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324950"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:38 -0700
X-CSE-ConnectionGUID: LDd3fphRTlCqxZAISFGENw==
X-CSE-MsgGUID: YljlFAewSsSZvhjMqIMzPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410984"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:35 -0700
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
Subject: [PATCH 09/12] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Date: Tue,  1 Apr 2025 21:02:22 +0530
Message-ID: <20250401153225.96379-10-anshuman.gupta@intel.com>
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
index a7a50f48f1c5..7877c2d61618 100644
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
index 9aacd5af7d0f..9d97f2c84c33 100644
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
@@ -496,8 +497,8 @@ struct xe_device {
 		/** @d3cold.capable: Indicates if root port is d3cold capable */
 		bool capable;
 
-		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
-		bool allowed;
+		/** @d3cold.target_state: Indicates d3cold target state */
+		enum xe_d3_state target_state;
 
 		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
 		bool vrsr_capable;
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 70d4827f5821..fa2d43395129 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -976,7 +976,7 @@ static int xe_pci_runtime_suspend(struct device *dev)
 
 	pci_save_state(pdev);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		d3cold_toggle(pdev, D3COLD_ENABLE);
 		pci_disable_device(pdev);
 		pci_ignore_hotplug(pdev);
@@ -1001,7 +1001,7 @@ static int xe_pci_runtime_resume(struct device *dev)
 
 	pci_restore_state(pdev);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = pci_enable_device(pdev);
 		if (err)
 			return err;
@@ -1017,7 +1017,7 @@ static int xe_pci_runtime_idle(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct xe_device *xe = pdev_to_xe_device(pdev);
 
-	xe_pm_d3cold_allowed_toggle(xe);
+	xe_pm_d3cold_target_state_toggle(xe);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index ea93923d6671..d4149a2eace7 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -585,7 +585,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
@@ -632,7 +632,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_rpm_lockmap_acquire(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_pcode_ready(xe, true);
 		if (err)
 			goto out;
@@ -655,7 +655,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_display_pm_runtime_resume(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.target_state) {
 		err = xe_bo_restore_user(xe);
 		if (err)
 			goto out;
@@ -897,13 +897,13 @@ int xe_pm_set_vram_threshold(struct xe_device *xe, u32 threshold)
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
@@ -911,7 +911,7 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
 	int i;
 
 	if (!xe->d3cold.capable) {
-		xe->d3cold.allowed = false;
+		xe->d3cold.target_state = XE_D3HOT;
 		return;
 	}
 
@@ -926,9 +926,9 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
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
index 2b5df31db4c4..803c82f50d77 100644
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
2.43.0


