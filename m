Return-Path: <linux-pci+bounces-28350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2144AC2A1D
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FD7A42350
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1829AB07;
	Fri, 23 May 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mH9meXK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95522541F;
	Fri, 23 May 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026823; cv=none; b=XDrOg3AsVnEpHJxGvbQjsjwhKVEUo8nbKS7D6dAr0sW1/rhBibVqJOaUpZl2cHkHSzyG+pocZcWAc2zM4c+OGpZl+H8zG93aUrfY4Icu4g1/DqPTENQaL6sRqCfESuyzEqwSF4OjKR8Z+jE7YXRTEB83emENLYatYO+PltnXaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026823; c=relaxed/simple;
	bh=zZkQPrOWz9t9zy6CLUbpHFxEOKK2DfWWIF4T94QYUl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0OhEBqIXs4Lp73SHSMB9p8vMvCTIJ/qVCwspjXOyymL7LSWhiG5b1S+1XlKBXY3I6+MvCjj7rvjHQ2Hzre9aBz7MGv86PhSOg5/UWOcPb0Ccz/SnsHE2dQt0lUcwJncJy3drzhe/IadeT3nEFeu0Dj0nTDfcWO1NyR2h2chrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mH9meXK6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026823; x=1779562823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZkQPrOWz9t9zy6CLUbpHFxEOKK2DfWWIF4T94QYUl4=;
  b=mH9meXK6UrzryKol9/yGsv8Ek/ivY1ERwfsAfFhApZxUkrKemhMqzvsv
   Fybb+NlNVxf1z5VKN0PeuVM/Xvpg0S9tfDOocdxJInoxWe/cOWZ6xgWGM
   1t84ZCsGgRk7qzDpXYfVC0rGjVSy60azawmISA0glYTGtwy/rvoCAnHgJ
   udCbEEA3aYFHrEMWJ1hnmcRDIRy+AItY/oL8pxuQnFF8Ovb0oVHr0hN2O
   LyXWNIYtj8H8IlSQAEsZSVMlIMflPjjI7MlX94Kk1v6nQXuUHW0eENeNY
   ZluggxJhgSYyEbji+VSjIH++HpU/9opZ9PnWC72nA7Vm0pGqhmzM3Tc+y
   A==;
X-CSE-ConnectionGUID: vtuYw/EGTCmyfyRoRzuQQw==
X-CSE-MsgGUID: JOT3pPPXSL2+uWTdFU9/BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498654"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498654"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:21 -0700
X-CSE-ConnectionGUID: GjhHGIOTS3eYo6/QDwjDkg==
X-CSE-MsgGUID: lyU9Bz4+RleHuBmYKWtL/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141759049"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:17 -0700
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
Subject: [PATCH v3 09/11] drm/xe/pm: D3Cold target state
Date: Sat, 24 May 2025 00:31:53 +0530
Message-Id: <20250523190155.2623462-10-badal.nilawar@intel.com>
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

Trade-off D3Cold target state based upon current vram usage.
If vram usage is greater than vram_d3cold_threshold and GPU
is VRSR capable target D3Cold state is D3Cold-VRSR
otherwise target state is D3Cold-Off.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index b86e95493cb5..1e061bfc3e52 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -113,6 +113,14 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
 			 &xe_pm_runtime_d3cold_map);
 }
 
+static void xe_pm_suspend_prepare(struct xe_device *xe)
+{
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
+		xe_pm_d3cold_target_state_toggle(xe);
+	else
+		xe->d3cold.target_state = XE_D3COLD_OFF;
+}
+
 /**
  * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
  * @xe: xe device instance
@@ -128,6 +136,8 @@ int xe_pm_suspend(struct xe_device *xe)
 	drm_dbg(&xe->drm, "Suspending device\n");
 	trace_xe_pm_suspend(xe, __builtin_return_address(0));
 
+	xe_pm_suspend_prepare(xe);
+
 	err = xe_pxp_pm_suspend(xe->pxp);
 	if (err)
 		goto err;
@@ -948,10 +958,14 @@ void xe_pm_d3cold_target_state_toggle(struct xe_device *xe)
 
 	if (total_vram_used_mb < xe->d3cold.vram_threshold)
 		xe->d3cold.target_state = XE_D3COLD_OFF;
+	else if (xe->d3cold.vrsr_capable)
+		xe->d3cold.target_state = XE_D3COLD_VRSR;
 	else
 		xe->d3cold.target_state = XE_D3HOT;
 
 	mutex_unlock(&xe->d3cold.lock);
+
+	drm_dbg(&xe->drm, "Xe D3cold target state %d\n", xe->d3cold.target_state);
 }
 
 /**
-- 
2.34.1


