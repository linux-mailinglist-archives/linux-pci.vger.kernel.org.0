Return-Path: <linux-pci+bounces-15744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F89B8291
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 19:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C8282874
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1C1C8FD2;
	Thu, 31 Oct 2024 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZNFKPfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47413ECF;
	Thu, 31 Oct 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399199; cv=fail; b=KtPgFjeyusvcU+c8c6jzGIeEPZmFfOiAoJJhH8TbdElm/7SLk2lbx5Pn479rN9UbBxdY1TIce3j2SMDa7iSiTyCjrXWwaz4VVNcfKJk9IjTUqFNQoOsP/9LB5Xd95113kohqMUAJj1dF3MCpItYPzXQZQHKudGT/9wBuBMktfeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399199; c=relaxed/simple;
	bh=mys+eoi9JQIMvn8WccsCnOCOrz6RYEWnAaiiHYnA2i0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdUAnDiXXADvLaQde0xaw24nkk6sIeUp7AoV/5ymBGwzb6LCSRDeMCy1dKMCKvtmV8aHefx+dd+4mZA11KfSZSidjOcrc4hBCY6DKvJYAvOu5LiMvbg4hqRK75dv8C43Sq4Uxrx/3iCVTFSG9n6f+mec3FzUdRneqH7fYokdFPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZNFKPfy; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730399197; x=1761935197;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mys+eoi9JQIMvn8WccsCnOCOrz6RYEWnAaiiHYnA2i0=;
  b=kZNFKPfyG4k6xrXOBlgXOUGr8g9GxXyf0+7/yEsb1A0EkfhCmkkuVq8m
   mcWrBuZMy9hovOAT1VYpv/CUDew8t5zAqjHUPX+olXU0DIucQtjH8B+pk
   yuy03zCQKmd31c3bFWL0ZV2pXJs5GA6ja369MaWIqK0zB8+4HRYMhGrgo
   7OIiFA7wd8FsX/dMJj7CzurSv7X1XGGafutRdFrkGgPxeofb79ul8WuSq
   HlH8Q3Fw++5PDO7WRgH7TFHK5hH+zgNsnpRi1mBi+6ne+iakRN4vh3ZG5
   Nq0XoXNHHdEQPsUVQEW5vZqYjmrEoKRE9SnoUc5TS5VtBK0Xp2cfvROn7
   A==;
X-CSE-ConnectionGUID: mUcYPWxrSruWzXYJInCjFg==
X-CSE-MsgGUID: f3YdtgL+SpyTmjuYpRGXzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="47634601"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="47634601"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 11:26:36 -0700
X-CSE-ConnectionGUID: xjGM6+FZSX20NN2ylklAbA==
X-CSE-MsgGUID: OMWqjyQWSFCkXuNc6w+5Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="106037445"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 11:26:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 11:26:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 11:26:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 11:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCbhKhEtctZHbViikEW/UHppJxzDFgtQIsPU/pfxlOIaIbOGQt0/DwQ8yS4W+SD4GLvpUTdWY9oY+Z4yGXx7vI0poQ724LWL83gYVjl7Qcm0hUPq+qNPzjioIh2j2dw3OlmcgEixQfuqRxqK5SebemFv6eJZKz//WCNJegbewO53MsEF96aQCDIkw4nNOm6s4fKl+L0ZD/9aSMyID9yz/0y09ZOR+8K2ctSM3SAyZjof4bTuQVshnr/y8Gx+Y9zU1Q4qkH3SqJr4IgHYK8WcASFvXiCu/x8YhX9I7A84qp+pg5umbvWPS+Tl0KWR7iRP2zIm6Lk6kaL/ZlxA5Q1Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+5J473wM4OqTsKZbTRYqEAXjr10nSn3I1VlWG+aE1s=;
 b=bcyAL69BHLF/3Sf4xr2AICY+9cFDCzuTdX2Ei95yIK1WUDXkbtHk6momghbS0rERYdn2ffN3E3bf20zyj7/YW9/S0OKnpAiMQgU8B050AnM3nyIbG3i0kSIexOZGKrgaq2A+VazjoWWWZ2NDK/YrHM9VRdvQwcLp0peS7GRonbRV9cJV2eqFczEgI0454+czM/3uTlgLfBbycCOxdW+lpMn4zfWMZ6hY0/xRxI8ztML0wAZiS9o0zNFNxm5fzXQmK1RvWblot8EiexTuGjgYMQDmG1NfxiBGALklbQ6Gigv9OKEpcRR7mWveYRGdwU+pEF9tOjPRcGtYM0I2H3VvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 18:26:30 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Thu, 31 Oct 2024
 18:26:28 +0000
