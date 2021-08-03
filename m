Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C33DE584
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 06:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhHCEjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 00:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233888AbhHCEjO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 00:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B81316104F;
        Tue,  3 Aug 2021 04:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627965543;
        bh=LrrFZSakdUxKwsRUW/i3f6iMngeHtZ/JieQmAqMg4aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ME1cin80LMWK3bk/ft2AS9dbDKCgdkF9Uz7YzLlejaJ9zBE5m/yZKSgXtwYBaFFbU
         jt/VCePPelSXrwc+HavXw59ttZRUySQWXvSIZQAY4qe0rVoy4J9/+qK3IsaiF1Aqxn
         dUfeQbVJMCsyHMvcLPLI/KUwBqEbXgaAELpGuieJLqRYSxCkH47NMTuW46SPWDRWy2
         rEjEmDlsequvUsOdVYl+d5Ot8tZ9bSEOGmAfrihviHTPjHNBPjblDiKZBvKoE79D+c
         2rRfY0Y4MIPivb8J8ktuE5FVSd6BZVRrFvSa0wmnbxRBj9uHrxqIEWgLkaRqhNCCh3
         cV+ZlG6A1S5Hg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mAmCj-00D8KL-If; Tue, 03 Aug 2021 06:39:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: PCI: kirin: Add support for Kirin970
Date:   Tue,  3 Aug 2021 06:38:57 +0200
Message-Id: <c7f01a8aba924ba90c3e8071d57998f7e0590b9b.1627965261.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627965261.git.mchehab+huawei@kernel.org>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
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
index 90cab09e8d4b..c0551d2e606d 100644
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
+          pcie@7,0 { // Lane 6: Ethernet
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

