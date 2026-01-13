Return-Path: <linux-pci+bounces-44642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92AD1A526
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FF63097C06
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872B30AAD8;
	Tue, 13 Jan 2026 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTVJCXIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833130ACF6;
	Tue, 13 Jan 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321971; cv=none; b=tz7g9PM61yQYtO3cckCgpTO8ocvH10o9EScCkvhtaPCuYHGMeJ8n+2gxU/PAfqh68rRQZ080HaQDSZWcLF5n9VTtYj0YVxtUdBG7F9zCPwzb19UI3VpAYyn5mM8jfaVkLywU8TEB28T0zAb4zHPovU/CYAf0bAISev46MndoHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321971; c=relaxed/simple;
	bh=tdyFxb8ShtT8cW27+J4Wc2g1kLnSW6VDCnFWjBdsxlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSHNSZmyyH0yhyiGimkfLSe1tpVjBpezpVFbGy52CjLTdP25NeKp3vHv4f76zEAUGDlxc4wbI/Ii6TuhAHAX8TlV9uwfGlAkPTyA2WZEb1JFjLOiGQCpTaVo6jPuYVmuM2EiAIE003PEc6pAaYZ8Ojuz98oLH4IAQF/8LiagfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTVJCXIq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321970; x=1799857970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdyFxb8ShtT8cW27+J4Wc2g1kLnSW6VDCnFWjBdsxlw=;
  b=hTVJCXIqg3Jq77s5416tfXUC46bwQi3RtoHRn5CkqsYYk9sOqP9ACr98
   tvfAdTI0clnayu3QvMrwrKiuAZVa7X9nNKznRg4eLKqHp7shW9pyyb2Nk
   cieUZR4npdb7TktptE/jt9LkLX9c/Rs/Npn+HqvVWsAuOkwifOtvZ7zVk
   mcFHQK/vvMNLNvzcBadlX1wIAsSst1QB4x4i0WAL0ufgWjPfpjPEjbYli
   r/oSJEdNz+Vv3qctj4NuLLjkHg6d23w4Ffi32XfeGkZ+kPTKqQwlS+vZe
   eKXDPvPum9hAIeTh9szKQ5+1tMCZZHFpgj0bE8kJQ3YXIU3CIKvg5CXnj
   Q==;
X-CSE-ConnectionGUID: oFBz6AGcRFGuMc+csBMIoA==
X-CSE-MsgGUID: lWVhYuioRX+7yHirOVVLGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521101"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521101"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:50 -0800
X-CSE-ConnectionGUID: +HigFG2vRNS2Y02pQyDCaA==
X-CSE-MsgGUID: yigGqjmvSB+uDEiv6q2DDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060372"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:46 -0800
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
Subject: [PATCH v6 12/12] drm/xe/vrsr: Introduce a debugfs node named vrsr_capable
Date: Tue, 13 Jan 2026 22:12:13 +0530
Message-ID: <20260113164200.1151788-26-badal.nilawar@intel.com>
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

Add a debugfs node named vrsr_capable to check if the device
supports VRSR.

V2: Use debugfs_create_bool for vrsr_capable node (Karthik)

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 844cfafe1ec7..60b78d3f91da 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -550,6 +550,8 @@ void xe_debugfs_register(struct xe_device *xe)
 	debugfs_create_file("disable_late_binding", 0600, root, xe,
 			    &disable_late_binding_fops);
 
+	debugfs_create_bool("vrsr_capable", 0400, root,
+			    &xe->d3cold.vrsr_capable);
 	/*
 	 * Don't expose page reclaim configuration file if not supported by the
 	 * hardware initially.
-- 
2.52.0


