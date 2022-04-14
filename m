Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D75009AC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbiDNJZh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbiDNJZa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 05:25:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99F6EB30;
        Thu, 14 Apr 2022 02:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krjMHF9KcVXJHC8zGmJNQzFTpJOIOQt1TSMqMkbGYtjCdETVumV6934o0xHTu8DBH92O1Yd1HBWbR2YuX9qGs4jyzBr0SzJZ2xyNRJwBm85/QqFFMLTFQybw2mnYi4RoJvLzKumWXAk7euAhvvPVZpnLv587QtT1pVt4veQ92NB46QpH5/UxJFEX1hIdKeOfnp6Uf3vcIANBF6RCVe6CWPuqYE+RYos88iz+X1J02UQac8xpKtBST8caRWTHYuTBxU9sFad1vAmYFnezZvy4J4TSHmc3L4VOBXB7UDJdEcYN8pp8nYGPa8BTbKGmm/mdpYCtx89lHJOGjhHG2IoKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXgNfcLo0pb1IFtCawUg/1sNUaw+3zCFzxed0QHO/OI=;
 b=KkncAdsnUJbtNx9nlaw4Lx+1kE0Ni8f8dCGZTVhJqqnXeIfF7wI8bN1+2E7u4bV4XGfBZx4KLPzN8Cl0zhqBE07NerZGQGukRlznptZfusBNqmKf4YKGTepbzkCue4pfGfT2XlyJuu4xFRJBPeB0rcaixT2YJ7d+JNpsIAAruk4x/OWKQ0u15E5AmLSz2oIyhQydeg7EVk5Z7ZTpZNf7IJ3mf0uqs3KheO79Vi/JSdwJjTuR1CKLTF4b1j7gXDT2wgcFLDwuFdudjH6LsaqPRDMgxnlrLK9fH5fUzSbL/h9h8PHsjRLHFPvOjnitYIbrNwAIvOL81M0puxYhzFlGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXgNfcLo0pb1IFtCawUg/1sNUaw+3zCFzxed0QHO/OI=;
 b=J/eWbSVvmTgWBkKvHSQEDO96frwq8WHo69sUhYxaHHltNzoUlLHLAEOcsWdI77xfZun0pXGBTaPf1CoQGHFBRjXh2mxTm5pOBRo+OTYk7rEMd/68n+NP8cQmqRFW/UfGIwbJX4pI0lGh8SA5pqYylBnRbgJZfdEH08IY5WJ1bO0=
Received: from BN9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::33)
 by CO6PR02MB7810.namprd02.prod.outlook.com (2603:10b6:303:ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 09:23:03 +0000
Received: from BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::40) by BN9P221CA0006.outlook.office365.com
 (2603:10b6:408:10a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 09:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT005.mail.protection.outlook.com (10.13.2.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 09:23:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Apr 2022 02:23:01 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Apr 2022 02:23:01 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=38782 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nevgq-0008Tv-NC; Thu, 14 Apr 2022 02:23:01 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v1 1/3] dt-bindings: PCI: xilinx-cpm: Remove version number in compatible string
Date:   Thu, 14 Apr 2022 14:52:50 +0530
Message-ID: <20220414092252.12174-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
References: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68fadbe7-f554-41c5-f340-08da1df85ff1
X-MS-TrafficTypeDiagnostic: CO6PR02MB7810:EE_
X-Microsoft-Antispam-PRVS: <CO6PR02MB7810DF5C70A67CD8378F363BA5EF9@CO6PR02MB7810.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dIkWlMbCPZmPC8CqrPg85sijKQOJ7rU5vKT71dT/ATRsdkOtqBGefU4DQwS082qRY8DiJTb6OY4jwkRqORa/nfaXAirsAn2VtxSzi81QSQ8bP2TOGIWeQoZxv0YB9FudWx+xhccO4o3fMFeax4OrB/odHdfidAjhb2banE8qDBG1PWTpmjOXQFUugzLAR5TQHRhRGu+I75PDm/Abqou8netmneqw6J6No9JW6Z8RtZmkVcVTg7ww3kOqz8ws/MtQJA/m4cmfwEUzO0JCmJ5SUUAAEgMbFr1WQF9nxFBLqxnumz5uIiRmlffrz0lBMQ5vco+JJAmyNozqhxP1QPgP1ifOjdnwMPXSbHJM9QlowVGCqDNLq33/TnNW9vdWJlpZiaGB66JsZxf/0C2fuyKt5nwHBZXD6pGyG27/16iddPUi3/z4gvjPsJwpunQxNIb+EsUU45a3a94Cgp/mkGDSbxsVshPAzgxo1xsXaQKpDIcuD7k16dwq6QgUBx6wzu71MAHdq8oyigx9amflz5bzwZw9RaJnooprtrbJ4r8DyAy9Y9FafsyfiGyfZ9rckO/Pheu36vgyrYCUEKl1y9zAT7GZIQCu8raqS8ALqJfRp0SNZBXzG5eBgaYeKQDhG0vnlDnOjrO4uP7urM6XZ9GkCJSE2mMq8P1fkoMJ8UWcGwVN80dtt4y0NzpSZE8g3bYeFOxlrvEP1LBcELncuS5yA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7636003)(70206006)(8676002)(4326008)(70586007)(36756003)(426003)(336012)(8936002)(40460700003)(54906003)(356005)(103116003)(110136005)(316002)(6666004)(7696005)(4744005)(9786002)(47076005)(2616005)(2906002)(186003)(26005)(83380400001)(82310400005)(5660300002)(36860700001)(508600001)(1076003)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 09:23:02.3727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fadbe7-f554-41c5-f340-08da1df85ff1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7810
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Removing unnecessary version number in compatible string.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 32f4641085bc..4ebcc838a1f6 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -14,7 +14,7 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,versal-cpm-host-1.00
+    const: xlnx,versal-cpm-host
 
   reg:
     items:
@@ -70,7 +70,7 @@ examples:
                #address-cells = <2>;
                #size-cells = <2>;
                cpm_pcie: pcie@fca10000 {
-                       compatible = "xlnx,versal-cpm-host-1.00";
+                       compatible = "xlnx,versal-cpm-host";
                        device_type = "pci";
                        #address-cells = <3>;
                        #interrupt-cells = <1>;
-- 
2.17.1

