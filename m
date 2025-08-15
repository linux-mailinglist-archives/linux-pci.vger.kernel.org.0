Return-Path: <linux-pci+bounces-34119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9B9B286F6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 22:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79905189749E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 20:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0242853EB;
	Fri, 15 Aug 2025 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NSGdT2zE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33E22F76B;
	Fri, 15 Aug 2025 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288675; cv=fail; b=tLx02FGb7IEGFLq8CXk8gu64C0loJemuC2dBYERgBUkVaI1b0ikzDWOMijKnmAuOAm5fJ1rjbtXdRNynArtg/Ws5WrwufwinXtGlfU1cgi0DRwXQDv7JAqnb9Q5SSy4CWZmc8Jg5ykDJm+lvRurwPURyrS0D2pf3/d0O/4VpxJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288675; c=relaxed/simple;
	bh=28XFFpZlCL4cQ8QPX20dGjMYfkMJsTHfSYOMhYoKbZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swzdGnJEA3ahHVP91/rlfd2AbC/cnq9NrDdRMI/1MqSkv8fSDFJRnhuftOKx3dSTRQoa5zuDP4VoL5h6tDCseC/RGLD7rhQoGR3PDRijy3EhLe8vkyuRmwElcnaX2fecCVuqd1DFffGzoVbIVcSkCY+kSEKU99AXEltTxhfZYSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NSGdT2zE; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfB2ar7BT64zrx4ZDh7NF0gKbSnP7w6Y7Q37N8vYUghX33HriiTcS2cZmhIobkHPjxp3LZGAq+mIRLiE5fWJn8uDTENFKPy703eZNFKkbcnRO8j1FewHfMyEGW1XtnGtwtl/uzUWbBZ+VDf4qyGCoYxZS2eqm5ajYnmjYNuTYz3iLD2JcKUa0rlGZg15R/ngkSHeKCoOnFFJ8hXJ6CvC3gZcQobIrdg31cY5+IBGJdj+O9SEF80wpdIgXfKgW1ajUWgPWv65CVrOZtjg3uWs8GFhb8KYQzqIXZzSrK3etKwJhAn4DdCyfRkDQy/vU5tX0crpFnk5l38MIusAtla7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCZ10LUq/xmePyo4N0fFtlc2bfmN0gWBMQQoRaiZMYk=;
 b=vBe7JIOw488MD29IMjWj5toqhyt4z8QjM192sMv8Ddk70WxbnWE5APPD4Gk8oPvG6c8B9w4ih1oWzyQltqV5kYlcM3MzQxzQWX58AkbxYqHc0P+kMUy+Sz2BTGRkh8UVIbwBsfIlwCb8ZKUxxdLf9LcFCjxbMsFEKWF6tUve0Pe87oMm5qmxpw0YaK4Qz1A5GW8EjVVCajs1HkOSFPYTfQlN2vGCL2UbqU6PTHqxqzbZ+kx/dT/YlB3/D4Ql4qev1bT0OXl8I/NCaV0pLfCcn+fhXl5d3OpcbEetFoOIbTj7hTHM37ZSKjuNL+cJnExDvVhy5lV7E/JQ8s8jTDIbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCZ10LUq/xmePyo4N0fFtlc2bfmN0gWBMQQoRaiZMYk=;
 b=NSGdT2zEkJq3HaHRgR8vDTsxLfiUKga7YHPipczoQFbO4oA+1VlkXBNJhiOrEADx8rb18NgjPEqdo3Tjz9PETtmTnpSin3BjReAikBDM9BPNypzK27SYNxgQpCs0XxrqbJd4qGraguTcFWGXgK+hnSw5v0iA6sqgW0R50+8h0qJ+u4eL/mPGL20oLMotGiuF7wslUdrMBffkQYamn/MGwZSwtaLELwGq9sz7BuNZ6uUe0WoiiYfvoQo8STpYUhrCmuvN6jiTUeISZDoNNR07mNAS8VG5mJI+eybx1yWe7uFTBO18qG17s0daAlkOb0t4SL+W2DbjGSrnwGyCijMKKQ==
