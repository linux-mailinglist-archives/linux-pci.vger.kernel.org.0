Return-Path: <linux-pci+bounces-13521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB529862DA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C8DB2B301
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70C41448E4;
	Wed, 25 Sep 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuUQVAla"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C9143890
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275552; cv=none; b=L5Cd+sSfu1HXx7mfwnCzvW0qqrngUNQUPEV/XsWTKksEhKxLjlHu5pY+yJDciy5YVhKq9Xe6JBoIGDvQtOBU0fYEKzwxh8GWC9DFjiqIKVndnFiTNrhizMLpx59az2EmzOJYcgharTsfflRfQEhd3LkJa/WjylPjQa/U5SWpH+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275552; c=relaxed/simple;
	bh=QJ3Ia74trw6e9yYEHquXCksV/8nYF89J6fDR+nXnoMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMSpsNjuQ0jzdj40lub1ATIbg9SO8LAREncPA2Le9tjwxfmIIpS2yKituFIMLUSDkVa7cW+t6JRJgz3D/Q+tIktUnOuSwYibdGdJp2jMNrqalGqP5+jBCRahNOs8vdH3rydzNsVwhAZuRaIbKvECeVmyrGmrHbgNgnQj+V33H9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuUQVAla; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727275552; x=1758811552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJ3Ia74trw6e9yYEHquXCksV/8nYF89J6fDR+nXnoMA=;
  b=IuUQVAlaV0BCeRpdRVu4nY3NoUPEXwsPHH+bwII+r2SqheaEerk7tPiQ
   hW2lp2mRTErzpUnGCStIQvAOjJUIR+8fHqEfD3YpMi3k5WDmha7yimLWC
   qkvcxcb29aZVh9dD1GpYjYM+7ZdoxHih84LzPXNzm4G6cRs2syaJZnLlh
   ab+lLSgtJD5p0lHzrbntuAkOGW7y+2s2iCaZRmyeAeOeWXnRx6zsxiO1f
   //bGSN9CyUQErRJYnvV3DgYR11fcUKfjb2EKvPDDxwNjnuECRUlVaasXo
   x+U+Oh7lTdLzOt1KwEAHAQzIzWnxCCzo0QuHG7WD+Dh6KuZLmbaRh7Jns
   Q==;
X-CSE-ConnectionGUID: Wksk/wK1SuKKzsT8zUPCDQ==
X-CSE-MsgGUID: l+2iVpF+Smix5AA2Jci2vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26470677"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26470677"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 07:45:51 -0700
X-CSE-ConnectionGUID: 1S1T/O/4ScSwwg1OZYtJjQ==
X-CSE-MsgGUID: sD11GR1LQRKVZKq3DnI9vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71941659"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 25 Sep 2024 07:45:48 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 25 Sep 2024 17:45:47 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 6/6] drm/i915/pm: Use pci_dev->skip_bus_pm for hibernate vs. D3 workaround
Date: Wed, 25 Sep 2024 17:45:26 +0300
Message-ID: <20240925144526.2482-7-ville.syrjala@linux.intel.com>
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

On some older laptops we have to leave the device in D0
during hibernation, or else the BIOS just hangs and never
finishes the hibernation.

Currently we are achieving that by skipping the
pci_set_power_state(D3). However we also need to call
pci_save_state() ahead of time, or else
pci_pm_suspend_noirq() will do the pci_set_power_state(D3)
anyway.

This is all rather ugly, and might cause us to deviate from
standard pci pm behaviour in unknown ways since we always
call pci_save_state() for any kind of suspend operation.

Stop calling pci_save_state()+pci_set_power_state() entirely
(apart from the switcheroo paths) and instead set
pci_dev->skip_bus_pm=true to prevent the D3 during hibernation
on old machines. Apart from that we'll just let the normal
pci pm code take care of everything for us.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index c3e7225ea1ba..05948d00a874 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1123,13 +1123,9 @@ static int i915_drm_suspend_noirq(struct drm_device *dev, bool hibernation)
 	 * Lenovo Thinkpad X301, X61s, X60, T60, X41
 	 * Fujitsu FSC S7110
 	 * Acer Aspire 1830T
-	 *
-	 * pci_save_state() is needed to prevent driver/pci from
-	 * automagically putting the device into D3.
 	 */
-	pci_save_state(pdev);
-	if (!(hibernation && GRAPHICS_VER(dev_priv) < 6))
-		pci_set_power_state(pdev, PCI_D3hot);
+	if (hibernation && GRAPHICS_VER(dev_priv) < 6)
+		pdev->skip_bus_pm = true;
 
 	return 0;
 }
@@ -1137,6 +1133,7 @@ static int i915_drm_suspend_noirq(struct drm_device *dev, bool hibernation)
 int i915_driver_suspend_switcheroo(struct drm_i915_private *i915,
 				   pm_message_t state)
 {
+	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	int error;
 
 	if (drm_WARN_ON_ONCE(&i915->drm, state.event != PM_EVENT_SUSPEND &&
@@ -1158,6 +1155,9 @@ int i915_driver_suspend_switcheroo(struct drm_i915_private *i915,
 	if (error)
 		return error;
 
+	pci_save_state(pdev);
+	pci_set_power_state(pdev, PCI_D3hot);
+
 	return 0;
 }
 
-- 
2.44.2


