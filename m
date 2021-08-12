Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13423EA028
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhHLIEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 04:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234974AbhHLIC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 04:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B42C6103A;
        Thu, 12 Aug 2021 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628755345;
        bh=ZYZYgbYECY4DjOExLjPk/HdYsGhlh57BZFBz2PbuKSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDatje45MmitwaS1aOIn6gKgcN6MSIueo71+HEBrDyE31cSGUhYNneaYbS7Lh6rAI
         LoAL+eS+7NJw+/MEv5EFf2NdSOva23muY4WLFDOnS4E3ksFchjs/m1NNuU6wM6mE3R
         YqyezZGq8COmC0k5tD1EawI2AyuLb6KrDmQr6UwuMfMNu6EgjYxyVIsOoBkDv34nxp
         OXF00Iw+CrWAXRcskj6OgfzsQE2YmiucABPczz46OWpWvoRvEfiN/fv6ZNulQRReWR
         2iEPfHhDgVaZ5WeTDWwcK/qw63tIBPM8h3n8K8B5s2jSz+IZPUx1E4gc6wAZXwGDD7
         BWbCdLXophmRA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5fT-00DZCm-Il; Thu, 12 Aug 2021 10:02:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v11 02/11] PCI: kirin: Reorganize the PHY logic inside the driver
Date:   Thu, 12 Aug 2021 10:02:13 +0200
Message-Id: <0f733720fc256579b76fd17e4f5b21f1c234f248.1628755058.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628755058.git.mchehab+huawei@kernel.org>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie-kirin PCIe driver contains internally a PHY interface for
Kirin 960.

As the next patches will add support for using an external PHY
driver, reorganize the driver in a way that the PHY part
will be self-contained.

This could be moved to a separate PHY driver, but a change
like that would mean a non-backward-compatible DT schema
change.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 298 ++++++++++++++----------
 1 file changed, 173 insertions(+), 125 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 026fd1e42a55..b4063a3434df 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -28,26 +28,16 @@
 
 #define to_kirin_pcie(x) dev_get_drvdata((x)->dev)
 
-#define REF_CLK_FREQ			100000000
-
 /* PCIe ELBI registers */
 #define SOC_PCIECTRL_CTRL0_ADDR		0x000
 #define SOC_PCIECTRL_CTRL1_ADDR		0x004
-#define SOC_PCIEPHY_CTRL2_ADDR		0x008
-#define SOC_PCIEPHY_CTRL3_ADDR		0x00c
 #define PCIE_ELBI_SLV_DBI_ENABLE	(0x1 << 21)
 
 /* info located in APB */
 #define PCIE_APP_LTSSM_ENABLE	0x01c
-#define PCIE_APB_PHY_CTRL0	0x0
-#define PCIE_APB_PHY_CTRL1	0x4
 #define PCIE_APB_PHY_STATUS0	0x400
 #define PCIE_LINKUP_ENABLE	(0x8020)
 #define PCIE_LTSSM_ENABLE_BIT	(0x1 << 11)
-#define PIPE_CLK_STABLE		(0x1 << 19)
-#define PHY_REF_PAD_BIT		(0x1 << 8)
-#define PHY_PWR_DOWN_BIT	(0x1 << 22)
-#define PHY_RST_ACK_BIT		(0x1 << 16)
 
 /* info located in sysctrl */
 #define SCTRL_PCIE_CMOS_OFFSET	0x60
@@ -60,6 +50,29 @@
 #define PCIE_DEBOUNCE_PARAM	0xF0F400
 #define PCIE_OE_BYPASS		(0x3 << 28)
 
+struct kirin_pcie {
+	struct dw_pcie	*pci;
+	struct phy	*phy;
+	void __iomem	*apb_base;
+	void		*phy_priv;	/* Needed for Kirin 960 PHY */
+};
+
+/*
+ * Kirin 960 PHY. Can't be split into a PHY driver without changing the
+ * DT schema.
+ */
+
+#define REF_CLK_FREQ			100000000
+
+/* PHY info located in APB */
+#define PCIE_APB_PHY_CTRL0	0x0
+#define PCIE_APB_PHY_CTRL1	0x4
+#define PCIE_APB_PHY_STATUS0   0x400
+#define PIPE_CLK_STABLE		BIT(19)
+#define PHY_REF_PAD_BIT		BIT(8)
+#define PHY_PWR_DOWN_BIT	BIT(22)
+#define PHY_RST_ACK_BIT		BIT(16)
+
 /* peri_crg ctrl */
 #define CRGCTRL_PCIE_ASSERT_OFFSET	0x88
 #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
