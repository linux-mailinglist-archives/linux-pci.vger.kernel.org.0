Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CCE304446
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbhAZHkK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 02:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbhAZHf4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 02:35:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D30B230FF;
        Tue, 26 Jan 2021 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611646515;
        bh=0PWNmmD8aIrWfoaRqv1U7jZhOGbu0vuhJNezgkrsXMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPNvtx8xHmFxJZemkrAeshowIDXKmlrgddenT0NfhiIDCPzIkxBSVlFMuXfogpOQq
         ZYu0S8x0EKXuE9U+da6FAnD5PvNZkwvXGgIF/AVmAuLYiTf4lO2dF41j7og5gna986
         dHUVis7qw+BD8ngv0cV3nrkYiod3hkQuTV2F+psn0cY0vCZqGZhDT2a3KOsB4po1s4
         Hv5RAvSL0MUFpdKR9qth5MNXqv6EbYqk/QKSGhYt1QjUs4iIqLYdUGOgMR+SoS3GBq
         SwZIvV/5LeZbBsKSr2OYQprkI/Jfhgb8cHWWsk+4cPDswBnq0rz2sy7Qc9gex1LWgd
         cwion271CYlSQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l4Isa-00BqrL-Hy; Tue, 26 Jan 2021 08:35:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH RFC 1/2] dt: pci: designware-pcie.txt: convert it to yaml
Date:   Tue, 26 Jan 2021 08:35:06 +0100
Message-Id: <55f479324098b66d7dba89c8f9c3e455731df4f7.1611645945.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611645945.git.mchehab+huawei@kernel.org>
References: <cover.1611645945.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the file into a JSON description at the yaml format.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
 .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
 .../bindings/pci/designware,pcie.yaml         | 194 ++++++++++++++++++
 .../bindings/pci/designware-pcie.txt          |  77 -------
 .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
 .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
 .../bindings/pci/hisilicon-pcie.txt           |   2 +-
 .../devicetree/bindings/pci/kirin-pcie.txt    |   2 +-
 .../bindings/pci/layerscape-pci.txt           |   2 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
 .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
 .../devicetree/bindings/pci/pci-keystone.txt  |  10 +-
 .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
 .../bindings/pci/samsung,exynos5440-pcie.txt  |   4 +-
 .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
 .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
 .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
 MAINTAINERS                                   |   2 +-
 19 files changed, 225 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/designware,pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
index b6acbe694ffb..86fa86c8cb60 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
@@ -3,7 +3,7 @@ Amlogic Meson AXG DWC PCIE SoC controller
 Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and
 inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/designware,pcie.yaml.
 
 Additional properties are described here:
 
@@ -33,7 +33,7 @@ Required properties:
 - phy-names: must contain "pcie"
 
 - device_type:
-	should be "pci". As specified in designware-pcie.txt
+	should be "pci". As specified in designware,pcie.yaml
 
 
 Example configuration:
diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 979dc7b6cfe8..26496da2a323 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -1,7 +1,7 @@
 * Axis ARTPEC-6 PCIe interface
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in designware,pcie.yaml.
 
 Required properties:
 - compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
