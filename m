Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D644717A4D
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjEaIjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjEaIjB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 04:39:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37DB10B;
        Wed, 31 May 2023 01:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJxqsvHUG9xSNjrRyIAMzBcjlxpGT/U1w3WAZRGJhSFzCNig9rn4de87UmzPHJomIkImgPdTj+/2yPoPJND9cpvnzb5ulXgtJDQPjqu1/i41m4RaqP2M6+I8pR7S5CWnXm30YppGr8v5S7d6yrUKQMJbjL5ec0b7Y5dT2Pa51UwidOD3nmaVYvLUY+oPf12328UccBc5+6jFgR76SjHaprmhyBB+dVFXrJXbohQn+eIWvfZNdGGRg2rBHvxA5tiz7Mm/jQYmyKnuVgU3NqsatURp82cwKvfKohLImkzHeZNJjlvU3ivBfN1oqj6ZW1qQ3ASYbDotm22vX39oEMerqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKmznyeJNYbWYILwdWkjf2CRuQN6xmFrueQPhh1E9+E=;
 b=ZiIWeNy5lPPwRA1q1vcjMNb/tadGH/jtG75BLie2TeOvUZGil9GIpITrGuU8K/V+9+BdLL1prexV7pH3brjEtB9eFJNYRAc2x0Gz+xorOusZFnslaC1ZaKrtWNWUUwVUYRCyUJeMZsPO/efGOlsBNWvJl2ZwoRmrEAiElyyWvRDnplhBcRpJRFS9Slyv27FlmuiInsccGPsWZjMjuHCL8AGzJ52cJ2mA3lO3nty6OO8RWoxjfLkqVQrjVtMV3DoaxI2TlY2xEF0pRx0Piu24rpwTdKNTkI5waRf+/GEcbkN5swdH8cwnmlgfMcNM69EPSE0x2BZTH+sKnNLow5BKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKmznyeJNYbWYILwdWkjf2CRuQN6xmFrueQPhh1E9+E=;
 b=gaf45xOmuQ47kCNVoZ10kW+dKhe83uGdo2P2MWAkkvbAWAZGze/6gCjF/CgpaAjisXCr/H3gLSOQJ7DOWGzHSybT9prqks+MEhLo0kISyG7FAWjpDezhk6uIozq8eGQjyHeGBEGwAE4Q4QRdi5LBCjEj1IdU9FacclKH0xKpNlU=
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:38:57 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:330:cafe::fa) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 08:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 08:38:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 03:38:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 03:38:55 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 31 May 2023 03:38:52 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        <nagaradhesh.yeleswarapu@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v4 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe Root Port Bridge
Date:   Wed, 31 May 2023 14:08:24 +0530
Message-ID: <20230531083825.985584-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531083825.985584-1-thippeswamy.havalige@amd.com>
References: <20230531083825.985584-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|DM6PR12MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: ba807da0-03d2-48fc-e5bd-08db61b27923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbXqDXLkaEedDs0ib4it9Mua3Lb33sDcf/0LbUYUdP0lHDiGZlGbZifC9Wgp9tuw2+PQfJFlZVPQYlOVU08G2suSHIiQisZr62vakHh76annbiwfiFN06u9xb9afsqjGLKoQ5WEzKx8ccLcz+WFA4Wv8jM1R5mCuZ0YPqUz10aStOHHnT4nelMZnPLAAufM7Zc8iWsiqlfsb0yo84wZIZE877XFowO7iqFMSytzcrQZMQ0Wv5/19ASXurGLgpaZNFFhVHeLM4xaQRdZPipI6K++yjXDHeEjBPRaZpPKQMj54yMvO+lWxvYO+imYoZnDUmQxSv26LU8Mqqp5GHZvVzMPc0U1S2BqkJuQ6Zzgjnplwb35aEDWWAhljCiydCemo3mZSLmtvgY6iUCVI0xnkeNXxKJOkUBwfQuNfWeBhOLqBY9yE08poARyEJqH1dA1B3SA+t8kW54/7oIIXj66eBX8ZMTnr38HCZsmg303orrs5BiLKEzlZZbMrr/mX4TFLxqyle2KiJIDwvRrixZbuKWQPqCK/xjkX32G1AWdW7p/VzGt4LPoeLf5NZACX/3UIrL+JQk1IeMjNGTyDQ1aQ5ilb+02GoZHCy8rSflHoBTECsrClFk8CANYh9mc5a/j2mE8Fa+hbSUMyUY1yyEDURY4JVLXLl4VU8GukQp1OpOpQbx6bSP6nX+vTRx644OH6l9VGW3k7UqfPbtlJuPjqj1cQ6ngVWIRmD+uNFoZye5MSoHXasqWXSXhKHpN9FNoS+NWGeM1CgBcD5+Xm/HJAOtXIavhi5MmZYhz6orisqZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(36860700001)(41300700001)(6666004)(966005)(47076005)(186003)(426003)(336012)(2616005)(110136005)(54906003)(40460700003)(478600001)(82740400003)(70586007)(70206006)(356005)(4326008)(316002)(40480700001)(5660300002)(8936002)(82310400005)(81166007)(44832011)(8676002)(2906002)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:38:56.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba807da0-03d2-48fc-e5bd-08db61b27923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
dt binding.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
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
index 000000000000..94f17a394110
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
+            ranges = <0x2000000 0x0 0xB0000000 0x0 0xB0000000 0x0 0x1000000>,
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
2.25.1

