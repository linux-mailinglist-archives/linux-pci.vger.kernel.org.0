Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486B262531A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 06:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiKKFhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 00:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKFhW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 00:37:22 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10CB64A2B;
        Thu, 10 Nov 2022 21:37:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buohi4luCCUIFxVtavdCbUTpeT4hohJkJFllqf1/WwLyQHFCUkj1XyRDf4sss22i8ylsCVoXvWvUpgzEBTxRe8Hr3DwKwwYqBS28x4JuLu/ERyatu9HTzN+de81oU2e+yRVJj+BMXHapWLuHywPIApHJQelpFY0O0XK53Q0yTlL2jGyQGHx4jwj9EFZgipF4RKC4IQqcxFb72sJeItKX8C+L5fOij6RbOsRJjvU8HSYA2qDnPFpQ6XF2cJCtHW4uqUtD3WPXtptCUYguhMkzrEEAjt3ldOp+CXjX6VQtl/5RnX9RpRHxUtKpE1m4e1qdKO2mnn3rPZvcPOMd5p8Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cW6r+Z1TFxn1OnXUEVfCIbVORQbc+I4DZzdcTHLp3w=;
 b=K7WaKx9MJLli0L1BOeeSYRsZBahbQjmQxGHaS4odUn922GhJwYk8Cnsytv52u5y21S0ulna+e/5apqAvWxg85JFUrHAnoU9+mDEK/flauX+TaALXR58P4UmZ2vw8US22bbHwUnXfmYJUueSVq4keirbO0/dCSDVMzNbukFjNBc0U4P1/r0RMn8d1R0Tf1G0jOq+AoU7c5uNly13H0Jd8epTC4dfell90knP8UUejBb43wxCTkC7TaHVz9tJEFKOo6TW8vvTn/BJmaiCqk+lK6mqMiYL6otXvjg0vzpBNZrHfaz5powlYH6D9RGs4fS1bAfRNS2VLNK2TtDBh3oBUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cW6r+Z1TFxn1OnXUEVfCIbVORQbc+I4DZzdcTHLp3w=;
 b=oIg1M74hZ1zfKb/H6dKo2yvU6bz1qY4GjAjN03UedAdL2N/S7PjCmAOur6AYNeaYFiuYSO7+UG1nbrglV7mcCIah/wp/fQWxCAgiBHMiKMF1PJls7TQY3CJpRZOs4GS8IU6v40/2s9qBkeX7+BVxk852/P/UGIoqfYPpOy8lFnQ=
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 05:37:18 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::d2) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Fri, 11 Nov 2022 05:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 05:37:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 23:37:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 23:37:17 -0600
Received: from xhdarjunv40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Thu, 10 Nov 2022 23:37:15 -0600
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v6 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML schemas of Xilinx AXI PCIe Root Port Bridge
Date:   Fri, 11 Nov 2022 11:07:08 +0530
Message-ID: <20221111053709.1474323-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ed184e-1b0a-43c8-e892-08dac3a6cc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RK9Da0MQgJzH8pKWFaWt4ybDbg1RNKuJxslzrgu6fFQPoTq09kuUYwr5H5LHSCeFdv9g5N47I0DL14+drXDfxMkywwnWGJ8CQaeiG0Kk/A3jIlCTfd0GeBNGBL4K0XEy3c/7MixYgPJWoE/JXjnTpQecF4qh+cpWG9jOMdW8695b9zppjPCerAii1APdCC8hzV+pB146gcnRnolSKaEolVUf6uxGf4jivCB6bvtkArQvkoFOYRqsZAHVBinezD170cgd4WOxD0Q8l5n+4xEOSsRYj/sDVhBoYJCukzZ3qttiZ2Vk6R6pcJ3T02/xArSYNRXfZVhfWb+/AGj9EvCrZ7okjkbbr8WZnUqycHRg55FoXL8hsbuuvqFt6y57g+qhriKpMsbpjWvT03Ty11RpDaB+sIFwcxggFwzc/Wg0DGLe4XVvOu7ps0Hqmj6rqPuRj4gb8XRQIqh06lHMFdQVtqmKqpWK9WLxtzqIk/f5Z7kWR68HV1fDzg6jYfFrg83VHHs9tm51uHCKwzAu5/gR7TocuBhfBCGXwsYhHUm/56oBRaVtkpfdrK6FjFOgN1KnaRSW+9pay23Kc4+lkY0ewCRR+7BxjxfhOZMrsr9ZCucCuqTjU3eAOrsW9LkQWZ5md9HWrpb0gs5FDRs20B30srs+NTKsydddTBxjHHjFETlCFJTLia9RxyLL3rfloaKs6FfTjyQWqcdZENPf7eZXjB00JS4z296YRZ3n9CqIppdY6VFUjKjiccfZcLtNRc7tdF8DznjZ1UFGwxRWTXxxXIVUXQChWcUo5QcVGmmSmh07Z3M9NRn796+Jplrt3/WRT0gNkvx9UUd3qeXNvdADMSCj1EPi9aID2WNXDrd0gq+knsJu3ehz1p4tRiwAPeHJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(966005)(478600001)(81166007)(82310400005)(110136005)(356005)(6666004)(82740400003)(54906003)(316002)(40480700001)(4326008)(8676002)(70206006)(70586007)(26005)(5660300002)(86362001)(36756003)(2616005)(8936002)(1076003)(336012)(186003)(36860700001)(47076005)(83380400001)(44832011)(41300700001)(426003)(40460700003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 05:37:18.7191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ed184e-1b0a-43c8-e892-08dac3a6cc70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

