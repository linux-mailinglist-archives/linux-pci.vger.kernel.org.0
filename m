Return-Path: <linux-pci+bounces-5329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1E388FB1F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D391C2145B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AA7E798;
	Thu, 28 Mar 2024 09:19:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABE7E0FC;
	Thu, 28 Mar 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617552; cv=fail; b=CR18WK9C7zh9ybxaSpr8pHnNOIz18mI7zIl3rS623cCe1pcA9PJNTIKCUyzZruzwTPfM6V43hvewvP0QdOq6KOvqMQ5EvlBeB4+xaKWflGazLjcoF6UBquhT3dP45NiPKKhUfMBUsKIuq7P6/y8WzAyOZOuBJRU2OJzApmUYkrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617552; c=relaxed/simple;
	bh=mpXhwF97fuxRS3B6a/BWdf9bWKTjpRGLBlqzcrbBrQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cXTMC9zQObWnKFcirYXXdTa59XxSUzl9y6adjmzmrxotnn3A1Maf1r7IQ9h766iKEa9Un/4QD7/IjmhvZRbu8MPU4lq4fD/3yQZF2r8/rLef83T+oT+EYNPcwTCe9TytKwuyDyHBuvnmimVanwSnHTmGJ3ru8VEb9dtNpoekjLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5NjOM+o9+M23JeQe4GVDGAAk49iIQlOog4PGhMzee5ygfb15McnoCp4beqcFB5vsuo4pd/Sl5Ovzu42bz5HKAWkBaFLCgwnsr9c7CXZSSG5cd5E/+AiNPN8ZNNVpnsYjeUq+rfiqVIxU68qGak0f1A67kMBpbxQS5p5MMwyj4eOqS3s63Sis64B86IsEX4xI/od1A+yI5bymDLmEqPMiqQgdKWMkIYGAzi9xwjtqwNAyIEmpnTiZ381kLq7UzHhF+hNp2TodH6sNOYXmzeuMb2cdCybDJ75PiQRWdMXdkDYx+b/SCKF5hSn9BnKJ5OTwlUKLQxiRv9rgZn8nfdRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9fmnXQNrF0yUf6gsxFXvF0YjdiKzG9Fap6pladclgc=;
 b=TmfaJvVE8SjzVKjAQlKbNGwRghOAp38O9rgda7+QFxFVF/FykzAoPgHYpzEMGePS3+x4mi24cwVK5tI3JgboSB+Uf1k5XH7Pt4vGJwEm9Q2O2Pws+7WxI592CxFBxXMT9kP79t+2oM7TOMHPycmqatux85Kc8ZrVzlozN+DV3dcGVBUD/oV4XZhBi+fREBJgQf/CI+ch5DXZrtR43RRDtPHvsah5G4/G8RE4+309iPmqtxw4HJVGikgLotow/jKe+DHQA1Rs/DisKZBbmtOKonclTfhbxxa/mNV//Md01BVOn5kgMNVxRAjgb5azi+dEi4C/QyP/k9ymBZfWV5mKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:59 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:59 +0000
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
Subject: [PATCH v16 15/22] PCI: microchip: Add event irqchip field to host port and add PLDA irqchip
Date: Thu, 28 Mar 2024 17:18:28 +0800
Message-Id: <20240328091835.14797-16-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1ecffa9-bce7-4e1d-2623-08dc4f0819b0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A6Rv+6JUmLKzbvuFQJpv3A6Hmbw9ivjaW3PcslBBO496dzAi2i2RS0TTbmJa5FVq78NXXifBk0BSi++mB1TYF2QkubMshTxzjGnmLMXSBdP1U/tRoHoTKsu89gkMwMSFxsYy4KXd9TqiVJW/P5dy5RsKJIT4LIrWyk3zMnaviakcxO0E4VuaMljXXcrqFjXQgSMx3rbriNU0oWOeARBDmAOPO3A1FiADtSttwvW6a2jUad1JsSwTuJoeyCNtfBnDCSQVl/Q2o6BLfOeKAi3M6/i8KQynlCjZBa5gMrhbxJ7TgZ6kRzZAbhXICUCTvnkGf75uzq1TlthdCchX9UqJN9y2B3u5wXAfCjVySrQ0JkEkSZufTkmeBrDIXO2JuIgk2DX31bloKE/1bBmI3YDa53Gqe8oLgeeYCX9WOFz9+exlxh7bB+852MSXSrufS1pxFP5F+d48TiBFOgidBF0FhxYYA2tCyc+T0/bgvHiFbOnRufEAcH7pjXVVFm4o8qfm6BdW5gFbw3sSJlbQXy42rtc2L3P7GIzdWqpPGU+ImKoj78bKqDGPTTWXgJNHeKwMQ+84IOKow81PRF2mIkrFMwyJMNMqf28hcTVI0W1ZcRjuteqSEE+7A/+R2XeyC464
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hsv6zU2PQykVCCXe/2GfBBuvg+WHBk6QpyBqsfFLl3luUxJD/uKYEZ5zl79B?=
 =?us-ascii?Q?P9PEdNKihBuuq2mCI0ciuynC4i+9det0tCkQNszL2/Ybrx1dSpu64ShtIDet?=
 =?us-ascii?Q?y/w6Ce+yvXbUjv84F9QR3SsOps1fg2hzljzY0xKmT1o3PoJicb4YlCO3E8Le?=
 =?us-ascii?Q?OC1MGLqY5y5P/ltbBcD34WYrAfz6hjLuyLvOimB2rwakNZuiAJupIc5eCJze?=
 =?us-ascii?Q?H3ewhaDdDgmhlCVFA/0rCLhQJMJxcbZo/FJO/va0lXIryHFXpwWTNP2WfOzL?=
 =?us-ascii?Q?we0yqDyRm7H34058uZMSAoo3JoS4AvsbiPulOTWrwGnvy66TLRby5znxkIjD?=
 =?us-ascii?Q?uWtVJWT3uC8MwtDjdIOjCUaBBytnt+uxl1d84V1dSjp8+LXhC5FPfncb9ezA?=
 =?us-ascii?Q?Etfbz5HcyRvRK9BThSC/O7oaUv+9JXAVrsZPN6qsoA4BBQ5h6fHNBSq2GJ2H?=
 =?us-ascii?Q?28uSUQpsbedJ9tFvdwt0OEsYWK5DD7Irdz59mgCoBh5JJI/ph+NbPJV1fpdm?=
 =?us-ascii?Q?Ere8dtYgsvI/lwBZZyDNtOlI8l1aBUET9z3Bc+7g4iwenl1B5ZLAKcmxra0A?=
 =?us-ascii?Q?cGVJziCzS5lfYFh4cYwqpQGKECDKDgM2WWhonjoTFHRDkzUeyic3D+cdFRJS?=
 =?us-ascii?Q?u9lVgOpGGsugRUmLpzMKytade0GceiNrVZGd0qFTmhX0tZZKsLkwBnrld02R?=
 =?us-ascii?Q?gKeY1xJmbhvkC7t4Guxx1JyXsiFDNkL3z+je3TbF69enC871XY8ZiLVoCzud?=
 =?us-ascii?Q?YiVztAPVdW2Y6E0t5p0E+TblWdkDKWMVIwIUE2fbVq70/VLSpyogDx2sonQq?=
 =?us-ascii?Q?2mUsgtdtsZ6j3RGHfWiNfvsFtHaimTzts9V5cspaLKfMNMoii/XofgjGfQRK?=
 =?us-ascii?Q?1ZhIcjLPVK1EeDhJ1hCwNmeV0FkehgS0UnbspiMoOpeJ9VVjOUtHkTcdxJEa?=
 =?us-ascii?Q?YOPmYkUOs64fbiojOOpEsSYORvj2j1l7sqh7ZL58U1vMimnY+rkKBk5k/hZM?=
 =?us-ascii?Q?Dz5BpPZtEBG+DLhBqd+yc6gJw2fkCvdMxYNY1l6r4RRWpiCTIiPb9qqztVLD?=
 =?us-ascii?Q?eFzlUT05ZXen4cXgdZLYmQemxmyLqaQSFVwmpCRxA8Tv83id2fUvtsu8GIgU?=
 =?us-ascii?Q?u87D7ZIs9xIZDByrYwYpKhsUU/+ta2ANX+7dtX7bL3xnm1gefz3jWpaGF1EC?=
 =?us-ascii?Q?p60ka0w8f5bWAc6Jtfi33r48z6yYmAIfGhnLxLsFbLptuYfCULpnKuqV24iY?=
 =?us-ascii?Q?TSYUlawdhRF7OgD2zdvFgPc+yXLNMUMtWQqhLM/dLJrrrLplun6IthyJ0wZ1?=
 =?us-ascii?Q?kWM+l8PO8fy9mqdXznl7dbxAOJvbEldW+y2I9TvprEh3v8HD1ND0EkUXcwGF?=
 =?us-ascii?Q?fp5WBeHQh/5xGZ23VFCkhGluzBwnC6mOoBxmB0aHGU6PUt1rnre+hq1WKJQk?=
 =?us-ascii?Q?uZxUk47Tco1us/Lwdo5ya/2PE3Gbtk7rMq80ghXT4eRSNwh4ocXG3zGzLSCf?=
 =?us-ascii?Q?tSV/GUPQr0mShERNQF10RuT3ulRKn936lAkDM2kpRv+tzx5zp0wBfcpa/pHR?=
 =?us-ascii?Q?HO0bWwWjS3jD/dPlWcT6i4csUXoSLfCN+zqiwoYjZgCsyDXEmOLoeiUZjwSQ?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ecffa9-bce7-4e1d-2623-08dc4f0819b0
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:59.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEWU4rXVQZIXMgS0vfYH4U6g91LZzzMgfWPeMSNhjmcScQigOhhc/MVHPuR3kdulWAAPcD9UyWqbQAF1EUaeVJXoVl97yODGx1VpdsBnncg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
controller.

