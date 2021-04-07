Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8635620D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbhDGDpF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:45:05 -0400
Received: from mo-csw-fb1515.securemx.jp ([210.130.202.171]:50090 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhDGDpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 23:45:05 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id 1373JBWC020770; Wed, 7 Apr 2021 12:19:11 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1373IliK011941; Wed, 7 Apr 2021 12:18:47 +0900
X-Iguazu-Qid: 34tMbaYFCU85j6pEYa
X-Iguazu-QSIG: v=2; s=0; t=1617765527; q=34tMbaYFCU85j6pEYa; m=A4Cle1xp0jGvPTv4bi29GOEwlWfJ0uFbRzwmah64oPo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 1373Ij4e024992
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 7 Apr 2021 12:18:46 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id A872D1000C9;
        Wed,  7 Apr 2021 12:18:45 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 1373IjN6001365;
        Wed, 7 Apr 2021 12:18:45 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 2/3] PCI: dwc: Visoconti: PCIe RC controller driver
Date:   Wed,  7 Apr 2021 12:18:38 +0900
X-TSB-HOP: ON
Message-Id: <20210407031839.386088-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to PCIe RC controller on Toshiba Visconti ARM SoCs.
PCIe controller is based of Synopsys DesignWare PCIe core.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/pci/controller/dwc/Kconfig         |  10 +
 drivers/pci/controller/dwc/Makefile        |   1 +
 drivers/pci/controller/dwc/pcie-visconti.c | 358 +++++++++++++++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b9aaa84452c4..ae125d7cf375 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -286,6 +286,16 @@ config PCIE_TEGRA194_EP
 	  in order to enable device-specific features PCIE_TEGRA194_EP must be
 	  selected. This uses the DesignWare core.
 
+config PCIE_VISCONTI
+	bool "Toshiba VISCONTI PCIe controllers"
+	depends on ARCH_VISCONTI || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
+	  This driver supports TMPV77xx.
+
 config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe host controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index ba7c42f6df6f..46ac5d49dc75 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PCI_MESON) += pci-meson.o
 obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
