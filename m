Return-Path: <linux-pci+bounces-15130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3BF9AD27A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C871F2215C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23C1CFEC7;
	Wed, 23 Oct 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u1jLQfrF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BD1CB312;
	Wed, 23 Oct 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704130; cv=fail; b=hDqg2Bvt7UrXaRekHyb/zxyRL58MP8Ovvb1snwEZkA0fRH1NRYMJ+eAAtZoT0odB1NIGGKNR4R8Y21snDkIYwqR6VYzrgvNFFBYkv+bEjx20kWMI4DY43rboWpCZXUiPRH6oP7geiqXHAribBHqd8DBIwHUKWrdopnqzLPPTgus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704130; c=relaxed/simple;
	bh=XkXJOr0gAcpQ0dkHLzCxgTlRvEvjnXtpKq2aw8oHBqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcX/XhjzhTxWH79DDfb+cgGiCiEiJM2f+fYPFnQ2LFx0WIdT91ErGsQDvLbTEi4YHze0KsLe98VWbfFS+xS3KCGa1/Y6Fo5lVowcBQdCNlrh4wA1FHJoHO2u7T+LCti40cdYMbCCUiEK95j7s7kzosgH1mnb2IlZRnfGjPN36bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u1jLQfrF; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvqPNQn/eRtSQ+sBfZ2KDJ6Bn8Zl4WzTiwgcvk7LeQe4S5S9UC0uoOQXwo66Y6dNv1rrnLgd4mqTymVXnsi2BfT5RhdOQeS6gYJvja3pxHqZWUow92BB5yM+6FcqbceuUzH5OmAd5x9lIwwP/yjgzg+zyGn+N70s7BqcfMF7uW9fEYr+Vh773dwRDyZ/wGT+Af4o5q63wNAmzQu6uyD15cWDWWj1ryTjkfNHItKzCHgFjoZUh6+JVvyANfTajUzecssfvQ7/adAq9C6pNbGjkXlNGRmF8KYoE5kRSmvCRUdJNBwv/YgLoU2mWre4sWyoCdOgSyKqaIRn2QQXqh3mOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAvBY+GzHfnlwh8MIGcdAH3G/HBdvL0/ocAn8GcTT/A=;
 b=pM8w8/C6TDeutJ0UOahHK70DAcpnPyP74mWedo8klgMAKjaVOfHwWPSpOO/4AmnTvnamXQDNFuimM6TN2Y3/mOn3pyuuTojeofs5rK4mUaQg+ceuZbRiJWU6Uev/EZreA0rvF7sbp42EmFIJBZSAAkf8vnJMf5UNNHyREQ8IIinUmZn8qtM7FpgIZAHaBEdG8Cvq69+Sbuh48MeqIP7XIbxev4swjdT1YdFXBOV3mhuXTe7RxNwCHhRhMULa0aaXDJ7iBZ3V+ODrPjo1lxocSEhb2TNe+qM8pW3MtFUkHYOQTlz/TmLLN2bjcvrB6EPPFEz3KceaPewn4UESO1P3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAvBY+GzHfnlwh8MIGcdAH3G/HBdvL0/ocAn8GcTT/A=;
 b=u1jLQfrFJTwsbdfdWD05xbtjVWAK4R7i0w8xJpMPQhwITwJKZY08F2XP1doeHT5Gr38WvL5OT0wO2ohMMxiTDDRFq2kzaNh7FjanVPTNlK195gYZN9OdvTbxXkj3tfIvY4OlI/Zdizvp5b94H6sa/FkMaiUoptS3D4s2+qAiR7c=
Received: from BN0PR08CA0022.namprd08.prod.outlook.com (2603:10b6:408:142::7)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 17:22:05 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::c9) by BN0PR08CA0022.outlook.office365.com
 (2603:10b6:408:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:04 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:03 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <Shyam-sundar.S-k@amd.com>, <richard.gong@amd.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <clemens@ladisch.de>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <naveenkrishna.chatradhi@amd.com>,
	<carlos.bilbao.osdev@gmail.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 01/16] x86/mce/amd: Remove shared threshold bank plumbing
