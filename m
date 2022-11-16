Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D210162C04E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiKPOA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiKPN6U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 08:58:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DDC419B4;
        Wed, 16 Nov 2022 05:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668606948; x=1700142948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JheLyRTgEp/3V42HChIgGKvaXCBJQLuWjCkgE/1vaY=;
  b=BoNQr3m+TkjmLWiTOpUobVVwnSZiJb70sK3DanlV5lMEC/lbOYOischw
   vuiLckEyUFRBJUoIoWu7wWViY5Yk4edLhYp2EsBqb/d2J7TI/C+FjeFB+
   bpI9M86su9noWL7QYKxpWjin83i2SGwKAuXj6A8FV5ft9hP56e+12PqoO
   1pH7j1Mmytko+sRepZi1FS9D3p++ip16sMxNhcc7EEqC51Sg5hYQbEP0m
   cZXQap6SFAltn+Vy6D5bQSR+03aTRBITL72NpmBaspzN1cesCzxoCIPp3
   Voiyp9ms35bZ+wP98shQdoN6eyNLpdAMIQ/+DJdP4gvuyXeNslhkIOGD5
   g==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="189213731"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 06:55:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 06:55:38 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 16 Nov 2022 06:55:36 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v1 9/9] riscv: dts: microchip: add parent ranges and dma-ranges for IKRD v2022.09
Date:   Wed, 16 Nov 2022 13:55:04 +0000
Message-ID: <20221116135504.258687-10-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116135504.258687-1-daire.mcnamara@microchip.com>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

we have replaced the "microchip,matro0" hack property with what was
suggested by Rob - create a parent bus and use ranges and dma-ranges in
the parent bus and pcie device to achieve the address translations we
need. Add the appropriate ranges and dma-ranges for the v2022.09 IKRD
so that it remains functional.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi | 62 +++++++++++--------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 1069134f2e12..51ce87e70b33 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -26,33 +26,41 @@ i2c2: i2c@40000200 {
 		status = "disabled";
 	};
 
-	pcie: pcie@3000000000 {
-		compatible = "microchip,pcie-host-1.0";
-		#address-cells = <0x3>;
-		#interrupt-cells = <0x1>;
-		#size-cells = <0x2>;
-		device_type = "pci";
-		reg = <0x30 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
-		reg-names = "cfg", "apb";
-		bus-range = <0x0 0x7f>;
-		interrupt-parent = <&plic>;
-		interrupts = <119>;
-		interrupt-map = <0 0 0 1 &pcie_intc 0>,
-				<0 0 0 2 &pcie_intc 1>,
-				<0 0 0 3 &pcie_intc 2>,
-				<0 0 0 4 &pcie_intc 3>;
-		interrupt-map-mask = <0 0 0 7>;
-		clocks = <&ccc_nw CLK_CCC_PLL0_OUT1>, <&ccc_nw CLK_CCC_PLL0_OUT3>;
-		clock-names = "fic1", "fic3";
-		ranges = <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
-		dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x1 0x00000000>;
-		msi-parent = <&pcie>;
-		msi-controller;
-		status = "disabled";
-		pcie_intc: interrupt-controller {
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
+	fabric-pcie-bus {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x40000000 0x0 0x40000000 0x0 0x20000000>,
+			 <0x30 0x0 0x30 0x0 0x10 0x0>;
+		dma-ranges = <0x0 0x0 0x10 0x0 0x0 0x80000000>;
+		pcie: pcie@3000000000 {
+			compatible = "microchip,pcie-host-1.0";
+			#address-cells = <0x3>;
+			#interrupt-cells = <0x1>;
+			#size-cells = <0x2>;
+			device_type = "pci";
+			reg = <0x30 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
+			reg-names = "cfg", "apb";
+			bus-range = <0x0 0x7f>;
+			interrupt-parent = <&plic>;
+			interrupts = <119>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			interrupt-map-mask = <0 0 0 7>;
+			clocks = <&ccc_nw CLK_CCC_PLL0_OUT1>, <&ccc_nw CLK_CCC_PLL0_OUT3>;
+			clock-names = "fic1", "fic3";
+			ranges = <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
+			dma-ranges = <0x3000000 0x10 0x0 0x0 0x0 0x0 0x80000000>;
+			msi-parent = <&pcie>;
+			msi-controller;
+			status = "disabled";
+			pcie_intc: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
 		};
 	};
 
-- 
2.25.1

