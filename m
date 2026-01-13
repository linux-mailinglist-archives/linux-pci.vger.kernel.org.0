Return-Path: <linux-pci+bounces-44639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31FD1A514
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500EC30A28F1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B830AAC2;
	Tue, 13 Jan 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgnVZPQL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8415B2DC763;
	Tue, 13 Jan 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321958; cv=none; b=N1s1ZU1pqTElT0tPCBWf381kibQjZ5BN9tsPK405bYdH8OjcBHL1vb1zkN5jcwc3RVfP+kaLZfSy2aEByTX5oRAnlEXSl7EMZJNsPEhGJp719DpGD6o3mmJ4ClBOVXnq9FAOR8Sh2toUISEV/hVUf1wuTxOKyZuILF+0uON6fLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321958; c=relaxed/simple;
	bh=5V9WxQCwkPKXAGgTcAIhV1W/VXY8KjUacpOsn36aCWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOLL6giE9o/iAI0h6EJRRI0ePqkmivYCl2dIGADmh3kdsx0fmEHGwnsIVJgrO7TXOYt12apXUxS+8KYC/S+iNDLFLs3jVEZTRUI2qeng4TU+dBS7wsu3tSSrXYG/quNjMMiN/PU7+UsX3O84EB78FCsB+P5oWS5J1T+O2o6ZSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgnVZPQL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321957; x=1799857957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5V9WxQCwkPKXAGgTcAIhV1W/VXY8KjUacpOsn36aCWY=;
  b=QgnVZPQLrXX3UW9vPAdnsorTSYRinL0Pm+2aMvsfn+3CRag9JEVcYXei
   uHArNNXVcuYg/r+LmvSmx4lrezxM2HgnWWKh/RvXbpIOwUKiP2ouAIEYV
   8fTbLSaZ0fqYZ11Qdpr38+PxyVgFw5N/05K+fxL3ZFmLU1ZIf/8b273KY
   7YbLq+T1ChbCyWkn3gm0rOJFMaTC0ZWsHY8POl2bk7L0+K9XVIT1lUs05
   QPPPur/OLL+5FpXV1m3BruXVfP2l9vJmoWJfzuHKrqeAYybYcQFECzvTh
   HCyEc85wixy/IttfA/HgJIeHlZv9iSvTt2/CDB4IdSIGK4iosCw6LNWIG
   w==;
X-CSE-ConnectionGUID: OAYTRe3NTMOEeFVZRrtWhA==
X-CSE-MsgGUID: VFUAgOEuQRiy5XQEV5jSMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521073"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521073"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:37 -0800
X-CSE-ConnectionGUID: hWaKj+imSnWwQjSBkxhgKA==
X-CSE-MsgGUID: awwNRpMVRsiip+CF+kAHhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060184"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:33 -0800
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
Subject: [PATCH v6 09/12] drm/xe/pm: Refactor PM Sleep Ops
Date: Tue, 13 Jan 2026 22:12:10 +0530
Message-ID: <20260113164200.1151788-23-badal.nilawar@intel.com>
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

Refactor PM Sleep OPS to indicate xe_pm_suspend/resume is called
during hibernation (S4) or suspend (S3/S2idle).

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_pci.c | 64 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_pm.c  | 10 +++---
 drivers/gpu/drm/xe/xe_pm.h  |  4 +--
 3 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index e1de6b337f1f..f1ec6aa26faa 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -1135,7 +1135,7 @@ static int xe_pci_suspend(struct device *dev)
 	if (xe_survivability_mode_is_boot_enabled(xe))
 		return -EBUSY;
 
-	err = xe_pm_suspend(xe);
+	err = xe_pm_suspend(xe, false);
 	if (err)
 		return err;
 
@@ -1173,13 +1173,66 @@ static int xe_pci_resume(struct device *dev)
 
 	pci_set_master(pdev);
 
-	err = xe_pm_resume(pdev_to_xe_device(pdev));
+	err = xe_pm_resume(pdev_to_xe_device(pdev), false);
 	if (err)
 		return err;
 
 	return 0;
 }
 
