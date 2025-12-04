Return-Path: <linux-pci+bounces-42657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F28CCA5517
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 21:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FE45303B805
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9E2FF16E;
	Thu,  4 Dec 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt/la+mc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FB2F7446;
	Thu,  4 Dec 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879333; cv=fail; b=sjvo+ZJEyesj7aburh/Bed4yzWe8629+KNrJjHwXmnyrOk4qu/NZptsLCQ0Ql6XhQ9tsrxVzU4V/FO138EdO2mdUf09GLliegm69d1oIqt4YkM+D5Ixp27iX88toi3dQ13dnd3sXIlJAqfK6eCkReXjvsugLdeS/BX2B1mweDDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879333; c=relaxed/simple;
	bh=Hl888flrbSi3cRMPqdK4Lg04f/EaFKdJ3LSsiC7e1Co=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HqS+cwS5aS4/+47hvthXpULU/j+7EZZm5lydrxxMJXJJ5KImKn/4QAFkSmRY0w1shjt+QnDwooTMw3s4NIwSNn6LLIaGaKwgz0IY8yc4RSP1Y1S+ZU4R1bfV+PelJLh5aOdInyC0IIk9LPt2nYr2TFUxEe8RE7edXAWzS62tCrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt/la+mc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764879331; x=1796415331;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Hl888flrbSi3cRMPqdK4Lg04f/EaFKdJ3LSsiC7e1Co=;
  b=kt/la+mc1T/rStFyDvzfYOZdIKcqyQbkmCrLzyBfI57/mTsA5xLzLBFD
   Die30TUNvQKX6q4lO+KbnEkbw4YUjZ36a9zPi/c7jKU36jx5Rd7qZdgwG
   Wv29AOK2czKs3BIB3OnsvKA0qCoFGqbAT1hoXpg8CiCZdx7JRf5N/e3VA
   2DauY6VE6rpsLdCdfBKYC6ug0VHusRpY92VwSF/Ihu17592EDrGXjEjfE
   pc5pYFMqcXanWSyOhUbKzdQufnRXnGicv6F/E8KA11pekLLZ8rYtNkdkU
   wac7yGJ0La9TD6CDiv8eHx+F1QidSuIoqLoYgJWZt30WPT+VlyDYwpzVi
   Q==;
X-CSE-ConnectionGUID: LiWMjv0wS9e1NN8RE74rGw==
X-CSE-MsgGUID: 3g5moblzQQOobEvJ80haPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77595482"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="77595482"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 12:15:30 -0800
X-CSE-ConnectionGUID: VQ0H7S1wRaGny7W7jYyfbw==
X-CSE-MsgGUID: PHzKUv9CQw+cnC0kP4HqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="195114370"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 12:15:30 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 12:15:29 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 12:15:29 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 12:15:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8+ZaXkrp75f1JRXZKOyUN1T5rHOIekv2/9yXVwKx7kfOl+5TkE5VK/FYH9tVWs1JkFAP+hRL2t1RNcryoTgruBJ5CCTtM/JStQz3IGRTJd8rqoopsLy4wniczTrKxHuBeL3mUGdB+W6FZu0YH814hBXzj0fm4UlfSflp9wWzVOQhkIS74VbBosrKODzCn274Zb4hYx3Ba/toSZQqZPUjosMrNR1Z80RfGduzVEpbHt9KSr/6V28z/LhcYrApUzezZrkhdMQ6bP5XXJVqAqxmB1aRAKqWmU0htVJbZ0KWEnyNzOadUtbX0YcR8Xj71H+SrNRkAnEFqQCEQ+3sSBM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgHQ9WlUmQvzU3VSJgjbPkH9iaPH0XzECrjHo2LlnZI=;
 b=oDND6o+L9YeI+P5hN+6slizYSylbTQ0td9WqPAk1pZTXNLf2FpIaOXf3kmrx8Nw+yKrEZdIcLT8UT8aS7GnkVaFAb8sLeqXFrrBKhvI0KQGeRXJ12aRQ4E42qv0iOSCCuyHajf4+biaTO6Ln5fjsIpbUNpHvYRJSuK30PZZ9FT4Ywa6xN2ZUJ1pIcKT6eZtdAZNFl3gPcqyETBx2kOAuAoyclC7umawdLT+9nX92reXbN42nQscfJHbDcyeVzcZPhPUrAWE0qjNcBMCl/pX/IUKAKruwautDNGUluITXCv+TxH60WCpJaC1ryAoBYOYtGf+1PJyy2ZoJ4SqSjC+c5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 20:15:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 20:15:21 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Dec 2025 12:15:18 -0800
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
Message-ID: <6931ebd626df6_1e021001d@dwillia2-mobl4.notmuch>
In-Reply-To: <2010f8dc-7cc6-4a42-a181-37e65fffd22f@intel.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-2-dan.j.williams@intel.com>
 <2010f8dc-7cc6-4a42-a181-37e65fffd22f@intel.com>
