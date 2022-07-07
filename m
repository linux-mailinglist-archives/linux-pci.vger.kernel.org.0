Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8588F56AD1F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 23:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiGGVDR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiGGVDQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 17:03:16 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC011F62C;
        Thu,  7 Jul 2022 14:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/Y27pF1nZke0QfmZNXSRWTv74VMP6F6OWZfpb9aOqFeOE+mq0sGq7mBRVTgn4fVh/DCMg8KzQk7i2YjjhRFwwCzM+QIqMT8lqI/RUlRc3kg+8M52ZGDDKhxaKbhOPEu3AkefTlk2WGb7pLRBz958xrVKJ8oz23vBiAxXE/TAf7cqs6VuXEL8F1GIEiZhcv7VBUEaklOyyqBpZ4nvUJQt7Nkwh4Ugs1wU+AQcklztzhRDEoze9yHLx4YwYi0u05moF2oa98/NGSXqcQQqNZCFHsTUKsvItY8iiWJMEgKMnI5b0V64emRsGEiDpgz5h00YIxunSrnrkMMXGZU5mfp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2O+UIbo35L7Hf8LqVh4PXhT3RTIE2whTFmwJuW9mcw=;
 b=ECHdzDrgS14MvSbA30HgMuw0fOg8xwRNkwOsub1wDaylAp1GafuEUoKAh2I0qnavUz5u677vYjYzFqHYBvnBD0TgJWOZwyQTDKX84vkG3XL5qwN+an5wJlvOIb35PRrePTPscjKiDp6x7ez7zAq9iYR2atMpfTdRe+g5kLbAQPqy9Xggv57hKCnUpWqwLpeUyJa13aXdbsN9xplAU1RwbSxnath0OaiSLZ0PaMmtZlYbZyI10MidBznohzACO6lTNI6udGrLSktUQOXrSw8HCTFnhg7+pYU3tgg7LeMgumy1Zwv54bvb14JGE8JIPeQblXeKmzcx9IWKMFXMsrWp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2O+UIbo35L7Hf8LqVh4PXhT3RTIE2whTFmwJuW9mcw=;
 b=oB6QGGluC90ox6If8+bqMFVPwFDInsAOJs72o6axyfxlAuCxUeLXmA7CBzrtOtAO/sn2P9QjiHVDLEJFdPRQRS9OGfkIkrtZKV+GVoIqdyncLNnJo80IPRbViK/kCg5LKbW7omQTDJCQxNr1ScHHTb0PdP2UBGP5cyQ62bWVRpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 21:03:10 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e%6]) with mapi id 15.20.5395.020; Thu, 7 Jul 2022
 21:03:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH 1/3] irqchip: imx mu worked as msi controller
