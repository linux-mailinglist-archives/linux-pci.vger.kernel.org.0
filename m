Return-Path: <linux-pci+bounces-24859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92016A736B7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7F93B7ACA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A716F265;
	Thu, 27 Mar 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4h6gjdau"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31413DBA0;
	Thu, 27 Mar 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092533; cv=fail; b=Jh5sNLHJ0JEQZ37P4S5t/1v0Vy48q8JPE2tzZiO+FXsep+QEhojYq40OIwYZN2uBEwErRXxvT7j1NE267NghCXpVVCsVdM2IRQCd1jH0hUThdNDGfTLn50cmcFULkL+cYH3NF2m3GGfPB1N7ySP52jhvbeP1CFLFpiXBYan6PJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092533; c=relaxed/simple;
	bh=TdrbiX+AFqwf7JwIWPJ+gbmKR6KIuLo7x9a/9F0Fpz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tu0kaIGXiTV8HN0cCPNkDB+czjcu7o0TKUrrrik0GnquE061CPFQpR0E1jIUe4lVSWN6m8Hq6d/0fiRlFVXGNU1l268W1g4keiSLbK6p2J5vKq4/C5ijWotiljiPHuXMnrvcSNl8WS7kVAaJTiWhYhRVDNGRYG4dVDszE/Hb0mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4h6gjdau; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExK3tC+5EdtsTcE51Mj5OYtiBz+UkIhKmiUUUHBTfay6iR3NaOBBJ7mTa3m4D5vqepfOppKRR+b1AfgZp9n/C8J0Un+VC3Zjix0fwCxfsv4BRGn1nBc1y1DVhtqMNXMzR4rfxFVYbgKvR7par3RO4wvu27ne7Bj5AgFrsajb04NZP6Cv7+orS+O22pvlpOjHb63QR+ThnCx6s2lhN+RLOFdNbhZ/bOSF4umeaqVRkFEM2fdlYCnb2BZh6ZYWi9JavFYmReiV8w0+1Djnc34GCNdcA/6IYr25OOnacqxuyzR24fINC4RgAE//8uaNAoF8sWJ/PVpAJItAg8Zk6ax7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4w4xp8kVZP5kHjgF6tBQ78b5CF/xDbQ/3vXHD7Lb/0=;
 b=sJLHEKAs0xQWfs8+oEtPowbjarzf5lhUQj/SUp/DL8NcA/emkiAf/PAraHPECr7BlR9Lm6z3/MbRC3TcF/MpC8yLYD/1VwFO54G+7M73BgObWagy0WT/e2bl6IEI9Y+Cgzxlkh/sRzgbpMnOH+QVi4lO4SnprUaVwcrUeYYCxGbmaT19QrOT2hpDFcWkWovrVQ4mMbi7ou1NJLvmv3ro4SAGxmcgpWLNKUqS5c4nZO8/YxevNPSuSnN2wvC+dWbVoyzTf0GXdkgFl/OZ4/59sjiNJuQUYq1lQfBgmRVyLguRBMWxqpdksI8sJsXbYjWhmtXoJA5IzELnjDK0hecBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4w4xp8kVZP5kHjgF6tBQ78b5CF/xDbQ/3vXHD7Lb/0=;
 b=4h6gjdauj32b7+dNyqcSQJCHvlxg0DU3Xg9a8IUshgE9GUC6Qc8Bitnnfy9DaXXBoWPDf5dPAZ/8qJF5gynIM7xAMquotkmfK1lhsmR79NXseAqJD5TWBdv8E8kzbfDlrjDoXby6YqIhEsEe/ivo/t8IkseU7iVyUPDoQXJy2Wg=
Received: from CH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:32::23)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:22:07 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::c3) by CH0PR07CA0018.outlook.office365.com
 (2603:10b6:610:32::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 16:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 16:22:07 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 11:22:06 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <bhelgaas@google.com>, <tglx@linutronix.de>, <jgross@suse.com>,
	<roger.pau@citrix.com>, <pstanner@redhat.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH] PCI/MSI: Fix x86 VMs crash due to dereferencing NULL
