Return-Path: <linux-pci+bounces-36890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A81FB9B9BA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47521B264E3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1625FA1D;
	Wed, 24 Sep 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FmNWHodn"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43025BF14;
	Wed, 24 Sep 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741065; cv=fail; b=pRoGmhc/U/CJkkezzfHQ7tu9lUIwQ0u3D9g48KNn+A/rOYTIZXnPrJRvLXwYdOZP6AcNdsqCAmn80h/jJOML1wO6uoxtFTVE7DPef7LQF0WGOpV6pD4EOfKs1h5wmM/KfNor+04PLE+mZg+GC6VknOUUGrocplmWlseVFmIOJv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741065; c=relaxed/simple;
	bh=jVCjcWD3kNUgTBVyMMYJTq6i5WhjynnYwxGRidT3l80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gZhM31xuqTpKWOCYHePRQUZvmLTwvT3kN+09lYAoOe1Wg+4kNzDXNUg9aet0paeottq8citHF9On2kaZBldq3UhfeiKsalObbTqWFl0Osw8K5FvH17Jhayun/t7gLaaDUMLfIrxlEflCdVs5CCrHLl7ElBaSEdVwU4ZkCm1LOFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FmNWHodn; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tcxsp9kZfmag0+Zg/N3fkT+FWkYYBfm5Hy9T0HT5f/DESpvaSC4FQRkqkN8P+VhY3hhyi1KHbQrsuz5lEJB8+h21UtCMtT8mpTR7Qm452O89UphPhVQfxHBTke5YzkoOhVH+HK+5kEJumTErTqZoIk89zNxOw2GT4WYnVfBqfOsrf0WQe27sgFkhmFr/w/HgvTg028yVTrBBV1aDF7WEsleVzCrHqLrBuEy1xBa1G55Qf/LCOcVaJES5FyAZXmf5K48hthnQerhWMgBCooHuesUc7ah8k5Ezc+XKb4zv2IVmdtT3eWEE7jsuRj6QYioiiI3xXtH0EXJLXQ9N7VMANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUC0lqM7XvxgvD8eQLHQ4KQ33JagX2ha5CD+h5Xdxdc=;
 b=xoSny2YAazsL4Hawnjzdmr+z4cbb5EF3sRsWXfb3rS7oUTSMzltWkccaF5uoKG6asdc1TOC9c6mn7JR8N7i+96e9k1Yq+KJdb/XCPM4Ala6HTs6O7oUw908fCCgWU65A6xi3xiXGFvpULTigcFSGC5cHCyBVB1ROF4t1nE343OhfLrqMTfw5DZ2BlqXYAuVSle+DUqL1UigMPDXm5BOYQlMAjdy1fF/i0b3iCZ/8Umi3eQzL6wTO1K/PxqjjZNa0o/Zlfsh2QLRYQBqGHeZS7jrDSCjYd2/VJFui7KCq4R0b4aAQTPJQd+pFvu1gmfQenxeMjJmyI7mk9627dZPpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUC0lqM7XvxgvD8eQLHQ4KQ33JagX2ha5CD+h5Xdxdc=;
 b=FmNWHodn7u8c5tiKHx5O0dlKNpyKdBuCfZNhYq6CFww2DQpv9357PXauaz0yH98uPUzu13tZ1bGxBsxILG2UTZcQLoUz+l7L9attRdKyuSM+mckAHkLwWVO+sLCWyQr9MOwPN6UglA7j6jeeP+BqlBgmF65pZE9aj1qlt8ueKKycX7NS670sfMr27W1OgABZPTXHwhPji9vR5oqgKRGRdLgopjgx1EcUtbrs+NzExlpyvsiZuB7jdeoZu8KYY6xZi7d5Yq72cQ9HATzN6G3J2OVVQFwfK7K1m5903hmkqWSL3kg1ZCCEp65EwZvIptjnnmQXPz6gfXJNoAjhUWbo1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 19:10:57 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 19:10:57 +0000
