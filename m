Return-Path: <linux-pci+bounces-5190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241E88C86C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350DC1C644FA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E713C66F;
	Tue, 26 Mar 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1t1B/Of"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7C13C837
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468995; cv=fail; b=OCRlysN9HNBkrKZRCok9ZZ7SyYJhMPUn9YJWOBVaXE0tMmED9HPg3m0HKQXgJdJI7BV82myOlZx78zqp70sUzWT96S7K2fjBHZSBHqWe/p+q0P9R/pbnE3GrUijS3cRs3iBZ2HvJHKLwmtSY7E0ymEseHkthLFKWj4MVjAikk2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468995; c=relaxed/simple;
	bh=RJAglGJ0XMTMdXu/VoiXosxz3TkiRRT7fc/1XvwacS0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HNwIoxPxC4r9qytDyKir2NiyrYu/OomiRVxG0wD2FuuU0dZJvHO20/d3HrRA9p6OUg31S0zAC+IiIjMwAJDnytq5M9PvsOvhy5m6sLiPu/uliMIPc6XGbCpaeVMCWmfXB/XWxMpnoVFw2ylmCAqBmtGxJeKp3LppMqQLwunxOgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1t1B/Of; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711468993; x=1743004993;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RJAglGJ0XMTMdXu/VoiXosxz3TkiRRT7fc/1XvwacS0=;
  b=c1t1B/OfL9s75e5mqu57MX/NgnSMT0QX4V9p0OEcrgNu3LGpzIWEby1b
   mY3UO1MuF4LRlVYbPMkhQyRtSTE/SrPGDsm8kgLmjX1ng5pt4pIZ412i7
   2ng/sFl+sO+BVcEFLplmlsMTfG7+lcI8NrwcIj5kShprGkHVpYY+N32i/
   kLKGnBJ/R3QTmNUIiQunrCN89eYCrh4ngTmDJtSXjffaXARF+NBluXb8K
   HrTWC/u1GGvhIdlhgjJ1eIi6xBrEtCmT9002kEOHnOdererIJfXQVEoxo
   USK7JiSUnm7xF4sPqQnI5pA1erNCh7BUkVPnvaSLHhc8t77qkOKN464Sx
   g==;
