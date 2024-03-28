Return-Path: <linux-pci+bounces-5328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62B88FB19
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA3C1F29C03
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127D7E564;
	Thu, 28 Mar 2024 09:19:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3A446DE;
	Thu, 28 Mar 2024 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617550; cv=fail; b=XLXW9XjkU4COP6A8d9/3ioV+L9EcOIWUUaBd0Hn/rhAih3nbvM5NUX+7G88kNIG66uzWpC2r7r/I/rUqGDLi18YGu0a0XEFcCNhlCu+2gbGZmNSx3r+h6hIgEtULkwtSPOnOcUV5A7UYgf1PbDe4uWXUMg7TSuNWNUbgjuHBerM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617550; c=relaxed/simple;
	bh=C5nAugbEc4otXexvnJcq5jk8jk76kNdeS5qpTB1308A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tlpenonfIfiub0bN/Ov8R7ZCQJaU2L/27ltRvPTC6QJ7URZox6FG0T22oMjrxpf8dMLcexeQmpRIJdmbqgcMoSmeS+j1771DDKFwylwTKFghZtquNnB5+mZE2fEmuhEX5+3IVNFqCdFkcLeEl9WQuKvj+24W4gJeFmeur7sJLt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFvuWBeMAgaEmH6VFvgMh+UtyQES5GWVTRkVcuGmmKVf3WP/eE0Ts13pX4AMrOoHKF5SfcMIPr2x7pP90UIPthTCEcUCHpIthPoBVzc+YSBk0auF3pUmHhGTlf2RHX+WoOkoA8u9dRQnwMmQkCZDf1oCJZhV9n1MUXP3QxNcLDxXkM8lbpAqmU3SpLmw68zk1Igaq7q9uiWRLm+YG6pNWnHpI1onNdPmigL2B1UcXh7dC5ciK/TI4mZdU+mjpZlmDRLTNLUnXaAyZki68aHg7hGvwNdlPIkv1f+F1q88zapB9HWnU/OFA5wH1fei/qgART4V5kFS8PUl8ojDeerOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ890sPTDIaTgSVopGlFF8OTlffwS8+Jl3vvqYke5M0=;
 b=jylh6k+3wwvFktsU2Km3u2Q+wxN2o13HRy7/IVQzM8NIammeQiFOCBjTxJej3ivEdDbwAPotoQd2CvBkySRM68WDISMK0B9B7cb2+q1F15bM8pnzghAeSpgTt8z5FWFzG5QqW2EGNXJpS9cbl6Yb6fMIH+8ckxujQm3d/aq6LEE/DoQhbWiiNZYX4mpmfd3nGx9nTk8J0ZAnuWYyfjSjfumVVeA57bAX94V2zfV3T8sXPvwTywcQ3EgTqI+VLm0jS/Z+9DBIHdyoJd1q8UU/Xzsj4gZyKFCZ4tJOGCN3NZwofLPJ9C9rPM5HpCFeknG2t58FAcXaocGxzF4nviOEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:58 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:58 +0000
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
Subject: [PATCH v16 14/22] PCI: microchip: Add get_events() callback and add PLDA get_event()
Date: Thu, 28 Mar 2024 17:18:27 +0800
Message-Id: <20240328091835.14797-15-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3007700-1537-4148-fa3d-08dc4f081915
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g/ZPqoFGKfFeQmoEx8ESxh/dLtKK2nkInU9tk0snIYn0PtF8RM82Rl3oxIRC3srsUumG0McmJtx7yDbxX++8BeK/AkDvAWt0kB2NgcTKeSAqcNyyNMH2mdEZGSM2Kt5tjR7yRG1/OorQv7j2YuD8HIwg0/Rt2FlBL+h/lPKfnycVADL47g+3pRmz7Uf2IdHmjDGRHrto9DJBh+xOAwbdhCY+zyeOqZQT+Jk3nkLbgYJhG1oatRkMrqV2f+6t902hRvZ0SBEeEnws8f8FbQnc2VXKLisnxSAh6Q23uMnS/4lqWtCk1VSzSIfpUvis/iTYajJmtOGpd5oM/jST9hNn7WcfRzQuoAa8sgl+KcMxiRv6320Y1rTgJrF9+WHBrZD3Y0tsvIEei076WDdjUkwZmdcUkRTAUA0wxd1VUXJMT2gVeMjK8D946ciAQiz2v4x/U5AMscO9Sjuo8CLXu+eogUSVPN1YSYjFMu0yhK33YdibdHiTcG0wTKXi0EeXvfmrdlC2lnOHh20RoZnDWthv7c+lGP0VWFPfbprKKQOl/mZYybNNXBv3on0+Mw9mDzHovHQxt6qXnjtSCeX29qoA8P95+F67hHQPkMvmESnQjQNUkBPB4gtyShypw3Hc5eLw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FYJvSWUL7flhiUnZhax+ULOvorZlbicQ6+jXgnnP3nCyHg9RYYCtSozXUiRc?=
 =?us-ascii?Q?qhhb0C92vZqngHWw+QjZgycJy0EI1CJQJ5ErY9FcKB3fBHMs8OBvlboJPwa+?=
 =?us-ascii?Q?7nYEsJ4NxqV2t/rCn0MOaB0KVs4YK/vtOUQYAGRd0vVHmqHpkfRvilQmM+b8?=
 =?us-ascii?Q?ri9YtIb9dNIQK+UBNXr+KlxSikZtR+9rV1oiY3K3vQrhkbjpVuwheAr66Q38?=
 =?us-ascii?Q?mj63F+NcMaftCGOSBvyJRWyejLSzw6WLcazKoa2SsOb1qpuwrGVB/BsHFRi4?=
 =?us-ascii?Q?PtljXJQz7Dse6OtbAHbPMmtbRjNgkYptNTjcs/na1l9C2djQ8UwrhnaEbjcI?=
 =?us-ascii?Q?p6PZlee2k1omfPC6FR+XiUqadEQAxiYdJSVvseyViG1PW5hqgboVQTwh8Xbq?=
 =?us-ascii?Q?CB7+ZRtry8kqkoqmZsC+gHGxUF8k4XwTPs3hSh/7FHPxfMZvCG12pyTupPsh?=
 =?us-ascii?Q?V31v6Vpc+7kauGwgcLRrlzXmxJTPQbMto4rFzUdOWEki1wKkGGjGDZdUigUx?=
 =?us-ascii?Q?g6paxQpebSDWWWsVnS4ga9Q90FcLf5MEoty/KdTehGGTQylmeq6NBzjgMsu+?=
 =?us-ascii?Q?NA5J9lsmmrq1AOAa+EhRi1Wq42S8dWB296oLf36pTcbESn8E7zzUEJDtbrJP?=
 =?us-ascii?Q?kUCBc+6Yrz+e7rg7r1E2SOwmltlqM0rlWXB/EkT4ivpL+cDQe+k2cgi8SPEI?=
 =?us-ascii?Q?1Y8vFYiAjV/rsErkHcT+WlHfy8VbrBucTiA77SIlIx8pR5nwLCfCGKse9U9r?=
 =?us-ascii?Q?LW7IzAVbt2PDPEMajfEtXk354p6Bd/ltnaaxUabejGme6lmVumi1nMefG8xd?=
 =?us-ascii?Q?rcOtAF4QuK5GHkS30Gl+y07OnMkI7UrTarLHmdx0r6elmlrIh3ZCYGhe26rC?=
 =?us-ascii?Q?HjdlsnK1Yow3KeA0Jx1yMEuwrvMnJvvOSeD7HwjejJYkScPiE87ngiMtxa5c?=
 =?us-ascii?Q?Uq1k25Miw6UYyMmnwd9AN0p7R8rCFxjIc8qI6TQeK/rU5IP9D5P7lSI1vLYn?=
 =?us-ascii?Q?uBoq+0xVdDI63fzPpcj0FY4smktIh5db2XsNQuqe+qXlpRT2LvunmFUe4EOY?=
 =?us-ascii?Q?eK77pohISrnm4IHFuLzT4O3mIHqRwMZecK5BAAV+28nSuQLgXBHou9Dtf0PA?=
 =?us-ascii?Q?CHAiMjXVPxLg+m3zXk+3PCJ6eWi6yS0QY6uMBw2qMLvdPWx/fzyr2tx8sxNJ?=
 =?us-ascii?Q?+lwLHFnQBFIibIlJ01lGdNvVIMlg85F1SrGFQugXH3rCFag3PslAMTiDBoIk?=
 =?us-ascii?Q?99Vc9hv+9P4+Fyorb8aoO2cekmO70l8Z/ighzrBHtBik+/A7YHNgRWj6W/Gu?=
 =?us-ascii?Q?YnftpYUM4nLj8dOwSd7hq3955HKIYOEJ6dvcbG/kVYH2jl9WKEZJJgeX5nuG?=
 =?us-ascii?Q?2YDhVDKwzyaOSBuQkhEQZtRCquM/iCa+PBn7xj8UIG7il13PSttqFgMyYQqO?=
 =?us-ascii?Q?Z2djN9HzJx2KZTPnQOdt2ig6iw8hwr+VvCUxu8JHwd5/ZCA/RKkesd9ESmLb?=
 =?us-ascii?Q?CqGNdIB4QpoKHDfT7VLrvCOxciMmTgkfz8MWM7nj7QTkqhYNX46YCrjFmE/v?=
 =?us-ascii?Q?q0RBKIlETXHzC7/g1NLe2SdyKdU7wRJm4jQ/4vGcjyHa0MGurULadQxT+ShS?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3007700-1537-4148-fa3d-08dc4f081915
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:58.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1goDZnbZ4YlazUp4cuj41+xEPFMpTc8VH3zJXSKPv8rxe15TvaglOzq3/72JyUBStIe2ofeCC0up6y+FwZo0V88fhSCQJSsNNbytdDfltzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

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


