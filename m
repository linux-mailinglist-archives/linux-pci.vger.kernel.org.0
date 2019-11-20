Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DA103220
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKTDpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:45:31 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:8229
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbfKTDpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:45:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiuW22Dmj2dqaQ6tr9aX6ypsRE9XsPkPA7nF5DZkTuEfAtszqP1tQVbppxsdWMnAl6GwFZimK83Utwdyd69Rl/CxOkb5sTEE7xCEueAxvgQVYZr8t+2YAlRDEVm4iXjthrwV8rriVdIajx5u0a571+qMokoOsVJnqjDyd+cZd59hjYW1F5ey4ubU+VoUXzMIXzuffdgI/DOBet8welTqpee5926ofMbyc6bjSXJnOXHdfYgDsRkeGELF5lvuviMOumX1dbClXR0EhxDlwOIgLaT5qLF1ImBkbOgG2UDLp3+u4E7ge5jhSyyWHk3TSD2GLN0OEigAXhBFREKR5DrHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhRdvfp/buVxJcqzu5df9l8rFPWtluuhwF82UHEkgb4=;
 b=eaDR8sZbk0idkxWVuw67d5yJgjheWxrNKC84ql4gPy3P3SxWtdolvJAfAE8ewcdlO9v+TAJOfiAh9vHLYSpVieRWLOO8MwTqIwMq4i7mDS9kBbtfmGFvIQ5r12j+5ojpAs3oJNWs0PfRYFWS3uBNUn+vZFmPGxfUpWYkvGdtg4FErU50xmz0GfvpI/YWYbQqwDgqRZH17BjQChMrj6rljpzeqUHzit3bWixpNgNkP4lGQqAc7V/tKEOHXlAkzdO41AcTwJq37ZmUaeunxgeqCQTXIT25hj9AmmLTSWv0zQgYbpBxt9wDK3/nVVOdRiddBOPorkH0r9E/JXVMwd/1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhRdvfp/buVxJcqzu5df9l8rFPWtluuhwF82UHEkgb4=;
 b=cvq8rJ9XQmeqJUnUEjy9qoJ5dGzLYx8Tiar0NQKdy4ZpB9stv2jS3hqT6KYtsuJwINY+1H5kZ7CRNbjbqEV+8dyUKdcqD/ha3JT9lbVjX88euhni5M9PGq5z/nPvuSlMsowjjnzo/alyQ6BwtIwLpY9U6gcFFPRfIun5BjpKzhY=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5657.eurprd04.prod.outlook.com (20.179.9.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 03:45:24 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:45:23 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv9 01/12] PCI: mobiveil: Re-abstract the private structure
