Return-Path: <linux-pci+bounces-29256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A4AD25F3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 20:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927A13A1B17
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6480A21CC7F;
	Mon,  9 Jun 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iaws1fOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9701B4121;
	Mon,  9 Jun 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494744; cv=fail; b=jM1hdkanYzPs7KjbUFVi19/P+O9f9U0aUFG5D1xI9Yhb2pHTUlSFcYYD3Z7bWhqXeF4kbqETRxk5XwGem6Bgcumi8BPahvsx9irQscgwe/jylaL9Jk5uAt0t9hfYuv23cMOfr5/uRBj/Uogj+4fycOK5kFUwSlQTWO9GxaZFRTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494744; c=relaxed/simple;
	bh=qIdMBL36w5V9l0tM5hdYU5Uf/4ZDE9FzzAsLBAoYD6s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjBVlLz7TL4JO1SqBaQLKVCbDGdTtvkVuzp4Dgy/5EPY+E2dXL21fhIM+Gpcwh8kffCt2WHJwrtdE0Cxp/hcWnN+mx2DJgeH8Vglv4mERa69le2++q64DPKwnGcEDvVEwq44NWiVdyT5HMn+m8ls4zASFfdLNnik0lCSo43AkZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iaws1fOk; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbYu/hsh0z80cpFzFuZzwCB8GFaRyy6Lw5bNFpBuXRgPNZcSP4RgX2ib9PxvKi7vG7YYW9roVSnsHoJksy26AZmi6IkhioeqnZE443S4wXLg3WWmm125JQeuG6brxj5Cwn09oRm91H9pZMHnkL4gxdKY74L86Fjn7u83x4TuF4+/UYIWy9R7lo9Edq/zL1nxuE5kOu6jDn1M/enTNl6NaoLP6zh/U2LuMnsBZrzf7+Ne8fmUgOMKy2Dx+d0Bw2/VCQO/AkQcaJORF7RNKqhz0mGs2Cr+A+Oq09a+IfT5iricP3d/L/Tyo8/nmj+MCdnvURf2fyytf3GfWNha5M268A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zGIBT9e6R4IfQzBODrFIRQJZDsNH1UzbyJhEZysgqw=;
 b=XHLli2aVwFNcOp2NdVKPCGDwV87noQpNBr2Qoyw1B84XyiWRQRJjKQldrw4o21A033xXwOPSyD0aWOW9TBDoRt8eYSapnuypqCtsCY1sJPCcgwfELXdCWOwFTDwoHUgIi0WLJGX4RlCR4N6byLqs6vc8NiqgpHkmx/ura4Q8TQVUEM9DLFR0b3wCqgPa9cuqPtHk64J7SQEEVSLyAJGOnhEBcaT/3gQgVz5MSFgLs4GMLg6Va1r3xQaauRoIRtd4CUPYpfHainGofa6LD21dSR5qkZGY4wdNANevqwdCtcfH9Pi6k52kP1GsMFEaDatvVlYD0AtVf5CG6sAhyUDBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zGIBT9e6R4IfQzBODrFIRQJZDsNH1UzbyJhEZysgqw=;
 b=Iaws1fOkJDNTEbutEKHu3IFb81nzf5WGf4XpFVk0z0hleV+4xtxTYnJTY7zNTUmVHAxZ0vSOwjGjXcoq5vN0mC8i7Wrs9WZg56aYqtsyVrJkLF0g3bTP33zBjTfrbySdxPFifr0UrEAtBtrLRA/E0009aCeD9Xx/uV27F5kZGkWV76QmwGa9cvSdcADSH+ZedwmUAc1r7u1DM/BYzkv29a+7bno/SK2H0xjorFec4t38X/778vaecZ1hef9R3+l71QZA11GGaTqEhZ88Qw/oNFc54xL/nezF4n+0wCp2X6ZLif7wmmKIK8fHLtt5ncFvh4SlSRNjz59PnHoR06uvYw==
