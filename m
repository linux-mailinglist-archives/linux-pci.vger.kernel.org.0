Return-Path: <linux-pci+bounces-34117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BFB2865F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 21:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCE03A6E71
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563E0286D6F;
	Fri, 15 Aug 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YkFweH3d"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356E27464F;
	Fri, 15 Aug 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286001; cv=fail; b=s4DH9bAyDKEPaYZJp1E3DocraXpZSjpPwK8rHUtsoN1JvJ2lZ8n/nCkM8aoJ8zS7ECy8Jrc3qB8WrtBO6VDaQYFTHPK9HXERFMMfF/PHHaB4tnLwSL3NzON6kPfkJT1sDSrNZEcmbAQ360Q7lcJ99VoETZh0ezJfBk1QAJpqwXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286001; c=relaxed/simple;
	bh=g0zicoh0CXHwxQCnqTGByg8hihGga6cf27q3KgveNNg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVTvyrzQvJYMzaDxWiPJNJx24rhCl6DmVoO+TQ1IxVLAXxeLTsIbbSEp27Myh3UAEMxjS7f6UVDEQvoriHFA39LxlVS1cLBATFBEaszXGf1fX2z2ex3K+2kl2lDEG7PZQr64Pkk4/a59ANH4geh0DrCqO96pJvS6iduG7QncQvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YkFweH3d; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/v4oX+8zVdiZfwb1VT2Lm1gvabPZVeZibs4XfhJugnH+S+lSBbGzBZNePpvtL/IYkSaem8CyPWWGRCpgjwOYNvd0w4znX+VWwFMhdtGb6spjfVGl2xwD9is3elJOxOLToswznDAjsO7PGo+9izsb6q6dd3d1Z8Zv+jr1Rj9cjYzo8kU6wFs5A9WHsfbP5ZRph8OZrKY3XKoDWvKndRz6ODIi4CScZ4qh7llxzj4FskA2SsjYUB8wkaXlid0PXwhfDzsbhs4dAH++7Dl2iwHxiknEFy/ntuKnE/DzRiCUpmoOLJh3M9ywWkNzjNIBfeXcTzoLyYKv/NsdkcYFHtDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqPYLw4cocmIKGG4xpE/yElC+R+vUv1MymMaf8SYoHs=;
 b=ovYfnUgsfCmPoR4zlGQyZTBgr7tskLwJOopZ4btYKKP7kar/I0OmBOSnCLyeesous+LIqwl8UIO5wGsgeyQeE1n7og5puJfuetyk/uxiaFqDxFVDhZc5sLyi56GaAWC+S2P7U+EhDz2w3EcWGxI6kNNDRdeBtcPPOuxVUFGrxt1iaYJGYvUiHMuNf2xobUbDQv4w+N6uta+hE5FANJZPHlmDI7KnBP7XeBdDkPfX+610jNhIRwpdMOYFx39QKw5El2Ax6Cl2AkB1kuR0vXzAEXX++1C/iFhVPsptdh68J9tzJQWFWzhfEUNjFuEclQyJ+0+MBBVdslP2I2JunKR+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqPYLw4cocmIKGG4xpE/yElC+R+vUv1MymMaf8SYoHs=;
 b=YkFweH3dSbs/YpbwsskQlyEu1o+/8IbHtH8bj5dJ/rZVuV+LedfdlfQtCb1LkROaMsbM10vsr4FVFeFp05q3/Ti6Mi9WE72aCxszmpifIhGfClfvKx/d13gGI7zC/cQpohfElZHtxJkCJdR8Dbv/2gI3cqKfT0joXAYc80aMBLKj+cSd9J92/lTLr8EDO9vsAWqcCatNvhRX+zdYQxIgrQrFrfKDpfafg40GBUhiOFgeWxvKZ8vZlCydUze1L9jwqtwVpLPe6jDdR4JcOM5dDGx3KehgnejokFnkd/Q5uPRY+SpTy1sN1gulRMqQBRW+zKTLrIVnv5eFaw824jafyg==
