Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AF3BD6A6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhGFMlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 08:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242163AbhGFMZt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 08:25:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FE6361D7D;
        Tue,  6 Jul 2021 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625574190;
        bh=sxopU2xgf9gCq7iJzt2WMieum1/6JUWxcZVX6F7baPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a02fXnLfitY/PD24h7ApCso3GR7xINTIctPiTZBeeJ7+6qv/4LvmPfMuCbUhkIfuC
         NfIiHRm6VxilKm8PkOmP/cqzpI+qn+rpEP9sDn7LtPyeWeberCRsLNJnfKXnW1Mrw9
         2jsboSwg6vM6/M7VApP2QIPmVBhPmqCcMXtJKJ5HSPDJUqFX8+3NPnjKdt1B8C1QCJ
         F2k9uxoMOeNe3pa8iQqX9WRPpyvaDVOSd0bWlEbtI7OMugj1zY7Hek3w5/Lafs+Rwu
         9nX7fu5ukvMj6mHB2NWG+rcs4I1KS+Ps2PyAxRjIfxsIuRDlvdY7gmHKbhP+Dg+TZy
         XPyKVIEZd3Xuw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m0k6W-004qMn-79; Tue, 06 Jul 2021 14:23:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH RFC 1/1] PCI: dwc: pcie-kirin: split PHY interface from the driver
Date:   Tue,  6 Jul 2021 14:23:06 +0200
Message-Id: <1977d79f3fa13f86c16167e44e98bf701fbaea0a.1625573452.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625573452.git.mchehab+huawei@kernel.org>
References: <cover.1625573452.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie-kirin PCIe driver contains internally a PHY interface for
a Hikey 960. As we'll be adding support also for Hikey 970, we
need to first split the PHY into a separate driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  24 +-
 drivers/pci/controller/dwc/pcie-kirin.c   | 195 +++-------------
 drivers/phy/hisilicon/Kconfig             |  10 +
 drivers/phy/hisilicon/Makefile            |   1 +
 drivers/phy/hisilicon/phy-hi3660-pcie.c   | 261 ++++++++++++++++++++++
 5 files changed, 321 insertions(+), 170 deletions(-)
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-pcie.c

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 53890e8052a7..3a589fa4ca81 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1001,17 +1001,28 @@ spi3: spi@ff3b3000 {
 			status = "disabled";
 		};
 
+		pcie_phy: pcie-phy@f3f2000 {
+			compatible = "hisilicon,hi960-pcie-phy";
+			reg = <0x0 0xf3f20000 0x0 0x40000>;
+			reg-names = "phy";
+			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>;
+			clock-names = "pcie_phy_ref", "pcie_apb_phy";
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
@@ -1028,15 +1039,10 @@ &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
 					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
 					<0x0 0 0 4
 					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
-				 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
-				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+			clocks = <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
 				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
 				 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
-			clock-names = "pcie_phy_ref", "pcie_aux",
-				      "pcie_apb_phy", "pcie_apb_sys",
-				      "pcie_aclk";
-			reset-gpios = <&gpio11 1 0 >;
+			clock-names = "pcie_aux", "pcie_apb_sys", "pcie_aclk";
 		};
 
 		/* UFS */
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 026fd1e42a55..f906211a0bca 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/types.h>
@@ -28,26 +29,17 @@
 
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
@@ -60,36 +52,13 @@
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
 	struct clk	*apb_sys_clk;
-	struct clk	*apb_phy_clk;
-	struct clk	*phy_ref_clk;
 	struct clk	*pcie_aclk;
 	struct clk	*pcie_aux_clk;
-	int		gpio_id_reset;
 };
 
 /* Registers in PCIeCTRL */
@@ -104,35 +73,15 @@ static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
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
 static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 			       struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	kirin_pcie->phy_ref_clk = devm_clk_get(dev, "pcie_phy_ref");
-	if (IS_ERR(kirin_pcie->phy_ref_clk))
-		return PTR_ERR(kirin_pcie->phy_ref_clk);
-
 	kirin_pcie->pcie_aux_clk = devm_clk_get(dev, "pcie_aux");
 	if (IS_ERR(kirin_pcie->pcie_aux_clk))
 		return PTR_ERR(kirin_pcie->pcie_aux_clk);
 
