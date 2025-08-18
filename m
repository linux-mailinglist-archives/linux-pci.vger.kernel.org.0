Return-Path: <linux-pci+bounces-34199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EF0B2AB8A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DE658688A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14D31E116;
	Mon, 18 Aug 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T4hWLo32"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F321773D;
	Mon, 18 Aug 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528058; cv=fail; b=aOcxKeUbHSqlZwN0LfxYDXRTOYbRt16C/E69GX19spVX8ynMSwfvFKJnRzAFU5/KEBQoBposIT5tjCAnK6ZoGVIWwRZI/YfRx85ndzja7xtQFqx4Cx+o7P1LCg4wFtcw4HnyjhiEIhfMvGx6tpLSNZnH9ub6uGv0uLubAeW9Gb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528058; c=relaxed/simple;
	bh=zk4kHkD4qc56SNF8M0SYlq6+9z2CO+E7k8Kg3ZRPmp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FWLlvtwyVegZgRgfCpa82UWC3HgEwdrhadMdZFM9YV7/3JH4vYM0zafmj7crJttLbaeVKaFXnfWqBXkJ02zH/VwOzMZtMqDMz36zOL9XcMTDLAgFTsNT9ggyWb9wqXhdcmxkrvJV65GSWHqozxz0o89vK0ZusU/of3LNqslDcoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T4hWLo32; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wf+QnQlg1AfV6RPIYbIxHzLZvX3RfMSS6jxslBSKLabSEBVcTtFNjZKXvl/EShnruDKUqvq9jIWDhZwbsnsouOaW3biDmUX+AVrLHYRABgWabD7DkTWO8a0+kmJbKJnGBSIDzBC/XuClcIflWxfv+SsPgWQ1SLNXkPHk1IssEKbpGxrNonjL3xbhrDperFKJdq7u+j6DMOoA6qfnitgHXotqyaoHLHUWjiKsECV5yWhQDjcSgo8O+5kmwPhL0t4zvk6VokVNkT+LIMQnNbjZ2PiYzXf/EDPpzgZIOWfgMQ8xTJm49VdVKb3hasbyMWRP+VC8h1ulKkNR0miAG36iHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk4kHkD4qc56SNF8M0SYlq6+9z2CO+E7k8Kg3ZRPmp8=;
 b=nB5AbpTnSmhJbOItJuegiW9eMMZ2us/DuTmHS+JfG7/2Q5VGhEPE5lK1OuXVwfxaF7SfgA7keShy2yzIYOonP+9DajhyFBxUDkJcKZgNPZ8TJeW1stSQ2Um36vbWBw3g4K8q5X+1/sv6BZmx/HVuJcvHXs6HGU9e9Mn0q7e3vJwl2loU+9FEIUnnaGXc61T2BulEG9K5dLCR++VOY54/TB480Q1AaBDkW+dyiwhvDw9W68AfY8oz1IoL9WGmR0HWFAxDZBhrUL44ZBAuuqQxlvJYvEn3K9W5doddLdJtdFD+Mp1SGB0nRjfHrUhi0lTu3he7c4FvrqmyDAzVRxtUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk4kHkD4qc56SNF8M0SYlq6+9z2CO+E7k8Kg3ZRPmp8=;
 b=T4hWLo324bQTlso0vC0K7nu0JvTdA4xi0QN2F0ZWCH0vzzNlYG+l+prmaCfBq1uRCtqtPEhNhghYFA/z+jeM6dW4m6Ja2d+ZMnCptLY/xViX7ckEJUlZJSDHgAmUMwU8Zo32Z4+p6L+C4TgX91wrf1XxHXI2vQ4V9wXqJIGCkj7DyMO/P3cuB5xq8md0bq80lj4kM9xZehaU5vy9kkcB1ukdVxrOYoUBUoYh4Bn+ozLw9M/o5Ft8gjyIZ69avCOUXI3q+rS5roS9PZf5cE2WTjuFgsR0Mbp2GI8apq9TwNfDT6YIBVqy1XeIovJPKggBVa4v/Cb6dfx6VXXP6LVXtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Mon, 18 Aug
 2025 14:40:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 14:40:54 +0000
