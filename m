Return-Path: <linux-pci+bounces-36892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222BB9BAE4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B37B348B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C232E4254;
	Wed, 24 Sep 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ru8dn9z8"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9D263F3C;
	Wed, 24 Sep 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741777; cv=fail; b=MWTrkovcPX2C694dnvXuLsN3yHegB0pxRcsyAn0X2J/caU+6Y4edELded9pPinMh7ynkAtbYv3ajBHgBD+kY22iXqiC5EvONF62yswf/SpmdpYFLpXZml3yJfoOMjwVOkczkhXz6p1hYFODhgEGA4XHkJx6iNQxvjD5vpec5brY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741777; c=relaxed/simple;
	bh=GrJfbUqC/ixQxgH+pF15JnXV+iapy3lU3SS+1iriDEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CxPmyRyv9oV/1XDaOCXdUPllPJw78T6dZ+orb/qu65qcHM9yPSOc/7WmFE/gA7Z2KGYjY3AKFapQtHmjnhu4XUbYKLxnenuGDIWzCt5o4NMiPkZeqibH+5eUQan2usHvIX/lnE19pwn+YHclu+6L7O9j4kgyIRCUfFzksmKStlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ru8dn9z8; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVAZtZ0+kThonDa11n+QiQkWnXH+2YaPv72y0Cd8UX4RV4QE/uMvBJ9ym6PJoscOuUmJy1lcvYAMVF0xC9Cpg8gdI0fjMLKdnXa+1Px5fUhq1KoO7LPKxZVwHFDwXsSDe31y+zdXluK2nORD4QwNGgga/Sf5OHQGYrAIOXioBgokdgUq8Eud3Hr+D/qal38IhIpDM0ZlX22/ZvC6X87GiqOMpiA9gGpOUgUrzs2T/gwdxrpkoz2m87OU5320o0F62fT0yny7Yy09UdfFq8R2jc0mq7Nxw3tXYnsd7FnJrSEZkuhOuE7RbCgEVKb0Nw82kEa13rItxF3ua1ad/xmnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Iv5bwT+c4OjwCRiqZYTJwYVpy/ysyCcg9hrNpncSTQ=;
 b=TGJNQaziqKYW1GfOw+wG6IhUr70EfEmxhJrjLaVtw9heeEIgTfjXZSISxC/aKrUi5EmD6BZF51r4wTP8sD3wAkQF4O5NSApNywheTMHA4B2AmzyHo2/tPrTLy2QO8RaoEA1kjPHJwRQEjvwPgzqg1L6Rdi7Yfl18fcMzNaEbHQ2JfocMICPwolMiKjpNlFDqMUOyzcsKDASijb/yfekO7YR7f0WTcGOv96TXVM0GgJ2i3P2yLcX53kNksEjKXdhsxAtxBKKp1kxSz1qaH56PkEnZo7Qli1Ek6aVZGpY4D+ik22FIa1pXVN9ZJoohtqDI3FYz4NANRFq+JFgjPxM8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Iv5bwT+c4OjwCRiqZYTJwYVpy/ysyCcg9hrNpncSTQ=;
 b=ru8dn9z8rbSKD7dlBRmYkbA+tXJT0sc8r/SNDc5zJX4vHkYqovdNFyojTszdpGooXHzresKFeV7ujMhQZcqBPMpC48zCMC4B417rfIXTD9beRu7KivyvRngPWYAydcP9c2A1TbGvbwmDVl15W+Z3qQxC4aNQJ+fshi/SpSXiee/YF4rwLQu1T7EgJf6BmKRcC2DEOpzyJMcpokU53wjvhfDJadhGzbOMvVVIBpJfJ37Y3pL7uXYqRSlpx/qobKmevRK57iCzwdGO+8ZZgx9jH67AuJllCxTkgjfWuUpwsRktiOD/xdPhn+OPXrfvHzvEd7RFOvVhg/2Pcy28KkNFCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 19:22:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 19:22:49 +0000
