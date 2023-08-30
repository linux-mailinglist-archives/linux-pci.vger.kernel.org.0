Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E47678DB37
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjH3Sip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbjH3JHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 05:07:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102ED2;
        Wed, 30 Aug 2023 02:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY1mRSXwlYhIB6G6RufrbEZDVAwwmTphaARBDls6j4VzvEjK4xxT2mI9NnSicxqa5kcSvzKILR8XdjXRe2HxSJQ5A8zFQITz3jxFIYPEEfQ8GXcfpDE+K8CmW+sxIlDU/dW/WNktuKHSQxTt2GJGy9Gfke5cZJAgU3Bsl3QXBrQ0kZuRvjIykxhfjvtbKuMJ4zzo75K5Bl4EUYJ6w2pctqB9Vu2L1BsnFCLTwOGk7ULejgKTGNqXmDpqqZ7J6csGRGxZmzOwJZ6IV4d7JoiJjWw2+VoL7cI+so2Ju4YiU42e6OzAH9ybKM7820VXUqQkP9iV7O0zxybYaRU171FRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK2rvL8XJ6T13bb1n4kbDrDbVptcpak7O8ilmpKuHWE=;
 b=HZ1wuY3eoMMQQCZxb17SGAJA8hEZcuM1S3zcK8+5hyobHnRhJqLxW1gT+Pvl4xOO0KRZoHgtBsgmLToab5dAwTzCAn4NmmK+MbVhPiTxdj/k4tSxu071jDp8lEzvB34aoueYXPru5b7jB3/CqY5cAd5nKVvZ/FoXPIOlZj1/WyzZf8JSaxKKMUIqZRrk6Ad1fbXcAFbGcCyva1GSo6Z35zYjrXi7OcVjd/t5m5ycnO9+/0+HeBLZUUMvnL6Uj376moOOAd29R0ME5noMzzkcCehwa1nqB8OiyUejKVShGQp9rzErO7Qg06j/IpjPaxzSQpDa53JN1RGYVTx6hUTDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK2rvL8XJ6T13bb1n4kbDrDbVptcpak7O8ilmpKuHWE=;
 b=zoSFokW+7nE0bL+57NkdkFnCPBJXHoue1eLAQEE4XNFp/yF82KsiaWqGHylyEm/O0OdKFdMitliXHvf0A4FU1tVTSEszrhhcCJ95KZXMoxdlXRSouiTvI+e8p2aI02+lIew+iqdl23a8pxCxutGMpjeZUpcALno2IqCgcLiQwtE=
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 09:07:34 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::e4) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Wed, 30 Aug 2023 09:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 09:07:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 04:07:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 04:07:32 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 04:07:29 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe Root Port Bridge
Date:   Wed, 30 Aug 2023 14:37:06 +0530
Message-ID: <20230830090707.278136-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830090707.278136-1-thippeswamy.havalige@amd.com>
References: <20230830090707.278136-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BY5PR12MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: c25de3ad-9991-4363-59a1-08dba9388ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHLZkve401ADdQ4Q7YOLGJBsfoNXT4ZfXCHrdEQjwOXgV6q7EQyX0XYj2c556B/olqRyFItpkwHb7PEmAw2pkKb1994Ub/JXGJfEjnmTT+lDwsk03jvtJToys3jbxYwiiMp+1jtUDJXy/D/4wf6tXqgZJQeqqpRMD5Hp8lU+sWMlw1d/c88YEPXKZJtzorxWrA8J+3QUwA1YriOUEsTw56x+GXe6rY2Gb0U9hl/WqlloXxoi04H4jAgd4qahCgN4Dwn2gszHvx7Yuz9IF6tk7NIIigr5RxLlfNT7PhXA2Pg9c5egB0A4450HrqSHhOhcABftIsbEjBDdAo5+uXd/hvg5LgJtyKY0ENXMXkWZnbcdp2Wln4A50UFVNVWTiUY8eegK2I649gWgTJe//LMv2t2QxjSO39xdzuWNhqWBuctYBp/9r3JQBIU76Db4inj8kRVUFz9y1FhYFBNklbc5BbdExYSR3TauPcwY5aJIThzomNK8e+7v3lj7V4h685nAFFd6WpNLTJM52HT/D0HViOryF68PiuZDV7jKF+QrCOi0oa1MQwQ6deJhcYXJcvP6rwyPVLAyv/53FWbUCVshkEA4sEsThuqlcHBM9uW6GnUS4oE2PaGxqOtEo7sgqMapTZ6KTCYWU5PcTtcmnL6N/pEF7D6pJC5uflEUAGA5ldGoy3k9VKMK61Tl77n9x16AX1izFKdiSqHo+idUBxIah3qSBN2TWXDI6sNKVOANvHJwmIlOXJQWJqq4MvNZ7tPUNFxd1cSgHjwFRz1QOYMD9Q61i7wMq6LnG5Smu8SsHac7zb8V58gAHTiZTZcGhA2Q
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(4326008)(82740400003)(86362001)(40480700001)(36756003)(36860700001)(356005)(47076005)(478600001)(426003)(110136005)(70586007)(26005)(336012)(966005)(2906002)(81166007)(40460700003)(70206006)(8676002)(5660300002)(8936002)(316002)(44832011)(1076003)(2616005)(7416002)(54906003)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:07:34.4545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c25de3ad-9991-4363-59a1-08dba9388ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
dt binding.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
changes in v7:
- None
changes in v6:
- None
change in v5:
- Modified uppercase case hex value to lower case.
change in v4:
- Removed unnecessary space.
changes in v3:
- Fixed compatible string issue.
- Modified ranges property description to maxItems.
- Modified address-cell property of interrupt-controller child node.
changes in v2:
- None
---
 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 114 +++++++++++++++++++++
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

