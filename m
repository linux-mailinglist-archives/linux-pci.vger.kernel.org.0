Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE71774A3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 11:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgCCKzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 05:55:00 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1749 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgCCKy7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 05:54:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5e37740000>; Tue, 03 Mar 2020 02:54:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Mar 2020 02:54:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Mar 2020 02:54:58 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar
 2020 10:54:58 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Mar 2020 10:54:57 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e5e377d0001>; Tue, 03 Mar 2020 02:54:57 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 5/5] PCI: tegra: Add support for PCIe endpoint mode in Tegra194
Date:   Tue, 3 Mar 2020 16:24:18 +0530
Message-ID: <20200303105418.2840-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303105418.2840-1-vidyas@nvidia.com>
References: <20200303105418.2840-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583232884; bh=23Lo0kXD6udRnF80/QMO2+QXnGIEhefiPTd0X7339mg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=rQ7Ppy8NT6uHKi8i/lpUctwPF2aEeD9QensnxTMb4aTUlTY7lKCGwMqYX/wNzQchE
         lf9gdpFtcIk3tHLEn6AnlZ0TNDajI5I4MP6EU8h4iR7YFh/KLq5Yegg4nZxdvek3Ki
         z1vPSaM+j1HvQ+qyFAS+7ANxjhjLuyVAaxuDMCHkOL+MbZuXZBZDYYdg72/bDbkluO
         Pm/hBVoTE8PvEANcXGrdG+gqxWjda3ip+ZcQm8AXnjFcka1Mn/IUpVw+Qs43z9jTww
         9LF51pBXYGHRSxfHNHfrY2YiZyfU4YcoGNFvig3ObP5ZVRM5x3kMEsBXpQpi3BMwUW
         NjcX5NRGcDGLA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for the endpoint mode of Synopsys DesignWare core based
dual mode PCIe controllers present in Tegra194 SoC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Addressed Lorenzo's review comments
* Started using threaded irqs instead of kthreads

V3:
* Addressed Thierry's review comments

V2:
* Addressed Bjorn's review comments
* Made changes as part of addressing review comments for other patches

 drivers/pci/controller/dwc/Kconfig         |  30 +-
 drivers/pci/controller/dwc/pcie-tegra194.c | 681 ++++++++++++++++++++-
 2 files changed, 693 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0830dfcfa43a..169cde58dd92 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -248,14 +248,38 @@ config PCI_MESON
 	  implement the driver.
 
 config PCIE_TEGRA194
-	tristate "NVIDIA Tegra194 (and later) PCIe controller"
+	tristate
+
+config PCIE_TEGRA194_HOST
+	tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
 	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PHY_TEGRA194_P2U
+	select PCIE_TEGRA194
+	default y
+	help
+	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
+	  work in host mode. There are two instances of PCIe controllers in
+	  Tegra194. This controller can work either as EP or RC. In order to
+	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
+	  in order to enable device-specific features PCIE_TEGRA194_EP must be
+	  selected. This uses the DesignWare core.
+
+config PCIE_TEGRA194_EP
+	tristate "NVIDIA Tegra194 (and later) PCIe controller - Endpoint Mode"
+	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PHY_TEGRA194_P2U
+	select PCIE_TEGRA194
 	help
-	  Say Y here if you want support for DesignWare core based PCIe host
-	  controller found in NVIDIA Tegra194 SoC.
+	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
+	  work in host mode. There are two instances of PCIe controllers in
+	  Tegra194. This controller can work either as EP or RC. In order to
+	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
+	  in order to enable device-specific features PCIE_TEGRA194_EP must be
+	  selected. This uses the DesignWare core.
 
 config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe controllers"
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index cbe95f0ea0ca..81810e644b23 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -14,6 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -53,6 +55,7 @@
 #define APPL_INTR_EN_L0_0_LINK_STATE_INT_EN	BIT(0)
 #define APPL_INTR_EN_L0_0_MSI_RCV_INT_EN	BIT(4)
 #define APPL_INTR_EN_L0_0_INT_INT_EN		BIT(8)
