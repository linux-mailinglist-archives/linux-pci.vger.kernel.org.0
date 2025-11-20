Return-Path: <linux-pci+bounces-41706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F788C71961
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 01:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0285C4E0F37
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 00:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30396199FB0;
	Thu, 20 Nov 2025 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0e6C6f9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9F156CA;
	Thu, 20 Nov 2025 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599472; cv=fail; b=ppju5EVqMGnrpbtvRK7NQeQ72O2c0O71YyH4WbnD9RjCit2heyZwulAUhnl2uaKYXPoXBVwDuvCD+JSi9cdq7JJcGzHbKx9x5TKWyaMyEq+bL2Wj6dhX4nsiJsCIFavdz6+0DyyFdInmkydE/PM+vmDHhI9o9hLIJvooKEFSBV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599472; c=relaxed/simple;
	bh=qIBIdnlJXLhBXsTyLscUdvPy3L5OEw+A+L+tPeHFM8Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=bpF3vhkvVTjhvFFUx8ERBPEGRkqlmojqxmB0lEGqNOf0SmFU8SSj78EYylRVd3hXt3ixNki3v65kZN7swBhn82uwuDr9Tl6oEzQWySmU73M+kM8RBErV8xFEwCjHc+1WXcABPb+LOYheiDXqnSLrKBvRRXcbsM5qHr3Sfxuq0J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0e6C6f9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763599470; x=1795135470;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=qIBIdnlJXLhBXsTyLscUdvPy3L5OEw+A+L+tPeHFM8Y=;
  b=j0e6C6f963D4OvyZN4Yx4UHPTP74bt3kqPk6CWB6A2DFqwzhwEleKoIp
   3VcLpotbNnttT2Y0fAG1UvxSRrZ2XZ4p7e/vmkadMv2VkogU0CH5ke/xx
   szr4cJqKD2j+SJxH7i2zGrFodqecyURWBBFdM5cb5dRPB70vsHpK1h33k
   PP3enBIs0Txzz6FHEQoLGQBw4GDzVvlnxPmqzaRKUWRYucvpwhmrTslQq
   FsFLFlESZphjn+6NnfVgrHVPFr0/W0HMteaYeAHual0WXzbfoC7sYrHG7
   JVC/7o3vEQw4eSVGp4lfV9Wrg65xWlCa/Ed/iR8sQzftV9ykraPGX+mPI
   g==;
X-CSE-ConnectionGUID: J0hqpqj/Qkm8piPKgTw5NQ==
X-CSE-MsgGUID: 9SxrruIRS8iH7X1Nk16bpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="53230416"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="53230416"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:44:30 -0800
X-CSE-ConnectionGUID: Ev6f5I9OQYuJNQjXIVDYoQ==
X-CSE-MsgGUID: +2WSU9OoS8C8GmVXWc6ymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="192010158"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:44:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 16:44:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 16:44:28 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 16:44:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBqKAGqo0g08/6ngUHVW+pIStJ5YyZ/MJ6jMMz3AoufcU9DVPhCC1+uhfBRt88iF88uBiN6wDB3W0Nhoay+dqhpBVPUr8WOFOn3k5T01dQcVmGnYkvgSXvlx99toqjU3ypchKr/vXBl07iLSb6O81fb1BIBMrhPz9q0Vfg3QA++yw4BT2ZauSmFlBQxR2LxGiIYLE4qb3klbgNaQctfRnnqda3pzqhha8DCk07cCRVZpBhsCi3I5UqCEh/abr/4ytgVqrnak0lYynQx5FxqCl0TkwuPgNN3CWNT0XoV1zk7AoYBp4vvr91BE1YQiP4hhfHtc6UDfdsVTx17ddh0cpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFnuNwDxb10rRTf0btNQ3VqXDbaG7OkvJFCpTqkzfFE=;
 b=YKFVzlzpNV3g1rq12oVW1HJZoxcHCXjyje6JEgYLER/6jh8R8GQP3HPt7FxQYfeqGNRwfAGT9xFtWlfUW3JJnZLT1vZhb4Nw403C0kFhI1pNaadqUqs1qslCistaQfbsAoTCEQqDbVmD1GjeSf4hIHG4ORXMGqo3dzkcKAjxxyoAoGorG1BPtyhX9UMXmNSWSCO4K8+dX538O1AD7bN8k9Zh3ALAn63mhN0sZwVINZ8APmY7bV5c/WuQbHVyIew7FJRRIdwjx2gglFZwJBhfjXLA4Gt2u+z8JFgl3eIR3/VSAj98arKZ4Y/8zswPxVt76cZLKQKS8BpLqkg6WczKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 00:44:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 00:44:21 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 16:44:19 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <691e646357da5_1a37510026@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-17-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-17-terry.bowman@amd.com>
