Return-Path: <linux-pci+bounces-10150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE7A92E483
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 12:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D713B215E6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B101115AD8B;
	Thu, 11 Jul 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fAbblH2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035A1586D5;
	Thu, 11 Jul 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693395; cv=none; b=WIt3ziBUDkY7Mke0lUx4iWfcCQKaH1d9cIDShlLzg0FZZrjYg7lI2u5P7riPZkH4J7sVuQj5XUENftPIaN/zOfOCiwAwFaiJdXWd7e/FrB3czMVP6CHUfW8Ejf378pzkKgl57zQm/qtQZwXrgr+T5EUqlEUEZ/MLJBrX/+488QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693395; c=relaxed/simple;
	bh=po6JcgW+HLlGJYh0A5KZZt8rZ8NAuWbj/QfkNLTnywM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOInRtiN7wzHE+4g/p1AoCE0KHHabaPEWPV1Ox1Ka4D0L5HLXZirUb64kjrSBHv/qhNwQWO10qgqkL4dexCxh1edb+5Bj534g1daJdEUe32jUCtIEHgT2wtZEYQQ+cM1EdJFmtioGD8ZZR9pkzRNstvMgtx81lErqCvsfjtdiM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fAbblH2e; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720693395; x=1752229395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=po6JcgW+HLlGJYh0A5KZZt8rZ8NAuWbj/QfkNLTnywM=;
  b=fAbblH2eKmxO45vn6jq1uurL7x6sz07XHGzWNkoqol2iZq8qhzBgTGKA
   GeHRFqxUFLu1w1JK9K8gbIRvQ4zOh+yaFM+ifNx27PdiVJ+elit7ROcNg
   jlW5ObOfU5/xR5xiYfCAHAh7yx20sKbr+8bTNmeoruM9EhvuqgZdGJNcr
   qyi76Z4qRhS+O76aho60UZJAjoiQEVEIYb//VxK9BYTaaPnOR777iIFcR
   a4/zGcqGa3pFHiyON3noDyjlmISvv3S7VNqZGGYiQTWsPTvk8EsU5dCeU
   JMwuI85ZsyM11naYH+nT7WCMsXsHRZYITaH7Zmw8BxXEqofadzgUCDsFB
   g==;
X-CSE-ConnectionGUID: oE7M2H4IRp2wJBQtwWzi7w==
X-CSE-MsgGUID: 5bHCZ26dRpiZyX5hE7z5DQ==
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="29112248"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2024 03:23:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jul 2024 03:22:55 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Jul 2024 03:22:53 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 1/3] PCI: microchip: Fix outbound address translation tables
Date: Thu, 11 Jul 2024 11:22:17 +0100
Message-ID: <20240711102218.2895429-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240711102218.2895429-2-daire.mcnamara@microchip.com>
References: <20240711102218.2895429-2-daire.mcnamara@microchip.com>
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

This necessitates changing a size_t in mc_pcie_setup_window
to a u64 to avoid a compile error on 32-bit platforms.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 137fb8570ba2..47c397ae515a 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -23,6 +23,8 @@
 /* Number of MSI IRQs */
 #define MC_MAX_NUM_MSI_IRQS			32
 
+#define MC_OUTBOUND_TRANS_TBL_MASK		GENMASK(31, 0)
+
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
 #define MC_PCIE1_CTRL_ADDR			0x0000a000u
@@ -933,7 +935,7 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
 
 static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 				 phys_addr_t axi_addr, phys_addr_t pci_addr,
-				 size_t size)
+				 resource_size_t size)
 {
 	u32 atr_sz = ilog2(size) - 1;
 	u32 val;
@@ -983,7 +985,8 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
 		if (resource_type(entry->res) == IORESOURCE_MEM) {
 			pci_addr = entry->res->start - entry->offset;
 			mc_pcie_setup_window(bridge_base_addr, index,
-					     entry->res->start, pci_addr,
+					     entry->res->start & MC_OUTBOUND_TRANS_TBL_MASK,
+					     pci_addr,
 					     resource_size(entry->res));
 			index++;
 		}
@@ -1117,9 +1120,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
-	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
-			     cfg->res.start,
-			     resource_size(&cfg->res));
+	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & MC_OUTBOUND_TRANS_TBL_MASK,
+			     0, resource_size(&cfg->res));
 
 	/* Need some fixups in config space */
 	mc_pcie_enable_msi(port, cfg->win);
-- 
2.34.1


