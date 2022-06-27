Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4791255C21E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbiF0MYj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 08:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbiF0MYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 08:24:35 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EC73BCA7;
        Mon, 27 Jun 2022 05:24:33 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,226,1650898800"; 
   d="scan'208";a="124258824"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Jun 2022 21:24:30 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0E1524290418;
        Mon, 27 Jun 2022 21:24:30 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 12/13] arm64: dts: renesas: r8a779f0: Add PCIe Host and Endpoint nodes
Date:   Mon, 27 Jun 2022 21:24:16 +0900
Message-Id: <20220627122417.809615-13-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe Host and Endpoint nodes for R-Car S4-8 (R8A779F0).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 118 ++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 384817ffa4de..a223f6bdc84a 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -504,6 +504,124 @@ hscif3: serial@e66a0000 {
 			status = "disabled";
 		};
 
+		pciec0: pcie@e65d0000 {
+			compatible = "renesas,r8a779f0-pcie",
+				     "renesas,rcar-gen4-pcie";
+			reg = <0 0xe65d0000 0 0x3000>, <0 0xe65d3000 0 0x2000>,
+			      <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
+			reg-names = "dbi", "atu", "app", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0x30000000 0 0x30000000 0 0x10000000>;
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "others", "dma", "correctable",
+					  "fatal", "nonfatal", "lp", "vndmsg";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 624>;
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 624>;
+			num-lanes = <2>;
+			snps,enable-cdm-check;
+			max-link-speed = <2>;
+			status = "disabled";
+		};
+
+		pciec1: pcie@e65d8000 {
+			compatible = "renesas,r8a779f0-pcie",
+				     "renesas,rcar-gen4-pcie";
+			reg = <0 0xe65d8000 0 0x3000>, <0 0xe65db000 0 0x2000>,
+			      <0 0xe65de200 0 0x0e00>, <0 0xee900000 0 0x400000>;
+			reg-names = "dbi", "atu", "app", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0xc0000000 0 0xc0000000 0 0x10000000>;
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			interrupts = <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "others", "dma", "correctable",
+					  "fatal", "nonfatal", "lp", "vndmsg";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 625>;
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 625>;
+			num-lanes = <2>;
+			snps,enable-cdm-check;
+			max-link-speed = <2>;
+			status = "disabled";
+		};
+
+		pciec0_ep: pcie-ep@e65d0000 {
+			compatible = "renesas,r8a779f0-pcie-ep",
+				     "renesas,rcar-gen4-pcie-ep";
+			reg = <0 0xe65d0000 0 0x3000>, <0 0xe65d3000 0 0x2000>,
+			      <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
+			reg-names = "dbi", "atu", "appl", "addr_space";
+			interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "others", "dma", "correctable",
+					  "fatal", "nonfatal", "lp", "vndmsg";
+			clocks = <&cpg CPG_MOD 624>;
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 624>;
+			num-lanes = <2>;
+			max-link-speed = <2>;
+			status = "disabled";
+		};
+
+		pciec1_ep: pcie-ep@e65d8000 {
+			compatible = "renesas,r8a779f0-pcie-ep",
+				     "renesas,rcar-gen4-pcie-ep";
+			reg = <0 0xe65d8000 0 0x3000>, <0 0xe65db000 0 0x2000>,
+			      <0 0xe65de200 0 0x0e00>, <0 0xee900000 0 0x400000>;
+			reg-names = "dbi", "atu", "appl", "addr_space";
+			interrupts = <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "others", "dma", "correctable",
+					  "fatal", "nonfatal", "lp", "vndmsg";
+			clocks = <&cpg CPG_MOD 625>;
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 625>;
+			num-lanes = <2>;
+			max-link-speed = <2>;
+			status = "disabled";
+		};
+
 		ufs: ufs@e6860000 {
 			compatible = "renesas,r8a779f0-ufs";
 			reg = <0 0xe6860000 0 0x100>;
-- 
2.25.1

