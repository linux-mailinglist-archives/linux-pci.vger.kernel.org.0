Return-Path: <linux-pci+bounces-35793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F958B50CED
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 06:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F44447FD6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F2277CB1;
	Wed, 10 Sep 2025 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN6nEW11"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4B25A32E
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479846; cv=fail; b=TE2VmoVYAVs8/v5+jcw0vhsKgJVLq+vZAU5iJ8gOmlaA1sfaLGf7M2PDImS75sQwWVquiHezeyAmx64NFhPqmdJAQPD/l1T7yxSyj5UNbEjAAC3LTW99rsIFinPbUNwyTDr3c3LUG84IUQpFckUtQcJG4PX6ADHaALBeC5tI6xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479846; c=relaxed/simple;
	bh=yRon0dUwRhXksp8mg9eUoC5OwuMxAs28kM8aWOnixa0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=UxU1UV8iQbzyCJgH9aJhknJiaSIwbDGNixv47YMNXKYud7p0QBhPK62fX6F8FfUJ7M5gwR+nsj4hCeS0xi/Nom0FlN65/xn9d/iGrp8IHZ90uuv9Gv3dVPpCP0vqxjWjcbxhhL6gZPggQ3MKvqGYT7KWFZeGV8W7v1jyZkDtuuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN6nEW11; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757479846; x=1789015846;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=yRon0dUwRhXksp8mg9eUoC5OwuMxAs28kM8aWOnixa0=;
  b=cN6nEW11sPoe4KQhbA+cZcjtvDjW+fxhhPj5JALKvni7WDbp/xeEnGv3
   0urzKhYrHJ+eZhBSv0DjqHCm5OTi0gsalScWDb/BdbHv1m1rJNo5oa2k2
   HHErVetyHOv2/vf0zFieHCbqF+VKybdXDTN3MTlvxY8abYrRQDM3unMlL
   T7ILMrF+rbvwal6LjC8S4edJOQgkhpNZgaf2tfEwvv0eUdb+SRChpBKTF
   TIZOq8EXe9NUhOtZC/5G/ne/KVKVYXn6zDEcUKVv6Ir4ql/pxVa3vHOJu
   Wo1loydk70Zb4SoHB04EpCIvXiictv04CSm3o+pDgSx02nVHWEsVw/ocp
   Q==;