@@ -69,8 +82,6 @@
 #define REF_2_PERST_MAX		25000
 #define PERST_2_ACCESS_MIN	10000
 #define PERST_2_ACCESS_MAX	12000
-#define LINK_WAIT_MIN		900
-#define LINK_WAIT_MAX		1000
 #define PIPE_CLK_WAIT_MIN	550
 #define PIPE_CLK_WAIT_MAX	600
 #define TIME_CMOS_MIN		100
@@ -78,118 +89,112 @@
 #define TIME_PHY_PD_MIN		10
 #define TIME_PHY_PD_MAX		11
 
-struct kirin_pcie {
-	struct dw_pcie	*pci;
-	void __iomem	*apb_base;
-	void __iomem	*phy_base;
+struct hi3660_pcie_phy {
+	struct device	*dev;
+	void __iomem	*base;
 	struct regmap	*crgctrl;
 	struct regmap	*sysctrl;
 	struct clk	*apb_sys_clk;
 	struct clk	*apb_phy_clk;
 	struct clk	*phy_ref_clk;
-	struct clk	*pcie_aclk;
-	struct clk	*pcie_aux_clk;
+	struct clk	*aclk;
+	struct clk	*aux_clk;
 	int		gpio_id_reset;
 };
 
-/* Registers in PCIeCTRL */
-static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
-					 u32 val, u32 reg)
-{
-	writel(val, kirin_pcie->apb_base + reg);
-}
-
-static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
-{
-	return readl(kirin_pcie->apb_base + reg);
-}
-
 /* Registers in PCIePHY */
-static inline void kirin_apb_phy_writel(struct kirin_pcie *kirin_pcie,
+static inline void kirin_apb_phy_writel(struct hi3660_pcie_phy *hi3660_pcie_phy,
 					u32 val, u32 reg)
 {
-	writel(val, kirin_pcie->phy_base + reg);
+	writel(val, hi3660_pcie_phy->base + reg);
 }
 
-static inline u32 kirin_apb_phy_readl(struct kirin_pcie *kirin_pcie, u32 reg)
+static inline u32 kirin_apb_phy_readl(struct hi3660_pcie_phy *hi3660_pcie_phy,
+				      u32 reg)
 {
-	return readl(kirin_pcie->phy_base + reg);
+	return readl(hi3660_pcie_phy->base + reg);
 }
 
-static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
-			       struct platform_device *pdev)
+static int hi3660_pcie_phy_get_clk(struct hi3660_pcie_phy *phy)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = phy->dev;
 
-	kirin_pcie->phy_ref_clk = devm_clk_get(dev, "pcie_phy_ref");
-	if (IS_ERR(kirin_pcie->phy_ref_clk))
-		return PTR_ERR(kirin_pcie->phy_ref_clk);
+	phy->phy_ref_clk = devm_clk_get(dev, "pcie_phy_ref");
+	if (IS_ERR(phy->phy_ref_clk))
+		return PTR_ERR(phy->phy_ref_clk);
 
-	kirin_pcie->pcie_aux_clk = devm_clk_get(dev, "pcie_aux");
-	if (IS_ERR(kirin_pcie->pcie_aux_clk))
-		return PTR_ERR(kirin_pcie->pcie_aux_clk);
+	phy->aux_clk = devm_clk_get(dev, "pcie_aux");
+	if (IS_ERR(phy->aux_clk))
+		return PTR_ERR(phy->aux_clk);
 
-	kirin_pcie->apb_phy_clk = devm_clk_get(dev, "pcie_apb_phy");
-	if (IS_ERR(kirin_pcie->apb_phy_clk))
-		return PTR_ERR(kirin_pcie->apb_phy_clk);
+	phy->apb_phy_clk = devm_clk_get(dev, "pcie_apb_phy");
+	if (IS_ERR(phy->apb_phy_clk))
+		return PTR_ERR(phy->apb_phy_clk);
 
