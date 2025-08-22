Return-Path: <linux-pci+bounces-34519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E30B30E94
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBCB5E64A2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 06:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4C2E2EEA;
	Fri, 22 Aug 2025 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t5cw1Jpb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6002E2833;
	Fri, 22 Aug 2025 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843272; cv=fail; b=q9hxL6ScudY/NIpEQeoWE1ew6oV3OoJw0pYaarWH3S+UpTfPXwIS7Qt/8zp4IgeKzlfpE8Sc7PbIUYUW2sNZKbolxmuRYkyaVlqJyiWeQYAwCrISFwpCZclEKKu13VhLGpAMSQNcFB8H09C3bNK+t3yXJgEACFIru0rlfXlw/7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843272; c=relaxed/simple;
	bh=YadmVgoTo2IPDJGS0KJ5q4vVT6ZTgrzhqrHHM9UcQkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niklan+kwm7yiXkXrJgMsutxSAJsMt9C2nHiGLbWPH6BgZEppptoeBJVkKt41FUjDGqXMpg9tHh70Dh+5FC17Xj+m8e6D9d430IVwN45tRNuJ+3BbbNGSD9cRw7Uf2rnVbiIAirD8YIl0Ve2BTIvhFP3+PKcasZyy/jDYfqPSiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t5cw1Jpb; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkrnCsbPJItYSA44cv+Q3qGS+D1a/iu3bFFDwqt5JtFCNb+JjAEY/9qE5Rnle+cjTjldIMTRa1V5hAChHdvdTBCy0HDXz04G28aNqzswBGG9b3z4IfXqhgd5JL5Vq3I4VuMM/11z4Vcku3bbptxCPfGyiFpnBkWbTlFPI5RjCuUSP5vltffsAZQ1R0sVPmN8EMQWI7yXhiwF4U4q9L+WuveIRvSfZOr5rPiMYFtRrKwEDSDL8vi8NYZaCYzoTBw1BLsAGr04SjSla+Wx21OBg+EieH5J2hhid60aaBXDdIXsDmN3Ujx1Uh+cfSwNwyzsGG0x23LyQPH/eaAKXSd5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgRqmJtyyZZKh40pf/48v4y890uKqUZvohs/c2O01aE=;
 b=JTJhRPILZUpC7RruSmzGErNjnjPM3dJUFL2Qe+BqYvNqytozQTDbMF4ILdS+I4BTqRAGfi+zgqvHNE5FDgXygFbA/Aa6hQjhFqGByXlwKCPRRDrBC6VGwEteWBHnN4MBLhS70pBWlCetIsjaDULFcMTDM5FI7vePZLbSX0mC58jGV1oxqq9idCPZDf5RTemq3XLdVE9O+3BEmPF+KXGIUGLrQRj8rTh8lHHIskVtMevKcnpwc8Yy+IJAEQThYWKxXVkBqD5V0yEUlfzJ854RukCyBaLhowroYOI1Kf+qX1q8WnFLCwr9gp4W+T8W7PSbvpNJXFuyiZLnZ2ZhxQiPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgRqmJtyyZZKh40pf/48v4y890uKqUZvohs/c2O01aE=;
 b=t5cw1JpbZ2aD1ppKt9P6Fsd/GmIqh59FgdjYOTKhbb9GoPfvpBmsQJIlhWjiX7AjWArAFXFX6JvjUNne/5NbxN1whyQ0uePg34iWTelVemwSw+qdV+vA30CGc3BEmcm6GCRuC2rr5rJz8GXtXU+CWXZ4Q/Ih8zTDTFr3mpAqFkITN4YToyMzN4309sVt99erWc95RC5rKSDsi7MdGpFUPvJAaLiC8FaFOFHVqS/i0xzCjTj92fPf8hfS1LogmloWb68Pu/trKfrfVbKwKcdGwnNib6MPx85DTDEdkcCLWZgJhTPWI9fX9od+lchk6MgIEEvh8Nqg/MgxLw61wfmBcw==
