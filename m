Return-Path: <linux-pci+bounces-36804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1922BB97664
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 21:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBFF1B221F3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C5302CBF;
	Tue, 23 Sep 2025 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H5eg180s"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86831C8606;
	Tue, 23 Sep 2025 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656815; cv=fail; b=NyJBWfo3vzbLwicxvDBwYwNUh9mEwVR5mAb1s9Xfm1VuAkgeDHmq5zitsyjiMagNb2xnnzGHF8kDmGyLLtNTK4QV9FdrCGwXYL2pobH2atn+MKJWxV00lr9tX1j5esz4xlQ5h9mQZ70TT/szi9y8HmqzPdyYj8Xhroxmk+e6pRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656815; c=relaxed/simple;
	bh=BCtdpLxjeJVVrII52JA02m3Pum8c6f0V258AhvSkXXQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQPGz92VWMQxrplpMwfNDY3Hex3rOmLzNcJMyaYOopmywlSfLm237Oxo+fZbkU46j/AQMN6/WkT14At5Z8e+u30GGE1bihmdk8uEgGzYx7lsYvdZZOBVtlIMI70zj2kn4PJhWPlVwzO91YJT7kFkn8bwoss5SzydBXSL0dt+hoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H5eg180s; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtuxDuPubg7gO3Kl5ocPx6mQsz98rIEJQjiiMjPiHJs+Q1XUC2N0Snu8LEXYv+kL6nJeIqTv9HL5aCuALPFvjZ3lLgZZyHLSTKh34VXGaIXTBi8m3fpLVL2KBo6OAoF6DoMcTlPkAn6TEbEOPeKYCdgFPn+vhc8kqReqIQERe60zxlc0cbC/mMKknfN8xKesALOP+20u17OCvpQHmjviIgz0JHysbBZH54LJbje6r84j5aPTnjMkBtwhiWX7cM0MygKuCpDKhY3VLDxp9EysB6UtYtC0H+oD8NoVN7bgsF6cGz5hwd2RGNzklaYdWbk0wfj7hYDG4nRAfvPNhy+hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7h+DRYrN5vlUCUlN2ZJ3jJKXucy42GT5edfhZVtl18=;
 b=DdHITg292wqW/JFxg4VlGJlCQAq8aKqreZNLxu8dDtHF224Me2BIuR44xulQPOalZR8UQ21tmuCaTCsAChsmDK65I9yWt9vR9zr30ckZzo9qW9P/XFpC01QftCRA+o+NCYLSoNOKIXRc6TJNHP6TorDu73uw+TNQRN4xfNtUdmlBVBTiF3TOg4iKfFWUTMrJtofabOAJiiKub8zAxfLLqe0f/OWWf3Cvx/zHPHXV0Y40zhknuGNPy2sXz/58OhtGGpN94LYKPmFNA628BaDHd1wm0A3kF+jBSdAA5jSP6Nzp9EofgPrjWYS1FAgLjfmOtBNAC4xKcgzsgiPDnclH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=csie.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7h+DRYrN5vlUCUlN2ZJ3jJKXucy42GT5edfhZVtl18=;
 b=H5eg180sxWwwJstcj30lO1LCeO7/scCZJ2YjosXIg+/yKYK4F6v/VwxIJxeCd8NFLafXoxONxXFRB4LP8v7ydGkTpkx+VMtnb6ZMdgAIjRdxnP2keMKfzuwXtH5oz1DKFrdoxoVoK3WzzGUHTOn1V0fjkaDYfxaS2YTmQBNYkYDFD4JRNrE2nZxhZiemA70ZD9EGt6qZrZrchszy5Gfe78VdgqQ+KrXCZ0n0yQX4Z2KQnniH3yDAk+MMZQuftzfXGWK7jQ6Lpr4/yaOVFfz/RKHcwFcWf074Tc8LHmiSjvmpfAdOdUQuBxe2WEyKr76anij17Nv/WN0Fg+izFqitlQ==
