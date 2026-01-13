Return-Path: <linux-pci+bounces-44640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA49D1A517
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A14D30AB2DD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567E30AAD7;
	Tue, 13 Jan 2026 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIPdXABp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B130AAC2;
	Tue, 13 Jan 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321963; cv=none; b=RthQdB/kP1VOcjHlaoP3OLpzOQbRmpiC+7d9I79Z6mOM9hbEVze9a11RkBHCIBPZ9uCmY4G15c7O6DXRV9dy0aOcTjO9WpOaUIgOEaIyjpbBFMp9HJVYowXPFMsXKuDaKVYMK5dfP80vM/s45PK2/k5Zb1Gg1btTNmlOP3rnSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321963; c=relaxed/simple;
	bh=+/nF7vMu0Ox13tlLTeWspkQn3oNTFgB0C6agnlc5P1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqKlgCuKhY4gcT6beM91ikcnQ6u7g+WK25k+sLeeWrOQdNA6RgEKKB6RWuJrcqzokBxEAApIJWII0nS7Dt4Aa3LQR8XBMkQ+ayZ0q0FbKb0ZmbVdNKWe/RP2b3lsUsTDSvms4bxRHgDqGttJXVexm07kAjNbxbPnOGAjCNSTivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIPdXABp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321962; x=1799857962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+/nF7vMu0Ox13tlLTeWspkQn3oNTFgB0C6agnlc5P1E=;
  b=RIPdXABp9zIRgvBEW358Vz5jj09nvBgYPe2Qa8VOri+ERxIvYq9a6RaR
   yq9gbHByvo0i0kAMMIROaMxQ1nKueeZ5QyxuJP2BSYazGuAsPwmfaC7/A
   pQoyxndcMh6GxLlh3yzpE6BdSG0Zsx23/PUKqgACIw3Ybb4QMc2xrHkgt
   pnEJRyKCgPoRBsRmgjB0/NVgDEHnnkUL5ztWkue1oR3Qv1lKT8FYXJ1Jv
   XTuB2kxmoK3/VarPi3Ke0JUN3EeE8nTvi0rFlqTZpAeJB0UuG2LboIx4c
   DXExkDtZAH/pQ7YHQeFFdhi8XyhFTAKhms0TVo/EUx6nAXDYb1hY/UZSM
   g==;
X-CSE-ConnectionGUID: Qr1rMIlkS76GHpDzLm1RFw==
X-CSE-MsgGUID: 3Qsd6u5MRAOdfHyvW9rWZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521080"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521080"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:41 -0800
X-CSE-ConnectionGUID: 81PKrvhJSZyKSFCWXWwolA==
X-CSE-MsgGUID: yV3dnwl2QsqsOp7KFrIwAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060217"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:37 -0800
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
Subject: [PATCH v6 10/12] drm/xe/vrsr: Enable VRSR
Date: Tue, 13 Jan 2026 22:12:11 +0530
Message-ID: <20260113164200.1151788-24-badal.nilawar@intel.com>
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

Enable VRSR in runtime suspend and also in System wide suspend.
Also fix couple of typo in xe_pm.c.

V2: Disable VRSR in runtime/system resume path
V3: Handle BO eviction

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Acked-by: Karthik Poosa <karthik.poosa@intel.com>
---
 drivers/gpu/drm/xe/xe_pci.c |  4 +--
 drivers/gpu/drm/xe/xe_pm.c  | 52 ++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index f1ec6aa26faa..8fc650b2de02 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1141,7 +1141,7 @@ static int xe_pci_suspend(struct device *dev)
 
 	/*
 	 * Enabling D3Cold is needed for S2Idle/S0ix.
-	 * It is save to allow here since xe_pm_suspend has evicted
+	 * It is safe to allow here since xe_pm_suspend has evicted
 	 * the local memory and the direct complete optimization is disabled.
 	 */
 	d3cold_toggle(pdev, D3COLD_ENABLE);
@@ -1158,7 +1158,7 @@ static int xe_pci_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int err;
 
-	/* Give back the D3Cold decision to the runtime P M*/
+	/* Give back the D3Cold decision to the runtime PM */
 	d3cold_toggle(pdev, D3COLD_DISABLE);
 
 	err = pci_set_power_state(pdev, PCI_D0);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 2cbcb9de7586..1dd8e2c0f51e 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -205,10 +205,12 @@ int xe_pm_suspend(struct xe_device *xe, bool hibernation)
 
 	xe_display_pm_suspend(xe);
 
-	/* FIXME: Super racey... */
-	err = xe_bo_evict_all(xe);
-	if (err)
-		goto err_display;
+	if (hibernation || xe->d3cold.target_state != XE_D3COLD_VRSR) {
+		/* FIXME: Super racey... */
+		err = xe_bo_evict_all(xe);
+		if (err)
+			goto err;
+	}
 
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_suspend(gt);
@@ -222,6 +224,12 @@ int xe_pm_suspend(struct xe_device *xe, bool hibernation)
 
 	xe_i2c_pm_suspend(xe);
 
+	if (!hibernation && xe->d3cold.target_state == XE_D3COLD_VRSR) {
+		err = xe_pm_vrsr_enable(xe);
+		if (err)
+			goto err_display;
+	}
+
 	drm_dbg(&xe->drm, "Device suspended\n");
 	xe_pm_block_end_signalling();
 
@@ -264,15 +272,20 @@ int xe_pm_resume(struct xe_device *xe, bool hibernation)
 	if (err)
 		return err;
 
+	if (!hibernation && xe->d3cold.target_state == XE_D3COLD_VRSR)
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
+	if (hibernation || xe->d3cold.target_state != XE_D3COLD_VRSR) {
+		err = xe_bo_restore_early(xe);
+		if (err)
+			goto err;
+	}
 
 	xe_i2c_pm_resume(xe, true);
 
@@ -292,9 +305,11 @@ int xe_pm_resume(struct xe_device *xe, bool hibernation)
 	if (err)
 		goto err;
 
-	err = xe_bo_restore_late(xe);
-	if (err)
-		goto err;
+	if (hibernation || xe->d3cold.target_state != XE_D3COLD_VRSR) {
+		err = xe_bo_restore_late(xe);
+		if (err)
+			goto err;
+	}
 
 	xe_pxp_pm_resume(xe->pxp);
 
@@ -740,7 +755,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
@@ -758,6 +773,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_i2c_pm_suspend(xe);
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
+		err = xe_pm_vrsr_enable(xe);
+		if (err) {
+			drm_err(&xe->drm, "Failed to enable VRSR: %d\n", err);
+			goto out_resume;
+		}
+	}
+
 	xe_rpm_lockmap_release(xe);
 	xe_pm_write_callback_task(xe, NULL);
 	return 0;
@@ -789,6 +812,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_rpm_lockmap_acquire(xe);
 
+	if (xe->d3cold.target_state == XE_D3COLD_VRSR)
+		xe_pm_vrsr_disable(xe);
+
 	if (xe->d3cold.target_state) {
 		for_each_gt(gt, xe, id)
 			xe_gt_idle_disable_c6(gt);
@@ -798,7 +824,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			goto out;
 
 		xe_display_pm_resume_early(xe);
+	}
 
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		/*
 		 * This only restores pinned memory which is the memory
 		 * required for the GT(s) to resume.
@@ -826,7 +854,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	if (err)
 		goto out;
 
-	if (xe->d3cold.target_state) {
+	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
 		err = xe_bo_restore_late(xe);
 		if (err)
 			goto out;
-- 
2.52.0


