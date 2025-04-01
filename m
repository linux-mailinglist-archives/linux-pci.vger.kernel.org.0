Return-Path: <linux-pci+bounces-25078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8CBA77F23
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700413AE85C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D720AF73;
	Tue,  1 Apr 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GV9AnRcU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC92046A8;
	Tue,  1 Apr 2025 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521791; cv=none; b=dkY/dahYaGO+CbXOqVoqfhlXiFdIQjeccX3bzYaVkvXZJ3ihdt/Umw2qtARlhbbJIjgvtvF5sOu9A6IbBP8OW/A3pMePju4lW7j71qFAaMT1Ht6yRPUGmEb4oB1EA6XwsNL3SWEmCMwKq8BHLvE6fnWZzf3lBOZ6d2V8vWV86Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521791; c=relaxed/simple;
	bh=1kVw63DFu0RhboG8D5eUTZLRgZ3R/5yhVNRksYbPPxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPstxwvJn9zQyn9OsSOK9EZlfUYrbnPg3e09zORWN7tTACESYH+lKYw9pgLPOL65CBCiF2DkOPJXvt64VzZh/o/mJNzDhfVF7av8fdhq1CXmyXPIwkVSXaS+mXODVKPP2rE44kq5xPdQuwi+U4bmEzBxDINkDj7FmEJreNDbtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GV9AnRcU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521790; x=1775057790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1kVw63DFu0RhboG8D5eUTZLRgZ3R/5yhVNRksYbPPxg=;
  b=GV9AnRcU9J/1RkM6C+T/DfQdlWyCeIJDZTNgXI5U6tbjcdkM+9gPfuff
   dlgcy344Vp7W01clxyURpFjIsL4IYMEc0m+2USS5ui2ez29/TKwLRslkD
   RFGtjtC3BPDDoCMlvUxc/XrFo62aohNIZf5uBeaoD8855jdcXOZwcMiwY
   dlXDy1vkcbfkBncnmuVinhVn9qxCQxOHPHMJPB41sNsJ/PiBp2fHcBqmt
   56lcTh5uXOOq1+tUMb5hMBYgPnZJKks6yzoWmT47U9fbfl3VSJzz2xWOU
   3NKeJoi7AuzEHCifXEULmaWIt+y9a4QAbyeUjrmrQwyft0ws7t4cZ7O2G
   A==;
X-CSE-ConnectionGUID: k4xH9c3bQvyI2AQjmJGyJw==
X-CSE-MsgGUID: iQoEdBD6QJGf43E3vJ6KSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324869"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324869"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:23 -0700
X-CSE-ConnectionGUID: I5er0o3tQjuqyBvLE3uBmg==
X-CSE-MsgGUID: 8rRGq7leS3uONrhGYUCDkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410883"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:19 -0700
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
	anshuman.gupta@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH 05/12] drm/xe/vrsr: Detect VRSR Capability
Date: Tue,  1 Apr 2025 21:02:18 +0530
Message-ID: <20250401153225.96379-6-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401153225.96379-1-anshuman.gupta@intel.com>
References: <20250401153225.96379-1-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect VRAM Self Refresh(vrsr) Capability.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_regs.h    |  3 +++
 drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
 drivers/gpu/drm/xe/xe_pm.c           | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

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
index b8ccf729f7c0..219800092b8d 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -498,6 +498,9 @@ struct xe_device {
 		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
 		bool allowed;
 
+		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
+		bool vrsr_capable;
+
 		/**
 		 * @d3cold.vram_threshold:
 		 *
@@ -508,6 +511,7 @@ struct xe_device {
 		 * Default threshold value is 300mb.
 		 */
 		u32 vram_threshold;
+
 		/** @d3cold.lock: protect vram_threshold */
 		struct mutex lock;
 	} d3cold;
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index a7ddf45db886..c96be409de49 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -17,12 +17,15 @@
 #include "xe_bo_evict.h"
 #include "xe_device.h"
 #include "xe_device_sysfs.h"
+#include "xe_force_wake.h"
 #include "xe_ggtt.h"
 #include "xe_gt.h"
 #include "xe_guc.h"
 #include "xe_irq.h"
+#include "xe_mmio.h"
 #include "xe_pcode.h"
 #include "xe_pxp.h"
+#include "regs/xe_regs.h"
 #include "xe_trace.h"
 #include "xe_wa.h"
 
@@ -236,6 +239,28 @@ static bool xe_pm_pci_d3cold_capable(struct xe_device *xe)
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
@@ -310,6 +335,8 @@ int xe_pm_init(struct xe_device *xe)
 		err = xe_pm_set_vram_threshold(xe, vram_threshold);
 		if (err)
 			return err;
+
+		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
 	}
 
 	xe_pm_runtime_init(xe);
-- 
2.43.0


