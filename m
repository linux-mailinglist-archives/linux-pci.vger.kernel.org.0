Return-Path: <linux-pci+bounces-5115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B63788AA1A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D276342BF2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D89FC0B;
	Mon, 25 Mar 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwToDKNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942A12B95
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379435; cv=fail; b=IZwJtvbwOcOsPkVdPKjBcv2Jk0BBHFHAy7VPutDhcNPrifVqIWNqTniSj/uL77PIlaa/cb7hyNF6RV4tveit5J1BF4xPYqDIaofzaKe47ZenGMMi4LX+aRZSlF9Uyx7qLUakLPoXNTP2Ts8YQwwrjg3na9m4QeuQUdBnMTItYhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379435; c=relaxed/simple;
	bh=eVOiBc2R8PvqpYNpiTqLZiguJXpJMLfgdilqq8CRXlo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NtrDBsyDqHESQdeJpgRJjS8rqvHMLu2KJ7D9PgXBiTvxaOX3yXsI3Us9VNzwIYVS32sq8AzCQve+ped8nfo+Cw2CBApXQkreyuVKB3g0GfLxXxcGjG4hRXY0oP3c030d/vTkR3cysUmeE1ieHpE4aFL8vpiuvIeNPR8XW+vFGpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwToDKNv; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711379434; x=1742915434;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eVOiBc2R8PvqpYNpiTqLZiguJXpJMLfgdilqq8CRXlo=;
  b=VwToDKNv4cnkeprxedkqUB4PvdsXZ2CO2Tyqu3Ywey4JF45n+ybrm5Hs
   8XZ6MoznkcGkPC4bsR99EzPTNWEo5bvrmf1t8z8G7dxCzzmtdTddOps7D
   uC9VIdXQ2zFCWSffqUoAjghTpf3kU26JSfBHsgxXsolsecNeyoin4Vmce
   ry9opob5lT78gkafdZlhRX8r8vFCAHw7pphuh1i0oa7oPDKK0RSXQFntb
   JAThlggdc9VLec18X4fQB9PsowRoYKpnD9UCIIZG3E0GJsGpgevns4r+S
   DAmzE5UyKGINMAxZbIMdt2dXxyV2d38M4xapNqgfZVnxwSQe6dsHiXMw/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="16930285"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="16930285"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20305376"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 08:10:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 08:10:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 08:10:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 08:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBCOuha9xssPcF6Fi/fwMsWXoZP1ev4ypdmH4+ztom7fFXRZ7aIw4H9spOJPl9hXAuS5k8ISefD/KAIUsHL65G2ph8SjIPSI8eVChMB4qm0ppftPhqygJsUBDzPF0lVYlJJwnU+aGcF+6aiMoyZI1YJjtf2xnf5dcJOiDqMLvAV3IfjHwzxUUL9JFQ1ZtLsMu0gwb47lHbjtl8bLuLzmi/odlI3cb3JaohUIwVQTBXkSr501GvgvGbaRPvk0ZZ5pYbsJdojFWOzOAENMYHmKqa2Z/+VkpiGWrBYeBrFV8Psfvz4hKsu6B87ExVDLQqlq5sXRxRQHuPKj6NVnTvBTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtaLd7ap6c30fW4pEc+4S7vrdh3tMRm132U3nOb+404=;
 b=STqiN05XqFRNxy+rfSRPaNkdgl+CsZZUS3bP7iP1kY2PJyfsDx7b5qkm8hJ/zRtSb5QaWGYxITJih8+R7pppbkNqVLjznwv/iHefMuZIwdmhTUATRsrjh2HbdDpWL1LqU6JeTgACHBpR3S3Tj+xUFyiS0KvJqIhB2YEbW9TDNPKZzEcnzgkyfUshHwi/iswCZIiUTPez9RfCJVdp+pMJMPkz5KE7kcnxigykJudtzMVNWr+y5N8U9sR8hVsjSQJyf/2B/AKzjjsZtLkevTfpaPKDm/jRW9AI3trLyqLDkIUb1yk8e6oriCeW4gQygD2OVUrSxs0JIql7PlQh5w/MIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 15:10:30 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 15:10:30 +0000