Subject: Re: [RESEND v13 16/25] CXL/AER: Introduce pcie/aer_cxl_vh.c in AER
 driver for forwarding CXL errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6b7692-855e-4d4a-7725-08de27cdf18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MllsUlJMM1N0Z1dzTFZ4R3R1cmpQUWRNS2VuMVZuVmQwdXBONU9nNHM2ZXpn?=
 =?utf-8?B?aTVTdjU5VnV5cE5nbVRYWU1DRGhlRnU4R28xK01ZcitYMFkzbnNLYVhGVG1i?=
 =?utf-8?B?ZUIwM3loUEk4YnQvY3N2YVQ0YzFwL3RrbVJiNXpBbTE5ZUlUblk1d1hKMjM4?=
 =?utf-8?B?bml0UmVjdE96R2I1V01NQUlhczNwMy9TTVNoVmdJYk1oTmtGUUg0WVYyQ2R4?=
 =?utf-8?B?TTFWcUNZdWZwejdaMExTZ2FQZDBSMS9DM3BBM3EyMm5uRFdaZ01kOUF5VUtl?=
 =?utf-8?B?Ky9BZ1lYUHBGYVFtd0JiUXNLUUNCbWJtVHlSdXo2L3dGaTZvNUs5cHJuVHdt?=
 =?utf-8?B?Z3Z5UVBjcVh3VEJZQUd1cWNPMGZuVVRNZFJxbHUvZXphZ2tYOEN0ck1INkVE?=
 =?utf-8?B?Zjh5VzFRejU0QUJ0RFNha0ZySjBQa1dWVXZiT1hYL0EwTzVaaWlmUUVlODly?=
 =?utf-8?B?cXdmMGFHYUlKcnNQWlZqR0dYRGhpRW0xbTRkVGd1eGFYOUs5NGFYbnZIM09J?=
 =?utf-8?B?aXlnamJISktod2Y4aTRTSklZajMxdkh4UXk3dERMc2ZsYWdJQ0Q2OThkUWpa?=
 =?utf-8?B?cU9MY2JZYmFzczdXTXFWK3JRd3hxc2t4S1dzT3kyNjNNazNDY2JOaERHK3Bx?=
 =?utf-8?B?V1E1WVRYeDV1NUZjVVdFeGpma0tpeTN2SU1jdXMwcldwaGF6N3Q1SDNYT3J3?=
 =?utf-8?B?aEFKQWFTTDlITWpDVlVZOFpINnRzbEZ1dkswMnlnb2wwZElORkN5MTg4THRz?=
 =?utf-8?B?Q2dVZ1h5TEMyZkllMzNQdjFjeGZiMW1PazlUZDFtTisxYkROM3duY1RBWWFw?=
 =?utf-8?B?S2dZMVNTNkRVK1o1emRJTUxNUkZ3a0NkcGY3Sm9VMFFaem5QS1ByaE1RT1NP?=
 =?utf-8?B?V3VRUHZCODF1WEtXdU5ObVBYN1RpeUZ6bi9aMnF5UWFsTWN0ampDcGtLQm5K?=
 =?utf-8?B?RmVkOTBJSXhwY0oxd3FzNVRydjM0NitxdGhCaHZxcG1peit2VHVyVGNadkxz?=
 =?utf-8?B?Z0Y1ZjdzZnJlcGRqVGU4eVp3dkVpOFJhOUY0d2ZXOEh6NFE5ZWFmUVg5SDZC?=
 =?utf-8?B?Ui80c0Vrb1ppYkFMeWJTZlJwSG1pRFpwWDZzTGRDemRaNFZRSTFiQzBROXF2?=
 =?utf-8?B?YjJ6NVVHOEc1VDJpcDd2KzgrUzlQTjFxREVrSG5uMmVRcDcvK2Z0UXQxb01N?=
 =?utf-8?B?Q0x6ektxanFud2dIeFhHNkx0WjNMU0EyVzhMamU0YWVhT3dGY2JYaTVKVVZv?=
 =?utf-8?B?NG82ME5PRUtxNGhxZTJJcHdZdWdtclg2OVREVkVQZjBFZzJZeFlsZHRtZ1Va?=
 =?utf-8?B?SDhSQXNqZ2Z4Vmc2VWJjR0hKQUJSRmJJaWZuZ3k2SnRTK2phN0RjUmo3VWIv?=
 =?utf-8?B?Z2lvbXd6cndzOGN2cU41bDJlYzlwNHB3Z3ZVZ3VteFN5cTlCMVNLazRRd08r?=
 =?utf-8?B?ZXlGVkdOUUltNE1RUG51YWdCMFZwTS9rODFGRE40T0xzMkVya0xIczRPY3pH?=
 =?utf-8?B?L0pHWlQzNHdKdjJIbEtqOE5vQVNJUzRldFFUVHJUZWFYaENrRVMyeHh3akpM?=
 =?utf-8?B?NWI3N29RU0lNNkdYQTVKZzJHZEtVTlpGL1V5K0FRd3c2KzgycVVFa3RpekE0?=
 =?utf-8?B?ZHVsYktCMTlSSE8yYVNxanFjL0pVdHlMaTBvYjZJSjh0bGk3LzE5SndaZXNX?=
 =?utf-8?B?N1FRdHZYaWVIMnVTS1kxSU9WbEpDKzMwRDhWaittSHVrbXBBSi96b0U0Y2hE?=
 =?utf-8?B?bk9HakVzTTFuZzBuVWhra3N2d0Y0ZXVHckI0OUxJS2lseWpBdmdJYUM3bnll?=
 =?utf-8?B?WVczaUFUT2N4WFJnOFY1ZkEwZlllenlLRGdsdjZEZzIzM2oyT2JaazQrS1g0?=
 =?utf-8?B?VVphSWNaSzJhVXRvdlREdk5qTGI5YmVBMStodkxoNWczcWk1QXZlSDkrbTZs?=
 =?utf-8?B?YSttR1J1M2RxMi9sZ0xzb25kUDNvUHRZb1IySTV3bE9PMzRDcjA5ZExEU0F4?=
 =?utf-8?B?c2Fzc3dSMWlTTDQraDc4RjVwT0U4YjJHNDRsMGtlMVFRcUQ5eVNGWmRRNERZ?=
 =?utf-8?Q?z82QfD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVo5cENQTjBPNVdXZDlFTnRyNnBheHF2OHVRZFY5RzZLT2M4bEIvUitwYSsr?=
 =?utf-8?B?S2s3UEJUTlRBMm1iTVI2L2tpZTg1SnhjWXNuL2Q5ZzhvWjdxWU84TkJtaXdU?=
 =?utf-8?B?VTErTHMvY1FMYW9KS1R0OUs0L2kzbm9TVWRGMDNPZ01iN0FOdGI3Tzg1YzBB?=
 =?utf-8?B?VkpkZkUwVjdrUEI2eEc0aTNiOHdnam5pT3hSUFdkUitqTVZuM0N6Q09kRkJS?=
 =?utf-8?B?dVRjZVVzUmlLUDE0MUFZRGdkeHFaM1RZckZJZXZKYkpiN0xlZ3crV2NvR2U0?=
 =?utf-8?B?cFB6Zm01ME11N2hVaERVMEJ1WlBpSjNNUWxnUC9sY01RZUlyVG5Hd0Z5bWI5?=
 =?utf-8?B?VmxieW1ScDF0d2FoRjBOVXJ2eXlnZnFTTTlhdENNOVNTSHBrbnVsV0FYdVdD?=
 =?utf-8?B?VGlVQk5YcHpXUUFSN1lwVGNBdFZjVTRvSEMwT2haSlZRM1U2ZS9qY3NKRkUx?=
 =?utf-8?B?K3lCYlVnS2haSzBya1IzTG9JQlZqcmMrZ0RqMTR3aHNRK0NvbTNJazJHRk0x?=
 =?utf-8?B?K3lGb0ZLK0R4N2RBbVZYN1JnelhpVnJrUjFoMWNYNkhSRXlHVGErR05wL2F3?=
 =?utf-8?B?cm5XQTRMaU44bER3Z2Eva1hOdkM3REp5ejdvcHNzZHV5cW9Pckp4dEdYWlhw?=
 =?utf-8?B?WW04cmlIWVpENjlVS0JMcE85NURrRGFlZU5JREhlNWFob3dISncwSHE4WXky?=
 =?utf-8?B?TGN3RzJ2U2h6MmVJY3JQd0NrY29COWx5UEwyL1hPTm5RVC9UYlNsODROY1hk?=
 =?utf-8?B?dS80Yld2UkpBNysxODNrUkU4bTQrTUtiMUlvRWhzWTIxZEV5Z2tlaittM0NS?=
 =?utf-8?B?d3d1VEl1TzF6ZGhEMzN5b0lsY2xXZFJrNEYyb20zUm1UcTdJc2dmTlRQUEtl?=
 =?utf-8?B?cHc0T1QxaEN5NndsNGJhRzFWbTJZeTZxMUdsN083dHhIQzRvWm5JNlBDMUdx?=
 =?utf-8?B?Tmt2TGU3WEpybmRxWUZob25NODk5YlFtVHhzU3VTMVEzanVjYXdoR0lLSU1u?=
 =?utf-8?B?bytDSUluTlVvWk90bjRJUmRKb0I1VmpCMU5panJEaWJoRy9yVy9CR3Urd1Vh?=
 =?utf-8?B?eERMcmhVRlBZOTRWQVYwb0ZuWWhuV2YwMTVzemhjZENYemlHUlhUTUNvd000?=
 =?utf-8?B?UmdSd2Z0ckQ2TE1LTzZCd0R2NGZCemhZZ05OL0hGYkdFa2V1Z0gxMEFZcGRm?=
 =?utf-8?B?aW5LYVBDRkdyd2NEcjNwOUhHd3I2WjVZbUMyZ1hzcDNMM2ZJTmUvRFBJNkJm?=
 =?utf-8?B?NFlZYTlnclJ0T0NqWG1JbTdqL1p2bXk0NWdQT3VqbVBaTE5SK2U5SXlJQ0dL?=
 =?utf-8?B?OXhpbklNSkNkZVA2dk0rV0tLeDkrdnFrTjc5WEd2Wm9pTXBwclk1QmlicU9O?=
 =?utf-8?B?bFM0N3NoTjR1Z1BNM0VSNFlIeXIxY2pId0lMWHFLbVBwcEhEa2dNWTZ5NHdw?=
 =?utf-8?B?N2c5eDcyV2dSNmg1UWFGRGx4NStueG1RNXZWV2QvMmJvWitUV3h5b25Ra2dt?=
 =?utf-8?B?MDRRNFQ2YnNyN3VNYkRnSGNOeGZCWnBWVkRwVCtMcktWNVk1dGpYOURjWEw1?=
 =?utf-8?B?cGpTdWdBK21LRTM5Kyt1Y2J0U1dsb1BzcktEdThvUk55MDBQcWJSc0M2c011?=
 =?utf-8?B?VWxoWG5TUkVoaktKSWh6dngraVEzQXZ3Si9uRGRVQkUzMUFOUnBsdG1sRVJM?=
 =?utf-8?B?Y2FoaFJWK2o2R24vTEJuZFN4OGZEOWxQUkdqNjBVM3M1Q2I1azBNdm1NNm5a?=
 =?utf-8?B?cTAvRk4vSC9ESzVMdjZpYkZuMndDN3IzMURxanU1N2E5Tm5kRDJsdEhSRy9C?=
 =?utf-8?B?RytWZHhRdld1a01raERpUzlCT210THMrZWN4UUVjeEtOZ1hDT3VHaS9OK0J1?=
 =?utf-8?B?SENaOUltMmY0QTdudGNHZVA2WWl6d0FxS2RjYThLM09YWnpXSHkvclM2U0Nq?=
 =?utf-8?B?WkdMUm9oMkl3cjZOMno1K1F2TTJtWGE4dEtHY3RkSExycGswQjJyU2t0NjNn?=
 =?utf-8?B?dTBpSVJGU3hEQ0Q2RWtXTk0yT054aW9NNUVDam14SHJyWnJqMVk5SmRTMkZh?=
 =?utf-8?B?cjZjV1A1bWduNU5POUhFZEJ4YnlKSFpwOUFoTXF3M2p0ZlFvdDRGTUh4UlZS?=
 =?utf-8?B?amdheitiTWI3VEJjUno5YWNub3R1SzBOUzNZd2MyalVHSUpRaGpJZjR3Qlg4?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6b7692-855e-4d4a-7725-08de27cdf18b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 00:44:20.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/JfzMmyaPf5m2ieUclfQtJhjOVToEYW7QR/UyjUuRnAap387gsIcgveTOPG5RlpV41hWnKqMBJ/2/UfULOOHDSYwARyBidnXVFoIIEb/H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
