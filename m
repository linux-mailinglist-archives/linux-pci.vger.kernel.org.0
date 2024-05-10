Return-Path: <linux-pci+bounces-7346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B58C2328
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C1F283025
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C5416F0CF;
	Fri, 10 May 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhFYWZ5L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08C16EC1E
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340172; cv=none; b=Xw5Ue4RNYZ80qHktQNJzacZwVr5lNWIEKVNr+vAbR60uHzt+fMhiVpQYKkt/QCjE6PQHwpglyM9Ou6Sdiz3ni/zQHOAn3zeDNA36UgTOGpN2tC3cPcsT2Kgv7BEu1KG2qQX7+VLIAHJyXwTfj1syOwizuy2Mge++CFrqFDuppAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340172; c=relaxed/simple;
	bh=8CYrtseSXDwGPEvOM19TLzH04Vyyl9/8hqNONUh6OaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+4W31UBax9gAQEqZV1yWiJrLr7++wnJdwKbXHE/zz69lRdMaxWRxWtLAUTb/Cl0lb0Eo3g66rdrLwYDPCTokiMEHH22pN430pBbTIN3MsROm9b+xg2UDNbSooniZxSfclmwXDRHpNREdjlTK9GyMx7GxxzqFe6A23w55QoYbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhFYWZ5L; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340158; x=1746876158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8CYrtseSXDwGPEvOM19TLzH04Vyyl9/8hqNONUh6OaA=;
  b=OhFYWZ5LG7MjDtTVHCQu4a5GYhtHxSQD6vYeYBDRdKVK/hyxK6fP1Dy5
   lOHJcSFxegHGbbBHXGVEKxne1xFxZDbCVbXupFkhIl+Z0qYmKJniSM/11
   uW1kQKUL4r35m/jo9Dp+VEBL0yInwL6zJgbAbW7vvzJ/UNeLxw7a8F8KD
   vjtVBfKxg/w3Vf8JC8h5HZyXdKNgBUru42RElLwrFs/tHs2jfUvUPkooV
   8fRdIhESO9NMu/O7hx4xlvyiFrv0g2/TOiHHHJ5mjxLp7H49cfEZ9uGwq
   ztktB2UXUVOaFIc0yB/2cs3+EPVf5ELH+cWecdW7SDebNf1BZ52M4OIxw
   Q==;
X-CSE-ConnectionGUID: w0SOdSYfQqi+m9G6S/pSHg==
X-CSE-MsgGUID: sIa0SQCCR3Wjre9UbppbOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21987660"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21987660"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:37 -0700
X-CSE-ConnectionGUID: QfWXW0JGTjG2cFM3gXW6Hw==
X-CSE-MsgGUID: 48ZWhdQ0TMWDmi86C+mA3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29590343"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:36 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/8] drm/i915/pciids: add INTEL_ILK_IDS(), use acronym
Date: Fri, 10 May 2024 14:22:15 +0300
Message-Id: <27ada56363cfa6a5b093cb31908a4b89aa912621.1715340032.git.jani.nikula@intel.com>
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

Most other PCI ID macros use platform acronyms. Follow suit for ILK. Add
INTEL_ILK_IDS() to identify all ILKs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      | 3 +--
 drivers/gpu/drm/i915/display/intel_display_device.c | 4 ++--
 drivers/gpu/drm/i915/i915_pci.c                     | 4 ++--
 include/drm/i915_pciids.h                           | 8 ++++++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index f50394a00fca..d8419d310091 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -533,8 +533,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_I965GM_IDS(&gen3_early_ops),
 	INTEL_GM45_IDS(&gen3_early_ops),
 	INTEL_G45_IDS(&gen3_early_ops),
-	INTEL_IRONLAKE_D_IDS(&gen3_early_ops),
-	INTEL_IRONLAKE_M_IDS(&gen3_early_ops),
+	INTEL_ILK_IDS(&gen3_early_ops),
 	INTEL_SNB_D_IDS(&gen6_early_ops),
 	INTEL_SNB_M_IDS(&gen6_early_ops),
 	INTEL_IVB_M_IDS(&gen6_early_ops),
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 0e0f5a36507d..052fd1c290c3 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -816,8 +816,8 @@ static const struct {
 	INTEL_GM45_IDS(&gm45_display),
 	INTEL_G45_IDS(&g45_display),
 	INTEL_PNV_IDS(&pnv_display),
-	INTEL_IRONLAKE_D_IDS(&ilk_d_display),
-	INTEL_IRONLAKE_M_IDS(&ilk_m_display),
+	INTEL_ILK_D_IDS(&ilk_d_display),
+	INTEL_ILK_M_IDS(&ilk_m_display),
 	INTEL_SNB_D_IDS(&snb_display),
 	INTEL_SNB_M_IDS(&snb_display),
 	INTEL_IVB_M_IDS(&ivb_display),
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index aa8593d73198..d85f023afebe 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -812,8 +812,8 @@ static const struct pci_device_id pciidlist[] = {
 	INTEL_G45_IDS(&g45_info),
 	INTEL_PNV_G_IDS(&pnv_g_info),
 	INTEL_PNV_M_IDS(&pnv_m_info),
-	INTEL_IRONLAKE_D_IDS(&ilk_d_info),
-	INTEL_IRONLAKE_M_IDS(&ilk_m_info),
+	INTEL_ILK_D_IDS(&ilk_d_info),
+	INTEL_ILK_M_IDS(&ilk_m_info),
 	INTEL_SNB_D_GT1_IDS(&snb_d_gt1_info),
 	INTEL_SNB_D_GT2_IDS(&snb_d_gt2_info),
 	INTEL_SNB_M_GT1_IDS(&snb_m_gt1_info),
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 21942a3c823b..05f466ca8ce2 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -118,12 +118,16 @@
 	INTEL_PNV_G_IDS(info), \
 	INTEL_PNV_M_IDS(info)
 
-#define INTEL_IRONLAKE_D_IDS(info) \
+#define INTEL_ILK_D_IDS(info) \
 	INTEL_VGA_DEVICE(0x0042, info)
 
-#define INTEL_IRONLAKE_M_IDS(info) \
+#define INTEL_ILK_M_IDS(info) \
 	INTEL_VGA_DEVICE(0x0046, info)
 
+#define INTEL_ILK_IDS(info) \
+	INTEL_ILK_D_IDS(info), \
+	INTEL_ILK_M_IDS(info)
+
 #define INTEL_SNB_D_GT1_IDS(info) \
 	INTEL_VGA_DEVICE(0x0102, info), \
 	INTEL_VGA_DEVICE(0x010A, info)
-- 
2.39.2


