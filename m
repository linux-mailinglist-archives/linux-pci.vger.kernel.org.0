Return-Path: <linux-pci+bounces-5931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED6189D9E9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DAF28149D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019812E1F0;
	Tue,  9 Apr 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrfDtLtI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5C7EF03;
	Tue,  9 Apr 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668410; cv=fail; b=uGkbYSHYqXdJurjuQw3ulAZVzXDFzrI2iuqKDqAHlQ9ICDiMVL2T6lYddJBzQQuN/2Hy4WjCqTcIOGmvATUxDOnOqMGcugzGAFKneASU1PJahZXmnMMR+/6FdhpiPLJiCViSQ1RjoihzPEsAniBMwuSOu7lSKaw5L1hdSGMNIdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668410; c=relaxed/simple;
	bh=gR53o5Ti/S49eEae+DIIrVWoJxzcfYJGJyVzrFwwzfc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r6ZUmp97kMMMsyG5MHyGyWK3jp6LDLTQDAphf+3vl0EM27tb3QHAy9CuMnqmGhlO7UiTlurD19aunCrwTG+YjZiBm0lwLihyMKguhtVI2MEbZGUSlRL9UEFmtWxL0xFnybRUNZ5XTaDwUs+Kh+/BRNxgZQ1x4PKf+yUGRUXPuXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrfDtLtI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712668408; x=1744204408;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gR53o5Ti/S49eEae+DIIrVWoJxzcfYJGJyVzrFwwzfc=;
  b=DrfDtLtImWAG6Iggpiy/tPI32kEILFdh17/mgfFvUOuJR2kgNYLmsGuM
   xhXLKz4iZLlF68xmvRowXI8tvPQfyFH/YzLhYE8qBRJbQGA/5OS2StT1n
   pl03THQMJU2Hfkhh8dbD4VimYODLtouzZU9Zt8iUgYHsD20XAiltOc23I
   B8ajhSamOVONEn5Hlo4nNRk/fWOOcgoNCNsaFbE/WP6zIOjg8LuwrCttH
   Ncnk8LhUJPz8rkl9CDm2zYf+G3ME052lDBE5tzHHz8NC8ryL8G1Bsiyvt
   BqXDNzEcn9N8SvpdFvhIJnn9ecL0QYsQtRutBQNtx7ff4tZCH8uABUytT
   g==;
X-CSE-ConnectionGUID: aC4gG+7gRHKfKRhCbxVb0g==
X-CSE-MsgGUID: VwOB8Vq6Tiqupq+Vq+uLCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8554294"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8554294"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:13:26 -0700
X-CSE-ConnectionGUID: KBBDLJ+AQAyViIxfbYu6Iw==
X-CSE-MsgGUID: hYks9dmxSD6stcTsGunFqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="51218025"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 06:13:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 06:13:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 06:13:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 06:13:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 06:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azAYB6PGJn97bW+s4xkqUXRkrD8hOOilA52Y//q96t3M5li3xzc/tGWgAVKPQUUs3JMHgoQ8QwjuRT+iwpGfoNXhpzyZTWl/qsi0BUvT1YIjsPJTTUCRVuq4wtYoGw7noWCog0mkXapwvA+qqsXvy7JgLw6/d1VPSO525YPuW3j8KOPEM9lRweLEgVQ6XAGz01vnk/C6tTHcx/cv81qmsqZXimhfmqpPrFcndmiqKK1FCN09AyYXA4h8iekWx5FSrL8DIv4hLUNM9ZuoM+iQZR2M65yh9fE1hgfUNs+97c+W3FYF97AbfZPHgLcuhYwpvnuveV+6WtKWiTADb/BieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/ljh2oLCP2rkbS4qb9/+BweBHwDJ++ZEBcWBF9NTUk=;
 b=Erqo7IqGfOidiEkK5RmKXs1550f4LKPXx03w8J/tBk8zlGYNsKk0r2uYHlE7KgYkbSS6pKFOif55IWFb5Zry4RCj/9DY6biYcGUprqwR+snAZWoEZ8QA851mNBjdea8Z4yIPYJ4JhvLRAbOXGtsQZdBRTthvN7bBG5UhsPvu1T1bqbe574ebVSZSy9pi4JRij2xoRPE60utTeBUrhiMT2CHA4+fULHdefzXbucES1HsLxqk6asEyR2zCeRnsh2mTQbOEad+H4ap3OShIAb5mMjWO0AqAOv/o5hKlZR/DqE6CYUdcmHzcNT/Nj+mflQ+0v25Esiwc/P5/tfU9nwIAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Tue, 9 Apr
 2024 13:13:23 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 13:13:23 +0000
