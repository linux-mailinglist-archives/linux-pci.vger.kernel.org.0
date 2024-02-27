Return-Path: <linux-pci+bounces-4098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F68868DB9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8D01F22400
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755EA13956A;
	Tue, 27 Feb 2024 10:37:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8881386CB;
	Tue, 27 Feb 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030221; cv=fail; b=hIN7S48xO7arkYnjip+LdqjJktQ1kDHZzKTYtzm0SdS3j4Y9iTnAFq4201Y0femfeWT3zaqpNNh1TNbw+JvGvz52sOpq1jFBcqP3jwApeN6n33ygRuXlRWn+TyBg3bgF9WOO2Ixce0wxoF1Vy1taF+n4EB1mlrkALwH/+oLcZ8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030221; c=relaxed/simple;
	bh=C5nAugbEc4otXexvnJcq5jk8jk76kNdeS5qpTB1308A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMZhrkwOfqfbLCHuEoAWoBc4aiiHG0pVnWs2dqnAW3fJFMM8+qFRpni/Iikd1IY6e1t05e28eDbaoDM/O05RpaZouQ3e+JgaoC5l8u9iQPywOK6qTNCMglgXjH4WAD6S6hXZa0ebX1QM/xNHANZCHEm7ORYUmuDfnPMFTRdVT+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZnGtmIzu+/v5DoY2R9AvwY32CJmuWkdmtHzLbCzhZ5nIJyfAoXNTB0GJ2If/hsajEnNIg7cnD4WwodVOIfwOqNlp4LAAhiS9cDWKCm7PTJcVoU8bmD/CNdgUVblstRsA09WLKIG6KDNapaNSHn/4Gw/mpTHWfDigPbQWacAFuX9L4DR3I2O7Uz/NYIxFgu150Hcs4CULNrFsg8F4a9uYTMGRjVAlWJF/zFm8vDzBDZ1njWyOg8tbdhqdiNMW8cakGrvA0Evuo1/W6yy724nxPSd6bpxnCjPeO59RarlIQ41uX9MCTaFyL+olVNxKuAtWe+DOzsGmGTKJn9MnwmUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ890sPTDIaTgSVopGlFF8OTlffwS8+Jl3vvqYke5M0=;
 b=htZkx2bkDGLc7qvNwAt+Vjq30Ovx6xNOaNO8grWMU4Y5hKwxirARmY3HTjdN/5KjuhT02AtwL6v68JK1Q1BxLudHGlsD/mmGnJ5K6JIchpFWxR25WVhV/SyxiZzhTH/Tupt5wfJKZHnzZmPSx7i4fcLMrh31VdomsbKIP8qxIoyx53HiuP7ijeclSFkDV0Q2ayAs+2zz1OFRl+6LUVAghZz7wu8XtyNgPoNMw5y4d5v96FWQBVy4+H9uZUhHMzwzavbqcqRV1QevvJGfjWxWYv+ErIpDyzIkkhsa9zKnDO5BXCNjiZdRHWm7jNBzFEdiNjNF/uuNjnpIn99Oo1qVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:44 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:44 +0000
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
Subject: [PATCH v15,RESEND 14/23] PCI: microchip: Add get_events() callback and add PLDA get_event()
Date: Tue, 27 Feb 2024 18:35:13 +0800
Message-Id: <20240227103522.80915-15-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27c83dda-ed14-42c9-77fa-08dc377fda40
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AGta6pUIvbFG1C6u8aHO5gmJo7NIK2EGs9Jal+3V9MX1kqvu1brAFrxBE7vUCbdC4wJvqrcs9MoZe5rocdmCAAyvd1aIP3q3vW9Ep9DlXXf+uYwAD9jsTSzK9EI5XIzfofraBR6o6DUTKuEjYVOxqfveVhbSzYcVyv6Dd8QkJ+paiHvG8wkX/mKRW1k0nz+hSYzLGmVKeMKKMFcVcu+Lvh0vDnmO+5JtdALOlAsgR94c+7XC9979rpISTxZBvLpmNRhcc+ye2s6mXJ0GOc2Vx+Dvt/B08TNu3JyozWmJiALYBAz1P+1/sOdrgyHIOpWblQdZEE9WTzahiX1XJWj5gSr9baabKyhc37dJpKgjBJcCrSj85UsBXx5gOmUka5KxiwVxve0BYIeEDXsAmYZhNza8xUiXs5n7a4iYi7Najepc2NMYZuoTGVCuLD5my9gK8mFuML9BOEwWzEoPpwce9gQzvwQTqXDkD7PsqBGhlYmnsgGCIHUrj3TtyeOqeHYp8+d7n40z4nk3nVrFOWINliJnbvo6+nYUtm8S9FuhBuugIt1/bOfXmt2jKGolMpF78ZXblHf32CyMA3Ev8XndG6Z9fqSf3RtEdcFben6zd8nMmo1iAIjs/y3XQRmtT5AO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4C8Z9pLA1TqKC5hoytw02OaVdCi/jR2fV9Z3Ir9zPxwkm0MJcYjZbGGdAQrF?=
 =?us-ascii?Q?o+kPPgjJ9IXFsd3s8HuaTuJltXyaMhGdT3asrf9q6YUZwddcfYp0s8jAWSAQ?=
 =?us-ascii?Q?HX7pnsD8F4BlIe4x2rRtUX/c3pGvq0t8G9Z8Xbs9osyznQWx/6ok0BFtKOkm?=
 =?us-ascii?Q?le/wZi+H7YxcVTQRZGaYG0MROEO2Az6lFhhLkRpVvI/t2cCou2NnCmQKAMQ5?=
 =?us-ascii?Q?OQvUJflHxPxHnUtpXlbxOTz/dpgPYfh5HGEiS72y0x5nsDhXDdn8tFBhgPUf?=
 =?us-ascii?Q?QwrsSP9bX3vFNtGx8nK2q0aDKt/tmBPo56VCvuDexTb8qfREVxjzMsgTQTab?=
 =?us-ascii?Q?uV5AWxENyypQrn2rN4l3/YBDsRdyOThLzWKX7MtVVxCbECFfmW4S9CdMpZ1i?=
 =?us-ascii?Q?gF5y1XJranLl6uiabKMh+OewS5VasY7c+3UBrQb8cetjUszKD8A1CbPa/cDR?=
 =?us-ascii?Q?u4OLw8B/Evc4Jo0416SkGdiUHh8byMLj8jHn8ZkgXhSx9jrYyOQ2p51LpLQH?=
 =?us-ascii?Q?OEDpudkdYIcagl3h0c2zCWJ+gWDKQmzx4qzFUA+7VB9L7p22OX+XLAMyBeTO?=
 =?us-ascii?Q?H1/U4sQ50S6es1AxxEI7IFbgCJbzSh1+7sL15fNXL7xI5PsJ3qrBdZoVsHKp?=
 =?us-ascii?Q?eMdX0RviuSl5QXcADq+iRGpGQKFFnHZ8dDEJUT+LCH8JJ7yM0J8TRrE/D9Qt?=
 =?us-ascii?Q?ieI8cR9Nu2sm60L2EEBIKewBJsImKFkHfFW4MJmqzlAUpHYsdJoZm3+7A2ZT?=
 =?us-ascii?Q?AA/Z+ggJXVg6s0SQxvcW0dqov0INy+niIoHij+swMGNjrmh27G9JxQlIHoN0?=
 =?us-ascii?Q?kKjfI7Ol64458M7ktzhJLiTd8XASKyi4baClmSTTUzWPpQU+UVIDN/OXKga6?=
 =?us-ascii?Q?SgaioJhy8QrgysePO4RK22rK4e6BeaerHDgIiFQRk+/cGnh3e6/rljSgYF8M?=
 =?us-ascii?Q?YsMM9ekxqlc9TXpt08/ylXlFFLGno/mbyYT+m9wdpzcovWhCoIifUqO6hy6S?=
 =?us-ascii?Q?ZVAzZeWwVpUe03vM4EZ8wFVyq1yrUG6bbnUQ7HM0xeuotA2Az4n5QRDwDcpH?=
 =?us-ascii?Q?dBlDetYG0AOorMfzhTFjkIlUwL04z59HgHjxpfhw+5Z1d0QsdF2z/52YO10V?=
 =?us-ascii?Q?KCsZFLnyqfKcLEbYF1JgO4TdjuGAJMVoegm7mf/Li1QrmurMINGC7cF5eOsV?=
 =?us-ascii?Q?OM9oBpPl+3uBoQQOwgGxkPqxMMDL2umswn6tKmz7x2ytY2l7e0TEtz5EAQdK?=
 =?us-ascii?Q?JZZd+CxpQlm/MxzwnOwR6J3ys6i2vFAuKX9hPdpI3ovQevtFdjSHKSghxmkI?=
 =?us-ascii?Q?5Fh0x34WIqv6SCj87Gh8CoTsJJss/Yn3qed8N9CSeeGDuFGegT9DoGuuHTuw?=
 =?us-ascii?Q?PurxbatNnLKkUZbG2Op8I2s6SEe+/lSMavD+tF6jnOZJTBKodjv9QqiySFzx?=
 =?us-ascii?Q?w/CmDZ6Si7EKbDQ8BuISBVIeZe+b3ZEZdh4tr3nGhGo1jsL7pMrU570WMOqu?=
 =?us-ascii?Q?tCl7UMQI38ZhaBCNWU8v/cCc0obsG90alrumVly9u0gtD2DrqoaMGAbpCbm9?=
 =?us-ascii?Q?GnWqL3r775uEIOi1ZnmfScCl1veZGZOULD/BDaAXPMRHwXKghDMIvOtwXZiU?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c83dda-ed14-42c9-77fa-08dc377fda40
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:44.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 407t+hdhtMoRK369YAxTIPB0+7zuqyceTypxoqTf05Lns0dM5rpB1Vg4q0bbkyJA1vedr9W62ocRZwyky8w6NR/HUruJdNZQ1I+UxtJLwzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
controller.

