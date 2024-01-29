Return-Path: <linux-pci+bounces-2682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4183FCCA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 04:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760211F21B92
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931211737;
	Mon, 29 Jan 2024 03:35:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2078.outbound.protection.partner.outlook.cn [139.219.17.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD1125CC;
	Mon, 29 Jan 2024 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499327; cv=fail; b=q7Eenelt7pTbE6p1NoJv3MO1DQujG47SJg3WZ1k0oLiUlwJ9OjvM5YhsWbnYSBqjp/DGOvKgOw/4D+1UgNi9u1OOqloVD0CWmmF+AevN+g08s5Ue6SgA6bQbAkUh7H/Quw6iBguH1vaEzpMGakqtns1KAisB4SN8N1/2scih3Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499327; c=relaxed/simple;
	bh=22WfnNEhA24fGIAnSj8FnGthhV9+MdctziwxO7auJ7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJ0Gzz+SzoLXyWp4pdS61DxcWSVuKEdLvtkOLpZqBLQi/L/xeLrJq07jYYcxD7y3mnhaZPOCa2uKFk3k6UkZlhMysotJvwShMY4zq7dTH0hN+D1UcHil3ZKYAr+RDg0CgQbxrkKgwuEmWW7GU2nWcqVoxGEDL9NDijgeFY4x2po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ9gD+O1+CqEK6nkncwtJn73kfIGGetArHB1Su2Q4LbYH1ribav7ai5VqQhi0f/KmQ/SkMq+y8DVunApZLkYx73aGG5oQHnkwqB4dR7sM7B5lQ2Fi+L3g1+FOZ3rjhKYw18/T1qfa+8TltqtU/1Y8gYNUX9Jgy+0osiXlvkvgBPyqnt0hxUjSWhBGJlDVtNJBNbqMioBLN0yTnh1rpbEPh2a7MHowleODd61pRMTCqFDy/oC0VHsHQxIa6Hxsa5658cUdQeihtyFe8eE01Y73FfxVTKnk/ZlTjvZqwfrT7HZBZS5cHwOIn4mInDdUkNbAe2aQrua94Etg0WCLbW/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvgzgZ+kCWJDW3yTlipB4uET3HJVJTZKxQ2LjTr36CU=;
 b=WTjXcpygRUfCSbZqYr0ImwWF63lNXOnHEeqqYtYSeu9MPUF3jwCD3NByPt+u87D8oyx8QqdkCjMaEMatWdL+rV3AkpVMnh6LfNu7L5gSGQ0C6ekIJ6/gL+xZV4psXKTqDtkXlW7RgDAYdWi5BUY1crjYiidSxC0WglKJNJeJaH4eSLvaRXOOs/EHU/X4KbB7bk8fkzeurMcmtCxg11t4jv4+q4qdSiTvgJMxk10Ht0ipMUs+93CBbC7jaEyvDz0th/wk6LwwY83DQDssKyAQ5pXuCcm/TYvIm5dkcuXV4C9HvkRcpMQNc9Q6TyTi2FCAX4YqX+fdZ0UJhk7pm1xtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 01:00:17 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:17 +0000
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
Subject: [PATCH v14,RESEND 10/22] PCI: microchip: Rename interrupt related functions
Date: Mon, 29 Jan 2024 08:59:55 +0800
Message-Id: <20240129005958.3613-9-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0552:EE_
X-MS-Office365-Filtering-Correlation-Id: 52144970-609a-430a-3c20-08dc2065a8ba
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/HNTBNLw7etFyc+Yb3v5SIL6sVdLPAtjnMn0JqtRy40hb89ZZzjeHKzoWHUsoxjx/5O04IweSixuQZgumAM8EjbYir4V4WqSNxkBBOShUViiLCPxbAaWw4SiZ7KoMkWjbxV43s7bMQoRI0eQLBseMQKqixK1pT3y0k6tNTLsPmWvLP9WvotlxLZetwo7BY8LOjfuzhAlHQKMb2buBTlwAFcNILspCxQxQmTWEsAPO0pBKZAWOP0+PgGfMqOLH9q/dwk/cx+LbLbYzeiw5GN6wG9H+XU2Xj6QAmqcGTucUhkG4Rn/3tORzouB9JL76/pbJsVG2+qboIkXpyzGPIWxHUedTHMFiXl29SUjUpi9BIyfEZVW7Qz8Qfal6xcHzX8q57ATNqIq4JvJu0nOhbvR4xpn5PUltnwetCO+lDX5Ed0Wf3xvcplH6GGwJJXJZGsjZUsTBfG6KVAYzeufY4MNdoqkJrvewbQJ1aTno1EFfXc7vfm7AKI5RfS/6aDp6pUfpyus5jdsnuux4hh8prmWoQwBE6AOL5Q7TEqbsHzV4/tp4LbceAwcm5zX6uxgAMrz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(2616005)(1076003)(41300700001)(26005)(41320700001)(40180700001)(40160700002)(38350700005)(508600001)(6666004)(83380400001)(54906003)(52116002)(36756003)(38100700002)(2906002)(66476007)(5660300002)(8936002)(86362001)(66946007)(30864003)(110136005)(44832011)(4326008)(7416002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vu6p7Vzo3oC4aagm22xgn43LqUpKUxHBmpvC0DDHGeDl/kOf72EEFjp5giZ0?=
 =?us-ascii?Q?6IJuQ93L42EZF+JHuJZwdQGUIbo+uuOVbGhMG7PKBpxI8DddrSiNJQ38GbcC?=
 =?us-ascii?Q?sxddEyz7ahIN4+HKkrcjB9Jz27cRH4aIVzJhffd4+fFU9eXpBKERIIPEsMsJ?=
 =?us-ascii?Q?FilX6dlYmo69tRSCbW8twgPazO2dRyg/ydeIYcLAM4PvhwsyKZYUXfMfst09?=
 =?us-ascii?Q?Pi3ZW5WN33BMvVI7mkBzp0425gI/P9cl6lIbeBrsQzN2h6sLL6PfdZPSiL42?=
 =?us-ascii?Q?1CVurJZ8bQ1lIm+4zB8nIbu0A1DR+5+gwTWkgjM6F3z4CHVdWSYfbgeghdom?=
 =?us-ascii?Q?dLi/bUXEDYhILvb/GWvQ0J/eR6xtCjz8M/wEiPUv4UIW8zjPn15w86BBnQMF?=
 =?us-ascii?Q?si54rfi5J5503CBgkphtNo0SwUtIjgGX+TtVTQye7wgtXE60h+uvfB3HPq9z?=
 =?us-ascii?Q?Q2NaUtzK9gwJB1gYsjQvoRPah4/6JoeEsRqDnSUGZQG9mB+e76jJYkpTmxkv?=
 =?us-ascii?Q?Ie4AovQ2o35zlKJ3lAbZv289fsCTJskPHncbktL/vMxVozVF5HZ0pDDYE1XJ?=
 =?us-ascii?Q?QWo1GbyWEJgHFljBMBKad0MPaUhL7+MSS/JStUkO+qBcORjMQZrjhrS1wSjX?=
 =?us-ascii?Q?K3CNB7Mf2DBFWUagSwezc4IgTa34NjN+WlQcEkGcRUe5l7KANgiGaDBVv3rQ?=
 =?us-ascii?Q?Fca/p374Ue4sqhL0XF0I4CwOKK0eeY7T39Q4ChZiy6WW66iYWDWG9JhHay3M?=
 =?us-ascii?Q?Hn8JN3FdC10GjPl6muXNtGn83E17Hdp+8Qjxwj7QYbqHvMbNE/JeTRXzsiy1?=
 =?us-ascii?Q?90Jtc4rwYCgtLo8JRYlsEHUEp2qpW2IILqtaDf6klwauOulrrlPAWCXFyp+l?=
 =?us-ascii?Q?cALZOewtPGC3CFlEFTTpa4OXjsTOrRgWslTE/bVY+WKIzl7rUXmY3GkI7Yke?=
 =?us-ascii?Q?dmFGXtfb3Ub963lpfnbFVgNdu5KU7V3d5moduQpQwmQ9FryoT9fnXT83PDm5?=
 =?us-ascii?Q?2ldcLC4BNeLhx0xqMpz2HCRm5jS7i264R11kPsll16Iyi9KGJ+zvATrq1ocX?=
 =?us-ascii?Q?AasGGcabLhrZAejxQJStezcfRb+orvEwSEwnnVbtHvjZv8P5V95ssKolMv0l?=
 =?us-ascii?Q?p8Brd/buLMjx/ry0gqWXxVpqM15ppP0szHVqeln4SXhl6q5wRTFQsAuGImGD?=
 =?us-ascii?Q?q4WZkqT7LBQgQxafGFxv6AxNP4kQGgNh6GeMboldenYF9THxWM/OCBS98G5B?=
 =?us-ascii?Q?FW3TjIo0Nz5kCLfNmwgn5yYmxUfgxOLWTqYAqwolWC2kX45etE16qnwqqXXw?=
 =?us-ascii?Q?54wpxi18yeHHeybg3J4RGHqpt8SinYghWrJjK4tfvOyUsKdmWUp4AOyzJbAM?=
 =?us-ascii?Q?nNEQBZQpdzvW8YE0fOAPqTUMPkBisIza/gF30d9010p7ZlU5pd6FrEfaQTEK?=
 =?us-ascii?Q?9YV1rqMwkXyjRohJDUjqbpiC7z4nbYtOToUC9KuG9FX7GJKvhLS6vey4P1tG?=
 =?us-ascii?Q?KyGQXXzrUHH50s61vN8/hvupNgDB5pJDSlJ7/vTQ+qlKIgRW+dmnQVzfgzwY?=
 =?us-ascii?Q?mdSB10XKdxgjCALrzAsfTO2p0NT1cYVHz6bIbQgbWtRFSHtdm0wUW3otNx3F?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52144970-609a-430a-3c20-08dc2065a8ba
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:17.5205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdwvwRkc2GeBiQrd2iuf+Ne6e31MyIXOkNAMi9JM0nYEn9aOhNBCbuF536ln+kwI0uHthCUWxivxCMb97zC6Alt+izh3G4p8xnxTsB7ZMvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

Rename mc_* to plda_* for IRQ functions and related IRQ domain ops data
instances.

MSI, INTx interrupt code and IRQ init code are all can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 109 +++++++++---------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 573ad31c578a..18bc352db389 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -318,7 +318,7 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
 }
 
-static void mc_handle_msi(struct irq_desc *desc)
+static void plda_handle_msi(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -346,7 +346,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void mc_msi_bottom_irq_ack(struct irq_data *data)
+static void plda_msi_bottom_irq_ack(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -355,7 +355,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
 	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
 }
 
-static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	phys_addr_t addr = port->msi.vector_phy;
@@ -368,21 +368,23 @@ static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		(int)data->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int mc_msi_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
+static int plda_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
 {
 	return -EINVAL;
 }
 
-static struct irq_chip mc_msi_bottom_irq_chip = {
-	.name = "Microchip MSI",
-	.irq_ack = mc_msi_bottom_irq_ack,
-	.irq_compose_msi_msg = mc_compose_msi_msg,
-	.irq_set_affinity = mc_msi_set_affinity,
+static struct irq_chip plda_msi_bottom_irq_chip = {
+	.name = "PLDA MSI",
+	.irq_ack = plda_msi_bottom_irq_ack,
+	.irq_compose_msi_msg = plda_compose_msi_msg,
+	.irq_set_affinity = plda_msi_set_affinity,
 };
 
-static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs, void *args)
+static int plda_irq_msi_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs,
+				     void *args)
 {
 	struct plda_pcie_rp *port = domain->host_data;
 	struct plda_msi *msi = &port->msi;
@@ -397,7 +399,7 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	set_bit(bit, msi->used);
 
-	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
+	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
 			    domain->host_data, handle_edge_irq, NULL, NULL);
 
 	mutex_unlock(&msi->lock);
@@ -405,8 +407,9 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
-static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs)
+static void plda_irq_msi_domain_free(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
@@ -423,24 +426,24 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops msi_domain_ops = {
-	.alloc	= mc_irq_msi_domain_alloc,
-	.free	= mc_irq_msi_domain_free,
+	.alloc	= plda_irq_msi_domain_alloc,
+	.free	= plda_irq_msi_domain_free,
 };
 
-static struct irq_chip mc_msi_irq_chip = {
-	.name = "Microchip PCIe MSI",
+static struct irq_chip plda_msi_irq_chip = {
+	.name = "PLDA PCIe MSI",
 	.irq_ack = irq_chip_ack_parent,
 	.irq_mask = pci_msi_mask_irq,
 	.irq_unmask = pci_msi_unmask_irq,
 };
 
-static struct msi_domain_info mc_msi_domain_info = {
+static struct msi_domain_info plda_msi_domain_info = {
 	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		  MSI_FLAG_PCI_MSIX),
-	.chip = &mc_msi_irq_chip,
+	.chip = &plda_msi_irq_chip,
 };
 
-static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
+static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
@@ -455,7 +458,8 @@ static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
 		return -ENOMEM;
 	}
 
-	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &mc_msi_domain_info,
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
+						    &plda_msi_domain_info,
 						    msi->dev_domain);
 	if (!msi->msi_domain) {
 		dev_err(dev, "failed to create MSI domain\n");
@@ -466,7 +470,7 @@ static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
 	return 0;
 }
 
