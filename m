Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AAD4AB47B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 07:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbiBGGPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 01:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351276AbiBGENI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 23:13:08 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24463C043180;
        Sun,  6 Feb 2022 20:13:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evPlkVCnWu6fvxRQacVbZ7oHD7wLy+qRtTay7LR7leFAwewTUr07/PKEQTcbHmG8o8w2xOrtqSIY57DkC6OSSQHBPL7VejGErFHm2cSMgpUfRYsgjTIyOlr8lXCOkjy5pZnN8zPT6HE7C62AIztI2AbUGa/12iPGvUvUvOBS5x6uwOJrWcXySZyjmPXxK+Mql+e+Ncd5YsCPoAT02JnnBmE4pCzc0midI2f9iUWIxejmliG/IBGuTD7SsL3PEJx1Dcm3T1yvSA3fXaYxdUhXAZs5DQsyt888UfGjuUatSKPEgAf4s3iarYOlVH1yeZiKiBkpAa+yeNpwAbFjBRj9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdJI5ur0mYlyE8KZosw09tYlAKu4OjZBFoQ1x1k1vsw=;
 b=dltrw1A8tb3UaE22AVWENkwK48yzGzAjeN5YszqrovPNpuPhpNwV+9fEuEY8aqLKBo/+5opFDyGz4+ZZ6VKCiBMTyEDCv1d1TCiRuVLBm3N8L01AaxLeq8JrJPawCyjiKra0mLwvICcgiwfcGNhqCYItqOfHkYjkOPo9sFEWopjl27cyymIvCYkWFId0eu+GH8ORnkqQSrTRTVMzm19k7zblDzdK+NzsuF1GCxQJljhKxREU5yaiOd7p8aqa2fcaZxMV4w4j1KcuqFTydOVpQXmfeT097P2cFPCVgZfH4T5/l/cejIQOt0mo//GgfWUcEicNt+bhhMJFyo1SiPb7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdJI5ur0mYlyE8KZosw09tYlAKu4OjZBFoQ1x1k1vsw=;
 b=koOu0Ta2RXDRpGNqlVZdGp/TTpK6cuV8xH5JkxWqGExI1nYU2uq2BFSFpvRvAtozcNc01IbWfvzuiGD3iybMF25ciAuYAZXzHwdAdVBTsSL2GN7R8+cKd2M+LMZ61AvASxreyKm/UYD2gc6kgWirPNSjmTuEI08k232+QOO2ZpM=
