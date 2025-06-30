Return-Path: <linux-pci+bounces-31137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E1AEEA9F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 00:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0682F16BA73
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F4823506D;
	Mon, 30 Jun 2025 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZg6gb3u"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BB21ABA8;
	Mon, 30 Jun 2025 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751323771; cv=fail; b=l1He5scQeA4kbcSejE6WqGZc/XF3OL9o9mRes0l5wLU1c5wBulOtQ7SPIOP7bxpS+pJE1kO4fshvfGVv1GHgHeJcjdzblkzjDeCsxbuzZ1lXllKdKq4ptKWHoP5iwXE5+XZFiEj3jTEStJSu6+xE8sQJZfUel7GwBOomSyhwELY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751323771; c=relaxed/simple;
	bh=wkOBMGakypF5AUvhnUfTIvODqxI8yqk4YjJUQe8NkuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FtV7/UUWFVX9Z4KUrpuR67Qa/YNcqQmSNt6hxNxpL2QPAT7IcnAPwP65kq8dJQpGiZltU84f9YrL8Rx86Ol55RC4FxtIbo2QpUR6QQxImp2YpBTHdoOEbWrI5T7wceSCZHTAiABju2/gvNWYT8b0iDhCXDl8PF8fflxCwZ3eEZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZg6gb3u; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naJG1JhJ+G/S+c8+i2o/Irjw1sThntpmiLtCroNBE2djgXUPkX3Uj8OriMkBSkJYKdUliCnXKo0I0EsP12kx0j1rq5zCZdz3W8e8kXtISVI6tM7o/oZw57b8fQU5zslYOSeHWxhM/ME18R9ZSvmrWXtV9urbpExxk3TuvfIADgkicCbsfIXKM0lRUpjzzL3vLROIt/QkOu7ZH8P4yDMPc4M3AWDi6T1VCCrh87eONYE7SMNrk5taqhuDXlLCRaoG8NG0hTrkx6GH3CSPoKm44O/agUdV2/Jb99/DzQG9cIizCUpInmVUdo5/+AwFKrj4yHYl5EKWKxZevcyQ3Bb/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRycKpLWJ5tBF/0KwEkr5FuE6Utd1KVp72BIqslKH3I=;
 b=vZoESkjCDKKJ9K+Gegc/cLJ14YSgEXH+BgErdJB+othhBRaJCDzFU1x9ac6xDc3opJKeZBQCdb1938302qjIg3x6nnYJ3dG4UakSlyJPujDvH9iopqHx0Avp8/gmxoSkNlzd5hDN7hGF3Gl5RM7Lpo126SfuaLnkZHOGIY4MtBW+x9G3G/4/VLHXStsmC1Hwmye41cqRuEFIqwywWYla1BeYUeBBmsElSs7GFWzSlvnBUiwaEkIdek8cqZ/nnUGGuM7GGlRPhDnZeqDPg+qfrVh4bFNizL72H4usojhiCTwHHh891lmtSQiZld9WFIxP2y+5q+7ciSKyYsgb/ETEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRycKpLWJ5tBF/0KwEkr5FuE6Utd1KVp72BIqslKH3I=;
 b=qZg6gb3u7JxNVHhvYNaHJ6E3XzBRFNXDTkHoR0f53jvUy8FirA/yI4sCHkl/zs9n99QPPW1jHwAnBShgHCguhF+5YHgnhsVNle1S94CJvQm3nJrR5qLCUJriOU+kOp1vt8VKd0yP8AJ9v198wDlItzXT3KNm138qywO0hWsTZ5fBz9zjlShNWzfwd1ByPWr2hLmjkDBwnVRAsgVxG6Gp1ZolPfExZ00dp/e/AFD5VJwQ1eYAGyKmVt4407pKeCJZ7qxhifUId/FQkLRnO48UBOmZ5YTvcJRRaIkeXe1zFYFAD/vnCecBEhBCivtx0v76Gb9JkbSuOHwzSKDEXnW2Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 22:49:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 22:49:27 +0000
Date: Mon, 30 Jun 2025 19:49:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com, helgaas@kernel.org
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <20250630224924.GC167785@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <e505c970-e519-44c6-a316-e5d186f216ca@linux.intel.com>
 <20250630123814.GS167785@nvidia.com>
 <aGLIEhoIiUIjI/MP@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLIEhoIiUIjI/MP@Asurada-Nvidia>
