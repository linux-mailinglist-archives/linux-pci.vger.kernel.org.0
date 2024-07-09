Return-Path: <linux-pci+bounces-9990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E345092BB79
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124A11C24129
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D531D2D057;
	Tue,  9 Jul 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0qRBHXuU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A1158DC3;
	Tue,  9 Jul 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532183; cv=fail; b=Z0+PUcSSYhRVFgaq/QSgb1SzuF72nGJXN3eCPnHIzgKDSi6UbEiRgVNTja1Qee7sDWJxOeUeFsBZRIMOXH3GsYDhWLsh6OA0Yk9ATt7mfQQY5pQBmgvCr6mo1Ay/BmlxBm7NU84dSZsCtefRogCkaCOtm6gQryLtM0B7aviDkEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532183; c=relaxed/simple;
	bh=L5SzMGkk5mzTzMYOdJSIUqfdc+mIepIm2om7yAphJgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLV3l8JYaCnk0jV9wdHAlegUAr6IXXbNWkzEm/I4ukdhg9CWsYwI/otOOgC2iMF6A0BGDnVKjSGJYEjhJVOwvpKp2x4gPoa2E+JKX+Omqd8djhuoZ3NoWlkC3lEmqSVrtpnFOqshpiUe8cshb468qLo9wLZ5keUW4yDLWRaKGXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0qRBHXuU; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsxYEzdZP2cvhAihc63IkclHnJ9IjRrliRDztxW7hkDTlDcK7JKLjTez1x1VMBKdAQlZka4rdlwds5Scte4/jIzN9MPy3/pHiKKQAmapqj923NQZuzEcp68JUjH68+koiUXLzWo5vqMcY0qEjraOdGOubqt3uGJVNK4un1vf2rV1Ip/kOsoZw3ULlqhY36SOD8ZVQErEf6fVKq3rTAAe5sVtFlkb+LqkOLWKxXBsypQukHIpLXVx0pRFxjA7xlTckNwwp969pMfpEXMpLGNsYCZgT3kLwe30q89bRms/UIhh/OVGvXsVPus42qLaFwrq3OcwV0YGzNn15ZDaZhzykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mmmhm2bIcYHyBnx+XtEQZti4mj2qsEkYghn8AWrBE9E=;
 b=BuSN0aGyHq+55tIA0SBY+MJxV5cLxAW5PbkhCv1x7GbYrEcoHGhABbN3eAUDlQQx3+bdFwFmZh+oRKa01tnRl6sdvUDuu48IXkvFU0yl/fQpOpfe9wJj1Xi87mwR9QvhipaTNbDFh8cRp7LoFBI3Xd5NZ8DBDQ0UkaXsxQoa4SryeYfKY1FFFIGHoLt2mGzElhTLRTichHcfxo8JAOo07SwtK4pxaPuxFmeRLbZ9b1iY9EucqETnoxNAt1hzxAC8wl3TnLGR0zxabFrlil02t5CsesRrrmWLnZVWZmpEMbMJcLviBZ8W/K0NKX5MZnUWLgd4maePnhyRVPQb4+cWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmmhm2bIcYHyBnx+XtEQZti4mj2qsEkYghn8AWrBE9E=;
 b=0qRBHXuU5zcMklEjFYeoCZciSZ6y9beMPCyjpXWr+R8Pwt72vKF4HOgpWOBc0XHeTNE3gAv9j7SFrOcyOlZBHt/T6hpAp1l1Y4mEZPog+kE1brd0/U5EQJejmVso+tMLRifQgHMFbc9TrzyFG6g56FKIG6q6vqjrwaWaS0xMsII=
Received: from DS7PR03CA0227.namprd03.prod.outlook.com (2603:10b6:5:3ba::22)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:36:15 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::b6) by DS7PR03CA0227.outlook.office365.com
 (2603:10b6:5:3ba::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 13:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 13:36:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:14 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 08:36:13 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>, <x86@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] PCI: align small (<4k) BARs
