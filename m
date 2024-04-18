Return-Path: <linux-pci+bounces-6437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9488A9DFB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588951F21478
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1E165FB0;
	Thu, 18 Apr 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eI0j2z2w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA53168AE3
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452866; cv=fail; b=CgC39EaUXxP9+XM2dFahj+dLEz27NkeFuxPTz18/c1nufyl3IyoehdP6DUQ2HqIP1Jm4Uzp+G+k8n28nUP+qzCXjIhTQPsmICgh4D3qxOS31/FezQlw8UwYxZA9wSNn651MPR06isdNyyVc85UGMjIakiNAbS2tV3edh5Nd5ya0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452866; c=relaxed/simple;
	bh=jZ7mlmTlXnA9lZGs1nsyikcBAdiia0L5wwrF6PkwszM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGb21W6YNu2J5CdPbADmSN0LDuraDtPJzubOfHEF3H9gPwBdbq5OehRYpqN2uTVvwPpmyNiTEqJjvo0vm/OelnUysEPcK5QL2O1pvmkQaCYO8YSc9KfjEIgg50Oqc/nErmW/jdquWido0PuiMEjzxizFIok7dq7DMkv3wqVbMoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eI0j2z2w; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713452864; x=1744988864;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jZ7mlmTlXnA9lZGs1nsyikcBAdiia0L5wwrF6PkwszM=;
  b=eI0j2z2wy3sJJaVCN6cKXSvbLR4RbxE8LT1FvVyryB6/zb3CQs16JuOA
   GBSTYEi4gNCuczfVqWwNgk5aIV/Ch8/+Y9376VeWokIhWnW5rCFyJcSSr
   9FRjZR0K2WEfOLgS/NHUz8I8sLNunPp45gvxf7kmzGGjjpFjnPlk50Eeb
   t0DveIl5e4oQ9lL+5mIx8IBgAPQXyrPemVI9lBHiFbKEEEKPKW1ZrkcWL
   gK+xovlP8anCyANwg9sONEJfKpqvFHxbs1BW0XHEovfwNyp7E0CZ7jqON
   nIxvDWT6zuJJpifYj7WyC8OjtlLqX28ITnZjzTHbigCS44pQNEQ5XO02E
   Q==;
X-CSE-ConnectionGUID: Xqru+m4dR8GAJgmFqKk/uA==
X-CSE-MsgGUID: prAggEoZRr+TZwcBg6IGIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12794321"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12794321"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:07:39 -0700
X-CSE-ConnectionGUID: GjyPT39fSvai57vwwi3dyg==
X-CSE-MsgGUID: IlCowIg+QYSSU8KJxTtFGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27679554"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 08:07:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 08:07:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 08:07:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 08:07:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxrrmdkqW7iYlITN9jrOXJVrnubduaLcTkiOlZwVRQlfgeUcDyujMC59BAO1UyP8ALA78R8NQbMmJFYTBkTMLlmk8/d1KnA3JO9TaKijbl5iLH+aHSEAbJwK+TSnW8EO5EtC9UuKNPslqbo+fVr+FOMkoL7XNhyWTiTnBaq+M41KNMoQnCDc3085qfje61iZt1DQx4FcFQhQYz9XQhO7281LMco+BPS0CCekomn0CptuNGAf28Ll2TCXWIkGb605FPqODLeHgQ2G1N/Z/7HBgybLRkbqPN/F2ULdgfLFg1iumB3PsAIobzeDSggIszTsKGED+MfzJPcOt1WfqetqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emAW+rB9vvfVLS4JdCqzv6Fc2dpWFH/zQ3AQasuNsgg=;
 b=Inzqb8ST2WDKAL7PWRjIE96DakmtsrqdmlcDV969QGhvwF4YX6ISDpgX6aqKs17PrJrJ+T59cEND6tWSWN/UXy3KB5E75oA8tYK77STUZTFfHdHZELKp79qM90X6oN9rq5DS2pDg4/ntTZ//oKtb/5GapnLvEQZ56J4LxAfb9a4NnHxrd0DX0b1a96l1l/AXop3e31ZVaTXE3dWKLkrw30yyXj5UPKWkFug3f6/in5QhE05vNPKkweHesNQ+wKf3anLZ+kb2vfOpazveMmnRJrvPeX6mSZlx24+rvM0mrcDXp4qZnIk0zfOF1AeRm/FfRSfcap2LwdhzD/MVMDfBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by CH3PR11MB8153.namprd11.prod.outlook.com (2603:10b6:610:163::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 15:07:28 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7472.027; Thu, 18 Apr 2024
 15:07:28 +0000