+#define APPL_INTR_EN_L0_0_PCI_CMD_EN_INT_EN	BIT(15)
 #define APPL_INTR_EN_L0_0_CDM_REG_CHK_INT_EN	BIT(19)
 #define APPL_INTR_EN_L0_0_SYS_INTR_EN		BIT(30)
 #define APPL_INTR_EN_L0_0_SYS_MSI_INTR_EN	BIT(31)
@@ -60,19 +63,26 @@
 #define APPL_INTR_STATUS_L0			0xC
 #define APPL_INTR_STATUS_L0_LINK_STATE_INT	BIT(0)
 #define APPL_INTR_STATUS_L0_INT_INT		BIT(8)
+#define APPL_INTR_STATUS_L0_PCI_CMD_EN_INT	BIT(15)
+#define APPL_INTR_STATUS_L0_PEX_RST_INT		BIT(16)
 #define APPL_INTR_STATUS_L0_CDM_REG_CHK_INT	BIT(18)
 
 #define APPL_INTR_EN_L1_0_0				0x1C
 #define APPL_INTR_EN_L1_0_0_LINK_REQ_RST_NOT_INT_EN	BIT(1)
+#define APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN		BIT(3)
+#define APPL_INTR_EN_L1_0_0_HOT_RESET_DONE_INT_EN	BIT(30)
 
 #define APPL_INTR_STATUS_L1_0_0				0x20
 #define APPL_INTR_STATUS_L1_0_0_LINK_REQ_RST_NOT_CHGED	BIT(1)
+#define APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED	BIT(3)
+#define APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE		BIT(30)
 
 #define APPL_INTR_STATUS_L1_1			0x2C
 #define APPL_INTR_STATUS_L1_2			0x30
 #define APPL_INTR_STATUS_L1_3			0x34
 #define APPL_INTR_STATUS_L1_6			0x3C
 #define APPL_INTR_STATUS_L1_7			0x40
+#define APPL_INTR_STATUS_L1_15_CFG_BME_CHGED	BIT(1)
 
 #define APPL_INTR_EN_L1_8_0			0x44
 #define APPL_INTR_EN_L1_8_BW_MGT_INT_EN		BIT(2)
@@ -103,8 +113,12 @@
 #define APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMP_ERR	BIT(1)
 #define APPL_INTR_STATUS_L1_18_CDM_REG_CHK_LOGIC_ERR	BIT(0)
 
+#define APPL_MSI_CTRL_1				0xAC
+
 #define APPL_MSI_CTRL_2				0xB0
 
+#define APPL_LEGACY_INTX			0xB8
+
 #define APPL_LTR_MSG_1				0xC4
 #define LTR_MSG_REQ				BIT(15)
 #define LTR_MST_NO_SNOOP_SHIFT			16
@@ -205,6 +219,13 @@
 #define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFFFFFF	1
 #define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001	2
 
+#define MSIX_ADDR_MATCH_LOW_OFF			0x940
+#define MSIX_ADDR_MATCH_LOW_OFF_EN		BIT(0)
+#define MSIX_ADDR_MATCH_LOW_OFF_MASK		GENMASK(31, 2)
+
+#define MSIX_ADDR_MATCH_HIGH_OFF		0x944
+#define MSIX_ADDR_MATCH_HIGH_OFF_MASK		GENMASK(31, 0)
+
 #define PORT_LOGIC_MSIX_DOORBELL			0x948
 
 #define CAP_SPCIE_CAP_OFF			0x154
@@ -223,6 +244,13 @@
 #define GEN3_CORE_CLK_FREQ	250000000
 #define GEN4_CORE_CLK_FREQ	500000000
 
+#define LTR_MSG_TIMEOUT		(100 * 1000)
+
+#define PERST_DEBOUNCE_TIME	(5 * 1000)
+
+#define EP_STATE_DISABLED	0
+#define EP_STATE_ENABLED	1
+
 static const unsigned int pcie_gen_freq[] = {
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
@@ -260,6 +288,8 @@ struct tegra_pcie_dw {
 	struct dw_pcie pci;
 	struct tegra_bpmp *bpmp;
 
+	enum dw_pcie_device_mode mode;
+
 	bool supports_clkreq;
 	bool enable_cdm_check;
 	bool link_state;
@@ -283,6 +313,16 @@ struct tegra_pcie_dw {
 	struct phy **phys;
 
 	struct dentry *debugfs;
+
+	/* Endpoint mode specific */
+	struct gpio_desc *pex_rst_gpiod;
+	struct gpio_desc *pex_refclk_sel_gpiod;
+	unsigned int pex_rst_irq;
+	int ep_state;
+};
+
+struct tegra_pcie_dw_of_data {
+	enum dw_pcie_device_mode mode;
 };
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
@@ -339,8 +379,9 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
 	}
 }
 
