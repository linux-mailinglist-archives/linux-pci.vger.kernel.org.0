Return-Path: <linux-pci+bounces-36898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA0B9BCC4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 22:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A38A1B2159C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE428322A11;
	Wed, 24 Sep 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MSc8Drj8"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E59321F40;
	Wed, 24 Sep 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744225; cv=fail; b=Lo8jzsmnhZwFAaLoh4+BqVc8g6aZt+Os6qpShoqc8Kc8MDv8/e27oaCKgVjYKlxfHHSl14elj1+OKeXwrx3CHYETXC1Y+/42iN89Uqm5hgzJPabqx2g9izF1kKX8B+WfLsTbhvjDjbDHDd8FwyA5+qMV8Y39M41c/5jnCzgy1qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744225; c=relaxed/simple;
	bh=2wHdTdvoM8LThkzpXVAWNYiqcjTXd1HDWNHt5hxKdH0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQnOoBOnbSCGNVDdNfh6J7Ro85I8jKxjpDrekc4U8yujxUF7QlfN4eEFG0J7+JkfxI0lIiNbZuIPhgUVQdO5Qo1nLUZHRzz+nsalzicGmOWqMQuc84S/o6S27BZLNB5+fiOJolabQ83v8duUnId5v4lBeltSGHrEB1QXbm5XWwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MSc8Drj8; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMFmCTq4P2nAzaESWg5Uhjean1/uQMAXZnmc2d+s0HmLAqY+42LfEYu/PNm16Q//55J8lncvbHPJGvKkA9JXAvtDA3AQle7KKGxQkPnV2jMHw7ZkCAedabeTIJdB42ImjP+JR4hQkpBIv73/7xlzNOK0i/YQOMwvSurWGXvUEpmd9atFdIIWhHTMJAtAWV9PljuW+8EuX9oqs8hYVBDyCL23pWyT7i+WUjN6YfZUtsjmUAHGZgAGIKGdl/titOCA8N9h6Zs2IVUjZHJ1pFSVNeryL+d0dFG4XNCpq4kXp4mBD6/MwR8WwV26X7j1Ak2RJeB1+ocAtJSUqjOjFi6tFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR+BrAxFQqT400X38afdiL7uX4G6s1XjWRQM6wKJsLA=;
 b=sWFzwG311e+k1y8Rfm0ySrLJNpZnLSnlHUiYiK+m2s2M7yErpbbbxmSBXZFqsO92IInh2ntXfTjGpGXVP4+CVI/aIjr96ded4NfLsJKE2OZ5Ht/7RNHz5GttCh80BVUjE+UGlAaLE23HwR761kM8XCAwAagaUp6w1o2tiDjZotV19DYb6ZHhvOyG12RCqBSpqz9JFo27ErzwgZyKoI2rPL5qzah9f300XAo+6OdFCfG+4RByzmOGn1ER7ylLZZ60Yy7M3n9Qbd6OMKb8aWXD3b9iDQFcgNFDWNXq4+lI7a6DXyaYx8HD6Z19elUeIVid7+Ok2saYnAR/56lvAYBjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=csie.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR+BrAxFQqT400X38afdiL7uX4G6s1XjWRQM6wKJsLA=;
 b=MSc8Drj8xU2vPvZHpn9SM4qBeaW8Lfcq/z4PFNc3T7E6+Vedrj57Y8MRtMcP8BE//Jaa8q041DJVFTUBrTuCCq/zal1WRIzZNEtcKs3iJywNPtEpZ/QlCv3wkO15PBJGL6yC/xeK07HGUjlIo38Xwk92b+FrEoMFiUbysbRLXq+er+9DM1TO05oU5vdyhAqMICfRAmK0xCb0Xe0tr8Gdkfj/QYioPmNe9xKrlnvnrNiaq9i95eEmaCV9CyUgwcHIi8ezAxY0SoTxFv+mSQs0nCyEly1JWJggIAjK69lu0hpwB/TXp3B5LO4+U7/hq3fcJYvhd+wOnb/i/VyuCXhUXQ==
