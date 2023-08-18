Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4287781379
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379683AbjHRTkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379673AbjHRTk3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A65421D;
        Fri, 18 Aug 2023 12:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+RKee5lUDsBpcIfMorV6UPDCOufYta6WPZ1hXEbFUyEgp0FyPuoBCaGILiT3sXUeew8porpUwzAm8eQ9Hfdp3Q2NbtV+Q5nsaQ3tZz+GXxZzSiNeUujXb9SDhIaCfwtP3/1+ipuu5vur0LaFczCeaM7GeH0aUwzZnQCNlC1wUmWiKwY2q3o6PoaVKErjMo/guHpOvWxivhsf3qjysoBRLXLrlhnjcj5/wnZkkgXr0i3szU5VLrEReJrGX2Ly4rlxTBG4oE5I58fegZu7ti84nJIzB17hUUnr08Oai7vk/biyY0fF7dXHiMxppFZ/HdXNiX3AohCPhY7ih51nfPkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTO4xoD0fKS516BA38NxupBB6hbMB0PL0ryX2H7CEcs=;
 b=aqut4cNqqdrPZZRN7+NlVVrSDlw0GKnWDePUVXTx875gO9ySG311ds+qaKnpV9FO/Ob0Zh//++zekX6jO4dKV8JxOFsYt7MRgBH9uDSrakhWjlPRDaPVCqTN5NMdcjCjlDhY1ad+BLQR9Plk9Dky28Jl4HWAXoCEyNnYUOGFu4MiNXT/H4XvZhxNkxiLfwzPhhqDLVBwcOd/a1R3uobalitz+GmmsWtMRUzgis0rgaw2emzOOWqSFvXSUQkMKw8APoToIIzfOFDhctcFsXzkuFZ4fSpo8MANHJrb4VbHjw/lHKOD/Rt4nZoo2xRL+6kNP5mTNItTxAu8gQ3tZjQJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTO4xoD0fKS516BA38NxupBB6hbMB0PL0ryX2H7CEcs=;
 b=FGr7324ZYvrbHxg4hvjbEetKErOTFHMeZl7ULZo1gkbSTgaqioIn38JKd96D48IxBEpK2JNFv37ek8HFs/XOiczPD5/wCDMpWhm6uQGXLNUEa4dPsVBbbKz7nC1NSBYfZMTMjOK+iXqMtvYO/4IQGrxSGNFQEg/1EIU5KHZBrOo=
Received: from MW4PR04CA0245.namprd04.prod.outlook.com (2603:10b6:303:88::10)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 19:40:25 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::b1) by MW4PR04CA0245.outlook.office365.com
 (2603:10b6:303:88::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:21 -0500
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
Subject: [PATCH v14.b 5/7] ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
Date:   Fri, 18 Aug 2023 14:40:05 -0500
Message-ID: <20230818194007.27410-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b88969c-4577-4a4f-4a5f-08dba022f79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8wnGV58Rz2W1UqUPhBN3c6hv2HFhpaHOgBRsWJCR/nSMLPmjAKpzA0uZIsrzCxb7kNEA9QcthDbY43WczVEa+xA14+74PAxsmwt72TDRxVDyxAQFVmyZht3Us9+XNSH8uijr8zm0BIdfq4JaEVgrvSUgnFlha+QPCGTMmZNiUPtPetuKJvLvCeVghigDYZ/8VITxjy3NcKKN0FlEISfzs9rp6FEtlzFIyOAL5IRRevVRCejJRXls4vd5ZBS+0ChoP+07bhEPgMC4zqv6AsFmv7ufRS7cg3VweJcYrT2eGIw7LWsAM5RGaCfB8fCJe0lAShjv33s4FDxBLadKLJHIxhEKq2X85vVWodLuhoBUSdpdOvSEB9vyQIfL3DdjjHYx02afQXl006yiSU9lcu6WtcowIaTED10KgKjjjPrQ7J8aMTLLjECgBg6RA80QaHY1bSZAfC8h12P546thnZzDt5aOHXBPcziyDr/kokwgvKSN9hP//md++39Z4U8IRz8NWEtg49kMXR7aq3cCKhcv7GNmXdQqun7FUwr9LFn+NxBBzUrBzM6qcV9+j7XWOY10yJcoc1+cI8rOnKsfpVWanPiqIE1pRkGF/dTDEW2lD7QBetPki1KB83wLZJ6hZTBqSqK79qyiFO9jhXhkT3siH5dnys2L8KMv7xSdq2hkQ2FFG66knrlpOQLo78QQbJl0aShhQR7nhOHd/EG+a+uIZwYCtRc5nBKbZ8Or1TDCqUFvwlx2FGNJm5+Op4jQyg+QU/hmvtZ1Dkw+kXUHkylpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(2906002)(47076005)(83380400001)(426003)(336012)(36860700001)(6666004)(70586007)(70206006)(478600001)(54906003)(7696005)(316002)(44832011)(5660300002)(2616005)(110136005)(16526019)(4326008)(26005)(1076003)(8936002)(41300700001)(8676002)(86362001)(36756003)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:24.4951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b88969c-4577-4a4f-4a5f-08dba022f79d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While parsing the constraints show all the entries for the table
to aid with debugging other problems later.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12->v13:
 * move location of the message to catch non-enabled constraints too
v9->v10:
 * split from other patches
---
 drivers/acpi/x86/s2idle.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 60835953ebfc4..87563337a4786 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -156,6 +156,13 @@ static void lpi_device_get_constraints_amd(void)
 					}
 				}
 
+				acpi_handle_debug(lps0_device_handle,
+						  "Name:%s, Enabled: %d, States: %d, MinDstate: %d\n",
+						  dev_info.name,
+						  dev_info.enabled,
+						  dev_info.function_states,
+						  dev_info.min_dstate);
+
 				if (!dev_info.enabled || !dev_info.name ||
 				    !dev_info.min_dstate)
 					continue;
@@ -164,9 +171,6 @@ static void lpi_device_get_constraints_amd(void)
 				if (ACPI_FAILURE(status))
 					continue;
 
-				acpi_handle_debug(lps0_device_handle,
-						  "Name:%s\n", dev_info.name);
-
 				list->min_dstate = dev_info.min_dstate;
 
 				lpi_constraints_table_size++;
-- 
2.34.1