-static irqreturn_t tegra_pcie_rp_irq_handler(struct tegra_pcie_dw *pcie)
+static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 {
+	struct tegra_pcie_dw *pcie = arg;
 	struct dw_pcie *pci = &pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	u32 val, tmp;
@@ -411,11 +452,121 @@ static irqreturn_t tegra_pcie_rp_irq_handler(struct tegra_pcie_dw *pcie)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t tegra_pcie_irq_handler(int irq, void *arg)
+static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
+{
+	u32 val;
+
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_1);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_2);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_3);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_6);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_7);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_8_0);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_9);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_10);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_11);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_13);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_14);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_15);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_17);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_MSI_CTRL_2);
+
+	val = appl_readl(pcie, APPL_CTRL);
+	val |= APPL_CTRL_LTSSM_EN;
+	appl_writel(pcie, val, APPL_CTRL);
+}
+
+static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
+	struct dw_pcie *pci = &pcie->pci;
+	u32 val, speed;
+
+	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
+		PCI_EXP_LNKSTA_CLS;
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	/* If EP doesn't advertise L1SS, just return */
+	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
+	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
+		return IRQ_HANDLED;
+
+	/* Check if BME is set to '1' */
+	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
+	if (val & PCI_COMMAND_MASTER) {
+		ktime_t timeout;
+
+		/* 110us for both snoop and no-snoop */
+		val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
+		val |= (val << LTR_MST_NO_SNOOP_SHIFT);
+		appl_writel(pcie, val, APPL_LTR_MSG_1);
+
+		/* Send LTR upstream */
+		val = appl_readl(pcie, APPL_LTR_MSG_2);
+		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
+		appl_writel(pcie, val, APPL_LTR_MSG_2);
+
+		timeout = ktime_add_us(ktime_get(), LTR_MSG_TIMEOUT);
+		for (;;) {
+			val = appl_readl(pcie, APPL_LTR_MSG_2);
+			if (!(val & APPL_LTR_MSG_2_LTR_MSG_REQ_STATE))
+				break;
+			if (ktime_after(ktime_get(), timeout))
+				break;
+			usleep_range(1000, 1100);
+		}
+		if (val & APPL_LTR_MSG_2_LTR_MSG_REQ_STATE)
+			dev_err(pcie->dev, "Failed to send LTR message\n");
+	}
 
-	return tegra_pcie_rp_irq_handler(pcie);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
+{
+	struct tegra_pcie_dw *pcie = arg;
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
+	int spurious = 1;
+	u32 val, tmp;
+
+	val = appl_readl(pcie, APPL_INTR_STATUS_L0);
+	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
+		val = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
+		appl_writel(pcie, val, APPL_INTR_STATUS_L1_0_0);
+
+		if (val & APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE)
+			pex_ep_event_hot_rst_done(pcie);
+
+		if (val & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
+			tmp = appl_readl(pcie, APPL_LINK_STATUS);
+			if (tmp & APPL_LINK_STATUS_RDLH_LINK_UP) {
+				dev_dbg(pcie->dev, "Link is up with Host\n");
+				dw_pcie_ep_linkup(ep);
+			}
+		}
+
+		spurious = 0;
+	}
+
+	if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
+		val = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
+		appl_writel(pcie, val, APPL_INTR_STATUS_L1_15);
+
+		if (val & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED)
+			return IRQ_WAKE_THREAD;
+
+		spurious = 0;
+	}
+
+	if (spurious) {
+		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
+			 val);
+		appl_writel(pcie, val, APPL_INTR_STATUS_L0);
+	}
+
+	return IRQ_HANDLED;
 }
 
 static int tegra_pcie_dw_rd_own_conf(struct pcie_port *pp, int where, int size,
@@ -884,8 +1035,26 @@ static void tegra_pcie_set_msi_vec_num(struct pcie_port *pp)
 	pp->num_vectors = MAX_MSI_IRQS;
 }
 
