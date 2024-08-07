Return-Path: <linux-pci+bounces-11446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E24694ACCB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72142B22AD1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3884B7F7F5;
	Wed,  7 Aug 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QubD58VG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC679949;
	Wed,  7 Aug 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043909; cv=fail; b=evZP8KJ9vfeDOZe8NmxugLyS1YaMZNjORWE/UeSE/aznfLON1e5V7ekg+ntasteO/JeZEn8/PBkMAFDt7ScYQ2xIZv6lDFTpMa7dvDZBj0n8jFsolRMq306nErZLEUROV8EKxDYlMo+IJ1FqGN0ZQ8SkV5RxZuxA/PPwTY2NmTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043909; c=relaxed/simple;
	bh=dm4vU9LmxJor9k+TGamv2Yo6oPTG7aVdDB3Sabd7v3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pG7VthKFyqj5KwlSBOGWxbuaD70KHijjw2i7Wt7OHCn/BkYiWzua4vPthWu0QmGrKk2v+ONwaJ5wl4lRaw3qirUQ0j+T8DbRPUnyHN4HCUPmAHk4GQwDb//OFjEc6jjADhlwqISwf2aHAh2TifEdXGinKqnnVcwW9UJsqq4LpWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QubD58VG; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uASGWldfckLdp2Xkvl2GgXWmeH0xTG/8OvkYgW2Tijj0pD3GOBVZqzo3E9K8dApPoA1Y+Ac6smfmKMgwB88VYL2wsMhL5PRgo8Ydsw99Fui4ox6sOPB5OGrhbFkHWV4F9XQVEuMI3jF+SZj1iEeW6cTQ2vHCEOkFmO1auTfXRyBf5g4qjEVCkn8oS2/0Ft9ZQiR+rDT75cqgqU5OeNk3CKC2SEiaTjHm65vDTcc0P1nJBZ1ZryIqPphWlpbRVlltqee4yj8S69E4xC48w0RWAPu6atCakyc7ikken8nijB+/ndss0MIV9SjD4ByTZ2fFVzumhiIHq3rMfjAKz/2eEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFwnRwtCAegQbxdYZ9WG0kvFW7XZdhwDbKqmw1mh588=;
 b=v3n5YaQv9kgr5uUp/c6jTeZ2Qt3TVh2jd39tj6ycxRLbaqna6q6+/Mm8K0ku87IIY98wOM7t5VTWCpV7iouZS0K4rjryeN5Q5KFn4nxOsEv/yIKIGSyJahW7E6tzn+XWg/DmOAix2hoW07Nvkcb18bCefsoblCD0MRoPtVojUZc7y0F8GxiXMUlG20C+FGCeFkXebqE4z7zFx7dOuhiI+OVB07umpB58mYP6T6Yl0XnBasHoOxGk1YrrOZo5iwi0ai6qjo9X9O7Bb8tvG8TV/Y4u2TRvUKXa6A/USBESa6lnqCJsrSqsmxmJSDRQM+2a7FDjLyJoNtgXXXg/SAnABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFwnRwtCAegQbxdYZ9WG0kvFW7XZdhwDbKqmw1mh588=;
 b=QubD58VGpmtaMHcNFVBXHFm4uS45F6PbmcA+61/1io3iXPECG1QHpnHiz/TJ4tq8d5jWTLkCXKFObPvuE3mvtQcFpdn5Nu2GU8H76f6unHYULHzWeN3YvyWysJqiqdHVuqLTzPl0vyRvMlKFaC3wb/Y0H+y/k+IDZfnw0I7bwSA=
Received: from DM6PR07CA0126.namprd07.prod.outlook.com (2603:10b6:5:330::9) by
 IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.12; Wed, 7 Aug 2024 15:18:22 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::ad) by DM6PR07CA0126.outlook.office365.com
 (2603:10b6:5:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Wed, 7 Aug 2024 15:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 15:18:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:18:21 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 10:18:20 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 8/8] PCI: Align small BARs
