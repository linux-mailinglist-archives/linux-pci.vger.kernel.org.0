Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB615B821
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgBMEJz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:09:55 -0500
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:23428
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729671AbgBMEJz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:09:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R87MzkasTD+pWgBT+Ze1ByfqEA0Tq7fpLjkLeZDRIeMUbcnFiY4cq8yT7LW4keBYM9R09LwbM6c+mDnsrwkPYvpETsPZ0DMW32gLjydt5HFJKhL11nwW1fjAoEi/Lml7OeIviaN/vHcSqdvRWbyhVgygEg5oMgHCT4z8suSTZqUHDY1be9wST6yRsMPiVAhdSh/2dFZ2+vHDuuHUXbksZaavh3y9e6kE/KwRdBnbaPzJAC+rsXZE6rK5M4hyzbsYDy4IR0Xm/aidLumK2P2R3i1L5hsfo8l9KIfIQ3PVg3j3LJwdHxHenWnL6ilZXdXCDwx++BQvHdoEzRT1b8ynxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiZZ7Xv1VUd91OEfyZV2/WDc0COPenZ/njJoPfdb418=;
 b=jK7QunABp9pz2jYXolDLttjSFUPFzB+JrOyBN6LwmVGmzGznr7zRcYtFmbQe0eKM/R/q1TPCSrKc8Fa6m4q5urPP1YOtYVwzLPlTFQEIOhYDTcFjErxLJeZT/4cnRaxdLqmQNVfqzYc1/VtoOqnogDW9ePv5pLTI3IKF8slF7rMIsTGS8Mer96WvBAL1KO3QayxTJ5Xla7vHSJDH+y4nxqOiZKyERNarJGq4ZDAzsAoxMWqbj6YbTeEG70+b45dDtS9pR00J55jPA/opj3VVJ4vHoAWLD5IZPfJQkOrV2BSrC0T2LYDRJnx4Bjb8hMIetOeWi67RYEM2qv/P2e2vxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiZZ7Xv1VUd91OEfyZV2/WDc0COPenZ/njJoPfdb418=;
 b=qUqrzE/oY/Upa3pu5z4Yq1KYvSsSo7/IzN+wnwHhnxqkFnGsmV14RLZyMIgJE7zmdfiHAVd8ofTcQc7zKse0bPfUW5fKVJBAEGJzMmKgM45zuIkQcA3TQLrgorYy/upqzrQ1aW0jR1sxQxoAilxvv8cxz+ja07CjsKg5wcZjamk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:09:46 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:09:46 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 01/13] PCI: mobiveil: Introduce a new structure mobiveil_root_port
Date:   Thu, 13 Feb 2020 12:06:32 +0800
Message-Id: <20200213040644.45858-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:09:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84950306-d75f-43b4-7023-08d7b03a8fc8
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7084F1BA669217F6F2FE6598841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(30864003)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /q1MzcvvBUEqgO0EYbSgt/LNYUkQRo+hvBImRGuWwUQLlpTuVfaYxL9VQIv1dRnXoavl85r2UEfGlltlPdLcRfDPZdDGqhQ6j9lFbZe+65mXNOIBmW3sahhVyVInzdz5WYprfJvI7QXvcgDVOGrbITUNXTcp8cieViFyga644uNKkGSpEzysiLgHF7cvs8paY8gfYkmSfR843EgPFdm5U4yKpMkENouxjbJprAaRFO9GiHaEIteDIr6djbkHYufzp7OdzfoJhBPKsy5uO8T0pSNXcYIfKUQXPHJhszXTWRMhFa6Wnj8o7y0FplSdS6ZO+kJRUWt+xYD4A/a1bjbA5pWGYH+Rft8yfYpyHPpc/itzu3A1HR5KUv/XAYZVzjjABubb/RuSwlcMXDjhw/c0+Xv67GL5skJzCeeZPcZuZcvF72DuFH0qih9FmN8Q5tNIuQtBhvkZn5QKGiMxtZMLm17cnOG+fcW3THmsW0dPr6/cfc49kM+m0ybXeEJ0Eem3kZkxq5HGV8Xp/gRGbt3XbHmciwgYvXEdEPQMwa/bxehq4T+xJqQhR/BNOQRbEZAdF46V174seL6cEbABBL7r1g==
X-MS-Exchange-AntiSpam-MessageData: Z6uha+9i0s+/9wQsCkag+YZI845FEl7qkpc0XsWXpgBjK/Yz54KFFENRtsBs3DuXBhOgIRtN+vzjDp97tosdp4+pIge30yFk80YyeTzN3oMl45ilcGSHVpKghPejfCNG+DTfPCb1O/i+n/gaMLkHBQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84950306-d75f-43b4-7023-08d7b03a8fc8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:09:46.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7dy++kvcHvRgxaY+gkyHOuBm/l9MrtJ6q/4n2QMf4rjFADueSNtO7H/1Nsv0jonWOYHIJUllnOHhjXacTk1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The Mobiveil PCIe controller can work in either Root Complex
mode or Endpoint mode. So introduce a new structure
mobiveil_root_port, and abstract the RC related members into
it such that the code can be used by both mode.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V10:
 - Refined the subject and change log.
 - Added prefix mobiveil to the root port structure.

 drivers/pci/controller/pcie-mobiveil.c | 99 ++++++++++++++++----------
 1 file changed, 60 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 3a696ca45bfa..d4de560cd711 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -3,7 +3,10 @@
  * PCIe host controller driver for Mobiveil PCIe Host controller
  *
  * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019-2020 NXP