Received: from BYAPR08CA0015.namprd08.prod.outlook.com (2603:10b6:a03:100::28)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 20:03:10 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::1d) by BYAPR08CA0015.outlook.office365.com
 (2603:10b6:a03:100::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 20:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 20:03:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 13:02:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Sep 2025 13:02:58 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 13:02:56 -0700
Date: Wed, 24 Sep 2025 13:02:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <suravee.suthikulpanit@amd.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <sven@kernel.org>, <j@jannau.net>,
	<alyssa@rosenzweig.io>, <neal@gompa.dev>, <robin.clark@oss.qualcomm.com>,
	<m.szyprowski@samsung.com>, <krzk@kernel.org>, <alim.akhtar@samsung.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <tjeznach@rivosinc.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <heiko@sntech.de>, <schnelle@linux.ibm.com>,
	<mjrosato@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>,
	<orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <jean-philippe@linaro.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <yi.l.liu@intel.com>, <cwabbott0@gmail.com>,
	<quic_pbrahma@quicinc.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <vsethi@nvidia.com>, <helgaas@kernel.org>,
	<etzhao1900@gmail.com>
Subject: Re: [PATCH v4 5/7] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aNRObmtcUkYTworw@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
 <20250924191055.GJ2617119@nvidia.com>
 <aNRLOsomtHNumaSY@Asurada-Nvidia>
 <20250924195254.GL2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924195254.GL2617119@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5153b8ce-63fc-4122-5443-08ddfba56259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0VmmuWWEgFqCknLNqMPD6I2UkGIGTK80hMjjM5Lpgpo9VEOpLQM+6MQuZrC?=
 =?us-ascii?Q?7U7Tb9IN8Wai+h1wu4FZ9efH4dg5krNQfpg4h/Hlw1kdI763rPNYjaQk52O9?=
 =?us-ascii?Q?OZyA33srousTNfNIHfqA3DyWzYRT0vAgQyUkZ28rYxKFawn1IiV0PSulcfHg?=
 =?us-ascii?Q?+/wvOSqV75rTDzvGS+dLuHe6J6LkGRTLzLArjXaqk9AXh9kT/EKrAde5YdHg?=
 =?us-ascii?Q?QAiNafIeXEwzzjW/NqbYBnXle2tdf1TatT3/6cP3JXNZhfmyz/ZYO/ezZAUB?=
 =?us-ascii?Q?5tKJwKqaZ+Pe72sa64ORCySmElFpkEQtW6fqmky359Zpf2xI47dTcVfs24m8?=
 =?us-ascii?Q?OZ/VMdssZvhrbeFtJd5aRHWHs/1izC6hHA06Uw1gZgmxPxiy48UCY1191LsT?=
 =?us-ascii?Q?6GQFNovQSUmULxpaGvkgsyXJBsUXNsj3oeTaZd/smk61vBDjh0XAeNDhnHCi?=
 =?us-ascii?Q?dO7xWYb9R0GpniAVnirpMHWRedqrLVrh4cyUw1SYOBlxDth1YS3ZcnbGckPE?=
 =?us-ascii?Q?4c3tRDaRP1ZvPYhoJAb/wNqcPlltIYwQEDXCLQ5trAiLDnE4NWwbtH1HtjSl?=
 =?us-ascii?Q?5vIsYcbo+LSj5IqbZrmcVvU0jZbSlHDH46MT1AmjgzJtp6fE7bwMBOavTadL?=
 =?us-ascii?Q?gPULiNinATMFWQCq5oC60EsedtKIFDR/uh6QGCyRudiYMgntu3qRhZQ6nF9V?=
 =?us-ascii?Q?cZbxeol/gVCdpswHYgR56BHH4R785eGThmSNWTgF+peSaioJaU/8pB3VpkLa?=
 =?us-ascii?Q?L8qQ70d9Lhkgefu/F0n3p0vtUOcxQGjmYuHfqYCcEVlsJrcMh5LwpPGV+LZf?=
 =?us-ascii?Q?TpNqlA69JGAQU7tQNqgHAXbSE8o4W1ReycDzRzg3Dv4/E4KyIOwPSHhGtWG3?=
 =?us-ascii?Q?IU4h/pynaVEN0OVLZ38NHt6aqIROBBbIjHLySgM/14jxuvQk40p9qMzkj/Ts?=
 =?us-ascii?Q?oho1h4acB7u9Zi8AhGdAZSZL1+CPXtuKhBnLJ4voV2VXFmm+vdXNsPrSZbq3?=
 =?us-ascii?Q?a5cM1Z9QSDs4eWS896bLiHJ2PXTK8FzD8ULtAxTe2ZyEiypiN0qjbg8/MgXn?=
 =?us-ascii?Q?krtcc6QK6v0DBWt4mXWCbm3eLV7YiFQKKSAoY5rJ/aQOITHZWQTX7olQX5iY?=
 =?us-ascii?Q?3deHGW1/g1bw1fn/Yu28G7Hs3Qw4XGrALLqtgVN+JI3YWC8W1aoYxr4O5K0t?=
 =?us-ascii?Q?4ZfaE+4DDzFVMwsReRnmurAzsIXA6vDc0ENAQ5jPy40gYisHcZHdvyV/WipD?=
 =?us-ascii?Q?SQpnRgIKIuxf8ZLDTb805WQngUuYTyEIGHbKKNyTR1WJnQCGyPl4G65CBPUd?=
 =?us-ascii?Q?fSKYYyVw6BKe9qNkLBpZ0S1AqoiAchUjsDa7jP5XzEYUcez3wepIalP4IvCI?=
 =?us-ascii?Q?E6WhLtmg0rfNK12Oavz7aLURK5i3YERcmrV/JjzpAnvHPagp2XcXLcSipI+/?=
 =?us-ascii?Q?OTvsGjYYEopMbcXMSQ/hLVr6EwMVAzqtAQTNXlUy++zQox+7CAuOvNaUzQw3?=
 =?us-ascii?Q?UTnfnkunVTfNyryqbOIMcHm+bag8s6Y2NICJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:03:09.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5153b8ce-63fc-4122-5443-08ddfba56259
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

On Wed, Sep 24, 2025 at 04:52:54PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 24, 2025 at 12:49:14PM -0700, Nicolin Chen wrote:
> > > I really wanted to say this should just always return the
> > > default_domain, but it looks like host1x_client_iommu_detach() is the
> > > only place outside the iommu drivers that would be unhappy with that.
> > 
> > I suppose any external user that allocates/attaches a domain has a
> > risk of potentially using this helper, in which case group->domain
> > may not be default_domain?
> 
> Yes, host1x seemed to be the only place that had that intersection.

I meant, we cannot prevent others from calling it like host1x does?

Even if we have those replacement APIs that we discussed last time,
such a driver might still want its own domain v.s. default_domain,
for pgsize or other use?

Thanks
Nicolin

