Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964A7594E37
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 03:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiHPBsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 21:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346123AbiHPBrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 21:47:33 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10089.outbound.protection.outlook.com [40.107.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5246219;
        Mon, 15 Aug 2022 14:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGJqM1dNs5QV2VlKZzHFrkrbO2dkD7Ak/5sYzjWVnMw3rHjbVw4adQ+k927LR5DOc4SYNcqaDw8BG/QJnfI5AA3Nw0y5j69d4pJA0MsjWvndWdUD/HuN3xK2SKaN2g8Uq5gx/U/L9MEHsuMK+s9YCtlCwVKF/8i/ZaLzdEbP1CUfHAnw7lDuwQSNkMReud++7gG4w/Ly1gkMdVUvxv5y7rB2OAnEKogeZNTHnvG3lECNdQfX4gwEdI+ywEOXJiTTb8dY4FD23ugOe+ufulvwmpeAEeHo4mmd4nV4OAUzK+INCTRCZn9jiI7ujTgGg6B8FkVvXUyiu9IytR70J45ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ2qPOqRvUT4Stm6wP/WJGhBGkxLdX4pSj90vv1QdAE=;
 b=c1JQUe8DeeeWSmW5+rJrMC+slBXHT/i5jAByG0pOX3rIDA7sQAdfYDdi0ZJIDo2XrkYscoE8gMmhzZ7Mlws/UcgjZmNHi9E41HAmvcFG6e6UcNTMoYonLcwKWHKLbrowZKz3fwRUv1xAVSHFj93XXTwWrlnfy65rYpQQuA/nKABy7vTTqCIuaE6UilOD4JsP4m45ktN+5KqPZ4413OM+SCR2sfF2X6WEOHgzKXrmNboZdY3/Sxb6YUHtIltVuwxYTLwtcBrfLxjIEGd3KxaTQhYoZOSWiK8gQ+NVfnxZBTvUqxH1seIVfGGiwQqTP98gicnJFIRZECDKgt0oBInAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ2qPOqRvUT4Stm6wP/WJGhBGkxLdX4pSj90vv1QdAE=;
 b=RTply/FWnt49bj4ULTzrMl87F5h4SNSs4wKRTOkqYZleWhbC1ZjXkd6b3bLSRiVVvZUJXCrZOjx8Y0nH/dU1njM7NjvuEmHNxfeZS6xWvSyOEU5jTS9g0PRBsgS4Zsq+SV4H3OjoRe3f1MElHafaVQX17vbxFEQ70udmRjbK2EM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2580.eurprd04.prod.outlook.com (2603:10a6:203:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 21:40:08 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 21:40:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v5 2/4] irqchip: Add IMX MU MSI controller driver
Date:   Mon, 15 Aug 2022 16:39:34 -0500
Message-Id: <20220815213936.2380439-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815213936.2380439-1-Frank.Li@nxp.com>
References: <20220815213936.2380439-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:930:14::9) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52133588-543a-4708-9ad3-08da7f06b93d
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2580:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmWDk2oW4TONyrgd961gFDABFUhKDIndN6/jgMukCbH+yDBV6f3Zwr8SujuWpkhQyxbIenM549TbMHryuAYXQOuJdSdKLc/7k9kjsmKfD7FZADSVKLSfDzLnZbFCYGVX9EiMpXByHR/PSF5rglT9KJKcXDlyvsq67A2kQgdClZBgrhzwCuN5VGzwCnClC1yc1IXpkQL6LylPHluTu7KvGWFilYr2r9WNsXXzQQr6w2dPPnAojuzUjm6T7Ch4AiiNNZzf3r7HWhtZqZl69P5TymkVRBKsFKWd0b9NHnaonoS0FXyeQdZESHE3fekuKHnAAeUDmbD0kw1Zp+LhU7QI++qYMVSGyH56K7xgchSk3ikWRO3Qv5/i21J6IBFNnvcKG68ksiawV+lGK3/EymsQnTitdGzLuwDEMTbpmURmC9hnL5Lwdy7F/B9GwH1D8SDKqpg7ubSqJBDwSXtDdKxddHt3OBP0IJ7sAwp51DfZloqaLQwz1IAH+RYKZaPzbUPHHOQ/NFmc4N0NcQoAh0nNr5kvYZIJaO6VJBTDOIengrthqtzzCNwI60NN59lWeK7fVX9FHyTERLOs/quImsWpBS0l5RUL0EFBD5OD/Jt+AJ6eVA6TfPpRYM0MwjaK3OarFGzhkAcfZH7j2Z+88Aegx4tddKfk2LMq7DLoPpWC2Ho9+pTPLz0IWM8XTeifJXbPFe5SNirscBiDRQ65EC+1Pn1bjrmClURhQLILjXRV1itz4/aicqFVSHphjbH616vcFWgX4RgESi03Bjc/5ZeUGbbHoNTT7ID4OiJeu+h3lYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(83380400001)(478600001)(5660300002)(1076003)(36756003)(186003)(6486002)(2616005)(38350700002)(8936002)(86362001)(41300700001)(316002)(30864003)(7416002)(6666004)(4326008)(8676002)(66476007)(38100700002)(66556008)(6506007)(6512007)(52116002)(2906002)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PcJuS4kZKc7SiPQ/rb93h2+sgkO1/XBRHgfwCYmlog0r+7h6kt64bRmJpEE6?=
 =?us-ascii?Q?r2UkJ6xO/QtKqtoFRTKte8LmHl/XzgO5ZbMzoq9HEMLAikW01eGmnrMuh9f+?=
 =?us-ascii?Q?7rkTprQ95TtJ7J74i2XDBPZXojTHifi3EXMIuIkT1GmALlI8TSgARxrJCwIY?=
 =?us-ascii?Q?KSXJ8jljYZrF/Mzxs/5Ub+wl5FJ4GR3wBmthFCndVP7M+km7D97Nr8D+4EUZ?=
 =?us-ascii?Q?E5PGx3zENiQhkGvprPC1WbEL4InwysD2oxkGsHpNUu6GIDtSY+fM16K0W7PK?=
 =?us-ascii?Q?dEJBMlAPPq9s9mIt4mzEvkYOmZ9lTEwcuHZGy3h8LhvKrHWE8IpIJkziM++h?=
 =?us-ascii?Q?Ee7WM3a3yhUoipvt7Xes75UXf1HUHdCuGHJyVpYtAcEUrsfWFvUGygftzCd0?=
 =?us-ascii?Q?ipuVJJVUFBVjY4rnk08LRFFHxrOofLimlu2wGavKX/N21q7sx3iv0vzFx2g5?=
 =?us-ascii?Q?MB/aG2zZJOtIVARcRba69Lq0ph2LjF7MP4i6eopBDRu386WozNL/AVcsEhDR?=
 =?us-ascii?Q?/Weap6VZTwo7vi8k5hEsrGixWazyKe2PiIdq9RP/AHrY0Dx0JMrkIQ4xM/5M?=
 =?us-ascii?Q?VVyrsl4KB0bet7qXc6Q70mIV5ySDHdAFd0+JJ+sS234qOUrp/ocBfWswTJxI?=
 =?us-ascii?Q?wGR+UvDaFsJe2aYLzRMHCK7cuimIkEQU4zKM3wdR/EkRAFgJvZqLakECr3Fy?=
 =?us-ascii?Q?CPVu/FJUu66Fg2/V18i5s2lOyjsAUHzUJ9k2Z7ruxxbJd3H/puCos/u10MBR?=
 =?us-ascii?Q?GHrayUEUcNKTtJHHg4jvNyRnmToMcaJaRQ3IaVY9y0JYLxDWTmIWhxsgqbwV?=
 =?us-ascii?Q?jRRzwfGLqbnsXcFNYM2tVup8sOHS/GFc/nl4uVs6LDifJ2WAxjzdEN5whUtM?=
 =?us-ascii?Q?LcJuUJIdTixB/0Ilg17sL+Wc2Aa1JsX0KqAAAb/dOxuGJ9yYjkxcQomB5LHu?=
 =?us-ascii?Q?DfPzZdsV7FrFk8vVRe13lP8Evt9agrhvfA/2YuC6GXQtY7ORKUFHDtaVDS2s?=
 =?us-ascii?Q?7cm5U8FWyJkcn0zp63ebqXZDlLR9EjB/PpC+kQ3DGlVdniqxJcywMaZOSdxW?=
 =?us-ascii?Q?r0MJM2zlkjj/NNUjEba/6rN6svdptdDrt16eXLFTrqb8gAs9bbHrV97KTV7D?=
 =?us-ascii?Q?/RiaVkYa7Ic4m6WkeYO5Zv4Dm+bHazzYwoD95G9kIROuYvSJOH5n1qKhn+oa?=
 =?us-ascii?Q?xu/JyRXhRr4L0pns1TyA3mPNHSwZ3hbhTKAR6Hw8B+tgwWZhw9Z7RP8B0Wau?=
 =?us-ascii?Q?0Q9eeK9aoSvO36Nos3UkbNpNjoO15YiA/7tA8FDvBpjfKAYTOiRpPMbHOZmk?=
 =?us-ascii?Q?c6K10EvsQXRjfRE/ZwZp88HtQR8ZzOfdqxQeOWsQMD5TJ+iK8zYvKAhLJtr6?=
 =?us-ascii?Q?XJwUnmOoWATIbuufo79l8R8uYFkO65kGiOQM7wEW2+wlF4AISawpwqw7niEm?=
 =?us-ascii?Q?SEGlz6OLGjyzgg4A9vpL7KPF2AvgAAhDB4TT8dHXpuU3qWtFJjnUFB5ky/LJ?=
 =?us-ascii?Q?9v/uBGQPbiAYG/Fps1E9uwpaW+n9WVLSM/usawOdS3ydtVXWN5u7WgBPVHY/?=
 =?us-ascii?Q?ZZS9gTbhl/hzYiMc4KF6gFNJILL0a7iOvh9rDDd4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52133588-543a-4708-9ad3-08da7f06b93d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 21:40:08.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2WPF5sVKnayhiAWSOaa6d3QASfP3Co7aP5uj3lrNUysKfb02oiOH7qUzo/cB9H/adQG74dJO45NyYEAN9XDFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The MU block found in a number of Freescale/NXP SoCs supports generating
