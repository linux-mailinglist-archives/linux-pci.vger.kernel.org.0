Return-Path: <linux-pci+bounces-5189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0871388C854
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 16:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DA5B29A03
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 15:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E888958220;
	Tue, 26 Mar 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8bBzEAH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A013C8FF
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468322; cv=fail; b=KnjEXwIad7UfEidUaTGJjpBtZLPHTy+wlMIaazamlkpro4j5/vDDuVLr2Y5k/ySbyxotEXT+lAkBBZqruECk8EuNiPoNeSfruM6HKgPA4H0Myyt2zjCeJDP2dgBtaOr4GSGryXmMEYf+aJoy+Rpgbz5DKi9jUNnpWi03caJEfYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468322; c=relaxed/simple;
	bh=tqiYftk+H+rVOqsH2Y3mHXD6v3I4BMbm5mEwgqtNN3k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aiA+U6x5ux5eRi+nbty07F8QxNkqTD1ySx+WQ2z+bbZ5SeXZH6NQXLcNjyYJ1De0AEbDdVAlq//O1q7WlaE1ua1Pq/YThTlUZ2JLTkOpZaNjOiwi88Qql7JKRg9JjyTSdWk2u3U+ysZ1Cy5Tqq9TjhU7k10vQBeP7TYIKLbUjRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8bBzEAH; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711468321; x=1743004321;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tqiYftk+H+rVOqsH2Y3mHXD6v3I4BMbm5mEwgqtNN3k=;
  b=S8bBzEAHWgOy/2J+1gbZ/y/dtiXoExw9KJPzOtYmRHq8Aczu7z88IhT7
   A/THk5dG1SvtCrRjXFyEu+N35sCi7ME+XFN0sDFWWEOLeWziRuN+8eRZP
   CTfnOEdLMfYa+ebRYBrDm6RRf3spQkdKLHx1UVZh6bp/nTF2mEpWCSLjr
   FGaoOaP5f6p/hE+DXkxYpNB2NJl+RKdhoJ/cu5pFbEglbWRwGYqw8bvQN
   uCNTB7j/7Kkuj4FCv3GvSeq9CzkVYsU2qM2bFhyQuQVClJy6LL/0dfsCD
   fwGsK53avnNYoXAOtobEoPQfQQjQXbJdIllg7+q5pxQfZH/ia9UTG+4kG
   g==;
X-CSE-ConnectionGUID: KurC4syVSg2tXjw/lt2QCw==
X-CSE-MsgGUID: AskW9q/fSXmRf+VKSt2BVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17159975"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17159975"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15992416"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 08:52:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 08:51:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 08:51:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 08:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdyrUjZBZlx7C2gyFoOljJVDlzDSDhAp3qBpDKylHSZwCDz1996CZxWm6dNEPSDQXNrp4LdIJUckBRe8fksCHWtHpRAplKFd9Z14lLl7BVojk7pH1PEk4wMGIR12KScr8dRvyTCEoipnq9Hrx5qmvSzWipXNmXTN7HQr3XnG61Pe0FjgZCW0hJ7K33Bsw+RaPeX5MMgahIljIEEG2SnR38GzqW7lAUXDiB86hBLzTQwpppcVYaS09vm2YJXVR6kN8c9QhNW3ffHf+z0MgijnxLu9Zo+lw/PMn/Q+BPrVeETsx2V0O3e9mBrrjyPlnP/AloKW9VxWeBrZBIp+e8LwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwE/sRyTBLHAW+jUAEjFc4U3Ar3xw2rRoZFd1pgrEsQ=;
 b=Uax9kEWRHgle0IW/lVbQe0OfpZTD11Bws25mM/Slfmar0Wbv+co3AdkNfFxWMvytiISzlv5cNkOuT4mxjeXkslI1Mw9FtO9nlq94Kju2sOyL1yeMEoPXfiIfY/JycbzN05snDWPYj688ZsWKefiG21ZYTDXSlz/6MdSh79owD2quNjyH5umUVh1FdaX7/Z4KbwNWp0AAGhm9c23pxPHi8TV4gF3LMUjbVHiZqU9mWIBwMEBrsVv8menDXdSpnZ0mVpnPWRx5iZUIKDMZHUgkFcyuqdxXY9syeZ0Qm2C/nEIYtbTp4JCin9jHLL7yNreciZfFEbTwvYqLA0VUa444xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 15:51:50 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 15:51:48 +0000
