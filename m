Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587E877ECCD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbjHPWKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346790AbjHPWKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C262705;
        Wed, 16 Aug 2023 15:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrvqDGxXRc51w5OlZ4MK8mxyhHy1i8F3cAqc5Dv9OYz7/rvkOjYS5At0gsiUnVyuoVMdOtq62akHVJcGQeNjtvFMsQpv2P9N5N/8te8cZnkXICywc0U9PbAsGP/NkBFfjAFIRGCX39NlUeAGn1T3xB1jQ/w9Sc2wW2UM3qBvyGRlUWxiLRaoiWIEZUfVkzeaPmvNoQ56wCx1S6v4N043rMMPy8UXxkp9DESS/8abyDLftbBnO+MK9RX6qhkpHvyT6JRO/WZtYASu0MUmmOhK+NSDL38wtPOAnpqdzV+tvVzIzBR10bKq8Jn4rIJ4PBA5OAg9k+/wjQTbKmbHYnJMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIfryX2RvXwZl1oT0n3qxt+4Hmo3lCcDx8YQEcm5ybo=;
 b=V8UV9H+jI58G5xGfCw0kTkyaOvVvlFlILl28Er2S1A+Ot1onZVCzXHQIuKmaYlGySJ+wfNiaxb80Syw9bY9PcYLfB48eZfaCsUq5XNzJEsA+KVwc7SIyTJN7pwMIAaNjQPh9bQTxOwfhMgAESoEVmncNxaGj+dynhei6gGdyhRDZQjHodDRDhGBz8o4TrTIrlQAFqtbW87Ljaj6GWRQjVnK1YJlqMPKCjupPPKGYKkEZyorLrJjBxOZXQ+WqjfG2kY2sIa45ew9Ft8FbY0V1q/cpgf32JMXQObJtjI+RD+Tr4Fu943DLFAibzahLkWxgDPbMBhtL6Q1ExOcHCu9ohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIfryX2RvXwZl1oT0n3qxt+4Hmo3lCcDx8YQEcm5ybo=;
 b=DOry0NNrap37fKbB1If3JQhMSCPP7pBI/Bn6MO1T/faDFSqHxRP4U9xySQVyH+KGasgO4Re8nrIMx1RwUHBcf3rKxFmUgvB8zvmHA522nTkctc1ZJJUS2jUCUtoHHx1ENILkGWHw6tH4m2VZvrGh2ER/v5d8pECaKOVj0Lc9Mgc=
Received: from CY8PR11CA0022.namprd11.prod.outlook.com (2603:10b6:930:48::6)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 22:10:45 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::8f) by CY8PR11CA0022.outlook.office365.com
 (2603:10b6:930:48::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:44 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:43 -0500
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
Subject: [PATCH v12 7/9] ACPI: x86: s2idle: Store if constraint is enabled
Date:   Wed, 16 Aug 2023 15:41:41 -0500
Message-ID: <20230816204143.66281-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da86bfe-a5eb-4b93-32a1-08db9ea5a349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTSRhA0Ywiumzpnnv2S7BpntYTylTbUve6thrp39cq/3vQQ2kAI6pz9WN+FPRWipnxQSb6/gzbU7qgYkJOzpJEZf7yaGpKMQlep8NYeKoIo3JzYywGPf8Vkx8W6jmQE2rigbziVxTrL87LmsJvVFHnjnl4VZYskM+tHF2uRhfRBsglJjs+Veaxd+mwOC9Tu1n9FILFlYyUUONqh70ssJuyzLLwQ5ft1zmW2rXdT56C/uUvCxrBNZNciwXdZf/tCo7wQg/iXjlvdwKPP+44duycuVK8aGe2Fs8LeOZuLH/ZeGPFlyR4j/zm7At9B8XTuABv4uMzdBwzCjrl4j+QRDJWooih6VSJNfOaEHRFlSrFstOfmI9UaKA1ilkn4QcLIkSjbLk+N6E4SE2MPhDlmgjR1fgEc3cpHTOreXrjk+GXoY1iSKZ7nBGv1W+aYniqa622FkGezJefXZCmM/oJ6ZezXTjwZIRgguUW/Yec/B7SEXtD5TcFFm9wN4rjONnkqyGVz+4Zc5RJRVXiIfPVf24eLwJfOONZN4qZDqZzLIugwgs7CodAz7ciJbeZ8bCeXWxFtnwcpCgCD4y73WetmkfJHHnaincX/XzOYQiD/GHEbp3z/XYwtzUPG4vk7uS/0toGGjtWCQ7s52uqx6IvZ688f8PbzK+yygda38cZ9Z8oPgujrWWRa6+6RSijkvlLreHk+sXoX5YzK2Q6m9HBQhQbre2ALZsn3DlT31WdhWe9AcX+5jqmJlPNkzooOrWXqTeUSzgYeRdQQrpiLgrvuLFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:44.8395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da86bfe-a5eb-4b93-32a1-08db9ea5a349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
 drivers/acpi/x86/s2idle.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index b8b3151215f0a..826f2924d05fe 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -78,6 +78,7 @@ struct lpi_device_constraint {
 struct lpi_constraints {
 	acpi_handle handle;
 	int min_dstate;
+	bool enabled;
 };
 
 /* AMD Constraint package structure */
@@ -157,8 +158,7 @@ static void lpi_device_get_constraints_amd(void)
 					}
 				}
 
-				if (!dev_info.enabled || !dev_info.name ||
-				    !dev_info.min_dstate)
+				if (!dev_info.name)
 					continue;
 
 				status = acpi_get_handle(NULL, dev_info.name, &list->handle);
@@ -173,7 +173,7 @@ static void lpi_device_get_constraints_amd(void)
 						  dev_info.min_dstate);
 
 				list->min_dstate = dev_info.min_dstate;
-
+				list->enabled = dev_info.enabled;
 				lpi_constraints_table_size++;
 			}
 		}
@@ -236,7 +236,7 @@ static void lpi_device_get_constraints(void)
 			}
 		}
 
-		if (!info.enabled || !info.package || !info.name)
+		if (!info.package || !info.name)
 			continue;
 
 		constraint = &lpi_constraints_table[lpi_constraints_table_size];
@@ -248,7 +248,7 @@ static void lpi_device_get_constraints(void)
 		acpi_handle_debug(lps0_device_handle,
 				  "index:%d Name:%s\n", i, info.name);
 
-		constraint->min_dstate = -1;
+		constraint->min_dstate = -EINVAL;
 
 		for (j = 0; j < package_count; j++) {
 			union acpi_object *info_obj = &info.package[j];
@@ -285,7 +285,7 @@ static void lpi_device_get_constraints(void)
 					  "Incomplete constraint defined\n");
 			continue;
 		}
-
+		constraint->enabled = info.enabled;
 		lpi_constraints_table_size++;
 	}
 
-- 
2.34.1

