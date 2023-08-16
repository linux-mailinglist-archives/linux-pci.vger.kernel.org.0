Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B4677ECC8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346792AbjHPWKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346787AbjHPWKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CC26AD;
        Wed, 16 Aug 2023 15:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCC1LSms9VDbi07R8q/z7A1a/4a8/6IPWWYOJyimtGms5WycYqRBPPi5xIaSNJ80gapYXm9GGkvepxZ4L4YNDH6a0jpTRXJuzdVe9GemFBVFOXQG9K0j1lwK40C0xhstyY7hjhOdepjJBSImVG3OlrnKestxzIuoyak1SBpOfwavn7t68FzyYgSsUFfDJNYoNgsN1sF47SSbw+DY5wcHTGoWDBvCfAbxVnhhgLXi3fzSX/fIJyD9fAHLkHhfbya3cZg/rfHHBKVVVRhiiTWJHvjS4N5GwlWSCX4DaJ7OpUaDB/UKzlLGHT6fmVfS86LBrArt2rQyJl9KLwhoyqsWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJcKY+uKW3wE4TuJNRk4uzTjHr7jUaX7A5i8dW7EEu8=;
 b=PuXvzzyhLf5TnUpgrS+hieDqn78OpHoyekIEFd+r8+BDPGFcFHuVhhpKUqjAXwRh15u6AdDQRu0Jj+Tp0/Wcp2iw+cxuM061R0/c9HTzG1vxnPwHBB4iCTF4pxqkMrXlToiA3PgrvC3mhHX+SGzwyNduY/FYxXG0GSQ90IJslIKp7JNg9UtOwzDPyJubA1GduEcfjmwdiWVjSPZR9o/1qwjAwyuHZ8NPkoiun4mcmcSlUX53H563SA+WONTKmsqWu2LGUi+RjNv3UKIsyF2wmKEy24CTBFHMrxJn+tM+FIi9xuGBmvqVkDgVB8fd14qLt3RXhXnk9Gotszz3SK+FqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJcKY+uKW3wE4TuJNRk4uzTjHr7jUaX7A5i8dW7EEu8=;
 b=DNyuH4UYAtFlSVbOxy8kcKiQ7LdtbSx6N6VL4cRIBR0AlWqzi4OJFqtvUlnPM9LQP7ErT/NRKIo4cf/SvsWsmAYFH4VBIhXXH45kUqwBmc2mBTXh86FhdoT3i3EqBCgPu4BuYhkTRiOmhEKDqtYapCXhkYCnZ5ChSC2l+ZDy++8=
Received: from CY5PR15CA0220.namprd15.prod.outlook.com (2603:10b6:930:88::22)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 22:10:43 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::3d) by CY5PR15CA0220.outlook.office365.com
 (2603:10b6:930:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:43 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:41 -0500
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
Subject: [PATCH v12 5/9] ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
Date:   Wed, 16 Aug 2023 15:41:39 -0500
Message-ID: <20230816204143.66281-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: b3036c72-5c4a-4489-d28d-08db9ea5a231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MUz6vukEVqEo0KGcW7XgyNkZnWIU3U7wnGXViSDVJOskv17pWOmEMoX2mTab58LI8tO3lvsYiqjvbGOcizdOSgOG62C3U1UtWWkqptbo/QG+UKlQL7Ji/b03EHMLVwzbGJmFfxvZVucl6l+8edpSObcEEFQJh2JKrNui7pSQInMb4bEoyfG+O44rGeFNlxcxDU8CCEuFm7xKXJxtHfNi32br5RouozHMIAOCZq6ApB6ausLjheEmQGbKMGfXstfPUr+y7d5CVS3M28uFU/O8zjF6dXN4J21wwR3oa2ijjR1b7p7ruuINkei2PWMyGd817A3vCvEpJdDWb5aGn0ig/afTECD0uDNyekQ2g1rDrhCEpTIuCbqbShAvgmus8Njrl1Tvr7V0aOWFlXH6dXrqe4nhEk7rYvuzY50cKCCjPo33cQ+bK20EO9eZGSkGPpGOCTmOoBuL1lmIs1aQaLKYdEKzjS6/6RtJqpx1vYey2KzVaD29IV1FAwOM6E4UT9e/NoItxpGKS6CkxdfWG8tuduZRS47NVdHtrXCGunbWH3wUVvTT8ppoE2j5FA7eZF8FcSmhD6pFfj3aSI/nCVl6x+Kcd09+iNuLrZULYnMg3WWlnYltSSyZ9TuRiI4Ln2EAFmwS9T2OMvdEkIVUg6Z9TFsme5U1yPDvkYKhN44cjICsPwYEjbzclJo/iR/k/5NeNif8PLqOKrND35huGBRJKokac7JY/PP6z11Nmhm7Jjp/VqAb+KyKhXd3ka9siHcEGiNhdXwsZ7eTnEMeJvXPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:43.0086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3036c72-5c4a-4489-d28d-08db9ea5a231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/acpi/x86/s2idle.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 508decbac2986..290514c21bb90 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -135,12 +135,12 @@ static void lpi_device_get_constraints_amd(void)
 				struct lpi_constraints *list;
 				acpi_status status;
 
+				list = &lpi_constraints_table[lpi_constraints_table_size];
+				list->min_dstate = -EINVAL;
+
 				for (k = 0; k < info_obj->package.count; k++) {
 					union acpi_object *obj = &info_obj->package.elements[k];
 
-					list = &lpi_constraints_table[lpi_constraints_table_size];
-					list->min_dstate = -1;
-
 					switch (k) {
 					case 0:
 						dev_info.enabled = obj->integer.value;
@@ -155,27 +155,21 @@ static void lpi_device_get_constraints_amd(void)
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