Thread-Topic: [PATCHv9 01/12] PCI: mobiveil: Re-abstract the private structure
Thread-Index: AQHVn1TwFR8APo0fq0uUrHwI6ZwoQQ==
Date:   Wed, 20 Nov 2019 03:45:23 +0000
Message-ID: <20191120034451.30102-2-Zhiqiang.Hou@nxp.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c143fa4-1a4b-4721-b3fa-08d76d6c12c1
x-ms-traffictypediagnostic: DB8PR04MB5657:|DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5657173DB3C7095047FDE812844F0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(54906003)(86362001)(36756003)(256004)(7736002)(305945005)(6116002)(66066001)(3846002)(110136005)(316002)(71190400001)(7416002)(1076003)(71200400001)(14444005)(30864003)(5024004)(52116002)(2501003)(4326008)(5660300002)(66476007)(476003)(64756008)(66556008)(11346002)(446003)(76176011)(2616005)(66946007)(6512007)(66446008)(8676002)(386003)(6506007)(2906002)(99286004)(102836004)(6486002)(81166006)(81156014)(8936002)(50226002)(186003)(26005)(478600001)(14454004)(486006)(6436002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5657;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWPjMoEY9MtEkcyCoHxZPaptCKJUVBnX9xXTSLDjygQ7zWrj7hffG1UrF4Kwft2vAP09tanaMc/4gwv2/a6hKKHWniiiuHc1ucM0j95MVvsBHyRNkAtLJP/3hzkF2Uo6m3CYigmq0IS1OFPMhy58pBIUmBj+3jfDUXNYcx2f8txjA/JlAempdJ6WWdoYwj5t0uxj02+nt3WCnWxIg0fkxrH37v7JEKZd6d/eEzb1SC2jYlgKfwFoDQcKXBReCd9U3P2Blw9G9x1RbzijUsLept+2Iv/Zfxj+0uPQFWUBpSsMxPrJpxuP5Oku75LNqhfxzIEe4KYg9HvXlZZTDr2iUYbS6sAd4eZmept+4EBRxK1IZg0DMq93Nt0c4bUWaTZ+DjuEwcJcxN2xYlT/EiIRgyTCZfnmI7g2fJbhEN81JfNP2+T/eWeJaLgfMwRejFS1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c143fa4-1a4b-4721-b3fa-08d76d6c12c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:45:23.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfVDUzk6Jnb0AZ1MWPJmfvBnr0vffKANfggYhw23fAEZzc5aFUtn+wjrA+GAPD+EMKV8pF6LqLoyRjKz8qMPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The Mobiveil PCIe controller can work in either Root Complex
mode or Endpoint mode. So introduce a new structure root_port,
and abstract the RC related members into it.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V9:
 - New patch splited from the #1 of V8 patches to make it easy to review.

 drivers/pci/controller/pcie-mobiveil.c | 99 ++++++++++++++++----------
 1 file changed, 60 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 3a696ca45bfa..5fd26e376af2 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -3,7 +3,10 @@
  * PCIe host controller driver for Mobiveil PCIe Host controller
  *
  * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019 NXP
+ *
  * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
  */
=20
 #include <linux/delay.h>
@@ -138,22 +141,27 @@ struct mobiveil_msi {			/* MSI information */
 	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
 };
=20
+struct root_port {
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
+	struct root_port rp;
 };
=20
 /*
@@ -281,16 +289,17 @@ static bool mobiveil_pcie_link_up(struct mobiveil_pci=
e *pcie)
 static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int d=
evfn)
 {
 	struct mobiveil_pcie *pcie =3D bus->sysdata;
+	struct root_port *rp =3D &pcie->rp;
=20
 	/* Only one device down on each root port */
-	if ((bus->number =3D=3D pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->number =3D=3D rp->root_bus_nr) && (devfn > 0))
 		return false;
=20
 	/*
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary =3D=3D pcie->root_bus_nr) && (PCI_SLOT(devfn) > 0))
+	if ((bus->primary =3D=3D rp->root_bus_nr) && (PCI_SLOT(devfn) > 0))
 		return false;
=20
 	return true;
@@ -304,13 +313,14 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci=
_bus *bus,
 					   unsigned int devfn, int where)
 {
 	struct mobiveil_pcie *pcie =3D bus->sysdata;
+	struct root_port *rp =3D &pcie->rp;
 	u32 value;
=20
 	if (!mobiveil_pcie_valid_device(bus, devfn))
 		return NULL;
=20
 	/* RC config access */
-	if (bus->number =3D=3D pcie->root_bus_nr)
+	if (bus->number =3D=3D rp->root_bus_nr)
 		return pcie->csr_axi_slave_base + where;
=20
 	/*
@@ -325,7 +335,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_b=
us *bus,
=20
 	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
=20
-	return pcie->config_axi_slave_base + where;
+	return rp->config_axi_slave_base + where;
 }
=20
 static struct pci_ops mobiveil_pcie_ops =3D {
@@ -339,7 +349,8 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct mobiveil_pcie *pcie =3D irq_desc_get_handler_data(desc);
 	struct device *dev =3D &pcie->pdev->dev;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct root_port *rp =3D &pcie->rp;
+	struct mobiveil_msi *msi =3D &rp->msi;
 	u32 msi_data, msi_addr_lo, msi_addr_hi;
 	u32 intr_status, msi_status;
 	unsigned long shifted_status;
@@ -365,7 +376,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		shifted_status >>=3D PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
-				virq =3D irq_find_mapping(pcie->intx_domain,
+				virq =3D irq_find_mapping(rp->intx_domain,
 							bit + 1);
 				if (virq)
 					generic_handle_irq(virq);
@@ -424,15 +435,16 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pci=
e *pcie)
 	struct device *dev =3D &pcie->pdev->dev;
 	struct platform_device *pdev =3D pcie->pdev;
 	struct device_node *node =3D dev->of_node;
+	struct root_port *rp =3D &pcie->rp;
 	struct resource *res;
=20
 	/* map config resource */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "config_axi_slave");
-	pcie->config_axi_slave_base =3D devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->config_axi_slave_base))
-		return PTR_ERR(pcie->config_axi_slave_base);
-	pcie->ob_io_res =3D res;
+	rp->config_axi_slave_base =3D devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(rp->config_axi_slave_base))
+		return PTR_ERR(rp->config_axi_slave_base);
+	rp->ob_io_res =3D res;
=20
 	/* map csr resource */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -455,9 +467,9 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie =
*pcie)
 	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
 		pcie->ppio_wins =3D MAX_PIO_WINDOWS;
