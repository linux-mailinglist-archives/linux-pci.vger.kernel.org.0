Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23957BF99
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiGTVbS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiGTVbQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:31:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C8F32EE9;
        Wed, 20 Jul 2022 14:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X90R6p9JEMMhLKacNu369y/ZOdCwX/2naelsum9C3ecvAZlwrQR3XiqNRrPye+vdyMbyjBzgFqBjnKCwm/aBlIzzkrZvt/QCd/5x8YsMsnH7Ir6OpOVmS7TFCj3E9XMZkYZXRK9wdVFcs4ktouC+oOSAKQpQ2A+A7O/93lwfS0vvPFrCeSdzWJeEdxiE4LcQMuV150tgxX9cWH+EoWYeMfdVtap+BpSQyqHJt95J0LGmgH9NB5j8PWun8W/WkEA7582ke7d2+Vr4LxB5+Y7mdZTED6iJSNCMl5H1m8Pgr6dpqsvvIv27YpaWmuDFjlNFvKRTRMxpeSMrYF9l96xJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asF68cMe4bNr/uSmcUlFQoSaQguF0PwRWXCflrxEx8I=;
 b=QFdOBkiVOpfSf3YFRyAwjfxG0PTAkGDtsfgD2dJd+DetSMzz4dw+jLiPqCVGvdsqcSb8Y7BKMxLJdDPvJJ9+W1hqco2LbYpyifJ2YhAIlkGKVjuDTjpPKZJjybrsNTC1uYnbYJViDTxkJfGwuX88dUZcLIx++Txm5aV2Qitvg/NRQQ0vSgzq3BAmXamgE7DZMv9gmNOMU3SsG8uK6fWmDXRb5/yoHq9qZAObOswtv4BCHtKZL7ggMsY2lHsfKChl0x+hrci6URzlD9ZRjsfKxUGNhOcBu1y5ShNegFPc8mAs+EUde631hsCFI1EnBk653OL8PviGZnP6P6WwO9B8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asF68cMe4bNr/uSmcUlFQoSaQguF0PwRWXCflrxEx8I=;
 b=BPEpGnf7MBXl/eE20N2ZI5MKxEdhpcKRTjuT90fDbPou+6xkxUqy75d6t3byee4516cavNdEPkM7w3+kH8wzFEggkXc+q9YrFJOF4rjdGQda6FWCHUtm+6tEsh1JwWt5Rf9sRxD8c9mMsUkZ6SDttYjUwrgjqR6BiAL7TSZQq9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5409.eurprd04.prod.outlook.com (2603:10a6:208:120::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 21:31:08 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%9]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 21:31:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     jdmason@kudzu.us, maz@kernel.org, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com,
        bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH v3 2/4] irqchip: imx mu worked as msi controller
