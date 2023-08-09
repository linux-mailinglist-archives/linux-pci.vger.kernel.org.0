Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06677691E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjHITrg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjHITrb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CE2139;
        Wed,  9 Aug 2023 12:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jhquoon4val693ZryQIT0oDdTGUqKtBj6Fu9A8+6UmyUwq0WScn5WCg66JJZ9tuWOylgVCmgqvPxu8GtbsOlfE7d9M4gaAYNU9Gaa7PM3vcyegjOnPEUU8YxDmQK8CWgoIej7vewj6VPZU9kdrwUGJUNuzufBb2mi68z2u48P6Xat3XWvoLJ/oukOYHpxZg55p2w6QYIMyRT6SKswQOupZERJMDPcjcrbTEqy4Ocl3TkARBcgXROM/YLRwda8+bgDYgKRfcT6Ipjbp4Z0aIUww/18k1Lt5qyznuat39VlnTyVoGiqnQe5bthkpqtweg8gfqcJo2rrJQalIfFGqzWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Buh7vRqbmd7eHrsaIoJVA2qwwyxu27Pby6rpmQDTkbY=;
 b=ZUpD4FS+caM0HC8bqkdc8Ntx7tilQSBPgnMRT9PYdvts27ImZTF8Dq8fLIaRPRSTQKT83vsA5kq/afgGxxAep/jySri/IuaGmGhW5uuRNtrhs7SlBsw3xaOJlkx9p7ra8d16n5dDVvINdb3YA64EvS69x6FRVQg2vUoV7XXkYhyPWJ3+cVxtM+dGWMITliPPs3rAbgknruAxMk1bV5fzSBbkNncKw8QLlK18LHUY0yrqPleNSyRhgTYUJu4xlxt/j9Q33rxAPykzwxpx0vh9wXbzLqXG5hqdiXOlsuxM4unnhJBHrjovap04vAFQXKn6BFlmRAX7DMMn2iyLsr+eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Buh7vRqbmd7eHrsaIoJVA2qwwyxu27Pby6rpmQDTkbY=;
 b=KQEzesYCxBPv5ncJHTcvinj9RrJ4Y8Cc7hli6yz+YozeY/9HestACAWNGgB2bQOq5zbxUOFDr8VWL9mmJjcdP/vYthtMHJifuOLXuivnRwymyOzBTpyQjvcW4dbeim2V7rqq1j5bV3+XQAYMiS+u0J3MacNokFZKqyDin0pnTVA=
Received: from MW2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:907:1::29)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Wed, 9 Aug
 2023 19:47:17 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::7c) by MW2PR16CA0052.outlook.office365.com
 (2603:10b6:907:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:17 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Iain Lane" <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v11 4/9] ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
Date:   Wed, 9 Aug 2023 13:54:48 -0500
Message-ID: <20230809185453.40916-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809185453.40916-1-mario.limonciello@amd.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: b11a1106-b242-48a5-5555-08db99116fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5ZgVE/vfnAjhGKm17uCC+/A0LTpKG+9kTHs0VqHBC9VuJ196ryt3t/vCRx6RBa7NFK3tH8RrYyPzifbfmAm55d8bzT5C820Ik9RMuvltO861JOD6f28HKCRLsoAmpufYtNiE7XHJ2TqgZiL5XNGVrLDbw/xqHI1Y3ifhz43PnSiWHczYS6buCbOfniNwp8rvLVO3OGzkWq4ZrgvNCFsrcAsWWyp3G2chnyQiJ0RrTMXvzJtxdpYh8MnurF4zq36r4ZIv6FEI2ZT8pEtIaHXxcCaBIFT3YzcfKsqUOib9tkd08dhiXZChnxxe11aRyfuFoizmXuKjbKaahHgDywXY6EmlPkZnj9WHRq2uxiQBpFrDeA3b9kVy9QMyHEec8rlPcyHVkDRCJmnPXle2lqWtnLSEE9vhiUvAxE4XdwaGkXIpXRGfcNJN2E/dXZJTdnJBexjt6mbknUoSKNa91LUJLOXH3HukanGuD2rr4Lt++LDQl6vor/0qVAYyAsrwMQzljn1DQmgLqAt2H2NqSvh1IXUNO62O7WxmsJb19E8b4MqxCE47mRCctxhOG43VsJRuqVSETm0X1WNaX9WP6hFD8ouTwpgqEYgJXNeh7U/Rb8eGS0Y77AxnyEhaeR6lupXtkdGgRlPCEDOzmNKHpxgFd7ttuPruiI6lMd+xDsm2jVnYxH1Qk34OowCoj5LB5Gi5w8d8uxaJ55wMO9CPxhH73oUa5LJEFsDn1BSHRWxM70vKa3ZZi681Gdfm09sOaL06uE7iM8EesK4nmU4nXQ5Vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(1800799006)(186006)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(336012)(2616005)(47076005)(356005)(81166007)(82740400003)(478600001)(16526019)(36860700001)(83380400001)(426003)(40460700003)(40480700001)(1076003)(26005)(110136005)(316002)(8676002)(4744005)(4326008)(2906002)(7696005)(6666004)(70586007)(8936002)(70206006)(54906003)(41300700001)(36756003)(44832011)(86362001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:17.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11a1106-b242-48a5-5555-08db99116fcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While parsing the constraints show all the entries for the table
to aid with debugging other problems later.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9->v10:
 * split from other patches
---
 drivers/acpi/x86/s2idle.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index b566b3aa09388..91cd6f8b8ade0 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -160,7 +160,11 @@ static void lpi_device_get_constraints_amd(void)
 					continue;
 
 				acpi_handle_debug(lps0_device_handle,
-						  "Name:%s\n", dev_info.name);
+						  "Name:%s, Enabled: %d, States: %d, MinDstate: %d\n",
+						  dev_info.name,
+						  dev_info.enabled,
+						  dev_info.function_states,
+						  dev_info.min_dstate);
 
 				list->min_dstate = dev_info.min_dstate;
 
-- 
2.34.1

