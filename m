Return-Path: <linux-pci+bounces-21257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A4A31B20
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 02:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC0F3A85F0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062DD2C1A2;
	Wed, 12 Feb 2025 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iM0xaNLD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F617991;
	Wed, 12 Feb 2025 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739323446; cv=fail; b=j1eVKKqwdq2gkw3wsxt8VJT7KGQmvuqA8rJuNo70IW1yJlBfQh0J56Rfh/2aohoIHFT7pw7rD3lUmYfY+v6I2hAn2E3MRPt5iSYVjgtit1wvfhkoYD0gNIPuchpc2NriOb5kmAQIRS3PXA103OpPlefY6cd45sbsB44oAf2ARig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739323446; c=relaxed/simple;
	bh=4TfQcHUyJjz4bF3Yl9EVN43H7w/GkRpOLcJQvQs6EQA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IUX8F18N50oHYTIP/gDT0m/Aa4AKVxN361hWibZc5P3vS/hsIpS5kkBaBLN3W35NrRkf73QnOPSF8RqVI2Ls+8VDXgSWPA2EVeWSScTVLwqFecGVb7nCXeerDJLknAFY2oiGcGp8dKOkEhyE461ze/9Jm3Yu365sdgn9pwvE7yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iM0xaNLD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739323445; x=1770859445;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4TfQcHUyJjz4bF3Yl9EVN43H7w/GkRpOLcJQvQs6EQA=;
  b=iM0xaNLDQIl2WsqtkCvUujRy2T4B26J6Tsdts9M70cDpgmhm/PnGg4hT
   7VuuhmuDKKWS5UgBDCg4UjwqAxS6wxtnoPtL5lkGZafFST4gs4wd65NBF
   SSsDyPIHORxh/7a+u5QsNQL645K3Ah1HUYg7eVM7VSLLZ2v7guiyddqGi
   WNWMRcf8M3WzENjcp781nh4CQDALJIvgYsQWi7cWSLhwExAUIFbEHPSKw
   VnExYSs1xSPAVKET2Ubta9GGhwNVrojtMCqM4xCJvGfIks2CaEmetngoi
   yVjIEjkNNeSxtwNdS1D/otV9TvWtTx/zE9Jn8TaUWr4BDjKhhabqPmc5k
   Q==;
X-CSE-ConnectionGUID: J50XQkDARA+kzlk2vkHeeQ==
X-CSE-MsgGUID: vP5DBR7WSTq2ETN+0AYpyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57501023"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57501023"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 17:24:04 -0800
X-CSE-ConnectionGUID: O0McBTpeT1C4BlxU3J0b9A==
X-CSE-MsgGUID: ttgiUQMMRHGRNpLqKiXsag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117849932"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 17:24:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 17:24:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 17:24:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 17:24:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+11/zklm2ZdnYZC7q4Hk4tqAH7/e46d8muJp9ncdRwrXAiSPr7bhwEsf4rmbZR2bRHVt5DazmTp8yi0J+ht9LVf0zY4dYKg0KkJcbrgaE9ZkfaVWrxxjnQlNJxFgupxJi60YC3k5YGa7ms+IjQvzGVdi1z6PI920n7cFjI5EB77IKBWHaWtAzTUo2fZ6fGwUFtDI9PsF9RA8YGe5UMizmM8cHvfSpliB5DYi+hoaUxn0zOR3fr484RI4tZ5ww6K439DkvTXhTWzDPX9wAjfW3bhwS/3oRlS2bpZoZelMDwYnSES0GbuVyl6vS4hg5dKfgAf5uxmwuOtbtGPU3fDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3TnLZ/0ygc6a3EHdCXVPN+XiLAWWXgkCFz4lX46vJ4=;
 b=B3o8949cvXXlEPDcrFiOosTFvWGrMZfrfZWxIOky9AsMtorQoVSeMi/NtpeDnZz5ziGG+wzTmpyfdULtqw/cYuLy/NAQ6Iv0d+1snjY9H84dibdZ8WnMiDgvz27Tgibu0M6R0I+giMOHKVxQm2jYFPTQ0BftK5sCleacNzuM04kPGcnwJd7Ru38yZRtHdA6kz8/BYlfIiDiXP53u0NrvTMljYLLGEp8Ve9vk/xYqLobP1igI1CrOl40XtMqBP/Y9tQAC4QXAboHhbI7LaEBB4mq6nQ+GTvtXgZcrV8LU3R/DZ0H54r3/bzhly8306DCbJTE9/EhapEtiqZH5LoXctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 01:23:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 01:23:46 +0000
