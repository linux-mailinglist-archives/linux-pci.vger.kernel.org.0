Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF95009AB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbiDNJZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbiDNJZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 05:25:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96896EC71;
        Thu, 14 Apr 2022 02:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtrPFAaPIGRnJ7HXkh1ezmzHLxjGIO4DxGK1CzJG4siE/TrhNV2jJP8MylDh3dj0kmx25jpp/VyzYbY9xi0/C3dhgdVKcpgU0zgRF5bMcouptV1p9PTWRaL+/kci+zgrHFCDtu3/8qR9yT4hQc99um7AnfQYNDMAi8JlMHYroRaddz5d3k4zRJFjs9TpUuN6CszAKsChZ/poOW9LblwM8SDwEBLtJ3Bu/g+2POLZaMsXh9UM9v5JMU/t66dWu7p/1Jh8gpmthWbxWnaG+MsCpFxtR+jFzWjavFea4ccEF/MRSThfvIu22xlRtuKaZi4iPfa/gNNvIhIN2qnxZU+Qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z6AsS4oK/LQJhpZLMtqPdqAZn51YGn/cbV5LB61NJY=;
 b=erX/na49zv8HViApyPjSSRVbLbJ9MzX2s3KX66WnEd6xUn0bVEJrJ9YV/n4DnYSR915CWhCRmSzT7nAaD6dtroB7wjOn+J1Q9n0r7hASQ6LNOgeDoFlvzxqnK4bNMW4x17yAgE1GcC10QPCcIrx4+KZbZH09VeBy99/gtiwM+LDp3sU+inqlKjFgRdelSVhXgE3H8SfDyrkZlBbYkgzESXZxITobr60m1u3IbsGJgV0HDGgfTLOFMNpyEyfSY+KrOLPWSkjgPLm0mAO8aje+ZS7IXHVPT9nV2DTO1BaQMRDxrva8r89NdsqJvV/l+3BhU1ttf/o87Ujzgx7JQGqABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z6AsS4oK/LQJhpZLMtqPdqAZn51YGn/cbV5LB61NJY=;
 b=kTEeNg0n4yRkUbzv2j3vB46JlKbNU7lJ9rnrhlJr8oHhvMhfAtcueO5Tkl1ynepyNztNOhwlNR/lzb7EfzBct0x3YMVhNQCv+QLKlUQ+ccG3MBZdKugoCUqs/cdKCJdqs5SHoBG3cnkpLdFL4acSPyAxNOjBswA2R0YfweeoQ+k=
Received: from SN7PR04CA0197.namprd04.prod.outlook.com (2603:10b6:806:126::22)
 by PH0PR02MB7126.namprd02.prod.outlook.com (2603:10b6:510:13::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 09:23:11 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:126:cafe::44) by SN7PR04CA0197.outlook.office365.com
 (2603:10b6:806:126::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 09:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 09:23:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Apr 2022 02:23:10 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Apr 2022 02:23:10 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=38782 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nevgz-0008Tv-L2; Thu, 14 Apr 2022 02:23:10 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v1 3/3] dt-bindings: PCI: xilinx-cpm: Change reg property order
Date:   Thu, 14 Apr 2022 14:52:52 +0530
Message-ID: <20220414092252.12174-4-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
References: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df315099-f6e2-4af9-0580-08da1df86560
X-MS-TrafficTypeDiagnostic: PH0PR02MB7126:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB7126903A3C7557CD7ED96D98A5EF9@PH0PR02MB7126.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MupmPpmc1fjW71HO34W0ZTAbetOYcmMGbMaJnZcitfPRt5wn+DvFZeIy1cT9O/PbORa5bTpF1ZI6QV4j9Xo6Wz7zfmyi/TBRl4SGX4snuSWc2+hGMDdzKvuSQktqKvDugpX7sOav6u8mJ8B/5tIAvgJIyDLBB2KLYagvv5IeBXWhFX97KQiIk4vv2HGxZhuHf/urt3MS9Fslp1LkZ7xjeDay9BGGQraFVY+iyOoilTF+8fxfgsvieX/7zttG8aCT1kWdj6RSEZ0V3R6eNeAPgP36VJ/Jlh+ESL0r+sStH98gCz9gYtWsuaK64knfs7y+2IK5eYftBpCFpGctwHBOvMWfmLP0rpmjaiFmpFTuZG8BucGKVCJQrkq1du86gzDiEDd2gVxQ71ys0I/Tgm3aO5TZUbuFCUfdQHnZb1+vDueakFMLZBRTpa/ZUrXVZlEr0uNoWzuIggD0prSkzku15BHFrps+g1pOVkL9MNJikVLlkmJeF1HJx8DPJiU+laWxRsxzGRdsiZa2wD0gRf/e58wgKSfN0d2DtOkmT9Bfy8FM0OT1PFqyDabSIrYEjQWtRW+E5PufWHMBfhzeyfdwfVUHAdgh6PNEBeJYOVosW8NYWEuzF4gE2hGsjfGv03eSRzR9MCN2N/zmxEn8DvYAiSHY4xs6esZm3f6+KMnrMLhq1hopBkFqhz6IVQovtJmuVpHYoqbGxFVRu+kLYilG2A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(110136005)(83380400001)(54906003)(4326008)(8676002)(336012)(426003)(47076005)(1076003)(5660300002)(70206006)(508600001)(82310400005)(70586007)(6666004)(36860700001)(7696005)(2906002)(2616005)(107886003)(40460700003)(103116003)(356005)(7636003)(9786002)(8936002)(26005)(186003)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 09:23:11.5451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df315099-f6e2-4af9-0580-08da1df86560
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7126
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Describe cpm reg property name before cfg reg property to align with
node name.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 4ebcc838a1f6..a3bc6ed9cf95 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -18,13 +18,13 @@ properties:
 
   reg:
     items:
-      - description: Configuration space region and bridge registers.
       - description: CPM system level control and status registers.
+      - description: Configuration space region and bridge registers.
 
   reg-names:
     items:
-      - const: cfg
       - const: cpm_slcr
+      - const: cfg
 
   interrupts:
     maxItems: 1
@@ -86,9 +86,9 @@ examples:
                        ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
                                 <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
                        msi-map = <0x0 &its_gic 0x0 0x10000>;
-                       reg = <0x6 0x00000000 0x0 0x10000000>,
-                             <0x0 0xfca10000 0x0 0x1000>;
-                       reg-names = "cfg", "cpm_slcr";
+                       reg = <0x0 0xfca10000 0x0 0x1000>,
+                             <0x6 0x00000000 0x0 0x10000000>;
+                       reg-names = "cpm_slcr", "cfg";
                        pcie_intc_0: interrupt-controller {
                                #address-cells = <0>;
                                #interrupt-cells = <1>;
-- 
2.17.1

