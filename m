Return-Path: <linux-pci+bounces-35876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5788B52AF3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027E2A80CBD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169192D3723;
	Thu, 11 Sep 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3p3iFdV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAA2D5940;
	Thu, 11 Sep 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577499; cv=none; b=rwG28CJK7z0AnRNDM9wbxd9u4Dwknr/0TnzfN0a8Ngoa256tvkQ8Ff0gieT/DAhUWuJwwcp7yP2sDw8lscK4rmvgrtFHVGwub0ZIvLzTDVejUBYfH1OSfWyFkZXPAGAXMz/hYLbXpHPrZHHA7zKTieGoyRROKxDt4Te+NisMr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577499; c=relaxed/simple;
	bh=oXbmaS48fO9o/2YikXjGdRRz6a3wwA1geRn/x6qZ98k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlrTYZgmDmp7uKhhDORQsMg31Ug2BblTTVH4EEHkmoE1XOYXDyZYI6dFpXQIP6IYGFhQzI3DOp5JOjfIHRnAf15v4NmOn3xEiJr6mZQA4RZx8GF0fuImV4oyXoElNTcnPu+V5oHOZJOxiWbeqDHjAWCpnaqcO4e/su0Zq7oefGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3p3iFdV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757577498; x=1789113498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oXbmaS48fO9o/2YikXjGdRRz6a3wwA1geRn/x6qZ98k=;
  b=D3p3iFdV/WISyYJgLF24AFkJf/qJZ2uCxKtYtsBRCeG50dXK4jT2QcaU
   otTAawoocknnQAqosLH9O3LqKchMDzemNLckUDIz4rjfhlOO8x6IK0nNi
   95shxPkxJCY565cak5u0Gp2yzsElQdbllKScgQp0KkKkGZAa7Bwqvl6oy
   fAuyUyaYwmC10ERSAQxyZttBuMGa4OPeFHzAOyZzzVaTejSbjawDGsQd5
   zutpbxz+PmqIJkurG4OyOP49sYpP/vhSUUZF++ghV2Ch7HydSOZWKMfgX
   qgQVDfuNWldB5rGl340MIVBQEr3C2VRecwAJxxOBKrC4/hMHXLjhHwefH
   w==;
X-CSE-ConnectionGUID: H08rSi9STOW/yUNNRHdn8g==
X-CSE-MsgGUID: id7e2qgNQUCRt/xRffwEdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63728910"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63728910"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:58:17 -0700
X-CSE-ConnectionGUID: O3u/AQjKQdy10kNOvrGpzQ==
X-CSE-MsgGUID: nDzn6KzfTp+gnd+hYQglJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="174422511"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:58:09 -0700
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
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/11] drm/xe/vram: Use pci_rebar_get_max_size()
Date: Thu, 11 Sep 2025 10:56:03 +0300
Message-Id: <20250911075605.5277-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
References: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use pci_rebar_get_max_size() from PCI core in resize_vram_bar() to
simplify code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_vram.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index 08a9abebfee7..b063c072df1e 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -53,16 +53,11 @@ static void resize_vram_bar(struct xe_device *xe)
 	resource_size_t current_size;
 	resource_size_t rebar_size;
 	struct resource *root_res;
-	u32 bar_size_mask;
+	int max_size, i;
 	u32 pci_cmd;
-	int i;
 
 	/* gather some relevant info */
 	current_size = pci_resource_len(pdev, LMEM_BAR);
-	bar_size_mask = pci_rebar_get_possible_sizes(pdev, LMEM_BAR);
-
-	if (!bar_size_mask)
-		return;
 
 	if (force_vram_bar_size < 0)
 		return;
@@ -76,7 +71,8 @@ static void resize_vram_bar(struct xe_device *xe)
 			drm_info(&xe->drm,
 				 "Requested size: %lluMiB is not supported by rebar sizes: 0x%x. Leaving default: %lluMiB\n",
 				 (u64)pci_rebar_size_to_bytes(rebar_size) >> 20,
-				 bar_size_mask, (u64)current_size >> 20);
+				 pci_rebar_get_possible_sizes(pdev, LMEM_BAR),
+				 (u64)current_size >> 20);
 			return;
 		}
 
@@ -84,7 +80,10 @@ static void resize_vram_bar(struct xe_device *xe)
 		if (rebar_size == current_size)
 			return;
 	} else {
-		rebar_size = pci_rebar_size_to_bytes(__fls(bar_size_mask));
+		max_size = pci_rebar_get_max_size(pdev, LMEM_BAR);
+		if (max_size < 0)
+			return;
+		rebar_size = pci_rebar_size_to_bytes(max_size);
 
 		/* only resize if larger than current */
 		if (rebar_size <= current_size)
-- 
2.39.5


