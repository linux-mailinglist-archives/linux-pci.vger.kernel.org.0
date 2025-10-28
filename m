Return-Path: <linux-pci+bounces-39560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD00C163CD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44EB3B87DE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BB34575E;
	Tue, 28 Oct 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEDnLZpM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44914337107;
	Tue, 28 Oct 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673059; cv=none; b=gSBYPxxdc1S2EOpIGCq14vEFz/LL8aA6zwiwDa59TnwKhFt0ZDPFdPcbiHGYTZpxn5+o2yf/MhpJe4pPWRZdk9J98I08D87l/vLzbucZik4YI/lSdtqe2aep64wCookpZ6DnCxJwrDrnsH2GZ4aFqVEcHO0VxpevPJznXo3F748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673059; c=relaxed/simple;
	bh=p0wHURDhEqxjdHQHtDybrhCJVt2NJrZ5/+N6qg46xHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCnQJ/YiICACGnhaYFB66IAOtVAceq3QYmA92JVK78SDrbV4+qCCQAqJa6H8CIHSOKtyrQ6aPyfZcLdpBS8MRn2HhCA1BdmvCFyWoTeOV2EsARTaTKbXzr5nroOcpBch9U73sYCqgEYR5/EGyhHpUt69nn8PplOlPsLTl3Mo1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEDnLZpM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761673059; x=1793209059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0wHURDhEqxjdHQHtDybrhCJVt2NJrZ5/+N6qg46xHM=;
  b=jEDnLZpMAA9V7AKokdNYQuOS/qnD9RHMHjpKuiXtpkOJ50f6tuYNyr7w
   hsMk1tpiQsQogi9jJQ14k49AYtsdGywB5W+06lCVqIcZoV7M1qg8JuvRy
   WCKIAcHzxTFG91wS/5zcSjbc4iCqfK4Vc0/QrSn3DKrdE2NozTiY08oZ7
   RH3ZbBxK1y953HKeuGt5vfrbMPR1QwxzeW8JuMGcDEAMUSIn6wuo10+gV
   9kw+ptAc5LgPd/PvUdPKZ05+ggKUK8tCrq3Vmf/+sD3mXvvnEnWzqivWq
   WRC73TKwxRdRj2ut8ycOO0zMm1KVN5W1kK1m0y3Kqu62EvER6YMMYOtya
   w==;
X-CSE-ConnectionGUID: aBK9zKW0SIePgVoeQhuS6g==
X-CSE-MsgGUID: KwAG66ygS3SCKNDFZilzVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63485045"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63485045"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:38 -0700
X-CSE-ConnectionGUID: aXywd5SLRtOwizDbGtwfqQ==
X-CSE-MsgGUID: eG48uwFjQWGOxO2mxr2acw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185746898"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:30 -0700
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
Subject: [PATCH 7/9] drm/i915: Remove driver side BAR release before resize
Date: Tue, 28 Oct 2025 19:35:49 +0200
Message-Id: <20251028173551.22578-8-ilpo.jarvinen@linux.intel.com>
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

Remove driver-side release of BARs from the i915 driver.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_region_lmem.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
index 51bb27e10a4f..ca3de61451a3 100644
--- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
@@ -18,16 +18,6 @@
 #include "gt/intel_gt_regs.h"
 
 #ifdef CONFIG_64BIT
-static void _release_bars(struct pci_dev *pdev)
-{
-	int resno;
-
-	for (resno = PCI_STD_RESOURCES; resno < PCI_STD_RESOURCE_END; resno++) {
-		if (pci_resource_len(pdev, resno))
-			pci_release_resource(pdev, resno);
-	}
-}
-
 static void
 _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
 {
@@ -35,8 +25,6 @@ _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
 	int bar_size = pci_rebar_bytes_to_size(size);
 	int ret;
 
-	_release_bars(pdev);
-
 	ret = pci_resize_resource(pdev, resno, bar_size);
 	if (ret) {
 		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
-- 
2.39.5


