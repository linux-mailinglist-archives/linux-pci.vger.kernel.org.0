Return-Path: <linux-pci+bounces-6088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A68A02CF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C801F23623
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AED181D19;
	Wed, 10 Apr 2024 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6JHSnn/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71F1836E1;
	Wed, 10 Apr 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786643; cv=fail; b=m0rgQBBGWghhDJ+4R9ez/VjAEX17ALKRQQGnPN4+kZROoyBXW4Wud4wb5f+LdFWlyyzgKszqlnc6EgIlN9Tvc/SuhfZBXfU08rHm1B3cT8MGQ4jxoPoayWBfmBMUwxR3l7w/ST42LjWC2yQEbbocKj67dEM2MX0V5OOk9+zPSOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786643; c=relaxed/simple;
	bh=5rgK6sfeu2j4oipp5KvNBaQSLqVojJgnoknSUrKAPio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qIgxXkkt1igRyYiNYpizzmdrf1p1imur+nzolHCFF2crGiZwRen/heHD0wfMonebTyBdt3vq6jlaaNhqsZbRFFNCT+2UStvSrUC+HqfGm6OzG/64Z1aJFgklWW9iFo1yIqAd/lT7NmwiFY6mXdl7gORNn02LZ+Qi4vG9ElcHXGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6JHSnn/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712786641; x=1744322641;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5rgK6sfeu2j4oipp5KvNBaQSLqVojJgnoknSUrKAPio=;
  b=m6JHSnn/29Sp2q47vq7KQmE7fBxh/Li7d4XJ5FcZjgZEkWHgV1PcVRO0
   soIr5EjMNZQux9m+D0nZLUNFcJ76E2xeGzk2qgk6FWPRWsr8jimkJt7z2
   DHjHasWCEjSaqOn27g0Am6BXI44JjxrBhPLSo6De3uDyg2Ps0szj0AnDP
   5xS5WkaGnP14gxR3Gpqr/T3q0nv6Rr6bcN+j5olboqCHYuqwNsOsNMYzn
   IUrRVnAw49jxADDTWEgih6yAUmoXZsIu5PUVdd0p6OKxT1/GYPIbYxABE
   KUloKDa5eHJXOlTSWkHdNDw+ZGilnmdxQc4I8QhUssc3CKCJrncjksmWs
   g==;
X-CSE-ConnectionGUID: RUrPKOZeSMWLj658SEvU/Q==
X-CSE-MsgGUID: Ci2ZPjG2RUS14cHF2XweaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8353559"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8353559"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:04:00 -0700
X-CSE-ConnectionGUID: 3hQm8uGQQai39j+cDJFgiw==
X-CSE-MsgGUID: GgoVoQKiRYy8n6V6se/6qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20737061"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 15:04:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:04:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 15:04:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:03:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhm31/IstFV+aoj5X/6+PB4J1+EUvPJOQey2dEYGf5A9DUZhL5fVtUmUjYvhviNTjSEaWKZ6CLPCE+5I02WNZbUT2pUEkCLkkbwzB1tH0iiT/n/cjEPCObRGrncgtBWcZrW3gdfgfrb2yP2w55vVZuUHyVQijKbRE5PXQFr2Z7T2yu20l/q/5E+LYTPiRPWBEJWmqCLscclRvpSdEBuVGaRU2S5DJ/WRLceF3ADmvKv6RaFfZdMAyuGiDLGiZS3u6Fo9f/KFc9XFwk2NXBewaUdxDtGELyk9tbdSgdIWJYYPNF0T3aDu1d/09FxhJ1Fso3mMfCQp3fgx7aYLpfwsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTJMzkL4gTL4/oYok0RapsNnx5xE4IMCwskfa+KUc38=;
 b=Bw+KQ3XzrSgVuOaXND7J/a6E9AzxMHhF1K7D5r4duCB1res11KjzOupAdvOm0B2IBpK4wlj+VVvAtSY61jd8v7lSfCnHMvNzQjb/7hzMrKRMQ5skXc/Vzq3LSOk4id0fkdnhOU9PUtUbRo1galwv6kxy6Cunxdc9z6krA3E0Y1HR3JR8WcXG1qn0H94oACzQ56dS6wXGvU4ygFFqQBeqGiHuYyBW7EayuTP29FSSj/oOcj/IAljY18H9owEgnj8z5ght8fposwnHDBARBkmTmId0Vc0GXAZuCe7UB2gHIsDQP24T/KOdUtl2tlVej1QiHx1HTuA75gqYe0gqx0X/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 22:03:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 22:03:56 +0000