=20
-	pcie->irq =3D platform_get_irq(pdev, 0);
-	if (pcie->irq <=3D 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
+	rp->irq =3D platform_get_irq(pdev, 0);
+	if (rp->irq <=3D 0) {
+		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
 		return -ENODEV;
 	}
=20
@@ -564,9 +576,9 @@ static int mobiveil_bringup_link(struct mobiveil_pcie *=
pcie)
 static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 {
 	phys_addr_t msg_addr =3D pcie->pcie_reg_base;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
-	pcie->msi.num_of_vectors =3D PCI_NUM_MSI;
+	msi->num_of_vectors =3D PCI_NUM_MSI;
 	msi->msi_pages_phys =3D (phys_addr_t)msg_addr;
=20
 	writel_relaxed(lower_32_bits(msg_addr),
@@ -579,7 +591,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pc=
ie *pcie)
=20
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
-	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie);
+	struct root_port *rp =3D &pcie->rp;
+	struct pci_host_bridge *bridge =3D rp->bridge;
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
=20
@@ -629,8 +642,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	 */
=20
 	/* config outbound translation window */
-	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
-			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
+	program_ob_windows(pcie, WIN_NUM_0, rp->ob_io_res->start, 0,
+			   CFG_WINDOW_TYPE, resource_size(rp->ob_io_res));
=20
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
@@ -667,32 +680,36 @@ static void mobiveil_mask_intx_irq(struct irq_data *d=
ata)
 {
 	struct irq_desc *desc =3D irq_to_desc(data->irq);
 	struct mobiveil_pcie *pcie;
+	struct root_port *rp;
 	unsigned long flags;
 	u32 mask, shifted_val;
=20
 	pcie =3D irq_desc_get_chip_data(desc);
+	rp =3D &pcie->rp;
 	mask =3D 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&rp->intx_mask_lock, flags);
 	shifted_val =3D mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val &=3D ~mask;
 	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&rp->intx_mask_lock, flags);
 }
=20
 static void mobiveil_unmask_intx_irq(struct irq_data *data)
 {
 	struct irq_desc *desc =3D irq_to_desc(data->irq);
 	struct mobiveil_pcie *pcie;
+	struct root_port *rp;
 	unsigned long flags;
 	u32 shifted_val, mask;
=20
 	pcie =3D irq_desc_get_chip_data(desc);
+	rp =3D &pcie->rp;
 	mask =3D 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&rp->intx_mask_lock, flags);
 	shifted_val =3D mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val |=3D mask;
 	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&rp->intx_mask_lock, flags);
 }
=20
 static struct irq_chip intx_irq_chip =3D {
@@ -760,7 +777,7 @@ static int mobiveil_irq_msi_domain_alloc(struct irq_dom=
ain *domain,
 					 unsigned int nr_irqs, void *args)
 {
 	struct mobiveil_pcie *pcie =3D domain->host_data;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
 	unsigned long bit;
=20
 	WARN_ON(nr_irqs !=3D 1);
@@ -787,7 +804,7 @@ static void mobiveil_irq_msi_domain_free(struct irq_dom=
ain *domain,
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
 	struct mobiveil_pcie *pcie =3D irq_data_get_irq_chip_data(d);
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
 	mutex_lock(&msi->lock);
=20
@@ -808,9 +825,9 @@ static int mobiveil_allocate_msi_domains(struct mobivei=
l_pcie *pcie)
 {
 	struct device *dev =3D &pcie->pdev->dev;
 	struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
-	mutex_init(&pcie->msi.lock);
+	mutex_init(&msi->lock);
 	msi->dev_domain =3D irq_domain_add_linear(NULL, msi->num_of_vectors,
 						&msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
@@ -834,18 +851,19 @@ static int mobiveil_pcie_init_irq_domain(struct mobiv=
eil_pcie *pcie)
 {
 	struct device *dev =3D &pcie->pdev->dev;
 	struct device_node *node =3D dev->of_node;
+	struct root_port *rp =3D &pcie->rp;
 	int ret;
=20
 	/* setup INTx */
-	pcie->intx_domain =3D irq_domain_add_linear(node, PCI_NUM_INTX,
-						  &intx_domain_ops, pcie);
+	rp->intx_domain =3D irq_domain_add_linear(node, PCI_NUM_INTX,
+						&intx_domain_ops, pcie);
=20
-	if (!pcie->intx_domain) {
+	if (!rp->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
 	}
=20
-	raw_spin_lock_init(&pcie->intx_mask_lock);
+	raw_spin_lock_init(&rp->intx_mask_lock);
=20
 	/* setup MSI */
 	ret =3D mobiveil_allocate_msi_domains(pcie);
@@ -862,6 +880,7 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct device *dev =3D &pdev->dev;
+	struct root_port *rp;
 	int ret;
=20
 	/* allocate the PCIe port */
@@ -870,6 +889,8 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		return -ENOMEM;
=20
 	pcie =3D pci_host_bridge_priv(bridge);
+	rp =3D &pcie->rp;
+	rp->bridge =3D bridge;
=20
 	pcie->pdev =3D pdev;
=20
@@ -904,12 +925,12 @@ static int mobiveil_pcie_probe(struct platform_device=
 *pdev)
 		return ret;
 	}
=20
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
+	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
=20
 	/* Initialize bridge */
 	bridge->dev.parent =3D dev;
 	bridge->sysdata =3D pcie;
-	bridge->busnr =3D pcie->root_bus_nr;
+	bridge->busnr =3D rp->root_bus_nr;
 	bridge->ops =3D &mobiveil_pcie_ops;
 	bridge->map_irq =3D of_irq_parse_and_map_pci;
 	bridge->swizzle_irq =3D pci_common_swizzle;
--=20
2.17.1

