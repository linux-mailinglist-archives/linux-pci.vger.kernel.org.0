Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102543C2565
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 15:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhGIOAc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 10:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232083AbhGIOAb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 10:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04FE5613C1;
        Fri,  9 Jul 2021 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625839068;
        bh=V7HJ8fMGt1R/rfzieoKwkAhPUtMkuM6FOH/wYJYnCGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwpnxKqaT9YJKkcKm1jsUKDwbkkL2mCvSU3FQ1bmEaOGeIJ9altd1QIzjJPY1CTSj
         vtUQRqqUOnoIQ5Yu0ozbPas0SclC5rCBQERtqUu4ZQ+ORP9BOW9XcGOexsPq+52g5X
         ry+65t2UbTDMsP2DweTu2GIHf9tmIRDo4Pf5GtifAY4q7GwZUM/jUtTau17COQNScq
         hfjXnEMsxNeEhjj20dyJlxD2WC2DjFAmJ4d7vIL/FKccgIFwRlFI0L7Q+YJ/syAjiC
         /N+Qj/HP473sIrpXnoVGguxvEGFl/Jvn3p5XTke8AieF4xJ6rcjKXg+xoeGDwllaWd
         lqpZ5xOmVRGxg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1r0i-0004lI-N6; Fri, 09 Jul 2021 15:57:44 +0200
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
Subject: [PATCH v3 2/2] dt-bindings: PCI: kirin-pcie.txt: convert it to yaml
Date:   Fri,  9 Jul 2021 15:57:43 +0200
Message-Id: <29d96d1b7fc27efd1437ba0cd73e21dfd354ac23.1625838920.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625838920.git.mchehab+huawei@kernel.org>
References: <cover.1625838920.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the file into a JSON description at the yaml format.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 79 +++++++++++++++++++
 .../devicetree/bindings/pci/kirin-pcie.txt    | 41 ----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 80 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
new file mode 100644
index 000000000000..66271419cd6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -0,0 +1,79 @@
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
+  Documentation/devicetree/bindings/pci/designware,pcie.yaml.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: hisilicon,kirin960-pcie
+    const: hisilicon,kirin970-pcie
+
+  reg:
+    description: |
+      Should contain rc_dbi, apb, config registers location and length.
+
+  reg-names:
+    items:
+      - const: dbi          # controller configuration registers
+      - const: apb          # apb Ctrl register defined by Kirin
+      - const: config       # PCIe configuration space registers
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
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
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie: pcie@f4000000 {
+        compatible = "hisilicon,kirin960-pcie";
+        reg = <0x0 0xf4000000 0x0 0x1000>,
+              <0x0 0xff3fe000 0x0 0x1000>,
+              <0x0 0xf4000000 0 0x2000>;
+        reg-names = "dbi","apb", "config";
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
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
deleted file mode 100644
index 3a36eeb1c434..000000000000
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ /dev/null
@@ -1,41 +0,0 @@
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
-	"hisilicon,kirin970-pcie"
-- reg: Should contain rc_dbi, apb, config registers location and length.
-- reg-names: Must include the following entries:
-  "dbi": controller configuration registers;
-  "apb": apb Ctrl register defined by Kirin;
-  "config": PCIe configuration space registers.
-
-Optional properties:
-
-Example based on kirin960:
-
-	pcie@f4000000 {
-		compatible = "hisilicon,kirin960-pcie";
-		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
-		      <0x0 0xF4000000 0 0x2000>;
-		reg-names = "dbi","apb", "config";
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
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 55ca4cac17b0..d5a592db84d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14369,7 +14369,7 @@ M:	Xiaowei Song <songxiaowei@hisilicon.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
+F:	Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-kirin.c
 
 PCIE DRIVER FOR HISILICON STB
-- 
2.31.1

