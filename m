Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB26709592
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjESLAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjESLAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 07:00:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46767E6E;
        Fri, 19 May 2023 04:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZxaA927P1tpalYWW6UcqrYFlmqqej2tKCqjzVuoviN0afcXckNv50w0qA2hYjnsgzMGS2ACvyXDdcCbL9MfOYWwbUuluRA/cuOdKrVsnuJF+ezOGd9OHlK5Dv9Lxy1uzAg+cRLjbekxN3ht67sTsznh2TxKtppBzUX0imEU09U7UMwmSIDaAw+xlXuyNNPkdJYUoN0UFu4MLOthTzsjzkSIprv0Ej/wk2MAHPaHSS9p+wzQbDtnSFQKbAImyCul9mt/xbB9ixdqgf3z786Fl3785szngST8d+c1lvL0Yg7JcdqfLAbTxeV+u3j51KFIZWihDWLX5pSUPF/TfYmjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2DTPVSgAbB5zdcvzIzzMf5T57BQtn1rgAdbeHhCaoU=;
 b=duJoNa6mrTpSINrH2pXWzkvzpw3FB4Ojk6NjXv5L0Nyh47DcFoXHFMN+OTiU0be845vXZiSWQ3G0HYD7PFFeW62JQwHsLNr+hGPQYqPkCBMTHF0vz9ThKqi1Z7v1dQBnWmn1n0AWQXW/TnB3A5XtuyDVl8jyNc7k7TF2sbGJ832aQ9bUE6xKNMCecVmLOWb7gCQFX+Z/bNc+sweD7iAH0k1ZEAexRorG/TlZz71tSZGcpyrnV+sDqrTPvWSYy7b/syvGOgWDETBcPPX10Wzotzwwumz9mS4Wmb4fcU5DtL8jkrnw/OMWROJsImErOGBGlr6mPIwNpRGRKZXY5Evx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2DTPVSgAbB5zdcvzIzzMf5T57BQtn1rgAdbeHhCaoU=;
 b=tScLZF4lgrtEIJEqHy4FBTik+9gIjVJ7ImkCPL6qzAUE3pMCRqkLeymh4ntr4VwcNYzp6eqz1RM73CCfx1yJavQyOTp9xA9chWD3I00K4QYm13WjenP8bPbRENiiVZl7vTy3JQqk9JpND7yg0B5pOJMFdV5jiecefg8S/jQ+uco=
Received: from MW4PR04CA0188.namprd04.prod.outlook.com (2603:10b6:303:86::13)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 10:59:54 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::91) by MW4PR04CA0188.outlook.office365.com
 (2603:10b6:303:86::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 10:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 10:59:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 05:59:52 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 19 May 2023 05:59:49 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        <nagaradhesh.yeleswarapu@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v3 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe Root Port Bridge
Date:   Fri, 19 May 2023 16:29:00 +0530
Message-ID: <20230519105901.2399452-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519105901.2399452-1-thippeswamy.havalige@amd.com>
References: <20230519105901.2399452-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|BY5PR12MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d08270-3676-4ee8-38c4-08db58582d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tE9yxlyZ/HMZiRTiAVec+rKKH8JT+OEtX9E9pRjLSpSy56XU/jkVeKTanVfAPEHzkfXIL029Dd//cCF9h1F8bbVOBjYJtox52QLyloYjyejRqRBtqYEfpbaWAcVo0ADstglyFH15OHOFzwexV3ytyk2u0TohJdQax4gej+94iajlgTAws5lNZKAYYjnJeh45nIx63JkU0dH4FdF4AqJZfke6cdoZkYJSgrQIQYralOrbPeUCncIDjwvY9nkwF9ATdy2xKustt3IoH1tYrG1LWjjg4aorrSC+6YTonhWP7SIO0F1wkhrDEcUaCCu6Kr92EB1o9GVsWdGAk2Dc47jWlbF0gRVqAWyiTsMxXsJpfgvMz6V2vFeS48fhd/ciW/MTaSYhtXzh7MYAcgsJM8ToAJG9OjQknHxJVICSVX1iOht8IanQqF4dr2cpzk9kFIqqHPx5s4ZNgFlt0X6fX1yrTlRNlGglsK3IA106wmCC7uMwks+Hgy3oe0SZgJdlPh5bVbyW3ze+/0yAAamw5PZDIK9BW6Yd0+nL5AWFozzBAiUKdZYvfD10GI2ZNkjDRChvfunii4lPyRa4NRJ4l1dYa+tlwLGZHdzRdl9Ys5e5UDgUNSHWHrwSakzj24RS9rPqgGE8Rng9dsyyA/vfFYinC4G5dnDg845YXMEbkUHmE3AMs9Fc3rnLBz1i1moNku7AgwDdSs/jMsYw99PQimeAyYxfi1TwqvnkqXqFe7xdxocdtP1u/fkliBvIJY3R+g2YtCvqUAvimwWmero5eGDfifmbkpyuHhlvHMbZSw9uAx0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(41300700001)(44832011)(26005)(1076003)(36860700001)(5660300002)(2616005)(36756003)(47076005)(82310400005)(186003)(336012)(426003)(2906002)(86362001)(966005)(356005)(81166007)(8676002)(8936002)(40480700001)(82740400003)(478600001)(70586007)(70206006)(4326008)(54906003)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 10:59:53.7742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d08270-3676-4ee8-38c4-08db58582d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
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
changes for v3:
- Fixed compatible string issue.
- Modified ranges property description to maxItems.
- Modified address-cell property of interrupt-controller child node.
changes for v2:
- None
 .../bindings/pci/xlnx,xdma-host.yaml          | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
new file mode 100644
index 000000000000..ec46712c3e7b
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
+                interrupt-controller ;
+            };
+        };
+    };
-- 
2.25.1

