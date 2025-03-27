Return-Path: <linux-pci+bounces-24860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E1A736D6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEA87A5959
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D001A4F1F;
	Thu, 27 Mar 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YHY44p31"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9832F3B;
	Thu, 27 Mar 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093002; cv=fail; b=fyZMSSDxRAeIjzmCNKeOBpggxhJPW7FzmNPBjfrJeITS+dojiUEwrbfGg4MFX5yoL0kihG3yzRgckQXFmWAtIWyNK3caRK7g/7XjIvhOG+59uFTi+vVy8wYFqRnNXrVACHtJI++gyKWO1aAcGawm5JugUahVrSRSdIvEC6rsR3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093002; c=relaxed/simple;
	bh=TdrbiX+AFqwf7JwIWPJ+gbmKR6KIuLo7x9a/9F0Fpz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OfW+ArETqfQNDY4hsZfIs+FOxpdhbQKkoyiG/NygcZy8olsHDjJkuL1y+ZluFU9p1yH6gq94nYFZpQRyGQuvHCd2pPxgbsld4hcvzQBjimlS4Ya/lFLscsaC0711ttciraNDG/O/HGUlQKD5woQB8PXZW+AwC1bIcJshph7tk5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YHY44p31; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya5qVmcX4bHfgqGhD7C+l9J4gU8o5t/rQoPHDlkrr6NdM5iGK8qp4cJKAhEpwCRJH3ozrHJPp3rANBMh/mzljgxHlPb6cusf65OwnRtWt4bIk1/OEvmwJ1ENLpjpNQk88WJjTwj+pVugIAZSCYzt6hTZP2O7OTdBc5FPvYf4eJ2WBwPGUeSRSdSLx1X34etshIHVxZJXBR87AiFShRZRFX6SeJYY+6jgs41f0n2NQGhWE1WAHnWqy0MvYmZ9yvwm7FzKBkcoIEjEWJyIfoDbgtfaiXPFWWr86keWMkq0oh+dnddAlJNP0RgQOIB2WVbBx8qVXHGsXhb+Gmf0ip+8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4w4xp8kVZP5kHjgF6tBQ78b5CF/xDbQ/3vXHD7Lb/0=;
 b=FLJqOOebw2AZKfBAhpL2Q1nFiXHXviowrrqU0F8u0+lBncod9u+SNK98F4RVYsyP/cI6ChhObuX10xXWMpYRfxZJTMpBf7F5/3JkSTE7oeCVM8LhLgW1cKjJ7gOzV9px+8pASqWQfgLH1a6QiDt/TaNkH3NgEhEVuq1RfAsb06WmTZyRBuQmn8sVapSWc/EUAh52mm8y0ExqXrbg0y+uaOz8RyEpKjiPSNipnTGrkRwaybgMYplxYvgMvqRQw5LEufsrvCpGUXRn1kFTYdAYCoR8K1P0HNhOvHDEeC9nEEyDdI7MlOjxj58Fju+y6KOilDqu8YsIICGwTq5j73O2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4w4xp8kVZP5kHjgF6tBQ78b5CF/xDbQ/3vXHD7Lb/0=;
 b=YHY44p31/Z2d6Y6fgDutBO1kxCYLmeHdqwZhn1UG1VNcT9ddcER4E4PQ4CN8ueaK6eahslpyZfWmnzCRD0HorUfZ1zKtUY1JQM1Ku6vcFVdUoHWNvgxnfKvZnXmpHHL49NKaPOSoEWjQFJ/9fuOFqrwYiULRU+FJ77JdGKzPeIs=
Received: from CH2PR10CA0018.namprd10.prod.outlook.com (2603:10b6:610:4c::28)
 by CY1PR12MB9676.namprd12.prod.outlook.com (2603:10b6:930:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:29:59 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::9f) by CH2PR10CA0018.outlook.office365.com
 (2603:10b6:610:4c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 16:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 16:29:58 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 11:29:58 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <bhelgaas@google.com>, <tglx@linutronix.de>, <jgross@suse.com>,
	<roger.pau@citrix.com>, <pstanner@redhat.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH RESEND v2] PCI/MSI: Fix x86 VMs crash due to dereferencing NULL MSI domain
