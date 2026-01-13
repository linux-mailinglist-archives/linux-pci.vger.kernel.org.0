Return-Path: <linux-pci+bounces-44636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F6D1A48D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91E8D300A901
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833442853EE;
	Tue, 13 Jan 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khppOlfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B41B3925;
	Tue, 13 Jan 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321946; cv=none; b=s66ZtEExvJTdJu5TadHFOdwlVdyO0OERSsl58dgEurU+8d79MNQ4CqAQ5oGFxJkskZXUlnXsh4TlRqcUa7fI2sjwNXHoJZ3Xuy7iPyi1v57pu/3FZEKjvgamDItfJbYmURe+YU+A1Np/Kq0RLW0SzUT8C7vYQ6+Cgci4eyw/UCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321946; c=relaxed/simple;
	bh=UBSkZCnczDCOM9e7bM9QQmn2oCcGZ3C8UJHokcmksvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8MjFmDZrRQzeJd2QPfO3LSfsq6finlaSdtybwFZHEzqrq1285ZP4SmUnYEZxwCTobPR3v0YBROd7N7oh6ehQs7x/5WXa4kJGwehp9PxM4DL6F1ZjZ65nR5yFLw5oUBV6Q9ytXoeMsD6oM5r9iRp2Ax+1e+EIpgTW7/S9mgYNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khppOlfI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321944; x=1799857944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UBSkZCnczDCOM9e7bM9QQmn2oCcGZ3C8UJHokcmksvs=;
  b=khppOlfI4LHxDSKHn5QkvEdJVXM0BMGLV3z6rVoxYm3dB4Wbif6ZhQXN
   eCmcnBBOmzAqGjZUegIKeLzD+Rbzm5pculvQPkLWqEogq49rihxnGXn7i
   ayEfecoZlzHMCbsf8MRRDIp598vdp0FivWMC8fSx6gCXuqsl0RYuAKq4Z
   JWLuOB7shkdOC8EtZwfbhHS1EL0mewblTdOV5qqKELcNYOoJqMTIRtZHJ
   gtVoLqcoN516mFqkmHiOFs6oraJJ3BIJ72Sdex1X1kGkMRH3wpVEZ5W+n
   SQmd3O7WxJ2e5z6qZIeF2PdrpqrVZPat8uez6n4VD3E9RCh98He8fvwzC
   w==;
X-CSE-ConnectionGUID: Ke3jGdupQZy9RdfTqwchlQ==
X-CSE-MsgGUID: WTIawu92RUiX8gRve39cVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521037"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521037"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:24 -0800
X-CSE-ConnectionGUID: Q2P+h4seTLiI7LJmSg5rkg==
X-CSE-MsgGUID: hPMaeO/DTsORNMTL4RGoqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060149"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:20 -0800
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
Subject: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot device
Date: Tue, 13 Jan 2026 22:12:07 +0530
Message-ID: <20260113164200.1151788-20-badal.nilawar@intel.com>
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

The VRSR feature is to enhance the display screen refresh experience
when the device exits from the D3cold state. Therefore, apply the VRSR
feature to the default VGA boot device and when a display is connected.

v2: Move generic display logic to i915/display (Jani)

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 22 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_display.h |  1 +
 drivers/gpu/drm/xe/display/xe_display.c      |  5 +++++
 drivers/gpu/drm/xe/display/xe_display.h      |  2 ++
 drivers/gpu/drm/xe/xe_pm.c                   |  5 +++++
 5 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 81b3a6692ca2..97c74272fb19 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -8426,3 +8426,25 @@ bool intel_scanout_needs_vtd_wa(struct intel_display *display)
 {
 	return IS_DISPLAY_VER(display, 6, 11) && intel_display_vtd_active(display);
 }
+
+bool intel_display_connected(struct intel_display *display)
+{
+	struct drm_connector *list_connector;
+	struct drm_connector_list_iter iter;
+	bool ret = false;
+
+	mutex_lock(&display->drm->mode_config.mutex);
+	drm_connector_list_iter_begin(display->drm, &iter);
+
+	drm_for_each_connector_iter(list_connector, &iter) {
+		if (list_connector->status == connector_status_connected) {
+			ret = true;
+			break;
+		}
+	}
+
+	drm_connector_list_iter_end(&iter);
+	mutex_unlock(&display->drm->mode_config.mutex);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
index f8e6e4e82722..20690aa59324 100644
--- a/drivers/gpu/drm/i915/display/intel_display.h
+++ b/drivers/gpu/drm/i915/display/intel_display.h
@@ -560,5 +560,6 @@ bool assert_port_valid(struct intel_display *display, enum port port);
 
 bool intel_scanout_needs_vtd_wa(struct intel_display *display);
 int intel_crtc_num_joined_pipes(const struct intel_crtc_state *crtc_state);
+bool intel_display_connected(struct intel_display *display);
 
 #endif
diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index f8a831b5dc7d..54ed39b257ad 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -64,6 +64,11 @@ bool xe_display_driver_probe_defer(struct pci_dev *pdev)
 	return intel_display_driver_probe_defer(pdev);
 }
 
+bool xe_display_connected(struct xe_device *xe)
+{
+	return intel_display_connected(xe->display);
+}
+
 /**
  * xe_display_driver_set_hooks - Add driver flags and hooks for display
  * @driver: DRM device driver
diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
index 76db95c25f7e..11d4b09808e5 100644
--- a/drivers/gpu/drm/xe/display/xe_display.h
+++ b/drivers/gpu/drm/xe/display/xe_display.h
@@ -37,6 +37,7 @@ void xe_display_pm_resume(struct xe_device *xe);
 void xe_display_pm_runtime_suspend(struct xe_device *xe);
 void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
 void xe_display_pm_runtime_resume(struct xe_device *xe);
+bool xe_display_connected(struct xe_device *xe);
 
 #else
 
@@ -67,5 +68,6 @@ static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_suspend_late(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
 
+static inline bool xe_display_connected(struct xe_device *xe) { return false; }
 #endif /* CONFIG_DRM_XE_DISPLAY */
 #endif /* _XE_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 3fe673f0f87d..e7aa876ce9e0 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -9,6 +9,7 @@
 #include <linux/fault-inject.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
+#include <linux/vgaarb.h>
 
 #include <drm/drm_managed.h>
 #include <drm/ttm/ttm_placement.h>
@@ -387,6 +388,7 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
 
 static void xe_pm_vrsr_init(struct xe_device *xe)
 {
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 	int ret;
 
 	if (!xe->info.has_vrsr)
@@ -395,6 +397,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
 	if (!xe_pm_vrsr_capable(xe))
 		return;
 
+	if (pdev != vga_default_device() || !xe_display_connected(xe))
+		return;
+
 	/*
 	 * If the VRSR initialization fails, the device will proceed with the regular
 	 * D3cold flow
-- 
2.52.0


