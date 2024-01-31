Return-Path: <linux-pci+bounces-2855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E48434CC
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 05:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D11B2331E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 04:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D9612B81;
	Wed, 31 Jan 2024 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="br60lIKT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669116435;
	Wed, 31 Jan 2024 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674971; cv=fail; b=p9GSc8fCxIZ2ixvGG/r/tt85fSrdNFS+QcS2td0e/dLMGXUXgdo50l86K03kR4jQnSaIh6n5LPLtPZ/lMQ+ghkM5BCh5Wwu0yHS76cYAf9cO7zQ1orF8YAU5e4jE2hvr28CizNduFfEHB5rrz9f1Kh8Fakzn/V3TsWys57TYenM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674971; c=relaxed/simple;
	bh=24lKLgHD9ZiBTPgBMFYlOEyBzAqHCpHd3X4UJixpFas=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s3fVOcMjnL+iyceQaWfWbA82f5/nzuQWzqpRPdL3LAwtYlb1aijNEF8JpI3d1seqlFPinnCzkZ919Ehx+YHN5bLEjU1fi44evFBwRWV3VX2VUZwS0xleO8GtF40L8yxNKbWt9t0/jvlNsvgXbiQuQagyvRK2LQMa2ZMnIVIP5q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=br60lIKT; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706674969; x=1738210969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=24lKLgHD9ZiBTPgBMFYlOEyBzAqHCpHd3X4UJixpFas=;
  b=br60lIKTqc1Ehb9adGP83JAuEHQn77H23pd9bnpOSWcviomtPhBtoAl2
   NJsKGTxkCtVVUSKznSwm+p5UXHW+jjbXjd5lLp15eXspGJEkwrYg+YUXk
   631uRb8MnWj4Eh6JItgFyFHt4NAw7UuQvzVsWbz3uNJ8Z2T5nWJfUCO3J
   ThJDrz+xSAZ9EFKxodx3e79oFDGqlFXGkViApZBV5TS70vUdWlFZHigqh
   eVRpN2WDtrHcj3Qw43vKLX0HdlBSBZkoAubox8C+LgQhTpnTdguE8KCiv
   Bq98sphUX8CgCTYbezzij10teWTgM/qytZPkXQVZaI7Am0Y8bS5lgBWqg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16867392"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="16867392"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 20:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4028057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 20:22:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 20:22:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 20:22:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 20:22:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHDjYiL3Xdn8tn4SJqy6Ua622prtXodF1EUf2/EA5AFmtKfRvjzre95PzK6c7mepn+6YmIN3clAOEOaMRJ9jUf9xribpfQqVn/DsoLs1nZw3RdvkoPbzJcISkEUV0c7KLxM1A4Euv2TaWbKvzQc854D9gCxeFF/Za7DYXhfl55r1o4jx6AMqK3FItvmwukr9XHs4ivejZlpH+oBKaFZtPRV1vOPihxUS7jRkZf/Lu3LexR13lTvMFFy73wvHi4xFayEtIaq8AfMmfzpInUO8lnQ8jIgHPGaXLfSIokEcUHpokUAkYzG2OpusNQZiu8Mo1wVYhbxA3kANhsFxqsgu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2dn5euQ3tsZOQFrKmciN3r9JasfCX5zxhXjZZIl0Jk=;
 b=k1ETBoXopsHOifcukNDBd+Eon6L/ISRz5DMV43dO4TFr4PTwyvaTUN8FaU74Cqabe/dV2teB0UPNEMF6hf5XNOmKamoDB1qbzF52vOIZnMp8H9IozXu+jpwR/liJ0WMA1wm6MjkiMr+PyA8TrcooTTSVQ60eeUt5szZ4b+cbks+dejZokfL/WKKtJx70dSAy70gYb00mII1DPH2bY3yD2p6E8R2YV+sBC6I9D8Y/gbcZgFQ+SL3hjl47sNP+AZFSV6DxepDXV4W3+NcHrMvMd8ZibtAzZGkVNgahJdOnJKyY8JXQy0rKqxEVa94+fYro7YF/E+AWofafScKuhlkIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 04:22:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 04:22:45 +0000
