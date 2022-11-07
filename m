Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0061EFB8
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiKGJ4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiKGJz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 04:55:59 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE925C2;
        Mon,  7 Nov 2022 01:55:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV2K73V+OagVuRPVWVhlnDUVk8v1Zs24LMWt4NrwcDdptD5o/EPHDOnzV15Shb5bkuUoimVyqBvbTaVd5BYWhsOntwwK9umrAMMuOZZbiCX0jYGZR/sGC0qN9F7bzomqCWEJjn6dPqWvz3CNwUVbyxNMBOhGvqNI2V7l0W61CmSq9SRPuz7b1bLGqD+KBVYlo5FMIEHIc8wZY21jZkuqPtG6ocbYBoO/wsRtz8jlbb+4oA4VWjCQTFUdir9T2SWavv0tRy59JbmOaEp0mSwPx/eG/bmAdTT93IIrZJ4ihXGPbkARAD7/SgyWeeShq+dHkCIqLU+3BCUfOXMA21EsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzA6/QRpm+MQjDQwJjy2BMQTp8YunuxP9G88Kxzgpgs=;
 b=dIxrpdfkJxEML3w/yKfoBI/xKgIwdPGeLpmWW0OcZ0XXPHmE9q/MN0qvc7Yg0POFlP7d/x9e1XMuynlR13F6eHrpsxk5X/BlFMt475u4ky30z1q3DaisAcNBLcwC/oRoJatRC9+qPuGHp/k086WZFwkAwNWsI6p2aUEuF7uI5UArhK67e49hN9y6iy/Q97jDKrGCiyaTGmR/qeFFaLpfGwA3L7td6b8yISRliye61zzGbF9CRHjFONJQiVSIsKio2ZUstPrtmRG7utiYPoGbA+RwEEyjg1YvwWdjTAmzs0wdcVP8AthWTTLKxzKgvklwr6iLfxLOub8w7u6w0nsAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzA6/QRpm+MQjDQwJjy2BMQTp8YunuxP9G88Kxzgpgs=;
 b=eFZ3hWDt/bZ2fLeFF39AgPBue1zb5BRvWH6Ybcq1EJnUOM9bjQlEmj0LtJiXTj8zWGN6wnJcoyXJKv+yxx9x6sDjCX8I1+yfvDd1AAbq1tHTpQjqZ4a4QZt+6T9eI2eKtzEUYjYlR348tc8CDdcESk1A3DJ+/XKyaCR8cEmhMW4=
Received: from DS7PR03CA0347.namprd03.prod.outlook.com (2603:10b6:8:55::6) by
 BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 09:55:54 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::ad) by DS7PR03CA0347.outlook.office365.com
 (2603:10b6:8:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Mon, 7 Nov 2022 09:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 09:55:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 03:55:51 -0600
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 7 Nov 2022 03:55:08 -0600
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v4 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas of Xilinx NWL PCIe Root Port Bridge
Date:   Mon, 7 Nov 2022 15:24:08 +0530
Message-ID: <20221107095408.924778-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107095408.924778-1-thippeswamy.havalige@amd.com>
References: <20221107095408.924778-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|BL1PR12MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c0bfda-1604-48ce-5402-08dac0a642c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9lQXx6mVhY3UqII9PJe5HRN+wrDT26YlYs1eRmgGfbxVwVCnSlR0jNm8WG+x5BmbLlmo4sF7+i3Xu2eD+fX6MLiyUhTwGCPP9fTk2UcOMU8CPiBiVilqTcvAqk+nlNELXV/chwmhhv8tJTKmaNn/pbKqJnTSH7Cm5JdXdNpDM6JnJeqbuoN0vQ3gJpuw9Jinp5gTR7OylCpfacxcZ3gIQ0+fwsJ6JTggs8EGHZStCUcALaHOIewcafXB/mqWA4msodfWn0iqcBCHKeARloZz0TTfAhL1zDdoOTiHziVoWQsbKVABjuKNrXIfRvi/05Ecd1SMV3Ml0IjSmCTprhoN61rWMjJ1LZO4e4l2zjff7GmTmTD96Eej79dI1dStk416cNrsW3uJkCYg2NMM/aBzxrC3gAD/ApE8WSILN/ASQCHWQWqiRrcbN2IvGzq0GAdYK8wmTWgsX+JEVP8d9dM1EzFKS7ZHnvLpZJFbDMW9XBolqQLz4iEC+POuffaqSoqvS9AlO7H5iwfTNXYUEzpEv9RXyAi6RLYce8CH6ua+5iSEM6+2+HR8s7m7rgKGg+YUqYHXDggDazTI2h92FYgoWKj78CpVWG+dIawM6Z+v/3GZNM5okEdWvLvDdtPwA2g0SUd2wA9N/3Tgxf68Ew4hCI1EHoRPORvAtzgig6uw2WPb6Ms+ItocPGhxHFEk5WlqIubUUi6ZQWb+soElXQBES1PpxxgX++EI+TdOKX8FutNm20YHL5BnWWc/AVzV0Yb+xl5bM6tQ3WHQtByphN9mIdXEXBNzbrq0DLZnpPz21wcxpRw/AgsOUZnOAr8UXLYeRuQa7uG5f9UVfJCNNWpwyJ2LsstN+iuNcrItgXhPsEp58NXUqcV3bVaqWhy+d6k
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(36756003)(82740400003)(2906002)(41300700001)(5660300002)(8936002)(4326008)(70206006)(54906003)(70586007)(36860700001)(8676002)(966005)(44832011)(316002)(110136005)(40480700001)(356005)(81166007)(86362001)(40460700003)(83380400001)(2616005)(336012)(26005)(186003)(1076003)(478600001)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 09:55:54.3094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c0bfda-1604-48ce-5402-08dac0a642c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
Changes in v4:
Dropped, msi-controller property as it comes from msi schema.
Rearranged interrupts description as per example.
Used same style of quotes.
---
 .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ---------
 .../bindings/pci/xlnx,nwl-pcie.yaml           | 149 ++++++++++++++++++
 2 files changed, 149 insertions(+), 73 deletions(-)
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
index 000000000000..35c2d9fb3b9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -0,0 +1,149 @@
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
+    minItems: 4
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

