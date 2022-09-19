Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA325BD148
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiISPl2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiISPlX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 11:41:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE542399CE;
        Mon, 19 Sep 2022 08:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLC1wzvBiaJy7CZnfLEdSkyrqgJIK+Rehy5CXq2vtUjgXanfheqwkg8T0qBTIv/ATqlqrqXGqsIXVRAqIAGP6wThkqOiCwLSVEP2Twu6n8TbBUwb0csu7Q8wDPq0y/ct4qj7LVYuOPJ5mjg/uxynzPgAvxpY9GanZTLB8kj5pp8f6axjflj8WVZuDQuZ5KA7Sqv1r8wwWq+cPmc3aDYYY/wiX1cfMYUOG467hCuJZeC8JPX+yK0XL99MmIBKX/b+ggpn2VjwIxmlnqpmjWDcoN11p5xoK1yEyqYL8KepkSod9TG8RXgZC+02OS5RB67/ZnQj0c+F/S9QiOaRhdX4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4HRMT8VBwUQPFzZjEB0zfcN9N4fLgSj3bCnIo7hLnE=;
 b=nVRc7QpSbroEIqlGEgEe5reZpkkisxTDRBe2MxWpNP4hhIhYx5QIenu2gT1FDpoYE0oziPPcgqEt/hTy0wSQpJ7ducIvaC7Pqu1a8uXDQMYhzwGyOYn2uPVpzt9oWopz4F5x3ZynBl5sF0nZQt6t54chB6lxQ7E/3q4Fcfl36791Hnlmky1sRz5167NYGguoN20rUscEZX2VfnWQCNHE3hE1CR2jSZwdRNIHV0neqhEJ83dmJrifR/5z/81qMpNHriJoEAam2BTyMDMadAij9mPk8U8JZzIol3XHgv2z7hMoZcPfhF78zsSrsOvcWhdR4mCdb0YCnpv9eTxPrFb2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4HRMT8VBwUQPFzZjEB0zfcN9N4fLgSj3bCnIo7hLnE=;
 b=MD7Zn90V5RdfSTwFWG3GHmmKL9Okjwny3RSA2aOHRPm7oiwhvYkDPLzno1RcLfwLbJGTLZuBtJ55GNTV9MK/udPRiWEFmYDTRk7C9vxhWpJfJbQ4JeFSVSJ+J0DAC4lxUIyaVbHFYauvOkw7GopPsAOP70gQkLekiCrgA8Bn4Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM0PR04MB6945.eurprd04.prod.outlook.com (2603:10a6:208:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 15:41:17 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:41:17 +0000
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
Subject: [PATCH v11 3/6] irqchip: Add IMX MU MSI controller driver
Date:   Mon, 19 Sep 2022 10:40:35 -0500
Message-Id: <20220919154038.187168-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919154038.187168-1-Frank.Li@nxp.com>
References: <20220919154038.187168-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|AM0PR04MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc0e2f8-2ba9-430e-98dd-08da9a55643a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKQj0RjzgLFb8Was6OAIHIHJJq5lJOJQWJ19KY94wIJJDYssC7XXezb4nJmmf/GaOrk4kiG2xYrdjXZG/Qmtber05rAnHz05FapJ21mpjj8YdOqXiFUpe8/ib5zagjp5iyQ+cbu+CwVeZl5xQXbOcOtbUxskQB7PNGTsA4GztS0+wyoOHCnJ9m9GmHQ8f5cGPilKBz9Zn+Pb42ZEJSG39TRsvHODbXP/wUFqApE8C8q7it6QbM9IysItF5pqG8/zoIMsn/bnlXzSpdfgXXZ0Ix9vJ5hP3P9oEeZztC63UEM9GNO/olUX4fKjOkBnP1apb0aav8ZbpGkF44SwLgszhplDSyK6yqrvWqiV06BUc/xt2oJN5jN0nnZ0qlLzrf9u53noOdePKEyacjfIaPQ+YnhidlIDVzfAxYcz0p/KggORusbd45OhcO7Kpw28s3+FUcAbGKXI0yT9/Utq1bbZrr3rua7L7Yzutw9pMPAajcWhFBjM2b+qixDvcEX/8sfguTPbjuk8dk1WCVzCwncC6Kq0HXWMzz+9zIL/g333iCY6rPOy0VEmM5fRKR+JolZIgV3ZIs2kQBgvfm8bOLQcWQPTC4QyvdQPb/O3GZKpQ2nOMiiXopSXfz23xGO/i8mu8HliSbZx/ngcUV+7NnuiuQMrLbzyBNxheBNTjW0YVninvV/FEIbn8L+odvKTW9cuO5HaFoUBo6wNfQ0zudO2bZGmkfa8q2W7QlCUfKyniiwR7FwpA6hX5cPjWibiNA1DAv5iKOYWXNqD/JwKX1MiOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(66476007)(36756003)(66556008)(1076003)(2616005)(2906002)(66946007)(38350700002)(38100700002)(4326008)(83380400001)(8936002)(186003)(41300700001)(6666004)(478600001)(8676002)(6512007)(86362001)(26005)(316002)(6506007)(52116002)(5660300002)(6486002)(7416002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tp683UT6v4G9wwwa0Dq+Ipy4oJQNZiEQjSExhXcfPo9sKPrA828dJyUb5qWp?=
 =?us-ascii?Q?FC4bh4ZtBZ4G+Mr6d+GRhLKMyzVTEzNutLU1rS5szq7jQBGklwHo5Bnq+DeV?=
 =?us-ascii?Q?1A88+0Mb/CQ98KlXFh/nu1A9f0YAhLSETLcBLUWxovoNYLOTKEuBHgTTBRTd?=
 =?us-ascii?Q?P+RBmLXkYEkhdW13QhK4kk/AbVoQa4bNsfKs+vg8qoYy+0m2BzEafzyQ5rwG?=
 =?us-ascii?Q?ie1HWwFCfsDys1yAYRw6X3Bj5IS8ckGBtYhjoA0CcueJp/gT/3nyt1GNmKzz?=
 =?us-ascii?Q?F/K87EGh876QyLFvA3qli3cjxM7iq4bTLncl3lthI3EWkcZBF4ukP2gkyVTe?=
 =?us-ascii?Q?IQ7lxZUVLUuQwNedPsrvnEsVZU0ehEfyJqx/G1++Le5mVQwPNPsc5AuSSSzy?=
 =?us-ascii?Q?SCDI2eUfIYlfRT4MpLyHrQhWNrjTjXHrRmbvEGx61pALSzv6KjSrJb/esGy1?=
 =?us-ascii?Q?jVC7IPy8nPw2NHreq39EOb1c8LPxo1VL9BMtF4DU+NbEFP6pQpTvEd2PKa/7?=
 =?us-ascii?Q?yHure6y72pbL35IB227nNxgixOOITcPgdLFJxD3qarigX3ZesTAvnrBzOP0e?=
 =?us-ascii?Q?J/8xFcHhDLc1zJ3rKnmk4zJesW/uPqtBKengLScUfSc0lxjQEQugf8vC2QyS?=
 =?us-ascii?Q?/7w2J2NHZomJG0pO28L5V4j1IswtBm0C0N4KrpSwUwhihhHsKpcJn5QSURG9?=
 =?us-ascii?Q?thnVLWMF5TyaaXRat+sNGA0sTt4/eLXDT/MIKNxyIdBv+kerTcV208Wa7rAa?=
 =?us-ascii?Q?APuazZp2eRTIyYCwS8hDb2U4jaCIhAIWtJlSyFlnapSV1BU1P1Rt9c7xqZwc?=
 =?us-ascii?Q?EynVBgezGiDBeF1GoJoTBlQjx78f8W9qjcBwpF6OQvGw0ewpErs74qpzgb3j?=
 =?us-ascii?Q?K3iKDFjIfFJ/pUpP8FycLbD0St4mEBcHfp6cMD7WNTfdTBiIBwNdB+jzhBAv?=
 =?us-ascii?Q?0acePRT1k15bLBOV0+pN6Uk5bK252iuRG/4mzltJsYzXte0/Z6EWxTuDXey1?=
 =?us-ascii?Q?ESa/t0YE10BdcK8RpC7Sns5jI7ByAQWXJWEhwSLygEDISi4L7+J47XGTjwXJ?=
 =?us-ascii?Q?OuH93EaKdEMaIAEmAW4UaO0tr9+cBecUXJYCzXKx4tiGi6wr3dAzXrst+JJL?=
 =?us-ascii?Q?W6+V8CevMCmPdHnh6jr7tKP0DhR0qmzvtw5qOlOFRwX5LaeQhGQce3tlu54A?=
 =?us-ascii?Q?HZnay3W1SXabWRL7Uu12svIPh+MZl3UOOBISNsybwRhpGrqHShQi4frwgmOR?=
 =?us-ascii?Q?3OLiM3bD4N7HBNiU0tK4VT+WVxXV5KWKSJaX+7nTuar8otxnLmjrJ0XDSBcv?=
 =?us-ascii?Q?sRxV9TlGOfyk+Gx73Rehhy4uQqklZzyRIohfQ+QX7Qm5UEnr+3keN3JeFrQG?=
 =?us-ascii?Q?074qvoHslKM++h1GLtgWofYQa9RaaplW5+2c05bkm+ISUfI72PdIJcXAnG2y?=
 =?us-ascii?Q?Pw3h0aMDjaTCRzzQJu1KP54QAtev1Ngu7H2/pTKqecYw0zcexBVm2mGl6JyK?=
 =?us-ascii?Q?uBc2nMRHj6jklpbiSvPvBPrEtep7EkjGlC1FuGqWCcReHGv1TWZdekRowv7c?=
 =?us-ascii?Q?XLIz2s25foqdDFwLoQ6OUZzHJaM/6Cr5RvUy0QYR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc0e2f8-2ba9-430e-98dd-08da9a55643a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:41:17.3930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Q4nWfhsIJ9nxKHIzpENPa323bm4HjoHz6Bh/CXdu2YIJ78ov9fckV8O5nKntbQQ+SbDeFDgYvJyL2tbiIWt4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

