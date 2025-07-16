Return-Path: <linux-pci+bounces-32288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E4B07AB8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB533B2AB2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6982F5492;
	Wed, 16 Jul 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLllmCCP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1F2F5481;
	Wed, 16 Jul 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682138; cv=fail; b=lReFnMcc+6B8N6bMxRq7drsDZ3AwEocxAblyply6kSFEzh+t30vnp2H77x6JrsJoapMBCRvCc7WsMqV1EuHC20ilnanGF78PRZEau9Rk8uCHAzin0BMvr5nOcyO7KXv7B6/cRlajEjMxdq7++KNQkcj5oJ1rlgt8d5w1GxxnLLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682138; c=relaxed/simple;
	bh=KuBzgyLsKvBXzRnjQ29mcnilLQl/lacH6YVKPu3i6/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wut6NXtX6f9lkfpRcnPxv9W4DYTHlfAyLBTa8bTYTng2TOgadH+S1NE63esefQndM+NiMvX2yRHHQmWWynWHlbM1jxa2YNzvnvfX38DpUvVl+M2hh/mKUeLE2vx7DOrmz3k0zEu/ipedC3Aqi3q8Ym0x1VUPKXfQR0Bg788vOGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLllmCCP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752682136; x=1784218136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KuBzgyLsKvBXzRnjQ29mcnilLQl/lacH6YVKPu3i6/c=;
  b=ZLllmCCP+9FCbu13c3I6CSMHBxNX9MJXp4SmX/S24XvEIJ1APQda6WSo
   BpW29JiNiWM7AxE7gOx3+Qod9yihdFuhFTcC/ETUoJuwi/BwQBuKivC5p
   C4i2VA0kJNEaMe+T545vvAv5iFAs0G0+H5WY0GQAT2K8Jd569GuD22MiK
   /pCi5Fji/ihG3t3f/ISMnEPBtizMvddA4xOyF7KVmKP/lF5facAnSuJjK
   ein5HSs5hlHAC/hmuGgA5mhk4o/pO3CYhdgYR9+5KGVu8HCBK6a3MG7Jn
   Ky7FtshcsjefB7umyTqBNiyaR7eXhMf3eq9NP77JwZAY3umdiQDn1SLNK
   A==;
X-CSE-ConnectionGUID: ERQr0rpnQtmWti13CEV6wQ==
X-CSE-MsgGUID: /S+syqolRw2JJ7GAG0yWZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55028206"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="55028206"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:08:56 -0700
X-CSE-ConnectionGUID: WQQdGEgzRdyVBM+vj8mVdA==
X-CSE-MsgGUID: xaIkJ0K7TsaAAbFSyekr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="188494783"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:08:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:08:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 09:08:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaUJePvL6GN4utu3u8mNkvVhCz6YQDUImsDX5ADJV8cHRNy5k6OjQnDBMU04314k/1NosdkTGqdHJfV0nmngzB98tuUuLOjU49XOzkux8XvyNcLaMcqrL4kD7Ty4nqfZetn7LoCVrubFkDEJaNg4p/7d8FMSQ67SwNVmSxagIfRTBWHkj2ZLw2eQ1YHRxMMoBFcABGWnwqUrhRUeq4qWyGC0VkvSd9tTPRrFzfUVhDYf+Oj/B7D7rME7YqJDdZuLsHglzl8jHtAEcJI9QZYPdtdj3RfEIk1q+Gcj6vXbGC8Au1x4lPd5ZCW68plUFXtFmP+PoPEz9/6+fTPCN9snJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Zi6qq2XsHf+MYlpzhKw8jirSmCxCJH11D9/i/vrzdI=;
 b=TYpeoEgFcdZjorAUvf6NIb+1QJ7VDBT1V2FLO/Bm9A5JM/0kJzxU8dv+lGg8wvvdzaG7pTffWzl86dV0qW5pr5luQdqX43jwoQVdduXWnhqBM9cudDXhtGkDUxYxzq3SlbLMHrEIKX8PfyvEboKNSBBpnymYR++zLBaLh4OKuoqAJzE82jnMOqtUH04oS5I39z83tfXa4LNpFQESUtxsP+VF3H6U0qkc0eB6jEdPm3t52EtJGjA+jWR1a7pnEuHVxh/v+7i5R5oWxSA8OExEs9+5C47xgJYKQQjuIBI0yutxHJcUigdeeJg526+a7b7AkibE1XZYt15sTVXWqyc2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 16:08:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 16:08:41 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<linux-kernel@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Nirmal Patel
	<nirmal.patel@linux.intel.com>
