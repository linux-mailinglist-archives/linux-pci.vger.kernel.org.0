Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376936207C8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 04:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiKHDvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 22:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiKHDvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 22:51:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191122D779;
        Mon,  7 Nov 2022 19:51:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMZsGXGgC2gOnwdqutyawDGiOIEo181+JOC8xADgU/877lPa9uuBWA4jqfGXiVi0BRc5jMMi0I+LAuFY+X/Rk8AV82edQuUJ5m9os6qKOXMG9VhPrO2H7X9U2CfFQlhoO03m5UD7AHKBg1TYyWcp6kB5mVSQIAKI/+TjkxQwc6fgz/zAgMMBAHbB5aOc5CZfuntA2RgBvlkYrbNbe0HI9XlwLx0X+s6aLSuxGK0oIAX0CCabworraEeHotA/y3iGA3fjLbxwJ1yBbuUq9bJCTNGWRyI69WAmmaufJSvg3ri8nsENRB8IgNBAEMrO2P4ZmO0ByUBAuDwNIlZym3LUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjtaZ8SicXvP4R0Uekhw1C/mxNB6d/2bUzB+DvNKUKc=;
 b=CM7lD6wbrOjB+EmTJ1xp9aTIc5erV+qwtLatLm3/chAiajw9FTBNVXMtAJVOTALX1z7YmYQMjNB5CmDQ2pFY+9ndhOXWDeHySdkuGOURLM4wDoFQVBCumA7mLSjXVQ6R6TrF720LNTS4pVvUWWhGlpYUPaxmN7O0TP9En/30/M32S9sT6N1DqzNOJQQ8HQxTNOKhRrK8K3OU0BNygXuDZW7LXhciEUXIjXIOhTrSMoT1O6DgKSipmFISycs6+jDwbd7G+KnwhtJiT5FMrFobp6UiZUA6BMTpO0yGn3ni1b5TqzJBsg8vhVEKnBPq86amgJ5hEsCsDtnd1ki7ghRGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjtaZ8SicXvP4R0Uekhw1C/mxNB6d/2bUzB+DvNKUKc=;
 b=VmU6921MyiiWyXN9rPNP1ZwolHL6YjX0xRXkWFpmEn9XL9fpf1ILXxphLavN3mS5p+SySKryIXYsMcIAputETbrbTLkmglDdddnTNcii6vWkVZD3vELtK+YG3bS31zE/g4GFgRmcXCV4TyaSV7Ql+qhhkqTLj0ITM87ugnU3fO4=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 03:51:02 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::77) by DS7PR05CA0081.outlook.office365.com
 (2603:10b6:8:57::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Tue, 8 Nov 2022 03:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 03:51:02 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 21:50:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 19:50:38 -0800
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 7 Nov 2022 21:50:36 -0600
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas of Xilinx NWL PCIe Root Port Bridge
Date:   Tue, 8 Nov 2022 09:20:30 +0530
Message-ID: <20221108035030.1040202-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108035030.1040202-1-thippeswamy.havalige@amd.com>
References: <20221108035030.1040202-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: b966b9e1-67ba-4970-3696-08dac13c74b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwdPDLWudjZqbAxckV7DaoKf1NuDQVStykovMNQ8KOoL2OkgBjR4cKPN+jmL/PVIuiGpXVtpUY+wswe0qwbAVDru/dXRtaNuZp2oQYtu3+27wc6xiLlE7W21SxpqW7xByJFsHTL0wkBIkrDRXioZTtCiR9rTLwD1Wug/+RW0O83A+eCKDIFc7jCovdNYfI41RlVlAkdmcPwf2jQaFAvhhUGQzPFef251ZvwZYQ1hCrdwDqcAQW6Gd60l188nIPRKZybycAX1KMATJmVKY+app8QB8HYJGw1uyrmlT3G6HL2voCKnnJILitGgXT8lnzuQZTBaUPXgiTlYi2QK+HZUpqgKYJl/C3qmxwFLpLB5+cn4mQ0TLif+DbunEfFusO++i3rtmd1ECH6rcKUMGaJw6QtZhzcrAD+t+0Km77KCdoL1kASB6LODD/ybttG6QzA0Y9HyAZTqEhuC5kJYRS1otmXTmsNdrjrwlIHwmPFBn4AYqSXug51cY8orFV9SxZPMknfqqMO0Xuu5cfFRbjg0D9KWoic/j3MbwlHNUcTSGSrTKG367cBt4QzesLZe8QMx6amP8Q376txma3os5HV/0eK8WnQr1v7o0x/KUoMhsnWvIbcz2CfaHM4Y++TK6JOYZoIqzKwRP5FJeQUlof0enNaBlV75+U5d1Zf4VaP+2Oj6aaZQSAFl6kyg3PP7G6Q1gBobHGs1pH7VZWWrt/0AWMUgWIgxSvXGUa4Ym+eGQKd0HccwjxkgGEt8dk6QqwAV3ZWDDZH4l/q4iTx/TO4/j5l7GVyFTlGVkgwd2TmiSc5LTNNnQIyvs30Bd8dSqMpJq/3gt38cfielwFnpzdxBExYka96NEGcWjuC5vYVaDkDjq6D9oM+sl/IS5y/nCa++
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(41300700001)(336012)(186003)(26005)(83380400001)(1076003)(40460700003)(426003)(70586007)(70206006)(8676002)(36756003)(8936002)(4326008)(44832011)(54906003)(82310400005)(110136005)(316002)(36860700001)(2616005)(6666004)(86362001)(966005)(356005)(478600001)(40480700001)(81166007)(82740400003)(2906002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:51:02.5746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b966b9e1-67ba-4970-3696-08dac13c74b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
dt binding.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Dropped minItems for interrupt-names property.
---
 .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ---------
 .../bindings/pci/xlnx,nwl-pcie.yaml           | 148 ++++++++++++++++++
 2 files changed, 148 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
deleted file mode 100644
index f56f8c58c5d9..000000000000
--- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-* Xilinx NWL PCIe Root Port Bridge DT description
-
-Required properties:
-- compatible: Should contain "xlnx,nwl-pcie-2.11"
-- #address-cells: Address representation for root ports, set to <3>
-- #size-cells: Size representation for root ports, set to <2>
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- reg: Should contain Bridge, PCIe Controller registers location,
-	configuration space, and length
-- reg-names: Must include the following entries:
-	"breg": bridge registers
-	"pcireg": PCIe controller registers
-	"cfg": configuration space region
-- device_type: must be "pci"
-- interrupts: Should contain NWL PCIe interrupt
-- interrupt-names: Must include the following entries:
-	"msi1, msi0": interrupt asserted when an MSI is received
-	"intx": interrupt asserted when a legacy interrupt is received
-	"misc": interrupt asserted when miscellaneous interrupt is received
-- interrupt-map-mask and interrupt-map: standard PCI properties to define the
-	mapping of the PCI interface to interrupt numbers.
-- ranges: ranges for the PCI memory regions (I/O space region is not
-	supported by hardware)
-	Please refer to the standard PCI bus binding document for a more
-	detailed explanation
-- msi-controller: indicates that this is MSI controller node
-- msi-parent:  MSI parent of the root complex itself
-- legacy-interrupt-controller: Interrupt controller device node for Legacy
-	interrupts
-	- interrupt-controller: identifies the node as an interrupt controller
-	- #interrupt-cells: should be set to 1
-	- #address-cells: specifies the number of cells needed to encode an
-		address. The value must be 0.
-
-Optional properties:
-- dma-coherent: present if DMA operations are coherent
-- clocks: Input clock specifier. Refer to common clock bindings
-
-Example:
-++++++++
-
-nwl_pcie: pcie@fd0e0000 {
-	#address-cells = <3>;
-	#size-cells = <2>;
-	compatible = "xlnx,nwl-pcie-2.11";
-	#interrupt-cells = <1>;
-	msi-controller;
-	device_type = "pci";
-	interrupt-parent = <&gic>;
-	interrupts = <0 114 4>, <0 115 4>, <0 116 4>, <0 117 4>, <0 118 4>;
-	interrupt-names = "msi0", "msi1", "intx", "dummy", "misc";
-	interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-	interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
-			<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
-			<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
-			<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
-
-	msi-parent = <&nwl_pcie>;
-	reg = <0x0 0xfd0e0000 0x0 0x1000>,
-	      <0x0 0xfd480000 0x0 0x1000>,
-	      <0x80 0x00000000 0x0 0x1000000>;
-	reg-names = "breg", "pcireg", "cfg";
-	ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000  /* non-prefetchable memory */
-		  0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
-
-	pcie_intc: legacy-interrupt-controller {
-		interrupt-controller;
-		#address-cells = <0>;
-		#interrupt-cells = <1>;
-	};
-
-};
diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
new file mode 100644
index 000000000000..af20e02500f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/xlnx,nwl-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx NWL PCIe Root Port Bridge
+
+maintainers:
+  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    const: xlnx,nwl-pcie-2.11
+
+  reg:
+    items:
+      - description: PCIe bridge registers location.
+      - description: PCIe Controller registers location.
+      - description: PCIe Configuration space region.
+
+  reg-names:
+    items:
+      - const: breg
+      - const: pcireg
+      - const: cfg
+
+  interrupts:
+    items:
+      - description: interrupt asserted when miscellaneous interrupt is received
+      - description: unused interrupt(dummy)
+      - description: interrupt asserted when a legacy interrupt is received
+      - description: msi1 interrupt asserted when an MSI is received
+      - description: msi0 interrupt asserted when an MSI is received
+
+  interrupt-names:
+    items:
+      - const: misc
+      - const: dummy
+      - const: intx
+      - const: msi1
+      - const: msi0
+
+  interrupt-map-mask:
+    items:
+      - const: 0
+      - const: 0
+      - const: 0
+      - const: 7
+
+  "#interrupt-cells":
+    const: 1
+
+  msi-parent:
+    description: MSI controller the device is capable of using.
+
+  interrupt-map:
+    maxItems: 4
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent:
+    description: Optional, present if DMA operations are coherent
+
+  clocks:
+    description: Optional, input clock specifier.
+
+  legacy-interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts.
+    type: object
+    properties:
+      "#address-cells":
+        const: 0
+
+      "#interrupt-cells":
+        const: 1
+
+      "interrupt-controller": true
+
+    required:
+      - "#address-cells"
+      - "#interrupt-cells"
+      - interrupt-controller
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+  - msi-controller
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        nwl_pcie: pcie@fd0e0000 {
+            compatible = "xlnx,nwl-pcie-2.11";
+            reg = <0x0 0xfd0e0000 0x0 0x1000>,
+                  <0x0 0xfd480000 0x0 0x1000>,
+                  <0x80 0x00000000 0x0 0x1000000>;
+            reg-names = "breg", "pcireg", "cfg";
+            ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
+                     <0x43000000 0x00000006 0x0 0x00000006 0x0 0x00000002 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            msi-controller;
+            device_type = "pci";
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 116 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "misc", "dummy", "intx", "msi1", "msi0";
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
+                            <0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
+                            <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
+                            <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
+            msi-parent = <&nwl_pcie>;
+            power-domains = <&zynqmp_firmware PD_PCIE>;
+            iommus = <&smmu 0x4d0>;
+            pcie_intc: legacy-interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
-- 
2.25.1

