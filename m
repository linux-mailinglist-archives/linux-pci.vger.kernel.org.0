Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5456320FF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiKULos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiKULom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:44:42 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E46DCA
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 03:44:39 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221121114437epoutp039dc05ccbdb4303ac0d5dfe0aafb09211~pluwnSZt01293612936epoutp03Z
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 11:44:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221121114437epoutp039dc05ccbdb4303ac0d5dfe0aafb09211~pluwnSZt01293612936epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669031077;
        bh=qAxZ732xQ1DuhM/zGUbX+ThXXcPExcF8vsOdKPXFUfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kI5GT52A+VttAlvpHNuIRgN14w6b1vQcKs5aFZTTKxmNjipDKew5bx5cxAYPfSMD3
         m9teMCE9YrAx6ysuxFpOX0KLZlU6plJg2TYETJeOs98Nh56dgDbzpyvOVkkC4SPYqb
         j5tAh++509yl10lFdkqWHPkgUwdBKjaXwF/F+E+0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221121114437epcas5p4b55b1c4f5885923b263382a76c914bf8~pluv_7xmx0787707877epcas5p47;
        Mon, 21 Nov 2022 11:44:37 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NG5CR3lKqz4x9Pq; Mon, 21 Nov
        2022 11:44:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.ED.39477.3A46B736; Mon, 21 Nov 2022 20:44:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221121104731epcas5p48f96c92e5bfb4ede56ce74a78887a2f3~pk8563w3Q1415714157epcas5p4K;
        Mon, 21 Nov 2022 10:47:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221121104731epsmtrp2d3808cb8063cc38963ec55ea7e0bdf07~pk8556ZHx2142521425epsmtrp2T;
        Mon, 21 Nov 2022 10:47:31 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-8a-637b64a38305
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.5B.14392.3475B736; Mon, 21 Nov 2022 19:47:31 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121104728epsmtip107d65946e074e0d476acd0942f90f74a~pk82agFP51012310123epsmtip1X;
        Mon, 21 Nov 2022 10:47:28 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 3/6] PCI: dwc: fsd: Add FSD PCIe Controller driver support
Date:   Mon, 21 Nov 2022 16:22:07 +0530
Message-Id: <20221121105210.68596-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121105210.68596-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxTAd/teX0uTbk+o84pRWZeRiQNbLHBhIPsg88m2jIQsGctm99I+
        WkZpa1+ZCDMi4uYYVHQyGYFCKLBQCDAqrnN8o+BwkA6ImBVUFDNclCJlwATcWorbf79z8zvn
        3HvuvXzMf4QI5KdpjYxBS2vEhAC/2Lfr5VCLMkch+W55M+p29eDotvkigdbO9vNQr62Nh67f
        d/BQTZ4ajXbtRpWXh7nohKWZQI57hQQyzUxhKLdwhYtGL5UTaMg8QKBi6yKO8lfzcdQ9ZwVo
        +twdLrryQzKqblvgoTKHnYtOdlzmIbO9AqCivqPI+aCJi36auIq9FkitPD4LqKrWTKrV+hVB
        TVxvJ6jpsfMcqquikUfZao5RpgtWQA3c+JFDuVt3JAk+TI9VM7SSMQQxWoVOmaZVxYnfTpa/
        KY+IlEhDpdEoShykpTOYOHHCO0mhb6VpPAcXB31GazI9S0k0y4r37Is16DKNTJBaxxrjxIxe
        qdHL9GEsncFmalVhWsYYI5VIwiM84ifp6of98foiN8iqnl3Gc0HeFVAA+HxIyuDXs/wCIOD7
        kz8D6Ph1kuML5gFcqyrCC4CfJ1gEcMkk97I3YbC5A/NJHQAW/1G/kXGSAxu+f8DxWgQZAo//
        VYB5WUTOY3Dp2xivhJFVAE7dqF/vHUAmws556HVw8iU4XlsLvCwkY+BgZznh67YTNrR0r9fx
        I1+FTRYn4a0DyQU+HGq8y/FJCbDH4QY+DoB/Dlzg+TgQumc7NgqpYL2tFPOxBi7aajZy42H3
        WDnu3Q9G7oLNl/b4lrfDksGmdQUjn4VFK9MbuhDazU/5Rbiw1o77eCs0949yfUzB4vlTGxMy
        AZjvKieKwY6y/1tUAWAFWxk9m6Fi2Ah9uJY5/N+tKXQZrWD9cYck2sHU7bmwXsDhg14A+ZhY
        JDz2UY7CX6ikj2QzBp3ckKlh2F4Q4RngGSxws0Ln+R1ao1wqi5bIIiMjZdF7I6XiLUJLaYjC
        n1TRRiadYfSM4Wkeh+8XmMvhOSu7/V6oXnnj9dFD+DOzz9elGEU5q432eMfNo5LsR65gVUlK
        JXNoqU7UqAiYKWkRmlw0u9JkSR0ah7+10Y9PuQ8ECWDtadXaneprzzVOWoQJNQflgpFJ2+r9
        hz0lAQt6UPKuQMtrOeG6FdznnPilb9t+uft4bfKTLPXNbRrVviy1Kfubw13X1GOfCipBxJN/
        9qd84Dw30NzSUBqbR4HPnea9m9xURYUcz0t1yab7OuKGX7k3B8tColaLopZVjjMHbPZblRnx
        4ZvaO4cKHV8w741NJ35Z9vHBqLr3Vzkkc6S27rxM+bt0y27T31ex1O0sfyR0PPjuzKOdotxh
        q1OMs2paGoIZWPpfsuV4fGUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTtc5vDrZYNETHYsD7w+yWDyYt43N
        4u+kY+wWhzZvZbe49vICu8WSpgyLy/u1LeYfOcdq0bx4PZvFhac9bBZ9Lx4yWzT0/Ga1uLxr
        DpvF2XnH2SwmrPrGYtHyp4XF4sCHVYwWT6Y8YrU4ujHYYtHWL+wWsy7sYLVo3XuE3WLejrmM
        Fr2Hay1uv1nHarHzzglmBymP378mMXos2FTqsWlVJ5vHnWt72DyeXJnO5LF/7hp2j81L6j36
        tqxi9Dh+YzuTx+dNcgFcUVw2Kak5mWWpRfp2CVwZb4/ZF/R+ZqxY9O4HSwNj01HGLkZODgkB
        E4lT6/cydzFycQgJ7GaUeLRyPzNEQlLi88V1TBC2sMTKf8/ZIYqamSQ+3TjFDpJgE9CSaPza
        BdYtItDDIjF76x2wKmaBJYwSm+/uYeti5OAQFvCS2PdJAqSBRUBV4vrSpWCreQWsJE7tm8MG
        sUFeYvWGA2CbOQWsJdYtvg0WFwKqWXfjD/sERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL
        89L1kvNzNzGC40tLcwfj9lUf9A4xMnEwHmKU4GBWEuEVOVaZLMSbklhZlVqUH19UmpNafIhR
        moNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTDM5lDSfnijR7sbBIXzdNlqk7//B4nHg7
        S6xls0jH/Vw541VbvgdfyJH4YhWk9k1hq5WFVdWbT99qXT1a1zy+eevaHaOy0on/zX6Frl/H
        LPBl4vprrGn2J1/yewZ1cty4bFsR+ztT8knL5TkT7NdUnd+98uFLo88/2T1zpV7UPgmryXhR
        ldIgMYXNNqDly2ylDzvF2idU9obstLN+4xD0yNhWQF1FuWhWt3aKva7ZZP+XGgLP2rb0rdkY
        +l+wq0pyc3Z+0HveY9eddxpm690NzLmiEVXItCHt9iHdO483XIpq1TKY+OjM0SCNY+vCI+qj
        WN4GB3J+2Hs89ra6V86bB0suPaiZ/uFdV490fbASS3FGoqEWc1FxIgCb3hckHgMAAA==
