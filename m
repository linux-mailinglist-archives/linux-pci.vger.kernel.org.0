Return-Path: <linux-pci+bounces-6139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600768A1C6D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2411F2142E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE41219DF4C;
	Thu, 11 Apr 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2ssOW88"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE53199EAC;
	Thu, 11 Apr 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852562; cv=fail; b=UK0coZCVDse9yyMuFd7dXpEInPyQORnEJs/CCQykHqMMwCtx5IIxVwUm/PcbNTy3dCitPRwEMVZwV4lwX1kqOnnAp+FECF1DlQO+a6zEXzHtqLfAI9ehSvtXiHA4hEEsU9hNBQfW7z51Fs4b9jo/ObEqoSh8A/WNPUS5I7WFwYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852562; c=relaxed/simple;
	bh=UbtNtDLKZphtQJD/E8yE7CRvBXx01CqZki+uRWFL8oU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M6kpUQke1xDTiTdnob056k+l7/tMmpFXKnSkE8F+f32B+nQKOU/2JZb9UXZtnV3Xn9ssCjSu74+RsryM03lH2HtXCil0WDn/MwqO05aSpPPQx9lcAPNt85FvGu31RfyUW2berhJ0k+j7mWAipneGHxn4e0EFYmejUwhuZr0bdMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2ssOW88; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712852560; x=1744388560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UbtNtDLKZphtQJD/E8yE7CRvBXx01CqZki+uRWFL8oU=;
  b=E2ssOW88fyMlqDgDM/QJeIdFubgnNgSUpL6tDDgBWDD7YLVwwsworfi5
   EPThWZdJsa6DnzWq6zHE/DLq5DsY6vDv+Gsgn3aqt5sgkc9EB+s7uziLt
   +Ag3zjQOkO7H57W3rN/Z8EZ4WzGxbXwA+PV3006AaIthpMhjfRcIoQuzr
   +aFqVJQGntbiRx4Luy9FuRLWuRXrevzLCjaot3+SDGbvkOW3wA1EHVEiG
   ZZ1fuKeYu/ENaz16f3Q6gcCGsQewn8I2tYQol7fH5FbJvaEC5EXoaOl9H
   vpa187q6peuI7MY2AXzOzzJ2UosIA9OuJGQK6CJywdN/khN+VjdC2pw8n
   A==;
X-CSE-ConnectionGUID: ZEyeUw1TTXmD2YpHsLy3XA==
X-CSE-MsgGUID: EJS5c9wkR+mQajhUpMvzNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8150986"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8150986"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:22:40 -0700
X-CSE-ConnectionGUID: ogjpxaJ4TzaReK63baLI2A==
X-CSE-MsgGUID: oaOi6PeaSlyFsx5/Cm0UlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20967533"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 09:22:39 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 09:22:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 09:22:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 09:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3nq6ckqF5rO0NjgStU+Am/fhlCxdOrn4qV4gMWTT7YDbYD9poOnty6u0m1vlbA6YwJU5u5l+LNpohaE2pXdC9MRS2w4Gbw5/9MNMRxicd15etEg+jd9AZZ9CO8FepNzjNUf7ta2pNr/Ux5Gv6kQ9oib9qlDoZ9MyyHUV9ChmF8+H/w3qw3cKhMrodt/zmni7zDDboQhOSEV1Jf9DGKaULuKaDyzLxJCAktkpF1UACp+RAGjF+ICFJOc4H+9WLt9QbZ1gcxERHoZ0p/c4SB+m+3J2pKGu74NjtYGhQI6u69YZwz5RAOlc/BRkuumBRBHpxvhpBBNhzM4SsQotIFWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyd+VfSiYjhEhB1rMYqzUbhq/Q2/HaP+XLLYzJhiq0U=;
 b=jJqLnrxY9QbecrqjO4/+OikYXCgOTQiCvj+UN2pN8xgx89vUl6WwDofL2NF2d8P2G8QSAEuh75rktKmjxdKQ7Kgl3VOmi5wedxAK7jXWf/MNGcW3iUgEyEV/e6hbiMVPFciyFA6igNqMf1A432GwXPcSnu+d8GDUp+4aSabctUg/XMkEBV9OYOP2nO0rHgKJkBfBm5rjYY3aDvVowwRI1cICpL51QuS7Qch63DiY808osx+tIWNs5o3QBXu2DDyiuA4KGVc76rR2AkDYp0xuxAnFs/NGCz8TYo9vsOWHGue+pTR21Y9bcvpIUx2jN+3J6GmZPjo5etVBJ6fzGyjeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 11 Apr
 2024 16:22:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 16:22:31 +0000
