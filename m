Return-Path: <linux-pci+bounces-2662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5120883FB84
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0000B20A28
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1968F5D;
	Mon, 29 Jan 2024 01:01:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2048.outbound.protection.partner.outlook.cn [139.219.146.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD7A8F5B;
	Mon, 29 Jan 2024 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490079; cv=fail; b=qGnWQ45CV9xgfo4Hxt9PpNZR1kz2okwLcXiNat0BTA+iu9u8aYjdvUru9vgrRbYkPW0OWvNU4TTPKb2KO/XWBsPQVEXxr/GEX5CSRfd2CQyqjTbB9mNgJqnEfY7L+IMLlGU3z16/gct8WGToTGXSERnM2wngvenNWc4eA6ytRys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490079; c=relaxed/simple;
	bh=SDRluIKdtwPtKDRBugcC+G+YH4p+OtMs3ZNtesAlOAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a6qyJ/334fNYcygqsuJB+IXlsji+hyaEd0a8FBbzjm+nVCqiacgQetdswM22+o1ma5APqu9onLk9p3ZRQYq+I2ijsgsefeErhxeL9nOWz4ebjAjzKH7Es2SU3G7mJDLTLxNeaNIZ0Q1Y7X5zFAYq4zMlnrKmW2hXdUMsM4J2JQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA0IpsiXXisH2MjSJVwAtb3BbhSwuDxFeS4NXGcSiEJh4Pk79gcGRelQM1fY0e2Duinuas302ibDi2Aa8w1Rprvx6kMsRh1Onu0Ya7L6/FtDWfeZb5e+yl/cKcGOtoAbQQByF3Av9RY4wqDptZlIhKOnp+nYY75CJTpoAM27LtWEUnozZOrny0ht8IetOTPKpLmd6FOq1B0lyIB8jfAHcOGJEid8MfYSjzCrTu7MmAbZVHJyTWnY8lrqFX66ngMMSafuixFFzwCaJgf9iKa1ZvUacvdu6NLPf+ewTyWBgjOzGlRCfy+cXv3EuQJtS2RYjjedBiuib3J7s5G1EEgl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmTs1eknZteQDcx68ARGiu+5RvkDg9S67OJ6YG+dVN4=;
 b=HPJUAlSCE+qZGpSB5Q9MwBwmdThp4DzgQA4UVluzw0hzI3Oq+wQNv8lp25lktXiBf/nCytYW80rwZcFmGjekgZ6T81XwWzwIHdXo+7a/6I07dVoOHw4ji3XJOcAuxWaOZX6NYn37lfkTJk97pYH2rg5RARz6dEkEZa9QKiS39uZbY5KxfLTSLh/7u2c9SQ1ElYWxotbAuqpZU5YtyX+fXFOZAciQp08RYHzVBOl7of5Bm9vNFuCi5nY+dpCiSsuouCQw5SJ7o6rahzDjVd6fJVipQVRBFdSLoWdQUrmChf57Va3Mlcl9FzNLdJjVaTblFeDjUht4JG4lflL2RQwGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 01:01:06 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:01:06 +0000
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
Subject: [PATCH v14,RESEND 14/22] PCI: microchip: Add get_events() callback and add PLDA get_event()
Date: Mon, 29 Jan 2024 09:00:58 +0800
Message-Id: <20240129010059.3672-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: e232ba0d-33e8-4a64-32eb-08dc2065c5ff
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kaHYvomQUXeLgKDTkto7eL32jzgFplMJKXlwfbNAOPC8/pf5Owxb01UHFGqSkHLXOy39wYiNB9K6Nna/astfZ9ZI1cQklj840kqviJrqX1N9EgP5Ziqims6RhJ7LnoiD0sVSxYU17KlTEY0R4e5Xb03CELiOigSPCp4XkdIg3OLAMMu4q+JmhsQ00TqheZjRQjf6rmPFpV/PiIb+/gZgMzAGVIAY2jem29oc553lYtRSvSuIHcL4DnOu1YZa5pYk3EH1xaXCuh7ocYcK4Z0qFS3LaYQ2gwHRGdOEZ3q5x4EB+W6XdHyjJ5/e4oChaoegmod1LQDyVsDqAU+mJn2WXl0AyjbVFR9Sar+BL2YhQxFM+AoQokNv4jQX/mPP3nyQ6ejdWlb+yOHYWtVquo32VzkEgk77IAaiihrcjrrDUBA47qNjg/CwKuMgeYwKoys8lwdBmO/EerwmO5BL786gyLGSkI68YfGmlpZ6SLgGYQBM6La7NS4VpS9IyrqHvL6I1H09KFEeRQiq8FRummCG0oWk11Co9hthQ1khFmmWRwUdIII41FAlx3j+2QqsaKgw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39830400003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(107886003)(1076003)(26005)(2616005)(38100700002)(44832011)(5660300002)(4326008)(8676002)(8936002)(7416002)(2906002)(508600001)(52116002)(6666004)(54906003)(66476007)(66556008)(66946007)(110136005)(41300700001)(41320700001)(38350700005)(86362001)(40160700002)(40180700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZjumFRsXCaIu/HRUdtPMADSY9HO5OeQw78aL/NeICTGhrB8ZoEEFORvvM3BS?=
 =?us-ascii?Q?+hI7ZVOllZ0wI/y2r7FGGfZsoJu6mAgR3nhrQgEhpI9OejYPrwiIk2PtXeHJ?=
 =?us-ascii?Q?MXCK1weboKhQhUjY88jQxwMFw9RM9bJpwIN/EMPX8n9nG3ROwykWAbtRVU1m?=
 =?us-ascii?Q?AF4hQy2h68A1BH1lFPbprT08F70QXZfJ2npXXztczJX3WOc3xHm4lRg6yvDP?=
 =?us-ascii?Q?klok6zI7UspfQqxKeqRvHt/rsr5OrPqhQner7yZy/RbD/2kDqNHZ/arG1F7n?=
 =?us-ascii?Q?vMAtmYrtPQtSIFGGkQL8eV/pB6+XgPyPjnbd3cc4ZkpF+SGJxfo11k3Y04dA?=
 =?us-ascii?Q?gbDM/+HQA2lG/bYNZZ3/5bgSaTU+TXpi0TEwqu0PbnH88eNlnzkYNVM/0ZCp?=
 =?us-ascii?Q?/uXqo38IanRMFdeMgc91x6kRHWA1Z9wKlXPLyOd3jkkc+SKVZuMz+0CNzgXP?=
 =?us-ascii?Q?pfLEE7vCgK30kaorppVcN2OPGprkxdO8Eq6eMag9pzbMs4V/qIq4M/n9fCOs?=
 =?us-ascii?Q?t1CmuyoT9/Rgfa1CCNgTD+tJDKONTjDhxu8UhrYB6ZNYfHfBVmQu7FI6h7Ne?=
 =?us-ascii?Q?HIb9VbKK6+dhtCAPm8vbUAEtjG08ncVei1D7n/Jxb8OCN92u+b0y7J/wQ3P0?=
 =?us-ascii?Q?SF/8uzuADAvhDRCfgsb2Rne/Br4RIAzQ/2MdScJKiZeET98TDxLOEFIFFeqQ?=
 =?us-ascii?Q?44bvvms9O0jDi4+VZa2ZGiNWHbOc0nqpLr2SSkhjjzI1M/1MxsGaTizlHtq3?=
 =?us-ascii?Q?XLhEL+b0VSJprZzhVWFBiGJ2ltlIZsBoqeSwXB2dVFKLNt6kf+r5N9RHNTQB?=
 =?us-ascii?Q?ipA0kCnn7CF/vEvwnO/rCAoK9eVIrRUW2sWlQ7XPfEgsXD2HWEMRUsRDWOFS?=
 =?us-ascii?Q?QMwG+CUkhM+/ISpuEA7a/BbUTyNPEt6fvhviVMmdGim+4zsb5kTYkJuy9Hui?=
 =?us-ascii?Q?pk7t53Laf8dGr0rFchlcj4EykkD46rCPZ+ZY/DRShlE8Ex/Jnw4kmFIkDfXe?=
 =?us-ascii?Q?/fddtpvJj7a7vy3T6MaNHqvHwFI8REgI0IsRmjep7rjkvGrS8Ki7uRkZpJN4?=
 =?us-ascii?Q?4a4wspf6uyHP5T35gRwx2eZ4msKHSwGEzdDtqqe5dtVK8XekLsuTP93CVdZ8?=
 =?us-ascii?Q?pj+pMVGEXVjpCF5m/j68gmBhaniQ/YayIzgts2Y96bR87H3cO8mur1pYeVth?=
 =?us-ascii?Q?FTXG6rX1zyK+EluRLdNYTqjIbC8lxXs5P5zX2ELgFyOmEz54TEBUrQuZIu5O?=
 =?us-ascii?Q?g9NRCt+jdDKf32xfeX12buQmxyadrDb3KvvxV9vRJkRa7R6oP2vNuAKttrpj?=
 =?us-ascii?Q?7y0CAsitjtuCX9krQr26S184dj9f/JXYRfs7nuKd/3HBzr2KbXIaGxfNuJJf?=
 =?us-ascii?Q?+dGEPcK1xxtBkmlAi7zbyqdOLK0Z2GuiHz0VbuiCD1BOS5GkQHn0YkBk7vmj?=
 =?us-ascii?Q?lruL3m+UipHwpkb9ZipsmTIJYv3iZbTVvk/VIex6UmQEi/yvm/Dp2iVE/+pS?=
 =?us-ascii?Q?z1/cU9Ok/QUD7yhUG+w6kCHoPXo7vCs0IDX7troKeXSPqbsJW+QlqbbB0oq+?=
 =?us-ascii?Q?+GO3q8qxRJsStudm9xoeRhCA2tQJEAEYs3S9l5lnP1NXRUx4mKjiL7HlS3gN?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e232ba0d-33e8-4a64-32eb-08dc2065c5ff
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:01:06.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkn5H445W001y5xh4u9ZRAGW1G52tiRwIXrpB7niOdedsdGujmw30lPKteswH2m3SQ0/a6pg4TM5BiO4QO6eQJvVKO2iDeXQWO9VJ59Y4b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0855

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
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