X-CMS-MailID: 20221121104731epcas5p48f96c92e5bfb4ede56ce74a78887a2f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121104731epcas5p48f96c92e5bfb4ede56ce74a78887a2f3
References: <20221121105210.68596-1-shradha.t@samsung.com>
        <CGME20221121104731epcas5p48f96c92e5bfb4ede56ce74a78887a2f3@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe controller driver file for PCIe controller
found in fsd SoC family. This driver adds support for both RC
and EP mode.

Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/Kconfig    |   35 +
 drivers/pci/controller/dwc/Makefile   |    1 +
 drivers/pci/controller/dwc/pcie-fsd.c | 1021 +++++++++++++++++++++++++
 3 files changed, 1057 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-fsd.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..9a3d194c979f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -14,6 +14,41 @@ config PCIE_DW_EP
 	bool
 	select PCIE_DW
 
+config PCIE_FSD
+	bool "Samsung FSD PCIe Controller"
+	default n
+	help
+	  Enables support for the PCIe controller in the FSD SoC. There are
+	  total three instances of PCIe controller in FSD. This controller
+	  can work either in RC or EP mode. In order to enable host-specific
+	  features, PCI_FSD_HOST must be selected and in order to enable
+	  device-specific feature PCI_FSD_EP must be selected.
+
+config PCIE_FSD_HOST
+	bool "PCIe FSD Host Mode"
+	depends on PCI
+	depends on PCI_MSI_IRQ_DOMAIN || PCI_DOMAIN
+	select PCIE_DW_HOST
+	select PCIE_FSD
+	default n
+	help
+	  Enables support for the PCIe controller in the FSD SoC to work in
+	  host (RC) mode. In order to enable host-specific features,
+	  PCIE_DW_HOST must be selected. PCIE_FSD should be selected for
+	  fsd controller specific settings.
+
+config PCIE_FSD_EP
+	bool "PCIe FSD Endpoint Mode"
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCIE_FSD
+	default n
+	help
+	  Enables support for the PCIe controller in the FSD SoC to work in
+	  endpoint mode. In order to enable device-specific feature
+	  PCI_FSD_EP must be selected. PCIE_FSD should be selected for
+	  fsd controller specific settings.
+
 config PCI_DRA7XX
 	tristate
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 8ba7b67f5e50..b76fa6b4e79f 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
+obj-$(CONFIG_PCIE_FSD) += pcie-fsd.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-fsd.c b/drivers/pci/controller/dwc/pcie-fsd.c
new file mode 100644
index 000000000000..4531efbfc313
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-fsd.c
@@ -0,0 +1,1021 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Tesla fsd SoC
+ *
+ * Copyright (C) 2017-2022 Samsung Electronics Co., Ltd. http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/resource.h>
+#include <linux/mfd/syscon.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+#define to_fsd_pcie(x)	dev_get_drvdata((x)->dev)
+
+/* PCIe ELBI registers */
+#define PCIE_APP_LTSSM_ENABLE		0x054
+#define PCIE_ELBI_LTSSM_ENABLE		0x1
+#define PCIE_ELBI_LTSSM_DISABLE		0x0
+#define PCIE_ELBI_CXPL_DEBUG_00_31	0x2C8
+#define LTSSM_STATE_MASK		0x3f
+#define LTSSM_STATE_L0			0x11
+#define PCIE_FSD_DEVICE_TYPE		0x080
+#define DEVICE_TYPE_RC			0x4
+#define DEVICE_TYPE_EP			0x0
+#define IRQ_MSI_ENABLE			BIT(17)
+#define IRQ0_EN				0x10
+#define IRQ1_EN				0x14
+#define IRQ2_EN				0x18
+#define IRQ5_EN				0x1c
+#define IRQ0_STS			0x0
+#define IRQ1_STS			0x4
+#define IRQ2_STS			0x8
+#define IRQ5_STS			0xc
+
+/* Gen3 Control Register */
+#define PCIE_GEN3_RELATED_OFF		0x890
+/* Parameters for equalization feature */
+#define PCIE_GEN3_EQUALIZATION_DISABLE	BIT(16)
+#define PCIE_GEN3_EQ_PHASE_2_3		BIT(9)
+#define PCIE_GEN3_RXEQ_PH01_EN		BIT(12)
+#define PCIE_GEN3_RXEQ_RGRDLESS_RXTS	BIT(13)
+
+/**
+ * struct fsd_pcie - representation of the pci controller
+ * @pci: representation of dwc pcie device structure
+ * @aux_clk: auxiliary clock for the pci block
+ * @dbi_clk: DBI clock
+ * @mstr_clk: master clock
+ * @slv_clk: slave clock
+ * @pdata: private data to determine the oprations supported by device
+ * @appl_base: represent the appl base
+ * @sysreg: represent the system register base
+ * @sysreg_base: represents the offset of the system register required
+ * @phy: represents the phy device associated for the controller
+ */
+struct fsd_pcie {
+	struct dw_pcie *pci;
+	struct clk *aux_clk;
+	struct clk *dbi_clk;
+	struct clk *mstr_clk;
+	struct clk *slv_clk;
+	const struct fsd_pcie_pdata *pdata;
+	void __iomem *appl_base;
+	struct regmap *sysreg;
+	unsigned int sysreg_base;
+	struct phy *phy;
+};
+
+enum fsd_pcie_addr_type {
+	ADDR_TYPE_DBI = 0x0,
+	ADDR_TYPE_DBI2 = 0x32,
+	ADDR_TYPE_ATU = 0x36,
+	ADDR_TYPE_DMA = 0x37,
+};
+
+enum IRQ0_ERR_BITS {
+	APP_PARITY_ERRS_0,
+	APP_PARITY_ERRS_1,
+	APP_PARITY_ERRS_2,
+	CFG_BW_MGT_INT = 4,
+	CFG_LINK_AUTO_BW_INT,
+	CFG_SYS_ERR_RC = 7,
+	DPA_SUBSTATE_UPDATE,
+	FLUSH_DONE,
+	RADM_CORRECTABLE_ERR = 12,
+	RADM_FATAL_ERR,
+	RADM_MSG_CPU_ACTIVE = 22,
+	RADM_MSG_IDLE,
+	RADM_MSG_LTR,
+	RADM_MSG_OBFF,
+	RADM_MSG_UNLOCK,
+	RADM_NONFATAL_ERR,
+	RADM_PM_PME,
+	RADM_PM_TO_ACK,
+	RADM_PM_TURNOFF,
+	RADM_VENDOR_MSG,
+};
+
+enum IRQ1_ERR_BITS {
+	TRGT_CPL_TIMEOUT = 0,
+	VEN_MSG_GRANT,
+	VEN_MSI_GRANT,
+};
+
+enum IRQ2_ERR_BITS {
+	APP_LTR_MSG_GRANT = 0,
+	APP_OBFF_MSG_GRANT,
+	CFG_AER_RC_ERR_INT,
+	CFG_BUS_MASTER_EN,
+	CFG_LINK_EQ_REQ_INT,
+	CFG_PME_INT,
+	EDMA_INT_0,
+	EDMA_INT_1,
+	EDMA_INT_2,
+	EDMA_INT_3,
+	EDMA_INT_4,
+	EDMA_INT_5,
+	EDMA_INT_6,
+	EDMA_INT_7,
+	PM_LINKST_IN_L0S = 18,
+	PM_LINKST_IN_L1,
+	PM_LINKST_IN_L1SUB_0,
+	PM_LINKST_IN_L2,
+	PM_LINKST_L2_EXIT,
+	PM_XTLH_BLOCK_TLP,
+	RADM_CPL_TIMEOUT,
+	RADM_Q_NOT_EMPTY,
+	RDLH_LINK_UP_0,
+	SMLH_LINK_UP = 29,
+	WAKE,
+	COMPARE_END_CHECKER,
+};
+
+enum IRQ5_ERR_BITS {
+	LINK_REQ_RST_NOT,
+	PM_LINKST_IN_L1SUB_1,
+	RDLH_LINK_UP_1,
+	SMLH_REQ_RST_NOT,
+};
+
+struct fsd_pcie_res_ops {
+	int (*get_mem_resources)(struct platform_device *pdev,
+				 struct fsd_pcie *fsd_ctrl);
+	int (*get_clk_resources)(struct platform_device *pdev,
+				 struct fsd_pcie *fsd_ctrl);
+	int (*init_clk_resources)(struct fsd_pcie *fsd_ctrl);
+	void (*deinit_clk_resources)(struct fsd_pcie *fsd_ctrl);
+};
+
+struct fsd_pcie_irq {
+	irqreturn_t (*pcie_msi_irq_handler)(int irq, void *arg);
+	void (*pcie_msi_init)(struct fsd_pcie *fsd_ctrl);
+	irqreturn_t (*pcie_sub_ctrl_handler)(int irq, void *arg);
+};
+
+struct fsd_pcie_pdata {
+	const struct dw_pcie_ops *dwc_ops;
+	struct dw_pcie_host_ops	*host_ops;
+	const struct fsd_pcie_res_ops *res_ops;
+	const struct fsd_pcie_irq *irq_data;
+	unsigned int appl_cxpl_debug_00_31;
+	int op_mode;
+};
+
+static int fsd_pcie_get_mem_resources(struct platform_device *pdev,
+					  struct fsd_pcie *fsd_ctrl)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	/* External Local Bus interface(ELBI) Register */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "appl");
+	if (!res)
+		return -EINVAL;
+	fsd_ctrl->appl_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(fsd_ctrl->appl_base)) {
+		dev_err(dev, "Failed to map appl_base\n");
+		return PTR_ERR(fsd_ctrl->appl_base);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	if (!res)
+		return -EINVAL;
+	fsd_ctrl->pci->dbi_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(fsd_ctrl->pci->dbi_base)) {
+		dev_err(dev, "failed to map dbi_base\n");
+		return PTR_ERR(fsd_ctrl->pci->dbi_base);
+	}
+
+	/* sysreg regmap handle */
+	fsd_ctrl->sysreg = syscon_regmap_lookup_by_phandle(dev->of_node,
+			"tesla,pcie-sysreg");
+	if (IS_ERR(fsd_ctrl->sysreg)) {
+		dev_err(dev, "Sysreg regmap lookup failed.\n");
+		return PTR_ERR(fsd_ctrl->sysreg);
+	}
+
+	ret = of_property_read_u32_index(dev->of_node, "tesla,pcie-sysreg", 1,
+					 &fsd_ctrl->sysreg_base);
+	if (ret) {
+		dev_err(dev, "Couldn't get the register offset for syscon!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fsd_pcie_get_clk_resources(struct platform_device *pdev,
+				       struct fsd_pcie *fsd_ctrl)
+{
+	struct device *dev = &pdev->dev;
+
+	fsd_ctrl->aux_clk = devm_clk_get(dev, "aux_clk");
+	if (IS_ERR(fsd_ctrl->aux_clk)) {
+		dev_err(dev, "couldn't get aux clock\n");
+		return -EINVAL;
+	}
+
+	fsd_ctrl->dbi_clk = devm_clk_get(dev, "dbi_clk");
+	if (IS_ERR(fsd_ctrl->dbi_clk)) {
+		dev_err(dev, "couldn't get dbi clk\n");
+		return -EINVAL;
+	}
+
+	fsd_ctrl->slv_clk = devm_clk_get(dev, "slv_clk");
+	if (IS_ERR(fsd_ctrl->slv_clk)) {
+		dev_err(dev, "couldn't get slave clock\n");
+		return -EINVAL;
+	}
+
+	fsd_ctrl->mstr_clk = devm_clk_get(dev, "mstr_clk");
+	if (IS_ERR(fsd_ctrl->mstr_clk)) {
+		dev_err(dev, "couldn't get master clk\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fsd_pcie_init_clk_resources(struct fsd_pcie *fsd_ctrl)
+{
+	clk_prepare_enable(fsd_ctrl->aux_clk);
+	clk_prepare_enable(fsd_ctrl->dbi_clk);
+	clk_prepare_enable(fsd_ctrl->mstr_clk);
+	clk_prepare_enable(fsd_ctrl->slv_clk);
+
+	return 0;
+}
+
+static void fsd_pcie_deinit_clk_resources(struct fsd_pcie *fsd_ctrl)
+{
+	clk_disable_unprepare(fsd_ctrl->slv_clk);
+	clk_disable_unprepare(fsd_ctrl->mstr_clk);
+	clk_disable_unprepare(fsd_ctrl->dbi_clk);
+	clk_disable_unprepare(fsd_ctrl->aux_clk);
+}
+
+static const struct fsd_pcie_res_ops fsd_pcie_res_ops_data = {
+	.get_mem_resources	= fsd_pcie_get_mem_resources,
+	.get_clk_resources	= fsd_pcie_get_clk_resources,
+	.init_clk_resources	= fsd_pcie_init_clk_resources,
+	.deinit_clk_resources	= fsd_pcie_deinit_clk_resources,
+};
+
+static void fsd_pcie_stop_link(struct dw_pcie *pci)
+{
+	u32 reg;
+	struct fsd_pcie *fsd_ctrl = to_fsd_pcie(pci);
+
+	reg = readl(fsd_ctrl->appl_base + PCIE_APP_LTSSM_ENABLE);
+	reg &= ~PCIE_ELBI_LTSSM_ENABLE;
+	writel(reg, fsd_ctrl->appl_base + PCIE_APP_LTSSM_ENABLE);
+}
+
+static int fsd_pcie_establish_link(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+	struct fsd_pcie *fsd_ctrl = to_fsd_pcie(pci);
+	struct dw_pcie_ep *ep;
+
+	if (dw_pcie_link_up(pci)) {
+		dev_info(dev, "Link already up\n");
+		return 0;
+	}
+
+	/* assert LTSSM enable */
+	writel(PCIE_ELBI_LTSSM_ENABLE, fsd_ctrl->appl_base +
+			PCIE_APP_LTSSM_ENABLE);
+
+	/* check if the link is up or not */
+	if (!dw_pcie_wait_for_link(pci)) {
+		dev_info(dev, "Link up done successfully\n");
+		if (fsd_ctrl->pdata->op_mode == DEVICE_TYPE_EP) {
+			ep = &pci->ep;
+			dw_pcie_ep_linkup(ep);
+		}
+		return 0;
+	}
+
+	if (fsd_ctrl->pdata->op_mode == DEVICE_TYPE_RC) {
+		/* Return success as link might come up later */
+		return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void handle_irq0_interrupts(u32 val, u32 is_en)
+{
+	u32 bit_off = 0;
+
+	if (val) {
+		while (bit_off < 32) {
+			if ((val & (0x1 << bit_off)) == 0 || (is_en &
+						(0x1 << bit_off)) == 0) {
+				bit_off++;
+				continue;
+			}
+			switch (bit_off) {
+			case RADM_VENDOR_MSG:
+				pr_info("Interrupt received for\n");
+				break;
+			case RADM_PM_TURNOFF:
+				pr_info("Interrupt received for RADM_PM_TURNOFF\n");
+				break;
+			case RADM_PM_TO_ACK:
+				pr_info("Interrupt received for RADM_PM_TO_ACK\n");
+				break;
+			case RADM_PM_PME:
+				pr_info("Interrupt received for RADM_PM_PME\n");
+				break;
+			case RADM_NONFATAL_ERR:
+				pr_info("Interrupt received for RADM_NONFATAL_ERR\n");
+				break;
+			case RADM_MSG_UNLOCK:
+				pr_info("Interrupt received for RADM_MSG_UNLOCK\n");
+				break;
+			case RADM_MSG_OBFF:
+				pr_info("Interrupt received for RADM_MSG_OBFF\n");
+				break;
+			case RADM_MSG_LTR:
+				pr_info("Interrupt received for RADM_MSG_LTR\n");
+				break;
+			case RADM_MSG_IDLE:
+				pr_info("Interrupt received for RADM_MSG_IDLE\n");
+				break;
+			case RADM_MSG_CPU_ACTIVE:
+				pr_info("Interrupt received for RADM_MSG_CPU_ACTIVE\n");
+				break;
+			case RADM_FATAL_ERR:
+				pr_info("Interrupt received for RADM_FATAL_ERR\n");
+				break;
+			case RADM_CORRECTABLE_ERR:
+				pr_info("Interrupt received for RADM_CORRECTABLE_ERR\n");
+				break;
+			case FLUSH_DONE:
+				pr_info("Interrupt received for FLUSH_DONE\n");
+				break;
+			case DPA_SUBSTATE_UPDATE:
+				pr_info("Interrupt received for DPA_SUBSTATE_UPDATE\n");
+				break;
+			case CFG_SYS_ERR_RC:
+				pr_info("Interrupt received for CFG_SYS_ERR_RC\n");
+				break;
+			case CFG_LINK_AUTO_BW_INT:
+				pr_info("Interrupt received for CFG_LINK_AUTO_BW_INT\n");
+				break;
+			case CFG_BW_MGT_INT:
+				pr_info("Interrupt received for CFG_BW_MGT_INT\n");
+				break;
+			case APP_PARITY_ERRS_2:
+				pr_info("Interrupt received for APP_PARITY_ERRS_2\n");
+				break;
+			case APP_PARITY_ERRS_1:
+				pr_info("Interrupt received for APP_PARITY_ERRS_1\n");
+				break;
+			case APP_PARITY_ERRS_0:
+				pr_info("Interrupt received for APP_PARITY_ERRS_0\n");
+				break;
+			default:
+				pr_info("Unknown Interrupt in IRQ0[%d]\n", bit_off);
+				break;
+			}
+			bit_off++;
+		}
+	}
+}
+
+static void handle_irq1_interrupts(u32 val, u32 is_en)
+{
+	u32 bit_off = 0;
+
+	if (val) {
+		while (bit_off < 32) {
+			if ((val & (0x1 << bit_off)) == 0 || (is_en &
+						(0x1 << bit_off)) == 0) {
+				bit_off++;
+				continue;
+			}
+			switch (bit_off) {
+			case TRGT_CPL_TIMEOUT:
+				pr_info("Interrupt for TRGT_CPL_TIMEOUT\n");
+				break;
+			case VEN_MSG_GRANT:
+				pr_info("Interrupt for VEN_MSG_GRANT\n");
+				break;
+			case VEN_MSI_GRANT:
+				pr_info("Interrupt for VEN_MSI_GRANT\n");
+				break;
+			default:
+				pr_info("Unknown Interrupt in IRQ1[%d]\n", bit_off);
+				break;
+			}
+			bit_off++;
+		}
+	}
+}
+
+static void handle_irq2_interrupts(u32 val, u32 is_en)
+{
+	u32 bit_off = 0;
+
+	if (val) {
+		while (bit_off < 32) {
+			if ((val & (0x1 << bit_off)) == 0 || (is_en &
+						(0x1 << bit_off)) == 0) {
+				bit_off++;
+				continue;
+			}
+			switch (bit_off) {
+			/* To indicate that controller has accepted to send
+			 * Latency Tolerance reporting message
+			 */
+			case APP_LTR_MSG_GRANT:
+				pr_info("Interrupt for APP_LTR_MSG_GRANT\n");
+				break;
+			case APP_OBFF_MSG_GRANT:
+				pr_info("Interrupt for APP_OBFF_MSG_GRANT\n");
+				break;
+			case CFG_AER_RC_ERR_INT:
+				pr_info("Interrupt for CFG_AER_RC_ERR_INT\n");
+				break;
+			/* IRQ when bus master is enabled */
+			case CFG_BUS_MASTER_EN:
+				pr_info("Interrupt for CFG_BUS_MASTER_EN\n");
+				break;
+			/* IRQ to indicate that link Equalization request has been set */
+			case CFG_LINK_EQ_REQ_INT:
+				pr_info("Interrupt for CFG_LINK_EQ_REQ_INT\n");
+				break;
+			case CFG_PME_INT:
+				pr_info("Interrupt for CFG_PME_INIT\n");
+				break;
+			case EDMA_INT_0:
+			case EDMA_INT_1:
+			case EDMA_INT_2:
+			case EDMA_INT_3:
+			case EDMA_INT_4:
+			case EDMA_INT_5:
+			case EDMA_INT_6:
+			case EDMA_INT_7:
+				pr_info("Interrupt for DMA\n");
+				break;
+			/* IRQ when link entres L0s */
+			case PM_LINKST_IN_L0S:
+				pr_info("Interrupt for PM_LINKST_IN_L0S\n");
+				break;
+			/* IRQ when link enters L1 */
+			case PM_LINKST_IN_L1:
+				pr_info("Interrupt for PM_LINKST_IN_L1\n");
+				break;
+			/* IRQ when link enters L1 substate */
+			case PM_LINKST_IN_L1SUB_0:
+				pr_info("Interrupt for PM_LINKST_IN_L1SUB_0\n");
+				break;
+			/* IRQ when link enters L2 */
+			case PM_LINKST_IN_L2:
+				pr_info("Interrupt for PM_LINKST_IN_L2\n");
+				break;
+			/* IRQ when link exits L2 */
+			case PM_LINKST_L2_EXIT:
+				pr_info("Interrupt for PM_LINKST_L2_EXIT\n");
+				break;
+			/* Indicates that application must stop sending new
+			 * outbound TLP requests due to current power state
+			 */
+			case PM_XTLH_BLOCK_TLP:
+				pr_info("Interrupt for PM_XTLH_BLOCK_TLP\n");
+				break;
+			/* Request failed to complete in time */
+			case RADM_CPL_TIMEOUT:
+				pr_info("Interrupt for RADM_CPL_TIMEOUT\n");
+				break;
+			/* Level indicating that receive queues contain TLP header/data */
+			case RADM_Q_NOT_EMPTY:
+				pr_info("Interrupt for RADM_Q_NOT_EMPTY\n");
+				break;
+			/* Data link layer up/down indicator */
+			case RDLH_LINK_UP_0:
+				pr_info("Interrupt for RDLH_LINK_UP_0\n");
+				break;
+			/* Phy link up/down indicator */
+			case SMLH_LINK_UP:
+				pr_info("Interrupt for SMLH_LINK_UP\n");
+				break;
+			case WAKE:
+				pr_info("Interrupt for WAKE\n");
+				break;
+			case COMPARE_END_CHECKER:
+				pr_info("Interrupt for COMPARE_END_CHECKER\n");
+				break;
+			default:
+				pr_info("Unknown Interrupt in IRQ2[%d]\n", bit_off);
+				break;
+			}
+			bit_off++;
+		}
+	}
+}
+
+static void handle_irq5_interrupts(u32 val, u32 is_en)
+{
+	u32 bit_off = 0;
+
+	if (val) {
+		while (bit_off < 32) {
+			if ((val & (0x1 << bit_off)) == 0 || (is_en &
+						(0x1 << bit_off)) == 0) {
+				bit_off++;
+				continue;
+			}
+			switch (bit_off) {
+			case LINK_REQ_RST_NOT:
+				pr_info("Interrupt for LINK_REQ_RST_NOT\n");
+				break;
+			case PM_LINKST_IN_L1SUB_1:
+				pr_info("Interrupt for L1 SUB state Exit\n");
+				break;
+			case RDLH_LINK_UP_1:
+				pr_info("Interrupt for RDLH_LINK_UP_1\n");
+				break;
+			/* Reset request because PHY link went down/ or got hot reset */
+			case SMLH_REQ_RST_NOT:
+				pr_info("Interrupt for SMLH_REQ_RST_NOT\n");
+				break;
+			default:
+				pr_info("Unknown Interrupt in IRQ5[%d]\n", bit_off);
+				break;
+			}
+			bit_off++;
+		}
+	}
+}
+
+/*
+ * fsd_pcie_sub_ctrl_handler : Interrupt handler for all PCIe interrupts.
+ *
+ * These interrupts trigger on different events happening in the PCIe
+ * controller like link status, link entering and exiting low power
+ * states like L0s, L1, DMA completion/abort interrupts, wake being
+ * triggered and other information.
+ *
+ * IRQ_0: (offset 0x0): IRQ for pulse output 1
+ *	Enable these interrupts at offset 0x10
+ * IRQ_1: (offset 0x4): IRQ for pulse output 2
+ *	Enable these interrupts at offset 0x14
+ * IRQ_2: (offset 0x8): IRQ for level output, rising edge
+ *	Enable these interrupts at offset 0x18
+ * IRQ_5: (offset 0xC): IRQ for level output, falling edge
+ *	Enable these interrupts at offset 0x1C
+ */
+
+static irqreturn_t fsd_pcie_sub_ctrl_handler(int irq, void *arg)
+{
+	u32 irq0, irq1, irq2, irq5;
+	struct fsd_pcie *fsd_ctrl = arg;
+	u32 irq0_en, irq1_en, irq2_en, irq5_en;
+
+	/* Read IRQ0 status */
+	irq0 = readl(fsd_ctrl->appl_base + IRQ0_STS);
+	/* Clear IRQ0 status after storing status value */
+	writel(irq0, fsd_ctrl->appl_base + IRQ0_STS);
+
+	/* Read IRQ1 status */
+	irq1 = readl(fsd_ctrl->appl_base + IRQ1_STS);
+	/* Clear IRQ1 status after storing status value */
+	writel(irq1, fsd_ctrl->appl_base + IRQ1_STS);
+
+	/* Read IRQ2 status */
+	irq2 = readl(fsd_ctrl->appl_base + IRQ2_STS);
+	/* Clear IRQ2 status after storing status value */
+	writel(irq2, fsd_ctrl->appl_base + IRQ2_STS);
+
+	/* Read IRQ5 status */
+	irq5 = readl(fsd_ctrl->appl_base + IRQ5_STS);
+	/* Clear IRQ5 status after storing status value */
+	writel(irq5, fsd_ctrl->appl_base + IRQ5_STS);
+
+	irq0_en = readl(fsd_ctrl->appl_base + IRQ0_EN);
+	irq1_en = readl(fsd_ctrl->appl_base + IRQ1_EN);
+	irq2_en = readl(fsd_ctrl->appl_base + IRQ2_EN);
+	irq5_en = readl(fsd_ctrl->appl_base + IRQ5_EN);
+	/* Handle all interrupts */
+	handle_irq0_interrupts(irq0, irq0_en);
+	handle_irq1_interrupts(irq1, irq1_en);
+	handle_irq2_interrupts(irq2, irq2_en);
+	handle_irq5_interrupts(irq5, irq5_en);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fsd_pcie_msi_irq_handler(int irq, void *arg)
+{
+	u32 val;
+	struct fsd_pcie *fsd_ctrl = arg;
+	struct dw_pcie *pci = fsd_ctrl->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+
+	val = readl(fsd_ctrl->appl_base + IRQ2_STS);
+
+	if ((val & IRQ_MSI_ENABLE) == IRQ_MSI_ENABLE) {
+		val &= IRQ_MSI_ENABLE;
+		writel(val, fsd_ctrl->appl_base + IRQ2_STS);
+		dw_handle_msi_irq(pp);
+	} else {
+		fsd_pcie_sub_ctrl_handler(irq, arg);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void fsd_pcie_msi_init(struct fsd_pcie *fsd_ctrl)
+{
+	int val;
+
+	/* enable MSI interrupt */
+	val = readl(fsd_ctrl->appl_base + IRQ2_EN);
+	val |= IRQ_MSI_ENABLE;
+	writel(val, fsd_ctrl->appl_base + IRQ2_EN);
+}
+
+static void fsd_pcie_enable_interrupts(struct fsd_pcie *fsd_ctrl)
+{
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		fsd_ctrl->pdata->irq_data->pcie_msi_init(fsd_ctrl);
+}
+
+static u32 fsd_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size)
+{
+	bool is_atu = false;
+	struct fsd_pcie *fsd_ctrl = to_fsd_pcie(pci);
+	u32 val;
+
+	if (pci->atu_base) {
+		if (base >= pci->atu_base) {
+
+			is_atu = true;
+			regmap_write(fsd_ctrl->sysreg, fsd_ctrl->sysreg_base,
+					ADDR_TYPE_ATU);
+			base = base - DEFAULT_DBI_ATU_OFFSET;
+		}
+	}
+
+	dw_pcie_read(base + reg, size, &val);
+
+	if (is_atu)
+		regmap_write(fsd_ctrl->sysreg, fsd_ctrl->sysreg_base, ADDR_TYPE_DBI);
+
+	return val;
+}
+
+static void fsd_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size, u32 val)
+{
+	struct fsd_pcie *fsd_ctrl = to_fsd_pcie(pci);
+	bool is_atu = false;
+
+	if (pci->atu_base) {
+		if (base >= pci->atu_base) {
+			is_atu = true;
+			regmap_write(fsd_ctrl->sysreg, fsd_ctrl->sysreg_base,
+					ADDR_TYPE_ATU);
+			base = base - DEFAULT_DBI_ATU_OFFSET;
+		}
+	}
+
+	dw_pcie_write(base + reg, size, val);
+
+	if (is_atu)
+		regmap_write(fsd_ctrl->sysreg, fsd_ctrl->sysreg_base, ADDR_TYPE_DBI);
+}
+
+static void fsd_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size, u32 val)
+{
+	struct fsd_pcie *fsd_ctrl = to_fsd_pcie(pci);
+
+	regmap_write(fsd_ctrl->sysreg, fsd_ctrl->sysreg_base, ADDR_TYPE_DBI2);
+	dw_pcie_write(pci->dbi_base + reg, size, val);
+	regmap_write(fsd_ctrl->sysreg, fsd_ctrl->sysreg_base, ADDR_TYPE_DBI);
+}
+
+static int fsd_pcie_link_up(struct dw_pcie *pci)
+{
+	u32 val;
+	struct fsd_pcie *fsd_ctrl = to_fsd_pcie(pci);
+
+	val = readl(fsd_ctrl->appl_base +
+			fsd_ctrl->pdata->appl_cxpl_debug_00_31);
+
+	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
+}
+
+static int fsd_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct fsd_pcie *fsd_ctrl = to_fsd_pcie(pci);
+
+	dw_pcie_writel_dbi(pci, PCIE_GEN3_RELATED_OFF,
+				(PCIE_GEN3_EQ_PHASE_2_3 |
+				 PCIE_GEN3_RXEQ_PH01_EN |
+				 PCIE_GEN3_RXEQ_RGRDLESS_RXTS));
+
+	fsd_pcie_enable_interrupts(fsd_ctrl);
+
+	return 0;
+}
+
+static struct dw_pcie_host_ops fsd_pcie_host_ops = {
+	.host_init = fsd_pcie_host_init,
+};
+
+static int fsd_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
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
+static const struct pci_epc_features fsd_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+	fsd_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &fsd_pcie_epc_features;
+}
+
+static struct dw_pcie_ep_ops fsd_dw_pcie_ep_ops = {
+	.raise_irq	= fsd_pcie_raise_irq,
+	.get_features	= fsd_pcie_get_features,
+};
+
+static const struct fsd_pcie_irq fsd_pcie_irq_data = {
+	.pcie_msi_irq_handler	= fsd_pcie_msi_irq_handler,
+	.pcie_msi_init		= fsd_pcie_msi_init,
+	.pcie_sub_ctrl_handler	= fsd_pcie_sub_ctrl_handler,
+};
+
+static int __init fsd_add_pcie_ep(struct fsd_pcie *fsd_ctrl,
+		struct platform_device *pdev)
+{
+	struct dw_pcie_ep *ep;
+	struct dw_pcie *pci = fsd_ctrl->pci;
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	ep = &pci->ep;
+	ep->ops = &fsd_dw_pcie_ep_ops;
+
+	dw_pcie_writel_dbi(pci, PCIE_GEN3_RELATED_OFF,
+				(PCIE_GEN3_EQUALIZATION_DISABLE |
+				 PCIE_GEN3_RXEQ_PH01_EN |
+				 PCIE_GEN3_RXEQ_RGRDLESS_RXTS));
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret)
+		dev_err(dev, "failed to initialize endpoint\n");
+
+	return ret;
+}
+
+static int __init fsd_add_pcie_port(struct fsd_pcie *fsd_ctrl,
+					struct platform_device *pdev)
+{
+	int irq;
+	struct device *dev = &pdev->dev;
+	int irq_flags;
+	int ret;
+	struct dw_pcie *pci = fsd_ctrl->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		irq = platform_get_irq_byname(pdev, "msi");
+		if (!irq) {
+			dev_err(dev, "failed to get msi irq\n");
+			return -ENODEV;
+		}
+
+		irq_flags = IRQF_TRIGGER_RISING | IRQF_SHARED | IRQF_NO_THREAD;
+
+		ret = devm_request_irq(dev, irq,
+					fsd_ctrl->pdata->irq_data->pcie_msi_irq_handler,
+					irq_flags, "fsd-pcie", fsd_ctrl);
+		if (ret) {
+			dev_err(dev, "failed to request msi irq\n");
+			return ret;
+		}
+		pp->msi_irq[0] = -ENODEV;
+	}
+
+	ret = dw_pcie_host_init(pp);
+	if (ret)
+		dev_err(dev, "failed to initialize host\n");
+
+	return ret;
+}
+
+static const struct dw_pcie_ops fsd_dw_pcie_ops = {
+	.read_dbi	= fsd_pcie_read_dbi,
+	.write_dbi	= fsd_pcie_write_dbi,
+	.write_dbi2	= fsd_pcie_write_dbi2,
+	.start_link	= fsd_pcie_establish_link,
+	.stop_link	= fsd_pcie_stop_link,
+	.link_up	= fsd_pcie_link_up,
+};
+
+static int fsd_pcie_probe(struct platform_device *pdev)
+{
+	int ret;
+	int irq, irq_flags;
+	struct dw_pcie *pci;
+	struct dw_pcie_rp *pp;
+	struct fsd_pcie *fsd_ctrl;
+	struct device *dev = &pdev->dev;
+	const struct fsd_pcie_pdata *pdata;
+	struct device_node *np = dev->of_node;
+
+	fsd_ctrl = devm_kzalloc(dev, sizeof(*fsd_ctrl), GFP_KERNEL);
+	if (!fsd_ctrl)
+		return -ENOMEM;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pdata = (const struct fsd_pcie_pdata *) of_device_get_match_data(dev);
+
+	fsd_ctrl->pci = pci;
+	fsd_ctrl->pdata = pdata;
+
+	pci->dev = dev;
+	pci->ops = pdata->dwc_ops;
+	pci->dbi_base2 = NULL;
+	pci->dbi_base = NULL;
+	pci->atu_base = NULL;
+	pp = &pci->pp;
+	pp->ops = fsd_ctrl->pdata->host_ops;
+
+	fsd_ctrl->phy = devm_of_phy_get(dev, np, NULL);
+	if (IS_ERR(fsd_ctrl->phy)) {
+		if (PTR_ERR(fsd_ctrl->phy) == -EPROBE_DEFER)
+			return PTR_ERR(fsd_ctrl->phy);
+	}
+
+	phy_init(fsd_ctrl->phy);
+
+	if (pdata->res_ops && pdata->res_ops->get_mem_resources) {
+		ret = pdata->res_ops->get_mem_resources(pdev, fsd_ctrl);
+		if (ret)
+			return ret;
+	}
+
+	if (pdata->res_ops && pdata->res_ops->get_clk_resources) {
+		ret = pdata->res_ops->get_clk_resources(pdev, fsd_ctrl);
+		if (ret)
+			return ret;
+		ret = pdata->res_ops->init_clk_resources(fsd_ctrl);
+		if (ret)
+			return ret;
+	}
+
+	platform_set_drvdata(pdev, fsd_ctrl);
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+	if (ret)
+		goto fail_dma_set;
+
+	switch (fsd_ctrl->pdata->op_mode) {
+	case DEVICE_TYPE_RC:
+		writel(DEVICE_TYPE_RC, fsd_ctrl->appl_base +
+					PCIE_FSD_DEVICE_TYPE);
+		ret = fsd_add_pcie_port(fsd_ctrl, pdev);
+		if (ret)
+			goto fail_add_pcie_port;
+		break;
+	case DEVICE_TYPE_EP:
+		writel(DEVICE_TYPE_EP, fsd_ctrl->appl_base +
+				PCIE_FSD_DEVICE_TYPE);
+
+		ret = fsd_add_pcie_ep(fsd_ctrl, pdev);
+		if (ret)
+			goto fail_add_pcie_ep;
+		break;
+	}
+
+	irq = platform_get_irq_byname(pdev, "sub_ctrl_intr");
+	if (irq > 0) {
+
+		irq_flags = IRQF_TRIGGER_RISING | IRQF_SHARED | IRQF_NO_THREAD;
+
+		ret = devm_request_irq(dev, irq,
+				fsd_ctrl->pdata->irq_data->pcie_sub_ctrl_handler,
+				irq_flags, "fsd-sub-ctrl-pcie", fsd_ctrl);
+		if (ret)
+			dev_err(dev, "failed to request sub ctrl irq\n");
+	}
+
+	dev_info(dev, "FSD PCIe probe completed successfully\n");
+
+	return 0;
+
+fail_dma_set:
+	dev_err(dev, "PCIe Failed to set 36 bit dma mask\n");
+fail_add_pcie_port:
+	phy_exit(fsd_ctrl->phy);
+fail_add_pcie_ep:
+	if (pdata->res_ops && pdata->res_ops->deinit_clk_resources)
+		pdata->res_ops->deinit_clk_resources(fsd_ctrl);
+	return ret;
+}
+
+static int __exit fsd_pcie_remove(struct platform_device *pdev)
+{
+	struct fsd_pcie *fsd_ctrl = platform_get_drvdata(pdev);
+	const struct fsd_pcie_pdata *pdata = fsd_ctrl->pdata;
+
+	if (pdata->res_ops && pdata->res_ops->deinit_clk_resources)
+		pdata->res_ops->deinit_clk_resources(fsd_ctrl);
+
+	return 0;
+}
+
+static const struct fsd_pcie_pdata fsd_pcie_rc_pdata = {
+	.dwc_ops		= &fsd_dw_pcie_ops,
+	.host_ops		= &fsd_pcie_host_ops,
+	.res_ops		= &fsd_pcie_res_ops_data,
+	.irq_data		= &fsd_pcie_irq_data,
+	.appl_cxpl_debug_00_31	= PCIE_ELBI_CXPL_DEBUG_00_31,
+	.op_mode		= DEVICE_TYPE_RC,
+};
+
+static const struct fsd_pcie_pdata fsd_pcie_ep_pdata = {
+	.dwc_ops		= &fsd_dw_pcie_ops,
+	.host_ops		= &fsd_pcie_host_ops,
+	.res_ops		= &fsd_pcie_res_ops_data,
+	.irq_data		= &fsd_pcie_irq_data,
+	.appl_cxpl_debug_00_31	= PCIE_ELBI_CXPL_DEBUG_00_31,
+	.op_mode		= DEVICE_TYPE_EP,
+};
+
+static const struct of_device_id fsd_pcie_of_match[] = {
+	{
+		.compatible = "tesla,fsd-pcie",
+		.data = (void *) &fsd_pcie_rc_pdata,
+	},
+	{
+		.compatible = "tesla,fsd-pcie-ep",
+		.data = (void *) &fsd_pcie_ep_pdata,
+	},
+
+	{},
+};
+
+static struct platform_driver fsd_pcie_driver = {
+	.probe		= fsd_pcie_probe,
+	.remove		= __exit_p(fsd_pcie_remove),
+	.driver		= {
+		.name	= "fsd-pcie",
+		.of_match_table = fsd_pcie_of_match,
+	},
+};
+
+static int __init fsd_pcie_init(void)
+{
+	return platform_driver_register(&fsd_pcie_driver);
+}
+module_init(fsd_pcie_init);
-- 
2.17.1

