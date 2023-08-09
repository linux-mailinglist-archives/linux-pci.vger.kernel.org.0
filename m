Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929B8776916
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjHITrh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjHITrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DF7213C;
        Wed,  9 Aug 2023 12:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEMODrSPbWlwGmzk10IcYZAjqDTzLvMGdnPpmpUdu3HBtmE01Szb7F5Lx/dmI1CEJHXE9plZQG/j1Py0qyHVZaFQ3gHRbeMbgsZQkI85vdaNoCbKnTiEyYDaX1wfnNxnFJn5Ack/bsFA3i86AEnw/l8Fk5MhK1hqE3DGv14Yg7jqa5dgizZ8XZuQ84t+GVm3zjNyI0XrdjvXxGRGojdbV6WqyVBDuM04UFe2coy5bVU4wH3Tjhe66UiYRe3GQ7BC2CK8ld4vOpBdi49ERg5BXMcww4ji4lNLo0/VnlyIZk/VsWizobe6RCtHw8P+WoF915FlHHQPBU8MTKT9YEoMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+TY3ImzioxIbedi45ZnKUekgHsOAKUBzr+1AI1cdws=;
 b=ltXweho05GiwCob3wS96eJfLwH04ihc1KEQTyjCcPilWNxK1MYxzZl6/lxXN2p2o6AL3ki1xm+azdml96mUEQuy+FXZeraDzdPmwAu77gK3vbwWSkIU27TJnuIwzp1sUSONtzeQ6+i+k/FmIO1qIZ4/tTSvotr3acgTFJA7fLY7VA5HclXe4x1kdnNItrFM5XaMw5zqrjhhk9EyfuNvqP6Z2jEdrfnmY+1NSn3Q//5Ak6VKjn1i+1vkluiNHl2w3i4z+edb4y5ZZnksBNVYm6iMrnz36SmGZQbdHlid3wKPeDBZGqG9tKHRuL3iuO53oHKRF/vtzEw9n/TOaIwV6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+TY3ImzioxIbedi45ZnKUekgHsOAKUBzr+1AI1cdws=;
 b=bj77V9xTLVb7SXRJQE7C2gYMEmF8xvI43p2AG+zh9gqBCWt/BvCRkMl2+kw7dsPWZtkjWIFSfBqnrOb9C4wMGt1calT2Qhs2kpuDEbe4YKYSLzqKcLBTs653dO4VgeHTnN3XZ1ZKviyRAoiC6PkjUdcR0VrFn6m6Qm36LtYqOZg=
Received: from MW2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:907:1::14)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 19:47:16 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::f2) by MW2PR16CA0037.outlook.office365.com
 (2603:10b6:907:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:16 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:15 -0500
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
Subject: [PATCH v11 3/9] ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
Date:   Wed, 9 Aug 2023 13:54:47 -0500
Message-ID: <20230809185453.40916-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: db191310-0d9a-49df-8044-08db99116f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4pzeMg9YNld/4TF9I7aBnTfQ8RvLhs9G1wv1VyOJ2tnU53CA3TXY+mLzgw5/pV++7em3rMtSXBLxPquSZEMWDF+ksABpPmfwkjhgW4zvrDREyOL1pv2Kna3lBjynQMMZ7z6wvdQ0s9C92wfUwzPauvxtTAGHONATEl8Mrwd0e32KBvD0C+P8kmNrpPNntLsX67snq4G7hyMayBH9ShK+P7VoPBl4WAfYYyk6ommOZ8CGqeZIymTiVNAtXWw0sYLtVM0ca3ADQJsmcPu+i+12q/7pGtpv/zNNsMv3prfXIGyC+qxfIHuM2m1ke7M76NNAwp/pQ9oaxVGmlCA919pkIn5GwrPbj5RtKeHxEM1QjiC3r0ejEEAb4+lbIw3n/rtfGlKw0iyNpqriMGR97N/+KatoXwTIm9Jmf7Oho6OPdTrPRkX/5dLflm9P13JCxPqH7OCIlWh93QEDSWmb+nHBY+NCFyZiJmaXxHazRVAgZYepDV+jUpxPRdpsQSbFxhQSCzoJ69FHYhYtToCEz5Jf0JySD71B0P5aKz4yjoGmElrz16pYmHpbp14qJfxEMWjSg0MoCnad9k92T6RB/HNpf8/so22BqVvVtGRkOEqYn75VRLHC03TIaBz1++LWvC9EDd/p8s4wG58R9tsr7k1YhiAl3CWO4vp4hYhHa6n5qt0EtkPsU8TwOryG0c3PPBasC+z8Ri1x/kad2/uI0mpMdLFFtYnf9I3EDgWvuPKXtD3FYV2FmMtIoDjwd3iC/Hkf9Pa1F6cAO3GgFtUDc1RxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(1800799006)(186006)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(70586007)(54906003)(70206006)(336012)(16526019)(26005)(1076003)(110136005)(6666004)(478600001)(36756003)(36860700001)(82740400003)(47076005)(83380400001)(2616005)(426003)(41300700001)(316002)(44832011)(4326008)(2906002)(7696005)(86362001)(81166007)(8936002)(8676002)(5660300002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:16.5247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db191310-0d9a-49df-8044-08db99116f77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
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
with each loop.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9->v10:
 * split from other patches
---
 drivers/acpi/x86/s2idle.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index ce62e61a9605e..b566b3aa09388 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -129,12 +129,12 @@ static void lpi_device_get_constraints_amd(void)
 				struct lpi_constraints *list;
 				acpi_status status;
 
+				list = &lpi_constraints_table[lpi_constraints_table_size];
+				list->min_dstate = -EINVAL;
+
 				for (k = 0; k < info_obj->package.count; ++k) {
 					union acpi_object *obj = &info_obj->package.elements[k];
 
-					list = &lpi_constraints_table[lpi_constraints_table_size];
-					list->min_dstate = -1;
-
 					switch (k) {
 					case 0:
 						dev_info.enabled = obj->integer.value;
@@ -149,26 +149,25 @@ static void lpi_device_get_constraints_amd(void)
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
+				if (list->min_dstate < 0) {
+					acpi_handle_debug(lps0_device_handle,
+							  "Incomplete constraint defined\n");
+					continue;
 				}
 				lpi_constraints_table_size++;
 			}
-- 
2.34.1