Message-ID: <658246e4-ea1c-4f15-9853-70a4f0f7869d@intel.com>
Date: Thu, 11 Apr 2024 09:22:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>
CC: Jakub Kicinski <kuba@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, <pabeni@redhat.com>, "John
 Fastabend" <john.fastabend@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann
	<daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
References: <ZhZC1kKMCKRvgIhd@nanopsycho> <20240410064611.553c22e9@kernel.org>
 <ZhasUvIMdewdM3KI@nanopsycho> <20240410103531.46437def@kernel.org>
 <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
 <20240410105619.3c19d189@kernel.org>
 <CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>
 <21c3855b-69e7-44a2-9622-b35f218fecbf@gmail.com>
 <20240410125802.2a1a1aeb@kernel.org>
 <7dcdd0ba-e7f8-4aa8-a551-8c0ab4c51cd9@intel.com>
 <ZheDyIRWPggbSB_r@nanopsycho>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZheDyIRWPggbSB_r@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: ca685204-22a4-4f56-0edb-08dc5a4396c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W50PiGPYMJcCTqfhqMMMFVO37RIDpfIANMTXPdF/CiPSygFBr2J3QJM+VXw7lNU8br2w1d1jLXj6rGY2sX7u2ZynPd71hfDp1QsKpSV3A7X/NIZooRuvRVrkQI/vqzV4pA0lxid4+j+E5lXh+nMSU/fqxYyghvX/lDWeJxjwofXhVlIz0g7hepBU+UVs8cvge4BwQTnHND13kVnufCQytAcbFP/NSEL1HBgZHrFapkB71X6kacGJFYLdEMFEO7JNejL2jXeq59OZb/jjfbu7VB7q3l7OHQ3kJnpD/1BmYwcmxHjv7ZSVRLFhVmxQM01zOVN68ezHKj/3zjpQ+cX4rBRjNoyfNnjSfr3L/avjawvjVzOqwZEwJstTHKmQoqLS99x3rgLKywnwe9fxf24NzXp5v7euswi0FbRwkzA/vkhCmxUP/Is7HEZPQmkfw6v0JL5KQm8R5SSiEm49jg2m3Edcb5y5p50icHsfmSVEheXlpr9Wv9whFgCrqiZ95Xq15ihZIcq7jmSd6AUX+KvfJ1fVVGx1XfRlKI6FXs1ZXVZf0xAl+0D6ZVgWnFApqIrOxFB1uuAVH7hjQv8POMMVnA4MrozL+/1+kSyxypNj1VVlgk1aTGUS21Vq+HXemdEefbVeR54LR0akB37RH142s835FhfmGnGt55x1f2A3bqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejkxcmdtdXY5bEduR21ZQUxwVy8zOWNlR29mUTM0STEzU0lwWWtRb2hMa2Zy?=
 =?utf-8?B?RVZ6ZE9ESVNRekcwQ3FiaU9GSlB6c3ZGRDR4aCtkdU1kcXB6aHlBUzFFaExM?=
 =?utf-8?B?WG5WZmk5NG1RYVdBbHlHOFBjWGUxYWJmb0dhSVNQdjNZdnl3L09rL0RYcHV1?=
 =?utf-8?B?Sk1hNVhWbEU3SFJFQVJhREZHbXJuZWJMbWVtcEl1a2Z2OFFrY0I2ZXgzWGR0?=
 =?utf-8?B?NkYreDhlSlZCSXl0NVl2YWVuNG1JUkZOVmJqWUowUU4vZjcycFFkVFhCOHJl?=
 =?utf-8?B?NjVKNUxBVGZDcUhhcko0TmF4aFN6dUkvcjNxWTFKS1ptM2xGN29CWmYySldU?=
 =?utf-8?B?dU4vbHE0dHFhUmt4Rk5HajB3aENjY0NSUy92TGZFTVl3aCtoUW5MekwvUDU4?=
 =?utf-8?B?NUxuZk9XTCsvb0RWckRmMElQR00xMEd3K2lIVGtKZW05L3pYa0F1SlNqTU9a?=
 =?utf-8?B?MUNCOFFZK3MreDM0VVpYRTV5ZFR6SzlMa2dPcm1JbTRNZmt2cWhLM01xcFVY?=
 =?utf-8?B?NHpmY0ZjRmVjQ2RlcGJkZGVub2Y3a2oyUXp1VzhNOUdpa0Q3TUF5NDNBZ3J5?=
 =?utf-8?B?Z0paVDJkekY2ZDZYSk10TXRMY1plcmhkWUNCRllkQ3RudEtLZUhIL3BBQ0tB?=
 =?utf-8?B?RlhUVTFHa0ZZMXFtckFmS09oYlBjeFRkNlZadEpzdkNFaVRQaUErSGlRcDdQ?=
 =?utf-8?B?YjMrWFlGRDVNNzFLSjlYUk5ad0tvbENXVmlWVVRYaFFuT2ttc2QwVUgyTERy?=
 =?utf-8?B?ZFBXTFJWOGRKNFpTSHd1RExCT0lMOG5jZWNScVBzN3ZKZ0cxTjV2dERFK0U5?=
 =?utf-8?B?djlxdlVpWnkvd2tPa1FBWVIwb2FYc281VCtVelZGaTNCcE9tZXNYbkhLVyt0?=
 =?utf-8?B?ZUF6aUVUeVFVS2pKMmhFa0dhT2M1cmZoN3hSazkwOTk3K0MxS3BYUGovbEl4?=
 =?utf-8?B?ajRIN296Vk92VzVhOFJqYnA3R1YrL1hFMjV6VlIzT0ZGU0RmNElSTWhGRFdF?=
 =?utf-8?B?citxMi8vMXI2VnJqSzlQUVN0aTdHTXVRQkZjNHlGSnBYbVB2RnZEOE9FRVF5?=
 =?utf-8?B?dHljYnp5Y1R3eDdYMklXcjRNQ1p6bG9YQ3piTnZRTlFPOHZqTWwyY3VLQmlj?=
 =?utf-8?B?a0pqcFl2UnA4L0lGMVdMWVlBVWRUa3k4MGJyaXRYNE5qcXQ4aFY5U2g4MDFw?=
 =?utf-8?B?N2VpdXRHZTlNeURHVFVKbmVJWGFQZURJZFBwc2UrazE5MTBSSFY2MFoyRkg0?=
 =?utf-8?B?cFVVVFZSUVFQY0gxRm8vaFpJc1o2cldXeWZxV0Nyd09PYVEwaTBQWTVWNkF0?=
 =?utf-8?B?aWlKUmE0WC8raklKZUtrZHpROFhBUDNKajVIN09ld1FWSlhOWTVKS3RQb2NO?=
 =?utf-8?B?OFQ4RnUwc3hRenhLRHlYNlhZenZqdVFJbHZJbG1HUjhLWjdiMzNIR3dCQXg2?=
 =?utf-8?B?RFBKS25NdHdLSFpIT0Q5WjhIbFlmOVdCRW8zSDV4MDVJVVg0dlBVSENMN1k1?=
 =?utf-8?B?QzZKWFJjS3RvUWJWNzhPYTN3bUNlbVFHcjYwSnJOYm9jQVhKM0NYTVMwYy9W?=
 =?utf-8?B?bUVYbzdRWFZBdEdzbjJvL3NSWngyNGJnQklUL2oyMmxiMEthL28xeFhyZGVs?=
 =?utf-8?B?b0FCcjF4TDV6bUJaenJ6TEpqUFMyK29UbUdUUVYvaE94ZDEwTHlCWHZBTXgx?=
 =?utf-8?B?K3ZvQjB2VlBzUFFEbUVPOEZudTFKQ1FHaFc2L3VOM0tGWW1HaXNBWWdSS3dH?=
 =?utf-8?B?VDNiL2pWa2dYVlV1SFRCajR4WlNLMEt6cXdQY1k2NVIrK2VDUXJGZVJqSjVj?=
 =?utf-8?B?V0JaZDd5VS9IWC9VTXBENGduWHRUWFM3S0FsT0cwSDJaU2diSkhQR2NldnEy?=
 =?utf-8?B?UURlMnZPRkZyZ2ZCZmdmU0IrVHBVcFpBVzVEVFUraGR6OWoralRUcEZxRWNn?=
 =?utf-8?B?akZ3STh3Si8vWC9TTkYvSEM4Y05pdGwyb0ErRkNqUDI0d0xhK0tWMkJBekZC?=
 =?utf-8?B?dWpObkxGU0FzNG5NTTQ5YkRRMXozS0xsbDhMZHlXMHZWYld2cThSQmxDVnRP?=
 =?utf-8?B?SnJzTE9Zb25UdU9mMjIrbVVrTXQ2UHJCeXpWSnJrdGhvZ1JhdDlyMEVXWCt2?=
 =?utf-8?B?YTVOcFVKZlRqejhtRGRvVmhOOEdpWGZVOWM1VnVVOHYwUzFMdXVXTkJlUWs1?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca685204-22a4-4f56-0edb-08dc5a4396c3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:22:31.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BGfSvqOtpqVsjLHNvPWZyXzsNIJfaESvKo0aVHMW2Gur0UiQZuw4PN+GXevUWTXrCFtdqWjCiVxot4r8ySKwIakPoRmADC7XXbd3Mf/jBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
