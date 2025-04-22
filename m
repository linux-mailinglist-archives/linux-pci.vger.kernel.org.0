Return-Path: <linux-pci+bounces-26415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9DA97368
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 19:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C141890279
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3C27C859;
	Tue, 22 Apr 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyXayeqc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7822ACDB;
	Tue, 22 Apr 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342207; cv=fail; b=MfT3eBH9tqAPv9iuLdHQ/9tmZxMHTe8qXh2KuAZqoC5tQ5fL3uBBzqRU4/RRBaJIC/YTB1M0Y/CMCfBKqe4FSdeifhMdOn2BEohXqT8edxdKutfdLm6FjovLqOewzhGLEMNNHRp5gIDzHgkaEyi7/gCRkGuZVjmAwbkL8QzdB/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342207; c=relaxed/simple;
	bh=DShvVyafBMpX9GI8DSPuY9qXSjXmX7PcQTJuqpCzgfU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bkTL66e63zbdpqv52C+gVg81v4DQYAX39+2MCxpCdZ5n6nJoP3T8g/rVqA8bJ4GUeEjFzg8Ff48oP2MsHAUin47NkJJpDUA1INJ7TMUA+VI1iMOd1Z1lbJLBfj0iKuViy4VdYUmOxtIgMPZY1KiNf/g7PLEhHP4jGTpICd4q2vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyXayeqc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745342206; x=1776878206;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DShvVyafBMpX9GI8DSPuY9qXSjXmX7PcQTJuqpCzgfU=;
  b=DyXayeqce5qjzMwcWa0ghdeefWxZHAV3pkYgyAJnon9GiaF+XIQf56Ak
   ncl/fo8iAk2Bs8E83STpYk4XRnouCb+XV9xLvwuSQut50njCMJljRbztZ
   Cq1A73xhGhi4rC4VIi2pZEByoMocVdFDWcZG6gcfAXWiNzLkQroF6WSNx
   AURSf3LkQMpklfG/+KoatEWDf7naNSHa3BYsLgPNQO0M2vE+Xe79FDHt3
   p9sluSEzERdaz1KtGEr/5dQAQor+88gPijgG+iElAm6MhOCEOsCkQrsm0
   uY77QrtGeRtj2ltbvFcmbHZ7QoPw2EXRbXs1XMsiojAsUWLXhboyDJ44P
   A==;
X-CSE-ConnectionGUID: dDm4SFbGQRGvrXZy4MR1yg==
X-CSE-MsgGUID: X2ykxmqHS8WE5l6eXoFkTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="47041153"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="47041153"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 10:16:45 -0700
X-CSE-ConnectionGUID: OvmXcoRBTPOxZf03cZ9spw==
X-CSE-MsgGUID: UJXJMAPITaO99F2sJWiQQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="137156713"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 10:16:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 10:16:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 10:16:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 10:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3jd5CumZ6Hk96ffyfa0ONZiDRipYHg2BSFxqsiNZcqU8BIylNew4NQ16ICzkDVr4p34yqKnRRfpcq5hTtgrEt7Lme03N/3l3yTcW8qaD8bJ/NqNWYjEnkQz+7XBwtExIIoxdStqQ7YPzLM0Dg5le44PbSQ3JgvvhJ7Ea7R2G5WThAM98wq7AmHtmqMw2KatKMBVLigOzFmN7suf9vbr2I6CLnBX7LCyt2phQh67ufyUdpzsIcgOJSlsRn7cT1Aei8n1mHwjKR3pkV3bp1fvedpzy/ygxWyEVl6VPP7X3EvuEZqajxGh6ZS1kga6xFvtPSKlUfYRhS1wAKD3MH3DKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhN8VcKATaJc9urGpz3I0RhLx2CIzUD28WZJ5Z+8YSU=;
 b=FRquUXqu4tLMrk2FQw2/npcTPzaoQfps3uY8nXUlDh9N2fOv8Nzv+sLo6wLU7nBwnUKap53O9fLrGnV+llqQsqfgivpLIFrtgRdDG190VN0kPl6mAWNcDxHDmWIGZAE8DNmti8+0egAjkk/Sr5lwsIzaFCnZE0v4v/+NGy29qaork/3+TiFHgxZ2fX0VcjRGfHVdKNFOUmB8HONdezyeE7l3/espNm1Kd1T6P/R/okAAiuAuY45da6qxLIirxzlWeAOKODKa2SJ2E1e4Hc/59X5HSYlgT4IKyQm6vdA8D6UskmA2Xmx3jWbTdpqxS5RoPgwcH1y4nk10IRjYwXp7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SJ5PPF3A51834D3.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::821) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Tue, 22 Apr
 2025 17:16:10 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%4]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 17:16:10 +0000
