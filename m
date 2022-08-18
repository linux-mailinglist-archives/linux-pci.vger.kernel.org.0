Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB80B59871E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbiHRPMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbiHRPME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 11:12:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0790BD77F;
        Thu, 18 Aug 2022 08:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdr981/0MXCj7CiebgeePX0Ux6NJBpQyw9TTQMyvEjFnjHqSx0foIDT2SqczLvxr8q1kV9ATc7wR9rA2zTW/qzrcNRtpEjz0C8JGn2KOiKYo+F1Ju8wakLrOXq89MkImRSVvdP5Dd0iDzZD5/PjJrxIK9ugJXsu+OaXpNj5q0mzbWz4dUXrHT+DZXX1P2xjjI/ENttXL+rL/zQ1pBmf967SPtlGyYt68hfc8m/vqsy3ISGojinsa0cEB62b8Zo5aPC2q5alijU+4jo/hP7Eq6qntp82bPB9G9hdtiwXLSdTmXe4+lgtipz08nTyJ/PLFwRzRioMUJTKGAfpExBiEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FTN6H7ukeDkJqVfwyfo0imFQDw/M5zvxApyhzWREEs=;
 b=S82FDo6HxXwXfDzlhfrdH0KwyePr/wfz6undhnkH5FXQ2FvYSt7yf5s+Gq11DSrEH9MmksRcXUnwfLdnNi2Gixu5lfKW78T4pS+LrWmlFwGPWbs4r0BF+h1T4bM6jbSMuuh95xBTF8PHcjJLoEXjcqIY4V1ac6fe1s2T0q2F1tDo+od92Y5ypqwp8TEe+oAebvlojkhJ7kkwssitieCN02DvPHVVTQQy1Hz1Ll5rbKPdR2L+RSOj7gcU47FdQhGBBJPWOxwu5Eq5XVlBZW3Vg4GaOfA/b9Q0w5irunYbE2h7Zozro1t5xy2/NWmPYi3RxO5IUI86a8lDVfqdzwjiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FTN6H7ukeDkJqVfwyfo0imFQDw/M5zvxApyhzWREEs=;
 b=e0V2N5nV1B/UOi9vvHbbwJjZvrBmAcxzzQjkRkuS70XQqb6PB1srBMopni4USAf18keb0P1wuX2L1T+mdvO9EPzDAYA4oGUjtT9DJJMRJBgoQAFMMaCRwonk4K40Y8lEjXmRy2EQ661wkcKZ1CLA/3Ux3jahgvpIAiw4ZsFCUoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5713.eurprd04.prod.outlook.com (2603:10a6:208:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 15:11:59 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c%3]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 15:11:59 +0000
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
Subject: [PATCH v6 2/4] irqchip: Add IMX MU MSI controller driver
Date:   Thu, 18 Aug 2022 10:11:25 -0500
Message-Id: <20220818151127.2449064-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818151127.2449064-1-Frank.Li@nxp.com>
References: <20220818151127.2449064-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b3571e1-49e8-447e-9bc3-08da812bff4c
X-MS-TrafficTypeDiagnostic: AM0PR04MB5713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMgbQl+sKmukAu5jwqIka5KMKS/TM1Smi9sfLjDVk5ka2Pfq6ZJw4XdflgzhV1ziy9y6Rt25rN6TY0oZwLPq16huyFp1bB9tNw1+n2u4Nwh6B7RkVNJu5kM4vKe10YL5R1auzIishcAROIE41dMrjYJktT5wiBrn7Zy7dr4OTkB77UV1XoOTNBx8j6J/Tf7XIrk+tA+4yjuqZ9shhEvuQFmIpml3rnFi1N7dMXUemyXR4FMsQ3iF3NkvOa4dyer61PIdVIhvvM2os5egW1DAuFE3vMvZQdvga5yvun6mQ0Z/z8ohrVaBzULo2pp2ABJZ+7iGMVzk/jDqI+1uuVfCTswO8GwnvmGUpHbQqfvKa/1AXkhdZLMRr1ZFO1+FjCwq9ThhYrFjyhgfSmogeGs3EqAsJk3pcbucdAj1svEMPqEvPk3Cxpo1vgR5/Nu6B1a8aAOZrC8lxZWbzgWEamTcrnz+Xv5pWDsxHnSG84y8yF0yGS2l7oDacJLBEDEgr6c9EQzhy0p6hjej+qLGzsBvfIVAV+LC7DhgI87sz+GkSpqO/45FfhO710PVMVpVOd7RV3xPDs4mn8JdEdPqV+RJ11uJQRtz/Syu7xrhwrH6Aj0TNyXioBwEo9gL2Qa7ainJXrYoZR5+Pxa19UeFdF7I6Fvesm2kKQBVianYwbrljRl8ZKwQDbQhVG/6NwQksMxpPwR35FzpB/jweP2U1zdYgLHItX4nWUoCz1cUorT8woG+5uoAfiPD4sg598a4/91ep2PIDdWofRcf3KyHaZ+AFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(2616005)(316002)(1076003)(186003)(83380400001)(36756003)(38350700002)(38100700002)(6506007)(52116002)(4326008)(66946007)(66476007)(66556008)(2906002)(8676002)(6486002)(86362001)(6512007)(41300700001)(478600001)(26005)(6666004)(8936002)(5660300002)(7416002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J75QTZ+QtjSgnTGL+R6/74cUfhLeO3tXw3OYE9FigP4IxvtfPnODpE4ql2b2?=
 =?us-ascii?Q?qujLKDySYjrNM3Sr9z8Ab0kt/3czjeBHp3CUER3oYid1D9C2NlHPiR4OSQHj?=
 =?us-ascii?Q?DaURfG56m0X4LnbPf/zlH2tEolWG0SI12TjwY3yt8gnLrXSwvHAsjMc5ssxw?=
 =?us-ascii?Q?nalgE5WVifCNpCkjPZ2KcsbOnCIUS72jc+5j5SzPTq+E1LUITPpFDy0UQTj0?=
 =?us-ascii?Q?diy80/l0BZ8mwXj5mIjD0eU20HQSVfVbT6IKk3S5FrjKzs8SxZsYIfbPoAa2?=
 =?us-ascii?Q?WDl0fMrdapIIW6Uhp8KJVtlevNQLp45d0CrmSmG/AuvriHEPJIBL+pM463in?=
 =?us-ascii?Q?BoqiSMY5Mkm9nNYH19ws2ksciOX3PgXsyxADSupp1Y9OJYsgmJIwjb9LjbVE?=
 =?us-ascii?Q?Hl8AAJmR+sp2JZgTJNcUhOWUliW22wFMCo28oT+x94pTxO/9/FUB0Zxcn840?=
 =?us-ascii?Q?xxMsVwnEkpyQXboa19Oxjyu4RibtEuBHu1R0T1uq8Wja43iIeHhIVdqVirBR?=
 =?us-ascii?Q?1qqL3dKBny6/rnsTqehp6fPBEXJlYjN6yYC5cMD4rKvrsHADnjUPFQEVa5Fn?=
 =?us-ascii?Q?J5smDpRLmS9cyBs0AwMY6E+R9lZYLYh4tXntli9WXBKuhsmqOqwbM96WIOMU?=
 =?us-ascii?Q?wQoJlu8va84l9HcR5xtt1lL7WfC8mUH1tRZXjm06VIIHYQLFq8v0MVL8RpaP?=
 =?us-ascii?Q?lHEDl3fbA0bZXAaTdGLjX9vj35s/co/wC8cySlZh6DtL1xfh7ZCx3vmdxxtr?=
 =?us-ascii?Q?fhqo/tXDkZsYFE29/6YkL9bLCwkn10Eqox6883boKhWojl0w+3/fqsEHHWNH?=
 =?us-ascii?Q?hS3+U9fGsNPrUZgg0+d3HXpPTo7ylvTCv0DRlrt6cnY5W/YkD69jmi2eHaT4?=
 =?us-ascii?Q?t8sf1kq5yjklJn85sTofYf4PUmUeQZGpulFQNF0GxNorDaBznWOrR8CfDEYN?=
 =?us-ascii?Q?bl92lEwAQcISepRSNlxFf9ozKLnEEpHVGycTRh+CN6x4m49QJNP8q0QK/oQk?=
 =?us-ascii?Q?g6szVZ7kEmbJhCBnpqiTPjaH/dJGY/J30SqFCA+eXy48oGGnh2Jza6C4UFBJ?=
 =?us-ascii?Q?BbTAe0i5upv4o+G+VVIpqh5U/lgQ6eodFT/u+2l3/MaPhnmP8w7xnHbzilC2?=
 =?us-ascii?Q?RyAAtWxoexRMQGk3+Pv+EOghuFAZgYOe9kuHXk9J0d6teotiQKzpS6oW/cX2?=
 =?us-ascii?Q?LmF9VerduJXJyeQwhE2w7E/iV76fjGzx3JTQAv3uf55IjxhfpqLTJzk/bydQ?=
 =?us-ascii?Q?B93bPwF+AgTtIRPg8UUKV+nVkFSRmNSAwUHGNTaD9/wB3Lurc7jfKEuSSnm3?=
 =?us-ascii?Q?TXUyZfDLGA3PSuptShimplq9cXGlShaFn6hpO57czwEeBF+ldmWz2Ol9LPyx?=
 =?us-ascii?Q?OTqRL71GTrVsPlc+c0/ikxycmdJmbI95wKknF/JG0yyuTdAHNoTcyiYEqhXN?=
 =?us-ascii?Q?tb744aMfjACXFXHoi3MsqgQyW2zeSWI/IBXpCqicBZMdWVaIYnwtljzyhr1v?=
 =?us-ascii?Q?Vq3LCmFUM6bilT76XbxLdWfASmNn9r8jyORRPLudiCzRWfsa0E7fqEJMOuiw?=
 =?us-ascii?Q?fEKqUETAYkGgCOdLz24=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3571e1-49e8-447e-9bc3-08da812bff4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 15:11:59.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkfH0RzbAGyBsmH6vB3lVFX02/3H8nBJqLd4guCGnDojM1Q04++41APZY51kil+1urPKigX8hmzttHCVSF436w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 0000000000000..110e5df1d6aa8
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

