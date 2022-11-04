Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85242618F86
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 05:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKDEmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 00:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKDEl7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 00:41:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4336C27B3F;
        Thu,  3 Nov 2022 21:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqlpDlNwxCAFIfPttwdDECu35/sXhWQas7SQfgqS/KOqNg5ndFsd4717Ujwe00cDNQDitSwagw+Gk7sb/AUuptU8xXRMDgxrcu9GMAvjuV3yR5I64co9wBB1H5ngPTPQV0KISiHh5gt90R56ZTnHfVyf29khmpcM0Wt3fwHgBHUWx5/mffF/F17Z+tJuk3Bgup/YQAVQkbeBtQXS1nKUkzHtU2J/kFpp8PX5QGG+VgHQdLW9lqQL9Te507nqDl+j+5lbi+bCGRT7ayb4J1b6Bgwo0HzEOuwqo/99DPdLsnQIb0NNLRFMfOHutPTJo8OLWPP+lyZmVklxsnWjMDZs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPf5slXD/0A/lzoCCQmUrBL/5eUL8LwhIv0isd3h2XY=;
 b=Gb9XvMoxo69WdqcQUSrME0jWCFEAyKmiUhUAlMNVIC5hz4t8QNS5o0wTe0I8hjwTdFRtiqwBpgJt5aIJjXFDRZYtqGdPYfiyUO97tM9fZi37Z8ezNX0RDqSRTBrv6armtkTMPv4aKIUa55MBOkgjjvsFRf3raaLxOb3tcDQt+5SrOkekkURJXH93Qlcz06yJTPYiQlRTZOPbp2BEEc4bed87x1N10v5cc4Hnwi6UuPNIVdlJKhYJ80RWEiu/2fFR6zPAodlVRQ5j8rOhPnKyPX+M3Awqfn8sMnc61HZmrAV0XWEHVnciU0+wHc9aKldZUwmdXUhah/dutEPESJaSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPf5slXD/0A/lzoCCQmUrBL/5eUL8LwhIv0isd3h2XY=;
 b=RWuOI33P2wQXByK19xsWpoO9q7Vu4UTJoeLq21ZPI6d87udTcznAqIXqGS1OaVzbhOaOSZXxfCz6WoAI3DxD6MEwqhsU6YZ6l84q8k2VZGGQ43ZJVG0k0N+k/pxgijzAnYhgH3ul6J7Shpdxrsk8sL246rsmZoxwnQaW0/5XQCo=
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 04:41:51 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::cc) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 04:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 04:41:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 23:41:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 21:41:48 -0700
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Thu, 3 Nov 2022 23:41:45 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v3 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas of Xilinx NWL PCIe Root Port Bridge
Date:   Fri, 4 Nov 2022 10:11:35 +0530
Message-ID: <20221104044135.469797-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221104044135.469797-1-thippeswamy.havalige@amd.com>
References: <20221104044135.469797-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a5cf3b-fa8d-4553-6b32-08dabe1ee406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMPBqAF6rP/Xa0xh5vym4xyAVqsf+Y298kB7GQOEg/mDKQ7esQ9Kgxnj3+V16499pBaV5eyj0cWvaqxxCXIJADp75KeqGcOgzNb5S9HeXu/477O9IsBlZpm6QPpXJsWjhi9vFJfafqg0Ha5sNCOnYL/T+sVnlmomtyZUFqVxK2QxZiphfoixD1nVbZ9W0D1BNxHWL54z3YIZT43B+ibL9XvM/p8TeM8b8IqFNH5QzAKZGfdaSxocCJqVJQGpF8ZTtavvJYjGwxQZPqhPKtl7R0FznSgaupaFDscrRPB4e8JvMsMVqJwzEGNEwfp1Zzk3sQQVd6ElRmmXccMulHDyrjzmOMUzcobzHgOrTemq4tqLF9vkWncu1HbdizTePNEWOWO9Brovw+0MjUsAII/M+lU24FkzaJ7KIqIZxVCRrIN5IDRJKbAWyRzWadDmZIHRRLDhaN6YdE9Etckw33fmfEituSLJkOUrrbhCuFVX6vHpvvgEgQTtQ4/PnRKFA1rjmVd15qeG6eo3bOie8QMBLtPDsyVNzmjM2dCzOurz6SUiOMOEmUbs7BY0XWXyVNyI2bgLP5TTJmleWwxRIpnic1gZgCpao0xdIEEi3VBvJso7qwShy0vw82wedyIJeOXjUCxog3vX9+pnly3FUhGRceMpqX5EwRPzJ/vy0TbkZTET++yBnuNZkwTuA4Lj2SIL4APn1fBuVgc0yEGS6+YV7JcpzflNHRQga734ycw3WM8bTNqDtQpQANwvBVSxa+fplPBnwdG3rT+p0xxWZyjGDDh4MWqgeeUnNsNccFGSUvrdBizxHZu3bLhoRBRE/G5n9wSvkPhI4oMWKRaljuWR8kVMcfqd/58XAg9bpDNhlPEp8P8fUfFb52pozQnH8LaB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(478600001)(966005)(86362001)(82310400005)(40480700001)(356005)(81166007)(54906003)(110136005)(6666004)(316002)(83380400001)(36756003)(70206006)(70586007)(1076003)(186003)(8676002)(4326008)(426003)(47076005)(2906002)(336012)(41300700001)(40460700003)(2616005)(36860700001)(5660300002)(82740400003)(44832011)(8936002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 04:41:50.9799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a5cf3b-fa8d-4553-6b32-08dabe1ee406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
 .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ---------
 .../bindings/pci/xlnx,nwl-pcie.yaml           | 152 ++++++++++++++++++
 2 files changed, 152 insertions(+), 73 deletions(-)
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
index 000000000000..e3484cc704e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -0,0 +1,152 @@
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
+  msi-controller:
+    description: Identifies the node as an MSI controller.
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