Date: Thu, 27 Mar 2025 16:29:46 +0000
Message-ID: <20250327162946.11347-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CY1PR12MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 634881b3-2469-4cc1-2c30-08dd6d4c9de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOG2fLXAeinJRGIpNXo0JKjYztFN4Qx0AtjQidr/5jYIwRAa5bgyEsK3xJ3A?=
 =?us-ascii?Q?jwafnctDsT01LpvN9RQrJh0ydsrYcjDDfCuAXZH/1YdvKcAjnQnu94BG05+h?=
 =?us-ascii?Q?4POo+lmUG+qpWxlx236zOjPT7DnodTaDAB2Bv2uoaKGUyjybyhE/UbrvAqLl?=
 =?us-ascii?Q?PL8uFXCuuRWOreL9tww4tp0p8mepNhwmRCFk7Pkg7KiAwH22gICJmB7d+qgM?=
 =?us-ascii?Q?nM3A3bk9mki6FWWzo2JpYqu9B8NwxkrcQYHlc+RpgHs+HW4RXNNZtLg0tKb/?=
 =?us-ascii?Q?vtlRwemM1SFVaN/vCJa+5HNrv/7/2SC8LHgL6m/h1nxZ/Q3NrUi7SH05fPrG?=
 =?us-ascii?Q?Y3QtHri0LAu+Uo2ThbRfDcgMBDwrVp6o2NPRKQ4crZcZXW4SeP7W7l05sz4m?=
 =?us-ascii?Q?1lxqBXTFtsQIypOctfZTuh/TVBvLjgTLY6dqOJCVX581BcVXHyEQ4I12LUa2?=
 =?us-ascii?Q?Akd5m9XjVeg6010/LjSCqbPWy1EKhdsyqvvfP+2WMrVx40UoOAcI/LaIkqH8?=
 =?us-ascii?Q?qYdSwOwoBVP4yPOpSPpUrf+gUAWETDK7YSy0v+yWrO56oXBpHcqmd4Cyh5B8?=
 =?us-ascii?Q?uAdNKncwnXdJoOqOQFmOBPeW8CqlNXmVo8Gz93hkkIkb5XXBv1woWUB7wOqw?=
 =?us-ascii?Q?n6HFeVU2ZVSqTmo5tN+NaSIHHu3wtU+L+iP6+pLyitSWkZQj+QSGU9IJYEr1?=
 =?us-ascii?Q?z6xEFTRyFgy9t8Qr4CpQ/VRsedNYLPieBIjU39o/68Kg9T6PkrfLY893c+15?=
 =?us-ascii?Q?30wHGH8RAlJuRNRQ6Ys0gYKmI6RmyY/e7cjBfjJ/1cIf13XYmflnYqlnOHJz?=
 =?us-ascii?Q?qqGajyF4CUrJApAB4b1/H6OBaKX1ydbGtENe+5Ioqylff7yYKjeQwBkdrhJD?=
 =?us-ascii?Q?zKX2+N1JqPVGFFg8POO8lPAAPlgQERjo3/Ih+QlXNHsgz7o1GVBzIQBWGDo8?=
 =?us-ascii?Q?7Bl46J4YV1XOO5hE9LOKXlKP3yXs/MbuLCPU+OnYwuv2/3BYjlaSvyk+BnO/?=
 =?us-ascii?Q?KlmaQ4dxyXwO/r1WGdPA0B5ehPP4C9EkK6Pa9bL9icXE3iqqymvFWILE4BmP?=
 =?us-ascii?Q?pW7+5SXMPM2UZjVo3yZ2+wAluSaE2/R55HXhcRLwpv0mKJ3iwzL37o7TwCZh?=
 =?us-ascii?Q?dt+C+isdeWJJz08zVN2vmjCTCxtnOZqZjL66nzqMCLSzOOtddVOr9XofNTEf?=
 =?us-ascii?Q?l6BgxM5sTF7TofPMmkax6TFNaZlpTka7r5LC8xKr2l7FVXOP+rBFVH2FvPVQ?=
 =?us-ascii?Q?IMyHTmR9vHMfm+IZ6WYjzYFh0Q5mYVWl6U6OQXii9v47+E2fmPrbAvf3DrW6?=
 =?us-ascii?Q?9LBtb/EuxK+wK++cN8syDfSCp/lEzLT3sdwI2Bwzd7ME6fHixZwJyzFSu0/w?=
 =?us-ascii?Q?YibtI503Q+ObevNoFMon/pW/w8964QbzK6kGTX/ky4IbYGiQkPB1Z8aKiNkR?=
 =?us-ascii?Q?hTHS4o/hbxCekNLiVHzYfIE14jTk45SZzFfGUuZzgo034KQPoyWNae1ZHl4U?=
 =?us-ascii?Q?W1VD+g998o88dEqtUvvex5FznUJy//795Ph9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:29:58.9484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634881b3-2469-4cc1-2c30-08dd6d4c9de2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9676

From: Ashish Kalra <ashish.kalra@amd.com>

Moving pci_msi_ignore_mask to per MSI domain flag is causing a panic
with SEV-SNP VMs under KVM while booting and initializing virtio-scsi
driver as below :