Message-ID: <74142526-b11a-4b31-b3f4-09391ed7927c@intel.com>
Date: Tue, 22 Apr 2025 10:16:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] igc: return early when failing to read EECD
 register
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	En-Wei Wu <en-wei.wu@canonical.com>, <vitaly.lifshits@intel.com>,
	<dima.ruinskiy@intel.com>, "Chia-Lin Kao (AceLan)"
	<acelan.kao@canonical.com>, Mor Bar-Gabay <morx.bar.gabay@intel.com>, "Kalesh
 AP" <kalesh-anakkur.purayil@broadcom.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <linux-pci@vger.kernel.org>
References: <20250418193411.GA168278@bhelgaas>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250418193411.GA168278@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:907:1::29) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SJ5PPF3A51834D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 709a5edb-67d1-4f3d-a0b0-08dd81c16043
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXN0aWsyWEx2UXUvQjR3ZHBNaDJPUzlhc0xVdmhaL3o5dEpHVFJEYVc4WlFx?=
 =?utf-8?B?dUVaZGxub0lkUzg0TWZjUUNQMTMzbVNlb0t1eXp6eVBPeGIvVWNmUngrd1J1?=
 =?utf-8?B?SGpKYUFScjA5NVZMZFZYNGo2a2Z4cG42bU5OM2t2bDBDbzJhOHFzZWMvKzd5?=
 =?utf-8?B?N3d1Tkl0K1o0SXhnQk5rZGllVDdJQ0s3WkN4M011c2dEUHQ4eGhSQ3pqUFJY?=
 =?utf-8?B?clpsWHk0S0RrSGQ0bVQ4c01PNE5iaUpuVkR2QkI1aE9rTjlSV2VsWlZ1VG9L?=
 =?utf-8?B?V1pHem4zM2RlSk5pc2wwSDdVVXFSRFlwNEpTS290VHJNdU1EZnA0R0hsY3g3?=
 =?utf-8?B?VHB6UmRSZnJrVGp3V0JOcFJ3SHlhYzBTNDhkRE9Dd0loR0t4cjdwRFhaQnE4?=
 =?utf-8?B?TGI5YlhyWi9uVXhkZVRqTEhRUG13K0QxTjZYYTlTRVIvUHR2M1lGaVo4WGor?=
 =?utf-8?B?cCtLY0dGdVBJUzBZRytTdzNranhRcTg1bGVsZUNKS2Y1eFpNM0RGcWlDanR1?=
 =?utf-8?B?R1dxZWFGOC9vOVdmaUZ3ekc0U2M1a3Y1L3hBZjdIZGZIV09LMzIwS25NRStm?=
 =?utf-8?B?R21LYlhpNFhCR2hTL0JlNmd1Y0IyOWpxYlF4bU1FSm1oUURta1k5VHBuNktM?=
 =?utf-8?B?QkpCbVhNZkN3REErTk5MOWdmeGg1bDV4OVhuOUF5VlhHWGUxdENqODArQ1Q4?=
 =?utf-8?B?Q2xGVkV6Y3BXTzAvdTExbHhMNm9nbE1YQktibFRQL0p6b2Uxd2ttRjQwRUlu?=
 =?utf-8?B?L0ZnUENUcHRkdEZLWWVjVmgzQjFOZk1STkhhZW96b2dEZ3RaVmVMUVNnUGdP?=
 =?utf-8?B?djkwZ1F5ekFvd2QvWXpUdExCOGdWeUZ6dkQ3bmRyU1NRTzJlMG8xUmVMTzJT?=
 =?utf-8?B?SGJTdXRBa1VLazR1OHJhUURNWFk4cGV6bGxVMm5CcHlHRUduZFJzYWkrSmdq?=
 =?utf-8?B?OEFDMG4yc3p4MGxRaktwOXBXUm5kV1JvSkJ1VjlHZVRESGl2YmdQSjRlQVFx?=
 =?utf-8?B?YzBPNkNsQzVvRE0rVlF2KzIyTmEraVd3M01aRVFMMUVLTngvdGVzWFdreXlT?=
 =?utf-8?B?UG1abVVSVmM1NDBVaE96T2dienFWWDlEaEE1c09SZHVUYTR1eURPNSsvVmJ3?=
 =?utf-8?B?VkVqc1pZUU1BcHEvbkZwMjMrN1hBNWNmbG1ZUFFPOS9CUmxGazdHUmVZeDBQ?=
 =?utf-8?B?TUNqSElvL0NIZUhNamllRnRnbkNDOGJOYXhqaUZ2UGV1WW9BZlovT0NQa1hq?=
 =?utf-8?B?UkNtc25uTDl3dmRDcTZ3WjJRdFhkKzR6djBVclhORTJJbjQxS0xuSGJPN2xT?=
 =?utf-8?B?Z2Y4ZkRDdGc5a3VUMVlvejdGUjU0bkZFNjQwMnQvMUFsVmhUMlJTS0MwVkZp?=
 =?utf-8?B?bk9jeXkwenlKU3lkbkF1YnFzWWRFUkVOWW1FR0tlUW1XdGNsNk5Rb25wN0h4?=
 =?utf-8?B?QU83WHR2L21XekFQSExNNmpEZlU2am1UdWhwbkNtN3ZqU2ovclRmdFVBbitm?=
 =?utf-8?B?K1BiYkROQmt4NGt3RHk3S21seVhlZjAzMm1pNFJQY3RZZ016Sjk0Q2RaVjdV?=
 =?utf-8?B?eE1Pc1pRQjdDRjVLcHl4bW9PRDZCOUMxT092NW8zSnlmdjd2VEVHMlFuRm1l?=
 =?utf-8?B?WUY4RUV4emNTN2ZMenpQc2hlUHkrTzFEQlMybVliVGx2dU1ZUGFSeU5XR2hh?=
 =?utf-8?B?RkNLTnBrd3U5dlFjYldRZVlGVnF4TXI0K1VnQmJuWGxDMGtJOFVzcmljd0dt?=
 =?utf-8?B?bG5Fd2dZTk1Qb1VqTTJ4bHhCTzEvUHluS0NPaWZPS1JXbTBZZ1VLbFFvNXNF?=
 =?utf-8?B?WXRYdXRxNEUyeVZhelpHM2VzR0c3UTdjdVFucVlORy9kbloyank1eTVHbWpi?=
 =?utf-8?B?RU9keEhuRFpiREZ1VXpTdGVlMVhMYllTU2hnejdIZFMwcG93N3ErVGRKWnpi?=
 =?utf-8?Q?XZGENH2PHnc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWd2RXZweFZNRGs0Y1dONEplOXpKQzJDYUNib3NKZUNmVVdjQ0poMy80RUFm?=
 =?utf-8?B?MXNwZUZrdWpBVWFrTU9DbVI0QWZSd0REQmZwVFVUN2U5ajV4RDZlUW04c0pr?=
 =?utf-8?B?Mjl4Ym5xZFVOa0dZekFTZHJ0d2NMMHpaVG0vc2phZVo2a3o1bGd2R1d3Wm5l?=
 =?utf-8?B?VFpVRjJ5L2pWbCtkQzRUMXRUWlo3QlJVUUhvWXRCVmxzOStzd1VwN1dtQXBz?=
 =?utf-8?B?U3BZZldNVmVuakc2TmxwZXJKRGQ2ZzNKeWVYcDd4VDhmaitLa1J3Z0JUdHl2?=
 =?utf-8?B?UW91SmlqejBhYm5CYS94Y2UyNytPbGJnbzg3eTUxeGZpRUlrN2x1WTdGak95?=
 =?utf-8?B?cmE1UXhCSTNEbGhucDFzcVM3Ynd0cHNKOTVTOVR0L2VnMllFSDNnMlZmMmFr?=
 =?utf-8?B?QXV4bm00ZG5kRHo5S1NPV2RnbnhQVEdnYjJkektzby9HdDZOMm9KOC8zTEJr?=
 =?utf-8?B?MlZjeXM3Ry9FcEpyNmFMZ0ZsK3lSUStxZktZM3RZeWVjNDFoSU9JaXpTQXRR?=
 =?utf-8?B?aHduSjczWVhyMnBVZlFHcUVaMk9zYmQ2cE1mNzRGU2o1bGk4NW9GcEMyeUtl?=
 =?utf-8?B?Qkk2K3ZnemRsZ3JTdWJYd25DQkQ2Z1BHU1ArSnFwSXRsSUZBRHZEMU92cjc5?=
 =?utf-8?B?WUk1Z1NDano4SHlOQytROXlPc0hKc01GVWswMzRDbUhKOG1BOHdyOG91aG4y?=
 =?utf-8?B?dDRIWWZoL2hzZk9RNDhDUk5rRjFkTDV2UWRUbmQ1MFpMS0JZc1BndWlKZmJ2?=
 =?utf-8?B?N0U5eU1YWGlCS3JSNStzKzdrVEpWTEtNdWFjSXdONm1keDY1TExHcytOMit5?=
 =?utf-8?B?R2ZWYk9oWnE5VUxOVENSbFdqaWV1TjJCWjk0bmVZSFo0MERIbXhRT0lnYXFB?=
 =?utf-8?B?Ym1XdGZxSFJSUWZXc2sxWk8raXVjOXVTeks1d2V5NkJDOHIyOEdtSDUzNFBk?=
 =?utf-8?B?Y3AwSWVuZXhvbjJRay9nc2djQVhBWGVKYlU2VUFRSE1rcmF0VGNQanZvUEVm?=
 =?utf-8?B?WklXK1JuWkw1d2JGV01zRDlRSnJiSVMxcHMxMWk1QitTV3FVYVlxeEcwZ2xM?=
 =?utf-8?B?dEhXcjBYZlpkR3JGaXlXUWtnM3BpSlNRTGNlR1NuRkVFblg1NStjWWY4dUF2?=
 =?utf-8?B?OHV0OENVU2Z2ZWpxY2pmRUV6SXZpZXl5VUZzQzhPdGdzMEZudlQ1dXJJazIy?=
 =?utf-8?B?bGNNbXRhYkRsUlIyQ0JQeVJ1anJlWkhzd216dEMwNi9LMU00aHJ3WldPSk5T?=
 =?utf-8?B?UEl2L2lqZmE1Y3pOTUdvOEN6QmtvN1VxME1KQ01kb1hxMlB0SUErczFMVDg0?=
 =?utf-8?B?bVhXSWNIeTVFeVYxd3lwQUV6WHlsUEV3UDVxR0dTUFFSSUlWYTZMSjAzWFht?=
 =?utf-8?B?STdWY0dRVHg3Y3FPVUJ6MjJUbmsrc2hHZ2dVQ3RJZm9saHptVm5zTjlKR0RD?=
 =?utf-8?B?RmJuNVdkYytTMm5pWi9yRVhuRXJQdkw5b2JjQVZUNG01NGkzSHg4cUZJWEk5?=
 =?utf-8?B?WHRiUGc5UXF1Ukk5L2RSeUhJQ1FhbFRWWUZ6Vk1CaXpzOVhiSDJYTmJBbnNk?=
 =?utf-8?B?ZGpyRnA3L09XWGYxTTdjckFNWUR5YUEyc1lYQjVDY3JSNXhPbWNmNmtPb3lI?=
 =?utf-8?B?YzNJRExVQktURHBjSWNlL2xCQjFiYzdvcFVkYmUyaHBYbnFqZW5WajBER1Vl?=
 =?utf-8?B?b1ZzQUFuVmpDLzJDQ3orMTBmS3VOdklxYkM2Y1V6N1U4V2pRek1NTjlVWFdp?=
 =?utf-8?B?VW1CUVdGQmg4dWVkbEl1N3p3MjhIS0Z6QXNNbWdEdGgydHYvTXhwLytwUWU0?=
 =?utf-8?B?bXFKS1BraWRneWZUOXFCQVo4MDUzZWVPN1pjQ1FpbFpHQld4bWVQYzBwSUcr?=
 =?utf-8?B?eUhuVnJleVFIbVJwVllyOUxxeWxQSThEMGNyMUprWjcrenRrUVR2bEczWVU4?=
 =?utf-8?B?VC90OFJ5UXpCZXNIVUE1M0IwYStyekVvQmwwT3lHV01VbU9reGJ0bXNWb1dT?=
 =?utf-8?B?TzJxNFFTVXlrRHBqbXFHQXREcEVneFUwR0JlUFpJTUUxZFg5NUhTT3J0ZzZj?=
 =?utf-8?B?SzZsTjQzcHROakEyZHZ5aW5TVFhFWjJlQUJsOXcrL0E1VGVmLy9iY3NBUDNB?=
 =?utf-8?B?alJ4a0hSbFNJZEpONzhYTUk2YTR1bi84TG5mTVNjalhsdldrR3FqelhxMERD?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 709a5edb-67d1-4f3d-a0b0-08dd81c16043
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 17:16:10.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnOHqDRv2hLuORQQmrAUEVQJ+EAcUAE8ZWlJgO+sH+s2AN66epea+A6Ku7L4iPtdWEByIU1TrtQKpWlhuRn/N2egI1To+VaZ/uxUA3ojWjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
X-OriginatorOrg: intel.com