Message-ID: <9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
Date: Tue, 9 Apr 2024 15:11:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>
CC: John Fastabend <john.fastabend@gmail.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, <davem@davemloft.net>, "Christoph
 Hellwig" <hch@lst.de>
References: <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho> <66142a4b402d5_2cb7208ec@john.notmuch>
 <ZhUgH9_beWrKbwwg@nanopsycho>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZhUgH9_beWrKbwwg@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6798:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbRYVLghygth5ZuEqSCtSfgpQtVdzeBLHW+AgJ+oLeBR+MdI0HAGuLfucqwIgsDJXYN/HI89+HTlIv3tiXfndFo9rGkFHyoA1ApzLLHeDwv1kmFrJVHwbfpwIhNnBSerin8uKmyr7hcxEIKWad0DAoG+m9yEEqvwF2xLG7THJt4IknLSjTjEDY3QpW2BHFKTaMTnqgq+QjIYjM/6foZTNh+DqHOq5tJlOw8bNMnM1AhEfKOUTGh7nu8uX+wFSjZAKB4Ge3BF9mvSM39bIVrIvvrPmkaDv5VyevjwWHZHUL2xnzJxA3nt6S4Q8EpAB+CCiEO1RNqcpvX6haScr3wfYxqb4OPKHByScwp0ZTDKfJDXeAuFz/qKfYh6GRWApsLG9L1n3SrnPnikxumPDpNR9dSJAOv98UHAGXQoA0ooTCMDfOOU3NEWjk+hB5tP5HD8nlRynriBYNNFWsdLLbP7G0zBKSWMCaVOz8qRnYFqPtyFZkCl0+0xt8thAuFS3m2oovSoQ5kEjM+6F43clw7SmbznFBgEqAwQtRVGdUOCY3xPLanzqmWxXgS5TKc49/5WOEoWTSXBhUXqrFg8al8k+ZQBQJWJodMXHbNlwG4EcbI0yZe78HgxfYHu6PThzdT5Ok2BHrMfCLK2jucBupZPR7H6gceMtT5lKC9v4nBm/40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L21aeDVkVVpLR1ZEZ1ZFbmZIOFVvUnNKblZGK2FDSkFCaFNoV2VsYVpOYzNJ?=
 =?utf-8?B?VEV4TkFMWlZVelN3cWsrVHlFL0NLbjJSbUx2K1ZRS21MNlFJK3VSWHVvaXJ0?=
 =?utf-8?B?QmVYTThqRlU1YW1XcmdkczU4MlRMR2Z6cE80ZW1HZEVTcWZUMThsTlREU1RR?=
 =?utf-8?B?MVBTb1NLV214czBldDhlbXRDaFNRSnQwb3hNM0tvMURyNE5xNEp5VE53WHpJ?=
 =?utf-8?B?cFRpZEU2YWpBSDlIWW5nUXJ1S0VTWFBRWXdxMkw3ejZzRXI3VDZGQ0ZBZllU?=
 =?utf-8?B?NHhDMDJZelBOR2JkZ2QyU1JWblU0d0xoZHdLRE5STzVhYytUV2d3MVBmWDBZ?=
 =?utf-8?B?SFhycWFaNFVkT3dJVUkvSjg2Z3dORjRLUGRqdXFyKzJON2g1NXRMME1qVXQz?=
 =?utf-8?B?MWZYRDJGOG5iVG9NaEhSQ3BnVTVuQ1NVbGJOdk1URUJNMFREL1pZcGgxQjJz?=
 =?utf-8?B?eHhFaUZTc2wrRTZZaDVKWkhFZWltckE5TXRJK1FIWGFEZjZvNmNFajZzVVZ0?=
 =?utf-8?B?NTVWQXJ2ZSsxOU1ZYmR3WHArTzNIa3dzUklNMGxmMHRZNEk5NlQ1T3ExMEhh?=
 =?utf-8?B?NDRZVDQ2VzJhcVdsT1dXbzFxamlKeVhLZEN3NWN1ODI4d01xaEMrK3lpRG5P?=
 =?utf-8?B?Zkx5RjBRdEo1dy80SUFCU09EaUpzUG9JaHVNQ0sxLzN3b1Q0SWVBM1J3dHNk?=
 =?utf-8?B?ZUpFWlYyQlZhM3A3SmVwOVBFYXFNYjJnUFFkcFpGSWZYalFSUFI5SC9yeXhW?=
 =?utf-8?B?SkZ5NVE0cTU5SGdDSmt5YUt6WkpjaUdSR2Z5c1hERnVrTUVXbkNtWUIrb05K?=
 =?utf-8?B?U2F2SE9yekxjVk5Ucnh0ZnJMdE1OL3BBemlQYW5iU1ZURlFOSzFHQUduN0FG?=
 =?utf-8?B?VkNYUForZ3BXTUMvMlhWaWJjRnAxZ0VZTFhKME5DeUFNajkvNTFQR0lKR1hw?=
 =?utf-8?B?UWhkVHRjOWdaUkZabXFFWVBlWDNvTm9oTkhtS01qYjBqS2tUeHlBUUdCMGJS?=
 =?utf-8?B?ZlFhSjZYdHlvUllxTWFqQjhSUm5Wb2ptakw2dnNqS2ZVazFKWWRtbkpUamNk?=
 =?utf-8?B?NzdOdVZrcUs0MzZPUWdXa2lyaiswYVoxRGhCSXBFQnZSMU1lTjNZT0J2Y2Qv?=
 =?utf-8?B?SlUyWGZjM2s1NlJqMTQwZGxBMWcxYzZMdEQ5OWxiWlFybGJQWnpySk5sQ2pW?=
 =?utf-8?B?NE5KTGgwZWVDNHVVZ3NPY3QzTHFlVVpONFI1OXA2WFl4dUhWTE9DMDExV2J5?=
 =?utf-8?B?MFpTRGFka01PTVc4eG5BMGF3MGVpNmVBYWUzTkVDYi9vSm1GbkIweU5SbHRP?=
 =?utf-8?B?ZVZiTENMQUV4YVU4SnhXcmF6cVlQZzBzL1IybVI5dmZzVy9OaDVDUXo4U2Z2?=
 =?utf-8?B?aXVXbm5lMUVVajFtVFVTb0NFN0hzVElpMTVINDVDUVFUZ2FKRE1FNWJvME1E?=
 =?utf-8?B?OS9lUUt3L1NRZXZUNEQ4eWV1b0xWSVFIdXMraEYxT2FtWnpGeEMrRTdGeUpX?=
 =?utf-8?B?RnZldU1jKzd6K29xTDZmL2NMS1dpZ05pVGVXc1lkaFg3ajNuNUE3SDJqdjlY?=
 =?utf-8?B?MHMyTDNPT21acmNFWCsyY09GWHRIdnNJM3UxREFmbW9HT2hjWDBSM0hFdjN3?=
 =?utf-8?B?SHZCTG16WWNRbjk2eTdZZTU2VHMzQmVQNDhRQkI5STM4eGNqdnF1aHdNY1k0?=
 =?utf-8?B?U0pZRHhYU3NITm0wY1Z3aSt2QURIelFRRmFkLytaTzk4eXo3RHRqcHdnWVpu?=
 =?utf-8?B?eUp3RFRoOG9tOWUrYzRTWERDT3Q2SDF2KzBCVFRIOHlZT1IxeFJaZlhab3Zw?=
 =?utf-8?B?UkNWeW4vdHlKUW05cjBCSEc5enJHQWpMUm1XV0RFKzU0NzMya3FXWlFOSlRY?=
 =?utf-8?B?MkxKV3ZvaVpVdEdTQXg4dWYrdFpmc2JTK3p3R1REbHE3NmVvSmo4eDRQMHk5?=
 =?utf-8?B?RElTOWREMjg3NmFXelEyQUsyQ2ZwSXU0TFU0dHQ5UzlUeFRXVmVXTURlSmFa?=
 =?utf-8?B?eFpuUlBob1FhQUtNczJvM0x0Nm5nQ091SldDdk5ad3V5ek1Va3RNbjUyYktE?=
 =?utf-8?B?MXloSkdqbk40WUhMS3IvVzIrLysrV2NVY1hJaVpwZXpDU2w4NThmeG5jVHBz?=
 =?utf-8?B?VVo3aVIvS2VKY2l3SVV0am9LN1NDekNSWkV2VUJVd1lHTGdzWFE0REJSTnpK?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c65e08a-6537-4ff5-d384-08dc5896d5b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:13:23.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5a5l6NBqKpDZH0VhsEw9CO1QSdy2rbbPe8XDd+u5tQyYBM0bDUAGDriEfgocQ5e5gce2vgY3Y6yDOk65K4XxEQt/+VDXF0fi1Bnib4k+KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com

