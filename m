Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C952B770A47
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 23:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjHDVCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjHDVBz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 17:01:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB54C3B;
        Fri,  4 Aug 2023 14:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNBU57HQLJKk6rxIrR0BLdwyJZHtxQ6PfoLrK5qyofNdOJG4k1AocX0W6r32JilOCHJdxR+O4UhOlOiKlo7JYhgsN/GiyNPTd/0YoAyW13Bn0PIg9K9p1wptlVCndroRylVWfGkWv88b2YeUNciHvEcOATP1jOCC0qerY1cTTMI9XjYqF+QQyVrYLw+1n+Mp7BoFQO8RAUi0TxP/jA8GtaC1VRaXhO5xUpHQ01Wrhrqq/gP2E3XN9zG9kmGbONLQye6f0PIGsZ3pqMecGfh8XPxOLDUOPO7BCq69q775rICW9gjy+GMckmTjUj5Fuc39grHcjDNRJMJwwCGMp54s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Buh7vRqbmd7eHrsaIoJVA2qwwyxu27Pby6rpmQDTkbY=;
 b=mc65TaPZy4PYoqyrEHppEgFXGG5KClZn/szg+a3sDSdOmI+1MLaH/flj72bJIsFGmzEtAhI25k7FhvwclGdPppO2xBDXbafkY8H+Ilj3LXJYfkhfPMVTx+IE29ef7skTe+WkKqpZn8nqXSV+65xoqlEpXWuHokQEYhkv1+M3qg2dXGVST/zMvlA179KBcUDIf+Kc8oVD91HzLkPXYjlMgFfHw1G1uUOPA53yUZJiqHrw8Qu2nCbO/k8roDj+te4WVXvckpDoTSWHQh9afq+BTQ9YlPV/V3O15MsCwSbyomYb5qRgCCMCzZ7mBMpkRibIZtm6+eMl9fDaHMM3tIhJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Buh7vRqbmd7eHrsaIoJVA2qwwyxu27Pby6rpmQDTkbY=;
 b=3hiLZJmWvSNZy/g3PfHbAYSOFnyKx3fCvYZeQgmLpnaterpwMRA+4tDvq/dEKQlSpsfKm+9gDnHvUnhv4a0T5BhP3AbfbKDjUqTRRKM6pwcsEHmrFkSGRCNU2RXa155fFzI6eWeXGt6WBqkWbnKZ6Y1xaKBx9An2Ntl6yRTy4Bs=
Received: from CY5PR14CA0021.namprd14.prod.outlook.com (2603:10b6:930:2::28)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 21:01:47 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::1e) by CY5PR14CA0021.outlook.office365.com
 (2603:10b6:930:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 21:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 21:01:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:01:45 -0500
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
Subject: [PATCH v10 4/7] ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
Date:   Fri, 4 Aug 2023 16:01:26 -0500
Message-ID: <20230804210129.5356-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804210129.5356-1-mario.limonciello@amd.com>
References: <20230804210129.5356-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: b43397cb-cb54-430b-cb6e-08db952e03e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnbziZ3OBHj7t8uN5Vzy9qL1b3GrJRm3YM75W0ou7vlgEZM33lIUqqKql37rx6n0IFPFxtptLFNW1QmxbprKmzFC6A3PM8CtjKPqEp/NCoR1rPKoVYbujH9Q3qxlLHS7HP+rg7e70DKE0cPhIHJXaqHHCCvynIuw93kq8f43jAx3gn6HL+c3sehw29zriUrzE9uC/SmZTa0nWDG159wOqYhlMu9gWWgPc5Ak39mgReO1q7Yd20DdXG9w8ieyPwcCbgCLf/QCETtiZntKopHgZYFGb2vPC95Ws2LUv58hpLpV2KGOUHTrrn/KuvLkn9DXYwx6+TtG9M657bQETT6MWAnV7CstOKuvpJ5O/uBLLxrzSrSYX9lyYbtBpYtvJNUrMTUEdSapaEhcteqcah2wRhG5MBFSj2WJQQL1hFTAlDo4X5vCkV8X7l+YF7t2rSrdQeWzcqmnLhr74sKqw0XyVAkwcitmbw84gpGHzPmjmFt3AVfYRVLEK39Zt2AolzdDckoMrqs6zoBHjmyzqP39KYi19fY0ku5V3N4NVm+aDrceGzKkIwuCvDvW7q1LYWxUFLRGPVDc2EXEqNJ7Dd+Sue1R3ffTRwuzfVoGWH4/vPvfRDMrxvO7X34IUrK2yw28ENSHNz9kScAj5zP6MXJxtbaEmr8GkxiMTZBRIcfDahn7L6z5OJCVgfqXz/ldZrRig+JHpgnN0Is8D4C/uRjy0Xlav8zYjXwsl+4qUPmggkRMn3dF8aQjDCg9+3SE0cTGx1PGEl5evx5cQ2atytp6OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(82310400008)(1800799003)(186006)(40470700004)(36840700001)(46966006)(40460700003)(16526019)(83380400001)(426003)(1076003)(2616005)(336012)(26005)(47076005)(8676002)(36860700001)(316002)(2906002)(70206006)(81166007)(5660300002)(70586007)(4326008)(41300700001)(8936002)(44832011)(6666004)(4744005)(7696005)(54906003)(478600001)(110136005)(40480700001)(356005)(36756003)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:01:46.8807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43397cb-cb54-430b-cb6e-08db952e03e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

