Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429C6049FF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiJSOzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 10:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiJSOzP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 10:55:15 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55C1BBEFD;
        Wed, 19 Oct 2022 07:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diXok1u0105eV+djuIe7gJoPWNW9NQX+c7YRgm9NfO1ETS8MnZVbupYvIvmpNXaq6uw73BprBBWPfGcOEtb6IHmB0jvNqWYoA1lLN95jvY0fMgLw8RAinVA4qwD23w3f9KKCmz+QFrYEhKpBDlaHVzZzgisPzuOj/Ed14wM4ip8sIY7/fA7FncJuXZ7UOZZxMFQ4Y+AkiOMXOgO2MJ70vZPNJov355Kl7qSsIu2i0LKRykv3al9zY/33A/H/aE1dzG4Kx8RlTFVmeWSiGfLvo2YzwwXz5nRdr93qARLCMsGbeXj90d/ACnIBIYHE8HX/2qfbVOAVRFwdqKgG54iIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUpnadfdzMK1LS7jCOVe767krzTOT8gzC4qjPNed+g4=;
 b=EL9JzP0In23OU18MjlTOEpsyZTzPOtOuaQDfXg8nfZYq6HyiJQ8532gu2BNcOvBBlmvBY7tViUHZcP7QZe0DIkTxWErsE5r2aTA865ClcLoK+CWIEMmpO32CA1mbL3PO3tfNW6kt5i70PSCxPncfquyZb4q8qN6rKvjPSOqaOry/fhIskF2M1x3/RKdCRokXLge2XJls5rHn2XuJp6cGBkH8689PNowEqpaam/K+Z7zDXlDzPiyC8BgnxHJiOI6XQ39t6lgZu+RHUbTgUd/UkOdrPnAHPWKpFVd4o0Nf7szjDSoUnxG16t1BkaNtF0HOWZ0TIhu5+Qhrcg0wmIbOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUpnadfdzMK1LS7jCOVe767krzTOT8gzC4qjPNed+g4=;
 b=nnjZQTX74izF8xGoxq0TqWHZ2VYUDipH0qTa5heeztPzcjtkP8H25J9Zs39MQv/UaBVEos9JDNuNoNYRDwFgoUlXpHB1yk/3rLwJnjKqh5NoUhRngg1fANtAvf4ZCuoesS0hau1XJNyIUAvWi8R7Xgd48OOyEN0NTKJZVA9mXAw=
Received: from DM6PR06CA0003.namprd06.prod.outlook.com (2603:10b6:5:120::16)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 14:46:48 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::d6) by DM6PR06CA0003.outlook.office365.com
 (2603:10b6:5:120::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 14:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 19 Oct 2022 14:46:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 09:46:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 07:46:46 -0700
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 19 Oct 2022 09:46:44 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML schemas of Xilinx AXI PCIe Root Port Bridge
Date:   Wed, 19 Oct 2022 20:16:39 +0530
Message-ID: <20221019144640.9458-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0b71b1-31b4-40e1-3b82-08dab1e0c019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBsqyhwK8J9mmkzXugHk0OfgPmYxhQQPwSv38Rl1uo6KnYfgFr4JNMS5luUeEtJ2a/xgxzx1AsOAL0XelnKTYeA3O5CSeNb4mttOlbfGjHe95il4pXVD+cqj4UAceW8c2mlgcyyqgIg4pXRkmZilOE6PTwyYCa0iCoGYzIciRSjKoNlPw5dit3WEql6NDJ1sOXbd20slKyZ1P4Tv2rvaJzECElmsM9Sv8yW8osiqqevN5UnvWz9LYed8uO9XkQ9l7X3Owq6GKA8e30N0GnM8MvolYkY3Tmnc7HWJ49ixiowoVTsN36cDMH3RRt2mY9aERo6rG1kTkEqDBFaDIf4VBvbOaiTbvkf1ZFUtovxJXs23XKFgaEUEfd1ibj1qNruD4+bmYUe4YH6XKLk+jtp3dnWUPMHAM1XMEJnEmT771CSWxPuUvsVU4QOR8dqR26lrePnDs18P53Pi1Q05swfWzChZjgsEij1LsbGo64l5zXVjmJHtgyq7JEBMKrDECNMYoy0N8+8UXomJ1596SksteexbqVGSLWscZ7YhKiFKE3dRwa1/ywic02wgSia+2JdpieGmdlxf54nd07JiNalDqOPbFyh/x870/iojR3CLUHMAeZvv0wqSJuGn7dxHllNtdw794/teSeiAVkPaE4xOXWAMdQWpwKvLtwJzhiKHWkcqeIvrWwnVbbaehd2Kl+0cQr9SBFQIwWtqRN4ZlJ/9DxT8vUe43IsqxeBSagUkoa2Mdmad3GPQK4r62KWUd/cu1l7Wuj4w5VMKjUFk/QbE33S8wi/0gJtL2kiKRaXG+UHEHMi/tki2GVbJ8y2I8sjKUqy94GO3qgvjNP3UtmXhVz0lEq4Qh6HsiM0x5PiVgcBnl3wI08yBhuY63+swnHQX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(316002)(110136005)(54906003)(83380400001)(8936002)(5660300002)(336012)(1076003)(2616005)(40460700003)(2906002)(44832011)(36860700001)(70206006)(47076005)(8676002)(70586007)(86362001)(186003)(82740400003)(82310400005)(41300700001)(26005)(6666004)(4326008)(426003)(40480700001)(36756003)(81166007)(966005)(478600001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 14:46:47.7516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0b71b1-31b4-40e1-3b82-08dab1e0c019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
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
 .../devicetree/bindings/pci/xilinx-pcie.yaml  | 81 +++++++++++++++++
 2 files changed, 81 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.yaml

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
diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.yaml b/Documentation/devicetree/bindings/pci/xilinx-pcie.yaml
new file mode 100644
index 000000000000..6b372ac1763e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xilinx-pcie.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/xilinx-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI PCIe Root Port Bridge DT description
+
+maintainers:
+  - Thippeswamy Havalige <thippesw@xilinx.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: xlnx,axi-pcie-host-1.00.a
+
+  reg:
+    items:
+      - description: should contain AXI PCIe registers location and length
+
+  interrupts:
+    items:
+      - description: should contain AXI PCIe interrupt
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ranges
+  - device_type
+  - interrupt-map
+  - "#interrupt-cells"
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    Zynq:
+        pci_express: pcie@50000000 {
+               #address-cells = <3>;
+               #size-cells = <2>;
+               #interrupt-cells = <1>;
+               compatible = "xlnx,axi-pcie-host-1.00.a";
+               reg = < 0x50000000 0x1000000 >;
+               device_type = "pci";
+               interrupts = < 0 52 4 >;
+               interrupt-map-mask = <0 0 0 7>;
+               interrupt-map = <0 0 0 1 &pcie_intc 1>,
+                               <0 0 0 2 &pcie_intc 2>,
+                               <0 0 0 3 &pcie_intc 3>,
+                               <0 0 0 4 &pcie_intc 4>;
+                ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
+                pcie_intc: interrupt-controller {
+                         interrupt-controller;
+                         #address-cells = <0>;
+                         #interrupt-cells = <1>;
+                };
+    };
-- 
2.25.1