-	kirin_pcie->apb_sys_clk = devm_clk_get(dev, "pcie_apb_sys");
-	if (IS_ERR(kirin_pcie->apb_sys_clk))
-		return PTR_ERR(kirin_pcie->apb_sys_clk);
+	phy->apb_sys_clk = devm_clk_get(dev, "pcie_apb_sys");
+	if (IS_ERR(phy->apb_sys_clk))
+		return PTR_ERR(phy->apb_sys_clk);
 
-	kirin_pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
-	if (IS_ERR(kirin_pcie->pcie_aclk))
-		return PTR_ERR(kirin_pcie->pcie_aclk);
+	phy->aclk = devm_clk_get(dev, "pcie_aclk");
+	if (IS_ERR(phy->aclk))
+		return PTR_ERR(phy->aclk);
 
 	return 0;
 }
 
-static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
-				    struct platform_device *pdev)
+static int hi3660_pcie_phy_get_resource(struct hi3660_pcie_phy *phy)
 {
-	kirin_pcie->apb_base =
-		devm_platform_ioremap_resource_byname(pdev, "apb");
-	if (IS_ERR(kirin_pcie->apb_base))
-		return PTR_ERR(kirin_pcie->apb_base);
-
-	kirin_pcie->phy_base =
-		devm_platform_ioremap_resource_byname(pdev, "phy");
-	if (IS_ERR(kirin_pcie->phy_base))
-		return PTR_ERR(kirin_pcie->phy_base);
-
-	kirin_pcie->crgctrl =
-		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-crgctrl");
-	if (IS_ERR(kirin_pcie->crgctrl))
-		return PTR_ERR(kirin_pcie->crgctrl);
-
-	kirin_pcie->sysctrl =
-		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-sctrl");
-	if (IS_ERR(kirin_pcie->sysctrl))
-		return PTR_ERR(kirin_pcie->sysctrl);
+	struct device *dev = phy->dev;
+	struct platform_device *pdev;
+
+	/* registers */
+	pdev = container_of(dev, struct platform_device, dev);
+
+	phy->base = devm_platform_ioremap_resource_byname(pdev, "phy");
+	if (IS_ERR(phy->base))
+		return PTR_ERR(phy->base);
+
+	phy->crgctrl = syscon_regmap_lookup_by_compatible("hisilicon,hi3660-crgctrl");
+	if (IS_ERR(phy->crgctrl))
+		return PTR_ERR(phy->crgctrl);
+
+	phy->sysctrl = syscon_regmap_lookup_by_compatible("hisilicon,hi3660-sctrl");
+	if (IS_ERR(phy->sysctrl))
+		return PTR_ERR(phy->sysctrl);
+
+	/* gpios */
+	phy->gpio_id_reset = of_get_named_gpio(dev->of_node,
+					       "reset-gpios", 0);
+	if (phy->gpio_id_reset == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (!gpio_is_valid(phy->gpio_id_reset)) {
+		dev_err(phy->dev, "unable to get a valid gpio pin\n");
+		return -ENODEV;
+	}
 
 	return 0;
 }
 
-static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
+static int hi3660_pcie_phy_start(struct hi3660_pcie_phy *phy)
 {
-	struct device *dev = kirin_pcie->pci->dev;
+	struct device *dev = phy->dev;
 	u32 reg_val;
 
-	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_CTRL1);
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL1);
 	reg_val &= ~PHY_REF_PAD_BIT;
-	kirin_apb_phy_writel(kirin_pcie, reg_val, PCIE_APB_PHY_CTRL1);
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL1);
 
-	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_CTRL0);
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL0);
 	reg_val &= ~PHY_PWR_DOWN_BIT;
-	kirin_apb_phy_writel(kirin_pcie, reg_val, PCIE_APB_PHY_CTRL0);
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL0);
 	usleep_range(TIME_PHY_PD_MIN, TIME_PHY_PD_MAX);
 
-	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_CTRL1);
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL1);
 	reg_val &= ~PHY_RST_ACK_BIT;
-	kirin_apb_phy_writel(kirin_pcie, reg_val, PCIE_APB_PHY_CTRL1);
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL1);
 
 	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
