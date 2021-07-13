Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0F3C6A89
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 08:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhGMGbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 02:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233948AbhGMGbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 02:31:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B8BC60FF2;
        Tue, 13 Jul 2021 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626157725;
        bh=TtBHxM+7iiSGJF7o6XXV3hGIFTzIQi9q1N1wcWm4R1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ue/ERhSk4j5jEr1YabcyM0ospoxCUGEar2rwpdf36yVELYjbDG7UwFgEPFXTf8QhN
         hdt676KY9nmC4HKH8zZXSaBnm+wh2SItwdXNDVUanHMiSXGDimFitpn3csbnxC1lp9
         WYrfkHGZv+Pr1ne3k4dGq3QUXy9uZ6z3wPSzgDJ4Udp94ih6MPFCC27tAurmi7U+Q5
         2o1sxzomEpNsiH/YuQjMXa1EX7O/0ihfSEwpl5j1tRUyhN8UAxJNZqZqv5M386qX0u
         4drPsAYgQ5FR3sB070vX+mYB0+otQ+4CHkEzT7gA9YrhfUB+1+XB60O4XitgQoPGOV
         qti3nBx+LkbZw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3BuN-005yPw-3c; Tue, 13 Jul 2021 08:28:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v5 7/8] PCI: kirin: Drop the PHY logic from the driver
Date:   Tue, 13 Jul 2021 08:28:40 +0200
Message-Id: <ebbb54aafa225e097b7504f2cf7a6718d38cc8ba.1626157454.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626157454.git.mchehab+huawei@kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie-kirin PCIe driver contains internally a PHY interface for
a Kirin 960. Drop it and add support for using the new PHY driver
for Kirin 960, updating DT accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  29 ++-
 drivers/pci/controller/dwc/pcie-kirin.c   | 252 +++-------------------
 2 files changed, 47 insertions(+), 234 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f1ec87c05842..772bb632814f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -995,17 +995,33 @@ spi3: spi@ff3b3000 {
 			status = "disabled";
 		};
 
+		pcie_phy: pcie-phy@f3f2000 {
+			compatible = "hisilicon,hi960-pcie-phy";
+			reg = <0x0 0xf3f20000 0x0 0x40000>;
+			reg-names = "phy";
+			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+				 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+				 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+			clock-names = "pcie_phy_ref", "pcie_aux",
+				      "pcie_apb_phy", "pcie_apb_sys",
+				      "pcie_aclk";
+			reset-gpios = <&gpio11 1 0 >;
+			#phy-cells = <0>;
+		};
+
 		pcie@f4000000 {
 			compatible = "hisilicon,kirin960-pcie";
 			reg = <0x0 0xf4000000 0x0 0x1000>,
 			      <0x0 0xff3fe000 0x0 0x1000>,
-			      <0x0 0xf3f20000 0x0 0x40000>,
 			      <0x0 0xf5000000 0x0 0x2000>;
-			reg-names = "dbi", "apb", "phy", "config";
+			reg-names = "dbi", "apb", "config";
 			bus-range = <0x0  0x1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
+			phys = <&pcie_phy>;
 			ranges = <0x02000000 0x0 0x00000000
 				  0x0 0xf6000000
 				  0x0 0x02000000>;
@@ -1022,15 +1038,6 @@ &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
 					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
 					<0x0 0 0 4
 					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
-				 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
-				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
-				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
-				 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
-			clock-names = "pcie_phy_ref", "pcie_aux",
-				      "pcie_apb_phy", "pcie_apb_sys",
-				      "pcie_aclk";
-			reset-gpios = <&gpio11 1 0 >;
 		};
 
 		/* UFS */
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 7b0f87535960..66662f7b0fc9 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/compiler.h>
-#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
@@ -21,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/types.h>
@@ -28,26 +28,17 @@
 
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
 #define PIPE_CLK_STABLE		(0x1 << 19)
-#define PHY_REF_PAD_BIT		(0x1 << 8)
-#define PHY_PWR_DOWN_BIT	(0x1 << 22)
-#define PHY_RST_ACK_BIT		(0x1 << 16)
 
 /* info located in sysctrl */
 #define SCTRL_PCIE_CMOS_OFFSET	0x60
@@ -60,36 +51,10 @@
 #define PCIE_DEBOUNCE_PARAM	0xF0F400
 #define PCIE_OE_BYPASS		(0x3 << 28)
 
