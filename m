Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52004D2E91
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 13:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiCIMBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 07:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiCIMBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 07:01:43 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A19A156C71;
        Wed,  9 Mar 2022 04:00:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQhgaTxuSEaQAfSA7Gq+JzLcr6+21Uuw5koM+wNQ1TnKN16sg+4/GvMnBSvdbx9llY7e0w34rYn7Pn1oOxaDqMsa4N+q/oZbk8eSK19bquVySOzJywxYo2RHAq2avEYOju8OCwvuAVgJKvLN5elumMR+oj8uGyCUbqXYbdDif6KuGbUg2Ua+HWAF9jafUOWzoC2FMADNww2DRZiqULcRy4g9KJG6eCmg5y8WzlFhD6m0xb69UB7Enfy+pzN+tzITyU9sugIos6PGIVrqMQTW2coeDeaemaaGwmfRixcGHIGTq5Ow6nH2m+R8jxZFALRovQO0jjyfDeeYTIfLYA2Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6PGwMhHGTUv8gV07Xsxe96nPY8UChtj67mIdpN7FeU=;
 b=bTimIxaF9+ORIL6TylhlDzBelN/kbET1RU6wn3ubB+6h8beyNKlZl+VyBhAf1/Fx+HfW1nj1vqwrK/aQuA/Xy5Yvd7KO0IfcYkzNiNjOzPIwJerrWLlTQYHrtFGFIF5Ll/ggLIEXRhOj3oWtcJyP5nCINq2sOGVSmfdISSdetOShiA5PYy2BFAFQhfLJg/q+u6ztse5GG0bXJep0yITIC/XtJ62UDqsPmfrWJk0g/9OV54UFZqr340eONQ7DfAJw6YJOlmjg4Tu4Lq17Ry6KI7AV4SY8h/GdKE9p8Xf5BtzXMcrDHW8+dsFa/Ypk9UWX4nXvx+vqnbrw2QxXdl4TSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6PGwMhHGTUv8gV07Xsxe96nPY8UChtj67mIdpN7FeU=;
 b=mR8zM914BwTxZOt1NKAoEF9oznfKVsidkjVUAiW3vssKGHDFANgkeDG13Y/5kr6m+ElZ2bnJgPlusdHuhWTv8M+ucVouQW6EyzOYXH5rsO0VH8iDZmp4nOW3qhW9SsXMKIOZXRe92JTcpJTT1fyLV5Kr+udXVBaOD6w/k4S9/nE=
Received: from SN6PR01CA0030.prod.exchangelabs.com (2603:10b6:805:b6::43) by
 MWHPR02MB2749.namprd02.prod.outlook.com (2603:10b6:300:106::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 12:00:39 +0000
Received: from SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::fe) by SN6PR01CA0030.outlook.office365.com
 (2603:10b6:805:b6::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 12:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0033.mail.protection.outlook.com (10.97.5.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 12:00:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Mar 2022 04:00:33 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Mar 2022 04:00:33 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=47618 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nRuzY-0008Ca-U8; Wed, 09 Mar 2022 04:00:33 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
Date:   Wed, 9 Mar 2022 17:30:24 +0530
Message-ID: <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
References: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 850acd52-4766-4026-a849-08da01c46dcd
X-MS-TrafficTypeDiagnostic: MWHPR02MB2749:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB27491EB80C5948CC5F460E6FA50A9@MWHPR02MB2749.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7KwEJ/PipIR1etSGgNk8fvCo+I8SRfiOfwN4pjAFvjvVFs6tuaF+gsSt5e6tOCLOtRGvJQT+2+kr2p7MDkfQ3rYNQbpssvpSNG357jrrBpOOOoBN3OuXUqV7M4YjrkIP1BZzG1vU9c5e+AkrRla5bWWFiRYqf4REn6W6oN9Q73VL6p03JPiV4fdtoiU/IpDMay9Z/nuwxdWXnoQHeQ3GD39pdFS4oNNW+wd24zAKkqIqInwwiyOEw98uS2Qhlj8W1/2JSlmkcLJgf3q+pjsclaG+I+fw2nbA2DLZ3YwtTLoPxMu5u+E2+Iq5+ELdz/o86yZ71Fhc8Jt1PQnpb4D9T8N+y+PL0E2J261F9B000SBACkUxetswI/NQN8smh8RlLptuXNXIBspM+JOvI5JmKGeFA2VaGPIkMTaM1tgaqslTg9Lam9sy7MONjSLoFYhuWyciksUl1m+JfP0ab+E2ZOAemC+I+1/5a/e7J6yEWiHhSns1tKObCYsNwh18XZiR8kA9CX0lYwwqsdSk+4mF7su1SM/myPmjtlBOzRXIid9H2PTcGCIlRIBWCVPdS0X5exFqzAkCXwoyxknVYaxmHgKWJQ+qno+zL3Zo5TBDzHHWcb34sqPjEFtbUmPWURb1uqkuvYdUEN32OJqcg0a402UZCdiVjGgcxEXQ1TCqxiU7OWjSblpOodRZC4SfaAydzSVcCSXn2rsaHCNgy5nxw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(2906002)(9786002)(316002)(110136005)(36756003)(426003)(508600001)(26005)(2616005)(1076003)(336012)(186003)(103116003)(7696005)(6666004)(36860700001)(7636003)(83380400001)(54906003)(40460700003)(107886003)(70586007)(70206006)(82310400004)(8676002)(4326008)(5660300002)(47076005)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:00:39.2821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850acd52-4766-4026-a849-08da01c46dcd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2749
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

