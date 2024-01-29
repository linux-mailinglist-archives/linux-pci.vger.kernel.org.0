Return-Path: <linux-pci+bounces-2663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E569583FB86
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2022840BC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C36D27D;
	Mon, 29 Jan 2024 01:01:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2048.outbound.protection.partner.outlook.cn [139.219.146.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D6C8C4;
	Mon, 29 Jan 2024 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490081; cv=fail; b=KQO+v7j0vfJh1aX8dGzEd9P7vrFn+iDORKL/hlYCpbXaVQZ+/3TxiNEBv57BtKNjOtqSP5K7Cm2KOogYxpLhkfI6DYoekqYsexJT8vrkwaQVlK6OYY43MVD9hRI/RpGBcseYgFOIuDYFzq9c89XByqnIaTVgQ/9GqthoL8b1Iyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490081; c=relaxed/simple;
	bh=6SnxoGHctv+weLX/56bmnX8+FM2s7IXcfCAn0xJUvD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6Jaiyyr1urjqRS7bbvl3Pqzyr7fCNvZGQnj1eAppf2RMZL4OuC1Akt+ApG6InhRyhrl80r1oOyoYldPvyErErkp4tlru3YaNE+qXtN8S5b7MtDt8E5GF2QHqe6ab52tFfyhok2zxIG6pbn1F1Hd7/NlfqeSQLKVMgwc/O+sV98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GChHrOiKzvMH263KmNQ2zY9Snm8jQYR1d0aL0Jr4H9G1cwe1HMzadVmng9xe/Z3l7Bw4+I25hbbZHTgrEHgt1HikiHfnOcv6H5VGuA4i8oed3p9Ad9sMsTFCDFn89dVEXYOYkbBk9/Dp7VYXNxQ/n4C/nz/YCYY6ro7p4po1Q+6PnfBQM3pjn8bUcoEHeRLGz9Y+pj+rk/wMP5MWsNHZWVDsv5Dg0ED2uuZUoPw8aWBgPvbW+gb7TWIOK5aD6nNdVUBcrg3RXUeUaqC3x8KNpkpKsieav+IRpZmw0MF9JxFSXBq7bJnj1fGmfCcUzDYHpm6VmruM71mV9NWG5Kvg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFAi/9ANhMNoN8P+bySA8VVky1s7VfWBI39iKhS+vok=;
 b=S3ZBUfdKeztQ2FlUn4IRqnZzxW9RuruEjejHiZSacu/2q9TuKxDlk7cQqS1XTggyL2DU6Trx17gNLK4GWsZ/Rcc9AM6peYrZemdy1bHjfZpL8VCIlGPQ5jsuV3KkfW8pbKypMlMwAZ2jnDfmV11O+WOsIHFAbIRpSpkb/YMpr9x+GXoN3Lsipdl7z93CSP56825IDYHOFw3LdafcMwYu5Jvto9I8En3gn0NyQFj4E0KagRmfKVCf7o6B+3rvqp0YSFCt2xfBIfyq2kGuitzavOS1FC3UpYB1m+QT/uti+pGK1ghyir5uxR0Egrt8hKuuj69J8+VOKqGrBRXI2OUz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 01:01:08 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:01:08 +0000
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
Subject: [PATCH v14,RESEND 15/22] PCI: microchip: Add event irqchip field to host port and add PLDA irqchip
Date: Mon, 29 Jan 2024 09:00:59 +0800
Message-Id: <20240129010059.3672-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129010059.3672-1-minda.chen@starfivetech.com>
References: <20240129010059.3672-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0016.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::25) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d1dd78-fd7a-4791-603d-08dc2065c6d3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AnAkD6eezUOJje8Nv4upUnoTvFLprQ2QWP3bGLicdRiABo2wn+U/hcb2YPPKadV5W8K1KTl4pLaWLx/3fWEtHJ4fVzlZro0i12Cahi4hQW52If51d+D0qiI1BuYp+m1kxF9+va0SGwxeItWAsEzydEr2cneZBSPgDhfphzo1X8rx9IgB4msMDsS0bz11KhhZh9ouk/4gZAiz6L9KIIaONEJczA1CwX/Z86gTE2S5BYBYK7hKTCUZjIBHPsR7FFUPImKh6zOfeBiscmKbFoKhFHRhHxj7bCWpCp8lEKC6a3btz+pNoYNB49AXE+GmRj0IyH5l3wltFEZoof66vWw+lTN0+TdRQd7p3ykigALB7iceyeQjeDcAR71WY3QBc4wEO/rVcol7IIgXfWM5Pfsa/8UBRpg4mY+z3NzgWWh66DlTuZmkaU5WPQU58l7mx3CjcjkgbPVJW06Ab2LgeR7b672V5a9XDHgy5FyCFKHQOtaVlMbYlS0G3Qp9ZwGpBLrcVUyV/C6mZylYrqPmw1DZ/hR9qYKWWJ00fVUDT1JX39gwU1nhtynb3k9Oi7f7kI85
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39830400003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(107886003)(1076003)(26005)(2616005)(38100700002)(44832011)(5660300002)(4326008)(8676002)(8936002)(7416002)(2906002)(508600001)(52116002)(6666004)(54906003)(66476007)(66556008)(66946007)(110136005)(41300700001)(41320700001)(38350700005)(86362001)(40160700002)(40180700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?liJfsC6IQh3Je/RiSly5rUntpxz/OmRVmcf3d6w1O+xNu7r1mshknfYxv7ss?=
 =?us-ascii?Q?oJjTnknT/PQ5y3h3v2RMUc7HXH3KnWmooP2sGt8JFsz3TCQG6X/ZSK41RABr?=
 =?us-ascii?Q?2zTdPpxem40Jc1Fg3aGnekE3v4ji0sMldsBCahMP2z8dNE+5VY38V3Zeqhvu?=
 =?us-ascii?Q?Igf4E04q1GhsCHdYVL3W+aB7Ta8OtEqS7G5Pkao5kpWrGeruz/b+cHCNHsgU?=
 =?us-ascii?Q?F0VngJMUKGIRuFU4sFZp07g88fYNzL8RkEI7Znxh3NCdKYykfAwbbE6eSyyl?=
 =?us-ascii?Q?caco9DUnvYgfwgJWGeLlfH6OdbM1xzBL8wvEQljHKe4pjIu2tBYgpakHnqHH?=
 =?us-ascii?Q?iU6bqUdenq6pqm9w8VDTY5ywn06HMVFagKUnLtIGqqUSBZIPPFh0kDknIdEO?=
 =?us-ascii?Q?lsQRMarnpDMHdn4UNRXpUynROFZofRtJ4znYwGUPI98SJItPK44Xx878fR1E?=
 =?us-ascii?Q?IvmETHqSejhx4LptdIeSmsqvxBd1m1gFk2uwdJph10hF4eV9/cOZZgx1EnCn?=
 =?us-ascii?Q?eG6MTVUV3fgkJdCsrkaJgRm8cQIy3Qvb/pfq8DExNGCx34Ye/UYlk6yv8cjs?=
 =?us-ascii?Q?PFRD0cTXe8QyWdqWqBLMOlaTjYluzDZONVZWKuHfD1RqQNMyBODE2IRpjK85?=
 =?us-ascii?Q?skbnPUxUjLz5VmBp1QbdyJ3K1KkzaQztUU+wgFbauuGWCacEImqbpg7TORxv?=
 =?us-ascii?Q?mYJbwQdk+pVO+dVGY3OfuFBn3NFq6fKbLFtPn7dmLUzaeN4WIN9w6UVZmjkN?=
 =?us-ascii?Q?jYH7KtXb3xu2KnVrzDH+tgJ5DQX6XP2XKbzxa3PMAqAlujLmqbg0BSQTo7Ps?=
 =?us-ascii?Q?6d0liNDdCuSa3L+2JFXcD8/aRbb1ZhjAceSuwt0GBp4NHTn/j+vOGWvkor22?=
 =?us-ascii?Q?/fyc4kR+bBnXUJSbLv4oXUmTwuDtHqJWhoYFF6ROS/6LTPVWukEkcRQaAdOf?=
 =?us-ascii?Q?fEo5h2pccV6yhBAIt7Q7kb1/vzH2ii7YafimC8tEm11pSc+/03gmj/wbVN+Z?=
 =?us-ascii?Q?0vsQUIoJfbnTkTKgDFYySvpqOJqs4u9JOTIK7hft3qILsWcqTaCDAckRdTnC?=
 =?us-ascii?Q?6RZg3g7K8Yx2Npc5w1hV/2kMBQ3Jf8s9rccFh+eS5dM2x3BZgBb83W3kvBVD?=
 =?us-ascii?Q?SNr+UQrpmtD1iGBTSA+ukFzU9sm/RBcLqNp53/AsjtK7u+NhiY4QOvkiJZ8J?=
 =?us-ascii?Q?t28zLprkJvTyAmylRToe0ZUhcYvDBqP4oEhqrcRwNbdKOgcKDjNHKKqSpDl7?=
 =?us-ascii?Q?ySYz+mFrv/9E1fB8mNicJL2su7ZV0rTrx3uP+j4kw3bV0qjwiW7Xkwmp+B6q?=
 =?us-ascii?Q?+lbtqsrZi72y3Axh/0K2ne9cLQXC6B9kHpHRw0gPhlMx2N4czOal4BIdy+vj?=
 =?us-ascii?Q?JA9EiSjfHYjHHnsoW5FgBt7Xj/yMI+p5eM3MCbNT6dQ3QBLvoYwqb9WCLqNY?=
 =?us-ascii?Q?uzGPdKPBmVg92DDxaeFAz9CjtEmgJ+p1Kh3//CcXFunp67VzaUncYAclOrNS?=
 =?us-ascii?Q?6iAaV/jAraJODJsRmxyc1+xUs+wft+WEYQweor+vJ8zRX/9syKZONwtTmvgL?=
 =?us-ascii?Q?ltfOW88QOydLkWi2wrq+wkTZZDN64e/PM9o/9e5oVR9Y2bf0v+HIJ0x4gFLU?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d1dd78-fd7a-4791-603d-08dc2065c6d3
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:01:08.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKy62uAlQ3tnUSqv0Zx9c629DvVbOzttP2+pApfb5ekqTcB5GwyElE10h7e/ho7kae30Lf08AFT9Zpin/ewKCSi/ufkhg3nyirlDc91SIq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0855

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
controller.

Microchip PolarFire PCIE event IRQs includes PLDA interrupts and
Polarfire their own interrupts. The interrupt irqchip ops includes
ack/mask/unmask interrupt ops, which will write correct registers.
Microchip Polarfire PCIe additional interrupts require to write Polarfire
SoC self-defined registers. So Microchip PCIe event irqchip ops can not
be re-used.

To support PLDA its own event IRQ process, implements PLDA irqchip ops and
add event irqchip field to struct pcie_plda_rp.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 66 ++++++++++++++++++-
 drivers/pci/controller/plda/pcie-plda.h       |  3 +
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index b3df373a2141..beaf5c27da84 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -770,6 +770,64 @@ static struct irq_chip mc_event_irq_chip = {
 	.irq_unmask = mc_unmask_event_irq,
 };
 
+static u32 plda_hwirq_to_mask(int hwirq)
+{
+	u32 mask;
+
+	/* hwirq 23 - 0 are the same with register */
+	if (hwirq < EVENT_PM_MSI_INT_INTX)
+		mask = BIT(hwirq);
+	else if (hwirq == EVENT_PM_MSI_INT_INTX)
+		mask = PM_MSI_INT_INTX_MASK;
+	else
+		mask = BIT(hwirq + PCI_NUM_INTX - 1);
+
+	return mask;
+}
+
+static void plda_ack_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
+		       port->bridge_addr + ISTATUS_LOCAL);
+}
+
+static void plda_mask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val &= ~mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static void plda_unmask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val |= mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip plda_event_irq_chip = {
+	.name = "PLDA PCIe EVENT",
+	.irq_ack = plda_ack_event_irq,
+	.irq_mask = plda_mask_event_irq,
+	.irq_unmask = plda_unmask_event_irq,
+};
+
 static const struct plda_event_ops plda_event_ops = {
 	.get_events = plda_get_events,
 };