Date: Tue, 9 Jul 2024 09:35:57 -0400
Message-ID: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: c366d33e-ab09-4827-4e8b-08dca01c1b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?12szkutEmxUW5Q17psesWALHt/B21VWTITxWkvJI8n9ZeQXJAG59ffJD6jDx?=
 =?us-ascii?Q?cZFilk8EDf33arJ1DKS4DTztsQv2Zpvx5/eWSnhTHXzRVMgtuOLyDKNuUuKf?=
 =?us-ascii?Q?pi3JRiD/vxhOF+vjti1i9othANZE0vrGaqYPDi4fUgog71aZmzYmwqnbyzvn?=
 =?us-ascii?Q?NCE0XF0K6VDib1f8lUIjdkrtNk3NZnnb01DzH7xRagNQ1QDDPppu/jMvnBt3?=
 =?us-ascii?Q?HUklb0TZcAxRt88ydJdcyifLsrSZAD1aFV1d2GFs/PpA8LgxxxngrI5UHz0d?=
 =?us-ascii?Q?BOkHD7ZYLdyA3ntn+YoLXpGOmLHyOYgXJDfhiJTmtfQpbDDKybTFLjzgi8Hk?=
 =?us-ascii?Q?PKk2EZmTox0UfJpyj014uOWvNo941rYsCutTgYdwQ/wT6NXguL8H7FXSXfcH?=
 =?us-ascii?Q?wQPZxic0a7N4IR2OnwsoKXfFjPlVwMHkCjsNUVX4vj8Bb/MNB5VDFtJrdtw7?=
 =?us-ascii?Q?2g8wCvwQobA+E2YHqANyPDOtBV2SEZapgdUrb9+let+Msm9yzsu/wOoMIqj1?=
 =?us-ascii?Q?GriE1zgzUkwAEJi//0s4RUFbmJ0sAmSa3FuSBcHDtdW6ObEy7KFf4IHKF1tq?=
 =?us-ascii?Q?H9LMHUK8pgWQ4mkTRhhDnFiDMEckj/6T/YvAt6lV0yGxldiE/DqSZ6wN/mFz?=
 =?us-ascii?Q?V2rcqRVFkzdydNzIzkp2NZjjLAIKLgHTfxo9YTxDwMmMZ50Aao/VUBXW5Yu3?=
 =?us-ascii?Q?oMMlOpzFmR9BPnm68DEpbE9TT92/HzLq6pvan8ef9ECK8PPfcndxqQx0PvFm?=
 =?us-ascii?Q?kAw6peaACp9HQ06QGYsLlDR745/8SSz+lSzj5/EeJAR9j7TNvn3rYg47cYP9?=
 =?us-ascii?Q?yFfaYmHk/P04dsQwgG63QrnpimzUe8UN5e711DZipT5Xj6awbVp+U/fxwu/W?=
 =?us-ascii?Q?HeIStIXrNGfZ8PN1UlGFb2eDn9d9Fniqd7FdwhqNJkb3WO1J9vPge8jn+J3t?=
 =?us-ascii?Q?TPAxXp/ki0DLN065v5KJeZ6In5ZqyF2SEl/Y6Zdggcwn5s0r6Arja4kB+m9z?=
 =?us-ascii?Q?I6VLzqzX+sovy7JBSwY9c/eP+T2GrQeJ5L1LNDcYf4GS6sGlEni+Pok9pg7z?=
 =?us-ascii?Q?SWleHunny4QFCnIc5nWJOEl2zVNgcwjYblVA8u21Lvk/ZBubZ31KAWe+uMTw?=
 =?us-ascii?Q?+qCqyi2w46jSavwVqphSFA4UimPjCcOkH8uz/XfTlImoJo7z4W49ARi7ljYF?=
 =?us-ascii?Q?6NIO27kvFao/WI9xWGjg0YVONDZH41Oda6fwwmYoGc/SAmIe6MKvzheqvu/2?=
 =?us-ascii?Q?E9FC4ity1nmu4QVvecsONZI1817Ulcmki4//xq6OXwKxE4ekNXboL2gPNyEl?=
 =?us-ascii?Q?eMMxOxQU04QRe7HAwhZdiKoSatZzjwpoysb95iuwDmmMGvbC805grTWtGaQR?=
 =?us-ascii?Q?3rwcyr/+aMNjOdIY8KRTLJ46gYDf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:36:15.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c366d33e-ab09-4827-4e8b-08dca01c1b02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475