-static void mc_handle_intx(struct irq_desc *desc)
+static void plda_handle_intx(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -493,7 +497,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void mc_ack_intx_irq(struct irq_data *data)
+static void plda_ack_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -502,7 +506,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
 	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
 }
 
-static void mc_mask_intx_irq(struct irq_data *data)
+static void plda_mask_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -517,7 +521,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static void mc_unmask_intx_irq(struct irq_data *data)
+static void plda_unmask_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -532,24 +536,24 @@ static void mc_unmask_intx_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static struct irq_chip mc_intx_irq_chip = {
-	.name = "Microchip PCIe INTx",
-	.irq_ack = mc_ack_intx_irq,
-	.irq_mask = mc_mask_intx_irq,
-	.irq_unmask = mc_unmask_intx_irq,
+static struct irq_chip plda_intx_irq_chip = {
+	.name = "PLDA PCIe INTx",
+	.irq_ack = plda_ack_intx_irq,
+	.irq_mask = plda_mask_intx_irq,
+	.irq_unmask = plda_unmask_intx_irq,
 };
 
-static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-			    irq_hw_number_t hwirq)
+static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_level_irq);
+	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
 }
 
 static const struct irq_domain_ops intx_domain_ops = {
-	.map = mc_pcie_intx_map,
+	.map = plda_pcie_intx_map,
 };
 
 static inline u32 reg_to_event(u32 reg, struct event_map field)