...
[    9.854554] virtio_scsi virtio1: 4/0/0 default/read/poll queues
[    9.855670] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    9.856840] #PF: supervisor read access in kernel mode
[    9.857695] #PF: error_code(0x0000) - not-present page
[    9.858501] PGD 0 P4D 0
[    9.858501] Oops: Oops: 0000 [#1] SMP NOPTI
[    9.858501] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-next-20250326-snp-host-f2a41ff576cc #379 VOLUNTARY
[    9.858501] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[    9.858501] RIP: 0010:msix_prepare_msi_desc+0x3c/0x90
[    9.858501] Code: 89 f0 48 8b 52 20 66 81 4e 4c 01 01 c7 46 04 01 00 00 00 8b 8f b4 03 00 00 48 89 e5 89 4e 50 48 8b b7 b0 09 00 00 48 89 70 58 <8b> 0a 81 e1 00 00 40 00 75 25 0f b6 50 4d d0 ea 83 f2 01 83 e2 01
[    9.858501] RSP: 0018:ffffa37f4002b898 EFLAGS: 00010202
[    9.858501] RAX: ffffa37f4002b8c8 RBX: ffffa37f4002b8c8 RCX: 0000000000000017
[    9.858501] RDX: 0000000000000000 RSI: ffffa37f400b5000 RDI: ffff984802524000
[    9.858501] RBP: ffffa37f4002b898 R08: 0000000000000002 R09: ffffa37f4002b854
[    9.858501] R10: 0000000000000004 R11: 0000000000000018 R12: ffff984802924000
[    9.858501] R13: ffff984802524000 R14: ffff9848025240c8 R15: 0000000000000000
[    9.858501] FS:  0000000000000000(0000) GS:ffff984bae657000(0000) knlGS:0000000000000000
[    9.858501] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.858501] CR2: 0000000000000000 CR3: 000800003c260000 CR4: 00000000003506f0
[    9.858501] Call Trace:
[    9.858501]  <TASK>
[    9.858501]  msix_setup_interrupts+0x10e/0x290
[    9.858501]  __pci_enable_msix_range+0x2ce/0x470
[    9.858501]  pci_alloc_irq_vectors_affinity+0xb2/0x110
[    9.858501]  vp_find_vqs_msix+0x228/0x530
[    9.858501]  vp_find_vqs+0x41/0x290
[    9.858501]  ? srso_return_thunk+0x5/0x5f
[    9.858501]  ? __dev_printk+0x39/0x80
[    9.858501]  ? srso_return_thunk+0x5/0x5f
[    9.858501]  ? _dev_info+0x6f/0x90
[    9.858501]  vp_modern_find_vqs+0x1c/0x70
[    9.858501]  virtscsi_init+0x2d2/0x340
[    9.858501]  ? __pfx_default_calc_sets+0x10/0x10
[    9.858501]  virtscsi_probe+0x135/0x3c0
[    9.858501]  virtio_dev_probe+0x1b6/0x2a0
...
...
[    9.934826] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

This is happening as x86 VMs only have x86_vector_domain (irq_domain)
created by native_create_pci_msi_domain() and that does not have an
associated msi_domain_info. Thus accessing msi_domain_info causes a
kernel NULL pointer dereference during msix_setup_interrupts() and
breaks x86 VMs.

In comparison, for native x86, there is irq domain hierarchy created
by interrupt remapping logic either by AMD IOMMU (AMD-IR) or Intel
DMAR (DMAR-MSI) and they have an associated msi_domain_info, so
moving pci_msi_ignore_mask to a per MSI domain flag works for
native x86.

Also, Hyper-V and Xen x86 VMs create "virtual" irq domains
(XEN-MSI) or (HV-PCI-MSI) with their associated msi_domain_info,
and they can also access pci_msi_ignore_mask as per MSI domain flag.

Fixes: c3164d2e0d18 ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 drivers/pci/msi/msi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index d74162880d83..05c651be93cc 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -297,7 +297,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
-	if (info->flags & MSI_FLAG_NO_MASK)
+	if (info && info->flags & MSI_FLAG_NO_MASK)
 		control &= ~PCI_MSI_FLAGS_MASKBIT;
 
 	desc.nvec_used			= nvec;
@@ -612,7 +612,8 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 	desc->pci.msi_attrib.is_64		= 1;
 	desc->pci.msi_attrib.default_irq	= dev->irq;
 	desc->pci.mask_base			= dev->msix_base;
-	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
+	desc->pci.msi_attrib.can_mask		= info ? !(info->flags & MSI_FLAG_NO_MASK) &&
+						  !desc->pci.msi_attrib.is_virtual :
 						  !desc->pci.msi_attrib.is_virtual;
 
 	if (desc->pci.msi_attrib.can_mask) {
@@ -747,7 +748,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
-	if (!(info->flags & MSI_FLAG_NO_MASK)) {
+	if (!info || !(info->flags & MSI_FLAG_NO_MASK)) {
 		/*
 		 * Ensure that all table entries are masked to prevent
 		 * stale entries from firing in a crash kernel.
-- 
2.34.1