On 4/18/2025 12:34 PM, Bjorn Helgaas wrote:
> [+cc Kalesh, Przemek, linux-pci]
> 
> On Tue, Jan 07, 2025 at 11:01:47AM -0800, Tony Nguyen wrote:
>> From: En-Wei Wu <en-wei.wu@canonical.com>
>>
>> When booting with a dock connected, the igc driver may get stuck for ~40
>> seconds if PCIe link is lost during initialization.
>>
>> This happens because the driver access device after EECD register reads
>> return all F's, indicating failed reads. Consequently, hw->hw_addr is set
>> to NULL, which impacts subsequent rd32() reads. This leads to the driver
>> hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
>> prevents retrieving the expected value.
>>
>> To address this, a validation check and a corresponding return value
>> catch is added for the EECD register read result. If all F's are
>> returned, indicating PCIe link loss, the driver will return -ENXIO
>> immediately. This avoids the 40-second hang and significantly improves
>> boot time when using a dock with an igc NIC.
>>
>> Log before the patch:
>> [    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
>> [    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
>> [    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
>> [   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
>> [   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
>> [   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
>> [   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity
>>
>> Log after the patch:
>> [    1.031000] igc 0000:70:00.0: enabling device (0000 -> 0002)
>> [    1.032097] igc 0000:70:00.0: PTM enabled, 4ns granularity
>> [    1.642291] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
>> [    5.480490] igc 0000:70:00.0: enabling device (0000 -> 0002)
>> [    5.480516] igc 0000:70:00.0: PTM enabled, 4ns granularity
>>
>> Fixes: ab4056126813 ("igc: Add NVM support")
>> Cc: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
>> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_base.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
>> index 9fae8bdec2a7..1613b562d17c 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_base.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
>> @@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
>>   	u32 eecd = rd32(IGC_EECD);
>>   	u16 size;
>>   
>> +	/* failed to read reg and got all F's */
>> +	if (!(~eecd))
>> +		return -ENXIO;
> 
> I don't understand this.  It looks like a band-aid that makes boot
> faster but doesn't solve the real problem.
> 
> In its defense, I guess that with this patch, the first igc probe
> fails, and then for some reason we attempt another a few seconds
> later, and the second igc probe works fine, so the NIC actually does
> end up working correct, right?
> 
> I think the PCI core has some issues with configuring ASPM L1.2, and I
> wonder if those are relevant here.  If somebody can repro the problem
> (i.e., without this patch, which looks like it appeared in v6.13 as
> bd2776e39c2a ("igc: return early when failing to read EECD
> register")), I wonder if you could try booting with "pcie_port_pm=off
> pcie_aspm.policy=performance" and see if that also avoids the problem?
> 
> If so, I'd like to see the dmesg log with "pci=earlydump" and the
> "sudo lspci -vv" output when booted with and without "pcie_port_pm=off
> pcie_aspm.policy=performance".

We weren't able to get a repro here.

En-Wei would you be able to provide this to Bjorn?

Thanks,
Tony

>>   	size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
>>   
>>   	/* Added to a constant, "size" becomes the left-shift value
>> @@ -221,6 +225,8 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
>>   
>>   	/* NVM initialization */
>>   	ret_val = igc_init_nvm_params_base(hw);
>> +	if (ret_val)
>> +		goto out;
>>   	switch (hw->mac.type) {
>>   	case igc_i225:
>>   		ret_val = igc_init_nvm_params_i225(hw);
>> -- 
>> 2.47.1
>>


