Return-Path: <linux-pci+bounces-5203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4303188CDD1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 21:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFE51F804E4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 20:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56221F95A;
	Tue, 26 Mar 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDhLvrQB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AA3DABE1;
	Tue, 26 Mar 2024 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483525; cv=fail; b=NnAm0cFv/1k1deDIoDD2mz/FD0X9F2072DZz2yuivdAaU0Q872QZcNK3ogY1aV59i0aPVytJuXUZfrKcl3hhRLdf8OY4pPIoDwMrquw4u/9pzlpWJ1moPaD32SBgqtsof5drt5Cex4HUV3DSTPN2CPrj33iFG/Bo3JnOVASyRns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483525; c=relaxed/simple;
	bh=WIxwQLhFhyHSCjl9kveZefGbw2fNi/PhIE3m4XkIxfw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Riuwr40h63eh+nR1laF51fe8F+1qizYu7MT/49nXxv2Iu5ZVdKkeZMBReKFABkFOk8LW30PmE7F46gDtXOGZHWNelYQ13cVMYUX6AEciiiHxluZhJK7phh+pJdcdU794L29ceqTQSKK7R2+VX5g71VcZ2DK3PXHtMf5ItLOpszM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDhLvrQB; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711483524; x=1743019524;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WIxwQLhFhyHSCjl9kveZefGbw2fNi/PhIE3m4XkIxfw=;
  b=kDhLvrQBmcVOOyJZSajbGwcIJ1gnGY4viEdV+0ub9j8fMm8PduvixVd+
   erTATs5FdqIyDootmn35gdrJdDhgxAinoz6SS0v6VB76nnsjwYMzkKnCA
   WdoyUDito7/Hrlxa9GLrc4QV2Dfb/HxDpJ4bb3Acn/zg/0FsviOnvNFnC
   bVf4xdMlGh+Ei61+Q1hK0I1PC9f68rljq24o6E78c2Fsex5jpxXGV5lfU
   gepFAfKGUsp+36AvO7JAlAv/1Pgt4jlWooA9YY94TaCSihUx95e8PcLEd
   5vAQmmObXWk+T1sA5ji+C+bXhIGuM7u6sms0a1KdQWMmZmEhMz2C3iElG
   g==;
