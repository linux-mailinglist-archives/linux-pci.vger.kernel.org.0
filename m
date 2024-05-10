Return-Path: <linux-pci+bounces-7345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F3B8C2321
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B671C20D53
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F417084A;
	Fri, 10 May 2024 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcilxjYb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02F54662
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340167; cv=none; b=HEW0sGhfVpFpU80lEQwOQ7P6KjnKgW01p/urnsmomHyHGHHGE9A9nMSwA4r/CCstCJmX7j0wElHuRNnd0KBEDxf/Y1wyweRnTIBj7UB4bUFGXshS2YieCizW8duysOeFYS/I+khy0eoDBJUYmXAK9fpHNbMfSFbImbr/UA4nDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340167; c=relaxed/simple;
	bh=M0RJBU0+0YZopGgGuNZdMGbRGUnkUED7RdfCztZDzP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFdWIsFkLIkq5updhmigcKyhtho40gNYtiO0EQM4JR/GRfXhhalBE3OtYVBwDSHuZwrVZ6v1rqQpHdsaw7uia43EULJiLy0W1PbsP3l9I7sCzaYPq2cnagy4ivlg2EEJnHs7ceWZNrNcmJjPSeT3ipFNVQplFlOCail1QiTW7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcilxjYb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340153; x=1746876153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0RJBU0+0YZopGgGuNZdMGbRGUnkUED7RdfCztZDzP4=;
  b=lcilxjYbof6rgt46P/0ozfxwaEXJQYWofVVp74S3WDIQO1j2j3ekDmCj
   J07cqcXtDVOWlKbsoYm3Vj52Zen09apbTf4Zg8U2aHd2E3lZ6yQazGRDT
   KM+ZMXzpQ/Z7MvThQAdFIvY/lun9Z9jn9Px00vfETEFTOhZZ+XcTXFPGk
   VDZUDxIugFLyhL03QEjsh1wKJQb0bqupNGXK8e9KaWRhN+k++Uy+CtsTx
   8pfTKg7p36DaJmwFEiGZx1GOy5GptVbOxUqcQ5/gTq949olNTucX7/hak
   +zMhaHv1LczXMMZOn5e+WGp8Yf7DmOc66qjzNN0Ce8tqECBoIqH88p/a3
   g==;
X-CSE-ConnectionGUID: sTiFcZI7QVuIE7CCGhllCQ==
X-CSE-MsgGUID: I8yZHiJgQHumdCovwUCJaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21987638"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21987638"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:32 -0700
X-CSE-ConnectionGUID: Rns2IjHCRAymf2lXeyGNUQ==
X-CSE-MsgGUID: k4Bc7bftStC0sYqb0Yi9WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29590329"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:31 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/8] drm/i915/pciids: add INTEL_PNV_IDS(), use acronym
Date: Fri, 10 May 2024 14:22:14 +0300
Message-Id: <5f9b34a2cd388244be03263a5147776bfe64d5ac.1715340032.git.jani.nikula@intel.com>
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

Most other PCI ID macros use platform acronyms. Follow suit for PNV. Add
INTEL_PNV_IDS() to identify all PNVs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      | 3 +--
 drivers/gpu/drm/i915/display/intel_display_device.c | 3 +--
 drivers/gpu/drm/i915/i915_pci.c                     | 4 ++--
 include/drm/i915_pciids.h                           | 8 ++++++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 59f4aefc6bc1..f50394a00fca 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -527,8 +527,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_I945G_IDS(&gen3_early_ops),
 	INTEL_I945GM_IDS(&gen3_early_ops),
 	INTEL_VLV_IDS(&gen6_early_ops),
-	INTEL_PINEVIEW_G_IDS(&gen3_early_ops),
-	INTEL_PINEVIEW_M_IDS(&gen3_early_ops),
+	INTEL_PNV_IDS(&gen3_early_ops),
 	INTEL_I965G_IDS(&gen3_early_ops),
 	INTEL_G33_IDS(&gen3_early_ops),
 	INTEL_I965GM_IDS(&gen3_early_ops),
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 56a2e17d7d9e..0e0f5a36507d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -815,8 +815,7 @@ static const struct {
 	INTEL_I965GM_IDS(&i965gm_display),
 	INTEL_GM45_IDS(&gm45_display),
 	INTEL_G45_IDS(&g45_display),
-	INTEL_PINEVIEW_G_IDS(&pnv_display),
-	INTEL_PINEVIEW_M_IDS(&pnv_display),
+	INTEL_PNV_IDS(&pnv_display),
 	INTEL_IRONLAKE_D_IDS(&ilk_d_display),
 	INTEL_IRONLAKE_M_IDS(&ilk_m_display),
 	INTEL_SNB_D_IDS(&snb_display),
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index b5a056c9cb79..aa8593d73198 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -810,8 +810,8 @@ static const struct pci_device_id pciidlist[] = {
 	INTEL_I965GM_IDS(&i965gm_info),
 	INTEL_GM45_IDS(&gm45_info),
 	INTEL_G45_IDS(&g45_info),
-	INTEL_PINEVIEW_G_IDS(&pnv_g_info),
-	INTEL_PINEVIEW_M_IDS(&pnv_m_info),
+	INTEL_PNV_G_IDS(&pnv_g_info),
+	INTEL_PNV_M_IDS(&pnv_m_info),
 	INTEL_IRONLAKE_D_IDS(&ilk_d_info),
 	INTEL_IRONLAKE_M_IDS(&ilk_m_info),
 	INTEL_SNB_D_GT1_IDS(&snb_d_gt1_info),
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 85ce33ad6e26..21942a3c823b 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -108,12 +108,16 @@
 	INTEL_VGA_DEVICE(0x2e42, info), /* B43_G */ \
 	INTEL_VGA_DEVICE(0x2e92, info)	/* B43_G.1 */
 
-#define INTEL_PINEVIEW_G_IDS(info) \
+#define INTEL_PNV_G_IDS(info) \
 	INTEL_VGA_DEVICE(0xa001, info)
 
-#define INTEL_PINEVIEW_M_IDS(info) \
+#define INTEL_PNV_M_IDS(info) \
 	INTEL_VGA_DEVICE(0xa011, info)
 
+#define INTEL_PNV_IDS(info) \
+	INTEL_PNV_G_IDS(info), \
+	INTEL_PNV_M_IDS(info)
+
 #define INTEL_IRONLAKE_D_IDS(info) \
 	INTEL_VGA_DEVICE(0x0042, info)
 
-- 
2.39.2


