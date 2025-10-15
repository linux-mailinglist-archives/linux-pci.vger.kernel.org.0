Return-Path: <linux-pci+bounces-38167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4EBDD4A6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FD824FB4D4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F112C237F;
	Wed, 15 Oct 2025 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxmDiX27"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BC2C326E;
	Wed, 15 Oct 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515362; cv=none; b=B1VVy3mh4upcD2lluC3hZ7xV4FBkv0BhTeNrWH3yRa9FFtRAKq6Bj4ehycsWYOMzYQsnbI7WF/tDcmedMihq5jL4bkUBoNXoyoqRWLo16bm3NtV4t3susmNtGBPIwQH9Cbp3deNNZW4d6nBg+yEsQVcb61MxW+I6BvGwJSbZs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515362; c=relaxed/simple;
	bh=0DCpJKa9LI8sTvf1sgsZc3EobCgq75SV5RisfqpdTwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSwYpmTLYZvFCH2Mq9Q0fja5MXfyPxlJUL5/AstmOlMJOG1gGCTwCu0QpMsLr3q3Rv5yXBYENzzZQk/iW6GrjYgf7ECYebMBR49YuL8cWaV3XVERkN/tbyiIOO0qAWzHXPIIe59xEIqqvWYFc7+zMHHpZh2botpTWj+iZdAF4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxmDiX27; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515361; x=1792051361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0DCpJKa9LI8sTvf1sgsZc3EobCgq75SV5RisfqpdTwE=;
  b=YxmDiX27NcMDUDz4MKNdp1T609Wo2MIxfrVszBQnO6a8mneb+s7YF5hG
   9ZZQpUn4uBXLPVmP7FRoLEMRcausUvE0UQpgFclP54SDU/ceHBatOpLEO
   HJnoekvHInsldpKGDPvBe+VrEh4aPoIE1eYiMViTivUhO91XgIq8mEF5C
   jOMnXY+Zuedx6IVF2MHe/gE3+8ewe3pyNIaTtgkMylGFa+FSiFxB5TRW7
   ewFQ5i3u8eVil7SUjLn1+4MwSl46Oo0NNPvFARLGM1I8V7I021Rp0nrEN
   llSgsEknqlWQOV0YzBO2xdYqMpmdhPMJUsLb1UemNCdn6Pes1Hxcge1MP
   Q==;
X-CSE-ConnectionGUID: GZXOT29oRHujRImzIKc+ZQ==
X-CSE-MsgGUID: GvfVYKXPQ1aYGUSQk2Hnng==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891467"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891467"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:41 -0700
X-CSE-ConnectionGUID: nA6wDb3gQTKjCbOtCFab1A==
X-CSE-MsgGUID: ET0fsUUVR3uRpVp9FNHEAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805384"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:37 -0700
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
	uma.shankar@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v5 04/12] drm/xe/vrsr: Introduce flag has_vrsr
Date: Wed, 15 Oct 2025 13:37:02 +0530
Message-Id: <20251015080710.1468409-5-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015080710.1468409-1-badal.nilawar@intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
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
Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h | 2 ++
 drivers/gpu/drm/xe/xe_pci.c          | 2 ++
 drivers/gpu/drm/xe/xe_pci_types.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 02c04ad7296e..7fbdb5545946 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -313,6 +313,8 @@ struct xe_device {
 		u8 has_sriov:1;
 		/** @info.has_usm: Device has unified shared memory support */
 		u8 has_usm:1;
+		/** @info.has_vrsr: Has capability to enter into VRAM self refresh */
+		u8 has_vrsr:1;
 		/** @info.has_64bit_timestamp: Device supports 64-bit timestamps */
 		u8 has_64bit_timestamp:1;
 		/** @info.is_dgfx: is discrete device */
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 24a38904bb50..0cc14ddd92de 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -350,6 +350,7 @@ static const struct xe_device_desc bmg_desc = {
 	.has_heci_cscfi = 1,
 	.has_late_bind = true,
 	.has_sriov = true,
+	.has_vrsr = true,
 	.max_gt_per_tile = 2,
 	.needs_scratch = true,
 	.subplatforms = (const struct xe_subplatform_desc[]) {
@@ -633,6 +634,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_pxp = desc->has_pxp;
 	xe->info.has_sriov = xe_configfs_primary_gt_allowed(to_pci_dev(xe->drm.dev)) &&
 		desc->has_sriov;
+	xe->info.has_vrsr = desc->has_vrsr;
 	xe->info.skip_guc_pc = desc->skip_guc_pc;
 	xe->info.skip_mtcfg = desc->skip_mtcfg;
 	xe->info.skip_pcode = desc->skip_pcode;
diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
index a4451bdc79fb..ad5b024ede1e 100644
--- a/drivers/gpu/drm/xe/xe_pci_types.h
+++ b/drivers/gpu/drm/xe/xe_pci_types.h
@@ -48,6 +48,7 @@ struct xe_device_desc {
 	u8 has_mbx_power_limits:1;
 	u8 has_pxp:1;
 	u8 has_sriov:1;
+	u8 has_vrsr:1;
 	u8 needs_scratch:1;
 	u8 skip_guc_pc:1;
 	u8 skip_mtcfg:1;
-- 
2.34.1