X-OriginatorOrg: intel.com



On 4/10/2024 11:31 PM, Jiri Pirko wrote:
> Thu, Apr 11, 2024 at 12:03:54AM CEST, jacob.e.keller@intel.com wrote:
>>
>>
>> On 4/10/2024 12:58 PM, Jakub Kicinski wrote:
>>> On Wed, 10 Apr 2024 11:29:57 -0700 Florian Fainelli wrote:
>>>>> If we are going to be trying to come up with some special status maybe
>>>>> it makes sense to have some status in the MAINTAINERS file that would
>>>>> indicate that this driver is exclusive to some organization and not
>>>>> publicly available so any maintenance would have to be proprietary.  
>>>>
>>>> I like that idea.
>>>
>>> +1, also first idea that came to mind but I was too afraid 
>>> of bike shedding to mention it :) Fingers crossed? :)
>>>
>>
>> +1, I think putting it in MAINTAINERS makes a lot of sense.
> 
> Well, how exactly you imagine to do this? I have no problem using
> MAINTAINERS for this, I was thinking about that too, but I could not
> figure out the way it would work. Having driver directory is much more
> obvious, person cooking up a patch sees that immediatelly. Do you look
> at MAINTAINTERS file when you do some driver API changing patch/ any
> patch? I certainly don't (not counting get_maintainers sctipt).

I use MAINTAINERS (along with get_maintainers) to figure out who to CC
when dealing with a driver. I guess I probably don't do so before making
a change.

I guess it depends on what the intent of documenting it is for.
Presumably it would be a hint and reminder to future maintainers that if
the folks listed as MAINTAINERS are no longer responsive then this
driver can be reverted.

Or if you push more strongly towards "its up to them to do all
maintenance" i.e. we don't make API changes for them, etc? I didn't get
the sense that was the consensus.

The consensus I got from reading this thread is that most people are ok
with merging the driver. Some reservations about the future and any API
changes specifically for the one driver... Some reservations about the
extra maintenance burden.

Several others pointed out example cases which are similar in
availability. Perhaps not quite as obvious as the case of this where the
device is produced and consumed by the same group only.

The practical reality is that many of the devices are practically
exclusive if not definitionally so.

