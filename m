Return-Path: <linux-pci+bounces-36135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D493B5747B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF4BA4E18E9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B742F39BD;
	Mon, 15 Sep 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyfOA+Xj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71DC2F28F5;
	Mon, 15 Sep 2025 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927810; cv=none; b=FeuqD3ZIR4OJfd2FWthq3e5mfDyWp2+PjZtVie8u+JpR4jlkeLlg3zCtYKUAc0biitYjXjc7s0xr6zpMlThk/mQjF7uP933N+kyLqzIlbze+NeLylrbataToPYz54jxrZGBsiX42DlMFMEKWGqwLN0zmiyegQ+ubcEQn1BLsLKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927810; c=relaxed/simple;
	bh=CMC8x2eBSJ4UoaxkrrTOqREVcL7ID4H/ORR4uPkIaKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1vUzoClay/mO0f8KwZQQx8sg0sBGnkoTR4/Rayf4axhlEEGYHe4AerTFlj2H+KPAqEHEFmzLN+1YGGGM9bbawsyBBDZ2x8GNKjIICzbK3EqphtF/GTTjJ0Cswv3VkKjd4E/0wyuD6o1SIn6VAWdn6ToLANlWMpZ282moAcZZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyfOA+Xj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757927809; x=1789463809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMC8x2eBSJ4UoaxkrrTOqREVcL7ID4H/ORR4uPkIaKs=;
  b=CyfOA+XjOn13Yt7j46HsQ3zJaYKN+vJlOG6tz982cBxJoC+GFqnyiSM5
   BBO7kcgPQCbB9lAvW6c5UX4pb6DyoT7LYQi7JcizpvwLM+I4dk/Kzl5M+
   XFGH35JnhGBlONnuu7pax03QTL/B52uRZv95JUa4ddoe89gKfaGfQjtai
   tQ2K9rmf2Md5UoOOmSgD/4MHofoWmZSO4H/oodc/xn8r4YyHmBy/PfOVf
   jtwie4XRzhpDN0KhK1AfjNlASIKs7vqPe/L2V1Fb/5Cny55K2X/CsTLF5
   cgD4M8dV62WgYF3AwKSwxNPLiE8qx1tjBSqxsDI508junTHPTtIFKZmd5
   g==;
X-CSE-ConnectionGUID: Ym82EHa8R86ojPSayzQPGw==
X-CSE-MsgGUID: tD1C3uIFRD2hT5vKKgSOSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="70857648"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="70857648"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:16:48 -0700
X-CSE-ConnectionGUID: 0w9WvEPQRPa+8YXnCTITGQ==
X-CSE-MsgGUID: SJZwvFJSQ4O4aV07xwZEpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174392724"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:16:39 -0700
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
Subject: [PATCH v2 11/11] PCI: Convert BAR sizes bitmasks to u64
Date: Mon, 15 Sep 2025 12:13:58 +0300
Message-Id: <20250915091358.9203-12-ilpo.jarvinen@linux.intel.com>
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

PCIe r6.2 section 7.8.6 defines resizable BAR sizes beyond the
currently supported maximum of 128TB which will require more than u32
to store the entire bitmask.

Convert Resizable BAR related functions to use u64 bitmask for BAR
sizes to make the typing more future-proof.

The support for the larger BAR sizes themselves is not added at this
point.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/xe/xe_vram.c | 2 +-
 drivers/pci/iov.c            | 2 +-
 drivers/pci/pci-sysfs.c      | 2 +-
 drivers/pci/rebar.c          | 4 ++--
 include/linux/pci.h          | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index ca02744fb369..22b998727eb2 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -70,7 +70,7 @@ static void resize_vram_bar(struct xe_device *xe)
 
 		if (!pci_rebar_size_supported(pdev, LMEM_BAR, rebar_size)) {
 			drm_info(&xe->drm,
-				 "Requested size: %lluMiB is not supported by rebar sizes: 0x%x. Leaving default: %lluMiB\n",
+				 "Requested size: %lluMiB is not supported by rebar sizes: 0x%llx. Leaving default: %lluMiB\n",
 				 (u64)pci_rebar_size_to_bytes(rebar_size) >> 20,
 				 pci_rebar_get_possible_sizes(pdev, LMEM_BAR),
 				 (u64)current_size >> 20);
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 51844a9176a0..d2741c4f3315 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1370,7 +1370,7 @@ EXPORT_SYMBOL_GPL(pci_iov_vf_bar_set_size);
 u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs)
 {
 	u64 vf_len = pci_resource_len(dev, resno);
-	u32 sizes;
+	u64 sizes;
 
 	if (!num_vfs)
 		return 0;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5eea14c1f7f5..b6920114d538 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1544,7 +1544,7 @@ static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 	pci_config_pm_runtime_get(pdev);
 
 	ret = sysfs_emit(buf, "%016llx\n",
-			 (u64)pci_rebar_get_possible_sizes(pdev, n));
+			 pci_rebar_get_possible_sizes(pdev, n));
 
 	pci_config_pm_runtime_put(pdev);
 
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 27185892ada4..ea8620e4bc18 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -105,7 +105,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
  * Return: A bitmask of possible sizes (bit 0=1MB, bit 31=128TB), or %0 if
  *	   BAR isn't resizable.
  */
-u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
+u64 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 {
 	int pos;
 	u32 cap;
@@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(pci_rebar_size_supported);
  */
 int pci_rebar_get_max_size(struct pci_dev *pdev, int bar)
 {
-	u32 sizes;
+	u64 sizes;
 
 	sizes = pci_rebar_get_possible_sizes(pdev, bar);
 	if (!sizes)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a4236aafad24..bb10c7eb49e2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1422,7 +1422,7 @@ void pci_release_resource(struct pci_dev *dev, int resno);
 /* Resizable BAR related routines */
 int pci_rebar_bytes_to_size(u64 bytes);
 resource_size_t pci_rebar_size_to_bytes(int size);
-u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
+u64 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size);
 int pci_rebar_get_max_size(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
-- 
2.39.5


