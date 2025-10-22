Return-Path: <linux-pci+bounces-39020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB2DBFC369
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47FE0561180
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF1347FC4;
	Wed, 22 Oct 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJOtxwAE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD726ED33;
	Wed, 22 Oct 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140105; cv=none; b=IFGdEFj4fe7zHXAExMgyD2l46rPKciL75uxlcCA6HFDX5eqCrLKE6BOzEJIDLzrccQsrF9e6IxWB2lj3AhloQNC/R0vSoSmCXaSc4wSiQRoAKowd4C3usrqwbA0YDf76godvGoEl2PTXfSmilgW0yUrztSPAwJ+rUhe6Ewitii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140105; c=relaxed/simple;
	bh=aCwA/8AZ/Dd5HOdjKbrsatAkfmOoCAgd0CW7fUArQ8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cg1hhFakULsRWa8AF2x/enT9IXH1MtgRIo8moJjYXgkG/ifN8PY9f22m1xZ7qKx8jC8aqQASdPadlUozK/9Yl861kmSzX+51RqFvNPWXOQJXnOPlgkjFN2Vaq2hOT/6TbnRul+QGAm1f0FrKgG90A7xWg+XPVLTcKPkBECqdjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJOtxwAE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140104; x=1792676104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aCwA/8AZ/Dd5HOdjKbrsatAkfmOoCAgd0CW7fUArQ8g=;
  b=nJOtxwAE5RmuEQaqcAA/O9gYVYeX/El6jMC4XkAoc1JtBQOKOAfeEL4X
   3T7dw76PWpNcgzrejDrNJDTz55aDX7Ui2cvkZw0h97JkLGgpb/CzNfOPe
   hH77tRbP/j6NjiGU++2S1fH2wLzT0oH4QYSr5S2NdcP3lQkj4ZPbnxhPO
   ssOYuGLB2eh+FbdpW3TnJs9ZZbcZvjx+lADrlvTwnl7RPGu0Q9438WZTG
   umw4q0arEqjx3lXkgk+whv26DSVtbxRpQ7Tu4K7GIMvln7JresuKqtbgv
   qMo042QDJYy3pIHEiNb5MbkkGHKOtTmeLQXyKq5/SkLNI6s/xzsrJRHAj
   A==;
X-CSE-ConnectionGUID: 8gMtnUEaQXuR7VLQHrAkSQ==
X-CSE-MsgGUID: IHSARtlGRme+9i28YBccaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74633030"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="74633030"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:35:03 -0700
X-CSE-ConnectionGUID: bGduhRuoR0qJ2P5vHudHmQ==
X-CSE-MsgGUID: sE6i9QM9Q6C1+bj0uMZWxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="221065052"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:34:56 -0700
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
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 06/11] drm/i915/gt: Use pci_rebar_size_supported()
Date: Wed, 22 Oct 2025 16:33:26 +0300
Message-Id: <20251022133331.4357-7-ilpo.jarvinen@linux.intel.com>
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

PCI core provides pci_rebar_size_supported() that helps in checking if
a BAR Size is supported for the BAR or not. Use it in
i915_resize_lmem_bar() to simplify code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_region_lmem.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
index 51bb27e10a4f..69c65fc8a72d 100644
--- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
@@ -61,16 +61,12 @@ static void i915_resize_lmem_bar(struct drm_i915_private *i915, resource_size_t
 	current_size = roundup_pow_of_two(pci_resource_len(pdev, GEN12_LMEM_BAR));
 
 	if (i915->params.lmem_bar_size) {
-		u32 bar_sizes;
-
-		rebar_size = i915->params.lmem_bar_size *
-			(resource_size_t)SZ_1M;
-		bar_sizes = pci_rebar_get_possible_sizes(pdev, GEN12_LMEM_BAR);
-
+		rebar_size = i915->params.lmem_bar_size * (resource_size_t)SZ_1M;
 		if (rebar_size == current_size)
 			return;
 
-		if (!(bar_sizes & BIT(pci_rebar_bytes_to_size(rebar_size))) ||
+		if (!pci_rebar_size_supported(pdev, GEN12_LMEM_BAR,
+					      pci_rebar_bytes_to_size(rebar_size)) ||
 		    rebar_size >= roundup_pow_of_two(lmem_size)) {
 			rebar_size = lmem_size;
 
-- 
2.39.5


