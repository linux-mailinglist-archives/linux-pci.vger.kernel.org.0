Return-Path: <linux-pci+bounces-11051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD279942F23
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396571F28AE1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE461B1437;
	Wed, 31 Jul 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/UWwD5y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473F1B1431;
	Wed, 31 Jul 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430237; cv=fail; b=nJIzR8Mtvy6i+jH4d1v1ZQaOY4XH/Gh0IFn6iLHg89cSZOUj7N3tguh0Uk1gAP2znWn4KGdGXxxIbdd51cyBf392Eij1pAOAah79Wka1pij2HF+x4Xq8ttfOILExhwIwO65F4umo+fC7vysS+KkJWtaXa2DjWKjFZ5+MtJ2YkGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430237; c=relaxed/simple;
	bh=aDCD4hvGIq8MlnNmDHjRNatrvJpyFaux2uhLHkZcfN4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=owMjwLaY9+gYqQrs7g6F31vLnn7RO1vV3pBmKT/Hz9J05sTHey7K8vWsUWIDAt3ElQdJM9d4vrwIX9bHlfC5L60xHkfTtF/VGNcU3DvmHDbtiAaMNv3yJGA3v/k08ju4r0ujWzviwaTaf6oW7KcubaSIi0r12KDZoCp92DMU2QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/UWwD5y; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722430236; x=1753966236;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aDCD4hvGIq8MlnNmDHjRNatrvJpyFaux2uhLHkZcfN4=;
  b=G/UWwD5yttC4l0jzMYRVXiHqjRIulkiKShhfQsJ+9iFmVYS8Ut3x/G0g
   agRoJ1o2NILFHzRZak+w8KudWZUokScGHNdxqfB2E0BQftLoNanL/tp9I
   rYzyYLoc/AFCffOwUjWk4VjPv9OxyR6Xlmb84Q50HiFjev7Xrnz73HB7n
   TvzHBkANVWjNY/72RluSP74uv4IIKwI457djjbD3mBijfqcQx5rPCMKjn
   pcVE4icS2L0/edSjuHEM7jnvfQIDKzSKHE3AWNuFR+kEhEPHDDBlrfioe
   FPxB+6hjJqh0HWyF0zjgyoKcxJlSlxMZdXe8udD+9pHzh+TSlMGyQVnTH
   g==;
X-CSE-ConnectionGUID: wfZaXIE8Ss62RoBXnJmWQw==
X-CSE-MsgGUID: XsyNO9rZRKCflcsDL+/yKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="37778244"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="37778244"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:50:35 -0700
X-CSE-ConnectionGUID: hfVJ53OURPGv2EyyhZoQnw==
X-CSE-MsgGUID: XeCyD18RQwi7tIQLpxui4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54668299"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 05:50:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 05:50:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 05:50:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 05:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+2oqoxo7Iv5F1pXogsNA2J/+JGuAz5LT39pXjqtX/byv0KyY9kcJtHP3wRpM/q5zyZu4TlQxnjlYHSL/SI2TL9+HEgTr/tPmCU3YSevLFUmk2JvGppGylJYtxOmTNDOtsoj770W62od00Ij9kRfKELlPKaYjf4P8meqF5tuiUo6cVL3XGKqz463hPDXQRbmgZ2ETmfH1s1XCOp3I3uTvPT3AvaySBH8W3VHHBZl2lV3lMa0zVaqiAjWrAjZaYxdBer/GdQkasFnVstYaNTj/z1nlfNEVbfj+oCr5XDHaGU67ugJ2GXTz2tm/aWYVlyeOIlKcQzIGQm8KFKiK8Zjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjJXBrSiYBInwP98oei82aS9GafMhD3rQh/IuZWsl4U=;
 b=XBdE+JOsYE8Ft5ZvySuKigUFTD+Ruf+VJhHOi+wXKxx/tT1FZTlHn78odf8zPytmicOdD3fE6J6lnywAijrN7AbNj2wO2iZ/QOFe8H4khCvMl3IfE0xmD7bWcYI+mCBofdcLOW8L2aVc01no3f13MJF6NDGglZYGnxJmXdWRqwYY5WTKazt9b9pPcrTVHkzD7kRN5FCYq1RAFUCol1UuSnQIyRvnLXemohemxKW69vdNwkScEEe7N3C/p1NnnDfUzKVu5KFzAofyduqVRra0b6hTeku3+zHvbrUw0Fkrg5l/oJTeGxjmT5L3sadu2ccOfYWLMCriyebe6tDzP3a/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 12:50:30 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 12:50:28 +0000
