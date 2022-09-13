Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44975B7C8E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIMVKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIMVKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:10:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259275CF9;
        Tue, 13 Sep 2022 14:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWJoTYEubkP3HYJ8K3g1abDUCJQKeLIz2ArkdPysLPk5YK/SEWL+3mgPrs8K6n0BL4HYodrbn5qf3U6U/elxIafSL9aaatkGcQ2ieAcKgtMZCTQPicbobg20OODyDVk3Y7FOP2ctvjO7xXw7mtI7yfTK58IuWYfCqV4/jeKXw6PrcHutYVGPf1uZcTnrARQ0Vuoiz3J//iINn/f8blo2zIwafDFuFduB3CbHlJ8FBXhaT2HGt8mLt7Qx/Da3RKk/gdFmmmg/kyJFvRupwQ+Y/qEyoCssoVufzSpJv6TtQwuZu9I48o8YodYF/ut5/9kiFTiaWUD/9jQPnhhFl0s71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4HRMT8VBwUQPFzZjEB0zfcN9N4fLgSj3bCnIo7hLnE=;
 b=khBm56QO7CfxkTYzt4BU+7+QLBXfNe2y/9N7RQJD/+Z3L+rjh3b9i2Rmzkpx8IQ5LmzapjZ2cFIOzIGWSP0ZTOi2XvxnPQhWShzhayDyFUfORpt57m2fSW54bosXH3me3GZxnPvBeTdrpvEka/yG/DklheKLy+jQQR1sImEWR7X7IcG7n+BfTml5WvyQAMVID26X9ZtEzXVuzMfbdrcQkhhLq+xj1dYBBa+QBC32OkOP+jZl8rsij+2fFDQ4tYGQ/k/HCLxgdk8RXcEU/4MtUm84u0SaTo+fzvmWfCFvR2+ajanu7lLPpSwJBLZZRpfbNldtPBhb5r7pvQTKObbh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4HRMT8VBwUQPFzZjEB0zfcN9N4fLgSj3bCnIo7hLnE=;
 b=jBfaPmDV7PRjiWEr1gnHBLRij3zb9XnZGt7lffyvwRT+sEvIimqYmSZ00+I0Ns0HnpgCdVycPSShVFMagmtWXdh1QPwMZ2/9maAX6zL5CYwdO9vs/+SGH3VW11WEiTATB5YSQBLjW5/8dqU8cIQ/Z9e+hRmPPvWzMzTQqZSKfMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 21:10:34 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 21:10:34 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v10 3/6] irqchip: Add IMX MU MSI controller driver
