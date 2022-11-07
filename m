Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9861EFB1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 10:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiKGJzN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 04:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKGJzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 04:55:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CD2D2;
        Mon,  7 Nov 2022 01:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3MwMJsGag+7DzH5BBNXaYFqL/T1H0D+QYFsn8a4OzeLJLzvwJlBBqmGBz13fReOED8Wu/Bo6zPYaKwhzMWtugSbijzSbyoNxhXlyqgPMyQIUUecL44b1rHQHFcJ95a+fEhTyki5fG6oXYbbbFLOfiZiQRwykC6grIt/vPY5b5WJlQGRYN5jTmNu457766A2WcIw7nzraJOdPijEiCeMIOVulPRmDN+dX/8OtrO8tLermwLcTnw+uyWfj1K9QyCoZZ9BQ/AMmQPag7Ua396nul6XjoGSEAjD9q2pD2Gk2wipXM6SnuSYemqHqkH0q2/C5MqHda2jPOI4m+EyiY4BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDKJA7zAsGFlGzz/dqLsc0TJ44lqo0ytS3dblT7cNNs=;
 b=aemWRFL9qJbXfIuyMWlgKPWYCkiGMFrwU0xaxTFEhvdlR7UNgHMtBSqJer+WmZKssmQ2YZjvGdlmTxgM6IBPYtsBaTfGRnn+Il/5DbX8kgr//fxWrinYi8ZSjMMzVyE9PVtU6wObbAeM3HksV9KPG3YC6gPwuQk3AQ5KqfJxWgQxUrhhy5eBiywHO+3behH7RFCI3vCfGol8AUYbcO9IBLzZn2vUu7E4g08o4Q8kVUj5ptqJfEqtuIFPyb1SZ4skcZa1+42HCwlzGosrhf5gVGJxh1KJ5i/DhQhZvy+FBqR+irnYLHUb2Ib6O7o9m9gJOxXLOwC2uTpUcBEZ1q8H8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDKJA7zAsGFlGzz/dqLsc0TJ44lqo0ytS3dblT7cNNs=;
 b=v5UE5hFviwex4wnMVJTvAZxaTfKLe6Ra7Nk1ZgP5+grvX68Y74ZEfhEy5mOFTafgvVumzqE4z3kTEcVkRKwzWa40j4Hoko0Bl1bpPCDCbvvk5srekDyZf/YAbNBxDEcUUm6MtzcPz1HlZPA3HLf92pSy16dOaZ/zlGU3fzzpI/M=
Received: from DS7PR03CA0116.namprd03.prod.outlook.com (2603:10b6:5:3b7::31)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 09:55:08 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::a2) by DS7PR03CA0116.outlook.office365.com
 (2603:10b6:5:3b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 09:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 09:55:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 03:55:07 -0600
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 7 Nov 2022 03:54:29 -0600
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML schemas of Xilinx AXI PCIe Root Port Bridge
Date:   Mon, 7 Nov 2022 15:24:07 +0530
Message-ID: <20221107095408.924778-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b32906f-cdf8-4871-34da-08dac0a62761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRd3ftcNUMTeC2iop3Or40VUEOV/CNdg4wqTTckqWb7T3l1vQ85FcGM+UBGMTj8FFFTN2kZWVRrhbuRbtVeAElgbnLrJUfhLut6sZkWT2VRLS2q28XpZFHYp01URxSPTY1T8BxSkIoxUDQi+gFUxa++ysoHW9aY9f2BpRklvbe104NntP7HdJPkKOzc3CEjkL5Lvgcxy1sIK0ZeY7JMawObucxqusitCZqwl4TXng3C5ZzDTGfMcmHPkRBkRGAnCnPHwCk2/XiJx4s2t/nDriu4YT0mqF0w25WKMd5ujTAlutNj+bNr7FEPIn4uy6fSbrS/ngC/6zrZEquazvq0Lqbjn/txv/JqM6wJy/0iutpoI5ExMMiybEzE3u0aVjpjNNZAshKWN1FFbXbr2IclWepSXe0nmqRocGkz1XFkjp7UU5sgGyCcfNExlAzIVJFRY9aAWfl9JUELQDG/HvqHNSgnnoAjT/AIyuQVlo/ve/HSa2fT9miy4dZsmn5udwlgFf+3Yg2VW+EfzxSf3ugD0T7JT/tHXjucidj5znR1e8xqtxGYsB10ZkW71GXP601taDswqPkHlIOW8mQFVSN6kQvFqzYj8inkKR+awqOZyAJ2e44FUW179bGz34TI34hax2gxjTzJkJ1NzJcqrvWJgcKQgD+FOy3tHh6sQyxewEnJtmZEGuYduQcb4JFdp6WIQJTAhkQBmvarwR75NIMI1rSF54lK9tpigonspdKx7ahnld6oSfiW/1FLZA+WPF5asT6P0JNOhcu1w5FHgzOExRpdClza+t5HB8E9a4FJ5Ay78XT0o/i70dBIBGCyD9/FxPN+ExYO6nEztw21ck1bA4XcMgxUyZn5vqtW6hdOzXOfMuQ3GlUZy2e/NMvTcigKY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(44832011)(82310400005)(2906002)(81166007)(966005)(70206006)(356005)(70586007)(4326008)(83380400001)(41300700001)(478600001)(54906003)(40480700001)(316002)(5660300002)(426003)(26005)(8936002)(186003)(336012)(1076003)(47076005)(2616005)(8676002)(40460700003)(110136005)(36860700001)(86362001)(6666004)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 09:55:08.3351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b32906f-cdf8-4871-34da-08dac0a62761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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
Changes in v4:
Modified to same style of quotes as in other places.
Removed spaces between <> of reg, ranges, interrupts properties.
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
index 000000000000..69b7decabd45
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
+      - interrupt-controller
+      - "#address-cells"
+      - "#interrupt-cells"
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
+        reg = <0x50000000 0x1000000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc 1>,
+                        <0 0 0 2 &pcie_intc 2>,
+                        <0 0 0 3 &pcie_intc 3>,
+                        <0 0 0 4 &pcie_intc 4>;
+        ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>;
+        pcie_intc: interrupt-controller {
+            interrupt-controller;
+            #address-cells = <0>;
+            #interrupt-cells = <1>;
+        };
+    };
-- 
2.25.1

