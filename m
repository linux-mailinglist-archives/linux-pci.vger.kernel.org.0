Return-Path: <linux-pci+bounces-28352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5BFAC2A28
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8105F7B37AA
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02A29ACE3;
	Fri, 23 May 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ms9mDGFM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA9204C0F;
	Fri, 23 May 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026830; cv=none; b=EKgomYn5uI8Z+/I6R6w+xQKsfj4VhmPMmtAdBZI0zY20OB4Q44njYdoZjxLok4qYAZSynca0kSiur8Vjc4kk4lkab3Zqqh9410GVg371wMffUbISGDn/XrfI82JNipay3YDc+azefFSwqg26UmgZeLi8t8sYgzHKd3rx9PadUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026830; c=relaxed/simple;
	bh=j0RX+hYzyhMgc0XGcBiN0az+uJ5tRmncGyuo6+y7pf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYbcGaIJz1AWqxXMO3SiKLu/SYl97umkGmnYQjTzRo56RYPCkXSOuwshI9LU1axUwNn6YABXTAxvajyg2bbtCaSqQcw/d5MK/mDZ0TvOZGKs/cXOZvVffyE3XA7hiLuPUlBHxkRM2wUgHYpcRoge5IvDukkiZDn5M7s/t3kfEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ms9mDGFM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026829; x=1779562829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0RX+hYzyhMgc0XGcBiN0az+uJ5tRmncGyuo6+y7pf0=;
  b=Ms9mDGFMDlX8wXcr//kPObvntqZqTppTQwBr4Uhwi7SseontOM82msjA
   TJ2wBqLVqiIxNXWLxnsXzmJZRsyMvplwePylSg+rUm7XxaJ9cS35wO0GD
   kooF8+wLHQYKxvTnAK5LX005oiPJ1sr0vHR6TOwGNNsYdm1gIHb6L0+xo
   /zxTnISK0vuVi+dafp/QZYnJU8vhV4YnxvvlgJ28K91bfuO3t/C9oCQpe
   P2BU6+l4I5lppDJ1KmcXRbtvKwEbJHlOYbYfXKJsCKVIsHrEFDQVmNatV
   yrB2+W0nw1RMvGkO2m9EGQJIXPM24FajYXiJ13CvJapEshWXBBxR1qSmE
   A==;
X-CSE-ConnectionGUID: VKoS9ExaQD+jeuulU5Z3hw==
X-CSE-MsgGUID: B5bxJnJoR3m9NF8uNhyG+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498729"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498729"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:28 -0700
X-CSE-ConnectionGUID: //PnBGV4RhKehWlFiUvdcQ==
X-CSE-MsgGUID: cVrJxG/QTCScwW0RBSL68w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141759109"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:00:24 -0700
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
Subject: [PATCH v3 11/11] drm/xe/vrsr: Introduce a debugfs node named vrsr_capable
Date: Sat, 24 May 2025 00:31:55 +0530
Message-Id: <20250523190155.2623462-12-badal.nilawar@intel.com>
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

Add a debugfs node named vrsr_capable to check if the device
supports VRSR.

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index d83cd6ed3fa8..d969a8f6d430 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -226,6 +226,23 @@ static const struct file_operations atomic_svm_timeslice_ms_fops = {
 	.write = atomic_svm_timeslice_ms_set,
 };
 
+static ssize_t vrsr_capable_show(struct file *f, char __user *ubuf,
+				 size_t size, loff_t *pos)
+{
+	struct xe_device *xe = file_inode(f)->i_private;
+	char buf[32];
+	int len = 0;
+
+	len = scnprintf(buf, sizeof(buf), "%s\n", xe->d3cold.vrsr_capable ? "true" : "false");
+
+	return simple_read_from_buffer(ubuf, size, pos, buf, len);
+}
+
+static const struct file_operations vrsr_capable_fops = {
+	.owner = THIS_MODULE,
+	.read = vrsr_capable_show,
+};
+
 void xe_debugfs_register(struct xe_device *xe)
 {
 	struct ttm_device *bdev = &xe->ttm;
@@ -249,6 +266,9 @@ void xe_debugfs_register(struct xe_device *xe)
 	debugfs_create_file("atomic_svm_timeslice_ms", 0600, root, xe,
 			    &atomic_svm_timeslice_ms_fops);
 
+	debugfs_create_file("vrsr_capable", 0400, root, xe,
+			    &vrsr_capable_fops);
+
 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
 		man = ttm_manager_type(bdev, mem_type);
 
-- 
2.34.1