PolarFire implements its own PCIe interrupts, additional to the regular
PCIe interrupts, due to lack of an MSI controller, so the interrupt to
event number mapping is different to the PLDA regular interrupts,
necessitating a custom get_events() implementation.

Microchip Polarfire PCIe additional intrerrupts:
(defined in drivers/pci/controller/plda/pcie-microchip-host.c)
EVENT_PCIE_L2_EXIT
EVENT_PCIE_HOTRST_EXIT
EVENT_PCIE_DLUP_EXIT
EVENT_SEC_TX_RAM_SEC_ERR
EVENT_SEC_RX_RAM_SEC_ERR
....

plda_get_events() adds interrupt register to PLDA event num mapping codes.
All The PLDA interrupts can be seen in new added graph.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 35 ++++++++++++++++++-
 drivers/pci/controller/plda/pcie-plda.h       | 32 +++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 8a51d3aa7e88..b3df373a2141 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -626,6 +626,26 @@ static u32 mc_get_events(struct plda_pcie_rp *port)
 	return events;
 }
 
+static u32 plda_get_events(struct plda_pcie_rp *port)
+{
+	u32 events, val, origin;
+
+	origin = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
+
+	/* MSI event and sys events */
+	val = (origin & SYS_AND_MSI_MASK) >> PM_MSI_INT_MSI_SHIFT;
+	events = val << (PM_MSI_INT_MSI_SHIFT - PCI_NUM_INTX + 1);
+
+	/* INTx events */
+	if (origin & PM_MSI_INT_INTX_MASK)
+		events |= BIT(PM_MSI_INT_INTX_SHIFT);
+
+	/* remains are same with register */
+	events |= origin & GENMASK(P_ATR_EVT_DOORBELL_SHIFT, 0);
+
+	return events;
+}
+
 static irqreturn_t mc_event_handler(int irq, void *dev_id)
 {
 	struct plda_pcie_rp *port = dev_id;
@@ -656,7 +676,7 @@ static void plda_handle_event(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	events = mc_get_events(port);
+	events = port->event_ops->get_events(port);
 
 	for_each_set_bit(bit, &events, port->num_events)
 		generic_handle_domain_irq(port->event_domain, bit);
@@ -750,6 +770,10 @@ static struct irq_chip mc_event_irq_chip = {
 	.irq_unmask = mc_unmask_event_irq,
 };
 
+static const struct plda_event_ops plda_event_ops = {
+	.get_events = plda_get_events,
+};
+
 static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
 			       irq_hw_number_t hwirq)
 {
@@ -815,6 +839,10 @@ static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
 				0, event_cause[event].sym, plda);
 }
 