-/* peri_crg ctrl */
-#define CRGCTRL_PCIE_ASSERT_OFFSET	0x88
-#define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
-
-/* Time for delay */
-#define REF_2_PERST_MIN		20000
-#define REF_2_PERST_MAX		25000
-#define PERST_2_ACCESS_MIN	10000
-#define PERST_2_ACCESS_MAX	12000
-#define LINK_WAIT_MIN		900
-#define LINK_WAIT_MAX		1000
-#define PIPE_CLK_WAIT_MIN	550
-#define PIPE_CLK_WAIT_MAX	600
-#define TIME_CMOS_MIN		100
-#define TIME_CMOS_MAX		105
-#define TIME_PHY_PD_MIN		10
-#define TIME_PHY_PD_MAX		11
-
 struct kirin_pcie {
 	struct dw_pcie	*pci;
+	struct phy	*phy;
 	void __iomem	*apb_base;
-	void __iomem	*phy_base;
-	struct regmap	*crgctrl;
-	struct regmap	*sysctrl;
-	struct clk	*apb_sys_clk;
-	struct clk	*apb_phy_clk;
-	struct clk	*phy_ref_clk;
-	struct clk	*pcie_aclk;
-	struct clk	*pcie_aux_clk;
-	int		gpio_id_reset;
 };
 
 /* Registers in PCIeCTRL */
@@ -104,46 +69,6 @@ static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
 	return readl(kirin_pcie->apb_base + reg);
 }
 
-/* Registers in PCIePHY */
-static inline void kirin_apb_phy_writel(struct kirin_pcie *kirin_pcie,
-					u32 val, u32 reg)
-{
-	writel(val, kirin_pcie->phy_base + reg);
-}
-
-static inline u32 kirin_apb_phy_readl(struct kirin_pcie *kirin_pcie, u32 reg)
-{
-	return readl(kirin_pcie->phy_base + reg);
-}
-
-static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
-			       struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-
-	kirin_pcie->phy_ref_clk = devm_clk_get(dev, "pcie_phy_ref");
-	if (IS_ERR(kirin_pcie->phy_ref_clk))
-		return PTR_ERR(kirin_pcie->phy_ref_clk);
-
-	kirin_pcie->pcie_aux_clk = devm_clk_get(dev, "pcie_aux");
-	if (IS_ERR(kirin_pcie->pcie_aux_clk))
-		return PTR_ERR(kirin_pcie->pcie_aux_clk);
-
-	kirin_pcie->apb_phy_clk = devm_clk_get(dev, "pcie_apb_phy");
-	if (IS_ERR(kirin_pcie->apb_phy_clk))
-		return PTR_ERR(kirin_pcie->apb_phy_clk);
-
-	kirin_pcie->apb_sys_clk = devm_clk_get(dev, "pcie_apb_sys");
-	if (IS_ERR(kirin_pcie->apb_sys_clk))
-		return PTR_ERR(kirin_pcie->apb_sys_clk);
-
-	kirin_pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
-	if (IS_ERR(kirin_pcie->pcie_aclk))
-		return PTR_ERR(kirin_pcie->pcie_aclk);
-
-	return 0;
-}
-
 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				    struct platform_device *pdev)
 {
@@ -152,149 +77,18 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	if (IS_ERR(kirin_pcie->apb_base))
 		return PTR_ERR(kirin_pcie->apb_base);
 
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
-
 	return 0;
 }
 