-	kirin_pcie->apb_phy_clk = devm_clk_get(dev, "pcie_apb_phy");
-	if (IS_ERR(kirin_pcie->apb_phy_clk))
-		return PTR_ERR(kirin_pcie->apb_phy_clk);
-
 	kirin_pcie->apb_sys_clk = devm_clk_get(dev, "pcie_apb_sys");
 	if (IS_ERR(kirin_pcie->apb_sys_clk))
 		return PTR_ERR(kirin_pcie->apb_sys_clk);
@@ -152,62 +101,9 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
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
 static int kirin_pcie_clk_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
 {
 	int ret = 0;
@@ -215,21 +111,9 @@ static int kirin_pcie_clk_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
 	if (!enable)
 		goto close_clk;
 
-	ret = clk_set_rate(kirin_pcie->phy_ref_clk, REF_CLK_FREQ);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(kirin_pcie->phy_ref_clk);
-	if (ret)
-		return ret;
-
 	ret = clk_prepare_enable(kirin_pcie->apb_sys_clk);
 	if (ret)
-		goto apb_sys_fail;
-
-	ret = clk_prepare_enable(kirin_pcie->apb_phy_clk);
-	if (ret)
-		goto apb_phy_fail;
+		return ret;
 
 	ret = clk_prepare_enable(kirin_pcie->pcie_aclk);
 	if (ret)
@@ -246,11 +130,7 @@ static int kirin_pcie_clk_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
 aux_clk_fail:
 	clk_disable_unprepare(kirin_pcie->pcie_aclk);
 aclk_fail:
-	clk_disable_unprepare(kirin_pcie->apb_phy_clk);
-apb_phy_fail:
 	clk_disable_unprepare(kirin_pcie->apb_sys_clk);
-apb_sys_fail:
-	clk_disable_unprepare(kirin_pcie->phy_ref_clk);
 
 	return ret;
 }
@@ -259,41 +139,18 @@ static int kirin_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
 	int ret;
 
-	/* Power supply for Host */
-	regmap_write(kirin_pcie->sysctrl,
-		     SCTRL_PCIE_CMOS_OFFSET, SCTRL_PCIE_CMOS_BIT);
-	usleep_range(TIME_CMOS_MIN, TIME_CMOS_MAX);
-	kirin_pcie_oe_enable(kirin_pcie);
+	ret = phy_init(kirin_pcie->phy);
+	if (ret)
+		return ret;
 
 	ret = kirin_pcie_clk_ctrl(kirin_pcie, true);
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
+	ret = phy_power_on(kirin_pcie->phy);
 	if (ret)
-		goto close_clk;
+		kirin_pcie_clk_ctrl(kirin_pcie, false);
 
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
 	return ret;
 }
 
