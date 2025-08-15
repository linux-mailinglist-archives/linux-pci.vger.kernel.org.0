Return-Path: <linux-pci+bounces-34115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFB2B285F3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 20:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0B1D037F5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6B23A99E;
	Fri, 15 Aug 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="si8WfRdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E8317714;
	Fri, 15 Aug 2025 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283547; cv=fail; b=KlZUZPcn0Lt9q1ujv/hsDMw/CRKdppXYQlKQK6sVpgOdVgbqj/rX4+ReSJw8Lz3KD+A2mG/dhfz+9cnQnKIZWEExgFIB+ApHumgVcSMgSUMWSbsF97ztU/jAEh8IffsKU0tKgvwbj+WnRyTBvd3rJ3EXQwlNg3bLsFPTX/xeuS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283547; c=relaxed/simple;
	bh=JEyFpLCnlTC+Pc3wrvB6u4bD9Z8KihpT8r5ko7gY9qw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P07UIjEkAjD2KWhkAZuIYKap8FhiMDQp0DSGXT/+gD4HzsPBhVTwW/Qz08sS7OX8N+RrxMXAVKpFLiZ/O0YOLdKn+H0mbONuTZVkZGjJm7eVF0dhNPhCsEkvmM/g+LL2UP0nXXpvhraboUEkHz7sseh4g5GIPupuON5P9enzfqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=si8WfRdR; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAx+KXYpfTaTvvvyw3CdjbTF1uclyNPvlICY7ssgmiCMYJ6C+udVenue0wuLt7D9vTfiCpQt692ntHPfnJz6oBP8Tesz0bpgq8nukr2EAWzGxzEM0VCSTV9MFOAAwxkAwcSeTUik9Xtn7TQ4/O+XiZ/pDOHimOyfTHKZmGt30RsmH2t2CHJiiHD5ee3zopD0Zvp152lh2Q81dlaTYSTM3QvEZKl+Nodcz4f2EBa9g6XhNLazaxmVs2gSTzSCXUTQpt0izYgWzdnUm9z8IgYPgQ9ejUqeXe3XGZv2yZ1yMl87xeThY/eiI83N8VneS2lSx83905pJ+dA8ZJ99+YRpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqX+/7tqtvqZ0h2XZ5+txCb4YhUTQ2SiaPt7MP9iPD0=;
 b=tIDgmAs9Se+S+lH19yAVGqKSXR14hi+uGLsQaBU8hwg+s4p3m32GsIUkDS3NBpcE9NvYviw4AKePZ3O3X16s2YfQIgO1q4tM+r+1JHiyflytovqLJ33dY/viICxZdlvVak3SRWkhOWVtJyQ51GbnuL+yM8J3maLKJBaZ/GUBI6IM2Nm4QDITL0x5l5geSBaYi0xvcTW9PU3l4gxdIm95S9OAca2gcZ5KUuBCsh1hNM6OI+mmcCGV1X4MjJkFmH4o/9OMJlU7jJWhuYYMNJ6LiQmpsw+XaDD5dlUONaku9M1dLATwwTFnp+ZyQoeEHoQn6aE8OMC2xOvocO50iFXPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqX+/7tqtvqZ0h2XZ5+txCb4YhUTQ2SiaPt7MP9iPD0=;
 b=si8WfRdRp9fno8qBtbDJdvHQU6+Lz7N6pgCWfze36DvXqB2tICIrndRio24Bbf0tUCO0PJazHDcBPORKpXGsxBy9NV0CvkEpGEg9YtQjOGASEv8YGDbZml717xPJXZh9gEXGYYXqV+u0t4AzOuGcTWC2hU9ka8REhNnfp6225Md9cY6RCnc/PkVtXHfAQAJFiubeZuwi79pQDaRqZllwvQKfdpDIP5trQYPgsl5lFp0GxkyNZrQxiEvCiucae4KCU9ZsKYDP3EQgcMS5pGnj2+4Gvoas6o6RftYDPujrpZUSCiGHax9XH49yRLMxZCmfmTABIYkjsg2nisea05KIrQ==
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 18:45:42 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::40) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 18:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 15 Aug 2025 18:45:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 11:45:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 11:45:23 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 15 Aug 2025 11:45:21 -0700
Date: Fri, 15 Aug 2025 11:45:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aJ+AP18ucw3Jb6QO@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB52769ACDFED7201CE282FE3C8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769ACDFED7201CE282FE3C8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 0865e9ea-fef3-4ddf-b002-08dddc2befae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q05Meb7QQNBdDfARrZ62OUm1QwgCAAzK+VxnWLRs3oc6bokHBNzi7tM3ZQEe?=
 =?us-ascii?Q?OLyCYkekDBUcGo0DQzA+JNoscHZKFW6eU+XEVcw67DbR/S+Kx0ntOULdFWT/?=
 =?us-ascii?Q?TDwojtl2NYEJwidv/+r0AND/XLHPnqhBr/80mvhhtHDRry5aBtlwAu2D3UAY?=
 =?us-ascii?Q?cNqrMWKr+Q0M1Uf9op6RK84k2yf11x8MzcHpnQ7ICqHSR5NEIVTzXuDaP8Wp?=
 =?us-ascii?Q?KFoys1dBS4nMtK1IUjHr3pZdzT1lP6+IM2vcap4qkcDw8zI9ZEQBl0vFdrNq?=
 =?us-ascii?Q?C9FVhLkvjY+0hL2328m6O8IyCSNQl3QXeE32STvgE/PS07wi7TU1xrX4axXB?=
 =?us-ascii?Q?fhpo3XnhkWZTgrxNhD/C9GSfxrsViuhLstmMYQkzWeJM1Aj4OAuI2Xx13BIZ?=
 =?us-ascii?Q?OzcJY6fPDkV4UvoD9h3SBLo2QJXf4RCQ15ul0w0I38H6oF88D6qBNCpVseB+?=
 =?us-ascii?Q?GRTHlL4+WClJnjkItDjQrDQ7u8aa5idioe+d8mKeTweG62a4eL9wQz63VIK7?=
 =?us-ascii?Q?pLMQ+JpDp0T1lSspNDl4Sxgom8kUt1AK64hhaAi1IIVglUj/l4DpogahPJVq?=
 =?us-ascii?Q?Trm4Y5bJV6tbRWJZUtm6BHTMU4KZLC7Cr1v1NRgsWVwpxvtzpg0rL1WHLOra?=
 =?us-ascii?Q?j3gzMS2Chpw9CTxrtc9WrWkIp4brqEz+LkX8mG/GnuhFOx6IGpaysWwGwpSI?=
 =?us-ascii?Q?ck04S6sOEVtS/JSwc9y96dAadUXjDIlyluyy8n6k0k9xfhngxMWSgFKNitF4?=
 =?us-ascii?Q?s/uul+zAhNTe5/A+lHrEZLL9uwVXiER039mlSUNvIAZAKo1/sV9Jvc20rwXc?=
 =?us-ascii?Q?Oo8kIbR9gBW2ALyjtlvZk+nQ4ZYocYkThBp89YL3CEw/wGaUfPQ4YBbTehcD?=
 =?us-ascii?Q?OLB7gb7kkqn5f3t1RZOyCUYMhYIQUFkFtLSzU/Ux6+jSk469Yl5cwCxTVe42?=
 =?us-ascii?Q?cMNFGxoWf4gL4j3AFr690u9NLP5LbycBNiRS7LTPmCoMpgso8R5U8Is5CTvq?=
 =?us-ascii?Q?BCVJe4p/CsZRx2ODdkB0A73uKkANzTCQ08TsqEswPDpSoAVWWX6nbWQlmM/X?=
 =?us-ascii?Q?cazlFp613+pTYgvolJKMDXFs6sUUK5RKOpomKk5zXeV5r3B9Od7dQWkz7MSJ?=
 =?us-ascii?Q?kpH1jaGWeZQlnOlDaenRru7rcR3tVzpAWGtcGp6FXH1qUNZFf5rBbZkgQkqY?=
 =?us-ascii?Q?R155fJ0w7mf4A9cc7jq4JvJ1QX2QgplASucrtQFjC6QPsW30PRvL2wP7I8AM?=
 =?us-ascii?Q?Ep7MfCfOH7sXCYjBz7XFqAAYE+tQ2HNRHLN4NFGypI03QM1WqSdYGE5en3GP?=
 =?us-ascii?Q?I9IiWxqziC3BcsyQhuA/yuRzu+qBPEnxkLsM7HHMu9ysAzy0i9exVrISQz/L?=
 =?us-ascii?Q?Tw2ZrD4Ec50T3BB4fKrahuOx02qPzICZRNv5MCyli70sRisMEZuz2z42x8xJ?=
 =?us-ascii?Q?Rgpl2Z+Q1eqJzzdXZ75b+XPF01GD3rZXJmKIypZp/or9Yqj0aiqyqKBGsjHC?=
 =?us-ascii?Q?rWrXZoxftsGWgLyhh34hS+mhVT5U8eh6PzBQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 18:45:41.8008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0865e9ea-fef3-4ddf-b002-08dddc2befae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6

