Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB98D6207CA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 04:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiKHDvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 22:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiKHDvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 22:51:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1F2D1FA;
        Mon,  7 Nov 2022 19:51:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItFnqu1EcJLY1THQKLDNLimTj3Ywz76lrWviDqpjU7e64F9baOoNVQ6/ZEFNWaHtQewV9r26Lwuvdpda2NmEnheJas2EqV/yOhbxn313FQM3IzF1AFI0UxBZDWkakaTDkX7/eSCyQz2yrYI3qQDXcgK+D3Dqi8kMec6EbdShZpdsRJYataaSNWAFrYKHTA3ByZ2WsqANJ5ZE2zWQ0umoKWU4loPAaXE7xR7q5JgqrJtQcxCe2RuOZPs0R3h7kebrYn6x/3Z1aWYz8ByRwS+aXKtmVIxXC5+oqWxVCm2IAxDT7AHKpyvTsVikVFQSHWp/3lf7VSW2xV14iOXix2jz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b01L88zLmoVal4M4hRftfaPvjjmTYZHDrm3s8+GXJI=;
 b=DXy+rlvib4B9+uTJg/eF/LhBqh06nLLw8GhJvwBSbUuTteuSH04hRVE3hBib+gQk8w4UqsPPDwRhkGpHLDOrkdLpXkKHMCZ4HQnRkzKlfsx4Qw45V6z9Y98Lj6SnVI6vlna4yvSoPG3OELaxZB4+ejYgx83GlCeEZqDvWbryi+KsLnutxlqzqWI6/8+4MopfREkVyM26OGCD571106eiNcdaty4a9rUlqN9S4pIxm7OcsCtt9iVejClpVIqy24lxW3EffTB7aegtSf6nZcsZWRXO4Js7MTMm0A7Cdl76CjfUiBuXmYWMw34OrS3trNIw8DgYOWb1ZrmB06dyO9O79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b01L88zLmoVal4M4hRftfaPvjjmTYZHDrm3s8+GXJI=;
 b=F7VxMcAuaCAe8f2w8KGXDO5E8nN8hY6OsHy655vBsbD79PRuicMW2p44FZmhXiN3OZrEK7X/N50ww6L7v/ddndQYju7GA0n8gK8unFas/HAFNIUik+vMApe+ItT4E+EgGJX6DHGIV+k1D2CqP6YYZ1C9ayI75T3Wmfz236gjvls=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 03:51:02 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::29) by DS7PR05CA0081.outlook.office365.com
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
 2022 19:50:35 -0800
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 7 Nov 2022 21:50:32 -0600
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML schemas of Xilinx AXI PCIe Root Port Bridge
Date:   Tue, 8 Nov 2022 09:20:29 +0530
Message-ID: <20221108035030.1040202-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b667d2a-d566-43e9-282c-08dac13c7468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Huo7C6bjfttG1AsZkuBtMmzUyje0M+cfWg9H0zUWsl6d9lIxMVhncVxlHa4ICvXGR5layyUTj9D5joeRRp8AEwysi09ox3PRh95OvObRWRtqCNniaN/Ul+vHEh9tZoTi5//tJ44HXyzsN+nUMm7ncmZEcQNC41NosW6C8tE9Fqa+nEuLcxgCPL4yGh0tFjTyBLofa9NMb45H+XcahXfHV3BAhYeXUyn+duZA4W20q7YxyFI+LqoPYYv440DlQCynIinHseDSHW3FMrirFwLGqILg8iCFmZ3VJOvgtpAszBIeCMMGQAsw3QkOosN2sJkp7j4u8+iMxGCYp0XdvFe7pWzzuk7gn8pvUtwevwquNH1XbdfMjBETr5nP8twRej4GuDiS/JPwWx8WxpzQ9A9ULtYAwQfMYSX5H0tekYKpInyFs9copFKMX2YPVT6yPSYDFJ1LGYji15LyW/oZiv/Xl9e/ZLOb0W5/uoR0BiRJr4SQH7U5nFPGyFk0gbr/45ogmX3BQ5RXyJvteNGjb4NewMd9bpJTUqTv4+IoGM8SrzHQd+8OTj4Bd7kcSVWY9vyBCCOwNNvlkzKsWb1miKc9Nlr5yKnH+cZJVBaaWhUu0/KyBmI7hPLxUUhuflyyuaWi+ei0oXlokWI+ZtCnETM72q7ry7d0MsKmiIpvGY6ZiSO+KAEAzkE5Z4lATGfCH714wGAGmOX01fWoqacjAwkBCfoSX6yLmb0QBoOF/6jIwZcEIx0pSgZoQR+Tp3GCSKB2NTmTa7YmXLqDGarWDKX3hQ1b+Tzs+TkNEQlDlPBZH7rH8Z81nuW2+IqsGCd7MA7EzNHI4cV2yypuCCG3KZ5Pw1+HxdaKaWLLFxkrpOWuAQP1g/GrQLB5T0aJFqrAdas
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(2906002)(26005)(36756003)(47076005)(478600001)(966005)(41300700001)(6666004)(8936002)(316002)(110136005)(40460700003)(81166007)(70586007)(356005)(36860700001)(70206006)(82740400003)(4326008)(8676002)(5660300002)(40480700001)(86362001)(54906003)(426003)(2616005)(1076003)(83380400001)(186003)(336012)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:51:02.0590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b667d2a-d566-43e9-282c-08dac13c7468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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
Dropped additional blank line before sob.
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