Subject: [PATCH 3/3] PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
Date: Wed, 16 Jul 2025 09:08:35 -0700
Message-ID: <20250716160835.680486-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716160835.680486-1-dan.j.williams@intel.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: 916b664f-12bd-4938-edad-08ddc4830800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FsF9k8Sz8wTKegNP4aAwghnWXkjvR6HB0FpPPI0PpFpf5tBT+OMAHYrQTOfO?=
 =?us-ascii?Q?abOnDGURA160ZbBYBsNi1ql11oj7jvZVTxodQDknPyEpvhKErowWvnS+/vaU?=
 =?us-ascii?Q?97MCrVdDfkCWwN5RRQi2HiQpVim6lkwfnQwD4iNPov49hJu+kaQHVdWADvnm?=
 =?us-ascii?Q?V1+RIkenj85uVL72YqsbnZVFZk9tAEJmHCDzbpesne57Qew6S61WS5a/Pmlj?=
 =?us-ascii?Q?rXOpQra2RHNVDyDyiNV/b2upG+SN9WxiLs/JTdOgMlkWYXkcJE0UBMAfTk/Y?=
 =?us-ascii?Q?BIis2WFmD3/4SXtFXjJCmlW/06yXDxklx9LMYtXfndtGRWN0e/O0iNgYFxsT?=
 =?us-ascii?Q?dYPfzSmHnSnGncdxS+wozlIDSXx33QT/PgUdpzF2ZZl8Aw7SDyaM2UuqTeJC?=
 =?us-ascii?Q?0w82ZK0yjViBjXUh/Pxq1XJAmQ2DFxEuNysp1ilBJCraQ0XhWYJZ3H6+GCl/?=
 =?us-ascii?Q?N749xof0cap+UpzyvIrpJqbuqIFAhtJKTlzoTmSJGgjG8feI/vhc34AITKO6?=
 =?us-ascii?Q?hhw7CzXeXOYZa7U1vKh7XRe3khtSRYhFkWXnO/rGXSEoymPM8oIxI0GX6S4k?=
 =?us-ascii?Q?YRf9AFj9wzb4zcef6/CnWTto/fVGo72yNrd/d/xTyL7XrMdmo572WRZIiEWu?=
 =?us-ascii?Q?Qy5i6lMKQrw0EjaT9VETVNLBSc1RxUvNZvnKdt8PyyT2GGa+5pGFxpmSVznl?=
 =?us-ascii?Q?DsOfZGwDqoGjcEfGcbLQZ0rCPmxYLg1M62PokXdehrZ6g90xoXMgfapubyRQ?=
 =?us-ascii?Q?U8sjIGjfrZSHqWruozHVDmkaNlwc2p39J7+tJzVfI90vLqG+9bgtcliA6Fmo?=
 =?us-ascii?Q?mMvxYOaPVrxvtChZ6qMLClR+UYMckpQKasKpUGhm7beggsKyjNSbcQ23NB9J?=
 =?us-ascii?Q?fXQUYAg7RdXG4Y3qyyqzxJ34EFRtj2Wc2IdXq5nmSQtBNb8C/LOIYoOPLKYy?=
 =?us-ascii?Q?wQcYUvaHiPqfk9tx1hA8FUOyRhA5B0RcHkcmOydfdLRGGey3ncAcva4tnnxZ?=
 =?us-ascii?Q?Gdl2zdrGNdUUN6sEEN/8s0UVKM6xH4z368XoIpzwMm7dObi7xi/JMuovNBqZ?=
 =?us-ascii?Q?RYyznjUD+e8d7o5CqdX6P3LyUzHH0WQbmSdMSPJXI/ojjB/g6KsWZ1Nw9GjA?=
 =?us-ascii?Q?mgPqpzf3F84i25MenWd9SuhfNfOr2C7VxuBuLHnOJ03yACgame5woWA0q6eX?=
 =?us-ascii?Q?c0+uldu2sYe5xf/C+B339deIaJUCmAnvhe645ufZTkKMDT4yXyys4VB+3K5u?=
 =?us-ascii?Q?i/gROoCKotIfi2wZ5gvvK7x47EHkqyXtxMAghWgPqHb7GRe5loTSvBY7l+ce?=
 =?us-ascii?Q?hdZOBsNXKIdw6N6FNu3r/c5QIGGCXljb2eW1RNch9Y4NCOe0VNHRZ7/Dkx7E?=
 =?us-ascii?Q?T3rhuVEdh5qIUCcGEBDhPRaMoAsvJhIhstEF4MIZFpuobBTG//3384duh3kx?=
 =?us-ascii?Q?i7g7fJdZ9nk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BdN6Z+6fSBTSyjH57C5Kh4pFaIiAEghezWP61x9SeCVT9U+ifIFKRTz3Tpd7?=
 =?us-ascii?Q?sQuG0OnJ+t9z51KTUrYKK7CkQ27iTnOmcJ2D/TqXo4mzdWHLlYICd2amGg55?=
 =?us-ascii?Q?MJiPPBEEkxGEMzFUEOoBPBUnAFKGFuxgLCnOcvc4EfuQWBZIxc29C0//f6yM?=
 =?us-ascii?Q?AYuJNQz4SQOGZHFPFrQGiZmt+/2oZPqZyOm2AncLdkodpIHsBFA3aT6hRYos?=
 =?us-ascii?Q?eE3vCMc8Yo613ed6+IM0qfUhovXNlD334/+WWTk9oQghwlz40eMQl+nVAp4K?=
 =?us-ascii?Q?8W1nZc0SINAMD/Jw2rhI6d+0dWNM8EAQ3BJCxPV/mIctqK3pWrw8X0yy/mrg?=
 =?us-ascii?Q?c0SIYt+t8/T+c+Lrd3DmGnhvHUeEp5P8aGvY+kSwmwqBmE8b9aZArQ7B7D0T?=
 =?us-ascii?Q?9BxUoDTiXhtLxaG5zVN//LGH1+j1dN+Ap+6MlNNkoM+NAgHWTFoY/rBK3Rgq?=
 =?us-ascii?Q?CN5pzAUAhKuaNBYB/syl5ZeF0vUS0HuQBgX7EpRKvtnT2v+/WFfCljhx290C?=
 =?us-ascii?Q?ZcPGYKnpdp42FcW1nFczJU/nnmfYwak5BwnPETDW2UzingpOWVs5+LOFL5wp?=
 =?us-ascii?Q?n4rpXns/rO0mVX94IuKBmH3xEBwAabOj8WBKkLTkHIOgR7cJgRhWWBwqYMLZ?=
 =?us-ascii?Q?tUlcZQk8nWRfhzztXr7ocK2TEkS+qTXbQgF3Map73OYGseKILFqFz6ySFdLv?=
 =?us-ascii?Q?MPQQUuNGqSntqtHrGSh2hWUN34uJhOVQQwNRrPdTkksrRMIKs7fYVzAkcy+f?=
 =?us-ascii?Q?hHUHxmCAldDPPiIzDsK3uNKBf5TfbxVx14JfjinQ/5udLkdy+M6r96x4cGMH?=
 =?us-ascii?Q?/hwJ5F9lzxR6tSiWA6hEbjarAYLUWW4TfJpV2kL32k6BlclQMSZ92RyyDBUl?=
 =?us-ascii?Q?afwVfpTRL6iL0S5DMlAEhlNMJo4NdkC06Zy8elb8KmpFJl9+nrcWjBP2BBJt?=
 =?us-ascii?Q?oZx9iGDER18gsmLJvEaWq3kyC3vYX0cdPPL9yeOd7KBzOcpJDcQw4RKBxU9i?=
 =?us-ascii?Q?Tryg0yvRUSDxgAA9IBUCTtEQIGKIExA+1jI9TbKRKikQ9l8Ai2bDBs3uiGsK?=
 =?us-ascii?Q?Orf4yT415liSM/X2GWt/DpuRne9bhOZCE8P1hyB9kE7Hyz5+foCXm+72vmn7?=
 =?us-ascii?Q?i8DuYZ3bmd8U1z+NwRfRNiGSaaaukVhI1+TexEr0SFLh87DaAFlpatgI0UWb?=
 =?us-ascii?Q?aBlz+lRnmwY7IuV/N0FsuM3iuYuQf9fXh8o96zKXRRgyEv+1JL0im4ecLEVZ?=
 =?us-ascii?Q?MYopvIp6R+l+kp6esoabvrxYZEJoKWrFV7tHFwVSRBu0jZn45rAFAxhUx2fE?=
 =?us-ascii?Q?qNhYJqV7cwpt44aF9P7L2GNx+6+OckN3UolvCnsXLyWaIECFnDoj/Rf4lZ8p?=
 =?us-ascii?Q?gFwHQN0cXAp83Q5mCkyUvKo7UF+WVJJ/nIiPtgJklCSCqtOelONAcfeD+zqn?=
 =?us-ascii?Q?B3DlmtgSJ18kdwdizpr8kubOmP9lmJp0gCB23PP2DUUbnmRWwLm7ihhkhdHV?=
 =?us-ascii?Q?7E0PGV5ZWFYJJsYW3yLGRJmDCGAkfn6FibEN13pA3jdfXjytPAmpz+8G34Yi?=
 =?us-ascii?Q?0Nhs8txm2fdQcue+u0t+Iznh6ZakeFpKivERjqO+iAzuKJ8EGZpO73GLzaGs?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 916b664f-12bd-4938-edad-08ddc4830800
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:08:41.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 616zmartAXhSvvvdpp4yQaYbbAkFu2/bWEF8RfhZB644zdePBh/jWnlAuFbao9ZzCTkHOfmcQjFW2VA4b4rJ59OnLVl3oddr22x8UChEREw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com