+static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
+{
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+
+	enable_irq(pcie->pex_rst_irq);
+
+	return 0;
+}
+
+static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
+{
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+
+	disable_irq(pcie->pex_rst_irq);
+}
+
 static const struct dw_pcie_ops tegra_dw_pcie_ops = {
 	.link_up = tegra_pcie_dw_link_up,
+	.start_link = tegra_pcie_dw_start_link,
+	.stop_link = tegra_pcie_dw_stop_link,
 };
 
 static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
@@ -986,6 +1155,26 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 	pcie->enable_cdm_check =
 		of_property_read_bool(np, "snps,enable-cdm-check");
 
+	if (pcie->mode == DW_PCIE_RC_TYPE)
+		return 0;
+
+	/* Endpoint mode specific DT entries */
+	pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
+	if (IS_ERR(pcie->pex_rst_gpiod)) {
+		dev_err(pcie->dev, "Failed to get PERST GPIO: %ld\n",
+			PTR_ERR(pcie->pex_rst_gpiod));
+		return PTR_ERR(pcie->pex_rst_gpiod);
+	}
+
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
+						    "nvidia,refclk-select",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
+		dev_info(pcie->dev, "Failed to get REFCLK select GPIOs: %ld\n",
+			 PTR_ERR(pcie->pex_refclk_sel_gpiod));
+		pcie->pex_refclk_sel_gpiod = NULL;
+	}
+
 	return 0;
 }
 
@@ -1017,6 +1206,34 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	return tegra_bpmp_transfer(pcie->bpmp, &msg);
 }
 
+static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
+					 bool enable)
+{
+	struct mrq_uphy_response resp;
+	struct tegra_bpmp_message msg;
+	struct mrq_uphy_request req;
+
+	memset(&req, 0, sizeof(req));
+	memset(&resp, 0, sizeof(resp));
+
+	if (enable) {
+		req.cmd = CMD_UPHY_PCIE_EP_CONTROLLER_PLL_INIT;
+		req.ep_ctrlr_pll_init.ep_controller = pcie->cid;
+	} else {
+		req.cmd = CMD_UPHY_PCIE_EP_CONTROLLER_PLL_OFF;
+		req.ep_ctrlr_pll_off.ep_controller = pcie->cid;
+	}
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_UPHY;
+	msg.tx.data = &req;
+	msg.tx.size = sizeof(req);
+	msg.rx.data = &resp;
+	msg.rx.size = sizeof(resp);
+
+	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+}
+
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 {
 	struct pcie_port *pp = &pcie->pci.pp;
@@ -1427,8 +1644,396 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 	return ret;
 }
 
