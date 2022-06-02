Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25AF53BF6A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbiFBUMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiFBUL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 16:11:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7DB52;
        Thu,  2 Jun 2022 13:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K80AY7/n8V5nzVzV0C0KFglAe2YnnC6FVa95zSeydqoIvXs54guowoIcKQOfbokwAe8WFrUHA1pT+0tCglzB+XND44kkd7UrHoJ9Yd/P94tGQsi75tHq613FmesGwYRV+DMIChzFux3KAqzHbhl29RsTYOW2QstM+l9WavK9NbaGlrJukLGwAye7ic1VSuZFxUGM7ytICduHq/21lVbrbYN4BQV3dPlpPDPRdx8LFq9cLbxo7rIcdYu/7caCbn2yPzM9UNvnyYn2izcknoosxZQ8tGCtXpAbyBw9J3TM3l01CDLzdzUpglJOgo7mYe5HUlAwo5DEwx56cDH3OlguHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOQs/7EHd6J7m/+z1GAyBeYJ8CQ8O8nMfvot06Gej7Q=;
 b=aX/SOwZVdOT2FcKAg9ogt8Hawe2uxIkdA4Cu8RTLoKxATMWOv1qqhRTDd9UEOrxoEB85SGidjeOKcgYDOfNUzxoZvomDXZ1dJLoRTyO+1WL63btZH3L0kueivs8zSh0/qeoNswvIciqGSFw8G8PSb9aIQt6ACUXKu3JZ1VxQFFWrlwSwYPNwQM6P+vBUZoK3k2rS7jh2ByCIE+yWpY6F/L4GJCwpHo4d+7Ayi+FulZsaylkAZNCmuyXptVhXdsD3eLCHStLh5FffOpYXicB+M+XCyvb27kI6wz2V+1XT4s+obC5m7cR+rGUM4qQ8qG/+bCctn+HE8ImXowv5pFvGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOQs/7EHd6J7m/+z1GAyBeYJ8CQ8O8nMfvot06Gej7Q=;
 b=NdAUPnv1mIYZY/vJH77el5ssUpcCyafAOw/FWEJB/ZCAhwtYlKTvc8tII5ZKqiveGzrlsGw6D1pkh0RTGeITvrSV8X5n9XLx/O3LMzlpJCjlv7EawJ7BJdZhdlD+0FrWLoDBGDHSAh64F4ptfMtxwcP+4Ttxest2Em4aE/UMy2I=
Received: from DM5PR18CA0058.namprd18.prod.outlook.com (2603:10b6:3:22::20) by
 DM5PR12MB1868.namprd12.prod.outlook.com (2603:10b6:3:106::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Thu, 2 Jun 2022 20:11:46 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::c9) by DM5PR18CA0058.outlook.office365.com
 (2603:10b6:3:22::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 20:11:46 +0000
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
 2022 15:11:43 -0500
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
        Babu Moger <babu.moger@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: [PATCH v2 2/6] x86/amd_nb: Add Family 19h model 70h-7Fh IDs
Date:   Thu, 2 Jun 2022 15:11:33 -0500
Message-ID: <20220602201137.1415-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbd754a7-e6ba-4b82-2b0b-08da44d41eb5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1868:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1868693C055A4E59A2CA131EE2DE9@DM5PR12MB1868.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPN1CoJXIzluYnb6KHhzFv7NV6AjrqEy0us8hS7SF4gxvMoJtPaxN19d3S2hMheBbwejXql476tKTql0A7I8PFPuYF80I5xtVJVnk3QrbKCI/R83bfsut31AQYoGo08xmsMsBUrwTNezCdDoQ1RPmNeg7TywmbbYzZPK8vibIaAsq8oMa7Dixsm0cbjzKBCI6wPtO1ksl12Fc9JiqBUUYce0w4kCzQIFoHpGY3qKDtqdDxvzCuXq3GDH+EalY7aEW/td6OZiqOYMLmmtlEfIrMecMGxQ+LHYFuK9BfcGgAZx4iTAOGeAPWXp9LCmC5AbNNhrHfJ3ak+rSpj84ShkfFDyT+So68raGjKvOtX/5C/YFfUfvpqrmpzeLGi0sIimtonWKbwGr0l2yhlUZJ82hSh5i2800Y5gQymaqnIsnkiyOjQ8kJeL19CdHxEy7ETrnxGx+ASKpOyqMYilHU8rCiQjAy1RmVKXSd5RIe4rPzcepEtTdNuaYTNg94Z1MxwzNDZcsXAAXyUF2DNJv644ki3Z/+ThfSGuy79jqeY7y2XcV9NbY0xIvEqRByRet08hHMad5R0CSD30oL4v2X591+prctnM7IqYScMipz5chpP/hy0TZLf9DbpONywe+2NB6LbDk5UWqyFucVRzQXSeSXUJNHjMOaSy18tyE1Y4XyNL6VXSEjuO79WHGb1Ji+N3YwgAVdx9SnAhR7dz7nB8EGo86TOUjernI+LM4UBme8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(6666004)(26005)(356005)(7696005)(921005)(110136005)(54906003)(36756003)(316002)(86362001)(40460700003)(508600001)(44832011)(426003)(16526019)(186003)(336012)(5660300002)(70206006)(70586007)(2906002)(8676002)(47076005)(4326008)(36860700001)(82310400005)(8936002)(2616005)(7416002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:11:46.3885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd754a7-e6ba-4b82-2b0b-08da44d41eb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1868
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for SMN communication on Family 19h Model 70h.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 60c7bd525237..15295f5d9aca 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -32,6 +32,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -46,6 +48,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{}
 };
 
@@ -71,6 +74,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ec1c226d13e6..32a1f85ff0de 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -561,6 +561,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.34.1

