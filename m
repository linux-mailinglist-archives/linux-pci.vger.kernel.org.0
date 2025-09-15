Return-Path: <linux-pci+bounces-36134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A435B5748B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A051A21D8C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB02F3C15;
	Mon, 15 Sep 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/7rwxIV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3042F3635;
	Mon, 15 Sep 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927796; cv=none; b=kZL6Ov5wYBVJjzo/VtcUh3ql7PbUledkbkiEdkO7U7U7K0OY1m9xxpkhaUW1j1/EsI1UBZf9vYZmz459PoM/lF659yTVBHjyHrW5gUIe2QDz1tY2hMzl6u4y4qFfTNL5VuKh/E5e8mMSchoFh11k/+SVdoSCgBb2CQTqLQIE84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927796; c=relaxed/simple;
	bh=hfZr4Pu+txZSdm11dML+ugv1o9AcchyGUheFrRE9JQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtAA0ay+hvSbB0MR1Br20GFSmLNR0hcQT2NW/3dwlfGK3idnc49vdTL2W/wUeRE1TpRBWl0UB1xQlypVbHtTtSKUOnu7Bx+kbSbJ0L1xKNSX0m3LYlFjJBYHl9cKGZuYU3nqgiTs0LOgbx0FsSAEh9RXqTakTfSV/SD8TloXk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/7rwxIV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757927794; x=1789463794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hfZr4Pu+txZSdm11dML+ugv1o9AcchyGUheFrRE9JQI=;
  b=Q/7rwxIVeKvoQr7RfOr92MFOWYEldCwfDjE3TGrUxLkfGF1vH48EdvRv
   hpaKaqERWKcjvW6VT1ofrcFJ77TVg04ASvd+RMcS1x/OaRhDk7y6jOLmO
   +KEXv4gsx05BJOMezQFHP4qpMq38KI0GTOKL8iAvxxKsdgsf6xOXPC2Zx
   U4trnVH281Up/Db0bcXQxPjgnVGHcBsANmJcaLLpUCjEluTzKi+vOOqXn
   /MOns1+bWhb+S5pfK0jiDcEq3lRTcre6a7Sv/NAXlx2owiLZ1bsF3QtBQ
   A/F0MNxn2ymVimt+4l9SQx2jqcKNP5BHDqXOf7DIaK7uxEiB34W8PBE59
   g==;
X-CSE-ConnectionGUID: ECtTUqPPTaq1X4H/znd02w==
X-CSE-MsgGUID: klpzva8ZQyi98rnaVuBPHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="70857594"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="70857594"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:16:30 -0700
X-CSE-ConnectionGUID: ggiUXmqWSJSnYWLjrJfVAw==
X-CSE-MsgGUID: fKhnZoS/RnyxtA+lMtysoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174392588"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:16:23 -0700
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
	?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 10/11] drm/amdgpu: Use pci_rebar_get_max_size()
Date: Mon, 15 Sep 2025 12:13:57 +0300
Message-Id: <20250915091358.9203-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use pci_rebar_get_max_size() from PCI core to simplify code in
amdgpu_device_resize_fb_bar().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 01d234cf8156..c4ab503fb5d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1670,9 +1670,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	int rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
 	struct pci_bus *root;
 	struct resource *res;
+	int max_size, r;
 	unsigned int i;
 	u16 cmd;
-	int r;
 
 	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
 		return 0;
@@ -1718,8 +1718,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
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


