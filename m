Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE752A27EF
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgKBKMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:12:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38290 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKMf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:12:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ACOdD003064;
        Mon, 2 Nov 2020 04:12:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604311945;
        bh=3Zn/1sH7odFvA8rHuF9tw0urF09pmV/QyOh+uZpfYck=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xO/Q2JiMz+kSeMW/AY9zNEBfRB7HXBKfI4XHwThua4dvWEleNSXj+6pgaQy0b0CvJ
         nPkg1yOgaGW7nXnKoUnj8Wptdb9OHnMsegiKWBjm3nbq1/V/VJcCIKyCJlgJzRdhJe
         hN+DW5Si/wPEAjmq3OeAba3tDd7ILDFq2Nui0cFM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2ACO83074593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 04:12:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 04:12:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 04:12:21 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ABtuc059084;
        Mon, 2 Nov 2020 04:12:17 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/8] arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
Date:   Mon, 2 Nov 2020 15:41:51 +0530
Message-ID: <20201102101154.13598-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102101154.13598-1-kishon@ti.com>
References: <20201102101154.13598-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe device tree node (both RC and EP) for the single PCIe
instance present in j7200.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 7668404c178b..9892704d4b67 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -25,6 +25,14 @@
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x1c000>;
 
+		pcie1_ctrl: pcie-ctrl@4074 {
+			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+			reg = <0x00004074 0x4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x4074 0x4074 0x4>;
+		};
+
 		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
@@ -478,6 +486,56 @@
 		};
 	};
 
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j7200-pcie-host", "ti,j721e-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 240 6>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		cdns,max-outbound-regions = <32>;
+		cdns,no-bar-match-nbits = <64>;
+		vendor-id = /bits/ 16 <0x104c>;
+		device-id = /bits/ 16 <0xb00f>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
+			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie1_ep: pcie-ep@2910000 {
+		compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 240 6>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		dma-coherent;
+	};
+
 	usbss0: cdns-usb@4104000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x4104000 0x00 0x100>;
-- 
2.17.1