Message-ID: <ef559fe9-f3cd-4edf-bee8-dbd2ae504288@intel.com>
Date: Tue, 26 Mar 2024 08:51:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, Nirmal Patel
	<nirmal.patel@linux.intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, <linux-pci@vger.kernel.org>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
References: <7f37506e-4849-4c7d-b76c-27b02b7453af@intel.com>
 <20240322233637.GA1385969@bhelgaas> <20240325171743.000013e6@linux.intel.com>
 <CAAd53p6JmJoGjiC5nqRbA4x6fNZY5xCyGELXj0-9ux2LWVhroA@mail.gmail.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <CAAd53p6JmJoGjiC5nqRbA4x6fNZY5xCyGELXj0-9ux2LWVhroA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|MN0PR11MB6157:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArmfDsg8OGYcpoGFRlwLJHbIAl1SX1MFmbLv5p8Az0ny18htK8tgyHMiDplC17Z9JctM8LMR99aSATlepYdObUZXMfmxqPeh+p2pGo4i+KcF0AAqB4hLsmqsBO93lkzOH8LdaWh/3/vueHr5B5o9tyRqYwsFUyXw/ImS672IENnIA4y9tM/jw6NENX2kMQzpveKBCXjWVmS+sW+VAB5xk/xz4o8MrM0spcLizLmVKUHvwyEyUrBw8T8LccehhQovRsZZ0N8Ofd0/9gJRXcEAv1LdXoC7lACvemLmrPFIE1ESrbY4hsiQvI0H1MijVxgWQWGVSl8NVaNO3oCM3+Dldx19AmOdU/j6EK0K9Mk950GoQ6imiBGjNu6Q6TgHx++Y3BTio7Io5KuwTVnl7YxXq9e5zCsV849O66lO7IBf1/bvRCe31ARXY4N++5xsruHJDyPLvPvSLylddltalfJDpNsMe0017e9RAqmggdKA1HuDr/acEFkazFCai3qYc953UMxe1h/y/X9ESNd1dxWJjYa4Ona3LAGAnSyKbDYOVGrwgU36PN+4J/fKyBzSV0yNyj1lvWCYf7W4+IGxBw3kE7YtT099wD6ZTsjA904HkmdigFMVJxBbg8VQ1zK1DpFVQH1m2McrvQ5VdRMVoV/ek8BmHkt9mZXAau3y3/kS+5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGp4UERlKzJubzZHQzlFRkVxbU52emM3M0JHd0N2WnhNWWQyYks1QlplL0ZK?=
 =?utf-8?B?akJKdFphODl1S3phYjdQZCtTRXBCWGZnczNpTkNDWkJKNFN0c2VTaVo0NEY2?=
 =?utf-8?B?WC9YRytQWHJuam1Ya2V5bmxkelNyVmlGMmpvby9pclhFYUFVeVB1TkVyRU0y?=
 =?utf-8?B?MEdoSTdzOWpOK0J5RWErQm9sakZiRmFtWUsrSkxrT25SUk5YTkJROHZ5YWxl?=
 =?utf-8?B?TTdFazcvS3ArNUFSZmZQL0s5aXJSUjZYdFdqZ1VGME4zbzZrK3RLZ0Ezc0F0?=
 =?utf-8?B?WG9zbk9hY2g1NXVIYWw5aEJYOGs2MmVwMEpYcml5NERuWnVWdjNlbW9od0ho?=
 =?utf-8?B?QTdpVE94aE9hN1NKTDNEU3Fzb1VvaThxQ09la2xUcU93U3AzNTQ1YUFvNDNJ?=
 =?utf-8?B?amQvWWJUVGV2QXFKbDJzZ0xlT0xmaFlkK3lYMHlKREx4YjVIUFRacFNIb1B6?=
 =?utf-8?B?T2l4WHk1NTYxQmJnK0ErZ00zdXpjdHdGV3Z0dlJFZ2hBQjRib05PQjhiSkNU?=
 =?utf-8?B?NmduQUludEoxMXdseTdMRlFuLzI4NjRzQmtONmVFVjhnbGx0anMySW51K0dG?=
 =?utf-8?B?THE5QW8vQkFYZ0xzcHpuTW1NV29iY2loUE1CTDUwbitzamt1dnF0L2tTVVVP?=
 =?utf-8?B?djlBMjU1RDZMcC9POUxHejNuOVRLTDN5NXh6RVpzakNFT3drdkowc3p1bmtV?=
 =?utf-8?B?bmlSdW8wVnhUMFVJcUZBTTZCR3h6WTRyajJtUjh2NEtJQTN1UEViSzZPb3JR?=
 =?utf-8?B?TCtmVVQzU1VERWN1V3UvZlNUK3J6d3hEWjZkU05idXhudWpjQUhwRkxiTU4v?=
 =?utf-8?B?NW5Pd0NVN3k0dHRvS0JNamRuVWd1RHl2eTZPc1VTRWhQMjRBLzZqWXQvbXlR?=
 =?utf-8?B?dnVKQjEzRmhvMVV2cEl3aEgzZkZYeTRPMFgzWDdRaUpBU0ZnSytRUldWdWp1?=
 =?utf-8?B?TFZ3SkcrTG14dGVnOHpjUnNzZm9Od211WndnYnhRWUI1am1TbVlsRFB4dldu?=
 =?utf-8?B?emh0VkNkWDVTaDlsZUsxNktReVVRUi9CdHV3NlhJc3VLS1k4WFUxWWw5eEh0?=
 =?utf-8?B?bDNHT0YxK25IbWU0SEtFTzFzc0tXWDkyWVFiZk9ZMVAwR09oNCt3cUJUQnp3?=
 =?utf-8?B?SFVGWDhhWU5TMWxQdDd2d1QzMis3bWswSlBoY3FkdkdHa1JzeEk0VEhBcGcx?=
 =?utf-8?B?NUhzMkRDRi92RXp4Ry92VUJVRU5qVXpYaUNmZmpSM2ZYRlRlY2Q5NHNxM2hn?=
 =?utf-8?B?ZEd3VEZhc3cxQlovQ2pRSFFMVGlFbmVuc0pzZW9QRlozc0RCNWRLMDZ1NWRJ?=
 =?utf-8?B?N1ZIeExHRnhvOVZ5dmQvWDJoVUlOZUVDY0VNemd4dmppSVQrVWlINkRjRU1u?=
 =?utf-8?B?NERrTWJHZnFrSlVyNXBrTkJiY21TTWVMeG5odHkwOGV5QnNrQnVGaVpvRnZm?=
 =?utf-8?B?ZDJSSUR3ZTV3NUhnNzVlOWZMY0xpWGIvSC9mK25SWFFsZFhjUmd6NFZJZmVB?=
 =?utf-8?B?R2NrRWdJclR2ajd6K3gzb1dhb3l5Y0kvR0JWRFNYSlcyK2wwelJMbWY5UVMx?=
 =?utf-8?B?ZGpxU2xzQVVsT1lTZkJCRzdRcEprTDZ0WU83NEwyaG5ZdXNRdGNWZHJMVll6?=
 =?utf-8?B?QWF0Q0M2WldWSFVkK0xhOVlJdlY4Y2h5WXJyTmEwYTRJN2gyN1djaERwME5y?=
 =?utf-8?B?K1hQQVJBR1BsbGFkdkhIZFNTSExDQSttWHlPSm9UamRJY2QwM1djS0oxUUZn?=
 =?utf-8?B?bWpGVXFMNFdBa0FTbUZiVTR0dldUTnR3WHRJdkNqZ29lc1JldTNuZTcxNzJo?=
 =?utf-8?B?SlJFdFpTamZkeTBYcGM4RlpsOHRGdG5LNzUwTXpObGdyM2RwbFhRRDR5TmZV?=
 =?utf-8?B?T2lib2c1amx6TGZvVW5abUM3Z252RzNPQnBoRVUvWjdqeTFhRjYwS09LZEo2?=
 =?utf-8?B?ckN1Nk95dzgzYy9xUHk4L0ovOWFzWDQzQzZVbmFUdUdoVStmVmVucDBVS3Mw?=
 =?utf-8?B?VkdRL0N5ZFVTRWFpRHJrNlBXV3hENnZLa0Y5VTl5TjdodGxOYmt6WjduK1hw?=
 =?utf-8?B?K1RBd1EvTnRZLzlMTFhrYUlMZUg4MjJkN1BhSEF4eXJUdUFadWtDYnk5MmNs?=
 =?utf-8?B?VU51VGRSUzBYa04yQ01scTJDU0dZNGRPdHVFdUZHWlpyMlk5T0NTN3dYcGhk?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5902936-399f-43e9-1a54-08dc4daca51d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 15:51:48.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2P+Rx/wJpCu7KOFrYYM+1b+mW86hVX/kDjKuWA6NeCTQeVSeEXV0N1pDppoYKHJDJJEY6kn2cPbzi/mCOGDwhstnfy9xNMR83vYAiAP+4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com

