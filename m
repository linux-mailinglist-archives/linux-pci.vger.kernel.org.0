Return-Path: <linux-pci+bounces-15139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE769AD2A7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76A01F21DB0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9B1F9424;
	Wed, 23 Oct 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DlpsPd5z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB071CF7BE;
	Wed, 23 Oct 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704143; cv=fail; b=JrnhsUiCOTK2yLGVZfgnXso3Wr9O/aDgL8NVzWA32Weaj0ralZXtG9Mqt3L/NJ78OPGL2EBq5/g7gIf2kH/BIJ7Ps+h2L9pVp4RYFOiaHw2U7E/nyFTkY+OKbHykhWCLD3wAgPux2ixRAM4lYws/a6PB70tQdHGDK2Q/q3Jd2ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704143; c=relaxed/simple;
	bh=ejqGFVWCdR5vFAogkde7qqRYPcVQXsKuH14d63l3sGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXKMveE91BQIo00TAxrHsIXpkvLwkuRTXaWP/yZM+w0cP5BQU0zssHnwnfvx1INBO8pSiijGCQTfVMTOgziMKWQElM1gwE/OVz9BX0/gYCoWLT7lt9JqIAXu6ownPLoHbl1ekiCJEijNdw9ZckIsvOou5DrSlJZUbAbS3OLfAos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DlpsPd5z; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bit7OCp9LCi9q2N9xK+ZVOB3sy0Q5/pIwAMjyPqt0jmdnJytaKkjgSARtVnmzQ+RXyQL0UUzGNiiiaSb9a/sEtwFOe5qFtj0xYn9WFAnZPhwPYgFbk0BRmgTNjx6AUlfQIhgO1rDCIsgTENaxpBixgwyEUT0GfwCSjGM+kmiwJbtGxePlnuqQbMHnNrDN4qC3FrDA7JIMnnPe8lEQGdC5Kr1pFsmf+OpTfjhcK9JpNiGOiHWbW1J3Oh7BTHSctmRrNunccnTOkpiXS8ChMn+SkZSYcLDVRl5ZMjro6rEtmbFLrbhowYp3ZFqUe4DVgoneJUIXTMtXFDyWjWf1iapwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1srBZhc+V+/h0D+FUFgjTXtsErvhUvkVjamX3rCZ9s=;
 b=AUGrIyitk1/M/Tgg8FycjdURp+fW6S2VPTPQL76OFyK0BAitw7wZR9Rmx7sxdMMhPlsHufA1FNEr09Ps4xXcVnAVjY51RNiHQvnN5sr05tYSzB276D0ZSQRBZ0N6yUDjzR9NeWZZluLNOUdcJwZPtelTc/Cjgmv7BvMXD4S7yYeIl4j7JUgqdvJMWk85i5P7tjZ/1ydY/PY/g9Icg5t7JkCSdFc9cuu9KS9uJbhKVlzalmJXMK/Bj1k6Cvr2B7X/evWNnoQYh9cilBHyCwSnCilrqBZesj7MiksXwe9y4GkpqkE9jr+T63d+awrDS7HCRmhjHTB8Q++a5+t7KQ4zRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1srBZhc+V+/h0D+FUFgjTXtsErvhUvkVjamX3rCZ9s=;
 b=DlpsPd5zFgHkgq66OQhjbMOVSliQmP6IQtldoQyJ1pI55DfVLi8FezD+MraoaWPdHDido5LkSuWXTAdcVFKO5gcw3WANprbv1p3CvfJoiJr8RZE2vmpkuaCYK+d7zFX198T411nBHhrEa7f9eOTlAVQOMxfZW66XEvEzSKN3LDE=
Received: from MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31) by
 BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 17:22:17 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::28) by MN2PR01CA0062.outlook.office365.com
 (2603:10b6:208:23f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:13 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <Shyam-sundar.S-k@amd.com>, <richard.gong@amd.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <clemens@ladisch.de>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <naveenkrishna.chatradhi@amd.com>,
	<carlos.bilbao.osdev@gmail.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 10/16] x86/amd_nb: Move SMN access code to a new amd_smn driver
