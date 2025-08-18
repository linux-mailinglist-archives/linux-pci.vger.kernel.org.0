Return-Path: <linux-pci+bounces-34220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF0AB2B067
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 20:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B81E566B0A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D45C3314C9;
	Mon, 18 Aug 2025 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sQyxZCr9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C43314A5;
	Mon, 18 Aug 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541778; cv=fail; b=G4Xx9CCNfJZe8WMk6juZOfBZhQg9EAWFBP4JTNAEa2Pd7QsOtZZTkDsFEqTPtdKKISOHS7fknkI5Zpns1fGKm5bQcAQEhUj5WFBGcVRffDPbuwygGAebEc4i4EqpXWuB7jkx3gTtedBX9uqpvXpvd6EkXNtUFndzqIydOceBGZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541778; c=relaxed/simple;
	bh=CrUl0YqU4mNldd4bcx2K3jL3iWpsHQxSXVi1Cg4o++0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFYLFlzsumOXAkKvg2QHuIfRbrK0cXxFv27/ytwVwODJq8t62ptAcBGo8f2PsYJ1W7mEj0e/K2ZfrJIAT+PMQaz7J7JXtVKbZt2G7QX+jsewtxDSLEujxT2fPX+YuJ9+AgLTvjqaXH3Ih5Ii3g5ZzN1FePMxyTmDxEDaIAYF/VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sQyxZCr9; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uotCfpIxegLEaRAEWQ1zQEwxRlc3KLuxOcotnzftQZ4M3h6coarl6WsmAvUdCjh/GBy5YJpsJOPijV+ibtLFbaNcxq3K89WPGodR6MhoSlfXT+Hqjlrew0rwHc6/bh7GKuVX708hmYDTFNMNtTMboy+PfxFTFR0ojBI68YevOu4WQnR0sa784BH730cWhxOpGJBKT0ArRirnQbtOC1KPi3Dy58bLBNnmVFKDDOxOlOa5zDdMSqjJX4PNUFXNwPEyLB+S2L6KW9g5t+drj01KCWPGrTvFNMDJlhWUXsjCfz6Q3ZXlzBlE+kPT0xxLK/lRRWFvQEy5pZ6a/bEg5XZ8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrmp5QflK+LSCJSK9jBedyKcAa7bSvHOSwLDsJx919k=;
 b=HbPbEoyqA18YffXLV8hFKeICWQ9CHm7HDXZqdmERW7aB1zdJWnor8bf10TmC+2Q6LWV94yYN8VX77LhO2hU5wHnu5RxHPDuW7/aHdUgBnFmHRz/DE2LgVVyOOdyTltMYEVoAachhZen+CeE4Kk2R3YuixI7uTnpVrSbSNzoWGt5lMFmnkpQ7uJ48V85M5UeIGMIGCcMUi7NP3zyodpfPjJ5e8zBpkG/o4/H8XhjQ/oRGqPsDjd7ijcXIE47I/R18is/gSH+/fYkO7ERZPS6nTFzXkGu/s1ulTOGK89n1/54eXiFyH3M1E4fq/QpKvcnqJMQqfAQtJmYglpRV39i9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrmp5QflK+LSCJSK9jBedyKcAa7bSvHOSwLDsJx919k=;
 b=sQyxZCr9FentSeCjqvJIJXIDjza1AknPsH1ECviP3BcSWPU8LzmfRyIbwTOTtTMxfdtMHeaZj+/dQfrteCZj3rCN+IDbwOWrJUAoK+V40GBYGcMUuWQ0wW4fEyOIasqn66zubtL9OLC4XtKlT+5FIP1lBxbJS7mpdYCVutlXV1GdM6tD7Ozo7c9Ezc20Fc7Ro3WsYhpDLBoIk1Wz0UVxqHYrhpH81DvLuQygF9kh5u/jGgwhvLgg3QNB8RiNYv0PvcaWRn7bdQzaSCLIwDCzCURVL5iCewnwN17Lcox8y0W35bKjuSVEBukPldjTvkLfeFtk064BDuDYanx3xN/Fsw==
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:29:31 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::af) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 18:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 18:29:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 18 Aug
 2025 11:29:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 18 Aug
 2025 11:29:07 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 18 Aug 2025 11:29:05 -0700
