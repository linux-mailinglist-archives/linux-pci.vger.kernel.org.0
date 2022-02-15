Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C399F4B6C94
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 13:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiBOMqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 07:46:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiBOMqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 07:46:30 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49816140F0;
        Tue, 15 Feb 2022 04:46:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRYKB58wDYy8nAhQ+sfmRifTE+FP+iBrWdyhu8ezh9kDVzGVVEQflu9HpsBCI9o1pyxpwb615/5pZOodnuaddbIqzJ8PPc2TUTxf0ODwF4URDobBeDFMZt/kkO/aiNXtbrL9UnupxDcpsJNCGYkSc8/hcWFYN7q6f+C8Aj7i1xuc8buiNMughAFY4RaDFm1+MVohPN9d5qKuSBfa0LsaF+YYM/1zlNGC0tzlmgagSkyBhcVChVC8RFXhpXXsfTHbQeoTb0qE8bYELISSE2hcqzSVDDFujBAoO0UXO0HXqirOlTL2lq4N8jVDCXnzSmxaJSuSCR/XNjwtf766/VHwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6PGwMhHGTUv8gV07Xsxe96nPY8UChtj67mIdpN7FeU=;
 b=VLTNPwSPqMPBuZO3X45nngXpMd9Gtx6bH6EQoS4/UJ0RYFhQ0PaptnMgyfB5+nWNwiqWwvWNhFiiQq1KzkY9MvFJlWhf/Nt2L0mPpdjJHSuEzTgFCOASGJzH9khoadH0Et9/sjXyB6rN2Zd8QOPMW9k+GAFJYELqElzjHGVmdgAGWZnUm/yXvoq6L4JvWCviA+iNFli0jZpoJbJ0cSPOBGHfnBlPLPfUvRqj39E+tqbN74x7ZRcKrRXqfnpZ7pzFh/o1UlQ63BBSpA94yWrRCHJVHaI2n2+mZbd/mIXqeGfCU+tMbvhGnVPWg7TZ/ajM+ZYDAJvaU2LpK8KvJ4CIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6PGwMhHGTUv8gV07Xsxe96nPY8UChtj67mIdpN7FeU=;
 b=DUIGBc7HLHMYjpXYYx4auui6B7+sBJmQMkdVAwmRuBgKURuCtgrKjW4kI5ja+LEclub90ylG6EkvAYNyBeW7/MlDNrIYLcMFF5dj4NpI7Oou4UkOXtLzOWFjCRBV1flkXFIN7+EN4NLa3/o+DfvRJ5WhKGiOdZdXvYszVZ5JUy8=
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by MN2PR02MB5821.namprd02.prod.outlook.com (2603:10b6:208:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 12:46:16 +0000
Received: from BN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::75) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Tue, 15 Feb 2022 12:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT018.mail.protection.outlook.com (10.13.3.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 12:46:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 15 Feb 2022 04:46:15 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 15 Feb 2022 04:46:15 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=50434 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nJxDi-000EtN-Oe; Tue, 15 Feb 2022 04:46:15 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
Date:   Tue, 15 Feb 2022 18:16:05 +0530
Message-ID: <20220215124606.28627-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
References: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36193b96-7ccb-4c9d-694c-08d9f08127ea
X-MS-TrafficTypeDiagnostic: MN2PR02MB5821:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB582143623B60CD86C72C4487A5349@MN2PR02MB5821.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vfF6zxStKDTStCnwtdafSgWFzRPZ7mDaDM6+lQbGWkICugtOZMDpg/nVBAhvAsrJ51iEM2UJsZEcPp7SRnUjLqg3Y/BsiqcXV2IPiLGZng96Ytt22srlXDGJjLzyBdqi+0l3E0kQWMXkQc20Q9BRk8x3l4hz5fIjEmSXyVAPwCUTYjRn9lhFAlAQ3roQCsShmMSyyEeRPXj0NLo3AC0vtFCKcInwbkIo49DfNUncRf6tW+vXMkVUQL/ImNKhjMMln1W6G2W+XgRok/eP48AuD4z4KKiHu2i2szBtxXABTcd8IqKKz+16lEx5ZXTSN0t1k9B3vIyuxhz+0/0jK4fhUozcQCVdvmAp/55tuTyTYt0LXB22oXRGDznHHJlmj5oqR0tRhwSUIKvZ0WQHi96Qt/Oiv72BB2IPEgqiPIez65rFD+bDRpbvQcrSs1OL1WYQd2hnOuifiMsmuua6KrPPheA5RU7TzfxcGaORN9WzvrM/JcQLyHr2TW/ChMeL6AaA4ccB5OhrplxPdi5hvRxSPDRcoMYpgM4TJNMv1hGseGRQCv6p+j3nUK0LHq4fJlT+aAyjNMAPNyz5xP3VolvnmmZcm4bHlyfZlJUudRVtkeEdixBafZ1FIMFbsgLe2G9JBvQDKJRQPGEkh+gFDsrFJm9sAOqEUrsxRFhZxR4p7NEFoLePy2/xutOUF9l1AXaO2TotmNsIeiw6W9doAK31Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(186003)(7636003)(356005)(9786002)(36756003)(8936002)(36860700001)(40460700003)(103116003)(47076005)(5660300002)(70586007)(2616005)(7696005)(6666004)(107886003)(426003)(70206006)(8676002)(336012)(83380400001)(1076003)(26005)(82310400004)(316002)(54906003)(110136005)(4326008)(508600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 12:46:15.9350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36193b96-7ccb-4c9d-694c-08d9f08127ea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5821
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root Port
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

