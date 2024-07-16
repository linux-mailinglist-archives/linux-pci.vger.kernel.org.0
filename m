Return-Path: <linux-pci+bounces-10400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 050EC93321E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BA81F27A5B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45E1A0727;
	Tue, 16 Jul 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="26Z25/1D"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D72B9B3;
	Tue, 16 Jul 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158502; cv=fail; b=r+hH8GmLrLCV5E10lDT3tSvvxcuuz2773qnGoQfMZyS6DzYbEfT9QAbOFzZ9bI1IbmbY26hsTZhJyDV38bnayV+FTz1S0wqzyEJPSGF9OBJiqujYNVjG1vK1n0d+RtoGQ9jLGTIOhlJlMAtANcF6i/p9E+dWBuZebLsRlaDqQiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158502; c=relaxed/simple;
	bh=UNh51fTagQPBPMjzwxxXB31v6QFA3mjHZcKCk35mya0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaKV/k9dK4zWMMA0LcZ9PFWfZjuVm8NiypGQycN3FTY0JKD0sRL3ADXwE9L4G9iLLSgdKdxxo99N5YRvzbIIlLhq5A3+YGxuEHDNy/vzT16RmRnr3CnKL+BFjqH4fFOkmR0WyTeUOLJ/sYv3fJHhTPRA/N/OWUcwCg1bnCoFN7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=26Z25/1D; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2xm91A5c0kSZXY+kWRSt+yeEkjuofC874ibpeA/zjZ0qSObsxz8ZkcwJXFHJWwBVIMhDucSkVa+Bxr+7nX2f1l3zyusoZZjuHomo4Y+noeuegrOXoB0rsp3tR3bZ3IwXP9gZsDtE4pPpNyVW68pQGrrEMrkF9EcD4zlw5hy9ykmytf/2rW56BENSq/8LMBESGSteXImkUodRB2farkY9NMKtnkN3Hb27lZ5pYhtkmhPegz8rVNChLIoSFO+la2olM0b+eJo26ecA1L/sRPm2rZvAPvG0IPfNjXS4EPlww2eDv3Mv/nZJsVosxISQgLOey50X+wL7eaoqup3nqQkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gRySur/qOxqgmNdT/AjUFNW1WnAl5ss/MaJuUSddcc=;
 b=Eco/7M0dw0yiFAEWgSSBSdspVHa8p8K/r2n8sLoBTuZe5Ft8c6UsA840ccWf1Trr1c6K7VxvFHZJfMw3FF0aiUvWdmWoirHlnqhX6K9EIYHXYgT5othoKQGQoLRXZIdmTpoOM1C+4GGgkaLcmktIMMvqFcCphXwJgdEscEPAFXzI6FV92Wu8moZ4Z7vonPRN3Yglmqq5ERFyEQt7zwbhzM90c/sEUfwfJszGHmdcnaiNrUdlVzXWLUz/CYmapSEZJZRSMk068H13fc10VV+Yt0yYY3hDgqaDqzcgMyFPeYlbd1Pl2EQU/9FDt1mvf01ZIh9roPR/AugeRdK87QzaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gRySur/qOxqgmNdT/AjUFNW1WnAl5ss/MaJuUSddcc=;
 b=26Z25/1DK/86oGHhhknveIF+nMjpN0ha0e5pQH8yZCAFXJ5YGA+9apQRObEJsyfskRZ/OoC9GhdQHGkZQX87tre0zZJus/mIE8qpQTBOrX7FSSUCwTUGiv3MqoMpDLodsbxDAw37tnjMB39yjF/k44sdsTupL0dUT8W6tUBVSOU=
Received: from DM6PR13CA0056.namprd13.prod.outlook.com (2603:10b6:5:134::33)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 19:34:58 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::3f) by DM6PR13CA0056.outlook.office365.com
 (2603:10b6:5:134::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 16 Jul 2024 19:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 19:34:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 14:34:56 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 14:34:56 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 8/8] PCI: Align small (<4k) BARs