The new common domain number allocator can replace the custom allocator
in VMD.

Beyond some code reuse benefits it does close a potential race whereby
vmd_find_free_domain() collides with new PCI buses coming online with a
conflicting domain number. Such a race has not been observed in
practice, hence not tagging this change as a fix.

As VMD uses pci_create_root_bus() rather than pci_alloc_host_bridge() +
pci_scan_root_bus_bridge() it has no chance to set ->domain_nr in the
bridge so needs to manage freeing the domain number on its own.

Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/controller/vmd.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8df064b62a2f..f60244ff9ef8 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -565,22 +565,6 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
 	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
 }
 
-/*
- * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
- * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
- * 16 bits are the PCI Segment Group (domain) number.  Other bits are
- * currently reserved.
- */
-static int vmd_find_free_domain(void)
-{
-	int domain = 0xffff;
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL)
-		domain = max_t(int, domain, pci_domain_nr(bus));
-	return domain + 1;
-}
-
 static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 				resource_size_t *offset1,
 				resource_size_t *offset2)
@@ -865,13 +849,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
-	sd->vmd_dev = vmd->dev;
-	sd->domain = vmd_find_free_domain();
-	if (sd->domain < 0)
-		return sd->domain;
-
-	sd->node = pcibus_to_node(vmd->dev->bus);
-
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
@@ -903,9 +880,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
+	sd->vmd_dev = vmd->dev;
+	sd->domain = pci_bus_find_emul_domain_nr(PCI_DOMAIN_NR_NOT_SET);
+	if (sd->domain < 0)
+		return sd->domain;
+
+	sd->node = pcibus_to_node(vmd->dev->bus);
+
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
+		pci_bus_release_emul_domain_nr(sd->domain);
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
 		return -ENODEV;
@@ -998,6 +983,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
+	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
@@ -1063,6 +1049,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
 	ida_free(&vmd_instance_ida, vmd->instance);
+	pci_bus_release_emul_domain_nr(vmd->sysdata.domain);
 }
 
 static void vmd_shutdown(struct pci_dev *dev)
-- 
2.50.1


