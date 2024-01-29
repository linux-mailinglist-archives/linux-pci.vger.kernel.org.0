Return-Path: <linux-pci+bounces-2673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4946E83FBAA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C659828430D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023ED268;
	Mon, 29 Jan 2024 01:16:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2084.outbound.protection.partner.outlook.cn [139.219.17.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5583DF55;
	Mon, 29 Jan 2024 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490973; cv=fail; b=XwaueSaLR6Ksk0wPK2bvxW5uXJQHisIcThqNMIKhvPlqzxmd0+/Za9i9oPk6r/A95i9u6nujOPQ7ycqYC8sVpG9bIn5Hlyvb9aLzOIBfoHt6E53dcG8j2VQoSmnZYEKyjnRJgyA6jhC/JdTR5MyI1tKbbiKaoOkTHFnb66gPuCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490973; c=relaxed/simple;
	bh=Jr9GqF0VedirT+pLXfWGwtgNFSVamL87RXSJnlSv/Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anaQOPzB7BjHKBAjd37GSLXMhPZONo8wgW/Yz9E8XbtEEV5QvK/r3EYzAx892cHX7plvbBiXX3UQJbB2O15wSRcM3nSHi6+PoCBa0now7gEtD0EFQJCZrtrqUhtgetzlv6I6+eFkIRmWem74H9+jWIwH10kCDtldTMZ0dTDLoUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXjW/5vDuV8iHPSYQgt6uIbfOukPGZgaAM4D+ZVOERvEXJCSg0GvGesBASmtZqoQ+ZwGsbeiew5re/xvYGQyUozzIXaz8xxM21a9ntcagBKNqpTQFoiF8OMg30II+rvQa7mGmGR9SIOtGopn4RF6A/u9d63GDgOkoF1Wr8ihz6ZLncCLnQGqbjE9mATQLBvUgdbrvVL72eYrhVwH+k85DqobDylLyWLIBDLXZmLYCXnHw6xaTPyuo/4CKeM4Jghp+/pGHKqWvpHId/Cs+tY/Y3K8DqSBRyrv+4DK62biPiT1iztvokE8NjRegLLD2fzFyMKg4016CmFki+ULVo0iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx5Yb/mH7vkRlelY89RpGgyd0V1vSjgcQXjlTiRgDK8=;
 b=eG/m9MjlzG6UOe4l7JFM/MueIX1J+RZr/3I8kRLNe/tQgGonQxCLZzF0OJ3J1IU/xm0vh5dxXyFMx2fID0gXkFDKo85Cwi7Q/iInBZcA76EERtebOTZVZNeQFkVc/snb+e98mFHq3cumwOL7PT5gIoJZ3setzmYI1YsscMsfeUbvJZzsSj4UwGW8/Dqo/yE8KNKJvVbnHmgafoiEon9EKmzVzsUaa/1UGFPTRkUIKDuXmv0ne7ChU5bzmUrrMZAG32QUgrGSuynL2L2WvK9rohrk8kYEoyfo+wGgjltBOeyJO8Zx6rSP5M9fPEiwRhDiRnCvcPvz9hZA3qsult6wjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:00:09 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:09 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v14,RESEND 04/22] PCI: microchip: Add bridge_addr field to struct mc_pcie
