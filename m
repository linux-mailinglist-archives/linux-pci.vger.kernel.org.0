Return-Path: <linux-pci+bounces-38173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47238BDD4C8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 889634FBA99
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC912C21F7;
	Wed, 15 Oct 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDeAu3SA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697D2BEFF0;
	Wed, 15 Oct 2025 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515388; cv=none; b=bJeYO3PDWmQ3ji+DtS1gGvWFDVEORPLMDCVqvwmNghZNg2KETW5UYeInK5SQxp8qGhhv6nyHA8lAHzS0bVRfmidnEGBz/E2DsWUr65oS4vHBj5ISHsH65KGWRRl7v1JyxEMPbk530ZhuyWC9uHHyyMLBzwFB76FKHxF8Tu4de/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515388; c=relaxed/simple;
	bh=JZ3qIsSovrFdFJs/dNlHB06AYAyshWfRv7BOvxYpBV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QylFT+fCHQplccBGTLyxPDezX41eIF38xOR+rAZ56KINbK5fgcj7LUmpnGiTCcwliJCcjTu2i3SU/gl4jGuQXHmjnjI34dxjMSylyjxXpi3QenE0NwX9/pgOoJIHlbVM7WDrOK2dXvB1PnryvIdD0SufQ/SJxpkb75R6tsy8eRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDeAu3SA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515387; x=1792051387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZ3qIsSovrFdFJs/dNlHB06AYAyshWfRv7BOvxYpBV8=;
  b=LDeAu3SAVdQQXBpR8GLg658sI1X2uK/kGW2FcVBOPUR2WldrKFWVweLg
   rAtQbfB5YJh+6tTu6P7c/dvBftPjBoxZGpmeV8dKa410L2fVv83TkBOuq
   Qv/dVzlr6yxLSX0tw7gGbgNOOH6FWWg5CSKbNx372xLdbzepz7OuEAa9F
   OiO1t+eLZGCjHpnkltAv+jE5Yn7S1O3g0UkfiNH1I51pk8I6eB+7kcdYd
   4I3878J+TpE2pSkc+ppuMYEz41a04w+lHj5sdFenLTfJt8kY52TdoSq4f
   nsqQluGrxqebA8q6heQE8FsEBjXjmsz4qPNWkY3lYFKfM2zsfz5IM7Z/j
   Q==;
X-CSE-ConnectionGUID: yZCGGDDjRv+X6UpwFzw+uA==
X-CSE-MsgGUID: 56MfOhbsS8+92P8dHLuq0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891521"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891521"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:03:07 -0700
X-CSE-ConnectionGUID: 46o1+FC0R5+xae4AH8ZY/w==
X-CSE-MsgGUID: ZgEYaXuPSlS9nZsH5ar5sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805541"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:03:02 -0700
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
Subject: [PATCH v5 10/12] drm/xe/vrsr: Enable VRSR
Date: Wed, 15 Oct 2025 13:37:08 +0530
Message-Id: <20251015080710.1468409-11-badal.nilawar@intel.com>
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

Enable VRSR in runtime suspend and also in System wide suspend.
Also fix couple of typo in xe_pm.c.

V2: Disable VRSR in runtime/system resume path

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Acked-by: Karthik Poosa <karthik.poosa@intel.com>
---
 drivers/gpu/drm/xe/xe_pci.c |  4 +--
 drivers/gpu/drm/xe/xe_pm.c  | 52 ++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index eb60cf44c1d7..2f1b6d52514c 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1067,7 +1067,7 @@ static int xe_pci_suspend(struct device *dev)
 
 	/*
 	 * Enabling D3Cold is needed for S2Idle/S0ix.
-	 * It is save to allow here since xe_pm_suspend has evicted
+	 * It is safe to allow here since xe_pm_suspend has evicted
 	 * the local memory and the direct complete optimization is disabled.
 	 */
 	d3cold_toggle(pdev, D3COLD_ENABLE);
@@ -1084,7 +1084,7 @@ static int xe_pci_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int err;
 
-	/* Give back the D3Cold decision to the runtime P M*/
+	/* Give back the D3Cold decision to the runtime PM */
 	d3cold_toggle(pdev, D3COLD_DISABLE);
 
 	err = pci_set_power_state(pdev, PCI_D0);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index f599513edca6..84cd9e84f548 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -204,10 +204,12 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_display_pm_suspend(xe);
 
-	/* FIXME: Super racey... */
-	err = xe_bo_evict_all(xe);
-	if (err)
-		goto err_display;
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
+		/* FIXME: Super racey... */
+		err = xe_bo_evict_all(xe);
+		if (err)
+			goto err;
+	}
 
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_suspend(gt);
@@ -221,6 +223,12 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_i2c_pm_suspend(xe);
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
+		err = xe_pm_vrsr_enable(xe);
+			if (err)
+				goto err_display;
+	}
+
 	drm_dbg(&xe->drm, "Device suspended\n");
 	xe_pm_block_end_signalling();
 
@@ -262,15 +270,20 @@ int xe_pm_resume(struct xe_device *xe)
 	if (err)
 		return err;
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR)
+		xe_pm_vrsr_disable(xe);
+
 	xe_display_pm_resume_early(xe);
 
 	/*
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
 
 	xe_i2c_pm_resume(xe, true);
 
@@ -281,9 +294,11 @@ int xe_pm_resume(struct xe_device *xe)
 
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
 
@@ -729,7 +744,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
@@ -747,6 +762,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_i2c_pm_suspend(xe);
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
+		err = xe_pm_vrsr_enable(xe);
+			if (err) {
+				drm_err(&xe->drm, "Failed to enable VRSR: %d\n", err);
+				goto out_resume;
+			}
+	}
+
 	xe_rpm_lockmap_release(xe);
 	xe_pm_write_callback_task(xe, NULL);
 	return 0;
@@ -787,7 +810,12 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			goto out;
 
 		xe_display_pm_resume_early(xe);
+	}
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR)
+		xe_pm_vrsr_disable(xe);
+
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		/*
 		 * This only restores pinned memory which is the memory
 		 * required for the GT(s) to resume.
@@ -807,7 +835,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_display_pm_runtime_resume(xe);
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_bo_restore_late(xe);
 		if (err)
 			goto out;
-- 
2.34.1