Received: from DM5PR15CA0041.namprd15.prod.outlook.com (2603:10b6:4:4b::27) by
 BY5PR02MB6404.namprd02.prod.outlook.com (2603:10b6:a03:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 04:13:04 +0000
Received: from DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::7c) by DM5PR15CA0041.outlook.office365.com
 (2603:10b6:4:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 04:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT009.mail.protection.outlook.com (10.13.5.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 04:13:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 6 Feb 2022 20:13:01 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 6 Feb 2022 20:13:01 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=45184 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nGvOe-0005Nx-TP; Sun, 06 Feb 2022 20:13:01 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/2] PCI: xilinx-cpm: Update YAML schemas for Versal CPM5 Root Port
Date:   Mon, 7 Feb 2022 09:42:48 +0530
Message-ID: <20220207041250.1658-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
References: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b3879f3-9328-4956-3e8b-08d9e9f0232b
X-MS-TrafficTypeDiagnostic: BY5PR02MB6404:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB64046FCE36775A591AA215B5A52C9@BY5PR02MB6404.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGfy8LXPGa4D6Zbo6KE6qd3fVNZKgPHhfbUtMxOJ5ioDpp1rKLErS4hTHIFvGJlljgcyWceFgDnN0vgQPISgXP70T+DmlD723IzSHQAvOz0pOHa+X04PTjlbllSqUVniUYjgeirE0Qyz8qbu8ATtuq61B7yKgF5sWOMUB70ycmrqKKcWZ9f4GEgSkK3W2rnlsEb/S2UJ6Tk2J1L1VWhhou1gtqoPMWfZnJOJgX+cWseh5TLOFibAuchLJSgZL0Upl6d3KyNeBrobp4VkwgHS0UNASzVjDN49xn9qeh7p1n2uF37llThcFalaL7ChnRXDrFE+BnZrTpZJSOpAAzPwADGp4cY93yiFpJxPfhIwfgLLegGw0sil2bN7P3qI3vu5Uo8OK3rMwHnUwG9wT9dD0KV26byDzfqdODTBlgjo1AWV5+6ccvs7iCDTaYG1l7TDqT2x1GeBegebYRI+Lz7R8vZoL38Yh+iW57uF45enM4RIuURFRRz3idrLrtzK+8uucHovxwhiNhtQgxHd2qDnoa/qawZaO/ps580vYqabipPa3vsD4F5AFppowYv43l/vAzh0Od5emfrRTssOKAfV4mtRp8ICL4vMzS5n7AM3eklUkUm77Cj68AUtBV54tzUd9r3w7xluFaiT2Yi/lSVG2uG0tbemNam/5LU5p8ydFMMlUiqDCga1yZNE0PESsc0v
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(103116003)(107886003)(2906002)(508600001)(26005)(186003)(1076003)(336012)(426003)(6666004)(2616005)(7696005)(82310400004)(47076005)(316002)(70586007)(70206006)(36860700001)(8936002)(36756003)(9786002)(83380400001)(5660300002)(54906003)(110136005)(4326008)(8676002)(7636003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 04:13:04.0314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3879f3-9328-4956-3e8b-08d9e9f0232b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6404
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root port
functioning at Gen5 speed.
Add support for YAML schemas documentation for Versal CPM5 Root Port driver.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 32f4641085bc..97c7229d7f91 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -14,17 +14,21 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,versal-cpm-host-1.00
+    contains:
+      enum:
+        - xlnx,versal-cpm-host-1.00
+        - xlnx,versal-cpm5-host-1.00
 
   reg:
-    items:
-      - description: Configuration space region and bridge registers.
-      - description: CPM system level control and status registers.
+    description: |
+      Should contain cpm_slcr, cfg registers location and length.
+      For xlnx,versal-cpm5-host-1.00, it should also contain cpm_csr.
+    minItems: 2
+    maxItems: 3
 
   reg-names:
-    items:
-      - const: cfg
-      - const: cpm_slcr
+    minItems: 2
+    maxItems: 3
 
   interrupts:
     maxItems: 1
@@ -95,4 +99,33 @@ examples:
                                interrupt-controller;
                        };
                };
+
+              cpm5_pcie: pcie@fcdd0000 {
+                       compatible = "xlnx,versal-cpm5-host-1.00";
+                       device_type = "pci";
+                       #address-cells = <3>;
+                       #interrupt-cells = <1>;
+                       #size-cells = <2>;
+                       interrupts = <0 72 4>;
+                       interrupt-parent = <&gic>;
+                       interrupt-map-mask = <0 0 0 7>;
+                       interrupt-map = <0 0 0 1 &pcie_intc_1 0>,
+                                       <0 0 0 2 &pcie_intc_1 1>,
+                                       <0 0 0 3 &pcie_intc_1 2>,
+                                       <0 0 0 4 &pcie_intc_1 3>;
+                       bus-range = <0x00 0xff>;
+                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
+                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
+                       msi-map = <0x0 &its_gic 0x0 0x10000>;
+                       reg = <0x00 0xfcdd0000 0x00 0x1000>,
+                             <0x06 0x00000000 0x00 0x1000000>,
+                             <0x00 0xfce20000 0x00 0x1000000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
+
+                       pcie_intc_1: interrupt-controller {
+                               #address-cells = <0>;
+                               #interrupt-cells = <1>;
+                               interrupt-controller;
+                       };
+               };
     };
-- 
2.17.1

