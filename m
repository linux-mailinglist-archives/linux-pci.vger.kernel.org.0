Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440EB7AF009
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjIZPy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZPy1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 11:54:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F9511D;
        Tue, 26 Sep 2023 08:54:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87CDC433C7;
        Tue, 26 Sep 2023 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695743660;
        bh=a0yWQ4vIBE8N4N1i6VC7OsRaMv2o6zjb5hCiz+yfCDg=;
        h=From:To:Cc:Subject:Date:From;
        b=u8XvF9TNvYBIvrKGre6i0T5K/DxCKJ68oIb6JbO8VGJGPKPUtxj2iQV0QAlrQmQMl
         Bt/H5gf0wWHzL4UZiKV6SlC1INMtcUIQNo+ws9TsR4vPogc6mJCuIq01pzcOH/FcQO
         7lbfPQXpttXVAI7h7Ds6HVt9Czq16CePiSqFtI/iy/erHiz3I1Wosqwqbcc1Vdf0dG
         raDlRaAtChbAc5Fa2llBkCd2kw3SZBNIsNgaR25fItAhCPnxrWlTbBf46ycs1jlrRk
         MgxL71snrZUpfA3A0gS8xU8+P5f9ay/d9BB33I1yvjRYjoHmRLCj6uYTudPpqcoA02
         bVhve0ve4Pd9g==
Received: (nullmailer pid 31792 invoked by uid 1000);
        Tue, 26 Sep 2023 15:54:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: PCI: brcm,iproc-pcie: Fix example indentation
Date:   Tue, 26 Sep 2023 10:53:40 -0500
Message-Id: <20230926155351.31117-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The example's indentation is off. While fixing this, the 'bus' node
is unnecessary and can be dropped. It is also preferred to split up
unrelated examples to their own entries.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/brcm,iproc-pcie.yaml         | 124 +++++++++---------
 1 file changed, 60 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
index 0972868735fc..0cb5bd6cffa1 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
@@ -117,68 +117,64 @@ unevaluatedProperties: false
 
 examples:
   - |
-   #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-   bus {
-      #address-cells = <1>;
-      #size-cells = <1>;
-           pcie0: pcie@18012000 {
-              compatible = "brcm,iproc-pcie";
-              reg = <0x18012000 0x1000>;
-
-              #interrupt-cells = <1>;
-              interrupt-map-mask = <0 0 0 0>;
-              interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
-
-              linux,pci-domain = <0>;
-
-              bus-range = <0x00 0xff>;
-
-              #address-cells = <3>;
-              #size-cells = <2>;
-              device_type = "pci";
-              ranges = <0x81000000 0 0     0x28000000 0 0x00010000>,
-                   <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
-
-              phys = <&phy 0 5>;
-              phy-names = "pcie-phy";
-
-              brcm,pcie-ob;
-              brcm,pcie-ob-axi-offset = <0x00000000>;
-
-              msi-parent = <&msi0>;
-
-              /* iProc event queue based MSI */
-              msi0: msi {
-                 compatible = "brcm,iproc-msi";
-                 msi-controller;
-                 interrupt-parent = <&gic>;
-                 interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
-                         <GIC_SPI 97 IRQ_TYPE_NONE>,
-                         <GIC_SPI 98 IRQ_TYPE_NONE>,
-                         <GIC_SPI 99 IRQ_TYPE_NONE>;
-              };
-           };
-
-           pcie1: pcie@18013000 {
-              compatible = "brcm,iproc-pcie";
-              reg = <0x18013000 0x1000>;
-
-              #interrupt-cells = <1>;
-              interrupt-map-mask = <0 0 0 0>;
-              interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
-
-              linux,pci-domain = <1>;
-
-              bus-range = <0x00 0xff>;
-
-              #address-cells = <3>;
-              #size-cells = <2>;
-              device_type = "pci";
-              ranges = <0x81000000 0 0     0x48000000 0 0x00010000>,
-                   <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
-
-              phys = <&phy 1 6>;
-              phy-names = "pcie-phy";
-           };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@18012000 {
+        compatible = "brcm,iproc-pcie";
+        reg = <0x18012000 0x1000>;
+
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0>;
+        interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+
+        linux,pci-domain = <0>;
+
+        bus-range = <0x00 0xff>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x81000000 0          0 0x28000000 0 0x00010000>,
+                 <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+
+        phys = <&phy 0 5>;
+        phy-names = "pcie-phy";
+
+        brcm,pcie-ob;
+        brcm,pcie-ob-axi-offset = <0x00000000>;
+
+        msi-parent = <&msi0>;
+
+        /* iProc event queue based MSI */
+        msi0: msi {
+            compatible = "brcm,iproc-msi";
+            msi-controller;
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
+                    <GIC_SPI 97 IRQ_TYPE_NONE>,
+                    <GIC_SPI 98 IRQ_TYPE_NONE>,
+                    <GIC_SPI 99 IRQ_TYPE_NONE>;
+        };
+    };
+  - |
+    pcie@18013000 {
+        compatible = "brcm,iproc-pcie";
+        reg = <0x18013000 0x1000>;
+
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0>;
+        interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+
+        linux,pci-domain = <1>;
+
+        bus-range = <0x00 0xff>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x81000000 0          0 0x48000000 0 0x00010000>,
+                 <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+
+        phys = <&phy 1 6>;
+        phy-names = "pcie-phy";
     };
-- 
2.40.1

