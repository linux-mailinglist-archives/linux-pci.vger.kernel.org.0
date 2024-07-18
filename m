Return-Path: <linux-pci+bounces-10504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A731934EB0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 16:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F48CB20BB7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C81213B286;
	Thu, 18 Jul 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nCdRnRrM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7113D8B8;
	Thu, 18 Jul 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311425; cv=fail; b=P1DjRHVCWHzYyLeEZNDGJ/CUNLWjFfcG7IEdKoVs+O7XYc8P2HJoSy3X+H1turKGcOOMmzdP6jETOf/clo3P0leZYwBvxThx4JLrXZl21/LgikrP4SAdvMqsxJh4v/1oD2ovrD7d6SOY8YXnDVvRp9DvlLlJVf0Q6Hof7EeYK+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311425; c=relaxed/simple;
	bh=KnpA3tLbamma6kE4RArguIVmB+ZeRSGPFNZKcMwuHwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fn2Ocj5vodPrbF9fqeQwjlwde7UB03w9JJtLGWKIyfWtdoEs0EcKmBMMJm61UwnEzCN7YaCgX0Ww9SCWhzlKZE2LBVBcQlTIc+8kMTRzODS94Sud/Rn0F4tb1c8hT/mo4aOpCP1gl4ycB63d9SD42DOSSyurk5uiyfRYOBVnoWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nCdRnRrM; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHZ9mfaST96WjG6JRmnNzCdU3xN4cDultfiaF3yW+OtqZuq1Mw+NqNkuL9wLDb7x+hQMeH5IEV+UqrzbCef8BEPIvkDUTgMGItRk1BvnKCz2fL3RbDXUJKso1soDqRUkNE0pnvkIIcB0zsyyMOliMJuyV/QH6uVBdpoUIL0akxPQFe9+lqFGOzU07gEjt7fSLzPcedivMGdX3fJjNIEPTKa0tHQGze5qT1cDfYQLauGRZXbln08j1hSoYF1/2O/hEKj1QR/nrnosK4JRiicE8RxihtObzUoJZBqTn3ngmcF+5jvHry5k6MZcbWUFchlUqJBuBW69SQFhyQBKqWI5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsGmuWGZUcQzY5rYIief2T8uEzEQQXjtE5AnZD2YDUg=;
 b=JYqM47Lff/Bz/Q/NFgqTP8w3Q4IoTvbuFrlGninRmhv+rLaH6kEkYGBAQNL0cP+MgST5Ts8h0gQYIz6w4tkNjoFSUfByy7kODbwNeaXz4b8CSmcz7RVmw+0TGfwNgKfuDjOpQ8UiH5lwzqRAdoRFGdPiSlNvjdkb1vfvAwY966vTuFU2P5vEJwqGtplgpgmyh1VKrGYMiV9ND0Pa1QdwqZ5fQlxHouV2+Juz8mER4vgTamG1y6m6Ox6jdaflNuHQL7OrCKWaVPQtZ81xrN7AiyNt6IslwXvOGqtHfA99ftHZn0k0ukFecy/A1vFfNPM9DZExsCUATZjgt1+h9uW7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsGmuWGZUcQzY5rYIief2T8uEzEQQXjtE5AnZD2YDUg=;
 b=nCdRnRrMmc69MZKSgUBXvsPxj6wHgSRLrjvOCzNWNK91Oe/qM/EVNieKlyVP7vZ0Unk+KWZ9eTA//Zf41NLAHXWd9LyTFdCW8Q8UB8pDslirUOPmaWOgPXCvbmY4Ix2YRyOvzW6tdQDxuOVdlBxIHrqmS7bRSKPR5a9p+ujejU4=
