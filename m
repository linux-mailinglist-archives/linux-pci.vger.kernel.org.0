Return-Path: <linux-pci+bounces-5339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F1888FC2A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46231C26F40
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D15FBA7;
	Thu, 28 Mar 2024 09:52:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FB364DA;
	Thu, 28 Mar 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619551; cv=fail; b=AG4rfK6QH3RzpOTCo5xY1jlgsDcTH9oyXZcAECFN5mV/mH4swQCRs4Knw+cMECLR3BnJ+Lf53hHQbPBWtELmZqh4UvE0ff+DJ2vV61xux2ElhNqdRHxB9CmSkjOgeL0tZnSQ3ypGqiE0GNRUke5LKfXkwJF25uepUgC6urUvvr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619551; c=relaxed/simple;
	bh=IWyU3Nb1lDW6JHJuysFfcNHrQ2UWhgpcddVWnUVeB88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=guRf51+cLPiInFaiOC3WsmDE6z0cpjwsgozFNmU4PPSvkP7lYqrP1CQCvkV0xiM99q115qQokeALRKHZE80OpCiDGId1tJeHpzRc5agiuCEx0Mk69AXBWzD+DKcewHq5QYujuRf/BAu4R8kglLMxobhJ/Y0AWZ4DUpwTNtsXNBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9mDw4XwaL2qCTufFfYbS17sAghny7xo91p9nk5lk0l2lUFuX67a1G75h1F35rQpf56Ep1cr6fsrwr3jRHyNw9XOp9mQl1c/gAH1xfmC+vEkf+b2AgDSWohHdlwfD12jPVFHFcWbP9alomLXr3Wb2DJ2tdXOMDpO053d5HnlaPAY5XA3RvHR7cBsM7LLWaTruPHuWF1OG0l8YofacK4oEKAwOVKjVTagTyH72M9NGwSLAQZhzOsdiPOrpA2AOfklxHhAc4IHwycAWAH2M23BUZDeAkT4XS3TmNfS5tLUwUPQ4tpKdSfkb5YOTJ8RO66UKyYJ2tvNmg4xjTH5/LSlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/CTRHF8OXhnsuS900QIctOG+tZySCVcRZiWfg2uaPc=;
 b=mOU3mUcUSwiFgzQ3aOxKkC8FgkaYQfs08AMvoqFpnUM+IROl1VPKeifTH0fOkXPbdkzdj7FcFwhNGfn/CJs3C0Ma5w4MBqLf/VrUAjRvIgKUQ7R3iIaSpTUDqtzaE2sfy4xVC0F21IrJBcj+ATPlrWM2THmeeUEfsRp9sjNj9gasI+wW0J2svtrPzry01y/u+5SQdraExocMCJxBt1hR17Gt4WAJyvwtoiLX1i0gfCAJAdAgR/GDEgHPL83W+rIw1zD/gUnE88XqDdC3dg2HOpH9ZEqxZDA2ZsDsIjeaTUWteqPU78dPge69UVf98OHJf9smB4vIj7FuECCJQR8k5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:48 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:48 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v16 04/22] PCI: microchip: Add bridge_addr field to struct mc_pcie