X-ClientProxiedBy: SA1PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bd7356-8d84-4930-946f-08ddb8285db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HuESrQnu8QrK/hBxDch9LKHoljDwvkn1xNrWCqu8u0qu0prAC5cFyiIM7Y0O?=
 =?us-ascii?Q?TQ7Wk4jf5DRU/Ur43YwLS5gEZAUfJu5UABTMz/q3cD7Sj2CUFHeVDu4gGiA+?=
 =?us-ascii?Q?2OOnhYRUr2BTes+h82T69eQazA6FSHUF7HOtpLm9kf2gE5rwDaOdm0IyiauT?=
 =?us-ascii?Q?xmF+bS8qcfaK8rp+ask2mISQCMVm6BC6JaZ+C56rgcj+pgk3tIeigeeWoi/R?=
 =?us-ascii?Q?E3QiETnddRYVCf5DhW3XstrY+YvaPnaqDv8piIuOhadCcGIdA7xsb19Qm4z2?=
 =?us-ascii?Q?2+uTgw0OQb8jNlgMqzj8ix5/ES9cVg28d6AK6B82DCZr1bAiz0rGvC4EMqp0?=
 =?us-ascii?Q?1+lNvIYr3Cit3OfvsS9wyNaiBWiQT+OsrUu5ioWAyPbM7YRJrZQzSKg7xcL7?=
 =?us-ascii?Q?D8SPcg2gnoKehtSbQQwlKGFDb2wMGW9K9GZxp7bdo0xK/nWTXZBbyIAUVhdJ?=
 =?us-ascii?Q?KkP39EEyp6XN9qfzjn6l5VDJu3bKx/15I/GoxWZL7C1iGGUArrkQFamj7fVl?=
 =?us-ascii?Q?dgdKodZEozSTpkxgBGt//IcOrui/oew9VMZbwEUujYCUWBbfKJ1d6ein2PY9?=
 =?us-ascii?Q?ANLn9guLg2MozY7GMvo0wbMwC+zX45a8TVHpgRB4Mb5Sb5o/R3U8kajeZ+4S?=
 =?us-ascii?Q?ERefgj1fl+6vhsm/FpttZYfVRrTrz4PbF3XxQHmKcclXS52dgsGVWXcuNyfB?=
 =?us-ascii?Q?YOzVMXlSJ2s6yF2q9xtGK24vi95O788z3gjuml4edtiRxvn3bNF8bJVWF5bB?=
 =?us-ascii?Q?Ys/kupYL4v4Z0KzHN24NXiRafNFhmaVEVSd5wUTpfBypYWvgCFr4TRJbT9xn?=
 =?us-ascii?Q?d4MsJ2l9pDW19fd6yQQe1ilplvHUR+tDpADp2BSdUFn/q2XpG7WmWBDkXN66?=
 =?us-ascii?Q?wZbtJODCi8G2I9TeiVoTmmRWnHSGWfDkL8HY0Ld0MAoHV+M6ASAoPH5UlG9Y?=
 =?us-ascii?Q?SnRQ0lZPAn+ABAfcXzQTIXseRDGDePKa5dWTnksPzoDLJOfXHA3HhTEkPKIm?=
 =?us-ascii?Q?CONOOv21q6qxnsXTqR0F+6KSH0EPjW5n2pEmXhOay5Ki7j38LxycEbWkOx24?=
 =?us-ascii?Q?kUgeAR62KUQjaiscm5Nuhk2PK1Z9F99Yios1zvt2jeS5PaERMgDKbJwvkHh+?=
 =?us-ascii?Q?XAvvA9wbHuuuKFEwqyEi52ao93XIil5dXFkcBNbwFjoj4i820p0eF1OOECyC?=
 =?us-ascii?Q?8TOXLV0OKXiv6qZBBcLICQ/KN0e8u0LhAaU1k1JKye6EuPjivJJU5lLtnpMy?=
 =?us-ascii?Q?OODgIv+U7oO1Twk6izkaSyNYsvbnGzE7B/SFKjdetZ6dNazffkNfHawMVFXG?=
 =?us-ascii?Q?UuHQmGnNLdKzVeAIlx8GUo1aZrW8kM1Wl3xnfpEN8JURcnfR8f6ibZlaExDA?=
 =?us-ascii?Q?geFXcjyxX++Hb3mpeuXhi/69MjtsgPIKg9AKMIx4s2Y7CPPW5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lE0R/WOPlUYvEJ2B/vBlntoq+a+i2/4IM0bzQtKFAHY7c5UZ6qRpU/9VDHw?=
 =?us-ascii?Q?ToEOYMw7QEitao4VsHovl7QoW//zoAaqb5x8aYi23pj45zWatR7LcjV5DI2t?=
 =?us-ascii?Q?5wiML+iUbg2rBD/ecsjsL56UFAdC5abVjEPe0jhu0TKFkASDtQqeGWusCrYZ?=
 =?us-ascii?Q?+KJfmvT8ACT3fxfob5qOlMIS+TS2R9+m/ivRzO14MyVMbEo5a3nqagd7Efqb?=
 =?us-ascii?Q?e6yfMMMoSS2rsDVtxd3dUSmnnAAO9PFwPOgHRNgbH8dzPpHm+c3wonA9wsvk?=
 =?us-ascii?Q?TMetc+I4VkDTuDdQNL3i+xUZEf3NkrQbT/jkrlwTRGfB3xWCbKcZMvcGBCuW?=
 =?us-ascii?Q?V9xnjtLgkRg203BvK/JZpohPMFWwVZBBvLUXyB6kyedJb30YfPoP0eJliv/P?=
 =?us-ascii?Q?3P2LrUDHd7njkjf9gMX3Xd59yGjY4apRLn/2zynqTgzT67cq4yFQixWHiC+D?=
 =?us-ascii?Q?cW37P/vhqyFG2hMG3sD/s5KiYuf45ZusEKTw8IbghZo3LbQOO/GyqenprVea?=
 =?us-ascii?Q?5BoJeyce/6MssO2g1YcxLRf6ZvjONxm4+vKs0TuzCkp1JVUFwp95dYxYGG30?=
 =?us-ascii?Q?afmxNRt7/DzZt0Pzf98+44pDfFay6K63UZlmdvHGVOjoGtSpUfXubKQ84H5z?=
 =?us-ascii?Q?UiIwiM3kWwgrhpfAV57fp2lYHf6i4+O0uBDds0lRsPOOFkjfklQPsyllbpu8?=
 =?us-ascii?Q?YVHlXNyTINSXyZC7mZyn0MXN8DvaG/Bo2b7O/2Wh1HLpiCrlHW5lIKA1Pkwg?=
 =?us-ascii?Q?c5vlKFDxbpnlrpwGKsVkBY5Hg9+vjPjeeADeVkSwy2bP7gj0HiKL8eeAe3dL?=
 =?us-ascii?Q?E7NiIHVAIHcSoARMRruAm1ZWYe6XoTRIhpTRDUC5YlFGLWBw1ZLU8gaRO+CU?=
 =?us-ascii?Q?CouZoFoyYL8XjJ8vTdp+lL3vpSr4KJqfFe5BDe29iaRkCCEb5h7KvtihdJFg?=
 =?us-ascii?Q?U8g96kCgfAvxjZitreFsXMA4AHhtAR2U9p++1hRBmekSP1HMyKxxwSj4qeMH?=
 =?us-ascii?Q?H3nWgDCkj4cTmFGkRbvzdOPZyOBl54Lux90U91jB/efxrk+HxM2+pUjxxY7F?=
 =?us-ascii?Q?6lsNDMPBjKJ4b1XEZB4JED7Pgt4Yr1fTv6JecA6/7a69qYNS/4HDI6DiClD6?=
 =?us-ascii?Q?5/6A/UAD0QyGTDTrqdyQfTckJ2GfmYCde8xt1aT4JKXAFewMumu4hMEolIlR?=
 =?us-ascii?Q?wCSP06YVA5Mmub0HZLZxUxZkzRSmAwlxzz0J0nqQyjDjUZgexAl5u8faDfuH?=
 =?us-ascii?Q?W/xzctfWBCxFRLzKl/VVvWBZMjQxWmVkJlrqJmd0XYHG86OHiF6g8hxlwFyE?=
 =?us-ascii?Q?ROFOWQ0dJZnHGEiKTP52xUb1Uf11sECo4fEAi/+o5uuWqx/YGdrasqw9QBaj?=
 =?us-ascii?Q?fKBz19P7tBDNwgw5eAGT5liu6qah/x131jleTKhOsbBgLrfgPZ36e+c+UByI?=
 =?us-ascii?Q?QEOM91FV1sfR6MX5lM4P1hCONcrGqB5cpx3d6IIEwUkKB1b3w97axhYsw9go?=
 =?us-ascii?Q?u8tDNsudTVk+CmBIgYDfL9HgjdVjPTFBJ9mKZnVhWsSWhAOQx3CObyG4sG+9?=
 =?us-ascii?Q?4+6LvtUHc8+ZXdrOJxoiSkdyXBbnXlgi5HG01Kb7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bd7356-8d84-4930-946f-08ddb8285db2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 22:49:27.0064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEH9a4EpA77W7ksT+MDOh94G7qlwx82qRF+UBcHZldRbATIWNqrQJnR6vY9tdcDG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491

