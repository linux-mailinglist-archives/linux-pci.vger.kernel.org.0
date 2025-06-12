Return-Path: <linux-pci+bounces-29525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545AEAD6A90
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93871173878
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42F42A82;
	Thu, 12 Jun 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jiWXWLOi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF28F5C;
	Thu, 12 Jun 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716578; cv=fail; b=JMM/hwX2llLsEJgoiDv6G4jywUb5qTBTPauDYFqg2BAs0KqlSMuwIsk4YOW+icDC+uUyRdbfREoP42lnJO7atJxHhWsYdZnfbxRsbM2y6HQa9axRJrGLmvmOpq5V5Ec42T73E8hY9Gl26up79S2pZmbVHisRgdiq3r9AOR90mDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716578; c=relaxed/simple;
	bh=mwzxsH79ou2B//FdnNEYdvfHCqv6o37j8joDgxYONAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9Km63yrErW23e3Kk+6e4oQlZrClmQiP2IRWvdSYY0joJX6UgatlaE4hbNrtKbH98WbycgJuiv6S+tS8iE9/ktipbSqfjGQvQADg6zpexb5Jy5wLPHL7EhWcwSZodNb96ApSKiM8De0A/JgFE28025bAbNDxMI4aCXuCnmKfr1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jiWXWLOi; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNq8Vw6s2frfCDLOf9bA+PzxA15k4FSY20UUfrP/p4oquVH4dUqny+3zIWy0hTSplg+nodxhTxbUSJjyZewQLRZDgrUc/BGuHVjJmfzqUyX7JkbhJvaYnX/TLnUA/pJERM7HB/Sr/Q+AoPZSANCY+laisD9UPZNz9UTqRwcVv6mlLWDbhqrx83lvyK/K9D6SCkzc++Q29se1Q4e1sG9w0pQCQ3Xxs03tgraKEb4YeXC93hE1d2cfPRl7h4b2GGX0zs/7JSfVXaNa4R8lB8CmjKj6plPFeAvX3LzPebs0BrtlYfSr7sn8rIqs+yj6QNdNHEr3WWMxS0a2Sg4vSJ9NRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3Lf9dUvT3SRab7KtcmXVPB7MhfKO9fY1L2iTVGIs6Y=;
 b=nPkPyhQdlsFZfKcA6/zDiKxTVx7UKCSFMvqQQxWXdGWz2gI3ppTvnRfJYX98T0iiX5i+ZlnvKFZeL//1Bf3raIIbWCdwe05HhuobsGq1iuAgPRl+UC8PsfxtW/FbOdy2D563+b61gpLP2JPWHpChRTIzZ7BwwyE2qw93Meq/85vyhE+RVgZxL2egb2HLvpS91Lxfjuvu9tv5uhsE7Ifs/tCVv0I2AeCgkTvXWtWlCU5v5j7b3qdvY5MQSDuvsTb4i89wTGfbdEga5ptX23SxuGJuOurmYl+7fiAatoeSU4WUEedsHgjv24HuVJr8k5pEMs5ZVS2B3ZpoflhIiwmt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Lf9dUvT3SRab7KtcmXVPB7MhfKO9fY1L2iTVGIs6Y=;
 b=jiWXWLOihtU7SCpFopOrJQG5H1YSsl4qSwXPcKfBtdskbxovc6nX8QJ+anzSiufCbmVhj4xWrWXr+2xoc5JfX/zhIEXQMPPnnkQ+c4zyv20JEsQC2L2uxL01oAWUqqvfjMRr4KtegS2JK94DYgJZhhuZL4eNP8KqaCdO6eL2UMs=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 08:22:53 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::ce) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.33 via Frontend Transport; Thu,
 12 Jun 2025 08:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 08:22:52 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 03:22:49 -0500
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"David Woodhouse" <dwmw@amazon.co.uk>, Kai-Heng Feng
	<kai.heng.feng@canonical.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Nikunj A Dadhania
	<nikunj@linux.vnet.ibm.com>, Santosh Shukla <santosh.shukla@amd.com>, Alexey
 Kardashevskiy <aik@amd.com>