On 3/25/2024 6:59 PM, Kai-Heng Feng wrote:
> On Tue, Mar 26, 2024 at 8:17 AM Nirmal Patel 
> <nirmal.patel@linux.intel.com> wrote:
>> 
>> On Fri, 22 Mar 2024 18:36:37 -0500 Bjorn Helgaas
>> <helgaas@kernel.org> wrote:
>> 
>>> On Fri, Mar 22, 2024 at 03:43:27PM -0700, Paul M Stillwell Jr
>>> wrote:
>>>> On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:
>>>>> On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel
>>>>> wrote:
>>>>>> On Fri, 15 Mar 2024 09:29:32 +0800 Kai-Heng Feng
>>>>>> <kai.heng.feng@canonical.com> wrote: ...
>>>>> 
>>>>>>> If there's an official document on intel.com, it can
>>>>>>> make many things clearer and easier. States what VMD does
>>>>>>> and what VMD expect OS to do can be really helpful.
>>>>>>> Basically put what you wrote in an official document.
>>>>>> 
>>>>>> Thanks for the suggestion. I can certainly find official
>>>>>> VMD architecture document and add that required information
>>>>>> to Documentation/PCI/controller/vmd.rst. Will that be
>>>>>> okay?
>>>>> 
>>>>> I'd definitely be interested in whatever you can add to
>>>>> illuminate these issues.
>>>>> 
>>>>>> I also need your some help/suggestion on following
>>>>>> alternate solution. We have been looking at VMD HW
>>>>>> registers to find some empty registers. Cache Line Size
>>>>>> register offset OCh is not being used by VMD. This is the
>>>>>> explanation in PCI spec 5.0 section 7.5.1.1.7: "This
>>>>>> read-write register is implemented for legacy compatibility
>>>>>> purposes but has no effect on any PCI Express device
>>>>>> behavior." Can these registers be used for passing _OSC
>>>>>> settings from BIOS to VMD OS driver?
>>>>>> 
>>>>>> These 8 bits are more than enough for UEFI VMD driver to
>>>>>> store all _OSC flags and VMD OS driver can read it during
>>>>>> OS boot up. This will solve all of our issues.
>>>>> 
>>>>> Interesting idea.  I think you'd have to do some work to
>>>>> separate out the conventional PCI devices, where
>>>>> PCI_CACHE_LINE_SIZE is still relevant, to make sure nothing
>>>>> breaks.  But I think we overwrite it in some cases even for
>>>>> PCIe devices where it's pointless, and it would be nice to
>>>>> clean that up.
>>>> 
>>>> I think the suggestion here is to use the VMD devices Cache
>>>> Line Size register, not the other PCI devices. In that case we
>>>> don't have to worry about conventional PCI devices because we
>>>> aren't touching them.
>>> 
>>> Yes, but there is generic code that writes PCI_CACHE_LINE_SIZE
>>> for every device in some cases.  If we wrote the VMD
>>> PCI_CACHE_LINE_SIZE, it would obliterate whatever you want to
>>> pass there.
>>> 
>>> Bjorn
>> Our initial testing showed no change in value by overwrite from
>> pci. The registers didn't change in Host as well as in Guest OS
>> when some data was written from BIOS. I will perform more testing
>> and also make sure to write every register just in case.
> 
> If the VMD hardware is designed in this way and there's an official 
> document states that "VMD ports should follow _OSC expect for 
> hotplugging" then IMO there's no need to find alternative.
> 

There isn't any official documentation for this, it's just the way VMD
is designed :). VMD assumes that everything behind it is hotpluggable so
the bits don't *really* matter. In other words, VMD supports hotplug and
you can't turn that off so hotplug is always on regardless of what the
bits say.

I believe prior to 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
features") VMD ignored the flags (which was ok, but led to the issue
that the patch corrected). I think that patch is fine except for the 
hotplug bits because the hypervisor BIOS isn't filling them in correctly 
(if I understand the problem correctly). As I mentioned earlier the VMD 
design is such that VMD is going to handle all the hotplug events so the 
bits in the root bridge for hotplug are irrelevant WRT VMD.

Paul

> Kai-Heng
> 
>> Thanks for the response.
>> 
>> -nirmal
>> 


