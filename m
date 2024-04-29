Return-Path: <linux-pci+bounces-6775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370398B55BF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9CD1F2361D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECFC3D996;
	Mon, 29 Apr 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXaHI2s9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2BB3D969;
	Mon, 29 Apr 2024 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387680; cv=none; b=J3ho+RsXulMJfA4+a3SBB1K3JerHubQ8iA+xQnBHTezYEQboQyv4rUcgyot8h/o8/vjDTEzHaaQKK0mIkXxnGlE0B8lYi5HFnLC1G/h3AuP5gaVrsIb2dw95MT8t958KabDIKXQbF7yD4/mUdxy3cnKQT0V8FuYi8feNaSjkdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387680; c=relaxed/simple;
	bh=/qjKS1tRau5PVYvMBMsW64xOEOfBMtAi8Dq49OisY+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URuXMUvJb4txMaZNMu2OrN+W+QNf6L5TnZKtbWRk3up/4EJt9rw+BuywDtTeUNjbLN4bFGAm4UlNq6Ne5qIs8V1sP8cOVrDvIWi7nTMjDK9AS8x9nIc4LvIidhXOmxAj63DiGKUTcSC0f1GVeWV+IrylnX1R8yIjDqPcjyBBJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXaHI2s9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387680; x=1745923680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qjKS1tRau5PVYvMBMsW64xOEOfBMtAi8Dq49OisY+E=;
  b=MXaHI2s9lYzybNZ7VGtsMyyYt/BDulr8BVJDgNv9e64eWfR2Qbfi1dU6
   BElXezv0o/+18x9+fT1/c5lyq/RtoK1wK/ngRXzAVQgMCnx4R1BC4bMbp
   H6OhVx2QDyqBvb1AJcNtzIe+RWfJydco/FRdLGTT7TN+m9Y/kqLnmoV+j
   PN580tjiQf5pEtS/9ICIoLvwAFtyG+EvcLxtGBMIhpuy+ZnR+6u/h4RJ1
   0ZXyLhIm6vx1egCQ6zqDEFlsg9A2lz3Dv4flbgu21/S2qW1f7vGii3dNL
   mEYtO/uzVXFwH7btuzNtybQrwO4tO1FXWZAq6T54PpaN2xEbQzspUzYjE
   g==;
X-CSE-ConnectionGUID: ojziekXaTg+l5iaGVWE7+Q==
X-CSE-MsgGUID: JwXF3WkRTRW3cxLzoIOXDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10201861"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10201861"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:59 -0700
X-CSE-ConnectionGUID: 1wCkMPVTRN2RWdOSG3Sqqg==
X-CSE-MsgGUID: d8wqhGNfSNSRJnAXcewYnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26589582"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 08/10] PCI: tegra: Use generic PCI Conf Type 1 helper
Date: Mon, 29 Apr 2024 13:46:31 +0300
Message-Id: <20240429104633.11060-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert tegra to use the pci_conf1_ext_addr() helper from PCI core to
calculate PCI Configuration Space address for Type 1 access.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Note: where mask is changed from 0xff -> 0xfc by this change.
---
 drivers/pci/controller/pci-tegra.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 038d974a318e..a86e88c6b87a 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -415,13 +415,6 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
  * address (access to which generates correct config transaction) falls in
  * this 4 KiB region.
  */
-static unsigned int tegra_pcie_conf_offset(u8 bus, unsigned int devfn,
-					   unsigned int where)
-{
-	return ((where & 0xf00) << 16) | (bus << 16) | (PCI_SLOT(devfn) << 11) |
-	       (PCI_FUNC(devfn) << 8) | (where & 0xff);
-}
-
 static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 					unsigned int devfn,
 					int where)
@@ -440,10 +433,9 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 			}
 		}
 	} else {
-		unsigned int offset;
-		u32 base;
+		u32 base, offset;
 
-		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
+		offset = pci_conf1_ext_addr(bus->number, devfn, where, false);
 
 		/* move 4 KiB window to offset within the FPCI region */
 		base = 0xfe100000 + ((offset & ~(SZ_4K - 1)) >> 8);
-- 
2.39.2