Received: from SA9PR13CA0142.namprd13.prod.outlook.com (2603:10b6:806:27::27)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Tue, 23 Sep 2025 19:46:49 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::7e) by SA9PR13CA0142.outlook.office365.com
 (2603:10b6:806:27::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 19:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 19:46:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 12:46:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 12:46:38 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 12:46:35 -0700
Date: Tue, 23 Sep 2025 12:46:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "sven@kernel.org"
	<sven@kernel.org>, "j@jannau.net" <j@jannau.net>, "alyssa@rosenzweig.io"
	<alyssa@rosenzweig.io>, "neal@gompa.dev" <neal@gompa.dev>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "krzk@kernel.org"
	<krzk@kernel.org>, "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "tjeznach@rivosinc.com"
	<tjeznach@rivosinc.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "heiko@sntech.de" <heiko@sntech.de>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"zhang.lyra@gmail.com" <zhang.lyra@gmail.com>, "wens@csie.org"
	<wens@csie.org>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"samuel@sholland.org" <samuel@sholland.org>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"cwabbott0@gmail.com" <cwabbott0@gmail.com>, "quic_pbrahma@quicinc.com"
	<quic_pbrahma@quicinc.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Sethi, Vikram" <vsethi@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "etzhao1900@gmail.com"
	<etzhao1900@gmail.com>
Subject: Re: [PATCH v4 1/7] iommu/arm-smmu-v3: Add release_domain to attach
 prior to release_dev()
Message-ID: <aNL5Gizi5krZN1KG@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
 <BL1PR11MB5271767F92289C1D1207D8188C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20250915123515.GE1024672@nvidia.com>
 <aM3dlQH0rk74w2CH@Asurada-Nvidia>
 <20250923172229.GD2608121@nvidia.com>
 <aNLa21vMlP6kgatx@Asurada-Nvidia>
 <20250923174453.GF2608121@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250923174453.GF2608121@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: d720f4e3-88f3-4300-9458-08ddfad9ef76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?edl+yiTwNSBMr7hTEbrTFuV6y17GA9J9hdAI04O96+FGTQSZ0040pRj2w+FF?=
 =?us-ascii?Q?ybnHXU/WSi4DUhm7bUv0PP/qxzdeDBDMsFSBgIfAV7jYZsuhoje8I5KhRWl5?=
 =?us-ascii?Q?CjlxT9yyjStltgbHRZ3WaOBoVsFY5SmKGH12OBmDXMsszhfIqNy5GTWxXwT8?=
 =?us-ascii?Q?ZoYY0jNqa6JlDZvN+yPPdVQz40A9eeG/EFS6YDbLx33Pet58iK/BF2llPcMl?=
 =?us-ascii?Q?nQJeU6Vee72c3W+nq7EMQRcUBTGuksX5q+N9UoHQz43Cbr6JZYfwhRMyDbQw?=
 =?us-ascii?Q?pe1Cer/K6Ky4/wd8QONRYJleJUbDEbXFrMNcuutUYjiOOpBHmVCEmv1HvPvT?=
 =?us-ascii?Q?YKaiGvcz1BJk1G/gc1gKxfGhctpxABPUiZeT0ftkq83VlNCam2Ax0Y6QOcFH?=
 =?us-ascii?Q?xFmigxen4X6hwxesV3b4QYNaauoWf/bvlAvX7fMpxmRDJHi790qmpXNx6RqZ?=
 =?us-ascii?Q?WgIpHrg7u+Cv/MrQ1al4ByjOQke2cHNaG9JAaFS7ToOAYmMK0M7TEBRkKALB?=
 =?us-ascii?Q?Y+P+fCHFkfUdLQaCk+FXOSNG5qWyR9sogbaiTX+ilk7KsFbsDvTiZ1sUfOTn?=
 =?us-ascii?Q?NoVsd5Nxrk9Wsiv8V1xir1oy+m6SAx3fswKUupmpUIoHNxgD5chvURk0Z9ko?=
 =?us-ascii?Q?4tQ/OdEPfGs6Avk1tYSC3L6SsmS0fMUfYvB9uv8uhDFhDOcZh7UU24pLfQi6?=
 =?us-ascii?Q?PZxEyPib4LE6d+LdaaF8RB6UleaKiFzQZbuztdCFno9bPV0WEEgdmCeJsWnx?=
 =?us-ascii?Q?WbGCNrPBi42JvlhNzVOOjVy8VW+lXpg7iCUGfSWbhil+OiUPHjLewFRbR/sE?=
 =?us-ascii?Q?J1NZ0CKFzLFgDIf3Ik2G/NJcB/HM8TbCmblq14lSEbhjsEuCaHn+mt0WuIR/?=
 =?us-ascii?Q?iToGwQ5bwH15g0oy4K8FSfp6IsMhD72BLMCIKVO9LRgvTB/JNnI3KvktREkr?=
 =?us-ascii?Q?3eGo860ERfL00ni5Fake0B0BqrLxFPgF6pxJtttzLFg3cQyFPfAkzPZNHfNx?=
 =?us-ascii?Q?cgQAgDnFa2szD4RdxytIU/SU+lB2RqIbiQZEz9+7PyyEd0OuwmW3k0Hdjyev?=
 =?us-ascii?Q?TKbQQa/NDs83INNDMPbqYGQKx+fQHLrx2L57rjoo4kjzQSEBuIKFwujZ+rgv?=
 =?us-ascii?Q?NsbmshaRKWC2dtQUpghyQtHHfi/pmXXswcoTqtbDgf4KWvcGy9MYSU3mE6Il?=
 =?us-ascii?Q?eR3eQkvxhlg2gMpmsX7e5kCNvhyZ1zmfXLrtOgNaS3AmX2BQ52HqkJEir09o?=
 =?us-ascii?Q?i7nrJPmIYU5wR3FtNzjq00snHwJbbE5YY5DELIfDcM9NmdfkKcfhmtl/QUva?=
 =?us-ascii?Q?9xUrp/lMCutu/R6csGWHqvu6B36gPtA9hNcWKGBV4kAFZ5HOY+ryhkgEmUHO?=
 =?us-ascii?Q?1eHyF3NxqupusvD6q2pyBapZZHgldTolhF1Ys0H2dVzpCLA3xmo2mZnwkRb4?=
 =?us-ascii?Q?a1NJCSW8EFaTHWHvR0fp7BIWXJTp8mLcJIaxEkLeOYq2P8pOOxqzOOqEnLng?=
 =?us-ascii?Q?EE2HHrIGh81w5uNymKruT3+dw7+e37RqC/sv?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:46:48.7849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d720f4e3-88f3-4300-9458-08ddfad9ef76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542

On Tue, Sep 23, 2025 at 02:44:53PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 10:37:31AM -0700, Nicolin Chen wrote:
> > On Tue, Sep 23, 2025 at 02:22:29PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Sep 19, 2025 at 03:47:49PM -0700, Nicolin Chen wrote:
> > > > +/* Same as arm_smmu_blocked_ops but less set_dev_pasid */
> > > > +static const struct iommu_domain_ops arm_smmu_release_ops = {
> > > > +	.attach_dev = arm_smmu_attach_dev_blocked,
> > > > +};
> > > 
> > > don't worry about set_dev_pasid for the release domain, it is never
> > > called anyhow.
> > > 
> > > The intention is to just use identity or blocked domains as is.
> > 
> > Ah, I see AMD separate release_domain from blocked_domain..
> 
> Send a patch for AMD since you found it?

Yea, sure.

Nicolin

