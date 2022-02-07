Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ACA4AB478
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 07:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiBGGPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 01:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351301AbiBGENN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 23:13:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC05C061A73;
        Sun,  6 Feb 2022 20:13:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UShHMPvW3tONAENKVom0tmxK10DyF7cgM6/VgVtKH0A5/cJxrgDNX9PvG5f2LpDy+AaEzqHtR6bfHDWZvhIGwTaJxTR1akGbwtfe8pLr6FqWhG6Ob5RHF1Mi+sFL8u4eD25kTqgSZ7BQ61WrJnzUbxz4caHPbnpwlgaQdDBnDHH0HjLCN21BOkyaYntGy4Ez1isXjbZr7NlydWwv85omFISdMfOIyWwNxB1XZFp9AitIVS2+/+I8rurieH5OroRuywwZjSIyB3BfNybMo9EjDuV8X2sZf+DkOTWdo7WMmd6jZwdphuiJgZnz/KaEQjwaaA1cgBAmMCB+Ps/J6f0GMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdJI5ur0mYlyE8KZosw09tYlAKu4OjZBFoQ1x1k1vsw=;
 b=ObFvaF5RZqwcoKMkwUsoq3JGH/cTi6fNjLurqNw/2uoOK8ST84xoZyqTQX+72dcKYwFmfkRYZurRnXzTWiThDI5ARVjcFK7EuSf2SEDg1TGMGf3suqyAdgAZJMEmoTtbHg3INYF2n7uZr3L8HcXUhqBGobFu16JWCQmHngReFs3MJdXueFCat8ZQuWldiUZfDcAE51FfmYMA/BCHHnNq+mEfkBjulLKuaEfjF5Epm2BfF66wvZ0d00Ry/f9eeflZan27LHI1/Xzi+3zVrEuzUKF+gcsZi8Yt+o2eG8yxq2NQacSXfpwElHMw5TUYbZ8iVuJVRZVEu0BkMDQqHJC5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdJI5ur0mYlyE8KZosw09tYlAKu4OjZBFoQ1x1k1vsw=;
 b=pqTCPVcqpun/CNAS55OxkiQa5Uy2kJaI/BR+tSEV0TAOxqJBgmaQgXCEZbvQQQJJzwQue5DD7vOhFMoaSTyJQilXo2wAkRZ0Dm6ZemwTMTn99dDc2gjIwePluPrfW8YfwEghPGz8si8pxYcAnkQYoqyxdv6CvldhUSRx+l4zgDs=
Received: from DM5PR15CA0027.namprd15.prod.outlook.com (2603:10b6:4:4b::13) by
 CO1PR02MB8348.namprd02.prod.outlook.com (2603:10b6:303:163::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.11; Mon, 7 Feb 2022 04:13:11 +0000
Received: from DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::9e) by DM5PR15CA0027.outlook.office365.com
 (2603:10b6:4:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 04:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT009.mail.protection.outlook.com (10.13.5.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 04:13:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 6 Feb 2022 20:13:04 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 6 Feb 2022 20:13:04 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=45184 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nGvOi-0005Nx-GD; Sun, 06 Feb 2022 20:13:04 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/2] PCI: xilinx-cpm: Update YAML schemas for Versal CPM5 Root Port
Date:   Mon, 7 Feb 2022 09:42:49 +0530
Message-ID: <20220207041250.1658-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
References: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a498fce6-d1b9-4c01-5ae1-08d9e9f0270d
X-MS-TrafficTypeDiagnostic: CO1PR02MB8348:EE_
X-Microsoft-Antispam-PRVS: <CO1PR02MB834867899012D9679CA0380EA52C9@CO1PR02MB8348.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Wl8MV5NAhm0bjZfIy57Fv9q7D8laRWT19/EYyCBfstNsm+HAz8sDDA9oS3RHXJ9qyyL7uZKAwcnYbUElvFhyF5DwPiSkLfwDgBaBrZXos54PcZwYlhZ5kHTIcLBeysd31I1kP9KsYs0ngznZe6h7C+m2trbiH5Rds9AkSFhhAxSe8sq97+7RxY6ND1PP5+MY6QukzXmW2TvV8v3sR7Mh4Q+spfJSDUiN9xPrMPorIz2FsdyGyOkPOJzOQZqWlc+MzkTgD2/T8oyyXXbdjmbSwYh9G2cvgpPm90wxvXfT6gtG7vmDkvl4qjRP3sBlPermdgbSCDc7/vVAyLZ796mUv6w6jL5O5zHVqM44H5uJyu+5QKJisRmZAsDkFDlQKsAoi+dBwF/krBLZC7+QfNXqHCG+JfhqJP4xlL/80bWIkldMqHZo9j4Y0GD5kcrUbkgClV5aj07N/6bVaxSdAvwdnvgySEl0znsVva+XYVYvU/UcshxqZcOSIuETfFAn8MGRESwK1/p3m8EHxpdc6YuRsxjrZ+E1kMH1xPyxRkNy6AfoCN2cbNxvpBrsCM3+FPG4lE64ePP2JXUi0cBQ8ZhRmUJtLvZRDl2YnuyOpyr1ZMALaHoamg9eWxsPxRMTbEsAb5y0dJKem4OEP0jmIKxJ5sJ4fVghTme/Vf+6I5CpFQueB6lddYQOvWC4OZKH3lB
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(54906003)(4326008)(186003)(1076003)(26005)(110136005)(336012)(82310400004)(426003)(7636003)(9786002)(356005)(70586007)(8676002)(8936002)(7696005)(316002)(2616005)(103116003)(5660300002)(107886003)(6666004)(2906002)(83380400001)(70206006)(47076005)(36860700001)(508600001)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 04:13:10.5307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a498fce6-d1b9-4c01-5ae1-08d9e9f0270d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8348
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

