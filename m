Return-Path: <linux-pci+bounces-42763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF4CAD822
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D84305654C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02BE2DF12F;
	Mon,  8 Dec 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfuvNvTV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED02DF14C;
	Mon,  8 Dec 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765205828; cv=none; b=Cgm13WuSkmAUcfrVNfZAJA19c4SCmYfeRW+YVHdg2bm3IAFVLs+6nJ6TklHWPeQVhQDuRXnt6JyOpcIFMRw0wTUOIT/pk9aCNtcTuUWmbRa6wEy6zxvh3a6eSkwtxs6ooAHKritgs1HBHWiVUHHf5J2f2Kd7C3bxiCY8HwZj1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765205828; c=relaxed/simple;
	bh=3asNEtGegEGQ06PL+zShSLnxGOlyzglhTNrW5ddlvHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WU9mrNypUxG2vgnw3g0xkGPpibrbeBu9nSpBRkSzKZIbpk/SGedNhaMhpamlBpVUGkyq7RBqXVB+xCEumOId7/cCTSWW1J/o0vwA06m3Lx6FhBVRsOoLubvEO7lPfWhQtTcHtQE+Td2hqYGoObfxJS6F9es2j5/+vyIvelqFC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfuvNvTV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765205826; x=1796741826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3asNEtGegEGQ06PL+zShSLnxGOlyzglhTNrW5ddlvHA=;
  b=jfuvNvTVwrEanJLi7BMhs8zQX++6mUATE3HK9UEAD5ItWrA9jVVl2Lro
   +tjTbMIRVMSnscB7EQMrsIJo84snuia2BhKB78M0F/rrpe1AQBkcCvCMu
   nTrFNcTdbsAasOu5OCqGGWiMmKK1nlFVJcPi3iUm1O6xAYOnBzRzZP2sc
   MPTAJKj+vgDBWNWtodpMaZMbFzamf0H4ybYRPgt9+j2dTFr+ka40GYxgY
   duC3HVVDs+ubp7tHZQLQ8rDTEpvVAb9CVFBKMXC7IxP6Ow38+TfxOkB8V
   8Zhc2D2izpx2McAyxNFmokRfDsIrxQza/IcqF475HcniN7V9c9/5JOmCa
   A==;
X-CSE-ConnectionGUID: EWqOfU9LQC+PBFtY71WsVw==
X-CSE-MsgGUID: QBJGC1EaTNG7BnUlDRr44Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67310479"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="67310479"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 06:57:04 -0800
X-CSE-ConnectionGUID: bGCW+LtRSR+ypOX2toH/oQ==
X-CSE-MsgGUID: YepLxwhbQIOshTvqHX0wUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="196718108"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 06:57:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/1] PCI: Use resource_set_range() that correctly sets ->end
Date: Mon,  8 Dec 2025 16:56:54 +0200
Message-Id: <20251208145654.5294-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__pci_read_base() sets resource start and end addresses when resource
is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
of representing 64-bit PCI addresses. This creates a problematic
resource that has non-zero flags but the start and end addresses do not
yield to resource size of 0 but 1.

Replace custom resource addresses setup with resource_set_range()
that correctly sets end address as -1 which results in resource_size()
returning 0.

For consistency, also use resource_set_range() in the other branch that
does size based resource setup.

Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/probe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 124d2d309c58..b8294a2f11f9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -287,8 +287,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
 		    && sz64 > 0x100000000ULL) {
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
-			res->start = 0;
-			res->end = 0;
+			resource_set_range(res, 0, 0);
 			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
 				res_name, (unsigned long long)sz64);
 			goto out;
@@ -297,8 +296,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8) && l) {
 			/* Above 32-bit boundary; try to reallocate */
 			res->flags |= IORESOURCE_UNSET;
-			res->start = 0;
-			res->end = sz64 - 1;
+			resource_set_range(res, 0, sz64);
 			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
 				 res_name, (unsigned long long)l64);
 			goto out;

base-commit: 43dfc13ca972988e620a6edb72956981b75ab6b0
-- 
2.39.5


