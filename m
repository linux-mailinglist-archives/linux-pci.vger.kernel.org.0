Return-Path: <linux-pci+bounces-28600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A1AC7C7A
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5553A53CB
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E728E59B;
	Thu, 29 May 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yqkbj+5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46982227E98;
	Thu, 29 May 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517301; cv=none; b=aeWyBmzoXGza8AuW1J/oKwvJPlVmZKLcYL8gfleU2fqijw2a2G9MXMHpy4bHS+J3EngDVEFWX1jEzjY1VBYY4n/PVEV7pOzjrHXBsXoHfrZ89SI6NFX9MS9uDrKEseuR/7ec2LFitO4CiBqF0vflKHuj6PTulgCSk8zYBMcDUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517301; c=relaxed/simple;
	bh=gq3lu6Vr77h2vZYMvDJ1FcMwb1J2hvDXLwwcG8LAHk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzXmP/riy1pNtYPEQmfYgPTW/yrjp8ILaviAkiB617xhL1Fp6pM7zggRpi64V7XjzWQASZcvccIAZYRYUp61hXbzuj7nCJDPzNhD6+LGegb8n7kOOWN//oAY2i1c2K+tjpcXP4WjmM8mXTVIkvPqJKg/mKRUVV2K2Y+cUwbtwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yqkbj+5a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517300; x=1780053300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gq3lu6Vr77h2vZYMvDJ1FcMwb1J2hvDXLwwcG8LAHk0=;
  b=Yqkbj+5alZo851WrfrV12zMPtInMHAngS5Z3o2sqPS9vmMvu2HmtsrgK
   iMjFiQ1WjVLOak6omzHQMGzRsyTeUguzn996d8m7b7HCwKYndhQ0ByTzh
   /XrWaxTQhE0DJGf/xvSbLgaA2CEu1UiFrPrxL6c5mbcfJOUpDCzlPMzIH
   nMRtln2ELHye6Qhu/W5O2P0LJhu9ZITyAJJ6B6ztj6FvBkZo09ftlu3RN
   k6EPFgtSSmyPkDVa/tnJ24w0OCEuH32P/roo5xIhWR2HSWNsbWA+Burb3
   92EAP3sEeKhvrLD1/DzTai0GRv2KODyL7R4+7lzEWqVP9SgpgkL/0cfBI
   A==;
X-CSE-ConnectionGUID: 0UtRu/yqTh+vmy7qNRJetA==
X-CSE-MsgGUID: nVbYX7pfTPaGzp5s0vxDCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68123128"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="68123128"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:00 -0700
X-CSE-ConnectionGUID: B3uuDiPEQrqnzIqbpbvBxw==
X-CSE-MsgGUID: q5TfuQo5TnOLOnCls+WpVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="143510415"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:14:56 -0700
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
Subject: [PATCH v4 04/11] drm/xe/vrsr: Introduce flag has_vrsr
Date: Thu, 29 May 2025 16:46:47 +0530
Message-Id: <20250529111654.3140766-5-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529111654.3140766-1-badal.nilawar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
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