diff --git a/Documentation/devicetree/bindings/pci/designware,pcie.yaml b/Documentation/devicetree/bindings/pci/designware,pcie.yaml
new file mode 100644
index 000000000000..e610ed073789
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/designware,pcie.yaml
@@ -0,0 +1,194 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/designware,pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare PCIe interface
+
+maintainers:
+  - Jingoo Han <jingoohan1@gmail.com>
+  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+
+description: |
+  Synopsys DesignWare PCIe host controller
+
+properties:
+  compatible:
+    description: |
+      The compatible can be either:
+      - snps,dw-pcie       # for RC mode
+      - snps,dw-pcie-ep    # For EP mode
+      or some other value, when there's a host-specific driver
+
+  reg:
+    description: |
+      For designware cores version < 4.80 contains the configuration
+      address space. For designware core version >= 4.80, contains
+      the configuration and ATU address space
+    maxItems: 4
+
+  reg-names:
+    description: |
+      Must be "config" for the PCIe configuration space and "atu" for
+      the ATU address space.
+      (The old way of getting the configuration address space from
+      "ranges" is deprecated and should be avoided.)
+    maxItems: 4
+
+  num-lanes:
+    description: |
+      number of lanes to use (this property should be specified unless
+      the link is brought already up in BIOS)
+    maxItems: 1
+
+  reset-gpio:
+    description: GPIO pin number of power good signal
+    maxItems: 1
+
+  clocks:
+    description: |
+      Must contain an entry for each entry in clock-names.
+      See Documentation/devicetree/bindings/clock/clock-bindings.txt for
+      details.
+    minItems: 2
+    maxItems: 8
+
+  clock-names:
+    description: |
+      Must include the following entries:
+      - "pcie"
+      - "pcie_bus"
+    minItems: 2
+    maxItems: 8
+
+  "snps,enable-cdm-check":
+    $ref: /schemas/types.yaml#definitions/flag
+    description: |
+      This is a boolean property and if present enables
+      automatic checking of CDM (Configuration Dependent Module) registers
+      for data corruption. CDM registers include standard PCIe configuration
+      space registers, Port Logic registers, DMA and iATU (internal Address
+      Translation Unit) registers.
+
+  # The following are mandatory properties for RC Mode
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  device_type:
+    const: pci
+
+  ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      ranges for the PCI memory and I/O regions
+    minItems: 1
+    maxItems: 8
+
+  "#interrupt-cells":
+    $ref: /schemas/types.yaml#/definitions/uint32
+    const: 1
+
+  interrupt-map-mask:
+    description: |
+      Standard PCI properties to define the mapping of the PCIe
+      interface to interrupt numbers.
+
+  interrupt-map:
+    description: |
+      Standard PCI properties to define the mapping of the PCIe
+      interface to interrupt numbers.
+
+  # The following are optional properties for RC mode
+
+  num-viewport:
+    description: |
+      number of view ports configured in hardware. If a platform
+      does not specify it, the driver assumes 2.
+
+  bus-range:
+    description: |
+      PCI bus numbers covered (it is recommended for new devicetrees
+      to specify this property, to keep backwards compatibility a range of
+      0x00-0xff is assumed if not present)
+
+  # The following are mandatory properties for EP Mode
+
+  num-ib-windows:
+    description: number of inbound address translation windows
+    maxItems: 1
+
+  num-ob-windows:
+    description: number of outbound address translation windows
+    maxItems: 1
+
+  # The following are optional properties for EP mode
+
+  max-functions:
+    description: maximum number of functions that can be configured
+    maxItems: 1
+
+required:
+  - reg
+  - reg-names
+  - compatible
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: snps,dw-pcie
+    then:
+      required:
+        - compatible
+        - "#address-cells"
+        - "#size-cells"
+        - device_type
+        - ranges
+        - "#interrupt-cells"
+        - interrupt-map-mask
+        - interrupt-map
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: snps,dw-pcie-ep
+    then:
+      required:
+        - compatible
+        - num-ib-windows
+        - num-ob-windows
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie: pcie@dfc00000 {
+      compatible = "snps,dw-pcie";
+      reg = <0xdfc00000 0x0001000>, /* IP registers */
+            <0xd0000000 0x0002000>; /* Configuration space */
+      reg-names = "dbi", "config";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      device_type = "pci";
+      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000
+          0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
+      interrupts = <25>, <24>;
+      #interrupt-cells = <1>;
+      num-lanes = <1>;
+    };
+    pcie_ep: pcie_ep@dfd00000 {
+      compatible = "snps,dw-pcie-ep";
+      reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
+            <0xdfc01000 0x0001000>, /* IP registers 2 */
+            <0xd0000000 0x2000000>; /* Configuration space */
+      reg-names = "dbi", "dbi2", "addr_space";
+      num-ib-windows = <6>;
+      num-ob-windows = <2>;
+      num-lanes = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
deleted file mode 100644
index 78494c4050f7..000000000000
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-* Synopsys DesignWare PCIe interface
-
-Required properties:
-- compatible:
-	"snps,dw-pcie" for RC mode;
-	"snps,dw-pcie-ep" for EP mode;
-- reg: For designware cores version < 4.80 contains the configuration
-       address space. For designware core version >= 4.80, contains
-       the configuration and ATU address space
-- reg-names: Must be "config" for the PCIe configuration space and "atu" for
-	     the ATU address space.
-    (The old way of getting the configuration address space from "ranges"
-    is deprecated and should be avoided.)
-RC mode:
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- device_type: set to "pci"
-- ranges: ranges for the PCI memory and I/O regions
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map: standard PCI
-	properties to define the mapping of the PCIe interface to interrupt
-	numbers.
-EP mode:
-- num-ib-windows: number of inbound address translation windows
-- num-ob-windows: number of outbound address translation windows
-
-Optional properties:
-- num-lanes: number of lanes to use (this property should be specified unless
-  the link is brought already up in BIOS)
-- reset-gpio: GPIO pin number of power good signal
-- clocks: Must contain an entry for each entry in clock-names.
-	See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-	- "pcie"
-	- "pcie_bus"
-- snps,enable-cdm-check: This is a boolean property and if present enables
-   automatic checking of CDM (Configuration Dependent Module) registers
-   for data corruption. CDM registers include standard PCIe configuration
-   space registers, Port Logic registers, DMA and iATU (internal Address
-   Translation Unit) registers.
-RC mode:
-- num-viewport: number of view ports configured in hardware. If a platform
-  does not specify it, the driver assumes 2.
-- bus-range: PCI bus numbers covered (it is recommended for new devicetrees
-  to specify this property, to keep backwards compatibility a range of
-  0x00-0xff is assumed if not present)
-
-EP mode:
-- max-functions: maximum number of functions that can be configured
-
-Example configuration:
-
-	pcie: pcie@dfc00000 {
-		compatible = "snps,dw-pcie";
-		reg = <0xdfc00000 0x0001000>, /* IP registers */
-		      <0xd0000000 0x0002000>; /* Configuration space */
-		reg-names = "dbi", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000
-			  0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
-		interrupts = <25>, <24>;
-		#interrupt-cells = <1>;
-		num-lanes = <1>;
-	};
-or
-	pcie: pcie@dfc00000 {
-		compatible = "snps,dw-pcie-ep";
-		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
-		      <0xdfc01000 0x0001000>, /* IP registers 2 */
-		      <0xd0000000 0x2000000>; /* Configuration space */
-		reg-names = "dbi", "dbi2", "addr_space";
-		num-ib-windows = <6>;
-		num-ob-windows = <2>;
-		num-lanes = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index de4b2baf91e8..bc6407793d7e 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -1,7 +1,7 @@
 * Freescale i.MX6 PCIe interface
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in designware,pcie.yaml.
 
 Required properties:
 - compatible:
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
index 760b4d740616..0994cf32c48d 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
@@ -3,7 +3,7 @@ HiSilicon STB PCIe host bridge DT description
 The HiSilicon STB PCIe host controller is based on the DesignWare PCIe core.
 It shares common functions with the DesignWare PCIe core driver and inherits
 common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/designware,pcie.yaml.
 
 Additional properties are described here:
 
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index d6796ef54ea1..6596f9042728 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -3,7 +3,7 @@ HiSilicon Hip05 and Hip06 PCIe host bridge DT description
 HiSilicon PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and inherits
 common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/designware,pcie.yaml.
 
 Additional properties are described here:
 
diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 6bbe43818ad5..8e4fe7fc50f9 100644
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -3,7 +3,7 @@ HiSilicon Kirin SoCs PCIe host DT description
 Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and
 inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/designware,pcie.yaml.
 
 Additional properties are described here:
 
diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index daa99f7d4c3f..13716646be08 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -1,7 +1,7 @@
 Freescale Layerscape PCIe controller
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in designware,pcie.yaml.
 
 This controller derives its clocks from the Reset Configuration Word (RCW)
 which is used to describe the PLL settings at the time of chip-reset.
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index bd43f3c3ece4..94cfc001283d 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -1,7 +1,7 @@
 NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
 
 This PCIe controller is based on the Synopsis Designware PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in designware,pcie.yaml.
 Some of the controller instances are dual mode where in they can work either
 in root port mode or endpoint mode but one at a time.
 
@@ -22,7 +22,7 @@ Required properties:
   property.
 - reg-names: Must include the following entries:
   "appl": Controller's application logic registers
-  "config": As per the definition in designware-pcie.txt
+  "config": As per the definition in designware,pcie.yaml
   "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
              Translation Unit) registers of the PCIe core are made available
              for SW access.
diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index 7a813d0e6d63..3fe051377d7b 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -1,7 +1,7 @@
 * Marvell Armada 7K/8K PCIe interface
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in designware,pcie.yaml.
 
 Required properties:
 - compatible: "marvell,armada8k-pcie"
diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 47202a2938f2..184a09ea732f 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -3,9 +3,9 @@ TI Keystone PCIe interface
 Keystone PCI host Controller is based on the Synopsys DesignWare PCI
 hardware version 3.65.  It shares common functions with the PCIe DesignWare
 core driver and inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt
+Documentation/devicetree/bindings/pci/designware,pcie.yaml
 
-Please refer to Documentation/devicetree/bindings/pci/designware-pcie.txt
+Please refer to Documentation/devicetree/bindings/pci/designware,pcie.yaml
 for the details of DesignWare DT bindings.  Additional properties are
 described here as well as properties that are not applicable.
 
@@ -82,11 +82,11 @@ reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 	   Address Translation Unit configuration registers and
 	   "addr_space" used to map remote RC address space
 num-ib-windows: As specified in
-		Documentation/devicetree/bindings/pci/designware-pcie.txt
+		Documentation/devicetree/bindings/pci/designware,pcie.yaml
 num-ob-windows: As specified in
-		Documentation/devicetree/bindings/pci/designware-pcie.txt
+		Documentation/devicetree/bindings/pci/designware,pcie.yaml
 num-lanes: As specified in
-	   Documentation/devicetree/bindings/pci/designware-pcie.txt
+	   Documentation/devicetree/bindings/pci/designware,pcie.yaml
 power-domains: As documented by the generic PM domain bindings in
 	       Documentation/devicetree/bindings/power/power_domain.txt.
 ti,syscon-pcie-mode: phandle to the device control module required to configure
diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
index 557a5089229d..bcd825308fb5 100644
--- a/Documentation/devicetree/bindings/pci/pcie-al.txt
+++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
@@ -2,7 +2,7 @@
 
 Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys DesignWare
 PCI core. It inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/designware,pcie.yaml.
 
 Properties of the host controller node that differ from it are:
 
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 02bc81bb8b2d..300073bd2aa4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -31,22 +31,22 @@
 - device_type:
 	Usage: required
 	Value type: <string>
-	Definition: Should be "pci". As specified in designware-pcie.txt
+	Definition: Should be "pci". As specified in designware,pcie.yaml
 
 - #address-cells:
 	Usage: required
 	Value type: <u32>
-	Definition: Should be 3. As specified in designware-pcie.txt
+	Definition: Should be 3. As specified in designware,pcie.yaml
 
 - #size-cells:
 	Usage: required
 	Value type: <u32>
-	Definition: Should be 2. As specified in designware-pcie.txt
+	Definition: Should be 2. As specified in designware,pcie.yaml
 
 - ranges:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
+	Definition: As specified in designware,pcie.yaml
 
 - interrupts:
 	Usage: required
@@ -61,17 +61,17 @@
 - #interrupt-cells:
 	Usage: required
 	Value type: <u32>
-	Definition: Should be 1. As specified in designware-pcie.txt
+	Definition: Should be 1. As specified in designware,pcie.yaml
 
 - interrupt-map-mask:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
+	Definition: As specified in designware,pcie.yaml
 
 - interrupt-map:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
+	Definition: As specified in designware,pcie.yaml
 
 - clocks:
 	Usage: required
diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
index 651d957d1051..f32b56f08794 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
@@ -1,7 +1,7 @@
 * Samsung Exynos 5440 PCIe interface
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in designware,pcie.yaml.
 
 Required properties:
 - compatible: "samsung,exynos5440-pcie"
@@ -16,7 +16,7 @@ Required properties:
 	Refer to Documentation/devicetree/bindings/phy/samsung-phy.txt
 
 For other common properties, refer to
-	Documentation/devicetree/bindings/pci/designware-pcie.txt
+	Documentation/devicetree/bindings/pci/designware,pcie.yaml
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index d6cf8a560ef0..a6e71daed944 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -10,7 +10,7 @@ description: |
   UniPhier PCIe endpoint controller is based on the Synopsys DesignWare
   PCI core. It shares common features with the PCIe DesignWare core and
   inherits common properties defined in
-  Documentation/devicetree/bindings/pci/designware-pcie.txt.
+  Documentation/devicetree/bindings/pci/designware,pcie.yaml.
 
 maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index d5cbfe6b0d89..e021ed076192 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -12,7 +12,7 @@ PCIe DesignWare Controller
 	       number of PHYs as specified in *phys* property.
  - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
 	       where <X> is the instance number of the pcie from the HW spec.
- - num-lanes as specified in ../designware-pcie.txt
+ - num-lanes as specified in ../designware,pcie.yaml
  - ti,syscon-lane-sel : phandle/offset pair. Phandle to the system control
 			module and the register offset to specify lane
 			selection.
@@ -32,7 +32,7 @@ HOST MODE
    device_type,
    ranges,
    interrupt-map-mask,
-   interrupt-map : as specified in ../designware-pcie.txt
+   interrupt-map : as specified in ../designware,pcie.yaml
  - ti,syscon-unaligned-access: phandle to the syscon DT node. The 1st argument
 			       should contain the register offset within syscon
 			       and the 2nd argument should contain the bit field
diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
index c4b7381733a0..7810132d62db 100644
--- a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
@@ -6,7 +6,7 @@ on Socionext UniPhier SoCs.
 UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and inherits
 common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/designware,pcie.yaml.
 
 Required properties:
 - compatible: Should be "socionext,uniphier-pcie".
diff --git a/MAINTAINERS b/MAINTAINERS
index 138798bbb32e..3bb3233830ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13469,7 +13469,7 @@ M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
+F:	Documentation/devicetree/bindings/pci/designware,pcie.yaml
 F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX/J721E
-- 
2.29.2

