Return-Path: <linux-pci+bounces-15135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8739AD293
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA5728211E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADA1D90AE;
	Wed, 23 Oct 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MK8c6euo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3121D14E1;
	Wed, 23 Oct 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704136; cv=fail; b=nvHMWgt7nHQf/xBhQEYcH4Im7mflcO7xXe8kZMFPqBHkK882y+1Er9ql1dELeFku4qyF14Q561Axdv7Nc8aWxhb0xRG7IocgO5XdQd54MyCzKcpKQ0IUKQ7sKTZQjN2mP7Z+NVVfY437y5kvcnSFu6h82K6Mv1RuH6ANlZDOQJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704136; c=relaxed/simple;
	bh=iY7cHi+gUHGRkHOVpA+0Nq/nE/11FeDTjEj5ElJTPyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxR8NS/ML9tQDSK6v+jeREw2LyRBVFaMAQfsoaVEJ0zdOg3jMGYgV1exJUagIGgUqTKG3fb5lM2TnzQFSEYTc7Z6nbQGIiYALDDhrOHywnb9m3GGZSRuJRt+LenkEt52bjc/HchnYgBpRIs16oCyhyNgLvy7ZNIfSKSU65WQ8w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MK8c6euo; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIon7eqVxxnV7MJ0Qx03m07CEteBCwd7owKACtl32htFsTUuZLn1rfnHAHtF0xkgFZjl8prGr+zoYve86aRsUHZKwZdRwwthfSvd3Fo2mbuOGnwUWDvfcuaimRBdlErxDc91m5GwqcnGjiqSUZ4Uu9GHrgMpcb88K/vviuOREKyFumKbsYbSv0SKNGM0xza6BwRQfus/HHTBeOcG37qc0U9ua9Zq2JbK2EakyWbMvYq9Dz63bMVMg4m8Je8ALV+3gic39U6gM3cpZRdLoBLwVmTU1fkB4u1ZZfmJ+NhAIqGe9S7An7apBQ2d7+6BUXVgMYbZH0AbwWsPc9eysXxyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpH3h8B4N35Ofklb0En1/r50952+zGplhK0cPH1ojKs=;
 b=fOB2u1PWjS+NF1QBXh1swbf/8zmLpQ9tV/ARr08wv5a8StEU/etVcikHnNt5U223VySQ0o6nFnJNRWjwg2qbfYpeJ9sY7lG+ZMgvCvl2biWxrPcXqFLo9T150QqGq4qgLOvnyonfVLBrSA9phYfvPiDGPwZai6K1MsvSwj/Bc+v21oN+Cr6bfL/aWo3vLf5iekFsVk5dp2Nnq9nyg8WltzQMlvZ/ASf9hDHRgGFH+nU679DodAfjl2JphP/Pjt3WJ84dZqGIV0sWyno9s9y45mMKx0rnMm18jxG16aQOSP7/TMjqN9WKEg39MU1FIZGzOA3tF/1fV5XVihnYfGzqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpH3h8B4N35Ofklb0En1/r50952+zGplhK0cPH1ojKs=;
 b=MK8c6euoXhXkH6WRZnUMlVwu4lz+gE6tBs+txgYvDK9Ibal9V8yLdA1254g8D5oiCIzPqCV4x+0xtt0HJ4p6RG/jyUPNN5qSoCE98IAAJjV+HCKs4rCL8H7k0cIRklGoeelHQOU2wk918lAinEoYYxDwKltESc9GDX84AAIMWdM=
