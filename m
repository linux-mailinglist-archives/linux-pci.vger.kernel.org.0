Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FE776926
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjHITsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjHITre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF32697;
        Wed,  9 Aug 2023 12:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0IeWBKk60jkabbA2igS7nf9luSicGgh6YPvNJfbnlO7xMyIiv/QjXOxBG+54DFhHLToD9CmLJIV0c78vYSMazE5nXU2KPtVqltiMLgxNMkMo0gamB0qvZfNnZ8wAgAKSeTiA5hOyfEvxq9nWGZM74Tfzpw3YoEYqfkL7sKI62Fajka+UZH2NV2Mgx//Mq7qAqymKUDhcbunrlyCk54vgVIU/OYpG69PEgRvFldUFBVIremITaX4zfG/U8SS4FwNP+1H4V4mQTBF/aob2QxTqrA4PQaxsMKrH4RUdGqLj1l96Krwqv1XBz+M9F/wAzY9eI20xfNvrm4Q8dg1YVOcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdDivnYtujAWAa9il7+N1e2ydP3LuW8rnDj+y/wNgT4=;
 b=QRFX8XvWvfAbMOsGqkNVmiHiHYxztU6EJciZdRNeJlZPzk59JwYyKlUv07kgVGbxiEVlLxpDDBXnrqWH0K36jv26jbykXMits6rZn/P8pAooznAa/T8yvBoGxq54CwjspTuFp8V6a8TgNK1p95zo0GsRo5pehb5qtZ2R7IaFUyuLDiMu8gGbKRHHTtwpWZNnYa6/UtiSpndqQUXT5W/pc2CVUW4VDZATw+rqmEaAbF6umt1EAplM7X7EweDqSOQZXlBIOi0pt44mdUmTXzrfRdgOO6/wRz+AZ7rdc0nNTqGNLCFcswAJWlFU13inSiZBa+NircT2VuR3k3wmG4hyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdDivnYtujAWAa9il7+N1e2ydP3LuW8rnDj+y/wNgT4=;
 b=mDtXHnKeqG30YRh8umoToKK1+ykpQGE61njbZNVzfGwQEWLnANfYFMRZqhkT8vBmGCLQSmHaNQ1Wqt1k+f2XrM8o0ZY9ND4rX0hwLYrpIcImVoN+nhZr59IGTjjsXnIyJdQ/+e0ReQW1NCVteRlSKeWuhWbJkDGyzizxkbCD97k=
Received: from MW2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:907:1::30)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 19:47:18 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::a2) by MW2PR16CA0053.outlook.office365.com
 (2603:10b6:907:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:18 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:16 -0500
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
Subject: [PATCH v11 5/9] ACPI: x86: s2idle: Store if constraint is enabled
Date:   Wed, 9 Aug 2023 13:54:49 -0500
Message-ID: <20230809185453.40916-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: ac39a05e-f0e6-44c0-3abc-08db99117074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJGCtlU0s4N2PHGwAT1RuDTYPIQUW91BywdC2KnGiDEin9lvZFua1O+T/yuwYJR0Xce7ZUAigN4T69WS3qqZ22tw4TU9sLF+q8BZcR99N0uM21WH2Yu87TW0PPSe9pffz+bMgQ9KG+ZIvd00V/zOjHGKFa48qOYqlsqBapgzeA6cG21EWqe4cLH0k09lH2UB07ADMj5kyV1vY+T8w0q3hBcCNijffgzu6iG/nWngvylUjGx6Uk4YMG0Vpfc8fCkP9JT98DSnr4ForZ69rZE7nIGjlhKJgRK5sb+tu4rJheENZmnmzA6f3eM8lszyWH22iMlzqw7f2hGRfxGiJIUsiOnn6kexmndv+DWEJCodoKls5++dmyYZI3cFR2tZNBrbqtD6n4SNzHaCC0LM7H6hOtxKj6ammUbGvPrN3IoYKsrX6d7/U9dtZI+KaMeN11d1E5MBoFsAlgB5UZRw2dJdl0VDDkOnGBN19S5DHy9/25AXaEFtfVEDm+JDg1zWeXbvYZvXo9iaceI+ByM0/WagImB0tPn66LX3/NuX6toX8/2DxjK19XacHkBRxYD1sjdZEpU05d6tlgwv344K+OyVxhokCUO0j1Uli3l+AcgOZnDrLKyr8tV0Ivr8LhemFM6tcsK252j9MazfczRLvJxxHY22Y6F3ikTR6fbbq0EVQk62XOaE76Qd0HuskBUjsDUZMW0rUei3dNP1dTqePuvSDPWwNqL2XThN/abXM6eB3aCv5thE77gWtn+nGD77AHknDIDDvHcrDKLidWK6cK2sFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(1800799006)(186006)(82310400008)(36840700001)(40470700004)(46966006)(478600001)(83380400001)(81166007)(7696005)(6666004)(2616005)(1076003)(26005)(82740400003)(54906003)(110136005)(356005)(70206006)(70586007)(4326008)(426003)(36860700001)(16526019)(336012)(5660300002)(47076005)(8676002)(8936002)(40460700003)(41300700001)(2906002)(316002)(44832011)(86362001)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:18.1810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac39a05e-f0e6-44c0-3abc-08db99117074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

