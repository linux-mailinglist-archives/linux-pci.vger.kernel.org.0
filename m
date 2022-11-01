Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1D614427
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 06:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiKAFVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 01:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAFVc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 01:21:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C6140ED;
        Mon, 31 Oct 2022 22:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT2CZDbAkoiq5WeXIIWevZ+F3wk+r9JJ6sGpE4FodyjofiJCsfdkR4LGgVm58kyvIrkGlvRx0TDe/9lPfgeLh3ZdCAcmVS3Scu9l4pAeNRn0U87XzhIC5HSXUL61xd2JAh278KtWiY63fW6eDYaQYkpauvW4D10BQxu+3S/EjGfYdO1IXrFvRiAce18JSx5vNSw52EeJ2rCsK7/NGD0kx4mwj0Y9TNYINtdn2kGV4kTHp5b2Guu08fDzMx5Opz8xUSSrcfBMdFKOahZKEIiXb+f3kTaxSsVUczAGGLaF64eO8FJqtswzDMUE8Hk2Q9eFsZrQ4WqvKgOKW27d3ZOjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmFE5m3c6/JIG4LoFb+XfEt9pQiJh8aS0MmE6VbICjI=;
 b=NaXVWldoefcnHqKRkmn4WESLOQ+XCAxZ6ek0K3WBZPpftTIhiTz26jgddj75Tagrl1EREeTTcIID+I6C8XWC7UeizYga2q6bltyFz67MhfYyiMLdDW3Cb60FHKuHkTZ3APhVbFStLzJsyEovuCQT6ONgTUXUN7TuKNkjAdNDfOXaqIPGMujpsSzh420qnr5ld8CLWFsN+lYl/8QOQjdfBwCGlld2jb1vnmBK+4vNTqkrjTHBuOQzzzMQbQyVYYr+qvNi3aWIOTx3xzI0rFQEgJI1Md78JgcAC+fZTvIitewWWioMJ0BcVYLY+r0U0cbBNU1R5ZnJrhue3LJHsaoBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmFE5m3c6/JIG4LoFb+XfEt9pQiJh8aS0MmE6VbICjI=;
 b=2isOeClH35k3c1nJzk7canFUYTtHKYZfl6uuIEAHW33+WAPdSFWlrEIgnYBRmsrRKCS1xxABIk0pzCtQJk75cb9yFfLQd+atzLXfy2ZNpoOc67ydMHq8DKuFnDRlfXWxNoJpgfaQwo7MuryV4pS2dqYsj+JPKe1jvBSwHZk57YM=
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 05:21:27 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::b5) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Tue, 1 Nov 2022 05:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 05:21:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 00:21:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 00:21:06 -0500
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 1 Nov 2022 00:21:04 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML schemas of Xilinx AXI PCIe Root Port Bridge
Date:   Tue, 1 Nov 2022 10:50:48 +0530
Message-ID: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a585cfa-d7b2-4af6-0e92-08dabbc8ed25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkAGsWcYVjiZIU6D7EZ107NMiuO1yMxunsL6dvgfXgpfOrGQafH9HzBrUgZjVPkbiJd6w1YBLYhea2FSOXu7+IbOJS1cbQ3NOPRlM227LW2jdUsOKVq0XcTWdEBFnTgz+tsG1mp2rVd1yyLEQBjlL3fx3T+qvVKcsIMxkqL9g8WIFNx58Yck6zy/a6Xd18sa/y+2P5PnJ2x9yzJ+RUWkDOMOs0k6/x429JhsYddX8sNPs/9nMMxa7674vEvZ+owWiuN3Sy/qeoCzg6leYKD6rYtB5Ygz429SrBw7b+IHWjSqDmNqvWFzKzdni2hqbgfF9UMaQsuly25rQ19NOymiZRlCvGRxdgF8Og6tVwG5r+qpQxlZiU18+o+edVrFKToEHk2Mca0eIt3LT84GO+Tpeb51RlI7QdbgoIK2a4LyoUWGBmlqijC6kTlWqm/7xfgFWZf+In4dkGh2i5N5JyMdj32Eihr2lF0/2CpdA8ClDKn5j78VPZ5pgU5sLIQLRLfWyf8foa7nVxmxdU/fiYBElA/pbgpkjhUA7AQUIZ32uAQ+ZB2qwWzgnTirre+oktgniupcHhnpXl4GDx5JbigoL/e96cJZvqUf4OsX8UYp/rBGtFZTzBuQvwvAcnrsZAhOmd0jq7Zd6yRtcF0FghtiKKHyZPjikbb+zXpnGJDMDPZpcDSM+ZuIMRd6r0VA8LxhYjQRM4J1oT9Tdielg/DakfKD6azcjhtvzPq0h/bSe+s1M34MbaT/FK6/RYHLjX2E4M3VyWlicSKKh6DMxwNZcuwuWPM7sxtToDDuIRzVg1nQOtbuV0ez2RVX4KmHnfQ3JQc9IJfQehOAJffv+i6/RMGrJOngMq800PwjLDe79qDmFQeQZlb5aAjy6LWqwkYR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(82310400005)(966005)(478600001)(82740400003)(86362001)(110136005)(54906003)(4326008)(44832011)(70206006)(70586007)(83380400001)(36860700001)(6666004)(8676002)(40460700003)(8936002)(316002)(186003)(1076003)(36756003)(426003)(47076005)(81166007)(2906002)(356005)(2616005)(26005)(41300700001)(336012)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 05:21:27.1266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a585cfa-d7b2-4af6-0e92-08dabbc8ed25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert to YAML dtschemas of Xilinx AXI PCIe Root Port Bridge
dt binding.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 .../devicetree/bindings/pci/xilinx-pcie.txt   | 88 -------------------
 .../bindings/pci/xlnx,axi-pcie-host.yaml      | 87 ++++++++++++++++++
 2 files changed, 87 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
