Return-Path: <linux-pci+bounces-38175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6BCBDD4B9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AEC1923B6B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A5513957E;
	Wed, 15 Oct 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG8tNjc4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AD2D060C;
	Wed, 15 Oct 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515396; cv=none; b=f1JSvZeQJOI/5FVB3y8I4L9pisIfs4L09Tx10FdyW6NEEmhi38RoVMJi23viwMKhSfkmd6R4ad6Ez4C3m5noHBSzs+lB+HVMy3fWFN2+UdZ4BYbe5vuriQabGpD/GGfV7xe4s8yyugLGt/RNQLqemgXcFaL0K+RhfeHoTR6Mzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515396; c=relaxed/simple;
	bh=hL6Oj0457W1ccYkzRwwH6dIwpIvldkAXzRJyQpPfUc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fd97QqyWmS16tWwPmqxkspLs6gEMcqjCXhrs2yf0QyZxSTDB5bpRkddTGW2QDPi7uIOBzI2t9l21WGqipLRJRcllWGjZqZp6+00yVKRYWCk7LfihXppSNhJHHm0XOUBvPKiY52JCLkzkpIqpzEbzg/1b2WaL7+s4772yuIZ1pFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fG8tNjc4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515395; x=1792051395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hL6Oj0457W1ccYkzRwwH6dIwpIvldkAXzRJyQpPfUc4=;
  b=fG8tNjc418BpxYSJ2qNy7nOEIzFNYgSyRgMSPVu++nx8MOeJhqK6okYh
   rY8ol7AoqhC9hICiU+4gKe9M5zHiEYNNMzfjhpgZRQdKwq1+NKmynille
   c2TUBDtGtDZz//KvRPbjM6LFBLc319HmJH9Ufq6eE/1gnH+Fz3DF2To8t
   cZUL8bg4VNFYLqDhCmpuaR9JwtrbKahUG+pVMF/PSRrZtsTD3ex54iqT3
   VJjEVm7Hd4uEZIwf9yJgRJHcGQf7gJjCBt6RDvTzmGXHzIUKXvkaa45aY
   lutRvhPoSDpN3TUXTRzmiPqmqxNmVbP8Z+FSCr8JeKft6+h3lGqTgMfxG
   w==;
X-CSE-ConnectionGUID: ZWiqaQ2FQTWRJuG/dzta9g==
X-CSE-MsgGUID: Dqh2LsuWTgerXelWiZEUdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891543"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891543"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:03:15 -0700
X-CSE-ConnectionGUID: C8rnhy7SQFqSxfjI4ZhzAw==
X-CSE-MsgGUID: bIBj/XW1R8aHi/Vad3RNqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805570"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:03:10 -0700
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
Subject: [PATCH v5 12/12] drm/xe/vrsr: Introduce a debugfs node named vrsr_capable
Date: Wed, 15 Oct 2025 13:37:10 +0530
Message-Id: <20251015080710.1468409-13-badal.nilawar@intel.com>
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

Add a debugfs node named vrsr_capable to check if the device
supports VRSR.

V2: Use debugfs_create_bool for vrsr_capable node (Karthik)

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 1c3c9557a9bd..11d1942c196d 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -402,6 +402,9 @@ void xe_debugfs_register(struct xe_device *xe)
 	debugfs_create_file("disable_late_binding", 0600, root, xe,
 			    &disable_late_binding_fops);
 
+	debugfs_create_bool("vrsr_capable", 0400, root,
+			    &xe->d3cold.vrsr_capable);
+
 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
 		man = ttm_manager_type(bdev, mem_type);
 
-- 
2.34.1


