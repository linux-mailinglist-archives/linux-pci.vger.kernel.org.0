Return-Path: <linux-pci+bounces-22053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E920A4038F
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B73BA5A3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921820F083;
	Fri, 21 Feb 2025 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCV8dqKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6D18DB0B
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181019; cv=fail; b=k+VJr0CG1kWKwMDAXnkuEzh7U44bCnnqLXuIl6o5dqzciDbskeyHCTGiCxT2XpuVvB2JHbKetB86+QA5nu3HZrjYgQgw5eaQJBDnkRSVA74X66aEIAgftLT46xHb+IXQ+Rr3NsG+/3dSmyTH137jG/POjpGa74ZqyAsPPy7RKSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181019; c=relaxed/simple;
	bh=a5PGLpgNzOSaGZxe0v8uo3l2bbwXWB5qGZT73yAbBLw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OUXO8MQQue+od49Ax2oxqWq8p+b/9kxj7kKleNvCx+mxW6Gn7kuP4AwxLr+zUtku9RlCKEfGW+6b8/fK5RphSqVBtKJcfek5wrw7z6BVLEqiDijKpITLHFYcHCxzDtMq8jERET6XRwuRs54d8uVq9K/tY0px0RejjVxjaA0hHNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCV8dqKI; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740181018; x=1771717018;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a5PGLpgNzOSaGZxe0v8uo3l2bbwXWB5qGZT73yAbBLw=;
  b=bCV8dqKIraJKtqHaqVvxnAh2YwhTxFTetHFryEXpaQ8IW/ldxlbezyKR
   4LWmCBE+IPtunj8txBtzyojJKxGPTAvBlKcMVomNzf7kADgn5t2JHsJqK
   jZtQNigGBsPQz+/zwcPtz70uFcYgK5N3X+IqnZeEIp++IrE8W5oUsyCAU
   Gyhni6yUekOA0wbOMGbnsoGf2yR7YDWAqP4klSKKRoyJaEEjKWYB3l3uM
   4MioQuzDRFwviEocEtVW/EkzrIkN/Y5YC6Q4Kn6dCyxIeejDLXuP7L5Ap
   Ar0KMUaquM/9smuN1LMeh2uAJKKHrNNoyR/cEkJkfgZYOUjUxglMCtspU
   g==;
X-CSE-ConnectionGUID: o1uq40SRSDinhiOL25l/ZA==
X-CSE-MsgGUID: TgWzMa6bR8ibCXSN6nu0Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44793323"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="44793323"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 15:36:57 -0800
X-CSE-ConnectionGUID: nqzArK8eTQSVZQJd9HHJhA==
X-CSE-MsgGUID: 7htobrTZQwyoPxfqf+u0jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="116029254"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 15:35:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 15:35:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 15:35:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 15:35:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrndTiZ10xATwSvjg9Gf6agIaAfnkJ+YZGPoNj9zBSxVuWbnuX709bnahjNDwb8bM3Th06vKgEPkzJEhaGijRsGScPW6660QjUiRk1yzFsDsqiV6PQONWzqwrZLgsJhb/ej+kptSmn64exHbaLdN2enWlo3nZVSxy1lEi6CWJoGwHItU0k/ed/TqDvqivw8LPpxVgsc8ezGiWV4SqzrFeTrLIezoCzS1HejIVUdhrNHvmkO3/SO1Gzq4prbLGG9VVvBOQRxlSKWOVaTwU3usu6fu/9FXdBcmmfcgGkZUKrpkypE5KmPTjZNNqf5t95oKWZDWIz4qnYbnbzl0wSl0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpSj2saCXQtqv/oO1EKhApo2/8bgyk/vQcJNHJyLBzU=;
 b=uRkXYVgX+tHS5aSas6w6DntR7AzlVWg5i3Ov8tz6jxToti8S+gP72izl7V6n88BP7ivwjdPbWu1rdYAeJJSdrq2eXfq0NG1OjXXqW+dYpu0B5WPw5mUuj2m/OpR3aGzt1EhrT9tImZ25FnU+d/29QXLhB7Rwz+KcR+2UfwnmNjZ2yb6dOlD8cck3Jhs38JiKqMCIaDXa1v29APcNDKrvWBQGwCHi8P52yMvCdbfoNa8JfMjfPKRt2xp0T4rmC/Hh7eFEg3KCeJXXyRtqevIkKHqVELxD28Sp4cqhBqIraYijEWASDxvCG4ypyqCQkuC/I+kfnz0mRGQm+hWGrqfXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 21 Feb
 2025 23:34:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 23:34:39 +0000