Date: Tue, 11 Feb 2025 17:23:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <67abf81f4617b_2d1e2946a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-8-terry.bowman@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211192444.2292833-8-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 36461891-aa34-4dce-fc38-08dd4b03e55f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2ZhRlJJdzkyOUdQL1YyUGhENi9jcHBJSENuUFRZbGVTaUtvbERncUF1ZEFN?=
 =?utf-8?B?SDRTSVVRZW5vZExaK1BPekNGWDdzNHlPVzkwNTNqTmZqRldISm9CSVJFaG14?=
 =?utf-8?B?MXFTWG8wVHVXWllmM3hEU3ZTWlJISE5wVVpvL2NQZ0VkamNCSU11Sjl3YXo1?=
 =?utf-8?B?VW95WVlRVUJJSllvcU4zRGI3dXBwdFNVU21oYkVMcEV3MmxadHB5ZTlUS3M5?=
 =?utf-8?B?MWJ6RVdPQjZxLzIrL1dZMDRDYm54NWhZS0ZaUVdVc01xbXpKNXlMUmVwd09K?=
 =?utf-8?B?RmhKVWVKa05jalA2bjlQeGpKTWZiVTNLeDRDUnJsN2dGaXMyZXNtZmhCNVBG?=
 =?utf-8?B?Z2tYL1hwcjBTTXBCZnZOYlFVQXZUdUpIZDZrTGh3N2trRUdhOWM2bWt4aTdK?=
 =?utf-8?B?Ym1xWnVlUDIrRHFhMU52RkVQUjBYRk8yWWlLOUQ5MUtJaDFXWE5pNHZWRCs1?=
 =?utf-8?B?OVowNWhwM3pPOEVPYS96M2dlSHpJRDRkdzBHZ1orbytHN1VYQ1FOS2p3OHdP?=
 =?utf-8?B?TE9TWUhoUnR2d2t1NFN4V0NBT0k4dE9wRE91aHJhblZTVSt3KzFGc3BFeFFT?=
 =?utf-8?B?M0hLQ3IvUnBkZ3pLYm9qVWtHUnNnbk9LSXVmRkYyMm9jQm1wY2ZWQnZ0RGFK?=
 =?utf-8?B?MHVHV1hnc1ZXNnQ3ek0zaUtvamtNV21iM2Zzd2lhVXk4RFFGRmlHMHhybmZt?=
 =?utf-8?B?QkFidGkreG5PS1lEalZ6cjhPTkNwUEJsSHpqWlRBd1pJaytGUjRuR0MzOEcx?=
 =?utf-8?B?ZUh4cXVMSGRyTGJYbHRESmNWNjB1OUl0eXp0dno3SThkbjBJeHhsNlVMeVh3?=
 =?utf-8?B?V28xWE84UHU5SERRNUR0YURnd1QxVUVWTS8vN2x2MGRTai80TDQ4L1AzZFQr?=
 =?utf-8?B?enM4YnFJTzFHazZCRGd6QzUrbmxFUlBwZnZ6OFBuNFpDUlJzbGRzVlBYQnI0?=
 =?utf-8?B?UWE1UUdvbWwyUEttTGRReWVhbEZTczZla1VyMktZeTBFdVphQm5KaWhQNVd1?=
 =?utf-8?B?dzlZM283UTU0ZkNNMWM2UklSMXZPSWNTbXhxOC8rVDM0cnVZclFpL2NKc1RQ?=
 =?utf-8?B?QXlvVFREdXhsd1UxLzBDbmptUjdBY0xhZmc2QVRlNm5xcHFrU0wya2VISllm?=
 =?utf-8?B?TmNpYW5JaGNld0lqdjYxdjcvWnl5aXFTcWZ5UGFlWmtWc3hLeEtGS3AzY2Vs?=
 =?utf-8?B?SW9kK1JQN2YwTWVBazQvQzF5SGcxWWZFdkxYMzRnWHpkWkhZU1BiTWRZQlp3?=
 =?utf-8?B?Tjl4OTZSTVZHdTFKRU51bmN2WkZFQUV1U080M2JPUVc4U2swL1BnWTZJVnVn?=
 =?utf-8?B?QkgyYTNSQmkzR3BvcTF3RGJWa0FQYXd6MkJWRU1uNVV0SnpreStoTUZVL1F5?=
 =?utf-8?B?a3hTL1RhbE9udnBHS3BmTzZCTjF6TmlYdjUwR1FuMjIyb0ZQanBsWXlMbTJv?=
 =?utf-8?B?ZlRzam9iTUpkR0VzcVRPL3NtU09LSEJOTnMvdmpidW9zdlJrTGlRMC9YTlFJ?=
 =?utf-8?B?R3k0d01NVkNhbkNtYjRrZHFVelJCejFLOG1hLzNuNmIxRCtzUEsxRmJqMmZG?=
 =?utf-8?B?SDVQUlJDenMwNjBEeGNUMHFOVWtCWWcwcWg5S0tHREFsSml1K2gvNk9NOFlT?=
 =?utf-8?B?dEhzdkUwb3dBWi9wQjR3bE8yWkpaNkY5dHhyb1ZqbFNDeDVVZGV1aVA3cWNs?=
 =?utf-8?B?cFlsKytjc2hqVTBXRXlKcGkrOFNmTzdjenRqcXc3U1dVT0kraTdSK2Juc1Z5?=
 =?utf-8?B?VzRNTlhGY2l6VFNvb3FXSGxrZiswaW9MSkszZ09zdm5TYkhvcEJOc1RkbXFJ?=
 =?utf-8?B?R0pXNUFORkF1cU1vOWF2Z2NYRlNaa2M3M3U4MDI4WWtyRGVxc3VJZDZjcHRG?=
 =?utf-8?B?RFUvMDBjbmVtdkRMNDAxY2xyOWpoZzJRVnBIcksyMWR2MGkrd0xNN2RlU24w?=
 =?utf-8?Q?E9WDfuzGV/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elo2bVJYd3c1NFFwMjlMYklKSi9YQ010dFR0elB4a3hvckgwSkVYVnhEbUhj?=
 =?utf-8?B?eEVPckVIZnFBTXUxNUFtT1ZuRmcvYkxNL0swQXBzZ1I3RnJkaFNreXhkY2JJ?=
 =?utf-8?B?a2Q1QUxNMUZuZE5sZXVrZUZzUE15RXFZK2VyaTJpelJHbVFQVnU5c08vUDl1?=
 =?utf-8?B?T0lMY2Z0SXhBTUEyRVgzOVMrME1POG0vbzV6RnFFSFVFT0VWRlgrb3dmM0Zs?=
 =?utf-8?B?YWRGRCtsb1RLM2p3TEdzRjhiV3hjWDBGSGVLcXkrVDJGQklqTXFlTHZnd1gy?=
 =?utf-8?B?WlJkVkFMbFdBdFRWUjRDckhZQlNHeWx6SWR1RzM5Z2RaUkhhL0dCaVRCMVFO?=
 =?utf-8?B?UGdaTGs2T3ZQRHlTSTBPMFBydjhFOFArY2dKZ200RlE5K1JpRys3cDR2bFZV?=
 =?utf-8?B?b3VLR0JId1dKSm83SjFkMXN0ZE9DYkFxKzBNZmVFVGduSklEZU9nVmlwV1RI?=
 =?utf-8?B?OHhhbExaUzREVjU2dlhlais4UGNjSGhKRXNJYTZ3OSs2YUU0R0d0SXo2Mjdw?=
 =?utf-8?B?dUEyL1pwcTh3YjVjZ1JLMkVmZ1lGVndhSHFwcytlTzVGU1lEYkVLazBkYXJX?=
 =?utf-8?B?QjlsYUc2OW05WTdWSVhDTVMySk13bHFSbGo0emk5aEJhQ3owbkQvelovQlZh?=
 =?utf-8?B?M2RSeittRzVlZGpWQ000R3JoYS8vNmQreUQ2b2NydEFPbUlyVXFzazFndHVp?=
 =?utf-8?B?QWZvVVlKZXd5cERJcVV1UlAzQ0dyaDljdHlSVlZhZEV2cFhYQnFHRDRPZUVB?=
 =?utf-8?B?am9UNnNQdWlyNi81cCtkRHR3Q3d0ai9ua3BUekxidnpQN3FMN0FZSWx6KzBy?=
 =?utf-8?B?VjYvRkRHYXJyTkFjUjdHQ3p1bzZJNnRtbHFuWjlVRjRzak1YcFp2UisvYWpS?=
 =?utf-8?B?SXpOenpIeHNDTlpSOU5PMGhCVWNRaTRsYVpVWC8wR2s5ZHg1TGU1T3N4Tys2?=
 =?utf-8?B?WlBkZmsrazNGSXM5L2lXMUtRd1QwUWs1OGFoVXFjWTlGdDFQeUJ4ejJ1Z0Fw?=
 =?utf-8?B?VWk2VVUxK1J1d2hxYjdlV0w2eWdsYTNwREFxMzNyS0dTNGM1RGRueXk1VDA5?=
 =?utf-8?B?SDVSV1JURkVBSytBejZkRS9zbVVZOE5jT1ZrS1EzRG9ZY2N0K2NXNnE4TWVL?=
 =?utf-8?B?a2tKbm1JMXdBeVJHWDBDZFN1ZzNtMDh0OEZzMjlRVUFBS0lUMEN4dlE3a2tE?=
 =?utf-8?B?MVBWL2EwR1JRTFJQKy8wK0FkcmNxTTk2S1U3eWYxU1V2OUprNVQ2WW04WDRo?=
 =?utf-8?B?bzVxRmxoOTVoQnM3b2trR3R1TENoL0tEa2ZQamIvNUEzSTBDNkM5TWkwczNu?=
 =?utf-8?B?azczTmI5WE9lRUNhMmZpSEJoMHFEa2p3QjJDb1paRzVydHJpUnZkT3htVFlE?=
 =?utf-8?B?cW9OZHNlSURpT1JjSC9zcENOMXpwMjBBVHBTcFBTZmxvUWZKbHhwbEFSN2gv?=
 =?utf-8?B?dndkVHJnTVBZM21TUzFZYU9YM0EvWERCNWZ0bHpqKzFrbGF2T2R3ellGRFVN?=
 =?utf-8?B?dGdaYTFWNHFkdGxsKytnZkR6OHJvM1Z1ZUhCWndIMXNjZ0lRUDNmYUVIb0lp?=
 =?utf-8?B?c1ZKSTRBUFlTYU9JV1RXWjQxUjhSNzlEQzZndkIxRHRWQVQ4Q3lDWmF0alhl?=
 =?utf-8?B?Z0I1THhBa1Nncm5qc3pHMUMrK3ZKYy95NkhmWTY2VTBoZ2FwbGE4YjhUUGx0?=
 =?utf-8?B?ZS8yZXA4NWhCL0ljR3lDNWhYazF2K1lQMlN6YWM1Qlk5NzBJeWNMc2VITjB4?=
 =?utf-8?B?YnZKdjNWWWYyYktZTWtGWFZtWVUxTXpQWjBZNk1iVjhjWjNSRDhrSWYwZEM3?=
 =?utf-8?B?NWFuT0RwOW0yRk4xcG5vNGFRRGpueXdUSFF4TU1zdDlOc2xDQUx6ajFtRUJJ?=
 =?utf-8?B?V0VCYnlWMlM3eE9DbHV0STFFcHF2dVY4VmZJQ1ZKeEdnZ0svL1NSQ2x2VkdC?=
 =?utf-8?B?TGs5amdmOGRXVndwT1d5L01xZUZCbVlvcUFSNDFBalkwM3FQbWNvb004QUEy?=
 =?utf-8?B?UkFOdGxUa3N1ZTR6RGlFRXZKZG96MldrVzV0NFhBMWtPVXRWWTNNaGZoaWM1?=
 =?utf-8?B?M3gzQVo2ajZTSGVxTUFqcy9lbUgyNStSSkFGZHl5QUJEVUJxZnpuUWtMVXpD?=
 =?utf-8?B?NS9RRTA4S0NPY2RKYmVjYWhKNHJNa21wZjd2Qm1GbkFnTXVnWlM4MTlQVWZm?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36461891-aa34-4dce-fc38-08dd4b03e55f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 01:23:46.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAaLjBo93wI8z3V3Y0kCbzxys1FdUCNjUn1xQdoqm/uxFrMjb3ecBNo/7ftXRiG0wh5BWbMA/82j2nv7w1YWjYFzpQeDQPpDlEzDPaZojHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
