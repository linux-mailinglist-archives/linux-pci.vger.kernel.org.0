Return-Path: <linux-pci+bounces-39025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F162BFC438
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C957F661022
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AD346E7C;
	Wed, 22 Oct 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXsQxwWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB21347FCD;
	Wed, 22 Oct 2025 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140172; cv=none; b=hmrfX0M8PYKUZRt1s7VEiEZjAn++gB6bHaL/ynzV/HL/p8oSnUGZq1Lns83WrGvltiE77mBkcKiDQ1IdDyv6pe4hz9ECsezJihuJshUDbR+4LX1ZNFVMLqlPp8qpl2LJylFqp+vjQ29EvbsVIjrc+7IZTq+uZlfeP1Pxd+E5ZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140172; c=relaxed/simple;
	bh=vgdrsWGvy0swoIbcD1t6cJesDB5Ul+gmQHIizIpLf3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxmgwyFDDKpgEme+XuH+x9ElqzE2cqZnxb/VH37wLHTceuMSw0WZGBOM/5wddrteNWCRF2zCvbCahUjjcLKMj6WEPZJTO3jzThyp8CorT5gK7Q/PZmV8HCi7XJgaUDn0SR19OIAeVfQTqx1i4D8REBRNgT7xIaJQKvv9NFl9jVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXsQxwWa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140171; x=1792676171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vgdrsWGvy0swoIbcD1t6cJesDB5Ul+gmQHIizIpLf3U=;
  b=MXsQxwWa1UA3s8IygxddKIsnxuzUEUzoNX+rhwAAy9M08bl/ZcmMRJY4
   +m0p4bZNGRLekfHCVnX02QUVYsL1JohosJmARWN0JwQlhh5yDzpB+oRX2
   PgcFK7usDp9Jj7Eu/9jOxjHDTw4B9OFURqgpnvR/sVo58KdrKZYFIypqV
   yPLPHviz+/5mgMqv06/+EuqWYY+MvGlMe3mjjq3uKk3HgBmBSRPpm0B/t
   wRp/+YfxmHOijZsEiOi1WkHYOPvo60EAFNUIrZZH7aMOX3vl6lCN6QRq1
   l/6QLogMpszY1vzEIoX9X8UgkoDznSSuIY7MC69e4pXA9K+xQjlWH37qJ
   A==;
X-CSE-ConnectionGUID: d4AD3028TfaTTM3nlKfJhw==
X-CSE-MsgGUID: PMXtevUgQfqSGqqIaDB6eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62317507"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="62317507"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:36:10 -0700
X-CSE-ConnectionGUID: 93A0HGFKS5SF/61i/IYhjw==
X-CSE-MsgGUID: hqWZieMqT7S1LMIUGJ5wuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="189152907"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:36:02 -0700
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
Subject: [PATCH v3 11/11] PCI: Convert BAR sizes bitmasks to u64
Date: Wed, 22 Oct 2025 16:33:31 +0300
Message-Id: <20251022133331.4357-12-ilpo.jarvinen@linux.intel.com>
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
index 55232dfe2cd8..f18232668810 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -72,7 +72,7 @@ static void resize_vram_bar(struct xe_device *xe)
 
 		if (!pci_rebar_size_supported(pdev, LMEM_BAR, rebar_size)) {
 			drm_info(&xe->drm,
-				 "Requested size: %lluMiB is not supported by rebar sizes: 0x%x. Leaving default: %lluMiB\n",
+				 "Requested size: %lluMiB is not supported by rebar sizes: 0x%llx. Leaving default: %lluMiB\n",
 				 (u64)pci_rebar_size_to_bytes(rebar_size) >> 20,
 				 pci_rebar_get_possible_sizes(pdev, LMEM_BAR),
 				 (u64)current_size >> 20);
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 02f4e9cd3fbe..c09f7caa49a4 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1375,7 +1375,7 @@ EXPORT_SYMBOL_GPL(pci_iov_vf_bar_set_size);
 u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs)
 {
 	u64 vf_len = pci_resource_len(dev, resno);
-	u32 sizes;
+	u64 sizes;
 
 	if (!num_vfs)
 		return 0;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index af74cf02bb90..cb19983182b5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1586,7 +1586,7 @@ static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 	pci_config_pm_runtime_get(pdev);
 
 	ret = sysfs_emit(buf, "%016llx\n",
-			 (u64)pci_rebar_get_possible_sizes(pdev, n));
+			 pci_rebar_get_possible_sizes(pdev, n));
 
 	pci_config_pm_runtime_put(pdev);
 
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 1c30beb80f85..1488769071ed 100644
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
index 61dcf5ff7df6..63d98b2a3e06 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1423,7 +1423,7 @@ int pci_release_resource(struct pci_dev *dev, int resno);
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


