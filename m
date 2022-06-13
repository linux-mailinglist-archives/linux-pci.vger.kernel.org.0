Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF621549F8A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiFMUjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242497AbiFMUi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:38:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735E5BE57;
        Mon, 13 Jun 2022 12:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYEkoRqvqQ4vL61CXRe1QK6R4ORa746YJIbxw93lw4mllfMKkoHVHL8lyuxMa9Htl8wyJCOoUGoWctS6jW9oJGpyoVnot4KTu5wVhNNO2zuGHE3fncKAk21gdNyUxke11e9VSIoPqrxSvtlpXejOAizPstBw9oGUQGKRTvtc2cEQFBJqKIjsQwVlSJ44JTH2R6IiFBp+RenNIniz6kphPu7tMkbR5lwkjaUTYQJx4coldGua36j75X+bENG25qi5G9HqVkI0JGr1tjxoLCuFLKULZ+N8Fkyy5OocqBTDUji8wQB92DVn4p7la4HMND7vVkPuAGD3BCogHuf0uqnhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IKQ8HtSuexS2DKi3KU9//b4rAAr99NK6swvTkNc+ao=;
 b=lBgNSBv10+heSlcUNiDGopXIp8VV8kr4HdN9pv3ChK6PXYODN1K2i3eoUi6vFoxQJCZoTgExEAG6Uu0uxn5V5uOFm3XisYvsaJYApysUJt96R5qzUnT0nI76bcpOO32HppmPc+119qIVjJXeXI5wWk1QLUjBLlhs+uAu0iye0RdBUe3snra210FYIdJrEgEACBhdm5kow3vCP2edQnYvLG0bmgpPl8GkqfdSANd6sz84Zza1C9M23x9qK+RtSiaHAlo9gcjqhQLrvvs3m6hAl2wEMayjHvkyP19RE4Z84gx4UhDr0U3wHoM3OfRjE1luqfL1+VIBLmUDLgSMk8M16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IKQ8HtSuexS2DKi3KU9//b4rAAr99NK6swvTkNc+ao=;
 b=jzVu9v827kTSjm/C88Ru0CHoVFxYRcpGQiJvA/WTYhawn+fpLauEoLt/r09uKGlVkomF5cWZeZ/AU9OqiAOTnEg5YbEMWtTnzuEAZv20vkOZRwo2VHdQmbjW/dwL2dn7L6l4+24pJ/2rThjDkTpdFnOgEv9lgumoFGEoDX92ut0=
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:16d::17)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 19:30:18 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::9e) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:16d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19 via Frontend
 Transport; Mon, 13 Jun 2022 19:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:30:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 14:30:13 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Muralidhara M K <muralimk@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v3 3/6] x86/amd_nb: Add Family 19h model 60h-6Fh IDs
Date:   Mon, 13 Jun 2022 14:29:53 -0500
Message-ID: <20220613192956.4911-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192956.4911-1-mario.limonciello@amd.com>
References: <20220613192956.4911-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74733680-bcb6-4a94-4c00-08da4d7325d8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4493:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB449302D08411AC8D03374847E2AB9@SA0PR12MB4493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSNJTGMpxRV00fNzddUORG3h23M6+9p447XlRLoKdKzfSsdGpE7NpkLjE/4ET8rR5eH0/iImwSRORknqVn1EwtIHlCTlTN1CV9IhUCSrTqG19DpeCVCflX0fjfUNbyqoTwlA4rje6Gcy4GzPbut1/Rt5nvKpo9Bet+PQCH2Lxma59ozctqwOfasDXgSlwoHc+kYdUp7lZeeB4v8xla33xDRPiaOI2W+DCutHoPzf727xEHEo9ceTn4IVfVcJhC22SOCbh8BV3ePBbN4bVvQriWA/R4DOD+9Hh/AtK7UR0TOfTJZbx1/Hj+s+SqJOsPCPlhP5Bj2sy6eBelOCrM+qwatmrg7rp7sXQuGFTe/c6UyyRF5Qj+J+UEEmtVkrHhYz8wZqBC1ieFKRTEMq8y/LSxRIsP61ly7/1ISvpluorlqyQohJC+sHPjEbETc3mCmwcrsmYxVFClo45VEWh9jFlygTXdMk0xSVlfdMYN1FXTAkyl6LVJ0Z4UE9iwSW8Dl8oVSXHYLGggJkTjUyZsrXnBfvF7+AtXqJ0tnFee7SD+VyjgknUWgw5E2Si8Ye1kHbyS5fesXxg/00Y5mIfNEhQcYzOchb6tuNSN6k5ttScEI1mEpwsObEIhaJDHBlOO/h5Nvu3UZnw6m+d2BvaeyibZO+ex3e6wFlQxbkv2ZjH0HUOkUsQVBCbjXJTZH4kOjo3l6GaMeM92Nfbil/VTMqmntIvAXwVryICmozwJvOXwM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(47076005)(26005)(16526019)(426003)(36860700001)(7416002)(7696005)(2906002)(5660300002)(6666004)(44832011)(336012)(921005)(356005)(36756003)(8676002)(316002)(54906003)(110136005)(40460700003)(81166007)(508600001)(70586007)(4326008)(2616005)(8936002)(86362001)(1076003)(186003)(82310400005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:30:17.5981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74733680-bcb6-4a94-4c00-08da4d7325d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for SMN communication on Family 19h Model 60h.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
v2->v3:
 * Pick up tags
 * Move ROOT declaration to match others

 arch/x86/kernel/amd_nb.c | 4 ++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index cb7a40378ed3..4266b64631a4 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -21,6 +21,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
 #define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
+#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
@@ -33,6 +34,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 
 /* Protect the PCI config register pairs used for SMN. */
@@ -48,6 +50,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{}
 };
@@ -74,6 +77,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 32a1f85ff0de..7fa460ccf7fa 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -561,6 +561,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
+#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
-- 
2.25.1

