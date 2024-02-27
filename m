Return-Path: <linux-pci+bounces-4106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD9868E04
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0681F252B3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A11386BA;
	Tue, 27 Feb 2024 10:51:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E62F9D6;
	Tue, 27 Feb 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031098; cv=fail; b=jLp0FYBHmfZBOMzfNZl+lDrXIVuQx0LqyxYSjSy5QnEj8w1hur0/hBLlAe0fSj/3H6zpQ6uo+BKxWJtHg1I6KD3G+tcGX6kNFHJjsE3RI7FggDRAha2yNnZtXZSGE8nA8RpQGFOFz+fx0lJn0a6XaAaSHYeY4mWR2D/8fpgieTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031098; c=relaxed/simple;
	bh=22WfnNEhA24fGIAnSj8FnGthhV9+MdctziwxO7auJ7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XO00baN+ZB+v8g/lnX9+PbGi9vkru0DA4ONcibDuSXSkkNyJnqXK0AzzVItIBXRRdCl6UJ3J4WIZYs6K4+UwHIZOiiAl0F72h1OyW6OJr8QhByOgxgoJOl59zEV6Ktus37Jc2ncI10TPz5lFRvpEuljVofgXyNH0HrPLpwObcQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLrOth91ePiVvLDhT7zqre2vWmg8WYL2vJ54p0WMUarb4tE69Z5/A+2ZDosU+nDjQN1zYwDDzy84u3s9gmvBFCjcI1OcwW8Xndu4/iTkeqcHWwQlmLErzJniVz+wgfBaPKC9wjI5ykdjGruq47iHopoMR5aZyn1QN9BbiNl5DBpWv+pLaZQzKWKjaAuhXNyTs9KvugOTJG5REXQ/b1H9akmFvFrnuj0g3VjrWeuQklvAM2db3zSC77wadoAiylLjSujdoqpeNh49ZtK//lUaCIKhW8JyTswAdJzQLtqpeot8x/uz4HsJMSOIV01oDb2PDHh1nA6IbEADioPoAKRzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvgzgZ+kCWJDW3yTlipB4uET3HJVJTZKxQ2LjTr36CU=;
 b=BV6iJ6eBzyGvNIRa/jeL275pFkUdpYa8FzaKW+qrPGLi93nerEXxlqRIEeZwHuy4UHlMtfiONH5sXZBAOjdtJZ+AJluANHuEJGhl1OG89RhH/03uI4JVyP4NtfW+yuhDbzAg0dTNcr7OghnXP7cP63UjhB8SVyX0KtWULz3dxaBpDFnKRld2RBCbH7WIrrMrsOk1FkS7S7dIM8f1o1stzMntZHySgdFU1x3IhJq5au72Z6roUzFXVDjOurbgt48kXvo0aTwmh1m/40q+qaJiA9dZigz9yxTldaYnH+Tqfkl+vHkvgS0XUnz/GOGPGBuix52xX4aqkY3YzNh98FF65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:40 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:40 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v15,RESEND 10/23] PCI: microchip: Rename interrupt related functions
