Return-Path: <linux-pci+bounces-6463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC208AA4DD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 23:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614441F217AA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A78194C92;
	Thu, 18 Apr 2024 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fV1fOiqa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD0194C86
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477087; cv=fail; b=LHVRcweLWFKGQ8jMkkhPjT9e8cspkC+o3w5fxWQ+wzMgkP3Biq0Kg+uxZpSTlKOX/HUmrkRcpC5nWASWXD7GTr7jC3nBUN06cfTcvUnbxFQQfoa2z8QhR24gna5weWabcL3T+dtSSmSIYSH2d+y0cejkIANQvpaTWVy6h3Lm9+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477087; c=relaxed/simple;
	bh=KnRj9SEKwXEo3KRxrPcrlxl7Gy8sGxmfyTYZDf4kjHE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDKcJ3CCevwXxcC/w4KO661RkB9ys4gdjF5Zstj31IpSO1t2sNAXBfb0DCutIbRIiPmTpXguizZQN8/UUEcYLxRst5d6PhYd0I39dgKaIaurotRC/PeHXh5nDA23eLRVCoXZxacKmMgvUxiP4GgHqIuT2H3P1bRKn9rqNbWu2G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fV1fOiqa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713477086; x=1745013086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KnRj9SEKwXEo3KRxrPcrlxl7Gy8sGxmfyTYZDf4kjHE=;
  b=fV1fOiqamATSh6r5n72nqeVTlBqEh0+f5/VFp5dxK3RxQokArcebZBll
   WKK6Lfk0JVPoo7r44KR5Wg7KVdq8CsoGksR2DKXhCHDKy3j2MVqEhw2NG
   c/nfx+tiPALMrCFUdUBaLsXYfmvbEndzjTir1MY++Is0aHO0IjkCbD2kx
   Fr4mFRqNGZ9J4h5av8zyQ4COta4+LPq6cJKBCjL60JIzR8HYi6PbnPdyz
   qLX9c/NWxmWgS+ZdjCbAMQz2yw59qkewl4icXMok10HCz4oAgCXOc21aL
   ScTJCKiENu1CEOtQQsEWaCspvZ5jR1rC6QbXnetPN1nKXzjcXTCwpWX+F
   w==;