Date: Wed, 23 Oct 2024 17:21:44 +0000
Message-ID: <20241023172150.659002-11-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023172150.659002-1-yazen.ghannam@amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: fcaaa0b0-667c-4993-edb5-08dcf3873c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mu5Fp8SmEprVdX3VJ71bz4HRBYwoiEL54nDwH2rOlhjNk3rGv0k3GUoxHXte?=
 =?us-ascii?Q?bFGsCEsFf3fwa2gJIl8Rxsfa5UrdgZjr3Q3Y/TV4ZAvZjG0PcRboo4qXQFTa?=
 =?us-ascii?Q?oRk2C8hL7+hg4Fb0DSOjnLCzQREuwgE4BWH51+eGMHvYAjhp1qZjaiPyP3KK?=
 =?us-ascii?Q?4WnNViwXTaVrs9hEPc8Xne5k3D/wyHAgaD+ORRI1HPudKyxrGYCK/s+AXOaq?=
 =?us-ascii?Q?81wq3E1thnkKGd/akHmpAYHWP4f9scdmhwqrWgYCDELAduDmCDX6kz4btCvW?=
 =?us-ascii?Q?3T0DfxxengDsGaC2yZZ7hb2EKN82wFriNYCstdHmkJmZzLYZ102+xHBoouTE?=
 =?us-ascii?Q?JtblDB32Fy4ZyCfIyKVH6LJjAIMv5k6VzFKxXmcqJypLjeT0/Yw0jstHWk2g?=
 =?us-ascii?Q?t8Zl4ojusaNXINocIZ5p1F9D+4fMxebLOUr6vjNYPRcODikH1hmEdu3UOJeJ?=
 =?us-ascii?Q?XNrPmUwvC6FNirSlSqWJtjF8RnMzj0D5rNEIX4XzQMtzEEeqNfEeJwt5s68v?=
 =?us-ascii?Q?4Did9hNXXBP8j1/FpqlziSsGxqHv38ahgifB55XK8OMOEVTRVaolchfD9H3T?=
 =?us-ascii?Q?DQdTMlbcC5V6WKPkLgt4RKqXnmrRZN6vZDyEdGQGEGJeoqReVmFkMDTXikHb?=
 =?us-ascii?Q?XiNodFXdhCnKwg7FMwijyNg4qPRhPDez1L1jJitaGBpVC36VOICq8Jq25E1B?=
 =?us-ascii?Q?pv8lAh0BoG9dLz4K3qImjht0IvtaHqPkHHdwe9DXGS4seNV762nbGGpWjYzn?=
 =?us-ascii?Q?6z6vz81cMJr3DcLmLrvUg9avuZxNeWku3t+F3GsG+MTxf1E0JWZAMU/AXfg8?=
 =?us-ascii?Q?Pwm5R9Z6ARhAGUcoklIh/UKw7tTIrFEsSmI6SfPaCRWweDrNAssj/wH6aPdF?=
 =?us-ascii?Q?8zVYVsKIqTtFBUf5h5sL+PHSZkIjxBvOzQDnw+Gc/+kVE26ypIOGeXgNYrOJ?=
 =?us-ascii?Q?fSwyBThYs1HACEb+Pq34uREQRw9Bit3In2CeLjZkz0kmQh5w2NegVxUh4Rjb?=
 =?us-ascii?Q?GDJ9uAWqu1Z9RLzLAXu5U/UBniZUrZwoosoC/JqYVL/LVCgh/I/qEaUBTmSu?=
 =?us-ascii?Q?U+wxDoNmgyhBAcZGP/GWQvhPq/yf4WyL29KrMgjZyHd4umVQ5ivIYilCtRln?=
 =?us-ascii?Q?VZmxCCYQHoIBUV71fe/4Y5nZshQ/N+TK/5A7cP8/zxmpyln7wdf6nHMp8SJU?=
 =?us-ascii?Q?kw6sSuk0+HYBCZgAoWHcRhMclS40Vxkkz59djQxxJ07cHkLO2mqEN+z0k0Bw?=
 =?us-ascii?Q?lscdecLLri8VReM8Wj3zFJox2xo96sg93Vl9e265DVA76LZPRPsHMOOPHuBz?=
 =?us-ascii?Q?NNa1Dt59+7v37HNdiu3w281Wqr2pq0vwO3HfFJvmERfX9AgQ2yz0yEUS+L1P?=
 =?us-ascii?Q?o7JAPhIeOoTo/FSL666lpFkJha0cBfFmSP+g7WNrQMI6svBc3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:13.5948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaaa0b0-667c-4993-edb5-08dcf3873c4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

