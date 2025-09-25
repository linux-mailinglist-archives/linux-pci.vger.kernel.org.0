Return-Path: <linux-pci+bounces-37022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FEBA1451
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 21:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4241BC5981
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231831B829;
	Thu, 25 Sep 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkTSSQBF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455631B83A
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830096; cv=fail; b=SrdVIb94GIil39HV6+pfWLqizOHHJWHsVbvOuDMp3KiAVX/x8iaID0kK/ksStHoSAYNthMKLNIVDqJp2jJub08Iw3l5Dr0DAGtx6gUKDUDJk5VIszJ2UYt8KVV2kxjh7EVYnZyz/C2nDL9hwX/DPRa2r6eRefQNjQQe+op5hpbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830096; c=relaxed/simple;
	bh=1tQOLb0yQTwI+GbhNEUz6SS8KbBg5eSyKJot3FZz1ak=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=oU0XOcVvezVIf/C2UE57unmAllFuRSq6oMIeH7b8S3ROU56QxIplAERp1t0lVakVDVYhs2xUsRra9Aj6Vfx6FGua0oKV1QBVJtvbTNoVgENhVuC/BoZPbnxBwuMcNO7HLv2/CxNLG2ZpkiiUZi+aXjkCc3ipQ0YFkGGlnifQJh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkTSSQBF; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758830094; x=1790366094;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=1tQOLb0yQTwI+GbhNEUz6SS8KbBg5eSyKJot3FZz1ak=;
  b=UkTSSQBFXPUDPEZ76ky/l+kV5HjDgAJll1RtC4FA+4anUc0AQxquIwOj
   AkF0Yhm1Di4zLdBhG7fOEv3khp+P/VHAELN9FUxQJQWQyHRm7UaesMNnt
   c42lBvbHRiBZ3VUSx4c03N+njgOx7uBpJlXgstYrzTG3eoOwW1/i/A6Cf
   ioS3XZTDObxOH2cuD/e62B9oRiGpFsjdiHod23lqJsY160MYBtLlovF9c
   /oERI5gvn+mKxt+kBHfXgUVCW2tSJR8onfxH4nkWLmOnBM75F43x40sad
   3eKtTzHfGq+Upr3JvXVY9PWZpPi5qnr9T3zT+o7o7zE2Ng5tNor47NDr2
   A==;
