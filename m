Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2277BEC2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHNRPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjHNRPU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 13:15:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3424E63;
        Mon, 14 Aug 2023 10:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNrDr6qxhH0ANlWrkhw58mp8r2yLdAc2R524ufs5R/Kg2YIPPOt71FpWuZ2dzC9bX4bNG3TnA6tzPndxCrFGpvA2BO64KGoMxIoluBvoXniIij9/DUJN73UmoOZKmVqm3JNY8QkhxsQl3v4S9OhAw7cY8e2Jm4ErZQVhcGE3Nkq+5ADi+JRNuzjGqPnHyQVHsFpWaNP5BMDp3ShhKv9cpKOr0QJX2I4uT7gmT6S2cuwPA4VUq9NSPGuMM9s/wW+L6aC/YmnJZqAHyXN2Y/QEwD3hD5ov+R28b3I8ZN43NIpl32Q6eY/QrZj53qqL+zc5LT5sXL7xazHa+/Wvl8rLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0YvSdvX33yYC9wmHYVM4XJPVWwUWRf6UO5qdN7llik=;
 b=BuSjZ+Xl3Nvxa3aCNdSEbLpJAwbC0eV5BdUdkJ0qbNDD3K8AlvVlRglBA81eE40w6vaBanjbXxpr3vOm+bn2LwdDUk/UMM35WuGu0s596D2rYzGIZq+/bYdCDEU47+U/Rk59bYjMMEh8rugZAnte4ZgkzYEbVwWyLahX+PWA0BREnZ/S+xVOeScQ77JSSgkiwdaUad7UtK3OatTXHxr3Eq2F4hGNCms6KtsrdZcu7Q2HwuLqCFIixqzuo7T9i4+HKtY7Fg/PSqrp1DN6RIQWXZvHhJvyo3IAUQNib09XkdzxBrWSfZciappNGv1Vfxev6ZreJNs0CIdBQ/qMshSEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0YvSdvX33yYC9wmHYVM4XJPVWwUWRf6UO5qdN7llik=;
 b=L1b8hsNFtEWSg1FisOoSjFovOZhdlIlzTun/poXMCDDbiEYiR7BU4ih8TNnP8jUjMdB9khg1VSC6B+4efWONFYYRnlRQjDwrRVS5SrwpptngYkSW1uLH75cjnM++H86ReQslqcz7wz9YV0XWeM1fmHQvD9B3YETD/LBUci+LHuo=
Received: from CY5PR17CA0004.namprd17.prod.outlook.com (2603:10b6:930:17::35)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:15:15 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::c1) by CY5PR17CA0004.outlook.office365.com
 (2603:10b6:930:17::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 17:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 17:15:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 12:15:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 10:14:55 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 12:14:52 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v4 3/3] PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
Date:   Mon, 14 Aug 2023 22:44:06 +0530
Message-ID: <20230814171406.214932-5-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
References: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e04580-292b-4f5d-79b9-08db9cea06d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75arK9BF/8KmzYhJG4MML7Spf6zR6EaaGST/pvEtKv7p5mJZUyRbU44xHuLRWt+C3VwBx5gL3dyCbRIuY1G8IJlN2fT+gIaFZ7m0bSw6b+SYEUhVkKCn0LLJaPx12F+RKzuEC6R8HfnQiMmxhIK2EmALW98LKjevcDmpHq+LGAzYyDsvJHKNgcB3/25vK5EoS8vSLCYDpG/27/ca5BGYDKoCjl925mMFPh4KRpaEkvJVD1NfZfR9NQtCYoDM5KK+lnbNZrvLE7wxQSoXls04DAOAPhfiUvDZqS4xE672jYls5OMgLcL/RgI6bF9r6ZebKCMye26DYPIK6F19ZRZ+7GnO48yFlDn48wKnsuhWwuFg/wmBhz+VNWJ/GD7wwA8e+EF9wslxTg9ciphJGbZ3ty5k+wmJ/lWrD4854V53gvH4Cpksolg89gWBno0lMuzWZnjPiTNezEdkrqUH4U08KOcyLUovz50UOIvQNg7NtznuI6cfHxSJn05zpQEI9qtblW4CeR4nNbIRvm7GIHRktKDmiNntjDSl8VApMDYP4Zm/CP8mAWlJWLwWB0dZbT3Az/2YAZrfPcJbCkdypiHRv0nULtCYLa4rrSo9ene6f4RzF6J+0hClmBwwSUTcmpk9OEEyMvhllUXwLms+HLdD22kcm2fbDh5Al7KDnFLcLte/NYUQ0TOjqJ5+Aqzx3n6x3Dv2umwQqPEVto2nyEPiSlu1qTzqWDPSUv4WGkzPd7BThsSS9oTrnnI/rUDe1J3Q9jrMC0ofPU5lC/rEWBHv0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(36756003)(426003)(336012)(47076005)(36860700001)(86362001)(40480700001)(41300700001)(478600001)(356005)(81166007)(54906003)(70586007)(70206006)(316002)(8676002)(5660300002)(4326008)(44832011)(82740400003)(8936002)(110136005)(40460700003)(2616005)(1076003)(26005)(2906002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:15:15.2831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e04580-292b-4f5d-79b9-08db9cea06d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Our controller is expecting ECAM size to be programmed by software. By
programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to 16MB
ECAM region which is used to detect 16 buses, so by updating
"NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to 256MB
ECAM region to detect 256 buses.

Nothing will break, when having a DT with the smaller ECAM size and boot a
kernel that includes this change,but the kernel will only be able to use 16
buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Changes in v4:
Move modified ECAM max size macro into a seperate patch.
 drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 8fe0e8a325b0..e307aceba5c9 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_MAX_SIZE		12
+#define NWL_ECAM_MAX_SIZE		16
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 #define CFG_PCIE_CACHE			GENMASK(7, 0)
-- 
2.17.1