X-CSE-ConnectionGUID: cmE7SqI2T0u79BBGGIJOCw==
X-CSE-MsgGUID: oyqn5i1dTAO2b8DzoxxKVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9182523"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9182523"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 14:51:25 -0700
X-CSE-ConnectionGUID: XbEj29MjRwee+5I8WSfVXA==
X-CSE-MsgGUID: AOHzmTC/RhqX6oRgAPeEZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27755262"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 14:51:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:51:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:51:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 14:51:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5Ssg61rIlImRfgRCV0nUp2IXKcQI8PKLB24F0MztKMjKrHlUWUTsXPyeKCNteapFiVMAP+ifAqbdq+O18X0B9loIsHT24/pJBbxsZkO4qXgmYKOS7DHHXeVqQDdAe8CFhCE33QEKgPsP2f4pWFBhYufnPyO3BzOJHzfzC6S7CFp5nPSPVT+JRifTPNKwpWQJ2Vcgp+Q/JpDdhj+kAp53TlQb/a3WmfY6xkwSdth7I3o7BQyN9+q/cAy+FyOeyLFn3/xWxZtpRfdl9wzgE4aJN0x55y7VOBE4PiabxDtjvSjF/T/h+suLW9STlhG3mSHYbQ0YAaEMDgO6pp4Uo0LHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxntBnvtYzZCKRKSQhjqQy/qWFavPY1EbxJ+3fchZ6o=;
 b=FdyJ9ZopcznE6SkgKv8+++spcZdEW9SK0AwFmLKKOgVfa2+JKkvdEWwe93w0EhJYtVbDr76mTWUwBls/6xIxwmW0OcDo7L6xYNpMuHeCP2K9bCxWEolU0CtbQrGG231rqRCXRrV53WXLztxDQCr+geRB/Rqt0OVXuTivrzansB410BaTjHAp6XMjBiPvUL2Km/xB0QiayPzeUQTvFEGgcpi3JF1gFdtHMx3QJJXTFOKsCnanRHo7uB6EMl/xQvLzlcKKUu8hVBZIh1P335wW9luvysCZtCBkJ0PL4sy8gxrtUu2ZUEphF624mX3mVJevR2IJw9ij7QzD0P9BqdQWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by LV3PR11MB8578.namprd11.prod.outlook.com (2603:10b6:408:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Thu, 18 Apr
 2024 21:51:21 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7472.027; Thu, 18 Apr 2024
 21:51:20 +0000
Message-ID: <68b92dca-2e51-4604-99e8-58a42459218a@intel.com>
Date: Thu, 18 Apr 2024 14:51:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
References: <20240418182653.GA216968@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240418182653.GA216968@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|LV3PR11MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b36b14-279a-482e-89d1-08dc5ff1af00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VROzQt/jpHG5nbGc9l++kZeKUo8LIVERY+bd3uy6aXhVrmsRO4ZljAScNAUKiBtZjgTRUfHd7aRk/FsLF593vzQF83ooZLGcGr1x5FcHWImOMZCClb4e5b6y6+HoFdh8yMS1UEE3bBMJtBkzVWDaLazGomOonKGrI0QQmE/cImpx0tYEMUBXhciJcaraG3ayoI+1EyYzs/SZz/+FzB9Jy5ssq2oaElOi6xax7fAdmkb7PezC2T+tlZZQAOkzKbYDZdTIVSl0OcagWhuMutxHCnnIzjYysPsomP0DQLA25qDiKbFqZ3OhN6lDOT5kmYOrGWs6gN9W8MK3e84dFrZhE+2TNRJZrOdXteMe8gYwirjpHeH1AskIPpiGxsixDcZFs6xa6X98Zf0p1+9RzJ140BCMMBR9ojc1elfRjRBqNZfoNAG1pEY+hOyy3xkGD5Fpwmu0klkpWSkPdd43zA6K/u7dFmLUZkf4PUmAFK07MXsX66qtck5UWY+j6+ldwKWXLdxneH/ncNnYBxrWzq3YZovYC7T4mkKx8bqEprwLfeKMj9SFeMTLChHK8kaNJBhNyL3XVwALZUz4bXDqOKtIQqdss6lUag9Oaj86G09QDaAV45OwBPY/R18Jydl4thQB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VhTmlrb2R1dnBZSkVkLzljZUt1YlVtaU9ibUhOUWUvMkJVT214QWplQVZk?=
 =?utf-8?B?VVRMRFFOOUxLamh2V1lBT0U1ZGM0UUFoTklEbzE2N1g3QjRpWW4xRHlCK2pB?=
 =?utf-8?B?T0xOcTkyQWZoVTFBRDJnSHNWZTcwTlJ5TXJPRmZxTlczNlNTbFF0UFdON2ky?=
 =?utf-8?B?KzBkbDdXcE1QU0QwZndoU1l4aW5kbnJ3dUdrRGkwZW50YVhQaWRHWTNacE9H?=
 =?utf-8?B?SkVoU1hBektYRkloYWwxdlI1ZnZrRWhrVnlCUjFtWUFBNlk1WDlidlJQbDcw?=
 =?utf-8?B?ZkQ0cFgzWmFBbTFoM1VZb3dxZ0lUT3JhTDdDWE1ScmMxWUc5ZDlPYTNMNXVF?=
 =?utf-8?B?NnlXdkxPMzVTc0U4ZjZ1dFcySWZEampUd3F6VzdHVEwwM0k2YW1mNlBzMUQx?=
 =?utf-8?B?eXpab3krQ1F4QXZXR3RWTE9TVDdBa3RORWszdUg5VVV1eFZOOW9IRUtESDl2?=
 =?utf-8?B?NWFNT0p4aytmbVRTZHMxMTlpTmpBZ2VNSXkrN3RMWlBxN0R5RG4rT0xBa2hY?=
 =?utf-8?B?bFdLS21zTUZ3aVJKRkhvY2h4ZXREMmdUMXpabktCVWVMNGZsRTVWV0s0c21X?=
 =?utf-8?B?VHdOUDRBTGx5QWFhUzlOY1BTSG1MS3JPVW9BRFVYYnIveDhvUDVPbzBaS1RG?=
 =?utf-8?B?VWU5LzErUG1RU1ZHblRva3poS0F5ZGVadGpvR3ZDMHdjMXpucFdhaDVvS3h5?=
 =?utf-8?B?bVk3L0laMENQUUVsYWJJRC8yMFVjL1RrcG4wMjVzbkVKUVFLc25udWxiMnNu?=
 =?utf-8?B?R0RBT2JOTDhHWXZzUklXZEZVYSszTDhBdVJNZU1UdWNFUTExeThXbVdzcGRk?=
 =?utf-8?B?Nngzb3d6cmZIRjdjVDE2SUZHR2Yva2NUSU1sS2JLK3hvSElZMCtXZERhMm1Z?=
 =?utf-8?B?dlg4U1hCTUc4Z0ZMQlRXQVpKeU1PMHF4bmZsS2RLU3N1cjIrL1hNQU1hUDE1?=
 =?utf-8?B?TU9rR0twNmdURnZPZGljZzlHenpuWUQrWG5YcG41c2dudUt4eElJRXY1RG15?=
 =?utf-8?B?YTNoNGo5ZFcyREhzVUlQUVNqSWlabUVKYjl0NVpvMzBJNTZscUIxelMvTFQ3?=
 =?utf-8?B?RDBPeDVHMkJQbDFMa1gwTWczajhSNmdqQnhaR0hxRTEyR0J2dGtmUjY0MTh0?=
 =?utf-8?B?WENtRk9LK0psTml0SG44ODFXMlpUYWt1MGNzODc1NE1lT3gvb2JaeGlDVWkz?=
 =?utf-8?B?bHgzZ1cwcU14cDE3ekhRRTZvRVpUVGJ0NUN2SDRZb3FHSmZyK0luLzU0dzBo?=
 =?utf-8?B?emMxT3R6WDNXUlhFQzA1R1VtcGllY09yZmExZ2t6RFA3M28xamxlSXN1Vm55?=
 =?utf-8?B?WVRqeTREV0xucjNWOVNUajBjVVNka0pGSnA1UUNGSEUyL0pVa3E3YnpTMG5o?=
 =?utf-8?B?Rk0zM25FMG55N1BQdHRZaG83cllsdytITXc1VFpQN2x6YkhLUWVlTW9rZzll?=
 =?utf-8?B?SDRPTzBxQVhVREJiaWsvbzcvMytzUDZmck1NbmlBcmZIb2loK0NTMG5QalMw?=
 =?utf-8?B?cnJjTjc5M3paZUR0Z0Q4MllXQUYvU2tPUEJGeTlrazVCOFVoc05tU2lncDcw?=
 =?utf-8?B?MWFlS3NFQUNiUnphMERnVXpXcWZab0h5ZUVFUDZkeTZGaWZVYUN0bkF6SlRr?=
 =?utf-8?B?UXZrTFdpeEQ4MGl2YTlvZDJwME84S2kzOXAyeFBDQW9ydWFac3FERHhyMW01?=
 =?utf-8?B?NStBQUp3MWdpSlY1ZzVxNm9zdGpXd2R5bmprQm40VDhhZXRNeGdkYzE2VlVv?=
 =?utf-8?B?cTEzSjBjSkZ5ODZId1VoUFVqQlFYUmhxTDlWQTQvcHk5V2t0YjJIMHNZdWwv?=
 =?utf-8?B?U0g1Z2w4VWRyaENUK0h1V21QNEhDalRPRlIrTEdDTUFhcm1nKy9yZ2dNSVh2?=
 =?utf-8?B?QVlIQldERmlCYUcxWjNnNEc4cEQxdU56V0IvTTZ6NWF2dFBVUWZiRFRacFcx?=
 =?utf-8?B?SytqR0NxVTJ5eHVsN1FIY2E1N1hiQTBLT3lxR0hHYWdDRFBZOWlXdUdBeWxq?=
 =?utf-8?B?RUx1NFdzSjM1S3c2T05DVm1vKzBQUW5Hd1U1MmRHM2QvSzhWRDgzQjk0K1h1?=
 =?utf-8?B?a0psWjVqTzNhWGFjQzhlMzVjOTljeXdWTUs2amVobVBDQVVJTUNtRnlvWVRt?=
 =?utf-8?B?QWlHaFpRZXFEaURDb2ZzOGpJVzFyQjdHL0tGVHRhQzB1QkRNTDlaQ1R4RzRt?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b36b14-279a-482e-89d1-08dc5ff1af00
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:51:20.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjIRufXrt9xosWlfFwABq2XNtpMhZl6mTL2Zy6/Ve4MFDXasdePCdzKbZMKvcz5l0o+Zk+4H/OPo9us2ZXWIaniGPAdnZMsTUUuv6LtYRMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8578
X-OriginatorOrg: intel.com

On 4/18/2024 11:26 AM, Bjorn Helgaas wrote:
> [+cc Keith]
> 
> On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
>> Adding documentation for the Intel VMD driver and updating the index
>> file to include it.
>>
>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>> ---
>>   Documentation/PCI/controller/vmd.rst | 51 ++++++++++++++++++++++++++++
>>   Documentation/PCI/index.rst          |  1 +
>>   2 files changed, 52 insertions(+)
>>   create mode 100644 Documentation/PCI/controller/vmd.rst
>>
>> diff --git a/Documentation/PCI/controller/vmd.rst b/Documentation/PCI/controller/vmd.rst
>> new file mode 100644
>> index 000000000000..e1a019035245
>> --- /dev/null
>> +++ b/Documentation/PCI/controller/vmd.rst
>> @@ -0,0 +1,51 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +=================================================================
>> +Linux Base Driver for the Intel(R) Volume Management Device (VMD)
>> +=================================================================
>> +
>> +Intel vmd Linux driver.
>> +
>> +Contents
>> +========
>> +
>> +- Overview
>> +- Features
>> +- Limitations
>> +
>> +The Intel VMD provides the means to provide volume management across separate
>> +PCI Express HBAs and SSDs without requiring operating system support or
>> +communication between drivers. It does this by obscuring each storage
>> +controller from the OS, but allowing a single driver to be loaded that would
>> +control each storage controller. A Volume Management Device (VMD) provides a
>> +single device for a single storage driver. The VMD resides in the IIO root
> 
> I'm not sure IIO (and PCH below) are really relevant to this.  I think

I'm trying to describe where in the CPU architecture VMD exists because 
it's not like other devices. It's not like a storage device or 
networking device that is plugged in somewhere; it exists as part of the 
CPU (in the IIO). I'm ok removing it, but it might be confusing to 
someone looking at the documentation. I'm also close to this so it may 
be clear to me, but confusing to others (which I know it is) so any help 
making it clearer would be appreciated.

> we really just care about the PCI topology enumerable by the OS.  If
> they are relevant, expand them on first use as you did for VMD so we
> have a hint about how to learn more about it.
> 

I don't fully understand this comment. The PCI topology behind VMD is 
not enumerable by the OS unless we are considering the vmd driver the 
OS. If the user enables VMD in the BIOS and the vmd driver isn't loaded, 
then the OS never sees the devices behind VMD.

The only reason the devices are seen by the OS is that the VMD driver 
does some mapping when the VMD driver loads during boot.

>> +complex and it appears to the OS as a root bus integrated endpoint. In the IIO,
> 
> I suspect "root bus integrated endpoint" means the same as "Root
> Complex Integrated Endpoint" as defined by the PCIe spec?  If so,
> please use that term and capitalize it so there's no confusion.
> 

OK, will fix.

>> +the VMD is in a central location to manipulate access to storage devices which
>> +may be attached directly to the IIO or indirectly through the PCH. Instead of
>> +allowing individual storage devices to be detected by the OS and allow it to
>> +load a separate driver instance for each, the VMD provides configuration
>> +settings to allow specific devices and root ports on the root bus to be
>> +invisible to the OS.
> 
> How are these settings configured?  BIOS setup menu?
> 

I believe there are 2 ways this is done:

The first is that the system designer creates a design such that some 
root ports and end points are behind VMD. If VMD is enabled in the BIOS 
then these devices don't show up to the OS and require a driver to use 
them (the vmd driver). If VMD is disabled in the BIOS then the devices 
are seen by the OS at boot time.

The second way is that there are settings in the BIOS for VMD. I don't 
think there are many settings... it's mostly enable/disable VMD

>> +VMD works by creating separate PCI domains for each VMD device in the system.
>> +This makes VMD look more like a host bridge than an endpoint so VMD must try
>> +to adhere to the ACPI Operating System Capabilities (_OSC) flags of the system.
> 
> As Keith pointed out, I think this needs more details about how the
> hardware itself works.  I don't think there's enough information here
> to maintain the OS/platform interface on an ongoing basis.
> 
> I think "creating a separate PCI domain" is a consequence of providing
> a new config access mechanism, e.g., a new ECAM region, for devices
> below the VMD bridge.  That hardware mechanism is important to
> understand because it means those downstream devices are unknown to
> anything that doesn't grok the config access mechanism.  For example,
> firmware wouldn't know anything about them unless it had a VMD driver.
> 
> Some of the pieces that might help figure this out:
>

I'll add some details to answer these in the documentation, but I'll 
give a brief answer here as well

>    - Which devices (VMD bridge, VMD Root Ports, devices below VMD Root
>      Ports) are enumerated in the host?
> 

Only the VMD device (as a PCI end point) are seen by the OS without the 
vmd driver

>    - Which devices are passed through to a virtual guest and enumerated
>      there?
> 

All devices under VMD are passed to a virtual guest

>    - Where does the vmd driver run (host or guest or both)?
> 

I believe the answer is both.

>    - Who (host or guest) runs the _OSC for the new VMD domain?
> 

I believe the answer here is neither :) This has been an issue since 
commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features"). I've 
submitted this patch 
(https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/) 
to attempt to fix the issue.