Message-ID: <f2f050c0-178b-4841-bd2c-3a7026481c89@intel.com>
Date: Thu, 18 Apr 2024 08:07:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Keith Busch <kbusch@kernel.org>
CC: <linux-pci@vger.kernel.org>
References: <20240417201542.102-1-paul.m.stillwell.jr@intel.com>
 <ZiBgeYVQRLWPs_ZO@kbusch-mbp>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <ZiBgeYVQRLWPs_ZO@kbusch-mbp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|CH3PR11MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: e07517ae-4038-4664-c6e4-08dc5fb94344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJzJAb8vfSkqY9AfWEHdUAk/R2xtp4Hlq/B1OBZpuu1jnRemi43BieORTl0ii426yhlbTusf9NfL3DB4kevkbNsOSnqtKbUn+hdL38l0YHTrPDcxk0sgHukyGA/HD7rG9XSToTbw3rwPaWAqbkd+XKpZfoz97Cp6dskh9pr/JYqjxGeu8UmJx/QVqGh5f8OfAAVBk8aNjbR5gdSTKnN62/HU0D1DgGP2h8ofzVHJN8tDPJX5HC3pWJsD/M19X2g4rZjhuj/6kPdD7zXfzRW4U41YDDekRkPlw500ao6eycn8cTVbv3lPsY9J2lF3IR7DSoQjxvcimJHcomL1SxLVH5s0SYj/JZ31CIC+pbchVmM7qf/ngvoZS4/Jw3UOKNk44KG9dShMsaQayVYGlmw9+BuDHT65UZu812K2rFXFxX4LS8njCRRkO97MkGu7YTfv00GpESfSK44pqPSqCH7lmNLZOK6VdExHo5CwsJZr+CnY5ylTUTH0GSMQBqIb+dmd9Z3TL4IoMg9UrFPzZmGuZd3a1SifY4+3NjIfY0K3a6Yum5kD5v5e+6jETt1Am7GxAvofyfHWVdTtUvxoqzNP2PW0/hv5laYGZkytFb4eYvrSfTjOprEoW+L6219ROcnR6gVFLSCP/IlMKr8hFkRj/SnvlC7cbAT0GlLG9Tk/348=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnhyd3p6d2ZGb3hOUUJCcytsT3FoSEQrNktyN3Z5Tm1wc1VWT1NPS2EvNDBY?=
 =?utf-8?B?ZWNLamM1Rk9YdVFMcmhYVHVXVURYUEx1d1dEdEtTek11OUtNbjNXMGhmNXhG?=
 =?utf-8?B?clRmVkp1QzRBOWtRcXliKzFEMUxYdTNsUFd1VG9NMVhlMmQ1b1k3Z2ZydUw0?=
 =?utf-8?B?R3JEVjJNL3JsSGNkUFhqdkRMY1YxVEF6dmhXQVFOU296UHQ3OUFxcUlXRGFq?=
 =?utf-8?B?ZjJKK1QxWXQ1bkMwZXJSVzE0bHFGS053Y2xMTFJuS3dzWlJXaHRwakdBd1Jn?=
 =?utf-8?B?a2hHNlBxWEk4VFpSZWxIUTUyUUtFd2wrbXlUZEtpMGV5a3FybWN4UzlBWW93?=
 =?utf-8?B?ZGV4K2N2ZU9hbHJhbjY0dDY4RFZxc2lNd25XclJOelZpRTRzOGx0LysrUHJH?=
 =?utf-8?B?VmpQeUgyM0pPZ3JNL2M1L3IzYXhxZWZlZzJrRVFsWWxMNEx5SHZOOVpZa05Q?=
 =?utf-8?B?UWdLZFpJdllJTE1lRENJWllucUFkdWY5QXU3T3dUVVNNTmdFWXZRQVhVYmZN?=
 =?utf-8?B?bmw2MHRKdVdaa3c2T1greDI0bDRJSkpRZ1ArK0hhZjROcHQ2VUN0dFh6a3Vt?=
 =?utf-8?B?SXVsKzRST1k3SkE0ZHhRZmtBUTJEZ3lSeEF4NEI2WTlrbEdBUHBRRTBPUWRl?=
 =?utf-8?B?ZUNVd1g5ajNrZHRPUDBnR3lPT01INDJZaEk4SFBUbkVCTWJxU0RLRnBBSlZL?=
 =?utf-8?B?NGdRSEVYOUdVQ3pmMzFqNnZPMTBmenRDSVhQM1FTVC9OQUUyUHZJc0pJUXYz?=
 =?utf-8?B?VkNydHhlQ3owai9JVGRqZVVEU21HeWV6RzhTVlJIQVZFeDFhbUgvdllXdWdr?=
 =?utf-8?B?MlFqM1E2b01qemZDT0RObWdtbytLSFcyWXpsRktYTFZFbGlBV29uVWpLNC9Z?=
 =?utf-8?B?bURSY2ZDQ0JRakhuTWoyNjFwYWF4UzkxRDBoem5WaVBRUjBLUU80eGxNOGtV?=
 =?utf-8?B?VUErWFRCQlZWMW44Y0ZFSGlJVnZPSklzVlFYcHl2WDd3R2tUblRyYlBMTHJG?=
 =?utf-8?B?aVU5RmIzU2M5VzIxay9FL013MFV0M3Z4ZVJ1Vm13TEgxYnJ3T2N0TDg4cWFE?=
 =?utf-8?B?MGQ3VTlja2xsdE44UXFQaXdOWkdwbGNTY291NHhXRFUrZmV6NUhqeUh5Vlow?=
 =?utf-8?B?QnpDMnY5ZVhla3ZTdm9iNW1wWkdlOXkvdlMxTkpYMkI2OUNNVW95ZGZZS1h1?=
 =?utf-8?B?VStKbHkyN29ZYXAyM1dDNTZuVThzMTI2S0kzR3FnQ2ZSdXBLNFhyYkwwbUt1?=
 =?utf-8?B?dFdNbWk4NFJqdnFBL0I4UzVxc0lWamJWdW4zRkxYUXV4emtYYkQwclpVTGI4?=
 =?utf-8?B?cnVyc0JOVnQ0UG95YzVweVdoeGZqd05vTlhSKytuNmdTdTFzRmMyOUo4NW8x?=
 =?utf-8?B?VjJaKzJoQ1F3NllkZVZTZTZtcG1OSEg0VGlYMFBKVUdFNnlRKzE0OXpydW1o?=
 =?utf-8?B?YWozVmE3L3VTd2lrZWlxcDNNTnB3TVZnekRkY2NyWERxM3E5cWFvVGczTGZm?=
 =?utf-8?B?Z1JsZ0dqcnNmdUJLc0pLZDJTNlBMQ3lNTUlUQWRHMmRDZUk1Z01sellNMXlz?=
 =?utf-8?B?dGJydkxKRzRPM2drcGk4MXZTMGFyR3lST1RER1NScXNQc1FkWDVIZWY5eFQ1?=
 =?utf-8?B?d29tNFp0U2svcTJhZlc2bXVTZk9KQUZRK3I5NGhsYmNyRlJoMmg3aUp4WkU3?=
 =?utf-8?B?Z1orV2ZkaG1lU2pndG9tMTVJUFBVOVFIWXNQbUloby9meWNOeXg5RDhIMFcv?=
 =?utf-8?B?M0RLSEljdWpZSEJvM01jL3FsOUxQQTMzcy9McmRUbTdTU0VVVXgxL2oxaTkx?=
 =?utf-8?B?UGJ6cXB5ZDlEV1pnekJPUno5THg0bElhNzhnTkNmYWlXY2R6ajlZZURSSmZ0?=
 =?utf-8?B?TkxHVmtSc3hrSjk2Q2p6b0RkRjhYRU4rNmpzY3JNeTlJdzA5bENCNW9XLzFP?=
 =?utf-8?B?WVB0QW54bmpiUC9lSnNseGpGdmhZaDJxMHFYby9HYlBnVGhJYTZxTHoxT3BQ?=
 =?utf-8?B?TjlXWUdTVFNRVjBJR2RGa2ZsZm5qMGErWHlUTzNYci9zYi9BblFOVVM1aHY1?=
 =?utf-8?B?UW9TMFVpVVo0a3lZWUdHbklRaWJRNWE3NFZMV2NMVlk2MDlXci9mK0FBWmpK?=
 =?utf-8?B?b1F0MGZTbTRrYTZLNEhEWDJoV0M5djNvMnllRDQ0TWdUci9EMndJMmpHaktK?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e07517ae-4038-4664-c6e4-08dc5fb94344
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 15:07:28.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGlfGpzD+Uvevb4xT3ajAlM6P4iDRmXfg3K6T0aMYBXbQVcMmXdQ5GZXnYn5L+WleDSW2zW1G798MUMMA7WW2Uhjog7ir0sgBVvWWQBa4FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8153
X-OriginatorOrg: intel.com