Date: Thu, 27 Mar 2025 16:21:55 +0000
Message-ID: <20250327162155.11133-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: a17d6a48-e77c-4c0f-a463-08dd6d4b84cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4X2BJi4GLwWuyHstzGheh/t68S9fjL96GhCId3dpiQKkmQpkJnZx2PlOhzEc?=
 =?us-ascii?Q?BhK3vFtx/lOM6ZmyCPJyJ50zEi78FEe0NowJ4PbiEp49Nufa1XwwvoD2WuXL?=
 =?us-ascii?Q?Ux7L05t2knXzMJFnqTrG/fD87VnvEgfuA8saBQ37I/SwUiKdtK2NlucYIRnE?=
 =?us-ascii?Q?yYKq6+GEFQlclHkyQNohMfErKj/yuHKN9tRMjpezzCyeK0JfZ8JPWGem766o?=
 =?us-ascii?Q?LyHK4aBE/H14VTT6PaYvYZzgkY6H3xHSWiDeFu1rhDW5E/sYCD3E1/UgWF4q?=
 =?us-ascii?Q?yD1Fe4phafzdp5lBjv0cf8rB6u3tM3JR53yDXsc6Ct2TW+WmOTuHZ/a/YWM1?=
 =?us-ascii?Q?ctEV2ASErriusl6deY2IsgExzMEHS3j8kheOtoJTnt+2tKecjcnPW8MKfYj3?=
 =?us-ascii?Q?A6KHGH+CR3YGfVMDFI5n35FVlvWUa9XHEjJXGtmssBQoEBiw6RASOF3sX2Lf?=
 =?us-ascii?Q?YjrvrPM4tPEkjKWlM8kVP140R6SQYjwvvCadMvL7KjY/FfpqdqX5e+u/CbOh?=
 =?us-ascii?Q?jtrkafHOXpk2ER9w51EA31RaUP1gcPYXS204n4mJLHQ1rlz7rFxhxF+byzH5?=
 =?us-ascii?Q?8bVYqkQXYbgEvVBKcPviOIrTJrufrh1CN51EgNW/OE3rQI4T9OrZoEQRKisk?=
 =?us-ascii?Q?J0fWF3Xz3pzdwro4cSgZkPrjRkLdfH1YPkY8VOj2phlTyaqRE/0ZJhrEHuRq?=
 =?us-ascii?Q?bwL6rOihbq1QhOLxND0GRLX3I6UtAKgnje9rCGvyznYQtNyGdK1qy2/ORchR?=
 =?us-ascii?Q?OxFmXdAT00EzF4CL4dJjlFwroyU3ozoqpey5sJ6o0Yag9QBGM0fWPx4llTRM?=
 =?us-ascii?Q?s+GzD35MIBTwiOMOi0/k1RoGWt0JPjfiMTW+fFWiaIzGmXfmXLZCr6TGA6Hj?=
 =?us-ascii?Q?xScUt65Nnb1wPaiBvD12/4pYNoqJXPTZoo3EC4O3/dVe+sITYuoIhGoVISH3?=
 =?us-ascii?Q?sryi33ryYjvpOykN+txlkkMBezxqbCJAoKpV2eGoy5NQx2JCroqLW4KFD58k?=
 =?us-ascii?Q?zwwnMEB41c/9cYr+MADJ5NxnQbBgPSQu5v00146ZNRBcNwvNug2xpY9M6jXX?=
 =?us-ascii?Q?olzI5ZHz3b3YCX10Up2MaZPjP/HH/8FDyEgsskFDAURzQno2dJhb8rI980bl?=
 =?us-ascii?Q?ZkvKpRlL8v03wEAlHTyvGzHMo6Tb5mr8fyLgpUFhtiQWgNeDQHa0NrLD4Bc5?=
 =?us-ascii?Q?4OHHdtwTSb25RX+X+vrNmFvn5UH0CUOHU6X+PJsy1oMMBa1kMOQzK8AJqMJ2?=
 =?us-ascii?Q?dfCgWyjnIUYwp3P2PjUTS2t48N0d0rM3JnjW25knxHAUNYeIxxA6So5t+Bco?=
 =?us-ascii?Q?EUootAfFB4NMsiAAyrs9vE3flELAdfSZ0O+wtsmPRSUxo4ovdA+ODOLczK0Y?=
 =?us-ascii?Q?2xkLXK58FP6hj0qAJDMX+cHJrZH4uJmtHi3llZRFXoZer+NtQ/crqatfh3H2?=
 =?us-ascii?Q?3tLsK84PKYvFR8HEZBw2luMgEJcynQvnmSASiNQX2N21NKoBTdmOJBc3AbzG?=
 =?us-ascii?Q?K0CMkzUbmCfih04=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:22:07.4028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17d6a48-e77c-4c0f-a463-08dd6d4b84cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

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


