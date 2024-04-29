Return-Path: <linux-pci+bounces-6774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D4A8B55BB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE91F235F8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B439FE0;
	Mon, 29 Apr 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGn8u6PF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723439FFD;
	Mon, 29 Apr 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387671; cv=none; b=pDC6MB05oCOlvB2rkoNXi5OKCOM6qYFp4m2usf5pDzSellNF5aoGz+yp9h3l4gUt/vZsDUJhD3WIRxLdRsi+t/3oIuzSbbfpvBx5bPqTC1AFRum4AExfT+l2Ljz5VwmvwebfJ4DEEdw8soKjaKH5uvuEB3zPqppdLru5XWi9LsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387671; c=relaxed/simple;
	bh=6Mc4DmXEXO6Kz1kJ/fVcR7ZcfLPUG4RYhvrVnAwaq+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snZqe2ZMeW8Bcgiafr4HOiLmTGzKRmx2wzk4z3zTw4dOSusXyNOOSQvOKvcbmtebAoG6AJhQfIbMaXzlt3CdZ0yr85Vd1Lx56CdKbWvyWAn1+ForNJcTZ1sY8KMkQYwGuQ1h/xqczVZZ6DTj2XF7gdsMM0HBVaelNJRJuZDBMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGn8u6PF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387670; x=1745923670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Mc4DmXEXO6Kz1kJ/fVcR7ZcfLPUG4RYhvrVnAwaq+0=;
  b=nGn8u6PFD9V+x8+C+PTitC8kIEN5+owjLW5/bpEidY9ooB/TrgYAaMI/
   xYPLAsGiaHPjcBXrltJ4YwxwpV2HzMlzHRSUa3dUXfqyH1BVvIYNFVDKP
   hspiLdiynFC68rmOld2Gvp6GtAc3WGQj9YzKc418+R3Ma/Nw8ZE57p/RR
   J7VSKpZtyhvqx0M3JE1nZgtUsecCjkFE5PdfpbicesvbLwJVfhVgiFEJ1
   cCSsTY08sGC6Z8E8jvrylWAcP7UXjarVtEK6f3yURSoPpDGQF+J1sagkl
   G0cd/FiVfcK3j/s+HEZ2uPUz+K4mXyjKnu+SMSId/66vy2bEuFRb0RSQO
   w==;
X-CSE-ConnectionGUID: KW/h/wAWTKGMWsbNa4lgdw==
X-CSE-MsgGUID: IhjGo+7lSLeZx6JRMYwkzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10201841"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10201841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:49 -0700
X-CSE-ConnectionGUID: /nnKB6kaSHeZOlfWFHxV8w==
X-CSE-MsgGUID: k64qq1ZHTVWYmwqvHsqZzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26589567"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 07/10] PCI: Replace PCI_CONF1{,_EXT}_ADDRESS() with the new helpers
Date: Mon, 29 Apr 2024 13:46:30 +0300
Message-Id: <20240429104633.11060-8-ilpo.jarvinen@linux.intel.com>
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

Replace the old PCI_CONF1{,_EXT}_ADDRESS() helpers used to calculate
PCI Configuration Space Type 1 addresses with the new
pci_conf1{,_ext}_offset() helpers that are more generic and more widely
available.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-ftpci100.c | 6 ++----
 drivers/pci/controller/pci-ixp4xx.c   | 5 ++---
 drivers/pci/controller/pcie-mt7621.c  | 7 +++----
 drivers/pci/pci.h                     | 8 --------
 4 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index ffdeed25e961..a8d0217a0b94 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -182,8 +182,7 @@ static int faraday_raw_pci_read_config(struct faraday_pci *p, int bus_number,
 				       unsigned int fn, int config, int size,
 				       u32 *value)
 {
-	writel(PCI_CONF1_ADDRESS(bus_number, PCI_SLOT(fn),
-				 PCI_FUNC(fn), config),
+	writel(pci_conf1_addr(bus_number, fn, config, true),
 			p->base + FTPCI_CONFIG);
 
 	*value = readl(p->base + FTPCI_DATA);
@@ -214,8 +213,7 @@ static int faraday_raw_pci_write_config(struct faraday_pci *p, int bus_number,
 {
 	int ret = PCIBIOS_SUCCESSFUL;
 
-	writel(PCI_CONF1_ADDRESS(bus_number, PCI_SLOT(fn),
-				 PCI_FUNC(fn), config),
+	writel(pci_conf1_addr(bus_number, fn, config, true),
 			p->base + FTPCI_CONFIG);
 
 	switch (size) {
diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
index ec0125344ca1..fd52f4a3ef31 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -192,9 +192,8 @@ static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, int where)
 		       BIT(32 - PCI_SLOT(devfn));
 	} else {
 		/* type 1 */
-		return (PCI_CONF1_ADDRESS(bus_num, PCI_SLOT(devfn),
-					  PCI_FUNC(devfn), where) &
-			~PCI_CONF1_ENABLE) | PCI_CONF1_TRANSACTION;
+		return pci_conf1_addr(bus_num, devfn, where, false) |
+		       PCI_CONF1_TRANSACTION;
 	}
 }
 
diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 79e225edb42a..2b2d9828a910 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -127,8 +127,7 @@ static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
 					 unsigned int devfn, int where)
 {
 	struct mt7621_pcie *pcie = bus->sysdata;
-	u32 address = PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn),
-					    PCI_FUNC(devfn), where);
+	u32 address = pci_conf1_ext_addr(bus->number, devfn, where, true);
 
 	writel_relaxed(address, pcie->base + RALINK_PCI_CONFIG_ADDR);
 
@@ -143,7 +142,7 @@ static struct pci_ops mt7621_pcie_ops = {
 
 static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 reg)
 {
-	u32 address = PCI_CONF1_EXT_ADDRESS(0, dev, 0, reg);
+	u32 address = pci_conf1_ext_addr(0, PCI_DEVFN(dev, 0), reg, true);
 
 	pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
 	return pcie_read(pcie, RALINK_PCI_CONFIG_DATA);
@@ -152,7 +151,7 @@ static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 reg)
 static void write_config(struct mt7621_pcie *pcie, unsigned int dev,
 			 u32 reg, u32 val)
 {
-	u32 address = PCI_CONF1_EXT_ADDRESS(0, dev, 0, reg);
+	u32 address = pci_conf1_ext_addr(0, PCI_DEVFN(dev, 0), reg, true);
 
 	pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
 	pcie_write(pcie, val, RALINK_PCI_CONFIG_DATA);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cf0530a60105..fdf9624b0b12 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -833,12 +833,4 @@ struct pci_devres {
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
 
-#define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
-	(PCI_CONF1_ENABLE | \
-	 pci_conf1_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
-
-#define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
-	(PCI_CONF1_ENABLE | \
-	 pci_conf1_ext_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
-
 #endif /* DRIVERS_PCI_H */
-- 
2.39.2