Date: Fri, 21 Feb 2025 15:34:37 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Lukas Wunner <lukas@wunner.de>, Ilpo
 =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <67b90d8d78418_2d2c2946a@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343743678.1074769.15403889527436764173.stgit@dwillia2-xfh.jf.intel.com>
 <20241210192140.GA3079633@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241210192140.GA3079633@bhelgaas>
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: b3da32bd-3bb2-4812-1eeb-08dd52d04f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K4mpIFEBKTnaHs15qpGvNPjREA8CHY/g9v4edGNqNXjaa2gQZ3DhnujMvCaS?=
 =?us-ascii?Q?tUuFMEVmvgOzR75y8O9Xem7kjJnXzUbG9dyZktWTRZ4V2MYNkDIK3fKpQ93w?=
 =?us-ascii?Q?K7fMnkiizHZrSFTSe4Ho/0HqAHnjWnsi2d++GbPyLiRwsCqgLVvLs8uNprCA?=
 =?us-ascii?Q?3I3RyS0Gb2xTimTvfJrWviU5Vqtt/NW/qwL4RVxzLKXNzQhoN/MrPwExnuKp?=
 =?us-ascii?Q?alMPu//wjfC4k6w/kGZBBTU8HaB0jmnHujGeubaQGLsJCqy7RU5nHyMgoc+5?=
 =?us-ascii?Q?NAeng83zBDdBH45W+CTVrz8jLmhCL5x7ioZ/OvLwz7U1mrZbpsZWKysquQl1?=
 =?us-ascii?Q?01z4iBtVuyZouAajNvuNAPRUChhGV/9Ac+a7achQr8jpSeclgMGUJtqPVZhj?=
 =?us-ascii?Q?bZ8JG9PmjPf9OYM13ShObs32WwPS7B/eoBivwJeTcpDYA+ytMfQJGCqZgpBJ?=
 =?us-ascii?Q?Pjby1Bg6ktlhhN4FWhTBK6qAtH4/o7MVis7/9hIwkx9KwtTOxrY5FJL24XIE?=
 =?us-ascii?Q?Zl6uJ8FAur8e2LOdJnYwFvTQjorezSW+HOVuv02FZQopraZm++HecKPE7INF?=
 =?us-ascii?Q?KU5FLo1gBGr96NDDwR7IDtiZPMED3oI8/5yfuOsncrOjeJBYmSIShHaNlsPr?=
 =?us-ascii?Q?fLp0IaCjJjjI6G/QrRCMjD+07eScQFprpaTvNxWMjhVFhryjtbSV4i8ZqE/R?=
 =?us-ascii?Q?B2khGxOCwI2MigFEb9qVkyz1HOLwHC1Jhkh8EpI4zV0u1fKrc4vzZi9z/MJE?=
 =?us-ascii?Q?yvR7TyvKnpLSzYWEda26rxNo4afPBlgduAy5feCUPyXcgsMH6zBKXF9LK3D9?=
 =?us-ascii?Q?Std+vBFIKYQj/5GFNNdSTfD2WZcwUwasQ3QvMQMmZfX+qZpXB013PoEiLbB7?=
 =?us-ascii?Q?4Gy+ikFZO9vkcIvUgU+RuggyMwjGhkg3YogPKBZxN8/dKIidZCkwL7H02G4f?=
 =?us-ascii?Q?MhgVvVUXbOpB9+/9+j2I/dJ86ZNYfqhdfAY9yrqsadSQwVuQgNpEQZDhGB+g?=
 =?us-ascii?Q?+ax0Cza0pU9RfD9orn1B7UmM9hd7Hets3hp7q5V9Cwa3SvO0yebpS5JCm8+V?=
 =?us-ascii?Q?bBSZVRWOWTgQtloWr/y4AJftWaQr88KUzC68oJLo6IiuXfc9Zz22t01VxyrS?=
 =?us-ascii?Q?HOqwJb7p2QZkl3AOfruiitueO/ayg4JH24b+rADWatBqUjGYP2BxsWkrkGmJ?=
 =?us-ascii?Q?3/5lyvP2/2te75w6b91VQS6KkXXkECSvRp41kbFFmRm41XVEaCCHIkYnmplb?=
 =?us-ascii?Q?AHzT4nX03Js5oULZEwurNZmpK7w1RRO15/zUWcP4KKKrDs8eVZ3LGJk7K3Gt?=
 =?us-ascii?Q?FSDq3+9l3richX7NPB/UbUccXlHq2LEhtJhK0LuIbJREKDdT1LKauKBLsUPY?=
 =?us-ascii?Q?JrSv41sa7fhpVyH39R/JPXaMP5Ax?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?weSf1WGFkgamOGeyFguh6KVfmREx5L0Tonz/ToglHwrsNKX+9Mj2CZmczluW?=
 =?us-ascii?Q?a/nOF9UZhlra0jIzr6fNM5gV7gwY1yNT7L2tMR6SduP9Cqf1Ake0q5RI7d64?=
 =?us-ascii?Q?gAxFA7Hd0h4y7DNj1WhmuGtlykvUTf3QDqLgNn5TWwAyDTdhgf4EWUFbkj3a?=
 =?us-ascii?Q?QTkPEqDXhl4X1Jfzm2+fx4vm076nUaA5NJb23yyY55g9cXov1UUGDdx4iT/d?=
 =?us-ascii?Q?kGVDRa+57vJ0DgIgm50oX4HzeA9ouCy0KtsCfGMjYYBsTukFSuOR4iLxf6jd?=
 =?us-ascii?Q?tKOPgvJQj1d7SFg9uF8CVmF9a2ZFgBLKQ+ku5wPtzspl1UBqC3zmWucPQNes?=
 =?us-ascii?Q?YWqk+B/WVWMHVP7ysRCnYjXqg6H9SJovoDLQAxpRD2rcdtJ8p0H+sawfoNEh?=
 =?us-ascii?Q?zgUS2HjCJ6pUqTiNE5HL41UaeeLwUBgBT+ZyOdSXP4gfb/Hl/+yeASGzIm7s?=
 =?us-ascii?Q?tklBQ8PNTz3bvhbTR6taeUvqort0Yy2ZfGmU+MjqhphGJzPjURkssoPhATZk?=
 =?us-ascii?Q?egJSvNTZf6ZvKm/ALz23Spw6sDinvRHfwL37yFRMEsjY6k/JKey6cmOXajUB?=
 =?us-ascii?Q?HHBkWvV9GpgJx5nrcf+/T6xOlkXy02+afcoL44hOszxQpjbiiZO+ljAJgGEC?=
 =?us-ascii?Q?QKJMTgR0JnQh4+OqTIneNKqTwuF+hQNN+0Q6Y4CbNcgCzcUCN2+zyfA+vrgY?=
 =?us-ascii?Q?5Ua+mZrZJ6zHeJlJKy9RjBpjzzS/BqQkfcRA9FtMKm+MvGxjjrefS6MDiK32?=
 =?us-ascii?Q?N/EwcgS6++8/5Ulmp0zO94wHGkTuXUCiO/+vSR7iCOlb4/09lyc+AjQzrjp0?=
 =?us-ascii?Q?mCzUZVGqKfzSSF+UEOU2AhGqsmIxAfkY0xk82sW+4sRTBqPjW7y/b1mspAMN?=
 =?us-ascii?Q?5bFzz0j6YSSCxug+9uCa8DaTp+xZa6iJiWYCW39fdXqBz2Bir+DPj6QSkd4W?=
 =?us-ascii?Q?TlED92atd3tdjAIPqx3QffAehp0tDCYuaFAMCs8ztu5426dSm3f5Niesf90Y?=
 =?us-ascii?Q?DkvvM0WVa2SBXCEaMeSrVDL0zjqqm85TeoCkFTZGqP6QFjJS0Wmkmpgh9Rk7?=
 =?us-ascii?Q?j6cqf++Bmsi14flFzqpD/+fGilTS3ADCgpX3aI/sAl9Fve1k6bc2UdERS90p?=
 =?us-ascii?Q?WSHc9j9aVsTLPGx5/P6bIFWsoHfNqph9QlzOpvTo6DBzIUUiYVfUic4ZhENB?=
 =?us-ascii?Q?vVRk/N6M/HYpXr0lJmXwfCcNdRXignWBqhRpkswUNJRGJVHLjMybhrwYGf9g?=
 =?us-ascii?Q?JNj2ftk3xsVh77mc34xkSUi2q0thyT5DyVNi5gfSChzVvm9TkIE7Og2PnCxV?=
 =?us-ascii?Q?qeuDRRSk2N+doARR8BaKqZABf2Z0JqQzKEy02lpe3+PK1j3H39nKkIrVLWc4?=
 =?us-ascii?Q?hcIbDxlVpwvufDOFVWH7OHGqPUKfXNReFUz9dsWKdb97MrX19vayZBqGgK5m?=
 =?us-ascii?Q?c1GbBgKRoqcadg9JK+unrpVKbx7kahwncP75CQ7M16Q3AALP6xDpylThjtS6?=
 =?us-ascii?Q?30XAHCuye36EED2ZwkOUhuKVAr54EwTMWY7JM8Sui+0CA7GWIZkLiZwlfMp/?=
 =?us-ascii?Q?AOAqdO2NITTuOsYE8ecIhSszi1cV+LGPY7L6PjuyL7kJ6/pAsswK6YNE+WyT?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3da32bd-3bb2-4812-1eeb-08dd52d04f84
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 23:34:39.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeESgg1Fal3J6Nf33Ufp58DFSZyNcOto2EiFXluK6AJ88KYMElA9bpsHoC0iIFQGrClj1vwcrTAYBi4DLbo24N22d69RV2+fiEjAIMboyQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Dec 05, 2024 at 02:23:56PM -0800, Dan Williams wrote:
> > PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> > enumerates new link capabilities and status added for Gen 6 devices. One
> > of the link details enumerated in that register block is the "Segment
> > Captured" status in the Device Status 3 register. That status is
> > relevant for enabling IDE (Integrity & Data Encryption) whereby
> > Selective IDE streams can be limited to a given requester id range
> > within a given segment.
> 
> s/requester id/Requester ID/ to match spec usage

Fixed.

> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -749,6 +749,7 @@
> >  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
> >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
> 
> It doesn't look like lspci knows about this; is there something in
> progress to add that?
> 
> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/header.h?id=v3.13.0#n257

Alexey, do you have plans to follow up your IDE addition to pcituils
with this DEV3 support given the "Flit Mode" detection requirements of
"IDE RID Association Register 2"?