Received: from DM6PR18CA0014.namprd18.prod.outlook.com (2603:10b6:5:15b::27)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 14:03:34 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::43) by DM6PR18CA0014.outlook.office365.com
 (2603:10b6:5:15b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:03:33 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:03:27 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Anvin <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Muralidhara M K" <muralidhara.mk@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, "Avadhut Naik" <Avadhut.Naik@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v1] x86/amd_nb: Add new PCI IDs for AMD family 0x1a model 60h
Date: Thu, 18 Jul 2024 19:32:58 +0530
Message-ID: <20240718140258.3425851-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f899560-9509-4cc7-8ea2-08dca732697c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TKwqV12Ej4sVNsLMjj9ByeFy5omjaDbrx2cOrcPpI3DRSQ2r7nKH4ZO7Y/nB?=
 =?us-ascii?Q?oSJc7GE82Y7GNxxO45dBZSa98U3j70gF0eU4UsPHL4P3PuYvDN88QP1xRKzT?=
 =?us-ascii?Q?GUYeLoRDJad6whHmKZ4po5mMY3N5kF9yZubOljUh0hi1ghekAKB07ongWv6g?=
 =?us-ascii?Q?vu21cdonUucDpIl+nDCT6imNQ0AW1jU3SB/m9BOqYuzAF7bFv9wfAyktnrwM?=
 =?us-ascii?Q?6qKE6ccqqag2yNsDpxxTWBVom0VKdNOozfQZpqJ5c4pEnoOo3SgWh8f0Q8VZ?=
 =?us-ascii?Q?MzqF91ATENwqBN820gszsM8MLYGxcIpG3OBWpD4mHpfeT8j3ZHLeKKfNEOkv?=
 =?us-ascii?Q?5kBZtdd+mCYzwF0cUnWMw8yQzEugPjoG0eHDzUjBHfL4y+dp+o0/AEJs/qH3?=
 =?us-ascii?Q?+fvuInQ+pHeObVVFe1zJiOLyhIYquVM2jIy/lqzplroBe4NrwNuVAbfCFqyT?=
 =?us-ascii?Q?oxgI4bzQozJUyvcpAkLeDVaPbrtqrQw0QjX2pGCiWXVMEwisu7Kz6PYC9JUu?=
 =?us-ascii?Q?oHgSZq858xAOzOHVF1/g7LbY9FnsBI9hUVUTR9ddOoYnKInRY245QxjgRBlW?=
 =?us-ascii?Q?H5eX4XoqkvFfCJWaEpHKounkWQDyh7y6DY8knrDR0TPJJFwZNUyhU0Zi8CJA?=
 =?us-ascii?Q?65bd3uAH5qkipIPF3yjvNuSbtsWwD7Zata/E1QYDPP5VDSdl9pgSCcG5oAE9?=
 =?us-ascii?Q?kTT7uhkDkoonJFp4nU2yofjU4mF43pLXHmCW/wUiJm1OfGfp+0l2rFYe3WBi?=
 =?us-ascii?Q?VroVNOe9sgCr2Br7hmwoq7k8s0c3vLE7lXed4J4vk1x/PxzL71P545Sids0e?=
 =?us-ascii?Q?LugYYzvPMUfcv7rd/yedxuKof66+3trm2CbkusaxgOCYczYXcufgWsVS4cFV?=
 =?us-ascii?Q?smQDybeFl9kWt1ouD26u0LICIMig7F6j+jMS5A46rbyJV2TOtxd8TonEsjUs?=
 =?us-ascii?Q?0f6+aGNQsEWx2zl34ed/SeirG0MEPSKgZRpkUHEc0aSXmmllntDvOuW9eYTy?=
 =?us-ascii?Q?tJsB7l/2kdtnaoxdF2HQ703noq6dtrn/gb0oWyIPX/mA3juicz9Evqfg0KDY?=
 =?us-ascii?Q?ncLp4MG0LYetdNatjPAnY6preXXUOhe2RbTNhW6STy4hBMfYjcSIh0RiV8QC?=
 =?us-ascii?Q?OXJpzOv3NexDTnIK/mc+bqf3Ziz9ePaP5bUXjnr28Y0P0wuNQHy+u1HBoXWa?=
 =?us-ascii?Q?b7AhmcSGFZRw2D+1JadFbAuC+NNMrhqvWGxz/XzBZlqxVNDhMoGdgWXlDzfy?=
 =?us-ascii?Q?oJneoGpi8QHgQAlCka6s4tEEpsG/0nAhUCJRlTS04zJld5Zg5qlgv15RuwT+?=
 =?us-ascii?Q?1VtsZaxfHozpGHlV/HByQdarXKMm89hOCKJ9E6uNCwjeLQtIgnj52GNefZ+i?=
 =?us-ascii?Q?Zt7KYZeJD6UlXnWN/XQmDZKJ/tkjmAHpyhnQmpXs3RKGjfHQx8pqhfStAx5v?=
 =?us-ascii?Q?9hmRo+mgCts2ELuC5BVNKdI1ILxF8rWaSo2ixHDc9d2es5J5P3kU8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:03:33.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f899560-9509-4cc7-8ea2-08dca732697c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869

Add the new PCI Device IDs to the root IDs and misc ids list to support
new generation of AMD 1Ah family 60h Models of processors.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
(As the amd_nb functions are used by PMC and PMF drivers, without these IDs
being present AMD PMF/PMC probe shall fail.)

 arch/x86/kernel/amd_nb.c | 3 +++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 059e5c16af05..61eadde08511 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -26,6 +26,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
 #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
 #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
+#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
@@ -63,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
 	{}
@@ -95,6 +97,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 76a8f2d6bd64..bbe8f3dfa813 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -580,6 +580,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
+#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
-- 
2.25.1


