Return-Path: <linux-pci+bounces-7164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9A8BE2BA
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784871F2200F
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D4715CD55;
	Tue,  7 May 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hseEWMT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F215B995
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086626; cv=none; b=qXBfGLIFkdTyJaYZNZ2wBkthLIKC/ZG7Xegf6XskKzbwAGWPn5BVuZk4EV4WU3TQJxgfOP+acbv6oz0aH2TBtIN/XVAMZ5551QQzEv9I84XNsVqZsFqmKd3l/EJ7FZNH2AEecccYBmYY7MVoiY84InSKjV6aqprG34CkqRwK3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086626; c=relaxed/simple;
	bh=5BlVl6oNwrTI4Klf6jl3jFAqaIz2l9bqvOgykOiukqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d05qQvVd6tJXYQiEjMIUjzWlr90FuPoFnMJOf4xMv5ASLOAWoqFeSWs69Quljdi+hgfjMGwbj1Rqf5duK+/W/ZFvgTZ4p6HqY0CDM7yOoZg91KDJ7j5hw1MNlFKn3eSgP4xlkXbCrTtmNoB6UhWKzzbSNLPHD2k7mhCxErPE8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hseEWMT8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715086625; x=1746622625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5BlVl6oNwrTI4Klf6jl3jFAqaIz2l9bqvOgykOiukqw=;
  b=hseEWMT8OYdF31Of6cCehYHRsGkugcuPxBapf7eaVhGbXOR83ZiHIj56
   bCMzEy36Uodah2hwhSe6e8piDA2wuWqaHyTq6t0vuCvjYvKUpV8X/tmY7
   Lmvs8CDSGS32Qyjv8cAfOBBycSx9hTaC3Wf3VFYTDEDvKlxbN4oaN4ZON
   gPqJc2MMrbyAs/dk9mmFsF75gO8Bc6G1fWR0IHsGauJVjfRHK8wdOmZcm
   Rw0/XvccnbjBy5FGYxMW6ZLS/vt71Pm0idSDqYfX8bwYPQ1gBV6rvkcWI
   Qn6hESJu2fsOJ+WWTj6ZfmMYYoSbodYK+mbBkz4MkNGYNadVTdJ4GPMFE
   A==;
X-CSE-ConnectionGUID: InlAaOFtS7qN2wTQ4UXYLg==
X-CSE-MsgGUID: t5qkxmj5T4K0zuuFMCJfLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11035187"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="11035187"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:57:04 -0700
X-CSE-ConnectionGUID: 6TUsrUqsRxSlq2okIBAsUg==
X-CSE-MsgGUID: NaZkjtGPSZSi09zdWs8q8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="29038149"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.16])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:57:02 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
Date: Tue,  7 May 2024 15:56:48 +0300
Message-Id: <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1715086509.git.jani.nikula@intel.com>
References: <cover.1715086509.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

It's confusing for INTEL_CFL_IDS() to include all CML PCI IDs. Even if
we treat them the same in a lot of places, CML is a platform of its own,
and the lists of PCI IDs should not conflate them.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      |  1 +
 drivers/gpu/drm/i915/display/intel_display_device.c |  1 +
 include/drm/i915_pciids.h                           | 12 +++++++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 59f4aefc6bc1..2e2d15be4025 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -547,6 +547,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_BXT_IDS(&gen9_early_ops),
 	INTEL_KBL_IDS(&gen9_early_ops),
 	INTEL_CFL_IDS(&gen9_early_ops),
+	INTEL_CML_IDS(&gen9_early_ops),
 	INTEL_GLK_IDS(&gen9_early_ops),
 	INTEL_CNL_IDS(&gen9_early_ops),
 	INTEL_ICL_11_IDS(&gen11_early_ops),
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 56a2e17d7d9e..3aa7d1cdd228 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -832,6 +832,7 @@ static const struct {
 	INTEL_GLK_IDS(&glk_display),
 	INTEL_KBL_IDS(&skl_display),
 	INTEL_CFL_IDS(&skl_display),
+	INTEL_CML_IDS(&skl_display),
 	INTEL_ICL_11_IDS(&icl_display),
 	INTEL_EHL_IDS(&jsl_ehl_display),
 	INTEL_JSL_IDS(&jsl_ehl_display),
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 85ce33ad6e26..5f52c504ffde 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -472,6 +472,12 @@
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
@@ -535,11 +541,7 @@
 	INTEL_WHL_U_GT1_IDS(info), \
 	INTEL_WHL_U_GT2_IDS(info), \
 	INTEL_WHL_U_GT3_IDS(info), \
-	INTEL_AML_CFL_GT2_IDS(info), \
-	INTEL_CML_GT1_IDS(info), \
-	INTEL_CML_GT2_IDS(info), \
-	INTEL_CML_U_GT1_IDS(info), \
-	INTEL_CML_U_GT2_IDS(info)
+	INTEL_AML_CFL_GT2_IDS(info)
 
 /* CNL */
 #define INTEL_CNL_PORT_F_IDS(info) \
-- 
2.39.2