Date:   Thu,  7 Jul 2022 16:02:36 -0500
Message-Id: <20220707210238.917477-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 988fb0de-400c-44d5-07ee-08da605c191a
X-MS-TrafficTypeDiagnostic: DBBPR04MB7817:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIIAhcqqAa/qKEYEGSfZ6LZzy5mhMgbmPOLzTk7oILF93GJCP54K7tnjJo6mixcU/26mycJVyrrF/lXtkyI7ucV3kxrR2cTQ7RUGj7VIOmDXsbuMobyTwSh6BQnL3rbl3mIPvoyxOkMu5k3/ZBHEGZFbAKIlJbXYz2Mb4qMA0koztX5ulHpMh6AkFo2T+LxFeGsQAoQswECCGSGvLsklURGeGKt8l0NeHsr5gRSPq/tiiavhUTfTrswwDQ/CHwbjnTZJi8s5uaxTFA5gWIulP631Et7f6EEbQkZl4AJuSIu0PWXeWuTK/dPARgnXZysVkEUPOCyARzSTZI+mko6ybvy7dvU1A6iMRg5HeJ0HPlEmKwT10dgjHaS85RyIdK27L51Bmk01mEFKBF1IzPi+Zezh+0rCNxiGOQ31bIicyXQJPpCpSMcnAB/AhsR6s2iHIOOO29fasMgvB/AWBfqvFORVmGmtfMS3woyaTpIyz4HGfYHe5kyndtzYKSVMU5VKNi5Eg7VEXk8jC3O4kVBg1HVpq1erJ7ANcsqvY6kyIPPGwQ+MufXPX4g3dFrS8yIFIKoSNYns9+r7iITl8uMe2LAZYZcD76F46pGwiK7tXCluPwRhRryPSPzp7jhZsJBX0pUwUxEBnlc4KY+lcDxwJU4tT1QjmlRA1qWx64I7ycduTGd/s+YvBbGssRsulT7P3Y1tUZHadRtzji5l4tND/pLf/a7Ut1Cx3CuL5578xyphLhVS2wSXjlrf68myHBfob5LfSTkjxTJrSXy9nz9ou+hcl+9LO3vRofsOhcnFnc92MEGYlvIbdeYoqt8Vkh69TuyzaxT9g/Q6VMA47NvgAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(38100700002)(6512007)(38350700002)(186003)(66946007)(66476007)(66556008)(4326008)(8676002)(5660300002)(316002)(921005)(83380400001)(36756003)(2906002)(2616005)(6486002)(8936002)(478600001)(41300700001)(6506007)(86362001)(6666004)(52116002)(26005)(1076003)(30864003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mTi7Xb7faZXywtpQ3trYrRwHv7G66mPVKEqGlj5/5xeqnFtdFtxSlyVeUut1?=
 =?us-ascii?Q?/afFHmfW6DFTwydUDWaMLGqPnNXWObQG6ANCjXIgyUzYyaP8+GJxfJ7Y0TpD?=
 =?us-ascii?Q?/RjEXoHiygAXM/5OjrJ/PTo2qvDRPBfksC1/Fo+ITFhCw7+FmsmdoQmBl8zp?=
 =?us-ascii?Q?bj4QyXvSJCEeUaZzS9+M2GOXIHY4INZ8og1uKfxzbvANpDgR1adQQyJyRFrH?=
 =?us-ascii?Q?8Cu2NihKQhwm/vrkN12yoJxpZ9qwcpplvHZorR7TP9jM1jSKNVXqvGD517v+?=
 =?us-ascii?Q?y1BIAKHV8M7V5L/TZQhGVYivrkillF8o60kPQO9unSmAn9wxmRMUU9O2NGBN?=
 =?us-ascii?Q?SAZ6x6/HSLO7drexw98Yv6qdcp1QSMo8RCDGl3MpdHYe2a4IjqV+oqM2dayS?=
 =?us-ascii?Q?VtJ9mc0Ftip8Urvc9Szl/4IbEOF8CM0n1z0BT9OXK1/0okAIlxWBHbGonWPe?=
 =?us-ascii?Q?eknV++8uUVbNv/DNMYMy+SOps9p5xbOCKUgo55LpfLGelWbVMw4Tf78wz6oD?=
 =?us-ascii?Q?gRpv5h6vyVaPoNwQLiqLfH4gX6f4W8yS9VmWFUl6Iwv2pyTPs6HG5RDqivwG?=
 =?us-ascii?Q?l28dnRJxiKMc9cBp65IqixlfNNPqA2iRy+XS49QEQWshwYW0RnlEqLhPFjAF?=
 =?us-ascii?Q?Gakhlto8Icn/bv1vA4t0JXTYHO1THYpUALLFxK2jtyKDL4wASuxfs4CQgsLY?=
 =?us-ascii?Q?AtILUDyx62lnn154E7Cb8eWQYd7S0kOCwAeh8YuWRysMEiDkxzW6su5tf7h0?=
 =?us-ascii?Q?Xn8nBBpync5O5nrIaR9zM18i+veWqPa7oHV+nUGqt/RFkhVvtolL93Hl/g1m?=
 =?us-ascii?Q?UrkbtkxWfpue3ezEf5wmPztHCm2YfQwY2cufGqiikeIAGj6y5Tlm51T/merb?=
 =?us-ascii?Q?ZAO/NwP77HNNcrRwhEXIS/OBg8Gu5o3Q+QGMCAs9RJm/STg0iIq4/GBR1zkH?=
 =?us-ascii?Q?QUxUwhR3Bw9VKBB55Cg6UI7jPZ62zwcrhN7nu6rZRphiOiCblXYEdMkenTkX?=
 =?us-ascii?Q?WQYBNwRx08vqr2RubW9cYFTHLKmJnnPeYwNs9WnAH/dBQI6P1rcm0wjngy+n?=
 =?us-ascii?Q?J5+hlCAhizn2rSVj+UnptWTiGyVAKIhN6V9PE9FXfBDPPjKSuUbcucRfUnDx?=
 =?us-ascii?Q?ZhoL2nNz7ANN9ilFSfDgdWM9iKlnS09T21oFAI0Zg6WzrctBh/CoyEWAJS1M?=
 =?us-ascii?Q?Hw1u4ff3IZH7StDTVH6LYdWTCW8WvhRcV9hWy0SVKhngQEUk05AyLOSmq54/?=
 =?us-ascii?Q?RlZecnjmwRgF1sCv1AlCMyiKgKECUUrzSbYDHuArycGG7FbMCsRqofghBtGV?=
 =?us-ascii?Q?qaQQWiIumSBF7soGUzsEbF7J16t9Mhsr0saFVdDV2tWig7oCSN8qgxKb3FxS?=
 =?us-ascii?Q?xY/TcV+mzTthEF9IQ+oVeSUgrQwQfl27czvaoVXsZQGZGhUFugu8Rlyoeoov?=
 =?us-ascii?Q?qjyLJ1e8DRvNoV7GRd+Vq/bCLx6Cx6XDRc+8+nr0j/NEFgBqaNb9xqXlOfZZ?=
 =?us-ascii?Q?rP2/S3fkGZmOfaBZkuvjj1U0Zx1FhzWvLfuPIIxTu1kswrbJQHlO8xhnFlP5?=
 =?us-ascii?Q?xXiTG1644iKgs3O0pQmTzIivSduIcp4PPX/ireCe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988fb0de-400c-44d5-07ee-08da605c191a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 21:03:10.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woE8NKOATVQQHJjs7dSUcTraY1vkgUa9/AMLSKMOfQ5dvEsnRNu2JvP3SidSYg8Q+TsnEnNzrAGGe+Ri1zdIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MU support generate irq by write data to a register.
This patch make mu worked as msi controller.
So MU can do doorbell by using standard msi api.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/irqchip/Kconfig          |   7 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-imx-mu-msi.c | 490 +++++++++++++++++++++++++++++++
 3 files changed, 498 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-mu-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5e4e50122777d..4599471d880c0 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -470,6 +470,13 @@ config IMX_INTMUX
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
 
+config IMX_MU_MSI
+	bool "i.MX MU work as MSI controller"
+	default y if ARCH_MXC
+	select IRQ_DOMAIN
+	help
+	  MU work as MSI controller to do general doorbell
+
 config LS1X_IRQ
 	bool "Loongson-1 Interrupt Controller"
 	depends on MACH_LOONGSON32
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5d8e21d3dc6d8..870423746c783 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
+obj-$(CONFIG_IMX_MU_MSI)		+= irq-imx-mu-msi.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
new file mode 100644
index 0000000000000..f7193a6c1245e
--- /dev/null
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP MU worked as MSI controller
+ *
+ * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ * Copyright 2022 NXP
+ *	Frank Li <Frank.Li@nxp.com>
+ *	Peng Fan <peng.fan@nxp.com>
+ *
+ * Based on drivers/mailbox/imx-mailbox.c
+ */
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+#include <linux/dma-iommu.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+
+
+#define IMX_MU_CHANS            4
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX,         /* Tx */
+	IMX_MU_TYPE_RX,         /* Rx */
+	IMX_MU_TYPE_TXDB,       /* Tx doorbell */
+	IMX_MU_TYPE_RXDB,       /* Rx doorbell */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2,
+	IMX_MU_V2_S4 = BIT(15),
+};
+
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+
+struct imx_mu_dcfg {
+	enum imx_mu_type type;
+	u32     xTR;            /* Transmit Register0 */
+	u32     xRR;            /* Receive Register0 */
+	u32     xSR[4];         /* Status Registers */
+	u32     xCR[4];         /* Control Registers */
+};
+
+struct imx_mu_msi {
+	spinlock_t		lock;
+	struct platform_device	*pdev;
+	struct irq_domain	*parent;
+	struct irq_domain	*msi_domain;
+	void __iomem		*regs;
+	phys_addr_t		msiir_addr;
+	struct imx_mu_dcfg	*cfg;
+	u32			msir_num;
+	struct imx_mu_msir	*msir;
+	u32			irqs_num;
+	unsigned long		used;
+	u32			gic_irq;
+	struct clk              *clk;
+	struct device		*pd_a;
+	struct device		*pd_b;
+	struct device_link	*pd_link_a;
+	struct device_link	*pd_link_b;
+};
+
+static void imx_mu_write(struct imx_mu_msi *msi_data, u32 val, u32 offs)
+{
+	iowrite32(val, msi_data->regs + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu_msi *msi_data, u32 offs)
+{
+	return ioread32(msi_data->regs + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu_msi *msi_data, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&msi_data->lock, flags);
+	val = imx_mu_read(msi_data, msi_data->cfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(msi_data, val, msi_data->cfg->xCR[type]);
+	spin_unlock_irqrestore(&msi_data->lock, flags);
+
+	return val;
+}
+
+static void imx_mu_msi_mask_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data->parent_data);
+
+	pci_msi_mask_irq(data);
+	imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq));
+}
+
+static void imx_mu_msi_unmask_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data->parent_data);
+
+	pci_msi_unmask_irq(data);
+	imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq), 0);
+}
+
+static struct irq_chip imx_mu_msi_irq_chip = {
+	.name = "MU-MSI",
+	.irq_mask       = imx_mu_msi_mask_irq,
+	.irq_unmask     = imx_mu_msi_unmask_irq,
+};
+
+static struct msi_domain_ops its_pmsi_ops = {
+};
+
+static struct msi_domain_info imx_mu_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS |
+		   MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX),
+	.ops	= &its_pmsi_ops,
+	.chip	= &imx_mu_msi_irq_chip,
+};
+
+static void imx_mu_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
+
+	msg->address_hi = upper_32_bits(msi_data->msiir_addr);
+	msg->address_lo = lower_32_bits(msi_data->msiir_addr + 4 * data->hwirq);
+	msg->data = data->hwirq;
+
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
+}
+
+static int imx_mu_msi_set_affinity(struct irq_data *irq_data,
+				   const struct cpumask *mask, bool force)
+
+{
+	return IRQ_SET_MASK_OK;
+}
+
+static struct irq_chip imx_mu_msi_parent_chip = {
+	.name			= "MU",
+	.irq_compose_msi_msg	= imx_mu_msi_compose_msg,
+	.irq_set_affinity = imx_mu_msi_set_affinity,
+};
+
+static int imx_mu_msi_domain_irq_alloc(struct irq_domain *domain,
+					unsigned int virq,
+					unsigned int nr_irqs,
+					void *args)
+{
+	struct imx_mu_msi *msi_data = domain->host_data;
+	msi_alloc_info_t *info = args;
+	int pos, err = 0;
+
+	pm_runtime_get_sync(&msi_data->pdev->dev);
+
+	WARN_ON(nr_irqs != 1);
+
+	spin_lock(&msi_data->lock);
+	pos = find_first_zero_bit(&msi_data->used, msi_data->irqs_num);
+	if (pos < msi_data->irqs_num)
+		__set_bit(pos, &msi_data->used);
+	else
+		err = -ENOSPC;
+	spin_unlock(&msi_data->lock);
+
+	if (err)
+		return err;
+
+	err = iommu_dma_prepare_msi(info->desc, msi_data->msiir_addr + pos * 4);
+	if (err)
+		return err;
+
+	irq_domain_set_info(domain, virq, pos,
+			    &imx_mu_msi_parent_chip, msi_data,
+			    handle_simple_irq, NULL, NULL);
+	return 0;
+}
+
+static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(d);
+	int pos;
+
+	pos = d->hwirq;
+	if (pos < 0 || pos >= msi_data->irqs_num) {
+		pr_err("failed to teardown msi. Invalid hwirq %d\n", pos);
+		return;
+	}
+
+	spin_lock(&msi_data->lock);
+	__clear_bit(pos, &msi_data->used);
+	spin_unlock(&msi_data->lock);
+
+	pm_runtime_put(&msi_data->pdev->dev);
+}
+
+static const struct irq_domain_ops imx_mu_msi_domain_ops = {
+	.alloc	= imx_mu_msi_domain_irq_alloc,
+	.free	= imx_mu_msi_domain_irq_free,
+};
+
+static void imx_mu_msi_irq_handler(struct irq_desc *desc)
+{
+	struct imx_mu_msi *msi_data = irq_desc_get_handler_data(desc);
+	u32 status;
+	int i;
+
+	status = imx_mu_read(msi_data, msi_data->cfg->xSR[IMX_MU_RSR]);
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+	for (i = 0; i < IMX_MU_CHANS; i++) {
+		if (status & IMX_MU_xSR_RFn(msi_data->cfg->type, i)) {
+			imx_mu_read(msi_data, msi_data->cfg->xRR + i * 4);
+			generic_handle_domain_irq(msi_data->parent, i);
+		}
+	}
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data)
+{
+	/* Initialize MSI domain parent */
+	msi_data->parent = irq_domain_add_linear(NULL,
+						 msi_data->irqs_num,
+						 &imx_mu_msi_domain_ops,
+						 msi_data);
+	if (!msi_data->parent) {
+		dev_err(&msi_data->pdev->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi_data->msi_domain = platform_msi_create_irq_domain(
+				of_node_to_fwnode(msi_data->pdev->dev.of_node),
+				&imx_mu_msi_domain_info,
+				msi_data->parent);
+
+	if (!msi_data->msi_domain) {
+		dev_err(&msi_data->pdev->dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi_data->parent);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int imx_mu_msi_teardown_hwirq(struct imx_mu_msi *msi_data)
+{
+	if (msi_data->gic_irq > 0)
+		irq_set_chained_handler_and_data(msi_data->gic_irq, NULL, NULL);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
+	.xTR    = 0x0,
+	.xRR    = 0x10,
+	.xSR    = {0x20, 0x20, 0x20, 0x20},
+	.xCR    = {0x24, 0x24, 0x24, 0x24},
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
+	.xTR    = 0x20,
+	.xRR    = 0x40,
+	.xSR    = {0x60, 0x60, 0x60, 0x60},
+	.xCR    = {0x64, 0x64, 0x64, 0x64},
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
+	.type   = IMX_MU_V2,
+	.xTR    = 0x200,
+	.xRR    = 0x280,
+	.xSR    = {0xC, 0x118, 0x124, 0x12C},
+	.xCR    = {0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
+	.type   = IMX_MU_V2 | IMX_MU_V2_S4,
+	.xTR    = 0x200,
+	.xRR    = 0x280,
+	.xSR    = {0xC, 0x118, 0x124, 0x12C},
+	.xCR    = {0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct of_device_id imx_mu_msi_ids[] = {
+	{ .compatible = "fsl,imx7ulp-mu-msi", .data = &imx_mu_cfg_imx7ulp },
+	{ .compatible = "fsl,imx6sx-mu-msi", .data = &imx_mu_cfg_imx6sx },
+	{ .compatible = "fsl,imx8ulp-mu-msi", .data = &imx_mu_cfg_imx8ulp },
+	{ .compatible = "fsl,imx8ulp-mu-msi-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, imx_mu_msi_ids);
+
+static int imx_mu_msi_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct imx_mu_msi *msi_data, *priv;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	match = of_match_device(imx_mu_msi_ids, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	priv = msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
+	if (!msi_data)
+		return -ENOMEM;
+
+	msi_data->cfg = (struct imx_mu_dcfg *) match->data;
+
+	msi_data->regs = devm_platform_ioremap_resource_byname(pdev, "a");
+	if (IS_ERR(msi_data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
+		return PTR_ERR(msi_data->regs);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "b");
+	if (!res)
+		return -EIO;
+
+	msi_data->msiir_addr = res->start + msi_data->cfg->xTR;
+
+	msi_data->pdev = pdev;
+	msi_data->irqs_num = IMX_MU_CHANS;
+
+	msi_data->gic_irq = platform_get_irq(msi_data->pdev, 0);
+	if (msi_data->gic_irq <= 0)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, msi_data);
+
+	msi_data->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(msi_data->clk)) {
+		if (PTR_ERR(msi_data->clk) != -ENOENT)
+			return PTR_ERR(msi_data->clk);
+
+		msi_data->clk = NULL;
+	}
+
+	ret = clk_prepare_enable(msi_data->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock\n");
+		return ret;
+	}
+
+	priv->pd_a = dev_pm_domain_attach_by_name(dev, "a");
+	if (IS_ERR(priv->pd_a))
+		return PTR_ERR(priv->pd_a);
+
+	priv->pd_link_a = device_link_add(dev, priv->pd_a,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+
+	if (!priv->pd_link_a) {
+		dev_err(dev, "Failed to add device_link to mu a.\n");
+		return -EINVAL;
+	}
+
+	priv->pd_b = dev_pm_domain_attach_by_name(dev, "b");
+	if (IS_ERR(priv->pd_b))
+		return PTR_ERR(priv->pd_b);
+
+	priv->pd_link_b = device_link_add(dev, priv->pd_b,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+
+	if (!priv->pd_link_b) {
+		dev_err(dev, "Failed to add device_link to mu a.\n");
+		return -EINVAL;
+	}
+
+	ret = imx_mu_msi_domains_init(msi_data);
+	if (ret)
+		return ret;
+
+	irq_set_chained_handler_and_data(msi_data->gic_irq,
+					 imx_mu_msi_irq_handler,
+					 msi_data);
+
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		goto disable_runtime_pm;
+	}
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		goto disable_runtime_pm;
+
+	clk_disable_unprepare(msi_data->clk);
+
+	return 0;
+
+disable_runtime_pm:
+	pm_runtime_disable(dev);
+	clk_disable_unprepare(msi_data->clk);
+
+	return ret;
+}
+
+static int __maybe_unused imx_mu_runtime_suspend(struct device *dev)
+{
+	struct imx_mu_msi *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int __maybe_unused imx_mu_runtime_resume(struct device *dev)
+{
+	struct imx_mu_msi *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		dev_err(dev, "failed to enable clock\n");
+
+	return ret;
+}
+
+static const struct dev_pm_ops imx_mu_pm_ops = {
+	SET_RUNTIME_PM_OPS(imx_mu_runtime_suspend,
+			   imx_mu_runtime_resume, NULL)
+};
+
+static int imx_mu_msi_remove(struct platform_device *pdev)
+{
+	struct imx_mu_msi *msi_data = platform_get_drvdata(pdev);
+
+	imx_mu_msi_teardown_hwirq(msi_data);
+
+	irq_domain_remove(msi_data->msi_domain);
+	irq_domain_remove(msi_data->parent);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver imx_mu_msi_driver = {
+	.driver = {
+		.name = "imx-mu-msi",
+		.of_match_table = imx_mu_msi_ids,
+		.pm = &imx_mu_pm_ops,
+	},
+	.probe = imx_mu_msi_probe,
+	.remove = imx_mu_msi_remove,
+};
+
+module_platform_driver(imx_mu_msi_driver);
+
+MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
+MODULE_DESCRIPTION("Freescale Layerscape SCFG MSI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