Date:   Wed, 20 Jul 2022 16:30:34 -0500
Message-Id: <20220720213036.1738628-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720213036.1738628-1-Frank.Li@nxp.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6950f99c-3c55-437b-032c-08da6a972899
X-MS-TrafficTypeDiagnostic: AM0PR04MB5409:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtM356TK5IG7oeDak7/nc1UpOPfk9DrH0RbR7wxtqP/MS8DmjFh8cJUilQEw+lcXvtbh9J/ewsMmKXUIQYQFW4SlAQd+GUU2fb3h5M0Temw42XyTA/+ydM5qAeuUpHH3OvGQiXOVOVpbj99dK7Y48jV1FgA4EKGeROA6TJ22tRbzah66I4UcmToDnwF5o265TX2e3fLG+vHSE4Z1EZKUs1VQ/X/I5F4HWGSp6W7sUfAkGqNm2Q2tLycEdN0UZ0SlaVz6jaAz1zFaGCFSBGKYW3nfm8AyXwGiblDLcbjp1KWrWX6eAzZJmXmjrALNx3v2pj7TwJEKRznSN4redw4WjHxP7aWAqGvH7t3ChbAzyuE6aOVpqYNm8+NfFgvw2lM/g+TPj164EkdQ16vG6Nxuk9+sBAk+EJUcUJPXc3aNUBT0JHgZ61y0q7QlMFClXsRA2nNmpoZLOmjuYTHMmJ+NRAJdhG4Gdeu+cnXp/k9x0Djaes2EgseV/g7TsNUc6WwCJh9EpG5z7Dws+Aib7gQTbnnEKiFUCG+ZYp7FoTCmL53VkNex8+K9OJKR2eiI1DNnZDkYvZjVZzb65pE4Bup5PFYR2/T9E0FwJkVYA6XLZ31cPBe8cDeL5B279vY3BgM5Qsxoeih8YbgWZsho9ZdT2uKURrgUvK9ySoB61wercinjnys1Ayx6BkpsvU4Xm2JtKgAXjkppIdJ7METIsMeDvFzMlWMq3IskcHRlFLUuJOyvIzv3QvSQZbfxyCnVOIdyyT0GuRBXGe/TFXG1/aiYppHX4LUZQ009ozOzmBKgTQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(38350700002)(6486002)(83380400001)(6666004)(52116002)(478600001)(41300700001)(2616005)(36756003)(6512007)(186003)(1076003)(8676002)(30864003)(7416002)(66476007)(6506007)(66556008)(5660300002)(2906002)(4326008)(8936002)(66946007)(26005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5dVs5Xmh3oVLaay/VDQQAmLXJDci0BSAIjiYJGPyAHRCIUpmd+e6t6fEv5Uc?=
 =?us-ascii?Q?4KYicvYz2G5959ParwfuQmdFh3aGjJaRSeY+bGWsraMku17B2PMPQTMfzG6w?=
 =?us-ascii?Q?Ud7afANpsFYmxOS/dI77AQEpaMgfIM6jZjRLPxjfXpbhzxIYJEe7vvF+s7T0?=
 =?us-ascii?Q?7l/cPU6y74RInkIFAuvRsCHX2MSXhyQCtz5Lk5eUMtzl5ucFrRfgyGMI+Sqe?=
 =?us-ascii?Q?SY//IUDs8x0VNCcfpmqhvNv2pljiUQTWuRER/KJSReGYQZcSh3MUPEHdITmE?=
 =?us-ascii?Q?83uUWJS9uFe/XhoSQtQdIlSQYAkw9iwSVU1f4BWqQoGrx+oIU8sYwMOrbAwY?=
 =?us-ascii?Q?XDI3HVCyJhMGfswxvrfAiKIdnfuXUMb7tJxUPY3PyzMelzUnKPMIl3UF6Tis?=
 =?us-ascii?Q?vn5bqSYn8hrHLUPPFICUcOxqiyrL0LHFPvR+PlqleYbi00UA+UgHVhkPfI1c?=
 =?us-ascii?Q?9qrPgnTBzaEWKgQC4fYGM/PlVK9xMBlN9vQ1QImIfgn0PIv7PMX8eKcDFN5p?=
 =?us-ascii?Q?BIKb3IzdalKluO2O+KC6HMFe/4VUbptWAaj25UKoz6/QGxA7ICuzrqS7SJu4?=
 =?us-ascii?Q?t9+5E9K9nsQFYZ/Ptw4NmOWb7Hhu4rRAPFUKx9xop8ZBbOlsuT3Mwpxkz6kI?=
 =?us-ascii?Q?t8VvntNPZNS1ndv516kqvZyk39kGZSZcMXSO5k6Vjb9XBogzpL4IEkWCfeLn?=
 =?us-ascii?Q?GtdAO2Ax0eiduGDiPefSs1cm7u+ZWGHY9Tukifzcy4Fr0XA1qVKHQX6fdGAW?=
 =?us-ascii?Q?OREWwN5kFWPtOJQcbEq3JtlZAER/C6GdQyrtv2OaVhBKB+jLqGZt1SFBPpP3?=
 =?us-ascii?Q?70tTYb40lWAd3XsSfyz+18OpVI1eAgtdj6aJ54g6Kr/zOyO7vk/Jgte5WqSL?=
 =?us-ascii?Q?TeKQueXVb3FM7oqz51MMc3oCSbM4etxxmLKKX+1ySF7wey9ZoDSfM6LbI3OU?=
 =?us-ascii?Q?0LG8CcSDEr0PbR8qsIrbUcBX0u64MbPYQqcVLOZR9wIJfJsdNHFwEgPNI81B?=
 =?us-ascii?Q?P9K3pmfoQV8WIWD+VhZb/evzihXaOCDJYWvRb8e5OMnJweHxPlGwLr7He9JA?=
 =?us-ascii?Q?9FL4dx0+w1vHQoUszF8LfPOujB62AHTjkEiYPNWVJCI1sIQP2p4vkNAhjLre?=
 =?us-ascii?Q?SKjhTFTtHh8HRQMm+++oxBJjR1yu28bE+uPez3bwiHceQqAZV8jZXvgygrAe?=
 =?us-ascii?Q?QmhOmT8z85XjDqu8LItnx9Dy8xVYdrMR3VyE+SNks35Zom73N0ZNfKVRWdIw?=
 =?us-ascii?Q?5JKkOiej5X8OWuR3jGhZqcLFxxrZ1aY8EttrxQnBQU7Z3+0kuWdaTSBr+gt+?=
 =?us-ascii?Q?CNN0cnAqqltWUt/TtCZe5m7b+6E2awrBwOOZaRSR9eXm24kjAmZ/S8IKV2Q8?=
 =?us-ascii?Q?rr24kh2RJ22i2VlJ1GeXsY5B6Pl6NV2FWpENgb66R3dGOX6VxbcQfBex8bsH?=
 =?us-ascii?Q?c9NfCb/+q22eDiRWxsiDKbj4mJS8629TKW9+B9xwLX+XJ4GX3Lr8jGW/uHIt?=
 =?us-ascii?Q?xaL10hP5oja1K+u8JJmFA47ULryevkzMaKFcfqNQDq5WXG9/lh9VUjqgnoY9?=
 =?us-ascii?Q?7RFEs7VbdF26rAfZ+cs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6950f99c-3c55-437b-032c-08da6a972899
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 21:31:08.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSMRX0KGA82qK0CkHUYRwIDcIv20kO3ubyAjlBpJjowQ2Uq5L7G7Az2ioo8if1d9Dz7BuDskuwli4zET48BUYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/irqchip/irq-imx-mu-msi.c | 462 +++++++++++++++++++++++++++++++
 3 files changed, 470 insertions(+)
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
index 0000000000000..8277dba857759
--- /dev/null
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -0,0 +1,462 @@
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
+	spinlock_t			lock;
+	struct platform_device		*pdev;
+	struct irq_domain		*parent;
+	struct irq_domain		*msi_domain;
+	void __iomem			*regs;
+	phys_addr_t			msiir_addr;
+	const struct imx_mu_dcfg	*cfg;
+	unsigned long			used;
+	u32				gic_irq;
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
+static void imx_mu_msi_mask_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data->parent_data);
+
+	imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq));
+}
+
+static void imx_mu_msi_unmask_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data->parent_data);
+
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
+	WARN_ON(nr_irqs != 1);
+
+	spin_lock(&msi_data->lock);
+	pos = find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
+	if (pos < IMX_MU_CHANS)
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
+
+	spin_lock(&msi_data->lock);
+	__clear_bit(d->hwirq, &msi_data->used);
+	spin_unlock(&msi_data->lock);
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
+	msi_data->parent = irq_domain_add_linear(dev_of_node(&msi_data->pdev->dev),
+						 IMX_MU_CHANS,
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
+	irq_domain_set_pm_device(msi_data->parent, &msi_data->pdev->dev);
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

