Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF11377ECDE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346774AbjHPWLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346780AbjHPWKx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731812708;
        Wed, 16 Aug 2023 15:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq8f1CbcAVhRkq2dpC6gDeg+LYphyzyTKGNsRfdCUeI4xweQWUl5+6rwtswRW5oI8evRYFaBj5crpudoekIlrruuhRCR6+oM2x/5zGw0+yjRezHK2k3J35HtHVgFXCOBflvmzaa/wOMrsKPQRQIc2JaSf9luN2skQXYPG4eahIJBQ0NmFPq5hVyX0atCGCrvfBxzzkFI1pStI0B9JZn9LvsJYxix9ULpqb2m44te9bXlh8VWUsd38QHMKrTHxXP4F8cs/tGLrFZrpOL9RVDmBnYgvvDWhmH+tz2MlUgKTvkrB7aTvZJTyayfULT+8IefiiQhWXQPquDUTyEp0QBnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z0oISn2A7L4+VMcPvWfDi5HZ7KR3PmdMVA1EiB6hso=;
 b=DQoeO386q3z2TsLqraVaIAu/87b5Vn6SXw+RiKgEUMa5m1rkjYSbSAXfkKv2miydNqaEV8PFpibn69cYlDfQX3qrv+LEBJggbe2tjDfVRYq9MRxz1V3dfYsz7nPFaLJZp1wpGUOv7y9lCayjbFQ92w6FQj/1gqag7VOVj86WK54JGlRVPxTNl0I5ffi19cea/V8Sag1cUhGSFofu1odzD2mVhRpgNgtXkHKnJIbxQfu1f+drnU3Hmp8wwYRZ+3bU8Ak4OP319F37LqiJdmvg+7gU18wELdmRhKCvhdLOdTc/5kKfX9kWC5d8Fk9Fj+UoE/ScZ+qnk7afj7U7CnVUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z0oISn2A7L4+VMcPvWfDi5HZ7KR3PmdMVA1EiB6hso=;
 b=L0VWLB5hlzSNCIHP1g5m2nuqyoeFU/PAdEdZj1+ilvyK7RiJocIMPDqX3QOBRnrKRZJOwwQIg/EwZB48lZRhtVO2392CVt1zLjUNi21qhNlnBYnzwkqJ+idqS6ouaXStVGxNUbA35/Z0gLSgzLLRslpReW7cDNgeFQCgxCe9ifc=
Received: from CY5PR15CA0176.namprd15.prod.outlook.com (2603:10b6:930:81::19)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 22:10:46 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::35) by CY5PR15CA0176.outlook.office365.com
 (2603:10b6:930:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:44 -0500
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
Subject: [PATCH v12 8/9] ACPI: x86: s2idle: Add for_each_lpi_constraint() helper
Date:   Wed, 16 Aug 2023 15:41:42 -0500
Message-ID: <20230816204143.66281-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: ac67eb50-d9d6-4e59-f2f9-08db9ea5a3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3E4ApALcMmOHGdSfdJWL542I4Kp8qKmezy2gjEDnnp7J48apQi6nTKhxF+Ja1oGNwoYiN7YP7Rzc2apSVyePEdEnz51weA/uO78hTpzEr1fW8TNikJNq0nX+xwmMgdipDTjJpsbWJMVEs0OX8egwxPUd1eeLqlBSrepFk67Teba/jv9LlYyMBqpp336TkXVWWgB27JUpL6fN6bTp8iFAmOLn3+rmkYn8MNy7qLWuPpCuxzMoHLCHxdMMIBdzwLoR8HPS0DOnFG8OH6Dc0AoSYmpIsVSdCf6B4Ex+blfrBwA4qYwtIJNHkTC3fhsDvZAZpN9SLoHJfpho02idQmR4R7wg9MKsGZPJsr6mlMTy/LAUWCuWFwd8X7TqxmF8FlP1fw4UEXw9HphSystXhFoIgFbn6mBCLTwgq9bRvtvVTKIjDmLrKr1mxO9maSHNA04DBWWNhIeDLP3hZCMfqoGd69cv1ujA3iZa3O6UKwSEw6qjOCblzPl/MTbSp+6X2uofsp9jumifIm/SKwdmuaVzdP6H+S5YnFEJEbYtxvbmh5v8+6GQpkSNAjF5Zay0VP3JX/jF+6uTmO17v632cGfGcJINXt6MoETsNpagqHRDJhd0MCZEGl7HYOo1F0gHk5V44bNU/WOySoVmI4g0IHmI8cnC3gZdNm00nQPwtq/+Zgk+EKLRkiU+0FbkMTdQnbrYlwZhOXS8ZcVDH9Es1LHPWHnm67rqkFBTQoBHeWiUhrjT6FSiAL4/8Fyk7F8M+7ilxC+vkbFfAwOVX66Sg/dUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:46.0175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac67eb50-d9d6-4e59-f2f9-08db9ea5a3fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

We have one existing and one coming user of this macro.
Introduce a helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11->v12:
 * New patch from Andy
---
 drivers/acpi/x86/s2idle.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 826f2924d05fe..8bda45579d44a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -95,6 +95,11 @@ static struct lpi_constraints *lpi_constraints_table;
 static int lpi_constraints_table_size;
 static int rev_id;
 
+#define for_each_lpi_constraint(entry)						\
+	for (int i = 0;								\
+	     entry = &lpi_constraints_table[i], i < lpi_constraints_table_size;	\
+	     i++)
+
 static void lpi_device_get_constraints_amd(void)
 {
 	union acpi_object *out_obj;
@@ -297,30 +302,29 @@ static void lpi_device_get_constraints(void)
 
 static void lpi_check_constraints(void)
 {
-	int i;
+	struct lpi_constraints *entry;
 
-	for (i = 0; i < lpi_constraints_table_size; ++i) {
-		acpi_handle handle = lpi_constraints_table[i].handle;
-		struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	for_each_lpi_constraint(entry) {
+		struct acpi_device *adev = acpi_fetch_acpi_dev(entry->handle);
 
 		if (!adev)
 			continue;
 
-		acpi_handle_debug(handle,
+		acpi_handle_debug(entry->handle,
 			"LPI: required min power state:%s current power state:%s\n",
-			acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+			acpi_power_state_string(entry->min_dstate),
 			acpi_power_state_string(adev->power.state));
 
 		if (!adev->flags.power_manageable) {
-			acpi_handle_info(handle, "LPI: Device not power manageable\n");
-			lpi_constraints_table[i].handle = NULL;
+			acpi_handle_info(entry->handle, "LPI: Device not power manageable\n");
+			entry->handle = NULL;
 			continue;
 		}
 
-		if (adev->power.state < lpi_constraints_table[i].min_dstate)
-			acpi_handle_info(handle,
+		if (adev->power.state < entry->min_dstate)
+			acpi_handle_info(entry->handle,
 				"LPI: Constraint not met; min power state:%s current power state:%s\n",
-				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+				acpi_power_state_string(entry->min_dstate),
 				acpi_power_state_string(adev->power.state));
 	}
 }
-- 
2.34.1

