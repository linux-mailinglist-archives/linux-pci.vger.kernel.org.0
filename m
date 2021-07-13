Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3893C6F7B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 13:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhGMLU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 07:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235709AbhGMLU6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 07:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41A146128B;
        Tue, 13 Jul 2021 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175088;
        bh=B4jrV49pQ0ECfJdfLnhF4upHjmaI6gwsWgymRUmtsww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/hGq9nN5Spi10U04g6BPiGuDeOAaCGttOByIKYPI8P8iZyGgs3pt3En5+Fk9czK6
         cORhGJdSpgjkQCbGdw1UuTFU+Xxau2vbLYKyU/Qv82EFizSfgMC1G8Si63FGQHG2Cr
         hEaEgQv5n4UWGNhsCbEFQriXhe9wfdngRRYyRNZV+qtMILKrDWlvcQM9UPoPWF8xdK
         zOXvev+d7i68ctZSjdN4yqoLyV/bdurXqy1bFmG0qookhuSj2QVR7K59P7WnIUCbv2
         NohKhOOwFCPHzxo3wvm5Dn23grBhz4YZMGjlzersJxoOPTaJYd3VtkOt9aDgJvRSWd
         ex8EmOfN/8XkA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3GQL-006b3n-2v; Tue, 13 Jul 2021 13:18:01 +0200
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
Subject: [PATCH v4 5/5] dt-bindings: PCI: kirin-pcie.txt: Convert it to yaml
Date:   Tue, 13 Jul 2021 13:17:55 +0200
Message-Id: <1f9b2f372364328e9cd3a18cf605ad541f3de4ab.1626174242.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626174242.git.mchehab+huawei@kernel.org>
References: <cover.1626174242.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the file into a JSON description at the yaml format.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 81 +++++++++++++++++++
 .../devicetree/bindings/pci/kirin-pcie.txt    | 41 ----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 82 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
new file mode 100644
index 000000000000..f797e2cc3da6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -0,0 +1,81 @@
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
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - hisilicon,kirin960-pcie
+        - hisilicon,kirin970-pcie
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