From: Mario Limonciello <mario.limonciello@amd.com>

SMN access was bolted into amd_nb mostly as convenience.  This has
limitations though that require incurring tech debt to keep it working.

Move SMN access to its own driver.

[Yazen: Adjust commit message and add MAINTAINERS entry]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 MAINTAINERS                          |   8 +++
 arch/x86/Kconfig                     |   3 +
 arch/x86/include/asm/amd_nb.h        |   3 -
 arch/x86/include/asm/amd_smn.h       |  11 +++
 arch/x86/kernel/Makefile             |   1 +
 arch/x86/kernel/amd_nb.c             |  89 -----------------------
 arch/x86/kernel/amd_smn.c            | 101 +++++++++++++++++++++++++++
 arch/x86/pci/fixup.c                 |   4 +-
 drivers/edac/Kconfig                 |   1 +
 drivers/edac/amd64_edac.c            |   1 +
 drivers/hwmon/Kconfig                |   2 +-
 drivers/hwmon/k10temp.c              |   2 +-
 drivers/platform/x86/amd/pmc/Kconfig |   2 +-
 drivers/platform/x86/amd/pmc/pmc.c   |   2 +-
 drivers/platform/x86/amd/pmf/Kconfig |   2 +-
 drivers/platform/x86/amd/pmf/core.c  |   2 +-
 drivers/ras/amd/atl/Kconfig          |   1 +
 drivers/ras/amd/atl/internal.h       |   1 +
 18 files changed, 136 insertions(+), 100 deletions(-)
 create mode 100644 arch/x86/include/asm/amd_smn.h
 create mode 100644 arch/x86/kernel/amd_smn.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ca246aef7ab..cb9af4353b31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1180,6 +1180,14 @@ S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
 
+AMD SMN DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
+M:	Yazen Ghannam <yazen.ghannam@amd.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	arch/x86/include/asm/amd_smn.h
+F:	arch/x86/kernel/amd_smn.c
+
 AMD SPI DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
 S:	Maintained
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba5252d8e21c..a03ffa5b6bb1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3128,6 +3128,9 @@ config AMD_NODE
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
+config AMD_SMN
+	def_bool y
+	depends on AMD_NODE
 endmenu
 
 menu "Binary Emulations"
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index b3b42e585655..55c03d3495bc 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -21,9 +21,6 @@ extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
 extern int amd_set_subcaches(int, unsigned long);
 
