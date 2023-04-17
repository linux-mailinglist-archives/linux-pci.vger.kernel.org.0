Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5BD6E4553
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 12:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjDQKfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 06:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjDQKfi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 06:35:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8159FA;
        Mon, 17 Apr 2023 03:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QauwBQG+cSgWOpt7ewJz1lNo3lprMPfaIELCI3FABUA0kBC933tsDCng/S6nkgGeFmyaOuGWZh3Eq2jD0XfgKjdMFyxMpIZ6I6/juPMfKwnYCWMM/GuYOdVmKssXGo1pWDICi3Akk1H0SVmaN9wZ/IXYlAdwbrZvkPCa955mvVmnqqWfiR07VnnZ3zNdmqJzz0/jrklmy/uDSHyKKhqqvawBj/HssqlT9xzWZLTgkfiAF5VD+UWzClwu3QCp6Cvhn4d/o0sPpQh9Hu5dE8/07Y6h1taDOq8MpjWljo/MMsj+X15QQx8pVon6Ew/HdCgXSHi3TvzWMmRQRXHpnHjTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXwie4AD8UX9P/VoTR06cOzNZmWzj5NuRZFmcnEqNUk=;
 b=jUHVctvtqpjjuivUWCXbUG7MmwgO25i5Sb4OvYeRzLo33wrt/yFYSkDLD5yn6+PLfIGV7rbqPZC/5Zloi86kkMMeSwP2VJgX2qPUDxs0kTFtXQVHlphGr50ronYVZwgsD3woYxxwvzBtFssOFXwPVjgvRn4rZ5Lwn0FeX0DrINkEG9UVrDv9/RMKIe8gPBfRbaYAoN7ws0/G+SHuPYo+VxvFGoI8P5Bomu+ER/mwykJz5vtIP1/g/CmSj1XGLKD+rAd2rGXfNzeraEl+MA9071jxxmJ+3pg0IClQZpTqrS0+MM1mqJo5MDT6usmfGIg3FC72RFCGsndkObMlI0ccEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXwie4AD8UX9P/VoTR06cOzNZmWzj5NuRZFmcnEqNUk=;
 b=uniTRqOtSy+PXvWHzm0elNbJTZjdsysQzWMQFpargk0IubUk+vk4RiT7djUBF0x7KUC6hvvShYxHPDRWsBpjeAxF7c4tXQG+TwUUPlyO+3OfIP9951h5DBFI8/JN79NUPunJtm9QhB6yQguENCnCd34C4lQ5D+J8jKrDkupIK0w=
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 10:33:22 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::d3) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 10:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Mon, 17 Apr 2023 10:33:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 05:33:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 05:33:20 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 17 Apr 2023 05:33:17 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        <lorenzo.pieralisi@arm.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe Root Port Bridge
Date:   Mon, 17 Apr 2023 16:02:25 +0530
Message-ID: <20230417103226.334588-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417103226.334588-1-thippeswamy.havalige@amd.com>
References: <20230417103226.334588-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|SJ0PR12MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d92709-e68d-4d0f-e41e-08db3f2f2ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNFHZOJh0yBneqdstCtofIKd/TTxS9Hbk1IbRLOdvSOTei33/bcnXJt4NRJPmcWYo+XbarFsJHj9BkGgSafWxvxDzSJn23iQSNJXzJiUmtj4Ay5DPAhhPwWTM4Kg4QN+WdBHp37kTxQVP2u/VlsQT+VBeRV2c364gH/8DTPUubG8Ew8jCvZr6FC01HjidbnP7oz6w28h3nqpJsnypYZuuyhSVecaVvUtKWYgEz8gkr5yU94mbUzY6jTeQbw4SHTyitce26vgeWzloOpaQ/nrPkGzTZ5lib409xV7ACm0dwOZhL9pXG4iaGqsbFQPyHV7Nf/sPeo3ToBpAoa2FnQ09z9uXsAxNQ9rzpuN0EpOye9WtIMQLm01qoI9jiARCvXh0X0pNkcioUvvpro9YODunKp+9P38oylBipfVtb6wc6aIsnHjqTmbO0pB/h5jP9CjQDrTDqcoK59Z5NaS28alinH/1xfCK3DGvvpkgGszn/6P9qKkIMmq+Hha7HhXBII5gU4Yi0MvRAPjjfJiWkol90aIgWFPDZnFXZ9WMRM/iy1hg0h4ZtgJ2AqHcK3Z8dRJfQBOh+0m89nnGjfAUZextR9gP7rl8OGaKUFCqIcWqpgDLXIQkL+tFNmCNOy1pf+Xnop6daKGSvbM1CBV7Gh9ZZwCveNT1KZYAVegCJ/vUfQwT/y3bT4hPyYKpGvos/CHyfDlEiAA/I5lUKXjJBfwYsDCIaqwPEzF0EKt+uM0NuVtUXPdWt5icALpGNWs6smT/zdSl+cpkSjhNhqmh4qFgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(36756003)(86362001)(40480700001)(81166007)(356005)(82740400003)(82310400005)(40460700003)(478600001)(26005)(1076003)(6666004)(966005)(5660300002)(41300700001)(8936002)(316002)(4326008)(54906003)(2906002)(110136005)(8676002)(70206006)(70586007)(44832011)(47076005)(426003)(2616005)(336012)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 10:33:21.5295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d92709-e68d-4d0f-e41e-08db3f2f2ab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 .../bindings/pci/xlnx,xdma-host.yaml          | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
new file mode 100644
index 000000000000..e3a1ef1a47d6
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
2.25.1

