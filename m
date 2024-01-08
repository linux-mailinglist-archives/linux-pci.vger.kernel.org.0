Return-Path: <linux-pci+bounces-1792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6895826C41
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3BF1C22144
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31701426E;
	Mon,  8 Jan 2024 11:10:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2050.outbound.protection.partner.outlook.cn [139.219.146.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7714277;
	Mon,  8 Jan 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c28fN9/VdEPNREDUgMvu9KHI0nKjCTShAFsNunNLs8RhHqas4Ryjqo6cecw4s9ALv5snRl8ueiHHUJJywg1W4oM+ywhfmefRbPEHR3HTtcu/x1Ku+6A8GYzFViX+szi7m03BWy1HVlTWXTJj6+Zv6KQQB1043tjM/jN2q+fB7eQnyaPAiqGwRtlQkA2JifxsiW1kBwsojWPp8EyUOS74pCiZr7jrxLQa2otfx3a2BLIu9AXT2nfUGRlAsZv/15CjffXgScTxpYe91U3uM41kLw3fGlQ6JaxZYT6B/DLDwf5Jq9rJwQBEV15sqNQ5T2X0RUnGfpMUvNaJf0Ely3Yobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpqY99b926ol+SPs5WN+/WcTgyU1vh55svYRCowYusg=;
 b=hZWqvjJqARZvYFZ7wA7GovVp+pz+p0LYYBUz1tmBgm+mGakRPLayKtbYtWBZYvwsaf1cnnwwFC1zpGqp7nDZAexCKcqs+SCDI7LD6ol/b5LC5PPIQehnOEKEzb0WZd5q59vtDH3LaPC1jXYbn3EWrMy0jQGU32ItirojZZ/6jTgx0Fyo3AHI0JmXJLR9Zwnv0b/3cPG+WMRsO2+SS5gnyGaBK8HBCBF6pvykG2pXvkfj4zHiP5BKVkclX6v2zE98zooikVnnoycIQqM8dtiO54OeM4PpG5/1LijdB0BlXZ4GxEGzX4bFAKs0mczLu8I0eGgo3Fawzd1rgbGGMOeAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:51 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:51 +0000
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
Subject: [PATCH v14 15/22] PCI: microchip: Add event irqchip field to host port and add PLDA irqchip
Date: Mon,  8 Jan 2024 19:06:05 +0800
Message-Id: <20240108110612.19048-16-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 778b46e7-0fc1-4a29-6bf3-08dc1039eac0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g2x5tHIXoV3eaALHSxit4oColJzGiknXodpwtuxjpyh4vTzTLqbOJLqdBCt6dIRe4o77He48rhUku35EouEHQSrJPXeS+UWjlmcGYsXhWtrmHh9KZYWVkyq9t8RysrNaxWvzYvdUgltwiKX+q4lMzsAxmPpUV9a73hs/bznOFoCCXY5TZ3oXnC3N9FiU4U3AXdyzYyPwV3uDLPcJ3KvahVMdbZ91fJUogf5nfiKkptrq+1xTFR9bLLfYfTRXEuVcU6nWGMYkClYQeZzC8A5e81ecBtoMJwcBCguAQ7iSFcXaapZKsaTvLEVYXztkGwiBxjjUKP9hwkEY7Cr45pXCDDCaPfINWRRKAZDj4O/wNNXxtqI7x5tPZ1jDziM/rAggPhh7wKOoas23GlkWNif0Nsf7zAgnxmgV41aEfkf8FHSiZRb/ev7usDER2XZhJLdjCtbW7vCG67RFCHgOM2xdqJdOiuO/6UiZw+kLJ6yhbUMDiTmU+KV3FCEndI2rselPOqNjqv2waqld2xhHog2csIDDCcOily1/DUnbFbxBk3LqAJKMYqrlgwiwCd6yHw1t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OEfiKfX71KEG1t00KpDQQM65o5tYWKvJmrNy+1E9FfVp+OLX68EMGWLpMz3/?=
 =?us-ascii?Q?4DXXdKvFELEwpXqbfGSgDLAze4G6ze1R4IVqNI0/gAQLLGw3ba9Y/Je7cr7M?=
 =?us-ascii?Q?SypTAkSfcc1MtB0izScOnlxux2iacAabsR0izXuak2zJaecgzgjzI19fLXdd?=
 =?us-ascii?Q?Seag2LsrHZ1ZdOfkK7vG7f+yXzWZumSTMtgwTWNMkitGfrq4DG8bgFa/uJF/?=
 =?us-ascii?Q?SkVamP7x/AU+W310qDn0YOhY6TuCZqJRREz2ZFsUQ09+LKseQfqph4kUek5o?=
 =?us-ascii?Q?DzgcfrL2jWuaS7qpISYGqNUVKpnAA0+7k13k4ccwAQEQvw2loNbinRh6pJlT?=
 =?us-ascii?Q?VAVl1xqAlXTh5Jp3f8uMiVlSKI8KiRxhp5TTXVepVhCpEfIDbsqIBKyICFr6?=
 =?us-ascii?Q?fLs18OtoSpOqiHKVFP/TPXnRveBeqVpN8IzGl+K86Kx0IlRHExurOxjW3yhb?=
 =?us-ascii?Q?VOqN27dvpSRcgt3rz4KN+h1m9RZQf5LnXzHRoZwzyzroPKZfoyRaGT03Iy1U?=
 =?us-ascii?Q?zTLzV7LzD3ebPxDsdnzWbz2EGVDwHuOR/hMXso6yZ6x2MeDBL9SFTkajIJTB?=
 =?us-ascii?Q?izejrC0/BQHKXp15XGCdcwIplUuf7HkNsfIMDJO7n1icuFay1sVc9WLHzUdT?=
 =?us-ascii?Q?RpuWh4NYj65V9H368mNMm4gIh6TqcJfjp5iUqegcmWC6IHOYOi7UfUA2oUTJ?=
 =?us-ascii?Q?W/w6oxdzhdx7R2vm6KDXaDGAGI9mwtxqo58AuRH8keZn4GaaIpasch/9ngA1?=
 =?us-ascii?Q?1yPdnBgrOfaqNsha+A9nVku3u+PMQQnl/cz3iK2fm26SM9G9LzGcm5/qO3Sx?=
 =?us-ascii?Q?kshgJUXbCJrdqjR1xe+vbj2NaEYsagnePBeBYhKRAg4fQAhSyMARIQyP2/XS?=
 =?us-ascii?Q?ELTBPhaGYnN/mEBLArfzYYYAflg1bzYGLRqWpznBautJs64rpF1Twi9IKdhr?=
 =?us-ascii?Q?/zhMxdd+Xl37qL/NrNhvaC35DzMjorewOoVTrqYRTWhy2wDkCxGfYKmwBj99?=
 =?us-ascii?Q?pi+Q66xenpSRvimivQld9XTE72vr/u25ehe8Ny1d0JJj4YsuKCTfMm1GJJcX?=
 =?us-ascii?Q?rNsCXboYM6kZNq7SpkETgubR8rmR0SRDRicwlJeysX2Xp9e81PGJSrYfU/+6?=
 =?us-ascii?Q?L24y+lSE4F0zosw7K+vVC80LofFbSxQ+kVl3mEGz2kCA6Kb7He5bEXN2e+fQ?=
 =?us-ascii?Q?qdPLLS3uXTDot8U3gGGoVeER4muaj+D6RvT64iWd639G0nBtA+y7re46A2DL?=
 =?us-ascii?Q?w9Pa6FTlpsuM2z/gImRzyVfLIQe+0E3p8Q9jiHLFLzqAqY0vkwwVo/h4WoB1?=
 =?us-ascii?Q?vWoRA2ylrSDmMp2BM4z2EMB6hwfn0wox0Duvw6DLnDaGfU9nVGSFAK8hI5sc?=
 =?us-ascii?Q?qxh5oaCIn4m7KmDy55zbtRIPHFU0TkKDqIJE85tBeTSQoEwMAlh5Hcecs9Dj?=
 =?us-ascii?Q?Cho3o0bKX30iXmp6FcDIvOLsBfEhqjZl9F0h533bvHi3vj7lfu2LgwB+GS8c?=
 =?us-ascii?Q?4BlwOsGWAcgpg0rk1QZuRsvZTda7gl6r8ug7lSEKW0Ct0XbYsmMFoNtikLWA?=
 =?us-ascii?Q?ct/mjF6TNPz+KboIHaOyZkJxcNA3k1mV0+OtELMn0wbnFFxxffUT9/oUNnuu?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778b46e7-0fc1-4a29-6bf3-08dc1039eac0
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:51.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gswIXt/Ba1UJU6Mbo6AbKLB+ProWYSDyq8TuGZMZh0XiOtCKkNmyTkdDlt8ARziA5qVvw/q2VtbmyYy/HIcTd0KufQOf8vh/PRT2JSn8F7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showes, PLDA PCIe contains an interrupt
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
 drivers/pci/controller/plda/pcie-plda.h       |  5 +-
 2 files changed, 69 insertions(+), 2 deletions(-)

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
index 9db92ccf286c..a3ce01735bea 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -107,7 +107,9 @@ enum plda_int_event {
 
 #define PLDA_NUM_DMA_EVENTS			16
 
-#define PLDA_MAX_INT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
+#define EVENT_PM_MSI_INT_INTX			(PLDA_NUM_DMA_EVENTS + PLDA_INTX)
+#define EVENT_PM_MSI_INT_MSI			(PLDA_NUM_DMA_EVENTS + PLDA_MSI)
+#define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
 /*
  * PLDA interrupt register
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


