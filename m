Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3AC62531E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 06:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiKKFh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 00:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKKFh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 00:37:26 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC01864A2B;
        Thu, 10 Nov 2022 21:37:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPL9G6eY8bx1ZIL/f2TP2Kn1CzDw1jQ/7uhRqYbhjFx3CmizR/Keq+wH8hUfW3RtOyE0MgesypQ/XVg9Oima8aXoLToz6jRFvqqfVprNInxg444xeq0mLNT3SkLjpVU5GGEZdTHLrdUvKM+voOwJsmrmLufV3VnDIoeGKLK/l1sCKo1qYMYLA+moSyvGSvaHlfq7gG2gKq0sGCE/csrmHY7/3KSmxnVSR/aVE0Ni0XhRsqiFdu9KVF8vRWQIuwXOe+QNtr5/wqzKE3RtybHScDiunVK/kB95mq+54Kqyv4QLr6jRzt0zX3t7lBI3tVoVyFLJpipAAtL4uWlRzeQL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taz/J4gZ722glgLXRIimXriPXeEAZv1K5B1ajraYkf4=;
 b=h2R8oK8/wP56gDZVnlRxKR3PcmthVqL54KDQJ4is6IHJGLljz3Di4A4kKDm7AjH7IZKk4/8Bff97GlikqdneRcVWWgWhweiX1Dz6ROceu2t7HC2UEPJl6D8mjNs0a9n5miFcKa7RdMkp2kO3tVpS2JGWRRtNG53qdaaB4bxGgVciOuP9Seaq52t4hJ+Ryg7l1U5ht58PxLXgJnrLgwGvOO5VhDW5mKB5Sur/SULM4ozkWl9VWwdG+eTopNj8zNa9xVurp/oFlezKVGLB0lb+dOh3BoVc/4e/TkePArnZs8iTiGzDyez20DtMo+Oqb8Wf7YE8Dv5elVtfr+pRleLnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taz/J4gZ722glgLXRIimXriPXeEAZv1K5B1ajraYkf4=;
 b=msp68y0o6Z+bSvXzs2OSlG04xeUJWBHVqqMsu0fs0XGXRHMpgRt00P+bjZvoL8p8+/xFYi6Nng4oJ0G4TRstkT0tuMGuug0YJ/bv35RM6FxawQKOXZPdILbzRr/DsgPrWo0rY3jqhmGFaePHDwZ+OCzkH4Y2OvY7ZrGuYE1mt/c=
Received: from DM5PR07CA0092.namprd07.prod.outlook.com (2603:10b6:4:ae::21) by
 PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 05:37:22 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::7) by DM5PR07CA0092.outlook.office365.com
 (2603:10b6:4:ae::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Fri, 11 Nov 2022 05:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 05:37:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 23:37:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 21:37:20 -0800
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Thu, 10 Nov 2022 23:37:18 -0600
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v6 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas of Xilinx NWL PCIe Root Port Bridge
Date:   Fri, 11 Nov 2022 11:07:09 +0530
Message-ID: <20221111053709.1474323-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111053709.1474323-1-thippeswamy.havalige@amd.com>
References: <20221111053709.1474323-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 044035c6-9f35-4a6b-302d-08dac3a6ce53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyuJHZtf5eub8/f+WXaXpgHTXPoFn2ft+V8xQOL1Z226WLw4Cilk+24+wAbd21w9R0Y8zMC2l01pNcVO/10qAYgMfhuI+ANl1KyujtC1qq173xpOSYlejyNz3TuaAU/4mb+E7ms+/N8SDzNO2kCRGyQALCkrdo4qsTkwAqTt2Kr+6y113XbsucL0sikahOY2A0h8IHJAiZwlEHPiMSdMUsNNJ+ubSPoTy9kEMYtvkXrTum7OJatEM35H5NWuDcVUwWk4X3jko1r6+nl3GA7IxO47jMyslKUs301cdkpOj9xW2EVMlVApbTse/ggTbdTFbWxMAeg8yWkxXSllz3uFsJ1gn/bDLzD3wXiSABuRanc+h2XFbuLguaMVGn2U73Wg88u8V1vh3kgsr+FlNV9zA5bGf8GzWulNux81XjZnRoytFWNRuiNRk2mX+CzWyC1AS6SepUFUHJsd1FUAaYzhzK7bhc/hOSz98sEpFroWiyHtPgz2rKlO7Q9euqUlKpg8hbMXCh0w3YsZOB3qPWY8kKDPUO4umBzDBrCkUrgWVinJ+92AxZvKyCk1XB0Up3F15wHhAOEylnWm4WAZgOLokj2cdALfm6KsICWiQ8+6o9D4PHwgqOURndwGPLXRgR21SyKa4P/fgl4hZKhYXOfps3QVvz7ikeLpOSW+ondFyW8EcMZilHOtiXdNvjM8QEFnAr6D6i5rNZvxyWoRTpx3ERkH6AtQJp5Cc1YZKySiFch5KMpwlHGNJNJ9RkTkweJhiTJWfD+x00f9/dUs51DfoPygGHK0CoWyb5rw28OAZmYjkzQ/j5MoFF6fmlEI9EhMVCmC6jKG4ta22c9xDsXZupnXgrXlkBZFh9SRYHUTs0hht+Q3XbFRcWTQdZ57veIJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(36756003)(36860700001)(5660300002)(8936002)(44832011)(2906002)(47076005)(2616005)(1076003)(336012)(426003)(186003)(83380400001)(82740400003)(356005)(81166007)(54906003)(4326008)(110136005)(316002)(82310400005)(478600001)(40480700001)(40460700003)(8676002)(41300700001)(70586007)(70206006)(966005)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 05:37:21.9111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044035c6-9f35-4a6b-302d-08dac3a6ce53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
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
changes in v6:
Added maxItems to clocks property.

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
index 000000000000..897602559b37
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
+    description: optional, only needed if DMA operations are coherent.
+
+  clocks:
+    maxItems: 1
+    description: optional, input clock specifier.
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