X-CSE-ConnectionGUID: bOGYHZG4QkuwwqPAt3bZHA==
X-CSE-MsgGUID: Wz6at66oRn+JrFag9umB5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70469685"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="70469685"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 21:50:45 -0700
X-CSE-ConnectionGUID: MPSl1LcMRlCEYnW8EREVaA==
X-CSE-MsgGUID: p0EW3OaPTpSnQ5ZJvtLjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="172874904"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 21:50:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 21:50:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 21:50:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.45)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 21:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hu0p5J4HM+GP156eoEspHNYylU7NalAzz5pYbPEuAYTOFJYozUNzxQFMuxGk3AU9yUdg4MmmjYzPWCGk764cXK7NwsMm7W34AyWX9yxUxjQc1hiknRuBfO1jcyxyLdl9WqCHTr89qm5OQlidOxGw0ooXmUD0egkdl8kx0i8aL8DALkFX7veLCyTUJCQVA7zuQAX4T8ekj8pJ2kmXL/YzleQhmBYaqcDxXD90yKwfN3EBpeGgzo29seW7hGyzUGTSD6AO8WcPvW+4tSuTwmgssG5q2a+A1/7paGOjDUxQd7gsCasHVCJaf+bmAowtkyq647TTJj8zXz3fTmY6ZcNBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeAi5RCKzPnttyjLda6qZWbqIdWm2ygdvdK2e+Xm/xo=;
 b=NAvqkmOTqZYv2X79xlNAqi7dekRoOdzNanFzZFXW66CDoG0dTKpECLhPhPKZZvkdfdUyxrU7l+RAfUYFluvLeyvrae1pkyiceV0tFcbFyjq24ZrFzJ9a4RrtNHoMZb7KAVVM7d4Qv8f2YiSqrKmtIJXqu40iopNm71sF3TZtoecCaJhs+9U7RUM6WmtuYLVRXUXbTLt31WkJYwQR5CuSIDyWjPIQsPh0jSuH5mRWomik96bkmWr2fJ8C/e/xoE1ee9UegPMBox4tn2awvLJpHrOwLdZ1jBIU3Mp+C0fucXEIL9hW4ZG10VPh2v68oh2ZrfLBteNj6f8O55/OsbzaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 04:50:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 04:50:42 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 9 Sep 2025 21:50:47 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <68c103a7db9fb_75e31003e@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5a7byg3ne9.fsf@kernel.org>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
 <yq5a7byg3ne9.fsf@kernel.org>
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: ae12c36d-e9a8-4d43-d95c-08ddf02598a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlZyOEZlT0xPM2ZUSjV1WDlzV1FIU1V0amd0cUc0blJJQkJJN1FQaThkeGlz?=
 =?utf-8?B?eUhIRkw4YWIwK0FoT3VUTTMyUFM3L001eGlqdUpIY1lMRks1dWRpUVM1RHow?=
 =?utf-8?B?Uy9IcHhWeFpCU1VFSlhTNUdHTTcyMXlCZG1GZmZDRlhtMXpkdzdnZXlKa2NM?=
 =?utf-8?B?MVZyaVkwbVk2YXRCZzZVUlBjK052TVpoVFo4WkNSekdEdEQrRDAyOFA2ZEFh?=
 =?utf-8?B?NG5Oa0FYZHBmMTB3MEt0Y0RaelYxMkZweHdtWlVMaUNpcklFc3EvekdNSzRL?=
 =?utf-8?B?V1ZJY0dIR3BTQ2VTL1RjZE10NFh3VUV1b0lkWUlEbkYzd0xXaTR2Q0NaNEU5?=
 =?utf-8?B?dXB1aFk3ZTNZWkJ4OEIxNWFTaXdhNWQySERBVUl2a0ZzTDdkdnZOY0o5TG13?=
 =?utf-8?B?MFRRVDNQVXY1L0VwNHJlTjIxWHJUQTRxNll3elZZa3YrdkVvenR0U0RxcktU?=
 =?utf-8?B?SS9tT2NKWkM0UEdKRE5MZEVqYzkvV2Y3Q01qUy9YYndvQjQ0TzlLckwrL0Q4?=
 =?utf-8?B?b3huenhmRk53ZXpSTEhJdXJ4Rnk2T2F4WEwwVDNTQnJMV005bG9UQ3RNWGdC?=
 =?utf-8?B?ZDdqU3VESGliTTkzWThqY09QaWNpR0gzSDZ0RDAxdGluV29PVHZHVlpiL0VZ?=
 =?utf-8?B?VjdUQU1jNnNEVU9rRWJyM1c2MDY4N0FUMHlLVXFuWGNrbWZpYkNQQVNPaFZR?=
 =?utf-8?B?UGdseURwMTl2NDg0UHlVUEcxK3BGT0NFTTVOSnEvYkpPYXN4NU8ydWduSER1?=
 =?utf-8?B?TEw3NVhZeVhKQVV3Vmk0V0N6dVVVZDYzUnZHVW10NXhRR2l1NG1TU1lrSW0w?=
 =?utf-8?B?dURXWEcvNEpMS0xRemhocGg1RDhBU3BlUUpPWUk1YUlPUFMzR1l1ODlacVVn?=
 =?utf-8?B?MEdzMlIwTjJFQ25iQ0NVZnNUR1IxQ2NyQ2pHcUNEcVJRc0ZQelBHdFdDYmYr?=
 =?utf-8?B?WXpxLzBHdlFjV0ZkUkI4RFBtYkVtby9TL1QyeWdCV1JUVUFINFdCcmlnQTRs?=
 =?utf-8?B?c1NMdWxRenZPSnRsQVhIb0V0TThPdTZyZEJjcDB2bElKdzkvNFdaVTJtQmJR?=
 =?utf-8?B?UDlnQUxhRFR6QWtqcnZSSWdveitDUnV2K3pEbmRWUmpreUJFY0tuYVJGQmhx?=
 =?utf-8?B?YVlPRU43TEJ2cm9GaGY5N25qQUtOVDFXckVMYThvc2llMldPWTlwYldpTy9z?=
 =?utf-8?B?V1Y4L29VRTdhb1lXS3BpM2E4dDdBSTAyejhBUERQenJXejBVQlB3ZWlyVklI?=
 =?utf-8?B?eEpoUCtYcXl2ckdzelRmR0ptZjNKUkh3L2Z1OXNGQWNKV2lNeFk1WEd3MnR1?=
 =?utf-8?B?OWJSN0tuekpMTFJVc1dYb0VmVnB3N3hKR2JWdWhoLzZ1VndhTlRielYyNk04?=
 =?utf-8?B?RWRrRE9CbUNSVDQxZnlZQnZ1Nk9CM1A2SHA3ZE05dVY3T2JaTWNzZXFXYVls?=
 =?utf-8?B?VlJzcDA2aFU1VldPeFIzdXRsRFlDZTFhNmVoazRVb0hJdXNzL1BtcFhuaVVo?=
 =?utf-8?B?S3orYlpwajBITmkvdzdBaFhFVzl5cFRBUHRzOVJwSHNJZnhZVkY4UjM2K2Nr?=
 =?utf-8?B?dkVkOGE5cVF4dHlKWnVoYmRrcG9rRnVLYlQ5ak00ekhmejgzV21WREVyUzB0?=
 =?utf-8?B?WThVbGRzMUZjaUlUL3NPQ2l1blE0N1Z2OXk4eldlMWpJL0J5d2FLeHcwSWRF?=
 =?utf-8?B?cHNlYWZvOVAvdjVsTi9UcHF0L21hTGJJWUI2KzYyR1FtOElpa3pJZzg4Unpi?=
 =?utf-8?B?Ky9tSk9JY3RsQTh3MFZOc2oydU05eUhobk9OT1BKNVV3NGFwOFBzUTZLWnQ0?=
 =?utf-8?B?VWFmTjUwdGFYS3BFN3ZVNlhDTmQvdXNSV1NORENNejFMT1NLMkZNZjlCZEU5?=
 =?utf-8?B?a3NyZDZ5dU9wQ0ZtNmY5dHhXdVQyenEwQU1ROXVERkxLc09sY3dOVVlJV1Vr?=
 =?utf-8?Q?hkNDyxFQNWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG8wQjBIQW16bUpEU1JxMWpzMFpYUWlic2tobk9ZWjV4bTRjL05ObXVsRWZi?=
 =?utf-8?B?NFRhbHFjK2VQN3I5QkQ5cGIyVFJKZkdXUTFIOEkyZS9abWh6SERYcXo5eUdZ?=
 =?utf-8?B?Smk0RnZmZnBNb3FmdU9LSjRGTm1WY1JsamtidExzbkZlL0FTV3cxZ0hGQ0t3?=
 =?utf-8?B?MHNMcTFmajVnY1puT0twRGtZUE1FTDg0aHJYNlFCWEhuUmEwNUhFMmQyS0xS?=
 =?utf-8?B?UXNGME5VU2RnTVFFVFBNS3RDMlkxdkt5TVVteFRJcVR5eDdub0xCMHVKS0FX?=
 =?utf-8?B?UThEM1hFOGNOWmNpa0xBeCtNMUQ3S2RyNW5UcXJ5Q3ZlUUVEekErNGtNREdJ?=
 =?utf-8?B?OFdvME1rVzBlOSszaGdCY3Y4SGJsM2luTzRJUndrTXlORytqU3dDRFZFcllu?=
 =?utf-8?B?U2NaQTFXSkMxcDM2bW9FdnU1dGRXT0lEaVVrNE44MXJzVlZNU2dkNTNNeTNn?=
 =?utf-8?B?eG9INnR1eHRqcmFpeVhxUlVveTNReHFkWmRsQWo4c3pnczJ6OWVVcWNieEhB?=
 =?utf-8?B?SzB5Z3VMVnlqMEh5QkRnNitaT2wrcC96VDJNZ1BnVlhGMWNPQ21PazZaL2ZX?=
 =?utf-8?B?cWFpRG1vaks4YUlTOXRPRzJuMm9rSTFuNlFzNmRGUDBZSnB6UC8vNlUzTzVR?=
 =?utf-8?B?K3hVblB1ZjBPaTNmTDNmTEM2bWVJMjNFT0tFa2E5SWdLOXQ4VjRnbDJKQXdy?=
 =?utf-8?B?M0NGRnZTT1NVekhLVmhIWllseGlaMWZvTDl1ZlZsZVRhRVI3SUoyOHBvNDU5?=
 =?utf-8?B?YWE3UDJmelpaRjA2aU1CaEZ6M0dpcnUrbVNoWUZrKzlyeS9yN1czZW1nQzBX?=
 =?utf-8?B?RVRZTVNZeUtJOFM1UjNuOFllQjdKYzVXYkt5UTdZdXB3R3Z2OGxLeFJUTHpB?=
 =?utf-8?B?UkN1eWlGODF1WHZLQkxQKzVYeXQvQUVUaktHYm11b0Y0NlFyWkV2QmlIbzVM?=
 =?utf-8?B?UVYwQTJjMVdCakJWSDQxc0JUdTZYR05FREFTcHFvL2hxZHhMOERWQThpTGwv?=
 =?utf-8?B?VXVadmNSM3p1aUpQT3VIUHdPcy9lV2NRM3gwU05PYW1sVmg1Nmg3c2FVeXZp?=
 =?utf-8?B?Q1BGSGliMkNlNy9XdFVxemZ1eGg0UGluWC9FdStscGlmUUszTHJVVnV5Z01v?=
 =?utf-8?B?alcvZWhhdkFsV212ZitnSUEyL1RqYnhkaUlkZnFmUXlnYXBWWDAyR3Vtd2tC?=
 =?utf-8?B?Rmg3TjRpRVJpZ2RyMWlFRU5ZUmx1NUNrVGgrem8wUzBjSXZOaGFoRDJqandr?=
 =?utf-8?B?cmV5QzNoZGdXYUJWTHkvMTg0SXgzSzNDOUZ6NnJYWjhVYVdvU0o5U1pybGVs?=
 =?utf-8?B?YTJTbHNVcEVKZUtFRnVKVSszNllEWkljUFd0NHhDcHNuMWltd00rYXQwOTYy?=
 =?utf-8?B?NVVIb0VyS1BPc2YrQ3J5YStIUFB3VmxWVlc4UDBwanJYSENCTDlmRTdldmhN?=
 =?utf-8?B?S2RpUTBWYnRwRFZlMjNUSFI1MUNtTEpWRzhGNjVWUWlMdE15VDErWDMzWTIw?=
 =?utf-8?B?VThhMC9jTzdya2cvRjBEWWJvVHhYekUxTDJKRkt1U3FPa2wvMG1GUXhsQlZm?=
 =?utf-8?B?WmdjNlBIZmVWaHV1Vk9HMHorOTNkeCtvS3hBNVhmRllsY3hycmxpUDRtT0NY?=
 =?utf-8?B?QXQ4VlVOWk1YUUtlcDE1dW1lZjJhNjNoZ0ZNQWFuTjQ1R3ZNcWNtQWhqUjYw?=
 =?utf-8?B?NUk3Q3FOM3o1K3dEKzdYeDMycFFyVEV3K0xlbjlFRnN1NUROdWRmczE2L1V5?=
 =?utf-8?B?UzFRTnFic0RmbzhJeS9qNWw0b2hYMkxWYmJVOFlHdTBleGZkME43ZUFkU1py?=
 =?utf-8?B?WHh5MnVjdmVVVFAwT2d0anVUd0ZuTXJFcW5aZURqc3c3YlNlTVZmdWZNOXp4?=
 =?utf-8?B?REViTk9yZVc4RXJtQlpWZUR3K0pscmFWajg5S0RyeVp6V0NLdm9UMkxtU2hS?=
 =?utf-8?B?VmxDNzRVUWJlQkN6KzExQXNYV2xQUzlPZHZsNStyS213akRjQmgwMXo5ZTUv?=
 =?utf-8?B?MGdVdzE1ZmlBZlZlZlBUYkVhc1FLNzUwOWsva25aU25kZ2JRengrbHZOY0VI?=
 =?utf-8?B?d0tudlRwa3UxRGluM000TThTM21JNldMc2VaMXhOUWhoWXpiWGVBZHM5RlZr?=
 =?utf-8?B?N0xmL0FLYXBEeEM5NDFLckpUL09FNVBKS1hTaGZsaFRNVW5yLzQ3Q05DaDZi?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae12c36d-e9a8-4d43-d95c-08ddf02598a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 04:50:42.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57dONSMjYuO5Ca7gzYuCfahNsm1VnV7+wINKdbyeMyJsXj5CVdes08Kq3B9LABxpSA7RmsmEfWdSoxYatBvytyPFg5/naqs4YwQp78jVCHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
[..]
> Can we add tsm_bind/unbind so that we can call tsm function from iommufd instead of
> pci specific functions like pci_tsm_bind()?
> 
> modified   drivers/virt/coco/tsm-core.c
> @@ -193,6 +193,24 @@ void tsm_ide_stream_unregister(struct pci_ide *ide)
>  }
>  EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
>  
> +int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
> +{
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);
> +}
> +EXPORT_SYMBOL_GPL(tsm_bind);

I do not immediately understand the value of this. dev_is_pci() and
to_pci_dev() are already EXPORT_SYMBOL functionality. Why do they need
to be wrapped in a new EXPORT_SYMBOL_GPL wrapper that validates the
device is PCI?

If this is really needed it can do in the follow-on patch that adds the
iommufd hookup.

