Return-Path: <linux-pci+bounces-28345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC872AC2A15
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699B454599E
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469EB29B8CA;
	Fri, 23 May 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1vnwEEg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497229AB02;
	Fri, 23 May 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026804; cv=none; b=Eea3D0OW+OQRh0btfsIt991QGFwgyCGOepeBD+L1pl/0gxrR7eyORha4dQvj5QoE0ZhjxiGDpxMPeDzVIUuslc2KRhvxXb1zj6b4LxbEjzrDO5JkmMJsSv4T+/Cnrj3V3VPDdsBbsxY7x3nIOLPYrgq1y9nmHKaG9BEP0VPvzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026804; c=relaxed/simple;
	bh=gq3lu6Vr77h2vZYMvDJ1FcMwb1J2hvDXLwwcG8LAHk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RajywAWQuoxZ+14pxzA90ECD6SjrVrZmASS8j6SVKP10/FT4vfBSyz/lbMMDlQKZZNfnZi4TJ6KbO+0ai1FA9jY38I0Vl9Ba4QQ04DbRYqTbTMi96wcbF7bBtsaKHm1JSGCOlgLUcZhEBegoi81PocEBSVYXi+RP6pXrCzJa8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1vnwEEg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026803; x=1779562803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gq3lu6Vr77h2vZYMvDJ1FcMwb1J2hvDXLwwcG8LAHk0=;
  b=Q1vnwEEgLC6fO/XeC4XilPRqrlBB16ZGkEPQJU8pRXyyOcMjFxTk1doJ
   +UdEYGNU5PgP3U49jQse/DQoJ079Jdv7m6JTCIJqpYLstooOBscZpM2M+
   e8GOXTPYtF1buswxDOP8rigUdnAXs4VdL34vqGSHeTLwCv2feyyfu6T8/
   BEZ7+sISYQlH4vm/jWObh+WDra2e2gTi0iUW0kmVvwK9ZkNe48PrQ3kpE
   cLorzE94hNgUOL5T0kYUyNQHUdnmq1i3JbGbk9LNsKT2xzFHuTYWqoagR
   5XStfVpuovLjFalKq0VAbRPkWSB98mW4gcB/f4XOPUfFFZviNtyINFSxs
   g==;
X-CSE-ConnectionGUID: dYqaL1oMRaGGmmAlxPPfww==
X-CSE-MsgGUID: cAHgpuclS4C4RI7ZZkvFqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498492"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498492"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:02 -0700
X-CSE-ConnectionGUID: bR1amnG0SJmEsGaEqrUXDQ==
X-CSE-MsgGUID: EPH+s7rDTZ+xUB0gqEus1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141758922"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:59:59 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH v3 04/11] drm/xe/vrsr: Introduce flag has_vrsr
Date: Sat, 24 May 2025 00:31:48 +0530
Message-Id: <20250523190155.2623462-5-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523190155.2623462-1-badal.nilawar@intel.com>
References: <20250523190155.2623462-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce flag has_vrsr to determine if platform supports VRSR feature

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h | 2 ++
 drivers/gpu/drm/xe/xe_pci.c          | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index f81be293b260..e2749ed2a61f 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -334,6 +334,8 @@ struct xe_device {
 		u8 has_sriov:1;
 		/** @info.has_usm: Device has unified shared memory support */
 		u8 has_usm:1;
+		/** @info.has_vrsr: Has capability to enter into VRAM self refresh */
+		u8 has_vrsr:1;
 		/** @info.has_64bit_timestamp: Device supports 64-bit timestamps */
 		u8 has_64bit_timestamp:1;
 		/** @info.is_dgfx: is discrete device */
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 024175cfe61e..46a99d6ef1a5 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -68,6 +68,7 @@ struct xe_device_desc {
 	u8 has_llc:1;
 	u8 has_pxp:1;
 	u8 has_sriov:1;
+	u8 has_vrsr:1;
 	u8 needs_scratch:1;
 	u8 skip_guc_pc:1;
 	u8 skip_mtcfg:1;
@@ -342,6 +343,7 @@ static const struct xe_device_desc bmg_desc = {
 	.dma_mask_size = 46,
 	.has_display = true,
 	.has_fan_control = true,
+	.has_vrsr = true,
 	.has_heci_cscfi = 1,
 	.needs_scratch = true,
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
2.34.1


