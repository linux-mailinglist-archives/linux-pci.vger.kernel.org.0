Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1768176F875
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 05:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHDDn7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 23:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHDDnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 23:43:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547BC4204;
        Thu,  3 Aug 2023 20:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqXOziP3uMvUKaLnfZ2QO43YqKeeLIjTLoAQCkHFEEqbtDttk1KRxT8xuR8azuowRHtBEY2DPl7R4U5GOdrUO0BMC1g7ys3Wn5KXhETAbcHl0Ac0UsV5RzlxGV5Aubkh0aN9LbaRo45O/XwZlPcNi/cGuTHR9LcDd+6EIqXYcgFpoEmnQPBjgHSIkfLIstxl73ajNcewoWnZ12mflBilA4t61KdNMYnQ/mWt0JrTtSUgkyOwVnfTQ789T7w0CmMpxGmXB6xY+oJg7TIcTX0WdSbaP27bj9Hs/RL05Z/BDf8ueTBfIOwkHqlGF0vGZpvsmRQNd0w3uxHci84OU5rYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEbh1VHYTTX6Kr0IFfAIU3r8/4U/uhamErK/+Vr0BN0=;
 b=PurPe068b8+LhM/gRZgJG1en0Gey3elqEGS4j3Pz7rp2KBoOeOd6XoKu4EF4WF74P+LXMsK+67e/CjGIpdWWMdO7OcJWvFHU7Itzyfo1AeBOsQumsIurpWSpoXQQqHq/lohxkcikufDXnK2V/Qh9W8sUkFMrf33DCAdDdxCCvqfY0fbk6z2Q17hedQtQtVVqFZRcdtQtWcGIZXXIEJmw2j4JSRWPDufyobt46O7uL7f4sdkrvawySbWYItfUi44OiM9w4lL+rSbWX0YDvuIvrFf/ztC16FrNYP63fGSuciJ2nKNJWxdfYcjV0OZISTeHYhDhWiRnvQ3Y9WcR10EnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEbh1VHYTTX6Kr0IFfAIU3r8/4U/uhamErK/+Vr0BN0=;
 b=lzttx3nCoMrzLAxb+TVfuxjl2a9Y7xNyMpT4YXaIIPhkqyKvaP1U64rGa/KxG/U/VVc7dksJfw7buf1EoI+UEwrhmj/ablepI7M/krIaIUnEofd1+acAwx2so0PimjKsRDky0gf5wmJh8Acn5nBblXYDCMP9K8hUDzVrEymZIE8=