Received: from BN9P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::14)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 17:22:10 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::51) by BN9P222CA0009.outlook.office365.com
 (2603:10b6:408:10c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:09 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:08 -0500
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
Subject: [PATCH 06/16] x86/amd_nb: Simplify root device search
Date: Wed, 23 Oct 2024 17:21:40 +0000
Message-ID: <20241023172150.659002-7-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 347fa5e8-fd30-4ec5-ca6e-08dcf38739d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/YOsmoURdp2yxgsz3YrQMDVyUfIgWq2xZ91glMqyPAtalS5+CPcp7OJ2v4xt?=
 =?us-ascii?Q?tvaN76MZgrS9BA5nJA2HQIe2+bzqY8ApAKZfplrKrKLDacR5DOtrn6uvXLS4?=
 =?us-ascii?Q?bRf7638RR8+XwanvFosTgIuT1UrDVf16GEx4U6kNP5eUM0mYAenP1++bM1a6?=
 =?us-ascii?Q?LcmacvkZt52vsUoOjJnayLJ6ojk4T1jOMaMAU5yrfI3na/Qf3rjVGFrRCwod?=
 =?us-ascii?Q?moItopj8Rr/1/I6jCPztRYQPHXpXYvkY/Sb6kro9J09v/qUhcsYBZzMOdjId?=
 =?us-ascii?Q?Yw3/3jS2pNvig+o+6zlqWSgBKXpKQERCOgk2QsGDPsQ5wakJTRDARFjNo5Ms?=
 =?us-ascii?Q?TfrkD6UbDnj2OTyuNi6wML97gVPLsvKsjmFSv1Idpzm4iRfqnjbS2AvYAldD?=
 =?us-ascii?Q?lBzwfGQQ/UrFI1/CvXi9dlcyitCIpU6AfaF36A4DIOAqyRVt/Z2pY3y3uaE/?=
 =?us-ascii?Q?yAJsIt6WvPN5xCs5QpNpnFuQHdBECYApNG+/YTBqFH8mAbjUMyldogh2qLcB?=
 =?us-ascii?Q?Zpi4ECfJfpmmhkWS002P2AogrLx1lUAcbM1eQmJcsD4KTQx4Wha2PmQIV8BD?=
 =?us-ascii?Q?tUUXzopxvgOYFBIYlxZyz5jWncHQN9gSakC+M+OXQrvaif2XeEbEIkPzkmlF?=
 =?us-ascii?Q?Cb0c2r9N9S7kdHvwD35om0CXUM4k9KtIDecGb8k0d3lLwJeBsk6h/72ent3c?=
 =?us-ascii?Q?oLud32knPJpA6xd5VDJW2MtYmQQj7DtLaZuX/RfvQDya9O0yv8Qk0iBQXrWM?=
 =?us-ascii?Q?IJFXlXSvPTvZZBwxludYu3AEAwknG0YSs/CFa34Dez75HtnvvXcnRFa1W9t0?=
 =?us-ascii?Q?ehJjxhTAuJYor4cxoPC+4v7oWl0rxDybq5DjTnAFuiYozGjnLo9TUr6Tp21g?=
 =?us-ascii?Q?UECVxJiMHcLPiugVPyPR9t47920fvrWMyXxBjrtHjLyWKL49P4pW5wBFz1ul?=
 =?us-ascii?Q?iVXhq5wwPgVnvFeMZ4T1a25RAztJrYiVb058CZ+Up03906kAeq1I8tO95IQL?=
 =?us-ascii?Q?jeX89lMQREfV5FX2litx4gZVpM87+Y+/gxQCJbh6p3xiQBGcDoaYn8cYF4vT?=
 =?us-ascii?Q?jipzKCBT1ewTnpJPaZ0pyGNYU8DFsL+aQpP8p6vxuvqrNHEk2mj2pqH4tN4J?=
 =?us-ascii?Q?Ati93Fa+7tOI7PvY4BRmsr6uVcObyI2vsypzCC+pOPYpcWyo0bvHCxnmgyVm?=
 =?us-ascii?Q?sIswyqfjEjSC+PS6S0I2m/Pl0zQv94gwj53Ade6rgWBA78e/IS+8yEjI71n2?=
 =?us-ascii?Q?ReMEqHYB8S5HufqNj0IEzl0aaMdM7gazahbsrK7Dy25xfudTUQXW9MJ/DmLZ?=
 =?us-ascii?Q?o0iTp+DoL5TCn2a4cBRzKIV0sqhMtBnPbPb3gpAP9NJoWg2OLgtVak3iuSDe?=
 =?us-ascii?Q?CgRAZCPhZnz7glUdOWme7aDWXMJ1sm6If4oyimzPdJvCCFoYAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:09.5564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347fa5e8-fd30-4ec5-ca6e-08dcf38739d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026

The "root" device search was introduced to support SMN access for Zen
systems. This device represents a PCIe root complex. It is not the
same as the "CPU/node" devices found at slots 0x18-0x1F.

There may be multiple PCIe root complexes within an AMD node. Such is
the case with server or HEDT systems, etc. Therefore it is not enough to
assume "root <-> AMD node" is a 1-to-1 association.

Currently, this is handled by skipping "extra" root complexes during the
search. However, the hardware provides the PCI bus number of an AMD
node's root device.

Use the hardware info to get the root device's bus and drop the extra
search code and PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/amd_node.h |  1 +
 arch/x86/kernel/amd_nb.c        | 80 ++-------------------------------
 arch/x86/kernel/amd_node.c      | 57 +++++++++++++++++++++++
 3 files changed, 62 insertions(+), 76 deletions(-)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 622bd3038eeb..3f097dd479f8 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -23,5 +23,6 @@
 #define AMD_NODE0_PCI_SLOT	0x18
 
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
+struct pci_dev *amd_node_get_root(u16 node);
 
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 34c06b25782d..135ecc0a0166 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,44 +15,11 @@
 #include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 
-#define PCI_DEVICE_ID_AMD_17H_ROOT		0x1450
-#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT		0x15d0
-#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT		0x1480
-#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT		0x1630
-#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT		0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT		0x14a4
-#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
-#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
-#define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
-#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
-#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
-#define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
-#define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
-
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
 static u32 *flush_words;
 
-static const struct pci_device_id amd_root_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
-	{}
-};
-
 static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
