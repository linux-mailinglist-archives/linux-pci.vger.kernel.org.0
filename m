Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F777BEB6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHNRO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjHNROw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 13:14:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3824E7D;
        Mon, 14 Aug 2023 10:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifh8NVBf/VN+qwbuvLYprV4Vu0PjDaYaTzxk7cGe9oDnawNQoZLTaiE7X+F3h/NPirutLw2aT07EBINEmKZ/fLoseeP5k5YPOcmzrxDmNC0OqdzS2BnlUkfr6gs8cSy5nX7ErxatBsCtnJiMi2OCPnnR4LCmBrCNoB3SA4XBWTHKFjnjQXI7E139xJ2Yr/1xeG1nu6vp8veLbQxcLoZPmEBSGTi6T7o0F3KbKMeuEAhIjHJV6By1ATVfZDLgKvsKnvxoa0FRBxSn9jgIHzPNaY8/XVZYqiszjKLsZWXCxWR1rXcqlJWM1f33WIj9kjxyv7A5VebqFirRgoQIoE43Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrTZvyIqy1JFgUXjNbxkkhXFaIYTn6d1lAorFxWIc2M=;
 b=ObMqDPr8e5CiyLpc/r7S1biZZqCygfEc83M34GHpCpwzXvB1+dJfsrQ3ByAY8MG/rxmy9qOEOxTY6/3amRfcLwoTSQ0d36BjxHwI43Lwp09GTsLkruppXs42chvmzjWsYSQgoeUbqGJLIZ2Ml+EjD3kqFtr0+Gva5tmgThGqAZibk1OSYzDge3iCo1PucTOUlNexJ0Pn7NXmgbzYHFbWEFNBqVEcs8tjGxYxUXznx9GVkDczH2+B5rEmSZM9NXMVJINUToj2N7ytiFbXGBWIeWwt48YLtJ4m2aVozp2iqTiCKUyDeMgglQ022iA6Ja62jG+3bvvyrTPuFP4aXkyvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrTZvyIqy1JFgUXjNbxkkhXFaIYTn6d1lAorFxWIc2M=;
 b=s7WfG5rIEmVA2WtFIlwRZa+bl0JCaEo3EUhbK2opr1fc2znMn+xr5jvDfN4imynGbq3iOf0qzgxOicZKcq9AstZzVJqekKCEb4H5uJqeBsM6A0se2NvfBnlXTEprgl0xfhdF0aIAX/To+KtCGA/BdLsDsteTncUnenjd0b8UuNI=
Received: from CY8PR11CA0023.namprd11.prod.outlook.com (2603:10b6:930:48::17)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:14:49 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::bd) by CY8PR11CA0023.outlook.office365.com
 (2603:10b6:930:48::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 17:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 17:14:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 12:14:48 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 12:14:45 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
Date:   Mon, 14 Aug 2023 22:44:04 +0530
Message-ID: <20230814171406.214932-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
References: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 20651ace-c788-4fda-ba22-08db9ce9f762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeNBXfFnqwC9+BI36lufrUzvTzqSXlKC96Sjj+n43NaK1uOVoXt9268F/eHmKhjsIwU1maLTbGyMWYY6n9pCl6G/tES48mygV+xB5NMKQSLSlF4cSp8zaOaMNSz0R1TDfdJE/TkI8lw4qHnynL/zknyPxa2SbGujJub+t81hg+SoFjxHcH0Y9iVkRo7DzAHw7eTkM8krgunHki+D+rOxSLCx3dE142extA2jt+eqXr5FL/u+lNR4rLuVrihwEvPYcjDwxEloiNOpvWQPnX+AGUGnV4BvBMiPCHfNg90eEVLU1eO2978LT01KKRAQSgzTshx5/Y0C/lmbyzxaGUJZF0WWno25wcYLTZ3HmrU92jIY3Y3dnnBS8H4NVAmSQt0F6hWTpDa7Q1D89xSWei9eXc0GAtTznoc20BJokdMlTbnfASidHUmWyUxRUyaA7uU2hLRBx7n5oHf3o8ve7Eq1OSdb4mw/EZdKI746zT7gh167vpPE+YsF96C0SYrOlLmEKwdWCmvRDv5DldqA6WYt4xugt2anG6wbMADMUKdjdatxvSGcJfw6Lm0jnVqdExR4GeP8APgYX8hr0Gt+hqDWz387EsSViijVbt/cFad4dch/TxnsI6ZrCGi3Si/SZsP8ic6zUjBQVuB8Bn/W472sf1X7odPu5KMi30zYUhmTQXDYy6yzi1Zw2tSr1lj+5clYDXIhMgzodfPFu56XoKKC/bRsWD7Kn6V1fc/JqixAbuWvn/DB1Stg1RjqPyPuUtDBrmiWRyxkdGIuHaqRsb79Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(186006)(451199021)(82310400008)(1800799006)(36840700001)(40470700004)(46966006)(81166007)(356005)(478600001)(86362001)(40480700001)(36756003)(44832011)(82740400003)(40460700003)(426003)(36860700001)(83380400001)(336012)(2616005)(26005)(1076003)(2906002)(70206006)(8936002)(8676002)(6666004)(110136005)(54906003)(41300700001)(316002)(70586007)(47076005)(4326008)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:14:49.3718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20651ace-c788-4fda-ba22-08db9ce9f762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update ECAM size in example to discover up to 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes in v4:
None
changes in v3:
None
changes in v2:
None.
changes in v1:
None.
---
 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
index 897602559b37..426f90a47f35 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -118,7 +118,7 @@ examples:
             compatible = "xlnx,nwl-pcie-2.11";
             reg = <0x0 0xfd0e0000 0x0 0x1000>,
                   <0x0 0xfd480000 0x0 0x1000>,
-                  <0x80 0x00000000 0x0 0x1000000>;
+                  <0x80 0x00000000 0x0 0x10000000>;
             reg-names = "breg", "pcireg", "cfg";
             ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
                      <0x43000000 0x00000006 0x0 0x00000006 0x0 0x00000002 0x0>;
-- 
2.17.1