Received: from DM5PR07CA0054.namprd07.prod.outlook.com (2603:10b6:4:ad::19) by
 DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Fri, 22 Aug 2025 06:14:27 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::93) by DM5PR07CA0054.outlook.office365.com
 (2603:10b6:4:ad::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 06:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 06:14:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 21 Aug
 2025 23:14:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 21 Aug
 2025 23:14:12 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 21 Aug 2025 23:14:10 -0700
Date: Thu, 21 Aug 2025 23:14:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ethan Zhao <etzhao1900@gmail.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<jgg@nvidia.com>, <will@kernel.org>, <robin.clark@oss.qualcomm.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>, <helgaas@kernel.org>
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <aKgKsXmVWS5NZdUn@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
 <d6b852bc-328a-41af-b125-e250c72c0d22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d6b852bc-328a-41af-b125-e250c72c0d22@gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 20684c77-740c-4935-81a9-08dde1432609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c7EWgqX+O0j6epS8boWfDsSkn5d4PDsY34sDQ+458CqtPwaiOaaGppl9eNLI?=
 =?us-ascii?Q?909LalIX46dBHkAR4rInJH9XoTmLjoe6ByCidCSvtQSR+cjjLWEC9X64Snz3?=
 =?us-ascii?Q?EFBzHPQAnEBx+4LCH0d7CQPuh8F27vpnHiQOQn0/GeZ9Xea59EOz1jKpDVUe?=
 =?us-ascii?Q?tWa+Ny7eRQ9EXF5yqKlRSyfKo6sNC978+a+rsgRvIHQtfNyTotj9/w40egZe?=
 =?us-ascii?Q?6WFlwmCQPCYQ+XZlifFOSLlpxectizqTqM49rZ2ASkK9Se8FftJIHX6UXqp5?=
 =?us-ascii?Q?TzRj0aaUBDOfgOhFwKDZ52X4aiWlNbzBCD854h60tTxDaeaxlihNlBHfiNY3?=
 =?us-ascii?Q?fuajqPs8Gk24SI6EkagRbkEkE6P4L8ihztO2RIFRkNkpDNC7uCOluV/inGbU?=
 =?us-ascii?Q?6Rt0E6Cm1XtXCrgR+0KkXbJv6xnPfJs700m+ImPs3cQVA3cUkMXnlXjEqq+C?=
 =?us-ascii?Q?GEITzsa1qJZy4ecZMeH9k/lHwavsQ7BkYuK/sr74HksZo6RzzGFiCTmZuSRA?=
 =?us-ascii?Q?5Ln4qBZXDEm8PHe5mOommJqVmXN6FyidRenNK/xuC7hnEFoIojX/cKx1HY+P?=
 =?us-ascii?Q?uT0GGHqPHg99dBUzflDxazbqQEh2dJu9kjslcJOvIXRfYLHAtB+kH07oOB6G?=
 =?us-ascii?Q?yz6NakqB8xBErm0rnchZ87WxeWXo1YKRKNEcJvpVIJC2m2bP7IekE46AcUkE?=
 =?us-ascii?Q?lVVtxAKO9ggK3Y+eYxdcGsYNY/LMYxQKioJ+rFZDslQuPysXrc7uB03uG42K?=
 =?us-ascii?Q?lB0S6yMEv9QoTaG9N5aIEYOEzgtx+9sqDxkY7bdZGkjM32TJrYc2WPhd21WY?=
 =?us-ascii?Q?Bkh1EhEGK1qrIJtWWBwK0yccjHOAt5EwK3kGMxGVET2Qzc1af8Q2nQqxQ8Ve?=
 =?us-ascii?Q?IAq8kRBezFe2CYiwjCwomosMlbzclav0RJf6JBUp4GrRJTRzwU2yaGNtXXoA?=
 =?us-ascii?Q?ROvtnCHIAtAFbBONmY6NDDG06bOGG8JAc4GkHgi4FPZO4cIwax6gMcf5ALBl?=
 =?us-ascii?Q?oxkfxlhp6jmQ+XOUlyeVvq/t4j682wSa1/QEQB6IecSvkcDUUMLqGAW5sPSc?=
 =?us-ascii?Q?4JtsVDjrDyu7w9TgggeTihGokJjXGKokxDoiqkk7lpfohlrcU5sI8yjggHET?=
 =?us-ascii?Q?cQK5Qo2siv0W74fk+SEBeRejGO9xvRcvdlUrE6DZ5hfYibfiTYat3tNiELTv?=
 =?us-ascii?Q?UB4zF1db22XVz8u1ePgiSZ+0JWSu8MTVlkoC+gvGKu+9Js1hq4HyGgDiqvrp?=
 =?us-ascii?Q?h6cfFdHe0OBwl9i8hq266VBp9nougMPj/q1fGSR+tzHapS3tMGuNRph+A6nh?=
 =?us-ascii?Q?X902Bz9dN/OZDlYhuTm5OMykX/c3fomc63LNdzbNqApO3RsvshzKsPp3bVxe?=
 =?us-ascii?Q?OwL2eGjdhsgdkLagIhgCYiKyUaRyeLjwTqhM/fH46ogsSd3+p21RAd84aDYJ?=
 =?us-ascii?Q?znxsWYCngoa9LcWLWArr1tS/LG8wOy/FaoJa7EFGnOTzqHqrM8Vs0/0b9yUv?=
 =?us-ascii?Q?8c6Q8vm62zVarmiedEtMRALvPnaI2ZV6hCLW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 06:14:27.2134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20684c77-740c-4935-81a9-08dde1432609
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

On Wed, Aug 20, 2025 at 11:18:52AM +0800, Ethan Zhao wrote:
> On 8/20/2025 5:59 AM, Nicolin Chen wrote:
> >   b) multiple pci_devs; single RID
> > 
> >      In this case, FLR only resets one device, while the IOMMU-
> >      level reset will block the entire RID (i.e. all devices),
> >      since they share the single translation tunnel. This could
> >      break the siblings, if they aren't also being reset along.

