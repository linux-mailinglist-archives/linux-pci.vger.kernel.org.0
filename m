Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243893DFBF0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 09:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhHDHTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 03:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235783AbhHDHTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 03:19:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 586B960F58;
        Wed,  4 Aug 2021 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628061541;
        bh=sHrrMCoPucrOmhUkx7GoWqzSWYG42ct97rGMr7KCNuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSYZkNuaFPMprz0/Zwo0vu7BPog1KXirlnyQAvFRsA5Aowo5GmmmFOYcyPq07MoYy
         MFhXbTtCTC0/BtMZ4T9g3fh13CrlcG6SYxvc2DP1hpmv72aeLZgHKV0SZzyJkkJzcd
         nMwDFhcS0k99mZw/1epa3v45sOTdQi7RZcXh+HvkE8xkKyedTwHzHiQeuZX7lnH4/2
         LQCERZbchHWVCbdoZOFAIFOzpM6YMytCVoagz5Kz5rx7g38/kqBj+eez6K/f3c6/nd
         00B1fLGOXhK9jsxSNERZg4nvsaW7TWt+8jvZ9t5qieq3uoP0OV3MfPYDdtOEPd9eh1
         LWiaSRC/n2+EQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBBB5-000BlG-6c; Wed, 04 Aug 2021 09:18:59 +0200
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
Subject: [PATCH v4 2/4] dt-bindings: PCI: kirin: Convert kirin-pcie.txt to yaml
Date:   Wed,  4 Aug 2021 09:18:55 +0200
Message-Id: <081c179ef2e0ddf11566144cd5967b15268565b4.1628061310.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628061310.git.mchehab+huawei@kernel.org>
References: <cover.1628061310.git.mchehab+huawei@kernel.org>
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
index 66065ae178b1..bde7b13b6bf0 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 5
     items:
       enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
-              ulreg, smu, mpu ]
+              ulreg, smu, mpu, phy ]
 
   num-lanes:
     description: |
diff --git a/MAINTAINERS b/MAINTAINERS
index 36aee8517ab0..ebc9abf061f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14474,7 +14474,7 @@ M:	Xiaowei Song <songxiaowei@hisilicon.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
+F:	Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-kirin.c
 
 PCIE DRIVER FOR HISILICON STB
-- 
2.31.1