X-CSE-ConnectionGUID: YoSt2logT9avuBQRD8zZTw==
X-CSE-MsgGUID: fJRp+fEPS6qoI2kUbtZFUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6498311"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6498311"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20712030"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 13:05:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 13:05:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 13:05:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 13:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVsHKli+x6DWJR6GuuulqtS95EC1lqw06nfbxgthv1Dco3nomja/hJ3y2NNqZ0aRu7Ys52svx4SvtgMb2QDCoyIHjl7Oxc+uqfFknviDnHOhEDK5KPJ29mk2ICGHB/bIDFbL8+ZiPY6VO2DBEAwPMPCdwbJJW2qyojF0PnMNF1ZIIa1W8tKLDEOcs7CbP3PcUeCzfyvzd2S45oPW3JpiRUlXbLnjud2IlnW9liSBUcrUtrugezF+je4D7v5L+BA/8/uLHUHBIipWMapY1um3czcNanOHoYbemH593e6QyDDyGcOVhRRKGyfmOLWkCJqVtTAI6YQN7KgjApYy0r5twA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IXJjipbfen+CuiNGzXzRXpUXMzDvh+x5c7WuPy6Yl8=;
 b=KUHeJRMA4SRNdWh2czyCokBXccHwbNcNTOUIySQ9nEPXcJ0xFhN+xpIeCsJCt0kb7/y4mQm7TK4DfWULbCEYmPQe2jROasaPCW5+aBzOtaGuxbWAH8gYOPHHhxlJMo2BIRR1I8/6XEBN8P+YSsV/32Qy1ZblEYgLKeY+ow/5x5uok3QOhmBfiyi/fQpR4Iw53VfGmQ93f94mjKuE4/W/HAWYDsGcouxoaOAP0Mv2sFZoM+AdI13+U/KZLcWYLXgP+XIdJgfNYfmvNQgwB9HWLF5tlyRlAh/NvBQjys5lBA/UTmlfKVS8H/RKAWXTv9TklH5P+Yj5AiTodle/X6YeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7113.namprd11.prod.outlook.com (2603:10b6:806:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 20:05:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 20:05:06 +0000
Date: Tue, 26 Mar 2024 13:05:04 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: <y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>, KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
Subject: Re: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Message-ID: <66032a6fe9e01_4a98a294d7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:303:dc::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7113:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hah+HZ0+h+ZNr4lFM/nvpfkOCxp/MgCjZbIFyDXW8s8dgZ4Kgdf6u1KaywbewWSWgip5BmbNOPCiWGMuusHg80AsqWDWVUhggqKTED8PfmijKq1uHJXnXC2q+OcjAFDuY2emN77yqn3cu1GEP8+Gl+32UZN3x+J8HfibKsk6/JDMceZ7nfsrBVLhGLuEbL6//daI8cW75iMzvrdrREaHwuYVj4zM+EUQNzl9nss1Br4cRquBITRfc92+phR9PSjcbWLp7BDSPRhhkjH1lD8CF9lCKlnRVn/rd04V6jIgBvNwqTHiN/qGhv2X8O/t18buZkXtSkiqY0wEgk8R20gU7hMsA7OusXb54V8MQyCVCLB0FRvqw48mafCuaUicu9R/lyitf7xujVlfEfC2DLFfBxU8gvKe85S8gib2sVA4Bas7OJZTZu+ia5l/CVs4wY/lQFDN2hBZUyPgzqyXjw6Gsl+952xDKnqHhVYx+njgYJ7VqpkrFxpCwWowwS0mMx+Ve9PGK5995xiQJ5pcV1GeoXRuXWY6jvxV9jYNiN0V04+wueQsj3Y35cbuXngklKjM3BjiIMJ9xtq5JyBrZsqkxoHtrUEOs3r5/uUVWbAnEuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVdHZXZBdW1iQlltcmhRdW9QTENNb28wOWE2dGM5ejNPRGlDV01VbFBXckY5?=
 =?utf-8?B?Z1RaNUNHcHQwZjI0Z3F5QVp6UHFMdk1FRHh3Z0ZCdG8wRE5tYjJmdmFGYzJ0?=
 =?utf-8?B?ZWRKckNueTBJMktHWTV5WHQrOGJISjk0L1NBTzJxUXhyWXNzaEpyWkFPZ0ta?=
 =?utf-8?B?YU85MFVydVRGdzNaT25UbDI3YnNNZUZGeXRSK0JiMjB2RDhSZ3Rnaks2M0Jp?=
 =?utf-8?B?MStOYndrUTRxNm5SRnJ2ZUJsNFd3TzI0OGJqcGh2NUwreEpOOE9xcS9qL2NY?=
 =?utf-8?B?T3BDN3BhenFyN3JLeWxDSnVzWldSdHpEK3BQbUYwazM0K0Q0UzV6U3liY3da?=
 =?utf-8?B?UmI4VWhpYk01ZVJWWmczZGkzdk5kNmI0cWt0VmdweHowM0wrTmh0RGgxSUYv?=
 =?utf-8?B?SGNuSmM5YU9kNU8rT21aL1ZQTkNsMW0zR3FUWjZKVWhzMmRSYWdRSTJ2d3Ra?=
 =?utf-8?B?ODZ4eVB5RlA4c1ZIbDVuYXZ1NmEvUStiNkNyaWMrVGl5aG9ZZEI0WGRrdXFx?=
 =?utf-8?B?a0d5VG5scGdEUlJscXBaeEgxbkY1cklwalpMUFd0RFErbHFFU3ZuZXZVcjM2?=
 =?utf-8?B?c3BadUsyVmRRYm5ZWEg3Tk9pcEtSeStISnF1Z3U1Q1JodGhUK0MvUldROUxF?=
 =?utf-8?B?bTVGVUJkOUlCRkxhRXVFT0FKWkVpYVgvcng4WmM3QzcwdE1SQmg5b2puQWhr?=
 =?utf-8?B?VGRHZ0k0ZmZtaXpoTzZMOXQxMVp2OUhXV2k1Q3JCdlZpWGtnbTMwNC9SUE9z?=
 =?utf-8?B?SkF0Y1U5MG1yak1KaUZSY1R3QzFmc1RXT1lIcUlXUTZvSHJDQndUWnZHY2dX?=
 =?utf-8?B?eXdaR0NSNlVpSDBnK0t4d2ZuSTBJZmFnaTlaaUVjL3lpaS9uaTZwbENGbmkx?=
 =?utf-8?B?cVB5SE1nY2dEZ3VodGpQZDRMZG9UWlp5a1dCR2E5alNBSGllR0g3L1laaHMx?=
 =?utf-8?B?U1FQSzBjNjdNVDNRS1VPQWJDVzF4QlJ5bU1Kdjd3bU8rY0J2NXcyTVpZRU1K?=
 =?utf-8?B?ZXA4alhMblVOTFJxSTU0ZkpwU2lXSk9qQmYwbVNTa1doTnZFUncvbEZTaWlk?=
 =?utf-8?B?K1Jlb3ZmaXdUdGlMcy9vRWdKcFFRd3d1SHA5dCtGYjZzbTlORHhFWHBYRFNz?=
 =?utf-8?B?cWdWRm41Y2tUTGdINEt5eW5YSEFGdWwrSzd4L3k0SWVUNzNndDJSd0lHZnM2?=
 =?utf-8?B?dnpEdXhpYTFKQWY5NE4yYmZOaVBnY253czhEK05YUFdndFF2M3Izb3ZWd2NQ?=
 =?utf-8?B?ZklkZ1AzaVkyZ3VqL3RnUkFFTWgrMkxYekhuRWt0T0RIalBCZW9sYzBDTGow?=
 =?utf-8?B?ZTNrK3Z3MWkzQm9wTTdvZnNvR2FuWU5XYXo5VjRlMGpxWkcwL0w2REZucFY3?=
 =?utf-8?B?UnpuR0xqVFAvemY3U00xOVdqOEM5eGRUY25YUWJ4WkppNi9QZUtRNE5qQTZy?=
 =?utf-8?B?MzJlNlB1S250dmcvS3d5NFNoeDNLYkVBVGR2YXJyT3JveWlXc0xOQVZZdHFB?=
 =?utf-8?B?VWFZMTE4aGJ5VG5GSzdzckp1dFExTVI5eG9JRHNueEpzU3V2eURKQ2xXY1ds?=
 =?utf-8?B?NWhpLzhsc01oWUFvbnlkOHJUeEtQd01oZFEwdmY5SmZTalRucHVicTd4RWdS?=
 =?utf-8?B?WWF2Z3hsU0RzRTFhd2dBdGp3N2dsNHBKUDJteCtHbll5aEM5bzNmTlNHSm1p?=
 =?utf-8?B?dEp6TnRhcERHeC9aNngvMWdRbXY2dmdTcllPKzg4NWJnRlg4OG9KR2dKTWgr?=
 =?utf-8?B?K0Z0R2NCbEJ0aEtLMkdRQ1FWY3AxWWJsd2JiM1p0MUdmam8zb252VFRHYjNh?=
 =?utf-8?B?b1A1VlhlTTA5RG44RTMzc0RuZHhJNjFVdlFiNG4xdDduTWlqT2RwUE56MU51?=
 =?utf-8?B?T0ZsMTVRWWVyRUcrb29YZDNzbnlOcVZsa1VyMWFTTTQ1RXFDVTFITGpBSmRE?=
 =?utf-8?B?WEZ5b3l3WWZvRHNGY3FySzlVbE54aTAxUXRabDZOdjB4Mmk2bWJ5WGRYMXA3?=
 =?utf-8?B?ZlVJTUE3SjFpTmJiMlVTUkhZcE4wMWNtei9DN2dFK3FKdGE2T2JGeUdpUDNE?=
 =?utf-8?B?U3I4U2FKSFdad3NtbHpGSEFpaC9uRzJ2NHAraGkzVGordmhQajFSbEdXY05E?=
 =?utf-8?B?M3FwUnJ3V0NzUkI3TUgybW1KRVJSZU9MaWIyQmJFaEJNU1I1ZFdZWDhJQ2RC?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba2155b-9efc-4b0b-973b-08dc4dd007ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 20:05:06.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vo+iL+fhFYtUuuERTXRBM6SnUvI16Gl03+qz/p/m4jZ2sUm3s4cCPZaHGo4sL3NRRrTdpSDxDESF+4SIcm7jynVPFDOi0mE39K9hIpUsUB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7113
X-OriginatorOrg: intel.com

Kobayashi,Daisuke wrote:
> From: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
> 
> This patch adds a function to output the link status of the CXL1.1 device
> when it is connected.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. The value of that register is outputted
> to sysfs, and based on that, displays the link status information.
> 
> Signed-off-by: "KobayashiDaisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  lib/access.c | 29 +++++++++++++++++++++
>  lib/pci.h    |  2 ++
>  ls-caps.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)