Date: Thu, 28 Mar 2024 17:18:17 +0800
Message-Id: <20240328091835.14797-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1531236a-9d19-4211-6dec-08dc4f081319
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4m4Fsdzby4aHg6pwz3IWaXSLKZIhQObJ3Z0DA/3a9DiDu/HS9lCLh74WuWlYLCCr10hH32DE8SDv+2aNrKgnMQFXYn/rBmv4dW44U3iMDdTivCB06cnOdgw7piv/W06HiJ/raWVUxacbrm897DbKtmOXJkNGY2/Nab3ZQpQ54NfIyvK4frd82VDi5daiifuAXYhzQH8X5yWW5ISTgtRj+GHEZdvK9SPKt0eDBWgundAzUNyg2wsx3ah2gFuzShgOhuImd5A0mOCQTP8F94eagTw6efFLtdAiSVfYqinxAVLKNNSm6MCixXIha6IGlUu2ieXJZ8C0cRckRYoJ/4bsG4t1fFlj3VWT1fJVtoErguwHyLQVVnB9XyEjRAQAVfBGWF4E23v8OdMQauQpQy17+iCP8/JAPSFem9jsgxpIUnYLM/QbUCqOJPy7Sqs5OQwWfC1CgTEtlDRhC36v2oobXErWcqb8Hu3UdfxwY7ahxLeoCk7oahMFhdvm9s31XExld88ZqapfI6gSacceLVZKVxI1E2tAkN0BJvCQIW8pcS8EXmL4JPXrY9qGgnfjnfMpKe72S/sgHRiWx1V8iJYhvRF79gf4DAbisDHntvJLaKunKnbDnjBDxl0YKt5YZdjC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LEP7CU1dKkthXxiP42OrVoaHH0lnkRudwzyiUW12FVOPJu0j9OQG4yAWmm7g?=
 =?us-ascii?Q?WDyqq0+ehRsXHGvQSewc3CZgvxYiyE4AGDQPW3u0XlNCU/ZRIBNWiYtxeQGZ?=
 =?us-ascii?Q?mC4Uk0Gm/ZY61ET7s+5X1ExsAgbQ65s6Delj2Z9UBrw2Ss1ruUu7gEl/2RNt?=
 =?us-ascii?Q?+XoLrSfwx+buaWE3uMrMQigqGi+j3wUpLrMFzsAeSi/sbAiNaW8lnhgSPsSW?=
 =?us-ascii?Q?HsY2JDJ4qYAoJHAvQsJHswVvbwu9zS25xBptpDsU1H8YEZ/b1pNyEe40bAJb?=
 =?us-ascii?Q?wHDU9UwraFRGGiBay1VI94Oe8l6WSGbMDcANRgBdssP9r7rMtSJXRKpNVE25?=
 =?us-ascii?Q?968oi7IQTK6Vk/8CItxFK9LoVIviYPqhZLk3Px8AVfY8OYJDM42N7/fWTcP3?=
 =?us-ascii?Q?OTGrfbNztcFQ92OmzF92V1wLDeHgOVCsTBM4Cz1nQWHaNdEJbRQzEFQ+v2Zl?=
 =?us-ascii?Q?56R9BjBezw5fELuZhV77eDcobWf2ayqeAB5O+RDKo91EGUt1hME0/epp1ORK?=
 =?us-ascii?Q?+aJsh5xE+UJpDxqxva7Hf0uO+Akn0wXixk5GPxLwEvtTExVdFMQTGYFml+UA?=
 =?us-ascii?Q?iy4h1NEkwQ9tS/wNicPYPDT07reZlRAIk7rXLuNMYCx1lmQ1WrSbygnqJKjn?=
 =?us-ascii?Q?C/SrQJzDVijhJa5gB7JKIf2zAPBtuImIvK2jFvIbvlUuqhE8jjyuOtLbIeOS?=
 =?us-ascii?Q?ngSEIx7NKfBEPdkvL0RDm5he9LDfK4YOr43PV3I2hW7MF4wnUeFlxbrIAVTj?=
 =?us-ascii?Q?DhIvhsW/BDdu/fd1KR4W4D8xiwhhA+5uJkyJS3JarrP4BTN/QVDG6719g1Ct?=
 =?us-ascii?Q?3RbLCr9ZlGrV6vPiSvoAdkNCTJZOeuuyGJdsKzvxAHbB3qtwTjTk3x0WLV46?=
 =?us-ascii?Q?tF09rmmzdlKAAqIwSICyBMXtElmcMjhdU/5l//C7MS98UWfao/L9w2+y+xYm?=
 =?us-ascii?Q?Fbibcin7JB3twI5iq86L1YpaTapCwMToVrh+E9R31amwrnGUXeOwqpMOTOWd?=
 =?us-ascii?Q?4obCvJtBEmY0JZEghNWyuU5fKG1PlC0tmF4+dPg7ONOTtMpbF3ujSMwwLBWQ?=
 =?us-ascii?Q?okeK4zbIhc7220h3+vFPKYa1EVihKMe4jZpUyFg9tDNSZH2SwCz/pXC9JaUK?=
 =?us-ascii?Q?YNjM0Cx1mI3QFgawoz+j4TkXOV2xkzMLfXNcKhOCbKqc38h5mUsVpcEXvPRn?=
 =?us-ascii?Q?7uA1m3FJd2P+i04QJA91HIlSGnH5lvWHWbHDKTN7md79IYUPAaC67Tobp+/C?=
 =?us-ascii?Q?B9rrKRopaynyf1PKPtFcHzDYQ4NKEY/6W5T8JJTQ8YIYIs1JbXLlxdQJXI4/?=
 =?us-ascii?Q?41tZhup7l5vociEa0BhS+Uy2TaUBuZTXKa1TtwjucrUBBHT6agFwioCYaRAS?=
 =?us-ascii?Q?672YeUJuCoBq83fezEePf3p2/DPlsEVKFyeQdEuyL15oQ/v+gPnZMHKjlcmT?=
 =?us-ascii?Q?T+/vgyQXyAlurmvJkm38jmYxUPr9PCR7wOJvOKC29BlvOhe5N7/fBVxTGolL?=
 =?us-ascii?Q?0WABNmFNbhrO4Fp9Xi5dMCiAzZMgxNoy1yz2jxRQWm8u0qVl5xp1xqrE/BPl?=
 =?us-ascii?Q?MtCcBJNcz/9sjXUmKUSnHQKmIkItZ0Gc6zGcsCKJd1Zuds9IsDaERE0wMRn1?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1531236a-9d19-4211-6dec-08dc4f081319
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:47.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gf84FnfnzkpyIrmswrcBLts8mO6yyTzHR5G5q0UeeXUlZmKrreFUeANWOiyHY/Shg2WF9+71H/72+xy0qF8RrBkmZyzGro8SDmBLfJ5X/Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Bridge address base is common PLDA field, add this to struct mc_pcie
first.

