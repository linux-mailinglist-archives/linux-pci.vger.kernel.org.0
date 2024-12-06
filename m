Return-Path: <linux-pci+bounces-17846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B49E753F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809E1169B8B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFA20DD53;
	Fri,  6 Dec 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2+bMcH9G"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12217A58F;
	Fri,  6 Dec 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501553; cv=fail; b=c+QLf0AIFVBq0Dosns0mtwWDcVqs8PBrLm1sXaff2RSLmuh17nxQyXXdfIirh+/AYnJ+h/QTw+hPjypCcvFeXbs3DjWPVbZ+ciwN7litFj4tVKNJdRxQZNyxLi6pw+K0rVoD12MikjSu7PjraegptV7Pe73eRDEWzW85UEkSNkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501553; c=relaxed/simple;
	bh=I56KNJnRmsNXnGb0I8vbQfvcemSTdNmJ/Rrxa/niPOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B65D9HLIJh54ysYZkfG2YMDVZgluCTM2cwUtK5PsPxLPHr+1vzQooqdjax8T752E46VVUDGs9/r43C8Lununz22Cdq+d/k2791w4tEhTpcvK7PE9ut9FVpRQyvEz2FLZUvO1lfBPZSPRzFAnJLn25IkVGEtbb2B3lYNhicjY1Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2+bMcH9G; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9/GJU47gAbhj7z5pjCukBQiJRX9mbxY3Lt5yNBmVETts0wWsCgYZsAxjr6ZgK0qrWlvT5rBgH5RwKBX2CU7XNJ1EM95tQyezkSWEltPjt6G2bnXXw3IJF321b5/d85Vu8sOQaucYByV0j0reogDtVSbwyV+SxWKM5piH833lLWbAFwwDRXz8zx3TCbrrDWfWFevIaTDdfcuOUbfqL6NaLhzSUDKm6hilUmGuRwMSlKmA+qrW89Wu2d301q1+xP3JoGK2GfigBuZ21RTMnil5ImMERs3TU0lHtihemdS/TdepSh15+JvF+OMlNj+bvR/fQkTLgtrrzIprJ2lC+F8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRvGkcmtAsT0q0xkGgY6nJIAlFTl7ZaIcAX6OGqxuYo=;
 b=VY88L/v9BUALhc7C6BJc6T2INEsAbnnOZ3mvVRVYVcK6+HiGAwyk6tO3NtPaohvQ+Zrn5B+Y7S/5BuRGMPTAJDpLPm84LLHBJuUeF2Em1Ilest7aOzx7ygh8q7+XlzlmLOd0FYzNWX023Q1W1cvEj/FWKtJlPr1FTKr9u8AqAhtVy4+1j5bS5Dh90kvW1mMK98aVOxeCK0oDczFHncKhqARqerDV6k/L9kGLG6FpPF9BTPf5bCme+WsknZBvNPtf1KHuXXjXXx7yF++Q9z8Xars0FBTyMHQTVBZHdePwuKyO1QSpwKLMeghbiLp5FhTyv08E2LCEIZZA7taL7rWKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRvGkcmtAsT0q0xkGgY6nJIAlFTl7ZaIcAX6OGqxuYo=;
 b=2+bMcH9GYe22D/3R7y771mD3VAwwt++0Dm14fVBbGPDk79jFteAi/3y5+iBfJGCyW/pO2mOktU6i+b5ZHiSgqOLcZ56uq5jf8rkIV+KO97icIly6utKzInyBwpBb42xE8SK9YXEu3DwWSUSBnNF1eh5+kisp751zuDAIIdwkut4=
Received: from DS0PR17CA0023.namprd17.prod.outlook.com (2603:10b6:8:191::24)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:12:26 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::c0) by DS0PR17CA0023.outlook.office365.com
 (2603:10b6:8:191::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 16:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:25 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:24 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Clemens Ladisch <clemens@ladisch.de>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Naveen
 Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>, Suma Hegde
	<suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2 01/16] x86/mce/amd: Remove shared threshold bank plumbing