X-CSE-ConnectionGUID: ezXgyuSmT32oA3R+7w6J5Q==
X-CSE-MsgGUID: 1jcgpFR4Tq2aTgNPHD8R1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6743551"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6743551"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15868914"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 09:03:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 09:03:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 09:03:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 09:03:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 09:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQs1oD97Tbx2/ji9DnHfmCZNJ7QzfsENJC3MDCNkO0F4XsLDJTbTqXZWt1nsDy1njFhpANp0ZULKPhtAxOzIVfPvbTTxHhIGEgT3ClcqonKexw8WVOG2+tFWDBxWM4MarnQ4fBww9EclJWi9fQdZQDOr2aDP8dqmi4Bs+SxvuS67GEG3kXMF4QG8k94VPCN8OTQrHxltTvKED0mSjXsQLhYMKbKWkYdNmjscGEYjM6RLGu31lOp4yVE+fGydgTPY9tsxEf9smyLzG/SDtIBW+SV/dOqf4aYZ3OFp/Z8y0g3jvrqZMikgfAbWjEFZSe4VVVSPPBf1m83Pg5YAwXwpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foOXlMYNcy9hb4zyFiiw9lLFt6lzOsTKiHqjDqybtrM=;
 b=DYK77X8Uj3QjFgnTaMInvesRoV/k0zBPvdIH+/ipz+jYSJs2DpEP9PqPnNd8QAtXUq5ak3hDZYlcjc1vXEmSKoyNgPT7aiCRNovUy0TZgiGVq4zZhNKXmxeV4HaIFDSdzYOsnPTMBzwN7/k+4fNwBkRxc+0Ocio7qkyrgkXSegz24xaA2CzErpOLSKqySVilyS4lQG+hZx4lezzwytwZvNWHdHHiwrqzejFaqg6mcBxG/MyMRiddhe4t07e5mFOLgXXx4bosi7fQAPBupFHw8cHa5oqLKuWNo1iKtjy8R67A65AQPCjzaTKaQNuZAfVsjCdj2I3o6WByBH54DpT1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH8PR11MB6853.namprd11.prod.outlook.com (2603:10b6:510:22e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 16:03:06 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:03:06 +0000
Message-ID: <29b62784-f56e-4b79-b003-3d12444f2809@intel.com>
Date: Tue, 26 Mar 2024 09:03:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, Nirmal Patel
	<nirmal.patel@linux.intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, <linux-pci@vger.kernel.org>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
References: <7f37506e-4849-4c7d-b76c-27b02b7453af@intel.com>
 <20240322233637.GA1385969@bhelgaas> <20240325171743.000013e6@linux.intel.com>
 <CAAd53p6JmJoGjiC5nqRbA4x6fNZY5xCyGELXj0-9ux2LWVhroA@mail.gmail.com>
 <ef559fe9-f3cd-4edf-bee8-dbd2ae504288@intel.com>
Content-Language: en-US
In-Reply-To: <ef559fe9-f3cd-4edf-bee8-dbd2ae504288@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH8PR11MB6853:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAb8sNX4w0zw7kmkO+vrNgtxnbpgKcwf8QxHylaQOmS5jAx7mak6J+/EXXXoN2RVtz1wyY1XcXB0jVL1bZtpeOyAIDhFdLuw0Ujc3ksdKXNYyKhcYjRAiJPUcez8xRwMPtA3wh8d8Cpq7OyGcigy3j5AiKP9wpe+EXeSKpa+0cNRYaFbG+iRhBPWQJ56ADw8awqDlgftoH8hIjMXGDvHaT93/W5DwHSrrWCrxoClbkKyo/2ul5gWnbo5EqYyt4m1YNGpyM0jwsVJcXpkrzs2DFxU8O8RZwykIRe5xN5HEulpnitKRG5lJZgi7VhYYl8hwlYz72P9gjjNBEBd/hZX7sKV/T/rCgD0B43SwzygWTIe1nHK8vwgY/gdLvb7a5GML+WouoxBIp/l3tDhLmj9GYGIMWEfQ64qPUEjtmdQYWShxC4TvoXpqX7xysbdO9ZGrpbLJ9VeSkc13W9SFGFK7nms0Pii6vGf1RvUmYbUpO6Bnn4AkFmSwwmPa3XpBNNEcB9lTjEkNSXFtYBBEd4TsroFQzgRZZiDJcNzgF3aXUW6etBVjUds5g029CKeJdnygymD3X5GuIZJuABZ002YvSn3pJLHmTbD8UNzWN8ZsoEd2Hs+TwJhkuuHnKZkqpEF/a60viCjIT+W8zvLxOrCoSz8kHehS0TToZl8P/oZzPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdrWEVuZGVVZWVrcTdtVlpibnd3dHo1M1ppNmxxWVlhWDZFN3B3bWlVYTMr?=
 =?utf-8?B?SHNNaGJ2VHo0ckpiSUlNemhKTWNtSFltaEJBTXNZeVJQWU9LWDZRY3Fnck5L?=
 =?utf-8?B?Q3llZHQvQzBiQXVwZGFmbWtpaHltU0JUMnhMYkF1SVJkU3dNbGRHY01mNHN0?=
 =?utf-8?B?eWhETmhBQXYrK28yT0d1aHlQQXhKck5GcU5PTDhSTUt0MHJSL1kvaUJjeEJk?=
 =?utf-8?B?RlVIK3RWZk5DMEdDa3ozeC9LditGNWJudng4bE8yQXQzVEU5c0wyVDExby9N?=
 =?utf-8?B?N2pDYWl3MlJGL3NRL0crZHErZGtTQ3JPaWM4Z2JnUDgxTnU3N3FYMGxsZUY1?=
 =?utf-8?B?Z1JMaFFaQ2szeTJFU1ZBNVhmU2dmM2RsMmFwK2U0YkU2VVMwb3RzSU9DY2JZ?=
 =?utf-8?B?WXB2NDZXMmpGdjZVS0ZyVWl6dVU0NTgrMlRycTN4WlhidXVlalUza2hiRmVZ?=
 =?utf-8?B?SXhxQkFtRFFSY3dnNUFDNU8ralFWTjBRNGhFdnVkOVdHUllON0hTNFMxekZL?=
 =?utf-8?B?cDd4Tkh3SGkvUXdZU0JsU2V3UnVnYkFTV3BaRGxid0FwVGtyMzc1TjdwTkRT?=
 =?utf-8?B?WGN6NmZXVXZrdEZCakhUbjhnVWhqNFR3bGF0UEgyTDRBaFlsQm5CTHRFUE9O?=
 =?utf-8?B?RTFJbytOS0gwUHkvTzFnUVJJcDVLTTV0N1dSdlRQVURNV2VBUXE2RjFVM2hM?=
 =?utf-8?B?VENNQUlIUm42TnNGdFBpUlVQbDVZOXFZN1F5V1lpUWxmSjFLWHE4Vmh3WHV4?=
 =?utf-8?B?N1h2dUlRR04wVzVyeWZBajZWT3hFcDN4STZUcHlreEY3VWkxRCtGM3BKcW5h?=
 =?utf-8?B?S2FnM011TTRlTXl3dms2ZlB0MHgvOGxkWk1peVhYcWR6WTVqanRUNFlHamJH?=
 =?utf-8?B?TW5TeFUvM1lJamhEUXI3Tzc4b2p0aGxLMW5CMHBCRGNLSTZQb0ZQYWY1K1Vr?=
 =?utf-8?B?NllmWS96ZFQrZ1BTeTM2bFRBQkpoM3hjVjdQUlBkeTlRZW1nQ3JwRElmczNL?=
 =?utf-8?B?UUgybzk5QkpuUFNvd3daMG9jMWpvcGJnYTFCTGxrakJVVG9uWG9PVENsbE1s?=
 =?utf-8?B?bnkraE44U1VDTk5aTms3OFBnVTNwRU1XRXZVWVVMU293d3RRSTdLU0VDMXVl?=
 =?utf-8?B?UG04S0huYmw0bGdVZVFBWEY3TUFWS2ZNS05xMmFKdGlLQUp5WHVPWDVJOWdE?=
 =?utf-8?B?Si8zQWlNYWNDVUJXRDE4bEhiNmZvN01JZ2RYUXpieWU0dlpLQ1REQVNYWXYy?=
 =?utf-8?B?UFpCb2R5dzN5Q2Z1K0g1UEsyRUlDKytLakJnczM5ZnRQZmRJVk4xRDc3bWx5?=
 =?utf-8?B?ekxzZ21sNmJOVldKZ2MyOU9hRVpRSkhGbFV1WEdFb3JSbzNxY2lsTUJMMFA4?=
 =?utf-8?B?SlplTDY4R2JtOWhMK242ZVJIbWtvSmFtSzdjVUtSR3ltVmFpODdqTTJaTlRP?=
 =?utf-8?B?TDMxNmw1dnhXWXhrZnN3T3VjdDVrcmJrQmM1TFFaa0RLaytJRUJtV1h0YkF4?=
 =?utf-8?B?anVScUk3UDJDd05qWkhpQ254THJNUHBRNTBER3JvdldwOFREemYvbHFTRytO?=
 =?utf-8?B?dG9HWnl4UERDZ1pwamRrRGQwSTEvangrUnhuVzU5RVhTbkNwTmJyY25Eb1g4?=
 =?utf-8?B?MGZNak03Sm9nSzdnY0tUM0lMc2J3a1Q1eTVBUytvUC8vUlQ3OTNIdTFXdUVL?=
 =?utf-8?B?elU0cGZkSnNxTUx1c0N6M3ZOcjE3d3FkQkN5RnJ2bUczK1ZRNUxDOXhKdHpY?=
 =?utf-8?B?Tm5tbFBFRlBkTEdQUHJKS2pvMW1XRTRWeThEbWJHdjFNK3lYV25RZFNyekdy?=
 =?utf-8?B?d0RxU3I4bElZZHpZbzcxN2lGRzZ4bG9QR3FPbVVtUEJDdDNNaGliL0Q3MFdp?=
 =?utf-8?B?WGc3aWU5UGV1VGFsLzBkcEpjTG5UTkdhMXBnMjh2dUNpYldjZ3BPa1N4UThs?=
 =?utf-8?B?Rk54cWNLQllWMHdFZHhGZkJDMHpKc0xBTVFjeFRqTitjcGpGNXdVU1VUalIy?=
 =?utf-8?B?N2orQ3ZackFGcGN3TDF2M0kzWE4rakVlUjNhK1FPMDlKVTV2VFdTcjZPN0hh?=
 =?utf-8?B?RWRSRGI4aWFQNExqUmRSdHcvTXFEYXJ0R1I2eWhkSkp1TFhybEwreXBxVXo4?=
 =?utf-8?B?Y1FjVThuSUNSUHV6L3ZDYlVSYmNlQ2VaZVJxWXh0bUxzYjlNemMzRjB2R3Bl?=
 =?utf-8?Q?HaRCgamoufKLknr8dFK51ss=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9ca8a9-794c-4d98-3ecd-08dc4dae3944
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 16:03:06.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnubPXR9TkGS9mlISN/1mAQvQPXJNDlOK1GI5tctY5xusWpnn9pWsfjn5AWxhDPncrD9xCDY/XCNkFTSRiV03GCARtIxY3LEhdObp4qZLuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6853
X-OriginatorOrg: intel.com

On 3/26/2024 8:51 AM, Paul M Stillwell Jr wrote:
> On 3/25/2024 6:59 PM, Kai-Heng Feng wrote:
>> On Tue, Mar 26, 2024 at 8:17 AM Nirmal Patel 
>> <nirmal.patel@linux.intel.com> wrote:
>>>
>>> On Fri, 22 Mar 2024 18:36:37 -0500 Bjorn Helgaas
>>> <helgaas@kernel.org> wrote:
>>>
>>>> On Fri, Mar 22, 2024 at 03:43:27PM -0700, Paul M Stillwell Jr
>>>> wrote:
>>>>> On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:
>>>>>> On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel
>>>>>> wrote:
>>>>>>> On Fri, 15 Mar 2024 09:29:32 +0800 Kai-Heng Feng
>>>>>>> <kai.heng.feng@canonical.com> wrote: ...
>>>>>>
>>>>>>>> If there's an official document on intel.com, it can
>>>>>>>> make many things clearer and easier. States what VMD does
>>>>>>>> and what VMD expect OS to do can be really helpful.
>>>>>>>> Basically put what you wrote in an official document.
>>>>>>>
>>>>>>> Thanks for the suggestion. I can certainly find official
>>>>>>> VMD architecture document and add that required information
>>>>>>> to Documentation/PCI/controller/vmd.rst. Will that be
>>>>>>> okay?
>>>>>>
>>>>>> I'd definitely be interested in whatever you can add to
>>>>>> illuminate these issues.
>>>>>>
>>>>>>> I also need your some help/suggestion on following
>>>>>>> alternate solution. We have been looking at VMD HW
>>>>>>> registers to find some empty registers. Cache Line Size
>>>>>>> register offset OCh is not being used by VMD. This is the
>>>>>>> explanation in PCI spec 5.0 section 7.5.1.1.7: "This
>>>>>>> read-write register is implemented for legacy compatibility
>>>>>>> purposes but has no effect on any PCI Express device
>>>>>>> behavior." Can these registers be used for passing _OSC
>>>>>>> settings from BIOS to VMD OS driver?
>>>>>>>
>>>>>>> These 8 bits are more than enough for UEFI VMD driver to
>>>>>>> store all _OSC flags and VMD OS driver can read it during
>>>>>>> OS boot up. This will solve all of our issues.
>>>>>>
>>>>>> Interesting idea.  I think you'd have to do some work to
>>>>>> separate out the conventional PCI devices, where
>>>>>> PCI_CACHE_LINE_SIZE is still relevant, to make sure nothing
>>>>>> breaks.  But I think we overwrite it in some cases even for
>>>>>> PCIe devices where it's pointless, and it would be nice to
>>>>>> clean that up.
>>>>>
>>>>> I think the suggestion here is to use the VMD devices Cache
>>>>> Line Size register, not the other PCI devices. In that case we
>>>>> don't have to worry about conventional PCI devices because we
>>>>> aren't touching them.
>>>>
>>>> Yes, but there is generic code that writes PCI_CACHE_LINE_SIZE
>>>> for every device in some cases.  If we wrote the VMD
>>>> PCI_CACHE_LINE_SIZE, it would obliterate whatever you want to
>>>> pass there.
>>>>
>>>> Bjorn
>>> Our initial testing showed no change in value by overwrite from
>>> pci. The registers didn't change in Host as well as in Guest OS
>>> when some data was written from BIOS. I will perform more testing
>>> and also make sure to write every register just in case.
>>
>> If the VMD hardware is designed in this way and there's an official 
>> document states that "VMD ports should follow _OSC expect for 
>> hotplugging" then IMO there's no need to find alternative.
>>
> 
> There isn't any official documentation for this, it's just the way VMD
> is designed :). VMD assumes that everything behind it is hotpluggable so
> the bits don't *really* matter. In other words, VMD supports hotplug and
> you can't turn that off so hotplug is always on regardless of what the
> bits say.
> 
> I believe prior to 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
> features") VMD ignored the flags (which was ok, but led to the issue
> that the patch corrected). I think that patch is fine except for the 
> hotplug bits because the hypervisor BIOS isn't filling them in correctly 
> (if I understand the problem correctly). As I mentioned earlier the VMD 
> design is such that VMD is going to handle all the hotplug events so the 
> bits in the root bridge for hotplug are irrelevant WRT VMD.
> 

I should have been clearer in one aspect of this response: the 
hypervisor BIOS sets all the _OSC bits to zero, not just the hotplug 
bits. It's just that the hotplug bits cause us issues when VMD is being 
used in a VM because it disables hotplug and we need it to be enabled 
because our customers expect to always be able to hotplug devices owned 
by VMD.

> Paul
> 
>> Kai-Heng
>>
>>> Thanks for the response.
>>>
>>> -nirmal
>>>
> 
> 


