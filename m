Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D3296AC2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376059AbgJWH60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 03:58:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46370 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S376034AbgJWH6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 03:58:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201023075758euoutp02fbab11a1fdc482be2c2fd4d07398d5f0~AkBLj0y471590415904euoutp02b
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 07:57:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201023075758euoutp02fbab11a1fdc482be2c2fd4d07398d5f0~AkBLj0y471590415904euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603439878;
        bh=S5O6LWwdePmCBugN9ckOPo+WqEUNWiGX5m51w52Arq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KATlsInRZUyb1Cgs5cYgf5YaceP6hzTBiqr+6z4L4+I6oU9kd9DJefnV5pXYciSFf
         SfFT4vIrCPmUewqgWrrxASG8l4yK0igOTrhqPguyIsvbpcVqlDeAwvvZ/SKgg6XZoR
         UiMvEQyBc/guvwtuuYQesXbaL1dkkBw6L2aBRRJ8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201023075757eucas1p253abbfe124256112a4f8029757f0253b~AkBLPccWM1556815568eucas1p2V;
        Fri, 23 Oct 2020 07:57:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DE.A8.06456.50D829F5; Fri, 23
        Oct 2020 08:57:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201023075757eucas1p13e4e7f5177bd3f789ac0d2a8aa57c86e~AkBK-dUF41766417664eucas1p1l;
        Fri, 23 Oct 2020 07:57:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201023075757eusmtrp11a5399733ded51bf3a06d545448f32ba~AkBK_tO7O0904209042eusmtrp1Y;
        Fri, 23 Oct 2020 07:57:57 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-12-5f928d05cf74
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.76.06314.50D829F5; Fri, 23
        Oct 2020 08:57:57 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201023075756eusmtip131722b6beff9be8fac6b44c0bd5d643b~AkBKa7XT92319023190eusmtip1f;
        Fri, 23 Oct 2020 07:57:56 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 6/6] arm64: dts: exynos: add the WiFi/PCIe support to
 TM2(e) boards
Date:   Fri, 23 Oct 2020 09:57:44 +0200
Message-Id: <20201023075744.26200-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023075744.26200-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHe3a33etocp3CnrRcDFMLckl9uPRiJgajCKS+SFC62kWlbcrm
        zBeINVF0zFIrMokpUjnWXGOZpqHWGE6cOnE6V/mSQWE5bUxN02o5r9q33/mf/3n+h8ODIZwm
        RiSWI8sn5TKRhM9k0dt6fzkPM6pqM470vhEQT9TZRINtiEF41soZhH7pEUoMf9EyCafTjBKu
        zsdMYlBnZxJ1zm4a4V2fRYkW2yRKlHXZUKJjog9JZguNOiMQdtRPosJGi1JoMVQyhXdaDUBo
        97TThIuW6DT0MuukmJTkFJByQVImK1tne4bkTfMKH7y6jarA+h4NCMEgfgz63+uABrAwDq4H
        0Nw1zqCKJQC/9nxCqGIRwL7aKsb2iG5gFaUazQAG2sfoOyNzvnVm0MXEE6FmXrPBGBaBJ8PV
        ZSLoQfAmBKru2kDQE46nw5+N42iQ6fgB6O9w0YPMxk/BmV41oNJ48Ln5LRLkEDwJLqimtnQD
        ChteZlKcCn3e+1vbhcPv9laU4r3QcU+7uRzESwGcGWpBqUILoEtdt/XSCTgxtLa5KYIfhC86
        BZR8Bo52u9GgDPFQ6JkPC8rIBta2PUQomQ0ryjmUOxbW2007se+GRxCKhdAe0DOp+9QAaP88
        BqoBr/5/WCMABsAllQppFqlIlJE3ExQiqUIpy0q4niu1gI2f4/hr978GyyPXrADHAH83O7O6
        JoPDEBUoiqRWADGEH8FOGXRc5bDFoqJiUp6bIVdKSIUVRGF0Ppd9tOnbFQ6eJconb5BkHinf
        7tKwkEgVMEfxC91LUVJuv8E6rDP5uNKLleVhK2qs5/Tvnva4faFGrfhWeu7AtPGc3qE5Pqst
        OYuXaONlfyafmmJcRRfiVkw2nzhVUCDlXcpjiWJHz+/n7nJH+0s/plRcKo4poQGDsaW5ujvN
        u1DGxqbi+z+4A16sX6IKlP6Yc856+HRFtijxECJXiP4BkghVIjUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4XV3W3knxBq+fyVgsacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL1r1H2C12
        3jnB7MDrsWbeGkaPnbPusnss2FTqsWlVJ5tH35ZVjB7Hb2xn8vi8SS6APUrPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY96RZcwF9+Urpm5tZG9g
        /C3ZxcjJISFgIjHvzA92EFtIYCmjxIevFRBxGYmT0xpYIWxhiT/Xuti6GLmAaj4xSpz+cIAJ
        JMEmYCjR9RYkwckhIuAk8X7yRWaQImaBNcwSjW3dYEXCAmESn5bvAytiEVCV+LTzMguIzStg
        K/HwWBMjxAZ5idUbDjCD2JwCdhLvGu4xQlxkK3H40FXmCYx8CxgZVjGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgRGwLZjPzfvYLy0MfgQowAHoxIPb8KEifFCrIllxZW5hxglOJiVRHidzp6O
        E+JNSaysSi3Kjy8qzUktPsRoCnTURGYp0eR8YHTmlcQbmhqaW1gamhubG5tZKInzdggcjBES
        SE8sSc1OTS1ILYLpY+LglGpgNP/Bwzlj9qkDnEZq86qzTob7neCZ6HOa0cO0sXkfo+4Zvd8C
        jV2Re39k6E/QfDHfd84Zz7RnRYo8TFeVwmJ8Iou1dYVuS7VsZNJ4eLCj5UlbkaLNgoTJCvM5
        mqYcPfm6V5Jhn/ICE+49//f+33Xm6sXzc4tjl116+3K9q//vHrHiSZssvLUdlFiKMxINtZiL
        ihMBcMrdu5YCAAA=
