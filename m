Return-Path: <linux-pci+bounces-7348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B28C232D
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8CD2833E5
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E4316F8FF;
	Fri, 10 May 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/ht/UIr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0616F27C
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340188; cv=none; b=eCYkTBUogLI0qyIAHvqi2bsNWOcio9GZqKL9WN+AzjxkNxVvKytAe0tUlGmwsL28gcDfaIVGMqTkZ/hwlAldocJyS9q4HlXfe0boV2fKUFYLP3pUZ2Cyb3PdWAkNgQ+uv1w5ixuzufH7KTqF85+hM85SvR1+BdG5O98Zawqf4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340188; c=relaxed/simple;
	bh=EmISR6cK/K/g8lUwbQi3gdogGyK78b/kkEnZ1pzAuY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyFrag0NkAN5MrltZeU3fz4BVGlA4GdYQ3YOYMtd3gfac00r7DgT4R1/vwTKETcVuWYzlNOn9ag35gkaxu/OejzW7/vN6/LYosP8fMazfnJaVivt8TQp6RGXUi5QEA9XnCQc8DdT76NkHrd8c70Hu1rt7knK64LUvz7Hb6OgtRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/ht/UIr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340169; x=1746876169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EmISR6cK/K/g8lUwbQi3gdogGyK78b/kkEnZ1pzAuY8=;
  b=M/ht/UIrm9dNyyOmn9rJlAjn9Kgia6iqRjSwAFm7Ly7pdL6Ft0Mtk7WA
   7sr1h2D4e565ye5Gz2+IKG0+BC/U+R/YdsboHzmC+H4/bmjKeX/8wPReK
   DFTVa5TfMPrqHpzVrwLyLv6TU6DdV2OCc3WCHtxiwdqun1Zfw9dfB0Py7
   7S+VjyzFcQIRDtX3TqvUn5+aG/dKGJHDBRMpSb7GEUtx65r7iQGXBcO9i
   kW8t+oIT4i1Vk/6QPx9X9gPpQN1A1ayNRkdVJJPDWTiyKLze2VWSzGf5n
   y8OZMe5V8mGVfwLytzG7cmazHcfHhKEq+aI9TGMsPhIMFQMc3oi48YSOx
   Q==;
X-CSE-ConnectionGUID: DuJrt3wnRHui1+wdGYukfw==
X-CSE-MsgGUID: YoVDaf9QRtOPQ8oG8I8DmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11442659"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11442659"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:48 -0700
X-CSE-ConnectionGUID: dOc+XxiBQu2ilvMy+psdGw==
X-CSE-MsgGUID: u4/KWnT2TJqxHiXE+AvaJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34234955"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:46 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/8] drm/i915/pciids: add INTEL_IVB_IDS()
Date: Fri, 10 May 2024 14:22:17 +0300
Message-Id: <ed89a25b2c6bce318fe59e883d18b62d9453196b.1715340032.git.jani.nikula@intel.com>
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

Add INTEL_IVB_IDS() to identify all IVBs except IVB Q transcode.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      | 3 +--
 drivers/gpu/drm/i915/display/intel_display_device.c | 3 +--
 include/drm/i915_pciids.h                           | 4 ++++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 23ded9260302..6549507003ec 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -535,8 +535,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_G45_IDS(&gen3_early_ops),
 	INTEL_ILK_IDS(&gen3_early_ops),
 	INTEL_SNB_IDS(&gen6_early_ops),
-	INTEL_IVB_M_IDS(&gen6_early_ops),
-	INTEL_IVB_D_IDS(&gen6_early_ops),
+	INTEL_IVB_IDS(&gen6_early_ops),
 	INTEL_HSW_IDS(&gen6_early_ops),
 	INTEL_BDW_IDS(&gen8_early_ops),
 	INTEL_CHV_IDS(&chv_early_ops),
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index c40d12ca386a..bb681c8ed8a0 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -819,8 +819,7 @@ static const struct {
 	INTEL_ILK_D_IDS(&ilk_d_display),
 	INTEL_ILK_M_IDS(&ilk_m_display),
 	INTEL_SNB_IDS(&snb_display),
-	INTEL_IVB_M_IDS(&ivb_display),
-	INTEL_IVB_D_IDS(&ivb_display),
+	INTEL_IVB_IDS(&ivb_display),
 	INTEL_HSW_IDS(&hsw_display),
 	INTEL_VLV_IDS(&vlv_display),
 	INTEL_BDW_IDS(&bdw_display),
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 0d48c493dcce..16778d92346b 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -177,6 +177,10 @@
 	INTEL_IVB_D_GT1_IDS(info), \
 	INTEL_IVB_D_GT2_IDS(info)
 
+#define INTEL_IVB_IDS(info) \
+	INTEL_IVB_M_IDS(info), \
+	INTEL_IVB_D_IDS(info)
+
 #define INTEL_IVB_Q_IDS(info) \
 	INTEL_QUANTA_VGA_DEVICE(info) /* Quanta transcode */
 
-- 
2.39.2


