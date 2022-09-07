Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECEA5AFACF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 05:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIGDtk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 23:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIGDtg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 23:49:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93423657D;
        Tue,  6 Sep 2022 20:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1bDxI9wZyp/fazfRaHO50x083tUQIuTepv2SI9+oQpg9BmzlFFhZiYhS6OU+VPIKoFtmih+eGuSLM6tqj0Hk76U1oSFVIsLc3oVeR6EJsG4x+w1HmGXlRiDhFYRKTvjClpED+oQ7D15gsIVmjLM6G6z0MAANKGNb74f6nbtpzewy29gRKwZFiKh8kmjzKZvYXMy1uYCJxc5zx+zoD9Rkrs5RIERHbblVGA0hbHOnUE0Cl0vQrV+MIgrlkW+DOc68LR7irNOdW91YBWBdtdxLQfjac90Ne+wmEiEB27Lf79ArgZ8MbW7nXWWh2xZ9p/5pmfzQvpz2BZ6fC5leBJdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlVieAhKtWRBwmuk6JC3NkAMB19eUwTNX1A69MCBoak=;
 b=iuWPppSPlpe9fvIL2LU9QA851dhSvcwQtFxOOhP+Rb1IX9fiKJNVR4BC17VzZYp0+XOXMzQ/7M0YSzNF9cZ5LyiIbo4PL5O3EACDmTLVpTeZZT7VAqxB6PrPdf61UOpAP8+SR06k2K7D5ipgaoic1C0sOawY7/c+WpP7D9C6wsiLqvgwrVNH6+Yut/MB+YJGGX0KWDnUuKcNWTGmnujSA2c45qLNZpQz8Q3efUu5PJczGdVd9MyWVBm3KxBg9H6uyV3GK+7Nf8IRW3j1zGlTt1irq/p+lOUXfxQ7rHE9URYRs67MaWxZTRmlynsRkEJLbgOoL88rP6qGunjCYmtsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlVieAhKtWRBwmuk6JC3NkAMB19eUwTNX1A69MCBoak=;
 b=JWXNGDiDI467gL9Q4Lb39oyY+b7c6QmXr+k71hSHBygbGiCcUs4rl3CqDqYGrgtK2IEYhNyazaq+7K9hS5V+42dthd/IPzdycc1LyfmVBWNsNTOZ0dQMEVafKkMo2y+hnvi5pM2B5bpybtc7QvFnLCyQViGiduqpHPn/cJVF+Os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by VE1PR04MB7453.eurprd04.prod.outlook.com (2603:10a6:800:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 03:49:27 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 03:49:26 +0000
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
Subject: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller driver
Date:   Tue,  6 Sep 2022 22:48:54 -0500
Message-Id: <20220907034856.3101570-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907034856.3101570-1-Frank.Li@nxp.com>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|VE1PR04MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: c587b035-98b5-4a6c-4342-08da9083f5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uqK8eiKqyNV8dKwbotIvOIuOgp2zKj08vYZMhNRl7QseuNe3RuP28eeNC10mFfhUUnVkySmg1MBqiPvjcc9/XoBIUqa+vHLymtAIT1Jakg4CWh2h2RAw3Joak4KrZgnPistebfF+S0Tndjcpgcl1ZxLGgonQRMTWEIPfrQrI3mjpm+vdX4XdNjCWaPI0GGGETTAIA2a5frBQQEcCMA7ISACTEEmYT03rWUG2HMYZbs86DBTBz7u/CadvYRYY/gVzVaeq6d7bMJSYrZ9BxuuGuF8UrkTZMwhUmwq2Trvk/sr+4jTqgvkkKwFR6MPE2HhT5sbui5ITUhNiyPZ8H+A1AU7nDMRXtYt8YnjVU+p6WMOe8k57v8DdiYJ+kLOO9JROS+ichPkeUfENBaHf0ZR9bsKkKSFZ/By1og3EcZlBNyzFXXMOWaLRaPwta1Klo6f7YYZnRFuzPysuXY4Ecv3kIzt888cD0jQC8cJrkpvFnB7+XVnLrKRXoRXnCH+cBXnI3MmwS9arZRZzQ5vkmqUMVkBejBdpx5gUmGvGWbaScHAlepORNXTu6lSMQCmvtPJWFiEmaeGgjq39IsHRgrYKo4/Y/8S4T7MQfzci6IDonhUiiukryavYE90s3LV13YbNvGX+kfS9rU3dqostFkpmIABrJiua439v+pq6Q/9nmdL4R8wheaHBBZYRi7Vjyr2suBN8KGtZfh4dyDVtSkZgjpENqXc7zMBjCzC8ORPizG2wJwEUSPXKNc2HHYWL4iDoV9DtBW8VWFwJTxJdPdXsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(30864003)(86362001)(38100700002)(36756003)(52116002)(316002)(38350700002)(478600001)(4326008)(66946007)(66476007)(8676002)(66556008)(26005)(2906002)(6666004)(83380400001)(1076003)(6506007)(5660300002)(41300700001)(6486002)(186003)(7416002)(6512007)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/dd9Wimfa2wby5XwfEwxWF8X7Dia8TduudRmKT6ZF//eOlcJQFGmSq9yESU?=
 =?us-ascii?Q?lTFNEXEYpYENf9eZ3rzJrLqzNuv3EsOWeB8ulLRNanTpEHNWytp81SRXxkNF?=
 =?us-ascii?Q?Gjypt+cHjUnZvrP025j/3YFOK36I8uJk1W6CR8ER9ny1IvLCAXYYu5jwaEbE?=
 =?us-ascii?Q?qYdfIMSe5PdOg6+dugkUXnSQHI0esoVgkwePh/DPvIFZJiFLg1Y438l0ux2g?=
 =?us-ascii?Q?I/APfrcJTtjt9PjFzzbUaAdjVkcjyDVCtGDbwDdSVTfLbMVgJN1oJ8Q2HjoA?=
 =?us-ascii?Q?mVPo31/WI6wDTYOsrYStqD9I15TPaDCqrJqkkMu9qeZo2dRzmzhQdJt6HiHF?=
 =?us-ascii?Q?DHt4G8HzS8veUC0B8D08Hyl3L/FrK4ZbUqonODuhdNYYTrWy1y+UmaQQXxQQ?=
 =?us-ascii?Q?+hnHf+H2Lf8lZha//aPG/TAqJJ/w6poEi6SBF3zcmSS7RhtFctYB+QBACDmx?=
 =?us-ascii?Q?jixt0CgVLprsjVgIj2Uy8QwTWmnpBnXntUZNQQJc5cgYUSTXGI7fihasfJ93?=
 =?us-ascii?Q?bw0xW9iTU2m9AiuC3eMMMZwkFPApHvv73zbe6bfEjI9tZP4nlxUsESlWqExn?=
 =?us-ascii?Q?BzcHyK1z2SmYZbPZX2PpeZj8BbP5fXMCPEhSow82fs+sg+wF7ktX2kHv7+ce?=
 =?us-ascii?Q?80DLvNwXUQrzXWwm0o6vu/0PAjof2cRGxb/pjH09u433EEXsWXoVRCbqooKY?=
 =?us-ascii?Q?cCHZgywmkS+HGqXhnX1pmN4+e7Q1i/BHrK+0J8argDld7F5EFTr9SiRWJVTO?=
 =?us-ascii?Q?q4PFUxVwaxTxW1Q9leYzp9+twOk8eluMQVWwpnd3UhyktE449bS1utNpX621?=
 =?us-ascii?Q?7LMT/Uz6kczQmfg0yw8Ix7I4zt6SKrk0/Tt1yFKM62zy2jvXHFzDUdkn8Nk4?=
 =?us-ascii?Q?TbXkWnv2KGC+LQSwvo/haw5byGCjzLiMH7cFYYky0wm5IGxtwA4Nju3M4Vc/?=
 =?us-ascii?Q?KnJdXDBXeK2fWp1LpOskklMK8F6hkRen5AvohB+c4mLHE8ylSb0dAgWSID75?=
 =?us-ascii?Q?qckqVajm7jtph2q7cEDC8KoKakwkHjwGYmWe24onvofrcGPh/7kSw1xnkNoe?=
 =?us-ascii?Q?eEx1RQAnSVzP4k6sDhP39y35SUkllCBL/XDML5Tnt4wjYDL2RfHQxBItgn6T?=
 =?us-ascii?Q?ZbC5zBHUsfErB9wV4fG/z7Mz77Q3+872dZVZw4Bu/2y7pLnbuOA0ZlcZs2AE?=
 =?us-ascii?Q?vp0SCIEnH+4gGGFX8IaJHF8GmuR4oLOKsvadRlueI3RNhjXzYceelwJB6qA+?=
 =?us-ascii?Q?7e+rWqhVdYA/lrnTFFKaC/eAZh8vAfwA1ssEOzVW3IzTsb0nNL74PbMXGZB6?=
 =?us-ascii?Q?sDEY3xc2LtifQ0NoBMH9xvIijot9jRIQ1bwmvKHdN3kpu99Ti9exJM1cEgl2?=
 =?us-ascii?Q?BBdAWTU4YJADlT12Qvry+kya/PRf7CZMqm405TUC8UR57pIQX0aO2k7kYGp8?=
 =?us-ascii?Q?so1HL/C9Fg/BHmqiQ/p0OzP5e5DI3BB4NR2+wXh0PeS00j+dDYoEngNC3ezr?=
 =?us-ascii?Q?M+DrJn6X+Ml82tEtqVKcy1avxMgOx2Z44jpzjQkFz5Rxf17LrDrIduJiqACZ?=
 =?us-ascii?Q?PwKPr4yucDVW9cQhINBjhz8w4YUc7WYM7duJwGio?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c587b035-98b5-4a6c-4342-08da9083f5da
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 03:49:26.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbwYXzEjOFp2oooPbXVRISrsJUoHxaYVDDyEVMuKQvMs34nwuvYa+b5KgmcereLRLH1mo0e8FOfN1jr2R/2EZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453
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
 drivers/irqchip/Kconfig          |   9 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-imx-mu-msi.c | 451 +++++++++++++++++++++++++++++++
 3 files changed, 461 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-mu-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5e4e50122777d..e04c6521dce55 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -470,6 +470,15 @@ config IMX_INTMUX
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
 
+config IMX_MU_MSI
+	bool "i.MX MU work as MSI controller"
+	default y if ARCH_MXC
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_MSI_IRQ_DOMAIN
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
index 0000000000000..82b55f6d87266
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
+	if (!pdev)
+		return -ENODEV;
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
+	if (IS_ERR(msi_data->clk)) {
+		if (PTR_ERR(msi_data->clk) != -ENOENT)
+			return PTR_ERR(msi_data->clk);
+
+		msi_data->clk = NULL;
+	}
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

