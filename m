Return-Path: <linux-pci+bounces-44638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC62D1A50E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CCDE308D04F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4330AAC9;
	Tue, 13 Jan 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M72xvR7H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4E30AAC2;
	Tue, 13 Jan 2026 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321955; cv=none; b=GRhq3l2VcFzzS3u9HCiBY7xcXfTTz+1zimwwf9CwHaXuTz5bptpYPnERYQVHQsC9nc9m6ZcwUoOc5xwn+1wezezNRJ+oaZYnwiYgORLSCyPL8lvO5159P3/er3mu8aJGso45Plwbdtrw1u0DQ2ELtjfIHFxCOTzdLThADKlWmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321955; c=relaxed/simple;
	bh=trDKs1jKEbKE7Za1jhy5nYv7ZJc3BN8CxALXHqh7VBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDVJ1hwPmDJD/PBS/aY+ThBtW9T/22m7FmB8bV0BScnIXO7PYhCG06AU590I80xoHNfjh2TNeaU3IhtkFWnypWRxs/9xJpk2Mwg1DlXqJLemTmhJpqQweygDF1LAgye/TmCrPNg88yK2xqrMmT72ZK/GsqOh3BGoevZ2xgHvlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M72xvR7H; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321953; x=1799857953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trDKs1jKEbKE7Za1jhy5nYv7ZJc3BN8CxALXHqh7VBU=;
  b=M72xvR7H5Es45X6Gx1GAShO9qs60DpixU8sZqjG2XGcMxxHkcYUw200k
   Lqf9tZ2An4mXiI6hEDfAd1sG8WMyZHlqvcICYMbl58itgdLPjXH9X3KSC
   AFctmEmRlZ+iqpdvOEBHghnLcPggWuan9ZLT57rrAu51VI1tC2G85z3KI
   x6zPa+D74rlX8AVZBCPl4IscJX3UoeMxq/EIAuj/b3CiOLA7gwSCUuk6L
   5PmkifIEDBUC6NzA/ludE5vUm1/tfQQVGUJuUK9w2vSTAsxndaU4mpddV
   PgnGnYxvbX+EmIWbvPbUCIJV9f2kFB1VwpruPHDKsqRGpJdQrPhHu1q9K
   A==;
X-CSE-ConnectionGUID: ezkGyqKtS7er2Ob4qL6Kng==
X-CSE-MsgGUID: d1q6rpQMQdyYOLpDa890Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521057"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521057"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:33 -0800
X-CSE-ConnectionGUID: bKjgY74UStCXlkSZGGuE0Q==
X-CSE-MsgGUID: pICgS0vNT2mHVzSu9/FxUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060162"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:29 -0800
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	karthik.poosa@intel.com,
	matthew.auld@intel.com,
	sk.anirban@intel.com,
	raag.jadav@intel.com
Subject: [PATCH v6 08/12] drm/xe/pm: D3cold target state
Date: Tue, 13 Jan 2026 22:12:09 +0530
Message-ID: <20260113164200.1151788-22-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113164200.1151788-14-badal.nilawar@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anshuman Gupta <anshuman.gupta@intel.com>

Trade-off D3cold target state based upon current vram usage.
If vram usage is greater than vram_d3cold_threshold and GPU
is VRSR capable target D3cold state is D3cold-VRSR
otherwise target state is D3cold-Off.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index ef7a686eb014..1a1edbfcf240 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -167,6 +167,14 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
 			 &xe_pm_runtime_d3cold_map);
 }
 
+static void xe_pm_suspend_prepare(struct xe_device *xe)
+{
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
+		xe_pm_d3cold_target_state_toggle(xe);
+	else
+		xe->d3cold.target_state = XE_D3COLD_OFF;
+}
+
 /**
  * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
  * @xe: xe device instance
@@ -183,6 +191,8 @@ int xe_pm_suspend(struct xe_device *xe)
 	xe_pm_block_begin_signalling();
 	trace_xe_pm_suspend(xe, __builtin_return_address(0));
 
+	xe_pm_suspend_prepare(xe);
+
 	err = xe_pxp_pm_suspend(xe->pxp);
 	if (err)
 		goto err;
@@ -1115,10 +1125,14 @@ void xe_pm_d3cold_target_state_toggle(struct xe_device *xe)
 
 	if (total_vram_used_mb < xe->d3cold.vram_threshold)
 		xe->d3cold.target_state = XE_D3COLD_OFF;
+	else if (xe->d3cold.vrsr_capable)
+		xe->d3cold.target_state = XE_D3COLD_VRSR;
 	else
 		xe->d3cold.target_state = XE_D3HOT;
 
 	mutex_unlock(&xe->d3cold.lock);
+
+	drm_dbg(&xe->drm, "Xe D3cold target state %d\n", xe->d3cold.target_state);
 }
 
 /**
-- 
2.52.0