Message-ID: <47ee0b81-9a8c-456d-82a1-fdac5ddb23e4@intel.com>
Date: Mon, 25 Mar 2024 08:10:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Nirmal Patel <nirmal.patel@linux.intel.com>, Kai-Heng Feng
	<kai.heng.feng@canonical.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20240322233637.GA1385969@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240322233637.GA1385969@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|MW6PR11MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 6526911c-512c-4d93-42a3-08dc4cddb5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKKjZzhT/r6hAdu4wxzeCBKOY7KCN4tWvwwL4AKW48GhC64d4MQN6aNUoPZShMDL70itH0dkXHEtbtL4hPMBTQj8FFm1tVoC7zS/JMses44jIthEwFuYD/1ih6X+1CAk9AVmRHRWPrGnhMaj/kefFh4Piu2D8N7fSf1gafMRS+MrS3EfUXPDlpTumZNjcddhYAAkfc/rMQOVZ/iSMli2aLxj5OXSyUFFs/35zhs38aW63QUs+axiHU/tYOgUHhtgGDrOCk79LqTbdjQO222fSzfOrNVTBHSVQZzzybaAx7koZ8wGYcwWE+SBW5GTzEzciBF/6Go/57yZOpEFTEYKirHv2+2tHhG6f0IIshhBxgYVi+WsVB1ghqvamx4/Sy2vMjQv6pQUJOpbpzxVjZXZFezL8MjrDeop1/FooKyk+KYw6UO9hLtb2VfDd76UEXwIQ3GnFvr0mqa4hySLOSjUmoiRH+eBRbqjuE6ZLvaxRw39wCbgx5LTvmZIJ/onVo168raB7AWp0M3LIQd/tVsk7dYua8tWJN8tsLDSPr9NcZ26tBKzDBpFdZ7FOZ+NZMFUl/W6+mi3GGurHYw2kYEiksKjWN69joD6zofxjO3CmQYFIET5gAb+Tz0XaztoudOpzi7ZFIdQy6yelVtbGYt4edFLnUZxbH8XPBCjlJtnDk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEhzejQ5d1JkNys0NW9KOHlBcDR3NEpGWHlVbkZPWGI5NlI1L2lzdWtNZVcr?=
 =?utf-8?B?ZmkxdjRKUnZvZGpQWDRnYmlFRTh0TXc3MGdwaTU3d2hsUlFUeGdCYy80QjdJ?=
 =?utf-8?B?Z2lMWml0b0xkdWp3UkRBUE5DNHpja1ZLYkwyeU03WFp5SXhRb2g4clpib1Vu?=
 =?utf-8?B?emNDTVBNMUFBKys3aWhPREZQNERJVHVFTUhsM0l3R29kQThkZWVMSk8yZUtR?=
 =?utf-8?B?dkRCdFUzWFdLYzhmRXFEMmZOT0tkWmd1YVlKOVBhbUV1Uk04Nmd1R3ZNNDVj?=
 =?utf-8?B?cXBuNVRFbmtDeSt2c3J4UWFKOEppWS9hL2ZEdUVmaGQrQWRnbXdmdllGdnhi?=
 =?utf-8?B?VnQzMlNtdUdiNFZkak5qSDdNeFBockJ4VFYxR0VjYk4rSFJBOEx1dG5qZWoz?=
 =?utf-8?B?NUx2c3hVQ004Y0JOT2hQUmQzMEpCSnhVMWNQenoyOFhqMENBL1pBakwxYkFs?=
 =?utf-8?B?MnRDcW5BQjBQUkhDMG5Gang1Ui85OUdjQ0EvUXdHbERNQko2TXRLejJ1bWh1?=
 =?utf-8?B?Y1JDZnVTVFlCbGZ3ZGNySHFscVBKNlVKVjFHNlFlVnB1cW81Ti95Kzl1TmIz?=
 =?utf-8?B?SDBEMi85YllhUWtYK2xHV01nSlJwcjBSa3V4d3Q4Vi9xdWtsb2haSGtUamI2?=
 =?utf-8?B?d1ppVnlrSm5pd2xHZ3J3UkxiUzVkQkZzUU5CZXJlUEIxelFHbUJ0VVFhNjBZ?=
 =?utf-8?B?aFRXaTY5ODJjV2h3Nnl5THJyYlo1RVcvazdQRzh4Vk9RYm80ci83U1d6VnRr?=
 =?utf-8?B?Tm5NZ3VCU1p0TVlJcmxGQXVNV25YNjl1VEtxOThiWTR1aW1peE04aXBpTnE3?=
 =?utf-8?B?K1NkZVpvNWlLbXJvZFBNbHZZVmlHYnA3QUhUQ3JhWEJKb3gyUnJ6elZ6Wldl?=
 =?utf-8?B?Z3ZaQzZFcjdiWDA0VnJ1a0xXOWVISno5ZDRVUkJtTGkyOGpYQ0wvaXRLQkFM?=
 =?utf-8?B?K29TUDZKUDlYNEp2YnhqNzdVUTV0YmsvaituTzFOR04vY0FJdkljbnFvSE56?=
 =?utf-8?B?bEZxeVBDTGM5blhNNjk4dGRETkpyU0xKb3kxVUxVbnlZQWRwTGZjZTVpd2RT?=
 =?utf-8?B?U0FUUXpqcVIyQTZtR1ZYWi9WYytxdkd0TnhVMlIrLzJCVW5xY21RZlY4V3Nw?=
 =?utf-8?B?YVQzMlNQUFlyQi9wN3VPa2E3VllpUmg0WWJKTDFQeEgvMXo4bUlEZGZFeVV3?=
 =?utf-8?B?TFk2MUFzRFNodHNkcE9tZFRTeWRvNGQ3Nzh5Q1d4enpjai9wOVhQS1lraGFy?=
 =?utf-8?B?cHNCcVM4NE5mUGlOWmdKTTFSYnlQUDJHVzBFWXc1WEcwMXFIS0xKcE5TTlRV?=
 =?utf-8?B?Wml4SkxXZUo4YkgrelBoL29NcmdRV1F1SkZOdStjSW9JT2xHRHlyYmtveUpD?=
 =?utf-8?B?YkUrZlhoaFpVcUVsZUYyaHVDdWVrd2FqTWRCL285NnZBbk04MWxwTlFuN3R5?=
 =?utf-8?B?dk10L3RsS09NdDU5RDFZR3M3Q1VwOVRnSWdiUW1UQTFHemdYYjRIYUpKaWkv?=
 =?utf-8?B?QTViZDhKQ0pjNlhGejAzU0RxNVJWMTlpaW1ValVXMkxCYmMwaXhrRFdNZzQw?=
 =?utf-8?B?aUtMUUFuclpJbDkrSXN2WTYrOHFZZXFYNXY2YWZTMkFzOFNodlBHOFBjaUVV?=
 =?utf-8?B?NWcrZFk4ektOR3R5ZjVUNDIxN2pkK3RMcjJaWjc2WkxPMDc4UnZRc05LWk9P?=
 =?utf-8?B?NDVkbnlEUUFxVDkvWlduMDd6V0Uzc1NseExLaHJiUStUM2o1WmFtbkZDMVhB?=
 =?utf-8?B?bTB0SzFXYlBYcWlSSDY5SUxSK0VoazBzOVN6Qkk5N01oeFJ3a3ZvdUxWSE55?=
 =?utf-8?B?SEVQRHIzb0IxMUtuREpSSUlDNmZvSTMwb2NmS3ZNcjFoZjU2V3lhbXE3bkha?=
 =?utf-8?B?MjNqdkk5RUtmWFZYeVZRUG8xY1dEY3RDdGlFSmFxWG5HN3R5RmM0SmFvaW95?=
 =?utf-8?B?N1hxYmJvRzU4cUVoOTV1azJWUGtiYzIySWxqSUVBbjJsZSs3M3NEUnZSQmN4?=
 =?utf-8?B?VGtRc2FhdVZ4RU5LckZ2aW93bENDKzl6dXZDaUFqQkQyb2tmTmtPYjI3MmFy?=
 =?utf-8?B?YnlUWTNkeFpSbjZWL1AyNHdNWmZ5VklQRXNLazlQbi9EREN1RmIvTFQ3THZR?=
 =?utf-8?B?S0ovNzdTNUxzM0dWakx6LzBSZWttaHVsVEd0eDliUlh5T3RTSEF3SXpYY3NI?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6526911c-512c-4d93-42a3-08dc4cddb5af
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 15:10:30.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7EctQqVcjY/pLl60D4+p2xH8sEAGgj4KdHkbOwiiGCMY0UqlQRZpedMUiNWLO6tAiZnXDUl8JJ1dzPONYaxvdytS4qg625+8BrGala1NQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com

