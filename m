Return-Path: <linux-pci+bounces-38168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2105BDD49A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1594219BA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4112D29C4;
	Wed, 15 Oct 2025 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEzLJLZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E0292B4B;
	Wed, 15 Oct 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515366; cv=none; b=C49muN60ttUc2ndEm9D8BZ3ybHFmAYQpGlDDlxiq2VneAGnguPYUoxkSls/BKWS6XUMm9RQb08N+ku8o32PVgI2TxKF1GnZP+Q0KSsFXNDnqW6/t4FvDxyjTT/0gQEUe5E9vChQ5ijob4j7nz2kPLqr3syfpu4i0y0h7izB39Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515366; c=relaxed/simple;
	bh=N5E50uh/7oNDG522HV0F0MulqleJ2JKOoGZz7/4RaQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHzyGcd3s5QOpShxVE6oro+TJsp8isyIW+75DY2n+Sy/G1SrJSjv3imH7Jn5UB71bIozW07fUe1IauanGE80G+FTdE1mD9zsLkpqmsde/mT0bNL3Te0tpGm4cfA/JQDy5NlPwdyY4hapUXuaIPx/fD1v6tJFNWtX+n56jcBg39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEzLJLZZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515365; x=1792051365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N5E50uh/7oNDG522HV0F0MulqleJ2JKOoGZz7/4RaQE=;
  b=JEzLJLZZPhN/VyPjCZWex1L9ZyILdl7cBS3UYlcw/jqGUOiuy0ISpuOO
   R9NqTYH8hl3DpKzIsGprWSvLH9L9oZLjZmI8YNmTU7yEqvPRD+vbOpMwq
   n4xboLZG7NYy+JrptbY4YebMElrAgAXDOPRleVi2mddJt9OfZadOjvtAk
   J0kruroKT2abnhKVc+fh8YpiciXOY86lZrhinn8QapD/lpWKeQHpZbBsV
   /PzbHb3UlYgqx+6/EDTk4RhjaQab8jqTxZIreMsxXUGbIP8xRH2674QwQ
   Ii5BYrGHT9VrwECdXFEFlg4DI8BauWpqt2BZy9yu0o7jZToLy5zkW9pc+
   Q==;
X-CSE-ConnectionGUID: 7/eXLgO/Sd+X4kaBMZUx7Q==
X-CSE-MsgGUID: 9uioV/cdRyOT5kr0OGJ0aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891476"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891476"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:45 -0700
X-CSE-ConnectionGUID: XXGRnbI3QVS/v9/frGIlUQ==
X-CSE-MsgGUID: zG1V0c3HTyKS2vSEb5ou4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805401"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:41 -0700
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
	uma.shankar@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v5 05/12] drm/xe/vrsr: Detect VRSR Capability
Date: Wed, 15 Oct 2025 13:37:03 +0530
Message-Id: <20251015080710.1468409-6-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015080710.1468409-1-badal.nilawar@intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
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
index 1926b4044314..5fe114e6bd51 100644
--- a/drivers/gpu/drm/xe/regs/xe_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_regs.h
@@ -55,6 +55,9 @@
 #define MTL_MPE_FREQUENCY			XE_REG(0x13802c)
 #define   MTL_RPE_MASK				REG_GENMASK(8, 0)
 
+#define VRAM_SR_CAPABILITY                         XE_REG(0x138144)
+#define   VRAM_SR_SUPPORTED                        REG_BIT(0)
+
 #define VF_CAP_REG				XE_REG(0x1901f8, XE_REG_OPTION_VF)
 #define   VF_CAP				REG_BIT(0)
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 7fbdb5545946..d94fee10d041 100644
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
index 210298c4bcb1..b9cd48359e6f 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -13,15 +13,18 @@
 #include <drm/ttm/ttm_placement.h>
 
 #include "display/xe_display.h"
+#include "regs/xe_regs.h"
 #include "xe_bo.h"
 #include "xe_bo_evict.h"
 #include "xe_device.h"
+#include "xe_force_wake.h"
 #include "xe_ggtt.h"
 #include "xe_gt.h"
 #include "xe_gt_idle.h"
 #include "xe_i2c.h"
 #include "xe_irq.h"
 #include "xe_late_bind_fw.h"
+#include "xe_mmio.h"
 #include "xe_pcode.h"
 #include "xe_pxp.h"
 #include "xe_sriov_vf_ccs.h"
@@ -309,6 +312,28 @@ static bool xe_pm_pci_d3cold_capable(struct xe_device *xe)
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
@@ -453,6 +478,7 @@ int xe_pm_init(struct xe_device *xe)
 		err = xe_pm_set_vram_threshold(xe, vram_threshold);
 		if (err)
 			goto err_unregister;
+		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
 	}
 
 	xe_pm_runtime_init(xe);
-- 
2.34.1


