Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF64E8BFC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 04:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiC1CQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiC1CQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 22:16:42 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F411C07
        for <linux-pci@vger.kernel.org>; Sun, 27 Mar 2022 19:15:01 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220328021459epoutp02925a8d325bf7a4c1baf77b064460e3db~gabcxHNNA1221212212epoutp02W
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 02:14:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220328021459epoutp02925a8d325bf7a4c1baf77b064460e3db~gabcxHNNA1221212212epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648433699;
        bh=RKA1BEHxq4eI/x9Il/yUbT598ogAY9m236ZMarS8cRY=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=u2l1iOK84LKN+oXIpP1/IBxUkCCoU9Tuis6oZaXDl6QR2CgIL7nIoqBLz8R5bAqNA
         q+X7yVrCSyqr2oHfLFIPvsVhaeuJrWAwQFyEYmprPG3Whjjgth+5mTGwe+7i1FTZOg
         AZuAg4k+eelcu377mpPU3ISVl+sjJhETWO3XeMhQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220328021458epcas2p172b4656435ff489876212ec7c63911aa~gabb-fxZc0856508565epcas2p1I;
        Mon, 28 Mar 2022 02:14:58 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KRbqx5tlRz4x9QT; Mon, 28 Mar
        2022 02:14:53 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-a5-62411a1d4abf
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.38.25540.D1A11426; Mon, 28 Mar 2022 11:14:53 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220328021453epcms2p15977e72b6c96253ecaefcb71e6d2acfe@epcms2p1>
Date:   Mon, 28 Mar 2022 11:14:53 +0900
X-CMS-MailID: 20220328021453epcms2p15977e72b6c96253ecaefcb71e6d2acfe
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmha6slGOSwbKLkhZLmjIsXh7StJh/
        5ByrxfNDs5gtPrWoWlx42sNm8XLWPTaLhp7frBZH3nxktth/fCWTxeVdc9gszs47zmYxYdU3
        Fos3v1+wW5xbnGnRuvcIu8XOOyeYHQQ91sxbw+hxfV2Ax4JNpR6bVnWyeTy5Mp3JY/OSeo++
        LasYPY7f2M7k8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
        qq2Si0+ArltmDtAXSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8
        dL281BIrQwMDI1OgwoTsjB2bdrEU3L/PWHFgSi97A2PXLsYuRg4OCQETiZU9NV2MXBxCAjsY
        Jd50PmYBifMKCEr83SHcxcjJISzgLHF16gM2EFtIQElix5p5zBBxa4lPUy6zgNhsApYSF1sf
        MoLMERE4yyRx8+52VhCHWeA2s8T85+/BqiQEeCVmtD+FsqUlti/fyghha0j8WNbLDGGLStxc
        /ZYdxn5/bD5UjYhE672zUDWCEg9+7oaKS0kseHKIFcKultj/9zcThN3AKNF/PxXiSX2JHdeN
        QcK8Ar4SsxfNBithEVCV2DOxFarcRaKxexnYSGYBeYntb+cwg7QyC2hKrN+lDzFFWeLILbhH
        Gjb+ZkdnMwvwSXQc/gsX3zHvCdR0NYl5K3cyQ4yRkdj60n8Co9IsRDjPQrJ2FsLaBYzMqxjF
        UguKc9NTi40KjOFxm5yfu4kRnJ613Hcwznj7Qe8QIxMH4yFGCQ5mJRFe2bP2SUK8KYmVValF
        +fFFpTmpxYcYTYEensgsJZqcD8wQeSXxhiaWBiZmZobmRqYG5krivF4pGxKFBNITS1KzU1ML
        Uotg+pg4OKUamFYHPNnFqu1tso63wJWJd8W79Zy3A1ZzHAhw7f38WZj3z3z7WI5rKz0OtV5Z
        /9vVX2xVTnnMXsf7Wj8W7rHY9WjZ0ypRzcxN1xTmFl7+taxmZ8qnqSz1vlzLmmOniy1vDS1f
        bfNt1dK2E40pzH/01zJ9Ov2nLGfzdFv7AM0/19fPUvkZXXTnBHeRuuoftbWJSVJnVEpOiBva
        +X8yu754Oue20kphyalXZ924dqv73vXVfSEJ2wQVb+/krPn2XfoE2+qVXK/m3jo/59nhr68v
        bGJ85H/YW1NX9vLBbQb7Pbfkemhq5/2pkZyV+eHA/rmak1+GOu6YuqLJxjrovmyOY5jfvZIQ
        AWOXcLMdcw8ePC6sxFKckWioxVxUnAgAzSLknVgEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328021453epcms2p15977e72b6c96253ecaefcb71e6d2acfe
