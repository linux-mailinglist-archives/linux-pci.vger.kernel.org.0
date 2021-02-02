Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03FC30BF83
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhBBNdN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232357AbhBBNbb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:31:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED16864F63;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=gJX2uEjb5s4boXI8AdwwpgjMqG9is0PeuQ5sxwVLzHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqq/KxT9OgUzXakZZwjsuiQLsUTPxk2zk4jCy0pcEoU8SJIaTClg0CnfWq+3rqq67
         9hsxq/zXWE9BCJ3MEDWyMJgWamlsmV/GlhxxkAaIIIhTsRj7ZfLjVNqnyxUDiXo8wD
         kWCnhvc8dWAIlonNCfT03pp9Im7NIj+frkDRyFIRxmm+b+bKdVmOZiaWtT8t4BE03K
         zuZInaD6wISfgRGJRGuw30AVPmXw2Sj+BP8/DggDVNUYxQIsZK3fpk+Orjv/PKkDfy
         2pCLFNESXfQC583UYyvyFnt3NhoGZQlCSQq8jg3d+S7/zvcRKupENjlDYufJ2FKIbz
         JwYRiQLlbIWWg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011yt-It; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 04/13] pci: dwc: pcie-kirin: add HI3670 PCI-E controller support
Date:   Tue,  2 Feb 2021 14:29:49 +0100
Message-Id: <8d988a1cd73c7eae083f5e026a2db71070210fdb.1612271903.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612271903.git.mchehab+huawei@kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add HiSilicon HI3670 SoC PCI-E controller support based on Designware
PCI-E controller IP.

[mchehab+huawei@kernel.org: fix merge conflicts]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 723 +++++++++++++++++++++++-
 1 file changed, 707 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 026fd1e42a55..5925d2b345a8 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -29,6 +29,7 @@
 #define to_kirin_pcie(x) dev_get_drvdata((x)->dev)
 
 #define REF_CLK_FREQ			100000000
+#define AXI_CLK_FREQ			207500000
 
 /* PCIe ELBI registers */
 #define SOC_PCIECTRL_CTRL0_ADDR		0x000
@@ -60,6 +61,65 @@
 #define PCIE_DEBOUNCE_PARAM	0xF0F400
 #define PCIE_OE_BYPASS		(0x3 << 28)
 
+/* PCIe CTRL registers */
+#define SOC_PCIECTRL_CTRL0_ADDR   0x000
+#define SOC_PCIECTRL_CTRL1_ADDR   0x004
+#define SOC_PCIECTRL_CTRL7_ADDR   0x01c
+#define SOC_PCIECTRL_CTRL12_ADDR  0x030
+#define SOC_PCIECTRL_CTRL20_ADDR  0x050
+#define SOC_PCIECTRL_CTRL21_ADDR  0x054
+#define SOC_PCIECTRL_STATE0_ADDR  0x400
+
+/* PCIe PHY registers */
+#define SOC_PCIEPHY_CTRL0_ADDR    0x000
+#define SOC_PCIEPHY_CTRL1_ADDR    0x004
+#define SOC_PCIEPHY_CTRL2_ADDR    0x008
+#define SOC_PCIEPHY_CTRL3_ADDR    0x00c
+#define SOC_PCIEPHY_CTRL38_ADDR   0x0098
+#define SOC_PCIEPHY_STATE0_ADDR   0x400
+
+#define PCIE_LINKUP_ENABLE            (0x8020)
+#define PCIE_ELBI_SLV_DBI_ENABLE      (0x1 << 21)
+#define PCIE_LTSSM_ENABLE_BIT         (0x1 << 11)
+#define PCIEPHY_RESET_BIT             (0x1 << 17)
+#define PCIEPHY_PIPE_LINE0_RESET_BIT  (0x1 << 19)
+
+#define PORT_MSI_CTRL_ADDR            0x820
+#define PORT_MSI_CTRL_UPPER_ADDR      0x824
+#define PORT_MSI_CTRL_INT0_ENABLE     0x828
+
+#define EYEPARAM_NOCFG 0xFFFFFFFF
+#define RAWLANEN_DIG_PCS_XF_TX_OVRD_IN_1 0x3001
+#define SUP_DIG_LVL_OVRD_IN 0xf
+#define LANEN_DIG_ASIC_TX_OVRD_IN_1 0x1002
+#define LANEN_DIG_ASIC_TX_OVRD_IN_2 0x1003
+
+/* kirin970 pciephy register */
+#define SOC_PCIEPHY_MMC1PLL_CTRL1  0xc04
+#define SOC_PCIEPHY_MMC1PLL_CTRL16 0xC40
+#define SOC_PCIEPHY_MMC1PLL_CTRL17 0xC44
+#define SOC_PCIEPHY_MMC1PLL_CTRL20 0xC50
+#define SOC_PCIEPHY_MMC1PLL_CTRL21 0xC54
+#define SOC_PCIEPHY_MMC1PLL_STAT0  0xE00
+
+#define CRGPERIPH_PEREN12   0x470
+#define CRGPERIPH_PERDIS12  0x474
+#define CRGPERIPH_PCIECTRL0 0x800
+
+/* define ie,oe cfg */
+#define IO_IE_EN_HARD_BYPASS         (0x1 << 27)
+#define IO_OE_EN_HARD_BYPASS         (0x1 << 11)
+#define IO_HARD_CTRL_DEBOUNCE_BYPASS (0x1 << 10)
+#define IO_OE_GT_MODE                (0x2 << 7)
+#define DEBOUNCE_WAITCFG_IN          (0xf << 20)
+#define DEBOUNCE_WAITCFG_OUT         (0xf << 13)
+
+/* noc power domain */
+#define NOC_POWER_IDLEREQ_1 0x38c
+#define NOC_POWER_IDLE_1    0x394
+#define NOC_PW_MASK         0x10000
+#define NOC_PW_SET_BIT      0x1
+
 /* peri_crg ctrl */
 #define CRGCTRL_PCIE_ASSERT_OFFSET	0x88
 #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
