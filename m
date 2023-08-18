Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9831578057B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356738AbjHRFPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356143AbjHRFO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:14:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E230D171C;
        Thu, 17 Aug 2023 22:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOyIS5FIOr6ahxbISE6gvOYH3dPC/Ez3CmXo43ORYqc0p3qDHHgQeid4YkmumkAoqeqsX5sz7CVtu87jXrqna0XgOLqeAMXQmHd9uRfFhK4RwXoVcORJ940dJOZPddA23pJo0PFNgrTX+JM923lvE0MXzZdo+c9lOUw2mlYvAupcY+KzMzZqfg7zGasdGex60NtPEV9lejS5pZwgFQIhIeY3meAmgDuMnn5bAZQ0aG3MFbIHKgm/pNiMUQNlQuGrIXRzhr6POm+jbWPoCRDJD84ZYGF9YdBEOWPeOqDvwEdk0PDQ3Khyqn6gHNR0GaeH+Z4JMnqZsZVVMAqzFpDqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IzIfll1akRPaWeOdAZwh2X1J7LPiGKGIf/2dea8czQ=;
 b=hfa8Ra6yEBgCfoa/EhMbeCBWGGb2v8OE100QHtbfkidTemmiQN3C5n47YKhQ4cU3+DSQX5NqBZDc6VmfRrSBxzgaiHmMttGHF3dQGxZ9WcmikGTxSLZH+wzRBG6Lk55HPQB2puryZ/qixOVUeK56UgRHhz1lqVn/voFQ5tWaL+w1Ijs43XdvCEncpWim4koJd1LfuvblEr5yMfTnZTTI6QWErFXSNJkNTSfig4ZyMLEWPOsV/IoAVB2Z+/Dv5/iNiafy7p7wP/oeTDMW9iZOl8UDLfKLAdQYoGWUHOFfkfvhulbeK9MhcH+NatTx7HX1GkoORiu0P7jQZgp70G5sAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IzIfll1akRPaWeOdAZwh2X1J7LPiGKGIf/2dea8czQ=;
 b=p+Shp9k8KgOCOZb92uit+CqVpsSnMj99YMTycec6hgYRKb80zkJA+ljoos/8sAxNISiBxOL/OvHSTX/q+oWhNSgbYwwsoF/HjL5QOoZQxwCgyez7doRbriEw+n+9kOsfPXFYWdpYjDOL286b0S5x3MwnhPx8lCr2ipj4nhphZDM=
Received: from DM6PR21CA0006.namprd21.prod.outlook.com (2603:10b6:5:174::16)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 05:14:51 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::1f) by DM6PR21CA0006.outlook.office365.com
 (2603:10b6:5:174::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8 via Frontend
 Transport; Fri, 18 Aug 2023 05:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 05:14:50 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:14:49 -0500
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
Subject: [PATCH v13 06/12] ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
Date:   Fri, 18 Aug 2023 00:13:13 -0500
Message-ID: <20230818051319.551-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: a870f430-5c8e-4395-1ee9-08db9faa0cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pi+bJWAI4E010eC2jeiEY+0yDnyp+qeoYINI6fpD5qc22zvamYvza6cBq6DK3IyFuV9pAWfTx4M+UuENKwaw7VC81fb9cfovcnmkDwSKBF/B898VwsVj71+z4J2odDchI0Z7+aZTg0a6f3SQEj7J2Fau5O0DO3ebBwRcyM5LgyQxovm51d8PlUW9QthYLrtAiOmjPObEgSMqx08NxtFfU2rQPdBRLugTpw6/3G8sVUxexmpeBVP7N52K2brL56xOweay23G4mMnCH3qJrLonSs1U1b5huXxm6GQ2eXHtgSOt61Eeixcogqd8ICdp7yDhkfFNXUKxWbkJWWsMu1jKZvRdk0YHzU1z1h5IIPfTQn9oeOY2HbKjFA7limAojqPAFfu4YBiJkDuNHqQSo2y1ke3B4MleVfHSCCxDzzQ52v2Y3wF2H1/sEF29WYHEVQvFdh7GkBDMsMRhuS1OwOw22zsOk5u2PhIP74OCyPJkQwvy9HzhwRkuGjCMa+6FSwv0554lSENcX0TbSZPdmbfqpeAWNqrmUAUnG0hUrjlVHxE03tHupaFbptbxr8WBVB9/2PvKonqcgBCvcEvYB/kVTlAxP0G3ivBaIOVrTZqZOw3BfzqxgPUhwJfu+Tfg4xVmGh5Iw/2s79nAjrlkRN9+QEzMb+V95k06+UO5T9kRAbTpfACfyauPE3cZiOx8iinht0fOfvtFrXqe06PMeA0eDh9ZglT1Wz6KS12dnLchRKz5qi4lmfDBje40aIwOS+xhBJDreArxRY11mtVR+J8zJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(83380400001)(26005)(86362001)(336012)(40480700001)(478600001)(426003)(7696005)(6666004)(2616005)(1076003)(36756003)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(70586007)(82740400003)(356005)(54906003)(70206006)(81166007)(316002)(110136005)(4326008)(8936002)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:14:50.8220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a870f430-5c8e-4395-1ee9-08db9faa0cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
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
with each loop. This fixes a functional problem is fixed where a
badly formed package in the inner loop may have incorrect data.

Fixes: 146f1ed852a8 ("ACPI: PM: s2idle: Add AMD support to handle _DSM")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11->v12:
 * Update commit message
v9->v10:
 * split from other patches
---
 drivers/acpi/x86/s2idle.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 508decbac2986..60835953ebfc4 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -135,12 +135,11 @@ static void lpi_device_get_constraints_amd(void)
 				struct lpi_constraints *list;
 				acpi_status status;
 
+				list = &lpi_constraints_table[lpi_constraints_table_size];
+
 				for (k = 0; k < info_obj->package.count; k++) {
 					union acpi_object *obj = &info_obj->package.elements[k];
 
-					list = &lpi_constraints_table[lpi_constraints_table_size];
-					list->min_dstate = -1;
-
 					switch (k) {
 					case 0:
 						dev_info.enabled = obj->integer.value;
@@ -155,27 +154,21 @@ static void lpi_device_get_constraints_amd(void)
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
-				}
 				lpi_constraints_table_size++;
 			}
 		}
-- 
2.34.1

