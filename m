Return-Path: <linux-pci+bounces-39561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB5C163C4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65470404FF2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E234B34DB42;
	Tue, 28 Oct 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoaXzYUr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C934DB41;
	Tue, 28 Oct 2025 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673082; cv=none; b=HJmcotgaMRmDZTqM0DCzON4IKfwd+2cP7MvDT+C+BKbLS+qdLRK0Lq7Uv7w1N9ILQXxOPANcC8LTcQC0owR6BpWSYCHzIKoOBXXCNslPo2hDgNSVIeWHSBDkIIDfLG3wy232dz+ya20UhkIMXwgxnTgIWBj4uoYDiwAksHrDpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673082; c=relaxed/simple;
	bh=8HzYU02dn6gqkOKj2vIFpqRrMZ6pFIdvNMAeG0Ynh8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxnwGRE5ds3NLrEPvcG5w6ZXWLWmq/HOpVkd2dYTjqPmgglsjgXypVQWDyO1Xx4Trc6QPaCUzuzV0kv6BvtgQ+g5t8wB8xnJRG2iYuPAFEtBW6MA1Osd7Uv3PWO3sMv83cgAyr1QKYPmHIRQyp0D16qq+PA7ORt802cOC/dWVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoaXzYUr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761673081; x=1793209081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8HzYU02dn6gqkOKj2vIFpqRrMZ6pFIdvNMAeG0Ynh8Y=;
  b=BoaXzYUroAJ+NjqrwYhYHfvSHPcXfaN3x7LSmnxgsi7IVnvm3mx4To1v
   iA+nwhl4aTNcGDKmPQbmGQUpq8oHC+PVgYo7C3Af9K7S2tnG37SQmaji1
   nlNIgFKfEgY55JKzWOkWZCQE61IELp4pT4AzS66AYWiFG4PT8700KlY3V
   bfd3Xtuy40yluSO2a3/GP5DzKVuJVn2PxsqLjmShZZ5LVOzEPpafJV7oh
   BfXGe2lhT5TtvuQZTCCwLZjk+8t9WtTOtwIcq+WMksNIuckSsFPLE36d2
   VKRIevr6YPXr5qEWFU2Du3b7ib0hv9bHIVcU3ln5XjoWRyNrlrPTLst3x
   A==;
X-CSE-ConnectionGUID: P731OD2xRTy0yVAh2o1IHw==
X-CSE-MsgGUID: UhBzqCe9R5WRH4goMA+++w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62811942"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="62811942"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:50 -0700
X-CSE-ConnectionGUID: O7zkssxpThup/TW4+3yClA==
X-CSE-MsgGUID: oeHFK8iZSu+Rblv5L3kuqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185112401"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:43 -0700
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
Subject: [PATCH 8/9] drm/amdgpu: Remove driver side BAR release before resize
Date: Tue, 28 Oct 2025 19:35:50 +0200
Message-Id: <20251028173551.22578-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
References: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
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

Remove driver-side release of BARs from the amdgpu driver.

Also remove the driver initiated assignment as pci_resize_resource()
should try to assign as much as possible. If the driver side call
manages to get more required resources assigned in some scenario, such
a problem should be fixed inside pci_resize_resource() instead.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a899fb4de29..65474d365229 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1729,12 +1729,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	pci_write_config_word(adev->pdev, PCI_COMMAND,
 			      cmd & ~PCI_COMMAND_MEMORY);
 
-	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
+	/* Tear down doorbell as resizing will release BARs */
 	amdgpu_doorbell_fini(adev);
-	if (adev->asic_type >= CHIP_BONAIRE)
-		pci_release_resource(adev->pdev, 2);
-
-	pci_release_resource(adev->pdev, 0);
 
 	r = pci_resize_resource(adev->pdev, 0, rbar_size);
 	if (r == -ENOSPC)
@@ -1743,8 +1739,6 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	else if (r && r != -ENOTSUPP)
 		dev_err(adev->dev, "Problem resizing BAR0 (%d).", r);
 
-	pci_assign_unassigned_bus_resources(adev->pdev->bus);
-
 	/* When the doorbell or fb BAR isn't available we have no chance of
 	 * using the device.
 	 */
-- 
2.39.5


