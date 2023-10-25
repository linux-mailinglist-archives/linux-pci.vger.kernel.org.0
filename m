Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9A7D5FB5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 04:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJYCGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 22:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYCGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 22:06:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E979710DD;
        Tue, 24 Oct 2023 19:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elQJocCXdGaTywAAcAKUNDhAcExsY3i46sL5Ja0oYJWpPTmx/BDFxZ1+u28GkpdE488Zo6eeA7bxbqCCBGMLXgLJ3yOBBMMGH8eUpMh+7GUXpWw4NLvxp+TRo4ZreBAhqMzqcdAAZFfAkViGnM4O1OTL5MvGAEHqOqITqdNq7VeNyh2IxMCwxeecDLAQXCK+YRzQsFMRdracN6rGY+2uzPk5FeCDCxKDr08l2MOLvSaKMR261SqQN1gUBzGQL45OMpxKEEPLXVI0PngxXwazQlYfkSiJnTK5KP6lvE9R5nGTX3L11H33kmHj3+WVYN5myYbuw9fBvIu6PSxQHkg41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB/htuh/LmLMsy+Xjs9vdnldu2LPswk2sXkenxKpz/g=;
 b=YXSeREgZq4niALfLwb9Hzz1pCmD3l6a4WRR0SUA2mk+EF+YV8x/9bRmEZjxs4UBTir1eL5wpGNvqOyZHIjz6FCuQJ5+gPQ2L9czUSjwytMZViq88pWCyIR8wpE5Db5pVbZQDaAIKjfuidOJDqGdaR1u2aFOsSjW6FWi7g0F9BUcAjeJOaixUU0plt1WMZKWDEx/tzbeTtHo1mNqv+PaoQiHjCZb3Zhqt6bjnCggCbfSCchdesK+rSYJLrj0Ml087yMqbJBrjweSeziPPeAnMcOaA1hgcLtyAe6spmEAAZRAetcZouecNFAYbBp7irHCmcstTV77aYgySLV2j/Xx49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB/htuh/LmLMsy+Xjs9vdnldu2LPswk2sXkenxKpz/g=;
 b=rH0GQyVMdlb3m2wjmYtxbgCPqPHCmvIvKS6zD1ZtVPPxeqkAVYjBluavtvNAK8pAl46jMlsV2gnN7uXHLpTmgBdABkNg2Szow74XgPriklXWrHH8TrYemw9Xcuw8R1E9C0pAAhVYkxKSw1yy8tCtG59ZPYC1Mw9TPnS/YMq7S0g=
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 25 Oct
 2023 02:06:09 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::19) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 02:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 02:06:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 21:06:07 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/4] PCI: Refresh root ports in pci_bridge_d3_update()
Date:   Tue, 24 Oct 2023 21:05:44 -0500
Message-ID: <20231025020546.504-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025020546.504-1-mario.limonciello@amd.com>
References: <20231025020546.504-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a863d84-b704-4aa1-51ca-08dbd4fef499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgXl1TGbz/oRBmPT99MVuVApCIFyYBg7ur+Z/5uK3bvcjr5ELoGXLaHPvcruu2kimw0ArwNuGXo7BIA7NnBuZ9dJsL13xN3KqoXGlBiuRJYuLbqwEpVTVwBhP7eYRl72Czn/4W4CAnUw46e+eEe4Z7ytlpIMK7fua574vrCyrgoyNlFduyRYsp7DxmlfYOQi2XjBB/D4ACOIx/j67tC1tA+D4wXUn3Tim1qz9hEnya2xKSB1qUbLt0H1AFRLkPSwFCsmr1aqW51sx+vBBo0lE56JxOCX6zEtjUTF/Xe6NDS2zYL4NUpShj4O2AXqoZpnu2O3PFImobg5OmmOalgUx3dNcCwaMMuJaDx9N7/VSZnG/dd2hko7A85RLqF+vsPIOucQPfmgl1nMDiubDY5q562ZJ3kd7BUi7l6H31wh2nls/+HpR+8mq7eMFWj8KKoaHK47ZLpHmdFdaTsochPoDST8/UQAgOJdDj1p43OBoix2RJIl7WQ7ft64AG0QObZ1TuAPPJROTiIoYl8LNdetOqd9DJ19UpTUKNZKsZ3eY6SWgnv3Uy6+hyjas6BKoiAR0EgJIIGtS2EVNbqbiGhUl3SCiCothQcTjYnIlSwQwn34dpoHz/H4CesrYAE4LxEKCl7onyLoyMPlGvwWxzXOh9Z7sMi2+s4aHOVoBdFO5I5sIDvTYPFasYYQiP35A1YLP/kZPm3ynZHiPd8ysZoh0mLU7MCU7QHmzRaws6E60Zw1I2oeSoICFwZtBjfdre1OvduFGKybAVdldl/tk9nYAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(36840700001)(46966006)(40470700004)(336012)(4326008)(8936002)(40480700001)(44832011)(40460700003)(41300700001)(36756003)(81166007)(2616005)(1076003)(86362001)(316002)(2906002)(5660300002)(8676002)(478600001)(110136005)(6666004)(70206006)(70586007)(54906003)(83380400001)(7696005)(426003)(356005)(82740400003)(26005)(16526019)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:09.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a863d84-b704-4aa1-51ca-08dbd4fef499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If pci_d3cold_enable() or pci_d3cold_disable() is called on a root
port it is ignored because there is no upstream bridge.

If called on a root port, use `no_d3cold` variable to decide policy
and also immediately refresh whether D3 is possible.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from RFC v1:
 * New patch
---
 drivers/pci/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8c5a6f68f63d..28f70e8ea478 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3021,6 +3021,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_disable)
 			return false;
 
+		if (bridge->no_d3cold)
+			return false;
+
 		/*
 		 * Hotplug ports handled by firmware in System Management Mode
 		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
@@ -3096,7 +3099,11 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	bool d3cold_ok = true;
 
 	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_possible(bridge))
+	if (!bridge) {
+		dev->bridge_d3 = pci_bridge_d3_possible(dev);
+		return;
+	}
+	if (!pci_bridge_d3_possible(bridge))
 		return;
 
 	/*
-- 
2.34.1

