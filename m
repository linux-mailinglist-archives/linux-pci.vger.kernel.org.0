Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A413DB610
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbhG3Jei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238366AbhG3Jed (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:34:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23CCB60EFD;
        Fri, 30 Jul 2021 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627637669;
        bh=QdyBV1Sgcg/acDjHmPix433hvfXbgcuLbP2ahG2J9yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkgAajBZj4eyz2HHvVPIf5XVd2u19D72u38K6ZWxrMpbEeKyoO17WlbTGqrNCbL3Q
         lYUTvs51XLwoEXVp4sMAIfZ9kzPYjb55VKmhFeyHeSVLGlc4RIK5ofsH8YzXgiUx3x
         T/JYfgBcfg4Wi9GpIR1+CenobQnGMdJq7nozFO//w+08CPS+vu+IO1z9xf0H2A/PLP
         uLGEsZEoLdwbsMuB5zuU5Ygn+PMyfWrtTyC9Pr2olcF/jzoVYq4ZAykrqyzTe/ykDS
         ydxOxBt1Zow2RCm0o40xaMAqOQrqdioahaH6Kb2HJ0/tbikwRxfsq438/HM6pH4lH1
         p5tmbvkG8680A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9OuO-006qwB-KG; Fri, 30 Jul 2021 11:34:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: PCI: kirin: Add support for Kirin970
Date:   Fri, 30 Jul 2021 11:34:20 +0200
Message-Id: <93a42a6317eed3b0eb6a35b6d4c484e106cb2793.1627637448.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627637448.git.mchehab+huawei@kernel.org>
References: <cover.1627637448.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new compatible, plus the new bindings needed by
HiKey970 board.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 76 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index 90cab09e8d4b..74169b5577d9 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -24,11 +24,12 @@ properties:
     contains:
       enum:
         - hisilicon,kirin960-pcie
+        - hisilicon,kirin970-pcie
 
   reg:
     description: |
       Should contain dbi, apb, config registers location and length.
-      For HiKey960, it should also contain phy.
+      For hisilicon,kirin960-pcie, it should also contain phy.
     minItems: 3
     maxItems: 4
 
@@ -36,6 +37,11 @@ properties:
     minItems: 3
     maxItems: 4
 
+  hisilicon,clken-gpios:
+    description: |
+      Clock input enablement GPIOs from PCI devices like Ethernet, M.2 and
+      mini-PCIe slots.
+
 required:
   - compatible
   - reg
@@ -47,6 +53,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/hi3660-clock.h>
+    #include <dt-bindings/clock/hi3670-clock.h>
 
     soc {
       #address-cells = <2>;
@@ -83,4 +90,71 @@ examples:
         clock-names = "pcie_phy_ref", "pcie_aux", "pcie_apb_phy",
                       "pcie_apb_sys", "pcie_aclk";
       };
+
+      pcie@f5000000 {
+        compatible = "hisilicon,kirin970-pcie";
+        reg = <0x0 0xf4000000 0x0 0x1000000>,
+              <0x0 0xfc180000 0x0 0x1000>,
+              <0x0 0xf5000000 0x0 0x2000>;
+        reg-names = "dbi", "apb", "config";
+        bus-range = <0x0  0x1>;
+        msi-parent = <&its_pcie>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        phys = <&pcie_phy>;
+        ranges = <0x02000000 0x0 0x00000000
+                  0x0 0xf6000000
+                  0x0 0x02000000>;
+        num-lanes = <1>;
+        #interrupt-cells = <1>;
+        interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+        reset-gpios = <&gpio7 0 0>;
+        hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>, <&gpio20 6 0>;
+
+        pcie@0 { // Lane 0: PCIe switch: Bus 1, Device 0
+          reg = <0 0 0 0 0>;
+          compatible = "pciclass,0604";
+          device_type = "pci";
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+          pcie@1,0 { // Lane 4: M.2
+            reg = <0x800 0 0 0 0>;
+            compatible = "pciclass,0604";
+            device_type = "pci";
+            reset-gpios = <&gpio3 1 0>;
+            clkreq-gpios = <&gpio27 3 0 >;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+          };
+          pcie@5,0 { // Lane 5: Mini PCIe
+            reg = <0x2800 0 0 0 0>;
+            compatible = "pciclass,0604";
+            device_type = "pci";
+            reset-gpios = <&gpio27 4 0 >;
+            clkreq-gpios = <&gpio17 0 0 >;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+          };
+          pcie@7,0 { // Lane 7: Ethernet
+            reg = <0x3800 0 0 0 0>;
+            compatible = "pciclass,0604";
+            device_type = "pci";
+            reset-gpios = <&gpio25 2 0 >;
+            clkreq-gpios = <&gpio20 6 0 >;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+          };
+        };
+      };
     };
-- 
2.31.1

