Return-Path: <linux-pci+bounces-38174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE1BDD4AE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7672B1923D00
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D22C21F7;
	Wed, 15 Oct 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEhRlmEW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE126E6F2;
	Wed, 15 Oct 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515392; cv=none; b=LXz9vOUpxa9IywQFl43sFo9BIif0dUVPPQH8AMB57ru/7P5BvVagWxq3e4KkkUwlFF/9DTtVPWr8ojmYIhIhUHphnIic4PyN4ywo5pZA6AzesqvelvziJdUWSKyDPpyOd+f4zN3vzxNrwvsRffcwBi6yaAWQNAdD7PluD1jZSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515392; c=relaxed/simple;
	bh=OAwLTgtExgWL+DQCTV9zplmSGb5GqoAMpIw5P8V3OiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDtOnNMRx5dqZOfuwYTQpY9RmIsk6kJYT5Ulc45QU1Vkg0QyUan7nCY1gM8M+r6wbc5pyBfG7b8+kyAKAcBfFO81P+tNxic1BO4Bj4aptxtW2heIjwY94j65hj2+Cr0oUyK+/ibHTMKG0jnFV+4nnqtdXUeiBsg5ZNTNOW/IKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEhRlmEW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515391; x=1792051391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OAwLTgtExgWL+DQCTV9zplmSGb5GqoAMpIw5P8V3OiY=;
  b=MEhRlmEWCAWYs29XUFZBM+Cg494chds80EeQ4oGU22I2/u3woTmIFFlX
   1rLq8zk+TP19X784hFiKzh16OvCV8NbX8GkwK7PfZEleX8MFG5ODjTKlO
   JLvCIZVOTHJ1fKaYf3AdItbR9yt94dnBxCQf5flvrt6rA0veFDDSHW/48
   6IgC8IE+3dWr2x97WAbpbyAD4T0FXYjwA6ydibF09zz0T/2IsKwtODvRW
   Z/zm4DDYEBauh9jU3OLtCGiTyX6768M7JyNnsoLEsBm0CqXynud1xPdLQ
   V2144s+IYBI28dYRtyPbGlPeypWPGUT+hCGIR8s34Padaye6Zhbfl3z99
   g==;
X-CSE-ConnectionGUID: i9BKQrf3ReC7crWZucheQg==
X-CSE-MsgGUID: NtYzOZ2xSbOcWO+Gh0S8IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891532"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891532"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:03:10 -0700
X-CSE-ConnectionGUID: zFNYUF6XQdKoB16t14sgcw==
X-CSE-MsgGUID: +kgS3+kET6eNg2smZH3UHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805559"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:03:06 -0700
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
Subject: [PATCH v5 11/12] drm/xe/pm/s2idle: Don't evict user BOs for D3hot and D3cold-VRSR state
Date: Wed, 15 Oct 2025 13:37:09 +0530
Message-Id: <20251015080710.1468409-12-badal.nilawar@intel.com>
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

In D3hot and D3cold-VRSR, VRAM remains active, so it is not necessary
to evict user BOs.

Cc: Matthew Auld <matthew.auld@intel.com>
Co-developed-by: Sk Anirban <sk.anirban@intel.com>
Signed-off-by: Sk Anirban <sk.anirban@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 84cd9e84f548..51ff9b90fbfd 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -169,7 +169,7 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
 
 static void xe_pm_suspend_prepare(struct xe_device *xe)
 {
-	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
+	if (pm_suspend_default_s2idle())
 		xe_pm_d3cold_target_state_toggle(xe);
 	else
 		xe->d3cold.target_state = XE_D3COLD_OFF;
@@ -191,8 +191,6 @@ int xe_pm_suspend(struct xe_device *xe)
 	xe_pm_block_begin_signalling();
 	trace_xe_pm_suspend(xe, __builtin_return_address(0));
 
-	xe_pm_suspend_prepare(xe);
-
 	err = xe_pxp_pm_suspend(xe->pxp);
 	if (err)
 		goto err;
@@ -543,8 +541,12 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 	int err = 0;
 
 	switch (action) {
-	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+		xe_pm_suspend_prepare(xe);
+		if (xe->d3cold.target_state != XE_D3COLD_OFF)
+			break;
+		fallthrough;
+	case PM_HIBERNATION_PREPARE:
 	{
 		struct xe_validation_ctx ctx;
 
@@ -569,8 +571,11 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 		xe_pm_block_end_signalling();
 		break;
 	}
-	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
+		if (xe->d3cold.target_state != XE_D3COLD_OFF)
+			break;
+		fallthrough;
+	case PM_POST_HIBERNATION:
 		complete_all(&xe->pm_block);
 		xe_pm_wake_rebind_workers(xe);
 		xe_bo_notifier_unprepare_all_pinned(xe);
-- 
2.34.1