@@ -84,12 +144,21 @@ struct kirin_pcie {
 	void __iomem	*phy_base;
 	struct regmap	*crgctrl;
 	struct regmap	*sysctrl;
+	struct regmap	*pmctrl;
 	struct clk	*apb_sys_clk;
 	struct clk	*apb_phy_clk;
 	struct clk	*phy_ref_clk;
 	struct clk	*pcie_aclk;
 	struct clk	*pcie_aux_clk;
-	int		gpio_id_reset;
+	int		gpio_id_reset[4];
+	int		gpio_id_clkreq[3];
+	u32		eye_param[5];
+};
+
+struct kirin_pcie_ops {
+	long (*get_resource)(struct kirin_pcie *kirin_pcie,
+			     struct platform_device *pdev);
+	int (*power_on)(struct kirin_pcie *kirin_pcie);
 };
 
 /* Registers in PCIeCTRL */
@@ -116,6 +185,28 @@ static inline u32 kirin_apb_phy_readl(struct kirin_pcie *kirin_pcie, u32 reg)
 	return readl(kirin_pcie->phy_base + reg);
 }
 
+static inline void kirin970_apb_phy_writel(struct kirin_pcie *kirin_pcie,
+					u32 val, u32 reg)
+{
+	writel(val, kirin_pcie->phy_base + 0x40000 + reg);
+}
+
+static inline u32 kirin970_apb_phy_readl(struct kirin_pcie *kirin_pcie, u32 reg)
+{
+	return readl(kirin_pcie->phy_base + 0x40000 + reg);
+}
+
+static inline void kirin_apb_natural_phy_writel(struct kirin_pcie *kirin_pcie,
+					u32 val, u32 reg)
+{
+	writel(val, kirin_pcie->phy_base + reg * 4);
+}
+
+static inline u32 kirin_apb_natural_phy_readl(struct kirin_pcie *kirin_pcie, u32 reg)
+{
+	return readl(kirin_pcie->phy_base + reg * 4);
+}
+
 static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 			       struct platform_device *pdev)
 {
@@ -144,9 +235,68 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 	return 0;
 }
 
