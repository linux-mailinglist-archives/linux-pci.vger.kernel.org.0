Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A6B600753
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJQHJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJQHJN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 03:09:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C32D758;
        Mon, 17 Oct 2022 00:09:08 -0700 (PDT)
X-UUID: 6ec0a578cdf54229b22d76d52413b5b3-20221017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ju2bHe3ERXn+3+rnay8a7hEfKCPJnttPMhhc5R1MVGc=;
        b=BCFtOKeXiX8junMda5TBZ5MIz2/U4tKL7PaQEF+RDpN7HQrUaJdNoLDkUebx+SYsP19rMgmAn6UQfJR/43AnNIM2+9S9R5RgQNu66iAtfnqMtHrh6a+6GA7AYjYiiraGWMk2vT9IffS+XHIna3392XSFrXJeP9vECU+dhIduo5E=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:83814c8f-0375-47b7-aaca-ec8e834fa5ba,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.11,REQID:83814c8f-0375-47b7-aaca-ec8e834fa5ba,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:39a5ff1,CLOUDID:a62393db-0379-47b3-a5dd-2ef5001d380a,B
        ulkID:221017150903YJ5JI0EC,BulkQuantity:0,Recheck:0,SF:38|28|16|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6ec0a578cdf54229b22d76d52413b5b3-20221017
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 958786385; Mon, 17 Oct 2022 15:09:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 17 Oct 2022 15:09:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 17 Oct 2022 15:09:00 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v1 2/3] arm64: dts: mt8195: Add pcie and pcie phy nodes
Date:   Mon, 17 Oct 2022 15:08:57 +0800
Message-ID: <20221017070858.13902-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221017070858.13902-1-tinghan.shen@mediatek.com>
References: <20221017070858.13902-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie and pcie phy nodes for mt8195.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 143 +++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d03f0c2b8233..903e92d6156f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1182,6 +1182,104 @@
 			status = "disabled";
 		};
 
+		pcie0: pcie@112f0000 {
+			compatible = "mediatek,mt8195-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x112f0000 0 0x4000>;
+			reg-names = "pcie-mac";
+			interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH 0>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x20000000
+				  0x0 0x20000000 0 0x200000>,
+				 <0x82000000 0 0x20200000
+				  0x0 0x20200000 0 0x3e00000>;
+
+			iommu-map = <0 &iommu_infra IOMMU_PORT_INFRA_PCIE0 0x2>;
+			iommu-map-mask = <0x0>;
+
+			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P0>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_26M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_32K>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
+			clock-names = "pl_250m", "tl_26m", "tl_96m",
+				      "tl_32k", "peri_26m", "peri_mem";
+			assigned-clocks = <&topckgen CLK_TOP_TL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4_D4>;
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@112f8000 {
+			compatible = "mediatek,mt8195-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x112f8000 0 0x4000>;
+			reg-names = "pcie-mac";
+			interrupts = <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH 0>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x24000000
+				  0x0 0x24000000 0 0x200000>,
+				 <0x82000000 0 0x24200000
+				  0x0 0x24200000 0 0x3e00000>;
+
+			iommu-map = <0 &iommu_infra IOMMU_PORT_INFRA_PCIE1 0x2>;
+			iommu-map-mask = <0x0>;
+
+			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P1>,
+				 <&clk26m>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+				 <&clk26m>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+				 /* Designer has connect pcie1 with peri_mem_p0 clock */
+				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
+			clock-names = "pl_250m", "tl_26m", "tl_96m",
+				      "tl_32k", "peri_26m", "peri_mem";
+			assigned-clocks = <&topckgen CLK_TOP_TL_P1>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4_D4>;
+
+			phys = <&u3port1 PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
 		nor_flash: spi@1132c000 {
 			compatible = "mediatek,mt8195-nor",
 				     "mediatek,mt8173-nor";
@@ -1241,6 +1339,34 @@
 				reg = <0x189 0x2>;
 				bits = <7 5>;
 			};
+			pciephy_rx_ln1: pciephy-rx-ln1@190 {
+				reg = <0x190 0x1>;
+				bits = <0 4>;
+			};
+			pciephy_tx_ln1_nmos: pciephy-tx-ln1-nmos@190 {
+				reg = <0x190 0x1>;
+				bits = <4 4>;
+			};
+			pciephy_tx_ln1_pmos: pciephy-tx-ln1-pmos@191 {
+				reg = <0x191 0x1>;
+				bits = <0 4>;
+			};
+			pciephy_rx_ln0: pciephy-rx-ln0@191 {
+				reg = <0x191 0x1>;
+				bits = <4 4>;
+			};
+			pciephy_tx_ln0_nmos: pciephy-tx-ln0-nmos@192 {
+				reg = <0x192 0x1>;
+				bits = <0 4>;
+			};
+			pciephy_tx_ln0_pmos: pciephy-tx-ln0-pmos@192 {
+				reg = <0x192 0x1>;
+				bits = <4 4>;
+			};
+			pciephy_glb_intr: pciephy-glb-intr@193 {
+				reg = <0x193 0x1>;
+				bits = <0 4>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
@@ -1461,6 +1587,23 @@
 			};
 		};
 
+		pciephy: phy@11e80000 {
+			compatible = "mediatek,mt8195-pcie-phy";
+			reg = <0 0x11e80000 0 0x10000>;
+			reg-names = "sif";
+			nvmem-cells = <&pciephy_glb_intr>, <&pciephy_tx_ln0_pmos>,
+				      <&pciephy_tx_ln0_nmos>, <&pciephy_rx_ln0>,
+				      <&pciephy_tx_ln1_pmos>, <&pciephy_tx_ln1_nmos>,
+				      <&pciephy_rx_ln1>;
+			nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
+					   "tx_ln0_nmos", "rx_ln0",
+					   "tx_ln1_pmos", "tx_ln1_nmos",
+					   "rx_ln1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_PHY>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		ufsphy: ufs-phy@11fa0000 {
 			compatible = "mediatek,mt8195-ufsphy", "mediatek,mt8183-ufsphy";
 			reg = <0 0x11fa0000 0 0xc000>;
-- 
2.18.0