@@ -85,11 +52,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id hygon_root_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
-	{}
-};
-
 static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
@@ -222,19 +184,15 @@ EXPORT_SYMBOL_GPL(amd_smn_write);
 static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	const struct pci_device_id *root_ids = amd_root_ids;
-	struct pci_dev *root, *misc;
+	struct pci_dev *misc;
 	struct amd_northbridge *nb;
-	u16 roots_per_misc = 0;
 	u16 misc_count = 0;
-	u16 root_count = 0;
-	u16 i, j;
+	u16 i;
 
 	if (amd_northbridges.num)
 		return 0;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		root_ids = hygon_root_ids;
 		misc_ids = hygon_nb_misc_ids;
 	}
 
@@ -245,23 +203,6 @@ static int amd_cache_northbridges(void)
 	if (!misc_count)
 		return -ENODEV;
 
-	root = NULL;
-	while ((root = next_northbridge(root, root_ids)))
-		root_count++;
-
-	if (root_count) {
-		roots_per_misc = root_count / misc_count;
-
-		/*
-		 * There should be _exactly_ N roots for each DF/SMN
-		 * interface.
-		 */
-		if (!roots_per_misc || (root_count % roots_per_misc)) {
-			pr_info("Unsupported AMD DF/PCI configuration found\n");
-			return -ENODEV;
-		}
-	}
-
 	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
@@ -269,25 +210,12 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 	amd_northbridges.num = misc_count;
 
-	misc = root = NULL;
+	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
-		node_to_amd_nb(i)->root = root =
-			next_northbridge(root, root_ids);
+		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
-
-		/*
-		 * If there are more PCI root devices than data fabric/
-		 * system management network interfaces, then the (N)
-		 * PCI roots per DF/SMN interface are functionally the
-		 * same (for DF/SMN access) and N-1 are redundant.  N-1
-		 * PCI roots should be skipped per DF/SMN interface so
-		 * the following DF/SMN interfaces get mapped to
-		 * correct PCI roots.
-		 */
-		for (j = 1; j < roots_per_misc; j++)
-			root = next_northbridge(root, root_ids);
 	}
 
 	if (amd_gart_present())
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index e825cd4426b9..3aaf7c81f0fa 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -32,3 +32,60 @@ struct pci_dev *amd_node_get_func(u16 node, u8 func)
 
 	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + node, func));
 }
+
+#define DF_BLK_INST_CNT		0x040
+#define	DF_CFG_ADDR_CNTL_LEGACY	0x084
+#define	DF_CFG_ADDR_CNTL_DF4	0xC04
+
+#define DF_MAJOR_REVISION	GENMASK(27, 24)
+
+static u16 get_cfg_addr_cntl_offset(struct pci_dev *df_f0)
+{
+	u32 reg;
+
+	/*
+	 * Revision fields added for DF4 and later.
+	 *
+	 * Major revision of '0' is found pre-DF4. Field is Read-as-Zero.
+	 */
+	if (pci_read_config_dword(df_f0, DF_BLK_INST_CNT, &reg))
+		return 0;
+
+	if (reg & DF_MAJOR_REVISION)
+		return DF_CFG_ADDR_CNTL_DF4;
+
+	return DF_CFG_ADDR_CNTL_LEGACY;
+}
+
+struct pci_dev *amd_node_get_root(u16 node)
+{
+	struct pci_dev *df_f0 __free(pci_dev_put) = NULL;
+	struct pci_dev *root;
+	u16 cntl_off;
+	u8 bus;
+
+	if (!boot_cpu_has(X86_FEATURE_ZEN))
+		return NULL;
+
+	/*
+	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
+	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
+	 * this Data Fabric instance. The segment, device, and function will be 0.
+	 */
+	df_f0 = amd_node_get_func(node, 0);
+	if (!df_f0)
+		return NULL;
+
+	cntl_off = get_cfg_addr_cntl_offset(df_f0);
+	if (!cntl_off)
+		return NULL;
+
+	if (pci_read_config_byte(df_f0, cntl_off, &bus))
+		return NULL;
+
+	/* Grab the pointer for the actual root device instance. */
+	root = pci_get_domain_bus_and_slot(0, bus, 0);
+
+	pci_dbg(root, "is root for AMD node %u\n", node);
+	return root;
+}
-- 
2.43.0


