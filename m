Return-Path: <linux-pci+bounces-22243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A106A4285B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11343A7537
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA6263C72;
	Mon, 24 Feb 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WW61np/K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26132627F2;
	Mon, 24 Feb 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415835; cv=none; b=dq4N0tgOnM+vN04IypkhEGJ9OJwzxYsW78UxPxE8kyP3pMWQz0yv39AxxkvigEvsEDoAn77D2gY/ecqdGyOSea+3NvH2b6cuWVdeuM9JFmQApT/GIi7DrIhJ8ITxnL4n+Dj5Cmr8L/+JID3LfpOwT7CZzE1G+siOx/eVvFZFZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415835; c=relaxed/simple;
	bh=vMWP1X1cnE+Dg2jsB5PyLd3fB7XjQNnO/YdhAylQXkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Az5yV7Y6zh0KGvXJCwvgNYd8Hs6bm2yOlr8yFnsGJ6msWpCZ0D6mumjhCpLK/Ifbh0Gy6vLumzNwkvsxMwG1572nB39enkbCWRAm/ceYAjm2mO4CRh2+caXknzHfeieQ+rYnF6f12M6UuE3Z8BqRqJSUULIQe2I94ZPBFtPGokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WW61np/K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740415834; x=1771951834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMWP1X1cnE+Dg2jsB5PyLd3fB7XjQNnO/YdhAylQXkI=;
  b=WW61np/K/CpDvCJxgLALmKliNLC9XlDTzcJuho26yUA8ofkrCPgUOea2
   dDmqgwQGv8v6nvbcfmFIFAXAc+wSjIPtBg2PhLpbtqSYtghzL9FfaNo6e
   8tjFpYyTTtRT7Ropcy6ZvKuQNdxssmR6Xy6NANsK6DMTrSwr36l5cpPTU
   aHfa/0Xxu2373rtuP7Q6KlxxxVtxnv4zIoEoDU/b+MfK5hFHlFvuVfejG
   cvZcz/SuHvXICkF4t2F1YMj5VLYYhVDkkNluu6Cm8Ua2bcaZPgWEX7HWN
   DcOJyS4IMzrx8MNDoJbq8DuYDT1tITlGJLNSZsQC+9t89N9dhToTYYtvh
   g==;
X-CSE-ConnectionGUID: iPLwvbiWSTyb+B6DPdySmQ==
X-CSE-MsgGUID: mYeUAt4rTBKnWOTIsYcynw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41063227"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41063227"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:34 -0800
X-CSE-ConnectionGUID: CILdZhPZQgaBWolf7fwafg==
X-CSE-MsgGUID: YETGrKstSGKRhD+szY1Yyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121032469"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:30 -0800
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
	kam.nasim@intel.com,
	Anshuman Gupta <anshuman.gupta@intel.com>
Subject: [RFC 6/6] drm/xe/vrsr: Enable VRSR
Date: Mon, 24 Feb 2025 22:18:49 +0530
Message-Id: <20250224164849.3746751-7-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224164849.3746751-1-anshuman.gupta@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
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
 drivers/gpu/drm/xe/xe_pm.c  | 49 +++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 70b697fde5b9..55b42b3a10d2 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -967,7 +967,7 @@ static int xe_pci_suspend(struct device *dev)
 
 	/*
 	 * Enabling D3Cold is needed for S2Idle/S0ix.
-	 * It is save to allow here since xe_pm_suspend has evicted
+	 * It is safe to allow here since xe_pm_suspend has evicted
 	 * the local memory and the direct complete optimization is disabled.
 	 */
 	d3cold_toggle(pdev, D3COLD_ENABLE);
@@ -983,7 +983,7 @@ static int xe_pci_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int err;
 
-	/* Give back the D3Cold decision to the runtime P M*/
+	/* Give back the D3Cold decision to the runtime PM */
 	d3cold_toggle(pdev, D3COLD_DISABLE);
 
 	err = pci_set_power_state(pdev, PCI_D0);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 6d28aedcb062..5c96f8629a87 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -232,10 +232,12 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_display_pm_suspend(xe);
 
-	/* FIXME: Super racey... */
-	err = xe_bo_evict_all(xe);
-	if (err)
-		goto err_pxp;
+	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
+		/* FIXME: Super racey... */
+		err = xe_bo_evict_all(xe);
+		if (err)
+			goto err_pxp;
+	}
 
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_suspend(gt);
@@ -247,6 +249,12 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_display_pm_suspend_late(xe);
 
+	if (xe->d3cold.allowed == XE_D3COLD_VRSR) {
+		err = xe_pm_enable_vrsr(xe, true);
+			if (err)
+				goto err_display;
+	}
+
 	drm_dbg(&xe->drm, "Device suspended\n");
 	return 0;
 
@@ -288,9 +296,11 @@ int xe_pm_resume(struct xe_device *xe)
 	 * This only restores pinned memory which is the memory required for the
 	 * GT(s) to resume.
 	 */
-	err = xe_bo_restore_kernel(xe);
-	if (err)
-		goto err;
+	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
+		err = xe_bo_restore_kernel(xe);
+		if (err)
+			goto err;
+	}
 
 	xe_irq_resume(xe);
 
@@ -299,9 +309,11 @@ int xe_pm_resume(struct xe_device *xe)
 
 	xe_display_pm_resume(xe);
 
-	err = xe_bo_restore_user(xe);
-	if (err)
-		goto err;
+	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
+		err = xe_bo_restore_user(xe);
+		if (err)
+			goto err;
+	}
 
 	xe_pxp_pm_resume(xe->pxp);
 
@@ -543,7 +555,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out_resume;
@@ -559,6 +571,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	xe_display_pm_runtime_suspend_late(xe);
 
+	if (xe->d3cold.allowed == XE_D3COLD_VRSR) {
+		err = xe_pm_enable_vrsr(xe, true);
+			if (err) {
+				drm_err(&xe->drm, "Failed to enable VRSR: %d\n", err);
+				goto out_resume;
+			}
+	}
+
 	xe_rpm_lockmap_release(xe);
 	xe_pm_write_callback_task(xe, NULL);
 	return 0;
@@ -590,7 +610,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_rpm_lockmap_acquire(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
 		err = xe_pcode_ready(xe, true);
 		if (err)
 			goto out;
@@ -606,6 +626,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			goto out;
 	}
 
+	if (xe->d3cold.allowed == XE_D3COLD_VRSR)
+		xe_display_pm_resume_early(xe);
+
 	xe_irq_resume(xe);
 
 	for_each_gt(gt, xe, id)
@@ -613,7 +636,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_display_pm_runtime_resume(xe);
 
-	if (xe->d3cold.allowed) {
+	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
 		err = xe_bo_restore_user(xe);
 		if (err)
 			goto out;
-- 
2.34.1