+static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
+{
+	u32 val;
+	int ret;
+
+	if (pcie->ep_state == EP_STATE_DISABLED)
+		return;
+
+	/* Disable LTSSM */
+	val = appl_readl(pcie, APPL_CTRL);
+	val &= ~APPL_CTRL_LTSSM_EN;
+	appl_writel(pcie, val, APPL_CTRL);
+
+	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) >>
+				 APPL_DEBUG_LTSSM_STATE_SHIFT) ==
+				 LTSSM_STATE_PRE_DETECT,
+				 1, LTSSM_TIMEOUT);
+	if (ret)
+		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
+
+	reset_control_assert(pcie->core_rst);
+
+	tegra_pcie_disable_phy(pcie);
+
+	reset_control_assert(pcie->core_apb_rst);
+
+	clk_disable_unprepare(pcie->core_clk);
+
+	pm_runtime_put_sync(pcie->dev);
+
+	ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
+	if (ret)
+		dev_err(pcie->dev, "Failed to turn off UPHY: %d\n", ret);
+
+	pcie->ep_state = EP_STATE_DISABLED;
+	dev_dbg(pcie->dev, "Uninitialization of endpoint is completed\n");
+}
+
+static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_ep *ep = &pci->ep;
+	struct device *dev = pcie->dev;
+	u32 val;
+	int ret;
+
+	if (pcie->ep_state == EP_STATE_ENABLED)
+		return;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
+			ret);
+		return;
+	}
+
+	ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
+	if (ret) {
+		dev_err(dev, "Failed to init UPHY for PCIe EP: %d\n", ret);
+		goto fail_pll_init;
+	}
+
+	ret = clk_prepare_enable(pcie->core_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable core clock: %d\n", ret);
+		goto fail_core_clk_enable;
+	}
+
+	ret = reset_control_deassert(pcie->core_apb_rst);
+	if (ret) {
+		dev_err(dev, "Failed to deassert core APB reset: %d\n", ret);
+		goto fail_core_apb_rst;
+	}
+
+	ret = tegra_pcie_enable_phy(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to enable PHY: %d\n", ret);
+		goto fail_phy;
+	}
+
+	/* Clear any stale interrupt statuses */
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_1);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_2);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_3);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_6);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_7);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_8_0);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_9);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_10);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_11);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_13);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_14);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_15);
+	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_17);
+
+	/* configure this core for EP mode operation */
+	val = appl_readl(pcie, APPL_DM_TYPE);
+	val &= ~APPL_DM_TYPE_MASK;
+	val |= APPL_DM_TYPE_EP;
+	appl_writel(pcie, val, APPL_DM_TYPE);
+
+	appl_writel(pcie, 0x0, APPL_CFG_SLCG_OVERRIDE);
+
+	val = appl_readl(pcie, APPL_CTRL);
+	val |= APPL_CTRL_SYS_PRE_DET_STATE;
+	val |= APPL_CTRL_HW_HOT_RST_EN;
+	appl_writel(pcie, val, APPL_CTRL);
+
+	val = appl_readl(pcie, APPL_CFG_MISC);
+	val |= APPL_CFG_MISC_SLV_EP_MODE;
+	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
+	appl_writel(pcie, val, APPL_CFG_MISC);
+
+	val = appl_readl(pcie, APPL_PINMUX);
+	val |= APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN;
+	val |= APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE;
+	appl_writel(pcie, val, APPL_PINMUX);
+
+	appl_writel(pcie, pcie->dbi_res->start & APPL_CFG_BASE_ADDR_MASK,
+		    APPL_CFG_BASE_ADDR);
+
+	appl_writel(pcie, pcie->atu_dma_res->start &
+		    APPL_CFG_IATU_DMA_BASE_ADDR_MASK,
+		    APPL_CFG_IATU_DMA_BASE_ADDR);
+
+	val = appl_readl(pcie, APPL_INTR_EN_L0_0);
+	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
+	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
+	val |= APPL_INTR_EN_L0_0_PCI_CMD_EN_INT_EN;
+	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
+
+	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
+	val |= APPL_INTR_EN_L1_0_0_HOT_RESET_DONE_INT_EN;
+	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
+	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
+
+	reset_control_deassert(pcie->core_rst);
+
+	if (pcie->update_fc_fixup) {
+		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
+		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
+		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
+	}
+
+	config_gen3_gen4_eq_presets(pcie);
+
+	init_host_aspm(pcie);
+
+	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
+	if (!pcie->supports_clkreq) {
+		disable_aspm_l11(pcie);
+		disable_aspm_l12(pcie);
+	}
+
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+
+	/* Configure N_FTS & FTS */
+	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
+	val &= ~(N_FTS_MASK << N_FTS_SHIFT);
+	val |= N_FTS_VAL << N_FTS_SHIFT;
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
+
+	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_GEN2_CTRL);
+	val &= ~FTS_MASK;
+	val |= FTS_VAL;
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
+
+	/* Configure Max Speed from DT */
+	if (pcie->max_speed && pcie->max_speed != -EINVAL) {
+		val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
+					PCI_EXP_LNKCAP);
+		val &= ~PCI_EXP_LNKCAP_SLS;
+		val |= pcie->max_speed;
+		dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP,
+				   val);
+	}
+
+	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
+						      PCI_CAP_ID_EXP);
+	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
+
+	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
+	val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
+	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
+	val = (lower_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
+	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
+
+	ret = dw_pcie_ep_init_complete(ep);
+	if (ret) {
+		dev_err(dev, "Failed to complete initialization: %d\n", ret);
+		goto fail_init_complete;
+	}
+
+	dw_pcie_ep_init_notify(ep);
+
+	/* Enable LTSSM */
+	val = appl_readl(pcie, APPL_CTRL);
+	val |= APPL_CTRL_LTSSM_EN;
+	appl_writel(pcie, val, APPL_CTRL);
+
+	pcie->ep_state = EP_STATE_ENABLED;
+	dev_dbg(dev, "Initialization of endpoint is completed\n");
+
+	return;
+
+fail_init_complete:
+	reset_control_assert(pcie->core_rst);
+	tegra_pcie_disable_phy(pcie);
+fail_phy:
+	reset_control_assert(pcie->core_apb_rst);
+fail_core_apb_rst:
+	clk_disable_unprepare(pcie->core_clk);
+fail_core_clk_enable:
+	tegra_pcie_bpmp_set_pll_state(pcie, false);
+fail_pll_init:
+	pm_runtime_put_sync(dev);
+}
+
+static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
+{
+	struct tegra_pcie_dw *pcie = arg;
+
+	if (gpiod_get_value(pcie->pex_rst_gpiod))
+		pex_ep_event_pex_rst_assert(pcie);
+	else
+		pex_ep_event_pex_rst_deassert(pcie);
+
+	return IRQ_HANDLED;
+}
+
+static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
+{
+	/* Tegra194 supports only INTA */
+	if (irq > 1)
+		return -EINVAL;
+
+	appl_writel(pcie, 1, APPL_LEGACY_INTX);
+	usleep_range(1000, 2000);
+	appl_writel(pcie, 0, APPL_LEGACY_INTX);
+	return 0;
+}
+
+static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
+{
+	if (unlikely(irq > 31))
+		return -EINVAL;
+
+	appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
+
+	return 0;
+}
+
+static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie, u16 irq)
+{
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
+
+	writel(irq, ep->msi_mem);
+
+	return 0;
+}
+
+static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				   enum pci_epc_irq_type type,
+				   u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
+
+	case PCI_EPC_IRQ_MSI:
+		return tegra_pcie_ep_raise_msi_irq(pcie, interrupt_num);
+
+	case PCI_EPC_IRQ_MSIX:
+		return tegra_pcie_ep_raise_msix_irq(pcie, interrupt_num);
+
+	default:
+		dev_err(pci->dev, "Unknown IRQ type\n");
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static const struct pci_epc_features tegra_pcie_epc_features = {
+	.linkup_notifier = true,
+	.core_init_notifier = true,
+	.msi_capable = false,
+	.msix_capable = false,
+	.reserved_bar = 1 << BAR_2 | 1 << BAR_3 | 1 << BAR_4 | 1 << BAR_5,
+	.bar_fixed_64bit = 1 << BAR_0,
+	.bar_fixed_size[0] = SZ_1M,
+};
+
+static const struct pci_epc_features*
+tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
+{
+	return &tegra_pcie_epc_features;
+}
+
+static struct dw_pcie_ep_ops pcie_ep_ops = {
+	.raise_irq = tegra_pcie_ep_raise_irq,
+	.get_features = tegra_pcie_ep_get_features,
+};
+
+static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
+				struct platform_device *pdev)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct device *dev = pcie->dev;
+	struct dw_pcie_ep *ep;
+	struct resource *res;
+	char *name;
+	int ret;
+
+	ep = &pci->ep;
+	ep->ops = &pcie_ep_ops;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+	ep->page_size = SZ_64K;
+
+	ret = gpiod_set_debounce(pcie->pex_rst_gpiod, PERST_DEBOUNCE_TIME);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set PERST GPIO debounce time: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = gpiod_to_irq(pcie->pex_rst_gpiod);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get IRQ for PERST GPIO: %d\n", ret);
+		return ret;
+	}
+	pcie->pex_rst_irq = (unsigned int)ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "tegra_pcie_%u_pex_rst_irq",
+			      pcie->cid);
+	if (!name) {
+		dev_err(dev, "Failed to create PERST IRQ string\n");
+		return -ENOMEM;
+	}
+
+	irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
+
+	pcie->ep_state = EP_STATE_DISABLED;
+
+	ret = devm_request_threaded_irq(dev, pcie->pex_rst_irq, NULL,
+					tegra_pcie_ep_pex_rst_irq,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					name, (void *)pcie);
+	if (ret < 0) {
+		dev_err(dev, "Failed to request IRQ for PERST: %d\n", ret);
+		return ret;
+	}
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "tegra_pcie_%u_ep_work",
+			      pcie->cid);
+	if (!name) {
+		dev_err(dev, "Failed to create PCIe EP work thread string\n");
+		return -ENOMEM;
+	}
+
+	pm_runtime_enable(dev);
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "Failed to initialize DWC Endpoint subsystem: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int tegra_pcie_dw_probe(struct platform_device *pdev)
 {
+	const struct tegra_pcie_dw_of_data *data;
 	struct device *dev = &pdev->dev;
 	struct resource *atu_dma_res;
 	struct tegra_pcie_dw *pcie;
@@ -1440,6 +2045,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	int ret;
 	u32 i;
 
+	data = of_device_get_match_data(dev);
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1449,6 +2056,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pci->ops = &tegra_dw_pcie_ops;
 	pp = &pci->pp;
 	pcie->dev = &pdev->dev;
+	pcie->mode = (enum dw_pcie_device_mode)data->mode;
 
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
@@ -1462,6 +2070,9 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (pcie->pex_refclk_sel_gpiod)
+		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 1);
+
 	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
 	if (IS_ERR(pcie->pex_ctl_supply)) {
 		ret = PTR_ERR(pcie->pex_ctl_supply);
@@ -1557,24 +2168,49 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = devm_request_irq(dev, pp->irq, tegra_pcie_irq_handler,
-			       IRQF_SHARED, "tegra-pcie-intr", pcie);
-	if (ret) {
-		dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq, ret);
-		return ret;
-	}
-
 	pcie->bpmp = tegra_bpmp_get(dev);
 	if (IS_ERR(pcie->bpmp))
 		return PTR_ERR(pcie->bpmp);
 
 	platform_set_drvdata(pdev, pcie);
 
