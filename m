Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B605F3DE583
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 06:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhHCEjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 00:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233878AbhHCEjO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 00:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2C0860F9C;
        Tue,  3 Aug 2021 04:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627965543;
        bh=z0aya0UFmOacKi0Vl++gYqtojCgt6X7zC5DUdaHjVsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjEKd+3QNsqnXTe8oJpF+JKodXWdp8wkuC0pjj6iepntRC39Mm+oiAycdchcDkkn+
         NP5L4VzRFDHwm5zgMb8lp268cWmpzGJ5uz4S5gvPnVJ1H/knZ1RebWDQ565I454Sif
         6IHS9K2nQQiQrtqpZc6XLFzStET63fFto+HYXR35ZkcjTmcj//uVwoOrLiBTu1YNRs
         0O1Hq0ja9OdSXHBC9jCtpBtOiTTdsSmuybwFF+2xpBmQCJx135HhFW6xICEWz54v3V
         nnJXOWRKdaP7l9PNlHfEbLTp77pD5rojeoSvdFZAi4FMJnZDTsce0QBZ8z6RQ6uk6m
         8MF/TLt7/NnOA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mAmCj-00D8KH-HA; Tue, 03 Aug 2021 06:39:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: PCI: kirin: Convert kirin-pcie.txt to yaml
Date:   Tue,  3 Aug 2021 06:38:56 +0200
Message-Id: <4d6e172cee9d477547d5ea26d0e5945fcbce15a1.1627965261.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627965261.git.mchehab+huawei@kernel.org>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the file into a JSON description at the yaml format.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 86 +++++++++++++++++++
 .../devicetree/bindings/pci/kirin-pcie.txt    | 50 -----------
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
 MAINTAINERS                                   |  2 +-
 4 files changed, 88 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
new file mode 100644
index 000000000000..90cab09e8d4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/hisilicon,kirin-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon Kirin SoCs PCIe host DT description
+
+maintainers:
+  - Xiaowei Song <songxiaowei@hisilicon.com>
+  - Binghui Wang <wangbinghui@hisilicon.com>
+
+description: |
+  Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
+  It shares common functions with the PCIe DesignWare core driver and
+  inherits common properties defined in
+  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - hisilicon,kirin960-pcie
+
+  reg:
+    description: |
+      Should contain dbi, apb, config registers location and length.
+      For HiKey960, it should also contain phy.
+    minItems: 3
+    maxItems: 4
+
+  reg-names:
+    minItems: 3
+    maxItems: 4
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/hi3660-clock.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie@f4000000 {
+        compatible = "hisilicon,kirin960-pcie";
+        reg = <0x0 0xf4000000 0x0 0x1000>,
+              <0x0 0xff3fe000 0x0 0x1000>,
+              <0x0 0xf3f20000 0x0 0x40000>,
+              <0x0 0xf5000000 0x0 0x2000>;
+        reg-names = "dbi", "apb", "phy", "config";
+        bus-range = <0x0  0x1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x02000000 0x0 0x00000000
+                  0x0 0xf6000000
+                  0x0 0x02000000>;
+        num-lanes = <1>;
+        #interrupt-cells = <1>;
+        interrupts = <0 283 4>;
+        interrupt-names = "msi";
+        interrupt-map-mask = <0xf800 0 0 7>;
+        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+                 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+                 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+        clock-names = "pcie_phy_ref", "pcie_aux", "pcie_apb_phy",
+                      "pcie_apb_sys", "pcie_aclk";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
deleted file mode 100644
index 7adab8999a6a..000000000000
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-HiSilicon Kirin SoCs PCIe host DT description
-
-Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
-It shares common functions with the PCIe DesignWare core driver and
-inherits common properties defined in
-Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
-
-Additional properties are described here:
-
-Required properties
-- compatible:
-	"hisilicon,kirin960-pcie"
-- reg: Should contain rc_dbi, apb, phy, config registers location and length.
-- reg-names: Must include the following entries:
-  "dbi": controller configuration registers;
-  "apb": apb Ctrl register defined by Kirin;
-  "phy": apb PHY register defined by Kirin;
-  "config": PCIe configuration space registers.
-- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
-
-Optional properties:
-
-Example based on kirin960:
-
-	pcie@f4000000 {
-		compatible = "hisilicon,kirin960-pcie";
-		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
-		      <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
-		reg-names = "dbi","apb","phy", "config";
-		bus-range = <0x0  0x1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
-		num-lanes = <1>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <0x0 0 0 1 &gic 0 0 0  282 4>,
-				<0x0 0 0 2 &gic 0 0 0  283 4>,
-				<0x0 0 0 3 &gic 0 0 0  284 4>,
-				<0x0 0 0 4 &gic 0 0 0  285 4>;
-		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
-			 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
-			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
-			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
-			 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
-		clock-names = "pcie_phy_ref", "pcie_aux",
-			      "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
-		reset-gpios = <&gpio11 1 0 >;
-	};
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index a8c1db879fb9..6c7501b8df01 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -34,7 +34,7 @@ properties:
     minItems: 2
     maxItems: 5
     items:
-      enum: [dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link]
+      enum: [dbi, dbi2, config, atu, apb, app, elbi, mgmt, ctrl, parf, cfg, link, phy]
 
   num-lanes:
     description: |
diff --git a/MAINTAINERS b/MAINTAINERS
index b54bd9dd07ec..d5f53b2d3f9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14420,7 +14420,7 @@ M:	Xiaowei Song <songxiaowei@hisilicon.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
+F:	Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-kirin.c
 
 PCIE DRIVER FOR HISILICON STB
-- 
2.31.1

