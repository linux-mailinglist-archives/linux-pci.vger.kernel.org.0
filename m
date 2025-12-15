Return-Path: <linux-pci+bounces-43069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD4CC02C4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F453013EB9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 23:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD936279DC2;
	Mon, 15 Dec 2025 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWF6S0jZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B015216E24;
	Mon, 15 Dec 2025 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765841363; cv=fail; b=kEAes2jjlZ/DRcMtb7KQHrksSpTTjRO6/xsl5CPGQaw9pk/QMZ3Eu6P9LLf8ycNA37NblERaPkvZH87RplLr2KbIk0v+YGRWgcOdBn5cmVb8A42cULtICMhbyhY64cfEKqCK3QhIqoccS89uALzGqLITS5gBiGjslNy0cMZpyRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765841363; c=relaxed/simple;
	bh=Nuvl6evbZ8bG5/jRBW7knqrX/SRlQf2pVI+H1v4qDQ8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=pDpu013wbehEgLD+wzGYz2TggpyL6kjZZqYg17zrPP+SvULrVWbsD2Cqsrq4RgHnYlKulwAUbe4Ur1D6ZFN7k6VU8+Gf8L0YEKXFs52kMuh0U93TneC7hWE3zocMtB4fdchorAw7S186PICGZE2ANjfli8UC1kd/SbX6XtN+psw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWF6S0jZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765841358; x=1797377358;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Nuvl6evbZ8bG5/jRBW7knqrX/SRlQf2pVI+H1v4qDQ8=;
  b=OWF6S0jZSI5wVgeEzRPzngf9Ggx1auU1E5PUqM4oND0LLrE0UTKt/w0N
   SZNJ6dvlK8xdYkXHQM/8x7KtdnuqlPJtSj+Z7qoDLhb12l7izhZGuduy8
   pnXX8VIv0wKYpOYS3rjbfVTlMBcth/2iSWbrBxaZHsD0ElCPdq1j1ZwrD
   1GbnAYB2TifSvmP8Jj6z0hyGvWNNE0O5VWTipdBa6D21Uu4yR6E9S+YD9
   FQGAxStJ7666RJaKEeaxWD2YxKpHjWIxd4uEcnkRlE2Q/BNQJ5K8S7ZXE
   adu7pi42vM//0FBtpzNfxPtyTq1rv6swMMDE0fV5X2u/t0kz9pQ8U93eg
   w==;
