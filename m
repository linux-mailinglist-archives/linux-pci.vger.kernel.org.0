Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69853BF62
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiFBUMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 16:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbiFBUL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 16:11:56 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A567679;
        Thu,  2 Jun 2022 13:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqS17MlAcinQ1hUv0JtTbVms3/C0DYkpqts/qHvx/TSYPn/7R52IGzWDPlrNjel53CJGuKoJapVPSOIcztWmCL21jk1dUE6nFJbcMw3yFz92+n6lcOixabJ0ifVTYWUxbYFXHEfDA+1OehYkDR9mD7caBAEgV+ugGoHbxb1KZqEjpa3T4kD8CKzZIyWltyFMfQSMw6HIHyVjuNj+jRwu1D4sPYCQKrUyz5rWG3mi1t/xpB+UFRpYJ7DIz0d5+4SDxyvQePa2FKv2kbA1iMQGsFDwg5cWC7HaETZXM6RHSu9NbNcXanm8v6+ZlKf/Ouxztp3bzhM3gXjJ8M5bPqmW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tItncnJI0XuN8JODRVC81fEkA525PLZ6Su56wn84K28=;
 b=ReiGnDVCK6RNMQ3RsyQzLPtZArLBA0dSLI3hXVKGDHE3GWV+liZhMEw56RnsYpyw6sPLj+FKIf6hXey/c4cvkqXeMNi6QDhibM6y5H9O4m0n0sllvcHtGu1BbNTVYkhtYSjwZmZhSGQW+JSxZ/IqZEdLCPsP1Ynz8ZE+GPCAuW6kFcrSyvlFCGTCAhDLoBZ9z36la1ANQfPNRG0tFjEYKqTNqwB8BTaAoBBxo6j7DaH9pB4UpNXSmGQqLq/LfaE/ntLjSN4TVsU/CARMWZLeny3pwRUr9m2hD0JeAz/SAUItxyOSGZ8YxKYgcTGEZF1ezrxvaLDathG/rAqenXG1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tItncnJI0XuN8JODRVC81fEkA525PLZ6Su56wn84K28=;
 b=z/xiz+N2eceOnZB/m2hXGm1QxePktSK84fl3ziGUSh6vH7KKlSgFUEYlKFjqIkPQ9Bcwz3es78F0GcXiLtQvlejZJ9axIjk7l5x5ejem+c/CUMH+O4P3Nt6vr3m6bmuHItkHh4GeF/XJGACVvTH+WiK7+dbSqPH67PJ2Uth3zjA=
Received: from DM5PR18CA0051.namprd18.prod.outlook.com (2603:10b6:3:22::13) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Thu, 2 Jun 2022 20:11:47 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::d9) by DM5PR18CA0051.outlook.office365.com
 (2603:10b6:3:22::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 20:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:11:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 15:11:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v2 3/6] x86/amd_nb: Add Family 19h model 60h-6Fh IDs
Date:   Thu, 2 Jun 2022 15:11:34 -0500
Message-ID: <20220602201137.1415-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602201137.1415-1-mario.limonciello@amd.com>
References: <20220602201137.1415-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51b01825-0301-4d3b-7537-08da44d41f01
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4124FE837FACE3CFCBCF93F2E2DE9@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWXW+27ltCbV+KC/WSjous3vOE8EhKaE/ax5y3x/ybCiGAo4qXDPsrbYP3CUrTn1afjdFerweNoEQfmcPG+AphLYadLFZs9wnBMvUKSSUdEyLYvytO4bDaJ4hu3n1io8ZkIWfjKvVnISi5ISebGgV2L0Qo2QjItQK4BPS9ljEL83DwJMkTyN7ujf6rPNBsAwYPldozupWi6GDYee2DPpUi4ZBwPoXSFaR4S/wsh2pOrFOgyu/ayazjcc2mW3vfwrsMQIaVjqQt7KE/LWn/7AeFXfxLPN9CJiapoc31o8t062EZ82iE6EI5bm+2CQLX52hM8xZbu2C+NTcyVOBOWYGneHkQqrns2RYxOd7SMvVrjAWScTp7CJHFw3bnxzubWGkS7C6aehik412veADUiZKs7Bfq2vDIzIWWNSqWdbyAgzFKST2fb3Tke86REFTnRRNJ0iZJmAuvdkBAkgA5tLg49hyTZiQBCgb+6EsynuAX8b8uaEd0gIGGKm9ALe2bagivFhZL76R33DNhOR9LRU7C0BmCNym5AHFXJDyXBNtkabvAjuWrfSE0wFwG85B/nD+pyoLwX+7vQYa0MzlGspYFy7sQIMH6xe0GfTeFn/sB66mXgzWK2rMkUOZTJNsE53kdNMpYyLEzJ12gmQW8ZQ5hIJscsmyhu1YhxLtHRL/RDHchdHd0y+WAiT3aPZKFZw75JvboflXxoAJFOVNIHmlZJBW3KPAXj6Xjv/yWs9A38=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(6666004)(316002)(86362001)(2906002)(82310400005)(508600001)(921005)(356005)(8936002)(5660300002)(36756003)(81166007)(7696005)(7416002)(110136005)(2616005)(26005)(40460700003)(186003)(70206006)(70586007)(54906003)(16526019)(426003)(336012)(36860700001)(1076003)(47076005)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:11:46.8260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b01825-0301-4d3b-7537-08da44d41f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 15295f5d9aca..491669c24ffd 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -32,6 +32,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
+#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 
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
2.34.1

