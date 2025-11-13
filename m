Return-Path: <linux-pci+bounces-41157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8BAC59584
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52CF834EC0B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636C351FBA;
	Thu, 13 Nov 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X51RPD2T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E129B795;
	Thu, 13 Nov 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056988; cv=none; b=QocQ8V8xAIk/7hmg2PeoleOeyZ7PFTeG3FyMMwvwMYVCXKJFL8lZ2GynbP3oDYy09/7miVq0BkvJoFL43pJy7ypRhT7ZEgOwzzhDaW5ptbrb7PfN6eZca1Cw1YK7iUHg4taU5CC0L+wtjaurBakO+lSZuEMwb1uqM2ZbgT1RGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056988; c=relaxed/simple;
	bh=zzHUHDFiSrAkWDG3zV+mEV8zw5HhIV42xiqeOVVULv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1szQo3rTi00kV3jBVG6uHxthArwGMu5rRkB2ktuZXclC5HYO52DwOA2ShEAFhK74RW82KOCfF21ay06GF5DMdLNkM6kTLHUu5r9y+rGTOcurbawGVkI/4Ra59VTcZ7V0ua2bdI47HPVCeFtM1zMRQTI3rbV4hoMtknb1hSahsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X51RPD2T; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763056987; x=1794592987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zzHUHDFiSrAkWDG3zV+mEV8zw5HhIV42xiqeOVVULv8=;
  b=X51RPD2TKEPUFHDLYEIoJ/nPESYfuN25ko4fupWe7Pxs+l2nIFdWOYSz
   jZRs7SsfMqqw2tVht3pPuqmGIl/WOD/GjF1JqZJ7xTDVNli54hm1UIent
   unLbDgcRs6BLZN3FK1EydhOiqVC6P2mg5dy5ELodCKJYLKREUC8/qZszJ
   QfydIzFPjsfXfm2EwgpnTmXriLjoeP3iUYAlLq7oplvQS4UA/M4ksBaP4
   gMamCw/iD4biF9HYtyCjhUJ1cBh1YtXBvbVTu66+b9BRxa1eK+E0Dkz+N
   QlQ3DXo4cRLdUpLhZtYXCscj8OCHNStDJsuH6U+k/Lb/bEa6DT8PB7rPh
   A==;
X-CSE-ConnectionGUID: Uob8JtY1QUOhGJI0hkOfeg==
X-CSE-MsgGUID: QnTYiU7GSQyo590/MNzMCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76490899"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="76490899"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:03:07 -0800
X-CSE-ConnectionGUID: jfhU2e5sR4OutZlp++bzsg==
X-CSE-MsgGUID: OQItNN3zSxaXHybVHw/VwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189407998"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:02:59 -0800
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
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 09/11] drm/xe/vram: Use pci_rebar_get_max_size()
Date: Thu, 13 Nov 2025 20:00:51 +0200
Message-Id: <20251113180053.27944-10-ilpo.jarvinen@linux.intel.com>
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

Use pci_rebar_get_max_size() from PCI core in resize_vram_bar() to simplify
code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_vram.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index 57c224fa0b56..524469f8a4bd 100644
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


