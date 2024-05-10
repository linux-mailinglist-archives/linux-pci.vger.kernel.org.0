Return-Path: <linux-pci+bounces-7347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0BE8C232C
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C5C1F2173B
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBE016F915;
	Fri, 10 May 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVbgKZRJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040316E894
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340180; cv=none; b=GEFZPjaSsXVQo5lQFq09546Jc95+8gWgTJYtCIIIWE75scGsUYy18yCFoV+AV1CgPrINZDJ5MKicvgDXm2ySkXf3bAdERU0bWxjI+fmN2Th7RE8Kpw8cgJUfx4YBsjOHkt8TBg6cuzi8x17CA1rOJwn0+hf2CvCdMo56BjQ4hh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340180; c=relaxed/simple;
	bh=oUD93JunRNJc19R+4rzQi/1dK3sVLJyG7ebgDtDSGSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EbLE0HSR+ZjXzro1uHrZ1wT416iN3MJav1b57OYdV1D9795PKqnIryc1QdjQvwe3Oqzpr2HktSZvd/J2U/CkNDXr3g5sUTLW+/n/4STFehIAUqU5DF0GrEtQoEKrxLeW/C5pXeQoooECclRw17nF+eDtinEd/2hz5zd6besykkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVbgKZRJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340165; x=1746876165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUD93JunRNJc19R+4rzQi/1dK3sVLJyG7ebgDtDSGSs=;
  b=XVbgKZRJrvSLPaoEwPQ0bkAnslTNLfxwZs2DAPxUyL+w8ALVx80Bpsny
   P2bzXVDkUC5/i9O0iMjYUUTgEr7k3hDvlQUCGtUz0z0XgkSosHT383CiS
   3aAxXtvOqx30EC9cn6dhdI8UVgZyuRSiZ3CEO2AeHLkBid2LqZN807alf
   veUUT+nGMWFou5US75KjcNYK4WHCVBZTI3A3affRp+Gg4NaVkRA0rgZmm
   XBs+meJeVRcYM7bZbKR4++lHq+Az2CGPAnW0YFEzkB8xR7swYfhhlICYz
   +yX6XNikTnBENTXX5c1IhaDjWRLMZRbH/uHw6U7/IZBKAt4Lij39KFBqn
   A==;
X-CSE-ConnectionGUID: 7Nttubn1R1qdDtEsFDVKrw==
X-CSE-MsgGUID: HINIYB9zRAK1G4mZl1MW+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11442648"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11442648"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:44 -0700
X-CSE-ConnectionGUID: v9Lb1iqLT7SagVf1eXH/7g==
X-CSE-MsgGUID: hA+sWgX4Qp6zS0LIJy0USg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34234923"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:41 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/8] drm/i915/pciids: add INTEL_SNB_IDS()
Date: Fri, 10 May 2024 14:22:16 +0300
Message-Id: <ffcb2d954ad9bca78ccd39836dc0a3dc7c6c0253.1715340032.git.jani.nikula@intel.com>
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

Add INTEL_SNB_IDS() to identify all SNBs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      | 3 +--
 drivers/gpu/drm/i915/display/intel_display_device.c | 3 +--
 include/drm/i915_pciids.h                           | 4 ++++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index d8419d310091..23ded9260302 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -534,8 +534,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_GM45_IDS(&gen3_early_ops),
 	INTEL_G45_IDS(&gen3_early_ops),
 	INTEL_ILK_IDS(&gen3_early_ops),
-	INTEL_SNB_D_IDS(&gen6_early_ops),
-	INTEL_SNB_M_IDS(&gen6_early_ops),
+	INTEL_SNB_IDS(&gen6_early_ops),
 	INTEL_IVB_M_IDS(&gen6_early_ops),
 	INTEL_IVB_D_IDS(&gen6_early_ops),
 	INTEL_HSW_IDS(&gen6_early_ops),
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 052fd1c290c3..c40d12ca386a 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -818,8 +818,7 @@ static const struct {
 	INTEL_PNV_IDS(&pnv_display),
 	INTEL_ILK_D_IDS(&ilk_d_display),
 	INTEL_ILK_M_IDS(&ilk_m_display),
-	INTEL_SNB_D_IDS(&snb_display),
-	INTEL_SNB_M_IDS(&snb_display),
+	INTEL_SNB_IDS(&snb_display),
 	INTEL_IVB_M_IDS(&ivb_display),
 	INTEL_IVB_D_IDS(&ivb_display),
 	INTEL_HSW_IDS(&hsw_display),
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 05f466ca8ce2..0d48c493dcce 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -151,6 +151,10 @@
 	INTEL_SNB_M_GT1_IDS(info), \
 	INTEL_SNB_M_GT2_IDS(info)
 
+#define INTEL_SNB_IDS(info) \
+	INTEL_SNB_D_IDS(info), \
+	INTEL_SNB_M_IDS(info)
+
 #define INTEL_IVB_M_GT1_IDS(info) \
 	INTEL_VGA_DEVICE(0x0156, info) /* GT1 mobile */
 
-- 
2.39.2


