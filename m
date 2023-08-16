Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC91D77ECD2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbjHPWK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346786AbjHPWKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95B319A1;
        Wed, 16 Aug 2023 15:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQBetMD7mLHsGiVkEY4afevREewRf8pGzCvTzVX2B9lJT2PTtE5mFNC9roLlvBoYlwQgcBi1Sn4AlAnm8yE7am/42oc0vZcxu6Gjs3BQiLhspauS0WckhP4llVVlQGvvm0MkAnmAXM0/hxt5+PY90sXDPk/JiymjSYWpPFk95IItT8nD5/PY0Zs9sLS7iCluHCMY0gO7IWuKujOHfE9Hy5CmwQe/pdEGoFlXEcpdoGhUHXG/NMzHb1/aDLjxDpuDZ/xaod6CMGvcOWUzAUc94DIbcF1NZVGXfTHXCNE0PzPRfPQQRnJbw8p6eXriLbbdWyMLUfRMd9j5gMzwqT1H6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcPVR/SmLRby7/MkRu0jxkL7rUgU3v7HgZOuE2DbrA4=;
 b=O7STGdF4Ewh842kwJXvgA8uB16b7JOTmi9lLCXykkyQOMvS7Kh0B26zH41ySchGejRrOFdQNCamg1HOINkk4PuIcIyGtPV8xGJ5wBZTGSHrUxNyT/igBumvdwNyzycCx42u2CToCtm41+Zteu4VC9NO9t3eY7OYUDdYvruCI5nqR9M5zfWxaNaKinLEWo2qroL3SLgRX9uXN9W7bVBZ/27k5rEt1R8P1xgGqxHLEY4SqrF2Kjnnx2TT7vGr9Vrgt54a4z30StsL8G2sDmz84wA1g1jZpnoAvyzmtoC6aOU78UxPDhn8WRJxtQyY7/ITjK4LJlzs3kCi9h3MdXFCTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcPVR/SmLRby7/MkRu0jxkL7rUgU3v7HgZOuE2DbrA4=;
 b=fHPZmq/KF17Yvtx3trvdt/VpvgnoWdtD7DE+I5jw8KJYRkoAKSb0TYnSAPd8WUjbuCDRExma0ILvG0fBn+sHYKkB59k2O5eLAfBqL9sJzRw4RLG4Rg7AIuvkauzIHwJemY2duXfv3vsz21hjX6Y7ub9RtSI9KvImOZJJw4tF1fk=
Received: from CY5PR15CA0211.namprd15.prod.outlook.com (2603:10b6:930:88::13)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 22:10:44 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::c4) by CY5PR15CA0211.outlook.office365.com
 (2603:10b6:930:88::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:44 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:42 -0500
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
Subject: [PATCH v12 6/9] ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
Date:   Wed, 16 Aug 2023 15:41:40 -0500
Message-ID: <20230816204143.66281-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816204143.66281-1-mario.limonciello@amd.com>
References: <20230816204143.66281-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7dc310-3f72-47d4-cbaa-08db9ea5a2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmX3pnZX2z5cNz3mURTsVNIsNezXrDEmR/rKL4qHTdQ5l0NW0qfS6EcsP+7XLNIccl3Ce2vttXwwj/vYk18BDkZr/BTqlBIyX3swIsQoIhafhKCxsFacN4tWShQNu1gAhCjA+Omhf/cVoOe8+W/WPvMFK5HajX6uTr6IHKAJHVJdOcju/PIULL6QRGEFS5EoilJUV8B6yufUWn4QN4TMNTPN+nxzl0/ndz92q8m6UukjuX9QPla8nvch5dGH6hPpxIp7D8NxqcFIcU/Wc1jW1sF2iALMnUEwFMXqhVK0vqHswJhL69yELZidCyKPrTfB1GmpFeAC8etuEFxXSewgYCLEHvfx4Kq6ZK+/Rz+UomD/5rKLscBRbN7vngDlW7masMHh7Jht2sgazbw6GOvTcN/nFBoEKJ+eI0Zx/a2UNI/tbHPwmVjS4MH2JVhG8T2DUsH6H7N+CKIwMsYvDm4Bdge1MOTBr5deya2WwPmNhbqSSBCuZDwwytLeqZ9LjgHMMHocvri4J0Ydik0Q1+euPaiz5QoTKjVO5pFFXLC0h4NLLow0ciGr0S4Bnr42LFxk16Dv4oBsDxGsQ2Re27H6BwW6/pkIzd5XlPnjauRAyYiHTiLHYrWU1g2pF6QGB+7wAlSr3ArdHCH4JoLmXr6w98Ntzzc+G+u4w92DXePd1csLGX6Eu/KLNqDa21StqEl4GW2jW1pS1oE6P2hDR0y7cSn5wYol0dkBsSUJLCcwSpPoZT7ykjEBHFU1450iLAZUj2+pCsuHHdKJlVPPbRC9mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(4744005)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:44.0242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7dc310-3f72-47d4-cbaa-08db9ea5a2cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
index 290514c21bb90..b8b3151215f0a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -166,7 +166,11 @@ static void lpi_device_get_constraints_amd(void)
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

