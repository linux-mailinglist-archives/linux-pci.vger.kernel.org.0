Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344B27808B8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359261AbjHRJgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359311AbjHRJgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 05:36:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C23AA1;
        Fri, 18 Aug 2023 02:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYbqiQlqQVPX7qaPqfEOusEH5baMep3akLv4UiI5pp9iadEJDXDppY+YoHh2d38sNQK/uTL2W5hFJXy/gVLdii2rOjigkNBzP+zQW3vmqzBjD8AIYdFVCFsGzxYyoUE7q1tvRUxjHYRLJ10+vn2oPk10/TxkG3nqFAxgG7v50sui6g9ecEMqpV09AcKHYIvyLp4jnReTKIdqhGLXmudEoFYh/KbnacXDs6A3wsTjbJ7XfxidZ+ZkPFSzX4EfZSuHI8laAHLVrf6oV73elNaixKiP+Pwmcmrz/cQzBafaF2zwxSFhnmU6SNZzFU4jIs2swbKjHM/zRzrY/3pgG7+ElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yjh3od/XM37KtFs130bGe4hEcVjoBTkNOYcy78mtl0=;
 b=kJos6ibIvHy2J7lLZs23sfZJC+WPEbVQnRAFnW5tbLNjAaP7RqEEntngAYsJVjmfEeUBDJ8ngcyEH6n8tNkRORKOroVR14cmEKxzPcuGYH2Xb4EKH+kg22AUCovR5fHxgdRMyxUNGezlNNJVimYI6iZNP8X870Yl0hJW2fKkWknXQtTFYK/v7lEMxXsm4xpVBIbGtfaq8mv2iJpaccyrQpUeMmTiUSzk0tXTET1hJJoKdo+n2zncwrzuIYON9/F3rxbNwVDThT18DGVaYkYCTWalGHdO6wCmBjjTd1mYw1KGIGG7AasriqOCD+BtSJBe67WSZopFkVRP9EaJ+fEV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yjh3od/XM37KtFs130bGe4hEcVjoBTkNOYcy78mtl0=;
 b=XtPmGeJMLUkFLGaTYZyfe3pRXSZiyHJ3aN/ugLQQHnHuD4OzBXvAoYxBb+bW4RKPC5s2XT4PI2XZUYOmAD9bJaJLT6QFM5j5yhRv+r4Aic5+uT6Se17pTSHrXUf6bTWkj/fuC7TeJaUXVNAnezyKednvozLpLJPGqg2zPo6pF5Y=
Received: from MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24) by
 PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 09:36:06 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::42) by MW2PR16CA0011.outlook.office365.com
 (2603:10b6:907::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 09:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 09:36:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 04:36:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 04:36:04 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 18 Aug 2023 04:36:01 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <michal.simek@amd.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe Root Port Bridge
Date:   Fri, 18 Aug 2023 15:05:06 +0530
Message-ID: <20230818093507.24435-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818093507.24435-1-thippeswamy.havalige@amd.com>
References: <20230818093507.24435-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH0PR12MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 6564352c-3b4e-431c-aece-08db9fce8ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iIKqIyVKhJ4bx+S04UItmOBrkCFhayoT/xg10ieSQctuLNr4fAWs6dGV0umgQHp5Zfo7odMcr12kQzb3dpT2DND6F9do2DUiHKgnra0S005Io+71PX42o7ofl4TbFK5YvAWWSESXQHdDlbXGniTg1LUZhuM7ehFHOP9UPFSMcir6jHeaWhKK1XSQ0/QCHyC+iAcE8LEH2XtBki+Od9qd5JRRySiqGYlBAv7yuVI4LrydAco6LfT59VsKtgKxxmcBHJ9t/ML4H37iIbHB2vlsMqIrECa4/7EwHb2BSGBOXI9zjVHC3TuCfoGh5MgGe16Nbs+ViJfbLwU5s6hgSCKpcszA7TtmLzooQemq4wwlUq5O3JKW6HpcKxacELykkxldgSwcWEiOeAkSOfVaDaC5xnmbPgRy8TSxCIP/KynWIVBoczkt5on9by65XtbB/x5C6eeooSHjtwpu5uxXxKvB5EYPbru4xnB93QTT/rVCiUgycGiDk3imtgAb7GstLVpxzIM2Gf4z/T70jW2VHO2y7SNsp71+gHookRqIY3yya2FFhPqzaDSHtnAVmhORVNjEXcAvmNpwTij1CkTlq+3NM3EPQ4g9oRSOpOWfULf78dTSI3wqInIQLuwL5Xame3eyzHJHpeE+i/NXUb5eMjv4hm5OVf6QmZrXZF2EQV81SzcXn7w2V1abPI25fNnwvvNK4EJiYMDtj/0VBr3OvFRmgGRy8BChPHEabadtco98mMEDWBKNDBsHHSRw3MhOl/gaRnRL+3rm+ZLxDX1j0UmweDqTV73/w292xCBysbbGN2iNDhqcUIukSr8PgVC1reD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40460700003)(40480700001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(336012)(1076003)(44832011)(47076005)(36860700001)(426003)(2616005)(966005)(478600001)(7416002)(81166007)(82740400003)(356005)(316002)(70206006)(110136005)(70586007)(54906003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:36:05.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6564352c-3b4e-431c-aece-08db9fce8ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
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