-static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
-				    struct platform_device *pdev)
+void kirin970_pcie_get_eyeparam(struct kirin_pcie *pcie)
 {
+	struct device *dev = pcie->pci->dev;
+	int i;
+	struct device_node *np;
+
+	np = dev->of_node;
+
+	if (of_property_read_u32_array(np, "eye_param", pcie->eye_param, 5)) {
+		for (i = 0; i < 5; i++)
+		pcie->eye_param[i] = EYEPARAM_NOCFG;
+	}
+
+	dev_dbg(dev, "eye_param_vboost = [0x%x]\n", pcie->eye_param[0]);
+	dev_dbg(dev, "eye_param_iboost = [0x%x]\n", pcie->eye_param[1]);
+	dev_dbg(dev, "eye_param_pre = [0x%x]\n", pcie->eye_param[2]);
+	dev_dbg(dev, "eye_param_post = [0x%x]\n", pcie->eye_param[3]);
+	dev_dbg(dev, "eye_param_main = [0x%x]\n", pcie->eye_param[4]);
+}
+
+static void kirin970_pcie_set_eyeparam(struct kirin_pcie *kirin_pcie)
+{
+	u32 val;
+
+	val = kirin_apb_natural_phy_readl(kirin_pcie, RAWLANEN_DIG_PCS_XF_TX_OVRD_IN_1);
+
+	if (kirin_pcie->eye_param[1] != EYEPARAM_NOCFG) {
+		val &= (~0xf00);
+		val |= (kirin_pcie->eye_param[1] << 8) | (0x1 << 12);
+	}
+	kirin_apb_natural_phy_writel(kirin_pcie, val, RAWLANEN_DIG_PCS_XF_TX_OVRD_IN_1);
+
+	val = kirin_apb_natural_phy_readl(kirin_pcie, LANEN_DIG_ASIC_TX_OVRD_IN_2);
+	val &= (~0x1FBF);
+	if (kirin_pcie->eye_param[2] != EYEPARAM_NOCFG)
+		val |= (kirin_pcie->eye_param[2]<< 0) | (0x1 << 6);
+
+	if (kirin_pcie->eye_param[3] != EYEPARAM_NOCFG)
+		val |= (kirin_pcie->eye_param[3] << 7) | (0x1 << 13);
+
+	kirin_apb_natural_phy_writel(kirin_pcie, val, LANEN_DIG_ASIC_TX_OVRD_IN_2);
+
+	val = kirin_apb_natural_phy_readl(kirin_pcie, SUP_DIG_LVL_OVRD_IN);
+	if (kirin_pcie->eye_param[0] != EYEPARAM_NOCFG) {
+		val &= (~0x1C0);
+		val |= (kirin_pcie->eye_param[0] << 6) | (0x1 << 9);
+	}
+	kirin_apb_natural_phy_writel(kirin_pcie, val, SUP_DIG_LVL_OVRD_IN);
+
+	val = kirin_apb_natural_phy_readl(kirin_pcie, LANEN_DIG_ASIC_TX_OVRD_IN_1);
+	if (kirin_pcie->eye_param[4] != EYEPARAM_NOCFG) {
+		val &= (~0x7E00);
+		val |= (kirin_pcie->eye_param[4] << 9) | (0x1 << 15);
+	}
+	kirin_apb_natural_phy_writel(kirin_pcie, val, LANEN_DIG_ASIC_TX_OVRD_IN_1);
+}
+
+static long kirin960_pcie_get_resource(struct kirin_pcie *kirin_pcie,
+				       struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
 	kirin_pcie->apb_base =
 		devm_platform_ioremap_resource_byname(pdev, "apb");
 	if (IS_ERR(kirin_pcie->apb_base))
@@ -167,6 +317,122 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	if (IS_ERR(kirin_pcie->sysctrl))
 		return PTR_ERR(kirin_pcie->sysctrl);
 
+	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
+						      "reset-gpios", 0);
+	if (kirin_pcie->gpio_id_reset[0] < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
+static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
+				      struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *apb;
+	struct resource *phy;
+	struct resource *dbi;
+	int ret;
+
+	apb = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb");
+	kirin_pcie->apb_base = devm_ioremap_resource(dev, apb);
+	if (IS_ERR(kirin_pcie->apb_base))
+		return PTR_ERR(kirin_pcie->apb_base);
+
+	phy = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
+	kirin_pcie->phy_base = devm_ioremap_resource(dev, phy);
+	if (IS_ERR(kirin_pcie->phy_base))
+		return PTR_ERR(kirin_pcie->phy_base);
+
+	dbi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	kirin_pcie->pci->dbi_base = devm_ioremap_resource(dev, dbi);
+	if (IS_ERR(kirin_pcie->pci->dbi_base))
+		return PTR_ERR(kirin_pcie->pci->dbi_base);
+
+	kirin970_pcie_get_eyeparam(kirin_pcie);
+
+	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
+						"switch,reset-gpios", 0);
+	if (kirin_pcie->gpio_id_reset[0] < 0)
+		return -ENODEV;
+
+	kirin_pcie->gpio_id_reset[1] = of_get_named_gpio(dev->of_node,
+						"eth,reset-gpios", 0);
+	if (kirin_pcie->gpio_id_reset[1] < 0)
+		return -ENODEV;
+
+	kirin_pcie->gpio_id_reset[2] = of_get_named_gpio(dev->of_node,
+						"m_2,reset-gpios", 0);
+	if (kirin_pcie->gpio_id_reset[2] < 0)
+		return -ENODEV;
+
+	kirin_pcie->gpio_id_reset[3] = of_get_named_gpio(dev->of_node,
+						"mini1,reset-gpios", 0);
+	if (kirin_pcie->gpio_id_reset[3] < 0)
+		return -ENODEV;
+
+	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[0],
+				    "pcie_switch_reset");
+	if (ret)
+		return ret;
+	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[1],
+				    "pcie_eth_reset");
+	if (ret)
+		return ret;
+	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[2],
+				    "pcie_m_2_reset");
+	if (ret)
+		return ret;
+	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[3],
+				    "pcie_mini1_reset");
+	if (ret)
+		return ret;
+
+	kirin_pcie->gpio_id_clkreq[0] = of_get_named_gpio(dev->of_node,
+						"eth,clkreq-gpios", 0);
+	if (kirin_pcie->gpio_id_clkreq[0] < 0)
+		return -ENODEV;
+
+	kirin_pcie->gpio_id_clkreq[1] = of_get_named_gpio(dev->of_node,
+						"m_2,clkreq-gpios", 0);
+	if (kirin_pcie->gpio_id_clkreq[1] < 0)
+		return -ENODEV;
+
+	kirin_pcie->gpio_id_clkreq[2] = of_get_named_gpio(dev->of_node,
+						"mini1,clkreq-gpios", 0);
+	if (kirin_pcie->gpio_id_clkreq[2] < 0)
+		return -ENODEV;
+
+	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[0],
+				    "pcie_eth_clkreq");
+	if (ret)
+		return ret;
+
+	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[1],
+				    "pcie_m_2_clkreq");
+	if (ret)
+		return ret;
+
+	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[2],
+				    "pcie_mini1_clkreq");
+	if (ret)
+		return ret;
+
+	kirin_pcie->crgctrl =
+		syscon_regmap_lookup_by_compatible("hisilicon,hi3670-crgctrl");
+	if (IS_ERR(kirin_pcie->crgctrl))
+		return PTR_ERR(kirin_pcie->crgctrl);
+
+	kirin_pcie->sysctrl =
+		syscon_regmap_lookup_by_compatible("hisilicon,hi3670-sctrl");
+	if (IS_ERR(kirin_pcie->sysctrl))
+		return PTR_ERR(kirin_pcie->sysctrl);
+
+	kirin_pcie->pmctrl =
+		syscon_regmap_lookup_by_compatible("hisilicon,hi3670-pmctrl");
+	if (IS_ERR(kirin_pcie->sysctrl))
+		return PTR_ERR(kirin_pcie->sysctrl);
+
 	return 0;
 }
 