Received: from BN8PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:d4::35)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.35; Mon, 9 Jun 2025 18:45:38 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::dc) by BN8PR04CA0061.outlook.office365.com
 (2603:10b6:408:d4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 18:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 18:45:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 11:45:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 9 Jun 2025 11:45:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 11:45:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>
Subject: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
Date: Mon, 9 Jun 2025 11:45:12 -0700
Message-ID: <cover.1749494161.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 1711d5f0-fa13-4d70-24f5-08dda785d420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K5AnE/XwTMLGV1C6gQxKkE2U0b3ZmxgRImhj0aNmoSMBWJTwClmD2zW8ZthS?=
 =?us-ascii?Q?4UHJ9S5E1LmzYgqB8s36FrcfxaIuIVViKqbKMeIVjLnzif5HlgsSXue+2LgJ?=
 =?us-ascii?Q?9i+1zpXS/tm1aDzjuu+Cq6gpURUUEjd4FYwivThZfOxUACgtnN66K+G+Nhh4?=
 =?us-ascii?Q?0lxiWHP/LNTSgXmPL3OAPM71XhFEVxCwT4BDuA8kNpuSy/6VU37uKTvocLw0?=
 =?us-ascii?Q?Jn3Wg7xKbV+2e2ohikIQCxz085amLODBunjSihWJWixMYciTG6L+gO2xxhUs?=
 =?us-ascii?Q?Fp08AVHCCbSTLeyG5v6//4+gOrfYfT8tccfL9ZLWaSas2lD43fSpsTgr/uxF?=
 =?us-ascii?Q?gl6+uHdI6yXBw9JxCi7pYx+CNueO2qhtfcV3w0A3lepCj+9Kvq0l6kVqTuVt?=
 =?us-ascii?Q?MDpMY5wJ0V31u+GDJZJGkzufdC6/bpsZ9ztI9Ft8q/gNgHuwvS7A+qw1ZIbl?=
 =?us-ascii?Q?MqFLAr1IunQ5l6GVX2M+t5MOEMnciBX7Z7I9YVz45l20+Dgk7CtxZQNVkHqk?=
 =?us-ascii?Q?0vLFSWtC3MJUzTW+QWBbnhq6YY5MfxZFZ1hR/CKSbRiiEpfJ1X6H1cYS23Gj?=
 =?us-ascii?Q?vqQiQqb+KOXpA98wbLsDKbYtDAHtzh+RqHDrxlwJmAmIdLaXlVCKcyOMRgQK?=
 =?us-ascii?Q?1H0ugOnwuD3iaTyVMTNpTPhVK0pv5DVe+M9Tx5lPhUY0Hz3/N+LbGIsKBRMZ?=
 =?us-ascii?Q?GDVebRgzqrMSDCP1OdiXofJ7/9IRHI9BLQbNLPIYEgWqRwjAtohyntZePlrZ?=
 =?us-ascii?Q?7YacwE8S03FenJnZzuFiQuwaoLiZAwpS4rlICh1ihQmzi9hL74kOUcxRSe7t?=
 =?us-ascii?Q?7nCipUU1ggUXXoXT6nIwzG7DKudqpcmcKXS9nh8hqCcyYDxphZrRkdJ8my9g?=
 =?us-ascii?Q?SBX3LyH6Jp4faimSEMDGJ80KSTqIbOH1bC68U8hckPXZAawdbG+dBeN4ixd4?=
 =?us-ascii?Q?I2zjQGkFx3rJt1kIE0URhYyVIuUBSLmKyIU3E1jOlpFEA6E5P0BJ9u1rjdJ1?=
 =?us-ascii?Q?WOVRnsMVSi8btnkY+g9A4B869CG4nHfnJ7XKoK+YODXf2KMNszg79BaqbiPf?=
 =?us-ascii?Q?dIPv5i/JOf3DoOeOGikx4jDiv2ca/9tEFp+xilfUHyuZRs0eHfoG3NXCk6Zr?=
 =?us-ascii?Q?5x6wDPFLCEDLt+tpYao4obgq/j7zS5ZFiMRM3VjFIEeAc84ik9siNZoKNoQh?=
 =?us-ascii?Q?Q79SNS39O9yVr1ZXCLB2l0NA84O1Kh0qgNeo3gST+w8DE56/5V9bX1a+y3PW?=
 =?us-ascii?Q?heDNjJ6v4qTXxWRkNyl3rfDpqAtb6f2cnYkwxD1h38woblHmV/rRlYz/W636?=
 =?us-ascii?Q?pkNj5yjw5tCHGZXh//ggdcFL1WMzKLWL+jc8X28s25lES8D1+pCoY5LvxAwg?=
 =?us-ascii?Q?N1yoQ5Vnol4Ev152EuRbdzmTkrIcQkU8Wsr/CGCt3kDsEIhm4cbLN0NrOeF4?=
 =?us-ascii?Q?arF2rEdKzx2b7jkyZC74naxBR9MeYwGMmMM9SJ+sEr7y5ljJtxMO5GhCZtvL?=
 =?us-ascii?Q?o4WTW4k1DVPmi8m0MJ+5F+ZmduPP+Vbn2T/PmlshLOUj8yC2gua7NhgA4g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 18:45:38.5928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1711d5f0-fa13-4d70-24f5-08dda785d420
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251

Hi all,

Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
before initiating a Function Level Reset, and then ensure no invalidation
requests being issued to a device when its ATS capability is disabled.

Both pci_enable_ats() and pci_disable_ats() are called by an IOMMU driver,
but an unsolicited FLR can happen at any time in the PCI layer. This might
result in a race between them, breaking the rules given by the PCIe Spec.

Therefore, there needs to be a sync between IOMMU and PCI subsystems, to
ensure that ATS will be disabled and never gets re-enabled until the FLR
finishes. Add a pair of new IOMMU helpers for PCI reset functions to call
before and after the reset routines. These two helpers will temporally
attach the device's RID/PASID to IOMMU_DOMAIN_BLOCKED, which should allow
its IOMMU driver to pause any DMA traffic and disable ATS feature until
the FLR is done.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommu_dev_reset-rfcv1

Thanks
Nicolin

Nicolin Chen (2):
  iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
  pci: Suspend ATS before doing FLR

 include/linux/iommu.h |  12 +++++
 drivers/iommu/iommu.c | 106 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c     |  42 +++++++++++++++--
 3 files changed, 156 insertions(+), 4 deletions(-)

-- 
2.43.0


