Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E211578057F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352924AbjHRFPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356473AbjHRFPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:15:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464EE171C;
        Thu, 17 Aug 2023 22:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZyojotYZ+qQmJS8o9zptmB+vgBqCaI44ojJtg1EwmbREke7jd8X5dOlLco6Om8CLhC33PsGTJGtmGBtuvJpPvr/R3hSD0z+r4Mzgoisk6bil/eGrvL+GuBPgy034w3tF3MKW24TF7XNdZ4Rb+G/K3ZhftKgQy5FUh9reAshVChfkdu5KBfJGffPFDrl3U1ZR4ECkf7P/vpwTRVvLY2RHPi70LZdG/V9NCGjSlqB7wseOOuk/ERm0VeB5KErXdgtX27rD4JgDshtwgCPlrWEX3+0fC5w3C2t4B3/enTkIFI23UdaHjCF4tYAlCiudd6bEgk5BLRjMY8mYsJ9LACNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhUTZ1IHoyHfxGrEqHgIYgdrsh6UqMet2Cl3hzYHqFA=;
 b=M6ox5Wz2LcD6G4W2hJ7bKEe7q1sKXd6jW/n8JEJzO6ee9FNGmGaLqmH9gq4S4HTfL/FrdZnbUcjIcfahC++lrFG5Uj38oAO6bRPyE8EtYngoqOHZWoabet78LL7AAvYqPZcI/AxxRugv+M05ezxdtywy3/j7C288Q5rG7NVNGf4nahWr3nYBrmY86aLwU5P2JfvK+xt0OmKRmEhIBIgdyt6LjdA5yp07YqvkaGOE3eD4dlhsNL9r7b71nX6xpYOund3AnvHGt5xKqzJ1qAz6Gb+JTSN+i2wegMusSiflBD2xhaVywncu8G6JtWljiJigWSHefazu8cbpRgZ5IN7LHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhUTZ1IHoyHfxGrEqHgIYgdrsh6UqMet2Cl3hzYHqFA=;
 b=TXOBaP4fHeDIePqaGUzQT2YGWKvoBCgfgJrQhcz+x8jVUfkR4f/6QmxEQkq+CHB8Z2Obnagi/OhFS1h9XE7HZGcU5a9pgbTpUioSTEyuV0lS6p2oFjczC+f2PtV/9/iCZB8xq2hq6MHxolnEWyLOihKS1H+19gqFun/CvIoG6+o=
Received: from SN7PR04CA0088.namprd04.prod.outlook.com (2603:10b6:806:121::33)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:15:03 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::6a) by SN7PR04CA0088.outlook.office365.com
 (2603:10b6:806:121::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 05:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 05:15:03 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:15:01 -0500
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
Subject: [PATCH v13 08/12] ACPI: x86: s2idle: Add for_each_lpi_constraint() helper
Date:   Fri, 18 Aug 2023 00:13:15 -0500
Message-ID: <20230818051319.551-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: cce2a951-0c96-41d6-73d3-08db9faa1433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGZlO2lZUe6b5JW/mRb7WqoV3WkUoo2zggeqiccDbUbCuSUAjaeeGLsSt7075F1ddxQoSm0rlbQAVN6MGCHeXL3EXNW1Y4rbUEtvBk4nrp7tyyqUf7CvENFRvIeoYfBjv0UrQK+8RkPreSVb1RZ9i5czo0Z8rPdJa0IATVO2eSd8o4a7qw/s6lJgQtJ8Jho/Il2HiLsVIW8qzllN7uNuy8UNr16AmZ1W7Fxsn45E13tjHGW3zs1aJq4wdbALRxOMej5bb9f5Q4KS4s11EawBQ1yXw/hwbV9fg1FRo9XQ3niv7pfbMHmMtgdf/SX6ZCbh9+iFU4toW79rKjw36qapUBdqTB4C+XvOdQ5/vPQSdYdL1bs3amNffMXFjBRcVeDm1JCwCVGUhjaFacxgvFvD6QZwi5d9ySdkN8RH7VoBXdavuMwQs+E180/hwQp15TZSBRQHBac6MxEcszteXSAyR5v3ENZ6z/94FkltAGzcv+Ml7hD6k7XvoNYAK6fFJaRD5ZnJsa6osuIINSSbjVzv19r9H34h0/NhrKaEX79OLoBgds/Ntq+luFfSvjoSzKM93wDAk6bqGQ2UBYO9iGTZ6LAOcVadPbzkLd7nQqiWfC3uq7T2eKKTifFPO2b6Y7Lt8II5t/3FSIfx4Mnsh2AcozEuY16G6gCpqb3j36JyUMX3dkEKKFaLN4HrhThQixN/t0mUzAZ5FMcwfV2PLtSpab4cFeJyzGjCOFt5c8Vu4DvzjR19yf2FP0gaIE5i7DCXFaM9LkbGpB/lM0GPCee2ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(6666004)(40460700003)(7696005)(83380400001)(81166007)(16526019)(336012)(356005)(426003)(26005)(82740400003)(86362001)(36756003)(47076005)(36860700001)(40480700001)(2616005)(1076003)(41300700001)(2906002)(316002)(70586007)(70206006)(110136005)(54906003)(44832011)(5660300002)(8676002)(8936002)(4326008)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:15:03.4605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce2a951-0c96-41d6-73d3-08db9faa1433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
index 87563337a4786..1aa3cd5677bd8 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -94,6 +94,11 @@ static struct lpi_constraints *lpi_constraints_table;
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
@@ -296,30 +301,29 @@ static void lpi_device_get_constraints(void)
 
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