Subject: [RFC PATCH] PCI: Add quirk to always map ivshmem as write-back
Date: Thu, 12 Jun 2025 18:22:33 +1000
Message-ID: <20250612082233.3008318-1-aik@amd.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: d0672236-b439-4197-cd84-08dda98a536e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PFhSPeyByGLjfHJsmnB3/me+Hm5Y+gm3w2FEB32aYh4QqPqWpLF4kMUhlW0Z?=
 =?us-ascii?Q?zXpbREOJzJ6r5ZZGuq31RcE0jLR/GlLoZhUOty4J2kL2KY0SuXJUJkvzrWa6?=
 =?us-ascii?Q?ZkCSEdXs1dkW/5QapEKEuifZpGW/ttR5h8cByuUSLzEghc7OcgQYtxdu5JpH?=
 =?us-ascii?Q?fGUPdTZB4asw3ZdjOy90ztXMpLSwDJVMoQVQCKMosXSzBbfsu2A37ApNK5cR?=
 =?us-ascii?Q?LIKCcDqd1OQEpzK6ERslVTMo2juBkrEoYeowJhT++mkuQfgKTdJbmBVq3857?=
 =?us-ascii?Q?OqAgeQ5/n3xGUAPtUibhNt+Om4BmI+cdTiJ5fynz6B7qWegt2sfJaqUEmxME?=
 =?us-ascii?Q?9h3ZbwWJVN+7hQz31Xb/y1jhjjJ51DEjKobmiiarhnTBresE93jH4SAkpMss?=
 =?us-ascii?Q?mt8lA5PjtSxcDcWfVeyzs4R36nFQcdb1t7tOl7SpgWZFkt6JMYmdik9PMGnv?=
 =?us-ascii?Q?eHtwaLj066id2053f7ba8uIjh2+tEbshuV98eo+hiW2vJscW+4xlT9t0MkIH?=
 =?us-ascii?Q?e/Higaj9ZeeOivEFLPVLlNWZFuezM1KkLAooOZADiKxXZjmLDOrqIK7Kq9Tp?=
 =?us-ascii?Q?j6E5XSpPHlafgdPKbUx6Q+Sy9FbM0QcfdMWjfGn3lvVA4obajjqQyAEscyMG?=
 =?us-ascii?Q?mslVPJFlAzsdekBWhlUmFLchJSdNnKBeQCGkW5csYZ1Kk4q5oO3DUO1rlPkY?=
 =?us-ascii?Q?nzETsnoRWSekIoUvoYTHOnR2X9lnoSJ7DJRUcz/Lk97UgqzcFfyzN4Mkh+su?=
 =?us-ascii?Q?Z6FbbHg1K5s1XgHE3doEJv9H4FW4pVY0w7bMg3EuAzGjIaFUPhCpI+XwBn+N?=
 =?us-ascii?Q?yy3WXD4UGE3aH0+ySkfwjTHTUstkBj1eGmFm99slumK1p4mFcitEV1Vd8+yl?=
 =?us-ascii?Q?dNnAdof8zKudV12npdz+ZbGObL4qpbCoz0WvEFxrwZTI4P++eHkzIgr+AUZx?=
 =?us-ascii?Q?2WA8UQnQsnBKQePU/eGoyRawwcy0mh6d1czOFrX+tIArWQ6Yko/N0cIr3Swn?=
 =?us-ascii?Q?xvRDX86JDCAUBSJYzgElotNj2lQzuufd2Iq7/rNFmgRM7+lyW+hZCtJUyTu7?=
 =?us-ascii?Q?qE4Wh6P6cM40RKzDIagkkyUhpPfASUgn4PQwruMMBuVQ7Wsb4pBHdVJMrWu8?=
 =?us-ascii?Q?eVU9tapckZw69Vyl1IFlLkih+mRRXFMIU209PC3h/gaj8miRyE6JNpLtdtM5?=
 =?us-ascii?Q?+SvrGTm/8SJi3k+Yd0uyDlGg7x7doVar97Sk5ivjKg2HXLADdQ6EivgJoOnq?=
 =?us-ascii?Q?3pHAOXA9dJslbXtJEYAGGckYvtm/rpKN8e8N19Usn/47BtoMjcyOaqJkbyHY?=
 =?us-ascii?Q?f+PlidHBKzGOQNLvDbH9pSIEuoRFLsbpza4zKT6mritCMVGzlkP767PuDwAi?=
 =?us-ascii?Q?pVekv6msG9GtCN79Rhl3rDW2Zed/aljebx2vF7KiUMAyYbmyMcJzI6ihz+UN?=
 =?us-ascii?Q?fuQGL0EYx5DOhCDh8usTQUDAsBIMK4nJ6dujEFQddgi9kmlzqtXfiRl8J80y?=
 =?us-ascii?Q?WTwcFY+tdZh1aNqiCzjADIzcSAmaE3MbcPd/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:22:52.5557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0672236-b439-4197-cd84-08dda98a536e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

