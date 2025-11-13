Return-Path: <linux-pci+bounces-41131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E62AC590AC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 155015458DD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6726E359FB1;
	Thu, 13 Nov 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qkhxo/9g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF92ECE82;
	Thu, 13 Nov 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051318; cv=none; b=OysRUUhZVf1gL21FVa8S+AeOFYodACQ4A1IZrKKIdRqiDofWMa1E3FPssU6liPBO+m6AZWzSaTTIF8AgnOmAFCxiSMJzsJwJG1YEFcJx7guzROOe5C90L+n3/tmFKIyFZ4ZeWoKEJsUD0WQmHTHyDY/xt4jT/sptuUpFmnx2AUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051318; c=relaxed/simple;
	bh=B26Ec9dWbSl4Gj6CIl71kjMp8WJ8/d82w0820A3xbuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuxwydoqASIBCteWRr1+yyLvRbdadsefKo5yg+ZFc4va9nmdPtB4IHYTbtAoXOIFqxOFeJgalVqVafXMli02Y5BLhlIK4tbfybOA3rQ7qvYExkbvgd1CSMH0FuHHedRrCkeEc3ayJn6lAEglVJs9nBu+WPv4SLHM/mIuK/HegPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qkhxo/9g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051317; x=1794587317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B26Ec9dWbSl4Gj6CIl71kjMp8WJ8/d82w0820A3xbuw=;
  b=Qkhxo/9gll17MGy4V9hU/2dgAd5Fm92MuU52yiC03YJfNFm2MOulzpjY
   F4Rl60vWqLvtzEJiGrwF9BMANTjShenkpXkVkpgHX8yCl1sK28ia7T+Hh
   EYZpagpkkmWTufs7R9SswpcX3friJaHYGx5/eVO/ic3xkrzEdc+vpXs9n
   E5BvFH4Tw+z2BUAZTB+uUj3Nqa3KArEtof+wTbUhxAaUL8x7jW0rIJEtA
   zonW14Z2WLo3KIWRvunpf+6T2w64cI3Spvd6IjEfI7V1zlE1SVCGpZ8aC
   girvdmDIo80CiwSSzQHb0Wcdtq7eJKHHjFyUjLpOY1PdcdahxpDAOkZ0D
   w==;
X-CSE-ConnectionGUID: t4EhkBy+RSSKcUVAlCF0kg==
X-CSE-MsgGUID: m5qmsFrITYyTH2msR7NBKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="69002451"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="69002451"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:28:36 -0800
X-CSE-ConnectionGUID: 061ungIyS+iTUZqUn4XgzA==
X-CSE-MsgGUID: Vz9zXO3SSmyNo9a5jYFbkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194699545"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:28:29 -0800
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
Subject: [PATCH v2 10/11] drm/amdgpu: Remove driver side BAR release before resize
Date: Thu, 13 Nov 2025 18:26:27 +0200
Message-Id: <20251113162628.5946-11-ilpo.jarvinen@linux.intel.com>
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
index 4e241836ae68..f11a255786d7 100644
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
 
 	r = pci_resize_resource(adev->pdev, 0, rbar_size, 1 << 5);
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


