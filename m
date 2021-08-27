Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF53FA071
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 22:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhH0UQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 16:16:32 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:5454
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231576AbhH0UQb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 16:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDr/n6qzna7fb4X3MtCBubLyTFWL5alX4VVnm08szVFl9rvjZNUoqgbbBbb5MSJ9W2yEKUIf33OyW5sGNGmlYX6Pl14I2yxjQcjLbkLaFbyPqvJKH8a1Q7B8HGoEuecUQWNaqR3258RoNfqBNiyOge81myk3YqZQbQYLRE4F+yfzL6I0ublhTUvqZHXpYsHu9Ty8WYlqzedwI3yQlrk4D0wgNrvUZuZFHeWvlXMk8IQu8vGAqGIsplbNsIsFzXHK2572YlnP+qveA2ft+alfmLBaGh2ne0VgjI6a/bV8ihUphdcwqNPC1I4TtPsc5Lm+s1uhUWavOpKAPGaqz0jQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLWJyROXL1mehOjYOyq5RdtKiMcZZWxh3cq9ICX/+3I=;
 b=Ma0nXPQoWT1Y7UAMg0/W4GVBrWXJPY/Mf2FNy+izs/Y53i3x5ujgylJid02z1TWQFWnoOGML8E8gBQVm3Fkprvhw4YGNS8Tk9aLLPH0eLuafU++XEYHIixwCEkT8vjk4Byzb7J3pSqvwlsEoQtlxGJ9CfgTNgE4ghG7OPWf4J04L47nEki/wR2L2UO5EHDkTtDSphrcpKVtvIQFMru/sObF8xCf2Nz20zmClOO5Y7SDZIGoE0fwx4niSUxQmi1Cz1NAKEM97NiGZ/U/Pr6tQdr+awOB2UpWAFy4l5Yf7gsWrc5ihFSeCZHXmvTxDlARq4yoQrYRdjsPupZWvaHRa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLWJyROXL1mehOjYOyq5RdtKiMcZZWxh3cq9ICX/+3I=;
 b=wJMwiC2EXdDxKhvv6hvpOU62P96+FvWSCYWcR/L4RneT0yhGa0ail/1/GweK8WuqzZH2mVwsSU0S3VZlC+leBzFev8wn1YrrHGAsowYvMFwETQTf86msTfoQODxhxB+uqIJhuVV1tg7tZ2N9jDf/qpF8nAbdR6athHBJ5hCmEZ8=
Received: from DM5PR08CA0047.namprd08.prod.outlook.com (2603:10b6:4:60::36) by
 MN2PR12MB3311.namprd12.prod.outlook.com (2603:10b6:208:100::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Fri, 27 Aug
 2021 20:15:38 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::55) by DM5PR08CA0047.outlook.office365.com
 (2603:10b6:4:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 20:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; ladisch.de; dkim=none (message not signed)
 header.d=none;ladisch.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:15:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 15:15:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>
CC:     <linux-hwmon@vger.kernel.org>,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wei Huang <wei.huang2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jean Delvare <jdelvare@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        David Bartley <andareed@gmail.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/3] hwmon: (k10temp): Add support for yellow carp
Date:   Fri, 27 Aug 2021 15:15:26 -0500
Message-ID: <20210827201527.24454-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827201527.24454-1-mario.limonciello@amd.com>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3c8450-5ad5-42b0-3536-08d969976e5b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3311:
X-Microsoft-Antispam-PRVS: <MN2PR12MB331141B1595AE4EA2DC2C318E2C89@MN2PR12MB3311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhoTPVE1qr3f4y6bNWXvi1HGsrbOKSz8qSwKdLzr84c101IBydSMGufvz7zOlQrQ+ewXEQt9FmkTrCYQSHk8NGnI78zWHONW7BBgyemu58IFYMITi57tqxnUb7vVqP0WrAVP5cmriovp1KZGLhu9R0dmaA5AFjxrZCaOBabIQWdkTYvQsXYS2yhE49ZVVKVn1MiX7n3E09P1a279P7dVlatJWRYZ62GPxatp3wT04L8EXsuvTDL4boCYf0DC7ewZc1Fby0Ug1/23gzMcYyir5xhJyy2eRtRsqKoBA6LtCeEsegoTZ9U6J+uwiBHRd3Ju4PdQVb/vTWd0UmDa8i8+vywsVcVL/5dH4r6nUkxlelFi2iQEdzh2HzEUvnY4YxtzfAO7vH6zOZlYAvgxeKoPhuQ+6TVSmiA1NABt2h4K302m5+Rr/v7p99ajvdA8iYzp7qMZAyicjv/PGO2QRibg9yEFD/087HCUyT5+La7BKYe2niMhxscQQSRYhx88uDG7gb6xDSL1VLerLL/HxofaL1hvAJKLGcSn0FKVy5vcBH25dMmqehXN0ZF3AQjOydeAf7Y1a7nVP4Ts6tUZWVePaUmtRxUBwgJr5zBuLcwg8X77OlYhbwEN5xXgK86Ex22jZaRbR9343wnj352H5fxtuJN5cs5x5tAcNCbf5YvXPExM/IkTXYCVxgz+MM6xmVbJfqnm/Mw2bYVxbWHZDuVgHxqVcI+ySXaD+3xyuRVuDBM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(7416002)(478600001)(44832011)(7696005)(4326008)(8936002)(5660300002)(316002)(54906003)(26005)(426003)(86362001)(2906002)(1076003)(2616005)(8676002)(186003)(70206006)(6916009)(82310400003)(83380400001)(36860700001)(356005)(82740400003)(81166007)(36756003)(16526019)(70586007)(336012)(47076005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:15:36.1045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3c8450-5ad5-42b0-3536-08d969976e5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3311
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yellow carp matches same behavior as green sardine and other Zen3
products, but have different CCD offsets.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 drivers/hwmon/k10temp.c  | 5 +++++
 include/linux/pci_ids.h  | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 23dda362dc0f..c92c9c774c0e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -25,6 +25,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
+#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
+#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
@@ -37,6 +39,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{}
 };
 
@@ -58,6 +61,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{}
 };
@@ -74,6 +78,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 159dbad73d82..38bc35ac8135 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -459,6 +459,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x154;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0x40 ... 0x4f:	/* Yellow Carp */
+			data->ccd_offset = 0x300;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
 		}
 	} else {
 		data->read_htcreg = read_htcreg_pci;
@@ -499,6 +503,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5356ccf1c275..e77a62fd0036 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -555,6 +555,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
+#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
-- 
2.25.1

