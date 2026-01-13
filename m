Return-Path: <linux-pci+bounces-44641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F865D1A51D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1319030B40D9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954930AAC9;
	Tue, 13 Jan 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3Y+Q8Ia"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BA2DC763;
	Tue, 13 Jan 2026 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321967; cv=none; b=JT0cWbQbhcLu/RMd9pT0nhT1tEXMsyNu0rURPFUIrWGElbSwarxIVVNcSaPLqr84JY9lxw+7idWsNOvWc59alSFFMl7gyJDGe2x0mSXOyHSkPAvcqXQCQmEaUFO87z8DG4HvobHZnUzXorPeOSKmYiu5hgjQa2KT2j2CANRZRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321967; c=relaxed/simple;
	bh=EhbOro/6pVIW02rKbQ479kU/sLmFKyjbCcftZJG0bsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqaIY2aydkCWp2MNjHuZRuSykwZ26k4tooyFUn3xpp7HqEfK0VwwvnveT50utzjcbI4l9T+ByDpgsbXJ4wEeBA+LP7RymSnJ8Q9qawU4QfDBIwNdhTxSn5FdwRbBsxJX7kl7D8y7oeC2gZKM8fWF2TUTus9vPCGEbWi/q53OFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3Y+Q8Ia; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321966; x=1799857966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhbOro/6pVIW02rKbQ479kU/sLmFKyjbCcftZJG0bsI=;
  b=e3Y+Q8IaglpsAlF/lyMfsDVDHSsqttFn7q4+JBiVXE2HqSTSyEDkxlCb
   nrEFd9dOESlTiDjiN+swT98DHtyjbmtMvVpvsp5Q9Pd20YlDwIn98IIC1
   nc8aGEWtFlHNGIM5M4NFyIrBL6YgoFu5WKk01ry2z9ZeBLAIfAVRy1ZaW
   WI0ZwB8XG7kY9uYIMAbs+LXBnkosW/RMk17wt1napTudqA5YHr1jgQmHQ
   dR0ZnPrzg8CnqsLW5W43m3CWYbI+Jk7pQKz3jfa4fZe7I0a9JS1CY0CIB
   tsffYu0OXg750++3AZf6GaFMlSuCHe0X7+YcViieGCG+0TB1bSlHvh2y9
   Q==;
X-CSE-ConnectionGUID: 2btQoOGmRt+gA97KJkgtOA==
X-CSE-MsgGUID: GP8KS/0BQx2BCp8sF3FpVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521091"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521091"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:46 -0800
X-CSE-ConnectionGUID: H1ToScFnTm+PLtXfZmyKaA==
X-CSE-MsgGUID: ye6fDcmEQ/mu7D5yR290rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060300"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:42 -0800
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
Subject: [PATCH v6 11/12] drm/xe/pm/s2idle: Don't evict user BOs D3cold-VRSR state
Date: Tue, 13 Jan 2026 22:12:12 +0530
Message-ID: <20260113164200.1151788-25-badal.nilawar@intel.com>
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

Since VRAM stays active in D3cold-VRSR, evicting user BOs is unnecessary.

Cc: Matthew Auld <matthew.auld@intel.com>
Co-developed-by: Sk Anirban <sk.anirban@intel.com>
Signed-off-by: Sk Anirban <sk.anirban@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
V1: Removed D3hot handling since, on discrete cards, we do not block
    D3cold during system suspend
---
 drivers/gpu/drm/xe/xe_pm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 1dd8e2c0f51e..3c7983afca9c 100644
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
@@ -192,8 +192,6 @@ int xe_pm_suspend(struct xe_device *xe, bool hibernation)
 	xe_pm_block_begin_signalling();
 	trace_xe_pm_suspend(xe, __builtin_return_address(0));
 
-	xe_pm_suspend_prepare(xe);
-
 	err = xe_pxp_pm_suspend(xe->pxp);
 	if (err)
 		goto err;
@@ -554,8 +552,12 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 	int err = 0;
 
 	switch (action) {
-	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+		xe_pm_suspend_prepare(xe);
+		if (xe->d3cold.target_state == XE_D3COLD_VRSR)
+			break;
+		fallthrough;
+	case PM_HIBERNATION_PREPARE:
 	{
 		struct xe_validation_ctx ctx;
 
@@ -580,8 +582,11 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 		xe_pm_block_end_signalling();
 		break;
 	}
-	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
+		if (xe->d3cold.target_state == XE_D3COLD_VRSR)
+			break;
+		fallthrough;
+	case PM_POST_HIBERNATION:
 		complete_all(&xe->pm_block);
 		xe_pm_wake_rebind_workers(xe);
 		xe_bo_notifier_unprepare_all_pinned(xe);
-- 
2.52.0