References: <CGME20220328021453epcms2p15977e72b6c96253ecaefcb71e6d2acfe@epcms2p1>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support Axis, ARTPEC-8 SoC.
ARTPEC-8 is the SoC platform of Axis Communications.
This is based on arm64 and support GEN4 & 2lane.
This PCIe controller is based on DesignWare Hardware core
and uses DesignWare core functions to implement the driver.
This is based on driver/pci/controller/dwc/pci-exynos.c

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
 drivers/pci/controller/dwc/Kconfig        |  31 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-artpec8.c | 912 ++++++++++++++++++++++++++++++
 3 files changed, 944 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3ab..668e346 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -222,6 +222,37 @@ config PCIE_ARTPEC6_EP
 	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
 	  endpoint mode. This uses the DesignWare core.
 
+config PCIE_ARTPEC8
+	bool "Axis ARTPEC-8 PCIe controller"
+
+config PCIE_ARTPEC8_HOST
+	bool "Axis ARTPEC-8 PCIe controller Host Mode"
+	depends on ARCH_ARTPEC
+	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_ENDPOINT
+	select PCI_EPF_TEST
+	select PCIE_DW_HOST
+	select PCIE_ARTPEC8
+	help
+	  Say 'Y' here to enable support for the PCIe controller in the
+	  ARTPEC-8 SoC to work in host mode.
+	  This PCIe controller is based on DesignWare Hardware core.
+	  And uses DesignWare core functions to implement the driver.
+
+config PCIE_ARTPEC8_EP
+	bool "Axis ARTPEC-8 PCIe controller Endpoint Mode"
+	depends on ARCH_ARTPEC
+	depends on PCI_ENDPOINT
+	depends on PCI_ENDPOINT_CONFIGFS
+	select PCI_EPF_TEST
+	select PCIE_DW_EP
+	select PCIE_ARTPEC8
+	help
+	  Say 'Y' here to enable support for the PCIe controller in the
+	  ARTPEC-8 SoC to work in endpoint mode.
+	  This PCIe controller is based on DesignWare Hardware core.
+	  And uses DesignWare core functions to implement the driver.
+
 config PCIE_ROCKCHIP_DW_HOST
 	bool "Rockchip DesignWare PCIe controller"
 	select PCIE_DW
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 8ba7b67..b361022 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
+obj-$(CONFIG_PCIE_ARTPEC8) += pcie-artpec8.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-artpec8.c b/drivers/pci/controller/dwc/pcie-artpec8.c
new file mode 100644
index 0000000..559b545
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-artpec8.c
@@ -0,0 +1,912 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe controller driver for Axis ARTPEC-8 SoC
+ *
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Author: Jaeho Cho <jaeho79.cho@samsung.com>
+ * This file is based on driver/pci/controller/dwc/pci-exynos.c
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+#include <linux/phy/phy.h>
+
+#include "pcie-designware.h"
+
+#define to_artpec8_pcie(x)	dev_get_drvdata((x)->dev)
+
+/* Gen3 Control Register */
+#define PCIE_GEN3_RELATED_OFF		0x890
+/* Disables equilzation feature */
+#define PCIE_GEN3_EQUALIZATION_DISABLE	(0x1 << 16)
+#define PCIE_GEN3_EQ_PHASE_2_3		(0x1 << 9)
+#define PCIE_GEN3_RXEQ_PH01_EN		(0x1 << 12)
+#define PCIE_GEN3_RXEQ_RGRDLESS_RXTS	(0x1 << 13)
+
+#define FAST_LINK_MODE			(7)
+
+/* PCIe ELBI registers */
+#define PCIE_IRQ0_STS			0x000
+#define PCIE_IRQ1_STS			0x004
+#define PCIE_IRQ2_STS			0x008
+#define PCIE_IRQ5_STS			0x00C
+#define PCIE_IRQ0_EN			0x010
+#define PCIE_IRQ1_EN			0x014
+#define PCIE_IRQ2_EN			0x018
+#define PCIE_IRQ5_EN			0x01C
+#define IRQ_MSI_ENABLE			BIT(20)
+#define PCIE_APP_LTSSM_ENABLE		0x054
+#define PCIE_ELBI_LTSSM_ENABLE		0x1
+#define PCIE_ELBI_CXPL_DEBUG_00_31	0x2C8
+#define PCIE_ELBI_CXPL_DEBUG_32_63	0x2CC
+#define PCIE_ELBI_SMLH_LINK_UP		BIT(4)
+#define PCIE_ARTPEC8_DEVICE_TYPE	0x080
+#define DEVICE_TYPE_EP			0x0
+#define DEVICE_TYPE_LEG_EP		0x1
+#define DEVICE_TYPE_RC			0x4
+#define PCIE_ELBI_SLV_AWMISC		0x828
+#define PCIE_ELBI_SLV_ARMISC		0x820
+#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
+#define LTSSM_STATE_MASK		0x3f
+#define LTSSM_STATE_L0			0x11
+
+/* FSYS SYSREG Offsets */
+#define FSYS_PCIE_CON			0x424
+#define PCIE_PERSTN			BIT(5)
+#define FSYS_PCIE_DBI_ADDR_CON		0x428
+#define FSYS_PCIE_DBI_ADDR_OVR_CDM	0x00
+#define FSYS_PCIE_DBI_ADDR_OVR_SHADOW	0x12
+#define FSYS_PCIE_DBI_ADDR_OVR_ATU	0x36
+
+/* PMU SYSCON Offsets */
+#define PMU_SYSCON_PCIE_ISOLATION	0x3200
+
+/* BUS P/S SYSCON Offsets */
+#define BUS_SYSCON_BUS_PATH_ENABLE	0x0
+
+int artpec8_pcie_dbi_addr_con[] = {
+	FSYS_PCIE_DBI_ADDR_CON
+};
+
+struct artpec8_pcie {
+	struct dw_pcie			*pci;
+	struct clk			*pipe_clk;
+	struct clk			*dbi_clk;
+	struct clk			*mstr_clk;
+	struct clk			*slv_clk;
+	const struct artpec8_pcie_pdata	*pdata;
+	void __iomem *elbi_base;
+	struct regmap *sysreg;
+	struct regmap *pmu_syscon;
+	struct regmap *bus_s_syscon;
+	struct regmap *bus_p_syscon;
+	enum dw_pcie_device_mode	mode;
+	int link_id;
+	/* For Generic PHY Framework */
+	struct phy			*phy;
+};
+
+struct artpec8_pcie_res_ops {
+	int (*get_mem_resources)(struct platform_device *pdev,
+				 struct artpec8_pcie *artpec8_ctrl);
+	int (*get_clk_resources)(struct platform_device *pdev,
+				 struct artpec8_pcie *artpec8_ctrl);
+	int (*init_clk_resources)(struct artpec8_pcie *artpec8_ctrl);
+	void (*deinit_clk_resources)(struct artpec8_pcie *artpec8_ctrl);
+};
+
+struct artpec8_pcie_pdata {
+	const struct dw_pcie_ops	*dwc_ops;
+	struct dw_pcie_host_ops		*host_ops;
+	const struct artpec8_pcie_res_ops	*res_ops;
+	enum dw_pcie_device_mode	mode;
+};
+
+enum artpec8_pcie_isolation {
+	PCIE_CLEAR_ISOLATION = 0,
+	PCIE_SET_ISOLATION = 1
+};
+
+enum artpec8_pcie_reg_bit {
+	PCIE_REG_BIT_LOW = 0,
+	PCIE_REG_BIT_HIGH = 1
+};
+
+static void artpec8_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size, u32 val);
+static u32 artpec8_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size);
+static void artpec8_pcie_writel(void __iomem *base, u32 val, u32 reg);
+
+static int artpec8_pcie_get_subsystem_resources(struct platform_device *pdev,
+					struct artpec8_pcie *artpec8_ctrl)
+{
+	struct dw_pcie *pci = artpec8_ctrl->pci;
+	struct device *dev = pci->dev;
+	struct resource *res;
+
+	/* External Local Bus interface(ELBI) Register */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
+	artpec8_ctrl->elbi_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(artpec8_ctrl->elbi_base)) {
+		dev_err(dev, "failed to map elbi_base\n");
+		return PTR_ERR(artpec8_ctrl->elbi_base);
+	}
+
+	/* fsys sysreg regmap handle, need to change using smc */
+	artpec8_ctrl->sysreg =
+		syscon_regmap_lookup_by_phandle(dev->of_node,
+			"samsung,fsys-sysreg");
+	if (IS_ERR(artpec8_ctrl->sysreg)) {
+		dev_err(dev, "fsys sysreg regmap lookup failed.\n");
+		return PTR_ERR(artpec8_ctrl->sysreg);
+	}
+
+	/* pmu syscon regmap handle, need to change using smc */
+	artpec8_ctrl->pmu_syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
+			"samsung,syscon-phandle");
+	if (IS_ERR(artpec8_ctrl->pmu_syscon)) {
+		dev_err(dev, "pmu syscon regmap lookup failed.\n");
+		return PTR_ERR(artpec8_ctrl->pmu_syscon);
+	}
+
+	/* bus s syscon regmap handle, need to change using smc */
+	artpec8_ctrl->bus_s_syscon =
+		syscon_regmap_lookup_by_phandle(dev->of_node,
+			"samsung,syscon-bus-s-fsys");
+	if (IS_ERR(artpec8_ctrl->bus_s_syscon)) {
+		dev_err(dev, "bus_s_syscon regmap lookup failed.\n");
+		return PTR_ERR(artpec8_ctrl->bus_s_syscon);
+	}
+
+	/* bus p syscon regmap handle, need to change using smc */
+	artpec8_ctrl->bus_p_syscon =
+		syscon_regmap_lookup_by_phandle(dev->of_node,
+			"samsung,syscon-bus-p-fsys");
+	if (IS_ERR(artpec8_ctrl->bus_p_syscon)) {
+		dev_err(dev, "bus_p_syscon regmap lookup failed.\n");
+		return PTR_ERR(artpec8_ctrl->bus_p_syscon);
+	}
+
+	return 0;
+}
+
+static int artpec8_pcie_get_rc_mem_resources(struct platform_device *pdev,
+					     struct artpec8_pcie *artpec8_ctrl)
+{
+	struct dw_pcie *pci = artpec8_ctrl->pci;
+	struct device *dev = pci->dev;
+	struct resource *res;
+
+	/* Data Bus Interface(DBI) Register */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	pci->dbi_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pci->dbi_base)) {
+		dev_err(dev, "failed to map dbi_base\n");
+		return PTR_ERR(pci->dbi_base);
+	}
+
+	return 0;
+}
+
+static int artpec8_pcie_get_ep_mem_resources(struct platform_device *pdev,
+					  struct artpec8_pcie *artpec8_ctrl)
+{
+	struct dw_pcie_ep *ep;
+	struct dw_pcie *pci = artpec8_ctrl->pci;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	ep = &pci->ep;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	pci->dbi_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pci->dbi_base)) {
+		dev_err(dev, "failed to map ep_dbics\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
+	pci->dbi_base2 = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pci->dbi_base2)) {
+		dev_err(dev, "failed to map ep_dbics2\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+
+	return 0;
+}
+
+static int artpec8_pcie_get_clk_resources(struct platform_device *pdev,
+				       struct artpec8_pcie *artpec8_ctrl)
+{
+	struct device *dev = &pdev->dev;
+
+	artpec8_ctrl->pipe_clk = devm_clk_get(dev, "pipe_clk");
+	if (IS_ERR(artpec8_ctrl->pipe_clk)) {
+		dev_err(dev, "couldn't get pipe clock\n");
+		return -EINVAL;
+	}
+
+	artpec8_ctrl->dbi_clk = devm_clk_get(dev, "dbi_clk");
+	if (IS_ERR(artpec8_ctrl->dbi_clk)) {
+		dev_info(dev, "couldn't get dbi clk\n");
+		return -EINVAL;
+	}
+
+	artpec8_ctrl->slv_clk = devm_clk_get(dev, "slv_clk");
+	if (IS_ERR(artpec8_ctrl->slv_clk)) {
+		dev_err(dev, "couldn't get slave clock\n");
+		return -EINVAL;
+	}
+
+	artpec8_ctrl->mstr_clk = devm_clk_get(dev, "mstr_clk");
+	if (IS_ERR(artpec8_ctrl->mstr_clk)) {
+		dev_info(dev, "couldn't get master clk\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int artpec8_pcie_init_clk_resources(struct artpec8_pcie *artpec8_ctrl)
+{
+	clk_prepare_enable(artpec8_ctrl->pipe_clk);
+	clk_prepare_enable(artpec8_ctrl->dbi_clk);
+	clk_prepare_enable(artpec8_ctrl->mstr_clk);
+	clk_prepare_enable(artpec8_ctrl->slv_clk);
+
+	return 0;
+}
+
+static void artpec8_pcie_deinit_clk_resources(struct artpec8_pcie *artpec8_ctrl)
+{
+	clk_disable_unprepare(artpec8_ctrl->slv_clk);
+	clk_disable_unprepare(artpec8_ctrl->mstr_clk);
+	clk_disable_unprepare(artpec8_ctrl->dbi_clk);
+	clk_disable_unprepare(artpec8_ctrl->pipe_clk);
+}
+
+static const struct artpec8_pcie_res_ops artpec8_pcie_rc_res_ops = {
+	.get_mem_resources	= artpec8_pcie_get_rc_mem_resources,
+	.get_clk_resources	= artpec8_pcie_get_clk_resources,
+	.init_clk_resources	= artpec8_pcie_init_clk_resources,
+	.deinit_clk_resources	= artpec8_pcie_deinit_clk_resources,
+};
+
+static const struct artpec8_pcie_res_ops artpec8_pcie_ep_res_ops = {
+	.get_mem_resources	= artpec8_pcie_get_ep_mem_resources,
+	.get_clk_resources	= artpec8_pcie_get_clk_resources,
+	.init_clk_resources	= artpec8_pcie_init_clk_resources,
+	.deinit_clk_resources	= artpec8_pcie_deinit_clk_resources,
+};
+
+static void artpec8_pcie_writel(void __iomem *base, u32 val, u32 reg)
+{
+	writel(val, base + reg);
+}
+
+static u32 artpec8_pcie_readl(void __iomem *base, u32 reg)
+{
+	return readl(base + reg);
+}
+
+static int artpec8_pcie_config_phy_power_isolation(struct dw_pcie *pci,
+						enum artpec8_pcie_reg_bit val)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = regmap_write(artpec8_ctrl->pmu_syscon, PMU_SYSCON_PCIE_ISOLATION,
+			   val);
+	if (ret)
+		dev_err(dev, "regmap write to %s  pcie phy power isolation failed\n",
+			val ? "set" : "clear");
+
+	return ret;
+}
+
+static int artpec8_pcie_config_bus_enable(struct dw_pcie *pci,
+						enum artpec8_pcie_reg_bit val)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = regmap_write(artpec8_ctrl->bus_p_syscon,
+			   BUS_SYSCON_BUS_PATH_ENABLE, val);
+	if (ret)
+		goto bus_enable_fail;
+
+	ret = regmap_write(artpec8_ctrl->bus_s_syscon,
+			   BUS_SYSCON_BUS_PATH_ENABLE, val);
+	if (ret)
+		goto bus_enable_fail;
+
+	return ret;
+
+bus_enable_fail:
+	dev_err(dev, "regmap write to %s pcie bus path failed\n",
+		val ? "enable" : "disable");
+	return ret;
+}
+
+static int artpec8_pcie_config_isolation(struct dw_pcie *pci,
+					 enum artpec8_pcie_isolation val)
+{
+	struct device *dev = pci->dev;
+	int ret;
+	/* reg_val[0] : for phy power isolation */
+	/* reg_val[1] : for bus enable */
+	enum artpec8_pcie_reg_bit reg_val[2];
+
+	switch (val) {
+	case PCIE_CLEAR_ISOLATION:
+		reg_val[0] = PCIE_REG_BIT_LOW;
+		reg_val[1] = PCIE_REG_BIT_HIGH;
+		break;
+	case PCIE_SET_ISOLATION:
+		reg_val[0] = PCIE_REG_BIT_HIGH;
+		reg_val[1] = PCIE_REG_BIT_LOW;
+		break;
+	default:
+		dev_err(dev, "%d is invalid value\n", val);
+		return -EINVAL;
+	}
+
+	ret = artpec8_pcie_config_phy_power_isolation(pci, reg_val[0]);
+	if (ret)
+		return ret;
+
+	ret = artpec8_pcie_config_bus_enable(pci, reg_val[1]);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "pcie is %s\n", val ? "disabled" : "enabled");
+
+	return ret;
+}
+
+static int artpec8_pcie_config_perstn(struct dw_pcie *pci,
+				      enum artpec8_pcie_reg_bit val)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+	struct device *dev = pci->dev;
+	unsigned int bits;
+	int ret;
+
+	if (val == PCIE_REG_BIT_HIGH)
+		bits = PCIE_PERSTN;
+	else
+		bits = 0;
+
+	ret = regmap_update_bits(artpec8_ctrl->sysreg, FSYS_PCIE_CON,
+				 PCIE_PERSTN, bits);
+	if (ret)
+		dev_err(dev, "failed to update fsys pcie con bits[0x%08x]\n",
+			bits);
+
+	return ret;
+}
+
+static void artpec8_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+	u32 val;
+
+	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
+				 PCIE_APP_LTSSM_ENABLE);
+
+	val &= ~PCIE_ELBI_LTSSM_ENABLE;
+	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
+			PCIE_APP_LTSSM_ENABLE);
+}
+
+static int artpec8_pcie_start_link(struct dw_pcie *pci)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+	u32 val;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	/* Equalization disable */
+	val = artpec8_pcie_read_dbi(pci, pci->dbi_base, PCIE_GEN3_RELATED_OFF,
+				    4);
+	artpec8_pcie_write_dbi(pci, pci->dbi_base, PCIE_GEN3_RELATED_OFF, 4,
+			       val | PCIE_GEN3_EQUALIZATION_DISABLE);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	/* assert LTSSM enable */
+	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
+				 PCIE_APP_LTSSM_ENABLE);
+
+	val |= PCIE_ELBI_LTSSM_ENABLE;
+	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
+			PCIE_APP_LTSSM_ENABLE);
+
+	return 0;
+}
+
+static irqreturn_t artpec8_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct artpec8_pcie *artpec8_ctrl = arg;
+	struct dw_pcie *pci = artpec8_ctrl->pci;
+	struct pcie_port *pp = &pci->pp;
+	u32 val;
+
+	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base, PCIE_IRQ2_STS);
+
+	if ((val & IRQ_MSI_ENABLE) == IRQ_MSI_ENABLE) {
+		val &= IRQ_MSI_ENABLE;
+		artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
+				    PCIE_IRQ2_STS);
+		dw_handle_msi_irq(pp);
+	} else
+		pr_info("0x%x unknown interrupt\n", val);
+
+
+	return IRQ_HANDLED;
+}
+
+static void artpec8_pcie_msi_init(struct artpec8_pcie *artpec8_ctrl)
+{
+	u32 val;
+
+	/* enable MSI interrupt */
+	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base, PCIE_IRQ2_EN);
+	val |= IRQ_MSI_ENABLE;
+	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val, PCIE_IRQ2_EN);
+}
+
+static void artpec8_pcie_enable_interrupts(struct artpec8_pcie *artpec8_ctrl)
+{
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		artpec8_pcie_msi_init(artpec8_ctrl);
+}
+
+static u32 artpec8_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+	u32 val;
+	bool is_atu = false;
+
+	if (base == pci->atu_base) {
+		is_atu = true;
+		base = pci->dbi_base;
+		regmap_write(artpec8_ctrl->sysreg,
+			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
+				FSYS_PCIE_DBI_ADDR_OVR_ATU);
+	}
+
+	dw_pcie_read(base + reg, size, &val);
+
+	if (is_atu)
+		regmap_write(artpec8_ctrl->sysreg,
+			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
+				FSYS_PCIE_DBI_ADDR_OVR_CDM);
+
+	return val;
+}
+
+static void artpec8_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size, u32 val)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+	bool is_atu = false;
+
+	if (base == pci->atu_base) {
+		is_atu = true;
+		base = pci->dbi_base;
+		regmap_write(artpec8_ctrl->sysreg,
+			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
+				FSYS_PCIE_DBI_ADDR_OVR_ATU);
+	}
+
+	dw_pcie_write(base + reg, size, val);
+
+	if (is_atu)
+		regmap_write(artpec8_ctrl->sysreg,
+			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
+				FSYS_PCIE_DBI_ADDR_OVR_CDM);
+}
+
+static void artpec8_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base,
+				    u32 reg, size_t size, u32 val)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+
+	regmap_write(artpec8_ctrl->sysreg,
+		artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
+			FSYS_PCIE_DBI_ADDR_OVR_SHADOW);
+
+	dw_pcie_write(base + reg, size, val);
+
+	regmap_write(artpec8_ctrl->sysreg,
+		artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
+			FSYS_PCIE_DBI_ADDR_OVR_CDM);
+}
+
+static int artpec8_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 *val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+
+	if (PCI_SLOT(devfn)) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	*val = dw_pcie_read_dbi(pci, where, size);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int artpec8_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+
+	if (PCI_SLOT(devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dw_pcie_write_dbi(pci, where, size, val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops artpec8_pci_ops = {
+	.read = artpec8_pcie_rd_own_conf,
+	.write = artpec8_pcie_wr_own_conf,
+};
+
+static int artpec8_pcie_link_up(struct dw_pcie *pci)
+{
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+	u32 val;
+
+	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
+			PCIE_ELBI_CXPL_DEBUG_00_31);
+
+	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
+}
+
+static int artpec8_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
+
+	pp->bridge->ops = &artpec8_pci_ops;
+
+	dw_pcie_writel_dbi(pci, PCIE_GEN3_RELATED_OFF,
+				(PCIE_GEN3_EQ_PHASE_2_3 |
+				 PCIE_GEN3_RXEQ_PH01_EN |
+				 PCIE_GEN3_RXEQ_RGRDLESS_RXTS));
+
+	artpec8_pcie_enable_interrupts(artpec8_ctrl);
+
+	return 0;
+}
+
+static struct dw_pcie_host_ops artpec8_pcie_host_ops = {
+	.host_init = artpec8_pcie_host_init,
+};
+
+static u8 artpec8_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
+	pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+
+	if (val == 0xffffffff)
+		return 1;
+
+	return 0;
+}
+
+static void artpec8_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+	/* Currently PCIe EP core is not setting iatu_unroll_enabled
+	 * so let's handle it here. We need to find proper place to
+	 * initialize this so that it can be used as for other EP
+	 * controllers as well.
+	 */
+	pci->iatu_unroll_enabled = artpec8_pcie_iatu_unroll_enabled(pci);
+
+	for (bar = BAR_0; bar <= BAR_5; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+}
+
+static int artpec8_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				 enum pci_epc_irq_type type, u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		dev_err(pci->dev, "EP does not support legacy IRQs\n");
+		return -EINVAL;
+	case PCI_EPC_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+	}
+
+	return 0;
+}
+
+static const struct pci_epc_features artpec8_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+artpec8_pcie_ep_get_features(struct dw_pcie_ep *ep)
+{
+	return &artpec8_pcie_epc_features;
+}
+
+static struct dw_pcie_ep_ops artpec8_dw_pcie_ep_ops = {
+	.ep_init	= artpec8_pcie_ep_init,
+	.raise_irq	= artpec8_pcie_raise_irq,
+	.get_features	= artpec8_pcie_ep_get_features,
+};
+
+static int __init artpec8_add_pcie_ep(struct artpec8_pcie *artpec8_ctrl,
+		struct platform_device *pdev)
+{
+	int ret;
+	struct dw_pcie_ep *ep;
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = artpec8_ctrl->pci;
+
+	ep = &pci->ep;
+	ep->ops = &artpec8_dw_pcie_ep_ops;
+
+	dw_pcie_writel_dbi(pci, PCIE_GEN3_RELATED_OFF,
+				(PCIE_GEN3_EQ_PHASE_2_3 |
+				 PCIE_GEN3_RXEQ_PH01_EN |
+				 PCIE_GEN3_RXEQ_RGRDLESS_RXTS));
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init artpec8_add_pcie_port(struct artpec8_pcie *artpec8_ctrl,
+					struct platform_device *pdev)
+{
+	struct dw_pcie *pci = artpec8_ctrl->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
+	int ret;
+	int irq_flags;
+	int irq;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		irq = platform_get_irq_byname(pdev, "intr");
+		if (!irq) {
+			dev_err(dev, "failed to get msi irq\n");
+			return -ENODEV;
+		}
+
+		irq_flags = IRQF_SHARED | IRQF_NO_THREAD;
+
+		ret = devm_request_irq(dev, irq, artpec8_pcie_msi_irq_handler,
+				irq_flags, "artpec8-pcie", artpec8_ctrl);
+		if (ret) {
+			dev_err(dev, "failed to request msi irq\n");
+			return ret;
+		}
+	}
+
+	/* Prevent core for messing with the IRQ, since it's muxed */
+	pp->msi_irq = -ENODEV;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dw_pcie_ops artpec8_dw_pcie_ops = {
+	.read_dbi	= artpec8_pcie_read_dbi,
+	.write_dbi	= artpec8_pcie_write_dbi,
+	.write_dbi2	= artpec8_pcie_write_dbi2,
+	.start_link	= artpec8_pcie_start_link,
+	.stop_link	= artpec8_pcie_stop_link,
+	.link_up	= artpec8_pcie_link_up,
+};
+
+static int artpec8_pcie_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct dw_pcie *pci;
+	struct pcie_port *pp;
+	struct artpec8_pcie *artpec8_ctrl;
+	enum dw_pcie_device_mode mode;
+	struct device *dev = &pdev->dev;
+	const struct artpec8_pcie_pdata *pdata;
+	struct device_node *np = dev->of_node;
+
+	artpec8_ctrl = devm_kzalloc(dev, sizeof(*artpec8_ctrl), GFP_KERNEL);
+	if (!artpec8_ctrl)
+		return -ENOMEM;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pdata = (const struct artpec8_pcie_pdata *)
+		of_device_get_match_data(dev);
+	if (!pdata) {
+		dev_err(dev, "failed to match device/n");
+		return -ENODEV;
+	}
+
+	mode = (enum dw_pcie_device_mode)pdata->mode;
+
+	artpec8_ctrl->pci = pci;
+	artpec8_ctrl->pdata = pdata;
+	artpec8_ctrl->mode = mode;
+
+	pci->dev = dev;
+	pci->ops = pdata->dwc_ops;
+	pci->dbi_base2 = NULL;
+	pci->dbi_base = NULL;
+	pp = &pci->pp;
+	pp->ops = artpec8_ctrl->pdata->host_ops;
+
+	if (mode == DW_PCIE_RC_TYPE)
+		artpec8_ctrl->link_id = of_alias_get_id(np, "pcierc");
+	else
+		artpec8_ctrl->link_id = of_alias_get_id(np, "pcieep");
+
+	ret = artpec8_pcie_get_subsystem_resources(pdev, artpec8_ctrl);
+	if (ret)
+		return ret;
+
+	if (pdata->res_ops && pdata->res_ops->get_mem_resources) {
+		ret = pdata->res_ops->get_mem_resources(pdev, artpec8_ctrl);
+		if (ret)
+			return ret;
+	}
+
+	if (pdata->res_ops && pdata->res_ops->get_clk_resources) {
+		ret = pdata->res_ops->get_clk_resources(pdev, artpec8_ctrl);
+		if (ret)
+			return ret;
+
+		ret = pdata->res_ops->init_clk_resources(artpec8_ctrl);
+		if (ret)
+			return ret;
+	}
+
+	platform_set_drvdata(pdev, artpec8_ctrl);
+
+	ret = artpec8_pcie_config_isolation(pci, PCIE_CLEAR_ISOLATION);
+	if (ret)
+		return ret;
+
+	ret = artpec8_pcie_config_perstn(pci, PCIE_REG_BIT_HIGH);
+	if (ret)
+		return ret;
+
+	artpec8_ctrl->phy = devm_of_phy_get(dev, np, NULL);
+	if (IS_ERR(artpec8_ctrl->phy)) {
+		if (PTR_ERR(artpec8_ctrl->phy) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get phy\n");
+		return PTR_ERR(artpec8_ctrl->phy);
+	}
+
+	phy_init(artpec8_ctrl->phy);
+	phy_reset(artpec8_ctrl->phy);
+
+	switch (mode) {
+	case DW_PCIE_RC_TYPE:
+		artpec8_pcie_writel(artpec8_ctrl->elbi_base, DEVICE_TYPE_RC,
+				PCIE_ARTPEC8_DEVICE_TYPE);
+		ret = artpec8_add_pcie_port(artpec8_ctrl, pdev);
+		if (ret < 0)
+			goto fail_probe;
+		break;
+	case DW_PCIE_EP_TYPE:
+		artpec8_pcie_writel(artpec8_ctrl->elbi_base, DEVICE_TYPE_EP,
+				PCIE_ARTPEC8_DEVICE_TYPE);
+
+		ret = artpec8_add_pcie_ep(artpec8_ctrl, pdev);
+		if (ret < 0)
+			goto fail_probe;
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", mode);
+		ret = -EINVAL;
+		goto fail_probe;
+	}
+
+	dev_info(dev, "Probe completed successfully\n");
+
+	return 0;
+
+fail_probe:
+	phy_exit(artpec8_ctrl->phy);
+	if (pdata->res_ops && pdata->res_ops->deinit_clk_resources)
+		pdata->res_ops->deinit_clk_resources(artpec8_ctrl);
+
+	return ret;
+}
+
+static int __exit artpec8_pcie_remove(struct platform_device *pdev)
+{
+	struct artpec8_pcie *artpec8_ctrl = platform_get_drvdata(pdev);
+	const struct artpec8_pcie_pdata *pdata = artpec8_ctrl->pdata;
+
+	if (pdata->res_ops && pdata->res_ops->deinit_clk_resources)
+		pdata->res_ops->deinit_clk_resources(artpec8_ctrl);
+
+	return 0;
+}
+
+static const struct artpec8_pcie_pdata artpec8_pcie_rc_pdata = {
+	.dwc_ops	= &artpec8_dw_pcie_ops,
+	.host_ops	= &artpec8_pcie_host_ops,
+	.res_ops	= &artpec8_pcie_rc_res_ops,
+	.mode		= DW_PCIE_RC_TYPE,
+};
+
+static const struct artpec8_pcie_pdata artpec8_pcie_ep_pdata = {
+	.dwc_ops	= &artpec8_dw_pcie_ops,
+	.host_ops	= &artpec8_pcie_host_ops,
+	.res_ops	= &artpec8_pcie_ep_res_ops,
+	.mode		= DW_PCIE_EP_TYPE,
+};
+
+static const struct of_device_id artpec8_pcie_of_match[] = {
+	{
+		.compatible = "axis,artpec8-pcie",
+		.data = &artpec8_pcie_rc_pdata,
+	},
+	{
+		.compatible = "axis,artpec8-pcie-ep",
+		.data = &artpec8_pcie_ep_pdata,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, artpec8_pcie_of_match);
+
+static struct platform_driver artpec8_pcie_driver = {
+	.probe	= artpec8_pcie_probe,
+	.remove		= __exit_p(artpec8_pcie_remove),
+	.driver = {
+		.name	= "artpec8-pcie",
+		.of_match_table = artpec8_pcie_of_match,
+	},
+};
+
+module_platform_driver(artpec8_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jaeho Cho <jaeho79.cho@samsung.com>");
-- 
2.9.5
