Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BF03C6F85
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhGMLVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 07:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235722AbhGMLU6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 07:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37E1161288;
        Tue, 13 Jul 2021 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175088;
        bh=AngUU9+jd6y01vzvv76hHqD4lr+yecKXQycEwI6Sb3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1aaoKWXePISgj92rle1dWtVvJ73H/UsL7ZKeyH+0Jdo+b6meGHEi8s78itNi1PC2
         +rTmv5tHP9/Qc8+Xhbvk7E0e6Gj4xk+umOPYw3HtBbLhHQVPBcROass4sBAq/rywvy
         7eDR0TXba0czB9Tv505GO+YOEpgTbKRCGBbcljFCyQDFCHUArwcTadRej54xe5BEY8
         vTZ9tSdxRLsVhq7I0Ci1tZCDTRUvAPwu8lUaK4QhWbZ1gmLnC2XUSpVGUpypUofwCh
         kKYhcus8xky/63UPAqyo9fZf5nWYByT8wqr8qnkrlvA4t+RMjVOYwR1sj4Hm/GgWW7
         cO0fVV3b8arwg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3GQL-006b3h-09; Tue, 13 Jul 2021 13:18:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 3/5] dt-bindings: PCI: update references to Designware schema
Date:   Tue, 13 Jul 2021 13:17:53 +0200
Message-Id: <2df0a85eaab7bae83719ca61e3fb64dda5a14a8c.1626174242.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626174242.git.mchehab+huawei@kernel.org>
References: <cover.1626174242.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that its contents were converted to a DT schema, replace
the references for the old file on existing properties.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  4 ++--
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |  2 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  2 +-
 .../bindings/pci/hisilicon-histb-pcie.txt          |  2 +-
 .../devicetree/bindings/pci/kirin-pcie.txt         |  2 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |  2 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt          |  5 +++--
 .../devicetree/bindings/pci/pci-armada8k.txt       |  2 +-
 Documentation/devicetree/bindings/pci/pcie-al.txt  |  2 +-
 .../devicetree/bindings/pci/qcom,pcie.txt          | 14 +++++++-------
 .../bindings/pci/samsung,exynos-pcie.yaml          |  4 ++--
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml |  4 ++--
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  4 ++--
 Documentation/devicetree/bindings/pci/ti-pci.txt   |  4 ++--
 .../devicetree/bindings/pci/uniphier-pcie.txt      |  2 +-
 15 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
index b6acbe694ffb..c3a75ac6e59d 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
@@ -3,7 +3,7 @@ Amlogic Meson AXG DWC PCIE SoC controller
 Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and
 inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
 
 Additional properties are described here:
 
@@ -33,7 +33,7 @@ Required properties:
 - phy-names: must contain "pcie"
 
 - device_type:
-	should be "pci". As specified in designware-pcie.txt
+	should be "pci". As specified in snps,dw-pcie.yaml
 
 
 Example configuration:
diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 979dc7b6cfe8..cc6dcdb676b9 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -1,7 +1,7 @@
 * Axis ARTPEC-6 PCIe interface
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
 Required properties:
 - compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index d8971ab99274..5e6eb44c81b5 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -1,7 +1,7 @@
 * Freescale i.MX6 PCIe interface
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
 Required properties:
 - compatible:
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
index 760b4d740616..5f0cf6c2fef3 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
@@ -3,7 +3,7 @@ HiSilicon STB PCIe host bridge DT description
 The HiSilicon STB PCIe host controller is based on the DesignWare PCIe core.
 It shares common functions with the DesignWare PCIe core driver and inherits
 common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
 
 Additional properties are described here:
 
diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 585aadfeafd1..3a36eeb1c434 100644
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -3,7 +3,7 @@ HiSilicon Kirin SoCs PCIe host DT description
 Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and
 inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
 
 Additional properties are described here:
 
diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 6d898dd4a8e2..f36efa73a470 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -1,7 +1,7 @@
 Freescale Layerscape PCIe controller
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
 This controller derives its clocks from the Reset Configuration Word (RCW)
 which is used to describe the PLL settings at the time of chip-reset.
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index bd43f3c3ece4..6a99d2aa8075 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -1,7 +1,8 @@
 NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
 
 This PCIe controller is based on the Synopsis Designware PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in snps,dw-pcie.yaml and
+snps,dw-pcie-ep.yaml.
 Some of the controller instances are dual mode where in they can work either
 in root port mode or endpoint mode but one at a time.
 
@@ -22,7 +23,7 @@ Required properties:
   property.
 - reg-names: Must include the following entries:
   "appl": Controller's application logic registers