Date: Mon, 29 Jan 2024 08:59:49 +0800
Message-Id: <20240129005958.3613-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129005958.3613-1-minda.chen@starfivetech.com>
References: <20240129005958.3613-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0630:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf03b02-de5e-471b-a3a3-08dc2065a398
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rNHi8eq8oWESFD8FUt97KUJtxkUBxq3iv5JES4EcFkcWDhcLb8CQ1j8MXF9frOcA41fWk8HrkfJ49xNmZPSunkqPPkmMWH+q2WQ8Rdry+3GSs5tfDPW7EpNNoF74dBa+ZxJAge+8RRmxQmu/xeApZdN3Qw0C+/iehtZNWas4nhOxV6wkyzr3Gdl4yDtfNDbLLLRwRP+bQJDGLlk5lbIEbmGN4XpGBKxraB1skGxHrtaqDaBwNpLOJ75R6HPIrF5xaefhylP5RecD7FDDL4xDaaTHhjbIMwcXF5Nqivf0pEShd6qEPGDbpP+i8i69dKSBJ/lGctDwXCT/ygJ1UnZUilRVuuModA+IUhER4OKEa/rqCRMTsW6sNpPH3DJHGpqp8OmU8MQnZPi3zwvDN9dD+ymmiMnqotutv52Zv5AR5qsRJLBkKa1A5JqzYYZm7p34otpiEWIofRyYpJc5Uets0YhAmanSYtLBvNytAmT70ypaFlfvBm2Ns2hqEabhSVQ35WhSaq4i32as90giLfIUFZNc1DxNa0Akptd7FL3cD1YUIVMnls1dvqa5q9oBZvnk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ht74ElwsQXFWk8h1nVugZmN2s9UdKSxQDzrAR0gn1GVm3OKc5v2khFPTcY6m?=
 =?us-ascii?Q?QDadCghco2mWxbRMjMdbkzGAgNZ9ySrDPPrIHSqePcGvfbTS+nEsW/i8dp/h?=
 =?us-ascii?Q?/W62Caml5Tc/C86OAOtkYrA04B9G3fXvyX8UcGB/U9vplOeQTYr4+K7Mww5N?=
 =?us-ascii?Q?jYr7zWlTbFfA4ZSHg8E5l1JrOntSq+WDMujBzQNqIsaDHuGROXrgOmbUMMvp?=
 =?us-ascii?Q?fUCuLMzRUPeaKubhQouT3VTwxvtSonX9DN3F7/DzXqppJTQkIkayHM2T6Ut8?=
 =?us-ascii?Q?FMjkaTe3ltSl+9XOMc0QUVzJkywG3XwcFQSSHUxSiRgPda3uU0sQsrvkkUvw?=
 =?us-ascii?Q?n5cZYFGR2fx3QdxCwChrwW7Nu7pwG6P45pMG3vYxMKG1dC/vUFOtwWFSsIqY?=
 =?us-ascii?Q?wbpwKON6LD5NcwxOGLPgNixvIRKbns9YoXH06S9ZwYC/UuSGHA2SlsNMRfVR?=
 =?us-ascii?Q?45bh8jt3T+zEHFmf/cDLC6cO0ElFJJ/+yjZorW/KwSWUYcD4NKzy106ifEf9?=
 =?us-ascii?Q?OvITgWWLJangcjrvDthwHsQ+XHvPx5Y59pxuCA3pPKrHnnyRGPsZl5EplI6c?=
 =?us-ascii?Q?QRAJ+DETPTzzB7ISCCNxCdaVnMjIgTP7V1vQTR6caQXiluhMo4ijLQ+WNyMM?=
 =?us-ascii?Q?15jNq8lxxMzqSSsOoM/qJHpJAJeIlaV+z25tt06Q5nBU2mBdDTvb1UhKe98s?=
 =?us-ascii?Q?atLzrzdl2HmMdDH01VROWxb23/dk5R1sMCVlcK+QX8msrHJjsTtj7/sJIIMa?=
 =?us-ascii?Q?0c6s7fsgkkNRerkXgV7RA/7C3IfGDgQAmcaTaZEMTsRSPRnjgfORq+1RRSGl?=
 =?us-ascii?Q?NTz+mQ95OlX6zRd5VMz5HwT5nV9LN0x/xtuUAcwA96wVNpgjmkj2PBNqqGgj?=
 =?us-ascii?Q?Ao6ejdxYSvmtHgWn0LZxToAz/FujgyZwRtb0mID9cOQVWgo8QTM1qItMDIz1?=
 =?us-ascii?Q?UCEFzT7tHw1FxZa98IhxIh8hwr9sgFlUvKqd574z1LRa+qVbZ6eWLkXf9H0I?=
 =?us-ascii?Q?Lca/JM9t/ciD/ExpUMyF0QWdUCsG3GHBJn1QYxhD3pKcQQ1JoyT2Jxr79uyb?=
 =?us-ascii?Q?wORD2ylAmz0RKxDxhoQTNYjLL1wiAmwODtuZkyxQHIySk+AcjkkyAaIRSiRX?=
 =?us-ascii?Q?TFu6EFpXkRl6ffbIitSlftlyA+cML2TIB7lsBK+CvwIO0PY/2pItvXEwJ0Uk?=
 =?us-ascii?Q?wmEmudQRUYn+9lA4LlL2qH7nPWj7H++8PWYgFw3ibwNrLFnCfu2eSEE7IO/R?=
 =?us-ascii?Q?vw4ILFtwfZET8qwrNTMLXXFf3idsgPe3AFQXcUdK9vH7FP0pZUy5feYHaJjq?=
 =?us-ascii?Q?zO2nfo/amXuZfFl0gC7NN/wMxigRq2GNmJVg0ibxtC9jedByEehAlGpUtpXF?=
 =?us-ascii?Q?WLPvZm3cGG9uH+aamUas+g2ZPrBiJd2jJ19v5sKn60edNdXGFST8s6JxeRDh?=
 =?us-ascii?Q?TcC1yFPZQ/ZzfR6MdC37csxMLgXEZ88UVmze6O7P6FBqjeKyOcCQgtQOACUS?=
 =?us-ascii?Q?QFM1tnvM7lRho3Ya6z4f4uYbWJysjn3Lnu6XF3YrsaPSbkwo3z2liVlWmxo8?=
 =?us-ascii?Q?1FPbbAnQ4BVVqMl0f9WTUxtuYslOhWlhbn6zHR3wO3+J1vpKC2MRXOkxKx4y?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf03b02-de5e-471b-a3a3-08dc2065a398
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:09.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xx1M8mzu6HZOqDEOpGFn7keA4rmJ1n8xrsLIeT5EbPEIj1s1FvZg8SJXNiYs6g4hetgst4n8JSHlXEX0M7YktxJJ4hpr98cMGX+c0vCDiuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

For bridge address base is common PLDA field, Add this to struct mc_pcie
first.

INTx and MSI codes interrupts codes will get the bridge base address from
port->bridge_addr. These codes will be changed to common codes.
axi_base_addr is Microchip its own data.

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