Date: Wed, 24 Sep 2025 16:22:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, bhelgaas@google.com, suravee.suthikulpanit@amd.com,
	will@kernel.org, robin.murphy@arm.com, sven@kernel.org,
	j@jannau.net, alyssa@rosenzweig.io, neal@gompa.dev,
	robin.clark@oss.qualcomm.com, m.szyprowski@samsung.com,
	krzk@kernel.org, alim.akhtar@samsung.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	yong.wu@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, tjeznach@rivosinc.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, heiko@sntech.de, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, jean-philippe@linaro.org, rafael@kernel.org,
	lenb@kernel.org, yi.l.liu@intel.com, cwabbott0@gmail.com,
	quic_pbrahma@quicinc.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	vsethi@nvidia.com, helgaas@kernel.org, etzhao1900@gmail.com
Subject: Re: [PATCH v4 4/7] iommu: Pass in old domain to attach_dev callback
 functions
Message-ID: <20250924192246.GK2617119@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
 <20250924184346.GI2617119@nvidia.com>
 <aNREE5qMJRU+0+Bw@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNREE5qMJRU+0+Bw@Asurada-Nvidia>
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdd5966-c4dd-4dc9-2e60-08ddfb9fbfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DJpk3apvdLdK6qEpvZnDAq7ic+TYVQtU0k3yPF0tLSs5KAMeq9b/uD0t2ZPO?=
 =?us-ascii?Q?8gEjCRUFuJ9htydLX8xMfGtSkoAmxe9ZK+eAOtgn8Qw93Edrf63oy+K8vog4?=
 =?us-ascii?Q?NmMfU+x+fJoSuTty96KnIJ+tRWTXcsS6wPzmBIZTJI3I3+FkCh95cZ/fsKvu?=
 =?us-ascii?Q?6o9U4sNPvKrnzYtGLXHOeSMFE8IJJEqUDdJELTaeZ2OPAqwXduvdozUxti1g?=
 =?us-ascii?Q?y2vvrT/tIbyCPQXh0Duowq4J7tIbwnhVLsF9zlm6znQSFqS1qTikd4+MIs37?=
 =?us-ascii?Q?Nj09xHUkFGu5beBbzaj8XwYfiZuQvUptKO0svc0qfW0gqaerqhX1jOotM5aK?=
 =?us-ascii?Q?R1k3xWCIxG2rBqidtrONiX9SBW6FoZ/6eLN9oSodbvRlNmICp3MSPTFk/6j7?=
 =?us-ascii?Q?2YUd9YZjB9huW/TIIMpz7f3+8OljOQJ8UIKUKfXPM9GIw+AYmFz54fp/W44J?=
 =?us-ascii?Q?3Om7Je4bmqNUC5lcqyrk8lHad0SfkwuTBUwd5PXk6hQGW1t4Abvrt1y1R7/u?=
 =?us-ascii?Q?YWNswPg9SD+fXLFxSI/KQtPqOjJL2VnK3FUfk2FykvaDbYuqMQSYO2nrjiWC?=
 =?us-ascii?Q?aVpR8Zlz2Yeik7lq11wN/cPh0Fgi6cf8s1Y7Rq6zpoKyoof7raVE73SxWsUZ?=
 =?us-ascii?Q?dL3rVATKUR2TZ9el7rLR7hkqbnj5ACLlKEVDMV3tyf306flk5SSjatobjPo5?=
 =?us-ascii?Q?qwz3f67byF4NaRvxhGzoPiQSwXvFjKvhulNNBlaLaUp7YElC7IH9Zpi/mW7O?=
 =?us-ascii?Q?/mYu3dO438El4hAtrup28NwoYIpI6i6+gKFf+nesLb+YElQ9Y+RdFqauW18v?=
 =?us-ascii?Q?hwgsYkxXB2LC1CdP6NdRUMwol13+1SBc97iyCQXVWkHhBvRhxRJHQue6gLK6?=
 =?us-ascii?Q?MoQZkN+ytn5NgkGFP5DLV16tvXdeyLqRNOj+atRuKLWJAt0MpguRhB8/mEzA?=
 =?us-ascii?Q?VL2vfIX90pTssLzdIiv02vIkEZHLqnu8bsvq33jyqe4GW12uAjLkKNFh2q36?=
 =?us-ascii?Q?9bD/MsXm1uozkVTOvYmY334juPSDugEi/DiQRqm9UIU39hthEJIarl6OlGvk?=
 =?us-ascii?Q?1pHX+RQyy97+VIhF5PCoP01K0/jZOygoYeOGBx3ZL371XjHIrPbtydKxcOm0?=
 =?us-ascii?Q?DHF0o48m/LnNXJKvxOiIx32QLHdSLszBFswgV+9yAjK4y0oK3VJD0mP15lSs?=
 =?us-ascii?Q?ex1ghd0JvFa4nXwDm9UjH4HjJUSso1h5Kqa00JeSiRujjulu0CX7pdzzCOPt?=
 =?us-ascii?Q?MFyPlK9N9CRVSgK0xazohFd42BCp/qH3lDZlFtBxGXbu3GA34IKWcMVxljNM?=
 =?us-ascii?Q?JwN//IuTvHr+/er7tze41HyUhbxrsk1CuE0kas5EYcMYuZnsN3yKlbgblJIJ?=
 =?us-ascii?Q?QsUqOQxyG0X4KMZxz/qC7rq2zpBS7n46JcBSlpTRzclP823+J7oUVbxyRQV2?=
 =?us-ascii?Q?pVIIbDZRupU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+PdLoH6bGeJG20/b/NDqWLEPT7KXFHuvXqaIIF8fxQGPHEytFQIXeEp9/sE?=
 =?us-ascii?Q?84VHlgVEALrOXUU+qBAenI67cORQ7zfjeWKf/qV9W4HQzD4oCQCNSNfQAWod?=
 =?us-ascii?Q?edkoAXIAc00N3dAKRZcVgyQXzhoYb2VDV0Z6TlgDG0+/W2q6J6KDk/R8GPXV?=
 =?us-ascii?Q?c3eGtYRr1Y1bXz54P5Key6m3OnKAneXlgbjCzJnkPFEh+GN1j8DCYRfqcqS9?=
 =?us-ascii?Q?klydDolhaANdWwBJE+N2MzRFfh8nDNk+yIhvI1dLeCPS2Y80DMoHG+FjMRrB?=
 =?us-ascii?Q?T0GcbBJQ/8IqiW4jXoOM7oG32jQDTFlDEm8btzX/5fKZT/NfyJIXmhW03Htc?=
 =?us-ascii?Q?zluDel47rjnI8EtF+qQGOi0Z2LovxrZ1QCeIW6ODFsXa5ULG5ZC4ysn+2Q6l?=
 =?us-ascii?Q?JBYh+yRbqLZdMUPKno+0PaF8qLjdBSBfxl1v9eLycS1+7EXIyZr2sltdWpBU?=
 =?us-ascii?Q?9aaSXAFUoog9rFi5kxUEF4tkCsYZpuOtlr+VvJhHaQOhE5ysGo0U7wMbJQ/a?=
 =?us-ascii?Q?ODcnbDXfwcRFZ5MoiGBPlEu56lhNX1cZ8pOhcBBUSWc8NtAYRiKmTnCWUl27?=
 =?us-ascii?Q?ZY0GbigkUpzNP6I4rYhZ/BJko8PhCyNZN3KUoFAf5QzDYdAq3LfXwISDYpjH?=
 =?us-ascii?Q?fxU4duJ0sBeeXhXuk3i04GRzvrKbRh3/NStLrGWID/2mK2Dw+tCzShvy8Dfl?=
 =?us-ascii?Q?XSmgEljY50stxDS0XY6FGZCGYhCd2OklSgJhqYokVzv/D2BKatuzJkxucF8I?=
 =?us-ascii?Q?vBV2DehCHvldpylXpZPSQUbrCg3eqNT09HxQz8aXKulYkMPv3IgSn4ADijWm?=
 =?us-ascii?Q?eyHAhu+mlLnQ23ynf38bl7Pmmj/vKPhqZh3SEl91nk9LGsu0J5mEtzPr8or/?=
 =?us-ascii?Q?TETI5uJ28YbnlzVjqBQmBmkkM2ZJvuYHs3xKH+EE3ln4i8kLbRWrYSos48jZ?=
 =?us-ascii?Q?L/Awv16wi/y41Pc9wdBxtDF1ibv1FyaxONrrUmg1XWDzhWZu3dYXJ4XMT8Dq?=
 =?us-ascii?Q?IoD1bs5mqCcVVVEcpjNrtJY8IUp50x3zxTshnxCcr9I4MlttlHPgF10YICVo?=
 =?us-ascii?Q?l6NW4sYC22yv8koOkr6QsYScj3RF/chIYS/ppjW21zeznw17W22Ua7MWif5Y?=
 =?us-ascii?Q?4HvQb/W4H49UWKnCochrS+sxreTmp9YcX2niNz/Si1ZAmyHUGWk/Q6WwZffh?=
 =?us-ascii?Q?d7fph8l33n91FS1G3Ek9RxQ8hOVKhcUDtsFFbBCi4/bogfsGOqhFKvcs2ccI?=
 =?us-ascii?Q?VAfXi/JBsdJT2i7rfbZip2WLo4vnCcmJUePT9398N7BPnhDnNYBU91t6u3rU?=
 =?us-ascii?Q?6qnk2tTpmkoZEFeDei8aVcJkWvG6evuJpLtSnnpK4FXueJUoP02nSRrEixvw?=
 =?us-ascii?Q?rfW9vvwehrz+5PkWN5Z6RhS8NtNrASorNDXP90aJXYTqTkuo+HGxqm7GuG2W?=
 =?us-ascii?Q?Th4rXedJTIcpExYIchwfWLWBTc4EmE3WhqNecRh7rbZcg3MovtEvL4/qEM7/?=
 =?us-ascii?Q?VrSzHI6j9yawNYmoFGnz+P2aHzyBwtv9PXBumpS5PR895NwXET3dRsy4EVmw?=
 =?us-ascii?Q?IwxA1eIByvjc0bJmQKZwmie39PykeS+z8GaDKD8L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdd5966-c4dd-4dc9-2e60-08ddfb9fbfbb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 19:22:49.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAhIDaV4liUTqtPVLo8pa2nOfcJPHOsJjCVIZD1lGcxIFaKIuScPtx0uQ2ES97f4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283

On Wed, Sep 24, 2025 at 12:18:43PM -0700, Nicolin Chen wrote:
> On Wed, Sep 24, 2025 at 03:43:46PM -0300, Jason Gunthorpe wrote:
> > I've split things like this into more patches before, but this
> > actually isn't too bad, so I wouldn't push for it.
> 
> Thanks. I will keep the flow in mind.
> 
> For working more on the new test attach op, I'd probably keep it
> as-is.
> 
> > A series version would be:
> >  - add a new op 'attach_dev2' or whatever
> >  - Convert all drivers that just change the signature
> >  - Convert drivers that have a trivial iommu_get_domain_for_dev()
> >  - N patches to convert more complex drivers one by one
> >  - Remove old op attach_dev
> 
> Does this mean that drivers would live with the 'attach_dev2' op
> renamed from 'attach_dev'? Or the last could rename it back?

Could rename back, often better to select a name that doesn't need a
rename back :)

Jason

