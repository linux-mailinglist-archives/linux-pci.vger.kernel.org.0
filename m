Return-Path: <linux-pci+bounces-19466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C14A1A04C48
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6667A0F6F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F451F708D;
	Tue,  7 Jan 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZKCxgOJn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BCD1E3779;
	Tue,  7 Jan 2025 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288951; cv=fail; b=kKAiskVucv9hrTOqL337KEGqhhWhZk1wE1PPlu7Zepv4QnqC8jDJEvNEaU6V3F7ZWYFEv1PMZu8s087/vH1+8eIcONr1M8P0e/KeEuxui+1knZJBi9RGLGz2mnj9wycuuA7PdAtkcwUAgzunGwagbMUipzSBEw5dTFKpHOxd0gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288951; c=relaxed/simple;
	bh=j6sgyOCS+H4nXsVZAHqyU9glI0qM4q3yqooa4aSbYnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFryMgKwCk36ZEHMUFijvquS9f6PtyaSvCvaQPu4i+GLtObVrF25UBH3hgR90iljHgLSWTmq0Xno211fIyU5gcdKzNbsjCCYdBrgU6cXvItEyiWJ824tZzqGucTo8a2K4ohMkIq5uQvy3yzYnL4iufX43J0Zyh15HavobiZFM3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZKCxgOJn; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEXfaD0yjapgS8DQIeAkcoCZXR27AJV8hwAPZ9Dfn/G8AmlIff9QpuXQhyTRq2MlYJ2ApyWNmQqFIZA/rovR6SQUL+iTSSw9Rt+03vRdqzgc23gvIhn2CLpXzToOOBY0UmRuyGayFuCNTFkhn27cbB0+N7nCRNNnWcnZNEHjNXnWTrysUJc2UytWCjhaNF6Yy9339/20/kGgpqf+gdH1whU1ZkcK42JOig+MeY0SDLGoOGGH0Fub4qAKz9ZEf7nVay4dLwNtRVtXTaQgV+2fmOmOMj6so7KFsUlTjN7cT2jy14Sw+coGH01YFGRnn9cUwy8JHBr2biGjvGo9iYnBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYJ+VoJlGuNwoQ17hbmfnJP6YoIWqe9eSMbkvg4e1PQ=;
 b=vE2HqnZwA1clhXqinfwfEgayKrbc/ma0caorE7/rkBqHRvg5HrfKuzJRuSj5ZzreVBAgwJ6Un+kVsN8GBFBw7Y47lNsPQq1fSUU7gCqQlsaf6SXc/kOMm3napOKx7vW2g1h+CfZ6Xv3td4rS9WvZ2e04XHVWwMrf5NXqQGR+/ww27dXrGpxrSiKwXN3pMuNqjhgkh43cfd8CNrh68JQPpJSPUH+ySC2XSaHvdydb6hsEC3Sph9PAnt1LYS4ig98AzjnD+zyFZnKIuT5VDoz2XN3TARsMk0OYSztpeDXehDpTJvMwkNlgPr4PVI01khGHhZn44nXvJYkFKnv9H5m2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYJ+VoJlGuNwoQ17hbmfnJP6YoIWqe9eSMbkvg4e1PQ=;
 b=ZKCxgOJnEA+RaLNp0G/d/LP1PmCZGx30G7iUwdU6+S1SevwT3BNI31mgC29cpz5xMaqxIYFYzfygNkBGxcdnDu1+r0zPJyfu+ozdqjpr0bD7wIX4j5mIpWSxFAIbkWIjFbX7YtRpYsUGgvbEcf/d8GgizAeQqdcGgb8qe7/4szc=