@@ -609,7 +613,7 @@ static u32 local_events(struct mc_pcie *port)
 	return val;
 }
 
-static u32 get_events(struct plda_pcie_rp *port)
+static u32 mc_get_events(struct plda_pcie_rp *port)
 {
 	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 events = 0;
@@ -638,7 +642,7 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void mc_handle_event(struct irq_desc *desc)
+static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	unsigned long events;
@@ -647,7 +651,7 @@ static void mc_handle_event(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	events = get_events(port);
+	events = mc_get_events(port);
 
 	for_each_set_bit(bit, &events, NUM_EVENTS)
 		generic_handle_domain_irq(port->event_domain, bit);
@@ -741,8 +745,8 @@ static struct irq_chip mc_event_irq_chip = {
 	.irq_unmask = mc_unmask_event_irq,
 };
 
-static int mc_pcie_event_map(struct irq_domain *domain, unsigned int irq,
-			     irq_hw_number_t hwirq)
+static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
 {
 	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
@@ -750,8 +754,8 @@ static int mc_pcie_event_map(struct irq_domain *domain, unsigned int irq,
 	return 0;
 }
 
-static const struct irq_domain_ops event_domain_ops = {
-	.map = mc_pcie_event_map,
+static const struct irq_domain_ops plda_event_domain_ops = {
+	.map = plda_pcie_event_map,
 };
 
 static inline void mc_pcie_deinit_clk(void *data)
@@ -799,7 +803,7 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
+static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
@@ -813,7 +817,8 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	}
 
 	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
-						   &event_domain_ops, port);
+						   &plda_event_domain_ops,
+						   port);
 	if (!port->event_domain) {
 		dev_err(dev, "failed to get event domain\n");
 		of_node_put(pcie_intc_node);
@@ -835,7 +840,7 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	of_node_put(pcie_intc_node);
 	raw_spin_lock_init(&port->lock);
 
-	return mc_allocate_msi_domains(port);
+	return plda_allocate_msi_domains(port);
 }
 
 static inline void mc_clear_secs(struct mc_pcie *port)
@@ -898,14 +903,14 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
 	int i, intx_irq, msi_irq, event_irq;
 	int ret;
 
-	ret = mc_pcie_init_irq_domains(port);
+	ret = plda_pcie_init_irq_domains(port);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
 		return ret;
@@ -938,7 +943,7 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 	}
 
 	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(intx_irq, mc_handle_intx, port);
+	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
 				     EVENT_LOCAL_PM_MSI_INT_MSI);
@@ -946,10 +951,10 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 		return -ENXIO;
 
 	/* Plug the MSI chained handler */
-	irq_set_chained_handler_and_data(msi_irq, mc_handle_msi, port);
+	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
 
 	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
+	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
 
 	return 0;
 }
@@ -977,7 +982,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = mc_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1


