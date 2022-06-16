Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8054E0FC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiFPMoq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFPMop (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 08:44:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE69DFC4;
        Thu, 16 Jun 2022 05:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvA2ztVjL8x2wSZFHDiwlU75mQouISmd+lKxTMODjLX2mwLOL486V++vfvZ7Iug7qQtc+2WEsFVCjKNwcmJ+YwHX7/LF+5/3C0Qxoyvq0YCFfYDNYkEGbLGyuyYWYAcwWRu8HQNONNJXsqoxFBCuxchn9iN4reDpO+HMgM2fKdzPLGA1xwuttEn/2p1KrTvzIB7u3CmkjihA2A81kFi7DHfENNIIoqAN8So09w/XC8FinWaCfWE2WGFtWpbNMuWamsgupXrXTrjwa7reqdHQk30DxPq94mQwdJWI492gRTg7Q3VXjca3k/EzvIitWmHJwe8Z3MO3jxE1vH9QgYLB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98A8jtRpT1SVHSfirIZF3dnOSoEZWQ2ovgiPp2lg+78=;
 b=gh/nXHa9/3TZ84xFKW8sedR1wpmd8uKA1P9vMHcUS/AjUtVGt+rNlGPeZNcuAcE85biDWgCZqRAOSOHqcuR2+9+eB+R8HalyLOC1dSKtSPfdDlyI8OO5ikDTcbfrswdhT3V9duTZg80ALcPUfJpw8GgbzytGI6R12D0qPhdxjrsjgW9KLLuIFsZeBCnLCDeEIdsR8dj4bxWUPFuU3QoeoKhoLXiukZYlDQZL+d1IJRaFUcj0mhw9JVfLo+MZfIo+pVj3AH2OSObIfr4NFdthVeWn7ZOrzX5Uj+LtNq4iXEOVelMoLvx5nJCqYAz7BeAHhNxbl2Zbnyh8C02iyTtQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98A8jtRpT1SVHSfirIZF3dnOSoEZWQ2ovgiPp2lg+78=;
 b=l1hLMk4mRjlj4uedqDdjM1duuyROA+ylAgPm339HoPsxnhWWbHbyPq+tDYFDgckKiMchEIbK7qiR5j/gDjUPOQLyg2uw0ZpJ7i5Xr4SX6VXPoWrHPFCiWYGZ90loivmOGhHvrBEKSfsxyhE7D3BeyNhMozojuMn1ZfXMjuInuTk=
Received: from DS7PR05CA0089.namprd05.prod.outlook.com (2603:10b6:8:56::6) by
 BL3PR02MB8147.namprd02.prod.outlook.com (2603:10b6:208:35e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Thu, 16 Jun
 2022 12:44:42 +0000
Received: from DM3NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::2b) by DS7PR05CA0089.outlook.office365.com
 (2603:10b6:8:56::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9 via Frontend
 Transport; Thu, 16 Jun 2022 12:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT013.mail.protection.outlook.com (10.13.5.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 12:44:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Jun 2022 05:44:38 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 16 Jun 2022 05:44:38 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=44392 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o1orV-000Aiu-Hd; Thu, 16 Jun 2022 05:44:37 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
Date:   Thu, 16 Jun 2022 18:14:28 +0530
Message-ID: <20220616124429.12917-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220616124429.12917-1-bharat.kumar.gogada@xilinx.com>
References: <20220616124429.12917-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa37eab7-d892-436c-caa5-08da4f95fbe3
X-MS-TrafficTypeDiagnostic: BL3PR02MB8147:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB8147576E1373A58BCFC6A957A5AC9@BL3PR02MB8147.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yROrGB46p5XN20qs6HnosahfqzbcdoxvwG8SGiWsm4EBo/ToJhy4znvPvGaMjF06pot89YwUCMkK3/sjf+jLHIAICW3aAEr+o95wQGilaKQM11D9PcRuyaZ4Nv5FRPSO9Xjevr41yV+5lkvZyeppZlhNb8d8PRt80/qkpzpchYXccZR0q/Cd7S9GreXaRKvz1vH2qOpwnGSfjyx4XfWppX45Tq865C+fTBrd60sxlHT/fbQEcCWStjIy/q1Njb04fSAuk5/dcjSAXI19Gcrffjbd4tcIP428HYEHCgXIKlsNhEAP+94ztnsg+E+jH8Z9+XQDC8jbg68Rb1+RQQ0P2HHyYJYV4gjNTmY3WX9qGnvtPMOH26ve3J5d2HYqCjPj24zRes+iJvIT3J5aN4v3+nT/rMLJvDsUT36U71k1ttVICNGyAFYhPIFZUwDffnjiCTd9L9ADIxJZ+fjcPbBOLNWevGQGrUjmQCJlB8kqcktWwMHqbqxpAqrRHjXIj0eedATL6vMWd34sS/f2smAwkBLlpGptAu3HzI9/bYNwGdJBr69taWZ9oz3JshqVfbl4x3d0ISpkJqBdAngay66cCNs6QsuyOF4fG3w75i0q63huziBt/Y+CQAiLJACmf6+RpFznBJRAaFXI/TLg5CL/sX5dufyp1mFjKNuMOQS35wwrhHBlBILZn7fcK5utglqjUrM6hA7OhAi0RAODy7ZGtQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(2906002)(36860700001)(186003)(83380400001)(426003)(47076005)(336012)(1076003)(316002)(6666004)(498600001)(54906003)(110136005)(26005)(8676002)(70586007)(4326008)(7696005)(9786002)(70206006)(356005)(107886003)(103116003)(40460700003)(7636003)(36756003)(82310400005)(8936002)(2616005)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 12:44:42.0140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa37eab7-d892-436c-caa5-08da4f95fbe3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8147
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
 .../bindings/pci/xilinx-versal-cpm.yaml       | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index cca395317a4c..80597f2974e5 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -14,17 +14,27 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,versal-cpm-host-1.00
+    contains:
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
-    items:
-      - const: cpm_slcr
-      - const: cfg
+    oneOf:
+      - items:
+          - const: cpm_slcr
+          - const: cfg
+      - items:
+          - const: cpm_slcr
+          - const: cfg
+          - const: cpm_csr
 
   interrupts:
     maxItems: 1
@@ -95,4 +105,34 @@ examples:
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