This series sets the default minimum resource alignment to 4k for memory
BARs. In preparation, it makes an optimization and addresses some corner
cases observed when reallocating BARs. I consider the prepapatory
patches to be prerequisites to changing the default BAR size.

Issues observed when small (<4k) BARs are not 4k aligned are:

1. Devices to be passed through (to e.g. a Xen HVM guest) with small
(<4k) BARs require each memory BAR to be page aligned. Currently, the
only way to guarantee this alignment from a user perspective is to fake
the size of the BARs using the pci=resource_alignment= option. This is a
bad user experience, and faking the BAR size is not always desirable.
See the comment in drivers/pci/pci.c:pci_request_resource_alignment()
for further discussion.

Anecdotally, we're using pcitest for PCI passthrough validation with
Xen, and pcitest fails with a fake BAR size.

2. Devices with multiple small (<4k) BARs could have the MSI-X tables
located in one of its small (<4k) BARs. This may lead to the MSI-X
tables being mapped in the same 4k region as other data. The PCIe 6.1
specification (section 7.7.2 MSI-X Capability and Table Structure) says
we probably shouldn't do that.

To improve the user experience, and increase conformance to PCIe spec,
set the default minimum resource alignment of memory BARs to 4k. Choose
4k (rather than PAGE_SIZE) for the alignment value in the common code,
since that is the value called out in the PCIe 6.1 spec, section 7.7.2.
The new default alignment may be overridden by arches by implementing
pcibios_default_alignment(), or by the user with the
pci=resource_alignment= option.

I considered introducing checks for the specific scenarios described,
but chose not to pursue this. A check such as "if (xen_domain())" may be
pretty simple, but that doesn't account for other hypervisors. If other
hypervisors are to be considered, or if we try to dynamically reallocate
BARs for devices being marked for passthrough, such a check may quickly
grow unwieldy. Further, checking for the MSI-X tables residing in a
small (<4k) BAR is unlikely to be a one-liner. Making 4k alignment the
default seems more robust.

I considered alternatively adding new functionality to the
pci=resource_alignment= option, but that approach was already attempted
and decided against [1].

[1] https://lore.kernel.org/linux-pci/1473757234-5284-4-git-send-email-xyjxie@linux.vnet.ibm.com/

Comment from pci_request_resource_alignment() pasted here for reference:

    /*
     * Increase the alignment of the resource.  There are two ways we
     * can do this:
     *
     * 1) Increase the size of the resource.  BARs are aligned on their
     *    size, so when we reallocate space for this resource, we'll
     *    allocate it with the larger alignment.  This also prevents
     *    assignment of any other BARs inside the alignment region, so
     *    if we're requesting page alignment, this means no other BARs
     *    will share the page.
     *
     *    The disadvantage is that this makes the resource larger than
     *    the hardware BAR, which may break drivers that compute things
     *    based on the resource size, e.g., to find registers at a
     *    fixed offset before the end of the BAR.
     *
     * 2) Retain the resource size, but use IORESOURCE_STARTALIGN and
     *    set r->start to the desired alignment.  By itself this
     *    doesn't prevent other BARs being put inside the alignment
     *    region, but if we realign *every* resource of every device in
     *    the system, none of them will share an alignment region.
     *
     * When the user has requested alignment for only some devices via
     * the "pci=resource_alignment" argument, "resize" is true and we
     * use the first method.  Otherwise we assume we're aligning all
     * devices and we use the second.
     */

Stewart Hildebrand (6):
  PCI: don't clear already cleared bit
  PCI: restore resource alignment
  PCI: restore memory decoding after reallocation
  x86: PCI: preserve IORESOURCE_STARTALIGN alignment
  PCI: don't reassign resources that are already aligned
  PCI: align small (<4k) BARs

 arch/x86/pci/i386.c     |  7 +++++--
 drivers/pci/pci.c       | 17 +++++++++++++---
 drivers/pci/setup-bus.c | 44 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 4 files changed, 65 insertions(+), 5 deletions(-)

-- 
2.45.2