You are much more of an expert in this area than I am, but as far as I 
can tell the only way the _OSC bits get cleared is via ACPI 
(specifically this code 
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/pci_root.c#L1038). 
Since ACPI doesn't run on the devices behind VMD the _OSC bits don't get 
set properly for them.

Ultimately the only _OSC bits that VMD cares about are the hotplug bits 
because that is a feature of our device; it enables hotplug in guests 
where there is no way to enable it. That's why my patch is to set them 
all the time and copy the other _OSC bits because there is no other way 
to enable this feature (i.e. there is no user space tool to 
enable/disable it).

>    - What happens to interrupts generated by devices downstream from
>      VMD, e.g., AER interrupts from VMD Root Ports, hotplug interrupts
>      from VMD Root Ports or switch downstream ports?  Who fields them?
>      In general firmware would field them unless it grants ownership
>      via _OSC.  If firmware grants ownership (or the OS forcibly takes
>      it by overriding it for hotplug), I guess the OS that requested
>      ownership would field them?
> 

The interrupts are passed through VMD to the OS. This was the AER issue 
that resulted in commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe 
features"). IIRC AER was disabled in the BIOS, but is was enabled in the 
VMD host bridge because pci_init_host_bridge() sets all the bits to 1 
and that generated an AER interrupt storm.

In bare metal scenarios the _OSC bits are correct, but in a hypervisor 
scenario the bits are wrong because they are all 0 regardless of what 
the ACPI tables indicate. The challenge is that the VMD driver has no 
way to know it's in a hypervisor to set the hotplug bits correctly.

>    - How do interrupts (hotplug, AER, etc) for things below VMD work?
>      Assuming the OS owns the feature, how does the OS discover them?

I feel like this is the same question as above? Or maybe I'm missing a 
subtlety about this...

>      I guess probably the usual PCIe Capability and MSI/MSI-X
>      Capabilities?  Which OS (host or guest) fields them?
>
>> +A couple of the _OSC flags regard hotplug support.  Hotplug is a feature that
>> +is always enabled when using VMD regardless of the _OSC flags.
> 
> We log the _OSC negotiation in dmesg, so if we ignore or override _OSC
> for hotplug, maybe that should be made explicit in the logging
> somehow?
> 

That's a really good idea and something I can add to 
https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/

Would a message like this help from the VMD driver?

"VMD enabled, hotplug enabled by VMD"

>> +Features
>> +========
>> +
>> +- Virtualization
>> +- MSIX interrupts
>> +- Power Management
>> +- Hotplug
> 
> s/MSIX/MSI-X/ to match spec usage.
> 
> I'm not sure what this list is telling us.
> 

Will fix

>> +Limitations
>> +===========
>> +
>> +When VMD is enabled and used in a hypervisor the _OSC flags provided by the
>> +hypervisor BIOS may not be correct. The most critical of these flags are the
>> +hotplug bits. If these bits are incorrect then the storage devices behind the
>> +VMD will not be able to be hotplugged. The driver always supports hotplug for
>> +the devices behind it so the hotplug bits reported by the OS are not used.
> 
> "_OSC may not be correct" sounds kind of problematic.  How does the
> OS deal with this?  How does the OS know whether to pay attention to
> _OSC or ignore it because it tells us garbage?
> 

That's the $64K question, lol. We've been trying to solve that since 
commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") :)

> If we ignore _OSC hotplug bits because "we know what we want, and we
> know we won't conflict with firmware," how do we deal with other _OSC
> bits?  AER?  PME?  What about bits that may be added in the future?
> Is there some kind of roadmap to help answer these questions?
> 

As I mentioned earlier, VMD only really cares about hotplug because that 
is the feature we enable for guests (and hosts).

I believe the solution is to use the root bridge settings for all other 
bits (which is what is happening currently). What this will mean in 
practice is that in a bare metal scenario the bits will be correct for 
all the features (AER et al) and that in a guest scenario all the bits 
other than hotplug (which we will enable always) will be 0 (that's what 
we see in all hypervisor scenarios we've tested) which is fine for us 
because we don't care about any of the other bits.

That's why I think it's ok for us to set the hotplug bits to 1 when the 
VMD driver loads; we aren't harming any other devices, we are enabling a 
feature that we know our users want and we are setting all the other 
_OSC bits "correctly" (for some values of correctly :) )

I appreciate your feedback and I'll start working on updating the 
documentation to make it clearer. I'll wait to send a v2 until I feel 
like we've finished our discussion from this one.

Paul

> Bjorn
> 


