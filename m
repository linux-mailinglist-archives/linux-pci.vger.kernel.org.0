Return-Path: <linux-pci+bounces-28607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DABAC7C8C
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F541BC2EE7
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B4226D1E;
	Thu, 29 May 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezoAk3sX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3C347B4;
	Thu, 29 May 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517327; cv=none; b=tkvPftsgb0SCGuDMS02DcSGQEKOm9rMY2oXR+5mXZ6S330YM2G25jS1GzQdTgcspZfsx/ZG1oxcLE11ijUScvMM52c2o59f+67mE4h9BGMBfUlNjgLzNzuwi7Xivxj1DWxdLCy7WZdxQAhjS0brLhpi02QZFibwoxyFOu4vB/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517327; c=relaxed/simple;
	bh=j0RX+hYzyhMgc0XGcBiN0az+uJ5tRmncGyuo6+y7pf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptdt1Qb6NY0Hs6M6wU/nHd2t4Kmq9IkZ03jBDZD6nXOcvjk67jWLnu/Ms102/sg7LsPeZlz3KVg/r9/0iTzy47kV3I7epFZFvi70+LuX4tmLnHcGkeq+nh8krS5kCXRwakJouhpCbY5U7SHUz2DDM0CaVpvbzb6z+dRmhCaq5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezoAk3sX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517326; x=1780053326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0RX+hYzyhMgc0XGcBiN0az+uJ5tRmncGyuo6+y7pf0=;
  b=ezoAk3sXAncSVwl3wYM+zkYmI0AaI4GorLrp5PMTRMtvbeYMv6cKF5+I
   cC2iCGHfDtUmb7/HwpMR3chmOe/HJl8bt6d558W76IN+4wZ/om/HovuyF
   3y0udPmqItfy5IS0TwgJb9hRknywcqTyLex2C2LDvBSTvzwMJdDVMn5Q1
   7EXZdkkkIIZ2yWZtKTB1qZxoP1FgDTRfXbXaKAuO3CIP4/PIoNJOMQ2bD
   Y4V+OGlBKMfpQHz3IkI8XPOM9pSJVWOt8n3altGsdcsR0akf6cI7tu8u5
   nJwh+/U+ttBrx41CyNaYv5M2PywOOZ6Oh3BVVJYhh9MXRqVUOomimGcfj
   A==;
X-CSE-ConnectionGUID: epbf1rHeRzm0zrx+bBqBFg==
X-CSE-MsgGUID: Ab1EtAXJSyqm6Hl46EnxqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68123205"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="68123205"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:26 -0700
X-CSE-ConnectionGUID: VMCMRwHRSgWM+cr3nZGDXA==
X-CSE-MsgGUID: Xeb4XZU9RIyzkw+VwsG9Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="143510606"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:15:22 -0700
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
Subject: [PATCH v4 11/11] drm/xe/vrsr: Introduce a debugfs node named vrsr_capable
Date: Thu, 29 May 2025 16:46:54 +0530
Message-Id: <20250529111654.3140766-12-badal.nilawar@intel.com>
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


