Return-Path: <linux-pci+bounces-13517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E29861DE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F331F2C9F1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661E14264A;
	Wed, 25 Sep 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHmrI2Lr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A23770D
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275538; cv=none; b=AcpoABNcyuEOfdH0jij9HIIEiV944UHii8VhgbK2yIHvq5GZZyQxe1WdkvWqnmp6F50hlKfaO0ISgqQtAAyg00zhOv5r8cpeecDaXTeqbsgbYCApBQBV4ut8QJg/iShJxx27jPF3r5dkVnl7lTRIdpFqhXC+g6V4/xT/W9LN3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275538; c=relaxed/simple;
	bh=1DnMFU1e1/0MLz85xEqNSfIRbU8roszrXvNJtr1XYtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJyV7bTVCt2DJ+niLhAmxoN8e0Kx0sow/RKr7uloj6gZyDzbfMVc5Js6ZKNcTAsPy71KMoA/agZ8FFZhpuKAVeZQgaxzH5rtH/Nx7PUVRI+r/AMGF/rz+E9EvixfSrPmNOmFzM8lC2Wy/YkQS8Dtoi+PaAf81bE4OYX7HCVNqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHmrI2Lr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727275538; x=1758811538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DnMFU1e1/0MLz85xEqNSfIRbU8roszrXvNJtr1XYtg=;
  b=fHmrI2LrMgqIaIAYZU+LIez7aJIxCbOlHn9rNrZzUNW/PeZx6HwilFH6
   1JtKHVZdliwxkZHc0R/ZVEppn+bcoXpaxxOE7oF2bKy4Szi+N/lxbbQlw
   EQBAnDdmCRz7K2g7UJDY9x1eevI2nUD95JgWiNZZxa4egSCNWh86mTmvj
   uxkfPvwrDnv1jMjQDkzwtbZ52lK31j9XhmDwshUGRB/f42n+d6x7AtDON
   OcEdhY8YhEJRnQiuzzoPK5fwSHAWaQpZJ2ibmR0HY3is8PpoVOG1gsrog
   j8F6DorNHLXjM4UOyqNXpCD1tN168Ck9vzbi+Jcsu+3hvUELGQBc8JKdp
   Q==;
X-CSE-ConnectionGUID: uvydQYv2QYOTa+pj3/jPLg==
X-CSE-MsgGUID: Cwqvk7W6RzSBu4ZGWXNamw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26470598"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26470598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 07:45:37 -0700
X-CSE-ConnectionGUID: QXCbu4C2R+uW/mhhhAbaCA==
X-CSE-MsgGUID: dhzemH1wRPGMPHN23LGYZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71941533"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 25 Sep 2024 07:45:34 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 25 Sep 2024 17:45:33 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/6] drm/i915/pm: Hoist pci_save_state()+pci_set_power_state() to the end of pm _late() hook
Date: Wed, 25 Sep 2024 17:45:22 +0300
Message-ID: <20240925144526.2482-3-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

driver/pci does the pci_save_state()+pci_set_power_state() from the
_noirq() pm hooks. Move our manual calls (needed for the hibernate+D3
workaround with buggy BIOSes) towards that same point. We currently
have no _noirq() hooks, so end of _late() hooks is the best we can
do right now.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 6dc0104a3e36..9d557ff8adf5 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1015,7 +1015,6 @@ static int i915_drm_suspend(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct intel_display *display = &dev_priv->display;
-	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
 	pci_power_t opregion_target_state;
 
 	disable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
@@ -1029,8 +1028,6 @@ static int i915_drm_suspend(struct drm_device *dev)
 		intel_display_driver_disable_user_access(dev_priv);
 	}
 
-	pci_save_state(pdev);
-
 	intel_display_driver_suspend(dev_priv);
 
 	intel_dp_mst_suspend(dev_priv);
@@ -1090,10 +1087,16 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
 		drm_err(&dev_priv->drm, "Suspend complete failed: %d\n", ret);
 		intel_power_domains_resume(dev_priv);
 
-		goto out;
+		goto fail;
 	}
 
+	enable_rpm_wakeref_asserts(rpm);
+
+	if (!dev_priv->uncore.user_forcewake_count)
+		intel_runtime_pm_driver_release(rpm);
+
 	pci_disable_device(pdev);
+
 	/*
 	 * During hibernation on some platforms the BIOS may try to access
 	 * the device even though it's already in D3 and hang the machine. So
@@ -1105,11 +1108,17 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
 	 * Lenovo Thinkpad X301, X61s, X60, T60, X41
 	 * Fujitsu FSC S7110
 	 * Acer Aspire 1830T
+	 *
+	 * pci_save_state() is needed to prevent driver/pci from
+	 * automagically putting the device into D3.
 	 */
+	pci_save_state(pdev);
 	if (!(hibernation && GRAPHICS_VER(dev_priv) < 6))
 		pci_set_power_state(pdev, PCI_D3hot);
 
-out:
+	return 0;
+
+fail:
 	enable_rpm_wakeref_asserts(rpm);
 	if (!dev_priv->uncore.user_forcewake_count)
 		intel_runtime_pm_driver_release(rpm);
-- 
2.44.2


