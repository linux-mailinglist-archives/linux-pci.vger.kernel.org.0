Return-Path: <linux-pci+bounces-42659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 907AFCA5606
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 21:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D18D3300BFBD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64857322DC1;
	Thu,  4 Dec 2025 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHbvjj+Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E84320CB1;
	Thu,  4 Dec 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881418; cv=fail; b=YcOM1BX5+uzeETCMidLS3Pf6IV2+f+5GJ05jR7kbz8j2DGNtISisSlqVLQ85W0kI0pwlIMBilvciGnNYenTCtLmObdL3JbAiISYQglw1ZI4eVTw+NF7unzk/TbrBHH38l5qlH7GxTBn9t5oombSwARDp1J1uY04Zxh65XLeEmhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881418; c=relaxed/simple;
	bh=7QkFZ/A+7CCAtSR898nWFmQcknP9nsaCDNPjWhXLVsI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Ab7PntggEmTfE9LziCarmTRME4MrZyH+2lR6HQisNRZ7WCBDgZvYVIRh1YjeeRKyYasjHMC+zG+wF5O/XIKGi6ngjR+QD9RvW2nDVIjDPrHTG5xnq4u2W3C80CerqwehPvYc0JAkp3UGcqG/SoXXjM4YCoYBwtZW3sTnqn/YPUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHbvjj+Q; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764881416; x=1796417416;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7QkFZ/A+7CCAtSR898nWFmQcknP9nsaCDNPjWhXLVsI=;
  b=NHbvjj+QO4tFXkOmKxqSrVle0lxD67qXQa2j2PnwSsjbyhXfDRNq7Qti
   Z/7ADc9X+9JIuVF2QFPd/TGk49TFQ/55vKkA9zY9dmntxAVQrpzV5bGp3
   ihkL83hLli60N2F9Gys6yrlp3a0i9x5A2YPwywl7n4V7JSL6DrUUuc+gg
   iZOSIesOWZ8Kb7shr2ci9e/h2z6+qq04pATMEeyR5sm236DGa7ZX+ZB51
   VWfthnAELLNrPLICBM7RGnUm4dGNJ2yY+bHjevBQzotmPwjn/N1uwj6Km
   ajxsP5DqZt6UX/DmeZnIf6UrNYZhxFTw5e9R1zBFOXM1mFXYLlXDarSmp
   Q==;