Date: Mon, 18 Aug 2025 11:40:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, bhelgaas@google.com, will@kernel.org,
	robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
	yi.l.liu@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com, helgaas@kernel.org,
	etzhao1900@gmail.com
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <20250818144051.GP802098@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <aeb04f91-ffce-4092-8dbc-17d116cd7c7e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb04f91-ffce-4092-8dbc-17d116cd7c7e@linux.intel.com>
X-ClientProxiedBy: BYAPR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:40::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4a396e-c398-4a45-a8b5-08ddde653c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IQckryFAjENWddx5TCU7fyBd8PLDncG/8POZInB6i1rJlV5Bs05x5hiYgVHf?=
 =?us-ascii?Q?/o1fXEzP3ovPIqBfDHRrLfg4H7QLfNTBeCZhFgb3zkWg2sz5lVCYa4tcXbCo?=
 =?us-ascii?Q?pDioJHjaE9WwIO5oOCGcDZGfEnZMX3m0EXPUJF//s1BFWjqnnLIMJI13Z+22?=
 =?us-ascii?Q?5YpLCu8nK2sy+a0z4mf9FtiUFk4PsOtf2oxlusqbADvgYQofQK1uuVBg86kq?=
 =?us-ascii?Q?vYJKQdOo28Y3N7tJ3jxsn8LHIpyGTmG/QWHTxiYkMSP4OIsKL10QzE5mmg52?=
 =?us-ascii?Q?VHC2Qn/pzaETupKdvE9dV7e4JQFJT9LyaKUeCg7wjGuJjaogmkg8WBRWU1tZ?=
 =?us-ascii?Q?LOfrdNlPIGta2nzF2c3jE1RUjvlbazYw7XbMEq189Q3GxeQzkFVEzs4rxcL6?=
 =?us-ascii?Q?r94U9u293CkXIqf1RIkkJ8Za58rWxuL2ZNHI9722rKRB2hF1ego8fI6+uVdf?=
 =?us-ascii?Q?tcWF3r0sOd7OLIlqK6y7rgxOOH1AvteUQnho7ICBs1zbUccUBu+PIgnysCEO?=
 =?us-ascii?Q?u+X2p5KdvJYrd5hWFXmsjannhgeHo51c/jV3ASly6ftn8oPk2m1/EXvbCfnE?=
 =?us-ascii?Q?NkqU0O1B6+raG8duOzsFJ01BQONsij9uDwTS/MiSpCdgsC2mYi+a+jsny5qt?=
 =?us-ascii?Q?rCI1WjhFDv9yXyiXcDOMboYiRneNod5dVL/48lCNe+enML3YnhC0M+utJTwY?=
 =?us-ascii?Q?KK8GLC41i62/w6uq3x9HoWqfzVdTy2CZnJZYpzb1KmC2U4iXX5m7JzQe5SWn?=
 =?us-ascii?Q?EZaqQYd5eUbg0/+LCMiwKAs32Jurdvcjix5Pg1Ow49onZg56wnvXAfPl26vw?=
 =?us-ascii?Q?ULiXQKkqiU602iwiWj1SK/k4hylynT4JLAnCoy5PchO1qReL2n/eTUvFC7bU?=
 =?us-ascii?Q?1lVN+KMjgabxzfYJCiI8AYMR0HT2XIcHmw3wgfi0jZAahMKtBI+H7MfmRBS8?=
 =?us-ascii?Q?oY78wD0fiIZCgk6v6DCZG8/5C/FPSPcN92Iicb52lEkW6LiXckLRnWl/uNcj?=
 =?us-ascii?Q?XBsPkizHuUp0ioQ5ZiWN4ThXfQVL4nbD0N9nyyZN//fSNSurTYItx7MhrhMb?=
 =?us-ascii?Q?9+IYZzeWMKmqvYzuPAQiCoY675jKJQQvxuZMF7UENGpnxK2n+QKyUWU6W6rX?=
 =?us-ascii?Q?HLJ/Qr0E3MupPLUx2BSMi/+8OioSKedBfnWZE9pJzX346a9QDNbK3fsYT/hy?=
 =?us-ascii?Q?BNrHSZOcYGVAAsVARiScNQPeIvFSld6OJqZkCkSKiwuGeo8Vp2HD9efF8gaz?=
 =?us-ascii?Q?Q1mWxm/mDOd0kOMHdBFfJKVHr/kLcDyi//Atw4eQL9ogOPVa/tpgtaVFQCwM?=
 =?us-ascii?Q?JVdApX6/3xlYJQX3Pp2oa14cRHzQIrrEQAXMiu1SE5rdlamJb3AVz7h2C0TG?=
 =?us-ascii?Q?Px8vmoAoJFbu82EzWRPKxF9LKg08FGf5s8J1zGv1q+kpK/EAEK4a1LPthouR?=
 =?us-ascii?Q?ChySmyxgu0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOFWn7Gmb6gK32/tX1nbeqMQJ79Ixof+yIjj3SlRgUXA+3cvojM3NmEa8ZCm?=
 =?us-ascii?Q?CVcjY/wrG+ssu6MhgutROjmngCpNwBFtKHi9RhcmzxmKz6nHx1Y6b53kJeEl?=
 =?us-ascii?Q?EsgWRlKKsojWPcy60LdjOKWnhudedmX6UZwlKCj9UZAEQCUIJ5ugQxSZVsEO?=
 =?us-ascii?Q?6R/xsLvCm/JKmGT/Zj+y4WMtssft3N9nrkdvVmpnHBp8lF7o0ngtEVSkXWeD?=
 =?us-ascii?Q?uS+v1qqHITGaUmqj+7IqtWVDdzVkubYhoqDymqJ+mYsqxXYWzySg+DY2CXsL?=
 =?us-ascii?Q?mRG9+mi8tUP6ljfxtEFW9h2TRTju4BK5YwdBpx5U2GAUxW/hEvuElEGGk4N/?=
 =?us-ascii?Q?ZuwZeo6/COyUWto7dCoS1NzQkWZlcwW/XphlhdKgHilsNXQmc8O0QMsht61f?=
 =?us-ascii?Q?u0/5jp4kpq7r+YmGSGLDzibWM58XIdnlIomefAgfRJYBCcbdOIRokcKqgUfS?=
 =?us-ascii?Q?3VD5N+BclNuOCiBT20Gj4EzYnzy1BSzRJS+xa/zvg7dS8Yg+8ndmTbdXNqix?=
 =?us-ascii?Q?L/49ItPeKr6zYSBXMmlIniGFnVPiEIKRCRXKlgrpryeQjduOT4A/QRlmH8RZ?=
 =?us-ascii?Q?8fy2s5+mcarSF86ZN5BFgRXV6phNBbWmdwpVL3bnwsLOTb7xTtfsd8GXyj7X?=
 =?us-ascii?Q?vub5jLmfFvlHd7ZVduPQtPPjLevoe7FRIWubkNMJUVzMVVufDAwmuxL2GM5X?=
 =?us-ascii?Q?kz+LVTd7rwLMIKM0tyxRPKlnz0rJbQkSEibePb29Q6Yzm5m9nzvzdUkxWuU9?=
 =?us-ascii?Q?r0WeYeYj7Sj+OZoRCsw1k0dADf1a6pj5N0ZnKyXZ7B98oX7/rR9pO3vLbU/Q?=
 =?us-ascii?Q?5xq7yjdTSu/5DjA7vMJxvWnNRu+o+xoYPrXNOkQ3rppoIQ731KH4EepQBEOh?=
 =?us-ascii?Q?e2Mv8SvCwagQbgb/4+UVNU3w7kJZzJQ3F27UKf5OBuWrE9hcOprYVKJryV81?=
 =?us-ascii?Q?F4IuYN15ki0X74GSaaSRq/7vXas/3QU/VjQmDExvrcqDVFB4REGXjY9vkImx?=
 =?us-ascii?Q?gMD28VW/mMS8IdI4pHjbRgg6J0yQDb/74u+AC/ZpmYi7iT2+2GARO5nZ6g/Z?=
 =?us-ascii?Q?6/OkrZ3SM9IWkYiPSexm5SFtlPHmcKC4AZXmbLzSNPUjl26PseoUmWRSEpDb?=
 =?us-ascii?Q?0Iw3yro4gBywQs1nwAxjZhEo2C/KU3mdrh9TMcFYl834jT7AAyf9iPdyumZx?=
 =?us-ascii?Q?mdO5Rg2swJuAj+YznUlQPWV1TlqAVCXIla+SyPoIr89OIETUT1wKPJwDF0mz?=
 =?us-ascii?Q?B/qikp9hbMkDxnIG+BzgWQNFSk5cr+mSr9UDALbTpKfKISU7/Rcj7dPHVWcA?=
 =?us-ascii?Q?S5s7OT2Gz5PiwtwIguXzi0DWCVHjRIAXXmJTQmsmdUxWGQ7ubw1jMu2ocQe6?=
 =?us-ascii?Q?gflH/pEsKa9E8iCBSKPlcCna0AcBHDXTlwukNayzSpvQYqvnbSpM0ZCq0WBO?=
 =?us-ascii?Q?p+fQE00V7SBmQyxuFIxliTRxDukkNCOxfhxFtjc9bw6iVb6O91unYQ9Nzfyc?=
 =?us-ascii?Q?c/kVj/k8djSzYqMs/Gsl1BlHRoRV6FvrUCiInwjRycNdzUW6l/d/IfIn8u5G?=
 =?us-ascii?Q?FqO97N+Dq5kh1NFFcAkgW5p9q0Klo0/O84TpIRJX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4a396e-c398-4a45-a8b5-08ddde653c0d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:40:53.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D67O7VRQBVvD3tcKIPn4bqOk4Gynq/D5yG5ZReREUJmbzFoWROKr9lH8ckOlefjm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490

On Fri, Aug 15, 2025 at 01:28:02PM +0800, Baolu Lu wrote:

> Given that iommu_group->mutex is transparent to the iommu driver, how
> about

It is not actually transparent, alot of drivers are implicitly
assuming that the core single threads their struct device for alot of
the ops callbacks and we exposed the lockdep test to the drivers to
help the document this.

Jason

