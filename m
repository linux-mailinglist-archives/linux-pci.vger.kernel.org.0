Return-Path: <linux-pci+bounces-3676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F04859652
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732142869D4
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7184F1E4;
	Sun, 18 Feb 2024 10:34:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52E4D580;
	Sun, 18 Feb 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252460; cv=fail; b=fT2k8fqo8ybv+RU9ts6+x8j71FzPHOJwzkvShk6Syr/BW+6lmjrS0fHFU1JTtZfhmYDmNHOhwNXMOoSF142P6BVXYQyxrdZw6ZXYr9ojOZnhRcr5HQK3V9vaale1PHcnJeJuvTX10ziEXVoav3oVQUoCa7Ri16gJF5F60mbZCyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252460; c=relaxed/simple;
	bh=22WfnNEhA24fGIAnSj8FnGthhV9+MdctziwxO7auJ7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQes1GYo1oBf15vBQQs1wnXm42crUoj6nZj74+4wS/lAr6ZzWxdCYMs5iGBtvRNvMkv3x4zgFZilYbVBnhwFXcHyUlB1LxyOnSuT9Z+KK9DxvjrmymAjwlmDwo91NYjioKTcQUfNO7SWtyhViia1ojhloZ2NkLLLGyscaj5SSQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaWKoMkTVFq8gDcWjjyhCLqbbKZBFAKFTAcfqHrk8mlPnqbP22+9MfW1pFnYsbxxbCNBio9BVvn7uvLlg7gO6XJGJI8Hj+FZR0x8DNOfI7iEN38KXHXX380+ypPr1nisXx3SWOd3w2PZv51m45w/hqIu2JApDs2bH6dGe6kZ5k91iIdP+szsU+acBtubfxg1kx6SqyN9XqGxSVE2CzFzPzF/65hMRlZuTxJv26TVtzmmge3yQjclM7/WugSDRF9cEu6XvGIN8JVdaYGOY8eLBdlXPQpJNCS9OlcC7ySALR1Eky6dcdkIDvCAF6A+m/tVxjffc6TG2pNpx3u/KjllSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvgzgZ+kCWJDW3yTlipB4uET3HJVJTZKxQ2LjTr36CU=;
 b=mYEQ2l/ZFT7HZ4sc8aQ06+Kp2Z04wbnY7VcgNq5kQDi0bDhXzBb4H3SXNkaOvdUfylFkFQWaA1hJiWsZDSj4F6w1OEsb2ppM69asbGYFOBLLfMJAMjtqHlaO3J4cGX42BfdqXgbRS1iNfayJWZs4w1EU317dIPL7OI7OGNc0B/IGnU5RhM+brQjuiXBSiBUXHl71JYyprqJwIyXJI9URQ73Jtxea8w7s7C2oqvupytnBQk6C6DnOIlGJAULWU2NedTWAuy/zMYse32mT60JT2b5n7Jg/8f3hbU3+U7+pa8DbFWmjSQP87ffJDNcimo0jv/Rz4FJeN+0nGPwZ3Af4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:45 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:45 +0000
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
Subject: [PATCH v15 10/23] PCI: microchip: Rename interrupt related functions
Date: Sun, 18 Feb 2024 18:17:29 +0800
Message-Id: <20240218101732.113397-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101732.113397-1-minda.chen@starfivetech.com>
References: <20240218101732.113397-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::31) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dfb301-0d0a-41a1-2b26-08dc306ad974
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZI3IDs8XAA+uWInhCgw0SNN9XONV1kzFrWl6+yBXReR5K5ANsyycBrWuQR19tO8/54yJhMt71RDVfbm5Wy7odSfns69qrhwp+dhm+t/iW7IWZrpXxCFPkR0IzCbkNYzFbg0I8yGpNPhJt5lAr44TksOcB4+SIVIntPKln8OngDcJGGk8ApjG0VXVItsIEmc95TGC332avQZ8pVCOMQeCNF3EjSOfYuFAMDBLbf2KiDDMFxtl52RY+Afy/1L+Dl4x3d0syovDwgfo3MbdVfDG08MOoFpRkZD0wsRHLvv2fbSrUfDX/2mFENXyqGDv4HwOQGldCzzuJ2vS0bfu0w4yjfoUm8y4oTVMVdfNODJU42Nd8/9bWeXxH95WR6Bk7y2v3G6ImVt8t5+e+WclAFWMnSKUTSRn70qmf8opUwvRj6vnG4fPoFKw419K7ktNiPgGekkuq3RgoKsD6QwevcHBe6W+Y6bTTIQD+I/7gDrDh/T+ibXjZm05AdfsNj/2HkN0to279LSYvmnPdBdInmSiMMXwjMh66pPAC3nwW1ce753MGw54dP3jrTEeByKfNmbp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(30864003)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?joiRhsdCbvv6PwkOERH6uuKYtwhmt7KIbaIW9owg5TWBzNohN9bu2K4vG99h?=
 =?us-ascii?Q?8a/0I1xadentbFhiF9+AOIc4jCBdlljfnwZTix+ul/PVPgkNIjLJE5mSsdK5?=
 =?us-ascii?Q?49CRLzsAPtzEZTsdkxeP/g0zUCh06aTTePR5Jid3JJpKdp/C0BZpoexeDpYt?=
 =?us-ascii?Q?N/INZa+e2j0MJ8TksDBEr4qC/Wef3za2BXdIOWd5ByPwuzMwnXV1lLqHCDcw?=
 =?us-ascii?Q?HXjUtbKAaImUP4Gm8IR1j0y2zDV8a62cIEEWNKmvxQvM8jv7ytDStb4BfNQ3?=
 =?us-ascii?Q?YWCKi95HArbcHjNlZSD8mc2GeFlwPVaHI5rJ+OEq1MFiF/z6PRUc/hYa4t2b?=
 =?us-ascii?Q?Dt2XeEBCWXX8YZwnTmosiDcIo4S7Y+uUQGDcUKlSQ7nBqGsQuTK+TQFRLx1I?=
 =?us-ascii?Q?uDoRMwHzQJUn/1ObyAhnA755YyDKffhJFnrBa+jiYNHeRnTyePDxctZkLClp?=
 =?us-ascii?Q?7Zl+tqoek0KTf11ULQb9epWqr4l+/R+gyq1Kv7M0Pl0zKRFh7CnH1vkja5cG?=
 =?us-ascii?Q?HuxM4yn4O+QNh6PhyKgp1WobWkExtH9pGcI4kllZIkXxfaHAcPMcpfc4rbBG?=
 =?us-ascii?Q?MlWo8KtAcbGGxJMfvoKw/CqLHAmT9jopSdViKJXsx998sh+kPgS4rD6L8nX0?=
 =?us-ascii?Q?xN9GoaQnM0YGHLL1mgFNB/vEisl778G1LlDeNaVDPpSg9E7shzHUJyED9pCT?=
 =?us-ascii?Q?d1x7ujla9tHJgQYlvUwGgAblY4JX3eEe9F3pwB9VtfKFaGPUa779KpbSCWo9?=
 =?us-ascii?Q?496kewKeuq7lBTzdWZtRQBUhBtNb/RdqGnkh86oD4/0VPecgTEdzdCeO2cGW?=
 =?us-ascii?Q?iYIjoTR0e/XSssKhsFSt/z4qSGywmBVpBPA54eIkB449BRo+UYBuSBH29TeK?=
 =?us-ascii?Q?D99iC+uwsMOmI3Z9ijSDpUiCkOPhKJgfzJ4pjqQ7YecNLN81xsvHhpbZvfOJ?=
 =?us-ascii?Q?9HZ8lwVTmkhIlklOirsaSVtkkDvfYv5dAsOPURZ0fZF/EZmX/0Ry7vP6TQrg?=
 =?us-ascii?Q?6D1M33jhC0c6RRDsCJCOKrtO4Q+6t89/Og60+zD9N8BegffrVTcUCpAsWF6Y?=
 =?us-ascii?Q?7CGgsHwgYSMb60VuwbF27xeofWdodzF/c27RMTpbEV7ZxZNvJ7h9W5qo7lq6?=
 =?us-ascii?Q?ZwzdgRU8rsC1KggIkCedu0OQ9bK/YZizHvgueM3nsqqaApbaS14a5Mhyyqvb?=
 =?us-ascii?Q?gDmbuksMXaNXCPNtUjSstUBYlnkXkyqkQfKbhKttHE28YTi5rXMCpaAFSI3i?=
 =?us-ascii?Q?2fabvgRSuvvr/Rb8jdm1XfMwRVEAdeDUwc40rVQjAQMmjbjvzEr1zBkWtVbV?=
 =?us-ascii?Q?kYnlhgAXXI/lBmTu1cClk67leJUQMfiXd2oB5Q3s05PEvz/5+O9d2xt1K3l8?=
 =?us-ascii?Q?diGEVZ7mVK9uqueT5CTTH1P9I9J9Qn5BipQc3VobIUs5vJfew29n4o8Gl8ww?=
 =?us-ascii?Q?JIvdHwO5cHfkX3uBF7gLRXvl3zPAyPEq4dldGUC9HfDCCKhqHMbjU2o4uKhG?=
 =?us-ascii?Q?Mkpo9S8J4itpDIe6myJuVkE3BaWkC70DQmZ14yWcOpaXbqICNKGePc51Ncou?=
 =?us-ascii?Q?5Hb3GuaXWg8P7lZD+RI/A47j4rC67mbN2NC8oxKY+aDTTEqEJlT1uTa4OqpX?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dfb301-0d0a-41a1-2b26-08dc306ad974
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:45.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqXO918PbT6Mj0Jqm3i8ktwRGhd7TFxdPhIsAWbDg7A262Zb1BbiPP0G48LgXxxF0eI4GtntlaygZPXkpRktkmesnbsH3t+1Ar3SP7RW5TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

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


