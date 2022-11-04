Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFA618F82
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 05:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKDElz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 00:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKDElx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 00:41:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75027913;
        Thu,  3 Nov 2022 21:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn61fyyg5UwQfxDsXB1Vg5QfXKr0ydVi9CowCOY00dN/tDS4glSDsgjzBsPJxEiJWPY1m47VS9ewgPy8ZgEjbQVFfV/YeQAVd/vwZalT6Zfv3lhP8jn9gvQq8QZ+I9H5FMy4R5TX+1ZCKfEzNCf2YplkHCrmOxLKcjFiU30kjVYfWI0hGZ1WEjCfxLEnlNND/HiW+T4vD9nL6r7YzQcX3sD3va64SxH5+lMEov+IsPGKhenKldWKDtwSbVhhBWTOymKOhlvFhu0exieoO8MI9ZeZyEGI1BkkzhVZ8R5zddEW5fEwdKeoofePfZy/LdSxW5d1WntLy2qVmf0PuMTfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZNZY/iH+9fdeqCJDbAPtUEzGr5io8/3KkAWxZqzmWg=;
 b=QPe8NHhzThDYJD/wCoGb6U3WjlXXh9vNT6y9rm2/jRHNcePwtaEp0NrOBOg7+KnyDEo17RUi5SbtZdtZvdzWGUv8PHG3xLRI4P66de9pU1bk6+mwBJ7fm8Xb3VZ07PLq2Ef5BZ+msAGBHWKF4KdP8xHUWTcL4xWWIW5Lo/0LbiZfI8KzP/yuwQbwjJRapesY0E+9vgax3O43vSAqmGPqhL4eCi+IC9/CCRGDLwrhC6CL/SDhpM+g5Wt/aIPxcGxaMamAuX65KDewDZAZyfW1V0jw680lccGeiacABYUdRV3bm7jz+zAFN4VPTA4Lzkx03EW1Z+oP88pH83Avmpq3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZNZY/iH+9fdeqCJDbAPtUEzGr5io8/3KkAWxZqzmWg=;
 b=AcNdLwROdqPrjq5uR9xw4mb1ccRlEHAOypu6hTlhgsYHDYhIec+zyMhglkCKsKg3edh+mTiOaCNshxMLmpBcGz6LN7pSgq3Gad+Gs/yQwgm2DrQLh2368iNF23WLEDwiQu9lJucnex2X3XGSksILLs6gSkfxrRymnfOwH+W/LRQ=
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 04:41:50 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::fe) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 04:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 04:41:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 23:41:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 23:41:44 -0500
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Thu, 3 Nov 2022 23:41:42 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML schemas of Xilinx AXI PCIe Root Port Bridge
Date:   Fri, 4 Nov 2022 10:11:34 +0530
Message-ID: <20221104044135.469797-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bb2e48-a015-4c56-b08c-08dabe1ee366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLW6RV9akzNqglhtg/4DLovzRYxymjQ+nAiE+RDG/eWLfBEkFIMtU89enxEVY+yLygbXot7d0jaBfUxCo93d3lAqHopeGqfWzitu/QimOQXIpK/ITIkt3GrTEBz5W3LBSwaKNePiXiS4f2OrRiFqMGL4x6bbFJOm0P7YAAyHaorO43IoDnKiggrPPqf4ppRkBD4IjvdjT+u392m0CGtjQs1TYe25KJjpaPSddHkY52aErXpsa4jtCNzKLItAFR+cDZLu/dlpARZUnX6ivSYexIjanKOXsdu3yIUIgYtHW/15SOvADxeo6ODs9bX+XNN1XHToNg76/QP219xwlh+/tTKU+qVG+43ycHsQmXNPMGxn8pue6mccsAhxliH0ZDCjmZG/qjJ8680uf3iu98LDuFJ0sMP+rUlq5OIvM0uuHQVSLSs78qeAKbhZpJtSMqRoKebdZ+goqWZiPoCRXN0DAh8JRaGX8KKV/RGiemtDDFYnFUtWps4zdlz1YmFvRGCrVhSwQwjYH5VJxtyJ3tltMUcxMKxE/KW7Oq4/DCF2/NrpNZcnq7dpEb7YyeicQBuYh4Esjn0+a1QN9x8k1aHcZoXNU4xY8vHJ58xUrzXpQWLInS1b2jdIXlZjw73UbO+Uzmzx19NpJg48d/vgavbOAeagYGGIltpiiEKyynm7JFvz30F4O68lVXqFycaqTsjmKe29qTxlRZ4Bd4U65b2qmzrHdej8QHzpTiu4+c1MrRlE49FIxz3xI9oeskyW730UlikZ+VxURlTa4ahJ/eUKzKcuWRVcAdqDgg/eZY40+Jcv6+ESEY+LF7HpS545dE5YMAgtIOX7n7kbm4Wk5IU8svfDc96ZkCMf1LGGNM/1FeTpNXPTE/OO5scq4Q0UUqkR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(186003)(478600001)(336012)(5660300002)(2906002)(426003)(47076005)(1076003)(8936002)(83380400001)(316002)(82310400005)(2616005)(110136005)(70206006)(6666004)(44832011)(8676002)(81166007)(70586007)(40460700003)(4326008)(54906003)(36756003)(356005)(36860700001)(86362001)(82740400003)(966005)(41300700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 04:41:49.9331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bb2e48-a015-4c56-b08c-08dabe1ee366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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
 .../bindings/pci/xlnx,axi-pcie-host.yaml      | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 88 deletions(-)
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
index 000000000000..cfe2b04d148b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
@@ -0,0 +1,88 @@
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
+      interrupt-controller: true
+
+      "#address-cells":
+        const: 0
+
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
+    pcie@50000000 {
+        compatible = "xlnx,axi-pcie-host-1.00.a";
+        reg = < 0x50000000 0x1000000 >;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        interrupts = < GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH >;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc 1>,
+                        <0 0 0 2 &pcie_intc 2>,
+                        <0 0 0 3 &pcie_intc 3>,
+                        <0 0 0 4 &pcie_intc 4>;
+        ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
+        pcie_intc: interrupt-controller {
+            interrupt-controller;
+            #address-cells = <0>;
+            #interrupt-cells = <1>;
+        };
+    };
-- 
2.25.1