Message-ID: <f9cd603d-8a3f-43fc-a670-75b4d9a6c729@intel.com>
Date: Thu, 31 Oct 2024 11:26:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpufeature: Document cpu_feature_enabled() as the
 default to use
To: Borislav Petkov <bp@alien8.de>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, "Luck, Tony" <tony.luck@intel.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "avadhut.naik@amd.com"
	<avadhut.naik@amd.com>, "john.allen@amd.com" <john.allen@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Shyam-sundar.S-k@amd.com"
	<Shyam-sundar.S-k@amd.com>, "richard.gong@amd.com" <richard.gong@amd.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "clemens@ladisch.de" <clemens@ladisch.de>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "naveenkrishna.chatradhi@amd.com"
	<naveenkrishna.chatradhi@amd.com>, "carlos.bilbao.osdev@gmail.com"
	<carlos.bilbao.osdev@gmail.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
 <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
 <20241029143928.GA1011322@yaz-khff2.amd.com>
 <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local>
 <SJ1PR11MB6083AA7B2E28F2DA24E4B456FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241030142138.GA1304646@yaz-khff2.amd.com>
 <c2894e47-f902-4603-84e7-a9aca545b18c@intel.com>
 <20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA1PR11MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 2820b261-ae68-40e9-d286-08dcf9d98930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0xTclBXbUIyVkRpQWhmbVdpL2hVTTA1Z01nQmsvNG1ldnRIYmxzTXBKZW9U?=
 =?utf-8?B?QXVESGd2RnBOQ2dOZ3BFcnoySmVsR21iQll0YnU1aDhhMFV6RzgraHVjNnZP?=
 =?utf-8?B?aXYzUXpVaTZBZUtBOHNhRjhWa1RDRXVGZjVXSlJyZlFFT0lHa29FR3drLzR1?=
 =?utf-8?B?UVZja0FMN1lNVXBYQzlUMFBkTk5KbTY0L1d2Znh4eEIzbzlLbk5sQVNXbml1?=
 =?utf-8?B?TmplTmgySnJmRkxqL3pYaDBWYm1CdkwranU1YUYzaG1VbFZ1QlB5ajNNcFVV?=
 =?utf-8?B?czlrU1hxQ1gza3hXYWVGZVliMFFOMEJuYWNvUlNvR2NReGtLcTgyT0JXaHdR?=
 =?utf-8?B?NWNxcm1kYmJtZTFDZENDbUxnRkJXWlkwZXVRY3RZVmNSN3BoblJFbVhzdWlu?=
 =?utf-8?B?SkJ5VlpJUjVvTzV2Y1hOR0NNSkJCOWVrSy8rMUdLZG1RUU9meEN4bmhtTVpj?=
 =?utf-8?B?Y0FWVStjVnNKaUpkemtzby8zZUJrQmJnNmIyVFpYS2JrTDRIVHZ4ZTBBTFl4?=
 =?utf-8?B?eHJjemYwRlM5dnQxeno5aVZSMmNOeEtPM1lIbkd2VEJESndwbkdVKzBqNGg1?=
 =?utf-8?B?VkV2MmdSK1Y3QjlsVitLd1N0WUx6MTVlbnFyVkprMkVnYUZzR3ZzejdqOC9I?=
 =?utf-8?B?NCtHZHhKVC9hcEN1SHROU0hMeS93eEhQQk9HTDJuR1o3cCtHU3EzU21DV3l2?=
 =?utf-8?B?ODFnbnIvMEo3dXh1RG5ndUZZeWZUcGx3bDcyTU43NHh5ajE4Z2hWRkljYVhh?=
 =?utf-8?B?V2VKSlRoeHltS0ZxYnl1UGtTMEdzazBlNmFISlZJQ1hVTVFHQzFSUVhUcTND?=
 =?utf-8?B?TmpaUnRWS3huelh4WW1JOS9yclB6S2N6WWZ2eTgwQXFncnFxUFVZZU5SdWVx?=
 =?utf-8?B?NzFLcm1jOTFxV0NDTWxRMkU3UUVNWFl5ZjZIQXV4OHR5TjBpbXZMenBYY1hl?=
 =?utf-8?B?SU1GeW1kV25vRzBGMUVWRCtyVTNuUGk3S3JpeUYrTjJRdjBHK2kwNWV0Sklr?=
 =?utf-8?B?b3MrVmduMHFuNEdXdURJZjNaS3FVdGJuZVgxU3lQc0Z3RFJqZnJuUU1FcnZi?=
 =?utf-8?B?TDRkVUxaeDVlL1VVRzBaNnVPa2NaaUVSSWtFUjBZVURXMUl3aDZSdUtjUnMr?=
 =?utf-8?B?Q3NOQU1UNTZieDU5R3FSM0NVMitVNzRycHpQMFl6T1c1STBRbm83TisrQlEz?=
 =?utf-8?B?dkxvd2tGeWl5ZE5lK3VXY09xMDBBUWtlWnVNYmZQdXhRMHI0ellEMmM4UGVq?=
 =?utf-8?B?N1RVam53QWEwQ091dnNRY0FZK0FQL2VkRUlkcTJXS09xUXdmZVNRSlhDUkNO?=
 =?utf-8?B?cDlPN0JjcHRXUFBnRVhGSHVZQUlZL3E5YzlYMEhrNGQyYnlaTEFMRGpKVmMz?=
 =?utf-8?B?eWhWamRSL1lQYjBXWTlub2tLVG9odUh6ajFoOW5Zd1BrMEE5aW40R1UyS3d6?=
 =?utf-8?B?N1k2ZDFPZ1pxSkdMVklIcGQySGowa2JNTzVYNXVDRllGdzFmU0o3ZlhIckRt?=
 =?utf-8?B?SGVWWEQwTHpXYTdPeDFnaWFpeHhhcXBZalRVSk9ObWhqMy9EeWUvM04yN2RT?=
 =?utf-8?B?M1g0cFBTdFdVa2pVV1NmdTh6MTZBSW5RVFUyY1JHOTNIWEpmMi9SMHNsN0Nm?=
 =?utf-8?B?Q3ZOanJrTU5lSU13Z1EvSkgvMnFjZThQcjhHNlVkcUJZWjE3V09SaDhOZWJO?=
 =?utf-8?B?NWxEWlEvQzBxOHRyRi9xNjZpREl2aGEvUENWUVNPNnVrcHhJNG4zUGFtV2Q1?=
 =?utf-8?Q?AJ2aF2l/onOliCqtCSGvRayUvsFLPtVyPpGBziW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFpIU3NBUEl4djltQVUzbWF1VktPRWJCNFpYbSs1cjFWeGpiREVGdG5FWC9B?=
 =?utf-8?B?WWJUMGVRakhlRWM3RzZ2cEZMU0JITWRZL3pYV2JuRTNvWkNZdHJjY2JHNUNq?=
 =?utf-8?B?bU1FWXFEUlJCamVNOWpFdUwxWk1FZ1BldmRDNnB6eHhTOWNRNUN0YTBTNGlB?=
 =?utf-8?B?S0xQazcwYnpMM3UvUlBkTmdKNWRaSklxbGFiUnduT3pmNy9pZGRCR29GNHJ3?=
 =?utf-8?B?UitNM2Vla0RwSUdSSnowaTZUc3BOeVhnYmh0djloZmUrdHNqZndsQklzZlcz?=
 =?utf-8?B?YzlOcitFSEltOVRUWExqTDdidDUrMW5jUW1Semw2UVlmNUE3UDZKUmZQUWpl?=
 =?utf-8?B?ZnRQMnJyZ0hDcU85OFZmL2JoZG5tRnhCaUNlbU5QS0syS2tiaDBPVlhVUnF3?=
 =?utf-8?B?N2g2WldyNThveStubnY2Z2VoRWdOOHNhTEVWaUFSelVZbWswZmhpSXBURC91?=
 =?utf-8?B?UE8xM0hJMWhJZnd5SUdwRzBYVkFUQzV6OFU4dll6NXFvdTAwczlWSUdtNlRU?=
 =?utf-8?B?MmJGY1ZZUU1PejZFOWJVYUFEdUNxc2lXT2I1MUEwWEppTkdjcllxdFdtY3ky?=
 =?utf-8?B?dUpySVJmaThMc05wQWQ4QzVjbjRiRWNaVVM5TlI5MS9xbDk2WnhmZC9rc20r?=
 =?utf-8?B?RGhPbTZEb25MYjA2SFJSSmE3V2xuWXBOYUhrTFg5SXJzanhuSkhGQ2NjNlRy?=
 =?utf-8?B?WXk3QXVHVUtRMjlDOStYTzR5QjYvaWdEL08ybVJsdGRZaExjZlZFdG9pN1Uw?=
 =?utf-8?B?UVg2eitidnk4Q0ZjRnkvK08xY3NEN05TdGlaQXBwVFZKU3lOOWhzSndScU5o?=
 =?utf-8?B?RmhNcWNsOGdnaG9MaHlhYnZ4bHMwcnNMcExLOHFzVkVHNG5QK0VUdW50NmVz?=
 =?utf-8?B?VElhYWVBdjNkallabVVCTGFUSVpsdGNYS0dYN2lNdVZ5bHFpTFd3RGdKczhO?=
 =?utf-8?B?STZ4TEI1QUx5UHliUG1NQ2cwRGlLTnMvZkxJNWl2d2hidjZYeU15RFJjUm5l?=
 =?utf-8?B?RDBXSnloSExNSW40Nlh2RW1MTysxMG9kTUxKbUlXd3lzU0JFaVJxN3B5cy9x?=
 =?utf-8?B?Tnp0elVJTWRWTllOY1NCWFo1bXlPS1RJdFRYNmcvTExwOXFQVytpVHAwaE12?=
 =?utf-8?B?YUZuVFdkU2xLQTRoSWJRV0d2TlZrbk5RdVY3WFNybFc1dDhvOUFkSVpRWjdG?=
 =?utf-8?B?UDVaRUNkQm1mTGhuVTlVL3ZidDJLdUgzc09LVXVlV3ZYREhTZlY0cXliTlhV?=
 =?utf-8?B?d1lrb3JsNVNJSGZaRWxkUTBKOHcvQ2txSThyTTlNU1NDUWd0aGFGRU9lOTVs?=
 =?utf-8?B?cXVFNkRLcTk1MWRoZmJmdlpOeDEyaDhaSmIycUpDc1BJMm44UERHTjlnbktI?=
 =?utf-8?B?ekVkb3BSS1hVVlhHeXVleUxlTkszRWpqL25OOVc0QmliTmJYVjBnWW5LWCtI?=
 =?utf-8?B?L3p4c3VWM0Y3VUpWYUxVM29velJnZUxpclRMdW8rcGRzcDNyNFpEMkp0Qzdu?=
 =?utf-8?B?cjlxTXlGbXN2QldYaGxkaGNpdXFwajAyTWk1S2h4SElONXpCcnJtaXlkelN3?=
 =?utf-8?B?T0pLbUd2TjJDb0RKd05pTDFUbFlwemJkUFRTandBV2Q4cU9BYVpISUdvSnJp?=
 =?utf-8?B?REpFaTJYSm1uZS9XQTJrNytlUEdOS2taU0lKczdZV0Z6MVorcE1DcUFOa1lM?=
 =?utf-8?B?dWMvbVBWMTJjMDFnbjE4UGtWREwvUXVDVzgrcVdnTi9ycTVNNHFMRWlIRyt3?=
 =?utf-8?B?VjNhZVh4QisyOU5WUU15L2JFNmE0Rk80NW1IN0g4ekFZekd4eDVyUW9ZT2VJ?=
 =?utf-8?B?UnRxZjdUZUgvVkRFaTgySDhYNUdTaWdLL0cyczEydzUxYVNTNFZEVE9JMGds?=
 =?utf-8?B?NVZCbTE4Z2s3ZHNUUWlFdXFvUGtLR3FNMjhkSEt1YkVaZG1HdWxTVmFsaFZE?=
 =?utf-8?B?c2V3NmJpUE5qdmhVRHc5enZWVlk0MktVU29ISjJoZjllV0NuYzhLK29YZUR3?=
 =?utf-8?B?YlNuZmpZM0dBZmpUcW9kdUFEOVU3cXBjV1V3TmxLbTNISENJUE1CWXhsOHk2?=
 =?utf-8?B?Z2V5cVI3cWVoTWtXS0VMekhvVDlTY3BpeElGNkxYUE9hVlNUL0xTTnZVU2Vv?=
 =?utf-8?Q?rcTeKWbI7XvrtrFf4KEbn3GS3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2820b261-ae68-40e9-d286-08dcf9d98930
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:26:28.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e95YfhwGdqZcv/Kqe2XmCnnRpf8kO6HdGm4TleUjMOhdKHcbRyKDlC0+ujt8QGoVw2VYBfbxSsyyYgHEZ6bbAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175
X-OriginatorOrg: intel.com

On 10/31/2024 3:34 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> cpu_feature_enabled() should be used in most cases when CPU feature
> support needs to be tested in code. Document that.
> 
> Reported-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/include/asm/cpufeature.h | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 

Looks good (a minor nit below),
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index 0b9611da6c53..de1ad09fe8d7 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -132,11 +132,12 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>  	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
>  
>  /*
> - * This macro is for detection of features which need kernel
> - * infrastructure to be used.  It may *not* directly test the CPU
> - * itself.  Use the cpu_has() family if you want true runtime
> - * testing of CPU features, like in hypervisor code where you are
> - * supporting a possible guest feature where host support for it
> + * This is the default CPU features testing macro to use in code.
> + *

Does "default CPU feature testing macro" roll better than "default CPU
features testing macro"?

> + * It is for detection of features which need kernel infrastructure to be
> + * used.  It may *not* directly test the CPU itself.  Use the cpu_has() family
> + * if you want true runtime testing of CPU features, like in hypervisor code
> + * where you are supporting a possible guest feature where host support for it
>   * is not relevant.
>   */