Received: from MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26) by
 SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 19:26:36 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::7d) by MN2PR01CA0057.outlook.office365.com
 (2603:10b6:208:23f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 19:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 15 Aug 2025 19:26:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 12:26:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 12:26:14 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 15 Aug 2025 12:26:12 -0700
Date: Fri, 15 Aug 2025 12:26:11 -0700
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
Subject: Re: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Message-ID: <aJ+J05iESNOVm0Kk@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F543286807E05FB465F58C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F543286807E05FB465F58C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: ad37a3ac-5b3e-4ba0-3fb2-08dddc31a6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4I0FplTrgwJqHxZvpqXW4WZjJSDR5l9NTuN85o0MKXpZ5rt7X6WRg3fFhST?=
 =?us-ascii?Q?Ujp7V8xFWrN/L4GmFEd4mb337uKQn6SeE86/7tLGM6tx1j8sm/idrsi5yagd?=
 =?us-ascii?Q?BpDTy8MLGo/WIZp7xQNUVesAAh0TCJMnUG9zBLSOrJ3uKaLhrzVfjNfY8ZN+?=
 =?us-ascii?Q?sH1iMoTUAP85LHVC5Jn6qJxJtmHfJ/lmwP29WOGzncQ030aQwKd8PJtztZ2Y?=
 =?us-ascii?Q?eQ5HJKmHJNm+iBHQlJFnjxgIA6zLq+4mHfYzoulE57a3ZYLvXQmHgvv7FtxE?=
 =?us-ascii?Q?dDfVYZf9mxorq96gfzyrLo5p+Q5uPZqkd5fLdkFQikrKy5Vxxo3rIqWk39vg?=
 =?us-ascii?Q?XQi4IpWfvV52w/OUR0oAHdBY6IzjsoXZi/CasVw8dR29lfJk1BhB7tP8CBGL?=
 =?us-ascii?Q?L6d/LmKC6QLLrAeLLgW1UCGZDrEfjRIlkU9nMI0NURr1zxgJc4MwYoAe8/Az?=
 =?us-ascii?Q?2GW0SCfqTyTvqXwtxsE3cFq+D2IZp5XrMk6MUMzC785a9YSq+B1KbETMnfAs?=
 =?us-ascii?Q?O3vPYTGBSgaExJf+C5szsF8xtrSgpigD+7rB4C5ehwCOpMmqtGvNHr/BjL0h?=
 =?us-ascii?Q?QQSRhIK5GQfFt6CNotKZnZ1DJKpSuijnV1UPWp1SQ5B7IbdkU1N1jmKE1rA5?=
 =?us-ascii?Q?K1xufQcZe6ohVwKFXj7A8W2D0XXpCUqrXW9gae2a72HnJYLiu92Yzwv8wSnH?=
 =?us-ascii?Q?qQUSAodhiKkuwI+PYhGvrotAiHuuB3FbY9ChKW8lE8Ya9bZwK72q+cO1l7w4?=
 =?us-ascii?Q?SNmrm1eLpF9xYCP+CpnDHaJa1Vk8QhHXMxtk+pnHR3785cJTCSk4C15oO/tg?=
 =?us-ascii?Q?ytFohbwp/os+PoORD8xgObxacNT4Q0jt+5VFcvY06xJv5uB/760iYvnzjZKZ?=
 =?us-ascii?Q?zzDI7u13n4Lq5oLnEQ9UZRSG0WHvxnRLRoOFrF4ThTyF7XEzbnOV8aXGVuQA?=
 =?us-ascii?Q?aRqaKxsCp+/k7aUwT0LvAXJTFipMkjowYjpeheJz6FEaa73I7zO66tTEJGlD?=
 =?us-ascii?Q?fAhPZzHgSweNun9kpu+uBHIsg8Kuc/GL4r7zGyokSVz8WzkNqf7gMv+xztMZ?=
 =?us-ascii?Q?XayoJgsaOffdredKKHbgyTgARozVgDfnXPRE9EctmjC0pUoADBBmK/7gJenO?=
 =?us-ascii?Q?XvLFhuFcdrrDv3gtpriB18F8sb8rdDXrFEAgzDxiMO2LUBESnixoxE7RNbwF?=
 =?us-ascii?Q?Xfzgwj1GhOVa3TRt/+WhV1OGVWAVDHLbq7UgxtpvRSBYc666JPx9wfX3uPQn?=
 =?us-ascii?Q?KsibY5c+VsDNev1dZ5LfqJ3C5hSYm72aU0iq10B+ecQ5G6O1GWmcVwz2Obit?=
 =?us-ascii?Q?j5YDvCMakMthDG5XngANhVggzsUTLJyiCup1nOaHl+Bjjv0YmY6Y0zYIVHf6?=
 =?us-ascii?Q?L8KP0znxF3gQ/O6X8l3PBeyjo0yhGsP05xn80aHsdtI0cXm4dWELGllJVXU2?=
 =?us-ascii?Q?VjBYRfvgu2wh0vOf0ISMbj2uMEQewdaeNTf30LBcxX+PasQz4riq9nu1A/AC?=
 =?us-ascii?Q?mZHhwGSuSUdyuaeSVxvHaCbW/afHeQ/RGAIp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:26:36.3051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad37a3ac-5b3e-4ba0-3fb2-08dddc31a6b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

On Fri, Aug 15, 2025 at 08:24:57AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, August 12, 2025 6:59 AM
> > 
> > The iommu_deferred_attach() is a runtime asynchronous function called by
> > iommu-dma function, which could race against other attach functions if it
> > accesses something in the dev->iommu_group.
> 
> Is there a real racing scenario being observed or more theoretical?
> 
> If the former may need a Fix tag. 

Theoretical. I will highlight that in next version.

> >  int iommu_deferred_attach(struct device *dev, struct iommu_domain
> > *domain)
> >  {
> > -	if (dev->iommu && dev->iommu->attach_deferred)
> > -		return __iommu_attach_device(domain, dev);
> > +	/*
> > +	 * This is called on the dma mapping fast path so avoid locking. This is
> > +	 * racy, but we have an expectation that the driver will setup its
> > DMAs
> > +	 * inside probe while being single threaded to avoid racing.
> > +	 */
> > +	if (!dev->iommu || !dev->iommu->attach_deferred)
> > +		return 0;
> 
> Is there any way to detect a driver breaking the expectation?

Hmm, I am not sure.. that would sound tricky if we really want to
have a 2nd flag to protect this one..

And this patch doesn't change the race situation, if it does ever
exist..

If we really want to play safe, moving the flag under the lock as
Baolu's suggestion is probably the answer?

Thanks
Nicolin