Date: Tue, 16 Jul 2024 15:32:38 -0400
Message-ID: <20240716193246.1909697-9-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
References: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 4648baa0-0343-44f8-d382-08dca5ce6050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ky/8eSy5Fjvscm1KDV+QyQ52D/x0aB/Zy1bHABaUzya/Eksfwy7jMuYNs75d?=
 =?us-ascii?Q?u1rWp88tC/+EY6O/wrKgcHQ62iIcSO8i000CdhTKQxMEcNkDWghLCm6WaJsk?=
 =?us-ascii?Q?j+R36/8rYaGs3D7rrriKOdDU/YJbr3jKjTCXVet8jYZ3PH5jbTZYdz9ALTK2?=
 =?us-ascii?Q?VbH2Cx79vxluBQ74XIRMv0hWKjC5IWLwvaz2yzbicMwJKOFVCIurUH5yNY18?=
 =?us-ascii?Q?IqwA95Ut1uLoHK7ZyIHnlodnAMC4/i/oFiMeoaTrcjxzYWaxwVfnUuH4gQYd?=
 =?us-ascii?Q?AaLcsq/54qWz64M/YaoMOOR++aYEaDemHDB6fcFXIAIfgMGXQg/8WVy4WVTG?=
 =?us-ascii?Q?Utv/7DW/TxV4GfsaJIckF1I4/K+FWAD41gBwxh4l/VZQgPW9sI97vwpmX0Vj?=
 =?us-ascii?Q?/ivzXssrhnnulknuylBJQjO+gWCN3E3AdCc1OMn/ds9Rr15FOLMkx1wPSNG5?=
 =?us-ascii?Q?flYq8xGqF36G8Wq/4JkZiD0AXaFpOEeRRwfevNJq0vhVdXmZYu1AuwKTybA6?=
 =?us-ascii?Q?xRZryUn127DPLgtqQ0WME2wwlCLu/1DQeESdQu4S08lR9iV2E3IAj5JZUSMC?=
 =?us-ascii?Q?VKCGztmrBZL5zBCWvlMm8cxGtCjRJeE7Kf8AgVQmCTpiwyqZR9zap79uceSa?=
 =?us-ascii?Q?ceFwAKmDCoef1ZFjM8YMnCAB/PCYWm6RpBvmPKyAtTpXjz1j+VgGdMwtYGbA?=
 =?us-ascii?Q?nULkQRjMbRaf8JrmazquALRMdJmBlyOSToWVHn8xck/pQaQL1bNmbPSYRRE+?=
 =?us-ascii?Q?lHx6kXv2By7501u1PFVwalDwqnKvx4T8lhNw5F3X5hkjBJIkJt9GMWWeSG6W?=
 =?us-ascii?Q?DnuzwBGXD8nDUwvAG4ks0Ier0I6RM/ARkN9eBBGhfbaKZrKkGcQ5ySsd58Nz?=
 =?us-ascii?Q?Odo1aiIfqBQWmYzacpKljdFIUd64s0evro4CyAuHWIOXLaUfpZ2n9AmlscN8?=
 =?us-ascii?Q?a3lCVlsAVGJUOhCz9NKwAiqSkxDD0+vKGrxmnYoV6t2KaeiCdDBye0GDAvod?=
 =?us-ascii?Q?pwYehM6x11g7MGkrqYuNmF+lOQ6gx89lAcC1/C4vY5NLilKDOnjEutpgsxmC?=
 =?us-ascii?Q?ux1iQCNkCtkkwPbgVhrviox3Uv8e8NgANNfL8gPHxn/v+I+a7yiZoO+J3pu9?=
 =?us-ascii?Q?WQmA8iMaK4QMpmfBsbgSqnak+IkCCVJDNL08iJd9EAme55R89DzHVuLYe8Fg?=
 =?us-ascii?Q?BigTfpWvDHXccIFekPttDim2o9968ali2nvhyZiVaRTZ59xlT7FYj3c7Pz9r?=
 =?us-ascii?Q?TeRDiT/8mjlvfyALcc3do25o4pByeA8huCrygoMJoGC05ellrMKb+qNCxsSm?=
 =?us-ascii?Q?VEnw8sa21369AXnJsGAnTUibe9msyyaRhxhdZiAs9GlDrDWGz4FjzajEVwga?=
 =?us-ascii?Q?PShEiVaOe39FzQ8rK2gV5Ws8U+rIMhk9uLLvrVzTniR3Z59GBmkQsu1s7Cyv?=
 =?us-ascii?Q?yO0RRDF2BOnIMga4nWQWN3NyJn5jM0DF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:34:57.6273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4648baa0-0343-44f8-d382-08dca5ce6050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406

Issues observed when small (<4k) BARs are not 4k aligned are:

1. Devices to be passed through (to e.g. a Xen HVM guest) with small
(<4k) BARs require each memory BAR to be page aligned. Currently, the
only way to guarantee this alignment from a user perspective is to fake
the size of the BARs using the pci=resource_alignment= option. This is a
bad user experience, and faking the BAR size is not always desirable.
For example, pcitest is a tool that is useful for PCI passthrough
validation with Xen, but pcitest fails with a fake BAR size.

2. Devices with multiple small (<4k) BARs could have the MSI-X tables
located in one of its small (<4k) BARs. This may lead to the MSI-X
tables being mapped in the same 4k region as other data. The PCIe 6.1
specification (section 7.7.2 MSI-X Capability and Table Structure) says
we probably shouldn't do that.

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

   When the user has requested alignment for only some devices via
   the "pci=resource_alignment" argument, "resize" is true and we
   use the first method.  Otherwise we assume we're aligning all
   devices and we use the second.

Changing pcibios_default_alignment() results in the second method of
alignment with IORESOURCE_STARTALIGN.

The new default alignment may be overridden by arches by implementing
pcibios_default_alignment(), or by the user on a per-device basis with
the pci=resource_alignment= option (although this reverts to using
IORESOURCE_SIZEALIGN).

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
Preparatory patches in this series are prerequisites to this patch.

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
index 6df318beff37..6b85a204ec4e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -31,6 +31,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -6485,7 +6486,12 @@ struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
 
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
2.45.2