Date: Mon, 18 Aug 2025 11:29:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "will@kernel.org"
	<will@kernel.org>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "yong.wu@mediatek.com"
	<yong.wu@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
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
Subject: Re: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Message-ID: <aKNw8CWEJ4/fJP2b@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F543286807E05FB465F58C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250818141751.GN802098@nvidia.com>
 <aKNmo/O5aXb88GKK@Asurada-Nvidia>
 <20250818180920.GC802098@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818180920.GC802098@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: becdc750-6317-4f35-ef77-08ddde852c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7lReftFSbAwlTh0FfjFvlXp5gG/hpEty6caJUem2Uc4mJKkuaoRHyyXCO4Rm?=
 =?us-ascii?Q?TZuAhJmEy0wJqGM/ZKzWgBE5wiD3YLQUzsyUGttkGG1q1ULzd81hNVr324Tk?=
 =?us-ascii?Q?mAArDficRw1Fwcqgr1FflcsAsvkPvA31TSMuNvdMveeIQ6Ac7oSViyWBIlED?=
 =?us-ascii?Q?pzkxjl3ESfRVdDq5j1OZOYOgfaR2kOu9HPp2gBMs5eF4Y1wfoZJfVi9KWiJE?=
 =?us-ascii?Q?FvA9nZL2nJRzLmNVjSywY9GYC43oZ9ocsnuoerA2T26zSlF/J4933aEnSB0p?=
 =?us-ascii?Q?/qina7DNcJiiNlj3NY4t0nVZiqLAkXHudpAoX6f/NyFv8Kvdv3b3p35haIXy?=
 =?us-ascii?Q?XSFrxAIU3DzpYW5F94/R35gCj8Y0YF+YUWrQOBkJoX3pyrvSgVbwmGY5aQpc?=
 =?us-ascii?Q?jWpJw13URFvMM1Z0zNEd/VpgS/h71A640N3K6h4gv4H9e0abuIZqwBZ7Ap3u?=
 =?us-ascii?Q?eJy7Grqww0M2QoNtdSqLaNH4DNb29wN54vV39rxRVtmkU3h2Pb6CqWPolRi1?=
 =?us-ascii?Q?cIyst/S54c6ryffBgv+fora38aTL9Wqc0TQOwmSL1ndv0hrYxDK8E8Tv71K1?=
 =?us-ascii?Q?hQLIEzWIoEY9FVQqRa4iBSZZ5LOa437Q6zyL5TXny6lBUYBgKoCdUusqBnfw?=
 =?us-ascii?Q?ew+HkrzZR5mo9vrKARcE5Sbl6Z/i7f/v6LuzOEabpVQyZ8Gl2la1ILyglMqp?=
 =?us-ascii?Q?lZBj5DznDaSHUYZEdh8sdgnFdv7zqZiQE7sg7NEu9CXkFgwtFCovdHChLO3n?=
 =?us-ascii?Q?FJCIdVL+wUqcMfz4LDEJyjXvBhh6tzd7lBxozEO3BsgVBdGtE71HEEAs0Nwf?=
 =?us-ascii?Q?ComdpvvApEv2SkYFXFr0DiQ1DW38292XzbRUYlqJoJa5CMwTA6bEB+NeWHZ6?=
 =?us-ascii?Q?AmG1XpmG96ktHr7TFhcPYYacKB1CUZPsNLjLnmvp7n4+tKklTWZYvTk7U36X?=
 =?us-ascii?Q?yY/qHjlYXCwtFJ5L8f76rGlgILjBQBaY8k6lNF3e/FmPnqvRCbLB9TwhNiZs?=
 =?us-ascii?Q?Ret71lCZp0q0UPYNQQvRr8G7Y50/XR3N2ay+9xBdBFi86D/5gSaOftAAeMyl?=
 =?us-ascii?Q?/Wo/jaLF2qJv8Ht2s/AGMiVRmyOyVkkK6EuEfL4w10pNraNzqC3ELAk31Ovd?=
 =?us-ascii?Q?VymNNM+kvNE8qQA876r5iWE3Nqn2MizFskKHJ9lL8Q/ci1Skd2qdmZ7V4IiL?=
 =?us-ascii?Q?bzjT2luw9kq57PXNW+rwlzjmJvfqJG1ve3l8T4sceqGCKMS8wdDAF8tg9/b5?=
 =?us-ascii?Q?DWn+BZjpTzYEzQtJwleG/f/KMfoW5ZfMl2L71FJy4JQ2seo1iH9LroSgbumi?=
 =?us-ascii?Q?PUOwDSlet1dXbrA3BneJFTxXES4IxTDg6CofkgFs0vCEPKwqWhpC6CCDxln3?=
 =?us-ascii?Q?GQPJ+N/Urbo/hqX5bX1BMO6G2V622E1lzoS1/ZdEFe4Mxq+nf9KLr63n5l/6?=
 =?us-ascii?Q?XL46qJ3Rxa91VsCc6Gn1ewNFVV3ez5Q5mvPgCsdFwU+bXlDTvk53D6O3M+PL?=
 =?us-ascii?Q?2JjQ7P7SpyQWVjGkuDv8lz0KW8jSyGcfRd+x?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:29:31.2004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: becdc750-6317-4f35-ef77-08ddde852c65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

On Mon, Aug 18, 2025 at 03:09:20PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 18, 2025 at 10:45:07AM -0700, Nicolin Chen wrote:
> > On Mon, Aug 18, 2025 at 11:17:51AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 15, 2025 at 08:24:57AM +0000, Tian, Kevin wrote:
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > Sent: Tuesday, August 12, 2025 6:59 AM
> > > > > 
> > > > > The iommu_deferred_attach() is a runtime asynchronous function called by
> > > > > iommu-dma function, which could race against other attach functions if it
> > > > > accesses something in the dev->iommu_group.
> > > > 
> > > > Is there a real racing scenario being observed or more theoretical?
> > > 
> > > I think the commit message should explain the actual reason this is
> > > being done, which AFAICT because the new lockdeps added in following
> > > patches will fail on this path otherwise.
> > 
> > Hmm, I can mention that. But I think that's just a part of the
> > reason. It still doesn't seem correct to invoke an attach_dev
> > function without the lock since iommu_group_mutex_assert() may
> > be used in the path?
> 
> Last time this was brought up there was a bit of an argument that it
> couldn't happen in parallel with anything anyhow so it doesn't
> technically need locking. But I think we should not make such
> arguments and be strict about our locking. It is too hard to
> understand the system correctness otherwise.

Yes. I will make the commit message clear that it isn't about a
bug fix, but to align with the locking policy at the attach_dev
callback and (more importantly) to fence gdev for the new flag.

Thanks
Nicolin

