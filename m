Return-Path: <linux-pci+bounces-25076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF05A77F1E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A6416CC78
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971220B20B;
	Tue,  1 Apr 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKM69a8r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1220B804;
	Tue,  1 Apr 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521787; cv=none; b=F74x6pdXZnNt3NZrBV5uS792aMCIcGAP1cNbH31g99+bHd1SGqueecCMff5FQr1cQPd6GYRjcU3+o1eUfmWVx2Ct6hseIRIviUKV41DLD98iVyCdsIAlzJF1ON8FHorFvfNEytZQ4la7hI685dc6FU/WaS+voLkTkeZHaxdF2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521787; c=relaxed/simple;
	bh=uExaOP1a4DxFAx6bbZRlSj9xlp0IAcng9Zs+2ugYS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENY5jktHmCoSDUrqJBBGlRaPQQL5yWsTKj0OzjH0QcD44LHJ7f+JYvnzQtLLeFu0kCPb82ZxMRI8f9bGLrII5MH1OYqN4ZCq0OuJXNYV9jbK46UDx5hzgCICzKIvObyn1ju6p6qGtswmsMQSGXIyNmX+nqJg3BQnEZew1slKav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKM69a8r; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521786; x=1775057786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uExaOP1a4DxFAx6bbZRlSj9xlp0IAcng9Zs+2ugYS/8=;
  b=UKM69a8rm6ZyGFrHp2h+QIz4kaqYkDcMTQhIyB+GbdtfGMqiAoiuNARb
   3f/QkhioEF4ZCCMdh4EgtIF3yHi8TxEqBbHREeBCJdnKbZ90mw3ej+K8/
   olcZOJEaYTRsU46MFpMn7hxFcEowWOgaeh8BAqy9JWKyH0YjLFXwUi9LO
   Ke3JCsGoK+enB8dJ13+V6I840klz6JNEP4KxtrYEBfiboQ4q6B1D3oUPi
   Ss2BYt7ltQMHg1H4Vr+1eW07WI+JiHCAKbs4/ua4LW2Aa97mU9F76OrXB
   6iUIic1WwWFvBOHLO3tBehm/8ZaBjOTXh2Kyv5aQZ/hftiOPRMY42POlA
   Q==;
X-CSE-ConnectionGUID: vVCFmD3UR0WbLOINxuP+Kw==
X-CSE-MsgGUID: WfzQEl6cRECtTuqgVb/DIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324835"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324835"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:19 -0700
X-CSE-ConnectionGUID: T8EbKZs1Sf+ecB+4SGcKCw==
X-CSE-MsgGUID: +cRi9RJ4QjS/KrePtLIb3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410833"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:16 -0700
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
Subject: [PATCH 04/12] drm/xe/vrsr: Introduce flag has_vrsr
Date: Tue,  1 Apr 2025 21:02:17 +0530
Message-ID: <20250401153225.96379-5-anshuman.gupta@intel.com>
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

From: Badal Nilawar <badal.nilawar@intel.com>

Introduce flag has_vrsr to determine if platform supports VRSR feature

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h | 2 ++
 drivers/gpu/drm/xe/xe_pci.c          | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index c54adebfe518..b8ccf729f7c0 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -334,6 +334,8 @@ struct xe_device {
 		u8 has_sriov:1;
 		/** @info.has_usm: Device has unified shared memory support */
 		u8 has_usm:1;
+		/** @info.has_vrsr: Has capability to enter into VRAM self refresh */
+		u8 has_vrsr:1;
 		/** @info.is_dgfx: is discrete device */
 		u8 is_dgfx:1;
 		/**
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 772b6c81672c..70d4827f5821 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -68,6 +68,7 @@ struct xe_device_desc {
 	u8 has_llc:1;
 	u8 has_pxp:1;
 	u8 has_sriov:1;
+	u8 has_vrsr:1;
 	u8 skip_guc_pc:1;
 	u8 skip_mtcfg:1;
 	u8 skip_pcode:1;
@@ -343,6 +344,7 @@ static const struct xe_device_desc bmg_desc = {
 	.dma_mask_size = 46,
 	.has_display = true,
 	.has_fan_control = true,
+	.has_vrsr = true,
 	.has_heci_cscfi = 1,
 };
 
@@ -589,6 +591,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_llc = desc->has_llc;
 	xe->info.has_pxp = desc->has_pxp;
 	xe->info.has_sriov = desc->has_sriov;
+	xe->info.has_vrsr = desc->has_vrsr;
 	xe->info.skip_guc_pc = desc->skip_guc_pc;
 	xe->info.skip_mtcfg = desc->skip_mtcfg;
 	xe->info.skip_pcode = desc->skip_pcode;
-- 
2.43.0


