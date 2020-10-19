Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12B2924F5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgJSJsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 05:48:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36236 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgJSJsS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 05:48:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201019094750euoutp02ab1fc8e58cb5ee2a1e5ad7fe9fcd8f73~-W794aS0P2546125461euoutp022
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 09:47:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201019094750euoutp02ab1fc8e58cb5ee2a1e5ad7fe9fcd8f73~-W794aS0P2546125461euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603100870;
        bh=1yaYI18k7RsdM2gsx6IUAQoC1QhJiiWneSZblenzeJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PoE5kynMYkiYSLzNOPEUGMNs0LWmW6CB/30d4w8VF+TwW8ytKMg2GuFPncsh8Ywza
         Yj6ydMjhd2SB9tGH162qMUAL4rrXYwedTpB9oRvxvF5nFVCDyN0oHVmMfWRYEsEULT
         RAWb4kS0ZnOR/j/A+dmOKcbmJtO4u51ESRA+eFeE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201019094741eucas1p1d6311fac3637c25544e2a49c66c70675~-W72JE4Cz1124911249eucas1p1J;
        Mon, 19 Oct 2020 09:47:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.F2.05997.DB06D8F5; Mon, 19
        Oct 2020 10:47:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094741eucas1p1b4934cd5024a18804fcee921294acee0~-W71jdajx1115511155eucas1p1p;
        Mon, 19 Oct 2020 09:47:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019094741eusmtrp2ff1e4745786cb611fe9b0a71d8e84f9a~-W71ioRl-2596225962eusmtrp26;
        Mon, 19 Oct 2020 09:47:41 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-4e-5f8d60bdca5f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.DB.06017.DB06D8F5; Mon, 19
        Oct 2020 10:47:41 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094740eusmtip152f8f58d57adbbdf89840488b764eb51~-W709jZWv1445014450eusmtip1U;
        Mon, 19 Oct 2020 09:47:40 +0000 (GMT)
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
Subject: [PATCH 6/6] arm64: dts: exynos: add the WiFi/PCIe support to TM2(e)
 boards
Date:   Mon, 19 Oct 2020 11:47:15 +0200
Message-Id: <20201019094715.15343-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019094715.15343-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTURzGO7t3u3cXZ9dpeViRMbQoyLcsLqQyRWJEHyToQ4Hp0psz3Wab
        s+xDDM2Xpmn2RR2hNtN0atoUy5XlZDhruUmSjXJRkZKVqWlivlS7XrNvv//zf57zHA4HR4RG
        rgjPUObQaqUsS8wj0J7BX64DfSnXk8MH56KoO/lyqs7m5FLu5SIu1bxQg1EjE2U8yuXqxKhR
        yy0eNVxr51HVricc6tvKZ4xqt3kwqrDPhlG940OIRCBtq20D0l6DB5PWm7VSs+kaT1rebQJS
        u/sBRzpv3pWInSai0+isjFxaHRabQsgHuxbR7KWgS5MtXzk6UCnSAz4OySjY396IMiwkmwEs
        HPHTA8LLCwCuPS9F2WEewCrbHOdfomn26sbiLoAFy6vczYhnyMpjXDwyAuqn9V7G8QBSApd+
        UowHIY0I1FXYAOPxJ0/C1oYaLsMoGQLLPeb1BgEZA1uGPmJsWxBs7exHGOaTsVB/uwlhDoJk
        EwYfzX5CWVMCLLbpAMv+8Iu9eyO8E/7preOwgQIAPzjbMXYoA3A0v3ojcQSOO5fXr4qQ+2CH
        JYyV46B7qhZlZEj6Qve0HyMjXrzZU4WwsgCWFAlZ9x5osN/brLWOvERYlsL7HYsI+0CVAJb2
        z3BvgCDD/7J6AEwgkNZqFOm0JlJJXwzVyBQarTI9NFWlMAPvz3H8ti88BJbVswOAxIHYR/Be
        VZYs5MpyNXmKAQBxRBwgiB92nBEK0mR5l2m1KlmtzaI1A2AHjooDBQeNU0lCMl2WQ2fSdDat
        /rfl4HyRDpQ7HRdUM+CEIYMoeNfaKelG88nHFGFwCwmr4Zlxi4+u+xR/t49pMtw3JtHNn8tU
        /sgdMCccU56PdlyZeyrpshjfFhvHDxEr8Q1d2rbg7y758Sxi696kmfa1YGe59cVY0GGLOxWt
        efXm3FFH3LioornFoWwci3w9sb1kW0iCGNXIZRH7EbVG9hejNuGuNQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Xd29Cb3xBre/CFosacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL1r1H2C12
        3jnB7MDrsWbeGkaPnbPusnss2FTqsWlVJ5tH35ZVjB7Hb2xn8vi8SS6APUrPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49jmbywFP+Qrnq18zdTA
        OFGqi5GTQ0LARGLZhxaWLkYuDiGBpYwS7e8+sEMkZCROTmtghbCFJf5c62KDKPrEKLF373o2
        kASbgKFE19suMFtEwEni/eSLzCBFzAJrmCUa27qZQBLCAsESz35+AZvKIqAq0Xd3E1icV8BW
        YuWJR1Db5CVWbzjADGJzCthJdC1cBmYLAdV0rZzGMoGRbwEjwypGkdTS4tz03GIjveLE3OLS
        vHS95PzcTYzAGNh27OeWHYxd74IPMQpwMCrx8D7I74kXYk0sK67MPcQowcGsJMLrdPZ0nBBv
        SmJlVWpRfnxRaU5q8SFGU6CjJjJLiSbnA+MzryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpi
        SWp2ampBahFMHxMHp1QDY6Lhj30l1obKM7Yazlr5Sag65qdtYm6NH1+V2/WemnUnL1/e2pGX
        ztwZ//ux69lWu67L2o+96mb83H6bKUlxUVr7Cx+OC6crdjFcPaS60iFslvJiHvOCns5Zunf3
        675bKXWxV/r8lN/xt+/cDTS1fpi4lNci8k1nQNPxaoFZ9bP7sn+nTnz/X4mlOCPRUIu5qDgR
        AJeb1f2XAgAA
X-CMS-MailID: 20201019094741eucas1p1b4934cd5024a18804fcee921294acee0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201019094741eucas1p1b4934cd5024a18804fcee921294acee0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201019094741eucas1p1b4934cd5024a18804fcee921294acee0
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
        <CGME20201019094741eucas1p1b4934cd5024a18804fcee921294acee0@eucas1p1.samsung.com>
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
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 36 +++++++++++++++++++
 3 files changed, 60 insertions(+), 2 deletions(-)

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
index 829fea23d4ab..ef45ef86c48d 100644
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
+			<&cmu_top CLK_MOUT_SCLK_PCIE_100>;
+	assigned-clock-parents = <&cmu_top CLK_SCLK_PCIE_100_FSYS>,
+			<&cmu_top CLK_MOUT_BUS_PLL_USER>;
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
index 8eb4576da8f3..be2d1753d1d1 100644
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
@@ -1830,6 +1835,37 @@
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
+			reg = <0x156b0000 0x1000>, <0x15700000 0x1000>,
+			      <0x0c000000 0x1000>;
+			reg-names = "elbi", "dbi", "config";
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
+			phy-names = "pcie-phy";
+			ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000>,
+				 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
+			status = "disabled";
+		};
 	};
 
 	timer: timer {
-- 
2.17.1

