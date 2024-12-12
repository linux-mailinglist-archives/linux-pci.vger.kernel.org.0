Return-Path: <linux-pci+bounces-18322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444B9EF80B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8181D1894A33
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276C721B8E1;
	Thu, 12 Dec 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RVV2Ij3q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072A217F34;
	Thu, 12 Dec 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024457; cv=fail; b=WOv5JLHyOpcnoINwYsIJaHfytEgQeNii1IDGJbBaV2ONxlo4+pUDW34drgwSFLd+ylx8ci+dCJM8JP0FQ3Q6JrWeKvK49tuca1oUDBOmooITFMiqSg2+ExeNYkTjarcy+W561TGCky5zci2jeiqms5uo1fgADJy/NWHnwHcBg0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024457; c=relaxed/simple;
	bh=CX+r2Wbgd0/gHJbruoDkMMQxfRwn8wTm5m8MyxN2jrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNhRjSAMS4H5y+KLPo/AduS7vUiVQiYH1vuCCJ7vr6U0o5Tt7uqd8L68FSGDxuEApADsD7UzNLuVbt8SKMj+Wut3p13Iu5wR9jYT7JSmUGLG21frIVdjW07e7bzkVngUNaiViRkeQeUOfnZXF48Mhi3cv6+/A55BFl0ctCY5DUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RVV2Ij3q; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoNARE54Vx4WPUC5rS6hQ2koBS2lH6vv1nUnOnXBsa5KYdEk7Ev9P6/2Ifk6qanCxVXibBbaCtdQU6zByunr86t5sYoyQxtNarib/f3e3zBfwPqcQPvzrxjWf0PL3ePcg+aprWsqLJQN/BIM55Q/YiUDOmhgk3osqAmzm4ID2hMSKheYRz0nnBfXvt/7IEb01emTSsFdt4u8p2n59AtmK8DNcLOSB5R7YBrRSJrkRBj/NpoxLoP4pkjQuFUjZEkUsxgoI7tSYPkyKkVFnuZ8kSIG2cIR4e5L7jxSKxnXzM3Xacog8KHPldb5sKFehowMNRCXIIe6yBgDLDoB0pueEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2sq8fBDdc/UH1duv5ky0yBqh0KohAFyb7B1ZOFzr0k=;
 b=Eb0mXrrM3WBaq7Y3Y6H2/OcGhuQQrVSIosFahSI9e+pknvhLcL96/l08rOeIOkOhu3PdJE5PLNVpuugy0ejWGRlrQ69nfVyrXL/tUBXAkYZXxRRsWMFNRzx98AE6OF309IkvWqixyrDBCaCnEHZwrfD77W1YS1Xgke/QwQw7Ok3xwTLLFATZZSQeqKd85IQSQYAik/RpKVg/b8+52rtv3RKfLUZIw/1EmmpTilKUWzH/YOpJjTg/Ve05rw8SiVTKkoxl1zG8Q7inBrXWPm7DFC3MyaUXC1ejGVOeplnn6qQ6YICbqyKc4lTeTXV5otD6i6a1F8YDJSAGzq/OW4An8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2sq8fBDdc/UH1duv5ky0yBqh0KohAFyb7B1ZOFzr0k=;
 b=RVV2Ij3qXrblgzp7/gHIyXVR47CemgPespjWEA86ezQs6bKT3+tB+XXh48cezTpe6YBEe6XJo2Av3FCpJ5KHGNWYuqbkrfXt900zFszbNzoqyLYjymOd6lnA2/Z6GJswPPK7qt9yk/3dek79w0Da6NnCLKWR8vNccvsN8tvUozw=
Received: from CH2PR14CA0040.namprd14.prod.outlook.com (2603:10b6:610:56::20)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 17:27:23 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::f2) by CH2PR14CA0040.outlook.office365.com
 (2603:10b6:610:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 17:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 17:27:23 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 11:27:21 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, <tony.luck@intel.com>,
	<mario.limonciello@amd.com>, <bhelgaas@google.com>, <jdelvare@suse.com>,
	<linux@roeck-us.net>, <clemens@ladisch.de>, <Shyam-sundar.S-k@amd.com>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<naveenkrishna.chatradhi@amd.com>, <suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2.1] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use SMN through AMD_NODE
