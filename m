Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3B6792897
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbjIEQX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354455AbjIELsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 07:48:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3AA1AE;
        Tue,  5 Sep 2023 04:48:34 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385BmJWf067524;
        Tue, 5 Sep 2023 06:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693914499;
        bh=wv46gSUbnd5T5QXTH0Mwp9tu+So1/AjM94GeHUDcTjM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Kd8/VPT9fcuFT5JgaYi2xQgt5cpbiC78w1cUY3q48XLNBf3d7o/OPRtIeuBcb4C/R
         K9FNJiD+JwqimTQQdC1jyoYYTxmQv61m6kNNZovef5KppsyqFyu5AP1ywqCVt51gOd
         VWDJW6WIqPz7wkmBG0MRmy0NI8qvvngwAYXqYOVo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385BmJ66054136
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Sep 2023 06:48:19 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 06:48:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 06:48:19 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385BmI3E075471;
        Tue, 5 Sep 2023 06:48:19 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [RFC PATCH 1/2] dt-bindings: PCI: ti,j721e-pci-*: Add "ti,syscon-pcie-refclk-out" property
Date:   Tue, 5 Sep 2023 17:18:15 +0530
Message-ID: <20230905114816.2993628-2-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905114816.2993628-1-a-verma1@ti.com>
References: <20230905114816.2993628-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Added "ti,syscon-pcie-refclk-out" property to specify the ACSPCIE clock
buffer register offset in SYSCON, which would be used to enable serdes
reference clock output.

Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 .../bindings/pci/ti,j721e-pci-host.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index a2c5eaea57f5..27bdc52282c4 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -44,6 +44,18 @@ properties:
           - description: pcie_ctrl register offset within SYSCON
     description: Specifier for configuring PCIe mode and link speed.
 
+  ti,syscon-pcie-refclk-out:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the SYSCON entry
+          - description: lock2_kick0 register offset within SYSCON
+          - description: lock2_kick1 register offset within SYSCON
+          - description: acspcie_ctrl register offset within SYSCON
+          - description: pcie_refclk_clksel register offset within SYSCON
+          - description: clock source index to source ref clock
+    description: Specifier for enabling ACSPCIe clock buffer for reference clock output.
+
   power-domains:
     maxItems: 1
 
@@ -99,6 +111,7 @@ required:
   - reg
   - reg-names
   - ti,syscon-pcie-ctrl
+  - ti,syscon-pcie-refclk-out
   - max-link-speed
   - num-lanes
   - power-domains
@@ -153,3 +166,43 @@ examples:
             dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
         };
     };
+
+  -
+    #include <dt-bindings/mux/mux.h>
+    #include <dt-bindings/mux/ti-serdes.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/phy/phy-ti.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie1_rc: pcie@2910000 {
+                compatible = "ti,j784s4-pcie-host";
+                reg = <0x00 0x02910000 0x00 0x1000>,
+                      <0x00 0x02917000 0x00 0x400>,
+                      <0x00 0x0d800000 0x00 0x00800000>,
+                      <0x00 0x18000000 0x00 0x00001000>;
+                reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+                interrupt-names = "link_state";
+                interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+                device_type = "pci";
+                ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
+                ti,syscon-pcie-refclk-out = <&scm_conf 0x9008 0x900c 0x18090 0x8074 0x1>;
+                max-link-speed = <3>;
+                num-lanes = <4>;
+                power-domains = <&k3_pds 333 TI_SCI_PD_EXCLUSIVE>;
+                clocks = <&k3_clks 333 0>;
+                clock-names = "fck";
+                #address-cells = <3>;
+                #size-cells = <2>;
+                bus-range = <0x0 0xff>;
+                vendor-id = <0x104c>;
+                device-id = <0xb013>;
+                msi-map = <0x0 &gic_its 0x10000 0x10000>;
+                dma-coherent;
+                ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
+                         <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
+                dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+        };
+    };
-- 
2.25.1