-	ret = tegra_pcie_config_rp(pcie);
-	if (ret && ret != -ENOMEDIUM)
-		goto fail;
-	else
-		return 0;
+	switch (pcie->mode) {
+	case DW_PCIE_RC_TYPE:
+		ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
+				       IRQF_SHARED, "tegra-pcie-intr", pcie);
+		if (ret) {
+			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
+				ret);
+			goto fail;
+		}
+
+		ret = tegra_pcie_config_rp(pcie);
+		if (ret && ret != -ENOMEDIUM)
+			goto fail;
+		else
+			return 0;
+		break;
+
+	case DW_PCIE_EP_TYPE:
+		ret = devm_request_threaded_irq(dev, pp->irq,
+						tegra_pcie_ep_hard_irq,
+						tegra_pcie_ep_irq_thread,
+						IRQF_SHARED | IRQF_ONESHOT,
+						"tegra-pcie-ep-intr", pcie);
+		if (ret) {
+			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
+				ret);
+			goto fail;
+		}
+
+		ret = tegra_pcie_config_ep(pcie, pdev);
+		if (ret < 0)
+			goto fail;
+		break;
+
+	default:
+		dev_err(dev, "Invalid PCIe device type %d\n", pcie->mode);
+	}
 
 fail:
 	tegra_bpmp_put(pcie->bpmp);
@@ -1593,6 +2229,8 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(pcie->dev);
 	pm_runtime_disable(pcie->dev);
 	tegra_bpmp_put(pcie->bpmp);
+	if (pcie->pex_refclk_sel_gpiod)
+		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
 
 	return 0;
 }
@@ -1697,9 +2335,22 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 	__deinit_controller(pcie);
 }
 
+static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct tegra_pcie_dw_of_data tegra_pcie_dw_ep_of_data = {
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static const struct of_device_id tegra_pcie_dw_of_match[] = {
 	{
 		.compatible = "nvidia,tegra194-pcie",
+		.data = &tegra_pcie_dw_rc_of_data,
+	},
+	{
+		.compatible = "nvidia,tegra194-pcie-ep",
+		.data = &tegra_pcie_dw_ep_of_data,
 	},
 	{},
 };
-- 
2.17.1