X-CSE-ConnectionGUID: c4yugw/MRVS4mtW7b4AEQw==
X-CSE-MsgGUID: 21zfmN/WSOK47jz3CpA5Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="65912863"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="65912863"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 12:50:13 -0800
X-CSE-ConnectionGUID: NaNejIfmTrOC+j91dmU3ig==
X-CSE-MsgGUID: ZuZJkM4wTkGhxw1QsZBhGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="194747056"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 12:50:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 12:50:12 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 12:50:12 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 12:50:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvJoMGX76z3bFGWI4c2LYM5jJKg+/uVrozY49h58EkvdSjKZBA7XEYcJSragvGgm+L4//zgGS+Rt6F+NXo/tTKgINVCxiLJCHj92q0WoQqOFuICEvrjTrh6TjWoX0mm4SdzHeR3k9vw5NKfrLuk6X0bmmelOLWGD2WDzj4oWS4M5tWODIdGVx60Her++Wylfn16G54dsJIsh6WWV54PrDG2oJHRqToirlzO64hJxuH1rbx8UF9qLKpQAjzEK9Ja1ccm3WdyPyfU/0MHY801aeVFYeFifpXA0VqMvQncCPs3WkDUWW7qiFhF0CtjgMdV1pLIkt+C9EuivLtfV6emtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rRVX6l/vrtt89AE+fUxzavCSefDzl2JPP8t7vcmp4M=;
 b=mg0S3q+Y7LGO9DJt5Uf6DgiRt5CHjgJfWnOGCA2Dpj7i/rzlEy6x5QkSrHNR7zsEFDSGLT6S3Jk6dodGz5ts8xlP8Q5ycfpfCpuL0P1krobfTgp1BnQOVMs0UtHwils7VNp/9+PNU6oGuqtc4R3mE8WRyzJp5SpakGRlaPnoT8OjGphMZ77jNxtYjaA5GuomPpSzpQkjX5loO6y+jBvLzXyx1T1SOnCjdFYmXdD0bdvR+HtvvqX1QEBu7UoGIrc/T+e8/yWuHXiQS9HmLmQDlbAXKBvuEHGnCZ3KLYryrF94fRjNbBeNpF902PP5/vGKxY7jdQw1b6nhqCQxcl6YYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF551321A38.namprd11.prod.outlook.com (2603:10b6:f:fc02::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 20:50:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 20:50:05 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Dec 2025 12:50:03 -0800
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
Message-ID: <6931f3fbae919_1e0210062@dwillia2-mobl4.notmuch>
In-Reply-To: <4e4e19e2-8aff-44a1-ba4d-2a4519745a3d@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-5-dan.j.williams@intel.com>
 <4e4e19e2-8aff-44a1-ba4d-2a4519745a3d@amd.com>
Subject: Re: [PATCH 4/6] cxl/mem: Convert devm_cxl_add_memdev() to
 scope-based-cleanup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF551321A38:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfe921d-db5b-45cb-b289-08de3376b42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFlJTFdneGMvY05NUnUvVW10LzJSRG83WkI1R0I1R1p3ZE54SGw4ZGdBTjA2?=
 =?utf-8?B?L3ppbzFJQnQ0U1k2RTkwM2VTcnYxR3FIei8yL3RacEJiN3dHeUpFMVRaeDEv?=
 =?utf-8?B?Z1lzcWhrdGsyeUIzbElYSTN1VjhGcWEzZzVIdHlHL0NxaGVaOEVXZmpKSHF3?=
 =?utf-8?B?cEhEUjZ2R0xsMWhQRTRxcCswZzhZOWREWTFvMDVHcVM2dTZUbVVESHpIeVAw?=
 =?utf-8?B?dnVYNlNWRnhMT3BrTU1Gb1J5Z2RCTmdzMGlMSm1hbDRpZWxPODJOZExVT3dW?=
 =?utf-8?B?SGZvR3kvNHA1OFJZU3BsdVVFb2NqQktGWkZsOGVxSWhYS0JVaVlQWStxbDEv?=
 =?utf-8?B?WXI5ZVVmZ3QzeVRMSTZiNFlieVlVUFF2L2QwU3N3R0pQYzNTK1dvcEp0L0NN?=
 =?utf-8?B?RjhhelNSclM4WS9TT0IyNU4wS2xGdnFVYytMOVJ6Ung4eXllWjAvenRyVkxl?=
 =?utf-8?B?a29OWUs4a3NkSGVrRThhMUpxeEJCcWx4anNkam9Ba3RPOFVJUWthMkg4b0dI?=
 =?utf-8?B?Snh4K2NDUGlaK2NRMGZEVkNSa3hWMm1iOG1iUXJLNEM3dkQxdDRvWDk1QTYr?=
 =?utf-8?B?SGw1QzlmUVNaMTRqZjkrN2prZkJuQlc2V1duTCtRSXhLaU1Wd3pCb1FqRWNx?=
 =?utf-8?B?YmZCSFlUQXJ6dHRhSGxpbUZDR1hadjYwd21NenE1WWNCSXBmRGxKdjJ6OHRh?=
 =?utf-8?B?TDJpbUpudVNzY2tTNjJ0aFdRUkdqeWIyeXNaVE5MZWlWb1BqWFVoR0NHdTc4?=
 =?utf-8?B?S2N0VG5rQWFhQzErdk92VW5pM3FRNytPcUJIdFNiR3o4ZFlUR3hMTzMrRHBK?=
 =?utf-8?B?bzEyNE1UUStOaFM1RnM0eTJKZmtTb2Z4WUZEN01hT2NBbEd4K1FpMi9kT1Vo?=
 =?utf-8?B?WlFyY2crelptaklzY2ZTdEswTU80a2JQcUo0TFFINE1GUnRRUmRMbGZOemM4?=
 =?utf-8?B?Q1dacHY3VTBka2xCQXJlRTRLTUtER0dJZFBydDJrOFh3dVJyTGp6a09TMjIv?=
 =?utf-8?B?b1BmWlJOV3dyYjY3TlZYM3NpWlR1WCtLYzFXVGx6K2tPY0tKMDk4bkdPUVh1?=
 =?utf-8?B?SHZvS0Z0Q2tKZzI2dFBVSU1XVVF2QVZTalE5cnc1VnpxMFlSRkZDNUg1dXhv?=
 =?utf-8?B?QW5JZWtVdDBVLzNqK2NRUUNIQUNYWTBxUFV5RmNmZ09ldWRsWUxMaTEyRDBz?=
 =?utf-8?B?cDhGMGdGcEh0RWNQd1AzNXF5Rm55Mi9jNVJVWngxTlJHcnBHRktPMDR3SXdK?=
 =?utf-8?B?MDNJN3dvNlF3N0JSN0FxOTh5Z2hhUlF1VjQ3a0l1SG9ZZURCNVpNd0tYMFpv?=
 =?utf-8?B?RGhjZFJUMlBtZVBOOXZQcTY5UDYrUUlXK2VTUVVTUEhBS25CSi95YjM4cTdy?=
 =?utf-8?B?MUVpQ3h6SnhCYzlOSUdHcDdQaG1PUWdSTzVxUlJRQUI3N2VvbkRlN2NUdXFQ?=
 =?utf-8?B?a25ibkR6V1RCTTh0WlhYeVI5WE1PTE5ESWI4cUVIQWxtMklzUUMxL1hsR2hx?=
 =?utf-8?B?L2pnS29DWDdqaUl2Ykt2bExqVW5BdjdJWnh2eUZ5VWFHTUxvNTFOZTNRSi92?=
 =?utf-8?B?TldBcE14cFYyc01DdDFVTDdLdWdGdmZFR21iWFlvVFZqNTNFQndjQmd0NzBX?=
 =?utf-8?B?UlozK1BOOHZqejMwUXI1S1RGUjhyeEhRUm55cjlmaGdYd05jcmp6RTdvdGFq?=
 =?utf-8?B?ZVc2VEVZajN1Q1dVWEg4NTVzSTF4aU1ISlpBOTNYanZUVVZzWktSdm4yQ0s4?=
 =?utf-8?B?TDVlbHl1cUFVZjFMRnNMMXRidG9iRmE4WDc0THlwUnN1ZnZ6L3lxZXM0bk9i?=
 =?utf-8?B?Qm9WaHNYbjhWNGdOZEhFdmtBbUVjWWx5OUtGSEt1aHUxVW9QUE5lYWdZRk53?=
 =?utf-8?B?Y2IxQUNlZW9vL0V0RnZhRGx2U2RFRXJEOEltMGVKMERSU3dKWW41OEV3YkRo?=
 =?utf-8?Q?PD6d+DWYV8Q4tDkBLxA7GKwqlDYVYu7I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDRYSlI2aExTMWFtMWhOc3J6aEZZbEJwY21uYU5TZVVQMGtFRG1FSnlHYmkv?=
 =?utf-8?B?TEFCQ3RxYTV2ZGF0QXVJRmkzSjVNL1ViZUp0TGwvQkpscGpyYVF0MUxLS2xI?=
 =?utf-8?B?dHdVZmVocUVwQ2dhTE1LVnNYdU1yMjlwdlZrQnkxa0VWOEFaeUkzVFNDZzcv?=
 =?utf-8?B?SnFWeFI4dHF2T01TTnBkRlM1WG5KT2Zza0JGRWNzbVJrYit1Z0VCTzcrMVJZ?=
 =?utf-8?B?ZTY2Qk1RS2MvQUtzdVlmdm1wN1J4RnFmbFVScENNZkMrNzRTVTRFbzh5WEpt?=
 =?utf-8?B?VXcxREJRZHZiWkg0SFloUjBlNWkzVy9PRFpmb085VXYydk9TbGV5ZW9RalBx?=
 =?utf-8?B?c3A4Mkwvelp6M3lscDZHL0RJeStYNTNPZFZvNDZmRlUvT3FvaGtnYlB3b1pS?=
 =?utf-8?B?RllYZkh2a3VJQWFhRk5PM09KazhKOFpGR2EyOC9pR2N2UnI4TUVsUTZOajZQ?=
 =?utf-8?B?elJZbmN5NjlHcDA0b05MR0dFNHpJOTV3SkNuOER5dTZkQ051WkpQY1Vkb0F5?=
 =?utf-8?B?S1dhc0F2VDN1dXNURWlnSkJ3RG9NR0pNUFN1NnR4RjgzeGU5YnBqa0RMaUVr?=
 =?utf-8?B?Tzdyd0gxZ2RLNytjVUdzUmdlMEIyN1IxNy9SclFtb1VDVzlmMm96dWM4Vyty?=
 =?utf-8?B?TlVHMG9ieGUyMFpxb2NhalNacnFtZWhQNmFtbWs5UGNOenpIbW9HQnNUelRl?=
 =?utf-8?B?UVltelJndCtpRnVlRWo0U0EyN0xUdVE3cklvVXFVa00zWnhxTWNTai9LNjY2?=
 =?utf-8?B?QlFkRzRRUUxqd2Rvb05LazlGMDlhVkwydlNxdnRXM2plTEV6RVJsbGZ0QitE?=
 =?utf-8?B?SGZINTlya0N3RmZYa29ncnV2enFkM3Q5U1FLRTduWEdEeGZrWG16cHlYZm8w?=
 =?utf-8?B?dnFXZ0J3by83aFhzcmZPemRBZlZmMUxMS29sdm9jaXJLb2RSSlpKWTd6akVK?=
 =?utf-8?B?SjFodlRmQ0dzbjQvRGVybml0enFjTTR3d1hKN3dUVmFWUmY3NnhDZytFV0V5?=
 =?utf-8?B?Y3dBdkVBV1dpNjhTeEZ1MXQrTnBZS1NlcDc2WXAzeEdSYXRaWkd5MWswbURh?=
 =?utf-8?B?b3d5SjYzeTd0dmY2ei9HSVJIakVHa0V2N0xYUHArb0NRSHZHWFMwalI2TlZE?=
 =?utf-8?B?WUw2MFBIN0tWWVRCTE16TXJLdDdnOGVtV1dJa1V1TVdWMmlqV3lRZ3lqMlpt?=
 =?utf-8?B?aEVKVkdSNFIzTC9mV3NGbGdJVHRiZE02U3FidGxyVUxNT2Y1MGEzTkRNMVJs?=
 =?utf-8?B?L3BYNWV0U0IzdDVxOUJQTXAzU1hpcW5rUko1Y01iVWt4ZWd1VXN5N3N1a2sw?=
 =?utf-8?B?T2lZZ29JV2xwSlVrTTNNQmlueUR1T2hVYllIelpBU2RNc2w4UGNtdUlNcXlC?=
 =?utf-8?B?RFZUQ0pXR1pxV0JWTElqWDRnZGM2VlBWNE45RjZiNzRZOHoyZWlySkJGQUdo?=
 =?utf-8?B?ZjA5a3FwM0JraTBNeTFSUUU4VUxLcXN5SFZFWStReEhZS0NkK25jZkxtdEEw?=
 =?utf-8?B?S2RjMWFuTElBd2ZSejRqd01HMUxaeVdYVktVQjBEZlhlSHpjcS9vbndPZitN?=
 =?utf-8?B?MHArZUZiQzhKT3grWHBqbnFDdTByRzJ5ZG5Ib3YraXB2T2oyOTJ5NzNLWC9u?=
 =?utf-8?B?aDdGWHp6T3E0dGlKanJkUU5PNkpjWUNmRERsUXYvN2p4a0tIdG9TMzBxVG5o?=
 =?utf-8?B?ZlN3bE9EMFRBd3kwYjh1QVo0R1A0cHNqbFNoOHpIVTZJNXFJNkJTc2xoL0Vs?=
 =?utf-8?B?cjJkc3I3Slo5SjlBMkZha3plaDdQeGpVMUlmdmtCYlVYbFRXaVhNdFMwN2E3?=
 =?utf-8?B?c0ttcU9zYk5IUzlUbHJPbUdxcVdmSis4K0xSYndnRlQzSGJudGEvUURyMDNH?=
 =?utf-8?B?eWxUYnA0WmR2TG9nZkpWYTFDY3czazRMbVUxYWJNak0xdkdvZWwraGlSc2oy?=
 =?utf-8?B?dUVybzQxY2s2TCtUS1ZDYVpaTXFqc3htcVNKV1pQM29OeU1Nek12TjZnUGp5?=
 =?utf-8?B?VE9qYjdISk02QldpR1BzWGtLa2s1TVRZRGVpZzhpQS9JbnY2ZlhIZmdaMWFq?=
 =?utf-8?B?aXZqTTFqRGVrUEdVMUZmOVF4MitYZHQ0YlFUMk5ydFlsQnpBd2FaQ3I0T2Vi?=
 =?utf-8?B?VUlYbmcyNWllRURTZmVTOEVEQkhKdVF4b1pPNTV6dGJiWlYwbzVuRlRTQzB6?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfe921d-db5b-45cb-b289-08de3376b42b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 20:50:05.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fi9kDQ4gZW1cFOOVuM0Hv+r4C2LEwT+jNiuX3lPOcTRZzie1SxFKcf9ECsYpgk8/BRFPexb5j21sbsc8MOhwSGR1xm1WPh5toDo7AyqVJZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF551321A38
X-OriginatorOrg: intel.com

Cheatham, Benjamin wrote:
[..]
> > -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
> > +	rc = devm_add_action_or_reset(host, cxl_memdev_unregister,
> > +				      no_free_ptr(cxlmd));
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  	return cxlmd;
> 
> Isn't cxlmd zeroed out by no_free_ptr() above? I think what needs to happen here is:
> 
> 	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
> 	if (rc) {
> 		no_free_ptr(cxlmd);
> 		return ERR_PTR(rc);
> 	}
> 
> 	return_ptr(cxlmd);
> 
> Looking ahead, this gets nullified in patch 6/6 so I guess it's only an issue if
> someone is in the middle of a bisect (or doesn't pick up patch 6/6 for some reason).

Good catch! ...and no, I should not leave that bisect problem in the set.

Will pull the cxl_memdev_autoremove() change forward for that.