Date: Fri, 6 Dec 2024 16:11:54 +0000
Message-ID: <20241206161210.163701-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206161210.163701-1-yazen.ghannam@amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f56297-d347-4645-5c10-08dd1610c670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXBSBjfNZWS/4tKegDfBy6QQAVFDzpexdwIMnMGbugUp4eCcyxsVoQ/UjMi2?=
 =?us-ascii?Q?c2ctH8HXzbvm/wFc+IhU+7fzvfU33DoKDllapG4SEwSmcXttZSuKvptKDd/l?=
 =?us-ascii?Q?Y0BkQo+yn0eAchBvxIZf5yDNF1xgDb34E+oozQojquJfwMgi5Ps7qBc5GwX7?=
 =?us-ascii?Q?0BCCH0Ct4NEXkgnjrtjz7nA4CXCa2xUt563PxKJLG55E3NSLuhflKUC9xGdu?=
 =?us-ascii?Q?3xvax3XpHbOeASMX4NF2EbBSSj9fb2CWXt8VGLFJSFgLuRl1VolRRgzVUEJ6?=
 =?us-ascii?Q?yVmaPP7ctudTncZ9HCrMqnvB/qiEliFqOm6s0pmUZHI6KKE+swHjNtNu32Zj?=
 =?us-ascii?Q?CrSh/j3mKjuJZvE4/jk1WA0tQQutQT8OTr8jVkr5jnY992uA1iiQznQoTQw6?=
 =?us-ascii?Q?mekaRPM+6Z0gKgVCBG3Q9geCeRs1hQN+BNTF5FoUVz8dQ6I7qgvVG/ca8H6X?=
 =?us-ascii?Q?8Qma+WV6j7TZWJ+2pG3psNAAgiGVgPURNxaGEVSIZujmpDvVmNUQBpIEI36M?=
 =?us-ascii?Q?bCcw0TW2VNpZ3LPSMDgBuN5vOWJB1PaelLED4EHTnClGQJzHu2qrh4XdAo12?=
 =?us-ascii?Q?2rZuYEb4fFILnJNSEYYe7/AsStf0bF7LfNSk+PkqUXxdK34PLqJ+qrURaWNg?=
 =?us-ascii?Q?iUNAwBaAY8/m8AnBKJ07hCgNwW2GgNwIMqwI+aw1A2pM4GPQPqRjNN+ZMs+K?=
 =?us-ascii?Q?3+d+YppKuwg1p9l/NzylGdVq9HP8Rbqd4aCB6azNJbgLxPYSaUibtEIHBlKo?=
 =?us-ascii?Q?YMUzqyCmy5g1Y9zv6YoJP54qAMZq0QzpHipp31S3NgMObatKat85JlmLvEaK?=
 =?us-ascii?Q?tqDYiZo4FT+7dIdumrBvrfVDAYEALEQXPzGS9HE5zc1nHYLYVKBU674XVft7?=
 =?us-ascii?Q?DxPc/9d2tO+W5GqyEL69x11Ja+pKph3xpocVDnUCKdE7AHeFi/8etfoLDd4z?=
 =?us-ascii?Q?12Nn7XD5rhypsL+2kLhlfaU4mEx1LQEEn5ljA/mQFdgXlauMPY014C8CUjc/?=
 =?us-ascii?Q?FsBlTPKgRhMEjcYrjixbeZz9Lb6gq43cqdAaIAeEgdAwpT6bBsiyewyxxJjS?=
 =?us-ascii?Q?FLvpJrdLOHs6hq7cDxHZxd4YTfVfsciJI/OhKKRApMVSaiCL+6dUS/j1j0zo?=
 =?us-ascii?Q?sbMpo36LeFZzLnm5A9TZBKGGZXS19kWSitx4/wruhpD0wJ0xIe9RKPp07BwY?=
 =?us-ascii?Q?527GhTwgyiNOyeigUzFhCyJaOXk/hyijEdAbyOGVcP1wRUnPbVf5iHzc5mNI?=
 =?us-ascii?Q?ZpbZ4jbmY1CuUq5tjq05dhqHST+Zb96eLnZo4fnJwLomcukscEfNVwepb+hZ?=
 =?us-ascii?Q?NlDo7KYbuuVBq1F1jkLPbdEaQThOM+v97Yj0A5aa4BW88GfOcfvVh3X6wZDU?=
 =?us-ascii?Q?Z9BKNKlWzhliv/jafAKXK5ZqtXlzy40CX9tZumryo+yTg8smn5NyKPA0ayyL?=
 =?us-ascii?Q?u4jbMcsQoryNHpWNS3XFepbZscO9A3/vCRoGxyfU+Wnk79hPfHXkSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:25.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f56297-d347-4645-5c10-08dd1610c670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