Including a userspace patch in a kernel patch submission breaks kernel
patch management tools like b4 shazam:

---
$ b4 shazam 20240312080559.14904-1-kobayashi.da-06@fujitsu.com
Grabbing thread from lore.kernel.org/all/20240312080559.14904-1-kobayashi.da-06@fujitsu.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 8 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
  ✓ [PATCH v3 2/3] Remove conditional branch that is not suitable for cxl1.1 devices
  ✓ [PATCH v3 3/3] Add function to display cxl1.1 device link status
  ---
  ✓ Signed: DKIM/fujitsu.com
---
Total patches: 3
---
Applying: Add sysfs attribute for CXL 1.1 device link status
Applying: Remove conditional branch that is not suitable for cxl1.1 devices
Applying: Add function to display cxl1.1 device link status
Patch failed at 0003 Add function to display cxl1.1 device link status
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
/home/dwillia2/git/linux/.git/rebase-apply/patch:117: trailing whitespace.
    w = (u16)strtoul(buf, NULL, 16);    
/home/dwillia2/git/linux/.git/rebase-apply/patch:130: trailing whitespace.
    w = (u16)strtoul(buf, NULL, 16);    
/home/dwillia2/git/linux/.git/rebase-apply/patch:158: trailing whitespace.
   
error: lib/access.c: does not exist in index
error: lib/pci.h: does not exist in index
error: ls-caps.c: does not exist in index
hint: Use 'git am --show-current-patch=diff' to see the failed patch
---

...and this patch should wait until the kernel change is accepted before
being submitted directly to the PCI utils project which does not watch
this linux-cxl mailing list.

