Return-Path: <linux-pci+bounces-5322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FAE88FB06
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604221F27D8D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2C5102E;
	Thu, 28 Mar 2024 09:19:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4E65BA7;
	Thu, 28 Mar 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617545; cv=fail; b=qFOlJVpDaqlaEVLPaAiMz6GoZA5r3I7erih1CWl9hHyj1cNHk44nzUnMBz3jQyJG7ExpI3qtpoJxj5I2xfjc7MOcl1m7RSyF/DuHXM4sLHj7qsYc/nXpmx9ZT50wMDo6TVkQe9ST1gAs2XXC3FOkhsyfRk0QnF9ZzxmC5PdpnRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617545; c=relaxed/simple;
	bh=/4PccNbWjjS+4Uc+iPMog5YcbODT2POYLU9j4TmmDl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJP3WSMFwmEpmwIT1Uudg8ZrExRiEoxMXhOkhgv6eIfop1Q16K46lGacej8I50OhFMKro0E/uF66HES4U4MImQHEeFukU29+oasBn/KQNou1oE67XoEp91oOdSxfjEVbOpLkfper4+76owD1cJw7VC/T9XzlhQZaYvjly3/3q54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3cvmYx0MyLmGfVCPRJt0H5yxV2rMt8EUP9juA5MflU+IhPhmN4thCWE8j+xJjDF+LUG3hTNYNOmxObjfp2jj5fQA9o2NeDj1uRsxxsYZuAAECY7jonhYmaQD2YYXfGlWm0rzRkGvvOZ1eps7ElOd04rvXEyjwJ5pkDSzO2ICUuDEy842+ZajaLBSKsLOOBf3wmr/lRDFCXLtxQrx/OIXm7u1yClJmG6Ym5e097NGIUEBNS1Ne2bBpzhIZD0o8102CgfAEOUiH/obV/guPjwo2WifSMHv+uArixVzK6S1XGGIQkIrMb1xUBZb6sIcEB/dAGWqiVF1XNhBg/TlB+ohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiqHj4APLQ+5sb97w44ol5KWqweOs8B8Tg2C7Uqvdm0=;
 b=dBMHehTHUD7kd0yWxo4O9O6H2AenbU6GcUpEY7pIMiPEUPS7eggMJj01d3+ezJh42nKPOHdjOxcxPtZdwLDeUjd9gEEl/Tkq45c04H+fpjEHHjrvA0jL71b7CIu0YoGbFd0mdYkeS+pBVBADCEau2AKJvrlW5N1YhZtMcTASMoJ+HgkZYGbfNB+7Zk1zbMdE6xL0fNAtXAVmNgyCXsBGmXio6GY22dSw2jLCPFF9QGB++4zM5MYEKUuv94sRQaDW7Td8RJS+4F/TRZcDGTn+H5NjkweEe/AZf8KKB5D7zxo8Mg2YV/4EEnQVhKz50gYue9vI1AprCnsjbrKmxHAxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:55 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:55 +0000
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
Subject: [PATCH v16 11/22] PCI: microchip: Add num_events field to struct plda_pcie_rp
Date: Thu, 28 Mar 2024 17:18:24 +0800
Message-Id: <20240328091835.14797-12-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0559:EE_
X-MS-Office365-Filtering-Correlation-Id: c27c3db2-0005-4c53-be14-08dc4f08174a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NQ1oB84fqURJgn5b0HHgd3Xt3a49rn1/s1/d9g9aPT+FLtZwPPqvcH/4rHvOTZdr+Fml6R4Jm1xUYRFCTcPMO/R8U6NBrgXIvOMKRbSN+odUN6x1DV66xDMpYT0cU9B2w/7UeM8JN2BJQN65Jv5n4ppdYhPdrJc1wMiTYEuhkivNHR/HN7CnHPjcmzk7E1z9BcCyQMzBxC0WMaOra7Z6zPkeqgQMNpst7nL1nK7bt9h3JcNPQ6v9WuTpM1JkprEbkP7JtHGkISGJrjqkWz7W6Lp8vnES4yS0JoNFjwtDk0CC5tbyRnOY3xM9AiLzoCqPr6wWcjD5eIzrbkkMwxXQI4UVNY033k2H56YY/9mzOjACMQZbFPXoepVVJl6OpS9IulRWBfvUilr09egU79OopnlCuJ85yq2aLTB+jWAzP2cFQByx1EiMyCLsjOhNS0oTESB23v1k47na905zkS4H5AuZTUIX8i8NwnAAdwBS0Lf7jrD+7h6IMV/vLNh/01INQt5CcWNJptExYIENZKOtbAe7HBey0WJayRh5ZAztTDZjb776NGHvBSDbXihBcy90Rn+/Nc9uIGPIMLFrlJ3gmj3RlmVIK96AZdpmny7xeggO7czqj03mqCPpSkonyCAm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKl5X7Upbu9oeJrwu064KGfO65CeeBo9hYWNUvovceUTLm+ZGo58eq/vrODg?=
 =?us-ascii?Q?S/83x+U4cSwey+WrfKsxDufwGT6zyvsMCHUGTTy27FigDPv4qeTwai2dos/G?=
 =?us-ascii?Q?q5sYkSNJBwiOHTVeYsbEUcapqYD7QW9yn80POHU5OZbSsYJ9nTCZ0GOMObDM?=
 =?us-ascii?Q?12sv5qKs6vm8YGx2BFZgOqRBtH1cnQYRd6qIcsL5y0CxxN5VMTSeflslY8gN?=
 =?us-ascii?Q?BhUV3O3TSN/TsFwzKJk+1O24lbQ5yZk62sCCl78oPIbRcwn2Ltp6fUm+wHHb?=
 =?us-ascii?Q?lpJZDrKLJMzPlaQOayKqKbFleJhKFpVFZDDccC6q3Rjm9xcVY3Q7oZ54geF7?=
 =?us-ascii?Q?sGCzvLrivwis2DKzE4QATEhcHorYRC2Cbh81dxGECH1IcbEq8dXB6kjwYk1/?=
 =?us-ascii?Q?Pv18yOX5vbOQ81mYXPPCOyxva3Y3YgPImn0dB9ajIzQxdt9a3Jn1+CSRSZmD?=
 =?us-ascii?Q?2JzCrLjtmZRamCwL2VgBR5b+jFsK7l1DAB1mw21RIQp2sQ6QJl651+ZTwzpQ?=
 =?us-ascii?Q?nrX6h+oGm9b7G1mEUzDOL/MOi4rBiJ9TsPuBc8x54Rg9KRrLMnfyy2M18H1t?=
 =?us-ascii?Q?t7K1qjIJXy5LfpU4t2QhK8mexmU0EaiqcHQbrYL2LYZcSZhkxftdNkAjrcCS?=
 =?us-ascii?Q?TRhVpQVFNJbfUbF25PtzEqa1/wsnakA2OkVlR3PWKpi+3mWRiQXhzQmitz63?=
 =?us-ascii?Q?hGPWmQCCb9Z2VZ9E37xJtArEcKPm9KO/deQWeow0odVK60jnwaX8S0GIoAvL?=
 =?us-ascii?Q?3Tyg/KrjZez129SEUyP3VeRmnBIYnJWA6JbxgxQwkiWWK/Ngc2jo+l6UrYS7?=
 =?us-ascii?Q?BYfQz/OLvEDRh/xLJF4nu3XdcGx8di1A1KbsnE9gmIinlTZ9cVcsUdPipfi1?=
 =?us-ascii?Q?6ecWYLwqebjtrv7ee9WmvZ0C/tyLmDiizFJiF7RGfcvKSzK+1V0xtwslhNwH?=
 =?us-ascii?Q?X8r9TGZiATqjGyLMdJspkXgbHzvZ6J4H8+4vnEipUkqYxuQZvJdZA9A9Y4ag?=
 =?us-ascii?Q?B7nYtrXGPXgms3fezM4LvIJnRz3vmrjT7rdEOQpi+2pNdkHr9xIBtzW3j6BT?=
 =?us-ascii?Q?RqrDGveV73YW/3fE52PxsgkQ6gwBAhUTL2ugOn5LUf4BMoWi08mh3f/YbO8B?=
 =?us-ascii?Q?wOr8AcC6GqN7vFOw7CxFMzBoN1zx0wqTWyCEIES3b1Wi1hgbPIOaAfuhTU6C?=
 =?us-ascii?Q?4Jvr4uM1ZZPFP7tukH6jX5ABMk3CUT6p61xaBTBjAABrjQFgbZPgMdcqb9Tb?=
 =?us-ascii?Q?Jo2IiCxinYXLKCSH73ChL2jMTXqN/E10QmLk6sIeZqqtN8VOem4n8J3VCm39?=
 =?us-ascii?Q?YeNAe/8Sv0wPa8wdpYTm+mszH4JaN7yivAcBNVqQfktFaCFupvwPqhCNKhzK?=
 =?us-ascii?Q?iknMkiNt02N3pqSjHCBh4afwtPsZ6z5xlfFBYEAG1e5mYVyr8isXrJpwcxUc?=
 =?us-ascii?Q?C1uPqKoxKx85iH/CGIrD6tWu0OmJ3DO4wXj7Efzct+OO2nJiX7cYGtCLVukl?=
 =?us-ascii?Q?N8lD9AlsZKYZaMGAiDFYISL14REpWWgeK1CnIepJK+VW1r3pl5lEVZx4kkUu?=
 =?us-ascii?Q?1gDlrK51nivMqbKu6hXteQGA+nQuOQrAp/SAgU7tj+I2FDLE8gy1vi94Tmf4?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27c3db2-0005-4c53-be14-08dc4f08174a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:55.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCqUTVSzgUeTd1HM4zUkERrAh1Nz1jXHo3gnykDfvXh97BBEy8fISY0lHGD2s/cuiEdr0BnrneSNinXfkY+Hi8MG014EDhlKcyy4vLuoefA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