-	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
 	if (reg_val & PIPE_CLK_STABLE) {
 		dev_err(dev, "PIPE clk is not stable\n");
 		return -EINVAL;
@@ -198,105 +203,157 @@ static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
 	return 0;
 }
 
-static void kirin_pcie_oe_enable(struct kirin_pcie *kirin_pcie)
+static void hi3660_pcie_phy_oe_enable(struct hi3660_pcie_phy *phy)
 {
 	u32 val;
 
-	regmap_read(kirin_pcie->sysctrl, SCTRL_PCIE_OE_OFFSET, &val);
+	regmap_read(phy->sysctrl, SCTRL_PCIE_OE_OFFSET, &val);
 	val |= PCIE_DEBOUNCE_PARAM;
 	val &= ~PCIE_OE_BYPASS;
-	regmap_write(kirin_pcie->sysctrl, SCTRL_PCIE_OE_OFFSET, val);
+	regmap_write(phy->sysctrl, SCTRL_PCIE_OE_OFFSET, val);
 }
 
-static int kirin_pcie_clk_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
+static int hi3660_pcie_phy_clk_ctrl(struct hi3660_pcie_phy *phy, bool enable)
 {
 	int ret = 0;
 
 	if (!enable)
 		goto close_clk;
 
-	ret = clk_set_rate(kirin_pcie->phy_ref_clk, REF_CLK_FREQ);
+	ret = clk_set_rate(phy->phy_ref_clk, REF_CLK_FREQ);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(kirin_pcie->phy_ref_clk);
+	ret = clk_prepare_enable(phy->phy_ref_clk);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(kirin_pcie->apb_sys_clk);
+	ret = clk_prepare_enable(phy->apb_sys_clk);
 	if (ret)
 		goto apb_sys_fail;
 
-	ret = clk_prepare_enable(kirin_pcie->apb_phy_clk);
+	ret = clk_prepare_enable(phy->apb_phy_clk);
 	if (ret)
 		goto apb_phy_fail;
 
-	ret = clk_prepare_enable(kirin_pcie->pcie_aclk);
+	ret = clk_prepare_enable(phy->aclk);
 	if (ret)
 		goto aclk_fail;
 
-	ret = clk_prepare_enable(kirin_pcie->pcie_aux_clk);
+	ret = clk_prepare_enable(phy->aux_clk);
 	if (ret)
 		goto aux_clk_fail;
 
 	return 0;
 
 close_clk:
-	clk_disable_unprepare(kirin_pcie->pcie_aux_clk);
+	clk_disable_unprepare(phy->aux_clk);
 aux_clk_fail:
-	clk_disable_unprepare(kirin_pcie->pcie_aclk);
+	clk_disable_unprepare(phy->aclk);
 aclk_fail:
-	clk_disable_unprepare(kirin_pcie->apb_phy_clk);
+	clk_disable_unprepare(phy->apb_phy_clk);
 apb_phy_fail:
-	clk_disable_unprepare(kirin_pcie->apb_sys_clk);
+	clk_disable_unprepare(phy->apb_sys_clk);
 apb_sys_fail:
-	clk_disable_unprepare(kirin_pcie->phy_ref_clk);
+	clk_disable_unprepare(phy->phy_ref_clk);
 
 	return ret;
 }
 
