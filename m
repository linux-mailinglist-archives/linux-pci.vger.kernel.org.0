Return-Path: <linux-pci+bounces-28606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4993AC7C89
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F7B4A58D0
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAFB28E5E5;
	Thu, 29 May 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWe3H4H4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A428E60A;
	Thu, 29 May 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517324; cv=none; b=RGpGaqCKq2O4tMV6g9tXu1Vn1R/xoln77FRigTOIjqO2QRRmai9cGQKtpX7d1Oy7H5MSyXM2bxyJJOW2yF3I2TQr9vV3ywa6TZbM+M7esYcgbMTg6JXhvBk6pRiYuoE86NtP7nDl2mtVKA1ZN7v9E2DZ9mt1a/OcOBg1nBqt0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517324; c=relaxed/simple;
	bh=bHhjXPjW14vl0hXyhieamfk7eD9SwgFwuqVjFNzqnTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjGkFM4aivOGUmG0HB/Ad961uATeMy2gIyx7q02z80uFxJs8ebNytX7lGqz9DHmLzsJAwap6GrMK/6CxpGDzOcD3GGySW5uqGG6/HdKipiWlUj68KWyF8mwJVOkigUNfh+cPEA23sgOeEJ8tPOi+Mev1OsLLe55RhqtLjxUhtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWe3H4H4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517322; x=1780053322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHhjXPjW14vl0hXyhieamfk7eD9SwgFwuqVjFNzqnTM=;
  b=lWe3H4H4ezvpdng7G5H7FMMKBxMI0YwTrzjpMft3bOriBhdTzf6/HG/j
   dOU0ce5/dWoWWBABTJSwAE6Z/ljqCDBkRp7az/lw4N1oQAZ1fBzyRu1xJ
   0ijXsplvWm7Qki1bYCeQHuaHJFN5Wio9gfg/W0shCVOlrrlzhylkmOZ0e
   DJMByPnD8CC8+EZJ8l1CaPOWgSDwJ63mPvW7/rl68n6jF3kU6ZpLD/OMT
   aimIHY+TJBtf/Ok0C1fs3nNuNnOO1/lW4N5Rimz3+13fRvk6pSloucfTV
   1JPQbjA1eCciOQZcAtKbFL6a2a1owR5g1yvac2qu0eH//E3TZO7LqLhFT
   g==;
X-CSE-ConnectionGUID: taEluyIVTxmUTST9Ii9B3w==
X-CSE-MsgGUID: 6EwvrypORVKdKYFl4tYabg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68123187"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="68123187"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:22 -0700
X-CSE-ConnectionGUID: me7bI1xsT9Gl1P5SQ8jS5g==
X-CSE-MsgGUID: /bvwVIFvSKmyvtwWaQUuIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="143510580"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:19 -0700
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
Subject: [PATCH v4 10/11] drm/xe/vrsr: Enable VRSR
Date: Thu, 29 May 2025 16:46:53 +0530
Message-Id: <20250529111654.3140766-11-badal.nilawar@intel.com>
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

Enabling VRSR in runtime suspend and also in System wide suspend.
Also fix couple of typo in xe_pm.c.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_pci.c |  4 ++--
 drivers/gpu/drm/xe/xe_pm.c  | 46 +++++++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 5ae1df345416..fdf878594fb0 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -926,7 +926,7 @@ static int xe_pci_suspend(struct device *dev)
 
 	/*
 	 * Enabling D3Cold is needed for S2Idle/S0ix.
-	 * It is save to allow here since xe_pm_suspend has evicted
+	 * It is safe to allow here since xe_pm_suspend has evicted
 	 * the local memory and the direct complete optimization is disabled.
 	 */
 	d3cold_toggle(pdev, D3COLD_ENABLE);
@@ -943,7 +943,7 @@ static int xe_pci_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int err;
 
-	/* Give back the D3Cold decision to the runtime P M*/
+	/* Give back the D3Cold decision to the runtime PM */
 	d3cold_toggle(pdev, D3COLD_DISABLE);
 
 	err = pci_set_power_state(pdev, PCI_D0);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 1e061bfc3e52..19596d467298 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -147,10 +147,12 @@ int xe_pm_suspend(struct xe_device *xe)
 
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
@@ -162,6 +164,12 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_display_pm_suspend_late(xe);
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
+		err = xe_pm_vrsr_enable(xe, true);
+			if (err)
+				goto err_display;
+	}
+
 	drm_dbg(&xe->drm, "Device suspended\n");
 	return 0;
 
@@ -203,9 +211,11 @@ int xe_pm_resume(struct xe_device *xe)
 	 * This only restores pinned memory which is the memory required for the
 	 * GT(s) to resume.
 	 */
-	err = xe_bo_restore_early(xe);
-	if (err)
-		goto err;
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
+		err = xe_bo_restore_early(xe);
+		if (err)
+			goto err;
+	}
 
 	xe_irq_resume(xe);
 
@@ -214,9 +224,11 @@ int xe_pm_resume(struct xe_device *xe)
 
 	xe_display_pm_resume(xe);
 
-	err = xe_bo_restore_late(xe);
-	if (err)
-		goto err;
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
+		err = xe_bo_restore_late(xe);
+		if (err)
+			goto err;
+	}
 
 	xe_pxp_pm_resume(xe->pxp);
 
@@ -616,7 +628,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
@@ -632,6 +644,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
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
@@ -669,7 +689,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			goto out;
 
 		xe_display_pm_resume_early(xe);
+	}
 
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		/*
 		 * This only restores pinned memory which is the memory
 		 * required for the GT(s) to resume.
@@ -686,7 +708,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_display_pm_runtime_resume(xe);
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_bo_restore_late(xe);
 		if (err)
 			goto out;
-- 
2.34.1


