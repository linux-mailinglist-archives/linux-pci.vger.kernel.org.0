Return-Path: <linux-pci+bounces-7351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505C8C2330
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E438A281130
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59715161B6A;
	Fri, 10 May 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjzufBYt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C216F84A
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340197; cv=none; b=BHnjkUXsoSUsMzJIZM+MaccWWeNgi0ifZw5sMBrAQ0WQf+EsLowZOyOslUzNAapSUVBbbNOHHkux6BijFa758Ul2HtldnWepJIjnHpIz24e+7MT0KEcTI/R98Yo4AaU4glewkjww7YlRdPrQg+7neM3BVf4zLZSIUbFS4uFiB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340197; c=relaxed/simple;
	bh=vUJHiaB9/vEc2ZeRjL63KHR9KGQgJcrnfwPBPpCG5As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvbcIqHyWaU6pl2gWPGzQ+0WlakOG7HQmhkKfhFVHjIme2ypSP4eqoHOVpbqn4va5Hkexc2bPq+GizruH8ReptWFq6kBwWBNAmpVvaPgI/TccOMP/lQcPsXd5pQoR72be3mLgqzxZ3KojC+zH/XaYAIiIONVYcx8fQj60flbmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjzufBYt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340181; x=1746876181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vUJHiaB9/vEc2ZeRjL63KHR9KGQgJcrnfwPBPpCG5As=;
  b=JjzufBYtez6CszXijmr7C0xyFpT4m4hb6pur7/kpt02tWLwj2wnQG3wA
   4W3/UloXetGcskmITeRK469U3uaMRbRzWTWb+fUGsv53c999FPmtAq5rT
   rwsKPcs8x0K7Gam4ywUuorIz8aIzQTCPcZzPpU1vjFHa/m9NzXJcCifop
   bqK5pwCF0asDSRQWxGeAWiXnxUygKJDNRy1PkCYlisOu/3o4UxY2u8xUI
   QhRzWM5jC67+66XyttfgeScguifKSLbqRII0SRVUq9uFHRqKdOlZpv/MA
   8LDseD/gEXxgiMeDF7gPeuUggwJV7Yos4W7vzpHGrqTyF8v/lpW6Etjhj
   A==;
X-CSE-ConnectionGUID: ksbRPP77SUynNhnPM1t1lQ==
X-CSE-MsgGUID: cO8F9CSwScqbJ9wdBe5+GA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11442681"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11442681"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:59 -0700
X-CSE-ConnectionGUID: Bx6xLqL3TkSYlMWNSINPGw==
X-CSE-MsgGUID: C+3L1/UWSGeoY1t8LWhAsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34235016"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:22:58 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 6/8] drm/i915/pciids: remove 11 from INTEL_ICL_IDS()
Date: Fri, 10 May 2024 14:22:19 +0300
Message-Id: <36973674bf333dfdd7cd32ae656754bfa150022b.1715340032.git.jani.nikula@intel.com>
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
for ICL.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      | 2 +-
 drivers/gpu/drm/i915/display/intel_display_device.c | 2 +-
 drivers/gpu/drm/i915/i915_pci.c                     | 2 +-
 include/drm/i915_pciids.h                           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 2b698a3f56ef..c150bb6f1a39 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -547,7 +547,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_CML_IDS(&gen9_early_ops),
 	INTEL_GLK_IDS(&gen9_early_ops),
 	INTEL_CNL_IDS(&gen9_early_ops),
-	INTEL_ICL_11_IDS(&gen11_early_ops),
+	INTEL_ICL_IDS(&gen11_early_ops),
 	INTEL_EHL_IDS(&gen11_early_ops),
 	INTEL_JSL_IDS(&gen11_early_ops),
 	INTEL_TGL_12_IDS(&gen11_early_ops),
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 23909a8e2dc8..e47896002c13 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -831,7 +831,7 @@ static const struct {
 	INTEL_CFL_IDS(&skl_display),
 	INTEL_WHL_IDS(&skl_display),
 	INTEL_CML_IDS(&skl_display),
-	INTEL_ICL_11_IDS(&icl_display),
+	INTEL_ICL_IDS(&icl_display),
 	INTEL_EHL_IDS(&jsl_ehl_display),
 	INTEL_JSL_IDS(&jsl_ehl_display),
 	INTEL_TGL_12_IDS(&tgl_display),
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index d85f023afebe..06b1d50ae47c 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -857,7 +857,7 @@ static const struct pci_device_id pciidlist[] = {
 	INTEL_CML_GT2_IDS(&cml_gt2_info),
 	INTEL_CML_U_GT1_IDS(&cml_gt1_info),
 	INTEL_CML_U_GT2_IDS(&cml_gt2_info),
-	INTEL_ICL_11_IDS(&icl_info),
+	INTEL_ICL_IDS(&icl_info),
 	INTEL_EHL_IDS(&ehl_info),
 	INTEL_JSL_IDS(&jsl_info),
 	INTEL_TGL_12_IDS(&tgl_info),
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 0c5a20d59801..ecfd7f71e2e7 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -597,7 +597,7 @@
 	INTEL_VGA_DEVICE(0x8A70, info), \
 	INTEL_VGA_DEVICE(0x8A71, info)
 
-#define INTEL_ICL_11_IDS(info) \
+#define INTEL_ICL_IDS(info) \
 	INTEL_ICL_PORT_F_IDS(info), \
 	INTEL_VGA_DEVICE(0x8A51, info), \
 	INTEL_VGA_DEVICE(0x8A5D, info)
-- 
2.39.2