+obj-$(CONFIG_PCIE_VISCONTI) += pcie-visconti.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
new file mode 100644
index 000000000000..e24f83df41b8
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DWC PCIe RC driver for Toshiba Visconti ARM SoC
+ *
+ * Copyright (C) 2019, 2020 Toshiba Electronic Device & Storage Corporation
+ * Copyright (C) 2020, TOSHIBA CORPORATION
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+#include "../../pci.h"
+
+struct visconti_pcie {
+	struct dw_pcie *pci;
+	void __iomem *ulreg_base;
+	void __iomem *smu_base;
+	void __iomem *mpu_base;
+	struct clk *refclk;
+	struct clk *sysclk;
+	struct clk *auxclk;
+};
+
+#define PCIE_UL_REG_S_PCIE_MODE		0x00F4
+#define  PCIE_UL_REG_S_PCIE_MODE_EP	0x00
+#define  PCIE_UL_REG_S_PCIE_MODE_RC	0x04
+
+#define PCIE_UL_REG_S_PERSTN_CTRL	0x00F8
+#define  PCIE_UL_IOM_PCIE_PERSTN_I_EN	BIT(3)
+#define  PCIE_UL_DIRECT_PERSTN_EN	BIT(2)
+#define  PCIE_UL_PERSTN_OUT		BIT(1)
+#define  PCIE_UL_DIRECT_PERSTN		BIT(0)
+
+#define PCIE_UL_REG_S_PHY_INIT_02	0x0104
+#define  PCIE_UL_PHY0_SRAM_EXT_LD_DONE	BIT(0)
+
+#define PCIE_UL_REG_S_PHY_INIT_03	0x0108
+#define  PCIE_UL_PHY0_SRAM_INIT_DONE	BIT(0)
+
+#define PCIE_UL_REG_S_INT_EVENT_MASK1	0x0138
+#define  PCIE_UL_CFG_PME_INT		BIT(0)
+#define  PCIE_UL_CFG_LINK_EQ_REQ_INT	BIT(1)
+#define  PCIE_UL_EDMA_INT0		BIT(2)
+#define  PCIE_UL_EDMA_INT1		BIT(3)
+#define  PCIE_UL_EDMA_INT2		BIT(4)
+#define  PCIE_UL_EDMA_INT3		BIT(5)
+#define  PCIE_UL_S_INT_EVENT_MASK1_ALL  (PCIE_UL_CFG_PME_INT | PCIE_UL_CFG_LINK_EQ_REQ_INT | \
+					 PCIE_UL_EDMA_INT0 | PCIE_UL_EDMA_INT1 | \
+					 PCIE_UL_EDMA_INT2 | PCIE_UL_EDMA_INT3)
+
+#define PCIE_UL_REG_S_SB_MON		0x0198
+#define PCIE_UL_REG_S_SIG_MON		0x019C
+#define  PCIE_UL_CORE_RST_N_MON		BIT(0)
+
+#define PCIE_UL_REG_V_SII_DBG_00	0x0844
+#define PCIE_UL_REG_V_SII_GEN_CTRL_01	0x0860
+#define  PCIE_UL_APP_LTSSM_ENABLE	BIT(0)
+
+#define PCIE_UL_REG_V_PHY_ST_00		0x0864
+#define  PCIE_UL_SMLH_LINK_UP		BIT(0)
+
+#define PCIE_UL_REG_V_PHY_ST_02		0x0868
+#define  PCIE_UL_S_DETECT_ACT		0x01
+#define  PCIE_UL_S_L0			0x11
+
+#define PISMU_CKON_PCIE			0x0038
+#define  PISMU_CKON_PCIE_AUX_CLK	BIT(1)
+#define  PISMU_CKON_PCIE_MSTR_ACLK	BIT(0)
+
+#define PISMU_RSOFF_PCIE		0x0538
+#define  PISMU_RSOFF_PCIE_ULREG_RST_N	BIT(1)
+#define  PISMU_RSOFF_PCIE_PWR_UP_RST_N	BIT(0)
+
+#define PCIE_MPU_REG_MP_EN		0x0
+#define  MPU_MP_EN_DISABLE		BIT(0)
+
+#define PCIE_BUS_OFFSET			0x40000000
+
+/* Access registers in PCIe ulreg */
+static inline void visconti_ulreg_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
+{
+	writel(val, pcie->ulreg_base + reg);
+}
+
+/* Access registers in PCIe smu */
+static inline void visconti_smu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
+{
+	writel(val, pcie->smu_base + reg);
+}
+
+/* Access registers in PCIe mpu */
+static inline void visconti_mpu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
+{
+	writel(val, pcie->mpu_base + reg);
+}
+
+static inline u32 visconti_mpu_readl(struct visconti_pcie *pcie, u32 reg)
+{
+	return readl(pcie->mpu_base + reg);
+}
+
+static int visconti_pcie_check_link_status(struct visconti_pcie *pcie)
+{
+	int err;
+	u32 val;
+
+	/* wait for linkup of phy link layer */
+	err = readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_00, val,
+				 (val & PCIE_UL_SMLH_LINK_UP), 1000, 10000);
+	if (err)
+		return err;
+
+	/* wait for linkup of data link layer */
+	err = readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_02, val,
+				 (val & PCIE_UL_S_DETECT_ACT), 1000, 10000);
+	if (err)
+		return err;
+
+	/* wait for LTSSM Status */
+	return readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_02, val,
+				  (val & PCIE_UL_S_L0), 1000, 10000);
+}
+
+static int visconti_pcie_establish_link(struct pcie_port *pp)
+{
+	int ret;
+	u32 val;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
+
+	visconti_ulreg_writel(pcie, PCIE_UL_APP_LTSSM_ENABLE, PCIE_UL_REG_V_SII_GEN_CTRL_01);
+
+	ret = visconti_pcie_check_link_status(pcie);
+	if (ret < 0) {
+		dev_info(pci->dev, "Link failure\n");
+		return ret;
+	}
+
+	val = visconti_mpu_readl(pcie, PCIE_MPU_REG_MP_EN);
+	visconti_mpu_writel(pcie, val & ~MPU_MP_EN_DISABLE, PCIE_MPU_REG_MP_EN);
+
+	visconti_ulreg_writel(pcie, PCIE_UL_S_INT_EVENT_MASK1_ALL, PCIE_UL_REG_S_INT_EVENT_MASK1);
+
+	return 0;
+}
+
+static int visconti_pcie_host_init(struct pcie_port *pp)
+{
+	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	dw_pcie_setup_rc(pp);
+	ret = visconti_pcie_establish_link(pp);
+	if (ret < 0)
+		return ret;
+
+	dw_pcie_wait_for_link(pci);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops visconti_pcie_host_ops = {
+	.host_init = visconti_pcie_host_init,
+};
+
+static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
+{
+	return pci_addr - PCIE_BUS_OFFSET;
+}
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.cpu_addr_fixup = visconti_pcie_cpu_addr_fixup,
+};
+
+static int visconti_get_resources(struct platform_device *pdev,
+				  struct visconti_pcie *pcie)
+{
+	struct device *dev = &pdev->dev;
+
+	pcie->pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
+	if (IS_ERR(pcie->pci->dbi_base))
+		return PTR_ERR(pcie->pci->dbi_base);
+
+	pcie->ulreg_base = devm_platform_ioremap_resource_byname(pdev, "ulreg");
+	if (IS_ERR(pcie->ulreg_base))
+		return PTR_ERR(pcie->ulreg_base);
+
+	pcie->smu_base = devm_platform_ioremap_resource_byname(pdev, "smu");
+	if (IS_ERR(pcie->smu_base))
+		return PTR_ERR(pcie->smu_base);
+
+	pcie->mpu_base = devm_platform_ioremap_resource_byname(pdev, "mpu");
+	if (IS_ERR(pcie->mpu_base))
+		return PTR_ERR(pcie->mpu_base);
+
+	pcie->refclk = devm_clk_get(dev, "pcie_refclk");
+	if (IS_ERR(pcie->refclk)) {
+		dev_err(dev, "Failed to get refclk clock: %ld\n", PTR_ERR(pcie->refclk));
+		return PTR_ERR(pcie->refclk);
+	}
+
+	pcie->sysclk = devm_clk_get(dev, "sysclk");
+	if (IS_ERR(pcie->sysclk)) {
+		dev_err(dev, "Failed to get sysclk clock: %ld\n", PTR_ERR(pcie->sysclk));
+		return PTR_ERR(pcie->sysclk);
+	}
+
+	pcie->auxclk = devm_clk_get(dev, "auxclk");
+	if (IS_ERR(pcie->auxclk)) {
+		dev_err(dev, "Failed to get auxclk clock: %ld\n", PTR_ERR(pcie->auxclk));
+		return PTR_ERR(pcie->auxclk);
+	}
+
+	return 0;
+}
+
+static int visconti_device_turnon(struct visconti_pcie *pcie)
+{
+	int err;
+	u32 val;
+
+	visconti_smu_writel(pcie, PISMU_CKON_PCIE_AUX_CLK | PISMU_CKON_PCIE_MSTR_ACLK,
+			    PISMU_CKON_PCIE);
+	ndelay(250);
+
+	visconti_smu_writel(pcie, PISMU_RSOFF_PCIE_ULREG_RST_N, PISMU_RSOFF_PCIE);
+
+	visconti_ulreg_writel(pcie, PCIE_UL_REG_S_PCIE_MODE_RC, PCIE_UL_REG_S_PCIE_MODE);
+
+	val = PCIE_UL_IOM_PCIE_PERSTN_I_EN | PCIE_UL_DIRECT_PERSTN_EN | PCIE_UL_DIRECT_PERSTN;
+	visconti_ulreg_writel(pcie, val, PCIE_UL_REG_S_PERSTN_CTRL);
+	udelay(100);
+
+	val |= PCIE_UL_PERSTN_OUT;
+	visconti_ulreg_writel(pcie, val, PCIE_UL_REG_S_PERSTN_CTRL);
+	udelay(100);
+
+	visconti_smu_writel(pcie, PISMU_RSOFF_PCIE_PWR_UP_RST_N, PISMU_RSOFF_PCIE);
+
+	err = readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_S_PHY_INIT_03, val,
+				 (val & PCIE_UL_PHY0_SRAM_INIT_DONE), 100, 1000);
+	if (err)
+		return err;
+
+	visconti_ulreg_writel(pcie, PCIE_UL_PHY0_SRAM_EXT_LD_DONE, PCIE_UL_REG_S_PHY_INIT_02);
+
+	return readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_S_SIG_MON, val,
+				 (val & PCIE_UL_CORE_RST_N_MON), 100, 1000);
+}
+
+static int visconti_add_pcie_port(struct visconti_pcie *pcie, struct platform_device *pdev)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pp->irq = platform_get_irq_byname(pdev, "intr");
+	if (pp->irq < 0) {
+		dev_err(dev, "interrupt intr is missing");
+		return pp->irq;
+	}
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+		if (pp->msi_irq < 0) {
+			dev_err(dev, "interrupt msi is missing");
+			return pp->msi_irq;
+		}
+	}
+
+	pp->ops = &visconti_pcie_host_ops;
+
+	pci->link_gen = of_pci_get_max_link_speed(pdev->dev.of_node);
+	if (pci->link_gen < 0 || pci->link_gen > 3) {
+		pci->link_gen = 3;
+		dev_dbg(dev, "Applied default link speed\n");
+	}
+
+	dev_dbg(dev, "link speed Gen %d", pci->link_gen);
+
+	ret = visconti_device_turnon(pcie);
+	if (ret)
+		goto error;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret)
+		dev_err(dev, "Failed to initialize host\n");
+
+error:
+	return ret;
+}
+
+static int visconti_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct visconti_pcie *pcie;
+	struct pcie_port *pp;
+	struct dw_pcie *pci;
+	int ret;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+	if (ret)
+		return ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pp = &pci->pp;
+	pp->num_vectors = MAX_MSI_IRQS;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+	pcie->pci = pci;
+
+	ret = visconti_get_resources(pdev, pcie);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, pcie);
+
+	return visconti_add_pcie_port(pcie, pdev);
+}
+
+static const struct of_device_id visconti_pcie_match[] = {
+	{ .compatible = "toshiba,visconti-pcie" },
+	{},
+};
+
+static struct platform_driver visconti_pcie_driver = {
+	.probe = visconti_pcie_probe,
+	.driver = {
+		.name = "visconti-pcie",
+		.of_match_table = visconti_pcie_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_platform_driver(visconti_pcie_driver);
-- 
2.30.0.rc2