+ *
  * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ *	   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
  */
 
 #include <linux/delay.h>
@@ -138,22 +141,27 @@ struct mobiveil_msi {			/* MSI information */
 	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
 };
 
+struct mobiveil_root_port {
+	char root_bus_nr;
+	void __iomem *config_axi_slave_base;	/* endpoint config base */
+	struct resource *ob_io_res;
+	int irq;
+	raw_spinlock_t intx_mask_lock;
+	struct irq_domain *intx_domain;
+	struct mobiveil_msi msi;
+	struct pci_host_bridge *bridge;
+};
+
 struct mobiveil_pcie {
 	struct platform_device *pdev;
-	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	void __iomem *csr_axi_slave_base;	/* root port config base */
 	void __iomem *apb_csr_base;	/* MSI register base */
 	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
-	struct irq_domain *intx_domain;
-	raw_spinlock_t intx_mask_lock;
-	int irq;
 	int apio_wins;
 	int ppio_wins;
 	int ob_wins_configured;		/* configured outbound windows */
 	int ib_wins_configured;		/* configured inbound windows */
-	struct resource *ob_io_res;
-	char root_bus_nr;
-	struct mobiveil_msi msi;
+	struct mobiveil_root_port rp;
 };
 
 /*
@@ -281,16 +289,17 @@ static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
 static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct mobiveil_pcie *pcie = bus->sysdata;
+	struct mobiveil_root_port *rp = &pcie->rp;
 
 	/* Only one device down on each root port */
-	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->number == rp->root_bus_nr) && (devfn > 0))
 		return false;
 
 	/*
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary == pcie->root_bus_nr) && (PCI_SLOT(devfn) > 0))
+	if ((bus->primary == rp->root_bus_nr) && (PCI_SLOT(devfn) > 0))
 		return false;
 
 	return true;
@@ -304,13 +313,14 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
 					   unsigned int devfn, int where)
 {
 	struct mobiveil_pcie *pcie = bus->sysdata;
+	struct mobiveil_root_port *rp = &pcie->rp;
 	u32 value;
 
 	if (!mobiveil_pcie_valid_device(bus, devfn))
 		return NULL;
 
 	/* RC config access */
-	if (bus->number == pcie->root_bus_nr)
+	if (bus->number == rp->root_bus_nr)
 		return pcie->csr_axi_slave_base + where;
 
 	/*
@@ -325,7 +335,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
 
 	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
 
-	return pcie->config_axi_slave_base + where;
+	return rp->config_axi_slave_base + where;
 }
 
 static struct pci_ops mobiveil_pcie_ops = {
@@ -339,7 +349,8 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
 	struct device *dev = &pcie->pdev->dev;
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_root_port *rp = &pcie->rp;
+	struct mobiveil_msi *msi = &rp->msi;
 	u32 msi_data, msi_addr_lo, msi_addr_hi;
 	u32 intr_status, msi_status;
 	unsigned long shifted_status;
@@ -365,7 +376,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		shifted_status >>= PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
-				virq = irq_find_mapping(pcie->intx_domain,
+				virq = irq_find_mapping(rp->intx_domain,
 							bit + 1);
 				if (virq)
 					generic_handle_irq(virq);
@@ -424,15 +435,16 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	struct device *dev = &pcie->pdev->dev;
 	struct platform_device *pdev = pcie->pdev;
 	struct device_node *node = dev->of_node;
+	struct mobiveil_root_port *rp = &pcie->rp;
 	struct resource *res;
 
 	/* map config resource */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "config_axi_slave");