-  "config": As per the definition in designware-pcie.txt
+  "config": As per the definition in snps,dw-pcie.yaml
   "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
              Translation Unit) registers of the PCIe core are made available
              for SW access.
diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index 7a813d0e6d63..ff25a134befa 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -1,7 +1,7 @@
 * Marvell Armada 7K/8K PCIe interface
 
 This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
+and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
 Required properties:
 - compatible: "marvell,armada8k-pcie"
diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
index 557a5089229d..2ad1fe466eab 100644
--- a/Documentation/devicetree/bindings/pci/pcie-al.txt
+++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
@@ -2,7 +2,7 @@
 
 Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys DesignWare
 PCI core. It inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
 
 Properties of the host controller node that differ from it are:
 
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 25f4def468bf..3f646875f8c2 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -34,22 +34,22 @@
 - device_type:
 	Usage: required
 	Value type: <string>
-	Definition: Should be "pci". As specified in designware-pcie.txt
+	Definition: Should be "pci". As specified in snps,dw-pcie.yaml
 
 - #address-cells:
 	Usage: required
 	Value type: <u32>
-	Definition: Should be 3. As specified in designware-pcie.txt
+	Definition: Should be 3. As specified in snps,dw-pcie.yaml
 
 - #size-cells:
 	Usage: required
 	Value type: <u32>
-	Definition: Should be 2. As specified in designware-pcie.txt
+	Definition: Should be 2. As specified in snps,dw-pcie.yaml
 
 - ranges:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
+	Definition: As specified in snps,dw-pcie.yaml
 
 - interrupts:
 	Usage: required
@@ -64,17 +64,17 @@
 - #interrupt-cells:
 	Usage: required
 	Value type: <u32>
-	Definition: Should be 1. As specified in designware-pcie.txt
+	Definition: Should be 1. As specified in snps,dw-pcie.yaml
 
 - interrupt-map-mask:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
+	Definition: As specified in snps,dw-pcie.yaml
 
 - interrupt-map:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
+	Definition: As specified in snps,dw-pcie.yaml
 
 - clocks:
 	Usage: required
diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
index 1810bf722350..445eed94b53f 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
@@ -13,10 +13,10 @@ maintainers:
 description: |+
   Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
   PCIe IP and thus inherits all the common properties defined in
-  designware-pcie.txt.
+  snps,dw-pcie.yaml.
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index b03cbb9b6602..2b9d1d6fc661 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -10,14 +10,14 @@ description: |+
   SiFive FU740 PCIe host controller is based on the Synopsys DesignWare
   PCI core. It shares common features with the PCIe DesignWare core and
   inherits common properties defined in
-  Documentation/devicetree/bindings/pci/designware-pcie.txt.
+  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
 
 maintainers:
   - Paul Walmsley <paul.walmsley@sifive.com>
   - Greentime Hu <greentime.hu@sifive.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index d6cf8a560ef0..144cbcd60a1c 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -10,13 +10,13 @@ description: |
   UniPhier PCIe endpoint controller is based on the Synopsys DesignWare
   PCI core. It shares common features with the PCIe DesignWare core and
   inherits common properties defined in
-  Documentation/devicetree/bindings/pci/designware-pcie.txt.
+  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml.
 
 maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 allOf:
-  - $ref: "pci-ep.yaml#"
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index d5cbfe6b0d89..8147e3e3e29b 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -12,7 +12,7 @@ PCIe DesignWare Controller
 	       number of PHYs as specified in *phys* property.
  - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
 	       where <X> is the instance number of the pcie from the HW spec.
- - num-lanes as specified in ../designware-pcie.txt
+ - num-lanes as specified in ../snps,dw-pcie.yaml
  - ti,syscon-lane-sel : phandle/offset pair. Phandle to the system control
 			module and the register offset to specify lane
 			selection.
@@ -32,7 +32,7 @@ HOST MODE
    device_type,
    ranges,
    interrupt-map-mask,
-   interrupt-map : as specified in ../designware-pcie.txt
+   interrupt-map : as specified in ../snps,dw-pcie.yaml
  - ti,syscon-unaligned-access: phandle to the syscon DT node. The 1st argument
 			       should contain the register offset within syscon
 			       and the 2nd argument should contain the bit field
diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
index c4b7381733a0..359585db049f 100644
--- a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
@@ -6,7 +6,7 @@ on Socionext UniPhier SoCs.
 UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and inherits
 common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt.
+Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
 
 Required properties:
 - compatible: Should be "socionext,uniphier-pcie".
-- 
2.31.1