@@ -448,26 +305,41 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	kirin_pcie->phy = devm_of_phy_get(dev, dev->of_node, NULL);
+	if (IS_ERR(kirin_pcie->phy))
+		return PTR_ERR(kirin_pcie->phy);
+
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
@@ -477,6 +349,7 @@ static const struct of_device_id kirin_pcie_match[] = {
 
 static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
+	.remove	        	= __exit_p(kirin_pcie_remove),
 	.driver			= {
 		.name			= "kirin-pcie",
 		.of_match_table = kirin_pcie_match,
diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 4d008cfc279c..c0725907e2cb 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -23,6 +23,16 @@ config PHY_HI3660_USB
 
 	  To compile this driver as a module, choose M here.
 
+config PHY_HI3660_PCIE
+	tristate "hi3660 PCIe PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the HISILICON HI3660 PCIe PHY.
+
+	  To compile this driver as a module, choose M here.
+
 config PHY_HI3670_USB
 	tristate "hi3670 USB PHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
index 51729868145b..3c3d70dd7469 100644
--- a/drivers/phy/hisilicon/Makefile
+++ b/drivers/phy/hisilicon/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
 obj-$(CONFIG_PHY_HI3660_USB)		+= phy-hi3660-usb3.o
+obj-$(CONFIG_PHY_HI3660_PCIE)		+= phy-hi3660-pcie.o
 obj-$(CONFIG_PHY_HI3670_USB)		+= phy-hi3670-usb3.o
 obj-$(CONFIG_PHY_HISTB_COMBPHY)		+= phy-histb-combphy.o
 obj-$(CONFIG_PHY_HISI_INNO_USB2)	+= phy-hisi-inno-usb2.o
diff --git a/drivers/phy/hisilicon/phy-hi3660-pcie.c b/drivers/phy/hisilicon/phy-hi3660-pcie.c
new file mode 100644
index 000000000000..de1d5e86435e
--- /dev/null
+++ b/drivers/phy/hisilicon/phy-hi3660-pcie.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe phy driver for Kirin 960
+ *
+ * Copyright (C) 2017 HiSilicon Electronics Co., Ltd.
+ *		https://www.huawei.com
+ *
+ * Copyright (C) 2021 Huawei Electronics Co., Ltd.
+ *		https://www.huawei.com
+ *
+ * Author:
+ *	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define REF_CLK_FREQ			100000000
+
+/* info located in APB PHY */
+#define PCIE_APB_PHY_CTRL0	0x0
+#define PCIE_APB_PHY_CTRL1	0x4
+#define PCIE_APB_PHY_STATUS0   0x400
+#define PIPE_CLK_STABLE		BIT(19)
+#define PHY_REF_PAD_BIT		BIT(8)
+#define PHY_PWR_DOWN_BIT	BIT(22)
+#define PHY_RST_ACK_BIT		BIT(16)
+
+/* info located in sysctrl */
+#define SCTRL_PCIE_CMOS_OFFSET	0x60
+#define SCTRL_PCIE_CMOS_BIT	0x10
+#define SCTRL_PCIE_ISO_OFFSET	0x44
+#define SCTRL_PCIE_ISO_BIT	0x30
+#define SCTRL_PCIE_HPCLK_OFFSET	0x190
+#define SCTRL_PCIE_HPCLK_BIT	0x184000
+#define SCTRL_PCIE_OE_OFFSET	0x14a
+#define PCIE_DEBOUNCE_PARAM	0xF0F400
+#define PCIE_OE_BYPASS		(0x3 << 28)
+
+/* peri_crg ctrl */
+#define CRGCTRL_PCIE_ASSERT_OFFSET	0x88
+#define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
+
+/* Time for delay */
+#define REF_2_PERST_MIN		20000
+#define REF_2_PERST_MAX		25000
+#define PERST_2_ACCESS_MIN	10000
+#define PERST_2_ACCESS_MAX	12000
+#define PIPE_CLK_WAIT_MIN	550
+#define PIPE_CLK_WAIT_MAX	600
+#define TIME_CMOS_MIN		100
+#define TIME_CMOS_MAX		105
+#define TIME_PHY_PD_MIN		10
+#define TIME_PHY_PD_MAX		11
+
+struct hi3660_pcie_phy {
+	struct device	*dev;
+	void __iomem	*base;
+	struct regmap	*crgctrl;
+	struct regmap	*sysctrl;
+	struct clk	*phy_ref_clk;
+	struct clk	*apb_phy_clk;
+	int		gpio_id_reset;
+};
+
+/* Registers in PCIePHY */
+static inline void kirin_apb_phy_writel(struct hi3660_pcie_phy *hi3660_pcie_phy,
+					u32 val, u32 reg)
+{
+	writel(val, hi3660_pcie_phy->base + reg);
+}
+
+static inline u32 kirin_apb_phy_readl(struct hi3660_pcie_phy *hi3660_pcie_phy,
+				      u32 reg)
+{
+	return readl(hi3660_pcie_phy->base + reg);
+}
+
+static void hi3660_pcie_phy_oe_enable(struct hi3660_pcie_phy *phy)
+{
+	u32 val;
+
+	regmap_read(phy->sysctrl, SCTRL_PCIE_OE_OFFSET, &val);
+	val |= PCIE_DEBOUNCE_PARAM;
+	val &= ~PCIE_OE_BYPASS;
+	regmap_write(phy->sysctrl, SCTRL_PCIE_OE_OFFSET, val);
+}
+
+static int hi3660_pcie_phy_init(struct phy *generic_phy)
+{
+	struct hi3660_pcie_phy *phy = phy_get_drvdata(generic_phy);
+	int ret;
+
+	/* Power supply for Host */
+	regmap_write(phy->sysctrl,
+		     SCTRL_PCIE_CMOS_OFFSET, SCTRL_PCIE_CMOS_BIT);
+	usleep_range(TIME_CMOS_MIN, TIME_CMOS_MAX);
+
+	hi3660_pcie_phy_oe_enable(phy);
+
+	ret = clk_set_rate(phy->phy_ref_clk, REF_CLK_FREQ);
+	if (ret)
+		return ret;
+
+	return clk_prepare_enable(phy->phy_ref_clk);
+}
+
+static int hi3660_pcie_phy_power_on(struct phy *generic_phy)
+{
+	struct hi3660_pcie_phy *phy = phy_get_drvdata(generic_phy);
+	struct device *dev = phy->dev;
+	u32 reg_val;
+	int ret;
+
+	ret = clk_prepare_enable(phy->apb_phy_clk);
+	if (ret)
+		goto disable_phy_clk;
+
+	/* ISO disable, PCIeCtrl, PHY assert and clk gate clear */
+	regmap_write(phy->sysctrl,
+		     SCTRL_PCIE_ISO_OFFSET, SCTRL_PCIE_ISO_BIT);
+	regmap_write(phy->crgctrl,
+		     CRGCTRL_PCIE_ASSERT_OFFSET, CRGCTRL_PCIE_ASSERT_BIT);
+	regmap_write(phy->sysctrl,
+		     SCTRL_PCIE_HPCLK_OFFSET, SCTRL_PCIE_HPCLK_BIT);
+
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL1);
+	reg_val &= ~PHY_REF_PAD_BIT;
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL1);
+
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL0);
+	reg_val &= ~PHY_PWR_DOWN_BIT;
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL0);
+	usleep_range(TIME_PHY_PD_MIN, TIME_PHY_PD_MAX);
+
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL1);
+	reg_val &= ~PHY_RST_ACK_BIT;
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL1);
+
+	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
+	if (reg_val & PIPE_CLK_STABLE) {
+		dev_err(dev, "PIPE clk is not stable\n");
+		ret = -EINVAL;
+		goto disable_clks;
+	}
+
+	/* perst assert Endpoint */
+	if (!gpio_request(phy->gpio_id_reset, "pcie_perst")) {
+		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
+		ret = gpio_direction_output(phy->gpio_id_reset, 1);
+		if (ret)
+			goto disable_clks;
+		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
+		return 0;
+	}
+
+disable_clks:
+	clk_disable_unprepare(phy->apb_phy_clk);
+disable_phy_clk:
+	clk_disable_unprepare(phy->phy_ref_clk);
+	return ret;
+}
+
+static int hi3660_pcie_phy_power_off(struct phy *generic_phy)
+{
+	struct hi3660_pcie_phy *phy = phy_get_drvdata(generic_phy);
+
+	/* Drop power supply for Host */
+	regmap_write(phy->sysctrl, SCTRL_PCIE_CMOS_OFFSET, 0x00);
+
+	clk_disable_unprepare(phy->apb_phy_clk);
+	clk_disable_unprepare(phy->phy_ref_clk);
+
+	return 0;
+}
+
+static const struct phy_ops hi3660_phy_ops = {
+	.init		= hi3660_pcie_phy_init,
+	.power_on	= hi3660_pcie_phy_power_on,
+	.power_off	= hi3660_pcie_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int hi3660_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct hi3660_pcie_phy *phy;
+	struct phy *generic_phy;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->dev = dev;
+
+	phy->phy_ref_clk = devm_clk_get(dev, "pcie_phy_ref");
+	if (IS_ERR(phy->phy_ref_clk))
+		return PTR_ERR(phy->phy_ref_clk);
+
+	phy->apb_phy_clk = devm_clk_get(dev, "pcie_apb_phy");
+	if (IS_ERR(phy->apb_phy_clk))
+		return PTR_ERR(phy->apb_phy_clk);
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
+	phy->gpio_id_reset = of_get_named_gpio(dev->of_node,
+					       "reset-gpios", 0);
+	if (phy->gpio_id_reset == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (!gpio_is_valid(phy->gpio_id_reset)) {
+		dev_err(dev, "unable to get a valid gpio pin\n");
+		return -ENODEV;
+	}
+
+	generic_phy = devm_phy_create(dev, dev->of_node, &hi3660_phy_ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id hi3660_pcie_phy_match[] = {
+	{
+		.compatible = "hisilicon,hi960-pcie-phy",
+	},
+	{},
+};
+
+static struct platform_driver hi3660_pcie_phy_driver = {
+	.probe	= hi3660_pcie_phy_probe,
+	.driver = {
+		.of_match_table	= hi3660_pcie_phy_match,
+		.name		= "hi3660_pcie_phy",
+		.suppress_bind_attrs = true,
+	}
+};
+builtin_platform_driver(hi3660_pcie_phy_driver);
-- 
2.31.1