X-CSE-ConnectionGUID: /n30HjClREeWbMFgLEpHhA==
X-CSE-MsgGUID: USgRuQg2S5CHs5G/kby7wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61050703"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="61050703"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 12:54:53 -0700
X-CSE-ConnectionGUID: RaVscc7rR0a61TYiwgF43g==
X-CSE-MsgGUID: 6eelWWiqSduFAOJm53y9UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177261916"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 12:54:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 12:54:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 12:54:53 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 12:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYufndKT4hyxNphcji57Fb2JphjQFW/lqE2UJBc4huFiXLDVXLwETVsMebqrMiGXpDnBfi0plQ74j9l6VchM5LYNIeIZBg2lxrP0NTi7eMJsfuVgFx0frEWBug7LpSYJ7XOxLbNbFWKwaFdfNr/HMms9Q+00A9VJf5GUTBDMw3iAkQ8v4zs4/PFw4A7RpWLX7ff4n/b/EOWZrUcTqAnFpo4uWdoWvMw5+Fp/N4X+F/k9l7ZRfXymG2PF68tDnqc9MOsWsOjRvRHagguFrYa95rLKJjgvn5aX1hfuAIvewJSmw8D5X08p42ozJVDgazXSmjra4/bP2yamlxcAZ/dJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUhpYTuXNcPWYlnGymYiUo1i+SH9YdfTnQsNuV7X87Q=;
 b=YsK4hB5TTlcc8i5MU8WTESWX/rMjDtubpFHSduRQL+Urusb5KGplnjpMmuJlEEbKPmZzLpVVhESepBaOM8BP/5ovMm92o8TXpQWRemikeGdbtK7Z98l0InA9bgumhzHgwWBDdpKPblyfZms5dVIVfazkG544EfD7vSRF7JLuQx2fMOVhRoYFw7NftGc70rC3/LzXLV32/7b79DLXkXp6s81GiALhPr20TKMEWYyEAf24H8duc8Da7wkVgNb5SsP4xVvd5eOvjCLD8pBJt0wxelYABFkLuyTgyQoe2KM0/BxwmMTlpd+U5r5SjlSdO6Xn3rb/sCmDjljIM+mCQ+XY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7299.namprd11.prod.outlook.com (2603:10b6:610:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 19:54:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 19:54:44 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 25 Sep 2025 12:54:42 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <68d59e02a9538_1c791008c@dwillia2-mobl4.notmuch>
In-Reply-To: <58386de5-7308-47ca-bedd-6844a1d8cd5f@amd.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-8-dan.j.williams@intel.com>
 <58386de5-7308-47ca-bedd-6844a1d8cd5f@amd.com>
Subject: Re: [PATCH resend v6 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bbd6f1-fd66-4f5c-a399-08ddfc6d5f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmF6Y3pHN1NjTlhxYUNuRWovaEQ1TW5mOE9BRWtjMU0xbnFJNzJaT0RmdGlQ?=
 =?utf-8?B?NkJlTytPWko1dUJZT1hZRFd5QTZzMG42SEJKekdMalFlMHp5ZDhkZzV3T1V3?=
 =?utf-8?B?a01lRm1pOGhjU1c3MlpNelJGaTduTFRhVDJGVVpEY0dPRWVZM0QxSExhVnVB?=
 =?utf-8?B?Tng0N3ZaUjZ0Y081dVcwWTFISXJuejlmY0o5ZVVTcnZVbUU5OUp4dG5QaHVE?=
 =?utf-8?B?QVo5cjJJZlIxcmVscm5FQmc4MzB3VmZhd0JUODNZd21aWTNoUmQ0aEg5QnMy?=
 =?utf-8?B?akh6RUpQMjlZV3B3ZmdPTFBNZjdYeHZWR0JnQUsvZUUzN3B5STh4T1dxanJx?=
 =?utf-8?B?TFRqdjB2Y0U5MWx0RHRzSG1icnltUFZhWjVJMFUwaW9KZlFuK2JyZlNPS014?=
 =?utf-8?B?Zk1NczhPR3hQZE4wdmk0NzkrNmE4VnBJY2tma2ZLTS81SzcxMmx6YzRsS29p?=
 =?utf-8?B?Rzl0U0ZSSzVobmFVQUJxYXcxbTJ6TU9FNmc4OGplOGlXRitPMEZ5d0puNWVj?=
 =?utf-8?B?VE10c1V1N04xbndjUDVhbGVDK042cS82b09oajE2SVEwaGhYdHJZTnRZa0Js?=
 =?utf-8?B?L3N0UUYxL3RNT1QxSDE3QnpvSDFhNGV1T2hIZm5mUHB6dk9BN2Uxb3djanNS?=
 =?utf-8?B?dUZScGhXbkNjczhlVCtHM09oaGNzNndTcFFhNFJTMVBMZ1E4SkxPOXBYOGxq?=
 =?utf-8?B?WnVKYURsa2F5ZlZJMWRQd3d0eUpQY0xDdnRCMzcvdndpa0tVK2FwN1VwSTNW?=
 =?utf-8?B?KzRBYnUzS2lQb0UvL0J0SXJISmdEdG5MOHZPZW5DTzVjZ3ZYZGdKZGY5MDRx?=
 =?utf-8?B?RTVsV0hNc2VVbVNXY29DSEJneU5waHpoWnYzUGhjUFJZOUk4KzBMRndaYkcy?=
 =?utf-8?B?RnR5MlBUVnViOWk1eGlnbktldUczSDFBVENxcHgyRGxXY3dxdkd3aStYNmhv?=
 =?utf-8?B?ZnVTOFV5VjVydG1VQnFWOVRxT2RCcnlSd2JsRVo3MC96a25KL2dIK2N1NUM0?=
 =?utf-8?B?ekdPbVUzZTh0amV2ZkFtdmZwcWZiNVpMdnVINFR0ZDlBZlk3elhUTlMwbGxC?=
 =?utf-8?B?OE1reTNzb2c3ZDM1Y3V5ZVBic0c5bmZ2R05qZkRzU2lqY09sQTFMUnU0T0F6?=
 =?utf-8?B?YWJtL2pOR0IxR0F0YTFGOHhuTHl2SU5JUkdKcGZmeEFrN3RZVXd4b1NieWhp?=
 =?utf-8?B?V3VpL0ZCNGpCT2xIc3JzMlByd3dvTmdoL25rYXhzUExJU0tPR2xSRllDUVp4?=
 =?utf-8?B?UkhwdnVvT2hmY0lObURmSnNiQ1gxZnlIS21ldTBKUXV0bTFMSVg2N0xuZ1Y5?=
 =?utf-8?B?UXJRS2xmcUpvcVIzNEs0dVFQTUJLeXE1cDNHWThvQjZSc3ljbnBuN0IzT2tT?=
 =?utf-8?B?KzBsbm5wV2hWWHRxSCt6Z3NSZEJMZEx5QzV4UFYwNE11T3Q0Um9wZkxsc2Iv?=
 =?utf-8?B?UGNnc3E2d200T2VsNjBMVjJiaGhGbUh3RWVWTWRCQStGdGFpMHJUSGZaUmln?=
 =?utf-8?B?U09RNkd5ODBIN2xiWjFwcUpXTE1oa2d2WENLTnYrMHoyWmdoT1lyUXlmNUNV?=
 =?utf-8?B?eEJKdXhYcE9SNC9IZm1DSHdsQnJ4OVJHZlIzSVdEV25tcjNuSDFoSFJWZWIz?=
 =?utf-8?B?dUt1a3kydkJFLy9jajRpQnpGRXpQa1FrbGVoTVozRWI4Ti96UjVJM1pFbHhV?=
 =?utf-8?B?TXRTNThOc3kzOHVZMk1hb0cvbExqUU1jRno2aWRDZWhDQ2hKRy9OZlQ3eXU2?=
 =?utf-8?B?ZVZwNHVmU0dPQTdkRHVGaVVQVG0yZ2hkQVZ3R1c2SHZDblJEV3gvV2VTQlNX?=
 =?utf-8?B?ZDhMMXBwQnl1MGdLWjloWnVsZHZ2U0tCbEUva2dPbHdOelBzZ2hWMzRyWXJt?=
 =?utf-8?Q?+nrm+msXcTMfS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpVajhwd1lNc05ZT2M3ZS9XT0JBSWZFb0ZJdUtSaU1nWjdLSXFpMExEcGR2?=
 =?utf-8?B?RVQ1TVlWdTVPa2dCcG1qbjF1S0k5M2NoV3IwblRwRWF5UXd5NmlaZ1F0S2I4?=
 =?utf-8?B?MjJSRVhuUkx6N1FjZkl5TXBYcXAyakMxa2ZjSDBiWnFUak5QMFFodnZCTGdF?=
 =?utf-8?B?enJMZDVrWVFiZlNZVXYrWDFiWjVta1Q3RUxsNUtHZ2tmaFBXZjQ5ZFZlMmJx?=
 =?utf-8?B?STZVbFpheXBUWkFUa2oyUHRuRllETjB0T2pjTjN2UEJIMUlmaFkxdU1DQ0Nj?=
 =?utf-8?B?TDhvQUZaWnRrUjVUb3BLbnl4LzFMTXpjQXJ4by9uWSszdjdWamJCZWV2aGFC?=
 =?utf-8?B?eUJteGFNdEJpcU5CQ0NpU001SUNHT1ZRbUJFVllvL1VJQ2JKaHBZQmx1ZEZw?=
 =?utf-8?B?NS9TVFFaMkdBNllQR3h3VEtyMlVGZDJEUzlieERZQmhYNXpFdUxJQlZXWkZm?=
 =?utf-8?B?RytMUXJBN3IvT0ViOHJwQXVnQ3IrOG9KQTIvVjMrcHBvU2VVbUc1Y0RRSnA4?=
 =?utf-8?B?R1V6Vk9KdEVzU1RnVlZQWGo3Z1pMVVBIVmxjUHpmaVZvT0lJVmlCano5SHpz?=
 =?utf-8?B?OVZqcU05d3JwVGQzZUo5ekpkM0RtN2pMcXRJSE5jcmJwWVBxY1l6Q3BrcTk2?=
 =?utf-8?B?b2l0dEg0K1ZjcVF1bE84K3lWc05LQWN0LzArSmlsaWdWNjJnS0wzRzdRek1H?=
 =?utf-8?B?YW1ETmR6YUI4YWJUZVA3aFgxZzhsVFFocEx2VjdBR3RXUDlLRmRyMEYySUJw?=
 =?utf-8?B?emNja01yVEh1bEM2ZzNhamtaTEpCTTdsam45R3BuZnF4ZFV5ZlJrcVg4clVv?=
 =?utf-8?B?bVNhM1o3eDh2b1pObWZ2YjlxYlRIcTluN2hIZEprUDljLzdmSEYrL0lRQVlR?=
 =?utf-8?B?M25MWVBoSFRnaUlLNkVJd1hhZTdQRUlGblN0Sy9UVWF1dm9jQkFEb0l5WURp?=
 =?utf-8?B?Y0xaeTJGRXQ4b0dJcEVlWG5TRGRiVVRkNldudzJHeGlnT0lYcGlCa1ZuMWFu?=
 =?utf-8?B?V0dBdCttd01RQmdGbkNvU3JBUEMrVUUwV3ZTV2hrTHRMK1Jxc1h5UXVkeWhn?=
 =?utf-8?B?QVQ4WmR4K1EwaVZnNE1Mb2dWSThLTmFUeWhoZXZLRGw4MnoyUTFUa3M4Rmx3?=
 =?utf-8?B?alBnMkErRk1IY3BYVVRDNkxIWnZvK3MyT1A3NFBMbWZJQmtzUjZKZ3RrWW1D?=
 =?utf-8?B?ZGZiZjBTa0Fab3FqU081OENJd1pwdmFTZnlRajYzeUxFU1R5QXJERWp4am5m?=
 =?utf-8?B?cEhpeUI1QmdlQVh4ZFNXemlOTkRjazJnc2Qvb3NCTnpOc3VNaHBVMmJQZ2x2?=
 =?utf-8?B?TmExV1NVNHJPNjVIbmQ5VlJvUTJ4aENTUURTSDNab1orM05QUDNjRmxJOWdR?=
 =?utf-8?B?V0RpaDI2NEpyTndXWjllekhyNFpiYWFNbm9GSVNOYTRKS1dzR0Vqamdxdi9q?=
 =?utf-8?B?NU9SeHNRUDZnMllsSVRPazN4aTUwVE9vdXRLNFBBWnI5RUtLOURMMS9IcGhX?=
 =?utf-8?B?WEQ2cWM2RjVHNm5JY3ZXV1BDcjdySnpST2tIQm1VVXN3T0NQZ0QzRm5hbzVa?=
 =?utf-8?B?eFg4MjJ0b1FqU3k0bEkrZE0rVWZPejFuNEQ3WGNKRW1YTERJY3dWaThTS1VE?=
 =?utf-8?B?aUh6WlNOOXJ4cnBPdjlpdCtxRHZNVW02WjE5MEJQSkJ6OEgxeE9aSVQ1b2VU?=
 =?utf-8?B?eFVVOFpYYUg0MmhwVUlIdWR6NTFPTk4rcTFMbW1EcElLRjNSb25PdmlxeHJu?=
 =?utf-8?B?OHlkMWtjWG8vZk45aE1veWxGTWZrdmdEL0x2VDZMMThSek4vcGE0L3pob0xN?=
 =?utf-8?B?bWpabjBteERoUmIvcC80Q0N1MTNrK0Y0VVZ5TmZwK3ljRGpyc0RMMmNVZjBr?=
 =?utf-8?B?bEF2STZhVHV2OWM4MlJmcHp6MGc1S1JORVA2bE44Rmh4MUIyVkNkUTNFZjJu?=
 =?utf-8?B?RlFGOEpOTCtwbkMzMDlHZjZCbi9XVnViYVQxMjdZbkRwRXFhQ1d3S0FQWlph?=
 =?utf-8?B?ME9vbkNLMGFnMG96ak01VjVhY3MzK1JNREM3alo5a0F2bzlIa0JkN2d3VzNV?=
 =?utf-8?B?Q1l1clpQMVVlOHpudDNQeSt4NUx3TE9MVEZCVnBlczNaVzRrL1ZkMy9NQXhG?=
 =?utf-8?B?YVFucXZvSDY1WVlqMnBEVVFtZGVSanRpeVlJejFjRnVqREdEK29RQ004d2FD?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bbd6f1-fd66-4f5c-a399-08ddfc6d5f9f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:54:44.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gg8GUuiDKKx+nUxiadAGGXo30TNxFF2ch2KDTYPW6XabPtnDUiSDNhakEYbpQLwy0oHLOExz0+TmbGkJefNkSnj/JdIbUnr4AoechcYmNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7299
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index 05ab8c18b768..608ce79d830f 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> > @@ -5,8 +5,12 @@
> >   
> >   #define dev_fmt(fmt) "PCI/IDE: " fmt
> >   #include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> 
> Compiles without it.

As Bjorn pointed out in his review, the recommendation is include what
you use:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submit-checklist.rst?id=v6.17-rc7#n17

> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > new file mode 100644
> > index 000000000000..5a7ffb1d826f
> > --- /dev/null
> > +++ b/include/linux/pci-ide.h
> > @@ -0,0 +1,73 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> 
> A nit: may be refer to the version where it appeared first (r6.1).

Bjorn asked that I move all the specification references forward [1], and in
this case I missed moving this one to r7.

[1]: http://lore.kernel.org/20250807212716.GA62016@bhelgaas

