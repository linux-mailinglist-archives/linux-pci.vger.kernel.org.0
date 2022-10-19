Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13A56049FD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 16:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJSOzj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 10:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiJSOzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 10:55:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FDBEB753;
        Wed, 19 Oct 2022 07:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+38+/e1H4yiFylK+UEZBaxCKWWi1sKEFxA0DPNKhTKqkIKOXa4dBMENTg8u7h0smS0JX/yV1ns/JT511juYFKe0tXJ8OQ9P5bL9/lShairhQIE51cYCkZcqCpBeFd2oAXOBgQO+B1VdXHb15tuKN5zCSImLqQUOJhsHU/2Xt9QsIZhkPLFyhZChUTiF1boqTRv9w2jlod617YZNxed/QP8L5vByMzmo+acOsBZDsy2zlBMBoUt2YmkuGgMbBid1FcGGjbf7QRZ3MQ5Voxz1lqxFvnRh4zDpfLqc3Qs2BjsP0uaYuQ3p+s8q2520y+nxR9HDAIhc+9JDz93nd72jAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/MimmidqPGF3nmtrdLL4db2omxCnVvguAJknCxQS+Y=;
 b=CzuNT0S0XNglBEDxbP3H3JD9mlQkBQg/WTMXZWdz1+wHALcvvPzzchO1meXmsEq5XbFdPrOOkInLnEKWLjFVJW3/BoxwOi7PoMt3pCb5i+zo0fmOHnYZzf/u1nAxKwH2d5SH37k9Eq5obt/TZqK/qXN2q8n9YtMzA2mqihjwb3FOex3xIjCiIzjlnhbjqMVUNeWeTyfvWpznwZO8idgNk2cBR6vc65mt/E3s3VSSzI44PcqjgN8TORU3b0UxWZ0KfbNv5/CxUASBoeHlh8eCW6a+/92f6ScAMw/002tR0ZYX6C93P9yd5jg8sa0BDN+Bt/nqD1sNLw1WvASnRjMn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/MimmidqPGF3nmtrdLL4db2omxCnVvguAJknCxQS+Y=;
 b=3Ny1ZodoSiSj26iA6az1ILbclhMdkEi8VLcXvefE+skx4u6tm+KYYXpgnin0ntx2cU7VciZ16Q2QDfEnaBZ3Z4DcWnSRndfpcsE8ClgcukiRWghdm4PAvfo/szoAq4AOWJjnKhy6d4bfAvLKgLzfjzxCg8fv1savQNIRlqTS0iY=