On 3/22/2024 4:36 PM, Bjorn Helgaas wrote:
> On Fri, Mar 22, 2024 at 03:43:27PM -0700, Paul M Stillwell Jr wrote:
>> On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:
>>> On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel wrote:
>>>> On Fri, 15 Mar 2024 09:29:32 +0800
>>>> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>> ...
>>>
>>>>> If there's an official document on intel.com, it can make many things
>>>>> clearer and easier.
>>>>> States what VMD does and what VMD expect OS to do can be really
>>>>> helpful. Basically put what you wrote in an official document.
>>>>
>>>> Thanks for the suggestion. I can certainly find official VMD
>>>> architecture document and add that required information to
>>>> Documentation/PCI/controller/vmd.rst. Will that be okay?
>>>
>>> I'd definitely be interested in whatever you can add to illuminate
>>> these issues.
>>>
>>>> I also need your some help/suggestion on following alternate solution.
>>>> We have been looking at VMD HW registers to find some empty registers.
>>>> Cache Line Size register offset OCh is not being used by VMD. This is
>>>> the explanation in PCI spec 5.0 section 7.5.1.1.7:
>>>> "This read-write register is implemented for legacy compatibility
>>>> purposes but has no effect on any PCI Express device behavior."
>>>> Can these registers be used for passing _OSC settings from BIOS to VMD
>>>> OS driver?
>>>>
>>>> These 8 bits are more than enough for UEFI VMD driver to store all _OSC
>>>> flags and VMD OS driver can read it during OS boot up. This will solve
>>>> all of our issues.
>>>
>>> Interesting idea.  I think you'd have to do some work to separate out
>>> the conventional PCI devices, where PCI_CACHE_LINE_SIZE is still
>>> relevant, to make sure nothing breaks.  But I think we overwrite it in
>>> some cases even for PCIe devices where it's pointless, and it would be
>>> nice to clean that up.
>>
>> I think the suggestion here is to use the VMD devices Cache Line Size
>> register, not the other PCI devices. In that case we don't have to worry
>> about conventional PCI devices because we aren't touching them.
> 
> Yes, but there is generic code that writes PCI_CACHE_LINE_SIZE for
> every device in some cases.  If we wrote the VMD PCI_CACHE_LINE_SIZE,
> it would obliterate whatever you want to pass there.
>

Ah, got it. Thanks for clarifying.

Paul




