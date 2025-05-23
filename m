Return-Path: <linux-pci+bounces-28351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA7DAC2A25
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB677B4D3B
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F233B22541F;
	Fri, 23 May 2025 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUUtkb4Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50867204C0F;
	Fri, 23 May 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026827; cv=none; b=mbTqfw6j3CbLqOymYmuPPDAAZvIzC/M2hga7H+XNrQuBlpazkxYM1BVOCLMZkvrmsDbwd05dl720Ex8zfHRo2z+7YZ/a5Vz8yLn7+kMTZFkCdbq+lmujhK7i8NrSPesM7s7CqZ0RWqqlBScvVDXp11lt/YF6D+kUIJlCZg3AyqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026827; c=relaxed/simple;
	bh=bHhjXPjW14vl0hXyhieamfk7eD9SwgFwuqVjFNzqnTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J2X3SfJtKE0L2Tq2+O/f+MeEdEekla9I/fmJL/zF1SIQl7UYdCxOLcJv80vqIQsk1e4ZRDoAR+7sf2ELwPO6NKhi0VNLkyRgLKcg+qSsX4KkB8Isr9lyw/9rimXLa30xARXUoDBdbDKJRH5digRAq5O3UrIeYpFPEwO69wqGIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUUtkb4Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026827; x=1779562827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHhjXPjW14vl0hXyhieamfk7eD9SwgFwuqVjFNzqnTM=;
  b=gUUtkb4QgV3BBnC/yYXhUu5ibQA1u+77tNbROLrxr33TPFWtE0FLfLFi
   IUUiYC00urbdN3W56P9oSiGHxEaj3iGqTg1sa4zQDw4EVLcUSAgS8Vb1P
   tCla+wJIYmJXDrcjI8k2FrHw97NRMKlsIvUSmNKjlKW94jdd4ORLDaev5
   P+du/Y5saPxG3fAH1ae8jLx22YEB4yvrBL94a3Cex02fY+IlxrKGluLP5
   5RBzf405c+/W0Em/khOI+mxkxQh9QPhx7me/pkpvB2t+VOFDXIPAW8Dl6
   SR9GgeaPpd3b73B32hhPBZbYygcUgHM3MT3oe8AmkxT5oamBlUVYhwNSY
   g==;
X-CSE-ConnectionGUID: vgXH1F90RHuTx3Uv23/v7w==
X-CSE-MsgGUID: AQlh0mChSDuHTUQap67/3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498699"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498699"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:24 -0700
X-CSE-ConnectionGUID: XFhQepFiQZa2FHHRgZ3LOQ==
X-CSE-MsgGUID: 5whG7uvsSVy7uIn3wCRQpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141759081"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:21 -0700
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
Subject: [PATCH v3 10/11] drm/xe/vrsr: Enable VRSR
Date: Sat, 24 May 2025 00:31:54 +0530
Message-Id: <20250523190155.2623462-11-badal.nilawar@intel.com>
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