Legacy AMD systems include an integrated Northbridge that is represented
by MCA bank 4. This is the only non-core MCA bank in legacy systems. The
Northbridge is physically shared by all the CPUs within an AMD "Node".

However, in practice the "shared" MCA bank can only by managed by a
single CPU within that AMD Node. This is known as the "Node Base Core"
(NBC). For example, only the NBC will be able to read the MCA bank 4
registers; they will be Read-as-Zero for other CPUs. Also, the MCA
Thresholding interrupt will only signal the NBC; the other CPUs will not
receive it. This is enforced by hardware, and it should not be managed by
software.

The current AMD Thresholding code attempts to deal with the "shared" MCA
bank by micromanaging the bank's sysfs kobjects. However, this does not
follow the intended kobject use cases. It is also fragile, and it has
caused bugs in the past.

Modern AMD systems do not need this shared MCA bank support, and it
should not be needed on legacy systems either.

Remove the shared threshold bank code. Also, move the threshold struct
definitions to mce/amd.c, since they are no longer needed in amd_nb.c.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-2-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/Kconfig              |   2 +-
 arch/x86/include/asm/amd_nb.h |  31 ---------
 arch/x86/kernel/cpu/mce/amd.c | 127 +++++++---------------------------
 3 files changed, 27 insertions(+), 133 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0ae48c4..e4e27d44dc2b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1189,7 +1189,7 @@ config X86_MCE_INTEL
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
-	depends on X86_MCE && X86_LOCAL_APIC && AMD_NB
+	depends on X86_MCE && X86_LOCAL_APIC
 	help
 	  Additional support for AMD specific MCE features such as
 	  the DRAM Error Threshold.
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index d0caac26533f..4f586fc699fd 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -4,7 +4,6 @@
 
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <linux/refcount.h>
 
 struct amd_nb_bus_dev_range {
 	u8 bus;
@@ -29,41 +28,11 @@ struct amd_l3_cache {
 	u8	 subcaches[4];
 };
 
-struct threshold_block {
-	unsigned int	 block;			/* Number within bank */
-	unsigned int	 bank;			/* MCA bank the block belongs to */
-	unsigned int	 cpu;			/* CPU which controls MCA bank */
-	u32		 address;		/* MSR address for the block */
-	u16		 interrupt_enable;	/* Enable/Disable APIC interrupt */
-	bool		 interrupt_capable;	/* Bank can generate an interrupt. */
-
-	u16		 threshold_limit;	/*
-						 * Value upon which threshold
-						 * interrupt is generated.
-						 */
-
-	struct kobject	 kobj;			/* sysfs object */
-	struct list_head miscj;			/*
-						 * List of threshold blocks
-						 * within a bank.
-						 */
-};
-
-struct threshold_bank {
-	struct kobject		*kobj;
-	struct threshold_block	*blocks;
-
-	/* initialized to the number of CPUs on the node sharing this bank */
-	refcount_t		cpus;
-	unsigned int		shared;
-};
-
 struct amd_northbridge {
 	struct pci_dev *root;
 	struct pci_dev *misc;
 	struct pci_dev *link;
 	struct amd_l3_cache l3_cache;
-	struct threshold_bank *bank4;
 };
 
 struct amd_northbridge_info {
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ca80fff1fea..0cbc56c68c8a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -4,8 +4,6 @@
  *
  *  Written by Jacob Shin - AMD, Inc.
  *  Maintained by: Borislav Petkov <bp@alien8.de>
- *
- *  All MC4_MISCi registers are shared between cores on a node.
  */
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
@@ -20,7 +18,6 @@
 #include <linux/smp.h>
 #include <linux/string.h>
 
-#include <asm/amd_nb.h>
 #include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
@@ -221,6 +218,32 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 #define MAX_MCATYPE_NAME_LEN	30
 static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
 
+struct threshold_block {
+	/* This block's number within its bank. */
+	unsigned int		block;
+	/* MCA bank number that contains this block. */
+	unsigned int		bank;
+	/* CPU which controls this block's MCA bank. */
+	unsigned int		cpu;
+	/* MCA_MISC MSR address for this block. */
+	u32			address;
+	/* Enable/Disable APIC interrupt. */
+	bool			interrupt_enable;
+	/* Bank can generate an interrupt. */
+	bool			interrupt_capable;
+	/* Value upon which threshold interrupt is generated. */
+	u16			threshold_limit;
+	/* sysfs object */
+	struct kobject		kobj;
+	/* List of threshold blocks within this block's MCA bank. */
+	struct list_head	miscj;
+};
+
+struct threshold_bank {
+	struct kobject		*kobj;
+	struct threshold_block	*blocks;
+};
+
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
 
 /*
@@ -333,19 +356,6 @@ struct thresh_restart {
 	u16			old_limit;
 };
 
-static inline bool is_shared_bank(int bank)
-{
-	/*
-	 * Scalable MCA provides for only one core to have access to the MSRs of
-	 * a shared bank.
-	 */
-	if (mce_flags.smca)
-		return false;
-
-	/* Bank 4 is for northbridge reporting and is thus shared */
-	return (bank == 4);
-}
-
 static const char *bank4_names(const struct threshold_block *b)
 {
 	switch (b->address) {
@@ -1198,35 +1208,10 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	return err;
 }
 
-static int __threshold_add_blocks(struct threshold_bank *b)
-{
-	struct list_head *head = &b->blocks->miscj;
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
-	int err = 0;
-
-	err = kobject_add(&b->blocks->kobj, b->kobj, b->blocks->kobj.name);
-	if (err)
-		return err;
-
-	list_for_each_entry_safe(pos, tmp, head, miscj) {
-
-		err = kobject_add(&pos->kobj, b->kobj, pos->kobj.name);
-		if (err) {
-			list_for_each_entry_safe_reverse(pos, tmp, head, miscj)
-				kobject_del(&pos->kobj);
-
-			return err;
-		}
-	}
-	return err;
-}
-
 static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 				 unsigned int bank)
 {
 	struct device *dev = this_cpu_read(mce_device);
-	struct amd_northbridge *nb = NULL;
 	struct threshold_bank *b = NULL;
 	const char *name = get_name(cpu, bank, NULL);
 	int err = 0;
@@ -1234,26 +1219,6 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 	if (!dev)
 		return -ENODEV;
 
-	if (is_shared_bank(bank)) {
-		nb = node_to_amd_nb(topology_amd_node_id(cpu));
-
-		/* threshold descriptor already initialized on this node? */
-		if (nb && nb->bank4) {
-			/* yes, use it */
-			b = nb->bank4;
-			err = kobject_add(b->kobj, &dev->kobj, name);
-			if (err)
-				goto out;
-
-			bp[bank] = b;
-			refcount_inc(&b->cpus);
-
-			err = __threshold_add_blocks(b);
-
-			goto out;
-		}
-	}
-
 	b = kzalloc(sizeof(struct threshold_bank), GFP_KERNEL);
 	if (!b) {
 		err = -ENOMEM;
@@ -1267,17 +1232,6 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		goto out_free;
 	}
 
-	if (is_shared_bank(bank)) {
-		b->shared = 1;
-		refcount_set(&b->cpus, 1);
-
-		/* nb is already initialized, see above */
-		if (nb) {
-			WARN_ON(nb->bank4);
-			nb->bank4 = b;
-		}
-	}
-
 	err = allocate_threshold_blocks(cpu, b, bank, 0, mca_msr_reg(bank, MCA_MISC));
 	if (err)
 		goto out_kobj;
@@ -1310,40 +1264,11 @@ static void deallocate_threshold_blocks(struct threshold_bank *bank)
 	kobject_put(&bank->blocks->kobj);
 }
 
-static void __threshold_remove_blocks(struct threshold_bank *b)
-{
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
-
-	kobject_put(b->kobj);
-
-	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
-		kobject_put(b->kobj);
-}
-
 static void threshold_remove_bank(struct threshold_bank *bank)
 {
-	struct amd_northbridge *nb;
-
 	if (!bank->blocks)
 		goto out_free;
 
-	if (!bank->shared)
-		goto out_dealloc;
-
-	if (!refcount_dec_and_test(&bank->cpus)) {
-		__threshold_remove_blocks(bank);
-		return;
-	} else {
-		/*
-		 * The last CPU on this node using the shared bank is going
-		 * away, remove that bank now.
-		 */
-		nb = node_to_amd_nb(topology_amd_node_id(smp_processor_id()));
-		nb->bank4 = NULL;
-	}
-
-out_dealloc:
 	deallocate_threshold_blocks(bank);
 
 out_free:
-- 
2.43.0


