Return-Path: <linux-pci+bounces-13201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D010978C37
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 02:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54F228299F
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 00:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926A138E;
	Sat, 14 Sep 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7tS6JyB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8881FA4
	for <linux-pci@vger.kernel.org>; Sat, 14 Sep 2024 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274116; cv=fail; b=LPgJp2B9190lNBhXV07d4GrunlnfJf9RmHxeBQKCc4sULpXTAzYEBNhX3at47uYzFDxEZRpYbjx3cdNtsljczPrLzosq1gzGsPb3GVcHGJ3xT7EmYP0LtP9nOVHkECTbXIwILvMdkblU1GavDlwGJc5FUh9YbYo70jTptIfnVJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274116; c=relaxed/simple;
	bh=oema9+mrkHGU0P1oCUWUN70/qnQqzFA80Ei7PJI2X3M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aAiSlZxQ0kyWKOpshtRavko7tkenC8N5KPSrT63W+mu4A19KhZWXrTVuYTnfB8EWAghUgmAWb3Mu9NwYNoH4Av2A5WjV71BjpwDAlYGIWqdC8lHYOYqpWPO3OE5UuCxlo/nEqCqWNzbF0PLAEwspNRuI6agp3HkA46JvjvabMKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7tS6JyB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726274115; x=1757810115;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oema9+mrkHGU0P1oCUWUN70/qnQqzFA80Ei7PJI2X3M=;
  b=B7tS6JyBp3sGekMv/TwOPNbZBL1V3uVlBMQNYIk6wYqmG5XlW+RI6J2o
   1z+NAbasjcB798YNy+d7Q/lfalE+uPp2KuswZThVbLhLv8Y8BMMb/sFsP
   GKUmrm0t9hFjY6rexTWIcA7fzTxaas6IifQxAj+vNEOGbNNsLKSiGXSGC
   leM8v8IPgWzgjfB74Qo1aoGTEmdgWs1rUj7cxn1Dm7wvWRqtw2P57ncNc
   zTeW57k1+DVQQUJMsi1NJemXu1xBg6hJvsWlxpDsORWfNgXgnWaLk2Opx
   u7B+JRk7QMZe3LwFXwcPFXN0QWf2fWEh0eWV+uHbCe4eoh0J0I/MzX6sU
   A==;
