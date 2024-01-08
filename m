Return-Path: <linux-pci+bounces-1789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25D826C29
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082F2282D29
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6212414014;
	Mon,  8 Jan 2024 11:07:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2040.outbound.protection.partner.outlook.cn [139.219.146.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598B14266;
	Mon,  8 Jan 2024 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eypf3qPsGGFKm6B1Ru1MzSqnv/buIzNEq9hILanx8IwVBwQvGlCGWU81qsOk1HrATjPsM6wP6LThlzkz9nIQlXEyn9AXg7w13BS/zw+FoV5wFSjhHfrLmWmSBD8/10YxkyWNYbbi/iP6kPLGsA85+20ebZIrRLhHCaGBwDIKIZ/v0OS8thZR5qxrC0NOBQP0M1k34/mGUihO3v86DypLXmmNQya4So3nNVCgxaNHVXlmCVJrorf+MVpRKyVxjbK2c78S01cMqYhx0pYKlMeLHSO6OKoIN8vZPa7h+Sq7A6Uu67Xf/teY8pLeU8IcZkL1ev4HQMMONl9qxjVr70v7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvgzgZ+kCWJDW3yTlipB4uET3HJVJTZKxQ2LjTr36CU=;
 b=SCv5BMYTAsZKEPVEGGSXrTvauB4PbQ/dQTi69Hcuv/9KwvWdCAkMoASL0ZXr2w1AKpJga6aUzcB6eQykT/b6aibYykxco0UsqMzLVblClhAHY1BpVwvzN0dpTnQCpMFTbdB/0FVaFMWIFuIDi91T21PtA/b3/FulXSDTA+hYGQWlKFmWq20Y9awDjM5KrwfadLFIi5jQ1epTCfgO+b43jG/prQTpDHu9lyofr/ArZYcQGdqF+t0a6ogCOcCkniTssaF5GnrCPL3bHDxWeJ7svQEfZvoOXVC3CYO492aNVnVtMbPnHW+ejqgtkzPrpwLyRuCJlqpZUsbr+HGniuFLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:42 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:42 +0000
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
Subject: [PATCH v14 10/22] PCI: microchip: Rename interrupt related functions
Date: Mon,  8 Jan 2024 19:06:00 +0800
Message-Id: <20240108110612.19048-11-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0797:EE_
X-MS-Office365-Filtering-Correlation-Id: 441e78fd-4514-4e35-e258-08dc1039e4e4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wxLDWAIy91dvjeXDLx+/cCftpWcJfEvA6ejWwtjcca6LhQS4TcXTcS2RyOIJUJ4jr8HLHoF5wbX2cMSy5rB421AhDcTTJDGKdef6cRxRj2m8XYMwTL9/Ji5mb9vU2toBF1J14GYBcLkR9ItxPczIsWDDDNOvipl/kbAyl4zhC90Tt6DC6AuAZKwbHdhqiE8Ci90yyr6FjdIUhVCCUZOCRHbgdf6bkPR+xvyhRq/awjyhrUpUChHFgYYkzVmxGcxv74yeJJARraSuGDHuXT5W24VHLmjd56mqREvtKKu3NmF5PuplBrSzK9NTL2IO3z2bWR/mrpsl21PZ8Q8XksAS4CK2zGQHLM2nJ1rObF/8QdgBN3Hofcefoiz/pjhYsFYZNvXXopAcPzhhJxAvp8BCS4b7gh3kUZ179N+biPbbtMf0sNZDfoLloQw2BbPbm+kc8vWBFIX/MQsqQzTvkWUw2izFzIGif7IElZJS6AZMvRN0PS5DNOJpGpHxavYppGUI21PsdyRE7+fe6suJSlVFB6+okl1xrYxt/RxnkIEdYAbjUPOYWKXVUcMGfuMa7YC1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(30864003)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?daMhXwQJZXUwh+QDvbK80okkUEjyPK50764vop5ZXLaheiH6MsV277uxMCgW?=
 =?us-ascii?Q?mNUfrTa++/7tTRwjz76HT1p6MeKAc9DbQJYiWyBIg0xStx1XC/krJr7iBvU/?=
 =?us-ascii?Q?MSg7bSUVM1Dac4cGa5e+YKLvklhi1tmzALh3LDGdLLxfgc77MGFjGqX2ARAu?=
 =?us-ascii?Q?2T7hbWj37hF7B9EkEYC1wnIF1YWtDaBl7GG7e4o1J72IXuzs1u5vi2pXksh5?=
 =?us-ascii?Q?4WmYjvZp5sW4nKH0vyfBtpKrAYxwrYTEuyAikjj6jcfXzgGARVBH7r7m2uZx?=
 =?us-ascii?Q?PZ9E8VooqOU9ULMKigdm/A2lNQpxzOJ2dObdwlJdFW4/32/GDIfsb9M1GthB?=
 =?us-ascii?Q?sTy5f5Pp8Z00zGvEewWD9zdbgkT2WQVh1mgupttBYs7ieSRJzd93PDQpClpu?=
 =?us-ascii?Q?y/3Knp5kTyLw/ZQCIdfXzUCRHHMss/3Qg3juZTxNwsN2tFv876+eisIm0NGz?=
 =?us-ascii?Q?r/ESowKTGkiNXrtreYLL7z1cA5/3KBM+FoSxOF4YEhzEmwHj3QguS7e+kTA2?=
 =?us-ascii?Q?gg5H38tcJXX19RCt1OVusXPKtL/0Lf9/YPZA/E1tg/808VGpwzu/0Tem+2QQ?=
 =?us-ascii?Q?+REs8j3qKE5VVNw8v4cgMFOMgcSJrsQhN0bz8SvCyN8h8ji0BwV5lC0+EUco?=
 =?us-ascii?Q?Mzb0NVdVKzWs18expO3P9vDHChFrwlEUP7dYJQBNGvpXsyJvYMjYWesiWews?=
 =?us-ascii?Q?ys94KO9d9AXtwWCV9FzcvEwqZ6W45Mqo+gYJbJErkx5vM0cHGhVMEC+szBmt?=
 =?us-ascii?Q?etBhqsDMow3KkLX7WJVeCb/9ay8x0lXUDcaV5SjAe5KgVcbImfPA75TQhbsY?=
 =?us-ascii?Q?Z3P0UlCDDmrISh1e7bMQI6UiR7afn2900EL5bzBPLH8j0pZrEBVgWaUJjChM?=
 =?us-ascii?Q?7VpiTNWQhQRSn27Zpb+/+9+X2InzD6JL3nINyUdKUGrBsYDkSuuyp/5V3rb9?=
 =?us-ascii?Q?tAjqljV+MkohOCA0dPKTOWB4bV+tXostzGqJ7CWZNoZ3sOLF7PVCEaoPUEb6?=
 =?us-ascii?Q?QmXWamJ9m56zm0UjZA6nP6U5uVClYPSZ1PQbW3eQCPQPpePkhjDG0kIrD5qU?=
 =?us-ascii?Q?EFF4XASS34EUFkq0Xcn2Fo7dJhTpJAnqbTT4oj7ZFuAmbgolE0kdou2F0g3O?=
 =?us-ascii?Q?ssn29MgNYuIxp+b4Yi9wCVFHXZlYEQCrXqcZx+NyXsaJvgXbgGJ9aftIzZMN?=
 =?us-ascii?Q?ea7mIGEBH/n4iCWLC6f8Ft+6HkElfm8APw8HLLAuBCO/1OOzPmLo/PugnFqo?=
 =?us-ascii?Q?wWNr4paWeZHPcRBvYjt8vbHmmJm1WPdmn0GDmxedxHWT3jjEPSfIhHd5ptHS?=
 =?us-ascii?Q?gYkYBuEINc9ROV5sl09nqkFAU7hg7U/s4Vpo8g1xF7pAeeHZL6ZEVQHe7Jhb?=
 =?us-ascii?Q?w61s/TWEuDGpYR7qLbsrpu430l1/RwB57ua8ra5+NJersv/1excoRHrniw1h?=
 =?us-ascii?Q?ChqvPEKZMMBVekzGTXCgP60IoiEEdhMqL59Jjp1UW/iDWNCTDjmM3WU2GTAz?=
 =?us-ascii?Q?8te1cHGeUwSRDFwQcHZ3BhZYE/GbZA+kfuQtc+s5dc16InHgzcPXjjgzLR6J?=
 =?us-ascii?Q?I8B5Z2c+eGnhHIRjlOk7+123BtrvQq73skjK+UTxIUaK5aLoCkbm/0SRptMM?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441e78fd-4514-4e35-e258-08dc1039e4e4
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:42.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iF2lk3YNWagGba0I7iwJoZiIUxU6WE16Ty3lqK6W4CImE12QsYMCyZ4wm3QCkz2METwZTTZU93DKlRiWuC6UmUITblrDYvBIy+OeCjOEFkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

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


