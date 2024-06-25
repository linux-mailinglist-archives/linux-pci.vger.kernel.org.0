Return-Path: <linux-pci+bounces-9231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E79916816
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1282826F3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263E1553A2;
	Tue, 25 Jun 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N7HP0Wvn"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87914D2BD;
	Tue, 25 Jun 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319154; cv=none; b=WmFtdKe7sPoFg0osefzyavQXE2mjwjyG+8kPsYb8mTglgf7cCBLbx/ZWicFCkRjiWFpuk5SB2Q4y+LDsBfWZ0Wb3+CbIAJxUSNsRwIsmlHp0Ou8G5mTtpAngC1Z1tpZcGX4F4jStg3HpcLK1CooJJlmEfL8+GPj8yWp8/2Q5gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319154; c=relaxed/simple;
	bh=D/DTZDdhp483468UdHXbB3SeAnPkikehybNHbu2tzLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfvDqQUbQvvqEsJAsaUU9siUacne+bIIgiQLqHB5OR1ohQqLiWsB3UKkWZ8y2vjGX6Xp0f3TjTKAswNVVfUN2+t9AkbECyCFHPV1Kk/eltgiSRv4R/3bzsaMas0Jkv9lFSj3G+/XaKmW17eXcbngf6ywFKK6DYGNeXGNSXNaSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N7HP0Wvn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719319153; x=1750855153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/DTZDdhp483468UdHXbB3SeAnPkikehybNHbu2tzLU=;
  b=N7HP0WvnRuITRrZjgXD7Ri2ROOv1G4v75fg2erq7nW0N459E4P9YXg9q
   okbuQJaFUP8dg3g3a8lIhWsICzFMJJXzbhZrr5mM+5cD9F1/jLn/NWV83
   66BarQZz6w8DFV3YAhSOGbe6AtnTACFqci1LSJOTXuyhtkqpJEfqAOhxq
   lvutIHxe6UoXPDuvRwr3Xtog1B3MYbEIm0Fzlqf5Dl8vpwlCUFNo4UXQn
   oEbOhr1BD9PqkL36y/POklQsLFleH6FivRLj4QUbqzKpu7MDvy7a46Mwv
   bmlMpxkjQQHJylTdyzE1g7ipT8MHx91plxATbY00pXzIHQZ6yRH+DtBRa
   Q==;
X-CSE-ConnectionGUID: txch52YOQf2qALM7aM1iOQ==
X-CSE-MsgGUID: Jp7v6NhiSmiD1LzDVHmD/Q==
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="28472715"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 05:39:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 05:38:44 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Jun 2024 05:38:40 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 1/3] PCI: microchip: Fix outbound address translation tables
Date: Tue, 25 Jun 2024 13:38:43 +0100
Message-ID: <20240625123845.3747764-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625123845.3747764-1-daire.mcnamara@microchip.com>
References: <20240625123845.3747764-1-daire.mcnamara@microchip.com>
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
to a resource_size_t to avoid a compile error on 32-bit platforms.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
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