Received: from DM6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:5:177::14)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 14:46:53 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::21) by DM6PR02CA0037.outlook.office365.com
 (2603:10b6:5:177::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Wed, 19 Oct 2022 14:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 14:46:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 09:46:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 09:46:50 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 19 Oct 2022 09:46:47 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas of Xilinx NWL PCIe Root Port Bridge
Date:   Wed, 19 Oct 2022 20:16:40 +0530
Message-ID: <20221019144640.9458-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221019144640.9458-1-thippeswamy.havalige@amd.com>
References: <20221019144640.9458-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3539a7-381f-4414-b801-08dab1e0c1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sUO2EohTG5r7ROCWhLq/KXGtswC/+XsoyR6aRumVPUKj/rCiT5b9iLdwg/tOWSm0vmwafFQB4Jzyliw/qHUgfPbprqqGpKwMkjsM8Xx/hCvJZCLHieaCqkdINxJZutF+6sUyKUPY/+n+VTCyH0VftPYXGgUg0MrWLsUUxJXcjYr+3rLIxiylmTcUz2TANI0JBXrFlnOEprBZb2gRITAQvavIZAKoVOK1bxtxdXuUR4MIRk7AiLbobh306XSbWeKr1yQfubnOLEsKxGUk+PRz7tWE1GkaAaxmKtmTqbDKThREA92qiz4gdQ3MXeHKPrf0UfFwj5/XFzVdbyaz7RSxOmsJhLgcKv7SmI5TWSrh3dXMOGWXmGKM3azCjLy3knD/jiXXulNkENa5tJKmc45j9PU9YQaapfRpqkPvIfDoF4rnEp0ie+6SDm4QD1iBKdg7DbK++jryGWtpK5uaFKDEgHC9NhfuwWcM7ujoEmSxL0n0S6QGgOfcloP+AKTGp/6y7qd68a2ElJIycCeLUWNbdeW0NeRozAZNKgmjLKP6uqjpFljgBESvHXg5fYLSf4iolAY6jU4J0vjx49KM4QBPCxYKg03jZ8l9h3u9DPVG3yoFYKZ7gEtfMmnL8ySMT/9qPEnzzhdF4jQCTPCxmnRH5nTZAq626euWdUR8A8QJKs/ZZRuwGoisktnoLM9GCU4fpUrYElv7bstuUMWVCK8yIoBkbEXKxaSblKNArBdUSkvjk0bittAg5JTcbjuO7tZ3pADGVo+YFmtTOA3eS4Q8eKQSxX61VWC/Ey09qimCTOu+/uQKoGAPjdNTKcUyo/PLaBeuZi/xXoMII7B5REJX4snMNadqmiNOjzK4xUA99g8ylG9eJBWopgdDD3np5cT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(426003)(36860700001)(47076005)(83380400001)(86362001)(82310400005)(81166007)(356005)(82740400003)(41300700001)(8676002)(4326008)(44832011)(8936002)(966005)(5660300002)(70206006)(316002)(54906003)(70586007)(110136005)(40480700001)(26005)(1076003)(336012)(186003)(40460700003)(2616005)(2906002)(6666004)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 14:46:50.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3539a7-381f-4414-b801-08dab1e0c1ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
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
 .../bindings/pci/xilinx-nwl-pcie.txt          |  73 -----------
 .../bindings/pci/xilinx-nwl-pcie.yaml         | 122 ++++++++++++++++++
 2 files changed, 122 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.yaml

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
diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.yaml
new file mode 100644
index 000000000000..97a33e8cc171
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/xilinx-nwl-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx NWL PCIe Root Port Bridge DT description
+
+maintainers:
+  - Thippeswamy Havalige <thippesw@xilinx.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
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
+    minItems: 5
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
+  legacy-interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts.
+    type: object
+    properties:
+      "#address-cells":
+        const: 0
+      "#interrupt-cells":
+        const: 1
+      "interrupt-controller": true
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - "#interrupt-cells"
+  - interrupt-map
+  - msi-controller
+  - msi-parent
+  - interrupt-map-mask
+  - legacy-interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    soc {
+          #address-cells = <2>;
+          #size-cells = <2>;
+          nwl_pcie: pcie@fd0e0000 {
+                     #address-cells = <3>;
+                     #size-cells = <2>;
+                     compatible = "xlnx,nwl-pcie-2.11";
+                     #interrupt-cells = <1>;
+                     msi-controller;
+                     device_type = "pci";
+                     interrupt-parent = <&gic>;
+                     interrupts = <0 114 4>, <0 115 4>, <0 116 4>, <0 117 4>, <0 118 4>;
+                     interrupt-names = "msi0", "msi1", "intx", "dummy", "misc";
+                     interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+                     interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
+                                     <0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
+                                     <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
+                                     <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
+
+                     msi-parent = <&nwl_pcie>;
+                     reg = <0x0 0xfd0e0000 0x0 0x1000>,
+                           <0x0 0xfd480000 0x0 0x1000>,
+                           <0x80 0x00000000 0x0 0x1000000>;
+                     reg-names = "breg", "pcireg", "cfg";
+                     ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000
+                               0x43000000 0x00000006 0x0 0x00000006 0x0 0x00000002 0x0>;
+
+                     pcie_intc: legacy-interrupt-controller {
+                     interrupt-controller;
+                     #address-cells = <0>;
+                     #interrupt-cells = <1>;
+                     };
+
+           };
+        };
-- 
2.25.1

