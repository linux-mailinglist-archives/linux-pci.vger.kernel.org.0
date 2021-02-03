Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F7130D3AD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhBCHDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231542AbhBCHCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:02:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CAF164F5D;
        Wed,  3 Feb 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335720;
        bh=E7yUqQo8Xn6JFXZwfNI1IGv93ZrxMNRZcf6mv6VtGWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuhKsqo+otYUgU/fiLZBZYudsjQYEMq+U1nY2q51juNEp1wLW8Nt2NNSWCE5K7E58
         knbIl41FPMlMspDz6AEZ0ogi4GVxkrBZx+GpXNRnpQMKLL0ckZ2pd6096GFMgR6uUM
         6ZsOMihsfokZhiTxoGhROsr8Vzzx4+rdDjx9bWR276VCwS9VH8S91w6N8TRis6dJpX
         Yhquj7aZZn4SZ2oTv0UFdNLtQpcnGZl2p56HLbb6wvPGe9cAPOawpkhEvsspMqg5QV
         ej+h7+ABq2QHAQI3Z+7pQcbBQnq6xEgXuEodWc1Xs1la+Mfgd4sxdMJgtGJyJXGRA4
         tJlVSkAmDrz4Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAo-001CAS-1k; Wed, 03 Feb 2021 08:01:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 02/11] doc: bindings: kirin-pcie.txt: convert it to YAML
Date:   Wed,  3 Feb 2021 08:01:46 +0100
Message-Id: <8617cb4f27b1f4146b956686f0410e5fc3827379.1612335031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612335031.git.mchehab+huawei@kernel.org>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert	the file into a	DT schema.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 90 +++++++++++++++++++
 .../devicetree/bindings/pci/kirin-pcie.txt    | 50 -----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 91 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
new file mode 100644
index 000000000000..46f9f3f25dbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -0,0 +1,90 @@
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
+  It shares common functions with the PCIe DesignWare core driver.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+#  - $ref: snps,pcie.yaml#
+
+properties:
+  compatible:
+    const: hisilicon,kirin960-pcie
+
+  reg:
+    description: |
+      Should contain rc_dbi, apb, phy, config registers location and length.
+
+  reg-names:
+    items:
+      - const: dbi          # controller configuration registers
+      - const: apb          # apb Ctrl register defined by Kirin
+      - const: phy          # apb PHY register defined by Kirin
+      - const: config       # PCIe configuration space registers
+
+  reset-gpios:
+    description: The GPIO to generate PCIe PERST# assert and deassert signal.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - reset-gpios
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
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
+      pcie: pcie@f4000000 {
+        compatible = "hisilicon,kirin960-pcie";
+        reg = <0x0 0xf4000000 0x0 0x1000>,
+              <0x0 0xff3fe000 0x0 0x1000>,
+              <0x0 0xf3f20000 0x0 0x40000>,
+              <0x0 0xF4000000 0 0x2000>;
+        reg-names = "dbi","apb","phy", "config";
+        bus-range = <0x0  0x1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
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
+        reset-gpios = <&gpio11 1 0 >;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
deleted file mode 100644
index a38f8e38a67b..000000000000
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-HiSilicon Kirin SoCs PCIe host DT description
-
-Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
-It shares common functions with the PCIe DesignWare core driver and
-inherits common properties defined in
-Documentation/devicetree/bindings/pci/snps,pcie.yaml.
-
-Additional properties are described here:
-
-Required properties
-- compatible:
-	"hisilicon,kirin960-pcie" for PCIe of Kirin960 SoC
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
-		compatible = "hisilicon,kirin-pcie";
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 0bcba0d4994c..701d7115af74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13817,7 +13817,7 @@ M:	Xiaowei Song <songxiaowei@hisilicon.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
+F:	Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-kirin.c
 
 PCIE DRIVER FOR HISILICON STB
-- 
2.29.2