+static const struct plda_event_ops mc_event_ops = {
+	.get_events = mc_get_events,
+};
+
 static const struct plda_event mc_event = {
 	.request_event_irq = mc_request_event_irq,
 	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
@@ -931,6 +959,9 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	int i, intx_irq, msi_irq, event_irq;
 	int ret;
 
+	if (!port->event_ops)
+		port->event_ops = &plda_event_ops;
+
 	ret = plda_pcie_init_irq_domains(port);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
@@ -1007,6 +1038,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
+	port->plda.event_ops = &mc_event_ops;
+
 	/* Address translation is up; safe to enable interrupts */
 	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
 	if (ret)
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 89172ce18237..e0e5e7cc8434 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -58,6 +58,7 @@
 #define  PM_MSI_INT_EVENTS_SHIFT		30
 #define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
 #define  PM_MSI_INT_SYS_ERR_SHIFT		31
+#define  SYS_AND_MSI_MASK			GENMASK(31, 28)
 #define  NUM_LOCAL_EVENTS			15
 #define ISTATUS_LOCAL				0x184
 #define IMASK_HOST				0x188
@@ -108,6 +109,36 @@ enum plda_int_event {
 
 #define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
+/*
+ * PLDA interrupt register
+ *
+ * 31         27     23              15           7          0
+ * +--+--+--+-+------+-+-+-+-+-+-+-+-+-----------+-----------+
+ * |12|11|10|9| intx |7|6|5|4|3|2|1|0| DMA error | DMA end   |
+ * +--+--+--+-+------+-+-+-+-+-+-+-+-+-----------+-----------+
+ * bit 0-7  DMA interrupt end : reserved for vendor implement
+ * bit 8-15 DMA error : reserved for vendor implement
+ * 0:  AXI post error (PLDA_AXI_POST_ERR)
+ * 1:  AXI fetch error (PLDA_AXI_FETCH_ERR)
+ * 2:  AXI discard error (PLDA_AXI_DISCARD_ERR)
+ * 3:  AXI doorbell (PLDA_PCIE_DOORBELL)
+ * 4:  PCIe post error (PLDA_PCIE_POST_ERR)
+ * 5:  PCIe fetch error (PLDA_PCIE_FETCH_ERR)
+ * 6:  PCIe discard error (PLDA_PCIE_DISCARD_ERR)
+ * 7:  PCIe doorbell (PLDA_PCIE_DOORBELL)
+ * 8:  4 INTx interruts (PLDA_INTX)
+ * 9:  MSI interrupt (PLDA_MSI)
+ * 10: AER event (PLDA_AER_EVENT)
+ * 11: PM/LTR/Hotplug (PLDA_MISC_EVENTS)
+ * 12: System error (PLDA_SYS_ERR)
+ */
+
+struct plda_pcie_rp;
+
+struct plda_event_ops {
+	u32 (*get_events)(struct plda_pcie_rp *pcie);
+};
+
 struct plda_msi {
 	struct mutex lock;		/* Protect used bitmap */
 	struct irq_domain *msi_domain;
@@ -123,6 +154,7 @@ struct plda_pcie_rp {
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
 	struct plda_msi msi;
+	const struct plda_event_ops *event_ops;
 	void __iomem *bridge_addr;
 	int num_events;
 };
-- 
2.17.1