@@ -208,6 +474,21 @@ static void kirin_pcie_oe_enable(struct kirin_pcie *kirin_pcie)
 	regmap_write(kirin_pcie->sysctrl, SCTRL_PCIE_OE_OFFSET, val);
 }
 
+static int kirin970_pcie_clk_ctrl(struct clk *clk, int clk_on)
+{
+	int ret = 0;
+
+	if (clk_on) {
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+	} else {
+		clk_disable_unprepare(clk);
+	}
+
+	return ret;
+}
+
 static int kirin_pcie_clk_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
 {
 	int ret = 0;
@@ -255,7 +536,401 @@ static int kirin_pcie_clk_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
 	return ret;
 }
 
-static int kirin_pcie_power_on(struct kirin_pcie *kirin_pcie)
+static void kirin970_pcie_natural_cfg(struct kirin_pcie *kirin_pcie)
+{
+	u32 val;
+
+	/* change 2p mem_ctrl */
+	kirin_apb_ctrl_writel(kirin_pcie, 0x02605550, SOC_PCIECTRL_CTRL20_ADDR);
+
+	/* pull up sys_aux_pwr_det */
+	val = kirin_apb_ctrl_readl(kirin_pcie, SOC_PCIECTRL_CTRL7_ADDR);
+	val |= (0x1 << 10);
+	kirin_apb_ctrl_writel(kirin_pcie, val, SOC_PCIECTRL_CTRL7_ADDR);
+
+	/* output, pull down */
+	val = kirin_apb_ctrl_readl(kirin_pcie, SOC_PCIECTRL_CTRL12_ADDR);
+	val &= ~(0x3 << 2);
+	val |= (0x1 << 1);
+	val &= ~(0x1 << 0);
+	kirin_apb_ctrl_writel(kirin_pcie, val, SOC_PCIECTRL_CTRL12_ADDR);
+
+	/* Handle phy_reset and lane0_reset to HW */
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_CTRL1_ADDR);
+	val |= PCIEPHY_RESET_BIT;
+	val &= ~PCIEPHY_PIPE_LINE0_RESET_BIT;
+	kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_CTRL1_ADDR);
+
+	/* fix chip bug: TxDetectRx fail */
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_CTRL38_ADDR);
+	val |= (0x1 << 2);
+	kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_CTRL38_ADDR);
+}
+
+static void kirin970_pcie_pll_init(struct kirin_pcie *kirin_pcie)
+{
+	u32 val;
+
+	/* choose FNPLL */
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_CTRL1);
+	val |= (0x1 << 27);
+	kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_MMC1PLL_CTRL1);
+
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_CTRL16);
+	val &= 0xF000FFFF;
+	/* fnpll fbdiv = 0xD0 */
+	val |= (0xd0 << 16);
+	kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_MMC1PLL_CTRL16);
+
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_CTRL17);
+	val &= 0xFF000000;
+	/* fnpll fracdiv = 0x555555 */
+	val |= (0x555555 << 0);
+	kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_MMC1PLL_CTRL17);
+
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_CTRL20);
+	val &= 0xF5FF88FF;
+	/* fnpll dll_en = 0x1 */
+	val |= (0x1 << 27);
+	/* fnpll postdiv1 = 0x5 */
+	val |= (0x5 << 8);
+	/* fnpll postdiv2 = 0x4 */
+	val |= (0x4 << 12);
+	/* fnpll pll_mode = 0x0 */
+	val &= ~(0x1 << 25);
+	kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_MMC1PLL_CTRL20);
+
+	kirin970_apb_phy_writel(kirin_pcie, 0x20, SOC_PCIEPHY_MMC1PLL_CTRL21);
+}
+
+static int kirin970_pcie_pll_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
+{
+	struct device *dev = kirin_pcie->pci->dev;
+	u32 val;
+	int time = 200;
+
+	if (enable) {
+		/* pd = 0 */
+		val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_CTRL16);
+		val &= ~(0x1 << 0);
+		kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_MMC1PLL_CTRL16);
+
+		val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_STAT0);
+
+		/* choose FNPLL */
+		while (!(val & 0x10)) {
+			if (!time) {
+				dev_err(dev, "wait for pll_lock timeout\n");
+				return -1;
+			}
+			time --;
+			udelay(1);
+			val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_STAT0);
+		}
+
+		/* pciepll_bp = 0 */
+		val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_CTRL20);
+		val &= ~(0x1 << 16);
+		kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_MMC1PLL_CTRL20);
+
+	} else {
+		/* pd = 1 */
+		val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_CTRL16);
+		val |= (0x1 << 0);
+		kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_MMC1PLL_CTRL16);
+
+		/* pciepll_bp = 1 */
+		val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_MMC1PLL_CTRL20);
+		val |= (0x1 << 16);
+		kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_MMC1PLL_CTRL20);
+	}
+
+	 return 0;
+}
+
+static void kirin970_pcie_hp_debounce_gt(struct kirin_pcie *kirin_pcie, bool open)
+{
+	if (open)
+		/* gt_clk_pcie_hp/gt_clk_pcie_debounce open */
+		regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PEREN12, 0x9000);
+	else
+		/* gt_clk_pcie_hp/gt_clk_pcie_debounce close */
+		regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PERDIS12, 0x9000);
+}
+
+static void kirin970_pcie_phyref_gt(struct kirin_pcie *kirin_pcie, bool open)
+{
+	unsigned int val;
+
+	regmap_read(kirin_pcie->crgctrl, CRGPERIPH_PCIECTRL0, &val);
+
+	if (open)
+		val &= ~(0x1 << 1); //enable hard gt mode
+	else
+		val |= (0x1 << 1); //disable hard gt mode
+
+	regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PCIECTRL0, val);
+
+	/* disable soft gt mode */
+	regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PERDIS12, 0x4000);
+}
+
+static void kirin970_pcie_oe_ctrl(struct kirin_pcie *kirin_pcie, bool en_flag)
+{
+	unsigned int val;
+
+	regmap_read(kirin_pcie->crgctrl , CRGPERIPH_PCIECTRL0, &val);
+
+	/* set ie cfg */
+	val |= IO_IE_EN_HARD_BYPASS;
+
+	/* set oe cfg */
+	val &= ~IO_HARD_CTRL_DEBOUNCE_BYPASS;
+
+	/* set phy_debounce in&out time */
+	val |= (DEBOUNCE_WAITCFG_IN | DEBOUNCE_WAITCFG_OUT);
+
+	/* select oe_gt_mode */
+	val |= IO_OE_GT_MODE;
+
+	if (en_flag)
+		val &= ~IO_OE_EN_HARD_BYPASS;
+	else
+		val |= IO_OE_EN_HARD_BYPASS;
+
+	regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PCIECTRL0, val);
+}
+
+static void kirin970_pcie_ioref_gt(struct kirin_pcie *kirin_pcie, bool open)
+{
+	unsigned int val;
+
+	if (open) {
+		kirin_apb_ctrl_writel(kirin_pcie, 0x20000070, SOC_PCIECTRL_CTRL21_ADDR);
+
+		kirin970_pcie_oe_ctrl(kirin_pcie, true);
+
+		/* en hard gt mode */
+		regmap_read(kirin_pcie->crgctrl, CRGPERIPH_PCIECTRL0, &val);
+		val &= ~(0x1 << 0);
+		regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PCIECTRL0, val);
+
+		/* disable soft gt mode */
+		regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PERDIS12, 0x2000);
+
+	} else {
+		/* disable hard gt mode */
+		regmap_read(kirin_pcie->crgctrl, CRGPERIPH_PCIECTRL0, &val);
+		val |= (0x1 << 0);
+		regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PCIECTRL0, val);
+
+		/* disable soft gt mode */
+		regmap_write(kirin_pcie->crgctrl, CRGPERIPH_PERDIS12, 0x2000);
+
+		kirin970_pcie_oe_ctrl(kirin_pcie, false);
+       }
+}
+
+static int kirin970_pcie_allclk_ctrl(struct kirin_pcie *kirin_pcie, bool clk_on)
+{
+	struct device *dev = kirin_pcie->pci->dev;
+	u32 val;
+	int ret = 0;
+
+	if (!clk_on)
+		goto ALL_CLOSE;
+
+	/* choose 100MHz clk src: Bit[8]==1 pad, Bit[8]==0 pll */
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_CTRL1_ADDR);
+	val &= ~(0x1 << 8);
+	kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_CTRL1_ADDR);
+
+	kirin970_pcie_pll_init(kirin_pcie);
+
+	ret = kirin970_pcie_pll_ctrl(kirin_pcie, true);
+	if (ret) {
+		dev_err(dev, "Failed to enable pll\n");
+		return -1;
+	}
+	kirin970_pcie_hp_debounce_gt(kirin_pcie, true);
+	kirin970_pcie_phyref_gt(kirin_pcie, true);
+	kirin970_pcie_ioref_gt(kirin_pcie, true);
+
+	ret = clk_set_rate(kirin_pcie->pcie_aclk, AXI_CLK_FREQ);
+	if (ret) {
+		dev_err(dev, "Failed to set rate\n");
+		goto GT_CLOSE;
+	}
+
+	ret = kirin970_pcie_clk_ctrl(kirin_pcie->pcie_aclk, true);
+	if (ret) {
+		dev_err(dev, "Failed to enable pcie_aclk\n");
+		goto GT_CLOSE;
+	}
+
+	ret = kirin970_pcie_clk_ctrl(kirin_pcie->pcie_aux_clk, true);
+	if (ret) {
+		dev_err(dev, "Failed to enable pcie_aux_clk\n");
+		goto AUX_CLK_FAIL;
+	}
+
+	return 0;
+
+ALL_CLOSE:
+	kirin970_pcie_clk_ctrl(kirin_pcie->pcie_aux_clk, false);
+AUX_CLK_FAIL:
+	kirin970_pcie_clk_ctrl(kirin_pcie->pcie_aclk, false);
+GT_CLOSE:
+	kirin970_pcie_ioref_gt(kirin_pcie, false);
+	kirin970_pcie_phyref_gt(kirin_pcie, false);
+	kirin970_pcie_hp_debounce_gt(kirin_pcie, false);
+
+	kirin970_pcie_pll_ctrl(kirin_pcie, false);
+
+	return ret;
+}
+
+static bool is_pipe_clk_stable(struct kirin_pcie *kirin_pcie)
+{
+	struct device *dev = kirin_pcie->pci->dev;
+	u32 val;
+	u32 time = 100;
+	u32 pipe_clk_stable = 0x1 << 19;
+
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_STATE0_ADDR);
+	while (val & pipe_clk_stable) {
+		mdelay(1);
+		if (time == 0) {
+			dev_err(dev, "PIPE clk is not stable\n");
+			return false;
+		}
+		time--;
+		val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_STATE0_ADDR);
+	}
+
+	return true;
+}
+
+static int kirin970_pcie_noc_power(struct kirin_pcie *kirin_pcie, bool enable)
+{
+	struct device *dev = kirin_pcie->pci->dev;
+	u32 time = 100;
+	unsigned int val = NOC_PW_MASK;
+	int rst;
+
+	if (enable)
+		val = NOC_PW_MASK | NOC_PW_SET_BIT;
+	else
+		val = NOC_PW_MASK;
+	rst = enable ? 1 : 0;
+
+	regmap_write(kirin_pcie->pmctrl, NOC_POWER_IDLEREQ_1, val);
+
+	time = 100;
+	regmap_read(kirin_pcie->pmctrl, NOC_POWER_IDLE_1, &val);
+	while((val & NOC_PW_SET_BIT) != rst) {
+		udelay(10);
+		if (!time) {
+			dev_err(dev, "Failed to reverse noc power-status\n");
+			return -1;
+		}
+		time--;
+		regmap_read(kirin_pcie->pmctrl, NOC_POWER_IDLE_1, &val);
+	}
+
+	return 0;
+}
+
+static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
+{
+	struct device *dev = kirin_pcie->pci->dev;
+	int ret;
+	u32 val;
+
+	/* Power supply for Host */
+	regmap_write(kirin_pcie->sysctrl,
+		     SCTRL_PCIE_CMOS_OFFSET, SCTRL_PCIE_CMOS_BIT);
+	usleep_range(TIME_CMOS_MIN, TIME_CMOS_MAX);
+	kirin_pcie_oe_enable(kirin_pcie);
+
+	ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[0], 0);
+	if (ret)
+		dev_err(dev, "Failed to pulse eth clkreq signal\n");
+
+	ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[1], 0);
+	if (ret)
+		dev_err(dev, "Failed to pulse m.2 clkreq signal\n");
+
+	ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[2], 0);
+	if (ret)
+		dev_err(dev, "Failed to pulse mini1 clkreq signal\n");
+
+	ret = kirin_pcie_clk_ctrl(kirin_pcie, true);
+	if (ret)
+		return ret;
+
+	/* ISO disable, PCIeCtrl, PHY assert and clk gate clear */
+	regmap_write(kirin_pcie->sysctrl,
+		     SCTRL_PCIE_ISO_OFFSET, SCTRL_PCIE_ISO_BIT);
+	regmap_write(kirin_pcie->crgctrl,
+		     CRGCTRL_PCIE_ASSERT_OFFSET, CRGCTRL_PCIE_ASSERT_BIT);
+	regmap_write(kirin_pcie->sysctrl,
+		     SCTRL_PCIE_HPCLK_OFFSET, SCTRL_PCIE_HPCLK_BIT);
+
+	kirin970_pcie_natural_cfg(kirin_pcie);
+
+	ret = kirin970_pcie_allclk_ctrl(kirin_pcie, true);
+	if (ret)
+		goto close_clk;
+
+	/* pull down phy_test_powerdown signal */
+	val = kirin970_apb_phy_readl(kirin_pcie, SOC_PCIEPHY_CTRL0_ADDR);
+	val &= ~(0x1 << 22);
+	kirin970_apb_phy_writel(kirin_pcie, val, SOC_PCIEPHY_CTRL0_ADDR);
+
+	/* deassert controller perst_n */
+	val = kirin_apb_ctrl_readl(kirin_pcie, SOC_PCIECTRL_CTRL12_ADDR);
+	val |= (0x1 << 2);
+	kirin_apb_ctrl_writel(kirin_pcie, val, SOC_PCIECTRL_CTRL12_ADDR);
+	udelay(10);
+
+	/* perst assert Endpoints */
+	usleep_range(21000, 23000);
+	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[0], 1);
+	if (ret)
+		goto close_clk;
+
+	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[1], 1);
+	if (ret)
+		goto close_clk;
+
+	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[2], 1);
+	if (ret)
+		goto close_clk;
+
+	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[3], 1);
+	if (ret)
+		goto close_clk;
+
+	usleep_range(10000, 11000);
+
+	ret = is_pipe_clk_stable(kirin_pcie);
+	if (!ret)
+		goto close_clk;
+
+	kirin970_pcie_set_eyeparam(kirin_pcie);
+
+	ret = kirin970_pcie_noc_power(kirin_pcie, false);
+	if (ret)
+		goto close_clk;
+
+	return 0;
+close_clk:
+	kirin_pcie_clk_ctrl(kirin_pcie, false);
+	return ret;
+}
+
+static int kirin960_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
 	int ret;
 
