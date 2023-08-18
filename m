Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDB978057D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356752AbjHRFPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354040AbjHRFPG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:15:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5712710C8;
        Thu, 17 Aug 2023 22:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUhzsMA7Elxcs3D9RlLL3+UmcXs3tA2mlgpSm97IS8qGFynk0ciqZwz18nIbpGcReQoKoZYQImPn936gfyBfohGZ5oGAJbWUlFckyHMqQpJznbz5hN+uA4/YQOeS0AsXNeN4w0podqfS5sYrd6DQEESZ+mkLC6I9K46M/3iqBIA/s0ClbLzlniBW31Yjyt2Sduugp+faxJL5p6WUsMGVrS9ijqColTLKJYM4evz1n9s4IqonwwxhsEctXHxR5EOywENuYhit5HC2YkyPjiDdv9U+rUa4DXgqwi6KCKJ1coMJuL3qnjQGzyt/04VRs9OQe4D/+eBcJHRZEeHvdmEquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTO4xoD0fKS516BA38NxupBB6hbMB0PL0ryX2H7CEcs=;
 b=ekGn2jGB2TSk3P+S80O0As5c3sbFGm8a1OGlYSvuxVbA7APkExhyVwZkf2/yX1pF+06Ys5Ox7lONVbla6rCxZhrDpxM9dLNatSvHiPIEaEJuQNf+1yYJkpoJzYqyjF3gw3hZALD+gseINy6sRSxIk4UI1ltHn+7Y1aG00o6IPtaBDOdHpfqP7DmqCedzwD1kxS4UHBKzzLGkfCk7hQ9D69WUBUyuUQKvlwFLXnRPuFFgRbEl7X/ypStBC+7t1hUnMbqeYxni9J26oTz4bvSI0q2EQ16ItU6GCjy3kLzzAUChocUJPf+pKnuyKhiCUswN0FFim3AaYA23vmw08rFLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTO4xoD0fKS516BA38NxupBB6hbMB0PL0ryX2H7CEcs=;
 b=usOJ8fdmhbe1ADLX3zEg5z6kl8oEI1Fd9oAn5/aVH/XkHcswxOQ8IxRvNsTC8ewhFlg3MCgMrG2ErSIr5LtVSudigER2miMYd9jD/jAnIg4MbmcUfldILQv5+BPNLSZSj1HWKPavGzRK+TWUWTvFN8O5CG8bUoj3n5+iISDwJj8=
Received: from SN7PR04CA0062.namprd04.prod.outlook.com (2603:10b6:806:121::7)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:15:02 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::71) by SN7PR04CA0062.outlook.office365.com
 (2603:10b6:806:121::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 05:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 05:15:02 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:14:50 -0500
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
Subject: [PATCH v13 07/12] ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
Date:   Fri, 18 Aug 2023 00:13:14 -0500
Message-ID: <20230818051319.551-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818051319.551-1-mario.limonciello@amd.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 431d71e7-afbf-4b85-c747-08db9faa13c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaUbiuZZGVTrPbbdHdwAME1gdHWcbhFM/Myz5jQqPH+VlTux4pavb1hNzIazFFDSuVyzVdLe0r1H4MvsChaMjoEMLYu5mAuphaPcwbZrIYmoz6uu1o1fuh45eC3S7rr7SUDIpI1lArkvPwG+W/PQVLCyjGU2CAJpiby1Umdvq6hd4EuPH/fQjkoRNPXcjmuYRfnAQnTpho/wd58x4vS0oKBtUkyVcDaw5LQuG5sA6EVc3hf1GBZXeWkfJEJF7qhc/8l6rVpOJQ6A/1ueMNvCN99aoImE5LB7fMvFfKYLEsZvCScp9hadsay8rb1wbPdexa8N8cehYpF4XL8arxwrszTSLtGrNruXI6ZOwqi7/ViPD7G/Z9wgF4HVUeeIXj7u800BqQlWrMOmwRD/kptEex6wJI8BrAWAdgJDw2sTxZlJ5/vMGsWNAltI1GI20hIP0HOXUuAiWQFRoWmrRnQLXFmYWDo482wvz6vOr83yHZCjPtAV+CvmywUB2y54w6wDq3Fe/2ZHuGulWS6+ipdRTp0t53CCdc965vsw7qwC1B9OiA1m8AnvrJihtlLYKuHHEqkBZ5AJ+f6+wFfLjKjNh2H/EV6PYp2Ih2Tynn7ZzIf3Rf6cFMWA6U+OjDw3uqwXoAewRGCBNabRBKW8BRMSX5F/uKy/XIaZIquQhX47IV7in7YOmNAwg8DyIod2LcXDeWoGyrsRajGIY6jKJMeYFYW6/a2yrXLWtjH6fIvCOkYp2Z2muPeEWjQy1VrLFdq55z7XLnWaxvFtY208g/eRZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(2616005)(5660300002)(44832011)(110136005)(16526019)(70586007)(478600001)(70206006)(7696005)(6666004)(54906003)(316002)(26005)(1076003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(426003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:15:02.7417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431d71e7-afbf-4b85-c747-08db9faa13c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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
v12->v13:
 * move location of the message to catch non-enabled constraints too
v9->v10:
 * split from other patches
---
 drivers/acpi/x86/s2idle.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 60835953ebfc4..87563337a4786 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -156,6 +156,13 @@ static void lpi_device_get_constraints_amd(void)
 					}
 				}
 
+				acpi_handle_debug(lps0_device_handle,
+						  "Name:%s, Enabled: %d, States: %d, MinDstate: %d\n",
+						  dev_info.name,
+						  dev_info.enabled,
+						  dev_info.function_states,
+						  dev_info.min_dstate);
+
 				if (!dev_info.enabled || !dev_info.name ||
 				    !dev_info.min_dstate)
 					continue;
@@ -164,9 +171,6 @@ static void lpi_device_get_constraints_amd(void)
 				if (ACPI_FAILURE(status))
 					continue;
 
-				acpi_handle_debug(lps0_device_handle,
-						  "Name:%s\n", dev_info.name);
-
 				list->min_dstate = dev_info.min_dstate;
 
 				lpi_constraints_table_size++;
-- 
2.34.1

