Return-Path: <linux-pci+bounces-28601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98CAC7C7F
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC8B3AA80D
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A0028E61C;
	Thu, 29 May 2025 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W02c2k0L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306D28E607;
	Thu, 29 May 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517305; cv=none; b=H6CMTjMLJBKD+5os6DQtIyBmU9PG1hgC+E7PNkPK6x7YTNr0YrcHRjmNGexTkyvphxKaF0cUexqhJGoK7NK35Ogy/EZi+9x4GAjhkfXXZdX733d/OKb1/dQ6Mqh34YZ/Z07TmKUd2tYcHrr1tFURMTVq3zeI4VaTmxp2cRnBCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517305; c=relaxed/simple;
	bh=lxHKZKVOenroNxh0FcZyRwd8gvSEvY446e/mnHo3N/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyjRoNir0SlwKyqqiWAa1iRWH0tQPm33X1SQ5vcfM+QCsZK9yZEXPtDkrirF5TCdogLS5AOgllwDa7ZANPD5W8pAZOZ4k59wmfVEpnljY9B7rNkLHeKlfcLkoHYJI3gvKJsvNqnvZHdbwVuEIHkbnEZMgxuFahkcZvCJzbQEeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W02c2k0L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517304; x=1780053304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lxHKZKVOenroNxh0FcZyRwd8gvSEvY446e/mnHo3N/0=;
  b=W02c2k0LL7VCZlbacrNMX4r99KUOUPnc6VNue2uZrolV5Ft4c3hM5P81
   KFKmPt93RLaC+vVwWKgjGhyrOP2iO2CcB4MlpTwdP4Vn7BAyGpraRK70h
   DaQFlaMCyiYfoSDSJWktezG9r5jr9gtyshjX57oKkiTJOEhdozJNYGFo/
   DB20CgSQIDRolc3PzGBBHe44aV5D1vhg0Ih68YPKcn7PDMoSp5yvbwuIZ
   yFo6MJzyiDCO4eYc80pPjN4zaxYdxVBOTufiYBBeZNGP2GyyoElsTQ1YB
   lzY8ciZMCJifoWbyYAePFK025f9S99mTQbLB2sTD9U3LGj7Sk596tIX35
   w==;
X-CSE-ConnectionGUID: vRJMbFJfQ0euMJ7JE+UvuA==
X-CSE-MsgGUID: MP/NVeHnRt+sO8vFFilfDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68123140"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="68123140"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:03 -0700
X-CSE-ConnectionGUID: YRErPp/vSEmm1GnbEp/dmw==
X-CSE-MsgGUID: DUd5Nw4wTnyGuamw08ljgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="143510464"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:00 -0700
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
Subject: [PATCH v4 05/11] drm/xe/vrsr: Detect VRSR Capability
Date: Thu, 29 May 2025 16:46:48 +0530
Message-Id: <20250529111654.3140766-6-badal.nilawar@intel.com>
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

Detect VRAM Self Refresh(vrsr) Capability.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_regs.h    |  3 +++
 drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
 drivers/gpu/drm/xe/xe_pm.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_regs.h b/drivers/gpu/drm/xe/regs/xe_regs.h
index 3abb17d2ca33..4db486fb310a 100644
--- a/drivers/gpu/drm/xe/regs/xe_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_regs.h
@@ -53,6 +53,9 @@
 #define MTL_MPE_FREQUENCY			XE_REG(0x13802c)
 #define   MTL_RPE_MASK				REG_GENMASK(8, 0)
 
+#define VRAM_SR_CAPABILITY                         XE_REG(0x138144)
+#define   VRAM_SR_SUPPORTED                        REG_BIT(0)
+
 #define VF_CAP_REG				XE_REG(0x1901f8, XE_REG_OPTION_VF)
 #define   VF_CAP				REG_BIT(0)
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index e2749ed2a61f..3a15b3a252fd 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -512,6 +512,9 @@ struct xe_device {
 		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
 		bool allowed;
 
+		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
+		bool vrsr_capable;
+
 		/**
 		 * @d3cold.vram_threshold:
 		 *
@@ -522,6 +525,7 @@ struct xe_device {
 		 * Default threshold value is 300mb.
 		 */
 		u32 vram_threshold;
+
 		/** @d3cold.lock: protect vram_threshold */
 		struct mutex lock;
 	} d3cold;
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 693866def183..c9395e62d21d 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -13,13 +13,16 @@
 #include <drm/ttm/ttm_placement.h>
 
 #include "display/xe_display.h"
+#include "regs/xe_regs.h"
 #include "xe_bo.h"
 #include "xe_bo_evict.h"
 #include "xe_device.h"
+#include "xe_force_wake.h"
 #include "xe_ggtt.h"
 #include "xe_gt.h"
 #include "xe_guc.h"
 #include "xe_irq.h"
+#include "xe_mmio.h"
 #include "xe_pcode.h"
 #include "xe_pxp.h"
 #include "xe_trace.h"
@@ -235,6 +238,28 @@ static bool xe_pm_pci_d3cold_capable(struct xe_device *xe)
 	return true;
 }
 
+static bool xe_pm_vrsr_capable(struct xe_device *xe)
+{
+	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
+	unsigned int fw_ref;
+	struct xe_gt *gt;
+	u32 val;
+
+	gt = xe_root_mmio_gt(xe);
+
+	if (!xe->info.probe_display)
+		return false;
+
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (!fw_ref)
+		return false;
+
+	val = xe_mmio_read32(mmio, VRAM_SR_CAPABILITY);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+
+	return val & VRAM_SR_SUPPORTED;
+}
+
 static void xe_pm_runtime_init(struct xe_device *xe)
 {
 	struct device *dev = xe->drm.dev;
@@ -349,6 +374,7 @@ int xe_pm_init(struct xe_device *xe)
 		err = xe_pm_set_vram_threshold(xe, vram_threshold);
 		if (err)
 			goto err_unregister;
+		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
 	}
 
 	xe_pm_runtime_init(xe);
-- 
2.34.1