Received: from CY5PR19CA0034.namprd19.prod.outlook.com (2603:10b6:930:1a::13)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 03:43:33 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::30) by CY5PR19CA0034.outlook.office365.com
 (2603:10b6:930:1a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 03:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 03:43:33 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 22:43:31 -0500
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
Subject: [PATCH v9 2/3] ACPI: x86: s2idle: Adjust constraints logic building
Date:   Thu, 3 Aug 2023 20:02:28 -0500
Message-ID: <20230804010229.3664-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804010229.3664-1-mario.limonciello@amd.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 8373be21-d49c-4401-a7f8-08db949cf9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVFXs8H7PfjzUhJgqR9qN/Y1q6ZAiAYRIKyTr2HxliH1jlyPJGHtaZGYOfYcT+nBaBzKD3ibdAQapGfSd/PIyjFYeYLyKP7Quak2Tj3lNQUydGHinrQCLkPFCUdNKLNxH1eeUftywJc+kZB8q8xyrVb1f81YceQwe927t0LDUQqpzqLe0TSEXLUpSgu3ivXcvPaUGCrYTf3ALbji0H7noWTLYq4gUGNlDTSUiAFn7ZWMhQye9QZfPzD1sqFSkrDCTreaL0+jfngwkK+xVfdHe/oZPBOd5pFjG80eGj/xKCKieNUQUxeTHI66X/SRvzBUfW/4lchmYnWM0KsFNVZdL7t+D9x1GF7safsnXXRPzp6gyOyWnuFeKkMena94thsa9uws27vReSh5fzQaBUFiFgBYVvOsWJPJDlNoKl1E8d2JiYp2OhGZHLnJKAKZTd7EmgC4P/vZsdoHeR/ok7tCJAxAtPyq4Mea8wsQXRb69UunQ+RXOuf+tDxQ6qb7E0prvNuSZa9ro01Kcn2h5Tm7NLm/3Yt6C24bVQCCtalruntjQJYJXwxBdGjCdiiGtrEv0qYeYYumS6I75e7S1hv1jjZrO+PzPkyXarRYo+CSOfcC2tzSnc1c3RNEN8b/9/ktFQFRp+FPkiKymjf8kHLUJWsv7yusrrxg9J29VlMDqx1uYTEiUN4kSpyb/9X4bXFvE5fv48mjuWZ+7wI+ySD20u6aH0yfbDXO4N/KBsfZRBeql/svsi+xGOgIsq8uPEhXEkcl8hsgcGJkFKKYoqr9Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400008)(451199021)(1800799003)(186006)(36840700001)(46966006)(40470700004)(83380400001)(2616005)(426003)(36860700001)(47076005)(40480700001)(316002)(70586007)(70206006)(41300700001)(1076003)(4326008)(44832011)(26005)(8676002)(8936002)(5660300002)(6666004)(7696005)(478600001)(54906003)(110136005)(86362001)(40460700003)(82740400003)(356005)(81166007)(336012)(2906002)(16526019)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 03:43:33.0349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8373be21-d49c-4401-a7f8-08db949cf9e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
v8->v9:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 48 ++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index ce62e61a9605e..cb2ea92af3eb7 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -78,6 +78,7 @@ struct lpi_device_constraint {
 struct lpi_constraints {
 	acpi_handle handle;
 	int min_dstate;
+	bool enabled;
 };
 
 /* AMD Constraint package structure */
@@ -120,8 +121,7 @@ static void lpi_device_get_constraints_amd(void)
 			if (!lpi_constraints_table)
 				goto free_acpi_buffer;
 
-			acpi_handle_debug(lps0_device_handle,
-					  "LPI: constraints list begin:\n");
+			acpi_handle_debug(lps0_device_handle, "LPI: constraints list begin:\n");
 
 			for (j = 0; j < package->package.count; ++j) {
 				union acpi_object *info_obj = &package->package.elements[j];
@@ -129,12 +129,12 @@ static void lpi_device_get_constraints_amd(void)
 				struct lpi_constraints *list;
 				acpi_status status;
 
+				list = &lpi_constraints_table[j];
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
@@ -149,27 +149,29 @@ static void lpi_device_get_constraints_amd(void)
 						dev_info.min_dstate = obj->integer.value;
 						break;
 					}
+				}
 
-					if (!dev_info.enabled || !dev_info.name ||
-					    !dev_info.min_dstate)
-						continue;
+				if (!dev_info.name)
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
+						  "Name:%s, Enabled: %d, States: %d, MinDstate: %d\n",
+						  dev_info.name,
+						  dev_info.enabled,
+						  dev_info.function_states,
+						  dev_info.min_dstate);
 
-					list->min_dstate = dev_info.min_dstate;
+				list->min_dstate = dev_info.min_dstate;
 
-					if (list->min_dstate < 0) {
-						acpi_handle_debug(lps0_device_handle,
-								  "Incomplete constraint defined\n");
-						continue;
-					}
+				if (list->min_dstate < 0) {
+					acpi_handle_debug(lps0_device_handle, "Incomplete constraint defined\n");
+					continue;
 				}
+				list->enabled = dev_info.enabled;
 				lpi_constraints_table_size++;
 			}
 		}
@@ -232,7 +234,7 @@ static void lpi_device_get_constraints(void)
 			}
 		}
 
-		if (!info.enabled || !info.package || !info.name)
+		if (!info.package || !info.name)
 			continue;
 
 		constraint = &lpi_constraints_table[lpi_constraints_table_size];
@@ -244,7 +246,7 @@ static void lpi_device_get_constraints(void)
 		acpi_handle_debug(lps0_device_handle,
 				  "index:%d Name:%s\n", i, info.name);
 
-		constraint->min_dstate = -1;
+		constraint->min_dstate = -EINVAL;
 
 		for (j = 0; j < package_count; ++j) {
 			union acpi_object *info_obj = &info.package[j];
@@ -281,7 +283,7 @@ static void lpi_device_get_constraints(void)
 					  "Incomplete constraint defined\n");
 			continue;
 		}
-
+		constraint->enabled = info.enabled;
 		lpi_constraints_table_size++;
 	}
 
-- 
2.34.1