On Mon, Jun 30, 2025 at 10:29:12AM -0700, Nicolin Chen wrote:
> On Mon, Jun 30, 2025 at 09:38:14AM -0300, Jason Gunthorpe wrote:
> > On Sat, Jun 28, 2025 at 09:28:12PM +0800, Baolu Lu wrote:
> >  
> > > Does this mean the IOMMU driver should disable ATS when ops-
> > > >blocked_domain is used? This might not be feasible because ops-
> > > >blocked_domain might possibly be attached to a PASID of a device,
> > > while other PASIDs still use ATS for functionality.
> > 
> > No.. The above should be setting everything, including PASIDs to the
> > blocked domain.
> > 
> > The driver doesn't have to disable ATS at the device, but ARM does.
> 
> Oh, the code is expecting a pci_disable_ats() call, as the next
> patch will check if ats is disabled on the PCI side..

I would not bother, it is alot more work to fix AMD and Intel iommu
drivers and I don't think it really buys us anything..

> If that's the case, we'd have to leave the ATS enabled but only
> trust that iommu driver won't issue any new ATS invalidation?

Yes.

> > ops->blocked_domain is not good, we support devices without static
> > blocking domain. But yes, using DOMAIN_BLOCKED is not greap, there is
> > a group->blocked_domain that should be used and will dynamicaly create
> > an empty paging domain if needed.
> 
> You mean we should use the group->blocking_domain, even if it was
> allocated to be a paging domain as the driver doesn't understand
> a IOMMU_DOMAIN_BLOCKED yet?

Yes, and you just get a group->blocking_domain to assign for the same reason.

Jason

