Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0561077ECCC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346808AbjHPWK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346785AbjHPWKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1322126AD;
        Wed, 16 Aug 2023 15:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBhLcYZceIVbdxwZRhlOrIs1ewazCLqrTqOLm7y63KKa+1tV9/JJ4OK5id1Hxccbn0LL+vWBDt+PQuEY4mmxRZEL7IZA70+FjyQHWYq2dx9N259vqVnqhlPav2sFYGVdvyWsaNsb6YP4H2lVOBmhxs7wg1NAYTq/MEmENbhunlwAwOVUIsCBZowGihQxp7uO1t24MaCLx5hc9i0HQEc5yIZj44kS1JCN8RcwPZWSj/rW+PDGmSLhyvLjC9dNs6nQfCsSrIB1+QhJEbIOwEkIeD1rMDR7CHXsWjn3hnUdsspS6EcPLcMlSL02jzOxHAlg4G9UilQYfmMZvtsqFcTmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsIjzWM4UwG08vvkQ8Of6qGSYx+/t2ioEsg9zc6Ur4s=;
 b=Xd2RvCdpRByl+qIwhXBjhAhKq9IvywuqGK0dsBLR2oHNJaVmPnAcaIVtb5a4HDFyfTFBCq3k6x3Q0Nzu1ZA4H+kPeSxMONxgdhLCiR33ML0WRdQsKx/nBJ5myi6+QGgfyjA/zWhPtsyWW1kCr7th7741dx4UjW2cyR/YFBGpdsoXGHQGizerNamBOrrnAeZ2xF9PhagDuAGaVTVPAu70nyekSGhMFJMoB68D7s45T4ccoiZng0+l88uRoGQcDAPVx5clMxiM+EVv0WC79VeCsQEfhZ3+eFjAQ4/sQcoH5KjsQwNTxCVS8upsU3m24UZpKQ1/YoiMOOlRwP4eT2k58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsIjzWM4UwG08vvkQ8Of6qGSYx+/t2ioEsg9zc6Ur4s=;
 b=F3OxNiqUwvuWGACCWU2USmFyVRJvtB4YeoV0HaBAsNEgnqobtAadjc/yd9BEZ1buRbol8kW3kQR8eHOom214A8TR6rwQ8FWOxUKrpt5K6fOtDn+CsOtsq/QPRfm8glhk66tzcuP928W5FYvo812DCGrdusEjNB/vXGT2i2i3Qyk=
Received: from CY5PR15CA0223.namprd15.prod.outlook.com (2603:10b6:930:88::9)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 22:10:41 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::db) by CY5PR15CA0223.outlook.office365.com
 (2603:10b6:930:88::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:41 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:39 -0500
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
Subject: [PATCH v12 3/9] ACPI: x86: s2idle: Post-increment variables when getting constraints
Date:   Wed, 16 Aug 2023 15:41:37 -0500
Message-ID: <20230816204143.66281-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8765e684-6fbc-4a26-69d1-08db9ea5a105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfrQqG0cX9aTbLyjHm7xx+xiTZMQUpVVFMP6AuDUo80FMxV2yFl6XADxQq/4KfoTGVXxwKGEIljZ+3M7M9OibkzHWkcb5yDbK3+jSk82e6ZXLrDFwRlUec+7Sc2MAE52EhXxv5uiQtTB3MQ/NQcdtLdjYIjZsizGdWUerPH5IfhRrB824HD6AdehjLyw/E1tW5aV6hHJv8bau/cbO4m0lcWePTxBlcO8gN38Bhbp4rdm1HWoICT8iPhfU4/4vosU7xMTeaZu6UzT9QOw9ZoulgAKFxdnHJZXNtWnHbol4B2x1dm+CP0wVyfWkI1SHsA+vnNJV09D1sbwfVF0j/1m2t17+wAl4CLVcXMLpRqvqzxq9dk27UzmGvXxeODauWwCWHduFsLo2KNGkgNWG7IY4/cqDn8EX2T4bzLanKLCZj/hLb2nfJ3Y4KAbzIUGhb0/2sgqKBQZcBf/McfhIVynolDkOvaZUrO6w8lm34fqi9UJVI+v7F7dX4l4KKq1WB23Uwxk+kH91o10niSx2fTiqhw7JmBFEAHouLw+hZTtMshvwz0Yo1VS5PfTaRdH4Vz6DVNrcRDfmKQHfdsE4QMH84rZKo5iLxcU5yjq+qCfN8St5ZV2A0/+S+RzzYElAWz81VJX5bE0M8g+7RSspLjz9hU/KDHJ7Onn2CffxUBgaXQmIg0ATZDE26/5rih0HdSbsWJfiiCQ6hN7q1zUCEAQbd6/rI7+kd8dV2Ac4VAADhQ1yLVYUd6HKY82U77QkjK5EVpDrpPI5PUszNEDz7oKCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:41.0243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8765e684-6fbc-4a26-69d1-08db9ea5a105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no reason for the variables to be pre-incremented.
No intended functional changes.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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

