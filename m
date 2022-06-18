Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9448855021B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 04:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383924AbiFRCpO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 22:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiFRCpN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 22:45:13 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF86A00E;
        Fri, 17 Jun 2022 19:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqEpaFexy7aKm1ta7TMP+TVPxyxKeh8cT/ztst8K+PToBgVzBShZwJBiEVPF6/gm5tdUOcLtqSCS0MV7KLSsgKj+qVF07D/PsyRrE9OAmvtvTWffpA4/vCW8xtWhueYtn0xBBS+NddaRjd6OUIgatpA3XH3uST+CYkY9tlt7ziPSSCODuanF58UpOVrKaEWIKb80jikd5+lLUewkZYDit7akqLt541BGRkIXCdbfs4f9n3ovcYbtutTw/naOvHmKsB1YZEqSx631a/nnhVROhMC+Iv/WFFmRFFLT5YQZmYWcS0p9gml02PRDgDzxxA/RSGTBvKz/PLcumYggvyx7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhxl0OPRdYEJQYQizH7s9QG6W/seRQ29jt240nkZG1k=;
 b=CyLBI9hIgxk23/5uClHUBICy47+TAZrqatPW1i7uds8yVsbM1W4R+NL0C2puRhgpeHe4SfaAN7N+3BXVlUXL/uimrnMAR6m+Sfegeei3uQelWn07jaGf90PXUiIUP8LUqF11aI0BE2jtQiY3Rt9v3Zxoqg7T9OOYinFrK78+j4ZNMMSbStX5tHFrCB7YhSJrl4uoDNmxAnaItqYqIQOdRGOsBbblAMY9om8ahYK+vOX3RrW2SIUL3nnZf0aoPEB7gF9mLN74hRyjgDXyDLHGDWbBZ/XZFVyBkeed7P4vCxgmKpSzdQB8KU5iB5uDUBqQzqmj/TNMmnzIo12+drcOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhxl0OPRdYEJQYQizH7s9QG6W/seRQ29jt240nkZG1k=;
 b=pbxfz8KawTZLLzBhf9d6nKHr/BlpUzdURHN6DukbY4S71x+MKXnjlxM+sM2jKhw20sqoZNmfrJ/36eQ/yVrCVeUr9N29aOB5JjxgTBwVyKOwBoCkCZb2naYzTvnGLMWQjhLJAPoXeTAMy9NgI1D89iQ7krflK+ySMYqgeuttKRQ=
Received: from DM5PR12CA0020.namprd12.prod.outlook.com (2603:10b6:4:1::30) by
 BYAPR02MB4597.namprd02.prod.outlook.com (2603:10b6:a03:11::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Sat, 18 Jun 2022 02:45:10 +0000
Received: from DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::6b) by DM5PR12CA0020.outlook.office365.com
 (2603:10b6:4:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Sat, 18 Jun 2022 02:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT041.mail.protection.outlook.com (10.13.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Sat, 18 Jun 2022 02:45:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 19:45:07 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 19:45:07 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=44908 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o2OSQ-000FZO-Lj; Fri, 17 Jun 2022 19:45:07 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
Date:   Sat, 18 Jun 2022 08:14:58 +0530
Message-ID: <20220618024459.7554-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220618024459.7554-1-bharat.kumar.gogada@xilinx.com>
References: <20220618024459.7554-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf02fa32-c09a-4028-a34c-08da50d48fa0
X-MS-TrafficTypeDiagnostic: BYAPR02MB4597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB4597C37B7FF0E547C6BC0319A5AE9@BYAPR02MB4597.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyHcQSPIqldc7OuWie+iUVGueGVUSelhFhoAUtFX/1rrSA3aRkM49Oa5GQuuLL7vVDuFq9Mew1sUWuQOBQSvkD0wd/eQhEnSLRH9RFXAVfxGtps9y1uiXGHVbweq41eNnk/EygJXufMPT4rl1Ffm73oeHz/ZgH4bVl4cYmoZ0dkOc4fk6WuQMyey26JRRw0DYwhEkbZDVbjTVxh1+vAtV5+3O4a1cWngVsYgbeR+0t8JHK98n0N8MCVh+Kj1m1CCyi23dI6myhPgHag6OUMg5XxQY66iUzXXXF3QaBlIZeWT8is9BA+IXqe/RdcybH37FZFfhXsi5gR77ywt5gQ1PMFw2U+ciSbPmziDSWBbWXct4AagwaPpZB6Sd3Veo4K26OHqGwINeczJI+rhVPfZEH67vd5yeIe1GdspmnfTC4w6bmasaAhGBqG+mtSrcdecYF4X+Ce+VxU/CWenPYS3wmsnQpiggnRNku+pN0LGfTzNjUFJxPHvwSzm2ZOQtfhXkjrPHhZJ4ylZWc/f7NJnx440sDH/tqrr/OkuQdxGC33I4Dg7QZ5M9TU4JTSjf2kYF71qoZrrZ6Jtq+y5aVgwI3jbltgufesvI9nDmqf8hmtM66Zb/0MpDY0OWk9lvXl05/bWbbyd8BvE5qb+f7g6+WTEA4rGkFHh0SQ1m5N1dhHImwHtBC/dBP/z8vfsIP7klJgp3B0xrSkLR+Al5kATjg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(316002)(4326008)(6666004)(1076003)(7696005)(356005)(47076005)(107886003)(70206006)(7636003)(70586007)(2906002)(2616005)(36756003)(82310400005)(8676002)(54906003)(36860700001)(26005)(186003)(5660300002)(103116003)(110136005)(40460700003)(9786002)(498600001)(336012)(8936002)(426003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 02:45:09.8367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf02fa32-c09a-4028-a34c-08da50d48fa0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4597
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root Port
functionality at Gen5 speed.

Add support for YAML schemas documentation for Versal CPM5 Root Port driver.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index cca395317a4c..133a7a74e6ac 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -14,17 +14,23 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,versal-cpm-host-1.00
+      enum:
+        - xlnx,versal-cpm-host-1.00
+        - xlnx,versal-cpm5-host
 
   reg:
     items:
       - description: CPM system level control and status registers.
       - description: Configuration space region and bridge registers.
+      - description: CPM5 control and status registers.
+    minItems: 2
 
   reg-names:
     items:
       - const: cpm_slcr
       - const: cfg
+      - const: cpm_csr
+    minItems: 2
 
   interrupts:
     maxItems: 1
@@ -95,4 +101,34 @@ examples:
                                interrupt-controller;
                        };
                };
+
+               cpm5_pcie: pcie@fcdd0000 {
+                       compatible = "xlnx,versal-cpm5-host";
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
+
     };
-- 
2.17.1