Subject: Re: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a02c90-6034-4518-58ef-08de3371d8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlB1ZlFGckRhajZXckdmQ0Y0L3J5TldGODFXYlpuRFRFZEtHT0VoQ1BtbWZH?=
 =?utf-8?B?Z1VMV1N1V2dUV0VqSlFFeXFLWUJ4Sy9NUVdwYUtzWmpFYXBnSER3dm9lTCs3?=
 =?utf-8?B?UzlFOElFWDNGWDhaUWZwaSt4aGNLaENUb0lQdlNUYkdIRGV3RTVScTRzaXZL?=
 =?utf-8?B?VkNmbmhBdXp2ZDZTUzBVeU1pbkxFbGtKWGplSjRuVFg0cW5EdVJlYUdRdlEx?=
 =?utf-8?B?QjhrUTRCODBZY3RyU3lnNlB1ZXhnUm1qWkJoVWxyRFpLR0J2bEhJYlJNak1E?=
 =?utf-8?B?UWN0elF2UlZHV010RVlhTzJTa3VJWXBMUFZQVGtuVncvSk1vcFg1QloxcGdQ?=
 =?utf-8?B?Y3dSUG1YRExtWi9kT1JsZkhWYVNRdFJRMXpjSDYrQjJySitaNTdNeDhvRzFD?=
 =?utf-8?B?aVdKelNTMEUxS1ZHZHkySHZ6Zy9ucE5sUXg4bUpaVTZSbUhIY09BVytVTk8x?=
 =?utf-8?B?UWFKQzdHc2lRdXdFYkRBOHVjVnFYWXFia2VHb3htWkRtMlc4eENwL1lCNzg4?=
 =?utf-8?B?alNyVUcrRmFVVlAwMCtmckpwdjVnem1tNEVJeDl2by9HMkNWcTBZbHZENUlr?=
 =?utf-8?B?QTZLLzJBak5pTmZ1ei9jWlJhYzVtbjF3YURDRWQ1bUF3L2t4WWZJQU5CbFEx?=
 =?utf-8?B?N1ZRM2JwTTc1T20yUEdJMi9WMU1WK290aSszZjIra2xaaE50YmVSNWh0b215?=
 =?utf-8?B?Rndpay96Lzd6QU5hVFMvWEdQS0x0NzNoTmdDT2J6MUpaRTIrWU9EK3Z6WDJC?=
 =?utf-8?B?TFhaeEhxRWl1RGw0M3pnTU5VVDdRTUpPdnNuc1VGVVNwN0R3QTI0cmtPQ0I5?=
 =?utf-8?B?ZDZzRElDekhIcEtDa01CeFc5TVQ4UGsxZTlXRTV2d2lMM2tpZkxHdDhrNGVN?=
 =?utf-8?B?Y3lRbUxOU3U1UDM4K3c3bWpuUkZBdmRRMloyVVZuRDFabmNnK2NlU3pOR0E1?=
 =?utf-8?B?YUhTZmxiQklDYWJhd1JmZDlOa00wd24wUFBZTzd0SWZWcnppT0Rhbkt3ZmdV?=
 =?utf-8?B?R2VFTnFhM2V3Y3dta0gyclNXczJ3RS9lY09NSFZCREdHRVpKdVNWWFEyaDBH?=
 =?utf-8?B?eVVvYUVWQkx2K1N6eUJlT29iWHhhcXlhbnAxODg2N0hSWG56V0JIa0pOTGpY?=
 =?utf-8?B?Y252a0dwR0luZFRYblBjSVBLRm5BaGVodEhJalh4WTh1L0lYbzg3R0hHc0xj?=
 =?utf-8?B?VnpBem1leEgySXF1NVpsUnNHMmRnbndJdFB3L2Q2L3oyWVF0Mlo3eHlTdXNO?=
 =?utf-8?B?WnFRS09LcGlmU2JOK2JjcnQ2b0RhVk1jWWxvdnlrL0VYWTBSck92VEQrV0E3?=
 =?utf-8?B?SFJHcHg2Nnpha3FteW9abFN5UGkvSUUrY3hoei9ubXA1SWg1T1gvSkdCM3hK?=
 =?utf-8?B?dTRSR3FmMDhEb1ZwanI2KzB6dGFiRWY1MnRWd1dOcnoxeDJ3Q285dmxCeGpw?=
 =?utf-8?B?M1liT3kxeTdSYWhYdXUzcjViNll6STdVK1pac3JvS3FWQVpkRWIyM2hyZ1NU?=
 =?utf-8?B?Qy9CZmFIMnlYd1Z5eG9YUGUrK0tXN1AzT2N0ZXI2T3JBdXVON0tmSkR6L2V0?=
 =?utf-8?B?Vkp0YzE3N1FHejBqQjhGVWVmek9HVUFiZTFKVjVEUHpKSkM4LzRmdmxuc3pY?=
 =?utf-8?B?RCtKMWFxbWtneDVsWE8yTGRhOHlhTnlwSDZZZGFkclB5Vkd0OVQ0V1p4OHd2?=
 =?utf-8?B?TnZiWTVNZVlGOTlkdzg2ZFcvdzI4UE51TGxLMEV2eGxYRGhwVVZuOGpqUUFr?=
 =?utf-8?B?b1hsY3hiSGJlNTdGR01wTW5kUFF6dTd4UG5PeVdraG5RVHhpQ3FXcHB1a1Nl?=
 =?utf-8?B?Y3ZWYm5sdCtmUnI2U3ZJb2ZudHBNT05XaE4xdzIzMkNvVzJIVC9FSU5haSty?=
 =?utf-8?B?aElaeGZyT2pGc2luUjhrMmdwWkdmbVZITWhyNjZJWlZNNXQ2dkQ3YjBLQmJZ?=
 =?utf-8?Q?UeVuEget33Q73eKlHvP6T8jJWVOB+h8v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVlZWEU2U0VjVFlMOEtjVGM1S2dkcFBNMlhXcjNzZG00cU5mY0pTNkVITGRk?=
 =?utf-8?B?YkRuZjJPMTNpRCtGVFpXRkJLMWZOUEJlaldtZTRuNUlXWW1rZDkyWWREUG0y?=
 =?utf-8?B?bXZ4b1hHaWZ2ekJwSXNHTVNzVDlKRTNKdEZZWDd5Q25YWk1lbUxYTlZLTnF2?=
 =?utf-8?B?aTYrTkZSRnhFVkp0RHY5eWtCQmlEMzFBVTBuMjBJcmw1VmtzaU42eUhscXBF?=
 =?utf-8?B?dkZrZGx1Z0ZIVnBoVkpFYjgrTHVEYkdJM3BsUDVGTjN5U0NmK0QzN3V0SXcr?=
 =?utf-8?B?UUROWUVSUlUwZExYUFkxQlg0QmVsZGR6S3Q1OTdYS3lFQzZ1bnIvSUR4dUdK?=
 =?utf-8?B?SFpQQUdOZTYrK2EwaGI3Y3NRbFcraEk4WTdjM2RIV2ZBMG5Dazd6WUszU2k4?=
 =?utf-8?B?bHladjZaTHZxVWZBVkdFeEZYaHNPWXFtOGVEcXA0VTBwNUdxelZod0lYQTZ5?=
 =?utf-8?B?bk9ScGJTSGJ6Rm5ObW1lTW8vVnpiSDJBOHlTbFBjVWVFNEQ4UEt4d1BVSmFG?=
 =?utf-8?B?ZDRvN1ZDOUtxRXlPUEs2QXVjRzRLd1ZPcVh5cXpSaHBaODFWN25nWG5iWDZ1?=
 =?utf-8?B?Vng0ZjhYazlnaTU3eHg2bTJybEFDWXF5ZC9HMjAyVFdCYTRjZkplNDVVbGxM?=
 =?utf-8?B?M3Yxa1ZFQzJ2WXpTSmQ1NFkvTXhpVnVWTEQvNEFISXl5dWdoMlJXN3dzOGhy?=
 =?utf-8?B?ZldvK2IrcHFMeEV2U2hXYlNzTXRVTElkYW5hL0FuVVBQSWZpSngreXNuLzM4?=
 =?utf-8?B?MVlhYzNXcUlYU1cxclBqbnhWR0tHekhCQU9NeTVCS1ZvUWI4bnMwbFUrckxT?=
 =?utf-8?B?cHlXcDl3V0NPK2VqR21YMDdyeDlrV3VXMkhCNjFRd3lRNVNqeFprQUxrV3dq?=
 =?utf-8?B?a1M2djdFMWo4MHovbnQxcUZsTjRnb2haZVpocDVobk13aWYyUnlkaDBUc0hw?=
 =?utf-8?B?QjJJMTByUVNvWit0aXBPaUxxdkhxSlBQSGp5OUFvRXJsT2RaV1RoVUg1MWQ2?=
 =?utf-8?B?TVF4Z1pONE9LdC9pd3FTRXNUMncyaWwvSHJFdGpxS0R3cHN2STJLSWdXN3lw?=
 =?utf-8?B?czAwQ3RPQzhJNkZwNEtiUmxSczByWmVySHpCZmovaHRTalJsVExXUVdFZWdp?=
 =?utf-8?B?bmhKa1puM2tPSCtJZWVmVDFKN2NIeEthcUQ0SC9TdVpxRzRCZGFiSzlLREVY?=
 =?utf-8?B?L0pkamNqd0hhd2hWbWlhTWs4aVNSTlhoelJ5amJPNVIrWGZhQ3lHTU5uSTdK?=
 =?utf-8?B?eGtiU05vaDZaRVBJdkdyM0JmZnMxZGROcjBkdlVybGN3VGRyK1Y2RytvWFl3?=
 =?utf-8?B?MUVJLzB5TzRuN25JZGp4NXhsOUdJZzlkUUtwaURKcTI5T09lS2dKWTlZTWlJ?=
 =?utf-8?B?VDI5YWR6VU5tRFczR1lrdkF0N3R3VzMzM1JEckxzQ28ydk5scGlWNXlYNExl?=
 =?utf-8?B?UGFLT1ZJMG5Ob08xMmhWam1Mcml4YmNoVk9JU2RBNG91T1VCSUlqZVRSaFA1?=
 =?utf-8?B?bkxjNDZRSHlwS3FCaWhKS2U3UlcxT0UvOGFockNJcnAvMEFmelZyYldweXNl?=
 =?utf-8?B?UG9qUnVnMUliV2c2QTJDT2RpR1NUL3pwZzQ1V293bzhRamVkdFdaK3J6U2dX?=
 =?utf-8?B?N21WdFNJR3lHTytuSW9rUnd4RVd2Q2YyakY3VnRwd2hLK1V4Zyt2cXRWckJT?=
 =?utf-8?B?RnlxcnN0YjVVNWNsT016b3FuelZReFVtZFIzNFdTbW0yK3psVUtBajlHTXda?=
 =?utf-8?B?Q2Y1MXRlT2MySnlaVkprQ0xueFlmbi9wanNTeHZQYXRJZ2JWOWJtZndGSC9K?=
 =?utf-8?B?MjVEL3Fndnk5VDBZWFJlR2x0Z2MyaWpRZzNQak0vTnd5dU5KSzdnQnFyaVlB?=
 =?utf-8?B?eE1KVU04ZWdKMHFYQ1dCUkxwUUV5bjhlbUk0TEJRK0NpMVkvM1MxSnVqalZU?=
 =?utf-8?B?MGQrTzVET0pTSUZ6YUNiMW9WY1lEK043ZnN6YkpxMFVXUktaa1V5cXpoYXhN?=
 =?utf-8?B?MExHdTFjYnRNOWFCK2VpYWEwSnJBcURTZmd5eFhSTlEzV1Jmb1Y3WjRRWVcr?=
 =?utf-8?B?YjlocFlpSU1wN01VdGowRUFGY1dRakJEQldNQTNCWlRma2d0ckFOVko3TUs3?=
 =?utf-8?B?ZENPeFI0U3dic3R2bGNqSEU2a2FHM3VBeHoyZWtaZ21xMjJlZi96MWdYSFFV?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a02c90-6034-4518-58ef-08de3371d8fa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 20:15:21.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJg95Wb2238PhQ7M9v860VHT6QVarI/LNBzm9//xW6iDCS44u+V/JddqGZb4sjNPb48N7crJSADTNERW0PcAF9z1iPVfbOyIX6UIo0i9S0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7563
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 12/3/25 7:21 PM, Dan Williams wrote:
> > A device release method is only for undoing allocations on the path to
> > preparing the device for device_add(). In contrast, devm allocations are
> > post device_add(), are acquired during / after ->probe() and are released
> > synchronous with ->remove().
> > 
> > So, a "devm" helper in a "release" method is a clear anti-pattern.
> > 
> > Move this devm release action where it belongs, an action created at edac
> > object creation time. Otherwise, this leaks resources until
> > cxl_memdev_release() time which may be long after these xarray and error
> > record caches have gone idle.
> > 
> > Note, this also fixes up the type of @cxlmd->err_rec_array which needlessly
> > dropped type-safety.
> > 
> > Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Shiju Jose <shiju.jose@huawei.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> This can go into fixes right? Does not look like a dependency for the rest of the series.

It could go into fixes, but until someone reports a practical problem
the urgency is low. The impacts of the leak are minor especially on
typical builds where CONFIG_DEBUG_KOBJECT_RELEASE is disabled. The main
motivation to push it along is to interdict any further attempts to make
the "release" vs "devm" mistake.

