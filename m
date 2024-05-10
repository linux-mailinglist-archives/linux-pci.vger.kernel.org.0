Return-Path: <linux-pci+bounces-7349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 517018C232F
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A2CB20DCA
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90AC16F0D6;
	Fri, 10 May 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+5Qz9A1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB616F823
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340189; cv=none; b=n9KVFmCGYTPi+3TqF40BM+vL3NvuNqTmYRa9FWFG43fQ7tsCp+2+QbkPQVAU5K8wuiJL1clzixXRVt7cj1o/KFaLVDVAGrVLnFVTViiMDPSiIsEK3J9EJBZeTFAzcBAY4ywpHBZfPtCY2BlEhBbJSDcWAQu41xcBO2ZHq+d5UnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340189; c=relaxed/simple;
	bh=gNthO8hrks93STnqKNOoHkVO7y8f0oXX7ICJ5gA5IVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruM/TR0hQKsOaIT+Jp1hypJsn7yc2+zLl9lzOzsQZ82zHFeuW3Gt9jViMUU8SekLgsCA/N8lzuQakJQKtQadFf6nvrPx1lJ0ng79ip/mFGXV3QZVggpr3e1j8330uhPaZVNocRE4em6Tnvf+va85U99wodXGtpiaifQK8/EeKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+5Qz9A1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340174; x=1746876174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gNthO8hrks93STnqKNOoHkVO7y8f0oXX7ICJ5gA5IVg=;
  b=l+5Qz9A1B5AfZF134Ug7ZjCIqbJMyEkT8Q9X/Jy35s0Tk3U4LKZo5xw+
   Snxib+ELS9pK8ku60t2nttUNWzsoh5DaqO5LWo7J45pLI8qJEEHKdnE7c
   mpVK6NDqF0tqvzLIMEmaRFOYlgPb++0QHsBKea94PQIsf2r3UjnnA3uWb
   BVJqbkvf6XZoNKSNHNg+mEtsaB7RaCEcQrQ2ipfygzpIxevM1860fKgZz
   SO/TYPLgXOE661oJpU6v2kvS4+jZNllFrfBxx81jGlfufrbghrQsS/CjH
   yp16potdI4+l6ozJGjuEo3GyDs02OFD+TAxFGyddMBbosKwejpcp0k35/
   A==;
X-CSE-ConnectionGUID: rDOMpiGHTQmLvsBH/eLRcg==
X-CSE-MsgGUID: uZ4v14F+SiWZ0k4kI+RBLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11442670"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11442670"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:54 -0700
X-CSE-ConnectionGUID: FO8a4JwzQnmTfMFiuB64iw==
X-CSE-MsgGUID: aE5Dcm/wSQ6VQaNZ+niy6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34234985"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:52 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 5/8] drm/i915/pciids: don't include WHL/CML PCI IDs in CFL
Date: Fri, 10 May 2024 14:22:18 +0300
Message-Id: <7cca91dc78ed2b5982f14e400f03a1704645e475.1715340032.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1715340032.git.jani.nikula@intel.com>
References: <cover.1715340032.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

It's confusing for INTEL_CFL_IDS() to include all WHL and CML PCI
IDs. Even if we treat them the same in a lot of places, CML is a
platform of its own, and the lists of PCI IDs should not conflate them.

Largely go by the idea that if a platform has a name, group its PCI IDs
together.

That said, AML is special, having both KBL and CFL variants. Leave that
alone.

v2: Also split out WHL not just CML (Rodrigo)

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                |  2 ++
 .../drm/i915/display/intel_display_device.c   |  2 ++
 include/drm/i915_pciids.h                     | 30 +++++++++++--------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 6549507003ec..2b698a3f56ef 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -543,6 +543,8 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_BXT_IDS(&gen9_early_ops),
 	INTEL_KBL_IDS(&gen9_early_ops),
 	INTEL_CFL_IDS(&gen9_early_ops),
+	INTEL_WHL_IDS(&gen9_early_ops),
+	INTEL_CML_IDS(&gen9_early_ops),
 	INTEL_GLK_IDS(&gen9_early_ops),
 	INTEL_CNL_IDS(&gen9_early_ops),
 	INTEL_ICL_11_IDS(&gen11_early_ops),
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index bb681c8ed8a0..23909a8e2dc8 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -829,6 +829,8 @@ static const struct {
 	INTEL_GLK_IDS(&glk_display),
 	INTEL_KBL_IDS(&skl_display),
 	INTEL_CFL_IDS(&skl_display),
+	INTEL_WHL_IDS(&skl_display),
+	INTEL_CML_IDS(&skl_display),
 	INTEL_ICL_11_IDS(&icl_display),
 	INTEL_EHL_IDS(&jsl_ehl_display),
 	INTEL_JSL_IDS(&jsl_ehl_display),
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 16778d92346b..0c5a20d59801 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -488,6 +488,12 @@
 	INTEL_VGA_DEVICE(0x9BCA, info), \
 	INTEL_VGA_DEVICE(0x9BCC, info)
 
+#define INTEL_CML_IDS(info) \
+	INTEL_CML_GT1_IDS(info), \
+	INTEL_CML_GT2_IDS(info), \
+	INTEL_CML_U_GT1_IDS(info), \
+	INTEL_CML_U_GT2_IDS(info)
+
 #define INTEL_KBL_IDS(info) \
 	INTEL_KBL_GT1_IDS(info), \
 	INTEL_KBL_GT2_IDS(info), \
@@ -527,6 +533,15 @@
 	INTEL_VGA_DEVICE(0x3EA7, info), /* ULT GT3 */ \
 	INTEL_VGA_DEVICE(0x3EA8, info)  /* ULT GT3 */
 
+#define INTEL_CFL_IDS(info)	   \
+	INTEL_CFL_S_GT1_IDS(info), \
+	INTEL_CFL_S_GT2_IDS(info), \
+	INTEL_CFL_H_GT1_IDS(info), \
+	INTEL_CFL_H_GT2_IDS(info), \
+	INTEL_CFL_U_GT2_IDS(info), \
+	INTEL_CFL_U_GT3_IDS(info), \
+	INTEL_AML_CFL_GT2_IDS(info)
+
 /* WHL/CFL U GT1 */
 #define INTEL_WHL_U_GT1_IDS(info) \
 	INTEL_VGA_DEVICE(0x3EA1, info), \
@@ -541,21 +556,10 @@
 #define INTEL_WHL_U_GT3_IDS(info) \
 	INTEL_VGA_DEVICE(0x3EA2, info)
 
-#define INTEL_CFL_IDS(info)	   \
-	INTEL_CFL_S_GT1_IDS(info), \
-	INTEL_CFL_S_GT2_IDS(info), \
-	INTEL_CFL_H_GT1_IDS(info), \
-	INTEL_CFL_H_GT2_IDS(info), \
-	INTEL_CFL_U_GT2_IDS(info), \
-	INTEL_CFL_U_GT3_IDS(info), \
+#define INTEL_WHL_IDS(info) \
 	INTEL_WHL_U_GT1_IDS(info), \
 	INTEL_WHL_U_GT2_IDS(info), \
-	INTEL_WHL_U_GT3_IDS(info), \
-	INTEL_AML_CFL_GT2_IDS(info), \
-	INTEL_CML_GT1_IDS(info), \
-	INTEL_CML_GT2_IDS(info), \
-	INTEL_CML_U_GT1_IDS(info), \
-	INTEL_CML_U_GT2_IDS(info)
+	INTEL_WHL_U_GT3_IDS(info)
 
 /* CNL */
 #define INTEL_CNL_PORT_F_IDS(info) \
-- 
2.39.2