+static int xe_pci_freeze(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct xe_device *xe = pdev_to_xe_device(pdev);
+	int err;
+
+	if (xe_survivability_mode_is_boot_enabled(xe))
+		return -EBUSY;
+
+	err = xe_pm_suspend(xe, true);
+	if (err)
+		return err;
+
+	/*
+	 * Enabling D3Cold is needed for S2Idle/S0ix.
+	 * It is save to allow here since xe_pm_suspend has evicted
+	 * the local memory and the direct complete optimization is disabled.
+	 */
+	d3cold_toggle(pdev, D3COLD_ENABLE);
+
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, PCI_D3cold);
+
+	return 0;
+}
+
+static int xe_pci_thaw(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int err;
+
+	/* Give back the D3Cold decision to the runtime P M*/
+	d3cold_toggle(pdev, D3COLD_DISABLE);
+
+	err = pci_set_power_state(pdev, PCI_D0);
+	if (err)
+		return err;
+
+	pci_restore_state(pdev);
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	pci_set_master(pdev);
+
+	err = xe_pm_resume(pdev_to_xe_device(pdev), true);
+	if (err)
+		return err;
+
+	return 0;
+}
 static int xe_pci_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1248,7 +1301,12 @@ static int xe_pci_runtime_idle(struct device *dev)
 }
 
 static const struct dev_pm_ops xe_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(xe_pci_suspend, xe_pci_resume)
+	.suspend = xe_pci_suspend,
+	.resume = xe_pci_resume,
+	.freeze = xe_pci_freeze,
+	.thaw = xe_pci_thaw,
+	.poweroff = xe_pci_freeze,
+	.restore = xe_pci_thaw,
 	SET_RUNTIME_PM_OPS(xe_pci_runtime_suspend, xe_pci_runtime_resume, xe_pci_runtime_idle)
 };
 #endif
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 1a1edbfcf240..2cbcb9de7586 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -178,16 +178,17 @@ static void xe_pm_suspend_prepare(struct xe_device *xe)
 /**
  * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
  * @xe: xe device instance
+ * @hibernation: whether the suspend is for hibernation
  *
  * Return: 0 on success
  */
-int xe_pm_suspend(struct xe_device *xe)
+int xe_pm_suspend(struct xe_device *xe, bool hibernation)
 {
 	struct xe_gt *gt;
 	u8 id;
 	int err;
 
-	drm_dbg(&xe->drm, "Suspending device\n");
+	drm_dbg(&xe->drm, "Suspending device for %s\n", hibernation ? "hibernation" : "S3/S2idle");
 	xe_pm_block_begin_signalling();
 	trace_xe_pm_suspend(xe, __builtin_return_address(0));
 
@@ -238,10 +239,11 @@ int xe_pm_suspend(struct xe_device *xe)
 /**
  * xe_pm_resume - Helper for System resume S3->S0 / S2idle->S0
  * @xe: xe device instance
+ * @hibernation: whether the resume is from hibernation
  *
  * Return: 0 on success
  */
-int xe_pm_resume(struct xe_device *xe)
+int xe_pm_resume(struct xe_device *xe, bool hibernation)
 {
 	struct xe_tile *tile;
 	struct xe_gt *gt;
@@ -249,7 +251,7 @@ int xe_pm_resume(struct xe_device *xe)
 	int err;
 
 	xe_pm_block_begin_signalling();
-	drm_dbg(&xe->drm, "Resuming device\n");
+	drm_dbg(&xe->drm, "Resuming device from %s\n", hibernation ? "hibernation" : "S3/S2idle");
 	trace_xe_pm_resume(xe, __builtin_return_address(0));
 
 	for_each_gt(gt, xe, id)
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index cd7b4a9b2c05..973475f2f7dd 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -19,8 +19,8 @@ enum xe_d3_state {
 	XE_D3COLD_OFF,
 };
 
-int xe_pm_suspend(struct xe_device *xe);
-int xe_pm_resume(struct xe_device *xe);
+int xe_pm_suspend(struct xe_device *xe, bool hibernation);
+int xe_pm_resume(struct xe_device *xe, bool hibernation);
 
 int xe_pm_init_early(struct xe_device *xe);
 int xe_pm_init(struct xe_device *xe);
-- 
2.52.0


