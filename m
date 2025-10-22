Return-Path: <linux-pci+bounces-39021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 030CCBFC378
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A1EE562F8B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773883191A1;
	Wed, 22 Oct 2025 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mu8b0Dzy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C1348864;
	Wed, 22 Oct 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140120; cv=none; b=rmp8rB8/A9YbEUSwFfkB1t4sKLWTLISQW6bXdxxmy64nPXY5c78UzNcP9KeRVtKQoX8uRdGMaYB60LZUgcYEuTDECnjAifeDEYp+5RX2lXk3cs55sMWjSMKhoGBL5+0dbkvfuknWbMrm67jmlfRxRz+246L2yx5fDGeYqZ/2iRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140120; c=relaxed/simple;
	bh=rvq8S7Tm5qcOrmVwTnQP2K04nFjvwe8824uK1q80uXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvPanpwDruXIWOKxcl79fmD4PbQDq7n/KciKt88b5AyyBffae7PaPYYSYENPy1XxgZkwucPfC6hxDOM4eWf9D2YJ23bZj1pDsNhQpJ6uuq19feJBOFw3ItUt5psa7vl3dREMnXmBj3fHxLO/fadS0LnxTjl8g9gUTWZtlFaP5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mu8b0Dzy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140119; x=1792676119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rvq8S7Tm5qcOrmVwTnQP2K04nFjvwe8824uK1q80uXo=;
  b=Mu8b0Dzysl5vGljtkEafvgj4ki2VbidHz//oIMktjdm4Bt6zmV0akyy4
   fGsPQENOVoNVmWkPO1a/Drm4GeElUF2XS/5nMD5PwTEufGNka6BX/oZ17
   ibSy9BKbhKgRjtYy/ZLU7oLShgWsoRecdJ3gNM0AOZMrH6gHI2lMGL0Jk
   2AC8uYiM1Jh1pnvD0p91xQp3Tw1P5P53XkrNE9SD48oxo6aPpc58W2WBS
   G2Mo/I6FmzT7UNW+a9/aKROs6bRyTKABkov9NFPBGVfHSPfLKaWboxGbH
   iFJeUQTVdl/U/ug5sIU+2sBfKxVFj7IU99zIha1jgNf2/dAZHBGlP/UGs
   A==;
X-CSE-ConnectionGUID: RtDlo1QlTrimM8T3aGW/Fw==
X-CSE-MsgGUID: Fve/zid6Q7OPNtgfmwvlOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63325338"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63325338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:35:18 -0700
X-CSE-ConnectionGUID: RPKSY7fORVOxMOWhTAvOgA==
X-CSE-MsgGUID: ZvV9E3lTTNCHcTSI6lf9VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="184275109"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:35:10 -0700
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
Subject: [PATCH v3 07/11] drm/xe/vram: Use PCI rebar helpers in resize_vram_bar()
Date: Wed, 22 Oct 2025 16:33:27 +0300
Message-Id: <20251022133331.4357-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
References: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI core provides pci_rebar_size_supported() and
pci_rebar_size_to_bytes(), use them in resize_vram_bar() to simplify
code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_vram.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index b44ebf50fedb..9ac053bb0b2e 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -24,8 +24,6 @@
 #include "xe_vram.h"
 #include "xe_vram_types.h"
 
-#define BAR_SIZE_SHIFT 20
-
 static void
 _resize_bar(struct xe_device *xe, int resno, resource_size_t size)
 {
@@ -74,25 +72,22 @@ static void resize_vram_bar(struct xe_device *xe)
 
 	/* set to a specific size? */
 	if (force_vram_bar_size) {
-		u32 bar_size_bit;
-
-		rebar_size = force_vram_bar_size * (resource_size_t)SZ_1M;
+		rebar_size = pci_rebar_bytes_to_size(force_vram_bar_size *
+						     (resource_size_t)SZ_1M);
 
-		bar_size_bit = bar_size_mask & BIT(pci_rebar_bytes_to_size(rebar_size));
-
-		if (!bar_size_bit) {
+		if (!pci_rebar_size_supported(pdev, LMEM_BAR, rebar_size)) {
 			drm_info(&xe->drm,
 				 "Requested size: %lluMiB is not supported by rebar sizes: 0x%x. Leaving default: %lluMiB\n",
-				 (u64)rebar_size >> 20, bar_size_mask, (u64)current_size >> 20);
+				 (u64)pci_rebar_size_to_bytes(rebar_size) >> 20,
+				 bar_size_mask, (u64)current_size >> 20);
 			return;
 		}
 
-		rebar_size = 1ULL << (__fls(bar_size_bit) + BAR_SIZE_SHIFT);
-
+		rebar_size = pci_rebar_size_to_bytes(rebar_size);
 		if (rebar_size == current_size)
 			return;
 	} else {
-		rebar_size = 1ULL << (__fls(bar_size_mask) + BAR_SIZE_SHIFT);
+		rebar_size = pci_rebar_size_to_bytes(__fls(bar_size_mask));
 
 		/* only resize if larger than current */
 		if (rebar_size <= current_size)
-- 
2.39.5