On 4/17/2024 4:51 PM, Keith Busch wrote:
> On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
>> +=================================================================
>> +Linux Base Driver for the Intel(R) Volume Management Device (VMD)
>> +=================================================================
>> +
>> +Intel vmd Linux driver.
>> +
>> +Contents
>> +========
>> +
>> +- Overview
>> +- Features
>> +- Limitations
>> +
>> +The Intel VMD provides the means to provide volume management across separate
>> +PCI Express HBAs and SSDs without requiring operating system support or
>> +communication between drivers. It does this by obscuring each storage
>> +controller from the OS, but allowing a single driver to be loaded that would
>> +control each storage controller. A Volume Management Device (VMD) provides a
>> +single device for a single storage driver. The VMD resides in the IIO root
>> +complex and it appears to the OS as a root bus integrated endpoint. In the IIO,
>> +the VMD is in a central location to manipulate access to storage devices which
>> +may be attached directly to the IIO or indirectly through the PCH. Instead of
>> +allowing individual storage devices to be detected by the OS and allow it to
>> +load a separate driver instance for each, the VMD provides configuration
>> +settings to allow specific devices and root ports on the root bus to be
>> +invisible to the OS.
> 
> This doesn't really capture how the vmd driver works here, though. The
> linux driver doesn't control or hide any devices connected to it; it
> just creates a host bridge to its PCI domain, then exposes everything to
> the rest of the OS for other drivers to bind to individual device
> instances that the pci bus driver finds. Everything functions much the
> same as if VMD was disabled.

I was trying more to provide an overview of how the VMD device itself 
works here and not the driver. The driver is fairly simple; it's how the 
device works that seems to confuse people :).

Do you have a suggestion on what you would like to see here?

Paul

