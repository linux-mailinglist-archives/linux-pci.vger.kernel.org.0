Return-Path: <linux-pci+bounces-25085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB7A77F22
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB1B7A4359
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0AB20B80F;
	Tue,  1 Apr 2025 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kADkIWjd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63841EE019;
	Tue,  1 Apr 2025 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521811; cv=none; b=cLy596JQyKpfHEyGj1r5Y45qEiOS4Pb14S0nag0JJ6aBYp834pCwgmRtGL+QuiYTVifaivIlzg71wYMiZIUuaFkpNiNW12ZWoHd5F5rFwOwnpBcaQWukApyfJuJuBVIMB6pPAHsnM6IhpHlwLSSykol3CxixHxr3YpqJjPVQOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521811; c=relaxed/simple;
	bh=ZpTd5OkMjuoDC2SxjqRXjmiHErjVUtHrIzbrcRffy/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+73mJKlupso+chwP9hCPDQwM9q4SbecUeFPcp1FSM5QMTrnDnP2OS5Od7JZLYWEiBMxMuSADLYIcAMlCYv0lXX4ga6uQlNkv4ORlT1RMGtUbF7hFSZor9x6pzuq/XDb61fiDCSMmP4qkDj0C7Or+obbyid92HnnxICte6hgoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kADkIWjd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521810; x=1775057810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZpTd5OkMjuoDC2SxjqRXjmiHErjVUtHrIzbrcRffy/g=;
  b=kADkIWjdvU2mkBfbMukMjY3VJdeJjFizpmQCcmA5928ndUO4CLMsB9KY
   c9Tp1G0jm6cRv86HqY/osrXvnMkd4cxaN1IOAmcU4m0BNl/IgCaUin2dT
   x5AlD92VQ9Rs30BBSbZ3bzCZPfT5L/L0uNgm7hNrKfKcPICdCQe0GrJSF
   QdnHn/Q3hjTLslzyF/PXVs0/8EX6UdY3UIZ8bw4ZcITdgIIJwuXPCFMu8
   Nwhvt0+xKuRYAXczQGb1IHLzl3fSdue8XD4tNVqkBkpIsD0UBBXAQhNmx
   2YlJ5jExpGt2WXknOwligO5g51ZCS6gl9ofq6xbGSOWqUOyrRc8vD+Xhz
   w==;
X-CSE-ConnectionGUID: x5+nplU7TFKpX8ID8QhBvA==
X-CSE-MsgGUID: clCLX7oSSU6G2KVfekft4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324999"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324999"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:50 -0700
X-CSE-ConnectionGUID: K+jpO5U1RgmjmUwqZV+vhg==
X-CSE-MsgGUID: SBoJ7e8zQ1OlP/+wBFG1Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126411018"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:46 -0700
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
Subject: [PATCH 12/12] drm/xe/vrsr: Introduce a debugfs node named vrsr_capable
Date: Tue,  1 Apr 2025 21:02:25 +0530
Message-ID: <20250401153225.96379-13-anshuman.gupta@intel.com>
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

Add a debugfs node named vrsr_capable to check if the device supports
VRSR

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index d0503959a8ed..9f8d635c750c 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -191,6 +191,23 @@ static const struct file_operations wedged_mode_fops = {
 	.write = wedged_mode_set,
 };
 
+static ssize_t vrsr_capable_show(struct file *f, char __user *ubuf,
+				size_t size, loff_t *pos)
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
@@ -211,6 +228,9 @@ void xe_debugfs_register(struct xe_device *xe)
 	debugfs_create_file("wedged_mode", 0600, root, xe,
 			    &wedged_mode_fops);
 
+	debugfs_create_file("vrsr_capable", 0400, root, xe,
+			    &vrsr_capable_fops);
+
 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
 		man = ttm_manager_type(bdev, mem_type);
 
-- 
2.43.0