Received: from SJ0PR13CA0232.namprd13.prod.outlook.com (2603:10b6:a03:2c1::27)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:29:05 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::da) by SJ0PR13CA0232.outlook.office365.com
 (2603:10b6:a03:2c1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 22:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:04 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:03 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Hans de Goede" <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>, Suma Hegde <suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v3 05/12] x86/amd_nb: Simplify root device search
Date: Tue, 7 Jan 2025 22:28:40 +0000
Message-ID: <20250107222847.3300430-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107222847.3300430-1-yazen.ghannam@amd.com>
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9fb4b9-3206-4ffd-7eaa-08dd2f6ab1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXezbih7JNgR7BE9Nh14vRd/zl3oZhRse+oRA5j1/xTLdVEc6Qbb26t/+tKX?=
 =?us-ascii?Q?UgdrgZ85l5d/R8KF9lqw0FpGItiv9dchwRAcNXjnVQu3nannxkUmHUAMYSlc?=
 =?us-ascii?Q?tos0EdRzIkoJk41nKRw9nO6iNtgC3Nc/FAWnTZUMCXYQyXqR1w3HM77q0pLB?=
 =?us-ascii?Q?eBh+PYPQUjwMe3dwnCWnR/GwRoQb6XDoaKy8WE+OhAqBvteVRYzou28IowbS?=
 =?us-ascii?Q?XBc6G4AXALd2RS1W7h4vLdTWAKjti2BzxC3ApZuenU+eY3o0iVm8wnIj/K8e?=
 =?us-ascii?Q?KEgdg88yHuiFuhxg/indg0ZTefa9LOm7FUev6F9XnAXcxIvJoNNunb29W9IM?=
 =?us-ascii?Q?g8M1hdqIN7zq+3LxMbf5RAhod8ZNKrwEwvPfAKTGGv2sUtUedxnx5le3yGE/?=
 =?us-ascii?Q?FrdV6TRt0469UrHZJxoh2slRzvAc+laq7PrJuzZzg8wppPytTPekqZ2C5vl+?=
 =?us-ascii?Q?hafbu5CykwsyJrGWeouChD3DZLo410ZlMVT6WmtCWaHl/ZH8/hImWJiUcNHi?=
 =?us-ascii?Q?XgEsKuQoPyBnHjWMuismCvedTLnTqifmzSoeY7SoNvhmVhzzfutOk1rOa48+?=
 =?us-ascii?Q?XcZbxBdRkKGQbDHv8XIe384oSuTFCpklpyGJnr1sn9cmBsO71kSM6ai5mfHG?=
 =?us-ascii?Q?/pAddit4ataGGj0xWPeT2DlAQnRiu+H5/BtN/90oplSvGxwdh/lUvuLoaG6q?=
 =?us-ascii?Q?khmmuLEua4dEeo6d8nvegDqiPj7rVG0CHHRviVbNuu25Ug7UJkoDMGQ7I75C?=
 =?us-ascii?Q?we0a7K0foIPWEBPrnO+5ZtT/3Ylybk0FEVQdbjNbBj+FK5yzMa5dafH9865+?=
 =?us-ascii?Q?2Y4Ny2CdYpqL0JrnJKTGntnSARdP039MgZBVq5vIY9tZywtdq3C1kQL2Wd70?=
 =?us-ascii?Q?EW/aSaHthauwJPx4uAGsZnh/3b+05EH87re2bqb4ZkIcVwzE1bXe+4h8/+G2?=
 =?us-ascii?Q?QtEyFVXDaHgCBYucFhMRSRzXVV1VO2GMJtUbjeSA2UlbGR1pGpycTEleNOlF?=
 =?us-ascii?Q?6YM0i/eADMyI3Jm7tm9y5ZBa0ieqdEgi7NH6dNaTDr2ctsONALmmsYulGH7u?=
 =?us-ascii?Q?h6vh1ZHYw9TGJ+0tgTVJFBCINtiwBFTusYOUpGNVM9rDqU4Bo6mq5EyjThU0?=
 =?us-ascii?Q?GlqJz2ks1Z5VemwbNc266/cKTR8+16S/9fnfWBJVeKW3jqR1mTE/7oZ1/03A?=
 =?us-ascii?Q?DKRTPV777jc3RWoqkjCLEcVyF0TXffg7E+yR6TeeynwRLiGu0opM9q514gni?=
 =?us-ascii?Q?fRv471djeP5svuJ+EfgNsCdZhRbd3CgEqrTWJNEwkmsnifx2kp3r9c70ClFx?=
 =?us-ascii?Q?K/Y0FaJJJg2e3WHKgn3wYg6DsMiaC3jrqxqo05GKdPD0jD/c0ihmL90cu2u1?=
 =?us-ascii?Q?9Rnbr/Lb3j/ax4pTicLG7PHoKkVSwXdi++uB4WF06B0nd33r+040MpelZ2T0?=
 =?us-ascii?Q?QW6vT56GmLm7/csZvwjUFqaE8nCNC6RsdKC50DnwIu/dhhyc7Iym9rz52ySn?=
 =?us-ascii?Q?F0YWQMGO6E2o6pEpyqOGPTagxkG9YnecODuv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:04.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9fb4b9-3206-4ffd-7eaa-08dd2f6ab1a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928

The "root" device search was introduced to support SMN access for Zen
systems. This device represents a PCIe root complex. It is not the
same as the "CPU/node" devices found at slots 0x18-0x1F.

There may be multiple PCIe root complexes within an AMD node. Such is
the case with server or High-end Desktop (HEDT) systems, etc. Therefore
it is not enough to assume "root <-> AMD node" is a 1-to-1 association.

Currently, this is handled by skipping "extra" root complexes during the
search. However, the hardware provides the PCI bus number of an AMD
node's root device.

Use the hardware info to get the root device's bus and drop the extra
search code and PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-7-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_node.h |  1 +
 arch/x86/kernel/amd_nb.c        | 80 ++-------------------------------
 arch/x86/kernel/amd_node.c      | 56 +++++++++++++++++++++++
 3 files changed, 61 insertions(+), 76 deletions(-)

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
index 7a62c5af2531..6218a0428c77 100644
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
index e825cd4426b9..4eea8c7d8090 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -32,3 +32,59 @@ struct pci_dev *amd_node_get_func(u16 node, u8 func)
 
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
+	struct pci_dev *root;
+	u16 cntl_off;
+	u8 bus;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return NULL;
+
+	/*
+	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
+	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
+	 * this Data Fabric instance. The segment, device, and function will be 0.
+	 */
+	struct pci_dev *df_f0 __free(pci_dev_put) = amd_node_get_func(node, 0);
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