Date: Thu, 12 Dec 2024 17:27:11 +0000
Message-ID: <20241212172711.1944927-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206161210.163701-15-yazen.ghannam@amd.com>
References:
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e185135-927f-4768-4f2b-08dd1ad23d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wdMUj3BRxr4U/qrOR0xQvH9M7Q1JNvtNBwIEV7q4OKBybqBJcn5pK5Xgx1bM?=
 =?us-ascii?Q?MesGvffK8y7FQX/RxzKOvMrxpyIzCoYv0HuBV5FNsIGsHZc12JoKAlH1UPnM?=
 =?us-ascii?Q?cpmrDpxIBwqaYyF/lVlHqID3lxYqHXo8TQjm5W/zDqB1jXis9tNMXah4oaRX?=
 =?us-ascii?Q?lrDcPkVw6InoQy4NepY95xaifm6ux48pLgrQuw02f12qnFvVqAdF4lbUUg1H?=
 =?us-ascii?Q?Jv5eHaVjxdSbZKunmPa8/DJHP+MByAOl34CtEPhoO1sADNbEdtjkNKvIvIvm?=
 =?us-ascii?Q?nrCd19LO3FiCgTcgbIGKIbHg2f2tj1+XOibDuGQdpc1ooXt4YLZb1p3xvlOi?=
 =?us-ascii?Q?gZK+v8n8onRbb01ZDPIpje+20vcCRooQcPhWp4G/IWdVShkPwUH4PzC2Mz5n?=
 =?us-ascii?Q?bjhjYwo7ak1QBnzu0/zM78wTNUGSl9V/jENbE0yRXN7BblNkrINxgjfkEgWI?=
 =?us-ascii?Q?puywguQAYV3m+yVv63W2lC1gYEq2QGJiDfcv3cnyEPbVbcpIr+Z4ep8gg9AQ?=
 =?us-ascii?Q?6p5BtAm34F0P/aObckQFTZjTGA5+whlfUCoJq1VJh/IkEl/9U6ZiUeBVHtm0?=
 =?us-ascii?Q?j4vXuLuIoAGM2GoW6kkT93JEDqsCnVsoYTy4AvygMeE/33xt6cy1LeR9SU69?=
 =?us-ascii?Q?wOkf/qCcIij8flAcitcOqPQpI6SGB3LKo30FSPJtxcmjOovwNKsFcA2rHZhf?=
 =?us-ascii?Q?3zg9v+IvLgM+HoW89m79lg8qrdk6eEHpSJem1N7p+P+ZP6hwd2IYAd+/QWIK?=
 =?us-ascii?Q?3YDUZPD8nGZR6Vzf0nBIfdvYoboSm7CtRrSIWALLEUIDZaA3YfjrZ+ilxeCD?=
 =?us-ascii?Q?knWQ+Xllk31GKZXmAMseytGMuQO9pA7Qyqk5sYcQRH3rqYgz/pAWlT6QcpmF?=
 =?us-ascii?Q?LADD8uPkcb7G9m/bVoav/vU3rKo2d1GQJkGhydAwLURbGPgbzbjLqZH/ncYZ?=
 =?us-ascii?Q?azbreX8j+/MzXPKKspDNlHKXKDOTFaDapQCAAXTcmOMakmeyBlWWGFmlwm34?=
 =?us-ascii?Q?+g+qVZBoCfmzHixygyDIyHJAZIdWMM4DTsnuWYcDWExT58IEvCKZRjvuE+ym?=
 =?us-ascii?Q?WCqhWUoKYKOO2pzicLusb87hpmItvbmmFdvMAtyp/Fd4WAoX29G4PZdfqgao?=
 =?us-ascii?Q?U7lBdh+Y1PFkEvf76UKLCoiOFxDf8yjwgpSaPLTcXtFtlDcRiqDkny1FVC+s?=
 =?us-ascii?Q?b229SPsU1ZhAoTeqJJa0Oed+RFEzq1aw9m0f0T/MdkrCJOkX3VibksYwntzk?=
 =?us-ascii?Q?Wf+VyRgn9Y78Hl8s1tpzr66gT8S89yRFjPd08YwELtDGY+OAW4ItUxD/RtfY?=
 =?us-ascii?Q?IivbDZfjUtt6ycI4FUPm5UXRxoGJNkMdNutakC/VI6CKhgVm81BosARkeIxJ?=
 =?us-ascii?Q?ll2fcntZVfLmFRvQtFzui3d5Wrw0ey8PVdAgGmkADVic1AZccvlrCoI46w1b?=
 =?us-ascii?Q?EisjLWPS5S2kHeQrISklZ1y89o02uD5ZyoswTh7lxoUks1vk/LgssA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 17:27:23.2658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e185135-927f-4768-4f2b-08dd1ad23d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