-static int kirin_pcie_power_on(struct kirin_pcie *kirin_pcie)
+static int hi3660_pcie_phy_power_on(struct kirin_pcie *pcie)
 {
+	struct hi3660_pcie_phy *phy = pcie->phy_priv;
 	int ret;
 
 	/* Power supply for Host */
-	regmap_write(kirin_pcie->sysctrl,
+	regmap_write(phy->sysctrl,
 		     SCTRL_PCIE_CMOS_OFFSET, SCTRL_PCIE_CMOS_BIT);
 	usleep_range(TIME_CMOS_MIN, TIME_CMOS_MAX);
-	kirin_pcie_oe_enable(kirin_pcie);
 
-	ret = kirin_pcie_clk_ctrl(kirin_pcie, true);
+	hi3660_pcie_phy_oe_enable(phy);
+
+	ret = hi3660_pcie_phy_clk_ctrl(phy, true);
 	if (ret)
 		return ret;
 
 	/* ISO disable, PCIeCtrl, PHY assert and clk gate clear */
-	regmap_write(kirin_pcie->sysctrl,
+	regmap_write(phy->sysctrl,
 		     SCTRL_PCIE_ISO_OFFSET, SCTRL_PCIE_ISO_BIT);
-	regmap_write(kirin_pcie->crgctrl,
+	regmap_write(phy->crgctrl,
 		     CRGCTRL_PCIE_ASSERT_OFFSET, CRGCTRL_PCIE_ASSERT_BIT);
-	regmap_write(kirin_pcie->sysctrl,
+	regmap_write(phy->sysctrl,
 		     SCTRL_PCIE_HPCLK_OFFSET, SCTRL_PCIE_HPCLK_BIT);
 
-	ret = kirin_pcie_phy_init(kirin_pcie);
+	ret = hi3660_pcie_phy_start(phy);
 	if (ret)
-		goto close_clk;
+		goto disable_clks;
 
 	/* perst assert Endpoint */
-	if (!gpio_request(kirin_pcie->gpio_id_reset, "pcie_perst")) {
+	if (!gpio_request(phy->gpio_id_reset, "pcie_perst")) {
 		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
-		ret = gpio_direction_output(kirin_pcie->gpio_id_reset, 1);
+		ret = gpio_direction_output(phy->gpio_id_reset, 1);
 		if (ret)
-			goto close_clk;
+			goto disable_clks;
 		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
-
 		return 0;
 	}
 
-close_clk:
-	kirin_pcie_clk_ctrl(kirin_pcie, false);
+disable_clks:
+	hi3660_pcie_phy_clk_ctrl(phy, false);
 	return ret;
 }
 
+static int hi3660_pcie_phy_init(struct platform_device *pdev,
+				struct kirin_pcie *pcie)
+{
+	struct device *dev = &pdev->dev;
+	struct hi3660_pcie_phy *phy;
+	int ret;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	pcie->phy_priv = phy;
+	phy->dev = dev;
+
+	/* registers */
+	pdev = container_of(dev, struct platform_device, dev);
+
+	ret = hi3660_pcie_phy_get_clk(phy);
+	if (ret)
+		return ret;
+
+	return hi3660_pcie_phy_get_resource(phy);
+}
+
+/*
+ * The non-PHY part starts here
+ */
+
+/* Registers in PCIeCTRL */
+static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
+					 u32 val, u32 reg)
+{
+	writel(val, kirin_pcie->apb_base + reg);
+}
+
+static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
+{
+	return readl(kirin_pcie->apb_base + reg);
+}
+
+static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
+				    struct platform_device *pdev)
+{
+	kirin_pcie->apb_base =
+		devm_platform_ioremap_resource_byname(pdev, "apb");
+	if (IS_ERR(kirin_pcie->apb_base))
+		return PTR_ERR(kirin_pcie->apb_base);
+
+	return 0;
+}
+
 static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
 					   bool on)
 {
@@ -444,7 +501,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	pci->pp.ops = &kirin_pcie_host_ops;
 	kirin_pcie->pci = pci;
 
-	ret = kirin_pcie_get_clk(kirin_pcie, pdev);
+	ret = hi3660_pcie_phy_init(pdev, kirin_pcie);
 	if (ret)
 		return ret;
 
@@ -452,16 +509,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	kirin_pcie->gpio_id_reset = of_get_named_gpio(dev->of_node,
-						      "reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (!gpio_is_valid(kirin_pcie->gpio_id_reset)) {
-		dev_err(dev, "unable to get a valid gpio pin\n");
-		return -ENODEV;
-	}
-
-	ret = kirin_pcie_power_on(kirin_pcie);
+	ret = hi3660_pcie_phy_power_on(kirin_pcie);
 	if (ret)
 		return ret;
 
@@ -479,8 +527,8 @@ static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
 	.driver			= {
 		.name			= "kirin-pcie",
-		.of_match_table = kirin_pcie_match,
-		.suppress_bind_attrs = true,
+		.of_match_table		= kirin_pcie_match,
+		.suppress_bind_attrs	= true,
 	},
 };
 builtin_platform_driver(kirin_pcie_driver);
-- 
2.31.1

