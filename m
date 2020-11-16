Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492302B4D13
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733056AbgKPRcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 12:32:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40294 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbgKPRcW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 12:32:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AGHW97B043081;
        Mon, 16 Nov 2020 11:32:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605547929;
        bh=ipn+VdtiySLcfcY4iB/vvPz6zJCnt01vn7+29Jujkhc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K09hyQGnPyE3aukYmVDzbeN245PzTgpjNJTgHAgmJ32f97eHXwGYrsx3XHq337sBI
         XWmQP+P+AmtdSGxnGEOatg9jLsRkODf3l3sr9pnlmlusNjGkSjjMCgGWjEwerbEjIC
         xmiPBi4qx55zQdIzWvw/4KZaiblz51+KtJZRdWPo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AGHW9xd002368
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 11:32:09 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 16
 Nov 2020 11:32:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 16 Nov 2020 11:32:08 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AGHVgJI030552;
        Mon, 16 Nov 2020 11:32:05 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for pcieX_ctrl
Date:   Mon, 16 Nov 2020 23:01:41 +0530
Message-ID: <20201116173141.31873-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116173141.31873-1-kishon@ti.com>
References: <20201116173141.31873-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove "syscon" nodes added for pcieX_ctrl and have the PCIe node
point to the parent with an offset argument.

Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 48 ++++-------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 620e69e42974..23a0024dda79 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -28,38 +28,6 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
-		pcie0_ctrl: syscon@4070 {
-			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-			reg = <0x00004070 0x4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x4070 0x4070 0x4>;
-		};
-
-		pcie1_ctrl: syscon@4074 {
-			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-			reg = <0x00004074 0x4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x4074 0x4074 0x4>;
-		};
-
-		pcie2_ctrl: syscon@4078 {
-			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-			reg = <0x00004078 0x4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x4078 0x4078 0x4>;
-		};
-
-		pcie3_ctrl: syscon@407c {
-			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-			reg = <0x0000407c 0x4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x407c 0x407c 0x4>;
-		};
-
 		serdes_ln_ctrl: mux@4080 {
 			compatible = "mmio-mux";
 			reg = <0x00004080 0x50>;
@@ -619,7 +587,7 @@
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
@@ -646,7 +614,7 @@
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
@@ -668,7 +636,7 @@
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
@@ -695,7 +663,7 @@
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
@@ -717,7 +685,7 @@
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
@@ -744,7 +712,7 @@
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
@@ -766,7 +734,7 @@
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
@@ -793,7 +761,7 @@
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
-- 
2.17.1