Message-ID: <1cbb02c8-ca3b-4de4-ae25-940bddd5469f@intel.com>
Date: Wed, 31 Jul 2024 14:50:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 2/3] net/mlx5: Add support for enabling PTM
 PCI capability
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, John Stultz
	<jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
References: <20240730134055.1835261-1-tariqt@nvidia.com>
 <20240730134055.1835261-3-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730134055.1835261-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::11) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: d498cabe-d7a6-4698-405d-08dcb15f5ae8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2N6ZEtLNG1wRS91ODdzY05RQVN3bVB1MmhsbWh2ZXMzbUNtMVJMMkZQdGEw?=
 =?utf-8?B?eVpOVEx5K3B1Tm80K09wK1gwNjFaWTRadVFHTldaWFhTZFFuY09MYkxnVUZF?=
 =?utf-8?B?TStDUERET0hsMFJWNW12Q0NyYi8waXJrYkZ0Qm52Rk01OWwzVlh1dUcvdzdr?=
 =?utf-8?B?TmxUMWltWGIrMExMS25MZ3p0ZmV1Vk9oU0F1MDlDMG5hQ0tmd2xQTVgvNXdU?=
 =?utf-8?B?MHptU1hWY0F5RmNoRzR3RDFvejhHTDhMSHpPRzlmRlZPdmw5ZW5SVWZlalN4?=
 =?utf-8?B?NXJncDQ1cFB5Z0JzWnQ5aUo5ZTUvek1vZTR3RG9SU0NTM1RaVTVNQVVONENj?=
 =?utf-8?B?cWdtYmx0VXExOGJEZmo1aGxHS0krSjk3Z1h0Q002VmMzTlh2K1NPQmdseTF6?=
 =?utf-8?B?YjRJTjB6VTl6UEQ2Wi9kcTl3M1daSFdSMStCZm1pZnBPajRvMkF6cDYwUDJo?=
 =?utf-8?B?WkFBNGthWnFJcHZzck85eE51bHh1UWZtRGFqSG0wNHFvbm5SdlAzTk51M2h1?=
 =?utf-8?B?Vjl2eUxmTDNxcjhRNEJFU0hOOGJaOEdBejZyVm1nVTJ0MUJrdndjOWVldHM5?=
 =?utf-8?B?VVNHd1R5NUZYOUlJdDJVU1JsbWxuMmpMN0VoRHBCSW5YQk1tckJMTkpmY2l1?=
 =?utf-8?B?YkhDdFhnNUZ4dWpmRUNmWmNzd0VGVDhuSGNZTzVoUnl2blYvUE9McHV3Um5r?=
 =?utf-8?B?bW9FRlhtTjZBVnhVK01ENWNoa0hIN0NoWkVqalF3eGdzYzJEdENKcXMwRUcr?=
 =?utf-8?B?aXFTendFdUJleTlJeDNaWk1MVDBZT2E4NmZaazBuT3Naa3Y0WC9BSWU1L3lV?=
 =?utf-8?B?bVdGZHF3b0ZJSTdPUlBvcUxBQThpTDhUbFVIdStCSUVWMXQ5aTZkZ0xuMjNa?=
 =?utf-8?B?dURFSlJCK0pyQTVPK2wzVk53dVo0REZMMSt2cCttRGpWN3Vob3BWanpDZWpU?=
 =?utf-8?B?SVRMeWJzNGZjeklQTEpNd3NKV2tZZE9UdFh1NnY2MjcxZkxvOW5Zb2o1UHE2?=
 =?utf-8?B?dnRlMVIveWRwUGlGOThoa2krcXY2SGszVjBLMCt5WW56MzltMHErTytaQkly?=
 =?utf-8?B?S0hmYVBGVEJJVmZqZDMxMENnM3lkcEJpZlhVVFpLeVFxSjJSS0hYZ1pBZE9x?=
 =?utf-8?B?NDloUmlRQ0VNWTNjM243RUtzTnlaa2JYUUJIWWJidjQ1K3VHTGl4dEhSSUVT?=
 =?utf-8?B?b2Y2TjNxUTREMStxaVlXeXRETldPT0lqQ2JWcXAwZnJqZTA3OFV2YTVNb0Ir?=
 =?utf-8?B?TmsveUUrRU9DdVR4blVGTzZJaFJsNkxINy82cXpWSDJ6aVBpWFRlSzhqdHFl?=
 =?utf-8?B?d0Jnc1RrQ0xkd3RXMkMxS2hlbkhSN0E2aCtMY3IyWWJLcDNSTHRCS1lSbitx?=
 =?utf-8?B?OFM1SHNqTUFQQ20valYwYWoyTjVaY0dQaWhnTGtWdlVTc2JHZjRQbmpoK1M0?=
 =?utf-8?B?VFZUaTdRZFRYeDhkeEtJT0QzNFQ1a1ZwTjNUa005T3J2QWlub3dYSHpRZUNp?=
 =?utf-8?B?YWlGK0JnUkZraWRjc3hnYWtjWWFpZ0txZVhjNkhmT3k5Y2JtOXROUUlHQW5j?=
 =?utf-8?B?WUlxcnlTbjBkdk56VmZ5RE5IS3NON3daWjcxSG02QXBGd1YrSlNXQ2RTWnR2?=
 =?utf-8?B?OVFKTXAwZFQxMkMrMmFqOXJJZW9KOUkycUlqK09tSEk1d2ZLMTFJbEM3Z1Az?=
 =?utf-8?B?dW1ReFJiUDJlejR4aGprT3FPUG50M29mOHlBeTF5ZjVZdEd4SFQ2VVJMLzQx?=
 =?utf-8?B?dStpdzlYU0NtM3Zaa0p2bHozWEhqdFdXTzU2aVJ3MHRuVWhaNlY4ZDI5aEI2?=
 =?utf-8?B?cFNtM29FZWd2WlpLbU1OZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW5qYU1xeldZRm9sSFpzZGxVblZEZ2dtclFEZzJKMmNuYUdzcFpMWjlhZ0Y1?=
 =?utf-8?B?dkNHU3kxNFBYVHdRZ1lhbElVU2M2VFlQMU1wTENqZEZkSFhhRnNYS010YVhL?=
 =?utf-8?B?bmU3aVBtT1pCais1ZmVBWEZRbWY2Z0RIck9McXZxT0xaTlBVQ2EvYitIL3RP?=
 =?utf-8?B?MldHeUM2dFEzd1NmRFJzUldZVktxMjlXT001d1pqRk1TRzFOUHVGOTBCZE8r?=
 =?utf-8?B?RHNYU0NGTWdYdWRQWjhieEhLZDhQeWZoRkRJZGIyMkxjSlRUSmNQdU5oUUgv?=
 =?utf-8?B?ZmNrWlhyY3dRMkdGRkJMeldVZkVqaTZldHJjY0R0SkxiYUZHT0JnOGV6RDQw?=
 =?utf-8?B?WTlyZXF2cEp6Slh5TXBUQlY4QlBtV3U3UGo1S3paYUJBQ2o3WXRhQWFsQVlL?=
 =?utf-8?B?bkRvMTZBVHphNktoaVlIZnpzRnFHOHI1cWV1cGlvTG5YemRSeVFuZjV2RDRU?=
 =?utf-8?B?UTNKUTFONnh1aHl5d0NQTVpCcDJsNVYrOHVHYlZDTjlCZHdneCtkdXhOUkpa?=
 =?utf-8?B?MVV4OFprelQwMnRqZVVCc1hXQlAzQjZkSVJEa0RtRnMrbDVwVlRCQUsxREJ3?=
 =?utf-8?B?emp0QU1iY2QrM05sVDM2M2ZYblN5K0pjeGF5OGNaWVUxWHNFOFhBWHFKK3ZF?=
 =?utf-8?B?N2F0U2lpNXRRaEhKd2ZqUWdROHFFakh6SmJtVDYwS21UZzNNRWVCNm5PYW9z?=
 =?utf-8?B?cHZSeE5wKzVVbWZJUlBiU3pUVnQ4K3pEZHNaZmtqcWNoNEN6bExnNTU4UmVj?=
 =?utf-8?B?aUVXT0tacEdWdkRUWkRsMEQ1MnNaaWtieGszYmhPVGxIRkhBY3dPMXdLdXBD?=
 =?utf-8?B?V2R1bllxeUM0L3laUjQ2U3NqaXFHRTV6dFp3c0s2UDRoOWF6Y3A1eVhSSmFo?=
 =?utf-8?B?aEI5b1Q1ZG5NMkJVQWU5T09sbktxdlNDNTJHUlUxWHNPQ0h6dFpydE90UjI0?=
 =?utf-8?B?eUlGT1NLbVFoM0ZMc25GbFU4TmgyL09SeldSd1N4bk5HOXN3T0hid2RqUW82?=
 =?utf-8?B?QXBBYzlpbUE2S2h3b2tpU1VGbHRwUmVHNjdOWEV4SmFYcFNCUnkvcmc3cUk2?=
 =?utf-8?B?cG9hM1Nxc1Y0bTFIUEs0dGhmdE1qMjVlUUpzYXcydU5rMXpQc0pKK1lKbTdr?=
 =?utf-8?B?aEU2SlN1aWJDVFBqNFRoMmtuWC9QNGZjYnNka2RNdEFIVTUwLzlNWjN0eU1C?=
 =?utf-8?B?OXZiQWxtcjdrdWtMYnUvdFN2ZXUwcDhENUFySE14dE5qa25oMFhqL1k3UDV4?=
 =?utf-8?B?UkxiZkNOemM3QjR4QVJqMnE4RUN3WEt0aGNhVnJuUjBnMUFhMVArMWFLWTFT?=
 =?utf-8?B?N2ZaQ2xiV2cwcGJDZEtndW1vK09WTllXd2s1ak92d2tzNHZUUGNYeWpibTNz?=
 =?utf-8?B?TTVscjRjRXQ1WGIyVGRnOE9RcmhXRXRkVUptKzdUUmc2ZlJERGRLbGhHREQ0?=
 =?utf-8?B?ZEpQQWxkbGx3RDZkWkpseW1vUkFWbUE5d2lreDkxV0ZIejNUbmxsNnZpUk5s?=
 =?utf-8?B?enQ1aU8wbmFpckc2cTNSaHVrR0JWM2tFTzRnTGthaDBPSzZQMUdsMXMxcE5B?=
 =?utf-8?B?TXV0UjBUd2xmRStWRWpxWG9HblRzSmY4RzhHUGU1b2RMRTl6TGU5L2tqVU9H?=
 =?utf-8?B?bTBnaW9YY1ozcWwrNzU0WUxUNkZTcWx5bmZtRFZqRld1ODVGMVM4QVFKOENO?=
 =?utf-8?B?RlRZRDczMmxFQnUvZTdIdWJDRXFqbjZsVUpta1ZkL2ZLakx0bWhMNEZ0bWFj?=
 =?utf-8?B?a3hZTUZOMjFCcDB6bDNRbm55RjdrNmpJQ3V6SDgybDBrZ0VjVFA5aG9WS3hp?=
 =?utf-8?B?SjBjOHUrTDF3enFVOFl5L0FNN0ppZWZ1VC80OFI5RTQvVFlPODVScElqa2Iv?=
 =?utf-8?B?ais1Ti9xci9SVzNUTy9xSGVmc0dBbS9mVlBKcVkxRDlObGJ3bWdPNlJleUpP?=
 =?utf-8?B?VHRmRUpMN1JMYXo2enRMWnJEZ0xpSThNTTdheE1JaTFncWNWNXRmOW16QkNa?=
 =?utf-8?B?azM2SFVCd0toY1BSa2N4RmkwenU4THh3dG9nUHNWTXNtQjcrS1ZGMHFmaTVp?=
 =?utf-8?B?T1NlenNHazBxdzJncDZ0eDMxWXJTNHpUb0g1ZHhVaFplMlFabFVzZStRWTVB?=
 =?utf-8?B?Uk1ONjlHcTdGWll0T1EvdWFHV0NBb2dJa2Nhc2Y1Tm85TmFpdUpHVU82UmNm?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d498cabe-d7a6-4698-405d-08dcb15f5ae8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:50:28.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvvJbQusxB83oFlwm6KVhAtBUnq1bc67dO5W4CFWOBa2BnWH+VN8fBHx20QyU0rOdzGtA1iWDnEzXHdKdzfjh+eY0GDyfqhWEL640IBC1/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
X-OriginatorOrg: intel.com



On 30.07.2024 15:40, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Since the kernel doesn't support enabling Precision Time Measurement
> for an endpoint device, enable the PTM PCI capability in the driver.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 527da58c7953..780078bd5b8c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -923,6 +923,11 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
>  	}
>  
>  	mlx5_pci_vsc_init(dev);
> +
> +	err = pci_enable_ptm(pdev, NULL);
> +	if (err)
> +		mlx5_core_info(dev, "PTM is not supported by PCIe\n");
> +
>  	return 0;
>  
>  err_clr_master:
> @@ -939,6 +944,7 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
>  	 * before removing the pci bars
>  	 */
>  	mlx5_drain_health_wq(dev);
> +	pci_disable_ptm(dev->pdev);
>  	iounmap(dev->iseg);
>  	release_bar(dev->pdev);
>  	mlx5_pci_disable_device(dev);

