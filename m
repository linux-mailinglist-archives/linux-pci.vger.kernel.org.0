Return-Path: <linux-pci+bounces-3674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D285964C
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E04285E47
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE54EB55;
	Sun, 18 Feb 2024 10:33:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2100.outbound.protection.partner.outlook.cn [139.219.17.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509C4D58F;
	Sun, 18 Feb 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252417; cv=fail; b=tWWdRZBj6v1fTz9vYRpqq9GcsQKZFZ/BjQve2zJdcNF1TjsU9Ey53BWWbBj68sI8Y8h72ivf71+ZKnNCV7gRgEdtcZxjKh2SIyH7QgRHDf9u8G4G42Nl7YH9StZgxgqlCo4pWoeOvao5Gl62GXWUaaVjKMdFvLORifnt9jP85RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252417; c=relaxed/simple;
	bh=SDRluIKdtwPtKDRBugcC+G+YH4p+OtMs3ZNtesAlOAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oESZWYp9GibLqIXpHH9WSomxtlWNVW9m0kl/QHd1WkwYoltN4GHeULfdYUOOSVH0VEaLKPc+LKgJYjxQ3AE3HMABCw3i0MuWhUkAyEsVzrPIZiJ+zVZGCny0m0ZspNMy8gdNBJfvvRdsEOybUFEeFeJzoPbnNlcdjPXV28xYf58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XguiKPLkvthW6VH0kQwjo1wtBwuh8HAnwhdHZpkZpTuDuMB80zB68Dp5kSIHpfq4mjH20Red4NHy6MYC+OF7y8JzOxWEJBLNazZ/RrET5xeWHKWzxp2UcFIaL64Nrmm02qswcTlI5SQcnZAvbQQQBHUcnu8wgDbU+lku67Au9x77vXTLjOWPaBJsRpYezFoXjsg6L4w0jeYJ62Q9YVOFgq33MGVeUegNPu+ABmkgJyTgntR0wNLhUYovonYvtnsbRqVfkpAXXua2360ytZBZtWXWBC5TVf9rrA7AIlb1KZQ6o0GkoALJXO/b02Co11DGiQckEhqhUNGQMfCIJiH6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmTs1eknZteQDcx68ARGiu+5RvkDg9S67OJ6YG+dVN4=;
 b=YvrhnoHcRbRPS2kdi2mdVJoPUTl0qDFdo1MQTTwkbN1ebDat+BEw4b6gsdM8P83qFDzfohPRwIk05hCHWKbLObcMdY05+Z6hlHGYAewXnoO6WOJL1JNGXGw2WmnfyBqDmETgrx5FoxYvlIcZx6cukEz1vkAb2BW9ldlCf+HP1GxgY7mtt9gxUo52u1qp/GLwMBfl2Fghb4MjIcfDGQW/WAqZAAI6BOX6SLr1ClnRc/tMXvZwRIGtXjXD0dyK1Th8iB1wNgOw9JBfTA3nX3NeuyNYOQPrPirU+u6dgVUQ9mzrWh2LEy5WzvQe+rh0QDI18KswTWYQSr2nv2unK8OALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:18:40 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:18:40 +0000
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
Subject: [PATCH v15 14/23] PCI: microchip: Add get_events() callback and add PLDA get_event()
Date: Sun, 18 Feb 2024 18:18:30 +0800
Message-Id: <20240218101831.113469-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e88696-6286-4cc3-4218-08dc306afa00
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fG77tOYjZ4P2hWB+06HUJ1mp1AcpAE0Csb/ai/js8BriShIpuSrFVnJA94exwtvhFXf4wC1B9gnZl36UVboF/OfNpxSxTJHu4hf27B/gYJvBcvXldhVopotMF6d+/wWVnnDakZkUOFQbRRE2LpZPfo3/heImRlna6SSX32VHXhY0H/2pI9znOGcFqHSVDycnQI9cl0GmURwQ/xTPu/ilHtX+uFS+qcImUP0HGTqHXXwJfcGj0UQTufZkBCJ8TIu5AZJ+ONx3FmMhkcxe6yX1sKYr2xKLGpsxbv9r2vJx4csDcRqt1cL41KZvpTHGKwfQXZnhbOhKejfSzIAMZZ0t1pLsDbJm1OSJFq9wB0FNMekx4b6IIzCt47QyK5L0Zdi13ame5RmqiTP9YeAdO4KHlKBIsZogfEGwk64cjlZuIby2avDSI/5oMke9QDBDXfHllGHtlbEFeWx15sK2JIqo99ylHHdKQjWfV3MV81VWI6a/x2cx9QF6qP+tj/p6dr02NWzJpJayXJOmA3UE4AzLuGtuD0sHo3Qn/lgdyNwZ3a3eYEZ8w/gA/R2aQrrxOEea
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7HOLSjhdEebLdeQzhIxpCek4Q+uRhWOEv6jow9mSYnqFXD6TAgeH9Hox0dx?=
 =?us-ascii?Q?t/Psm2hLwUfARGiO1Nv/U2a1VF0ZKocaLDwPk1+28PHYHRbp1Lo08Hu6Ejpa?=
 =?us-ascii?Q?0CNoabECgN3FAbzlrfe0QtDBf2dwjF9iSGXLnKCk+qO/WVgKqMvxLrcWoW+f?=
 =?us-ascii?Q?oia2hIxy4nG+1XZ51/NV+yJv+ilMXuo4kuovpOBFHjOzj4A2CYsXEh42D1JB?=
 =?us-ascii?Q?yQ/0fTBuE+1tZwKdqe2bzsE4YGaKXOVGp0LuIPoiN1s8FsOzJZpZ9V6Q7seT?=
 =?us-ascii?Q?6+6hCjNYKDEi3466zlu196Q+qSnabOOKSCMas4M+cG9jqMAihO9WXgoR7t0m?=
 =?us-ascii?Q?PKmBCUkjfQJM0KLpjEaTA+qTg9PO5R5jD12UvN7oaj/gzLtKWttn6IkOMly3?=
 =?us-ascii?Q?HrNKR+Q/aM/wMsL8qWwPPTxH+t5bMR5mduwrO5yf2R0IybpbGnHKd84au/pE?=
 =?us-ascii?Q?4Z7789T93ooxnt30WlzkWJ7Wbr6fl4pVdaQRZkQxQ8tZwA83zGh2/kM8KJy3?=
 =?us-ascii?Q?v5mtDWtbd4fD1xev81p00M+wWMjUnbjn7vXjXtK7qX/rV5hKSUshjWSc7r+5?=
 =?us-ascii?Q?7qj6k/xnc+r3jfmYnoD3pl9HYIscAkPb3cGjbRCACof4EwhjesBUr+9UD0BC?=
 =?us-ascii?Q?DxgFSjptsr5sg+LLbBJ5Sz984wkb6O+S0rolJcB/fX+LYsqf2hU+eYvxgJk1?=
 =?us-ascii?Q?xqEO0FjFVctPPwatlxozYqxa++heqiIKo/Q0KvYx6pcc3SL5CjijQC6uM18j?=
 =?us-ascii?Q?Y3GGF29VPy8EtA9f1gFBpWMRAa27vpcvzv/52Lzvr8bTB4YC5enkGQCQ4ipr?=
 =?us-ascii?Q?0Jw+kr3nFSj05EOwkNfBtyS7RrKW5cPo6nZdJ6RUaSaxzBaF04sii8v7jXKK?=
 =?us-ascii?Q?Xqq55CxYBC89fId68/ZYsrAKcC0xZKHPB3DDkjh68weQx6HY8S+f+U9VXsBe?=
 =?us-ascii?Q?ktf9JkMESd5RN/rYmCbcsdeTV0/pXPLf1Ps9xoM7nGFy2crifjIRZf8b7vkg?=
 =?us-ascii?Q?kd76ymubm8N3gYAvpQxpaozbc+RBAtpwIRt+6xeKnq+cxAKaopn1cf7QHFfG?=
 =?us-ascii?Q?WKofOsa+kiY1XQ5Rfqb/V/+lpi4dCuoBD/mb2B6UV6uhIqQaKS09ZaU1k5Xv?=
 =?us-ascii?Q?iDN+z4swwi7Bn22aI9X0eeyorNVxgsXn6zgu5HIndncXm3bfg2VLvPyQauXV?=
 =?us-ascii?Q?2moIdPmL4wpmKm6sv3x9VA9QU2ZhItO0/Dv0LZAgSc5tBOC9iz+Zie3bJiBD?=
 =?us-ascii?Q?ZvBKxZSmCZKlaLwtJ4VK+YzsBO1py9wcb+EJc8+RhpzCVNIMii1bOiputJUy?=
 =?us-ascii?Q?4UVlQoHsu2yC+DGCZvP0RnZahbpkWWAdODRDYuVBUzCCK0IUrepPZw6qqAHC?=
 =?us-ascii?Q?R5KakrqYKCOdQeDJ7+VxpUSz5lfPY1OAePZFhdrVfSGDLdU7qSj0heIIb7iZ?=
 =?us-ascii?Q?APHg5XhU7/qTtsDWnIf3+YzKNqEzdvpWDlssJUmU3TPxq2Cbfx8SikEuPFPn?=
 =?us-ascii?Q?e7XkBLut1KPOsJHGV28nwdnhVFbY1oKzC8J0Kb/1VCg0mkXi+X7ZO7SQJ8gM?=
 =?us-ascii?Q?N5MnrhVwML1kRPDybZiDesYdXkOnr+91vwiiPXyi0Bnwr1Yz8YGzcoduyr0m?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e88696-6286-4cc3-4218-08dc306afa00
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:18:39.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6w2e52Yz4B5wIsTnfByk6aJTCGiwM37yFmNVNKSvSqp57BhUfg4HpfD6fkDN029wuML3/7A308W5c92Z/VgzmNRuyi6Y/uzI+Obk2Ab3A/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

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


