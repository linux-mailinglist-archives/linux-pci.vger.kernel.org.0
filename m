Return-Path: <linux-pci+bounces-8537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96964902175
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EDCB26619
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E64B7F48A;
	Mon, 10 Jun 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uBF55iLR"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75B7F7C2;
	Mon, 10 Jun 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021975; cv=none; b=uIJ8SeP8G+y3DfmKKeilY0A3NwiMbBcr9qbc5NGzSgyCnwn7xkwFfiHihYnhcTt4pUmPCdYvkmdW+NBN0T+fB7tMSxptpCLjmHNr+RJek10k/2dfP+RSM0tCcIzLnj1VVYnFBs18JUQ4imXvnebFitRltOdbR0rDX/Doqfwu+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021975; c=relaxed/simple;
	bh=oFdeEmSZCx2CmTI24Mlau+qRlUsKvxGoVQk9WMKPt7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/swPI4neuVy9PxLGxr0Za6hakWI+WR519v61Epn9pvWFNPYiJpqXob+DPtE6YFyfo2So3/KcbJJeOt0gSejKLBdxj1txieDKonge3JtybYv1HCqMg0HgCBqY4VfBY8HcN/1/khQBexkQwKASkJIwWU2gLwGnJxfKRYiHROqrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uBF55iLR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718021974; x=1749557974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFdeEmSZCx2CmTI24Mlau+qRlUsKvxGoVQk9WMKPt7Y=;
  b=uBF55iLRjjnHnGp2CU5l93sd+Z/NdWhCXMjTpZvnVG+uy0OvndrvkvDI
   ZoY/Pn0yZ2ac5wqhotrnswBjh9tufMg4NCvPbmrNvgtc2qSJoMnw63mUN
   aPnW91YdLhTEwbIFcUyN6mVRlgbHN1kh6YRX/vq7TFQ3kYgRiplAMKKyy
   /98KDeZ2Gi6b4ya1VGjFpmTElCxfcDwYutgNnqevm52IwXkNfZmNrhspP
   ekN2o369orU1vAhLYS/GboiWx80aBq8wPaIhpLWEWo5J18XVwTet1J9pH
   GUVaWOKBTNx6EcVvi9suD8CvNEwvMjoMH3ZuleYprZ72WfJMYtBMaUxjD
   g==;
X-CSE-ConnectionGUID: dqLk+HR7SaOyO/C4oxTk7g==
X-CSE-MsgGUID: yGdRtAjnRVyfbWIIvRK/bg==
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="27206508"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2024 05:19:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Jun 2024 05:18:28 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Jun 2024 05:18:26 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <daire.mcnamara@microchip.com>
Subject: [PATCH v2 1/3] PCI: microchip: Fix outbound address translation tables
Date: Mon, 10 Jun 2024 13:18:20 +0100
Message-ID: <20240610121822.2636971-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610121822.2636971-1-daire.mcnamara@microchip.com>
References: <20240610121822.2636971-1-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Daire McNamara <daire.mcnamara@microchip.com>

On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
three general-purpose Fabric Interface Controller (FIC) buses that
encapsulate an AXI-M interface. That FIC is responsible for managing
the translations of the upper 32-bits of the AXI-M address. On MPFS,
the Root Port driver needs to take account of that outbound address
translation done by the parent FIC bus before setting up its own
outbound address translation tables.  In all cases on MPFS,
the remaining outbound address translation tables are 32-bit only.

Limit the outbound address translation tables to 32-bit only.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 137fb8570ba2..853adce24492 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -933,7 +933,7 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
 
 static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 				 phys_addr_t axi_addr, phys_addr_t pci_addr,
-				 size_t size)
+				 u64 size)
 {
 	u32 atr_sz = ilog2(size) - 1;
 	u32 val;
@@ -983,7 +983,8 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
 		if (resource_type(entry->res) == IORESOURCE_MEM) {
 			pci_addr = entry->res->start - entry->offset;
 			mc_pcie_setup_window(bridge_base_addr, index,
-					     entry->res->start, pci_addr,
+					     entry->res->start & 0xffffffff,
+					     pci_addr,
 					     resource_size(entry->res));
 			index++;
 		}
@@ -1117,9 +1118,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
-	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
-			     cfg->res.start,
-			     resource_size(&cfg->res));
+	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
+			     0, resource_size(&cfg->res));
 
 	/* Need some fixups in config space */
 	mc_pcie_enable_msi(port, cfg->win);
-- 
2.34.1


