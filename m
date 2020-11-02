Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF182A27E8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgKBKMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:12:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38340 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgKBKMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:12:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ACTld003136;
        Mon, 2 Nov 2020 04:12:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604311949;
        bh=yXkEa7Q+nG4lbV+xXUuIkCvfRCO63DcaQ86Sm5PsyrY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UTUqDBUMKXIO7GL9WZxepuqNIaulWOGSYzs/tHJ68mzOeP2jj7zFNbB+wZrMUkmiH
         /V4vwCrJtil53sNuPrSAmjUMEtiL+hMP/UPZZrMQJ0Su1fm74AQ0Zur9lArAoA87lv
         k/ZWJWgswdF6r/vYJnVd3Mb1IhpZ/qSStR1A0JA4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2ACTUw068031
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 04:12:29 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 04:12:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 04:12:17 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ABtub059084;
        Mon, 2 Nov 2020 04:12:13 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/8] arm64: dts: ti: k3-j7200-main: Add DT for WIZ and SERDES
Date:   Mon, 2 Nov 2020 15:41:50 +0530
Message-ID: <20201102101154.13598-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102101154.13598-1-kishon@ti.com>
References: <20201102101154.13598-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dt node for the single instance of WIZ and SERDES module
shared by PCIe, CPSW (SGMII/QSGMII) and USB.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 61 +++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 72d6496e88dd..7668404c178b 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -417,6 +417,67 @@
 		dma-coherent;
 	};
 
+	serdes_refclk: serdes_refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+	};
+
+	serdes_wiz0: wiz@5060000 {
+		compatible = "ti,j721e-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 292 11>, <&k3_clks 292 85>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		ranges = <0x5060000 0x0 0x5060000 0x10000>;
+
+		assigned-clocks = <&k3_clks 292 85>;
+		assigned-clock-parents = <&k3_clks 292 89>;
+
+		wiz0_pll0_refclk: pll0-refclk {
+			clocks = <&k3_clks 292 85>, <&serdes_refclk>;
+			clock-output-names = "wiz0_pll0_refclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_pll0_refclk>;
+			assigned-clock-parents = <&k3_clks 292 85>;
+		};
+
+		wiz0_pll1_refclk: pll1-refclk {
+			clocks = <&k3_clks 292 85>, <&serdes_refclk>;
+			clock-output-names = "wiz0_pll1_refclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_pll1_refclk>;
+			assigned-clock-parents = <&k3_clks 292 85>;
+		};
+
+		wiz0_refclk_dig: refclk-dig {
+			clocks = <&k3_clks 292 85>, <&serdes_refclk>;
+			clock-output-names = "wiz0_refclk_dig";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_refclk_dig>;
+			assigned-clock-parents = <&k3_clks 292 85>;
+		};
+
+		wiz0_cmn_refclk_dig_div: cmn-refclk-dig-div {
+			clocks = <&wiz0_refclk_dig>;
+			#clock-cells = <0>;
+		};
+
+		serdes0: serdes@5060000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05060000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&wiz0_pll0_refclk>;
+			clock-names = "refclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	usbss0: cdns-usb@4104000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x4104000 0x00 0x100>;
-- 
2.17.1

