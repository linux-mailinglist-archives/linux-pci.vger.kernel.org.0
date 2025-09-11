Return-Path: <linux-pci+bounces-35875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 071C7B52AEE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DEE1C81CDA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0E2D3A9E;
	Thu, 11 Sep 2025 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWG+HmLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16B2D3723;
	Thu, 11 Sep 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577495; cv=none; b=cyTYAnTfvW5paLP6QCEsc6Obi9c/9G7v60AyPc0KyXqn09Ok7y8jVEx/XS8kmdTXx8UUhJHFOfFAlyXIzMVcK44dL2KmB+um1RhKH5lSCD+Ax1vsOb4GC5QQcgmuiT52Rno/odeb/C1kP+EXdR91M5AB8pIvp9SLJw7Xwpor4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577495; c=relaxed/simple;
	bh=6RYIEQkuOzl3A3InWzcMug/hfkfoXrpzul9p5LmOsSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCaDTHMqmhc3QITwnrXlFuk/L/AUjMsTP5HXnQTg8QksjR1YmOaI5PYXCsMMOszc4zeRXCOZTHOIQ9syKWeX9KBv8xb8jED8pZRf6mH9fMijwM/v5qThQrqje6msdHw0eoX26i5S0R+xjbT6Hcm6x/f9Eh/K7wIzrWuIDyrIQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWG+HmLl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757577494; x=1789113494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6RYIEQkuOzl3A3InWzcMug/hfkfoXrpzul9p5LmOsSg=;
  b=MWG+HmLl4A83guvrsntVPttJJo1FuJkfdAO9TLDAL2bskUBqGQ+aQhSP
   +9CG7QsV6ZDN40K9ul8Vk8+RtoZZA2xbAofO++flHP4tXXtZfkckY/Gac
   qWjL/rKy/D0Z4qK8dgvdzg8dxPxfGzuaGsAbFLySQI74A6BcxYFvbf2E5
   ZwyF/mPHwbwWTin5lv5MRmFl9pltvLQLYgfFN9V4QVMeNHImK2gyy5bd9
   GbJEpz8R3axmOBCo4SDoipdL40b9/pZYrWVj9QDGm3FuzFT6h3cHSegSK
   3Qi1W8KLzYKFjQqKXvqrKVcObKyg01imMDl0Damp6A2OpzIcczi/M2qPM
   g==;
X-CSE-ConnectionGUID: 84K2LCWiT+yFt7lExg/Qpg==
X-CSE-MsgGUID: 82fUquxBRGG1uAZpybE9Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70999386"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="70999386"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:57:51 -0700
X-CSE-ConnectionGUID: gRaHmoh2RmK5x3zOFXvN2w==
X-CSE-MsgGUID: f+tPr7AfRD+jyMtnjayPKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="173186319"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:57:44 -0700
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
Subject: [PATCH 07/11] drm/xe/vram: Use PCI rebar helpers in resize_vram_bar()
Date: Thu, 11 Sep 2025 10:56:01 +0300
Message-Id: <20250911075605.5277-8-ilpo.jarvinen@linux.intel.com>
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

PCI core provides pci_rebar_size_supported(), use it in
resize_vram_bar() to simplify code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_vram.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index e421a74fb87c..08a9abebfee7 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -21,8 +21,6 @@
 #include "xe_sriov.h"
 #include "xe_vram.h"
 
-#define BAR_SIZE_SHIFT 20
-
 static void
 _resize_bar(struct xe_device *xe, int resno, resource_size_t size)
 {
@@ -71,25 +69,22 @@ static void resize_vram_bar(struct xe_device *xe)
 
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


