Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08ED780579
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356702AbjHRFPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356102AbjHRFO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:14:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB510C8;
        Thu, 17 Aug 2023 22:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9KtHNub7nwdt/0EmtRd+aILk9kHeLsAw3+cFSZJoX2rY8Iaa8xUX5lE64EpnT14eMQlpIDFqIk124gtWrs3Q3MzhIS847aNwRH9FzSK/FAAeOeEicNdNj0ZykcvHjnQhddr9aFjj/mSEKEXIoy1MBqJ4KDDkEcE1wUlm32+nTncBCUFZ/ijgVRw+JWakKW0JyzaIUkOb9haubeI2+A//j1QuTG5UEFHoBJaS1PKUSzNGOoAt8ECZGIC0pMg73xM7yA59MqBaHxIFoW9wTrJu+7e/zZ7ivua1dT/oDIYaPrNBVR285q9t0D1LOWmpSuQv/Ng+v0mHwQ0oMBXDc8sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9pIliEasY3hi8iYJYhXDM/t9oeU4sjbjdpuPj5rH9Q=;
 b=YXQKo98cdznQp4wg1ONokavx6aL+2MZujt49S6wV3dnvvSFeWsTnQgMmOWsrF2djzBbQh9GMER6ee8pX4EG3RwOSb8cqrCsqwPUl1YuGk5mSGbIwlLQfKNlk7iDtovUb2g/wBt92NxEPxL+bYFc1u5mlTbJcW+Fzhsaek2U5nzhYvhgTGD2E68y510wP409aku28uhMm5c2tztaH7O9VjYW4USIglB36SNqjFH96CRm2xM4oAsivye+OM4x/kmn1uuaRRNO5f9cFTFeivR1QnpboIE2kGwIV2AsQjzorcxTPBPm2izMqc58dFHOUpsisIHHDKqoM7DAf9EjZdwsGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9pIliEasY3hi8iYJYhXDM/t9oeU4sjbjdpuPj5rH9Q=;
 b=lEKibi/S25jFpbhsB+VM4hcbF8CqfM5FsBPaT84StM28LMg4euyIIa6BUWT9l6/scqDUKQh4gtuf2pmsKCmIxlklv8HtJ01lHMBHghVxMVlwZ7rWj1G9l1dS8JIC9lhUo1DmDe3WTgGoEWB/FEvgyAFl5QN5XQusuK+K+JbtBH0=
Received: from CY5P221CA0096.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::31) by
 PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:14:49 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::25) by CY5P221CA0096.outlook.office365.com
 (2603:10b6:930:9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 05:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 05:14:48 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:14:47 -0500
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
Subject: [PATCH v13 04/12] ACPI: x86: s2idle: Post-increment variables when getting constraints
Date:   Fri, 18 Aug 2023 00:13:11 -0500
Message-ID: <20230818051319.551-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: dbeea1d8-9fb0-422c-049e-08db9faa0b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfACwTUL+w7rtR/ZyCwsD1QshfQBh/B7oVaIVyQmkQ7hmqGEePBUSAEEUXBM7LJELIjclSDBrhJxbm/e+cBMvgE7ivnroYNTEfOJ68iYnv2dSUluIwzxyI+5n6kacGEUWit2vtP3sYbIfb2tGCrvaIy3/JC5PNbzWmGKCJxP98+paKObGdUHxwR9kWYD/JgR1FFA7kmpm28YycA2I6oR3hZaeRh2VHW/tUBLQM5sVqqEYXObGjrn8CbU56zHxvrp9XuAJBC9h0OHNtpoWnjS4pWhU2x7KCDms2eMkdNjdPCFLO2IE2C57mg7CFrch3XCqhZ+cautUh9rBEW6+inbVw136ydeDXNFXnQYduj4QzNJR2H6FlYN+2a9uNS3WvWCK92OfyAXciH3ayDImCLPHEADxRV54gzWZiCJ/DX7/VqN2cYSYX7vmx9b0N57Jif1SQPQpGUwSYHQY8et9o9paHoM7Qe81+EUIMJii/4oglGn5ZrQr7t+FMmwT9p78s+xER51QjOl7RSHpmDHSQmRCheh+C2VkoCE187irDoJaEoJzyUwaRXboz8VDxS1NGHN3gzO4nGbHqZdqbaLY+qiGOMpkthLJXl2SA5JbavD3/lzzIEp00jvoy30zaQKO7ySyomOtzw+hSJWqw4YXqMsb7WQqDQ25LRrYcWrbACcJc+c/jeb/wKxxOrGwgmzqcXbGHhrt4mslL0N98CaS9jPlSh654P8iy6K6s2SSvyKTjqXuNq3dzrmcRGN0EGSHwc5JSzg8afUp8+t2ICnt/U1dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(478600001)(316002)(44832011)(5660300002)(16526019)(26005)(426003)(336012)(40480700001)(8936002)(4326008)(8676002)(110136005)(54906003)(41300700001)(70586007)(70206006)(7696005)(2906002)(6666004)(40460700003)(83380400001)(2616005)(36756003)(47076005)(36860700001)(1076003)(86362001)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:14:48.6389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeea1d8-9fb0-422c-049e-08db9faa0b65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When code uses a pre-increment it makes the reader question "why".
In the constraint fetching code there is no reason for the variables
to be pre-incremented so adjust to post-increment.
No intended functional changes.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12->v13:
 * Add tag
 * Reword message
---
 drivers/acpi/x86/s2idle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index ce62e61a9605e..7711dde68947f 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -123,13 +123,13 @@ static void lpi_device_get_constraints_amd(void)
 			acpi_handle_debug(lps0_device_handle,
 					  "LPI: constraints list begin:\n");
 
-			for (j = 0; j < package->package.count; ++j) {
+			for (j = 0; j < package->package.count; j++) {
 				union acpi_object *info_obj = &package->package.elements[j];
 				struct lpi_device_constraint_amd dev_info = {};
 				struct lpi_constraints *list;
 				acpi_status status;
 
-				for (k = 0; k < info_obj->package.count; ++k) {
+				for (k = 0; k < info_obj->package.count; k++) {
 					union acpi_object *obj = &info_obj->package.elements[k];
 
 					list = &lpi_constraints_table[lpi_constraints_table_size];
@@ -214,7 +214,7 @@ static void lpi_device_get_constraints(void)
 		if (!package)
 			continue;
 
-		for (j = 0; j < package->package.count; ++j) {
+		for (j = 0; j < package->package.count; j++) {
 			union acpi_object *element =
 					&(package->package.elements[j]);
 
@@ -246,7 +246,7 @@ static void lpi_device_get_constraints(void)
 
 		constraint->min_dstate = -1;
 
-		for (j = 0; j < package_count; ++j) {
+		for (j = 0; j < package_count; j++) {
 			union acpi_object *info_obj = &info.package[j];
 			union acpi_object *cnstr_pkg;
 			union acpi_object *obj;
-- 
2.34.1