@@ -282,9 +957,9 @@ static int kirin_pcie_power_on(struct kirin_pcie *kirin_pcie)
 		goto close_clk;
 
 	/* perst assert Endpoint */
-	if (!gpio_request(kirin_pcie->gpio_id_reset, "pcie_perst")) {
+	if (!gpio_request(kirin_pcie->gpio_id_reset[0], "pcie_perst")) {
 		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
-		ret = gpio_direction_output(kirin_pcie->gpio_id_reset, 1);
+		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[0], 1);
 		if (ret)
 			goto close_clk;
 		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
@@ -419,11 +1094,29 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
 	.host_init = kirin_pcie_host_init,
 };
 
+struct kirin_pcie_ops kirin960_pcie_ops = {
+	.get_resource = kirin960_pcie_get_resource,
+	.power_on = kirin960_pcie_power_on,
+};
+
+struct kirin_pcie_ops kirin970_pcie_ops = {
+	.get_resource = kirin970_pcie_get_resource,
+	.power_on = kirin970_pcie_power_on,
+};
+
+static const struct of_device_id kirin_pcie_match[] = {
+	{ .compatible = "hisilicon,kirin960-pcie", .data = &kirin960_pcie_ops },
+	{ .compatible = "hisilicon,kirin970-pcie", .data = &kirin970_pcie_ops },
+	{},
+};
+
 static int kirin_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct kirin_pcie *kirin_pcie;
 	struct dw_pcie *pci;
