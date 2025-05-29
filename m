Return-Path: <linux-pci+bounces-28603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279CDAC7C84
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A8E7A1DB3
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21FB1F7075;
	Thu, 29 May 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eo+oFKu/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5A21882B;
	Thu, 29 May 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517312; cv=none; b=VeAU5SGtq1+Gx6YAIeda1DEOHbgy/aJ/XlVp8hIyLNAq0ddklWDpydAE2F+QDsb8VofOCw2v3LoZn5SvuZvy1tA63HeNI7eciUd0dvFMrYjUwf7XcdQu6ICnWzdDcmBFbzfBfarUPEj7OzCK+49AkdkE3XhdLwXkc4FVQ6FUiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517312; c=relaxed/simple;
	bh=gzhdE5y3lhUr2rWxOg/vRRvTqpZk42Yf+2TMKejj6qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LglKRo+Wbf2jPb2McxtKiJqS1zL1MUelL16cKHN5cWIei1gyRdPChTSzIri2XveZ0AnUgUJd5Do7Bw16NyfMzXK/RAmHEC4IxE6PS5R1dlYvtronbt4BgpXlez2ebf+0Hx6wA5W56dpT9GK6KogsrKGc0tyb0XWeYrcpuZbTdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eo+oFKu/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517311; x=1780053311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gzhdE5y3lhUr2rWxOg/vRRvTqpZk42Yf+2TMKejj6qg=;
  b=Eo+oFKu/Wu9qW9VfLQFJ3rUS/Wt8YELrSCEURI4bmjMZ7cWjmfXbRYq7
   CEGOEjxoRo9tQdb75SwBrXsRKZJkjZEXOm98TN1rOGkG3+9jPk+dO5WNv
   dGOrYPAUN/DsfrMhWGOgNhgvgOT53LPM7HhFfi5ZPPuz7cH6YogevCaQj
   feTWkFtjJE4hZwJpuFpWDhQ+67+rNB3PkLMPEuOJjUBhvWKB5ZW22jUM1
   LHg+aRarhaRVngFDnOgivoSHRqaGbFGR9tmvUh14Zl4pc+EY9E3tGijcp
   0ts2s0gxitb2b2LiXndDFQ9UMj9qkkJxrFJ+zOL69i6KlBtgESinaKEmh
   Q==;
X-CSE-ConnectionGUID: OAPb7NHaSQaHkazifsR/7g==
X-CSE-MsgGUID: 7LBc4wVMShS4MfgAgNLD2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68123162"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="68123162"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:11 -0700
X-CSE-ConnectionGUID: xgmMoqQLSIueKhbol7T1Qg==
X-CSE-MsgGUID: BMLFaOhGRVCICKv0tDuV0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="143510526"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:07 -0700
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
Subject: [PATCH v4 07/11] drm/xe/vrsr: Enable VRSR on default VGA boot device
Date: Thu, 29 May 2025 16:46:50 +0530
Message-Id: <20250529111654.3140766-8-badal.nilawar@intel.com>
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

The VRSR feature is to enhance the display screen refresh experience
when the device exits from the D3Cold state. Therefore, apply the VRSR
feature to the default VGA boot device and when a display is connected.

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/xe/display/xe_display.h |  2 ++
 drivers/gpu/drm/xe/xe_pm.c              |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 20c3bcd953b7..b3da88b12b35 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -88,6 +88,28 @@ static void display_destroy(struct drm_device *dev, void *dummy)
 	destroy_workqueue(xe->display.hotplug.dp_wq);
 }
 
+bool xe_display_connected(struct xe_device *xe)
+{
+	struct drm_connector *list_connector;
+	struct drm_connector_list_iter iter;
+	bool ret = false;
+
+	mutex_lock(&xe->drm.mode_config.mutex);
+	drm_connector_list_iter_begin(&xe->drm, &iter);
+
+	drm_for_each_connector_iter(list_connector, &iter) {
+		if (list_connector->status == connector_status_connected) {
+			ret = true;
+			break;
+		}
+	}
+
+	drm_connector_list_iter_end(&iter);
+	mutex_unlock(&xe->drm.mode_config.mutex);
+
+	return ret;
+}
+
 /**
  * xe_display_create - create display struct
  * @xe: XE device instance
diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
index 46e14f8dee28..c79441bccb43 100644
--- a/drivers/gpu/drm/xe/display/xe_display.h
+++ b/drivers/gpu/drm/xe/display/xe_display.h
@@ -39,6 +39,7 @@ void xe_display_pm_resume(struct xe_device *xe);
 void xe_display_pm_runtime_suspend(struct xe_device *xe);
 void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
 void xe_display_pm_runtime_resume(struct xe_device *xe);
+bool xe_display_connected(struct xe_device *xe);
 
 #else
 
@@ -71,5 +72,6 @@ static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_suspend_late(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
 
+static inline bool xe_display_connected(struct xe_device *xe) { return false; }
 #endif /* CONFIG_DRM_XE_DISPLAY */
 #endif /* _XE_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 278f2eeeaab6..c84b9b3f7371 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -9,6 +9,7 @@
 #include <linux/fault-inject.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
+#include <linux/vgaarb.h>
 
 #include <drm/drm_managed.h>
 #include <drm/ttm/ttm_placement.h>
@@ -310,6 +311,7 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
 
 static void xe_pm_vrsr_init(struct xe_device *xe)
 {
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 	int ret;
 
 	/* Check if platform support D3Cold VRSR */
@@ -319,6 +321,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
 	if (!xe_pm_vrsr_capable(xe))
 		return;
 
+	if (pdev != vga_default_device() || !xe_display_connected(xe))
+		return;
+
 	/*
 	 * If the VRSR initialization fails, the device will proceed with the regular
 	 * D3Cold flow
-- 
2.34.1