QEMU Inter-VM Shared Memory (ivshmem) is designed to share a memory
region between guest and host. The host creates a file, passes it to QEMU
which it presents to the guest via PCI BAR#2. The guest userspace
can map /sys/bus/pci/devices/0000:01:02.3/resource2(_wc) to use the region
without having the guest driver for the device at all.

The problem with this, since it is a PCI resource, the PCI sysfs
reasonably enforces:
- no caching when mapped via "resourceN" (PTE::PCD on x86) or
- write-through when mapped via "resourceN_wc" (PTE::PWT on x86).

As the result, the host writes are seen by the guest immediately
(as the region is just a mapped file) but it takes quite some time for
the host to see non-cached guest writes.

Add a quirk to always map ivshmem's BAR2 as cacheable (==write-back) as
ivshmem is backed by RAM anyway.
(Re)use already defined but not used IORESOURCE_CACHEABLE flag.

This does not affect other ways of mapping a PCI BAR, a driver can use
memremap() for this functionality.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

What is this IORESOURCE_CACHEABLE for actually?

Anyway, the alternatives are:

1. add a new node in sysfs - "resourceN_wb" - for mapping as writeback
but this requires changing existing (and likely old) userspace tools;

2. fix the kernel to strictly follow /proc/mtrr (now it is rather
a recommendation) but Documentation/arch/x86/mtrr.rst says it is replaced
with PAT which does not seem to allow overriding caching for specific
devices (==MMIO ranges).

---
 drivers/pci/mmap.c   | 6 ++++++
 drivers/pci/quirks.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index 8da3347a95c4..8495bee08fae 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -35,6 +35,7 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 	if (write_combine)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	else
+	else if (!(pci_resource_flags(pdev, bar) & IORESOURCE_CACHEABLE))
 		vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
 
 	if (mmap_state == pci_mmap_io) {
@@ -46,6 +47,11 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 
 	vma->vm_ops = &pci_phys_vm_ops;
 
+	if (pci_resource_flags(pdev, bar) & IORESOURCE_CACHEABLE)
+		return remap_pfn_range_notrack(vma, vma->vm_start, vma->vm_pgoff,
+					       vma->vm_end - vma->vm_start,
+					       vma->vm_page_prot);
+
 	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 				  vma->vm_end - vma->vm_start,
 				  vma->vm_page_prot);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..858869ec6612 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6335,3 +6335,11 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+static void pci_ivshmem_writeback(struct pci_dev *dev)
+{
+	struct resource *r = &dev->resource[2];
+
+	r->flags |= IORESOURCE_CACHEABLE;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1110, pci_ivshmem_writeback);
-- 
2.49.0