Date: Wed, 23 Oct 2024 17:21:35 +0000
Message-ID: <20241023172150.659002-2-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a7bb42-d64e-4e45-5d61-08dcf38736fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZyZ7kYPjPbjiTwqwHj4JKune+rTMZkMFUKicGGbEWZBtT0BWbt7Oo07Qyce?=
 =?us-ascii?Q?zRonoEEt1Qt2PrU/mAjLWgHPUMRBCzh8Qhfsa4a79AQmFQADWthVmA+Ql76h?=
 =?us-ascii?Q?h8X0yfPfKzjXXKkVsiF+kx3cI00EK252bAF8HkoFKp1PWrLfr44K9I31vfF6?=
 =?us-ascii?Q?txzrfD4HltTvx2kk8b3+C2zCyf5c3311f34k6+OXNQhGZzgLXnXnUKO2ZYIG?=
 =?us-ascii?Q?bXsIQfQClnuS/l4Vkywwjomc1pzk4PPCgkWob2gEuQUJcnaHhCykE7Sfaj4Y?=
 =?us-ascii?Q?lwnACXP7dAwpGZ5YHfViw4Z5YndmtZB8bpQjMe4LEYRKpYP/aQxlCIvLsWbX?=
 =?us-ascii?Q?40DemOMEfL8xg2tApDxQKE/XdoYhu+QUxYb9ETZVr10ebYxdkqhDLhUWgRmL?=
 =?us-ascii?Q?zUNbGhLfkdOW0hIzAWel0fAwbL+d7NnZZiUMyx+nUCkqbte1QHjNdIyYeaqA?=
 =?us-ascii?Q?fcsozzviWmuA7H/X7zKRMdI5+gkevBnR8p+ybm3AwIMry5jTAMI/TLG1jO0h?=
 =?us-ascii?Q?Ks3ajoNPW3LeNQ57QxL0LbW1qtmgyWQU8o+Xnje0qdoGP3Buw0hzRDbguf4K?=
 =?us-ascii?Q?JgkKHWgkeunX4c0nz3sv5B08PQEkswegzxFYHIbwCCKL3ud2Ml8viKbiKuoq?=
 =?us-ascii?Q?mFEKLuOJTJIitu5pYm4l/fh6ArxZ4m3ioTBD/NS17cBApzEWm54V3rPyxEbr?=
 =?us-ascii?Q?Z8i+rCh1lNGk58pskIKL0NQ+yqOr1KyI0/0P7csd5BC1s/+zFDdB+VY/jFP/?=
 =?us-ascii?Q?YifXWz5MfRPXzZsprDESkyE+1XnX/TUWkaes1l6cYYoq119FLdCs3R2hnNbe?=
 =?us-ascii?Q?ZrqaXNWrY+ni02vhD6XqIfdaSOGEvzu4Z8YwVhLb8GVUrO6lObqVbQ7RhMxP?=
 =?us-ascii?Q?LZRL/NYZADMq4g09D+NZR/MzldvW0x3Ya6HrnjchaIfo15hsp1z5XYiWpAnE?=
 =?us-ascii?Q?S4+OlhwkryAdjuqmKzntGiUCBzxUpJUqYreev5gF5eZqMZuGDBB39tAUvMoW?=
 =?us-ascii?Q?XxUZQZ2AcIJOh+HGrlpImb1PnbdYQ4m18R2wqizhJBXBr9i5q0F7tIsy6LkG?=
 =?us-ascii?Q?6K4gagrAqbiK/TCLr8Ped1/eQgNbVJyuhfnEFGaa7cDTlnGBpASAOFuDPyXp?=
 =?us-ascii?Q?d+D4w+vUrGAl5lUF7QNH+ylrS9UnwVQZFoTqq17paz+RNcmIVDxfkq+jgs4u?=
 =?us-ascii?Q?4yvSH6fXSyr9/FrPeVMGvF6yB92Xv64p49613wThQzDqezlLCDFS6VZB/keO?=
 =?us-ascii?Q?X8SER8pc1HonP/EFX2jJRAsjj/J1U1q2JO8LOQama0hP3vPAlIM2xBK8Y74U?=
 =?us-ascii?Q?v3aRtR7Ve7efe+mWfyjDjgoBg8dtkDjDn4GTtKewgyONJknMvkaIlFXcQTMQ?=
 =?us-ascii?Q?ufOJJF/IU6z7RWbD300RLbYsA+hrD/G2+RLtySSYC3NEYoJSTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:04.7629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a7bb42-d64e-4e45-5d61-08dcf38736fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201

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
 arch/x86/Kconfig              |   2 +-
 arch/x86/include/asm/amd_nb.h |  31 ---------
 arch/x86/kernel/cpu/mce/amd.c | 127 +++++++---------------------------
 3 files changed, 27 insertions(+), 133 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0bdb7a394f59..c6f917b762c0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1186,7 +1186,7 @@ config X86_MCE_INTEL
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
-	depends on X86_MCE && X86_LOCAL_APIC && AMD_NB
+	depends on X86_MCE && X86_LOCAL_APIC
 	help
 	  Additional support for AMD specific MCE features such as
 	  the DRAM Error Threshold.
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 6f3b6aef47ba..b09c26a551eb 100644
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
index 14bf8c232e45..0c80dad50664 100644
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
@@ -1194,35 +1204,10 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
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
@@ -1230,26 +1215,6 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
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
@@ -1263,17 +1228,6 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
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
@@ -1306,40 +1260,11 @@ static void deallocate_threshold_blocks(struct threshold_bank *bank)
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