Received: from MN2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:208:23c::17)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 20:11:10 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::95) by MN2PR18CA0012.outlook.office365.com
 (2603:10b6:208:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 20:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 20:11:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 13:10:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 13:10:49 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 15 Aug 2025 13:10:47 -0700
Date: Fri, 15 Aug 2025 13:10:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<jgg@nvidia.com>, <will@kernel.org>, <robin.clark@oss.qualcomm.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 4/5] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
Message-ID: <aJ+URYbOWEmZAq8S@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <5ba556fc54777853c499186f494f3411d7a4a5a9.1754952762.git.nicolinc@nvidia.com>
 <7b8d8bfa-ca6b-4a07-8a4d-a30d8993c7c7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b8d8bfa-ca6b-4a07-8a4d-a30d8993c7c7@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5f866b-fb3d-45d0-c0e8-08dddc37dfc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oczcHd6Zu9eQCIVtBn8+MFwEiOPDRw4jvsdqOzZk7TusS/yPaMs1ZDPc0sOz?=
 =?us-ascii?Q?kIy6fynCWIv9xVp68cB4bpbn5O6mk4LUMclcB7Ea4FrO2U8izE55gH/687he?=
 =?us-ascii?Q?cGJQ3CTcd00jz/yBaBh9/1bgVMZzv9Bteyi8oYdHwERdUlLxYY7QyAsGrLVc?=
 =?us-ascii?Q?CytGKQj8k+P9glQajS535/TQ7NKxj0vMZJmF+W3f9J9oNtnQ8vRv57aiLpbP?=
 =?us-ascii?Q?6CcqekOlEk/lvw/HPiM0LBQsj/MwwPkBcPDaH60N3TbMPP1Pmn96fRJQiVuu?=
 =?us-ascii?Q?DhHbfDnzE2MNZjSj5g2Z627Jd/VotxIRgVB0I3wGvIRcX7gd3ps9nrAQJOrQ?=
 =?us-ascii?Q?pnVYjtUl6neseLwK16NXeEkc0jMFF8XDrEAkrzz9xR+nH10eVehDRkkMku2a?=
 =?us-ascii?Q?UnWFfkmBIrrGuI8ew2nDpAWD5+LptlB5IkjVGNWssp3m/bKXWhBjQCGfAuAB?=
 =?us-ascii?Q?bxC6VXeygU32sCwQOS6gWe4H8IuQ+LhUczfPse8WMf79lGLidwZOjb3alGdt?=
 =?us-ascii?Q?HP2HGw2xM4uh8snT92GsiJPvnxOeFWFhQ5hI71OJipvjYXkTVTCD6iEwXR3s?=
 =?us-ascii?Q?8hTDmuJChRfA5Du7Wl0aIiEyPseMzTXQ7fiqT6rm/YMoaCYQQwqevTB9nPBp?=
 =?us-ascii?Q?QpFvtcgtOYLWdaabMyC2+x0oQOdUpGR8MXOmQUsufjtrOcpQhKxBJOnoSoix?=
 =?us-ascii?Q?L23LBM0i0BnHP59rwgElQdM+l8F/JjCDna6+UdvEblaG4QDOqYZYeOjY3Tb2?=
 =?us-ascii?Q?DQQ6yqvWJXpog6HDuhL+ElEak8e98d/C+jYBoJ/dSUTxlPAZUYEnD5lmLicz?=
 =?us-ascii?Q?LC3kQ4sD+GaX2cuEnS5BJSG369KEPdu4h+TOZD79eGKcmJsulfojdWoQG1J/?=
 =?us-ascii?Q?IRak8Udelpiksk8eBmEOWJ+oOgAw/X9C5QDYOPwF4XqgIgNF0XUe9uSbR329?=
 =?us-ascii?Q?Dxr0uAguBic5uaLz+pgQNFR5JYdxnQgEkMPWOq6ufAn0c3kt+rs/0zOd5UmP?=
 =?us-ascii?Q?GWeVe6OEm2p6XFbKQPxGfGVqnKWf1YlZ+66dw2j7T6JMyh4SroHdzHv8zAkG?=
 =?us-ascii?Q?gkbRBUOesvZSqtRW3ORBuy5tk8X9YJ5oDQyHAYbrtcqbhqN/Hn0A25mxPJiM?=
 =?us-ascii?Q?h5eq/5WxopOP7NU937swEcVJF8pWkz0MthI8RNTe/rbqUT2FDDWQzqfu9hcL?=
 =?us-ascii?Q?zs1T2G/0HtSwwKm1venyABoYrAPWa8AeKIaatx1q2kGioMGPh0R9UVBN8QQ7?=
 =?us-ascii?Q?hAo84K9+LLZ8G7hb4jqYU3yGSlwhNvC1AWJoqB/r3AIkB8+aw/bm0x2SqlJx?=
 =?us-ascii?Q?gmL8LCOX6C36eeSjpohiI7weGZUsW3mc21bt+NUOO1OjrKcyqJq9sOYe4ZQk?=
 =?us-ascii?Q?b6dPcOxOg4C2yOo2HQbtFGWcmIlZ8zzpH0gzizEFSNYhpMYgOqTa1vdGwoO1?=
 =?us-ascii?Q?hsE/r+yWJOXzXgVzMPHmAfl5JIIXTfyRNlHq4AsaY/6XKVngDeXNDOPxqn8T?=
 =?us-ascii?Q?toGchZWIP8O+n/EigfS1ULHyn44X8Pe8mNXn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 20:11:08.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5f866b-fb3d-45d0-c0e8-08dddc37dfc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01

On Fri, Aug 15, 2025 at 01:49:55PM +0800, Baolu Lu wrote:
> On 8/12/25 06:59, Nicolin Chen wrote:
> > Provide a callback from the PCI subsystem that will enclose the reset and
> > have the iommu core temporarily change all the attached domain to BLOCKED.
> > After attaching a BLOCKED domain, IOMMU drivers should fence any incoming
> 
> Nit, my understanding is that it's not the "IOMMU drivers" but the
> "IOMMU hardware" that fences any further incoming translation requests,
> right?

Yes. I will change this to:

Provide a callback from the PCI subsystem that will enclose the reset and
have the iommu core temporarily change all the attached domain to BLOCKED.
After attaching a BLOCKED domain, IOMMU hardware would fence any incoming
ATS queries. And IOMMU drivers should also synchronously stop issuing new
ATS invalidations and wait for all ATS invalidations to complete. This can
avoid any ATS invaliation timeouts.

Thanks
Nicolin