-static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
-{
-	struct device *dev = kirin_pcie->pci->dev;
-	u32 reg_val;
-
-	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_CTRL1);
-	reg_val &= ~PHY_REF_PAD_BIT;
-	kirin_apb_phy_writel(kirin_pcie, reg_val, PCIE_APB_PHY_CTRL1);
-
-	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_CTRL0);
-	reg_val &= ~PHY_PWR_DOWN_BIT;
-	kirin_apb_phy_writel(kirin_pcie, reg_val, PCIE_APB_PHY_CTRL0);
-	usleep_range(TIME_PHY_PD_MIN, TIME_PHY_PD_MAX);
-
-	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_CTRL1);
-	reg_val &= ~PHY_RST_ACK_BIT;
-	kirin_apb_phy_writel(kirin_pcie, reg_val, PCIE_APB_PHY_CTRL1);
-
-	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
-	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
-	if (reg_val & PIPE_CLK_STABLE) {
-		dev_err(dev, "PIPE clk is not stable\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void kirin_pcie_oe_enable(struct kirin_pcie *kirin_pcie)
-{
-	u32 val;
-
-	regmap_read(kirin_pcie->sysctrl, SCTRL_PCIE_OE_OFFSET, &val);
-	val |= PCIE_DEBOUNCE_PARAM;
-	val &= ~PCIE_OE_BYPASS;
-	regmap_write(kirin_pcie->sysctrl, SCTRL_PCIE_OE_OFFSET, val);
-}
-
-static int kirin_pcie_clk_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
-{
-	int ret = 0;
-
-	if (!enable)
-		goto close_clk;
-
-	ret = clk_set_rate(kirin_pcie->phy_ref_clk, REF_CLK_FREQ);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(kirin_pcie->phy_ref_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(kirin_pcie->apb_sys_clk);
-	if (ret)
-		goto apb_sys_fail;
-
-	ret = clk_prepare_enable(kirin_pcie->apb_phy_clk);
-	if (ret)
-		goto apb_phy_fail;
-
-	ret = clk_prepare_enable(kirin_pcie->pcie_aclk);
-	if (ret)
-		goto aclk_fail;
-
-	ret = clk_prepare_enable(kirin_pcie->pcie_aux_clk);
-	if (ret)
-		goto aux_clk_fail;
-
-	return 0;
-
-close_clk:
-	clk_disable_unprepare(kirin_pcie->pcie_aux_clk);
-aux_clk_fail:
-	clk_disable_unprepare(kirin_pcie->pcie_aclk);
-aclk_fail:
-	clk_disable_unprepare(kirin_pcie->apb_phy_clk);
-apb_phy_fail:
-	clk_disable_unprepare(kirin_pcie->apb_sys_clk);
-apb_sys_fail:
-	clk_disable_unprepare(kirin_pcie->phy_ref_clk);
-
-	return ret;
-}
-
 static int kirin_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
 	int ret;
 
-	/* Power supply for Host */
-	regmap_write(kirin_pcie->sysctrl,
-		     SCTRL_PCIE_CMOS_OFFSET, SCTRL_PCIE_CMOS_BIT);
-	usleep_range(TIME_CMOS_MIN, TIME_CMOS_MAX);
-	kirin_pcie_oe_enable(kirin_pcie);
-
-	ret = kirin_pcie_clk_ctrl(kirin_pcie, true);
+	ret = phy_init(kirin_pcie->phy);
 	if (ret)
 		return ret;
 
-	/* ISO disable, PCIeCtrl, PHY assert and clk gate clear */
-	regmap_write(kirin_pcie->sysctrl,
-		     SCTRL_PCIE_ISO_OFFSET, SCTRL_PCIE_ISO_BIT);
-	regmap_write(kirin_pcie->crgctrl,
-		     CRGCTRL_PCIE_ASSERT_OFFSET, CRGCTRL_PCIE_ASSERT_BIT);
-	regmap_write(kirin_pcie->sysctrl,
-		     SCTRL_PCIE_HPCLK_OFFSET, SCTRL_PCIE_HPCLK_BIT);
-
-	ret = kirin_pcie_phy_init(kirin_pcie);
-	if (ret)
-		goto close_clk;
-
-	/* perst assert Endpoint */
-	if (!gpio_request(kirin_pcie->gpio_id_reset, "pcie_perst")) {
-		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
-		ret = gpio_direction_output(kirin_pcie->gpio_id_reset, 1);
-		if (ret)
-			goto close_clk;
-		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
-
-		return 0;
-	}
-
-close_clk:
-	kirin_pcie_clk_ctrl(kirin_pcie, false);
-	return ret;
+	return phy_power_on(kirin_pcie->phy);
 }
 
 static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
@@ -444,30 +238,41 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	pci->pp.ops = &kirin_pcie_host_ops;
 	kirin_pcie->pci = pci;
 
-	ret = kirin_pcie_get_clk(kirin_pcie, pdev);
-	if (ret)
-		return ret;
+	kirin_pcie->phy = devm_of_phy_get(dev, dev->of_node, NULL);
+	if (IS_ERR(kirin_pcie->phy))
+		return PTR_ERR(kirin_pcie->phy);
 
 	ret = kirin_pcie_get_resource(kirin_pcie, pdev);
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
 	ret = kirin_pcie_power_on(kirin_pcie);
 	if (ret)
 		return ret;
 
 	platform_set_drvdata(pdev, kirin_pcie);
 
-	return dw_pcie_host_init(&pci->pp);
+	ret = dw_pcie_host_init(&pci->pp);
+	if (ret) {
+		phy_power_off(kirin_pcie->phy);
+		goto err;
+	}
+
+	return 0;
+err:
+	phy_exit(kirin_pcie->phy);
+
+	return ret;
+}
+
+static int __exit kirin_pcie_remove(struct platform_device *pdev)
+{
+	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
+
+	phy_power_off(kirin_pcie->phy);
+	phy_exit(kirin_pcie->phy);
+
+	return 0;
 }
 
 static const struct of_device_id kirin_pcie_match[] = {
@@ -478,6 +283,7 @@ static const struct of_device_id kirin_pcie_match[] = {
 
 static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
+	.remove	        	= __exit_p(kirin_pcie_remove),
 	.driver			= {
 		.name			= "kirin-pcie",
 		.of_match_table = kirin_pcie_match,
-- 
2.31.1

