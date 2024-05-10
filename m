Return-Path: <linux-pci+bounces-7352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CBE8C2331
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45F82830FB
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1B16DEDE;
	Fri, 10 May 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXJMwgxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67616F0E5
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340197; cv=none; b=hX3kUyEtLx+hoSTtVnDJm4GIiVGZst1IZFE4Apvkzg4TlhmQ+AVIu0jlVfSWMTP5NDVpztlddinZgFjzQg/Mon9gzNLmv+aRNcNtrhRd59rHjYeIup/4hDnqfxo4q8qlI2vlzNFPfInThEbSw92/Uv3x7bpS7dJmTwW5nRiOROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340197; c=relaxed/simple;
	bh=/UV9YT7dmBjUaJi6T69VthRsqm9/oktzq7hcrAQaTz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3B/v/8eKNwbIw3uj4LjAIgt6NiJ2+OmxObn8U1WZ5iZRDWydb76Rpuf+0U4fJbc3LdiLYO6Mpe8oSIX8lTya9izeVSSCl9E1pTxgOxQVEA6pOp70CRudqy1D08QYTxUJpf7IehIqulPpg0I0HfdHs7aGpv0gg8Em+iYLIWDwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXJMwgxA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340190; x=1746876190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UV9YT7dmBjUaJi6T69VthRsqm9/oktzq7hcrAQaTz8=;
  b=FXJMwgxAr9N9OL3085zm+UknQXz05Y9dl95siRbpBy2Ezc47Y1hTtsfP
   Tx7IR/IijGT14YbmTDq+MSjFZ9pG8G2ZG4t77l8jot9XaSlT6luV06M2a
   QwoHZnE/6LYQ2NyZ0mJdUjmhGtiNSo+KNhtMQqEcF2hFMNKYvRKWxICyz
   INVlJMnAj4FOnT7zPR68jPLBjwQwJpcw9VD3BiVsMoCwH0o0LZKP50dLO
   Vb5L83+YaykQ7Oj9sh+eSFKpbVnHcgGVSkiG/KQIAwDagPVmqsjBCPywc
   slURov3C05lmSN4lpap12womsSSJLgrNhXw4XUHcPEx4sdy+EnY6Ui4os
   A==;
X-CSE-ConnectionGUID: 7QrgG6jaSEe1hJkrWXgBCA==
X-CSE-MsgGUID: eWO5O2svQ+GCWGY5flC6ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11442701"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11442701"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:23:10 -0700
X-CSE-ConnectionGUID: Sawz9nYRRSOBvVdP9+/HXA==
X-CSE-MsgGUID: 4YE6cHYUSnmOAkZ9blNQVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34235095"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:23:08 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 8/8] drm/i915/pciids: don't include RPL-U PCI IDs in RPL-P
Date: Fri, 10 May 2024 14:22:21 +0300
Message-Id: <28fe0910efb93a28c400728af14beff015667f42.1715340032.git.jani.nikula@intel.com>
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

It's confusing for INTEL_RPLP_IDS() to include INTEL_RPLU_IDS(). Even if
we treat them the same elsewhere, the lists of PCI IDs should not.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/x86/kernel/early-quirks.c                      | 1 +
 drivers/gpu/drm/i915/display/intel_display_device.c | 1 +
 drivers/gpu/drm/i915/i915_pci.c                     | 1 +
 drivers/gpu/drm/i915/intel_device_info.c            | 1 +
 include/drm/i915_pciids.h                           | 1 -
 5 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index b2b9cc3b9545..fd74d7f26f01 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -556,6 +556,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_ADLP_IDS(&gen11_early_ops),
 	INTEL_ADLN_IDS(&gen11_early_ops),
 	INTEL_RPLS_IDS(&gen11_early_ops),
+	INTEL_RPLU_IDS(&gen11_early_ops),
 	INTEL_RPLP_IDS(&gen11_early_ops),
 };
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index fb4c4054207e..89069cff06b4 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -841,6 +841,7 @@ static const struct {
 	INTEL_RPLS_IDS(&adl_s_display),
 	INTEL_ADLP_IDS(&xe_lpd_display),
 	INTEL_ADLN_IDS(&xe_lpd_display),
+	INTEL_RPLU_IDS(&xe_lpd_display),
 	INTEL_RPLP_IDS(&xe_lpd_display),
 	INTEL_DG2_IDS(&xe_hpd_display),
 
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index fa56113ed1ce..74202925d13f 100644
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
index 64651a54a245..a39497971994 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -182,6 +182,7 @@ static const u16 subplatform_n_ids[] = {
 
 static const u16 subplatform_rpl_ids[] = {
 	INTEL_RPLS_IDS(0),
+	INTEL_RPLU_IDS(0),
 	INTEL_RPLP_IDS(0),
 };
 
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 42913d2eb655..04f6ca3dc5c1 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -717,7 +717,6 @@
 
 /* RPL-P */
 #define INTEL_RPLP_IDS(info) \
-	INTEL_RPLU_IDS(info), \
 	INTEL_VGA_DEVICE(0xA720, info), \
 	INTEL_VGA_DEVICE(0xA7A0, info), \
 	INTEL_VGA_DEVICE(0xA7A8, info), \
-- 
2.39.2