Message-ID: <3d6e33f5-c25e-45d6-9cbb-fa06d56605b1@intel.com>
Date: Wed, 31 Jan 2024 12:25:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/5] iommu/vt-d: don't issue ATS Invalidation request
 when device is disconnected
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, <baolu.lu@linux.intel.com>,
	<bhelgaas@google.com>, <robin.murphy@arm.com>, <jgg@ziepe.ca>
CC: <kevin.tian@intel.com>, <dwmw2@infradead.org>, <will@kernel.org>,
	<lukas@wunner.de>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Haorong Ye <yehaorong@bytedance.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-3-haifeng.zhao@linux.intel.com>
 <62f9ad7b-eaad-4a73-856a-78b30817b0d5@intel.com>
 <d4e857f7-1a8f-43da-8f9b-0fba352c7b5b@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <d4e857f7-1a8f-43da-8f9b-0fba352c7b5b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: c225ba0f-80c1-4704-07e5-08dc2214462f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUs7jamobH+U2ZccePmi3UiD+bZ2IYeyzmAAJRSossJ2f7rixnPpDVQqgtHqGYqWBvv1E7a41HxPsby7YClpranNbc5JPFopfxlou11Qi4nxiQuSIx3zTKb29gmq6Oz1UXWnbkXfKBUvWzJlRQggFx0VbMO1eBfjD6cUXHTlFu+CxcVGA+0ijP4p9W2NVMFYZX55kQSi6jFRxMTFkmLESfnC6zxc32qq0ZH0dy58iDzXMzvqHVmynNyLJTk/65YFJUv0QSB6Y3MfUlFDKQZ/4hV0Ynh8JjBa5m92tf0yRi4b8zQsWTNJSxgXj5b1cKDlFDd3fH2SL4PKJam3t2TlAuzGE5K1TJAn0OmI2dSCrww6+edAxZwvwvyHGguTQLIvtyWsMYQFbeSw6lgy5+JEy/EzpAKtbLbyuyoW1nvO3qJ4D8tQ0C9+jCiuz3/tparv2NyE9ZA9UOloXWcBGamgNmjytKRu5Yf1gHDnkQ2IU7ExxAfcnmzS5MyJIWbB8TVXJp5RA4PBiJ6AtLPn+91sLN+Ms/l6mbgoIRNeDNC9CR7Abantm6DnYRhb4nl3d+wqkVEcGVUomKtiklzv2tPVHVWId+ycT5AsYS209qN88nBsQKqHVuJMiC4n+NzJtf8j6CJXAT48u6sgakRfLCkIZ2WES/LnFVetP2H4Jbfbz1VzSn0CANPIjrSwsp7aC2QT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(83380400001)(6512007)(26005)(2616005)(38100700002)(5660300002)(4326008)(8676002)(8936002)(7416002)(2906002)(30864003)(478600001)(6486002)(6506007)(53546011)(6666004)(66476007)(66556008)(66946007)(316002)(31696002)(86362001)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdPdk0zcnJJUFFwVDNhN3ViMEF2UzJha3dhdEs2enFlbERMVGx4SXVmem5D?=
 =?utf-8?B?OXRxSW05K1FVV1hNMzdrSlN0ekZzcDQ3RGFCdTM1dWthOXJCaGJQQU02UVJC?=
 =?utf-8?B?QXBWNnRDSVNpRkJrQldranU0aEk4UFdkZkorNVhSMnc5YW5XUnk3T2xRMDgw?=
 =?utf-8?B?V2cwMFMwdEhyWEVUR1AwTm5QQ2dCRkcxU1EyOHBXcmdVNGRnREpRYzk1eVdl?=
 =?utf-8?B?WjJUYStybHZYcWJQblI1ZU1jUGYwVTMrcWFzKy9CUDBINm9OaHpmMDhIbSsy?=
 =?utf-8?B?TjFsTW1qb0ViREw1VXVRZjBMaTFVZjVoQkUzTHAxMjdxeE1DTElFV1llSEoz?=
 =?utf-8?B?ZkhLQllOaUVOUWJRRkdFbzNDZEorWlloS1ZRUkNlN2tvajQ2Y1lFK01PS0x1?=
 =?utf-8?B?aUswSFZxaUVVSU1YV3JGU2xwWjBIaHlKMVEzcWs5YllYQitHNC9oSXdkUVB6?=
 =?utf-8?B?WHZTRHZnZEcwcTJCOEhtSWt1NThyUkpJM3FoQ3A4WEFyUkoyRndRZkI4dGNx?=
 =?utf-8?B?bU0ybjJXa1E2VlVicVk1ODRlUGZ1R1NaK3NCcmwrQUx1Z2R0VGJjaGQ3ZDlN?=
 =?utf-8?B?bmJiQUlhWDBvbk9vZHZsanhKR3dKWUw0SUR4M1M3Y2s1RW1oUFU1WFE0V0oy?=
 =?utf-8?B?UEQycnlGTlJaUDdhVXRoanpyYTVUcFI0cThBL20wQnBEZEFudVU4emJ2TlN6?=
 =?utf-8?B?a0NFWWlPTlBXaGhNN1p2SXZhM2cxT2xWY3Z2SGJxVno3KzJ4NGluUHViOWtT?=
 =?utf-8?B?dEMwY0F2Rm1YTG4vOHlkN0x3eG12UXQxZ1cwZWdadG9VT2tkU1ZicFRHM0NQ?=
 =?utf-8?B?Z2tJUC9TMnArM2hTSDgwUzZDYjJaM1JsOVc1cmJrcFZiZnNTS0R5TW5NYUZj?=
 =?utf-8?B?ZHI3VVlLaHJ0NnN2V1gzVksyM1hUSm00WS94WVpiMG5yTXJDYld3a2MyZW5x?=
 =?utf-8?B?RnJtZnluZzh0NmpNT0RnUWpFYXFwSDFuQnBiSW1LOWZGK3pFVHc1eENINGdJ?=
 =?utf-8?B?VVI4RXJaNUZ1Q3JQRG5VMHJCUGFzYzEvZmIwMFJhaEV0VGlsRHFISmM5dEY5?=
 =?utf-8?B?b2NFeVUwWG80WVZuNE54UGY1aS9ubENCWW12azdBS0R1UUZWTU40TDFTcEtu?=
 =?utf-8?B?S2Q4VmxxckJXNDE3OE81SEMyWEdpV1lERG41OGQ2cnNLUUhQejQ5OFhzV0xE?=
 =?utf-8?B?UENmbTRGQkxsRW12OFZRNHJxNFdJS3VELzdadjBJTlJvRnpkTjh2VFQ4UmVW?=
 =?utf-8?B?d2pVQTlYYS9pOW1wTm9SNzlnRTB4K3FHdmh0TDlGM2FmaWthMXRQaVozVkpu?=
 =?utf-8?B?YVBYV3lJTC9JNnJ4bnE1UVh1anA0ODZ2VW1lUkQvWnJIQ01RMm1jaGdDV2gx?=
 =?utf-8?B?QUVoaW9MbjhNU0diaC9ScTRuQXhHUjlPMzVHYUlwa0l0Y3lnL0Y2elQ0NGxL?=
 =?utf-8?B?TnoyV3hhZUxEeUlVYnp2L1JPYVJSSk9UYVlHeUY0T1ROQUVKQUhrVVhrNTBQ?=
 =?utf-8?B?cktrWStORlc5QzlQeUFZOVZvWmNmV3NPQldUcm9ZTVdsK2dzWHdUYkkxOWN4?=
 =?utf-8?B?K3ZYdzRtWEVDNVV5UXl4aDVuc1Bmd2k2dFgvWUEvdEsxbVROZ2RGcWRXV0Y5?=
 =?utf-8?B?NTcrU05QVVFJREs3cVRVbjJQMlgvN1h3N0N0TFNzWnhhV1R4L2swNVdZTVJo?=
 =?utf-8?B?ZXo0UVdiZlNXUFdiZlA5ak43ZlRPcTdWNUdLUGRuc3MrWGZsSGNUUWxZK2ph?=
 =?utf-8?B?UHZZWTA2R2Q5MHJuT1oxUDA0T0ZmOGVjVVhKcEpaa3RxaDQ3Nkw4L2ZBdkJu?=
 =?utf-8?B?OGNhdGZWZzdlMGR2MDQ2NGkvUWdzMmhzUVBFTjFwMHc4SEVIc09zY3hGME53?=
 =?utf-8?B?VTZvU0EvQWtMU2FsdzZtR0syY2JSK3FmU0RnbC9ONG5rNEtVZ1N2MWxaQmpl?=
 =?utf-8?B?dURueXYyMkg2d1h2UmY1dlFMQXlrUGwwUEtjZWt6eWtnS0RhR0ZHenJ4bXBm?=
 =?utf-8?B?VlZGdUwvcXh3NEtnaktNNFNNWUFZYitxMTNVaVI5T1IxWmR0L3NpQjBwY25v?=
 =?utf-8?B?QUtsb1JXMjJYQklSdnFtbVpORmxDQVJKTlJQUG01NkhBT1RjUi82MitwVS9Q?=
 =?utf-8?Q?792qNJwLHjQWBnNkFWQeC1nN6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c225ba0f-80c1-4704-07e5-08dc2214462f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 04:22:45.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: che/5/Nw/F3fjTJaGlAkoMkixwRcCnwHGORVnb2mh+cLpNXsDrzqXt5lvW7Dj/xiaftVnosIPbbSSJrUxr/zHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com