> Yup, such alias devices might not have ATS cap. because of they
> are PCI devices or they share the RID(BDF), so checking ATS cap
> condition might be useful here to skip the prepare()/done()

Yea, I agree, yet I think we need it to be "sure" than "might"?

So perhaps we should check alias too. Given that all alias devices
in this case share the same RID and reside in the same iommu_group,
we could iterate the group devices for pci_devs_are_dma_aliases().

> > > 2. Reset PF when its VFs are actvie.
> > 
> >   c) multiple pci_devs with their own RIDs
> > 
> >      In this case, either FLR or IOMMU only resets the PF. That
> >      being said, VFs might be affected since PF is resetting?
> >      If there is an issue, I don't see it coming from the IOMMU-
> >      level reset..

> Each of the PF and its VFs has it owns RID(BDF), but the VFs' life
> depends on the living of PF, resetting PF, means all its VFs are
> lost.
> 
> There is no processing logic about PF and its VFs in FLR() yet.
> my understanding the upper layer callers should consider the
> complexity of such case.
> 
> While we introducing the connection of IOMMU & device in FLR(),
> seems we brought some of the logic from the outside to the inside
> part.
> 
> One method might we don't handle PF either by explicit checking its
> VF configuration existing to skip prepare()/done() ? till we have
> much clearer handling logic about it.

That sounds a good one to start with.

The prepare()/done() functions can internally bypass for devices:

	if (!pci_ats_supported(pci_dev) || pci_sriov_get_totalvfs(pci_dev))
		return 0;
	/* And check alias too */

Thanks
Nicolin