The number of events is different across platforms. In order to share
interrupt processing code, add a variable that defines the number of
events so that it can be set per-platform instead of hardcoding it.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 8 +++++---
 drivers/pci/controller/plda/pcie-plda.h           | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 18bc352db389..0a5cd8b214cd 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -653,7 +653,7 @@ static void plda_handle_event(struct irq_desc *desc)
 
 	events = mc_get_events(port);
 
-	for_each_set_bit(bit, &events, NUM_EVENTS)
+	for_each_set_bit(bit, &events, port->num_events)
 		generic_handle_domain_irq(port->event_domain, bit);
 
 	chained_irq_exit(chip, desc);
@@ -816,7 +816,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 		return -EINVAL;
 	}
 
-	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
+	port->event_domain = irq_domain_add_linear(pcie_intc_node,
+						   port->num_events,
 						   &plda_event_domain_ops,
 						   port);
 	if (!port->event_domain) {
@@ -920,7 +921,7 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
 	if (irq < 0)
 		return -ENODEV;
 
-	for (i = 0; i < NUM_EVENTS; i++) {
+	for (i = 0; i < port->num_events; i++) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
 			dev_err(dev, "failed to map hwirq %d\n", i);
@@ -1012,6 +1013,7 @@ static int mc_host_probe(struct platform_device *pdev)
 
 	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	plda->bridge_addr = bridge_base_addr;
+	plda->num_events = NUM_EVENTS;
 
 	/* Allow enabling MSI by disabling MSI-X */
 	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index e277a5452b5d..f7e900b395f8 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -124,6 +124,7 @@ struct plda_pcie_rp {
 	raw_spinlock_t lock;
 	struct plda_msi msi;
 	void __iomem *bridge_addr;
+	int num_events;
 };
 
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-- 
2.17.1