X-CSE-ConnectionGUID: Q87lVhFWQcG2KNxVgU1VXw==
X-CSE-MsgGUID: GR5t0pzDQzanw4mej2xyFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25016278"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25016278"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 17:35:10 -0700
X-CSE-ConnectionGUID: z/0r/baaQTC5NYp7OUgVkA==
X-CSE-MsgGUID: AEb3Sl1vSSePzpossyMQzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="69020515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 17:35:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:35:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:35:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 17:35:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 17:35:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt75Z746lNUAb45EI1iWdNxC2m+x0YtjQmsR4rwpzyBR/rtSVvPlhxUfLf5pOg6nLDbAwOkeDj367AzekVQL27OxjIs0qfKHRQLI1YrdV5gT03hkng4tQUNt5FIc1rA9fm4wMak9Jg5PdUSAYj+92sT2oU0ZQxuYAhQatRThl47+8TSshkelZPIhsYZBQHQ0gdukgx+17EDS/ASZahyDrR+1chhl44tUv9+UDecdzG4SMb4W/mjwDGsDeKlFpu3LEmixDJE+oGTnMiFmYo+2UPlYVfOb7E8Xu0LqisAmlpgSdPrrdTjvcBFphh6gJGZGheFXgHdf8kl3knfvikLKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvZJ6Fh+VBVdl8QKVyA3FmPiccINW8EwYNouXYwzPeY=;
 b=aDGCgdmFQTjYudxZpJ9MhUPCLUzv6WwAmD22rOtMZ1InV1anMKuVn5N+P9r47nXcSYpvtUUDpJG7vyjvLj4Ad7B/x8gAcsWmPasiM731JTD6FZ9UlM5LDw6YwXXyGq75RquoUvVCL9wbFN3OaYBeRWiJvLWDphaj3CuGvVRGnAxhxxHz10ROp3mCo2hTL4QC4DTrjha+rpuXlzmQDhYxTe5Z4AdHiYooI4NrJN/Qsifbqw2apIUfadvHMDXloDgTn0A2IMLw70BkxqP7QLmG1oXzIa+dKF0CdFOf/c06wwFboR6dx8vCHJyRnGO9RicaaOPHeuv0QTP/mGtpHqsCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CH3PR11MB8546.namprd11.prod.outlook.com (2603:10b6:610:1ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Sat, 14 Sep
 2024 00:35:06 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7962.018; Sat, 14 Sep 2024
 00:35:05 +0000
Date: Sat, 14 Sep 2024 08:34:55 +0800
From: Philip Li <philip.li@intel.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, kernel test robot <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, Linux Memory Management List
	<linux-mm@kvack.org>, Richard Zhu <hongxing.zhu@nxp.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Lucas Stach
	<l.stach@pengutronix.de>, <linux-pci@vger.kernel.org>
Subject: Re: [linux-next:master 11090/11210]
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000:
 reg: [[864026624, 4194304], [402653184, 134217728]] is too short
Message-ID: <ZuTaL7f+gp4ux4n1@rli9-mobl>
References: <202409131940.gkwdcLJ6-lkp@intel.com>
 <20240913163249.GA713949@bhelgaas>
 <20240913181218.GA3047723@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913181218.GA3047723@rocinante>
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CH3PR11MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f0d135-035d-4ff2-0703-08dcd4551409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|220923002;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eThURkJRTWkvU3QyQVdlYUxFUkRqeEpsUi9EQTBYZmtXa1d1RGhlL0JYbVQy?=
 =?utf-8?B?NnNTUEgrVkFEa2R0M3AzOEk4M1FtNEVvMWhCS3ovYTR4TDFVczBpSHJNek5y?=
 =?utf-8?B?eituWDdIWXRveEE5TzVSWWt6cmYwdWtpcjM3MEcrVTlLVnN6a1NMT2hRaCtB?=
 =?utf-8?B?QXlSY0JtS2JaZ3RoNVVtbUJjMFNmcml4dEgyMEZYTHd0TkRPOVBWY01QK09i?=
 =?utf-8?B?SFhyVTV2dWhWWmhkWmtZTUIxeVpLT2kzK2NqTnlFRXRJMzhwWVZtQ3p5SkpN?=
 =?utf-8?B?TlZuQ2NPbEtqSzB4UUJ2MzV3ZU9rMlZZSkJxK1M1dWMramt1eXlFdVA4VzNs?=
 =?utf-8?B?dlI1cGl3cWFhUzdndWJkR2RsVWRTR281QStSbTVrb0tqcVBPdjRwWFk0ZUFN?=
 =?utf-8?B?eUFTY2hucUZyd1AydXN4WkVRYzVmRklndE9wUmp5THNGaG4zTXFmNkRmcjgx?=
 =?utf-8?B?NUE1a1BIeXNQbFhFUjRSejNhTXR3RjhVU1R4MVYydmw0T2l6OWpnajFEQ1Y4?=
 =?utf-8?B?MFVIZHZiOS9WcmlWeFIwQUFhV2ZmNFlyTGFUaElyOFNYOXZyVW8vbjA2aW5K?=
 =?utf-8?B?MmZVeCs0bWQreXdtNERrVkJPaXFleW1sY25Zb0drdU9zcjBjVi9lODNLUHp1?=
 =?utf-8?B?aGdRSUd1VWZIWDUzSExHT205QUlCWUVBVk4rTVdESUkxbzZ1VHBabjlwNFVh?=
 =?utf-8?B?aWFpdVExeVNra2swOGd5WnNuSW96Z3B6ZG12WXl2bHcwRjJvY0MrOEJPMW50?=
 =?utf-8?B?ckdWcXJBR0NxWHNaY1JQbmZqRnlWT0NIUWlFd0hMTEFQcC9XOVJTVjdqNm5C?=
 =?utf-8?B?SFlzQ2VTamFGTmczd1FmTmpwb0M3SEQzZlFPMDhBNlg0RHh4aldXVVdXZHFz?=
 =?utf-8?B?aDdDanpXSTVsZ1hjVW5EeExSSHRHTFFIRnp1UlF5d1pscUxaUk54amdHVEdP?=
 =?utf-8?B?Q095b1dLWG1qamJMblV2MTMxZDhUL1M1NFFROGRjcnBtWEk3ZEJHaTRFQ0Jq?=
 =?utf-8?B?K2RkYS9UZWVNSmJ6N21sbVJ6YzhkOUJmWlg1VjRiTkIyOG1zVzlTWk04ZVN4?=
 =?utf-8?B?V1hVY2xXdzlTdlorN2RJRFlCVllzK0tveDFvOUEzaEdzNUVUdXFMY05RUG43?=
 =?utf-8?B?VEhDZEswM3lObzJXNHlRZ090UXVBbE1NZ3ZjTWVBU2xUTEl1Q1FwMS8reXQz?=
 =?utf-8?B?UGdoNzNmNlgraWxQNTlTak1DRFNvY0VmVW4xNW9UN1VsYzFXSXg5ZGdhSGY4?=
 =?utf-8?B?N1RycFRicW5ZRGFnQ0YyQlRwZG5CYlVaSFV6bWxlRDAvUlBvWENwRXQ5MGNL?=
 =?utf-8?B?N3ZrbWdyTjZtWi9na1BoQ2JVYmxYTUVURjQ4WEVIMjVWazZob0tzc0NwZTlu?=
 =?utf-8?B?b1doWHhUWE5kSjA3WHk3VUF1SStJcldTYWMxZjFmVzE5UjFiZ2ZQN2N1RkVw?=
 =?utf-8?B?RFVmTllTN0JTU3BVYkZWeU9YZHl6Z3FNRURNYXA0UlpiTnVOWHUzR2ZZY2Zw?=
 =?utf-8?B?YmZNS1Q1MWN3dnR5bDhyclFadzdySDZOOHNSMGJPOFBaNUQ0bXFrd3l4c01M?=
 =?utf-8?B?TUVOOFc1WWp5QzVFWCtGcW5DSjlWRGxrbUg2TVhqbmZSNGkxWlFXK3hWbkFB?=
 =?utf-8?B?NnJVLy93RHVnNVBSSlIwS1RBVnNrWWtQSGI2MzFWTW9wNHI5SDFySFpNZDM4?=
 =?utf-8?B?aVF3emlqc2cwdmRNem1Icmt3VUQ5MVdRdlNvRnJXWURSSU92aGxRaDl3Q1pm?=
 =?utf-8?B?bkcwbnRqME91REw1NUZ6V3kwaE1OZUlHSGdxYk5vUmIxZndxYUZyQmRHYXhm?=
 =?utf-8?B?NlZxVmRUQ3BtMjVKM09iVVVaNW9odmdzK2E3TW01bHZieDF6eUhXYnBpRGNS?=
 =?utf-8?B?MDdMU3pKRmJFMkkwTUp5a3FFQ1NNTGxJMHgxUTZ4NXgzeVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xpQXpwQ2UrRnhoaExjbEE2Tmw1U1hUNmZsek1qRUdtdDZIOU9zaHRSNzQw?=
 =?utf-8?B?Ly9jWDJhRUIzUXpRdHJwVmlXcjJkQ29LMWpGbzFZcUh5Z1lLOWZDV2l6MlI2?=
 =?utf-8?B?eU9JdGhQWW9HSFJmb0d5cEhUM2R2WUtHL1lFM2liVmdlQUM1MWU0Yng3TmtE?=
 =?utf-8?B?eHQxTGw5dGhiZXplR3NYdnBYZGlyUnlvN21VbUhuY3o5YmxhVDFkK2R1Qkxw?=
 =?utf-8?B?TFVvbmEzZ1ZBajlPbHRjT1hVOVZaVFIrRTRFODZnSW56RG9wVitnM0h1T3JF?=
 =?utf-8?B?Q3NaUFIzUWxNNGIvVWpDdEVvREd1UFlDcFNvNnpCaDBsMjVFSS9taWlhcERG?=
 =?utf-8?B?MTB6MzFIUEdaUGs0Sk5qKzFGSi9ncHpZM2pZRk5uUWJEZHhZZHJvaUtnMUJi?=
 =?utf-8?B?ZU5uK3ZxYzlqQWh3eGVlUEJZUWVsNFRya1BlOENRL0IxT0F0bVdRZWp3ZjdZ?=
 =?utf-8?B?cUtEUkhPV2hFOW1MYi82ZW1HK3c5aEx4ei8ram1TdG9PNm50bGRrdVM0L2ZQ?=
 =?utf-8?B?UWRkRTQwcng2UmdLY2hBOUlsTlE1ZVRRZkUvbktJdlA2MEJ5eWlQaFRSQTcr?=
 =?utf-8?B?aUpEVVNmeWNSK0FqVld6TGJVbmU5RHpTMjJSaVp3c1o0ZzdCdWVvWWIzdXJN?=
 =?utf-8?B?Mjk5eS9YVUxVWFJsVlVKRGpyVDVXelg2ZHROS2dmQmxtT1JnQ0RVM1k0NDkx?=
 =?utf-8?B?N1RRRGNwczNPZkQwV1dseFR2Sy9TTHJjL3VUNnMzSVlhbWQ1YmhHdUZ6ZUty?=
 =?utf-8?B?UVRITk1TdmF2anA2WTNRVDVybmVSNU1UemJIWi9IaFRCbGwyRzMycHFIK0Z6?=
 =?utf-8?B?UWVCUVdaM0VNNmZzYnVtTlgzS25FRjRldGZOK2JhRXlEKzgwU3pBZW5aMENp?=
 =?utf-8?B?QVRmVXZJSTBUUXBtazFBSlVRWXl5QTk2ZWxFQXh5Y1BDaUV4bmRpN25wZGNh?=
 =?utf-8?B?T1M3QU1BQ0tmQWIzcEltMFQzWVF1aUNoZ3J2Y0pLOUk5UWZBbXdVd1RzUW1o?=
 =?utf-8?B?eU43RllzRHZXaEFOdll4UVlEMW94bUMrZ3JGdFJuYUFuQytDU09ZZXl1V2gv?=
 =?utf-8?B?b3g1L3Y2UGlOYVI0M1Zyc3I5NERPRDVlaDlFNVFGcmJ3OGVzV3h0UjlnMnN0?=
 =?utf-8?B?V3RGWW1wOXZIMTFMT3kxcFRFNi9tTEhtTjN2VVF0YWswUkY4VXVuK1NzVDJX?=
 =?utf-8?B?bDliWTVZRTZ1Z0ZFVUtQYnArMllzd08wZGN2cUszSks0dGxBU3FCYWxvNVdy?=
 =?utf-8?B?TlAxWkpta1Z0OFVVZjYyREhVdFZFcnU5N3k0TGNCMDFCUTl0OEpWMkx5YVNm?=
 =?utf-8?B?RnBNSEVWNE8vemRZRHpoRnV2S3ZmTDZrM0VuU0s0aXo4M25lQzRZZisxQkdG?=
 =?utf-8?B?emZaR0tubEFFQTNHNG9rMWdpSXdhRkQyWnI1TXFtSXJjWWlRMzFQTlAxZGpO?=
 =?utf-8?B?alh6Z3ZzZUpXOXhieHJjTFZRejZoR0FZaHZBNjFsdEdaZGZkaCtCeGZEdUpz?=
 =?utf-8?B?dWdkOWY5eGNVbERhZGNoc0pDeWdkTUhwa2tyZERzMGJBYmI1Z1pIOUlMRkpT?=
 =?utf-8?B?dUNQOWx2NUpNbmltUTE5NEo1eW5jT3pMSi9zby9qSGZwUEl2Q3VsWlhBbUhX?=
 =?utf-8?B?WXQ5M0NuVFhmZGtobGJ1bU1ZNXQ4U05qZ3E5WFdRMzMyckowaSs5aTA0Vkc3?=
 =?utf-8?B?RWx1MnNnY1pKSmhBUUpIWmYxRjhYd09CcnNBQVdWZVBiOWZ1aFJRc2hHRWVO?=
 =?utf-8?B?T3hKdnFtS3Zud0IwMVZFVUVrRkdHWGxuMW5zcnBHYVNJMzU5SjhJd2NEUTh2?=
 =?utf-8?B?N2dLK1hMR1ZwTFVoSTFTVHBjSzJWcjBtcExxQUxFSzIvV1lRclpzMmhHTDdO?=
 =?utf-8?B?SmJUT1pvaS9JTDF0c254R1RqLzk1RGY1THFNT1VnRUhqVHQ2NHpLSGZqK28y?=
 =?utf-8?B?TDBZSmNlSHk2alpJSEhCRCtLcnhtTHlsU1libmtLZ2EzSGtBek1maDZvQzlY?=
 =?utf-8?B?blVwVlJVMUhhVEdsV2pHUmYxSlZ1SzNyQ25GSTRWWktQVWpMSDliTVVjTVRi?=
 =?utf-8?B?QzdpZ2xaSXoxUFl6NlBxNDZFeTBwOWJRWUhxZnBMNlAyZUt4MXNIbituV2px?=
 =?utf-8?Q?Q0NE4QKQQxQioFalB47a1aQp2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f0d135-035d-4ff2-0703-08dcd4551409
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 00:35:05.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQpNA3+qFA6TjW4PMKEB96WGrFJinyvO3rewMio2SHey8w16LhxPJ38XSnXsQzFVrsSfabnmKKExXSEDXoeLWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8546
X-OriginatorOrg: intel.com

On Sat, Sep 14, 2024 at 03:12:18AM +0900, Krzysztof Wilczyński wrote:
> [+Cc Philip]
> 
> Hello,
> 
> > I don't know if this is a false positive or related to
> > https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2f309c988b7c
> > ("dt-bindings: PCI: imx6q-pcie: Add reg-name "dbi2" and "atu" for
> > i.MX8M PCIe Endpoint") or what, but needs to be resolved before this
> > gets merged to mainline.
> 
> Philip, this is one of the false-positives, isn't it?  I believe we've got
> a few of these recently.  See below for an example.

thanks for the input, sorry for the noise report. As this is reported against linux-next,
do you suggest the bot may ignore the report on linux-next but only report for mainline?

Or do you mean the issue itself (like this case "is too short") is a meaningless one that
the bot need ignore?

Thanks

> 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > > head:   57f962b956f1d116cd64d5c406776c4975de549d
> > > commit: b099c3ac1a08c08517c1ff05c52a7f5476020b02 [11090/11210] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > config: arm64-randconfig-051-20240911 (https://download.01.org/0day-ci/archive/20240913/202409131940.gkwdcLJ6-lkp@intel.com/config)
> > > compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> > > dtschema version: 2024.6.dev16+gc51125d
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131940.gkwdcLJ6-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202409131940.gkwdcLJ6-lkp@intel.com/
> > > 
> > > dtcheck warnings: (new ones prefixed by >>)
> > > >> arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
> > >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > > >> arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
> > >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > > --
> > > >> arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
> > >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > > >> arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
> > >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > > --
> > > >> arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
> > >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > > >> arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
> > >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > > --
> > > >> arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk-no-eth.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
> > >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > > >> arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk-no-eth.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
> > >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> 
> Past conversation about these errors:
> 
>   - https://lore.kernel.org/all/202407041154.pTMBERxA-lkp@intel.com/
> 
> 	Krzysztof
> 