+	const struct of_device_id *of_id;
+	struct kirin_pcie_ops *ops;
 	int ret;
 
 	if (!dev->of_node) {
@@ -431,6 +1124,9 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	of_id = of_match_node(kirin_pcie_match, dev->of_node);
+	ops = (struct kirin_pcie_ops *)of_id->data;
+
 	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
 	if (!kirin_pcie)
 		return -ENOMEM;
@@ -448,20 +1144,20 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = kirin_pcie_get_resource(kirin_pcie, pdev);
+	ret = ops->get_resource(kirin_pcie, pdev);
 	if (ret)
 		return ret;
 
-	kirin_pcie->gpio_id_reset = of_get_named_gpio(dev->of_node,
+	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
 						      "reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset == -EPROBE_DEFER) {
+	if (kirin_pcie->gpio_id_reset[0] == -EPROBE_DEFER) {
 		return -EPROBE_DEFER;
-	} else if (!gpio_is_valid(kirin_pcie->gpio_id_reset)) {
+	} else if (!gpio_is_valid(kirin_pcie->gpio_id_reset[0])) {
 		dev_err(dev, "unable to get a valid gpio pin\n");
 		return -ENODEV;
 	}
 
-	ret = kirin_pcie_power_on(kirin_pcie);
+	ret = ops->power_on(kirin_pcie);
 	if (ret)
 		return ret;
 
@@ -470,11 +1166,6 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
-static const struct of_device_id kirin_pcie_match[] = {
-	{ .compatible = "hisilicon,kirin960-pcie" },
-	{},
-};
-
 static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
 	.driver			= {
-- 
2.29.2