On 2024/1/30 13:37, Ethan Zhao wrote:
> 
> On 1/29/2024 5:32 PM, Yi Liu wrote:
>> On 2024/1/29 11:49, Ethan Zhao wrote:
>>> For those endpoint devices connect to system via hotplug capable ports,
>>> users could request a hot reset to the device by flapping device's link
>>> through setting the slot's link control register, as pciehp_ist() DLLSC
>>> interrupt sequence response, pciehp will unload the device driver and
>>> then power it off. thus cause an IOMMU device-TLB invalidation (Intel
>>> VT-d spec, or ATS Invalidation in PCIe spec r6.1) request for non-existence
>>> target device to be sent and deadly loop to retry that request after ITE
>>> fault triggered in interrupt context.
>>>
>>> That would cause following continuous hard lockup warning and system hang
>>>
>>> [ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
>>> [ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not present
>>> [ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
>>> [ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded 
>>> Tainted: G S
>>>           OE    kernel version xxxx
>>> [ 4223.822623] Hardware name: vendorname xxxx 666-106,
>>> BIOS 01.01.02.03.01 05/15/2023
>>> [ 4223.822623] RIP: 0010:qi_submit_sync+0x2c0/0x490
>>> [ 4223.822624] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 
>>> c1 48 8b
>>>   57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> 
>>> f6 c6 1
>>> 0 74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
>>> [ 4223.822624] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
>>> [ 4223.822625] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 
>>> 0000000000000005
>>> [ 4223.822625] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: 
>>> ffff9f38401a8340
>>> [ 4223.822625] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 
>>> 0000000000000000
>>> [ 4223.822626] R10: 0000000000000010 R11: 0000000000000018 R12: 
>>> ffff9f384005e200
>>> [ 4223.822626] R13: 0000000000000004 R14: 0000000000000046 R15: 
>>> 0000000000000004
>>> [ 4223.822626] FS:  0000000000000000(0000) GS:ffffa237ae400000(0000)
>>> knlGS:0000000000000000
>>> [ 4223.822627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 4223.822627] CR2: 00007ffe86515d80 CR3: 000002fd3000a001 CR4: 
>>> 0000000000770ee0
>>> [ 4223.822627] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>> 0000000000000000
>>> [ 4223.822628] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
>>> 0000000000000400
>>> [ 4223.822628] PKRU: 55555554
>>> [ 4223.822628] Call Trace:
>>> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
>>> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
>>> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
>>> [ 4223.822629]  intel_iommu_release_device+0x1f/0x30
>>> [ 4223.822629]  iommu_release_device+0x33/0x60
>>> [ 4223.822629]  iommu_bus_notifier+0x7f/0x90
>>> [ 4223.822630]  blocking_notifier_call_chain+0x60/0x90
>>> [ 4223.822630]  device_del+0x2e5/0x420
>>> [ 4223.822630]  pci_remove_bus_device+0x70/0x110
>>> [ 4223.822630]  pciehp_unconfigure_device+0x7c/0x130
>>> [ 4223.822631]  pciehp_disable_slot+0x6b/0x100
>>> [ 4223.822631]  pciehp_handle_presence_or_link_change+0xd8/0x320
>>> [ 4223.822631]  pciehp_ist+0x176/0x180
>>> [ 4223.822631]  ? irq_finalize_oneshot.part.50+0x110/0x110
>>> [ 4223.822632]  irq_thread_fn+0x19/0x50
>>> [ 4223.822632]  irq_thread+0x104/0x190
>>> [ 4223.822632]  ? irq_forced_thread_fn+0x90/0x90
>>> [ 4223.822632]  ? irq_thread_check_affinity+0xe0/0xe0
>>> [ 4223.822633]  kthread+0x114/0x130
>>> [ 4223.822633]  ? __kthread_cancel_work+0x40/0x40
>>> [ 4223.822633]  ret_from_fork+0x1f/0x30
>>> [ 4223.822633] Kernel panic - not syncing: Hard LOCKUP
>>> [ 4223.822634] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded 
>>> Tainted: G S
>>>           OE     kernel version xxxx
>>> [ 4223.822634] Hardware name: vendorname xxxx 666-106,
>>> BIOS 01.01.02.03.01 05/15/2023
>>> [ 4223.822634] Call Trace:
>>> [ 4223.822634]  <NMI>
>>> [ 4223.822635]  dump_stack+0x6d/0x88
>>> [ 4223.822635]  panic+0x101/0x2d0
>>> [ 4223.822635]  ? ret_from_fork+0x11/0x30
>>> [ 4223.822635]  nmi_panic.cold.14+0xc/0xc
>>> [ 4223.822636]  watchdog_overflow_callback.cold.8+0x6d/0x81
>>> [ 4223.822636]  __perf_event_overflow+0x4f/0xf0
>>> [ 4223.822636]  handle_pmi_common+0x1ef/0x290
>>> [ 4223.822636]  ? __set_pte_vaddr+0x28/0x40
>>> [ 4223.822637]  ? flush_tlb_one_kernel+0xa/0x20
>>> [ 4223.822637]  ? __native_set_fixmap+0x24/0x30
>>> [ 4223.822637]  ? ghes_copy_tofrom_phys+0x70/0x100
>>> [ 4223.822637]  ? __ghes_peek_estatus.isra.16+0x49/0xa0
>>> [ 4223.822637]  intel_pmu_handle_irq+0xba/0x2b0
>>> [ 4223.822638]  perf_event_nmi_handler+0x24/0x40
>>> [ 4223.822638]  nmi_handle+0x4d/0xf0
>>> [ 4223.822638]  default_do_nmi+0x49/0x100
>>> [ 4223.822638]  exc_nmi+0x134/0x180
>>> [ 4223.822639]  end_repeat_nmi+0x16/0x67
>>> [ 4223.822639] RIP: 0010:qi_submit_sync+0x2c0/0x490
>>> [ 4223.822639] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 
>>> c1 48 8b
>>>   57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> 
>>> f6 c6 10
>>>   74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
>>> [ 4223.822640] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
>>> [ 4223.822640] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 
>>> 0000000000000005
>>> [ 4223.822640] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: 
>>> ffff9f38401a8340
>>> [ 4223.822641] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 
>>> 0000000000000000
>>> [ 4223.822641] R10: 0000000000000010 R11: 0000000000000018 R12: 
>>> ffff9f384005e200
>>> [ 4223.822641] R13: 0000000000000004 R14: 0000000000000046 R15: 
>>> 0000000000000004
>>> [ 4223.822641]  ? qi_submit_sync+0x2c0/0x490
>>> [ 4223.822642]  ? qi_submit_sync+0x2c0/0x490
>>> [ 4223.822642]  </NMI>
>>> [ 4223.822642]  qi_flush_dev_iotlb+0xb1/0xd0
>>> [ 4223.822642]  __dmar_remove_one_dev_info+0x224/0x250
>>> [ 4223.822643]  dmar_remove_one_dev_info+0x3e/0x50
>>> [ 4223.822643]  intel_iommu_release_device+0x1f/0x30
>>> [ 4223.822643]  iommu_release_device+0x33/0x60
>>> [ 4223.822643]  iommu_bus_notifier+0x7f/0x90
>>> [ 4223.822644]  blocking_notifier_call_chain+0x60/0x90
>>> [ 4223.822644]  device_del+0x2e5/0x420
>>> [ 4223.822644]  pci_remove_bus_device+0x70/0x110
>>> [ 4223.822644]  pciehp_unconfigure_device+0x7c/0x130
>>> [ 4223.822644]  pciehp_disable_slot+0x6b/0x100
>>> [ 4223.822645]  pciehp_handle_presence_or_link_change+0xd8/0x320
>>> [ 4223.822645]  pciehp_ist+0x176/0x180
>>> [ 4223.822645]  ? irq_finalize_oneshot.part.50+0x110/0x110
>>> [ 4223.822645]  irq_thread_fn+0x19/0x50
>>> [ 4223.822646]  irq_thread+0x104/0x190
>>> [ 4223.822646]  ? irq_forced_thread_fn+0x90/0x90
>>> [ 4223.822646]  ? irq_thread_check_affinity+0xe0/0xe0
>>> [ 4223.822646]  kthread+0x114/0x130
>>> [ 4223.822647]  ? __kthread_cancel_work+0x40/0x40
>>> [ 4223.822647]  ret_from_fork+0x1f/0x30
>>> [ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 (relocation
>>> range: 0xffffffff80000000-0xffffffffbfffffff)
>>>
>>> Such issue could be triggered by all kinds of regular surprise removal
>>> hotplug operation. like:
>>>
>>> 1. pull EP(endpoint device) out directly.
>>> 2. turn off EP's power.
>>> 3. bring the link down.
>>> etc.
>>>
>>> this patch aims to work for regular safe removal and surprise removal
>>> unplug. these hot unplug handling process could be optimized for fix the
>>> ATS Invalidation hang issue by calling pci_dev_is_disconnected() in
>>> function devtlb_invalidation_with_pasid() to check target device state to
>>> avoid sending meaningless ATS Invalidation request to iommu when device is
>>> gone. (see IMPLEMENTATION NOTE in PCIe spec r6.1 section 10.3.1)
>>>
>>> For safe removal, device wouldn't be removed until the whole software
>>> handling process is done, it wouldn't trigger the hard lock up issue
>>> caused by too long ATS Invalidation timeout wait. In safe removal path,
>>> device state isn't set to pci_channel_io_perm_failure in
>>> pciehp_unconfigure_device() by checking 'presence' parameter, calling
>>> pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will return
>>> false there, wouldn't break the function.
>>>
>>> For surprise removal, device state is set to pci_channel_io_perm_failure in
>>> pciehp_unconfigure_device(), means device is already gone (disconnected)
>>> call pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will
>>> return true to break the function not to send ATS Invalidation request to
>>> the disconnected device blindly, thus avoid to trigger further ITE fault,
>>> and ITE fault will block all invalidation request to be handled.
>>> furthermore retry the timeout request could trigger hard lockup.
>>>
>>> safe removal (present) & surprise removal (not present)
>>>
>>> pciehp_ist()
>>>     pciehp_handle_presence_or_link_change()
>>>       pciehp_disable_slot()
>>>         remove_board()
>>>           pciehp_unconfigure_device(presence) {
>>>             if (!presence)
>>>                  pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
>>>             }
>>>
>>> this patch works for regular safe removal and surprise removal of ATS
>>> capable endpoint on PCIe switch downstream ports.
>>
>> this is not the real fix. So this series may focus on the real fix (avoid
>> dead loop in intel iommu driver when ITE happens), and in the end add this
>> patch as an optimization.
> 
> This is the second time I brought it on top of other patches as Baolu perfers
> 
> Bjorn also suggested to take this one as optimization addition to others.
> 
> Anyway, just the order in this patch list, the same result after applied.
> 
> to solve customer issue, this one is needed.

I think even without this patch, customer's issue can be fixed by the last
3 patches of this series. is it? So this patch is not the real fix customer
wants, but nice to have. That's why I think it is an optimization. The
result is the same after applying in mainline. It's fine to keep it the
first two of this series, but need to tell customer what kind of patches
need to be back-ported.

Regards,
Yi Liu

> 
>>
>>> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
>>> Tested-by: Haorong Ye <yehaorong@bytedance.com>
>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/pasid.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>> index 3239cefa4c33..953592125e4a 100644
>>> --- a/drivers/iommu/intel/pasid.c
>>> +++ b/drivers/iommu/intel/pasid.c
>>> @@ -214,6 +214,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu 
>>> *iommu,
>>>       if (!info || !info->ats_enabled)
>>>           return;
>>>   +    if (pci_dev_is_disconnected(to_pci_dev(dev)))
>>> +        return;
>>> +
>>>       sid = info->bus << 8 | info->devfn;
>>>       qdep = info->ats_qdep;
>>>       pfsid = info->pfsid;
>>