deleted file mode 100644
index fd57a81180a4..000000000000
--- a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
+++ /dev/null
@@ -1,88 +0,0 @@
-* Xilinx AXI PCIe Root Port Bridge DT description
-
-Required properties:
-- #address-cells: Address representation for root ports, set to <3>
-- #size-cells: Size representation for root ports, set to <2>
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- compatible: Should contain "xlnx,axi-pcie-host-1.00.a"
-- reg: Should contain AXI PCIe registers location and length
-- device_type: must be "pci"
-- interrupts: Should contain AXI PCIe interrupt
-- interrupt-map-mask,
-  interrupt-map: standard PCI properties to define the mapping of the
-	PCI interface to interrupt numbers.
-- ranges: ranges for the PCI memory regions (I/O space region is not
-	supported by hardware)
-	Please refer to the standard PCI bus binding document for a more
-	detailed explanation
-
-Optional properties for Zynq/Microblaze:
-- bus-range: PCI bus numbers covered
-
-Interrupt controller child node
-+++++++++++++++++++++++++++++++
-Required properties:
-- interrupt-controller: identifies the node as an interrupt controller
-- #address-cells: specifies the number of cells needed to encode an
-	address. The value must be 0.
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-
-NOTE:
-The core provides a single interrupt for both INTx/MSI messages. So,
-created a interrupt controller node to support 'interrupt-map' DT
-functionality.  The driver will create an IRQ domain for this map, decode
-the four INTx interrupts in ISR and route them to this domain.
-
-
-Example:
-++++++++
-Zynq:
-	pci_express: axi-pcie@50000000 {
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		compatible = "xlnx,axi-pcie-host-1.00.a";
-		reg = < 0x50000000 0x1000000 >;
-		device_type = "pci";
-		interrupts = < 0 52 4 >;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc 1>,
-				<0 0 0 2 &pcie_intc 2>,
-				<0 0 0 3 &pcie_intc 3>,
-				<0 0 0 4 &pcie_intc 4>;
-		ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
-
-		pcie_intc: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-	};
-
-
-Microblaze:
-	pci_express: axi-pcie@10000000 {
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		compatible = "xlnx,axi-pcie-host-1.00.a";
-		reg = <0x10000000 0x4000000>;
-		device_type = "pci";
-		interrupt-parent = <&microblaze_0_intc>;
-		interrupts = <1 2>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc 1>,
-				<0 0 0 2 &pcie_intc 2>,
-				<0 0 0 3 &pcie_intc 3>,
-				<0 0 0 4 &pcie_intc 4>;
-		ranges = <0x02000000 0x00000000 0x80000000 0x80000000 0x00000000 0x10000000>;
-
-		pcie_intc: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-
-	};
diff --git a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
new file mode 100644
index 000000000000..fc0761a7a2e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/xlnx,axi-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI PCIe Root Port Bridge
+
+maintainers:
+  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: xlnx,axi-pcie-host-1.00.a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ranges:
+    items:
+      - description: |
+          ranges for the PCI memory regions (I/O space region is not
+          supported by hardware)
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-controller:
+    description: identifies the node as an interrupt controller
+    type: object
+    properties:
+      "interrupt-controller": true
+      "#address-cells":
+        const: 0
+      "#interrupt-cells":
+        const: 1
+
+    required:
+      - 'interrupt-controller'
+      - '#address-cells'
+      - '#interrupt-cells'
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - interrupts
+  - interrupt-map
+  - "#interrupt-cells"
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    zynq:
+        pci_express: pcie@50000000 {
+            compatible = "xlnx,axi-pcie-host-1.00.a";
+            reg = < 0x50000000 0x1000000 >;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            device_type = "pci";
+            interrupts = < GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH >;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc 1>,
+                            <0 0 0 2 &pcie_intc 2>,
+                            <0 0 0 3 &pcie_intc 3>,
+                            <0 0 0 4 &pcie_intc 4>;
+            ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
+            pcie_intc: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
-- 
2.25.1

