Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058D729ED46
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 14:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgJ2Nm4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 09:42:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38306 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgJ2Nmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 09:42:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201029134041euoutp02adb66f1840814cacb53967c5d761b3a9~CekIpTA1m1391313913euoutp02B
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 13:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201029134041euoutp02adb66f1840814cacb53967c5d761b3a9~CekIpTA1m1391313913euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603978841;
        bh=G7+cs0Cey9mc1jUmzGnGpiHoQ8KNRi7EJkpJq7+FJtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4XN8no9xJ84HMBOlxCnje+FVbK/wC+nq+MmMQyIxtMQvFnTIbyrdTcdIUXYiTAN+
         8DGJnox3BExRiXOXop0zaZ9jAb6CQMPK8u+XmouZ0YscPityCYGr1pCtwol6M5J/4d
         uWjnz7a45qLvflrjzZ3bcIB3AsuPpdwvZarYSuVc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201029134041eucas1p155b4949ffe67b6c3d13ec01ef0cc42eb~CekH-d4MP0596605966eucas1p1M;
        Thu, 29 Oct 2020 13:40:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.99.05997.956CA9F5; Thu, 29
        Oct 2020 13:40:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201029134040eucas1p2a8958b44842a8a4647e3aa4521c75725~CekHj4xNl0841008410eucas1p2Z;
        Thu, 29 Oct 2020 13:40:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201029134040eusmtrp24faa91cd5b16d567bd3e90e0fb74f44c~CekHjMRNb0455804558eusmtrp2Y;
        Thu, 29 Oct 2020 13:40:40 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-42-5f9ac65995aa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6F.91.06017.856CA9F5; Thu, 29
        Oct 2020 13:40:40 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201029134040eusmtip11497fb3783904a71700c403a00bb994d~CekG8YpxE2155521555eusmtip19;
        Thu, 29 Oct 2020 13:40:40 +0000 (GMT)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 6/6] arm64: dts: exynos: add the WiFi/PCIe support to
 TM2(e) boards
Date:   Thu, 29 Oct 2020 14:40:17 +0100
Message-Id: <20201029134017.27400-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029134017.27400-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm29nOOQ6Xx6Phh5WDdbPIWxYdSMVU6lR/qh+hgdp0J5V0yo6X
        TARboTZvswIvmIommbdsielQsyWboW4jKQw1LOhiZGbT8NryeLT+Pe9z+Z6Xlw9HyBqRO56g
        TGVUSnmiDBULO41LFq8IY2W0b3seSj1Qx1M1A2YRNbacK6Ia5yswyvqpEKUslnaMGtVXodRI
        tQmlyi19Aur7yleMah2YxCh7TxdGdU8MIsESuqW6BdDdlZMYXatLo3VNt1G6uKMJ0KaxZwLa
        pvM4h10SByiYxIR0RuUTdFkcX/axHElZlF4b6rWAHFDkrgEOOCSOQK2uB9MAMU4SjQBWlZgF
        nEAS8wBOLyG8YAOwqH4FbCWK74+LeOEhgCWfi1B+WE/k3f0t5Fwo4Qc1M5p1AcddiWC4uEBx
        HoSoQWDp+3EBx7sQ4bB3NZyzC4m90FqwhHG0hAiELWuRfJcUNrf3IxztQARBo1rGvQKJJgwa
        7I829wmD6p9mIY9d4DdTB8bjndDeXSPgAzcB/GBuxfihEMBRdflm+jicMC9v7IkQB+BjvQ9P
        n4D2vsGNYkhsg2MzzhyNrMM7nWWbtATm55K8ex+sNLX9q31hfY3wmIYt/Q2bNywFMN/2FNUC
        aeX/sloAmoAbk8YmxTHsYSWT4c3Kk9g0ZZx3bHKSDqx/m6E/pvkuoF+NMQACBzJHiXW8IpoU
        ydPZzCQDgDgic5WEjAxFkRKFPPM6o0qOVqUlMqwB7MCFMjeJf910JEnEyVOZqwyTwqi2VAHu
        4J4DSo8NGBOUrTH7pVNtmWeynodl/Mgazu73Ubz0ny34lX7F1GNhzTcaQrSv5h1tw6ke20/F
        ip3PT71LXvAkw0LfKCL2LOtHnOrp4ah7u+pIM7XkFnryYu8X3yinC7vTPcPXDEcnHfWnZXN7
        7E7ZGq9Apb/ubMFsc8Bb7ZNbh+aMAgeZkI2X+x1EVKz8LxMU6tEyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4Xd2IY7PiDVrPq1gsacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL/3t2sFvs
        vHOC2YHXY828NYweO2fdZfdYsKnUY9OqTjaPvi2rGD2O39jO5PF5k1wAe5SeTVF+aUmqQkZ+
        cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvRHM5gLfshXnN57nrGB
        sVeqi5GTQ0LARKJv7m3WLkYuDiGBpYwSU1e0skMkZCROTmtghbCFJf5c62KDKPrEKPHy2Adm
        kASbgKFE11uQBCeHiICTxPvJF8HizAIrmSUObssDsYUFwiRuznsINpRFQFXiQvdPIJuDg1fA
        VmLN31iI+fISqzccYAYJcwrYSRxrUgIJCwFV7Dv1inkCI98CRoZVjCKppcW56bnFRnrFibnF
        pXnpesn5uZsYgcG/7djPLTsYu94FH2IU4GBU4uG9cHtmvBBrYllxZe4hRgkOZiURXqezp+OE
        eFMSK6tSi/Lji0pzUosPMZoCnTSRWUo0OR8YmXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATS
        E0tSs1NTC1KLYPqYODilGhg91rzuSj06tS5xTr6vjm1dRJLnBRmzv7KtcyReT/JpeP5wkuqS
        D+dL9vikBN9O//h9zf7cc2tWlvPZW509fr1q0e3XT80MKjk6nzJr3rZpS5m2uu0d/6GFIkfO
        rDr4n/P1pYZUxhzGrJ8PPM/Ptp3z9umG2avu3U6uuJdUsGbj/F9z9/sV7Li8XYmlOCPRUIu5
        qDgRADSB6GuUAgAA
X-CMS-MailID: 20201029134040eucas1p2a8958b44842a8a4647e3aa4521c75725
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201029134040eucas1p2a8958b44842a8a4647e3aa4521c75725
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201029134040eucas1p2a8958b44842a8a4647e3aa4521c75725
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
        <CGME20201029134040eucas1p2a8958b44842a8a4647e3aa4521c75725@eucas1p2.samsung.com>
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
index 97a2f0c7c0cf..5ec447f0cf5d 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -968,6 +968,25 @@
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
@@ -1084,8 +1103,11 @@
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
index 0a886bb6c806..1d2442ac432c 100644
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
+			num-viewport = <3>;
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