@@ -777,7 +835,9 @@ static const struct plda_event_ops plda_event_ops = {
 static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
 			       irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_irq);
+	struct plda_pcie_rp *port = (void *)domain->host_data;
+
+	irq_set_chip_and_handler(irq, port->event_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
@@ -962,6 +1022,9 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	if (!port->event_ops)
 		port->event_ops = &plda_event_ops;
 
+	if (!port->event_irq_chip)
+		port->event_irq_chip = &plda_event_irq_chip;
+
 	ret = plda_pcie_init_irq_domains(port);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
@@ -1039,6 +1102,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	port->plda.event_ops = &mc_event_ops;
+	port->plda.event_irq_chip = &mc_event_irq_chip;
 
 	/* Address translation is up; safe to enable interrupts */
 	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index e0e5e7cc8434..a3ce01735bea 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -107,6 +107,8 @@ enum plda_int_event {
 
 #define PLDA_NUM_DMA_EVENTS			16
 
+#define EVENT_PM_MSI_INT_INTX			(PLDA_NUM_DMA_EVENTS + PLDA_INTX)
+#define EVENT_PM_MSI_INT_MSI			(PLDA_NUM_DMA_EVENTS + PLDA_MSI)
 #define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
 /*
@@ -155,6 +157,7 @@ struct plda_pcie_rp {
 	raw_spinlock_t lock;
 	struct plda_msi msi;
 	const struct plda_event_ops *event_ops;
+	const struct irq_chip *event_irq_chip;
 	void __iomem *bridge_addr;
 	int num_events;
 };
-- 
2.17.1


