Return-Path: <linux-pci+bounces-25084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C45A77F2A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B24C16D603
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A320B20B;
	Tue,  1 Apr 2025 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nV5Dt7fQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5420B805;
	Tue,  1 Apr 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521807; cv=none; b=S/u6goIYC634gWpNLbaK6Bqdb3NKE4iDe4QpCpJIF82wLOQkiraArmFl78ytMMBkPtRvjGfHeyeO4nNcuwdnoolqM3MlHiPSsg+8FmJR0eoIrbEf9LLn7lbnUGWmryDMRZTU82j+Q6+tWKjjDfKzpP8muyYH6Ajfba++ZZxYAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521807; c=relaxed/simple;
	bh=3kFo9kHIYEW2U38uGY2EHvjOkveB2fddRfsmPzdrHiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUbZpoayrcOKwfslTvDtwULb96DQjyjIMay9k7eNDexWUneGZcB9LM26y3vEqSArTanRI/Cp8vXqZmmLPD4baDGy+ejwVFR7D0+6Wm7JACpuRDWkYhaLNa9FX6pZIKAwqf07pOK90iVLN6pGX9JxOpDIARXimeMHfCd908/ORbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nV5Dt7fQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521806; x=1775057806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3kFo9kHIYEW2U38uGY2EHvjOkveB2fddRfsmPzdrHiI=;
  b=nV5Dt7fQnRSAej5wj78uqFQs1pTryn1CofLbw3odtCMcULTKxQr+xD5p
   6DHgn4eevyPx5y33OqDYc9NVgm7EWh+LdYRSdYmOczJW5/YdM5QL7wQSK
   nQK0VxAjn/tOvyqBmHV1b6kOOy3fXBxaRnJQdmolUNCi9jE0jwdWijjOS
   NAgwcm8jc6/7laO9YcfZYUWsJjdM2ouNGym/VfrJNtPfLCdRqZwXpP8PY
   cHmmGjTNcCxMbQ2I72bmvYdOJUkj9WUDW6eBOAYRXha/HqSSKKAe/TFmz
   op/KFMLboOY2vntxZ5fIe7BEd0vU+arAlZUOwEQ04uxT/1eXaORTXCTFI
   Q==;
X-CSE-ConnectionGUID: HicoOEfDRXC91gov5fvnbw==
X-CSE-MsgGUID: keVn9TL0TreY+UB0cSu+DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324982"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324982"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:46 -0700
X-CSE-ConnectionGUID: DTa4hykwTOGbM0byefHxEQ==
X-CSE-MsgGUID: qUhWmOHfS6CG74RO96CGkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410995"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:43 -0700
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
Subject: [PATCH 11/12] drm/xe/vrsr: Enable VRSR
Date: Tue,  1 Apr 2025 21:02:24 +0530
Message-ID: <20250401153225.96379-12-anshuman.gupta@intel.com>
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

Enabling VRSR in runtime suspend and also in System wide suspend.
Also fix couple of typo in xe_pm.c.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_pci.c |  4 +--
 drivers/gpu/drm/xe/xe_pm.c  | 51 +++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index fa2d43395129..3317d475be79 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -925,7 +925,7 @@ static int xe_pci_suspend(struct device *dev)
 
 	/*
 	 * Enabling D3Cold is needed for S2Idle/S0ix.
-	 * It is save to allow here since xe_pm_suspend has evicted
+	 * It is safe to allow here since xe_pm_suspend has evicted
 	 * the local memory and the direct complete optimization is disabled.
 	 */
 	d3cold_toggle(pdev, D3COLD_ENABLE);
@@ -942,7 +942,7 @@ static int xe_pci_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int err;
 
-	/* Give back the D3Cold decision to the runtime P M*/
+	/* Give back the D3Cold decision to the runtime PM */
 	d3cold_toggle(pdev, D3COLD_DISABLE);
 
 	err = pci_set_power_state(pdev, PCI_D0);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 5db9313ae269..41b59c8b31b3 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -151,7 +151,7 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
 static void xe_pm_suspend_prepare(struct xe_device *xe)
 {
 	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
-		xe_pm_d3cold_allowed_toggle(xe);
+		xe_pm_d3cold_target_state_toggle(xe);
 	else
 		xe->d3cold.target_state = XE_D3COLD_OFF;
 }
@@ -182,10 +182,12 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_display_pm_suspend(xe);
 
-	/* FIXME: Super racey... */
-	err = xe_bo_evict_all(xe);
-	if (err)
-		goto err_pxp;
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
+		/* FIXME: Super racey... */
+		err = xe_bo_evict_all(xe);
+		if (err)
+			goto err_pxp;
+	}
 
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_suspend(gt);
@@ -197,6 +199,12 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_display_pm_suspend_late(xe);
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
+		err = xe_pm_vrsr_enable(xe, true);
+			if (err)
+				goto err_display;
+	}
+
 	drm_dbg(&xe->drm, "Device suspended\n");
 	return 0;
 
@@ -238,9 +246,11 @@ int xe_pm_resume(struct xe_device *xe)
 	 * This only restores pinned memory which is the memory required for the
 	 * GT(s) to resume.
 	 */
-	err = xe_bo_restore_kernel(xe);
-	if (err)
-		goto err;
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
+		err = xe_bo_restore_kernel(xe);
+		if (err)
+			goto err;
+	}
 
 	xe_irq_resume(xe);
 
@@ -249,9 +259,11 @@ int xe_pm_resume(struct xe_device *xe)
 
 	xe_display_pm_resume(xe);
 
-	err = xe_bo_restore_user(xe);
-	if (err)
-		goto err;
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
+		err = xe_bo_restore_user(xe);
+		if (err)
+			goto err;
+	}
 
 	xe_pxp_pm_resume(xe->pxp);
 
@@ -595,7 +607,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
@@ -611,6 +623,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend_late(xe);
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
+		err = xe_pm_vrsr_enable(xe, true);
+			if (err) {
+				drm_err(&xe->drm, "Failed to enable VRSR: %d\n", err);
+				goto out_resume;
+			}
+	}
+
 	xe_rpm_lockmap_release(xe);
 	xe_pm_write_callback_task(xe, NULL);
 	return 0;
@@ -642,7 +662,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_rpm_lockmap_acquire(xe);
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_pcode_ready(xe, true);
 		if (err)
 			goto out;
@@ -658,6 +678,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			goto out;
 	}
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR)
+		xe_display_pm_resume_early(xe);
+
 	xe_irq_resume(xe);
 
 	for_each_gt(gt, xe, id)
@@ -665,7 +688,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_display_pm_runtime_resume(xe);
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_bo_restore_user(xe);
 		if (err)
 			goto out;
-- 
2.43.0


