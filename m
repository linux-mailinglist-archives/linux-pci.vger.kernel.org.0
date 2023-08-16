Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A36577ECC3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346771AbjHPWKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346784AbjHPWKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D707C19A1;
        Wed, 16 Aug 2023 15:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+HxEhz/Iu+w8NEGZHOkJWAzmPcS2IoRc2wIfbo308JwiGfggmuHwrXu0kQvT+Pdn9pEs0xv+/vgCBS2SZXpUrUYPOD/HR2aG9HHNhhRT6jc2VO266Rz4e8B2LzWlt1m+QruCFv7rvjj7grqDJ/G/bcVsNComh4aJal0MOdFe/iAvnpL5hWMUbdEGbSE/nNxnxch7DcXe/zU3NXfNJE7Dxdf8Ub7X22q5webP1bwTZNn2sM4r2nqj7G8b8NWUJOZgW+prrBCBGeWkiULERdK6Odx/skPzjiivR7qRRPzhXsAmpcfNnlrfEMUAwtzCen2nnAip+cgVoHRp9pI+wmezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEDVgXKd5mNpSBxC3wfR85w392WHlAZwDxTaCkxX1Vw=;
 b=HBQDN7cLJIZPNuS3Tq0kksGneb/Z/VVzpepNtvjd9b7NkmvsvL2uMrlNlyTQtf03Bj3NhRPeOWi0Jxz8D22+Wc6Ea2djeNpH5OnI3Qs+Uh4wN0wkaGK6rcuwGQq1Q+b3l83aWhPPalKEo+9B2bh13p2sMc3DtOCsfMwEMfU6/p8sxb6tezzMeOpd8KkgrQWKGhPpAeFBGZ38hmISsLZ6uBqg1SOyEse5z1OelLZHmAoObBd3zHAe8Z+EZxydqZQD0jux1ORLTeqsCkUCdHc1vJPpnvzjUZ89gQLzKmhgUMUDRiYdXrDA8yxdokywDY8V58plIylPlK7KfcS/MdDExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEDVgXKd5mNpSBxC3wfR85w392WHlAZwDxTaCkxX1Vw=;
 b=NHwH5u8DeILz7tpJHywV03EUy69tHcZlQVFpk01rRkGOqhVEYrYW7237eWVpv4D73OTgWyv3RpaNpTt6Wlm16yJMFfzECU6ATS8dVWox/SZB302rUiwTb6ub1MOvpeIgDm14XBo3cO0JvRTfaS5StGwH/E6sgpW0r8yfMQbX9zE=
Received: from CY5PR15CA0220.namprd15.prod.outlook.com (2603:10b6:930:88::22)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 22:10:42 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::40) by CY5PR15CA0220.outlook.office365.com
 (2603:10b6:930:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
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
 2023 17:10:40 -0500
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
Subject: [PATCH v12 4/9] ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
Date:   Wed, 16 Aug 2023 15:41:38 -0500
Message-ID: <20230816204143.66281-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a7757f-e826-42a4-9f92-08db9ea5a17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7jqrxNc0x5/gvsj7oR2MMqIgxhRXePxVHVKCd+93fq1YiWjNYEoluPj2dCUD2K0Q0M/PUuJXnjNlkzRxY/YPP5+q6BnsekUvRg0cytF3klXYhQ4fPVHsh2kAcJg0RyLtAXejVO0OEd8k882O/IFFju0k5TEJOSaBAhnKMUuuT3QKXtMC0FY67fAfXoXCMd7gAP+c6aWw4y547MhtRG0pNJlVa47p0IbKtdgteNEm8OTXXnNOZAzE+DlJ1Ddz8sDgj7G7kdiUy/K+BmVD3fpmfzvcs0DXw554IpzCoixHcNjf+LlBWRY9WgDxhjhlBYJKLvLaYmKrofAfeOyQFrC/puc18UPB/+cP6OYoeVBKjERXqSMEHLF4YtQtir5UdbFCq8i7txo5wEH7QpJ9A20/7l0qdKaEqn0xj4kVThJ5lMncFFbf1xTTNDE0heqzyJn/ERcNOXcoNyEag+7hbNdN2pAp75sWe+RZFS3g5mtk+69eOXgTLot/RgdoQa7od8Doy0HHcgYBPUXLF46y4gK537FUf60s2ZTh+0vDSiestaQjqkIKHR8TQQCegqAxry9xPqwmJiMRy7E96hZFUW9+Vrkwi5Qi0YJ/YGQgb4q11pkj2Uwmt3b5CiCAu/6X3p7lHTEKrHjHYRuc+12uuY6XTQehlbQKfRej7Jn6gEtNkKXTAZ3Le6EnhIbseW7j11TEUZ7b0q+XCwTYMSe3aGbiTzfbBdonFM7OBnCd70SPutpDuwAevb/hyyTFEigLJtThOnS1vaBSLC3pxXD8Im4Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(4744005)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:41.8054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a7757f-e826-42a4-9f92-08db9ea5a17c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If a badly constructed firmware includes multiple `ACPI_TYPE_PACKAGE`
objects while evaluating the AMD LPS0 _DSM, there will be a memory
leak.  Explicitly guard against this.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 7711dde68947f..508decbac2986 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -113,6 +113,12 @@ static void lpi_device_get_constraints_amd(void)
 		union acpi_object *package = &out_obj->package.elements[i];
 
 		if (package->type == ACPI_TYPE_PACKAGE) {
+			if (lpi_constraints_table) {
+				acpi_handle_err(lps0_device_handle,
+						"Duplicate constraints list\n");
+				goto free_acpi_buffer;
+			}
+
 			lpi_constraints_table = kcalloc(package->package.count,
 							sizeof(*lpi_constraints_table),
 							GFP_KERNEL);
-- 
2.34.1