> registers for the endpoint's Root Port. The same needs to be done for
> each of the CXL Downstream Switch Ports and CXL Root Ports found between
> the endpoint and CXL Host Bridge.
> 
> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
> sub-topology between the endpoint and the CXL Host Bridge. This function
> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
> associated with this Port. The same check will be added in the future for
> upstream switch ports.
> 
> Move the RAS register map logic from cxl_dport_map_ras() into
> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
> function, cxl_dport_map_ras().

Not sure about the motivation here...

> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.

Ok, makes sense...

> cxl_dport_init_ras_reporting() must check for previously mapped registers
> before mapping. This is required because multiple Endpoints under a CXL
> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
> once.

Sounds broken. Every device upstream-port only has one downstream port.

A CXL switch config looks like this:

           │             
┌──────────┼────────────┐
│SWITCH   ┌┴─┐          │
│         │UP│          │
│         └─┬┘          │
│    ┌──────┼─────┐     │
│    │      │     │     │
│   ┌┴─┐  ┌─┴┐  ┌─┴┐    │
│   │DP│  │DP│  │DP│    │
│   └┬─┘  └─┬┘  └─┬┘    │
└────┼──────┼─────┼─────┘
    ┌┴─┐  ┌─┴┐  ┌─┴┐     
    │EP│  │EP│  │EP│     
    └──┘  └──┘  └──┘     

