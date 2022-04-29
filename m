Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7E514A2C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359682AbiD2NFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359681AbiD2NFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 09:05:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379DCAB81;
        Fri, 29 Apr 2022 06:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgjn2N5re0vIzIeVaQIErWDzDnKWYjISiZ8jPYijmXijWQzZAJyY4UsFMLXNmiagz8C5zaVnQ/cmQptKMS7oOtwvZoGYFZMGEUY6k7+1C2wvzOc3GDJhEtkBLwdn/OSrI3B6B7D4DQxAVCjmIAHgEUCywr+eZN7ZNnI4cSku+Ot9kL7MxpErZmRlOvkEBoPmwA+gRdhDy3YmM3vWObxC77ksn4LwYQYBnF8xzE9sOV39s+C5LIdPJ/qjFMUAjNjP5Oysl5fNXT3oZchJ2ox0YuJ93zeFDdaAlOfj/NPEUId3HAY+zeQeRfbtJm8w3CrnBtNTEzpL+1xTu0ExfhBbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s62Pffy32MGc4HC6/KmSUPaD/Qr8YNde5y21qLEVE8c=;
 b=YAIV9f19ZbGkEjhRI83+Ih+3R1SOef1T1RSnV2cJD6op4SMXVJpanmAq7YbejSaUwQAWIbNg3rhYrU+ezx7P+P5BW3ceFfIzWxBRJdo5XtsDMHhzfhlUBxiCCjOC7dgYOY5AbL9NwiIyNYKrQtJ6xj+f/d8KJnsApcCDdv1b1xtHBtvoM8Hcs+jcqtvVrOB1TXJMeQsHm8ItsWwQlLSnUGc2XcJ3DVmOgY1BDm81hviDIysvZx1q0JrSWvghzU/IKh7jpJEFC0hDq9cWTvoCT8btzLJGlW+tSaGsKNT/Xy5NAwj0Y+us4cGjtVbmwcYipdxMuvUu3JlSy6hEyS7vYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s62Pffy32MGc4HC6/KmSUPaD/Qr8YNde5y21qLEVE8c=;
 b=ClROwEoenV/wp3ADylFUiFH4fpYMcrgzVPuZTnYVrmgWzrBcDMJ2S56w44S8+trmZUmZHGbKN1bR5T+aXnuWeZZIq26JABgNfz+rHwMlnj6ivhCDQoy/itmU74hDEXUKZ6ELuP1TdgEnnanalxy/LuUNZjGSc64FIp9a+XLq0bY=
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by PH0PR02MB8793.namprd02.prod.outlook.com (2603:10b6:510:f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 13:02:33 +0000
Received: from BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::c4) by BN9PR03CA0358.outlook.office365.com
 (2603:10b6:408:f6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 13:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT028.mail.protection.outlook.com (10.13.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 13:02:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 06:02:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 06:02:27 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=47396 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nkQGQ-0002p1-M9; Fri, 29 Apr 2022 06:02:27 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH] dt-bindings: PCI: xilinx-cpm: Change reg property order
Date:   Fri, 29 Apr 2022 18:32:21 +0530
Message-ID: <20220429130221.32113-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47ffef7f-c61e-4148-cf73-08da29e0868e
X-MS-TrafficTypeDiagnostic: PH0PR02MB8793:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB87938F30FEDC8FAD87070013A5FC9@PH0PR02MB8793.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjSfA1m+LiHiF3Cfzo1YVvmUaD4XyD+pO5CWIuV3AC9U89PMjR6VE8cgnGWryrh3W6/mY9FzZy+OMH5e56eSXuvcjwvSRBCrhigE+1JEocQl4DSs1ZfzVgyVkpvlaxFfLZZEC2seOQVVcemKgWiEU2UN+cd9S/SIjpSVeMyacaYSongXNdnt8RCcAcvbVsjwCW2JWNqXmb4LFlY1gNvyRahTrx5RRMKcUkCryY2onqkJpSQGr2qOFyFvlIBCgunxz634ecA6Fz+r+rj7jrBkGbKc9r5cvrwFHO614nwYEUIr+Z8tFANKKhznVPymtsUy27hUymfWx/m9FcONyZSYtOirDJPyTJj+/NlgeyC5Qrqq564IfwTZHQZNRtoujS9ucGyDFHQELZik81Q0NQhfzZEfeg60mvuSXXo8L/XsaQ+l2iTqDyTvqY+Vhkd2wFfvRBMoiVFJSSk0uNkfZ54epg1ULiMkGnU8aTOSDqG75CUvy3mdx79+biSkfRidL1uGxqkyD52nqnnuQr4igmb2FpAlHYzSelQ8dcvfD3ubLHx4OiqNx37YW+h3agBb/d8y+cjPnssu6CpnT/gneLWsrUWspD7mFp/x2qjWmqqbGczi2inP8Rr3BleqG58utojOr0Dyv+RwBCTHWwWFFG1ZIf4i7KsCmnLlGh4ZRRhwLV4xwWCtmK2jbfAKfPim4iqyf2XFbyi4uhzEnlSpW5V5Ww==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(7696005)(6666004)(356005)(7636003)(36860700001)(26005)(186003)(336012)(426003)(1076003)(107886003)(2616005)(47076005)(8936002)(9786002)(4326008)(40460700003)(8676002)(82310400005)(5660300002)(2906002)(36756003)(110136005)(508600001)(103116003)(70586007)(70206006)(316002)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 13:02:33.1859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ffef7f-c61e-4148-cf73-08da29e0868e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8793
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Describe cpm reg property before cfg reg property to align with
node name.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 32f4641085bc..cca395317a4c 100644
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