The HSMP interface is just an SMN interface with different offsets.

Define an HSMP wrapper in the SMN code and have the HSMP platform driver
use that rather than a local solution.

Also, remove the "root" member from AMD_NB, since there are no more
users of it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241206161210.163701-15-yazen.ghannam@amd.com
    
    v2->v2.1:
    * Include static_assert() and comment for sysfs attributes.
    
    v1->v2:
    * Rebase on recent HSMP rework.

 arch/x86/include/asm/amd_nb.h         |  1 -
 arch/x86/include/asm/amd_node.h       |  3 +++
 arch/x86/kernel/amd_nb.c              |  1 -
 arch/x86/kernel/amd_node.c            |  9 +++++++
 drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
 drivers/platform/x86/amd/hsmp/acpi.c  |  7 +++---
 drivers/platform/x86/amd/hsmp/hsmp.c  |  1 -
 drivers/platform/x86/amd/hsmp/hsmp.h  |  3 ---
 drivers/platform/x86/amd/hsmp/plat.c  | 35 +++++++++------------------
 9 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 4c4efb93045e..adfa0854cf2d 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -27,7 +27,6 @@ struct amd_l3_cache {
 };
 
 struct amd_northbridge {
-	struct pci_dev *root;
 	struct pci_dev *misc;
 	struct pci_dev *link;
 	struct amd_l3_cache l3_cache;
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 113ad3e8ee40..5fe9c6537434 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -33,4 +33,7 @@ static inline u16 amd_num_nodes(void)
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
 int __must_check amd_smn_write(u16 node, u32 address, u32 value);
 
+/* Should only be used by the HSMP driver. */
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 2729e99806ec..3a20312062af 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -73,7 +73,6 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 
 	for (i = 0; i < amd_northbridges.num; i++) {
-		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 	}
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index d2ec7fd555c5..65045f223c10 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -97,6 +97,9 @@ static DEFINE_MUTEX(smn_mutex);
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
 
+#define HSMP_INDEX_OFFSET	0xc4
+#define HSMP_DATA_OFFSET	0xc8
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -179,6 +182,12 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write)
+{
+	return __amd_smn_rw(HSMP_INDEX_OFFSET, HSMP_DATA_OFFSET, node, address, value, write);
+}
+EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
+
 static int amd_cache_roots(void)
 {
 	u16 node, num_nodes = amd_num_nodes();
diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd/hsmp/Kconfig
index 7d10d4462a45..d6f7a62d55b5 100644
--- a/drivers/platform/x86/amd/hsmp/Kconfig
+++ b/drivers/platform/x86/amd/hsmp/Kconfig
@@ -7,7 +7,7 @@ config AMD_HSMP
 	tristate
 
 menu "AMD HSMP Driver"
-	depends on AMD_NB || COMPILE_TEST
+	depends on AMD_NODE || COMPILE_TEST
 
 config AMD_HSMP_ACPI
 	tristate "AMD HSMP ACPI device driver"
diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/hsmp/acpi.c
index e981d45e1c12..28565ca78afd 100644
--- a/drivers/platform/x86/amd/hsmp/acpi.c
+++ b/drivers/platform/x86/amd/hsmp/acpi.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
 #include <linux/acpi.h>
 #include <linux/device.h>
@@ -24,6 +23,8 @@
 
 #include <uapi/asm-generic/errno-base.h>
 
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
 
 #define DRIVER_NAME		"amd_hsmp"
@@ -321,8 +322,8 @@ static int hsmp_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (!hsmp_pdev->is_probed) {
-		hsmp_pdev->num_sockets = amd_nb_num();
-		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
+		hsmp_pdev->num_sockets = amd_num_nodes();
+		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
 			return -ENODEV;
 
 		hsmp_pdev->sock = devm_kcalloc(&pdev->dev, hsmp_pdev->num_sockets,
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/amd/hsmp/hsmp.c
index 227b4ad4a51a..e04c613ad5d6 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp/hsmp.c
@@ -8,7 +8,6 @@
  */
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.h b/drivers/platform/x86/amd/hsmp/hsmp.h
index e852f0a947e4..af8b21f821d6 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.h
+++ b/drivers/platform/x86/amd/hsmp/hsmp.h
@@ -21,8 +21,6 @@
 
 #define HSMP_ATTR_GRP_NAME_SIZE	10
 
-#define MAX_AMD_SOCKETS 8
-
 #define HSMP_CDEV_NAME		"hsmp_cdev"
 #define HSMP_DEVNODE_NAME	"hsmp"
 
@@ -41,7 +39,6 @@ struct hsmp_socket {
 	void __iomem *virt_base_addr;
 	struct semaphore hsmp_sem;
 	char name[HSMP_ATTR_GRP_NAME_SIZE];
-	struct pci_dev *root;
 	struct device *dev;
 	u16 sock_ind;
 	int (*amd_hsmp_rdwr)(struct hsmp_socket *sock, u32 off, u32 *val, bool rw);
diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/hsmp/plat.c
index a61f815c9f80..32921092b0c8 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
 #include <linux/device.h>
 #include <linux/module.h>
@@ -18,6 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
 
 #define DRIVER_NAME		"amd_hsmp"
@@ -34,28 +35,12 @@
 #define SMN_HSMP_MSG_RESP	0x0010980
 #define SMN_HSMP_MSG_DATA	0x00109E0
 
-#define HSMP_INDEX_REG		0xc4
-#define HSMP_DATA_REG		0xc8
-
 static struct hsmp_plat_device *hsmp_pdev;
 
 static int amd_hsmp_pci_rdwr(struct hsmp_socket *sock, u32 offset,
 			     u32 *value, bool write)
 {
-	int ret;
-
-	if (!sock->root)
-		return -ENODEV;
-
-	ret = pci_write_config_dword(sock->root, HSMP_INDEX_REG,
-				     sock->mbinfo.base_addr + offset);
-	if (ret)
-		return ret;
-
-	ret = (write ? pci_write_config_dword(sock->root, HSMP_DATA_REG, *value)
-		     : pci_read_config_dword(sock->root, HSMP_DATA_REG, value));
-
-	return ret;
+	return amd_smn_hsmp_rdwr(sock->sock_ind, sock->mbinfo.base_addr + offset, value, write);
 }
 
 static ssize_t hsmp_metric_tbl_plat_read(struct file *filp, struct kobject *kobj,
@@ -95,7 +80,12 @@ static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
  * Static array of 8 + 1(for NULL) elements is created below
  * to create sysfs groups for sockets.
  * is_bin_visible function is used to show / hide the necessary groups.
+ *
+ * Validate the maximum number against MAX_AMD_NUM_NODES. If this changes,
+ * then the attributes and groups below must be adjusted.
  */
+static_assert(MAX_AMD_NUM_NODES == 8);
+
 #define HSMP_BIN_ATTR(index, _list)					\
 static struct bin_attribute attr##index = {				\
 	.attr = { .name = HSMP_METRICS_TABLE_NAME, .mode = 0444},	\
@@ -159,10 +149,7 @@ static int init_platform_device(struct device *dev)
 	int ret, i;
 
 	for (i = 0; i < hsmp_pdev->num_sockets; i++) {
-		if (!node_to_amd_nb(i))
-			return -ENODEV;
 		sock = &hsmp_pdev->sock[i];
-		sock->root			= node_to_amd_nb(i)->root;
 		sock->sock_ind			= i;
 		sock->dev			= dev;
 		sock->mbinfo.base_addr		= SMN_HSMP_BASE;
@@ -305,11 +292,11 @@ static int __init hsmp_plt_init(void)
 		return -ENOMEM;
 
 	/*
-	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
+	 * amd_num_nodes() returns number of SMN/DF interfaces present in the system
 	 * if we have N SMN/DF interfaces that ideally means N sockets
 	 */
-	hsmp_pdev->num_sockets = amd_nb_num();
-	if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
+	hsmp_pdev->num_sockets = amd_num_nodes();
+	if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
 		return ret;
 
 	ret = platform_driver_register(&amd_hsmp_driver);
-- 
2.43.0


