Return-Path: <linux-pci+bounces-7165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671128BE2C0
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE01B26528
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96BD15D5DB;
	Tue,  7 May 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctjdsG0O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567715D5C9
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086631; cv=none; b=P9QM96ohb87psuJmX+mkxUYu826Xd7yaMTU+SbU9uahARG+92WA44poiCT3ysyJh/cUq94VwqjtPN3xm5gUW7tGpf/BKGLyws3r2P6Jt1vPsQPUMtqDsk3dDGqN8Feq7Jm3fAebvdaJ5Fi/GDIMeu1j/yYb/0foMmKxp2F2I7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086631; c=relaxed/simple;
	bh=tDLtaw9p935dhWpUjICAylppBv9rjk+cip7jHg552uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFR0Nl89uCCzmFT5UZRvu+LtbhKQgE0H6etED5KSWVfQc8wPHivLk/7QB2iJ9MiSbqiw9Sz/x0f6LmAwhEcRrAxiEn4i2sAgE84GIBo9P2VjdI9U72n5dS/qvRyJfs1swTC3Lt/uut5IBrgYebUDQYkdRGlcqdjXfGhOjrv5JwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctjdsG0O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715086630; x=1746622630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDLtaw9p935dhWpUjICAylppBv9rjk+cip7jHg552uA=;
  b=ctjdsG0OBRdiP32GF1ATZe28G3KfqsBwt1qP6iVLZA7rAFezgE7oEAVH
   F0XoxPYP6vCIxAmIe49xQnYK1G+xNawZsRzMdEHq9//jXkkoLcIkpljCK
   hiQvi0NIOqlhCxf7Bc5pSN6gNI+AEOMJN19aH8k1IGzg/Yaa91NX/3XX1
   IV4CW6NnTnzHNrL0vqWmxXXVqdP+vhgHYCmMg38AK042F1EQ717vsK29n
   iok41Ev5ko3f0SbE0LYsJESnQ+Uh7dvfIDJQbkgnMdLW0hIutQ3la7tai
   BpfDUxZMLb8tubyu4DD5WuluOynN7X5UvbsBXAFjuhHpWc7YJk/HtPipM
   Q==;
X-CSE-ConnectionGUID: B3pT5PnRRh6b38lLp31e/Q==
X-CSE-MsgGUID: jf+s3soWQ6qQMf4wNgiM5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11035217"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="11035217"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:57:10 -0700
X-CSE-ConnectionGUID: OW300R5MRIy3UHZIPB6nLQ==
X-CSE-MsgGUID: fZ7ws3iHQUyGQhHssu9nsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="29038156"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.16])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:57:08 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/5] drm/i915: don't include RPL-U PCI IDs in RPL-P
Date: Tue,  7 May 2024 15:56:49 +0300
Message-Id: <697b354c2f12f923867cea2ad8f6628737716949.1715086509.git.jani.nikula@intel.com>
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

It's confusing for INTEL_RPLP_IDS() to include INTEL_RPLU_IDS(). Even if
we treat them the same elsewhere, the lists of PCI IDs should not.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      | 1 +
 drivers/gpu/drm/i915/display/intel_display_device.c | 1 +
 drivers/gpu/drm/i915/i915_pci.c                     | 1 +
 drivers/gpu/drm/i915/intel_device_info.c            | 1 +
 include/drm/i915_pciids.h                           | 1 -
 5 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 2e2d15be4025..549227d15691 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -559,6 +559,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_ADLP_IDS(&gen11_early_ops),
 	INTEL_ADLN_IDS(&gen11_early_ops),
 	INTEL_RPLS_IDS(&gen11_early_ops),
+	INTEL_RPLU_IDS(&gen11_early_ops),
 	INTEL_RPLP_IDS(&gen11_early_ops),
 };
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 3aa7d1cdd228..342b439b0ee4 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -843,6 +843,7 @@ static const struct {
 	INTEL_RPLS_IDS(&adl_s_display),
 	INTEL_ADLP_IDS(&xe_lpd_display),
 	INTEL_ADLN_IDS(&xe_lpd_display),
+	INTEL_RPLU_IDS(&xe_lpd_display),
 	INTEL_RPLP_IDS(&xe_lpd_display),
 	INTEL_DG2_IDS(&xe_hpd_display),
 
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 405ca17a990b..a16fb09061e2 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -867,6 +867,7 @@ static const struct pci_device_id pciidlist[] = {
 	INTEL_ADLN_IDS(&adl_p_info),
 	INTEL_DG1_IDS(&dg1_info),
 	INTEL_RPLS_IDS(&adl_s_info),
+	INTEL_RPLU_IDS(&adl_p_info),
 	INTEL_RPLP_IDS(&adl_p_info),
 	INTEL_DG2_IDS(&dg2_info),
 	INTEL_ATS_M_IDS(&ats_m_info),
diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index a0a43ea07f11..b119923f8be2 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -182,6 +182,7 @@ static const u16 subplatform_n_ids[] = {
 
 static const u16 subplatform_rpl_ids[] = {
 	INTEL_RPLS_IDS(0),
+	INTEL_RPLU_IDS(0),
 	INTEL_RPLP_IDS(0),
 };
 
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 5f52c504ffde..1b9cb6195637 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -699,7 +699,6 @@
 
 /* RPL-P */
 #define INTEL_RPLP_IDS(info) \
-	INTEL_RPLU_IDS(info), \
 	INTEL_VGA_DEVICE(0xA720, info), \
 	INTEL_VGA_DEVICE(0xA7A0, info), \
 	INTEL_VGA_DEVICE(0xA7A8, info), \
-- 
2.39.2