Date: Wed, 7 Aug 2024 11:17:17 -0400
Message-ID: <20240807151723.613742-9-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807151723.613742-1-stewart.hildebrand@amd.com>
References: <20240807151723.613742-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9e4a61-4369-46eb-1628-08dcb6f42d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6D66cjtFM25064WASyk9G3DAy78Qz0DlmgQcK7HCNVUajBpwTAfqTMhJXQIx?=
 =?us-ascii?Q?2wUSvhu3jh2RSuH8iytreuOO5KdQZPrnZvReRmWtv7MB79X46thbvDkvucmS?=
 =?us-ascii?Q?yqHnhPET1muCdADMSFtF+QuDh3HLIyHy3+QiDtm2PJs0xtiqM9yULexSOQOI?=
 =?us-ascii?Q?37To+0rvjQBGJMkXOYcIpLNikcQ7XYgEIWgEYuCl8sx7WT9Uv+f4aeRgk3/X?=
 =?us-ascii?Q?v+O9KnKRPHTrW/qpAgjHmie00uVXdx0qJHgLiGBk53rw7+psmdiQ56KM5Q4c?=
 =?us-ascii?Q?rdjPOKHFaFhfCZ0LXPMrUHLXaRD96fIMbvZknDnQ3nAzODR+2ikPUWdVwUkB?=
 =?us-ascii?Q?xSrn2FFhztZoms5uCXJTqRFE7GwG2Jz8QaBevdGu4uYGVh9MRmRJV/DzPRB7?=
 =?us-ascii?Q?tyVhghwwm7OpmlZV5huw5//pTlYQUdFtSI/jzSLMJrTx3w4ABF41vJnCClm1?=
 =?us-ascii?Q?589484ahd25bJXUWWOaOgKZIgtmE0Eap4HUyh79gH87JtAyqWVgncqFYYLNc?=
 =?us-ascii?Q?logWi3SSBlysqjtVI9TEGYTWtjTRzv5v5C3QdJtAlp3keKp6KhKNPn8+jvFo?=
 =?us-ascii?Q?yuNrsb8VGw3NEvkIyFrvdZYUFfjBaYPVL6+malME9GXbYUucHyp1MsneAaj7?=
 =?us-ascii?Q?qsFWvER1o0AFAq5QECm5g9p9w9Qn28To6WivKI71IVMBl++gyXDSI3PdiZ76?=
 =?us-ascii?Q?mz3hu0KjRDS11J/zGDx1TN6vOJ+6037ViaH+sFcjLTjJATwts/qVn5IVEWSq?=
 =?us-ascii?Q?7DPrpM59ODF5BM+nFSPrt/Mrq8Pm+96RdBZD/S/nzItqYNI0lCMpLp3hX6p0?=
 =?us-ascii?Q?fMA4t4TJwNUbsniOIjX/kpqnLrZw7jtmhporc+Oj/n+KIp0Tpq+J9aaMyAfi?=
 =?us-ascii?Q?a+jMRWUfLVql7NXGOAohGtBcPTa5lPzIknREMJkCvRjkuzc63KXCBjZu3u/Z?=
 =?us-ascii?Q?TvR759QTUum0Cp8cPcCQsPjYTVmBFQl7etP+eYhYK+SNsdQRl8A3Vy885j/q?=
 =?us-ascii?Q?c4Dh6Flvi5B/0LBHyDles7eKTLdm6zGI1vUyyu+6sJHK5NFTea7ZDVplRioq?=
 =?us-ascii?Q?+wXHEErFCKdeMVF4k55cNfGu5tf8z5nUtXs7bSr4M3IKqLUrcAHFTTFJmNf2?=
 =?us-ascii?Q?vNLuGlU0bvEYOKY3U5dBRnrvGbFftt0dMSZQ+w3TYOJD1ts1+DGhtOXVI5H9?=
 =?us-ascii?Q?NrMyR0e7ywgaaDMdxfLQXWobN+I0o8eSHHyRCUyYLwIBOOPQjMH5+/rip3xt?=
 =?us-ascii?Q?2BKVt0VU7FnTE9erUpZDF8YCvK4h0AaG62wRSvbSH3UF7JVFN4qbcvq1opmQ?=
 =?us-ascii?Q?oXU9l3eCmaTVkqQEZuj7YKB9VyF7uzZPWMdcOcVUn9TEZBy8kZfdya/26VRX?=
 =?us-ascii?Q?yDN4IH8pMkU8oRgaNFPa0reKMFZZiW4YsxgI55UbZZJLr55tgKn/H0z1IPwy?=
 =?us-ascii?Q?/cPGEOyRGN+A1j6F1+2XUTaLUUYXLKoG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:18:22.2519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9e4a61-4369-46eb-1628-08dcb6f42d09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