...so how can an endpoint ever find that its immediate parent downstream
port has already been mapped?

> Introduce a mutex for synchronizing accesses to the cached RAS mapping.

I suspect the motivation for the lock and "previously mapped" check was
due to noticing that the ras registers are not being unmapped, but
that's due to a devm bug below.

Even if it were the case that multiple resources need to share 1 devm
mapping, that would need to look something like the logic around
cxl_detach_ep(). In that arrangement, the first endpoint in the door
sets up the 'struct cxl_port' and its 'struct cxl_dport' instances, and
the last endpoint out the door tears it all down and turns off the
lights.

> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/pci.c | 42 ++++++++++++++++++++----------------------
>  drivers/cxl/cxl.h      |  6 ++----
>  drivers/cxl/mem.c      | 31 +++++++++++++++++++++++++++++--
>  3 files changed, 51 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..143c853a52c4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,8 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +static DEFINE_MUTEX(ras_init_mutex);
> +
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> @@ -749,18 +751,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  	}
>  }
>  
> -static void cxl_dport_map_ras(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -}
> -
>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  {
>  	void __iomem *aer_base = dport->regs.dport_aer;
> @@ -788,22 +778,30 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
>   */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {
> -	dport->reg_map.host = host;
> -	cxl_dport_map_ras(dport);
> -
> -	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> -
> -		if (!host_bridge->native_aer)
> -			return;
> +	struct device *dport_dev = dport->dport_dev;
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>  
> +	dport->reg_map.host = dport_dev;

This seems to be confused about how devm works. @host is passed in
because the cxl_memdev instance being probed in cxl_mem_probe() is doing
setup work on behalf of @dport_dev.

When the cxl_memdev goes through a ->remove() event, unbind from
cxl_mem, it tears down that mapping.

However, when using @dport_dev as the devm host, that mapping will not
be torn down until either the @dport_dev goes through a ->remove() event
or the device is unregistered altogether. There is no CXL subsystem
coordination with a driver for @dport_dev. The PCIe portdrv might have
an interest in it, but CXL can not depend on portdrv to map CXL
registers or keep the device bound while CXL has an interest those
registers. The devres_release_all() triggered by a
"device_del(@dport_dev)" is also uncoordinated with any CXL interest. In
general, it is a devm anti-pattern to depend on a device_del() event to
trigger devres_release_all().


> +	if (dport->rch && host_bridge->native_aer) {
>  		cxl_dport_map_rch_aer(dport);
>  		cxl_disable_rch_root_ints(dport);
>  	}
> +
> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
> +	mutex_lock(&ras_init_mutex);

I suspect this lock and check got added to workaround "Failed to request
region" messages coming out of devm_cxl_iomap_block() in testing? Per
above, that's not "more than 1 downstream EPi", that's "failure to clean
up the last mapping for the next cxl_mem_probe() event of the same
endpoint".