Message-ID: <7dcdd0ba-e7f8-4aa8-a551-8c0ab4c51cd9@intel.com>
Date: Wed, 10 Apr 2024 15:03:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jakub Kicinski <kuba@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, <pabeni@redhat.com>, John Fastabend
	<john.fastabend@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann <daniel@iogearbox.net>, "Edward
 Cree" <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alexander Duyck
	<alexanderduyck@fb.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <ZhZC1kKMCKRvgIhd@nanopsycho>
 <20240410064611.553c22e9@kernel.org> <ZhasUvIMdewdM3KI@nanopsycho>
 <20240410103531.46437def@kernel.org>
 <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
 <20240410105619.3c19d189@kernel.org>
 <CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>
 <21c3855b-69e7-44a2-9622-b35f218fecbf@gmail.com>
 <20240410125802.2a1a1aeb@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240410125802.2a1a1aeb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0329.namprd04.prod.outlook.com
 (2603:10b6:303:82::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7177:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztbKYycjDCfGx1Jc/6mjT+1mXgVv/22PXLmV+ZrW2wIdCuS3JxlyHBMKf05L2odgtIXzimtpSeLlSUQhnkkpJ2LneWLOEXG+1z6FJt7PBxx+AF5qZyKVa5SvHPAkO5sb4Roq7I9tAST30h7XRe68E78Rqz61LZIpns1aqtyJ4MmtMKEw3GCLtRoMLO1FzxAzIzv9As990KxiA0xp7nSRaM8FiHsKU08pnKqDryizebZbwHsuFQV9cZ1S1RXZq9uxUccMzJQF01+M+aHClZLP9XmdKdywGanL3jNknznoY8BtvQlgJ+2xfeA4HnRLPBZIvTJfWcihoO93cDbxWofJ8SyR/cNFoIX9mNZmddFdYNsemjOyrxbJDxXrkQB4TZWCDK0aOaeUyhEgpB6bXgeaIVsD2nx4rewo/l6VWsoqFm9BeWSjm5Vojl+raDc3F1ZyNbulIoCGJ2ksQYOb1Xkic0oAD6NlbRVmvcOBEt+Jx80ZQAJraRz7FZprOK8I07iMBiue4ssN0Ev2vHi3ie2+NGVC3L5T9n/XqVuHzqBrX5RXKu5CsRA8ZiCNriOYABIRez+BgnvuxHa7lCsgNSOBIKqc0LgaNummLDU8PidEAbyKP4c/XiaRmbV1U8fQZXRxMfSvItpKqv+/yWBNnTPfJEmqh/QWGFcriDFAPdZ/op4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHFvcGFyUjlxYUlnVk80MjVwNXl3SHM3eXU1UXdBQkhtdjIxeTR4Nm1aYmMz?=
 =?utf-8?B?QnBlZlo0WGUxVi8rQVR6eWJBYUtOUEVPUTc3Mnc4ejEvaVRsRnpCUnZHcXMv?=
 =?utf-8?B?c09nTjRVYVhBZ0crZkhWVFQ1cXRIOUZFQzNxcS9iTjBzS1lsdmZIc1RIVjA5?=
 =?utf-8?B?VlMrWHBjeklSU0hWNmg3VEZLdElRS3dIbDhsRldGZWdWNFowZFdxNkRUeUdk?=
 =?utf-8?B?TDVkaG5NQUVSb01UM28xWXBqZlpIMGQ3bzhsTFBVdFRpMXMwcWxhNm84RlR6?=
 =?utf-8?B?SG9Ya2x4dGdESGY3aFFsT2RFZnEwREc4dEJhdzh4c3VqTElMcDZHSjJ2dHZF?=
 =?utf-8?B?U0RkaTVrS0tEcWJGSkhrTkV1eVBiR29ycjRaNUY3ZVA1ZzZiUUd0Sm05emFK?=
 =?utf-8?B?eTJUTVJpR3VqMGZkZjRPTDFIbEcrdHRvK1Z4S3RZQUMxU1h5YkMxcVlwNzUv?=
 =?utf-8?B?NHlLcEhPekQ1ZVluajRwa1I3V0U2MllseU44RnpTcG0rV0dCbTVLOVhXckNu?=
 =?utf-8?B?M1dNVExHUGF6OE5IQjhlazZucHQ3U3puVllTZmY3SDh5VjBBZSswaFhXNVgx?=
 =?utf-8?B?TmJ3VmxsY1QwbmdscFgwdUx0THJoeUwxQXNnOHNONFMxVDc4VEdzTzNNWXd0?=
 =?utf-8?B?djFsZXFUa0xvV3FSdlNiekFlaTUza295UDkyQW9PQTllYTFGS21RQTBnemta?=
 =?utf-8?B?Ny8vcXMwSWQxcXNnZTNLekt3V2VGdkhpR2g1ZURjOXFPSVZoWkRGSGszZzZP?=
 =?utf-8?B?TytWYldtZW5mbkh5dDhvS0pSSFpQOE82NmtGaUZVOW5VSXR5TlRVSlRSWFJ0?=
 =?utf-8?B?dkhhOTZWb1cyb0x3Wm5MbGVNeEUrTW5oSjJqL25pOTk3MXhUR0FPNlBJaEhH?=
 =?utf-8?B?UWRuczkrMkJscys3dExzcEJqTnp3UVNrdU1XNGdVUk1JeEQ3a3RXcXlSLzdr?=
 =?utf-8?B?eW00MmZIRzN2b1pZQkhBUnZxa3Z2ZFVmbnFCbHVMbHZlSlhkTS9nTTFPSXVm?=
 =?utf-8?B?VmJ6MEVNZGhMNEdacy9wT1hnMzZZNHRLd3ljUURTVmhjTFZIMHVDM2MzK0Nw?=
 =?utf-8?B?UjhoeStVOS9EQlIxbCtpTytFNGIvRHpOVnlURWVBaXliZFRMbm9iZ3pJK2NV?=
 =?utf-8?B?Q2luN0ErSlNJaWsxTjVMZE5uMVBUQ3NvbUZMYThyMW9xOHJidWZzSEhHZ1NZ?=
 =?utf-8?B?b1krMm0ydHZ0T2VaZHBNeER1ZWFTTU5XSk5ZWmdtWWQzbVJPMzNEa1JpL0RV?=
 =?utf-8?B?WnZtd0pJMzZ3UDlqdE9mSXk5ZDQ3Vkl2M3JYRldtL1dMMC95eW1PbXNnR2pV?=
 =?utf-8?B?ci9LaVRSNDh5dW1tMWNEQ0lZR2E2NG13cnF3dEhQQTlQRWFrVGhyaDhCY3RK?=
 =?utf-8?B?Qm85VUtrTDlISVB3MnN1YytpRDNoMFR1cXk1aTlqRDMzUmg5OEJKRHVTeVNi?=
 =?utf-8?B?VERia2VsVTRYZks4MjF4K010U20rT2drbHRZTVl2ZlUzTTlPTTVpUjQ1d2Nt?=
 =?utf-8?B?QW4zZXo0aEhmekszNytzbmZ6Z05lWXk4S2JPUU0xWGwzMzF2bFNTQmZRWWNy?=
 =?utf-8?B?dlZHTGlSNTZGamlsbGZCTjVZbGV0M2RXbzNsVHhZbEpvWHBHUXF6ZWtLK3VQ?=
 =?utf-8?B?T2lDNHkxazVVNlZZWFJSMms2a3ovQmV2TmJCR251aWFsRGNsSitGeWhvNkdh?=
 =?utf-8?B?c0RITlIwRlA1Rmltcmg2SVo0OHNpVzI4dm9xYW9Fb1BhdE1qbUZBOGVQRHMw?=
 =?utf-8?B?NkZHRk10N3FEUDhGMnFsS25hVWdkUHVSM3ViUy9YMWZmUDczcHpSR25mTk9C?=
 =?utf-8?B?UFBvcTY1bGVTUGVrWTgvZVFDdHQzSjNieE80OHluVkhhNEIrcS9nVWxFZTNW?=
 =?utf-8?B?MmY2WWhCeWhHVkMxWGgvNFdwWWFlbHd0N1laUkZpaXFSK01nSlhkZ3Badml5?=
 =?utf-8?B?cVFmL080SGZqcVNlRUlMV2dEY1c4UEdjRFZPTjYxTFhRMXZsV2MvL1IzNmpr?=
 =?utf-8?B?M0JkSU4xVEJVSUU0TU53RHdEUnNNdTZ2S01DeTZmS1ZING1WK3RsWTZhQ2lt?=
 =?utf-8?B?bUhxTWowUjNiRTNHcHVEakVDdzkzNlB0cjdDTldGamsyUWpXSXNJSytEc2RD?=
 =?utf-8?B?R2JsRjlSaFptWDFKQmNnSlY5dytCSS9tTUtDMTUwVjUvZ053R2l6V01GUnYw?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fac9966-05b0-4594-97c5-08dc59aa1e4f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:03:56.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdg5j6wqNtNmjL02gDszQAjwhQrFUsvALdmIW77KrKLx27KeOfSO8UmWmtGqKfSrydlnrXRlwS1pzLjrpLJph5kWCk0yqGJw+J7Yn9SJDHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7177
X-OriginatorOrg: intel.com



On 4/10/2024 12:58 PM, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 11:29:57 -0700 Florian Fainelli wrote:
>>> If we are going to be trying to come up with some special status maybe
>>> it makes sense to have some status in the MAINTAINERS file that would
>>> indicate that this driver is exclusive to some organization and not
>>> publicly available so any maintenance would have to be proprietary.  
>>
>> I like that idea.
> 
> +1, also first idea that came to mind but I was too afraid 
> of bike shedding to mention it :) Fingers crossed? :)
> 

+1, I think putting it in MAINTAINERS makes a lot of sense.