From: Jiri Pirko <jiri@resnulli.us>
Date: Tue, 9 Apr 2024 13:01:51 +0200

> Mon, Apr 08, 2024 at 07:32:59PM CEST, john.fastabend@gmail.com wrote:
>> Jiri Pirko wrote:
>>> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>>>> On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>
>>>>> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>>>>>> On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>>>
>>>>>>> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>>>>>>>>> Alex already indicated new features are coming, changes to the core
>>>>>>>>> code will be proposed. How should those be evaluated? Hypothetically
>>>>>>>>> should fbnic be allowed to be the first implementation of something
>>>>>>>>> invasive like Mina's DMABUF work? Google published an open userspace
>>>>>>>>> for NCCL that people can (in theory at least) actually run. Meta would
>>>>>>>>> not be able to do that. I would say that clearly crosses the line and
>>>>>>>>> should not be accepted.
>>>>>>>>
>>>>>>>> Why not? Just because we are not commercially selling it doesn't mean
>>>>>>>> we couldn't look at other solutions such as QEMU. If we were to
>>>>>>>> provide a github repo with an emulation of the NIC would that be
>>>>>>>> enough to satisfy the "commercial" requirement?
>>>>>>>
>>>>>>> My test is not "commercial", it is enabling open source ecosystem vs
>>>>>>> benefiting only proprietary software.
>>>>>>
>>>>>> Sorry, that was where this started where Jiri was stating that we had
>>>>>> to be selling this.
>>>>>
>>>>> For the record, I never wrote that. Not sure why you repeat this over
>>>>> this thread.
>>>>
>>>> Because you seem to be implying that the Meta NIC driver shouldn't be
>>>> included simply since it isn't going to be available outside of Meta.

