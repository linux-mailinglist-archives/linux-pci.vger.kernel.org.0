Return-Path: <linux-pci+bounces-1787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11897826C25
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F969B20A03
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288E1426D;
	Mon,  8 Jan 2024 11:06:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2042.outbound.protection.partner.outlook.cn [139.219.17.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEAA20323;
	Mon,  8 Jan 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BODUrkhU0N/ylHT5ewSAdQkJg1O9VA0c+jhv0rAv3ulmjoEAu10aiON2BjNY96RhZk6aAX7g2V6DuxhlyiSSc6+3Rgi/41TjuZx29TFOBwvasEZm3nzge+8EazyYSgBly7UHT6Zl4ckdHO2oExArh/0F06EhWm+0Es0aSekhXyqEY2AyTL8URNcalEY+WuLxyB98wMv9rnlUEup1QokhO+3D939DR0ySmqYriSoKy5b8TewOf2PxQJjJ1qw+9B0NpPTXYLCKN+1zC7LY6CEJBfnI+OloMoru9U8gNuM/CD+2SCjROnPThaAk8sF0sGy2GuSfJc34w2Edp21w22Q1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx5Yb/mH7vkRlelY89RpGgyd0V1vSjgcQXjlTiRgDK8=;
 b=WbqQBrxfT8esIYdtfth1tyjgsq/IUpqysX6T5pamjz+aLq8C3Mm7CiPBlGzNcmtS3neOctDJt4tDCbtUuHd7cLEM/VQYnVaO7DLw1R5c0dusQXRFnkvhKuRZzImnm/Bbsx3Mh0CKKtGFH76HuEYeErWp3xUmsrB8+sWUfmdklkd5HBjTfq0/eX2mMNGxiaOJ/gGNfnpTdum3svjzvWHwBkoPjvgan66mKdHkwjq3pqSoevHs44Uc+3D0JjHOLxyXMa+QcwIsUvzbQc1JePkc9R720/g6NmEYqzPll4xv8SusHnhUGfYoxGlZMdicNjpGMqfsVWezydU0yCzsyeYscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0701.CHNPR01.prod.partner.outlook.cn (10.43.107.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.32; Mon, 8 Jan 2024 11:06:30 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:30 +0000
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
Subject: [PATCH v14 04/22] PCI: microchip: Add bridge_addr field to struct mc_pcie
Date: Mon,  8 Jan 2024 19:05:54 +0800
Message-Id: <20240108110612.19048-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108110612.19048-1-minda.chen@starfivetech.com>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0701:EE_
X-MS-Office365-Filtering-Correlation-Id: d69c881f-2a77-45d9-e1d4-08dc1039dde8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LlRXAkzP6esPo1JGDsT8mo4Zym+dzUuuZEFWIjkP3a4XiGaHHXjBPnmHhQjEFko17uczJWPGNV7d9G26XnxtaAm58XX5FpdRbY+p8N04LOyXwngSCDCiipXwg1a5gGkHt8BdQ+1HSFnxqEPrvvMpFnLqaVt+dgoyLIlj7OCgu7aV684i9C2u74xBM8puOamwZ0kmh3x9fMzHy1EiVtK/YvGgjrzNoGHrVmEn0enMcAq38Y1u952CgJcDDzfU/dNlixksPUFiGxrR6tYAb10bPrGCNACWdkAmL9mtqeA34RzIVLDm1ywKHv96v8ivWjJ/0VB+KsLwhs8T4d4KU3U3d5ljYhvTisJvkCq7tU9FLVUYpyRBCEdGUwSahgnWOltoVNDFqIbaHwK576kZIsCBlihqV64O3QfilrsQN397DOifSc+9dglbrIihv1xqL8lzBQBZPe9SBNwsazF3wDn0QydgHc6+bohb8Rr6Ezeixq/f0JdZICpHwqqhTOYHqIjwWafcCpQQLxqefZfqDkWg3XktKaEvw+WCijn1HpEylcTZyc9RWx/czL2YJub2+ZdM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(4326008)(2906002)(44832011)(8676002)(8936002)(54906003)(110136005)(66946007)(66556008)(66476007)(41320700001)(508600001)(38350700005)(6666004)(52116002)(2616005)(36756003)(107886003)(26005)(1076003)(41300700001)(40180700001)(83380400001)(38100700002)(40160700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJJopD0hd92xIXw1XeoVFqXZVytQ621YN99/G1hklruIsgCXu5eMeGCUyi9a?=
 =?us-ascii?Q?eVUM3G6ZgG3D+qRyqkQYe9Em/rD3WZ4oiwr3g9qfRun3khuMl6dJ7sbSUgMI?=
 =?us-ascii?Q?uBhGU4dFi7o/x+9zRTcydsVbOW2DFcOgCxJRE+5R+jZg1leIR+qeSctBy99M?=
 =?us-ascii?Q?OtI/obIbjeQvftwNt/K7+S8W+ZbvhoQhK62fCNnHa2A/M6NSCBUopEaQVeDQ?=
 =?us-ascii?Q?r/EZbtbCr3wdirlR46mOVMuMDKxuJdcM25F2FWLcqiNgePXxkfLqRlWVzMVb?=
 =?us-ascii?Q?2lEAVcKHP8pfGUHfCsaR4ofdE0V8/eV2lrxz1dvh7j6x1zjepvALYMhkJBlb?=
 =?us-ascii?Q?AR6cKg/0z4fsjI5trgWUQFER+gnX5KK6/UephwjWSP+YixCkkTIWQtTsMe4r?=
 =?us-ascii?Q?EuUyeTX/QCGC5gOljWzvrO76B/X3UMqxjRufMg6D6TT3hDusaim64YpAwj7Q?=
 =?us-ascii?Q?DP2N3wE6tJZiP4Wa6mL4F1TlicqkNQ3gqA1aXHtXDlL3kN+/tn9IlviRwyZK?=
 =?us-ascii?Q?YqBQ5+5ef0xCol18W0d2wzy5lXNJHigZdqBoW2XulVSQW+6NBJQ43/vg/emu?=
 =?us-ascii?Q?yIdIro+okXZYaqGXmOPRJjZiZnyP771z/vpIq1xC90OiqDpaxJUdxDkvREO0?=
 =?us-ascii?Q?o9SdNKJAm90PuuXRhscWm2yBfXbyjHB9eFqaOoH/2hCnKmWBYMko3gD2E3aD?=
 =?us-ascii?Q?OHxMWcd2Z2LstLiS021i20CBKtyza1mLfuJw+IC7Q7hwI+CBGTqJY+OfZHFJ?=
 =?us-ascii?Q?hlaOumgQ7VBmt761fk31jlTNNS7/FhR6L2VEgfNXzTawZLNiK56v7VKwGmEx?=
 =?us-ascii?Q?E9nEhqe4G/R6b3mQNdrQYm43AhlFhOiNcIDaVkMIkYGjQEQYixO47PCXFtK9?=
 =?us-ascii?Q?VeD176gP2IhbafWxQJG2XJdp0QpI/wqlQvbadxfrovhxXNedEsur6LFFvoFI?=
 =?us-ascii?Q?iHM+ord/14dHDo28OmmHUCz3PFcrJEuONanzIXCNyPCoOTItsvrlsLBTd4Jn?=
 =?us-ascii?Q?zty0NcAfzAK0OS4Zt5klsBt5gibbERCULMcZjlkhfSj9ywD27AVZS+X2llKz?=
 =?us-ascii?Q?YT4L6jgDYNG/WRvCMxgCvhQOp7a92ZHUHhSJ0MWgMemis4ISD/yL/fk89AM/?=
 =?us-ascii?Q?MDwFbJnTTWAvHaX1ChiDaep6uSqiqrtV7xRHVDqSsboOXnpg0lsBUkkFjysa?=
 =?us-ascii?Q?ajZObxfsUaL6MXjjQcfLdfmWGVF5UOpVed6l0q7sE4wdFcO5PZJVQDfnsNCw?=
 =?us-ascii?Q?hrzl0t0WLZKMRHIxTwUmzHyJnVU1wJCbiaWI6RiQw+h4crOh1YhLDRKucgIX?=
 =?us-ascii?Q?s2ZAYJiWZqIBIKX21GeUw/7Fn790hP96RQSiOTy3nfNpffZqgNNRTaw82LKP?=
 =?us-ascii?Q?OXxzn/J4OISUtShfHrKEsME1SgNelUe/2yEPV9SwrXjsZDMLmfj03r+3ePej?=
 =?us-ascii?Q?6OAbEy7ZIj1/46v872GJLIAyeV15w5fE5P3ivoQdC1prfMnyDdmDgMCsLhdq?=
 =?us-ascii?Q?woCUScmtYmCqtR5VQs+JRbs7uIQYYmM4zxtfMfzw8LTpnZdc8MukVMuJ0JQn?=
 =?us-ascii?Q?ZlGvChfykgIDU4bjbovIeHWjFYUnUjWPMs5PD1HmJQNNzNyaPHX2NXiTjYyc?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69c881f-2a77-45d9-e1d4-08dc1039dde8
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:30.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4owNnNre7KIBa3J+FQS69MsqZukZf09dBStXuzILp/AcW8MWsqn9lF2aWPrIzP96wnIU4+Oj4GCoZo1ZAQmg9wfkhOgdiGG+vwhVxk3mPA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0701

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


