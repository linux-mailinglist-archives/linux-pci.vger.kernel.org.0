Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EED781380
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379696AbjHRTkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379671AbjHRTk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E91421C;
        Fri, 18 Aug 2023 12:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmVttqhinbb7JRZEuLIvG9KGafV16PyO8zndIZCJXoedIAZeLu0AvGcEd3+hF3N/j2qg9IOcVpScFj/4hz/3YOWTFMrSX82qcrNtUvhHaOIO3TyV5gsEaklcio9abVB9leg6BECmLGI77rDnVlKuuNFPas9lJM7UcCPQ3O7dXR7MBBwRcRZ00+yM6B7NtXaVFuAz1RExEmOtBbTKywKD74CafIn7YCaD9BN8kF6t05ARWJdqiB86VfkKpdr9Rr6YIuOAvf5wD7wQ9iT76m1X/rW/EqUYEJIHdMvE/lS+azR3JkRJ/uadGA/XtPpoVKhZOxCyW+vXu3BYNmf/Mm0w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IzIfll1akRPaWeOdAZwh2X1J7LPiGKGIf/2dea8czQ=;
 b=EWoDsJ2EOZ8fTOVmFvyPJ3FyoN8I88jBDdsARuWvs3o5ryNC93+TU0LUG8tzp4khdFBg6pcL7GHli3n5FI0Gyni4IjS9wjJVTFv97nZ8oKSIEzBdjLSjzPfOeR9XtaU8FClKxxlYD4nZ3BXN5sfIq1uUawW3VSM/RWE3FKyjKAu19TPz2I9vVK7CBwYf5DWtT0qtB030cv+EV8gu0OUj8tzwAnVocB4ggwBSdXV72S48zogyA5MuMP/Kv9z8sqPVjGNAQ/Nf2WIdICM5VMXXEjYj1J8MhHXvzdYb84BjHUxpM/0jy+U8219ExGLHqiuRDXAieFdmyTWJpvLvx9iQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IzIfll1akRPaWeOdAZwh2X1J7LPiGKGIf/2dea8czQ=;
 b=EuBsYx47WTA7IddSRm+qfSRy9dv3LHB+TwcMvshOj1zI4LooFBaW97KA41+kRCDvz9D+mvsIS7AoVS8k8m72CZbJpxu3MecNrOwumyZC2UIE3yyMFVdKJocVKKtIQiT3I9Uepf/YXNASn60hAFgCxjdjxf+0Xv2XWviOG8DBt38=
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 19:40:24 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::7) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v14.b 4/7] ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
Date:   Fri, 18 Aug 2023 14:40:04 -0500
Message-ID: <20230818194007.27410-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818194007.27410-1-mario.limonciello@amd.com>
References: <20230818194007.27410-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc80f41-b62e-44d9-79d3-08dba022f6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a50D0SoZTeZ54cm2r5BGyl6+4pRJQ6xx1WU+8fuKu0VWKAVGV4BK9R6WBO9XhhT7EF7+UGBjFsh/8/mS/uV2sBHXJlF5jpy22KOsfssgpE14vizKBsx7k009nHeEbjuZr5M0bmHR7JQG0gRZ3SFdrBk/b+X/L8acEHDW7hWZ7tFOfcDOvADuRBJql4E/9IiJTckglIHJqYdZgaVQfhZ9dSR4O+Z8tj5gl1V+W+I9A4mY1K0H72HyZ5rWCBeJZn9t8GoX2pWpz4Zj4pv6TQEVfLs9eIrV+/gQNemtbfw8W5bkMJCFexhEVmt/J9LwG3konsgFkNW5Bm5MDmEVRfMKLAAG+2DoaEwzYCAeOVVlUIVij1AuvYQfrUmFwYSugzjCA7TR1eOSV4ccf6hser++ftz8L2kso0JO3/Wb77+ZHMvnYpxts8/NMkMmMVCok+0do+LyzMm1H8ZnRaRAjU9e0iz9EtRIyyjp7PrFQOReLVMF5wGAaYGB2thpIy+bbVZJa5/7IgrwMvKBQeBcl6ZzdDlbik8bf3xDZMZ/LrzlOz/q//+mtLfXTx7o22lsdxuxdEdynckaZEJWSLGk/ae4XpuG1Wj+1fBFo9xWh97x3is6olJQfd0fKlh6nVfvjsO7W8h72Dw2XEY78d4rAuhh7NfQjFz3jXRfS4SN00kFqbp2srQliuOJGRxBoky0eoYeGCHcdLXg1OQCxwvwQXS7HC3aYqPZoKogtU0h4e1sRqCgBr/7+xUA/uMRjvWOJ1ZdE7tzYwOwNVRtR6niBUqi8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(86362001)(36756003)(81166007)(82740400003)(356005)(40480700001)(5660300002)(2616005)(44832011)(16526019)(110136005)(6666004)(70206006)(70586007)(316002)(7696005)(54906003)(478600001)(1076003)(26005)(4326008)(8676002)(8936002)(41300700001)(40460700003)(336012)(426003)(36860700001)(2906002)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:23.3232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc80f41-b62e-44d9-79d3-08dba022f6ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The constraints table should be resetting the `list` object
after running through all of `info_obj` iterations.

This adjusts whitespace as well as less code will now be included
with each loop. This fixes a functional problem is fixed where a
badly formed package in the inner loop may have incorrect data.

Fixes: 146f1ed852a8 ("ACPI: PM: s2idle: Add AMD support to handle _DSM")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11->v12:
 * Update commit message
v9->v10:
 * split from other patches
---
 drivers/acpi/x86/s2idle.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 508decbac2986..60835953ebfc4 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -135,12 +135,11 @@ static void lpi_device_get_constraints_amd(void)
 				struct lpi_constraints *list;
 				acpi_status status;
 
+				list = &lpi_constraints_table[lpi_constraints_table_size];
+
 				for (k = 0; k < info_obj->package.count; k++) {
 					union acpi_object *obj = &info_obj->package.elements[k];
 
-					list = &lpi_constraints_table[lpi_constraints_table_size];
-					list->min_dstate = -1;
-
 					switch (k) {
 					case 0:
 						dev_info.enabled = obj->integer.value;
@@ -155,27 +154,21 @@ static void lpi_device_get_constraints_amd(void)
 						dev_info.min_dstate = obj->integer.value;
 						break;
 					}
+				}
 
-					if (!dev_info.enabled || !dev_info.name ||
-					    !dev_info.min_dstate)
-						continue;
+				if (!dev_info.enabled || !dev_info.name ||
+				    !dev_info.min_dstate)
+					continue;
 
-					status = acpi_get_handle(NULL, dev_info.name,
-								 &list->handle);
-					if (ACPI_FAILURE(status))
-						continue;
+				status = acpi_get_handle(NULL, dev_info.name, &list->handle);
+				if (ACPI_FAILURE(status))
+					continue;
 
-					acpi_handle_debug(lps0_device_handle,
-							  "Name:%s\n", dev_info.name);
+				acpi_handle_debug(lps0_device_handle,
+						  "Name:%s\n", dev_info.name);
 
-					list->min_dstate = dev_info.min_dstate;
+				list->min_dstate = dev_info.min_dstate;
 
-					if (list->min_dstate < 0) {
-						acpi_handle_debug(lps0_device_handle,
-								  "Incomplete constraint defined\n");
-						continue;
-					}
-				}
 				lpi_constraints_table_size++;
 			}
 		}
-- 
2.34.1

