Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2BF6F006C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 07:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbjD0FeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 01:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242821AbjD0FeA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 01:34:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B35A2D69;
        Wed, 26 Apr 2023 22:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6vGhsZjjA7NzGtGU0pwSzIiRQcI795oYMwMPM+/c3bVhO8kOUkcqjSZqKpT0r2a4yhB9nrkpJXb2QCWCRuUfPkfpy9XJNeYJUN1j6e0XPwigPdHiD7oJjQx262GISpnMMx/zvyThlcRCM+Lr3CfTl9WjuKY2Gc39OZgSISBFWpMNFUKZR6uMNRGmZ4eFmyFblGaclxgc9tFPdI3gu46WfOQI+d5opVI2PWPHwNDyAQ9zuSsXL187cqojiRVk/EhPFBkc1XSXWYUawBTmFxz471QEBGX8XUgoNQaC1VMuJivEyAyWLTQrrkeaagbxD5grYdEqVOt6uYlXskOND0b8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddIU3m+Sm+uKTF7l8g1GkIxPn9oe6x3D0wp471Zgy/o=;
 b=T0dmdGwCC2thHBnLZ3/8HTKM2b1CM7dljMBnb9XVp/lt1tUZPW1+HrmiTf/HtCCt8PCQ3KLb0J50NVat1OKvit6Lxb788aZMBm/5a/zbl5Kz2RvzsZAcii5HXHJArB51AD6W0RF6jXmQdjgHENeZmFk8hVbtn7UBavhylIsTiMn0VFm0nci8BVJX7oKo1v0WCtqU+8tz4QPBe5evCg7DsH6o/WkTqwp/v+2QbwXy5IptdCmiJl1mBse/ohXvMwIk3pI68Vg2LX0ljvo5sFxZuYcOZSvkVUeXoB54Fvto7W5KVUXzY9hGxr+ieCdoguBHFhwMk7TALFN2SeWY8wAk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddIU3m+Sm+uKTF7l8g1GkIxPn9oe6x3D0wp471Zgy/o=;
 b=xgkbIunyPYzoUxYsBmIwTMAL6CHshByeDBWX+NWtGSZLbnErIN3WCUrq3YtYABFLnK2pLt/jTmQkY1laLAude4QMTnwtOOMxRz2oC0j7x9CuuxDkUU435ztGCkDCARZHedl2dkHtdjUXDS7rJ7VE6PQmXkCbK6j67UKPXBFqrOg=
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 05:33:56 +0000
Received: from DS1PEPF0000E644.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::3d) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 05:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E644.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 05:33:56 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 00:33:54 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>
CC:     Richard gong <richard.gong@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Date:   Thu, 27 Apr 2023 00:33:36 -0500
Message-ID: <20230427053338.16653-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427053338.16653-1-mario.limonciello@amd.com>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E644:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db783eb-415a-4d67-2550-08db46e0ff05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7a0jCyqW3hvKIltE2tNrzwEsKKmnOzf/r51CD6pUqGtGNCrffxSbmIzdJiw1zluTI9FNeo6Rs7jnBQMHGWNuQ3rVwkNOcPsQFMkD7tKQabD7NbS/L7Q8owNUPUx8eR6345yHXRV6Lpyu6b/iViq+E51J1wn/NPIC03O7r391mtW5vtBUQ+44Wfqt9t3Zx6J5XAU5H+B3yNPxqL7rn4FitrTvTyL7Df7IOy0YfAX1BYvcSxZFmOqIwICVjpteYyoBCAvFKCtWL8FK0dOw5irgYKaNJHG2m932CXLnvQKo5ryU1/qqrcWUF1w8ObdDfCORsThgRSvzZAGPggUx3yW8Ge88MAi0D2tmb7ys/dO2l1vvxQiNI89oNE8m3kdvOUW/gUHCxVK+yeMEOcYfG+xGIv/pAXkJsuBRnCeR+Sn/0SkUZ+zrKakAQlldpTXsf1n7prdRYW/+7A6ITjI+oDC33UiGvoioL6yPR32UMKG5Ypqo+dAn9939r8NwiaXe+unOOzb5ChYm0MGIrEYh9gDcpYNLu/adNnuW9K6i2HI3YsMMlf1pf3HL83+ENrd9mLu2fAtqndUb/orkZKpOUnNrIdn6DzUwzS3rPZP0zRiCgz3F1IqJRWMruNz2xV8kfcEh6KYN2tQ8fbl0bZ6TEZd4KxrxiR2ioqjctXsLXdXdM0JWCr97lFcbioVl8jAGKGIfxQCIhLRGM8K/irBwPL6c8PQiuO/Sgs4S8JRA2/JohIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(336012)(426003)(70586007)(4326008)(6636002)(36860700001)(478600001)(7696005)(6666004)(2616005)(1076003)(16526019)(186003)(26005)(110136005)(54906003)(7416002)(2906002)(44832011)(5660300002)(36756003)(40460700003)(356005)(81166007)(82740400003)(8676002)(41300700001)(8936002)(70206006)(82310400005)(316002)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 05:33:56.7109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db783eb-415a-4d67-2550-08db46e0ff05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E644.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s2idle previously worked on this system, but it regressed in kernel
6.4 due to commit 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN
index 0 for driver probe").

The reason for the regression is that before this commit the SMN
communication was hardcoded, but after amd_smn_read() is used which
relies upon the misc PCI ID used by DF function 3 being included in
a table.  The ID was missing for model 78h, so this meant that the
amd_smn_read() wouldn't work.

Add the missing ID into amd_nb, restoring s2idle on this system.

Fixes: 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN index 0 for driver probe")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/amd_nb.c | 2 ++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 4266b64631a4..7e331e8f3692 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -36,6 +36,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -79,6 +80,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 45c3d62e616d..95f33dadb2be 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -567,6 +567,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.34.1

