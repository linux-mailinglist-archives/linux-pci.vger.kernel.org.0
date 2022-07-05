Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76575668C3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 12:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiGEK6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 06:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiGEK5Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 06:57:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91815A32;
        Tue,  5 Jul 2022 03:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkcX2hMtVODCcSM3KqcO+J5KhYLPTFerIHzMKwSqr3h2K3AedDvKojPldStkvX+cl6xz8tmC8BLTzxR0NMJmz3D3ssLG7fJTbPKwxW03ylPkwxzmcdIB/memkUKsnO/JQghKRkOazxXSNulp80aHlqZBZ2Hh5r7YV95zXJ8u26Uru+YrDiaCk0JtguIbUiU7VAs+AYCdOx7WrLZfwolWlvZDh4kL1RZBqYIDj42w0otRH0vQBbQDXzlmko9L/fsu7QDn+t7C39tW8dVA51UNGFVf86htqZQ+gSgdwESZ+6xOkGIr43+gNesKzT/Z2dlQkGtr//fFssw+v+5SV0kaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ5TflSQ9KYJaNuR+dVW1vtGQH4/39ZAzkIKtRAjm8w=;
 b=G/L99Db1qHu/TuqlvmC9u5U+0kNJznCbNX+aRupFJLRhKgKE1ah6ADHMQRINxsZSBPTrbLLQMNwkTkqceQ3Xn1BSsB/b/qia5v12wR3EZBYd9mqp5w3tr6/lWOtGgB5qP1f51W7MUGfMo1TpWuZMR4CK+sDnYFxOKGOc/WoSugrk0funHjUtDil9qxYTgTECtzvBvr/qIgSI3JLLLwxICtgtXD20qZEZ1rvso1ny4DvH2ZVi2TdPLWPsIhd4JNSYR0OYgSacQFwxiYzKwcKYbQlgWQZC7XtyqkvYGgNR3GTnYSyLXN5Zvp/zkncWiskp24LCBHm6Lr6PjEADy98grw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ5TflSQ9KYJaNuR+dVW1vtGQH4/39ZAzkIKtRAjm8w=;
 b=I14ygnlZ3L8CE1zm1giax/OiTbKUkG045jO87I1JVlAFFCm+EJnpWGQ4cXzQuyvjxrp2xYT22XEv7Jlj1KaU1jMTxjvUvdxh4UiAL2qcciR+Fliu1Kr5Kc5SqYfnk7XbOe04bBrJOKJkri6uw+hDmT2QJk6TWN+9sqJYxWrxNKQ=
Received: from DS7PR05CA0019.namprd05.prod.outlook.com (2603:10b6:5:3b9::24)
 by BYAPR02MB4215.namprd02.prod.outlook.com (2603:10b6:a02:f4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 10:56:55 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::61) by DS7PR05CA0019.outlook.office365.com
 (2603:10b6:5:3b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.11 via Frontend
 Transport; Tue, 5 Jul 2022 10:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 10:56:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Jul 2022 03:56:54 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Jul 2022 03:56:54 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=51530 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o8gEf-000FEX-Ko; Tue, 05 Jul 2022 03:56:54 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v6 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
Date:   Tue, 5 Jul 2022 16:26:45 +0530
Message-ID: <20220705105646.16980-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
References: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5074dda2-d94f-45ba-9683-08da5e7512e2
X-MS-TrafficTypeDiagnostic: BYAPR02MB4215:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MjHeoph1Ya2naHkBC30nWT/KitVmIbcfbtupcMiK9zraBeYRf1FggtPQn0fJ8vkLvwehA82fs/loWbouDeG5tAMZ3WeZp90AzryH/umzbvS6g5LfQDPqNLksVbq/+Z2V1Xy9GaWHwdt+2Gj3m6yXhI45Gt7AWbIv1NYwxCXdPJSzvAeaqwyeKv0ivSHLzv1oKY9o1GRwRWUeEd990yGopS992NDhdKiJlhPZk/ZXRacAG2s8a5EuWq45DuiwlLyTk5zq1S7aRdruYtQpzHhgOqC4djn4X9xzed+ycIQJDzvZepAhE9EB2ck62FNPB+gkpbBEZWZohfhNWD3spEWThYOvuub7S72j320sNVM7ECwLWmx2mZMWr2v0amSqMU9duTZGXhX1pCMrbfyIBQhxlo97Hc9VnZ6am4wYhuB7e+HvcdrmTBZjsgYkngHbxiRBkoMRYoXllW3Fd/NPiXk/X9Mwc3pIk+APInbdbLQ+L+UNMDzaIRZeLLwbYTElhZbZdtCR2s4fyfsgjPoAZYvePfHvE+MhfhECZRdXq2h3RbdkiWf1D0YPl+yukUNQnlddh+rd1jTCUhdd766WzCsYq+4Crbdl7Er32JWghdgRIHYcWQg8j5cAGnDpE63BTMcOUpQ0LBDsOlXkmZLXFfaUlP8d/HI3LZrXHMiSzJOvBqLd4SvNau8lphNe6qjkL24r4SL1VprXumlT3h12tylqtcQpmCj0Itq28Qqx/O4IASY7vkV4yD0Jy8Pvlt17K+9XyQZTf8qc1Jisds0DqwfTSxPCS3LuaIeks3tZdhpjw/7BraFygumR2wqkkq7G6sfKKX7NlI7p7dW9Gzbq8KVQQTY4MWmrtJ9xdBBNJ0eKhQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(40470700004)(36840700001)(83380400001)(186003)(336012)(47076005)(426003)(70586007)(70206006)(8676002)(4326008)(103116003)(478600001)(9786002)(40460700003)(8936002)(5660300002)(82740400003)(356005)(7636003)(26005)(82310400005)(6666004)(41300700001)(36860700001)(40480700001)(107886003)(1076003)(2616005)(2906002)(7696005)(110136005)(54906003)(316002)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 10:56:54.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5074dda2-d94f-45ba-9683-08da5e7512e2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4215
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index cca395317a4c..24ddc2855b94 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -14,17 +14,23 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,versal-cpm-host-1.00
+    enum:
+      - xlnx,versal-cpm-host-1.00
+      - xlnx,versal-cpm5-host
 
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