-	pcie->config_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->config_axi_slave_base))
-		return PTR_ERR(pcie->config_axi_slave_base);
-	pcie->ob_io_res = res;
+	rp->config_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(rp->config_axi_slave_base))
+		return PTR_ERR(rp->config_axi_slave_base);
+	rp->ob_io_res = res;
 
 	/* map csr resource */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -455,9 +467,9 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
 		pcie->ppio_wins = MAX_PIO_WINDOWS;
 
-	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq <= 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
+	rp->irq = platform_get_irq(pdev, 0);
+	if (rp->irq <= 0) {
+		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
 		return -ENODEV;
 	}
 
@@ -564,9 +576,9 @@ static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
 static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 {
 	phys_addr_t msg_addr = pcie->pcie_reg_base;
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 
-	pcie->msi.num_of_vectors = PCI_NUM_MSI;
+	msi->num_of_vectors = PCI_NUM_MSI;
 	msi->msi_pages_phys = (phys_addr_t)msg_addr;
 
 	writel_relaxed(lower_32_bits(msg_addr),
@@ -579,7 +591,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct mobiveil_root_port *rp = &pcie->rp;
+	struct pci_host_bridge *bridge = rp->bridge;
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
 
@@ -629,8 +642,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	 */
 
 	/* config outbound translation window */
-	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
-			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
+	program_ob_windows(pcie, WIN_NUM_0, rp->ob_io_res->start, 0,
+			   CFG_WINDOW_TYPE, resource_size(rp->ob_io_res));
 
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
@@ -667,32 +680,36 @@ static void mobiveil_mask_intx_irq(struct irq_data *data)
 {
 	struct irq_desc *desc = irq_to_desc(data->irq);
 	struct mobiveil_pcie *pcie;
+	struct mobiveil_root_port *rp;
 	unsigned long flags;
 	u32 mask, shifted_val;
 
 	pcie = irq_desc_get_chip_data(desc);
+	rp = &pcie->rp;
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&rp->intx_mask_lock, flags);
 	shifted_val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val &= ~mask;
 	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&rp->intx_mask_lock, flags);
 }
 
 static void mobiveil_unmask_intx_irq(struct irq_data *data)
 {
 	struct irq_desc *desc = irq_to_desc(data->irq);
 	struct mobiveil_pcie *pcie;
+	struct mobiveil_root_port *rp;
 	unsigned long flags;
 	u32 shifted_val, mask;
 
 	pcie = irq_desc_get_chip_data(desc);
+	rp = &pcie->rp;
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&rp->intx_mask_lock, flags);
 	shifted_val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val |= mask;
 	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&rp->intx_mask_lock, flags);
 }
 
 static struct irq_chip intx_irq_chip = {
@@ -760,7 +777,7 @@ static int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
 					 unsigned int nr_irqs, void *args)
 {
 	struct mobiveil_pcie *pcie = domain->host_data;
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 	unsigned long bit;
 
 	WARN_ON(nr_irqs != 1);
@@ -787,7 +804,7 @@ static void mobiveil_irq_msi_domain_free(struct irq_domain *domain,
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(d);
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 
 	mutex_lock(&msi->lock);
 
@@ -808,9 +825,9 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 
-	mutex_init(&pcie->msi.lock);
+	mutex_init(&msi->lock);
 	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
 						&msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
@@ -834,18 +851,19 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct mobiveil_root_port *rp = &pcie->rp;
 	int ret;
 
 	/* setup INTx */
-	pcie->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
-						  &intx_domain_ops, pcie);
+	rp->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
+						&intx_domain_ops, pcie);
 
-	if (!pcie->intx_domain) {
+	if (!rp->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
 	}
 
-	raw_spin_lock_init(&pcie->intx_mask_lock);
+	raw_spin_lock_init(&rp->intx_mask_lock);
 
 	/* setup MSI */
 	ret = mobiveil_allocate_msi_domains(pcie);
@@ -862,6 +880,7 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct device *dev = &pdev->dev;
+	struct mobiveil_root_port *rp;
 	int ret;
 
 	/* allocate the PCIe port */
@@ -870,6 +889,8 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(bridge);
+	rp = &pcie->rp;
+	rp->bridge = bridge;
 
 	pcie->pdev = pdev;
 
@@ -904,12 +925,12 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
+	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
 
 	/* Initialize bridge */
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
-	bridge->busnr = pcie->root_bus_nr;
+	bridge->busnr = rp->root_bus_nr;
 	bridge->ops = &mobiveil_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
-- 
2.17.1

