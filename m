Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC625614423
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 06:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKAFVZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 01:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAFVY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 01:21:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5DB140ED;
        Mon, 31 Oct 2022 22:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZx6NxjDzdq+zdLBlx5U5fUfr4Cr0rGLTIYjgkRAZzx5OIhOmeqAQnJFl3HTX5HQ5z9fDGpNYNBSeEi2yjGIG+GFJrC6dyDXYENdCf0295Z1OcKibcHY9tdlJzHGOmBIQA5UUFEvSawcvnQUUTz006q+77wx56fvzY3N5S7D1dJQFvhZu0Jm7t97iNtIinfwrZesUKB/ESgq5XWCxLhKQ5JxjiX96qYP/pM6xXuC+vlYs3hycxA36oIQ4+srBVOH6gvOJOShC2HwS7zSurt90HyMwrq3TOZriSJnd664drJ6T/YthX/2VkYVPO3kpnrWkENkMZGQjSp2HaMCm5Kulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRohqT8S4OgE6bAdWwvozuEa36hsVzc6eVLNb/fyAgU=;
 b=esnitoEySGRtYAH3PadDtiWrHqsUYI8mVyiQPOeX03W79h5x0EtrQa8jXgLwBJZPRpiqQXRyJGz8j6gPBwSL01fVURxM1yUd8/T7PSmlVp6RmtXI5Ol4B1cxq9QgDzxhkKBMEWr5tXltiJHRhEBo8K+xOAOwLOP+Yll9inhZ4L3IFzIftsdSqJQo/8FwPvkXVilZORw7GGnU/D+TZKFBgOjCmdllYDm/hT2k7v/PryjP7kpS7VmGBwi8BayhtYWcFGQsY6FscFkuBaT64DzK5zeti379Aneap19A2KJIGGb83ybz+y4pzpIevaNHrpOQbxjj98/WKBetniJeUP2uew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRohqT8S4OgE6bAdWwvozuEa36hsVzc6eVLNb/fyAgU=;
 b=VIKew2cfNNNhmQ7sF7Vp/yGwsI9ZiNQlszP1Pp2aMRExtoQw/PW+zknpJ3kuR6sZ5nR5WzgzEZHtvzkUd3vXCgat/GeNSSgq0exbiyQu30X58xy1BRTolas+qNC5aXfNjX+vnrDkzc5jFjFL1Uk0e1ZZK/1KFMm1nKgSKs+tJKY=
Received: from MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 05:21:20 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::9a) by MW4PR04CA0300.outlook.office365.com
 (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Tue, 1 Nov 2022 05:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 05:21:19 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 00:21:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 22:21:10 -0700
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 1 Nov 2022 00:21:07 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas of Xilinx NWL PCIe Root Port Bridge
Date:   Tue, 1 Nov 2022 10:50:49 +0530
Message-ID: <20221101052049.3946283-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
References: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: fc10d7da-5196-4bfd-3024-08dabbc8e895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEobmIdl53l6d+cON87lFAYgqKBd4BaIUy36AWmTDmlYbUdHxcS5bRV+mvcF/ZU67Ikatudn8Z8fgDJwRwVgUZ9uDiu/3L2ui2z9BPj/stp3uNQrkvM5zXttjFRZxI+ZHdBlpOQkAYGGcJi78nJi0Cksaz5xc1ydmDkSJqJ7rzgctwDUS90UBNowKd5Le/S4ewAppuJWBzPkOUlIaKKGAVAe5w51FiJ0yulGSAcJ4VEeVeOB9yIFFI4NoMPBYmU9fbDshIVx9sfx1thjbxKegFm0tqgKkUY1WrhDvrqOf6EgedUJE5i37NGCu4EoW/bSNSe8gQlhcWDfQAvzAvELowJ0MQiB8jC77mrGp6Ib9bJEh0UKM3vGp6bF/1jj2/L5HKpWFqUwdK2J4bRME1TLL8FWokUviroMyqIP1V8cdH3DmHtXmob5Jq3r87M7La0mqyJTkH4SnUvmS+CnZLzUBkpOIq5twJHXJzQNqlYN3bPu2vuTjlhglIgypFDRGkUKZ6uOhO1EL9+2i1vGsEPU2enUIeVgE6ArZCYB13YLW0YCxqjg4SDsYAyen2eDcGlo9riytb11gi8/Dhxs5UAVXJ+Yavw5FYjx7+l6WwlZbgdoXJneSmN5XgFzeu4P2dW5HwOxSxxUUUJPt8Aj/2qfL0lznN1oWoMAlmrPGjIeOaN0mZk6/2kAI26Oiro/bINbXsBqzNG1cokA8Fi19fo0jeOBK1Fp1p2ZLMJHya6jt8tRtXHGXveDob3Hgvtj9MUCIuMweReAxxn2I4WG3lSdLeZVJTB14C2YwD75WjcLD8YsC7lcfWyK7WdD8/jWxBQq4cRk4PcoBweDjNANL16nA9oRWn/hWbzji1sgUxrXkV56opT1hExlLpxhlFQTnSyI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(336012)(82310400005)(1076003)(186003)(5660300002)(40460700003)(83380400001)(426003)(47076005)(44832011)(2906002)(36756003)(86362001)(356005)(81166007)(36860700001)(82740400003)(26005)(316002)(6666004)(2616005)(8936002)(70206006)(41300700001)(40480700001)(70586007)(54906003)(478600001)(8676002)(110136005)(4326008)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 05:21:19.4572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc10d7da-5196-4bfd-3024-08dabbc8e895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
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
 .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ----------
 .../bindings/pci/xlnx,nwl-pcie.yaml           | 137 ++++++++++++++++++
 2 files changed, 137 insertions(+), 73 deletions(-)
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
index 000000000000..f6634be618a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -0,0 +1,137 @@
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
+      - description: msi0 interrupt asserted when an MSI is received
+      - description: msi1 interrupt asserted when an MSI is received
+      - description: interrupt asserted when a legacy interrupt is received
+      - description: unused interrupt(dummy)
+      - description: interrupt asserted when miscellaneous interrupt is received
+
+  interrupt-names:
+    maxItems: 5
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
+  msi-controller:
+    description: Identifies the node as an MSI controller.
+
+  msi-parent:
+    description: MSI controller the device is capable of using.
+
+  interrupt-map:
+    maxItems: 4
+
+  dma-coherent:
+    description: Optional,present if DMA operations are coherent
+
+  clocks:
+    description: Optional,Input clock specifier. Refer to common clock bindings
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
+      - '#address-cells'
+      - '#interrupt-cells'
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
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
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
+            interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "intx", "dummy", "misc";
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
+                            <0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
+                            <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
+                            <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
+            msi-parent = <&nwl_pcie>;
+            pcie_intc: legacy-interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
-- 
2.25.1

