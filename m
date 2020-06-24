Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C437206D3C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 09:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbgFXHCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 03:02:38 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:47352 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387918AbgFXHCh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 03:02:37 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jun 2020 00:02:36 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg02-sd.qualcomm.com with ESMTP; 24 Jun 2020 00:02:32 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 8E72D217C4; Wed, 24 Jun 2020 12:32:30 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pci: convert QCOM pci bindings to YAML
Date:   Wed, 24 Jun 2020 12:32:04 +0530
Message-Id: <1592982124-27160-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert QCOM pci bindings to YAML schema

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt          | 330 ---------------
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 470 +++++++++++++++++++++
 2 files changed, 470 insertions(+), 330 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
deleted file mode 100644
index 981b4de12807..000000000000
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ /dev/null
@@ -1,330 +0,0 @@
-* Qualcomm PCI express root complex
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Value should contain
-			- "qcom,pcie-ipq8064" for ipq8064
-			- "qcom,pcie-apq8064" for apq8064
-			- "qcom,pcie-apq8084" for apq8084
-			- "qcom,pcie-msm8996" for msm8996 or apq8096
-			- "qcom,pcie-ipq4019" for ipq4019
-			- "qcom,pcie-ipq8074" for ipq8074
-			- "qcom,pcie-qcs404" for qcs404
-			- "qcom,pcie-sdm845" for sdm845
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: Register ranges as listed in the reg-names property
-
-- reg-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Must include the following entries
-			- "parf"   Qualcomm specific registers
-			- "dbi"	   DesignWare PCIe registers
-			- "elbi"   External local bus interface registers
-			- "config" PCIe configuration space
-
-- device_type:
-	Usage: required
-	Value type: <string>
-	Definition: Should be "pci". As specified in designware-pcie.txt
-
-- #address-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: Should be 3. As specified in designware-pcie.txt
-
-- #size-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: Should be 2. As specified in designware-pcie.txt
-
-- ranges:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: MSI interrupt
-
-- interrupt-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Should contain "msi"
-
-- #interrupt-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: Should be 1. As specified in designware-pcie.txt
-
-- interrupt-map-mask:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
-
-- interrupt-map:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: As specified in designware-pcie.txt
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: List of phandle and clock specifier pairs as listed
-		    in clock-names property
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "iface"	Configuration AHB clock
-
-- clock-names:
-	Usage: required for ipq/apq8064
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "core"	Clocks the pcie hw block
-			- "phy"		Clocks the pcie PHY block
-- clock-names:
-	Usage: required for apq8084/ipq4019
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "aux"		Auxiliary (AUX) clock
-			- "bus_master"	Master AXI clock
-			- "bus_slave"	Slave AXI clock
-
-- clock-names:
-	Usage: required for msm8996/apq8096
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "pipe"	Pipe Clock driving internal logic
-			- "aux"		Auxiliary (AUX) clock
-			- "cfg"		Configuration clock
-			- "bus_master"	Master AXI clock
-			- "bus_slave"	Slave AXI clock
-
-- clock-names:
-	Usage: required for ipq8074
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "iface"	PCIe to SysNOC BIU clock
-			- "axi_m"	AXI Master clock
-			- "axi_s"	AXI Slave clock
-			- "ahb"		AHB clock
-			- "aux"		Auxiliary clock
-
-- clock-names:
-	Usage: required for qcs404
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "iface"	AHB clock
-			- "aux"		Auxiliary clock
-			- "master_bus"	AXI Master clock
-			- "slave_bus"	AXI Slave clock
-
--clock-names:
-	Usage: required for sdm845
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "aux"		Auxiliary clock
-			- "cfg"		Configuration clock
-			- "bus_master"	Master AXI clock
-			- "bus_slave"	Slave AXI clock
-			- "slave_q2a"	Slave Q2A clock
-			- "tbu"		PCIe TBU clock
-			- "pipe"	PIPE clock
-
-- resets:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: List of phandle and reset specifier pairs as listed
-		    in reset-names property
-
-- reset-names:
-	Usage: required for ipq/apq8064
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "axi"  AXI reset
-			- "ahb"  AHB reset
-			- "por"  POR reset
-			- "pci"  PCI reset
-			- "phy"  PHY reset
-
-- reset-names:
-	Usage: required for apq8084
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "core" Core reset
-
-- reset-names:
-	Usage: required for ipq/apq8064
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "axi_m"		AXI master reset
-			- "axi_s"		AXI slave reset
-			- "pipe"		PIPE reset
-			- "axi_m_vmid"		VMID reset
-			- "axi_s_xpu"		XPU reset
-			- "parf"		PARF reset
-			- "phy"			PHY reset
-			- "axi_m_sticky"	AXI sticky reset
-			- "pipe_sticky"		PIPE sticky reset
-			- "pwr"			PWR reset
-			- "ahb"			AHB reset
-			- "phy_ahb"		PHY AHB reset
-
-- reset-names:
-	Usage: required for ipq8074
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "pipe"		PIPE reset
-			- "sleep"		Sleep reset
-			- "sticky"		Core Sticky reset
-			- "axi_m"		AXI Master reset
-			- "axi_s"		AXI Slave reset
-			- "ahb"			AHB Reset
-			- "axi_m_sticky"	AXI Master Sticky reset
-
-- reset-names:
-	Usage: required for qcs404
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "axi_m"		AXI Master reset
-			- "axi_s"		AXI Slave reset
-			- "axi_m_sticky"	AXI Master Sticky reset
-			- "pipe_sticky"		PIPE sticky reset
-			- "pwr"			PWR reset
-			- "ahb"			AHB reset
-
-- reset-names:
-	Usage: required for sdm845
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "pci"			PCIe core reset
-
-- power-domains:
-	Usage: required for apq8084 and msm8996/apq8096
-	Value type: <prop-encoded-array>
-	Definition: A phandle and power domain specifier pair to the
-		    power domain which is responsible for collapsing
-		    and restoring power to the peripheral
-
-- vdda-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: A phandle to the core analog power supply
-
-- vdda_phy-supply:
-	Usage: required for ipq/apq8064
-	Value type: <phandle>
-	Definition: A phandle to the analog power supply for PHY
-
-- vdda_refclk-supply:
-	Usage: required for ipq/apq8064
-	Value type: <phandle>
-	Definition: A phandle to the analog power supply for IC which generates
-		    reference clock
-- vddpe-3v3-supply:
-	Usage: optional
-	Value type: <phandle>
-	Definition: A phandle to the PCIe endpoint power supply
-
-- phys:
-	Usage: required for apq8084 and qcs404
-	Value type: <phandle>
-	Definition: List of phandle(s) as listed in phy-names property
-
-- phy-names:
-	Usage: required for apq8084 and qcs404
-	Value type: <stringlist>
-	Definition: Should contain "pciephy"
-
-- <name>-gpios:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: List of phandle and GPIO specifier pairs. Should contain
-			- "perst-gpios"	PCIe endpoint reset signal line
-			- "wake-gpios"	PCIe endpoint wake signal line
-
-* Example for ipq/apq8064
-	pcie@1b500000 {
-		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
-		reg = <0x1b500000 0x1000
-		       0x1b502000 0x80
-		       0x1b600000 0x100
-		       0x0ff00000 0x100000>;
-		reg-names = "dbi", "elbi", "parf", "config";
-		device_type = "pci";
-		linux,pci-domain = <0>;
-		bus-range = <0x00 0xff>;
-		num-lanes = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
-			  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
-		interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-				<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-				<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
-		clocks = <&gcc PCIE_A_CLK>,
-			 <&gcc PCIE_H_CLK>,
-			 <&gcc PCIE_PHY_CLK>;
-		clock-names = "core", "iface", "phy";
-		resets = <&gcc PCIE_ACLK_RESET>,
-			 <&gcc PCIE_HCLK_RESET>,
-			 <&gcc PCIE_POR_RESET>,
-			 <&gcc PCIE_PCI_RESET>,
-			 <&gcc PCIE_PHY_RESET>;
-		reset-names = "axi", "ahb", "por", "pci", "phy";
-		pinctrl-0 = <&pcie_pins_default>;
-		pinctrl-names = "default";
-	};
-
-* Example for apq8084
-	pcie0@fc520000 {
-		compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
-		reg = <0xfc520000 0x2000>,
-		      <0xff000000 0x1000>,
-		      <0xff001000 0x1000>,
-		      <0xff002000 0x2000>;
-		reg-names = "parf", "dbi", "elbi", "config";
-		device_type = "pci";
-		linux,pci-domain = <0>;
-		bus-range = <0x00 0xff>;
-		num-lanes = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		ranges = <0x81000000 0 0          0xff200000 0 0x00100000   /* I/O */
-			  0x82000000 0 0x00300000 0xff300000 0 0x00d00000>; /* memory */
-		interrupts = <GIC_SPI 243 IRQ_TYPE_NONE>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-				<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-				<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-				<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
-		clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
-			 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
-			 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
-			 <&gcc GCC_PCIE_0_AUX_CLK>;
-		clock-names = "iface", "master_bus", "slave_bus", "aux";
-		resets = <&gcc GCC_PCIE_0_BCR>;
-		reset-names = "core";
-		power-domains = <&gcc PCIE0_GDSC>;
-		vdda-supply = <&pma8084_l3>;
-		phys = <&pciephy0>;
-		phy-names = "pciephy";
-		perst-gpio = <&tlmm 70 GPIO_ACTIVE_LOW>;
-		pinctrl-0 = <&pcie0_pins_default>;
-		pinctrl-names = "default";
-	};
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
new file mode 100644
index 000000000000..b119ce4711b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -0,0 +1,470 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/qcom,pcie.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm PCI express root complex
+
+maintainers:
+  - Sivaprakash Murugesan <sivaprak@codeaurora.org>
+
+description:
+  QCOM PCIe controller uses Designware IP with Qualcomm specific hardware
+  wrappers.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-apq8064
+      - qcom,pcie-apq8084
+      - qcom,pcie-ipq4019
+      - qcom,pcie-ipq8064
+      - qcom,pcie-ipq8074
+      - qcom,pcie-msm8996
+      - qcom,pcie-qcs404
+      - qcom,pcie-sdm845
+
+  reg:
+    description: Register ranges as listed in the reg-names property
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: elbi
+      - const: parf
+      - const: config
+
+  "#size-cells":
+    const: 2
+
+  device_type:
+    items:
+      - const: pci
+
+  "#address-cells":
+    const: 3
+
+  ranges:
+    maxItems: 2
+
+  interrupts:
+    items:
+      - description: MSI interrupts
+
+  interrupt-names:
+    const: msi
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-map-mask:
+    items:
+      - description: standard PCI properties to define mapping of PCIe
+                     interface to interrupt numbers.
+
+  interrupt-map:
+    maxItems: 4
+
+  clocks:
+    minItems: 1
+    maxItems: 7
+
+  clock-names:
+    minItems: 1
+    maxItems: 7
+
+  resets:
+    minItems: 1
+    maxItems: 12
+
+  reset-names:
+    minItems: 1
+    maxItems: 12
+
+  power-domains:
+    items:
+      - description: phandle to the power domain responsible for collapsing
+                     and restoring power to peripherals
+
+  vdda-supply:
+    items:
+      - description: phandle to power supply
+
+  vdda_phy-supply:
+    items:
+      - description: phandle to the power supply to PHY
+
+  vdda_refclk-supply:
+    items:
+      - description: phandle to power supply for ref clock generator
+
+  vddpe-3v3-supply:
+    items:
+      - description: PCIe endpoint power supply
+
+  phys:
+    items:
+      - description: phandle to the PHY block
+
+  phy-names:
+    const: pciephy
+
+  perst-gpios:
+    description: Endpoint reset signal line
+
+  bus-range:
+    description: Range of bus numbers associated with this controller
+
+  num-lanes:
+    const: 1
+
+  linux,pci-domain:
+    description: pci host bridge domain number
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - device_type
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - interrupts
+  - interrupt-names
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+
+additionalProperties: false
+
+allOf:
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - qcom,pcie-apq8064
+   then:
+     properties:
+       clocks:
+         items:
+           - description: clock for pcie hw block
+           - description: clock for pcie phy block
+       clock-names:
+         items:
+           - const: core
+           - const: phy
+       resets:
+         items:
+           - description: AXI reset
+           - description: AHB reset
+           - description: POR reset
+           - description: PCI reset
+           - description: PHY reset
+       reset-names:
+         items:
+           - const: axi
+           - const: ahb
+           - const: por
+           - const: pci
+           - const: phy
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - qcom,pcie-apq8084
+   then:
+     properties:
+       clocks:
+         items:
+           - description: AUX clock
+           - description: Master AXI clock
+           - description: Slave AXI clock
+       clock-names:
+         items:
+           - const: aux
+           - const: bus_master
+           - const: bus_slave
+       resets:
+         items:
+           - description: core reset
+       reset-names:
+         items:
+           - const: core
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - qcom,pcie-ipq4019
+   then:
+     properties:
+       clocks:
+         items:
+           - description: AUX clock
+           - description: Master AXI clock
+           - description: Slave AXI clock
+       clock-names:
+         items:
+           - const: aux
+           - const: master_bus
+           - const: master_slave
+       resets:
+         items:
+           - description: AXI master reset
+           - description: AXI slave reset
+           - description: PCIE pipe reset
+           - description: AXI vmid reset
+           - description: AXI XPU reset
+           - description: parf reset
+           - description: PHY reset
+           - description: AXI master sticky reset
+           - description: PCIE pipe sticky reset
+           - description: pwr reset
+           - description: AHB reset
+           - description: PHY AHB reset
+       reset-names:
+         items:
+           - const: axi_m
+           - const: axi_s
+           - const: pipe
+           - const: axi_m_vmid
+           - const: axi_s_xpu
+           - const: parf
+           - const: phy
+           - const: axi_m_sticky
+           - const: pipe_sticky
+           - const: pwr
+           - const: ahb
+           - const: phy_ahb
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - qcom,pcie-ipq8064
+   then:
+     properties:
+       clocks:
+         items:
+           - description: core clock
+           - description: interface clock
+           - description: phy clock
+           - description: Auxilary clock
+           - description: reference clock
+       clock-names:
+         items:
+           - const: core
+           - const: iface
+           - const: phy
+           - const: aux
+           - const: ref
+       resets:
+         items:
+           - description: AXI reset
+           - description: AHB reset
+           - description: POR reset
+           - description: PCI reset
+           - description: PHY reset
+           - description: External reset
+       reset-names:
+         items:
+           - const: axi
+           - const: ahb
+           - const: por
+           - const: pci
+           - const: phy
+           - const: ext
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - qcom,pcie-ipq8074
+   then:
+     properties:
+       clocks:
+         items:
+           - description: sys noc interface clock
+           - description: AXI master clock
+           - description: AXI slave clock
+           - description: AHB clock
+           - description: Auxilary clock
+       clock-names:
+         items:
+           - const: iface
+           - const: axi_m
+           - const: axi_s
+           - const: ahb
+           - const: aux
+       resets:
+         items:
+           - description: PIPE reset
+           - description: PCIe sleep reset
+           - description: PCIe sticky reset
+           - description: AXI master reset
+           - description: AXI slave reset
+           - description: AHB reset
+           - description: AXI master sticky reset
+       reset-names:
+         items:
+           - const: pipe
+           - const: sleep
+           - const: sticky
+           - const: axi_m
+           - const: axi_s
+           - const: ahb
+           - const: axi_m_sticky
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - qcom,pcie-msm8996
+   then:
+     properties:
+       clocks:
+         items:
+           - description: PCIe pipe clock
+           - description: Auxilary clock
+           - description: AHB config clock
+           - description: AXI master clock
+           - description: AXI slave clock
+       clock-names:
+         items:
+           - const: pipe
+           - const: aux
+           - const: cfg
+           - const: bus_master
+           - const: bus_slave
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - qcom,pcie-qcs404
+   then:
+     properties:
+       clocks:
+         items:
+           - description: interface clock
+           - description: Auxilary clock
+           - description: AXI master clock
+           - description: AXI slave clock
+       clock-names:
+         items:
+           - const: iface
+           - const: aux
+           - const: master_bus
+           - const: slave_bus
+       resets:
+         items:
+           - description: AXI master reset
+           - description: AXI slave reset
+           - description: AXI master sticky reset
+           - description: PCIe pipe sticky reset
+           - description: power reset
+           - description: AHB reset
+       reset-names:
+         items:
+           - const: axi_m
+           - const: axi_s
+           - const: axi_m_sticky
+           - const: pipe_sticky
+           - const: pwr
+           - const: ahb
+ - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - qcom,pcie-sdm845
+   then:
+     properties:
+       clocks:
+         items:
+           - description: PCIE pipe clock
+           - description: Auxilary clock
+           - description: AHB config clock
+           - description: AXI Master clock
+           - description: AXI Slave clock
+           - description: AXI Slave Q2A clock
+           - description: NOC TBU clock
+       clock-names:
+         items:
+           - const: pipe
+           - const: aux
+           - const: cfg
+           - const: bus_master
+           - const: bus_slave
+           - const: slave_q2a
+           - const: tbu
+       resets:
+         items:
+           - description: PCI reset
+       reset-names:
+         items:
+           - const: pci
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pcie: pci@10000000 {
+        compatible = "qcom,pcie-qcs404";
+        reg =  <0x10000000 0xf1d>,
+               <0x10000f20 0xa8>,
+               <0x07780000 0x2000>,
+               <0x10001000 0x2000>;
+        reg-names = "dbi", "elbi", "parf", "config";
+        device_type = "pci";
+        linux,pci-domain = <0>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ranges = <0x01000000 0 0          0x10003000 0 0x00010000>, /* I/O */
+                 <0x02000000 0 0x10013000 0x10013000 0 0x007ed000>; /* memory */
+
+        interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+        clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_0_AUX_CLK>,
+                 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+        clock-names = "iface", "aux", "master_bus", "slave_bus";
+
+        resets = <&gcc 18>,
+                 <&gcc 17>,
+                 <&gcc 15>,
+                 <&gcc 19>,
+                 <&gcc GCC_PCIE_0_BCR>,
+                 <&gcc 16>;
+        reset-names = "axi_m",
+                      "axi_s",
+                      "axi_m_sticky",
+                      "pipe_sticky",
+                      "pwr",
+                      "ahb";
+
+        phys = <&pcie_phy>;
+        phy-names = "pciephy";
+
+    };
-- 
2.7.4