-int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
-int __must_check amd_smn_write(u16 node, u32 address, u32 value);
-
 struct amd_l3_cache {
 	unsigned indices;
 	u8	 subcaches[4];
diff --git a/arch/x86/include/asm/amd_smn.h b/arch/x86/include/asm/amd_smn.h
new file mode 100644
index 000000000000..6850de69f863
--- /dev/null
+++ b/arch/x86/include/asm/amd_smn.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_AMD_SMN_H
+#define _ASM_X86_AMD_SMN_H
+
+#include <linux/types.h>
+#include <asm/amd_node.h>
+
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
+int __must_check amd_smn_write(u16 node, u32 address, u32 value);
+
+#endif /* _ASM_X86_AMD_SMN_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b43eb7e384eb..1df22821f72d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_nb.o
 obj-$(CONFIG_AMD_NODE)		+= amd_node.o
+obj-$(CONFIG_AMD_SMN)		+= amd_smn.o
 obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 9b159f9b4a11..10cdeddeda02 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,9 +15,6 @@
 #include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 
-/* Protect the PCI config register pairs used for SMN. */
-static DEFINE_MUTEX(smn_mutex);
-
 static u32 *flush_words;
 
 static const struct pci_device_id amd_nb_misc_ids[] = {
@@ -59,92 +56,6 @@ struct amd_northbridge *node_to_amd_nb(int node)
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
 
-/*
- * SMN accesses may fail in ways that are difficult to detect here in the called
- * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
- * their own checking based on what behavior they expect.
- *
- * For SMN reads, the returned value may be zero if the register is Read-as-Zero.
- * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Response"
- * can be checked here, and a proper error code can be returned.
- *
- * But the Read-as-Zero response cannot be verified here. A value of 0 may be
- * correct in some cases, so callers must check that this correct is for the
- * register/fields they need.
- *
- * For SMN writes, success can be determined through a "write and read back"
- * However, this is not robust when done here.
- *
- * Possible issues:
- *
- * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
- *    *not* match the write value.
- *
- * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
- *    known here.
- *
- * 3) Bits that are "Reserved / Set to 1". Ditto above.
- *
- * Callers of amd_smn_write() should do the "write and read back" check
- * themselves, if needed.
- *
- * For #1, they can see if their target bits got cleared.
- *
- * For #2 and #3, they can check if their target bits got set as intended.
- *
- * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
- * the operation is considered a success, and the caller does their own
- * checking.
- */
-static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
-{
-	struct pci_dev *root;
-	int err = -ENODEV;
-
-	if (node >= amd_northbridges.num)
-		goto out;
-
-	root = node_to_amd_nb(node)->root;
-	if (!root)
-		goto out;
-
-	mutex_lock(&smn_mutex);
-
-	err = pci_write_config_dword(root, 0x60, address);
-	if (err) {
-		pr_warn("Error programming SMN address 0x%x.\n", address);
-		goto out_unlock;
-	}
-
-	err = (write ? pci_write_config_dword(root, 0x64, *value)
-		     : pci_read_config_dword(root, 0x64, value));
-
-out_unlock:
-	mutex_unlock(&smn_mutex);
-
-out:
-	return err;
-}
-
-int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
-{
-	int err = __amd_smn_rw(node, address, value, false);
-
-	if (PCI_POSSIBLE_ERROR(*value)) {
-		err = -ENODEV;
-		*value = 0;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(amd_smn_read);
-
-int __must_check amd_smn_write(u16 node, u32 address, u32 value)
-{
-	return __amd_smn_rw(node, address, &value, true);
-}
-EXPORT_SYMBOL_GPL(amd_smn_write);
-
 static int amd_cache_northbridges(void)
 {
 	struct amd_northbridge *nb;
diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
new file mode 100644
index 000000000000..06160a9e2444
--- /dev/null
+++ b/arch/x86/kernel/amd_smn.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD SMN driver, used for register access
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt) "amd_smn: " fmt
+
+#include <linux/pci.h>
+
+#include <asm/amd_nb.h>
+#include <asm/amd_smn.h>
+
+/* Protect the PCI config register pairs used for SMN. */
+static DEFINE_MUTEX(smn_mutex);
+
+/*
+ * SMN accesses may fail in ways that are difficult to detect here in the called
+ * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
+ * their own checking based on what behavior they expect.
+ *
+ * For SMN reads, the returned value may be zero if the register is Read-as-Zero.
+ * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Response"
+ * can be checked here, and a proper error code can be returned.
+ *
+ * But the Read-as-Zero response cannot be verified here. A value of 0 may be
+ * correct in some cases, so callers must check that this correct is for the
+ * register/fields they need.
+ *
+ * For SMN writes, success can be determined through a "write and read back"
+ * However, this is not robust when done here.
+ *
+ * Possible issues:
+ *
+ * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
+ *    *not* match the write value.
+ *
+ * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
+ *    known here.
+ *
+ * 3) Bits that are "Reserved / Set to 1". Ditto above.
+ *
+ * Callers of amd_smn_write() should do the "write and read back" check
+ * themselves, if needed.
+ *
+ * For #1, they can see if their target bits got cleared.
+ *
+ * For #2 and #3, they can check if their target bits got set as intended.
+ *
+ * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
+ * the operation is considered a success, and the caller does their own
+ * checking.
+ */
+static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
+{
+	struct pci_dev *root;
+	int err = -ENODEV;
+
+	if (node >= amd_nb_num())
+		goto out;
+
+	root = node_to_amd_nb(node)->root;
+	if (!root)
+		goto out;
+
+	mutex_lock(&smn_mutex);
+
+	err = pci_write_config_dword(root, 0x60, address);
+	if (err) {
+		pr_warn("Error programming SMN address 0x%x.\n", address);
+		goto out_unlock;
+	}
+
+	err = (write ? pci_write_config_dword(root, 0x64, *value)
+		     : pci_read_config_dword(root, 0x64, value));
+
+out_unlock:
+	mutex_unlock(&smn_mutex);
+
+out:
+	return err;
+}
+
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
+{
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		err = -ENODEV;
+		*value = 0;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(amd_smn_read);
+
+int __must_check amd_smn_write(u16 node, u32 address, u32 value)
+{
+	return __amd_smn_rw(node, address, &value, true);
+}
+EXPORT_SYMBOL_GPL(amd_smn_write);
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 98a9bb92d75c..e8ea627c22b4 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -9,7 +9,7 @@
 #include <linux/pci.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
-#include <asm/amd_nb.h>
+#include <asm/amd_smn.h>
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
@@ -828,7 +828,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
 
 #endif
 
-#ifdef CONFIG_AMD_NB
+#ifdef CONFIG_AMD_SMN
 
 #define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
 #define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 81af6c344d6b..acdd920b8769 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -78,6 +78,7 @@ config EDAC_GHES
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
+	depends on AMD_SMN
 	imply AMD_ATL
 	help
 	  Support for error detection and correction of DRAM ECC errors on
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddfbdb66b794..b0ee0593137b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2,6 +2,7 @@
 #include <linux/ras.h>
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
+#include <asm/amd_smn.h>
 
 static struct edac_pci_ctl_info *pci_ctl;
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08a3c863f80a..bf2bd7098f2c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -324,7 +324,7 @@ config SENSORS_K8TEMP
 
 config SENSORS_K10TEMP
 	tristate "AMD Family 10h+ temperature sensor"
-	depends on X86 && PCI && AMD_NB
+	depends on X86 && PCI && AMD_SMN
 	help
 	  If you say yes here you get support for the temperature
 	  sensor(s) inside your CPU. Supported are later revisions of
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7dc19c5d62ac..1a16640d2fa1 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
-#include <asm/amd_nb.h>
+#include <asm/amd_smn.h>
 #include <asm/processor.h>
 
 MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
diff --git a/drivers/platform/x86/amd/pmc/Kconfig b/drivers/platform/x86/amd/pmc/Kconfig
index 94f9563d8be7..d9cae227aff9 100644
--- a/drivers/platform/x86/amd/pmc/Kconfig
+++ b/drivers/platform/x86/amd/pmc/Kconfig
@@ -5,7 +5,7 @@
 
 config AMD_PMC
 	tristate "AMD SoC PMC driver"
-	depends on ACPI && PCI && RTC_CLASS && AMD_NB
+	depends on ACPI && PCI && RTC_CLASS && AMD_SMN
 	depends on SUSPEND
 	select SERIO
 	help
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index bbb8edb62e00..663cf8d671c7 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -10,7 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <asm/amd_nb.h>
+#include <asm/amd_smn.h>
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
diff --git a/drivers/platform/x86/amd/pmf/Kconfig b/drivers/platform/x86/amd/pmf/Kconfig
index f4fa8bd8bda8..67913f64faf3 100644
--- a/drivers/platform/x86/amd/pmf/Kconfig
+++ b/drivers/platform/x86/amd/pmf/Kconfig
@@ -7,7 +7,7 @@ config AMD_PMF
 	tristate "AMD Platform Management Framework"
 	depends on ACPI && PCI
 	depends on POWER_SUPPLY
-	depends on AMD_NB
+	depends on AMD_SMN
 	select ACPI_PLATFORM_PROFILE
 	depends on TEE && AMDTEE
 	depends on AMD_SFH_HID
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index d6af0ca036f1..21f9ec19941b 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -8,7 +8,7 @@
  * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
  */
 
-#include <asm/amd_nb.h>
+#include <asm/amd_smn.h>
 #include <linux/debugfs.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
index 551680073e43..819ac593e743 100644
--- a/drivers/ras/amd/atl/Kconfig
+++ b/drivers/ras/amd/atl/Kconfig
@@ -10,6 +10,7 @@
 config AMD_ATL
 	tristate "AMD Address Translation Library"
 	depends on AMD_NB && X86_64 && RAS
+	depends on AMD_SMN
 	depends on MEMORY_FAILURE
 	default N
 	help
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 143d04c779a8..49cd3e95e0c6 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -18,6 +18,7 @@
 #include <linux/ras.h>
 
 #include <asm/amd_nb.h>
+#include <asm/amd_smn.h>
 
 #include "reg_fields.h"
 
-- 
2.43.0