IRQs by writing data to a register

This enables the MU block to be used as a MSI controller, by leveraging
the platform-MSI API

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/irqchip/Kconfig          |   7 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-imx-mu-msi.c | 451 +++++++++++++++++++++++++++++++
 3 files changed, 459 insertions(+)
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
index 0000000000000..1930c47c3570d
--- /dev/null
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Freescale MU worked as MSI controller
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
+#include <linux/irqchip.h>
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
+	IMX_MU_V1 = BIT(0),
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+};
+
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(data, x) ((data->cfg->type) & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_RFn(data, x) ((data->cfg->type) & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
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
+	spinlock_t			lock;
+	raw_spinlock_t			reglock;
+	struct irq_domain		*msi_domain;
+	void __iomem			*regs;
+	phys_addr_t			msiir_addr;
+	const struct imx_mu_dcfg	*cfg;
+	unsigned long			used;
+	struct clk			*clk;
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
+	raw_spin_lock_irqsave(&msi_data->reglock, flags);
+	val = imx_mu_read(msi_data, msi_data->cfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(msi_data, val, msi_data->cfg->xCR[type]);
+	raw_spin_unlock_irqrestore(&msi_data->reglock, flags);
+
+	return val;
+}
+
+static void imx_mu_msi_parent_mask_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
+
+	imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(msi_data, data->hwirq));
+}
+
+static void imx_mu_msi_parent_unmask_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
+
+	imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, IMX_MU_xCR_RIEn(msi_data, data->hwirq), 0);
+}
+
+static void imx_mu_msi_parent_ack_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
+
+	imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
+}
+
+static struct irq_chip imx_mu_msi_irq_chip = {
+	.name = "MU-MSI",
+	.irq_ack = irq_chip_ack_parent,
+};
+
+static struct msi_domain_ops imx_mu_msi_irq_ops = {
+};
+
+static struct msi_domain_info imx_mu_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &imx_mu_msi_irq_ops,
+	.chip	= &imx_mu_msi_irq_chip,
+};
+
+static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
+					  struct msi_msg *msg)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
+	u64 addr = msi_data->msiir_addr + 4 * data->hwirq;
+
+	msg->address_hi = upper_32_bits(addr);
+	msg->address_lo = lower_32_bits(addr);
+	msg->data = data->hwirq;
+}
+
+static int imx_mu_msi_parent_set_affinity(struct irq_data *irq_data,
+				   const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip imx_mu_msi_parent_chip = {
+	.name		= "MU",
+	.irq_mask	= imx_mu_msi_parent_mask_irq,
+	.irq_unmask	= imx_mu_msi_parent_unmask_irq,
+	.irq_ack	= imx_mu_msi_parent_ack_irq,
+	.irq_compose_msi_msg	= imx_mu_msi_parent_compose_msg,
+	.irq_set_affinity = imx_mu_msi_parent_set_affinity,
+};
+
+static int imx_mu_msi_domain_irq_alloc(struct irq_domain *domain,
+					unsigned int virq,
+					unsigned int nr_irqs,
+					void *args)
+{
+	struct imx_mu_msi *msi_data = domain->host_data;
+	unsigned long flags;
+	int pos, err = 0;
+
+	WARN_ON(nr_irqs != 1);
+
+	spin_lock_irqsave(&msi_data->lock, flags);
+	pos = find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
+	if (pos < IMX_MU_CHANS)
+		__set_bit(pos, &msi_data->used);
+	else
+		err = -ENOSPC;
+	spin_unlock_irqrestore(&msi_data->lock, flags);
+
+	if (err)
+		return err;
+
+	irq_domain_set_info(domain, virq, pos,
+			    &imx_mu_msi_parent_chip, msi_data,
+			    handle_edge_irq, NULL, NULL);
+	return 0;
+}
+
+static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	spin_lock_irqsave(&msi_data->lock, flags);
+	__clear_bit(d->hwirq, &msi_data->used);
+	spin_unlock_irqrestore(&msi_data->lock, flags);
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
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 status;
+	int i;
+
+	status = imx_mu_read(msi_data, msi_data->cfg->xSR[IMX_MU_RSR]);
+
+	chained_irq_enter(chip, desc);
+	for (i = 0; i < IMX_MU_CHANS; i++) {
+		if (status & IMX_MU_xSR_RFn(msi_data, i))
+			generic_handle_domain_irq(msi_data->msi_domain, i);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
+{
+	struct fwnode_handle *fwnodes = dev_fwnode(dev);
+	struct irq_domain *parent;
+
+	/* Initialize MSI domain parent */
+	parent = irq_domain_create_linear(fwnodes,
+					    IMX_MU_CHANS,
+					    &imx_mu_msi_domain_ops,
+					    msi_data);
+	if (!parent) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+
+	msi_data->msi_domain = platform_msi_create_irq_domain(
+				fwnodes,
+				&imx_mu_msi_domain_info,
+				parent);
+
+	if (!msi_data->msi_domain) {
+		dev_err(dev, "failed to create MSI domain\n");
+		irq_domain_remove(parent);
+		return -ENOMEM;
+	}
+
+	irq_domain_set_pm_device(msi_data->msi_domain, dev);
+
+	return 0;
+}
+
+/* Register offset of different version MU IP */
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
+
+	.type   = IMX_MU_V2 | IMX_MU_V2_S4,
+	.xTR    = 0x200,
+	.xRR    = 0x280,
+	.xSR    = {0xC, 0x118, 0x124, 0x12C},
+	.xCR    = {0x110, 0x114, 0x120, 0x128},
+};
+
+static int __init imx_mu_of_init(struct device_node *dn,
+				 struct device_node *parent,
+				 const struct imx_mu_dcfg *cfg
+				)
+{
+	struct platform_device *pdev = of_find_device_by_node(dn);
+	struct imx_mu_msi *msi_data, *priv;
+	struct device_link *pd_link_a;
+	struct device_link *pd_link_b;
+	struct resource *res;
+	struct device *pd_a;
+	struct device *pd_b;
+	struct device *dev;
+	int ret;
+	int irq;
+
+	if (!pdev)
+		return -ENODEV;
+
+	dev = &pdev->dev;
+
+	priv = msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
+	if (!msi_data)
+		return -ENOMEM;
+
+	msi_data->cfg = cfg;
+
+	msi_data->regs = devm_platform_ioremap_resource_byname(pdev, "processor a-facing");
+	if (IS_ERR(msi_data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
+		return PTR_ERR(msi_data->regs);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "processor b-facing");
+	if (!res)
+		return -EIO;
+
+	msi_data->msiir_addr = res->start + msi_data->cfg->xTR;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
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
+	pd_a = dev_pm_domain_attach_by_name(dev, "processor a-facing");
+	if (IS_ERR(pd_a))
+		return PTR_ERR(pd_a);
+
+	pd_b = dev_pm_domain_attach_by_name(dev, "processor b-facing");
+	if (IS_ERR(pd_b))
+		return PTR_ERR(pd_b);
+
+	pd_link_a = device_link_add(dev, pd_a,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+
+	if (!pd_link_a) {
+		dev_err(dev, "Failed to add device_link to mu a.\n");
+		goto err_pd_a;
+	}
+
+	pd_link_b = device_link_add(dev, pd_b,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+
+
+	if (!pd_link_b) {
+		dev_err(dev, "Failed to add device_link to mu a.\n");
+		goto err_pd_b;
+	}
+
+	ret = imx_mu_msi_domains_init(msi_data, dev);
+	if (ret)
+		goto err_dm_init;
+
+	irq_set_chained_handler_and_data(irq,
+					 imx_mu_msi_irq_handler,
+					 msi_data);
+
+	pm_runtime_enable(dev);
+
+	return 0;
+
+err_dm_init:
+	device_link_remove(dev,	pd_b);
+err_pd_b:
+	device_link_remove(dev, pd_a);
+err_pd_a:
+	return -EINVAL;
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
+static int __init imx_mu_imx7ulp_of_init(struct device_node *dn,
+					 struct device_node *parent)
+{
+	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx7ulp);
+}
+
+static int __init imx_mu_imx6sx_of_init(struct device_node *dn,
+					struct device_node *parent)
+{
+	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx6sx);
+}
+
+static int __init imx_mu_imx8ulp_of_init(struct device_node *dn,
+					 struct device_node *parent)
+{
+	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp);
+}
+
+static int __init imx_mu_imx8ulp_s4_of_init(struct device_node *dn,
+					    struct device_node *parent)
+{
+	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp_s4);
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(imx_mu_msi)
+IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
+IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_of_init)
+IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_of_init)
+IRQCHIP_MATCH("fsl,imx8ulp-mu-msi-s4", imx_mu_imx8ulp_s4_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(imx_mu_msi, .pm = &imx_mu_pm_ops)
+
+
+MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
+MODULE_DESCRIPTION("Freescale MU MSI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