Date: Wed, 24 Sep 2025 16:10:55 -0300
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
Subject: Re: [PATCH v4 5/7] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <20250924191055.GJ2617119@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SA9PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:806:23::18) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ad7db0-0066-4f3c-b1f6-08ddfb9e1715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlLQDpNWJHJPiGRFHRiN3OCslDOYStecKhHDR4fOwHK+Lzf7H5dJG87yN+1R?=
 =?us-ascii?Q?NZWtiCPZWsuSQBx8GxDqfwXIYhr9RHZpA1I9vHQI4hdvvcgWMmyOvXwb0O1f?=
 =?us-ascii?Q?JdIGw5apmFEfLpB6BMCHiPEhZVhY4YQGFiKt7uYeAkoXImWvKSz0TMaMv+fo?=
 =?us-ascii?Q?fUhO2wVOpbPXsjMOisi3aerP6V2yJkBY0MeExflf8calWpa9Fjm9Gmw4wca5?=
 =?us-ascii?Q?5NtrNJXOPzllE8GMz9ECDDECOs/Mwea+52XR0kdL8RMD8BxhI7JpQnXVTYBA?=
 =?us-ascii?Q?dZYgw302w3/4AxX6phDhc2sJx/GLIdvWvQeoAXS6NRxZuBf6iKNON2LgBTO7?=
 =?us-ascii?Q?ck3RcLBGHcsFy3q46T4mDAhJ9TvH0po/30wlyFOI7HyG6n6Z5P7/+th4IZzm?=
 =?us-ascii?Q?IH4utmSw2JXKOjPhUU2Sa3RmRxWwrn0lhuLHf+60oewaWjzWJdH2dDxWvGzJ?=
 =?us-ascii?Q?v31tteyGG3NjZMfe75595plQukckA+hEr3WJ2JWVNNeLBb3JtK3TWMhLwomM?=
 =?us-ascii?Q?UZvDXOy7kdkNTLcmz/lk6QGsEoXhP2KedhzzKpMds6Bg2y6HLHNzF7aDV8oZ?=
 =?us-ascii?Q?I/1IqtLZPwlEwibHy4iRS5B5B9UOsqI5wJcA3wlrDKWdZ+QNHGqPXVT25CDZ?=
 =?us-ascii?Q?Qzb9ifIquKQwSWwVGrR/1iJgwIwJUpT2GaYz3G9WAbu49hT0xkCkpxMB5Efa?=
 =?us-ascii?Q?WJFxaw0k89b/ov8E1R6QRI4hadvUkQvO90TEwd8xLPB9Pwgxd47BO94i88Js?=
 =?us-ascii?Q?d1Yu6fdz1oXWAeyDV2n0TDIpinXdRnxDcFvMEWXx8n0oVL3cERDe/T7J7KYM?=
 =?us-ascii?Q?HM994Gy19Wc+bdevpudPBboZJh5QNTFHC+lby8HRgb4C9l0TzFlqXl61S/C+?=
 =?us-ascii?Q?yemPAMn58rGkGyCS0ksnYdtRWmJF7RIG8rR1tZQRwz+89Aobbn/MEm45TGyt?=
 =?us-ascii?Q?HhkNNDvkFnqhi0KqBWjR1BrwNb8SnhAqzDUv+8IcbbGZRUZjAktgrqovSArF?=
 =?us-ascii?Q?W3F2yxl2ayuNa85GQANCH/CFPDCAbAFIiW1PajXe7/DTX7pQJqDlXYGYpt3u?=
 =?us-ascii?Q?NRrCBT6ZINEMO179tbnOXX19PHlK8Mlb3Fc0NQMQe7Qcegn8QnCkLfjHGSao?=
 =?us-ascii?Q?4cyepyaxfkwuLBwq1DRzd+iDceWPwrkRCzW8LHjlCQIDCw+soyweyyYZLZLP?=
 =?us-ascii?Q?BTTWgwzxY3eBk51ebmAeWgPtg9MfH3ztyuJB5rcLd/molwwBWMIKsu7ga9Sd?=
 =?us-ascii?Q?4PS+Vp8iyXaz2+5DYQhwOUMkAuRyxOsTbdEN4hHT1ezbK2yHCplUAyMCl9AL?=
 =?us-ascii?Q?fPfaWmHVf1J0vCVK6PMTYdnhNxoQtzCSVDGdYjf6hcOlpA6/YUJ0Q2OZoI9z?=
 =?us-ascii?Q?2X3WJToeYZMHuYaHFpBE/uod6vOAQcIvCPeUtY1YKrYiBut7mmIclSYXXrxt?=
 =?us-ascii?Q?SlUY5xNPtEosIbwDQYsVAX5vYswOala5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExIWLpnjkEZJ+aUcJfyZglgdyRY06PMDwQrkaG9UwXSJ1u8k24dxdjM1mzcj?=
 =?us-ascii?Q?YMcDCQa31iwG8N8Ukry2KMG9Xe5Xe6UUc/BEEny9GouBtOuaH4P6CBpfxHs1?=
 =?us-ascii?Q?N7KXxvSJOyJaHWuoWKIzMn6s9T2PV9i4lirmswmS9KKnTngg7DFCLb31Nxpu?=
 =?us-ascii?Q?K1p6cyeegngMtMZ+u9XMfrWnshtcCqHUZsVR6hxpankqJxt6Q2dtSe+5o8jL?=
 =?us-ascii?Q?jXv8fxbq/OtlLdjo23T7tESV07FR4ya524WJI/OauaBn5WIXK8gnZdg8K47q?=
 =?us-ascii?Q?4izH5wksdyI6YSJTlrsrKbh+o8irQwnGtihmvGFG51zoFW07YOBX0mC0O5ye?=
 =?us-ascii?Q?L5S+7Kt1a1mMIWUAfHmzCuERjtvnHPg4KH2jmyI8q39YCAJcn7dpUuyF8qpf?=
 =?us-ascii?Q?6JYMg2kMt+Ozec9Mdx9si2MXhMjx5PzRLecAdynxauBZDmiCSqT/equ0Me8q?=
 =?us-ascii?Q?0jwmZRuiBjnNGrTN/uTenUCSeizL458i4YGA4auVSsE+Zql26Na4FJgy/tJ0?=
 =?us-ascii?Q?1ZidNN6TZimCGzEI0pvlkTwuimZRsiNEbTmopjm7c+pCdhLoQnQYiZ3PecCV?=
 =?us-ascii?Q?jHwDjOLaHmBFKuHL+VcJNClk8eQb/DCi+PEIPOlMwRILh3YoUX6FkDEmSb9A?=
 =?us-ascii?Q?9Pefy/LBXutknAkbFFc9OwkwakOf2iVDdzkilU3wHqQkL3PvOqKPT7MPYCiv?=
 =?us-ascii?Q?5vrKSInWB8uD9WenytZoP3k53TcSC4IA5dgDX8zckjb58gbguV3kr4gpPW9N?=
 =?us-ascii?Q?RnVtUVdmhBRGRlDhXvRpUJ1IiJeKL/i8V/WRuPVfrnosdZKcFoRhPFqxyj+F?=
 =?us-ascii?Q?vDvRXW+b9aYCfarg7U0vxxfs6DBOHtvQ7f8Mjkjq2MYjLD/S9yr8CRMLYNuF?=
 =?us-ascii?Q?EVPDwrLXN9R6wN+RJbWrqrtfQRyHCVOdqmXRK8yaqamoUEsYaass2zioNebt?=
 =?us-ascii?Q?DaA2j5uznOlKKHZIHP3mwTfvxWBtuLJwAtMxkRB2Cepjk1jHzQyfcUVhlgol?=
 =?us-ascii?Q?kgd2Ycdqs1WEvf0+Meum0m1zCD1UL+L6Rj7DtfdjDtQXO1mfnOMKpVgRXDGe?=
 =?us-ascii?Q?IKGq2pYdEWc7uj0ETln6TKjdJo0lbN8q7qCDiNVuDwT7gMDNkIjQ+Eu7Kssl?=
 =?us-ascii?Q?saAHpQKBOjBuUlekDmKgAJi72dExviOaDTSEoNdyGgfnqy8GdX5THicj2Aml?=
 =?us-ascii?Q?n73QRDeGFcF1POuOm0XyxEC9KDkmFtqbC47aePmAHhznd7QKk41cyafeIS4u?=
 =?us-ascii?Q?djyp5D3jTm32b4Bn+4hfKFSPvcQKQ+FPip5QxWLJGUs/RSvkx6p9Ej8ZX4m3?=
 =?us-ascii?Q?lIA0ypdiXziZ856Vt9U4j7rdFDfvRL45oHp/0vMKncFgkmNsxwJdyvqp89Ej?=
 =?us-ascii?Q?yLBaJFLJOhLwWyevcT6LB57V7OyBJxIs+yK+LKw7mSzVDWuxbv0NVyn+2sTc?=
 =?us-ascii?Q?FMT0IZ9PzLJnX/40q+BeD98dI7xruigfZz+y48RezP4M7/6rU9PrmOmzaeCW?=
 =?us-ascii?Q?aEN4k2Lp7T+7gyikNYSLwzjiXk22AqB7pnH63qQ2xfWqNQVSMuMYMoy2SCZS?=
 =?us-ascii?Q?5Xe4QuNCmhsuVOOHhqD5tTRBgiJYVVkFxZaG3myT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ad7db0-0066-4f3c-b1f6-08ddfb9e1715
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 19:10:56.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMk50uLh2x0DigDubBOymKgzFMi+m4LRf7/aXlMd0pJEG/tg3WinYIykj7PDAVw0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

