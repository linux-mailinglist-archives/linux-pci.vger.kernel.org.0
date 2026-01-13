Return-Path: <linux-pci+bounces-44633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5848D1A4F9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED50630770CF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5A3093D1;
	Tue, 13 Jan 2026 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jd5VZrQl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3871B3925;
	Tue, 13 Jan 2026 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321932; cv=none; b=gp5CHIkYtPI53Dr1S7c3YE+qirX4KV84JBJDlxv6aOE+ReBxw6BvL1BayjuYqmw1AUV5g8g98ZgsB9RuOeH0NiLUPv/I3BqQvGTVUwlP8nrC5stbLhRRMKaNtL+tF2/UqqxzRIAeTMQ4d3zcNtO7eW5n0UG1P5/AHw7PxN3W3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321932; c=relaxed/simple;
	bh=Z9wb6BEv+oTSxpC6jeqFljfkBQ+JtoAg778D+FBmjxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr3kMvO+0KTqkfrKIX91jyRpAygooFj0JyJ1TOPETtHeCLmv/rAS6SvbkFWb8VyfxezXkgwMZzDMQhr7E3IpD46JLMuEdPknoOAWifmhdpgrr5HI5/vuYUjzRL04ModoZvBmFlYJcWtXPyLD2tRnVZh+LVb3lqkdSIvOs6opUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jd5VZrQl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321931; x=1799857931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z9wb6BEv+oTSxpC6jeqFljfkBQ+JtoAg778D+FBmjxI=;
  b=jd5VZrQlqUf+COinUer5pOK2SxavxTfzBKWAi6TKKSJdZHgo9GTUWjxg
   2p8ar/FJbM+2o8qsPj8sfa3XT3mjYryFsk0oP0/dE5HWhjTX2SgaBHdC8
   t0q4hjjlhd61rMT9E4TvLcwVQdAbU6ChBiBEXqHW55cGg5XKkS36MPQGJ
   cZmT5z/8nQAp+A9BMY0u3hfmDQZPWj62bMuqo+xrA4t059eXhQKSOhbFz
   tL49kMHtH0/9aNoXzIEJxKB+kbUyL6kaHZNfzeAhtCfwCRHep82putdKz
   lE3/KwlEtp3GDUcrV8oavMoBuFJyVw9mEUm0ufbKbAvlHNYbQrRS4oqCe
   Q==;
X-CSE-ConnectionGUID: Bo07UTnwRWWBG6BPIRmzAQ==
X-CSE-MsgGUID: wJASf6lfSVG7uWL3Oxr36A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521013"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521013"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:11 -0800
X-CSE-ConnectionGUID: 7MjBiNBsRZKE5kdPrv+/6g==
X-CSE-MsgGUID: IuXDXYwySCSP6v83orJVQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060125"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:07 -0800
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
Subject: [PATCH v6 03/12] drm/xe/vrsr: Introduce flag has_vrsr
Date: Tue, 13 Jan 2026 22:12:04 +0530
Message-ID: <20260113164200.1151788-17-badal.nilawar@intel.com>
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

Introduce flag has_vrsr to determine if platform supports VRSR feature

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>
---
V2: Rebased
---
 drivers/gpu/drm/xe/xe_device_types.h | 2 ++
 drivers/gpu/drm/xe/xe_pci.c          | 2 ++
 drivers/gpu/drm/xe/xe_pci_types.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index f689766adcb1..a7e9d981618c 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -363,6 +363,8 @@ struct xe_device {
 		u8 has_sriov:1;
 		/** @info.has_usm: Device has unified shared memory support */
 		u8 has_usm:1;
+		/** @info.has_vrsr: Has capability to enter into VRAM self refresh */
+		u8 has_vrsr:1;
 		/** @info.has_64bit_timestamp: Device supports 64-bit timestamps */
 		u8 has_64bit_timestamp:1;
 		/** @info.is_dgfx: is discrete device */
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 5c705124270e..5c14e1978a72 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -375,6 +375,7 @@ static const struct xe_device_desc bmg_desc = {
 	.has_soc_remapper_telem = true,
 	.has_sriov = true,
 	.has_mem_copy_instr = true,
+	.has_vrsr = true,
 	.max_gt_per_tile = 2,
 	.needs_scratch = true,
 	.subplatforms = (const struct xe_subplatform_desc[]) {
@@ -706,6 +707,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_sriov = xe_configfs_primary_gt_allowed(to_pci_dev(xe->drm.dev)) &&
 		desc->has_sriov;
 	xe->info.has_mem_copy_instr = desc->has_mem_copy_instr;
+	xe->info.has_vrsr = desc->has_vrsr;
 	xe->info.skip_guc_pc = desc->skip_guc_pc;
 	xe->info.skip_mtcfg = desc->skip_mtcfg;
 	xe->info.skip_pcode = desc->skip_pcode;
diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
index 20acc5349ee6..d9c490a68043 100644
--- a/drivers/gpu/drm/xe/xe_pci_types.h
+++ b/drivers/gpu/drm/xe/xe_pci_types.h
@@ -57,6 +57,7 @@ struct xe_device_desc {
 	u8 has_soc_remapper_sysctrl:1;
 	u8 has_soc_remapper_telem:1;
 	u8 has_sriov:1;
+	u8 has_vrsr:1;
 	u8 needs_scratch:1;
 	u8 skip_guc_pc:1;
 	u8 skip_mtcfg:1;
-- 
2.52.0


