Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002BC770A49
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 23:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjHDVCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 17:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjHDVBz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 17:01:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62064EC4;
        Fri,  4 Aug 2023 14:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuOTxfnITYq+hLEBZH1KEyDoD7Yf0MFQXsyOKzZrPjRp1kz1YaebWzHQQEmKK+kWuAd/47bQzlozd6knFC/xLta+8IgS0LnoLIJZpZvCTIChOY0xuAwxE+wSoL6mW9gxppRvm+ZrKs1wBzSuPh60OarORv/l5/MoY8VYYFb+JIOn5pNWivp4jhYlOn3GTkek+iJOwsEGxxXlKDZCCz5thQhgTNMi7Azo3Vd+qtj4jYTSo+5JwmYuAAZylOLCdX58wU8QMTrh9IVTdDOnzEXxzFUo3e1cjpjEoIApr5cc5o0NHmF17k7Bbfg3jtThlJ82Iwpy2F8Ald7/XFcVUQecEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdDivnYtujAWAa9il7+N1e2ydP3LuW8rnDj+y/wNgT4=;
 b=hFrd00VdaGc4jd2mCUxgEu79zeiJSU7AloI/N5Tg+rvgl/by+qxrF+OxavXh8cLItkMtCPaPYaZyook64ycmskAk65RtFKKZRCxOtbspZWXSK7q4DbvLLRL3GsVpfcbWDPLWhYIC9z1xS7IPhtmazgdMWAdDq+uHt0d5cq6R4rXDpBKoLNnkSKdAjUjkbM1RPa4hDURSo66iZuH+As2EsxN5UZWnFdbTuxE4L2HarvAb1WcBcDJGT5Uy4yJHZBtJfEiD2uL/949bPzGw839hMKvHdNF/MyuIWXAZgTKrZg8uM1MpznhlMHk0zMlXP7USqy8NwA24bDo58wxnhHj5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdDivnYtujAWAa9il7+N1e2ydP3LuW8rnDj+y/wNgT4=;
 b=N9zWzJv8F0TftbgfNq0YnoT27nkL0NHqY71ApbdgMcEx6h5J2pudc90VTCAONxc3k0W8RxJh0vltrxVsk3AA9+uUc6r0YuDrmj9IQn0zmVtD+NboPDZQiw00XunOBBtUWDBDTkjy38uayFrBl1SssCgGPVxekG6hFzi40xLZBQs=
Received: from CY5PR14CA0024.namprd14.prod.outlook.com (2603:10b6:930:2::30)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 21:01:48 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::6e) by CY5PR14CA0024.outlook.office365.com
 (2603:10b6:930:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 21:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 21:01:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:01:46 -0500
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
Subject: [PATCH v10 5/7] ACPI: x86: s2idle: Store if constraint is enabled
Date:   Fri, 4 Aug 2023 16:01:27 -0500
Message-ID: <20230804210129.5356-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 57143717-cb95-4c7f-140f-08db952e0474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqHnr5bdLXLmD6O9bA3nD8kISjuvz+kWhVtMwf1Do6Wp8MM+lloJ+/0Ywu1HFCPjHH0jCFGQuMpreX6GUYYp8FtD6xbOiUtrWkjDyK9ZeH30WjjJJAP5/l6KKnrCxIgwh2bu0doDP83uvslxdRlxZcPOaun1ryJbTdgkwpyRbjtzcFnRRYFXTkRjFbTWynPurmouXopwT/a7Zscy8QSCi4WZYkDmWRE6w6WZMoeyDtuHNBwu1TQhoa6irCiA87wsBrJOFKbTqiv4t9ybLM6h/4RpBSNRJlXJ/hqsMaqNAlUhtKaGmaBwPiBHW4+OO8fVMjeKjbHmr/DB8lyE1i40cyUQmmD2/Ik8Qdev9auDtbvPlqVkYTehhIg0rzuXv3CHrDKJtlvhk39Q/WAvnK4yBVHSlorjT2+vKFBPEMGnacgL8lNqF23/HKvN/CHmx+9DVfR6CuUrtpP6tJeQRymdWlB4XKv2eD8T59H7OW7MYL0GQZ3TPyviZUtsf368Biij8wsutNw7l8gNTmhWGcM9Q1/jqwnhJ5PYGAg2Am+J9HBcLc9tjshtdsZH8rlddzRe2fyEQbaxdczUwzFP3KhFesOsbymKqOyvAWTS8wDgJquoNY2fwGoXq+Hai0xO2QqxDS99GMQyiyTWcqYqzYPWhqhbWz1WtMwG3D731JguO8uz9SwuthBajGcS0WTcWOB4MYzs3cSivR2hON5Fz7zF5kOQssUwOonSJtBa4mOOiUHam+06F0YUmakKjlbZUYA7iIjJ51e0fg2zmtePLMvVSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(82310400008)(451199021)(1800799003)(186006)(36840700001)(46966006)(40470700004)(83380400001)(2616005)(426003)(47076005)(36860700001)(40480700001)(41300700001)(70586007)(316002)(70206006)(4326008)(7696005)(44832011)(26005)(1076003)(8936002)(5660300002)(8676002)(6666004)(86362001)(478600001)(54906003)(110136005)(40460700003)(81166007)(356005)(82740400003)(36756003)(16526019)(336012)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:01:47.7713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57143717-cb95-4c7f-140f-08db952e0474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Constraints are currently only stored when enabled.  To enable
the ability to check if constraints are present they need to be
stored even if disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9->v10:
 * split from other patches
---
 drivers/acpi/x86/s2idle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 91cd6f8b8ade0..0c8101acc92ef 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -78,6 +78,7 @@ struct lpi_device_constraint {
 struct lpi_constraints {
 	acpi_handle handle;
 	int min_dstate;
+	bool enabled;
 };
 
 /* AMD Constraint package structure */
@@ -151,8 +152,7 @@ static void lpi_device_get_constraints_amd(void)
 					}
 				}
 
-				if (!dev_info.enabled || !dev_info.name ||
-				    !dev_info.min_dstate)
+				if (!dev_info.name)
 					continue;
 
 				status = acpi_get_handle(NULL, dev_info.name, &list->handle);
@@ -173,6 +173,7 @@ static void lpi_device_get_constraints_amd(void)
 							  "Incomplete constraint defined\n");
 					continue;
 				}
+				list->enabled = dev_info.enabled;
 				lpi_constraints_table_size++;
 			}
 		}
@@ -235,7 +236,7 @@ static void lpi_device_get_constraints(void)
 			}
 		}
 
-		if (!info.enabled || !info.package || !info.name)
+		if (!info.package || !info.name)
 			continue;
 
 		constraint = &lpi_constraints_table[lpi_constraints_table_size];
@@ -247,7 +248,7 @@ static void lpi_device_get_constraints(void)
 		acpi_handle_debug(lps0_device_handle,
 				  "index:%d Name:%s\n", i, info.name);
 
-		constraint->min_dstate = -1;
+		constraint->min_dstate = -EINVAL;
 
 		for (j = 0; j < package_count; ++j) {
 			union acpi_object *info_obj = &info.package[j];
@@ -284,7 +285,7 @@ static void lpi_device_get_constraints(void)
 					  "Incomplete constraint defined\n");
 			continue;
 		}
-
+		constraint->enabled = info.enabled;
 		lpi_constraints_table_size++;
 	}
 
-- 
2.34.1

