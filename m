Return-Path: <linux-pci+bounces-41233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A22C5C978
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 11:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447CB3BC792
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30775313277;
	Fri, 14 Nov 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqhQP6UX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F23128C0;
	Fri, 14 Nov 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116268; cv=none; b=QVrH/J2vWzklgT8di7gXTZFAPK1UOnmVEMZ4aJIMWvB1cN0Uzu3qg79NGmvdyailxm0qGSCdj5sGYU1qjvVKahtEIbBf2CP83BG2Ox5DwPo3LHe8wFheRiCQrqA92M9Ns6jMPHDf01OcwbpYOlzKeBHKYlIks0eQPJ8rHYa6lS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116268; c=relaxed/simple;
	bh=4H+gkE1nhzILPkm76jIHz8K1t3KUC9ctV4oeJAaqBDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XubqHh6lBu7Muh5dzd5w5fMQedqrtHw4hSbqLOJePKD5iPnqkQsaJJpBVHfmygVPGIj/mQAbj+uq5MIrs4TyXG8Jw+vQmGx0gbcmZElVJy5m29LmJM8WvsQGPlT/GEJVunGwhKgzvIYb4tYPY9wRkyZlLIFqk95Gek1z4BJ9Fm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqhQP6UX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763116266; x=1794652266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4H+gkE1nhzILPkm76jIHz8K1t3KUC9ctV4oeJAaqBDA=;
  b=TqhQP6UXeNWPnJxCPCog51n/nSygYUgM8QEHtJHGFt3aEEGYg0fSICHZ
   i6/ZlkZJEqA0rpYvrAzZ4NDB000xGkMC4yYMZslwmg0PicIIwggwHTKAj
   bFRkD/AWp8vLI8rVgFMHhmq/r9yBkzZuK0BS7v2e5HjnLVA1eeD9mwz+3
   WY+N8NXRYXr6btWUmAovXlNNrN38tiegOvhfL1TYx7evLRZrcagPbIxQ9
   r9JEz9J4p5FyMaQjyRptLCI8bH2VK434vbzPnyZVuZWF5tRZlKCE8cQpe
   oB7PqSXakNohoKNqFAx1acSNIPBrkLgTjW8Ow1OQMLXrAoJGbAEfP3tmB
   w==;
X-CSE-ConnectionGUID: MoM6vQTATEW+rdIAVgSuuw==
X-CSE-MsgGUID: Kon7nMDYSiWeYxnFtukGLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76670211"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="76670211"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 02:31:04 -0800
X-CSE-ConnectionGUID: eBJRYcq2Sr6a7pU+o5mKXQ==
X-CSE-MsgGUID: OeaTK7j+SCKPYKFtdtMwLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="213155445"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.31])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 02:31:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI (& drm/amdgpu): BAR to be excluded depends on HW generation
Date: Fri, 14 Nov 2025 12:30:53 +0200
Message-Id: <20251114103053.13778-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Depending on HW generation, BAR that needs to be excluded from
pci_resize_resource() is either 2 or 5.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

This change should be be folded into the commit 73cd7ee85e78 ("PCI: Fix
restoring BARs on BAR resize rollback path") in the pci/resource branch.

Also the changelog should be changed: "(BAR 5)" -> "(BAR 2 or 5)".

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4e241836ae68..bf0bc38e1c47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1736,7 +1736,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_release_resource(adev->pdev, 0);
 
-	r = pci_resize_resource(adev->pdev, 0, rbar_size, 1 << 5);
+	r = pci_resize_resource(adev->pdev, 0, rbar_size,
+				(adev->asic_type >= CHIP_BONAIRE) ? 1 << 5
+								  : 1 << 2);
 	if (r == -ENOSPC)
 		dev_info(adev->dev,
 			 "Not enough PCI address space for a large BAR.");

base-commit: 73cd7ee85e788bc2541bfce2500e3587cf79f081
-- 
2.39.5