Date:   Tue, 13 Sep 2022 16:09:54 -0500
Message-Id: <20220913210957.3493826-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913210957.3493826-1-Frank.Li@nxp.com>
References: <20220913210957.3493826-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: a55e5008-08b6-4e39-86ea-08da95cc65a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uq6D7RMguTf7aFul0HZ64m7NlKh3mwRlu2VLmcJwI3uz+ff6w4+j91wtYI3by4swsJ9aJQyxDvG+Nxz4ZmnfX+3IfggLtNs0g2/OugLUqTm7awd75+FAQOy6u24He3/HYSDLTN9fJak8cP08zIj3yOhyyQFtdFvQFLtsrbptaWcKkttSBK6YpkpeLsi3JB1+JAR3ZPGBHeI+liC0lip1wD9fphKntwXxrwBRMwafZiVYagPsd8/fokdfIQgbAyz+IVpbZe3dscJ9YYHE0q8fXlCCY1NawSrrcOuJFS68dWQRFVJeVH3smdXSyk7xojvSjZZibdwac2lvHasYKAhhIhW4/aaVfwwWVLWLQ51acpFIIk1LBy0G0n1dRl83hhMMlEiJFscYWgEUDZSaXsaxFf4+ED/12KnA5U2QRnYidMbO7HVKzyOxjVlrs4DJMjPLbWqq2l/EY2QkVSb89kDgjFZ8qhoX4hMpK9/OUPDHORQ0QIJe2sUVvmK26rxWC/f1uZTQDDMrqzjppBsEA4GUGKHAWMgAbbI1QZM/ugPeyDLX5NgNGnQKyeTOlUZobChsvTIbsxYjQpMsOZgZc5qD3TWDlNBoxMacOcYs4lKyINXID4uw2OPNNHHxVt1UnneaD7lBH6gerLOPOu5j0lb5XLov1tqYbdGJ600oM6tgeUIS5VLlbrHgD+E3nq1r29fr+2aA1XhQt12mb6t6gENTH6jgYCwlk9YFk9b3UIC10/FgNjQwl7rV7ki9WDfm6cdR+N1vqUHYIIsvSo3iZaIp8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(30864003)(38100700002)(478600001)(316002)(83380400001)(36756003)(8676002)(66556008)(2906002)(26005)(52116002)(2616005)(6486002)(66476007)(66946007)(6512007)(86362001)(6506007)(4326008)(41300700001)(7416002)(38350700002)(6666004)(8936002)(5660300002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G96IwHafFIUBDu8rpzECmfCZ14v1oO3u0JPJL6jdqpuHmctQ3Q76MfYYFrr9?=
 =?us-ascii?Q?dsKSBuhLM9riP9yMmJE3a72gQXP8d1wmNB6AgZSIv1ztTCl1Ne5j6vZJC0nC?=
 =?us-ascii?Q?n3DCFn2v6j6ADFJ+LiYRx/hGFzZjbgCoaZuqpdrlxSggeIU8Sw6RcDFnGyRI?=
 =?us-ascii?Q?Z6Fzxkj7MXLuW4rQQ/yMajBfWZLiDMEhbHmyCBdF2PUB+/lsLVvBYkoOHuRQ?=
 =?us-ascii?Q?wSVoz7FJrqAlptrdgH3/Ot8gDDuBC99tPQk8k3XbVCkXlX/8v4GuNOd67s5b?=
 =?us-ascii?Q?bNdXvkfSLbE+D5wnUbIBqZjXNkB519RZZ3Hmd8PcebK9ytRZ+1KNXQEahbmc?=
 =?us-ascii?Q?IGlHCzHKdAS6EWFq1zHNZqdQ0EgucAalES0iKIE0EAxV1OtZBCK2Ka6QU97Q?=
 =?us-ascii?Q?3hrb/Dw9kswMbFuEOD4u/h5/I0wHpLAJxA/Ef0mpqdMBJgSczYqXza1VebRX?=
 =?us-ascii?Q?PMtMY62GZHBP8aOw8dqcoLPuYUHt0pqLZxyHzISQuqI29fsyG9l8l1otYDgp?=
 =?us-ascii?Q?NKE1br3FH8X3pSH7//9eUHskkH8eCPywkNhfoqFjZOtujn5dNEJyyB29QZRX?=
 =?us-ascii?Q?1rmKCA5kyiNkJmrgDRTxT2zlP3vHUIWyXAqvwUBdGY3n/GhqAf+PjCLnBCK1?=
 =?us-ascii?Q?ZAIbsvrRx6V78BR61XU6odGcTRZOjXcB2BIYB8tEV0htiTf9voqtGRgfcpRJ?=
 =?us-ascii?Q?9tChDOiNPDFu6qwSKZV/FfaGxyqqnR3oMJwxDBN8o/Fokck3EebPsrScooh4?=
 =?us-ascii?Q?JPHtmHbZL70i4SC1eltOlOwMFkQ0Pf86YIT77Z5L7bU+LpC1q/tUSy3s5mxR?=
 =?us-ascii?Q?m5ZFwKUfq8Cu7JEPM5dW3aN5bFrWd+d5RcLrY/KGhekOLkHGE8mIDNAX7m2N?=
 =?us-ascii?Q?B0J0+ze1ueXiKFJ09avNuPx8BYoJKDuXA/s4dVCkKOPoYBHzJlA5omx94/ye?=
 =?us-ascii?Q?MQRsrQNl8V7pb3KP4qvwwftHXsEjMyTD86/04HmlOEAdsBDZlUA1A9k5rWjz?=
 =?us-ascii?Q?1kG+pDJUlra5fZ3v0I+mQaqnYCzShcC4wlzQo6pEMRCBKj8ys08SSSAwa/jB?=
 =?us-ascii?Q?mpfI8NnKejXfyz8iHW7TQCgRA5w1tGFWi+AvSCPUfJ7ZoResNXBVNeBdwNJg?=
 =?us-ascii?Q?lIq+iIMQBIDokftGNt5NTBuqYwSrw/mYFZx68XeCI/ADMe9DDcFruwU8vdEp?=
 =?us-ascii?Q?VTQW8nZNKQHDut0NCZ1Gvj2+VLN511fpG6pNGZFMM0JeLf1ld/VaB/qAu5Xp?=
 =?us-ascii?Q?7LtcVqzHoOVBymkGRWNADbPhqkwDfZYHas5koLh4GbzoGEMHqkdjmZogPBB9?=
 =?us-ascii?Q?Zp8ua2F05BkcXBhcJGn6YGaozaYET3ZuVNOKLQGpbyP/APPLPWq6ym82BmhQ?=
 =?us-ascii?Q?jaxH9XbMxjzdp2oClo8jsNAHjzB1SsRDwojGeht7Sqm+5FNNvQL6/K8aHqt6?=
 =?us-ascii?Q?jpz1FYcJQfd4e2SPPybXlwJsU2tMfd+l64wHR+2NtE8ewwhi3HPJ0Z/bDQ3s?=
 =?us-ascii?Q?1bLOcTVHL6Rle+d4+GiA0NwSyWzSbknJcrrcJa+Yf73BlI0VohNNXSCDQBoo?=
 =?us-ascii?Q?hzvtAeUvJfwnorFX8Yw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55e5008-08b6-4e39-86ea-08da95cc65a0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 21:10:34.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0pAjd0BStIaOxiow+94qwsE9gtMezhlRLxDus/zwkfagUBXGJTLyaWmeYdN8RMhTxQEaqmdAoGT2cF/6uL3ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621
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
IRQs by writing data to a register.

This enables the MU block to be used as a MSI controller, by leveraging
the platform-MSI API.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/irqchip/Kconfig          |  14 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-imx-mu-msi.c | 455 +++++++++++++++++++++++++++++++
 3 files changed, 470 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-mu-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5e4e50122777d..b9adc698ef0fc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -470,6 +470,20 @@ config IMX_INTMUX
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
 
+config IMX_MU_MSI
+	tristate "i.MX MU used as MSI controller"
+	depends on OF && HAS_IOMEM
+	default m if ARCH_MXC
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_MSI_IRQ_DOMAIN
+	help
+	  Provide a driver for the MU block used as a CPU-to-CPU MSI
+	  controller. This requires a specially crafted DT to make use
+	  of this driver.
+
+	  If unsure, say N
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
index 0000000000000..4bb9456ba4820
--- /dev/null
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Freescale MU used as MSI controller
+ *
+ * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ * Copyright 2022 NXP
+ *	Frank Li <Frank.Li@nxp.com>
+ *	Peng Fan <peng.fan@nxp.com>
+ *
+ * Based on drivers/mailbox/imx-mailbox.c
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-iommu.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+#include <linux/spinlock.h>
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
+	IMX_MU_xSR_MAX
+};
+
+enum imx_mu_type {
+	IMX_MU_V2 = BIT(1),
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
+	u32     xSR[IMX_MU_xSR_MAX];         /* Status Registers */
+	u32     xCR[IMX_MU_xCR_MAX];         /* Control Registers */
+};
+
+struct imx_mu_msi {
+	raw_spinlock_t			lock;
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
+	raw_spin_lock_irqsave(&msi_data->lock, flags);
+	val = imx_mu_read(msi_data, msi_data->cfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(msi_data, val, msi_data->cfg->xCR[type]);
+	raw_spin_unlock_irqrestore(&msi_data->lock, flags);
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
+	raw_spin_lock_irqsave(&msi_data->lock, flags);
+	pos = find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
+	if (pos < IMX_MU_CHANS)
+		__set_bit(pos, &msi_data->used);
+	else
+		err = -ENOSPC;
+	raw_spin_unlock_irqrestore(&msi_data->lock, flags);
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
+	raw_spin_lock_irqsave(&msi_data->lock, flags);
+	__clear_bit(d->hwirq, &msi_data->used);
+	raw_spin_unlock_irqrestore(&msi_data->lock, flags);
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
+	msi_data->msi_domain = platform_msi_create_irq_domain(fwnodes,
+					&imx_mu_msi_domain_info,
+					parent);
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
+	.type	= 0,
+	.xTR    = 0x0,
+	.xRR    = 0x10,
+	.xSR    = {
+			[IMX_MU_SR]  = 0x20,
+			[IMX_MU_GSR] = 0x20,
+			[IMX_MU_TSR] = 0x20,
+			[IMX_MU_RSR] = 0x20,
+		  },
+	.xCR    = {
+			[IMX_MU_GIER] = 0x24,
+			[IMX_MU_GCR]  = 0x24,
+			[IMX_MU_TCR]  = 0x24,
+			[IMX_MU_RCR]  = 0x24,
+		  },
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
+	.type	= 0,
+	.xTR    = 0x20,
+	.xRR    = 0x40,
+	.xSR    = {
+			[IMX_MU_SR]  = 0x60,
+			[IMX_MU_GSR] = 0x60,
+			[IMX_MU_TSR] = 0x60,
+			[IMX_MU_RSR] = 0x60,
+		  },
+	.xCR    = {
+			[IMX_MU_GIER] = 0x64,
+			[IMX_MU_GCR]  = 0x64,
+			[IMX_MU_TCR]  = 0x64,
+			[IMX_MU_RCR]  = 0x64,
+		  },
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
+	.type   = IMX_MU_V2,
+	.xTR    = 0x200,
+	.xRR    = 0x280,
+	.xSR    = {
+			[IMX_MU_SR]  = 0xC,
+			[IMX_MU_GSR] = 0x118,
+			[IMX_MU_GSR] = 0x124,
+			[IMX_MU_RSR] = 0x12C,
+		  },
+	.xCR    = {
+			[IMX_MU_GIER] = 0x110,
+			[IMX_MU_GCR]  = 0x114,
+			[IMX_MU_TCR]  = 0x120,
+			[IMX_MU_RCR]  = 0x128
+		  },
+};
+
+static int __init imx_mu_of_init(struct device_node *dn,
+				 struct device_node *parent,
+				 const struct imx_mu_dcfg *cfg)
+{
+	struct platform_device *pdev = of_find_device_by_node(dn);
+	struct device_link *pd_link_a;
+	struct device_link *pd_link_b;
+	struct imx_mu_msi *msi_data;
+	struct resource *res;
+	struct device *pd_a;
+	struct device *pd_b;
+	struct device *dev;
+	int ret;
+	int irq;
+
+	dev = &pdev->dev;
+
+	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
+	if (!msi_data)
+		return -ENOMEM;
+
+	msi_data->cfg = cfg;
+
+	msi_data->regs = devm_platform_ioremap_resource_byname(pdev, "processor-a-side");
+	if (IS_ERR(msi_data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
+		return PTR_ERR(msi_data->regs);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "processor-b-side");
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
+	if (IS_ERR(msi_data->clk))
+		return PTR_ERR(msi_data->clk);
+
+	pd_a = dev_pm_domain_attach_by_name(dev, "processor-a-side");
+	if (IS_ERR(pd_a))
+		return PTR_ERR(pd_a);
+
+	pd_b = dev_pm_domain_attach_by_name(dev, "processor-b-side");
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
+	pm_runtime_enable(dev);
+
+	irq_set_chained_handler_and_data(irq,
+					 imx_mu_msi_irq_handler,
+					 msi_data);
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
+IRQCHIP_PLATFORM_DRIVER_BEGIN(imx_mu_msi)
+IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
+IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_of_init)
+IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(imx_mu_msi, .pm = &imx_mu_pm_ops)
+
+
+MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
+MODULE_DESCRIPTION("Freescale MU MSI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