> soon. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used as an
> indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology will refer to CXL VH and not
> CXL RCH errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol errors
> named pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> Synchronize accesses using the RW semaphore.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
> This will contain a reference to the erring PCI device and the error
> severity. This will be used when the work is dequeued by the cxl_core driver.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Some small things to fixup.

> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 000000000000..5dbc81341dc4
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <linux/pci.h>
> +#include <linux/bitfield.h>
> +#include <linux/kfifo.h>
> +#include "../pci.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	struct rw_semaphore rw_sema;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};
> +
> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
> +	.rw_sema = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rw_sema)
> +};
> +
> +bool cxl_error_is_native(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +
> +	return (pcie_ports_native || host->native_aer);

This function always confuses me because there is zero "cxl" inside this
function. Something to comment on later so I am not scratching my head
the next time this function is touched.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");

Why is this exported? All of the consumers are local to
drivers/pci/pcie/built-in.a.

> +
> +bool is_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");

Ditto on the export, and I do not see it getting used anywhere later in
the series.

Also, this is so tiny that if anything else wanted to use it just make
it a static inline.

> +
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return is_internal_error(info);
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_error, "CXL");

No consumers for this exported symbol.

> +
> +void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
> +		.severity = info->severity,
> +		.pdev = pdev
> +	};
> +
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);

This guard can be downgraded to rwsem_read. This only needs to make sure
that the kifo remain registered for the duration of the function.

> +
> +	if (!cxl_proto_err_kfifo.work) {
> +		dev_warn_once(&pdev->dev, "CXL driver is unregistered. Unable to forward error.");

I would combine this with the following ratelimited message because they
are effectively the same thing. "Hey admin, I see some errors but the
driver to handle them is gone, or out to lunch." The reason to combine
them is that you probably want this message to catch dropped errors
without failure, and this dev_warn_once() starts failing after the first
invocation.

> +		return;
> +	}
> +
> +	if (!kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_proto_err_kfifo.work);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_forward_error, "CXL");

No consumer for this export.

> +
> +void cxl_register_proto_err_work(struct work_struct *work)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +	cxl_proto_err_kfifo.work = work;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");

Oh hey, the rest of these exports make sense.

...but I do think you can go back and remove

 bool is_internal_error(struct aer_err_info *info);
 bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
 void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);

...from pci.h, and move them to an aer internal header like
drivers/pci/pcie/portdrv.h.

