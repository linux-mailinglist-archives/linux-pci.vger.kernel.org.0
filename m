Return-Path: <linux-pci+bounces-36131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6ACB57474
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D7E173CDC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061F2F2914;
	Mon, 15 Sep 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBpVBP5L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B43221DA5;
	Mon, 15 Sep 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927749; cv=none; b=gaBLE0QPbaJYyi5N5XE4E/rpbX+cP+IjmyG3+JQD3etTYzUarm8/nkuPoILNsQB7hSVhk7iWJVizRzLbqSt+92xEOZNMxcSdl11Ao+8DP3bbsdC3+Q6OFVYmETV8+7e/wwaD+WiXRFOWcuL7wmlZsFWFn0p3GKa1133/SdidHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927749; c=relaxed/simple;
	bh=MCrmdy109Fbjud3+MYKK2EMTUs8mzp+zO0nHpuscGPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xbk0vecwpOll1jo1wAG1RVn9r4x9+dL+JEH+zUSo9FNDgBxV6UbatL8W9pWlQD4N2QB91TI2JGERWlwRp7O6i8zfPlkzZvg5U/vtkIJ7ITRYnUFLCadPf4dHm97aEOGppSsdNO1Z3ySi2ghMMB6sXLTXerrhGgHcAmW7FvVcD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBpVBP5L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757927747; x=1789463747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MCrmdy109Fbjud3+MYKK2EMTUs8mzp+zO0nHpuscGPU=;
  b=kBpVBP5LTLAmvbvpKUWb2JhtlQq3W/k43poU/z7reC0Oun/KEmR6vU33
   0MjxzG8HjfHC+1otDH8vwALGycdfqbXfj4OS2hzr67CMEpMaeELmUBW1Z
   cwv348tXJMebk4CS+3LryjsfQaOETnqzG9srl9/AfJAdzrYeI4Fr8g1A1
   jt2f8knvpgnwFo/ui7GgIGrj/mSX5piRjCjo3CfuSOwZ3RyQy/qpzNA11
   e0PxTYg1CVioXKjwdWwm7OWVx3n0YV365k0By1KosHmZVxWLqvLAZz/se
   dkCeRlBtN18QWZHXZpoUc31HdJlcocQFsRBaIsx40DfgG0h5Iqge32+Kz
   w==;
X-CSE-ConnectionGUID: iw/drrR4TgWy4Nun8jhBhw==
X-CSE-MsgGUID: lHRpe/wsS26HZLsrs9/TTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59401307"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59401307"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:15:47 -0700
X-CSE-ConnectionGUID: fbKaiQoqQ/ewcz/3tZM/eQ==
X-CSE-MsgGUID: l1+Y/EZ6SkiOBkQ7kJ31Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="175364034"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:15:39 -0700
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
Subject: [PATCH v2 07/11] drm/xe/vram: Use PCI rebar helpers in resize_vram_bar()
Date: Mon, 15 Sep 2025 12:13:54 +0300
Message-Id: <20250915091358.9203-8-ilpo.jarvinen@linux.intel.com>
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

PCI core provides pci_rebar_size_supported() and
pci_rebar_size_to_bytes(), use them in resize_vram_bar() to simplify
code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/xe/xe_vram.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index 0b7417bb0a47..d4fbd7f74255 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -22,8 +22,6 @@
 #include "xe_vram.h"
 #include "xe_vram_types.h"
 
-#define BAR_SIZE_SHIFT 20
-
 static void
 _resize_bar(struct xe_device *xe, int resno, resource_size_t size)
 {
@@ -72,25 +70,22 @@ static void resize_vram_bar(struct xe_device *xe)
 
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


