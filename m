Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5523F78137E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379690AbjHRTkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379676AbjHRTke (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:34 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E213C3F;
        Fri, 18 Aug 2023 12:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnighoZqJNlIH9OPr+LqGFMHpRqRCqnzezzW8PVF6YFriYjvqHfwqw1AT7O3gnMNueJmjXo2fhP8CwmxAhmZeA6ym4zgP+GmIB+MnxTiQTX5Xu3pNZT9jNC03QDeDR1oe0SjkNmmpJarFd2YrNxp4mjx1j+6KsGMNztPvSje4NwiIT7PpKZffr9HV1xR99zqYijYcO3r5yPnQ5PlOpTler67DF6/MPYkJk1PjM3QnmNJUvLoYPy1t29579k1TmBSo9vvz+6vyrNrg9hZjmYfPFpSSQ57Pchlo5+w8uGJpOE16oVFk5Gfub2jzHR86rfM/eAMdGsUbAVbHIu4cmDxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhUTZ1IHoyHfxGrEqHgIYgdrsh6UqMet2Cl3hzYHqFA=;
 b=T35iu0GXwCC/b5VeQ1QpTm1FpqzWevnpmnpGnRgbHIfeLx1bOrjxhf/XqC9UM5V96c4EEl0hVEuLaw2KdOrZLJByLyN/IkHVLbFQWseaBfsntQA6ZJo9u24hZdqZTgneaGYOGE6gL6FFhb7DOptxyfvCwQeCYF5c+uaCHr7RhEtigM4h0WehPw+ZJtSBEL7hfIbh6yqk03sxKJHe/DWJ67Wy1JYz58zvoAKngiRjKkFRyLcUJRVAmYgA7FKrrO89vDHPsUUI9Am5JrWFhz35fQ50nTCrNfxiQsk7dGY2mYJ4vrRZm1WOKv2NXxG+aohwKqnn6Q+8H/q/lVIpl2sd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhUTZ1IHoyHfxGrEqHgIYgdrsh6UqMet2Cl3hzYHqFA=;
 b=tzRzu7vZCXalPnD8KDkeUqH8G967UfZNxyRSGE/DyZ5oaULg+NZeOTVP7KM/PW8G5N32z5QI9w2lc4SDgk0yWKrPR96K9fzWkOjSW6y9UimzsQOAmjYgEMQXgybcSsEghx3zeLs37XJnbjYu6gKtH6jrkrxFvShUV+eq3WfeX4g=
Received: from MW4PR04CA0262.namprd04.prod.outlook.com (2603:10b6:303:88::27)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 19:40:25 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::58) by MW4PR04CA0262.outlook.office365.com
 (2603:10b6:303:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:22 -0500
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
Subject: [PATCH v14.b 6/7] ACPI: x86: s2idle: Add for_each_lpi_constraint() helper
Date:   Fri, 18 Aug 2023 14:40:06 -0500
Message-ID: <20230818194007.27410-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: dac6f949-d382-4d51-44ca-08dba022f819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUXnQ9nmwzLf/gNZ30eIw4WOilDf5rvq1/ZZZm/1Tic0OwWHyfFk9kG5azmDD4kyOj1mRWOZYwLxs0/o/I3+cnx9SsDnve32dC1uMT2gfp0XvmCxXuG1gBldkEbf/4u9eMv0V5+om0nh++VNyDicXSLY4Z7XqBcoiM+neRsdzqShjCoGYJdTYw9rl4MIsV0pnddHxnFNTOWDKy+44Qvwm6qG5xHHuk0OrbGLqWvs89AAU0TsdZc7PxSReV+Ud8rSB2GYBAM/yhT+syFI+AKPQAoXMlzOge0DQY30xBt+IlAzM2MXTaEr9zNSYz+QjapeGyrXqkcO1LM22vcdWaTJ8pvi0ETcrcdOqai5/ByafB3oJkPv5hfZb1BEZk6vinHn8zVt3/B0kKTi9h6poMoZKETzkBmP2wdlmViPfqbXf2bdpuTzt76+dLiXa/yVgxRPRAyasfAZMjlJD7Vj4/NgpbuFkgwQM49xXC02ZKhBQiaeIRntM9Fzp9zVQN6av/N2nZg3tNLQ9M4fRyqCQ9fI1m0Z5V8XzDpWsI+OutzMlkg/HryC4UXfp+HNaCGuZk+51JMT0NdAr1hdHC2kq/7+KyfL49GPLyKVWJwYb0K8DMP4bOV7eXFaM3OiwEi3U6qoCV5pXrTQ+iUtWDwQ7EwMY+aJ5Q5e6ut+fvwP5j+mBSX7l/FSt1rXtoMcLjZzMS0jlCIlGTnhTbornxCggMn8NcPsmLsbItUu3r8K+P/JcnLEAg6vLwdFNp+9a2llvED2+7tOOzktxmuiuGTfZtc4kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(110136005)(86362001)(70206006)(70586007)(44832011)(5660300002)(2616005)(41300700001)(2906002)(316002)(54906003)(8676002)(8936002)(4326008)(478600001)(40460700003)(6666004)(7696005)(36756003)(82740400003)(356005)(81166007)(47076005)(16526019)(336012)(426003)(36860700001)(1076003)(83380400001)(26005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:25.3076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac6f949-d382-4d51-44ca-08dba022f819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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