Date: Tue, 27 Feb 2024 18:35:09 +0800
Message-Id: <20240227103522.80915-11-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227103522.80915-1-minda.chen@starfivetech.com>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: aab900bc-bc89-4d43-f2a7-08dc377fd7a4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tPp1EEuEVIbVzIDBm8u+ObZh+W5o1A6Ih33mFQ0rY6Ij7bjMbHXuh8y7i67r305Z0dAsG8W0LLcmVVBIpO9BF1sYDbeTusKkbcKL5DX2vwDtFzarEF+VAu8ypio7Awpkt+WkAhv/FsykIsfPG5vLOyWLDzXiFtsHfid8YVl3HcKowX0hkdug44+QGhK3nbF0c1U6uCDlQakLcTh9ScsCZuKbmlRiSwrUN1WfzF19OrQYvl4J/LlDem3Bsmgwb570DlgnswYuIi6YrXrI6l5Moy0PNigQAWlAGkDlu15MEz5+87ANa50IWfDdckVsJVeRNDxKi8Zh7b1NmkQ2GQ+JIXC6YKnIWbOea7kkYUkUml/nWO2Tbl2mdU7kj2/qxi0n6F7uIYpIozup+iIYkd7vIYe2vajzyVqdAFTy+tiXMdlIQGfhveJ2Q2it0eezMpyJtn/RwkpMm3mZ9sfaT/NvlxdvtmkzHTNF+n3yhvz0a3Uwt4F/Skq4IAMK7bpcO9psKDwEUv/oLaMU8VtIFNQmp5O0PyRmCyhAk2Vtp3QZYbieBXYRTrf3mxOqeXprXoXheRzSdak9eXfeFBBjfnDJfBrDkea/cK9FoyUgEWaUSUB93jXhtF6FyfxMSZuCtd8l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nv3LFTORJZ2/XV+tydo94CkMscGfB4ccjyOIALNSpf+9Hm3Zorzsozv+fhE2?=
 =?us-ascii?Q?5haXntHCd9SkHkYhGfVNwZPx76kTk/u8OdAZKJnhkkuQ6jLuEhqsxSaypmnp?=
 =?us-ascii?Q?GH9GQ7zY6DTfBNHfKYDxWnoOS+CrTYk6Cgtrab8xyC4MI5tgheQWyBtsYvwQ?=
 =?us-ascii?Q?X59muD6DEDcJwO9QtE2MF9H+hC3SQ+Rt3cQz9vShuGDV7VTyirM2jVeErjDV?=
 =?us-ascii?Q?ijES0RmN/sBb/elEN0t3bNdAsuxgchNyqL5L6DnUv3QOU69MfAGh85vq4jgX?=
 =?us-ascii?Q?+dEKvbyEgMvwCNrLR2wQMpcYV7iFBxCS8ihnfeWmyoauljHpjPLdsAMF6o/0?=
 =?us-ascii?Q?UZ81hCSBCFssGvHNKCbnTvfVdBrCdSp/jX37vcJKQIPmftbgm0VF6hyUkLQi?=
 =?us-ascii?Q?iiwuS44rYct1r6is8hnVtZ5ZJ6lIs+4sppHeR3iht/yn59EXAtKN+AebhcN9?=
 =?us-ascii?Q?J5bmWDAdmy5NH2RwQLKCcqkqGq6fAvVQUsVE8OMlnUKt7RnspRPu5+XdILlW?=
 =?us-ascii?Q?LUuZ/+07YtDuuMtDa4dOAVEpxOwsuUc2mFeMSr5gn3ZSoVLx+/0U2Jd5s27d?=
 =?us-ascii?Q?dexUPd9CchkjIKnRSb+MQEPeppMbUBkDrsCED3PHFKt+YCwvKgqCkg15huSl?=
 =?us-ascii?Q?OmCzVNBhvVnzgrRjt7JUzROWuUgc6IUcdbzda/oZvkHIk1MKffkl5S+G1G6/?=
 =?us-ascii?Q?r1krocIS9L7FyrvKibVjJV4UAkt87i4Q9O9H05d1HjKffDrfsCV+jyn06FVM?=
 =?us-ascii?Q?jsxNjJ4wz16dnjAXCmrxsDpoksiFOdoKv8agxJvZukadV20+QLn6ovlcxPBD?=
 =?us-ascii?Q?2qhSqSe3OdQYcDSkaHTgIRsz7FygLJbGLelDK8ymc8YoxjjIeGIghCohargp?=
 =?us-ascii?Q?kuLVJ3S8BMD73BdRJZJhiKTPjL0TZfzTkqJ0ZbroEQKKK+fGm9n8Gwv9rHUh?=
 =?us-ascii?Q?kTFWeVFIkRui+Dxv4s8G6LQcbm64fymG76KsykHC5ogaApdDkxR+u5haZN6P?=
 =?us-ascii?Q?YsbbcjMhWOuM/5KoYx4HZ7P/BK7AvXF8wmCM1eDBbMJtTkQlSAKh+3hEuKiM?=
 =?us-ascii?Q?x+uKsD9OPT1HNFsnScpKO3nrGwFJWbh4G0hOAgWEc/SSpksWUOF7BdXPf/3Z?=
 =?us-ascii?Q?ls4LvCCeDE5rIs4RrrqALXOCTN2uj5vUNYq2t3X3bQhms+5p/2+whSyEH2kr?=
 =?us-ascii?Q?nXhFvHURDxcS5uozQCTwKb8QWxcHpaEB/FtI0VJQKLkGsGVsVVoXG1/AEPz+?=
 =?us-ascii?Q?aq82rFl6cBSfSmuGea+izgfaae4Exm0leWdzZiNm3KkU/EW49dj55ytBIW8m?=
 =?us-ascii?Q?J3e7AQjvAdNRsjhciqmG22BvoouIBg7FDIJIzG69SyWrUUvOREYJQpp+XvkQ?=
 =?us-ascii?Q?eQnRGbrtUCqyi7Y+4R2NhSZewCQcJ8rAiFH1NusUCHiOqXd20WubyWeJPrE9?=
 =?us-ascii?Q?HTcC/n0biDP6OCOfWU2Bf4bcjJV/oAdfszBmNOu/InkLj+TXQ3dbpMDstWGg?=
 =?us-ascii?Q?JIW33UN2Gr5Xcodym4uDHmquHsiQ/Q4lpOaORQFvV72GhHMihk1A93suO01/?=
 =?us-ascii?Q?lNAS/Fn2POKXkhVSnJ59wRxR8ubRlYOsGuqZu6qv7Fbrxs65kqzMKQw7dvHj?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab900bc-bc89-4d43-f2a7-08dc377fd7a4
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:39.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a47Ul8rITAWFE9PQDmHQFSCOWI5savWFQJFITaLaFcDsULuxcV4y3luoI1SLjb7J0FC39zBgakklXdhgzHukr9ZV6XHLGtVt3AbVwyFK4xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

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


