Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341E770005D
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 08:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbjELG2H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 02:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbjELG2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 02:28:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7785BB4;
        Thu, 11 May 2023 23:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O15TDzhEq+3N99t4fMoxhLayPDwC5cEG07wuNpL5abJd0pQvwxMtbKJI4pvkEo+w+xXXvx7gVHgKfQ6Kvr6RXlS/nZjBp3ihg3N3Iepf47t/t/HeBvylbCWJkyjfHvr2ju9UFrAD9XAf6kcvGOPy/EDHDvOUcZW/7TQMOj8czDFzLneeZy72at5Pq7U8o492y4UvvvqfuC6y/grEa+mtMUNDyOV436ooxUD8YsRPJty9kxVjn9+Iz3PSUVFZmQnY/uZBWrFD9TgwZYhkZyGs0/l+i/mMJo5hBKpNctRd31kQtqO3gKRstZDrRvKRqgfTlfxOcY4m/R+JpD5phfcAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQWiXBcXFSTLU09f/kaDstI7SlzJvuJ5p4kGuoiiI0I=;
 b=VMspdDu5N8I94Cq3HigUhXWZjkmQd/yLARUK33bAwfOc6CRLd4RlIpX+RHIFpag2ZYKtNCXC2XXLd7caGotshNJbgeF+aDVlkiXLLUTp9Xw3B0lRT2FOOj02bOs148G24Mgg3EW04QyRNHZc5qJNbFqgDEmpRPZLVoIpJaJKnH2K48GULPbIav2XwxhKRa8qntZn6GisHbTXxsGnv9DEJO22XTW1cVoea+bliaxus6HCyBklFdqzCaH/PiHfVEL/tPM2Aw+0cRoJ21ejbnkhSeM3sqylyS1QMEHFaqT2wPuorWKY61kOuGtsO3GFX+h/YpyXgJL1NePcZNJ67sBYWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQWiXBcXFSTLU09f/kaDstI7SlzJvuJ5p4kGuoiiI0I=;
 b=ITE3Z4OQO5YXQmkDBts+g0AmFltoy/bQPSqXecdYnnMshqPYP7rDCEyC8RnrmVCeUHdG8anJVdmXGNLylrghN+y82LQTVHGPlNXzqctE6m6LBRP+v8D157wravwabLjnuVPmK58ZZHtrqMvaVCcccV09KF4jcn+hyQvLR1NPB7k=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 06:27:56 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::27) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 06:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.23 via Frontend Transport; Fri, 12 May 2023 06:27:55 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 01:27:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 23:27:54 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 12 May 2023 01:27:51 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        <lorenzo.pieralisi@arm.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v2 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe Root Port Bridge
Date:   Fri, 12 May 2023 11:57:24 +0530
Message-ID: <20230512062725.1208385-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512062725.1208385-1-thippeswamy.havalige@amd.com>
References: <20230512062725.1208385-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: af417cf1-9431-4590-0184-08db52b205c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZNv13vwZiIgw8cU4NAUkLGlXz9kTseL1kGG3PuYwha71+HeVbxxXU8rBQfvq3XZkL+MXJz1HkQq4HpBjQJlymsuTd7+8dl8CT+MpPAifwu1S43t9HwAPp+8S0XcI1/P9OfZHeQ1A2ZjTsO3J/RusuzLy6d1vVSMb6j4nNIEVZmq/dXUKZDRVNbUQd7IgDp3y7CWCIiI9ZrlaE9ESxLAePsCeyxXXL8pACXnkcWEzlyyOpnnkqObxNf/MTo6UYg8ROke/GbjL78SdH84AvCiAdI4p9aGRnZ3t/cZM0xVdzC76db6pya0fJT7YOuwNbNSRtTQnJ+OHbDeYJnxCPxcSJyO7DOQlMc1nb7rGclQxkpVnv3QWbcxKbLMAaOuVb7360puxLsG5Za6dklTd9+lWJabFqzINm+G3VLXx4fKtSp62kKaInMciaPAx+7q6wWxz9sxPRNYSOYle4aEmq6b+aMw9KPeKsf8gMyMgcjiO0FdGHrU4O3fnXcfyo4mPYIEc+2gGQjU0QZAMCGBLewyaf5A4tiFvesVIJXvZP3aCyKEoAAQIYuj55Y9OUFdNcOpxzr/s4SsKIRzZra+XghYWJ1I7kjXI4Qb2FkE5eMvD9UlQ3dT6bLnU7YRf+lTJEnV5Q84SKQCH0c/oYpgAgm/yqpROKcrhiSFYRLFyY/BVZHG20ycM7vKuUOhpGFV8SNbCXD4rz//UebkmPRQK8urC3OEFNsMArtbCWU7IWi4SZ2qNs+vzvcrRq3a0ctbR7n8Y2r/9CbpIoHl2vEaL8ifJnDD+fxjZeWj5XjIgQQtaXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(44832011)(478600001)(1076003)(26005)(316002)(356005)(47076005)(36860700001)(41300700001)(70586007)(426003)(336012)(70206006)(4326008)(54906003)(110136005)(82740400003)(966005)(2616005)(8676002)(86362001)(6666004)(8936002)(82310400005)(2906002)(186003)(36756003)(40460700003)(40480700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 06:27:55.6169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af417cf1-9431-4590-0184-08db52b205c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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
 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
new file mode 100644
index 0000000..e3a1ef1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
@@ -0,0 +1,117 @@
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
+    const: xlnx,xdma-host-3.0
+
+  reg:
+    maxItems: 1
+
+  ranges:
+    items:
+      - description: |
+          ranges for the PCI memory regions (I/O space region is not
+          supported by hardware)
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
+            ranges = <0x2000000 0x0 0xb0000000 0x0 0xb0000000 0x0 0x1000000>,
+                     <0x43000000 0x5 0x0 0x5 0x0 0x0 0x1000000>;
+            pcie_intc_0: interrupt-controller {
+                #address-cells = <2>;
+                #interrupt-cells = <1>;
+                interrupt-controller ;
+            };
+        };
+    };
-- 
1.8.3.1

