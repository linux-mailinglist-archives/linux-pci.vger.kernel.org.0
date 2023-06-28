Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A82740D79
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjF1JsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 05:48:04 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:24321
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233252AbjF1J2d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 05:28:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+5d41OC2y0Zx0XKoFYhcrICY5K3ngebihTpTNStSz7ujmYF9bgvy/VTK4/THRMmsOkTUiWit+k7P8144aSsMYGETlSJAZUG2aOx64HsI5PeYasUpmNelG64E5xqDVQlnuxRojFAa4/4ZIoDi+jSInNRLS+MnNh45peWJvd1FmYE3bY7QQ1EuZUMz/czxcDbUumoi+o//8fDyhBHCssUjK+LOboUjvs9PQNzVmum+gxTJoIKbz/y7uGh6KfR1+VCtRpq+Ut/Nh8TLNfu63MZetT5CVK1t7oz5syTs56Rlb/kC6CR5s6yuBvOD3HhksRn8enCi4cR3tzZd6v2xPkmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBzZpUijtMesSK983L3QV7/spfkNsg12eqSx6ROG86o=;
 b=CzblrzuyMOPy247KgdKnJaoq4vCPEPBBXD+kp2x87iuADWkaXiJykqc+Zq/tKoJQb3DOn2UBC9H1PswcPAx0/A5c3wklWowueD6lt2/z0vTmKhgKOXEnBSlOGGiFtAmefTzp7cQW9sfXinCdJ4/Lf5eT13ZHhWQaZ0AxV1nDofAK4bCXULfzX4T3W4UXp4pcg+stKjt4TYZbl3i68HgPsdMuAnAuqL0P7edWZZwvf3gF8XWbiwsCqBb90EcU35Q5wkm6CeKCuU6OnCzKuXaJRxGfjsZBrpBlDsr47+YFpbe+R8/oB0A/xjAVoyo9eCwZXijijdzqPG2XuKZJrulMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBzZpUijtMesSK983L3QV7/spfkNsg12eqSx6ROG86o=;
 b=iqLVVeqQU97ATroq1QO1sgP7yn9rZpvXxnuHBWfOpTRefo3QGsOLQc+Q/AW5534Dy5FN4Ez2+YWHT5byFO+BBUgkgk2G0hwD0cg4C77UDmNtFOYUm/5vxS/EWCN6oLyu4oPpkli5+2maTnfipk83cQQQQINtWpmGQa4Y0/oOcwg=
Received: from DS7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:3b8::9) by
 PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:28:30 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::39) by DS7PR03CA0004.outlook.office365.com
 (2603:10b6:5:3b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19 via Frontend
 Transport; Wed, 28 Jun 2023 09:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 09:28:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 04:28:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 04:28:24 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 28 Jun 2023 04:28:21 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH V5 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe Root Port Bridge
Date:   Wed, 28 Jun 2023 14:58:11 +0530
Message-ID: <20230628092812.1592644-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
References: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e5a633-b2af-4735-42d5-08db77ba08a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gar/T6lfyMKlccbO6MLiMF5kSQv50Q7jMwDvRBR7YfWoT7xFdrmRI+0qi/BwJFjW41FYmU1oA3fcDmu9PM9Ntsax71t79oQ1bE80s9J+ZIUvDkhWEaJoSPnIJb1Nas9+bK4uE3/l0N1YDF3q09C/RfcxPFPO1eP00wbaVLznwimaPDKQ4HaiHLwBNazBJLqUtnGC2htdBw0gQ1M5GB4YgUSq4t53+6pkx6X5yqHF46zVuO7f2aLSn1J0kASkXkpqHx/eg0tcKMSKQZTNFF2BJLmTFZtlD9nQYOCW4sxWzUbgItUXpwvzome5IWaVmo5USIYSsMnytwPJCG+Z3ACd0uIVt5+v23I3JcC/bC1T5hwZnCCRYt6kjXRx/2f4xAyZJHs2Gmr2kZp0Xcx4O5ErWEMBWvkW5TCi8BP730Ch/rlWG3kqIXhschd34X6kYnuwR50s+WMpxGSlAhkYD5OVDtGRWv584u2A/fUegCxv6t0GJ9/JxyX4TEx+XF9+ASH6JQCA37ZW/aHdcUsb+bcS/qMhMoroNytP84917mFaonxkivu8/uFepj3dmqoyUa+OMSRFe9tIXD/SGqi8p8qnFvS1Fplujylq8WEt/jBdzluHzyo/45VbHYn3vDoG+5CTjyLjHbf3NjfKk6eCtCuynTOo2hHHCsYWJ7J1ehesuYEsRWAydqfeojwUEKIQIOX8bXvZ+AI/IRNblIz5GVq7dzUslmQpkNUZk3WqI35u5rfc1QqhVQXcxtBTX3P+9hLYfHMwvMoMoOl1rmLmYKvzdXs0raYbyHHPcD/WMdSbutE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(36860700001)(26005)(36756003)(356005)(82740400003)(44832011)(70206006)(86362001)(41300700001)(40460700003)(40480700001)(4326008)(81166007)(8936002)(70586007)(316002)(8676002)(110136005)(966005)(47076005)(5660300002)(186003)(1076003)(54906003)(6666004)(2906002)(426003)(336012)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:28:29.4881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e5a633-b2af-4735-42d5-08db77ba08a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
dt binding.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
change in v5:
Modified uppercase case hex value to lower case.
change in v4:
- Removed unnecessary space.
changes in v3:
- Fixed compatible string issue.
- Modified ranges property description to maxItems.
- Modified address-cell property of interrupt-controller child node.
changes in v2:
- None
 .../bindings/pci/xlnx,xdma-host.yaml          | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
new file mode 100644
index 0000000..0aa00b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/xlnx,xdma-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XDMA PL PCIe Root Port Bridge
+
+maintainers:
+  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: xlnx,xdma-host-3.00
+
+  reg:
+    maxItems: 1
+
+  ranges:
+    maxItems: 2
+
+  interrupts:
+    items:
+      - description: interrupt asserted when miscellaneous interrupt is received.
+      - description: msi0 interrupt asserted when an MSI is received.
+      - description: msi1 interrupt asserted when an MSI is received.
+
+  interrupt-names:
+    items:
+      - const: misc
+      - const: msi0
+      - const: msi1
+
+  interrupt-map-mask:
+    items:
+      - const: 0
+      - const: 0
+      - const: 0
+      - const: 7
+
+  interrupt-map:
+    maxItems: 4
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
+  - interrupt-map-mask
+  - "#interrupt-cells"
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@a0000000 {
+            compatible = "xlnx,xdma-host-3.00";
+            reg = <0x0 0xa0000000 0x0 0x10000000>;
+            ranges = <0x2000000 0x0 0xb0000000 0x0 0xb0000000 0x0 0x1000000>,
+                     <0x43000000 0x5 0x0 0x5 0x0 0x0 0x1000000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            device_type = "pci";
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "misc", "msi0", "msi1";
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
+                            <0 0 0 2 &pcie_intc_0 1>,
+                            <0 0 0 3 &pcie_intc_0 2>,
+                            <0 0 0 4 &pcie_intc_0 3>;
+            pcie_intc_0: interrupt-controller {
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
+            };
+        };
+    };
-- 
1.8.3.1

