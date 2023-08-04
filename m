Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9F770A3F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjHDVBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 17:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjHDVBt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 17:01:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDC14EC7;
        Fri,  4 Aug 2023 14:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8CzH4YvMTxbuMjWQDol/bbIF+WRHdt6sQyMuc3P0VkmedzyuWTUSvseQob8XFTvsxUpOlYD7xB6PaFsWTPeO/IHq6oDEZqKln2ebW3arOHNWbi4TetdYOEOUQarWCUE44dkjqvgcj3f/72z2fImPlheyDaUKzqTh9Gd023pXdf8NrO3r7WQTHFE8RkkHWcvBttvnsXRdLGj4ta5n5cNkYtt9GyrgF+OK6yvD/fKqxoFvSXJpho1QatBzF4ltrzxqF1NYeW7vDBg3kRk3UBjwWBFj/HISH+2yNKo1/bCpPhtmmZLjnSnMZxe5y8IgeR342KHPmYFs0+6DTYuB5oMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+TY3ImzioxIbedi45ZnKUekgHsOAKUBzr+1AI1cdws=;
 b=KUAIYeo3oOIHvJBeSrlZuAbgFclbQ1Cyz6l9NYSyw6ChQQWZfFkrHxaSwOIqWCIw2pvhvfx0yUlS6yDOpYV64gDiokS9KVzxxzwEONw39Ku2P2b1u98Nx3UclAq9XzEb3fxdtj6juiSgrDXCat5NDsoa0XORusroZj93APY33/ZHNbpTfOehPDQEx+b2ZPrt+1Anq4NdAxsVQOD/V1GBUeBwwUSQYh6y0Ixc9D0RTUVxGcDsltoeft2NUUIhQFiXibFcWAlf10b3sMfJqIqunVnT9SA3/Ru+aTUTkg6I9DaeBMP0T9XPLD4VJsGhSCIVi2mI5dP2WjOxnwc/PnSewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+TY3ImzioxIbedi45ZnKUekgHsOAKUBzr+1AI1cdws=;
 b=zVyP130PvPauLtF7MncAtlXmkcc7TJpwO9KUcKiyvKKeemrXQeoTfQ0+MrrWK9l7KxCVEYqST03Txp55U0DOUjThpxOb+2hhTiGw5MhCbFjs+VqZPNbE/yHomZ1W3RkfGMFSBafjfLtd0g4kTLN6u5c7xO/VSyNkHn9mBHn03Xk=
Received: from DS7PR03CA0261.namprd03.prod.outlook.com (2603:10b6:5:3b3::26)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 21:01:46 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::b4) by DS7PR03CA0261.outlook.office365.com
 (2603:10b6:5:3b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Fri, 4 Aug 2023 21:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 21:01:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:01:44 -0500
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
Subject: [PATCH v10 3/7] ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
Date:   Fri, 4 Aug 2023 16:01:25 -0500
Message-ID: <20230804210129.5356-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM4PR12MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: e621c67a-83d3-44e3-f4cf-08db952e0355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/+Jrqn8YELcYifXNNhCstfGuQw4s4VNtl2gUySRViUFizz9xJyz2PQ+CpYBHpzittetKirOd+YLrgV45oBe35j/IPXfDT+he7vGDF5mgDMOmZDX7lSC4XEBxhn6CCUPqBgKGwsqtVR9P9ecfM5oHjjHlwt10uGt9nET4WjT7mYZlfywVERkn6hTj+FVGxMUhk3PG526I3o0yUGRxgOQAM/F/2AauPTpa774s/imWPO2MLzvDaJeYFhHdARY3MAdFzfk9WZZgZC/qf4dZx+fkea8vTSIgmv9U4eIjSSd/JvkBeTHQO9/g+IZMmlHQIAL7RE39kYFunKoOBR2j3XnAiaFazFGIo+RBZSPUCIjsyRYtOapx9WbpiIRL/oKzIQnNcVgDEtgf5/BPqJH0+0hQB+akD4Tgy4ozgy9wRBvECVD1qlb69QMLgMlcLgIFNwdU6LOql+hF0jqnH97K+5U/XLxW3PcPXoOcXtgN+qd4mo+RibzVYEUOC/SWT0xjViXDQoqyX8VFbBt0lVJY1FPIjLFiu2f7/gZMovYUahdc82/olWfd4YLUhMF90QyLGieLfnRpcWstuZGgC/eoErn3DcBDs+HPX8dJyT2VI99y8Up7Lc2WGI1VRnGiQxv4JudKwa+d964UAv8QWTJbQT9/yxXyBxwQ2W0Kv8nQjylCEHG1/boCUXS0/QHedZG1sKsWGLCYimkIu23iDQxK8g35xKwz2PXeJ/LIrSwOpBrWliEBUveLqr3rL1Nv4CvXolek6dYBZaaMioYbshKiTe/Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(186006)(82310400008)(1800799003)(46966006)(36840700001)(40470700004)(7696005)(6666004)(40460700003)(86362001)(36860700001)(26005)(1076003)(40480700001)(426003)(16526019)(336012)(36756003)(2616005)(83380400001)(47076005)(81166007)(356005)(5660300002)(41300700001)(8936002)(8676002)(4326008)(2906002)(70586007)(70206006)(316002)(82740400003)(478600001)(44832011)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:01:45.8962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e621c67a-83d3-44e3-f4cf-08db952e0355
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
with each loop.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9->v10:
 * split from other patches
---
 drivers/acpi/x86/s2idle.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index ce62e61a9605e..b566b3aa09388 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -129,12 +129,12 @@ static void lpi_device_get_constraints_amd(void)
 				struct lpi_constraints *list;
 				acpi_status status;
 
+				list = &lpi_constraints_table[lpi_constraints_table_size];
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
@@ -149,26 +149,25 @@ static void lpi_device_get_constraints_amd(void)
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
+				if (list->min_dstate < 0) {
+					acpi_handle_debug(lps0_device_handle,
+							  "Incomplete constraint defined\n");
+					continue;
 				}
 				lpi_constraints_table_size++;
 			}
-- 
2.34.1

