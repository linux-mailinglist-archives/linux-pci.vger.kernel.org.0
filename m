Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC154393B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245631AbiFHQlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 12:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbiFHQlV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 12:41:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92CBCAA;
        Wed,  8 Jun 2022 09:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T55oz9sM8lZkmimXwlCb13hL7Djdya/U8IaFkFvXjUxlCkmnAvLck5yv9bJ+vmr5duZOVX8kDZqQv8f1i4p1UdtO776AgBmH7Ks55mMIILhfhpt1i8OglNhtCTk4GaMkDayr3jw7vte0iuJaBUiLLrNgyd8/KVudKXr5xWntr0wgl4BecBkrYRZzpMEO1EWY65ZxrMlRYwxkZWiI37m0usyeUoSw8AucLDWL9QGkkuwQ/3rG9+DHmDLzcV7lW849PISECTAYxTbPzPqS9GXYiTNifAIUF04cnrVO4K+3z5CRvt9U1cpVYj7GKc4bkHD8fkl/Bs0HvqOHHo9021lmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98A8jtRpT1SVHSfirIZF3dnOSoEZWQ2ovgiPp2lg+78=;
 b=SjtgK6QErEjy7+REnK87njhYrBNEdIbMG9eT59rsVjR2CgLwGjxsboPhXp4zFhAE7SvwP5k4nh/TGweTEV/XZrC71+bIYEuIMdjQ7uD6AViB31S6Xix+SV2o8AxhQLjf3QnYURlT7moKti0OFf7c96wxj/PjKyAhBD58075poMpGAlQcaJmWnwFi06wxJGNEGuaRvCfuCgW5XykTX+ufMun/dFfFcHehDXLrxCTwbfQ/z402mU0vRAliPq3G+C0gY21YF7KVZ1FVgf8Us8x4hayjL8nShO1XyMeDAEM7eTAEFR/CzLtZVTWfW/FHkgv+58kTP2ZwQ1dgAHi8EP50lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98A8jtRpT1SVHSfirIZF3dnOSoEZWQ2ovgiPp2lg+78=;
 b=XrbNEfY81M467eQSQkVr5ijMPvd4ZifRo81RGPxOx1PpAN86r8rR0pe+WS30uiYGJF2qJOSqB6rNfVoosY91mHAeY/fD/AatmTWZyNcJH5qkLA36NLY+qE82QzsB1TWWPYpboUW/Qy3WHUpqJy6GD5QsgE7Kuya/mMTWtSCKkXo=
Received: from SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::33)
 by SJ0PR02MB8354.namprd02.prod.outlook.com (2603:10b6:a03:3e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 16:41:18 +0000
Received: from SN1NAM02FT0032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:26:cafe::9b) by SA9P223CA0028.outlook.office365.com
 (2603:10b6:806:26::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 8 Jun 2022 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0032.mail.protection.outlook.com (10.97.5.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 16:41:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Jun 2022 09:41:17 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Jun 2022 09:41:17 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=41368 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nyyk9-00016D-4L; Wed, 08 Jun 2022 09:41:17 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
Date:   Wed, 8 Jun 2022 22:10:45 +0530
Message-ID: <20220608164046.3474-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220608164046.3474-1-bharat.kumar.gogada@xilinx.com>
References: <20220608164046.3474-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 762d2d11-0557-43fc-30bf-08da496db5fa
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8354:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8354F306B8982172DF9BD15FA5A49@SJ0PR02MB8354.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3D9U2d86Sl6LmbUrYyVCk47TDzaFeFF+ytHNPkzGkuyxbfuwaqet7NHp/ygbWSPR+SGXwUIU8sX8YZkuWgnHaTpCUXAC2RBJ+nI/eQwYNBoJPX9IgeYdMRl4yIRcPwkV5S60hnRyny1ivs7drkAR2QaiBQnzJnr151Spy0wC89jD0ARRkJa/B5zcNriHz/mLwAJPc7XSXAt2FcByEq3AaFA3CsP5Q/0lTg0muuy/c8pkSj338RV6F6mfSmQ1qr7a3liLF+qGkhe6M9Ez/KaF/RXCzZUK6M06VPUHk1T9YnqCe3G8LCyzkirdlAro84034QHDvsKvKQNBmYrpgct3aTPH4UNzazQeg1grCL5aMPv4B9o5iJwgm9J2vDWhzZAa5JsHB9Cfgr7foqwvgXBsiYbOmFXxFp7u4lwRdEjbERNSY6NDcZXeeFx5WHu+VPPhppDP/YmJv0KKINmFrdQnmS+Th+ko5S6v2lR30u4OOnTBw5b6laK0gLJyo1Faw1XiPEBwDNOpsRjcuXXbOk8zTgPWRdaMUaTp4Q3WtbeorvpbcBH+mEmn3GlUgE/ur4m0/c0zCWPPFyzCnJnjLIxAriju88hAsxrlje5y5TPFuV1mNDaYATrPIa+gr/F467iR4E1K/S1OYJSE61JwjmcqT4mdgpG//aCH2Rof4ddrGzV820aPqx+N0xKg4mb1pzn+vPUmY13ynH0HA5AsgfGLMg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(70206006)(8676002)(6666004)(103116003)(47076005)(7696005)(36860700001)(107886003)(4326008)(5660300002)(186003)(2906002)(70586007)(82310400005)(508600001)(9786002)(83380400001)(1076003)(356005)(426003)(110136005)(7636003)(54906003)(316002)(26005)(336012)(8936002)(40460700003)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:41:17.8744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762d2d11-0557-43fc-30bf-08da496db5fa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8354
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

