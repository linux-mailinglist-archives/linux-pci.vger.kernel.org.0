Return-Path: <linux-pci+bounces-7350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26448C232E
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424911F216C3
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164B16132E;
	Fri, 10 May 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzxbS+P6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9725816DEDE
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340196; cv=none; b=c3zvpc+djrlNTe6hUFhlK0ccjUaeCifySgSclE0OpgM4HT+CzdUTbuv4G+MgneWsPhZH23bOa7OmJJypwHzcJnuPDQQy+lY7iPok9TRY9koadRHSbOrh8RbhjsvsU6UeoZC3CjtH1EiQH5WvRYlHu85TwHMAL/mo1IUKpe5XKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340196; c=relaxed/simple;
	bh=jloYEZB3w48aU492x/i7skY4g6XBc5NY5NTAMLjD2ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taOQWjeU67lFbb/0RghPfdhE7PmC9xuo0ETZsNI3Y9YJAshWk/2fRsrsDhki2HikCuHbyP9c9D6LoyTAyNT6cFuc/uftJ8pDkyI9yIFFahH8iDmE/hv3eiNuaklv5u+o/hXhvoy7T6NGytuFcyNgbsrdr2Am7MKjagsv1qsjm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzxbS+P6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340189; x=1746876189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jloYEZB3w48aU492x/i7skY4g6XBc5NY5NTAMLjD2ds=;
  b=UzxbS+P6ky+eysn07eRf7kWK5BjtGxtTUl9qnFGMAvb4+xRLloy8wUTs
   yzTvNprxwB7ISx1ESQz/q3NZ8dRdSJ/X655T5D96l95aCQWKx6FulhF3T
   Rmx14j4jXa2P4if4Zta6QD4uRoKOkqqEyuZbB1bilSSxy7JuQY7TW8hAe
   xh5AIlrDiU7jB5lBbX1VM6ZKk9VSbhToOrxmLtvwTewEd2kFFxpVLsMJG
   P8RcvcxdVhUzzAR8hp4KaPLsfG3d2Yp2nogUMnE/KxZT0QTWI9fJnfUE1
   BBo86fsLhot1gLAYStGYYMhPWON6qXDW+Hj95hotlYE4LA1gGgJA8oKcB
   g==;
X-CSE-ConnectionGUID: EpI/iFqySvOKTIcyTClRVA==
X-CSE-MsgGUID: M7Wdwa0fTnqdjp4J90qIiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11442691"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11442691"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:23:04 -0700
X-CSE-ConnectionGUID: mmiiR93jQzyt0i/jhYrw6Q==
X-CSE-MsgGUID: GldeMH7lTSSeALakbNvd6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34235062"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:23:03 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 7/8] drm/i915/pciids: remove 12 from INTEL_TGL_IDS()
Date: Fri, 10 May 2024 14:22:20 +0300
Message-Id: <044a5c553dc4564431bbef197d5e2dd085624fc2.1715340032.git.jani.nikula@intel.com>
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

Most other PCI ID macros do not encode the gen in the name. Follow suit
for TGL.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      |  2 +-
 drivers/gpu/drm/i915/display/intel_display_device.c |  2 +-
 drivers/gpu/drm/i915/i915_pci.c                     |  2 +-
 drivers/gpu/drm/i915/intel_device_info.c            |  2 +-
 include/drm/i915_pciids.h                           | 10 +++++-----
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index c150bb6f1a39..b2b9cc3b9545 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -550,7 +550,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_ICL_IDS(&gen11_early_ops),
 	INTEL_EHL_IDS(&gen11_early_ops),
 	INTEL_JSL_IDS(&gen11_early_ops),
-	INTEL_TGL_12_IDS(&gen11_early_ops),
+	INTEL_TGL_IDS(&gen11_early_ops),
 	INTEL_RKL_IDS(&gen11_early_ops),
 	INTEL_ADLS_IDS(&gen11_early_ops),
 	INTEL_ADLP_IDS(&gen11_early_ops),
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index e47896002c13..fb4c4054207e 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -834,7 +834,7 @@ static const struct {
 	INTEL_ICL_IDS(&icl_display),
 	INTEL_EHL_IDS(&jsl_ehl_display),
 	INTEL_JSL_IDS(&jsl_ehl_display),
-	INTEL_TGL_12_IDS(&tgl_display),
+	INTEL_TGL_IDS(&tgl_display),
 	INTEL_DG1_IDS(&dg1_display),
 	INTEL_RKL_IDS(&rkl_display),
 	INTEL_ADLS_IDS(&adl_s_display),
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 06b1d50ae47c..fa56113ed1ce 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -860,7 +860,7 @@ static const struct pci_device_id pciidlist[] = {
 	INTEL_ICL_IDS(&icl_info),
 	INTEL_EHL_IDS(&ehl_info),
 	INTEL_JSL_IDS(&jsl_info),
-	INTEL_TGL_12_IDS(&tgl_info),
+	INTEL_TGL_IDS(&tgl_info),
 	INTEL_RKL_IDS(&rkl_info),
 	INTEL_ADLS_IDS(&adl_s_info),
 	INTEL_ADLP_IDS(&adl_p_info),
diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index a0a43ea07f11..64651a54a245 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -173,7 +173,7 @@ static const u16 subplatform_portf_ids[] = {
 };
 
 static const u16 subplatform_uy_ids[] = {
-	INTEL_TGL_12_GT2_IDS(0),
+	INTEL_TGL_GT2_IDS(0),
 };
 
 static const u16 subplatform_n_ids[] = {
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index ecfd7f71e2e7..42913d2eb655 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -620,12 +620,12 @@
 	INTEL_VGA_DEVICE(0x4E71, info)
 
 /* TGL */
-#define INTEL_TGL_12_GT1_IDS(info) \
+#define INTEL_TGL_GT1_IDS(info) \
 	INTEL_VGA_DEVICE(0x9A60, info), \
 	INTEL_VGA_DEVICE(0x9A68, info), \
 	INTEL_VGA_DEVICE(0x9A70, info)
 
-#define INTEL_TGL_12_GT2_IDS(info) \
+#define INTEL_TGL_GT2_IDS(info) \
 	INTEL_VGA_DEVICE(0x9A40, info), \
 	INTEL_VGA_DEVICE(0x9A49, info), \
 	INTEL_VGA_DEVICE(0x9A59, info), \
@@ -635,9 +635,9 @@
 	INTEL_VGA_DEVICE(0x9AD9, info), \
 	INTEL_VGA_DEVICE(0x9AF8, info)
 
-#define INTEL_TGL_12_IDS(info) \
-	INTEL_TGL_12_GT1_IDS(info), \
-	INTEL_TGL_12_GT2_IDS(info)
+#define INTEL_TGL_IDS(info) \
+	INTEL_TGL_GT1_IDS(info), \
+	INTEL_TGL_GT2_IDS(info)
 
 /* RKL */
 #define INTEL_RKL_IDS(info) \
-- 
2.39.2