X-CMS-MailID: 20201023075757eucas1p13e4e7f5177bd3f789ac0d2a8aa57c86e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075757eucas1p13e4e7f5177bd3f789ac0d2a8aa57c86e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075757eucas1p13e4e7f5177bd3f789ac0d2a8aa57c86e
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
        <CGME20201023075757eucas1p13e4e7f5177bd3f789ac0d2a8aa57c86e@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jaehoon Chung <jh80.chung@samsung.com>

Add the nodes relevant to PCIe PHY and PCIe support. PCIe is used for the
WiFi interface (Broadcom Limited BCM4358 802.11ac Wireless LAN SoC).

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
[mszyprow: rewrote commit message, reworked board/generic dts/dtsi split]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../boot/dts/exynos/exynos5433-pinctrl.dtsi   |  2 +-
 .../dts/exynos/exynos5433-tm2-common.dtsi     | 24 ++++++++++++-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 35 +++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
index 9df7c65593a1..32a6518517e5 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
@@ -329,7 +329,7 @@
 	};
 
 	pcie_bus: pcie_bus {
-		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
+		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 	};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 829fea23d4ab..6e45a42be562 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -969,6 +969,25 @@
 	bus-width = <4>;
 };
 
+&pcie {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_bus &pcie_wlanen>;
+	vdd10-supply = <&ldo6_reg>;
+	vdd18-supply = <&ldo7_reg>;
+	assigned-clocks = <&cmu_fsys CLK_MOUT_SCLK_PCIE_100_USER>,
+			  <&cmu_top CLK_MOUT_SCLK_PCIE_100>;
+	assigned-clock-parents = <&cmu_top CLK_SCLK_PCIE_100_FSYS>,
+				 <&cmu_top CLK_MOUT_BUS_PLL_USER>;
+	assigned-clock-rates = <0>, <100000000>;
+	interrupt-map-mask = <0 0 0 0>;
+	interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
 &ppmu_d0_general {
 	status = "okay";
 	events {
@@ -1085,8 +1104,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&initial_ese>;
 
+	pcie_wlanen: pcie-wlanen {
+		PIN(INPUT, gpj2-0, UP, FAST_SR4);
+	};
+
 	initial_ese: initial-state {
-		PIN(INPUT, gpj2-0, DOWN, FAST_SR1);
 		PIN(INPUT, gpj2-1, DOWN, FAST_SR1);
 		PIN(INPUT, gpj2-2, DOWN, FAST_SR1);
 	};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 8eb4576da8f3..4d25b7d2486c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1029,6 +1029,11 @@
 			reg = <0x145f0000 0x1038>;
 		};
 
+		syscon_fsys: syscon@156f0000 {
+			compatible = "syscon";
+			reg = <0x156f0000 0x1044>;
+		};
+
 		gsc_0: video-scaler@13c00000 {
 			compatible = "samsung,exynos5433-gsc";
 			reg = <0x13c00000 0x1000>;
@@ -1830,6 +1835,36 @@
 				status = "disabled";
 			};
 		};
+
+		pcie_phy: pcie-phy@15680000 {
+			compatible = "samsung,exynos5433-pcie-phy";
+			reg = <0x15680000 0x1000>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			samsung,fsys-sysreg = <&syscon_fsys>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		pcie: pcie@15700000 {
+			compatible = "samsung,exynos5433-pcie";
+			reg = <0x15700000 0x1000>, <0x156b0000 0x1000>,
+			      <0x0c000000 0x1000>;
+			reg-names = "dbi", "elbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_fsys CLK_PCIE>,
+			         <&cmu_fsys CLK_PCLK_PCIE_PHY>;
+			clock-names = "pcie", "pcie_bus";
+			num-lanes = <1>;
+			bus-range = <0x00 0xff>;
+			phys = <&pcie_phy>;
+			ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000>,
+				 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
+			status = "disabled";
+		};
 	};
 
 	timer: timer {
-- 
2.17.1

