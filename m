Return-Path: <linux-pci+bounces-41130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5EC590B0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75EA854544C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F5359F95;
	Thu, 13 Nov 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqwrCDYC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E122FABE7;
	Thu, 13 Nov 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051306; cv=none; b=ZZQCixshBaC3jKziZ5eF62cPVYsmzcs74rMeDU77WAueaS1/SW8csznS9QxnH+2/s4IA1/L2AFlihnbjZkUxnv2A3xyNijlHrFMQEIwAb6bjWRdpa+Zz0/Qr0CMldM4qfd/CNbv02kBBGwpRnVmAq1pDJ+x5e6tfDY8su3+B6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051306; c=relaxed/simple;
	bh=3gicyKIAp5+Tdg6fbzRkVNCgC4gW75kbXan2uC1VABk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soODX1oRbG144crw3Dn33iZq/MtoLSGV5w88yEK3VYYTA09ZCkg2acRGZp4tnuAEVgqAIY1OViPw0plALwodjuEPekd8vcqp0U705fjDk661q7rKbwnGCh6AoYyB6vQh+pIxtpsQGy8IZkXXvBEEpT7k8KgZGtnaiI6St8+dkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqwrCDYC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051304; x=1794587304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gicyKIAp5+Tdg6fbzRkVNCgC4gW75kbXan2uC1VABk=;
  b=OqwrCDYC3ygRHG2Yg/6xbE0U0S0d2B+grAEnKSMyKzhk6xAktqerUQMd
   wvXAt1sWjG90XA0hvvg1ES7ux+eKhfCxeA8EulGaqrcRU7Q4nEtCf/Veq
   GZo8mpLoBzKrf26h+5HepRc1tkUBmyflIqtu0XnYH53iIb5ciyLk/p5fU
   WkArLVOvGFtIDVyA0Lg1Xnjx3daUkb7saKw0xaap+up3IGwcntA4b6blk
   3uQlSUz4OT7ygCgYdO8EObfufnl35LmBS/29The29K77/r/ZNDIu9efnz
   GFelHJSD2U/VsLxicogQu+2razaNX4qLGD/U3pM23Y6NRib+SGHwF7GkI
   g==;
X-CSE-ConnectionGUID: IxO1p5N/SxiKXAPp4zJlXQ==
X-CSE-MsgGUID: eZaCGyfBSuC8wKi92Z+HoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="69002410"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="69002410"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:28:24 -0800
X-CSE-ConnectionGUID: C/EHdc1NRPKGwQO++diRyw==
X-CSE-MsgGUID: o9z4l7s6QOGbq2peue/4vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194699530"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:28:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 09/11] drm/i915: Remove driver side BAR release before resize
Date: Thu, 13 Nov 2025 18:26:26 +0200
Message-Id: <20251113162628.5946-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI core handles releasing device's resources and their rollback in
case of failure of a BAR resizing operation. Releasing resource prior
to calling pci_resize_resource() prevents PCI core from restoring the
BARs as they were.

Remove driver-side release of BARs from the i915 driver.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_region_lmem.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
index 7699e8fcf5ed..c37a0560ebe0 100644
--- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
@@ -18,16 +18,6 @@
 #include "gt/intel_gt_regs.h"
 
 #ifdef CONFIG_64BIT
-static void _release_bars(struct pci_dev *pdev)
-{
-	int resno;
-
-	for (resno = PCI_STD_RESOURCES; resno < PCI_STD_RESOURCE_END; resno++) {
-		if (pci_resource_len(pdev, resno))
-			pci_release_resource(pdev, resno);
-	}
-}
-
 static void
 _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
 {
@@ -35,8 +25,6 @@ _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
 	int bar_size = pci_rebar_bytes_to_size(size);
 	int ret;
 
-	_release_bars(pdev);
-
 	ret = pci_resize_resource(pdev, resno, bar_size, 0);
 	if (ret) {
 		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
-- 
2.39.5