BTW idpf is also not something you can go and buy in a store, but it's
here in the kernel. Anyway, see below.

>>>> The fact is Meta employs a number of kernel developers and as a result
>>>> of that there will be a number of kernel developers that will have
>>>> access to this NIC and likely do development on systems containing it.

[...]

>> Vendors would happily spin up a NIC if a DC with scale like this
>> would pay for it. They just don't advertise it in patch 0/X,
>> "adding device for cloud provider foo".
>>
>> There is no difference here. We gain developers, we gain insights,
>> learnings and Linux and OSS drivers are running on another big
>> DC. They improve things and find bugs they upstream them its a win.
>>
>> The opposite is also true if we exclude a driver/NIC HW that is
>> running on major DCs we lose a lot of insight, experience, value.
> 
> Could you please describe in details and examples what exactly is we
> are about to loose? I don't see it.

As long as driver A introduces new features / improvements / API /
whatever to the core kernel, we benefit from this no matter whether I'm
actually able to run this driver on my system.

Some drivers even give us benefit by that they are of good quality (I
don't speak for this driver, just some hypothetical) and/or have
interesting design / code / API / etc. choices. The drivers I work on
did gain a lot just from that I was reading new commits / lore threads
and look at changes in other drivers.

I saw enough situations when driver A started using/doing something the
way it wasn't ever done anywhere before, and then more and more drivers
stated doing the same thing and at the end it became sorta standard.

I didn't read this patchset and thus can't say if it will bring us good
immediately or some time later, but I believe there's no reason to
reject the driver only because you can't buy a board for it in your
gadget store next door.

[...]

Thanks,
Olek

