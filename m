Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2E773BC0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 17:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjHHPzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjHHPxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 11:53:18 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4F2558E;
        Tue,  8 Aug 2023 08:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5GAb6nfuN5JB3M0GZjks+ruY5ShArCQ7SwZ1d2uAPCJCqklbQk2hM2VIL0N04enqEDSKEq0x1bB4XzKYR4ba0FKgMMeBkerO5tzZFS3LCBP9qmk9Ae2e5nrGOjYeqNRwi4VLAncJizg2NvheNfAdd2uoEGM3fem723L6RGCUmi/qN6/8FeQDbQO9/G62MemATP5WyV4Nb9UoZQYA57bJdMZPORsd4pTuaxjufSmmVY2Mixa2JThg5u6HTlEdhTyCfOMxYCC4Kkn000u1Zv2bQjRpk+Wgrgif8Dq6noqzj26I9PyvYeRcPwQY4bvPcyWX2nebnASKr4Nlkvf6WQ8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIQHeIMkxG6lDjVUlDqkrRlX9TL7+IhtokbAHjreAng=;
 b=CND4FpcRqFA8hgIo0ywexetJqNY5+W4C0f4uUEbrIw3l3TTlIjvxf6TOvb5Slb/3izjlu2x1XODCDEPpt6ZmWw6FVu1OvdYzvLUDXztQ2EgQCcNnYS9p8dgUIacNZDazmBbkuCh4TjeK8GdE4Lk0kWD/zkdJlywqBqPeDEgeLpb3Ww9kbRJU6YUsMl4ZlHMA9x818S5Q6nSSF5T9r2MO7iwa3CUgTZkey2LWAi0pLzZqpHVrd3AQFfNqraiHb+LGobDkGS8Msz5LNczBdw7Dqp8amhI9+9/mM0+kmY9nbnVIRGbc9xS/e2yE5A+9NxqxUhC3GVkJYH4Xlsi6j4frqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIQHeIMkxG6lDjVUlDqkrRlX9TL7+IhtokbAHjreAng=;
 b=hsx2Nl86AU9snySfCxT1f+2fAM/zw6Zi7RQXOgo9NBlVqO04b45gOFuABIDcHCh4btlGj5FDNquqa/dbhlpCk0r9b122yhZjK26XUqAMC8UJLcy51hS+IJt+YhU6kUFmG8OPYwzpPyX6frLVTxaYpXoqdDOPnK/kdslnyf55A1Y=
Received: from CY8PR11CA0021.namprd11.prod.outlook.com (2603:10b6:930:48::19)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:38:07 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::5f) by CY8PR11CA0021.outlook.office365.com
 (2603:10b6:930:48::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 10:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:38:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:38:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:38:05 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 8 Aug 2023 05:38:03 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example.
Date:   Tue, 8 Aug 2023 16:07:32 +0530
Message-ID: <20230808103733.93707-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
References: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: caf6ce87-c23c-4522-7b2c-08db97fb8da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCwhdaV2cK9tzm6d2U8hJIIRWOLTHzB3+7mE03HPnhLGo2X42Fvr2kjoemx61SHmX39GG5q/UOv5U1Kj7QDKUa+u2FPPW1qqcpxIUKZ09O9plfLfAsaoAMLPjW5LKVRfAjRzQWdzgDOlHsw7/s5pBmcEPYOxbwFgrkelZFCngsUPRpjJ38uwzOdzUYuv62AC4ClMV7DPuYdIF35qXNffj5I24ZblM2rRbDKFcorytoNwdeQ9Nq1avIz1A5C2H99PxSwSBnAzhHfDMhCnZNKoATpL/4bLfXTzNY0mZShrQnkK6vIInJ2ugIxZBjO9lb7MJOIticQjQTB/jo2BLIWyvbMHasOjPMDwW8uZ3KMS5tX1jbTWif6avd3GDJWpZs3kaBWeMwSDmmrGUtgnajSximC1Gkh4yxi5WLycTkZCj7CjhzWiCu/HHN2dDgbwAOce0zG0U3p3moTuMetZBFyrcI5fBs+HYH3DORmMN0khiwhof2VJw7wyH5VRF6gn757vwlri3FV79g9APivMgG/RqF+YwtSDPgy9ti1pTXtUdG1v6RtTHpNeAFXnkj0b3eBWOaj1fvt2PytgijVv7PSUj6OXjI3vJ3e4Y0HF8JDMPzRg25mSmz531u1CHswgCo/GEL8q4mG7ZJEAUQ+qJkpMS8REJATouOMaqixtrQDwR+10O8bWNc/2OM/GB4GYlJA0uNvWBuifw/sXXdHMYZY1zVOIMrboC5D1vqHaEFMQe3gGG+YDVasDvdyWX/y1alPT3bYtXtRcfpUQwGIsb51KSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(186006)(1800799003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(2616005)(36756003)(26005)(1076003)(6666004)(81166007)(478600001)(356005)(82740400003)(54906003)(110136005)(336012)(70586007)(70206006)(4326008)(316002)(41300700001)(426003)(8936002)(8676002)(5660300002)(44832011)(40460700003)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:38:07.1399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf6ce87-c23c-4522-7b2c-08db97fb8da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update ECAM size in example to discover up to 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v2:
None.
changes in v1:
None.
---
 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
index 8976025..426f90a 100644
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
1.8.3.1

