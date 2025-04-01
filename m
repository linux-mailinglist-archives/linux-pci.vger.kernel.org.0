Return-Path: <linux-pci+bounces-25083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC8A77F28
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340463A61FE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BE20B7F1;
	Tue,  1 Apr 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mV7HUVZj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06120B215;
	Tue,  1 Apr 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521805; cv=none; b=nrIRPStESMTDLDAxf3TIyQiEbeWA8dK6MBfTJnpOYq9Em/RDug04kyCi4MhGFUhL2hniS6uL8U+WyCgHlWMbuYA5qgvJ27EKaTsHs1G2QhQoHETZP2CLFPsFdvNS67/6ciP6wSr9rLsN/WYnv1GZzJbO0hG+M89vJoYn5OlFvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521805; c=relaxed/simple;
	bh=dsP+888uIdqDAiC2Bm7ZdgFdM4RIRERPL+I4RhA8s+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu0Vo7cZ2Q4zj02xAhJpeALAcZQrszeHiNPJe7HcgEqigONuOK6qjM4TKL8roJMJK9YBrjJXMMSKjmyInZPAvtNlV4BhTpfNLtMeUIst2bnefUrQF0jZ/PzS1lrz8TjejhO+R5IhQ7WYga2q2nf3II+ogtdeXN4yH1p+mMD2u1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mV7HUVZj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521804; x=1775057804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsP+888uIdqDAiC2Bm7ZdgFdM4RIRERPL+I4RhA8s+M=;
  b=mV7HUVZjzvenMJnbbhv0lTzwlqVAv1LikFGXXNnwgpvtY9bjsLRG82RQ
   i4Ikfq+UkCguojEJrCPX3uI03G9xXdFAn+5+4V+yN8eYIdyxfmHyz3Q5u
   z+jsTSCEOX97+DiAleMMn5KXnKjBaRyGbLNT+tasZVz7xUVh5tzGpyTlr
   a0+DdOzxnYcbk1hPn3pufIRBnrUl2lkdGuxG0RRtx5uRyzKQjgBYATBxP
   ju203skuoK71FN6316TPlKYgdY7xPp91DNmrGzUHd3hilivQCcLUdzBUl
   DwVj2MBqtpXw37pinKYTabWxMa7Uy0jjJXFG8g6a/98/6bR/kQDmkkZ9I
   A==;
X-CSE-ConnectionGUID: BnxF+l1yRdGbM8NUDxrntQ==
X-CSE-MsgGUID: kBl1CqV3TgCWehibYcJKFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324970"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324970"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:43 -0700
X-CSE-ConnectionGUID: 7tuduFq8SsysXcdMIqzJtg==
X-CSE-MsgGUID: euFH4kPtTHSbmyPBe3rq6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410990"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:39 -0700
From: Anshuman Gupta <anshuman.gupta@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	badal.nilawar@intel.com,
	anshuman.gupta@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH 10/12] drm/xe/pm: D3Cold target state
Date: Tue,  1 Apr 2025 21:02:23 +0530
Message-ID: <20250401153225.96379-11-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401153225.96379-1-anshuman.gupta@intel.com>
References: <20250401153225.96379-1-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trade-off D3Cold target state based upon current vram usage.
If vram usage is greater than vram_d3cold_threshold and GPU
is VRSR capable target D3Cold state is D3Cold-VRSR
otherwise target state is D3Cold-Off.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index d4149a2eace7..5db9313ae269 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -148,6 +148,14 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
 			 &xe_pm_runtime_d3cold_map);
 }
 
+static void xe_pm_suspend_prepare(struct xe_device *xe)
+{
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
+		xe_pm_d3cold_allowed_toggle(xe);
+	else
+		xe->d3cold.target_state = XE_D3COLD_OFF;
+}
+
 /**
  * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
  * @xe: xe device instance
@@ -163,6 +171,8 @@ int xe_pm_suspend(struct xe_device *xe)
 	drm_dbg(&xe->drm, "Suspending device\n");
 	trace_xe_pm_suspend(xe, __builtin_return_address(0));
 
+	xe_pm_suspend_prepare(xe);
+
 	err = xe_pxp_pm_suspend(xe->pxp);
 	if (err)
 		goto err;
@@ -927,10 +937,14 @@ void xe_pm_d3cold_target_state_toggle(struct xe_device *xe)
 
 	if (total_vram_used_mb < xe->d3cold.vram_threshold)
 		xe->d3cold.target_state = XE_D3COLD_OFF;
+	else if (xe->d3cold.vrsr_capable)
+		xe->d3cold.target_state = XE_D3COLD_VRSR;
 	else
 		xe->d3cold.target_state = XE_D3HOT;
 
 	mutex_unlock(&xe->d3cold.lock);
+
+	drm_dbg(&xe->drm, "Xe d3cold target state %d\n", xe->d3cold.allowed);
 }
 
 /**
-- 
2.43.0