On Sun, Aug 31, 2025 at 04:31:57PM -0700, Nicolin Chen wrote:
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ea2ef53bd4fef..99680cdb57265 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -2097,7 +2097,7 @@ EXPORT_SYMBOL_GPL(dma_iova_destroy);
>  
>  void iommu_setup_dma_ops(struct device *dev)
>  {
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);

Lets have another patch to tidy this. This function can only be called on
the default_domain. We can trivally pass it in. In all three cases the
default domain was just attached to the device.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee163..93e82d5776ff57 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -620,7 +620,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	}
 
 	if (group->default_domain)
-		iommu_setup_dma_ops(dev);
+		iommu_setup_dma_ops(dev, group->default_domain);
 
 	mutex_unlock(&group->mutex);
 
@@ -1908,7 +1908,7 @@ static int bus_iommu_probe(const struct bus_type *bus)
 			return ret;
 		}
 		for_each_group_device(group, gdev)
-			iommu_setup_dma_ops(gdev->dev);
+			iommu_setup_dma_ops(gdev->dev, group->default_domain);
 		mutex_unlock(&group->mutex);
 
 		/*
@@ -3104,7 +3104,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	/* Make sure dma_ops is appropriatley set */
 	for_each_group_device(group, gdev)
-		iommu_setup_dma_ops(gdev->dev);
+		iommu_setup_dma_ops(gdev->dev, group->default_domain);
 
 out_unlock:
 	mutex_unlock(&group->mutex);

> +/* Caller must be a general/external function that isn't an IOMMU callback */
>  struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)

Maybe a kdoc?

/**
 * iommu_get_domain_for_dev() - Return the DMA API domain pointer
 * @dev - Device to query
 *
 * This function can be called within a driver bound to dev. The returned
 * pointer is valid for the lifetime of the bound driver.
 *
 * It should not be called by drivers with driver_managed_dma = true.
 */
struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)

I really wanted to say this should just always return the
default_domain, but it looks like host1x_client_iommu_detach() is the
only place outside the iommu drivers that would be unhappy with that.

Jason

