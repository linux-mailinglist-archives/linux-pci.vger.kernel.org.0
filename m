Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD3600756
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJQHJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJQHJN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 03:09:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955257E1F;
        Mon, 17 Oct 2022 00:09:08 -0700 (PDT)
X-UUID: 3389be396c8b4e0eb4bb273337964771-20221017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D2S3DQgWXod379+3uCrDiDKGjcHd4CLUQw64HdfRMJ8=;
        b=g0LCPdX+G3mJQrSAv5fLm3CmiM+Q3zN+UIBdkEa0PNO7WMaYq9PLENxE4fxu+OSX8PMXuqZUV2vEP++ERv2gxMQwlSwZgjNhTcERVf86BRvVKNPML/grF3/W/9vFxmNtTHGg7oTZszcI9MdBIMkb0kCGpg2nedoplAuRXDRpnXo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b0d37d92-0f87-4b25-a3b1-d8a139d86fc8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:a52393db-0379-47b3-a5dd-2ef5001d380a,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3389be396c8b4e0eb4bb273337964771-20221017
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1120094907; Mon, 17 Oct 2022 15:09:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
        TingHan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v1 1/3] dt-bindings: PCI: mediatek-gen3: Add iommu and power-domain support
Date:   Mon, 17 Oct 2022 15:08:56 +0800
Message-ID: <20221017070858.13902-2-tinghan.shen@mediatek.com>
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

From: Jianjun Wang <jianjun.wang@mediatek.com>

Add iommu and power-domain support, and add examples for MT8195, which
has two PCIe ports with different clocks and phys.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
---
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index c00be39af64e..089074b5fa95 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -70,6 +70,12 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommu-map:
+    maxItems: 1
+
+  iommu-map-mask:
+    maxItems: 1
+
   resets:
     minItems: 1
     maxItems: 2
@@ -107,6 +113,9 @@ properties:
     items:
       - const: pcie-phy
 
+  power-domains:
+    maxItems: 1
+
   '#interrupt-cells':
     const: 1
 
@@ -191,3 +200,109 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/memory/mt8195-memory-port.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie0: pcie@112f0000 {
+            compatible = "mediatek,mt8195-pcie", "mediatek,mt8192-pcie";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x00 0x112f0000 0x00 0x4000>;
+            reg-names = "pcie-mac";
+            interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH 0>;
+            bus-range = <0x00 0xff>;
+            ranges = <0x81000000 0x00 0x20000000 0x00
+                      0x20000000 0x00 0x200000>,
+                     <0x82000000 0x00 0x20200000 0x00
+                      0x20200000 0x00 0x3e00000>;
+
+            iommu-map = <0 &iommu_infra IOMMU_PORT_INFRA_PCIE0 0x2>;
+            iommu-map-mask = <0x0>;
+
+            clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P0>,
+                     <&infracfg_ao CLK_INFRA_AO_PCIE_TL_26M>,
+                     <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+                     <&infracfg_ao CLK_INFRA_AO_PCIE_TL_32K>,
+                     <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+                     <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
+            clock-names = "pl_250m", "tl_26m", "tl_96m",
+                          "tl_32k", "peri_26m", "peri_mem";
+            assigned-clocks = <&topckgen CLK_TOP_TL>;
+            assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4_D4>;
+
+            phys = <&pciephy>;
+            phy-names = "pcie-phy";
+
+            power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                            <0 0 0 2 &pcie_intc0 1>,
+                            <0 0 0 3 &pcie_intc0 2>,
+                            <0 0 0 4 &pcie_intc0 3>;
+            pcie_intc0: interrupt-controller {
+                      #address-cells = <0>;
+                      #interrupt-cells = <1>;
+                      interrupt-controller;
+            };
+        };
+
+        pcie1: pcie@112f8000 {
+            compatible = "mediatek,mt8195-pcie", "mediatek,mt8192-pcie";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x00 0x112f8000 0x00 0x4000>;
+            reg-names = "pcie-mac";
+            interrupts = <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH 0>;
+            bus-range = <0x00 0xff>;
+            ranges = <0x81000000 0x00 0x24000000 0x00
+                      0x24000000 0x00 0x200000>,
+                     <0x82000000 0x00 0x24200000 0x00
+                      0x24200000 0x00 0x3e00000>;
+
+            iommu-map = <0 &iommu_infra IOMMU_PORT_INFRA_PCIE1 0x2>;
+            iommu-map-mask = <0x0>;
+
+            clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P1>,
+                     <&clk26m>,
+                     <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+                     <&clk26m>,
+                     <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+                     /* Designer has connect pcie1 with peri_mem_p0 clock */
+                     <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
+            clock-names = "pl_250m", "tl_26m", "tl_96m",
+                          "tl_32k", "peri_26m", "peri_mem";
+            assigned-clocks = <&topckgen CLK_TOP_TL_P1>;
+            assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4_D4>;
+
+            phys = <&u3port1 PHY_TYPE_PCIE>;
+            phy-names = "pcie-phy";
+
+            power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+                            <0 0 0 2 &pcie_intc1 1>,
+                            <0 0 0 3 &pcie_intc1 2>,
+                            <0 0 0 4 &pcie_intc1 3>;
+            pcie_intc1: interrupt-controller {
+                      #address-cells = <0>;
+                      #interrupt-cells = <1>;
+                      interrupt-controller;
+            };
+        };
+    };
-- 
2.18.0

