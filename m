Return-Path: <linux-pci+bounces-22239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAC3A42846
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666271898E2B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF4262D3D;
	Mon, 24 Feb 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXY+/hvi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176592627F2;
	Mon, 24 Feb 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415820; cv=none; b=LXedfTX13CwgM9svghbPJ+vciNeRd9pz/WpWNqjxfF3LjmlFP5zP8aQEMYGRy5Hs3hP9yQ+Rt4JsyaySspKg1LKQMNvnDDMsYA3XOGY//b6eLycn9PcwMK2i3PUVDHRtObyyD2NxrkoZyBwG9rPbeOFleCdLbYQ8VGuRsmJc2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415820; c=relaxed/simple;
	bh=uy26mGDGVPF9x/+qQmcXIUmlZvjs+RGZJrKYOCea2Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7wZvmQxkSNSryw9cpVQ/9cN5uhbndBT0Hgsn0D0ZMYxBBIU3ntf2MoOjvwbddG5UL6KhK4nEUUcqgWIA9nusVtToa8mVJGZrUGCQefx9RHHGA3i5hOJgrdJ/LfjUtTkTg9Z/45mlRVwG4iLg2Zu2Ul0+yaGZGhwiWIAfNh0fdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXY+/hvi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740415819; x=1771951819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uy26mGDGVPF9x/+qQmcXIUmlZvjs+RGZJrKYOCea2Hg=;
  b=DXY+/hvipjgXWFxgjV7Ux/3UyrUt+BPUsABX/5D0mUeOcGJn7OrXgN/y
   cLRmfFcYPkiDsIjl3SpBByBU2UWx6XAETRvOQ5RcWunrEi+kdq36ooK6i
   R8FDzLQFA+yXIYLk8KAM6GGHYrqUOwTWa+XF+UCKZ1sG80osLhr/V2BKZ
   0LOtyO8LPMGmM6JbixM1iHFiVejSTRQ5X0dM6nM3ZuvsQ60ZvJpYHUZjd
   EFy/w/XR6ZS7D6T42+LXuRwPuBuTD4fyxCztq7wXbh6D6UhN55POGvFsS
   ybaFaTA8QoRtasACrrzkYUWH8s2weNf50iTCwzp/oZoc3LcWx13rdVUTK
   A==;
X-CSE-ConnectionGUID: zw4sDPz+QNuZz0etiz/vfg==
X-CSE-MsgGUID: o55O/REcTsWIhzDYeUah6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41063195"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41063195"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:19 -0800
X-CSE-ConnectionGUID: fjPxS7m+SZqQUP7vAkl1PQ==
X-CSE-MsgGUID: kThcxfqMQteGnAZGendkBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121032360"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:16 -0800
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
Subject: [RFC 2/6] drm/xe/vrsr: Detect vrsr capability
Date: Mon, 24 Feb 2025 22:18:45 +0530
Message-Id: <20250224164849.3746751-3-anshuman.gupta@intel.com>
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

Detect VRAM Self Refresh(vrsr) Capability.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_regs.h    |  3 +++
 drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
 drivers/gpu/drm/xe/xe_pm.c           | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_regs.h b/drivers/gpu/drm/xe/regs/xe_regs.h
index 6cf282618836..21563e9d958b 100644
--- a/drivers/gpu/drm/xe/regs/xe_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_regs.h
@@ -57,6 +57,9 @@
 #define MTL_MPE_FREQUENCY			XE_REG(0x13802c)
 #define   MTL_RPE_MASK				REG_GENMASK(8, 0)
 
+#define VRAM_CAPABILITY                         XE_REG(0x138144)
+#define   VRAM_SUPPORTED                        REG_BIT(0)
+
 #define VF_CAP_REG				XE_REG(0x1901f8, XE_REG_OPTION_VF)
 #define   VF_CAP				REG_BIT(0)
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 4656305dd45a..c2ab2c91c968 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -490,6 +490,9 @@ struct xe_device {
 		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
 		bool allowed;
 
+		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
+		bool vrsr_capable;
+
 		/**
 		 * @d3cold.vram_threshold:
 		 *
@@ -500,6 +503,7 @@ struct xe_device {
 		 * Default threshold value is 300mb.
 		 */
 		u32 vram_threshold;
+
 		/** @d3cold.lock: protect vram_threshold */
 		struct mutex lock;
 	} d3cold;
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 12200be7b43d..dead236355d8 100644
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
+	val = xe_mmio_read32(mmio, VRAM_CAPABILITY);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+
+	return val & VRAM_SUPPORTED;
+}
+
 static void xe_pm_runtime_init(struct xe_device *xe)
 {
 	struct device *dev = xe->drm.dev;
@@ -303,6 +328,8 @@ int xe_pm_init(struct xe_device *xe)
 		err = xe_pm_set_vram_threshold(xe, DEFAULT_VRAM_THRESHOLD);
 		if (err)
 			return err;
+
+		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
 	}
 
 	xe_pm_runtime_init(xe);
-- 
2.34.1