In this context, "small" is defined as less than max(SZ_4K, PAGE_SIZE).

Issues observed when small BARs are not sufficiently aligned are:

1. Devices to be passed through (to e.g. a Xen HVM guest) with small
BARs require each memory BAR to be page aligned. Currently, the only way
to guarantee this alignment from a user perspective is to fake the size
of the BARs using the pci=resource_alignment= option. This is a bad user
experience, and faking the BAR size is not always desirable. For
example, pcitest is a tool that is useful for PCI passthrough validation
with Xen, but pcitest fails with a fake BAR size.

2. Devices with multiple small BARs could have the MSI-X tables located
in one of its small BARs. This may lead to the MSI-X tables being mapped
in the same 4k region as other data. The PCIe 6.1 specification (section
7.7.2 MSI-X Capability and Table Structure) says we probably should
avoid that.

To improve the user experience (i.e. don't require the user to specify
pci=resource_alignment=), and increase conformance to PCIe spec, set the
default minimum resource alignment of memory BARs to the greater of 4k
or PAGE_SIZE.

Quoting the comment in
drivers/pci/pci.c:pci_request_resource_alignment(), there are two ways
we can increase the resource alignment:

1) Increase the size of the resource.  BARs are aligned on their
   size, so when we reallocate space for this resource, we'll
   allocate it with the larger alignment.  This also prevents
   assignment of any other BARs inside the alignment region, so
   if we're requesting page alignment, this means no other BARs
   will share the page.

   The disadvantage is that this makes the resource larger than
   the hardware BAR, which may break drivers that compute things
   based on the resource size, e.g., to find registers at a
   fixed offset before the end of the BAR.

2) Retain the resource size, but use IORESOURCE_STARTALIGN and
   set r->start to the desired alignment.  By itself this
   doesn't prevent other BARs being put inside the alignment
   region, but if we realign *every* resource of every device in
   the system, none of them will share an alignment region.

Changing pcibios_default_alignment() results in the second method of
alignment with IORESOURCE_STARTALIGN.

The new default alignment may be overridden by arches by implementing
pcibios_default_alignment(), or by the user on a per-device basis with
the pci=resource_alignment= option (although this reverts to using
IORESOURCE_SIZEALIGN).

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
Preparatory patches in this series are prerequisites to this patch.

v2->v3:
* new subject (was: "PCI: Align small (<4k) BARs")
* clarify 4k vs PAGE_SIZE in commit message

v1->v2:
* capitalize subject text
* s/4 * 1024/SZ_4K/
* #include <linux/sizes.h>
* update commit message
* use max(SZ_4K, PAGE_SIZE) for alignment value
---
 drivers/pci/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af34407f2fb9..efdd5b85ea8c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -31,6 +31,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -6484,7 +6485,12 @@ struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
 
 resource_size_t __weak pcibios_default_alignment(void)
 {
-	return 0;
+	/*
+	 * Avoid MSI-X tables being mapped in the same 4k region as other data
+	 * according to PCIe 6.1 specification section 7.7.2 MSI-X Capability
+	 * and Table Structure.
+	 */
+	return max(SZ_4K, PAGE_SIZE);
 }
 
 /*
-- 
2.46.0