Microchip PolarFire PCIE event IRQs includes PLDA interrupts and
Polarfire additional interrupts. The interrupt irqchip ops includes
ack/mask/unmask interrupt ops, which will write correct registers.
Microchip Polarfire PCIe additional interrupts require to write Polarfire
SoC self-defined registers. So Microchip PCIe event irqchip ops can not
be re-used.

Microchip Polarfire PCIe additional intrerrupts:
(defined in drivers/pci/controller/plda/pcie-microchip-host.c)
EVENT_PCIE_L2_EXIT
EVENT_PCIE_HOTRST_EXIT
EVENT_PCIE_DLUP_EXIT
EVENT_SEC_TX_RAM_SEC_ERR
EVENT_SEC_RX_RAM_SEC_ERR
....

To support PLDA its own event IRQ process, implements PLDA irqchip ops and
add event irqchip field to struct pcie_plda_rp.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 66 ++++++++++++++++++-
 drivers/pci/controller/plda/pcie-plda.h       | 34 +++++-----
 2 files changed, 84 insertions(+), 16 deletions(-)

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
index e0e5e7cc8434..0e5157eb3a32 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -107,6 +107,8 @@ enum plda_int_event {
 
 #define PLDA_NUM_DMA_EVENTS			16
 
+#define EVENT_PM_MSI_INT_INTX			(PLDA_NUM_DMA_EVENTS + PLDA_INTX)
+#define EVENT_PM_MSI_INT_MSI			(PLDA_NUM_DMA_EVENTS + PLDA_MSI)
 #define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
 /*
@@ -116,21 +118,22 @@ enum plda_int_event {
  * +--+--+--+-+------+-+-+-+-+-+-+-+-+-----------+-----------+
  * |12|11|10|9| intx |7|6|5|4|3|2|1|0| DMA error | DMA end   |
  * +--+--+--+-+------+-+-+-+-+-+-+-+-+-----------+-----------+
- * bit 0-7  DMA interrupt end : reserved for vendor implement
- * bit 8-15 DMA error : reserved for vendor implement
- * 0:  AXI post error (PLDA_AXI_POST_ERR)
- * 1:  AXI fetch error (PLDA_AXI_FETCH_ERR)
- * 2:  AXI discard error (PLDA_AXI_DISCARD_ERR)
- * 3:  AXI doorbell (PLDA_PCIE_DOORBELL)
- * 4:  PCIe post error (PLDA_PCIE_POST_ERR)
- * 5:  PCIe fetch error (PLDA_PCIE_FETCH_ERR)
- * 6:  PCIe discard error (PLDA_PCIE_DISCARD_ERR)
- * 7:  PCIe doorbell (PLDA_PCIE_DOORBELL)
- * 8:  4 INTx interruts (PLDA_INTX)
- * 9:  MSI interrupt (PLDA_MSI)
- * 10: AER event (PLDA_AER_EVENT)
- * 11: PM/LTR/Hotplug (PLDA_MISC_EVENTS)
- * 12: System error (PLDA_SYS_ERR)
+ * event  bit
+ * 0-7   (0-7)   DMA interrupt end : reserved for vendor implement
+ * 8-15  (8-15)  DMA error : reserved for vendor implement
+ * 16    (16)    AXI post error (PLDA_AXI_POST_ERR)
+ * 17    (17)    AXI fetch error (PLDA_AXI_FETCH_ERR)
+ * 18    (18)    AXI discard error (PLDA_AXI_DISCARD_ERR)
+ * 19    (19)    AXI doorbell (PLDA_PCIE_DOORBELL)
+ * 20    (20)    PCIe post error (PLDA_PCIE_POST_ERR)
+ * 21    (21)    PCIe fetch error (PLDA_PCIE_FETCH_ERR)
+ * 22    (22)    PCIe discard error (PLDA_PCIE_DISCARD_ERR)
+ * 23    (23)    PCIe doorbell (PLDA_PCIE_DOORBELL)
+ * 24    (27-24) INTx interruts (PLDA_INTX)
+ * 25    (28):   MSI interrupt (PLDA_MSI)
+ * 26    (29):   AER event (PLDA_AER_EVENT)
+ * 27    (30):   PM/LTR/Hotplug (PLDA_MISC_EVENTS)
+ * 28    (31):   System error (PLDA_SYS_ERR)
  */
 
 struct plda_pcie_rp;
@@ -155,6 +158,7 @@ struct plda_pcie_rp {
 	raw_spinlock_t lock;
 	struct plda_msi msi;
 	const struct plda_event_ops *event_ops;
+	const struct irq_chip *event_irq_chip;
 	void __iomem *bridge_addr;
 	int num_events;
 };
-- 
2.17.1