INTx and MSI interrupt code will be changed to common code, so get
the bridge base address from port->bridge_addr instead of
axi_base_addr. axi_base_addr is Microchip its own data.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index d9030d550482..c55ede80a6d0 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -195,6 +195,7 @@ struct mc_pcie {
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
 	struct mc_msi msi;
+	void __iomem *bridge_addr;
 };
 
 struct cause {
@@ -339,8 +340,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
 	struct mc_msi *msi = &port->msi;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long status;
 	u32 bit;
 	int ret;
@@ -365,8 +365,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 static void mc_msi_bottom_irq_ack(struct irq_data *data)
 {
 	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	u32 bitpos = data->hwirq;
 
 	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
@@ -488,8 +487,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 	struct mc_pcie *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long status;
 	u32 bit;
 	int ret;
@@ -514,8 +512,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 static void mc_ack_intx_irq(struct irq_data *data)
 {
 	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 
 	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
@@ -524,8 +521,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
 static void mc_mask_intx_irq(struct irq_data *data)
 {
 	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long flags;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 	u32 val;
@@ -540,8 +536,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
 static void mc_unmask_intx_irq(struct irq_data *data)
 {
 	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long flags;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 	u32 val;
@@ -896,8 +891,7 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 static int mc_pcie_setup_windows(struct platform_device *pdev,
 				 struct mc_pcie *port)
 {
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
 	u64 pci_addr;
@@ -1081,6 +1075,7 @@ static int mc_host_probe(struct platform_device *pdev)
 	mc_disable_interrupts(port);
 
 	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	port->bridge_addr = bridge_base_addr;
 
 	/* Allow enabling MSI by disabling MSI-X */
 	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
-- 
2.17.1


