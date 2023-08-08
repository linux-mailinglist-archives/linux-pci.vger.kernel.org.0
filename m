Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304F3773D96
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjHHQTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjHHQSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:18:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78A086AE;
        Tue,  8 Aug 2023 08:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWhcehBiuq2uIVI5jtg7Yb8p59MUpPR2Cswayreoxg1LGYHvQ6Ngz5qyVoGOmJFJ8hCVf+6oSRcg26Arqc2yFcc668LL127DvRAXQ9+rylCkvuoBqdM/EufXDkJU4yZYfxCU3wW/qHMO7cLyJ9o6YZ49G/hf3p8AJOIBqDi2c9+RwZsuySZV5KboM+PlYUT1OK3Nim1Vj1IjOMD9WqqKYtfHiN5QjkSnx9Mn0t8OJ4lmSVL8AT8mHkRjcEnuD83nlBOsv6wUTetzl2TOUzbdYju/HKsjXXQCITz6QGxMrx3Lv0fNsntcEUDmM1x62JKbqEuL497xHQyRo0MACFjmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8F7Gg8zuPB9EzHOl9s40woauJyLnmF88nRo/0QJcVw=;
 b=O9iTOurbZ1SUQ0bDxDP8VJDglvZZ39XvNzKPFdDpRAbu7MTcPXKqy6Fep5AKBjeDH+NkggwNazVB2DhO8iNnLaxkaZzN2a5115CF/F53EVp3AMVYjlXZakJ1OAVKTzUjgZCwSsbJRlgLHgDbqevdUhc64774ML22JmEHURVpo5F91kCU18VomhqW/5qvdDzgtXaC0/yVRF+ysUBZYA6W3ALoquEWj2abyE29SGwRLDP0VGcBOoYDI3Kx5er6CvuZdUJGEuxfoVKONbLlzf6BsAeKp/Ix9QnFY+sKMlQy4KqdnZP7KEoCI3U64bW374nH+cz5mhdvLOP5GG9YTWIWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8F7Gg8zuPB9EzHOl9s40woauJyLnmF88nRo/0QJcVw=;
 b=pXxbmogluU4uMVbqcZimn898K9n6NiN787hedB5HgPWKXyJgVpVKZyoPYFlS4yjrWaBiALC/m5wm+ia3boVldhxGL7ey8EVi3NMDmtLVZe8dMNUsqrUPLM3RZsEGOH15Q0GYTRA4ZWuOHTQr8BL4Be6BZtRtNT3esKl2YktlMuQ=
Received: from PH8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:510:2d2::22)
 by DM6PR12MB5006.namprd12.prod.outlook.com (2603:10b6:5:1b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:38:10 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::f0) by PH8PR15CA0023.outlook.office365.com
 (2603:10b6:510:2d2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 10:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 10:38:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:38:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:38:09 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 8 Aug 2023 05:38:06 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v2 2/2] PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses.
Date:   Tue, 8 Aug 2023 16:07:33 +0530
Message-ID: <20230808103733.93707-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
References: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: c71c7a90-78d0-4fa4-f44c-08db97fb8f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1HcHwRi1P5Ds8zHaIv5JNchDbtsOF2qGm+P0v5Ag453fjbrKCDW/6gjWX5ljVG7EsRJIRmtjkuNlfhruNnguU9MEeHIkx++/DbNg8ErlwY7QOOkTrRl3TJq/KZ6MFZjmi1GYoOGQl1wiSA1MTsojdAh/moy83ER/f4Ea77h4Jje8KncIzbzqca/h+uzpg3eSpKWkYimlTLoAM/cs4oiE+A6D+JMqE79P7JRbdGbEALiAmJ8QoN2iebeCmkJ/DEjq37T5BKjlKGHozGFHzLJzgMpjCOBrP8j3frMTI/OUXn6GuCa9W5WWln06T2WpwU3i0Rf7Dla3KaZVJZLXhymuVjnS8cig8OHIiKjtL+zt57p7vhaLDJdegCF7nsQea2fvQ7QzcRlH3pYqHVl7nW3oli0soJjdNAvC6ry9q/yTE2AiI5Es5DTg3/thBfWWRLQIrXJZfxrU35cxayIRr+J18fEy3DFnMoog7dyfY25mQyPApNUuSR3WT5jnrhX2+oZrxAUY56vn77kTYx5y+y7F2QJJ9Bnefz9GqHR8JtqBT0iich2og5wqI1gfkPOfyBY3lUvmKe4nHjId/26ZUHYDM5iESQYiqW9ZrRJYWismN6GQyZ5nMt9u+19PSjtAucqEhmMoV5a/VmW8hnxkekC97eCR3UvZEGaWOuipWV7xqaDObkvM2GGGr0UxD9gW6yCTGRvDpQC9rs7fI3bD+8XwJz1V/+LzVY2Vf6IsiClieNhpbCvezM7w0YCpKoZQB8D2m8EjY6NwrWwJoIS+PxHJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(82310400008)(1800799003)(186006)(451199021)(46966006)(36840700001)(40470700004)(2616005)(26005)(1076003)(36756003)(336012)(6666004)(81166007)(478600001)(356005)(82740400003)(110136005)(54906003)(70586007)(70206006)(4326008)(41300700001)(426003)(316002)(8676002)(8936002)(5660300002)(44832011)(40460700003)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:38:10.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71c7a90-78d0-4fa4-f44c-08db97fb8f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v2:
- Update this changes in a seperate patch.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index a73554e..b515019 100644
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
-- 
1.8.3.1

