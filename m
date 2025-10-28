Return-Path: <linux-pci+bounces-39559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A2C163AF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D703A403FED
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0634AB0D;
	Tue, 28 Oct 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXMLsNi9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A934575E;
	Tue, 28 Oct 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673047; cv=none; b=S0cC40onh22DXY6i2QUieyUIfl3Xp+rGtdrP/JP5qcD2rJeCUhlRdBtFP/awMRE058CTKsoGb3f+kTeY8FWD8VWKbaSE+zKIPheKZMFi8GEbG4JbX05Qww+ZcuUBDVcKcER9N3m9tiArk6J76n/MgMgAzZJkqGkSJt7UmgNIwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673047; c=relaxed/simple;
	bh=aCyNNcynk6Iwh3upBHjwChHEBH25NCgzbc0Xsbk5ieI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liVa9lgBWOeA34Q3ByA3PNDxPFqHZngYrxVHV5D60vUfk0myhs3ITW8LVTQKa5hoEGfAUr33O6v4y7CUdTlx4ejmwjgbU/NP/GB/SzaCH001W5Cyu7tGp4PGjEfuJc38abWIScPyWUU41kuaNeKGFwKlPi4j8wxErH9xHDk+UgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXMLsNi9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761673046; x=1793209046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aCyNNcynk6Iwh3upBHjwChHEBH25NCgzbc0Xsbk5ieI=;
  b=CXMLsNi9Ub0XFSMSly0oJI2kbfsYLXHa+kAmW9kSADYdWgQPbX/Z5cNR
   RHXcycZNXwEi/bvFr81kGQn/fRrbZkr9sbUkYQUeP3SQiQEA3bPeFvYFz
   bDDG7F6GRrJ5B8wCajOEzIqXA8l8STbMYI6QEO6yO6b9JmLVujTXSRA4E
   JeRiD/3EZSo+68071TdCyxZkJgKmHobBdxVYN7hUNqGR7iOmyusic1KrQ
   ACo79ejdnQMy0Nesb0qQZLGHhlSHFGkMpLPtuIR84PDSfrLZD1W+u/TKl
   RKrhgLwgngb7RsKM1bPar4nCHTa2n3V0C8t/CUHM1zYk7rE55z6PaaGZq
   w==;
X-CSE-ConnectionGUID: E2wW+/1hSaigSxwA8I76Gw==
X-CSE-MsgGUID: GjGvcz4xQya+FwpaJeyhoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74457705"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="74457705"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:25 -0700
X-CSE-ConnectionGUID: +HEFfINgTs2XP0zut8S6cg==
X-CSE-MsgGUID: CKP/G/LHRrCWhnASdtrLTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185879228"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:18 -0700
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
Subject: [PATCH 6/9] drm/xe: Remove driver side BAR release before resize
Date: Tue, 28 Oct 2025 19:35:48 +0200
Message-Id: <20251028173551.22578-7-ilpo.jarvinen@linux.intel.com>
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

Remove driver-side release of BARs from the xe driver.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_vram.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index b44ebf50fedb..929412f0d131 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -33,9 +33,6 @@ _resize_bar(struct xe_device *xe, int resno, resource_size_t size)
 	int bar_size = pci_rebar_bytes_to_size(size);
 	int ret;
 
-	if (pci_resource_len(pdev, resno))
-		pci_release_resource(pdev, resno);
-
 	ret = pci_resize_resource(pdev, resno, bar_size);
 	if (ret) {
 		drm_info(&xe->drm, "Failed to resize BAR%d to %dM (%pe). Consider enabling 'Resizable BAR' support in your BIOS\n",
-- 
2.39.5


