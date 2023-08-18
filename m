Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B778137B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379670AbjHRTkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379672AbjHRTk3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B53C3F;
        Fri, 18 Aug 2023 12:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFRPOr6BMF/N621MM50+te9NMMuOcsbQvIDhPR+6dLuuEB2yq9vSiaTHjog6Bnj5wM+HX2m7WZNJoLJxB2REncGmMmIzU34omLTzitXrYJ73tcpZMTtjdvNKhjnW1x0dM4VsWwm8tayEMiFHmbB5tO7pP/i8WPULHrvvQ0cQqpYFmjRDtrhO6dHMCw+vcnabBmqd8ZO1OtcrhsTuQjDfNXjhuAoh37B77gBPQ3kn4A2uFsbR5foYqXEU1157v+pIGJ94uUUJXAH6XskfIY3pMVew8gCI/C/7xZa7LLNHgucA7Jlrqg/chmvYsCpB4jgBIpqKYrcoGLNuIsNsKj7GlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9pIliEasY3hi8iYJYhXDM/t9oeU4sjbjdpuPj5rH9Q=;
 b=d+SapltKNYLM2HwYAdK/em3rh35nycj2G89D+TV+T9SBTH2gyUdmdoYXVHzFUd4v17Q8jU7bh5UH1yfvJmGsnaHKHsstk0y+kZlzpOLc0vNBeiEG8bdvLPUnrCghG9MvhjQjbffkJE/KQbH2JpXjS8rw3nenmS4/pcALhGXktZc9IrdoOAbcLwHddyimjjI+Zz1u/Ppc6CmV/IalTGnf93fPmQhtQRXzQBLxPVKop5aG2WMdXNj5oMV6zxC6Da37a9jVW1LVd+y+P1MfmiWx+/YlMV1zGqjiSgZyWjWnxi2WcdloFs7UTMjM0SJPVNA3VCe9HwM/yd57fs6xsTDZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9pIliEasY3hi8iYJYhXDM/t9oeU4sjbjdpuPj5rH9Q=;
 b=OitMJazDliy0w+DMTXxP5waqlZDQRy1DO/MbCuba4ozvKIccNLXxt9P1K3AUf79onIjUBSzkFlugWTrdleAfQM8n6eW3GCOSRxgljgE8l9MEg/XN8aKtGXP2EDY5YXR22CLRg/00LEl+7y785DoN2bAnPgQx0y31JVtYOCAU9Wg=
Received: from MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 19:40:21 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::71) by MW4PR04CA0254.outlook.office365.com
 (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:21 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:19 -0500
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
Subject: [PATCH v14.b 2/7] ACPI: x86: s2idle: Post-increment variables when getting constraints
Date:   Fri, 18 Aug 2023 14:40:02 -0500
Message-ID: <20230818194007.27410-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BL0PR12MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 9460988f-7ce0-428e-73ff-08dba022f5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qILOEIVONLdRyxaD3UpeE0Xlo3indhsMb0/WzkeK/TU1OHxseHZRQsw+6UKovxGN/9u6MSQZyePS7IXHKRwwShLv18ZIVZ52RKWjBqmx9ZEgFD9poGTdXt+lLfrsW4h/hzDLZJjOZB6Vu+0RVmvUJIRBa9vTfhco7ZN3eNCJQPNppBazjUTG+t86/L4d5ZP7z4F9X3kbEVBo6TUs6ParuR669tS7CXfQmAACrjFtiDNPuRjeHuBWHU7hWA51ARGQTfFGZVFwudPVSDrnqurI+Ab0wisO1TJAT6l3RFGkvLNNnCtjNdNyo7XgR1jkRJCqyvbOETxRJnawslfBstDKbr4yeidNOZ2vdYpYFZv5XnhFDYxUUG3m5k6qS/g3WZ6TOWd7erp7g0gNAltLR7iguKzxxTRjbKhEMXrbyRDQqHu806hJf3IFN9Oyl01NJWr24q1GCThOzLzYFA/+cgyQ44EbH58ctyYzhcChLzuwfU8UARVnzkT5AvneEIU/B5EBSd8+LI91vWi61itjFS/jPaG6WSWQ07bbuPQFY6RJ07TpwLrPB44wYVOokjR4tktrVWFf2/QHUyxEs858tSUf8lkZ7qPECiWFRtBY9bHXkop//BBr9j+c72emfBkqE25miAZ5ykAZXMlT0MloHXofSd1uqTlcNoPS8oa+aLuLAw7xMLeosVUyiV3w9VcHnrd63g2Kcec/fRTcDhuvWbhF6vlutvKIh1gTaoaq5lZz6tC5faM2UxX+ZtChItlZNno5sNu6Ddg8pUeh/PcdvNlXqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(6666004)(7696005)(40460700003)(36860700001)(16526019)(426003)(336012)(40480700001)(26005)(1076003)(83380400001)(36756003)(47076005)(81166007)(82740400003)(356005)(2616005)(316002)(2906002)(54906003)(41300700001)(70206006)(70586007)(86362001)(110136005)(5660300002)(44832011)(8676002)(4326008)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:21.3701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9460988f-7ce0-428e-73ff-08dba022f5c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When code uses a pre-increment it makes the reader question "why".
In the constraint fetching code there is no reason for the variables
to be pre-incremented so adjust to post-increment.
No intended functional changes.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12->v13:
 * Add tag
 * Reword message
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