X-CSE-ConnectionGUID: ktf3thkYQk6eQrWh4byBLQ==
X-CSE-MsgGUID: VZnAmB41TqK9/oYn7UQikw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="66940558"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="66940558"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 15:29:17 -0800
X-CSE-ConnectionGUID: nhpzqSdHTXK39JZ9oO4Ojw==
X-CSE-MsgGUID: TbPONjuOQ62plB83eOjhmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="202263571"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 15:29:17 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 15:29:16 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 15:29:16 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 15:29:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNb/88KsbP5zeDt6XXGoZx8nb1P4nmOHfi3GtX+oSxkE6HJ0Y0dr4kxEygIha+wDnwMhLdTB8Fcwf250FFsG7ky7xXqOo5hGtp6yhxJuc6QPvJxwmTq/u58BfF70r79R3r59paX0KEs0S1kgtGt/QZqD2vjVCQ/Lpcd8JgiYYZXSgETCithpwUpJXVGtnikbWBzfZndhtF/rO/4uJDUnwlNLtt4/JG4bwSK/EmunL7B7omZuv08gAHYibL2jRV9gi5GA8sxUhtO8LTyM4aluKdjZSZ2nLWCNm9FdQbRlxBEl9D0jqcYwZP9CZp1LZiaVfNE6u62zXyw+g/nTI8nLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2aeuIEQn2WqWpk2qSnK1LROEGpnBXNnCo9RT+WY5ik=;
 b=ygOacAnSg1jTduO1rRHbS6azh50VFVPZl7l/KGYJ9aWIS5A3usgjbsbDUtxYw0gdKzVoG9KH3P7o3/cQcRolojblZSbzotd15frAmol15/ehXLM17F5UzjOWOiNbO/rG2EdfZplUku7uRA0ydz0fVfINXn4cSaVJho3AMKSE6rwAjtVKgTSrlRH/xzpkaca6fB9fQlOSocZg9h7hi2JDuZcg98AaC+mVfSU/QXQtFUEunWmLEgDyKEN0BOXj/Lh36C/jKDAOW4YjV2axNmCYyFjLfLbN+SD3qVLH1khbEkXHTH8/zoje8k3Pb3gaNO7n4oC5cAQYrAaTuepCVuiS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 23:29:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 23:29:14 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 15 Dec 2025 15:29:13 -0800
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
Message-ID: <694099c96f509_1cee1003b@dwillia2-mobl4.notmuch>
In-Reply-To: <c7878afc-237f-4bfc-bfc9-aaded2e2420e@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <c7878afc-237f-4bfc-bfc9-aaded2e2420e@amd.com>
Subject: Re: [PATCH 0/6] cxl: Initialization reworks in support Soft Reserve
 Recovery and Accelerator Memory
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e66e2a1-d6b7-4f97-4428-08de3c31c285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVVxcEFjZWFVcDRzdDU2Ri9HTG5YWUxxdlNZOXMwaUs2d0lKOUowcjFsaHln?=
 =?utf-8?B?MHdDYU54MHNBYmxicGxkbmhyRTBDUXlGcDBaWlpRMkNVMTNwc0R3T0JXVVBE?=
 =?utf-8?B?OHdxOWZOVGU0dE5ub3pDSmhQQlQ3cisrWnVIb0Z3UFNBcjVLcVMzWGZXVnRw?=
 =?utf-8?B?TlpyWWhyVng5MlpnV1o3azQvaE16K2kzV2poK0piNTNZK2dId3BZMUdSdFN5?=
 =?utf-8?B?OHd6WU1yYnZra3UrSVVaZ25QMWhoWVBacVNZdnpWeWpNdFQ3aTk3WGNCK1BJ?=
 =?utf-8?B?ZFhFZVVlaFpaNEwxamJOYVM3TEtnRDY5T0V2SDlmajEydEU5SHBNTlZIMFpC?=
 =?utf-8?B?U0FZbGw3aExFUXI1alpaWDNnVWxuY1d6RmJFUXBuQ2R3bGVMVytyaTVSNUxZ?=
 =?utf-8?B?dHBnbHFLL2JoSXR2RDhTR0N4bkcvSGJMSTJnQzJQSU5LUDVCZlRjdFg1R3ZD?=
 =?utf-8?B?WTlSNytRa1BVTzVQb1c2dS9LZHgvVUovNkZxendrSlhzYlNySmN2UHpnS0ZN?=
 =?utf-8?B?aUJ6MzY4eTlkdzM4SU5pakVNYWRudVIvZXY0WWQwV3BOaE9XSXlybGd4SlAv?=
 =?utf-8?B?RFNJeXVMTzVQUFdPR1FXU01wNGVwOXI0blA1a3I5TDZBYkEyWnY5VU1Ha3ZC?=
 =?utf-8?B?WlhVaGh0V1IyckN4WTFBOWQ4R0Z2N2Q0aitnK0ZSMytjWHpVQ0c1bzh5eFRS?=
 =?utf-8?B?a2RKWGsyc3FTVzF4REIzc3ZQcEl5djhlUFBoWEwzYkNsWmZaN05tVzExdjNT?=
 =?utf-8?B?aUF5Z1kzNzAzb3kvMjlreUw4K2FqTzIvVlNXSG52bGtmaGtNbUxac25pRzNt?=
 =?utf-8?B?bEZoanZ2QWZjZ1lWNzRBb3BYL1BHMUJsSkZrQzFqWHJSUEpiclhiTUlHOUhh?=
 =?utf-8?B?SzdLYjVtbEVzdUlXaGpBMENSNk1LRUU3MER3U2d3ZVc2M1FNZlJQUUpLNStQ?=
 =?utf-8?B?b2ViVGhWVW5jakE5ZEtIQzFvQVl2RjNMWS9iQ3lVMkNJejljd3lGc2E5a28x?=
 =?utf-8?B?ZmZPREljQXNsd0k0RitpNGZUZnM2VGRxTnV1ME9LOUEyck5uRjlXbXE3MTBM?=
 =?utf-8?B?MG14d3RHTFI5ZE1TNFJqbjhNSGdjZjhsN29vWGhzOWVld2xTMWhXNE02eVN0?=
 =?utf-8?B?ZGMwdmRldHl5T3hhY0lMTTJGNnBBcExsQ215d0tDMzRvN2ZnazJFL2R4NDJJ?=
 =?utf-8?B?MkxiWGw4VTFhanNiaHNtbXpWU0lxSFdNVDdqdWIvQUh3RW1lUHNta1pCVmxw?=
 =?utf-8?B?UElyQTNMWXJyck1oV2wydlh2UjAwTEpDSXhIZkM4RWtYZWlkcS8zakwrMFQ0?=
 =?utf-8?B?b2svb1NaZTg5NGdqRXpkRVZ6K00veEtkWUJMeWVGWmgrMzNFZXlrNDkzMU9E?=
 =?utf-8?B?emFDc3ZkVDVCMUEraGNwazJwbWplNkFBQXp6N2xDcFloNTBYWS9wZ0lzbnVt?=
 =?utf-8?B?NlJDelJVa0JuRjBodi9EeFppdzg2MDJ1a2dCcWExcGI5Q1MvR2swS2dEVVF2?=
 =?utf-8?B?V1BWUk9NMnVRaTlBdjgrYi9SS28rNEgvY28xZ2NMWXZpOE1nNHpqQVdhZ3lu?=
 =?utf-8?B?ak9sNG1RSWVNUTMyTHd0Sis2ZU5uOTFJMzRmSkJRRzRYOGllTVI4T2l6a0Vj?=
 =?utf-8?B?eEtUVTFEK2ZkU2xqOURhY0VsRlRFMTZaMVMyREpTT2FyUVp1bTdTNWZKTldT?=
 =?utf-8?B?YXFYSDQvbVB0bXV2bWFrazFhQk5ad0lpVGU3NGJtNlg3YTZQVDdmTndhU0s5?=
 =?utf-8?B?YjZSWnNnbnRET1B5V0FacU01ZHJ1bXM5bEY2anZPN0JVQUF0Y0xFQVRqN0Nm?=
 =?utf-8?B?ZGVDQlVKSEdmakxHWG80TnI3WURXVm5ubTZ3QVJYMHBYdUFnUHBHUUJlT0VV?=
 =?utf-8?B?ZE5EanliK2kyRHFOS2RoODlZYTJJaHQ1MGhzK3VlWkI3RzFWenpRMmxjWWp1?=
 =?utf-8?Q?7KMhewiEzDbZjoBv9WVLxBhaYPMzvAoq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FKc1lMOUVXRUdtRkl5MUlpMDY3RytSQTZwa1RrR3lYaEtkRytDZ1psYVF1?=
 =?utf-8?B?VC9CczdhQjNGSnBVa29qOGI5dlBJd0RmOVJTWTRCRVV3UzI4ZjlXM3FYOXhk?=
 =?utf-8?B?K29ndkExbUw4ckVzeTVha252RUNzeG0yaDdmbXUxekdjYWZRbTZIRmsxODhx?=
 =?utf-8?B?cnVzcklMYlYraHRzcWNTS3JwdEczVlVtWkxwOVRoRk1VVUYwU1ZMM0pJQW5v?=
 =?utf-8?B?UW5yWTJHU1VFMThsTW00bmZZaFBnK0ZrTXN4ejk3aEhaeDFLZUp1eGh5ZnhW?=
 =?utf-8?B?RGw5Q1BKOGZod3hSdmN2cWVqejhscTBvK0dOdStDa1ZiTktkc1VxNWE5L1pn?=
 =?utf-8?B?WnhEby8zdXExNEl6ZjJ4Z3FYK2U4YVRLS09sYm5ZeXppZXM0MTF1bHpGMEZJ?=
 =?utf-8?B?ZTA4UExBZFFTTy9MaHlrVklRRmc2dDdYekczNGFsOEtCNGczYTdWdzN1Nlc4?=
 =?utf-8?B?OUJCNHg5RkZUWFJDTEdJMS85Z1lmWVFYaXBleDRaKy85L29iMTJyNWdpNFJE?=
 =?utf-8?B?Q0s3dkFlcXp2VkxZRlB1SmxaQVFCeVFPVG85L3MwSDFKQ2tYdTZrQ1VNRjBI?=
 =?utf-8?B?WDY3STBqTWMza1ZCazE2d3hRV2p0K1h2MVAxL3VNcVlXd2Qzb3R1dDhTL0lT?=
 =?utf-8?B?N3BTYnVpTUZ0dDcyRW1mQzh3M0tKYzJPSm1BYlF3OHRUOFVqT2h4L0FCQlYy?=
 =?utf-8?B?SEtaT2RUL2NlZFdJMytFRVhMZFZaMzA0bTlQSytqcEh5SVFWT2JVWDdFTnJq?=
 =?utf-8?B?azhhWmZueStVd1lKRldaVkZ1eTJGcGEvdk1GNjBCL1NpVXpyOFJiZ3hVMTQ1?=
 =?utf-8?B?ZW5kM0RzL0htYmowYUZOTG83b0xqdnluZ1BHdFZCUXJ5Tkttc1BnVFJUSmxT?=
 =?utf-8?B?ejJTZ2ZsTG9tQXhkMXZvc1RTRTY4K0FZU3p2WTlObTVWS2g1QWhmMk5TZVV1?=
 =?utf-8?B?RmZWTzJsdkhuUUY1YzhDVDJkb1hPeFF3ak9ibUtGS2RwK1N3emYxV0cvZWt4?=
 =?utf-8?B?TW5ESDdOeUd1TkxyQUhMcWhTbjZoWjQrM3NiZEtoNjlkelVwenQvejk1aDhx?=
 =?utf-8?B?SkRUK043VmQ1VG1HZEE3ZlEzQUkwLytqZy8rV0JhaFlicEtVMUZMamhSeWxk?=
 =?utf-8?B?b1lzSkdKQmlveDRHL1BaZWdJR1FiYmIrK3RlWkZOUUxBWjNkdzZ3TmNscDNk?=
 =?utf-8?B?bzkxekJRTlpwWVRTS3JacjRLSis1TXVRRjBmTEpDUUhRRjJUVDlrcDh6a0p6?=
 =?utf-8?B?MUpMN1owZmdVNDJBS0lnaUZRZjg3a1BDUTIzYUgyNmZ1eTB4T0VpQVJ5Q0lK?=
 =?utf-8?B?emplWlI5RlVYUDBSMWlRYWEwSnBZU2hJNnRER2RaTVovYml5ZjZOR0hsQXZ6?=
 =?utf-8?B?aGlPZVBJUXdYMDRlNTV2bUNNcnM5V2VMNy9NeCtTWnQvU2NkV1p1eDJ4akZJ?=
 =?utf-8?B?Qk5FQ0hvRTZEOTJtN3RXSW9ZMGI3dEdsV1hYeExORG85RDlrWGpWUExIQm5x?=
 =?utf-8?B?S3Exak9CM1VzK245ZGlkTkR3Y2VRYjBWckF1UXdlWms0R2U1VVR6V0xpQ25V?=
 =?utf-8?B?eGJVdFgremhpOVROV2RORXlOOTlidkwrVmlQb2dkN2k5elhPcVB0QXJkOE52?=
 =?utf-8?B?YmFaMmt4NWFJL2F5YWwxNTVKUyt1Ni94UldPRmNRL21qeExhMkJ0VzFlWUhF?=
 =?utf-8?B?TXRRYUszQVA2Qk1ZZlhMdU1xVVllTUt2bTFYNVlTaHJzZWd2YWVxdlZvYThv?=
 =?utf-8?B?NFNGZjFqSHdMNUFwalhqTXJFaE1IS1lQdFJrU1drTGhhdUZHQVpTbThmUmUz?=
 =?utf-8?B?R2V6K2JyNEoxV0V2VGZiMnFTS05xZUpBUjNiNmdlcVlOMUZEem9YZVBMQS9W?=
 =?utf-8?B?V2VlMzlJdGxjZmFYL2RqZGdPYXl3QUFpTUpQZ2dXM1YzczF6NUh3bSswMXpk?=
 =?utf-8?B?ei9IdmJEUE5NeUR6dUMzYXNLVVlqNFlTcjJwa1hUMEtqeHkzZjdOMnZiWGMx?=
 =?utf-8?B?VlEya0t1VThoQ2pGTkZQazdwTW80akhOUjNDQmhLZVkzYnl5Umdnb3RsNThh?=
 =?utf-8?B?ay8rcnUwMjUrbXBZVk8xUDZHaUhWcHdvR2hJL0x4NWNBSExoalhDb1VqRGlr?=
 =?utf-8?B?MVpTRXBNUG5iZmsrL1krMFhZUHJXN2dURk5WSDZEVzJGZDBUMDRzYlFCK0tH?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e66e2a1-d6b7-4f97-4428-08de3c31c285
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 23:29:14.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+Kv+kqKClfqDoVLoszG8MMfXel3AOjY4LBVUadnMXskrWyn6jIr3oG42c+u9yIREXDxD2RHqYloZcx1Yk/C4nkuYdK/NkvxN2eoFJsxlfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > Dan Williams (6):
> >    cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
> >    cxl/mem: Arrange for always-synchronous memdev attach
> >    cxl/port: Arrange for always synchronous endpoint attach
> >    cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
> >    cxl/mem: Drop @host argument to devm_cxl_add_memdev()
> >    cxl/mem: Introduce a memdev creation ->probe() operation
> >
> >   drivers/cxl/Kconfig          |   2 +-
> >   drivers/cxl/cxl.h            |   2 +
> >   drivers/cxl/cxlmem.h         |  17 ++++--
> >   drivers/cxl/core/edac.c      |  64 ++++++++++++---------
> >   drivers/cxl/core/memdev.c    | 104 ++++++++++++++++++++++++-----------
> >   drivers/cxl/mem.c            |  69 +++++++++--------------
> >   drivers/cxl/pci.c            |   2 +-
> >   drivers/cxl/port.c           |  40 ++++++++++++++
> >   tools/testing/cxl/test/mem.c |   2 +-
> >   9 files changed, 192 insertions(+), 110 deletions(-)
> >
> >
> > base-commit: ea5514e300568cbe8f19431c3e424d4791db8291
> 
> 
> I have tested this series with Type2 and it works as expected:
> 
> 
> 1) type2 fails to be installed if cxl_mem not loaded.
> 
> 2) cxl_mem, cxl_port and cxl_core not removable as type2 driver 
> installed depends on them.
> 
> 3) cxl_acpi is still possible to remove ...
> 
> 
> FWIW:
> 
> 
> Tested-by: Alejandro Lucero <alucerop@amd.com>

Thanks.

Do note that module removability does not affect the unbind path. So you
can still do all the same "remove" violence via:

"echo $device > /sys/bus/cxl/driver/$driver/unbind"

...as would be caused by:

"modprobe -r $driver"

...i.e. nothing blocks unbind even if the module is pinned.

