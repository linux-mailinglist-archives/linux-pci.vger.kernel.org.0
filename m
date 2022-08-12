Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA735916DF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiHLVxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiHLVxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 17:53:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208DB2D87;
        Fri, 12 Aug 2022 14:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgxHgcxqD47kb7RpMLhPjQpkG9ZGcEM+ogG6VPukbI76aDKDsHZMTbyv6HyazSfdiUXAXU6VW98SC6qGwOFfCzvS5VpseHN4QMjiXjNjl6vXivX55GxbkQeDnR7iH349lrMnyftNG9Z9vcT1FxQK1Pgmmeptz3s9hIGLHLrMI7nG9Tb1oLZtqflaoDpDpoyr4aD66QhPm8MBoIE2/S36ZSZAnQCyIAJEE+aNDMUg7DYdaaU1K75ICKdTBTLWJFtz68MjLiyZDBzAyXpodQFyVH+FF+UL4INdhY72kjb6Rfw6c9YrS9SBIxl9Q5JlKoNlUCNyM02ovFAE+2URc1QbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HDf3DbK/tyJ6XyuRDutz180dpu+bKOW/APIOAD7k/U=;
 b=FPvz+wBlGThyzsgx96S5OYDq7R0L2K2ek3YlNkrinsmxCo4aRoVIKSe9jfBaeufl+zlnOaL0b6qZD8kOt6wB2Chdl8idts+RKC/4xmyyA5SVHUzYiJaFgoEoD5jBXohdPZ0sO2vTpGWCQuASIjfPmIGLRGbtoCLvA6/U7ie6dWysSmXn/ONDtXz0H19IOvQnpokji4zX2gOvXGZ/In1o2zp7UjZPnslO9bXgjlwFKRMD2QxMvTyzYtTvtIdkK75NjVNBNdyfddBvQL6pu4kbNb1gRQZa/Ht+WST6SZUfzgKQ+c9hA+V1GXuV2kayNNbLRD/lbE/JDl59em+QQOW97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HDf3DbK/tyJ6XyuRDutz180dpu+bKOW/APIOAD7k/U=;
 b=i5zijTLZOjh4tycdJMRqOS67V5mVsJ1b5HjHE2/th0RXPwgRG6I3jFKdCb3oKNwMsJ6E2iNP5zCVUgMGeLnz87hdW4SNhOO8kJDxzBF67xMTf6y4rabKP0v5wIyUmXyshLm63IknARS20/woYtnolG6jfb2KuKuUA9uifrn9hHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 21:53:12 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%6]) with mapi id 15.20.5504.023; Fri, 12 Aug 2022
 21:53:12 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v4 2/4] irqchip: imx mu worked as msi controller
