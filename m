Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE876E75A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 13:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjHCLui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 07:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjHCLue (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 07:50:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BAB272A;
        Thu,  3 Aug 2023 04:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nACdV3RqJ0q5MmzoVmoxOnmSDvvMLlfS++TLEsThjpmDIXnJyLahI63ub1HiupNdE+YEuvIVZOrNU/5Bev4oJ/iV5bifT2JYbADg8kk2/Cahh7FIbQMhVmgzlLprxtwnOv+k9crvSkurBh41SI6oHbMMkEkBleRDhzudV0qOoG3Oo80qnovviXoPrbNNXcR1hfLp7BCMjrkO+R/USNKz2gYfc9WD1LB1ounOYxK12ASUai6YoQ7BrYHGAcYtYOHZB4YNVQEEardTJsHnhALc65gRtotqZ53jNiirslel/CUr/RGtvM4BBHuKwBLPhdfUfjSrlZSO8W/l9xD5e+m7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByXv/8fNtwaQMvLzxFc2CJTJnn2cf+qKtiEZD+GH0Yg=;
 b=djZP4m31S1NLjwc1Mr7MHUXOTqSyRkXtlxeHz7oPew46HtxLWjbvLKPLR5sq8inUCiyHehFd8jsXf5dCMqSMAf8E7To53ob81VgIl+WO7PGX5ZyqEXbc0OtFwXrn16+tG58yGxMFpWGckEntVVWo9MEPADcBxd8WmEao7ISrhIrigvU+NuSui4f8ZZ7w8s6vPPNkDNuXAfZcOsPnvWHTFH0ioo9Ax3AFCbsyDOpKtbx+2DYKLK5Lmo/sGd+N2g3d7I2a8yeR5pZw9NeLg2BDR6LQccb7BN9d5/voTpHNgepGJdwlwxQXts3bCWbbzk6zSAJdKwqa8la5OIJIC2MJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByXv/8fNtwaQMvLzxFc2CJTJnn2cf+qKtiEZD+GH0Yg=;
 b=VKcycxZnanvnOvuyWYMhaNAGQ/RgJevYBzao0LpQ1I7Z1cOZj2JWBYiROXCw+eYSrmmruQW1xw4+a+3GmB5uwvBh0WKjo4+kQxAJreyBwz5ytpMws5j/z46Ow+tJqydHjbgOwMVHbquqbidsApMpBcgRp3HkiXwv3pjXTvI+prM=
Received: from CY5PR20CA0006.namprd20.prod.outlook.com (2603:10b6:930:3::30)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:50:28 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::88) by CY5PR20CA0006.outlook.office365.com
 (2603:10b6:930:3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 11:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 11:50:27 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 06:50:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 04:50:26 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 06:50:24 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <lpieralisi@kernel.org>,
        <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating ecam default value.
Date:   Thu, 3 Aug 2023 17:20:16 +0530
Message-ID: <20230803115016.4266-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e53c711-81a1-4c21-d0a7-08db9417d4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aWX0cktiEN21bPayGpqGrWPWuIUUJmYkEBNw+hSGwCE6uM6II3yJ36t2ICcfCdtT4pFM8gCOpfuox2zCT7CqjfmIEDPpeVKljqwfhekJPhnCUfKAKlM1B4BhV0BJ41cmQwaGX2hZa7czpthM3F3lZ8YYW5hYwiOZnxOXYUYH+rEKaU0i3x7pr+wu7aupLoPlqqcbQw3nAfKwxNV8kBiA1TgE3hCJPznu2MAbsF47n5xQEfEBXp2ymE8UZtd1FTFj9G7BoVAvEaS4RnEhw20mREwBFWHLItUE7KR0lUVoKWnvO50VhyY2a9b7VoOfUc6pWtF00Ks/J+vv4WdZZt+DSNxSaCaDsmtlZKQyZROMCl9u85n6ClAukQ+sEVwLU5rXjKm7ksZFLMXsLgpdA0+VBrxfn4nWigLRdT/MocNFy1g5n2LVu2m/Ixkwy9WkyPQyzr4VSDKKhZiy3vOHfAgegq99jekTW4iSkBzkuPmBeNiNX2lX/GIiTmr+dW4PQgX58rK+hyPNUDUklcGB6Mrh6nBSBDmx72nz4n+CuFi99yL+j+cWOqnc/wOwHADWuAkPG4ptYV/RS33gDZTR3LqsSb2k8ELX+SBkQuerpz/Fd5JXk9eEvvlAHlNKEkNhi9SzCbF02VIcorpSymx6tICyYHwct8jxL6llZEzR/iUVFM2iaOuUgXTfkhkTVDTSoxKhscpLFsyMw2qom3Cp/D7jVY4ZrdXQLetOyyu00e6udYyoUY+FlHlmCuZtjDm2E0jGmKPo5YzSR1ETTH5Qebqwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(41300700001)(40460700003)(8936002)(8676002)(36860700001)(83380400001)(47076005)(336012)(186003)(1076003)(26005)(86362001)(2616005)(426003)(81166007)(356005)(82740400003)(316002)(6666004)(40480700001)(110136005)(54906003)(478600001)(36756003)(4326008)(70586007)(70206006)(2906002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:50:27.8625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e53c711-81a1-4c21-d0a7-08db9417d4e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove reduntant code.
Change NWL_ECAM_VALUE_DEFAULT to 16 to support maximum 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 176686b..6d40543 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_VALUE_DEFAULT		12
+#define NWL_ECAM_VALUE_DEFAULT		16
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 #define CFG_PCIE_CACHE			GENMASK(7, 0)
@@ -683,15 +683,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
 			  E_ECAM_BASE_HI);
 
-	/* Get bus range */
-	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
-	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
-	/* Write primary, secondary and subordinate bus numbers */
-	ecam_val = first_busno;
-	ecam_val |= (first_busno + 1) << 8;
-	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
-	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
-
 	if (nwl_pcie_link_up(pcie))
 		dev_info(dev, "Link is UP\n");
 	else
-- 
1.8.3.1

