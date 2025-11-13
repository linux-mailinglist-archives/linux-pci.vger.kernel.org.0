Return-Path: <linux-pci+bounces-41158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26893C597AD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 514F84FB400
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D8D30BF55;
	Thu, 13 Nov 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3C5BY2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792627B4F7;
	Thu, 13 Nov 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057001; cv=none; b=T1G1YLOkmbt2JUWEg6pEKJ6aiKMwdxOooXrK6+LkGqhHLInZ79scB//aCv2YAE36tR/o1t3ot4WLcZVFtcGbhKnQm4AS1J2l4It1I1cEEuqJG0lf7A3djmxXLl+ZwRz/fWNPqGc9YC2YnjwXPFApuKJ9ajuL+JzxnzZS0ooLy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057001; c=relaxed/simple;
	bh=e5pHv3WKNR67jU/OKNlgxz1wxiWJXKsANnUH51oNoN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJ6UKv9Va82gbEiUF6mLv8BAJcPXE1bdjDkw/o6z/X6lyGDTJgvIHv+E5JawjWW+mtyhHkZHikeoxxuAdkUvF/6CXbed3o7RreeN9aEJID2Le0APsASHViwTW/pmG+amFQjfDAwjz8Y7NJsHhHTYTCtYysxAFSLs2XbEajHjtt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3C5BY2B; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763057000; x=1794593000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e5pHv3WKNR67jU/OKNlgxz1wxiWJXKsANnUH51oNoN4=;
  b=n3C5BY2B9Nt0XJT2oOlh3vZfBJIxx4RVhvfZq182eHFXcsvPzj5L32Zl
   QOYJzLAlD+BHaP+9/rLioss6nRENkdDazsRliRXfHcUuKj56xKSuIrWZz
   pZnjiY0C80+ucmgjAGcwErVv4c57G21W86uyoIm5ibCho4M+zS+SYHRrR
   E8CY7zrd/woHLLphHxuczvFd10Bc07FK1iLQ11a70WFwUUzjt1J6Pgg5G
   3M/oMd/77+sE1FXWdmYQAxdM7AHcx/Uqbr8M7r+pAgn5FC36LxhARUh3m
   x6esLUI7GhitnI2rwdJruNue13W4nu6705xt45mFrp2NLShQaY3COP446
   w==;
X-CSE-ConnectionGUID: OYxCNlOcR8ukEx1EvxrEaQ==
X-CSE-MsgGUID: O9RgHI+LQZykqeH4O6MVwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65186389"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65186389"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:03:19 -0800
X-CSE-ConnectionGUID: vw5syRMES/e5N/FePsjwlQ==
X-CSE-MsgGUID: GX9mxbz3QqCr9ylcbbcFmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194001333"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:03:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 10/11] drm/amdgpu: Use pci_rebar_get_max_size()
Date: Thu, 13 Nov 2025 20:00:52 +0200
Message-Id: <20251113180053.27944-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
References: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use pci_rebar_get_max_size() to simplify amdgpu_device_resize_fb_bar().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f11a255786d7..da2b6158b65f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1673,9 +1673,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	int rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
 	struct pci_bus *root;
 	struct resource *res;
+	int max_size, r;
 	unsigned int i;
 	u16 cmd;
-	int r;
 
 	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
 		return 0;
@@ -1721,8 +1721,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 		return 0;
 
 	/* Limit the BAR size to what is available */
-	rbar_size = min(fls(pci_rebar_get_possible_sizes(adev->pdev, 0)) - 1,
-			rbar_size);
+	max_size = pci_rebar_get_max_size(adev->pdev, 0);
+	if (max_size < 0)
+		return 0;
+	rbar_size = min(max_size, rbar_size);
 
 	/* Disable memory decoding while we change the BAR addresses and size */
 	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
-- 
2.39.5


