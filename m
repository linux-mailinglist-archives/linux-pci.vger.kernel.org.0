Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413385281D3
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbiEPKWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 06:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbiEPKWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 06:22:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2BDECC;
        Mon, 16 May 2022 03:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFCfGKpSFgfv0Untsy0zPWqKvaCK3djM/67nQhUi3Kwa2UQuQ40rDS/Ppo2tne2rSTn9QZo0Qinhl8SE/VhnrUSCGp03P4FW+erbvNWfYmb+FcyDxzSA2fL+YHSXOliNSVliuoSxv5A5x2/3H7JyFw+EPSN5YCcFEm5hgGWLTQJJh0R8+LH7Ha5DEZ1hhrBziDEP0mUdo4eR/TwQlo90eNut8oKzbSXG3kKgIqDNy8dBzI2Ax7hjXecBHWhrtH9E5BFEa/dRZKTds+yXcnlEtOR/gc36NiDMaKNPwEbsyY9NdgZKu7Y6B1L9kvx8H2suVFDujJ8hq+sBkuabYIL8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uGhNXLu+6XpG+z9hgxojci92YotiD5gDdcEQIFSSWg=;
 b=SxDcKx0ZLLMRqnjux+up04TGEiI0/M9eztCyxtVmcFOxaPBLPsE2L7y8H5vbdotH3wPLo/7hj3jmu4Igsk5kB8X7/rDOdaWc7FX5FzXV3xyEDxVFcD+jiU3GIKP6kFe31dILG04YI9qQM6ZjKosPJ1Aqzu1VCrM7Dbii5I/hoHuscaYW5vf3/LcuAUVUC0riyBHreuiNbtOZtDH18e9V3B2Nfb3xWWsL5CbUFWJIAzjLTLZLpMwxKuMaUil1j67RR8opYHHhDPxFKcNlzWERTUOwDyfx7kQSNrd/3mjNqxZ2kuQ+Iix+LHcUEF2hJZF0phkdTdIixb2MHHyB+R/SRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uGhNXLu+6XpG+z9hgxojci92YotiD5gDdcEQIFSSWg=;
 b=W/4svv22XDO/NeoYMvt8lpixFRpcHs+B6pEb/0vJUnmTbPQ+ELc8ITBRm40OQj051RMtQPIDwYvzWyL4Nt9ExhBYrujsDiPdMKPy7qKyBD1fuHDxmLVAvRY+DyKcnO8H99M0JvubOAcH/0PDH37WPwoV1yzqedFvm4x8XYyrlCc=
Received: from SN7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::15)
 by DM5PR0201MB3573.namprd02.prod.outlook.com (2603:10b6:4:81::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 10:22:23 +0000
Received: from SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:124:cafe::92) by SN7P222CA0017.outlook.office365.com
 (2603:10b6:806:124::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Mon, 16 May 2022 10:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0006.mail.protection.outlook.com (10.97.5.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 10:22:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 16 May 2022 03:22:21 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 16 May 2022 03:22:21 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=53786 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nqXrp-0003YT-FN; Mon, 16 May 2022 03:22:21 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property order
Date:   Mon, 16 May 2022 15:52:17 +0530
Message-ID: <20220516102217.25960-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a616999f-8c3b-4069-ea46-08da3725f781
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3573:EE_
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3573E085374DDAF603CF6BF7A5CF9@DM5PR0201MB3573.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yqmlsl7bifP8d5WRcxBx+RD3d2WNWWKEfyXSTGxbZXbMEamunfSGns0qr6bU73PIzjmnVA8GLqhEkJ9xbuX//CjUFwodzFLCbBLoR0zWajkJXDV0obL+axH9M4x6189PVm7b9N6DL5Y+zoZpNlcKER1Q5B3OjqUkW42on2Mu8qgjZJwz82dYwimLvjplrx4fLXlsMSBzQCRysr2tFuMhGRhGANdT7K0jKA5MKywSob4CkbttZ6wsL+T214V+DL7oxheNR+TVxWU8aFRTmrsEpSR2dKRGK2ytVW5F8w15Y4owFwNNXTdk3+Vwn0kNjgq5D/InsXeKIbnT8o9YxmB0zCKRy823tcK7KgGdG+I2n9GrKIZMwk9/FGffVhoqTaQQTe607BRPWrhXx9rYMTIO64ScXogTLxMMwubSUVmknxfk17Wj47LR9N6yKyQcWYatMqqj5/9J4AgyHK1kykR76e5pL3/1Z7iBgE1ZW7MjRtoLgayJRt5eFZKsmDIv/+A0KQZQ8teDo25zqxphJknFwfnaKmeN59XWgX6AbwjvR75hX+hW0qStL8ktMh3sRY+2WBYJkgkpUhHOx8QekcgOiuLNv1NvAaNfQuxhakDMj7xbs5j31R27TzDjnt2jx+0CNZle8fvUArZGxDMzwDoF4+crhuyLtfGjKSKIixegcmuRvvb14tDa6dzf64oxvIzoYfbr4mfZDPJWjHCzHYX40g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(508600001)(316002)(26005)(5660300002)(82310400005)(6666004)(8936002)(2906002)(83380400001)(356005)(9786002)(7696005)(110136005)(36860700001)(40460700003)(8676002)(4326008)(70586007)(70206006)(186003)(36756003)(107886003)(7636003)(103116003)(336012)(1076003)(47076005)(426003)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 10:22:23.1056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a616999f-8c3b-4069-ea46-08da3725f781
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3573
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All existing vendor DTSes are using "cpm_slcr" reg followed by "cfg" reg.

This order is also suggested by node name which is pcie@fca10000 which
suggests that cpm_slcr register should be the first.

Driver itself is using devm_platform_ioremap_resource_byname() for both
names that's why there is no functional change even on description which
are using current order.

But still prefer to change order to cover currently used description.
Fixes: e22fadb1d014 ("PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port")

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

