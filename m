Return-Path: <linux-pci+bounces-22241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3EA42856
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3313BAEEB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34623263C72;
	Mon, 24 Feb 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZOQRzKz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC62627F2;
	Mon, 24 Feb 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415828; cv=none; b=fAKAUYZy/03Alm9bbKuUSIM0CzOTeoSgojTZB1KRYCXIy5+DYgF3kqKrYWt8GiVTzxTbB8Ahxo1Cfaic01DOQc4+J2dpq3kiFiEXn5FQKZEo0DPBtUbc7Lv/+SjSCWgi03/WmYEcm3mej0r7MkGA2eEnpjkaZuWRx6ynPg/GD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415828; c=relaxed/simple;
	bh=s1755bRkVQkvuVT5nc9PfQbKU5v1eRuaL7KrfAtQIpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bx3djOumfx8CVnxoC0xEG6T4xUQ0x51l/db6q7G4w14J7Y7LzuenfievvHEdbT/dODbRcIQb34JdS9iPq18x11Su3y9MDYsfV77JtJcba74fPdCRWRmi8dXbGTagR72q7PUpkOWykAKJbtqgRbLvj7jTh4C5OHKljHc1ysHiCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZOQRzKz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740415826; x=1771951826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1755bRkVQkvuVT5nc9PfQbKU5v1eRuaL7KrfAtQIpA=;
  b=fZOQRzKzNkngQYMI6v1DD+2uvafMorSqChiCd6g2KZNVBSDs3/mfdf2G
   avUM94KncVx7xrUH1EiX4MxS/8Ddap5s8EZCjUauzO0ESov39cEcXacw0
   1iRpRjHAUrmlox3YeViCsgA4vSmFZWJuX0y3FN2GwMZa5IjGRiy04k9s8
   Xy3X6KKFvd/n1djf/WPOTsP7/lewvyaaMk0tMk96Bxdaf41BUW6F2OsUo
   tEdQ9eE1Vv0gZb10fqULYkNFbJzLkjfPcma24JEY/CAsIpZrQyeknR5qE
   TAtzzlZWHp89+RMZeZVZUOpyqbPs5y1hs1oX2yJ/s3Yi7TyqEkIhwp+1Z
   g==;
X-CSE-ConnectionGUID: FJIeg5xcTVi8eakmUz0JcA==
X-CSE-MsgGUID: O7tJEg1lRm69pacKY0UO5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41063204"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41063204"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:26 -0800
X-CSE-ConnectionGUID: Zmo+KQ9NTXSKvIx70nocsg==
X-CSE-MsgGUID: YuB/u+3YT5GO05mVuqcGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121032404"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:23 -0800
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
	kam.nasim@intel.com,
	Anshuman Gupta <anshuman.gupta@intel.com>
Subject: [RFC 4/6] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Date: Mon, 24 Feb 2025 22:18:47 +0530
Message-Id: <20250224164849.3746751-5-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224164849.3746751-1-anshuman.gupta@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add xe_d3_state enum to add support for VRAM Self Refresh
d3cold state.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h | 5 +++--
 drivers/gpu/drm/xe/xe_pm.c           | 6 +++---
 drivers/gpu/drm/xe/xe_pm.h           | 6 ++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index da7946b75cd5..937461939ecc 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -19,6 +19,7 @@
 #include "xe_memirq_types.h"
 #include "xe_oa_types.h"
 #include "xe_platform_types.h"
+#include "xe_pm.h"
 #include "xe_pmu_types.h"
 #include "xe_pt_types.h"
 #include "xe_sriov_types.h"
@@ -488,8 +489,8 @@ struct xe_device {
 		/** @d3cold.capable: Indicates if root port is d3cold capable */
 		bool capable;
 
-		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
-		bool allowed;
+		/** @d3cold.allowed: Indicates d3cold target state */
+		enum xe_d3_state allowed;
 
 		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
 		bool vrsr_capable;
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 32583651988f..81e67b5693dc 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -859,7 +859,7 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
 	int i;
 
 	if (!xe->d3cold.capable) {
-		xe->d3cold.allowed = false;
+		xe->d3cold.allowed = XE_D3HOT;
 		return;
 	}
 
@@ -874,9 +874,9 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
 	mutex_lock(&xe->d3cold.lock);
 
 	if (total_vram_used_mb < xe->d3cold.vram_threshold)
-		xe->d3cold.allowed = true;
+		xe->d3cold.allowed = XE_D3COLD_OFF;
 	else
-		xe->d3cold.allowed = false;
+		xe->d3cold.allowed = XE_D3HOT;
 
 	mutex_unlock(&xe->d3cold.lock);
 }
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index c9f176912b46..b7b74757ce21 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -12,6 +12,12 @@
 
 struct xe_device;
 
+enum xe_d3_state {
+	XE_D3HOT = 0,
+	XE_D3COLD_OFF,
+	XE_D3COLD_VRSR,
+};
+
 int xe_pm_suspend(struct xe_device *xe);
 int xe_pm_resume(struct xe_device *xe);
 
-- 
2.34.1