Date:   Fri, 12 Aug 2022 16:52:40 -0500
Message-Id: <20220812215242.2255824-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812215242.2255824-1-Frank.Li@nxp.com>
References: <20220812215242.2255824-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 468e7192-a28d-4d0e-82c3-08da7cad0d32
X-MS-TrafficTypeDiagnostic: GV1PR04MB9087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXP5P87mEjru+Dmc1mk/KLh8B8Hc/RPFvo7lcWU0fJif1lZuTCKqLzKxhB2rQh1mnY67M40o20+QkFYT6ZsvVB/ep685ZegSMY5UjqlADLs2RiZLIsWzR4PzdFmTt8bHXOpTt7CP0K5FsXxnjlm+VeBC9DJVHi8La1eSfONk7xszxk8KWdEVeQNo2MlT9oObXcxwKGJ2S8i8sknfB5dssQ3ZL+qr285TglhZbwlETdMfvxv2yyQ8Y1NqkgsKmVvi1qSqjnS2XdduZ3g7/FMe7sf/jK7D/WIBxCL353S1rD8URQeWZEwcExj9J1SDflkqFCY7nGj/6qSEF9NiONMzdUnoAb03RE8UMvVZlz7qpVWv3LcSsePKPROXMjO2vKV5nZpuJizAdWUIlx/BFb/L/vGypeahMLRp7MNqsaoYaa8kN4GKSpDKTvVgOdryEorTSL4mtTp95tGPDQu/J6IN+L8TVPSV0Eq64uJD42FI179CrG8b9R1WBLKhU7u2z53YRRzMiH7GmLSnPN08yJvmd7Xtib+579b1TzqbZ6IDtKAslbPBXNmJ1OV+pvHMC2TsSK0R1vU2Gsd50laXzPs/J15RmkmqKK97rEbKa5/8jViR8wlVQhgHe/N8OvP64njv7jkppXaHeFlmYtGniAY7GxTRj7zrivDQNfjWjAqesbDGg2eb53XiBnSCeGqspp/q4we6GNef8hTF7osHgs51W3arflNfBc5ZkUbdf9Qk7pqHuk2bQiaW11sewZaKD3juGPNlI5OYnc7CqAy47SBdcCvS+nClW+8J+1m4MeUtpac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(1076003)(2616005)(186003)(83380400001)(38100700002)(6486002)(478600001)(38350700002)(316002)(66556008)(41300700001)(6666004)(7416002)(30864003)(5660300002)(52116002)(2906002)(8936002)(26005)(6512007)(66946007)(8676002)(6506007)(4326008)(66476007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6fLpK61cW2UmOvgNj7IVpWkRuPV31PMCAITeMKyunhSd/z8oyKdRELBPgR51?=
 =?us-ascii?Q?rt2tzOX1dUv7PfzpcH+AmYdfsD9veAgV2sSGN0wEsWJtJz6T0+zCLPrzdHXf?=
 =?us-ascii?Q?gn4uu6goYJO2LcOukVWx3BIfqvQTVBZDoHha57ZxCxdi1xZ3rjL2/WF7KEoO?=
 =?us-ascii?Q?QCL/3V58H9T1UhX05EQCBCYkt3hbC/K+8/7v2bOEpRvmbgVeD0Uy1u+I57my?=
 =?us-ascii?Q?jPn3ATu9CV27AUe0kIQh/vdrXOBeVC03opxIZKvM2znIO+EP1bj8IvmfmncG?=
 =?us-ascii?Q?iVAE8wSe/ICZDre9ySU6vFsIqUNrhWPLfIyvDr2Ay2Qb4nN4LTB3xGNJSH4R?=
 =?us-ascii?Q?kqoJHUA9sRIkbWFb26h4/uxqVicJvwgRK5xdEgIpsJ8UEymti4reI1iPlfAW?=
 =?us-ascii?Q?cYWwd4MAAEWL0xocIi8F+clmPZLAoSkzEKISAlbn/+WBJT78SS6AEepf+a19?=
 =?us-ascii?Q?IGPwQtpP3j2eELtcSI51satIvbrtzuuY5lgvKb4XbKe4tHy9GChJeWbNdTNX?=
 =?us-ascii?Q?cpb2NmLWjr8AtkyEdPT8LgnzgPhr2zgAo5845n26mejJBq8rlWB8PKF+K3ym?=
 =?us-ascii?Q?vhrvs08LkZS30t1o+uMfZO7enqzzghG0B/zg+Qf0+wH909O5Am7Kk+te9tgo?=
 =?us-ascii?Q?6jKSZHY2zGQsa+Wctix4W5dz9ZIFxlW87Dt7F1AgZSwQbY2dipclSp1it2Gl?=
 =?us-ascii?Q?otEUbBSSyCrTwsx5VfJZ81ssVNDIz3OUXlcNreSAPwkxnQEjJX0cACcw20A3?=
 =?us-ascii?Q?nakBXlEAgPX+si93PMkNXAUHTmywO0b0L0BEbildYeHYXPLwacrU1UjA5vvL?=
 =?us-ascii?Q?fM87//bwxTeI3V/Tx9oJB44ZQC2sgPQKx1gE4VIpkKJME6+UfBKDrvKP3TvV?=
 =?us-ascii?Q?9xYEDO7sAgQOYvf+/oSFSpgw7jY7qOpIOrCXhr7nvW2vItwTechhzKu3ky7y?=
 =?us-ascii?Q?eTVtCSc8ghveQb+g6nb4/Yqcs0odgG+442ST878oP0pIOsNWeeYlpZrGSHEI?=
 =?us-ascii?Q?amtIQLtNbV1tayUISIr0FHQqVv/D1hYg+hpeVU4U4a2imX0eh+uZl3IkBU8H?=
 =?us-ascii?Q?5w4iVT5DeI86oXO4jTg0zF7FU6/86fZINelFfdrIPn748IPMPytBLzHOAUea?=
 =?us-ascii?Q?InhNs+tFDBug2mPftN9nL66Dv6I4qsIRHZtLOdadXlRMgT7HjbJ6oJT46PQw?=
 =?us-ascii?Q?ayKboDxtMbZ/WsW94Zckyp5sTMwsaFfFHcIhwwJr9Zsgh/mosEjD8M7GtgCp?=
 =?us-ascii?Q?v28WlCPdpdf/RAx5KP5taCd65UU3N/mUpfklUo5LpYZ7WQheKkmAsFXV76kn?=
 =?us-ascii?Q?qLiS3lIiqHSR3dJ8GGEYpDYQWv1xsllfYIDINxP2rqWyjUlfKN0HqE3f0axw?=
 =?us-ascii?Q?hXeWtom0I9hxcqxT9WO209ImaVPF+S+lEKpqFzX4kTOHGh+ufiRaNqlMrlMg?=
 =?us-ascii?Q?XzVzoGaoDlsZYinF3jmpEECKWBkbhKbQugqpY9hmCUM9olrNdhzFkoEbEKiI?=
 =?us-ascii?Q?KOXrAgxoCGlGbFp28rqPSx4jQ7BoowE3hP3vyU+rCdueYKOCOrU5bz5cn8jE?=
 =?us-ascii?Q?qKOIF6aZPyqAC1o/iTg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468e7192-a28d-4d0e-82c3-08da7cad0d32
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 21:53:12.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooWHwRNPEKrups73PQtk027rivZSc7WfgncWOxjTenTLL5A6VoJg9WqWyEpKONk+bH++o4O2YCuWCwLq47oVkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087
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
 drivers/irqchip/irq-imx-mu-msi.c | 443 +++++++++++++++++++++++++++++++
 3 files changed, 451 insertions(+)
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
index 0000000000000..bb111412d598f
--- /dev/null
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -0,0 +1,443 @@
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
+	struct platform_device		*pdev;
+	struct irq_domain		*parent;
+	struct irq_domain		*msi_domain;
+	void __iomem			*regs;
+	phys_addr_t			msiir_addr;
+	const struct imx_mu_dcfg	*cfg;
+	unsigned long			used;
+	int				gic_irq;
+	struct clk			*clk;
+	struct device			*pd_a;
+	struct device			*pd_b;
+	struct device_link		*pd_link_a;
+	struct device_link		*pd_link_b;
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
+        struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
+
+        imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
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
+static void imx_mu_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
+	u64 addr = msi_data->msiir_addr + 4 * data->hwirq;
+
+	msg->address_hi = upper_32_bits(addr);
+	msg->address_lo = lower_32_bits(addr);
+	msg->data = data->hwirq;
+}
+
+static struct irq_chip imx_mu_msi_parent_chip = {
+	.name		= "MU",
+	.irq_mask	= imx_mu_msi_parent_mask_irq,
+	.irq_unmask	= imx_mu_msi_parent_unmask_irq,
+	.irq_ack	= imx_mu_msi_parent_ack_irq,
+	.irq_compose_msi_msg	= imx_mu_msi_compose_msg,
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
+	u32 status;
+	int i;
+
+	status = imx_mu_read(msi_data, msi_data->cfg->xSR[IMX_MU_RSR]);
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+	for (i = 0; i < IMX_MU_CHANS; i++) {
+		if (status & IMX_MU_xSR_RFn(msi_data, i)) {
+			generic_handle_domain_irq(msi_data->msi_domain, i);
+		}
+	}
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data)
+{
+	struct fwnode_handle *fwnodes = of_node_to_fwnode(dev_of_node(&msi_data->pdev->dev));
+
+	/* Initialize MSI domain parent */
+	msi_data->parent = irq_domain_create_linear(fwnodes,
+						    IMX_MU_CHANS,
+						    &imx_mu_msi_domain_ops,
+						    msi_data);
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
+	/* clean irq_set_affinity again because it is chained irq */
+	imx_mu_msi_irq_chip.irq_set_affinity = NULL;
+
+	irq_domain_set_pm_device(msi_data->msi_domain, &msi_data->pdev->dev);
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
+				 const struct imx_mu_dcfg *cfg)
+{
+	struct platform_device *pdev = of_find_device_by_node(dn);
+	struct imx_mu_msi *msi_data, *priv;
+	struct resource *res;
+	struct device *dev;
+	int ret;
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
+	return 0;
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
+MODULE_DESCRIPTION("Freescale MU work as MSI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

