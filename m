Return-Path: <linux-pci+bounces-1791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD94C826C3E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07251C208C2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17F14017;
	Mon,  8 Jan 2024 11:10:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2050.outbound.protection.partner.outlook.cn [139.219.146.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F81426F;
	Mon,  8 Jan 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO3/KZJ0ej4TjUHBdZ0yRwqRkGMDn1FVm3cCd0RIuNVo2q4rQQ0URJGQIbK7GR368HAb8QnbRno+j/pDYvU8sczUJT6gpXxf10SZ8fdZBpGVTJ3u1wJlQPZSGQYESICERtOgcCYuIVrZNeN9q63sWQuOg402PpGoJD5MLZf+tMUhuPsTCfrOfIMuui1Aq1Odz6gJy3n5yQKVOkGGF334H+GpZ9Gi/qTMeMipS9vb8IIzamjhdi9ybR10C5q+hsQfV99di/swBezGUqLpIdHLMcwONgx8Ip0b64xHPcE5f4rx0Iwtk/td2NZ+m28xvAU+n16Wl8kVO4FHu+H+QFNoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MZHud6DOJtHq48cZ3FRIwx5aCvi4W9JCy0s5IDEiPo=;
 b=avTgESNSHBSAEBV8EZ9D1poqZzsebloDpVzynWEyILmTRgLI9rFHuiyHojxQyupm/LkDLV9dAseSh9o/ohg6C0Wz4R8nX1ChNO7dHMGiPcD+rR//1eROiooSD6Ew30saXV/nmvwzPmAr/9Oui0QW75/+J8MNqg0mwXuZ2lbaC7+JMtA2CpRdCjpIakIyPWsTcVg79NZO34xYED7B3HAHiPZv4qWRjMZB/FoGR4ogAwE1voKj7kKutPsMu6xmifcbA/TMlX4lYUyrpQrwCK+yUkvwg8T4J+ZwcfN8dsRVnD1lQVXyJgjGZGDlWaL5mEVbPcflU0XaW1q1N1MwbEiwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:50 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:49 +0000
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
Subject: [PATCH v14 14/22] PCI: microchip: Add get_events() callback and add PLDA get_event()
Date: Mon,  8 Jan 2024 19:06:04 +0800
Message-Id: <20240108110612.19048-15-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e7bb5f3-f1e8-4b32-098b-08dc1039e994
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q2xb0/IrYH/URU2UW9oK4R9fCBNF7RVROCWAoy8Z4WqFtyRBEnWfzXyAmqZnuKM9ERT5I7osCJ9mwftxl2Z/fD43ZZL0mOJpn9EPz1TPgM/6QCrPYtvZj0AJkAytF6dn8DOcmsF+sQccHFVNROJ1b/3OP6/ZMuIgoOFIU3uCWf9SAstn0M2aRjgi0x03dnMQO0EDCP83tk4EPol6XC8ZnKWcKGdsaUbjXirBMrTng/v8YWHTfvNYqH0Mv1EOkBVTy9kqWTJrRQfMX1lX7O7nI1uDg1T1Lqd9GDOB7Teg5x/gGup+N0S5i2fdpb8FuSNCdrzqxeydQ9aK8YpXPN8fiTr9HujVs7/wUmBy7QtZcTzCPAOPUb7ann4cJMoMLz5V/awy1iUW+0oEJjbI3s6xVgbbhBAbKb7l0ql1cxFynuIOm+S94w9b55xahE3Mh/ngm7PcXgWPxC2zVMUEMihkWwAbNm51G9dvOoh+ztrPc7+2w9c94whmEjk+Af5HxZbeJWxTOox3cXDmT4QA3YRKla/Z01+20q49RykYTG7jbd51xmPwmMmKVbb6li1/9pKL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y8Q7fC0zRsLwGsIBCiTFPKOZQ7U2QMIn4LY/Mzi1oYq4t1iiOn3ZdhDNg7pB?=
 =?us-ascii?Q?o5kdknWaj7bFckUp+xoIjc4iJB7weLzBWDu343npfyqbhxEp08w2JqD73voA?=
 =?us-ascii?Q?NVtxl/1CoYUc9SMVc77HlczJedXv5Koiv6C0KuxFAz55P1QxJjbj3bg40NV2?=
 =?us-ascii?Q?iw5gwwB60lbAVM6YpAxiI7WBBiLfAmcW1JL9jJXB913moJJpC1JbOJxx40WX?=
 =?us-ascii?Q?s0Gbs1RSxtqX1g7sc9R6MTH09t5/OZW8jfxDTbYLdvms6aTKS0FPiqcYFB2T?=
 =?us-ascii?Q?urQBAMf/gB1M7VYWmh0uoQCcyIs5YJMu3haR9byEwLkMijIb8eQ9mXZQTa0V?=
 =?us-ascii?Q?dGYctci9RZtBVEjIO4ua9GPiDdpuzWT/m0f+jMz9ce0C8jwnEbDW70Q15Y3+?=
 =?us-ascii?Q?y4rkbTekpml+V0pL9sXekOR6XaieOICdt7ljoRyLTQkQEjoEo8C5Jt8yVGvQ?=
 =?us-ascii?Q?izBfL6Q9Prt/NDr5jB3bSY1idI5OX7Pp8m9crAB6FM7EKHOp3yX4O7jMH/9/?=
 =?us-ascii?Q?o+L26yfPLop+6ndo/n/xWD5UBEu9YxURj0qW0+ltyJDheLontmZxvN4heeBv?=
 =?us-ascii?Q?pyB1XyyqLB/28wsuRozXLfamjcjNMtM8tAo2c3MQ4+eza+m2YoqvCitBWDPk?=
 =?us-ascii?Q?wd8Zsz0ILbWygJXpB+lFPfPOq9JRVJNaVubPiZ4svrvQCki9wb2Ohv9vRwA1?=
 =?us-ascii?Q?/9JYHMIhp2p0JnpUv1dsPLNPue51yT3CHJPs/5ZYWxx2SdBYEmLB31P67nC0?=
 =?us-ascii?Q?m/m08DgWQQhDTQ5zPmEhJWQLN0cKAKjtqBSjERCK6BPGNTwNP7trx9kbg7NR?=
 =?us-ascii?Q?pqcC06wrqXUkmGbCzxwNCGJgk3sFBW0n8oAnKLHRHf0XVNFqDUy8wPFQ+bva?=
 =?us-ascii?Q?mx5aOltxD44IN0g56PyHFYdn2TXgpuv3bQ6fhwni+z68uykEoQZ5atF6NZBL?=
 =?us-ascii?Q?UR88HWLVG0ftksGHbbFOmPrMpYV0VmHCYWMUN55Hq4j5ylNrdf7tsyVZ9ZJW?=
 =?us-ascii?Q?OjRXl9Q7cmzdOX8ufS99ayEd7A6Gn6nvKdDE0sJocMdCVko9vV/nlfjutYwK?=
 =?us-ascii?Q?2vJjMN1KUozmlI95Ie02yBP7SrcbK+frfUrGnAY/z8gIDCfpXujI5m8WbLna?=
 =?us-ascii?Q?R6WeO9WiuRhdTDYXgLZiJzdGqRba/Ilwdod+x+usWAkfWbsCTplNfDp+IlEf?=
 =?us-ascii?Q?w5MuRlFv2uW43Mq98HdtXiubLSnIfPif4A8Lk09ogMlptammGiXZdNOI3vDb?=
 =?us-ascii?Q?cScT9aFamYy4lA4ythC4nPanUWN5Gz/oTJLp8ScPsPVHncXkqfm51h62V75w?=
 =?us-ascii?Q?p2MCTnlkM0aq7aAFnIgmwmQEqYGI1W5YzOkcBhR2ZeEQasW47qekwNqCLSmO?=
 =?us-ascii?Q?17jPMX7C/eKqpnNOAWDeTq4ct+Hmi3YA/VID6UQ/TqCHKzY8sd/2Iten4BAJ?=
 =?us-ascii?Q?nC1lsIbkyU201v6a/6bbG3Xcb68ti4NmdUJLzQPWR4AcyHYK3yb5QHG8vREP?=
 =?us-ascii?Q?ON/Pg/+Z5v7jWdXnjjP7y71cizcv2AnsBBf//ckF0TqPh2VL/XUwR2BuSDa2?=
 =?us-ascii?Q?bQZZe2ZZujipE70iGP3hk8ocmsDyoTU6JnHwulcsoNMmiONt81/D5UDhPw+h?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7bb5f3-f1e8-4b32-098b-08dc1039e994
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:49.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45qgO6nBlIqYv860XjADsVQ/RU1daaLyT0X0lyHxal4fyvXjcAzMckGBpGanKzIu2WKFnx9C3OAKwQBWonHCE/WGhNvjQp8hHhB22sIi4eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showes, PLDA PCIe contains an interrupt
controller.

PolarFire implements its own PCIe interrupts, additional to the regular
PCIe interrupts, due to lack of an MSI controller, so the interrupt to
event number mapping is different to the PLDA regular interrupts,
necessitating a custom get_events() implementation.

Microchip Polarfire PCIe additional intrerrupts:
EVENT_PCIE_L2_EXIT
EVENT_PCIE_HOTRST_EXIT
EVENT_PCIE_DLUP_EXIT
EVENT_SEC_TX_RAM_SEC_ERR
EVENT_SEC_RX_RAM_SEC_ERR
....

plda_get_events() adds interrupt register to PLDA local event num mapping
codes. All The PLDA interrupts can be seen in new added graph.

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
index 0efe64d5f688..9db92ccf286c 100644
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
 
 #define PLDA_MAX_INT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
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


