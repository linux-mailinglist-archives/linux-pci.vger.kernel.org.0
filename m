Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CF75E6827
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiIVQNy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiIVQNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:13:47 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B22C11A;
        Thu, 22 Sep 2022 09:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJVWZfSHIB7jMsUf/vJxp+Nb165ccSAOQiqD4QqDDBYvIO6h1rAVptCypFPYlyc9Sfhl+qqKrtcUmTw7JbcnsunLy3mCpGhkxEaDOiQaDtUQ1tSqHONc3JV3LcTVMV+95+Ocm5z8olIudZTBXyauZpE7eK6ex6Wsdwd91vBnUeFOPBzmtOtHqnoPQpsqUf/NzTMUnVXzaXk5gmOf5B6fLJmg5ohHC5WxV4q+cPPa3HqNNPj2UhArYXQL+ax8mRGllXiPdkvr9vACnc7rLT3fVlWL6QuS+N0JDSJELY216gGvjU7Ra/uP3Kae66V4kDcQErREH4djV9JP+NMDnpcwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4HRMT8VBwUQPFzZjEB0zfcN9N4fLgSj3bCnIo7hLnE=;
 b=j9bx4Mg00eehz1O4+BQIvIiTQYXBm0gjzjHkDYftGJnsE8+YdwtD7GTvj7nKZY6beQTHZcMdH1gSvPCZDj8C8Ibm/z3yWDqNVwLlLQzm7DAtKuLiB4/fI+1ZbQp/8Ug7/C9dJUPdab5IWej6nZ6CO1HJ7PlvVQ8CHQrOUfuINqbmS6VqpCF5DYzFDvPp1hh/IclZBmRHX4FUJptcofu/jj4V/bIw+aUWmWBQV8zU2aw9HW/KBbeVWZqQR1js/aEnS1+NIxcYYBh4xNMIZzD90Zmo9Gxu0WREpd3HAY05X974ZcvjL9W4m1WeiTBPCTqk4a4yflzGjI1sO2wELm3aMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4HRMT8VBwUQPFzZjEB0zfcN9N4fLgSj3bCnIo7hLnE=;
 b=pf/QvUJp4OuKZcNo4GzgzIlltpnFVXU66B82AlpB3B8Ou9P8jjJtstuxgsoN42MG0gNTvs/GdZ3GgyEQ8oEHRf9xy1kSSvS2rp47w7aWXDXkrQfHnDaecn+X66kSbh54EjLkkA8w1Rhg07892kInHdIBDjlGoqCoPXreQ/Dr3O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 16:13:42 +0000
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428]) by DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:13:42 +0000
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
Subject: [PATCH v12 3/6] irqchip: Add IMX MU MSI controller driver
Date:   Thu, 22 Sep 2022 11:12:43 -0500
Message-Id: <20220922161246.20586-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922161246.20586-1-Frank.Li@nxp.com>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8789:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: a8df3b00-8e72-4aa8-0e7e-08da9cb56ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HItvM81GG5arGYsqwB1zY2juJtP4CD5nvebT8vCDCKPXN1wfitkB17KD6jSgQHf0pjxuipDHbBI2kZUbYn9ipv0wos4B86LC3ifWXsVtNDX21AtZMbOsb5Truu+ReM0dmIsv0yOtVYVGEo0FhsqvWZP4VDGAeXcjkOFTEpPZ66Jg7glv88Ia1F68loTbkNhtt11rkIWQ/hXqL1/mNjery7Oh3R0QHjbDdUNmBMvCOGTYJoDJ4IJ4qmWNJ4ItW0yYEhMOeJqSF4caijSmR9qMYTIflrO4ydHyPB2IO/s4jbYcM3zRdHb2N12WRsvL5Z5QuEf2DIjKJTz/lWPSAl0RurKFb3bD/BFbqisLlSkviw1U+MxrUJZ58UaVFVjVYQBV7B7EO+zW1vNL9XCW6tgH3JDOPn3XEIR47EOvmZA7cgqYrUxxAntAvsFPuSh92IObxQJBV5YMJ123bWoU34tmrfxHaDg/d1uV7Ysfdkh4SbU48vYDWA7VzYB3o7F/RyjwMREbtgkm+dxRJS9RIYzdKVxfdBeGvDhIBt9JzZRbXDY6/PTIz1uIqGHvqlaqfz4+3jb5Mv/7q3F7vNo+62xp8yZ/S1tIJCQjGGQ4GOX0Lbu2FKsNkn2SOTbLY0hII1GcPS2LTJROuPy755lN/T3CpWxSd4lqA+vD0SG/2ySuh7Wr0KTtpWbKuZZ6bxAcURs4M2RAwAmawT3garnePTDhF4+xhqtrnqUUtCe5Otp3uVR8xE+PiutmOggiP4Hfqqb45Ujj646pusbdf74SxnHHjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8789.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(83380400001)(1076003)(2616005)(6512007)(186003)(38100700002)(52116002)(66556008)(30864003)(38350700002)(66476007)(8936002)(5660300002)(41300700001)(478600001)(2906002)(6506007)(6486002)(26005)(7416002)(66946007)(4326008)(8676002)(36756003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9dIMOeuTZjnB2ulLWaZEHFhwknpeaVq68XJs71id7X/eh3+QMTRUqNsJ3beF?=
 =?us-ascii?Q?5FFL5ux+t6FMBMTuwfHczWE+xucP8ZAt4aNOC8FiuQUoHUgQUbFrxMIdbZrU?=
 =?us-ascii?Q?mGQt7r7qG+yKHLUkW1ZSGuhrOoA/K6wyLqTJC0OsGNCxfws6rbUHEmOWVIEs?=
 =?us-ascii?Q?r11Zwh67esvupDmX6QOZ3mosQd9yG4+1yoBQEqR7Z1wPLa7S5ptxpHkcwsay?=
 =?us-ascii?Q?upCIOdufA/999uRu0pSaHG4ovukgRv8exOspiMkzL5DkKzIYwNf7CrJixaUK?=
 =?us-ascii?Q?u8Wfn+nkcSsJJFdQxHUAWQOFQghgRsgYYFYtQjfoh0oe9A3uZnWJJN3APcDd?=
 =?us-ascii?Q?xZEzC4tce4O47WkX/k21ssoP4IOhGeFQZpsq0p0w7eVsJumhmz8BdXDKfflE?=
 =?us-ascii?Q?2Cz88nKikNFkphjPx55geoYSAkxALPL5o7TJ39caoQU7RTPUFr4KQQtykuBk?=
 =?us-ascii?Q?wx237fujS2Hm0fzv3fkvXjfeZQAmv7o8LgKyLSguLjf+d8Sjv0QEarfhppno?=
 =?us-ascii?Q?HWUZfKdUdloSJS5q/PKcxtbvs1fSyWX5sarzQtE/6qI3jBjrnb5N7ireuXoW?=
 =?us-ascii?Q?2IDTiJRD6Rw8Iy8bLf92bawaMSYnp3Q1c/aeXI6Dd5AWTgAdaQwq7T+lsbR6?=
 =?us-ascii?Q?Rg4HGg6nHsDSQDU1iOOJaApMk7uKyllG8e44LchBhNVov6hXGSEdzTNgOau5?=
 =?us-ascii?Q?jsA09Ese5r6qs8/90jlpOGX39HR8pzr76/KgeFx2RbCsD3FGCBUZndmkUl8n?=
 =?us-ascii?Q?2LcfqSYcfTzJufcpXvGh6Dkv84Xme4V5HqB2u97n1U+/r49091mE2qY9ixhY?=
 =?us-ascii?Q?jGNkz+F5BAPV3jSwVqwlJU5GgwwX1B6l/cN5Nyd6ROulOd+MjyDaWhsJNg0n?=
 =?us-ascii?Q?HYymQG7BEuNR+4lJJjpG+0i9+rIZ6uXey1OVjySWgAJyLltI6/nT88ytvcti?=
 =?us-ascii?Q?wBQeOdUGiUhVQ7xkyAqtREcVhTKoOA8jyqYKXeSGZpUc0rzL0dnaa6vH+eLK?=
 =?us-ascii?Q?lv/4T/6gMQMmdtHPXrqGqXCtmaHRfnA6DKTahYNMziVghb/hydiy001FEgVf?=
 =?us-ascii?Q?LJN4ixQE/9cj5t7ux9T760hpVvyOVvWAnAUVDYCBdE8sm4xII6khehv69UaV?=
 =?us-ascii?Q?qyrMF29RacNVQBvk5issquixfrIVBQPifjXvnaWqxA9QZXHdffybKulEt4lY?=
 =?us-ascii?Q?VhUnqRu0pPrOyru4myWdXjjHIq6eMHLIt1fs8aW/6JdLSKCN7S+A0S0Hi1Uw?=
 =?us-ascii?Q?CvH4CoAoSWcPZ4UFZs1mOGHwJfiqH7yKHYPOloZOjNddTafUsqO5s3TRkvCY?=
 =?us-ascii?Q?oix5LsZssi8LT1jqLkQI5jqKXj/ARUwaYViGQlkE0O/hmmuy5VUGe19xKHpV?=
 =?us-ascii?Q?AcgmB9OZWUxZ3T60kwbba6Ck6C++qVj7KJDtC+mICoxlgahuTzeaEde2LtP6?=
 =?us-ascii?Q?aeugVyIc2PsYgK3fuu6QR3Naq0Cx6Vj5LM9XBGJLj8t5p5VHZxXj9TR0PNQg?=
 =?us-ascii?Q?UzuBhf3d9iCVIOUwT9g6YuVWQrmUqMmF2tnDUrkLccyfug+PeIU+EfnrVSOW?=
 =?us-ascii?Q?7uj5Xq8laikoIOgkyZAaqRb/eCSslbAZlsv7sjzN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8df3b00-8e72-4aa8-0e7e-08da9cb56ad6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8789.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:13:42.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yqPakgEbAho/6LrcE8BTVAmEivIu/L9ls6oeypoo4KHMSam+eAo0+YBCOw0AoF1eCf0443OOGs2hwxSG4L10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