On Fri, Aug 15, 2025 at 08:55:28AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, August 12, 2025 6:59 AM
> > On the other hand, the iommu_get_domain_for_dev() API always returns the
> > group->domain pointer, and several IOMMMU drivers call this API in their
> > attach_dev callback functions to get the currently attached domain for a
> > device, which will be broken for the recovery case mentioned above:
> >  1. core asks the driver to attach dev from blocked to group->domain
> >  2. driver attaches dev from group->domain to group->domain
> 
> the 2nd bullet implies that a driver may skip the operation by noting that
> old domain is same as the new one?

Drivers uses iommu_get_domain_for_dev() to get the "old domain".
But during a reset, it doesn't return the actual old domain that
should be blocked domain but returns the group->domain.

Driver needs the actual domain (blocked) in that case because it
handles the requests from iommu_dev_reset_prepare/done().

> > So, iommu_get_domain_for_dev() should check the gdev flag and return the
> > blocked domain if the flag is set. But the caller of this API could hold
> > the group->mutex already or not, making it difficult to add the lock.
> > 
> > Introduce a new iommu_get_domain_for_dev_locked() helper to be used by
> > those drivers in a context that is already under the protection of the
> > group->mutex, e.g. those attach_dev callback functions. And roll out the
> > new helper to all the existing IOMMU drivers.
> 
> iommu_get_domain_for_dev() is also called outside of attach_dev
> callback functions, e.g. malidp_get_pgsize_bitmap(). and the returned
> info according to the attached domain might be saved in static
> structures, e.g.:
> 
> 	ms->mmu_prefetch_pgsize = malidp_get_pgsize_bitmap(mp);
> 
> would that cause weird issues when blocking domain is returned
> though one may not expect reset to happen at that point?

We aren't changing the iommu_get_domain_for_dev(). So, it should
be used exclusively for functions that are outside group->mutex,
like this one, i.e. they should still get the group->domain v.s.
the blocked domain.

Thanks
Nicolin

