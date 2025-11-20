Return-Path: <linux-pci+bounces-41715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 246FDC71FFD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 04:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0A2772C861
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 03:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B82D2382;
	Thu, 20 Nov 2025 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lf1ByUag"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3862DA76D;
	Thu, 20 Nov 2025 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609648; cv=fail; b=pqyLQ8bz5SMZIml/XYlpoUb2khgGDlemwiVNN+ikir6v/x+jgBBFFytN80BnJWQ9DhyBF/7D9+WVPvLTM0yN+gJPRf7fQyw//+Jqsh/ojfj1MdH+tm5DoRCYb7qMkmJjoUuRSYNEBgdpiVOI4eg4dgWF4NaZ1923ucNturslmz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609648; c=relaxed/simple;
	bh=nXg7xnAYLO+jxaeD1259OvfRrOPlLfqGLEH97+Y6xg4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=PEmiJWqfzPTJ+c9G/LNN4Jp4bAPO+C++lewi7GzX0sCzdNisJeKEAGAi6AJraMKfkm+rP2eqpZN5gbNHKxc7kyAHRsQNe1vPCh3NddvPiDxJ6SNC8deisVfJkoJ6Rj3PPSy1y0Yngy80i5acwXiwW89kkD2Fm0rllQR1ejF2vNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lf1ByUag; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763609647; x=1795145647;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=nXg7xnAYLO+jxaeD1259OvfRrOPlLfqGLEH97+Y6xg4=;
  b=lf1ByUag+yYVVsWa1eu4WBmxXY3gI5BNvbL1CIddbwQVWkWh/mciq05i
   JnWQuxiyjaxTRMfpQczDJcEYRS2zRUfVQ0NMPhmgvZ0ldAQiB5hpfgyoF
   cbE4hJ31YbRD812R3xqB/MYMaEHyruPegBrE/z2ony2ceVKoreVs336bB
   O0aOT8q4HGLGGuDb9Oy4PSOAkENF/yJoJpnyNu0KXKR7U9Ly0pLZtdgmG
   flXaoDDUwwmdtBlYgLoaSyyqPhWer3KwJeBr1YmJJu0TT00DoXmGTrpWT
   GgKeuUw3Tc+zVUZc+pUUt6+DmhAuSckFmXIcuxEJbc6pA/bCZGFauHsKF
   w==;
X-CSE-ConnectionGUID: Jt0CxWnYRJSV0b0pduk1Wg==
X-CSE-MsgGUID: UHZnFkTQQuePxalnMortWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65369352"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65369352"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 19:34:06 -0800
X-CSE-ConnectionGUID: VrLfCywwR7KRE2CoiC7FlA==
X-CSE-MsgGUID: KrTVq1KkTzC8h77PW7J4mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="190907193"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 19:34:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 19:34:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 19:34:05 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 19:34:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xr0r/ypnCrfqtn5cL8exvQznHmfkvtEzfo2db/j0CY8fgzWtVsetqP63Fu6t4QV9pN4QszS1YKLl1t3O02IZ9+Yq1QFZCkOi09Wk26Mh/RGJ/PlRc3z9mIfh0IjcsOVKu9ChDTAEfXV7725PJkcft+tIDWE2MAaXp5K7UDKPHgDZYXVnByo6cx1RbsZqCSMN4m8bNbOwUX21VLhm1wpbEMLq0O+sZrThPv05S1S/N42zaKj6uhvjKsSNmhc+ZcCuozV6qB6XG0IA378sTeLoNGQpSnXMGcYme0rQpeSIAPvZScpy2SZY4SilXmJqAJcsjelLhBvfM1xktQOR0FIDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8a7rJyy6E4La19TLiTJW5kwdd3p6Re+9+hEgG96skM=;
 b=PCOlOa3B3/Z9dUt1phlfECxShOzwYLkBBL0lm8FYiQvhAkwKC4pbFJZ8X69w6ZEj8YN/h2VdDJYNRPI1ZO/vGBI3LNj+xJxUKxVUoLk6v++bDvkIkc2AB1FfJHGqKe9Ha/gkPxcKl8uEiVa9taL8KG4Thwzkk4/8leqV1kcXGyvCRHvwM0ozVes/O2h2fMCQt1ZcXQU8NqGtvTq1Qasnwb5M2hnxcwACV5yZcMgHT033f+kYlKNahdvqM4Waip3xuaDvSDamoIbQYjDL9FfYpjGJ66ggKA1iAdo+Q2ZrSVon+s0BWooQQk5OMcXcLz5pzk4BcXexGy8mA23VaGAIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:33:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 03:33:57 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 19:33:56 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <691e8c241ffd5_1a375100e3@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-22-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-22-terry.bowman@amd.com>
Subject: Re: [RESEND v13 21/25] PCI/AER: Dequeue forwarded CXL error
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5063a259-7744-4d14-532f-08de27e5a362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG1xbEdIN2R3YjlqV3NQYm0vNlUvTXVpOE55RkF3VHhIYjNXYnBxV1RHdWpi?=
 =?utf-8?B?d21kSkZmQnZBZFlXNnpWUDFxS2lrbm10T29odnZrY3ZxWDhjR2dyNEQ4MENy?=
 =?utf-8?B?NG5pdlkyYTg4TzNwSG4zclFPWHE5eGRGem5VdFRISis1QytFaENtWGRQZVRi?=
 =?utf-8?B?QThpY3lWOHQ4OWEyOW40Q1h3clhpOTJkZmt0UWdIUGhXUUptd1hTbXpQNUFn?=
 =?utf-8?B?eEl5c3QxblkwdG96eWF5anBCbDNURG5MUE1kYUVpU2tFSGovQXJtS2JtWndN?=
 =?utf-8?B?MHExclhucnFmK01rTDhycFhwZUQzNks2ci9tMjNzaFZYZlNrYWQvQ01yVXpt?=
 =?utf-8?B?Z2NKblRIK0NYa3U0OHRzRjI4YWU4VXBBZVlUR3AxcEp6MlVYUXg2ME1Ka05V?=
 =?utf-8?B?WVFMVC9YaXlqaHdyakc2YVRBb1NKS1R6K085NTBZZTQ3ajY2c3RSOEtQRDBH?=
 =?utf-8?B?OHI2V2VVZDNtWCtleU9EQS9udGw5MFVwY1BNdWlBelBZeG9ZUXNRSUZFVmE1?=
 =?utf-8?B?NThkRWtGZ1AwalZRcFNEMi9FcU4zbGdYL016ejRxSGg1VTZ1UmtIb3hmZUo4?=
 =?utf-8?B?RjNhZXU3eU8yU3pWdUlsVUxxbFM0MjVPQXZ4b0l4cXFZNHhqNEFCR3U2ak5j?=
 =?utf-8?B?RU0wUk9iRkRRV0JMalU1RlpvekpQUjE2OVdNWEpVbVM4UVkrKzA4dS83NU14?=
 =?utf-8?B?eWlITExGWnI4Z1EvdlJqcHBBWUJTR0tiUWpJb2hGdzFhSnN2K05WaGJ5WTQr?=
 =?utf-8?B?MWJVTFM0b1hCbm0yYXd5T1Z6TGxuWFMzVk1MOXZmUm9JdThSMUdGN1lLNjFN?=
 =?utf-8?B?S0lNZ2FXV05Rei93dGxvUFkvUGRrTzh2TlI3NW5kUlpONGtWcjdHUHNDdXJX?=
 =?utf-8?B?bjc4ZmhXNzE1K014ZFBpVVplUmJUM3JrcXlCajY3eUdycEZzT0svVk1WU1lr?=
 =?utf-8?B?YTBaV2hIdGRDQXV4U0dORWQ5c3FLN2VBdnR4KzJpTW5JOGFubFFDR3ZubGZr?=
 =?utf-8?B?NVpFakdlNmdpVm43UnJuUUUweTB5dnI3Qi9PTXpUbFYyOCt1TjVPbUNUM1Jy?=
 =?utf-8?B?YkxLVG1INk50NE9FNDNPN0JCeFpiQTVpRlAzTkFYbDBkRlBCSTZrdDM5MXhn?=
 =?utf-8?B?WFkySmY1b3dSUEFmNlZodGJVcU9KamU5eWNsQlVCOHBEOHFGaEt3TkFkZDdo?=
 =?utf-8?B?aW8rby90VGhaeTJxK3ZwbjMzMzFseGlycy8rWmdzZXJnc2lPSUlXQkdpa3hO?=
 =?utf-8?B?YW1oai9CYUtSQjQ1NHB6TmtXb0FLU3B1bUVLeEJzeVpML3RvcHFvblp6Nkg3?=
 =?utf-8?B?WTBtRkRBdzRTTXNKWFlaNFFlSytYOEdJY04rQjBtemVyUHhtbDRuUG5VcENQ?=
 =?utf-8?B?TkExL05keU9LWmJHRUVKSEN1QzBaWUV4dXY2Ni9DZkFHamtoMnhaa3dVQnEx?=
 =?utf-8?B?UURaalBqUWZFOUlCUmxiY0V6S1l0ZGZzM1cyblVNbGNsMVQvT0E3RGdDaXVI?=
 =?utf-8?B?ZVZQTkpMZDM5UFdnNlB1MVFrL1V0SVQrbmVJOXE5N3JtMHVsUHFURjV1bFBR?=
 =?utf-8?B?SHhTUmR4T2t1b2p0MHFUbUtNWXJENFM2T3ViTnp3Q2NYZjRCY3VHanNEbmdI?=
 =?utf-8?B?MkhUOGJzbU44M2VKNThRR29zN2R5Y0xXRlpnalV3OG5nblBvWTFCR0paaEFy?=
 =?utf-8?B?WXN0UzU3L3RKbkxBNVNPYlpDck1pczQ3SWRvVWZhdmtFTnh2NDVpQmpSTW40?=
 =?utf-8?B?SlVBK2hkekY0QnYxbDBEYWJGWDhrQ3VDM25BeTFiWFBrVzR3NDlPUXl3ZlVm?=
 =?utf-8?B?V0Uza3ZxNFBPWlU1ZXoyV0JnZ25EMWhZZlhLYVdBRnBvb2RkVEVLdWRjMjAv?=
 =?utf-8?B?ME9IT2dyQ0ZHb1ZBcWxSazFRQ0haRnA0WXcrclV2SlpRQTBwVlBnTXloY0ds?=
 =?utf-8?B?SzdPeXRDUWl5aERNMzhMang3VnU5a3RFbkhXdFB2NE0ycEJVVm5yNnVldSt2?=
 =?utf-8?B?ZkE4WlNRcjdqN2xXa2ZHWE1sNTgrMjZWTHdwK2d3TXNTMUtUWkFvM3d1ZWFN?=
 =?utf-8?Q?M1QPLw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVB5dHJLUktOT1J3dzZsUUFURWZ3VlNxcUI3VjNBU09oSVA3ZGFmUkxESXBG?=
 =?utf-8?B?V0JVeERFQTkzZjlkQWx5R0NYN0k4Y1J6SkFUc3Z2emtJUkl3WDIydTNrd0Rm?=
 =?utf-8?B?WkdpQkMySld3Vm55Slk3RXgyREFGOGlPR092ZUlPMnBCd05RWjBvRjNTVW1p?=
 =?utf-8?B?bTVCdS9iY29PWjMrMFFzcGdNdkJUQit4SWMzWkdzNnFZU0pxL1dEdXpFVElO?=
 =?utf-8?B?TmllRVlSaG04VjlNcHdhamwrV1ZhTElUK2VLUzJHaWFoNWtxdm54eGtUWEtt?=
 =?utf-8?B?Rmx0dVp3WnlneERramxXeUJVUDdHa0N3WVZ3K0cyVWRPZ2tEOVU3K3hxZ2tV?=
 =?utf-8?B?ZjkrTFJBVFBKaXJhS053TGlVRWFVNXA0ZExGRE1xSTMyNFZsZHFQUGVxRFcz?=
 =?utf-8?B?cTF1UmxsbFAwallBUzN3d01vREYxVVVPQmlaUjluYWZHMFp3bkgwb3JoVWtT?=
 =?utf-8?B?RHB4dllsRkgrejZ0K3JZWEtPS3RWM2FpN1BaS0g1V1pDMktmeFRCUkwrbm9F?=
 =?utf-8?B?K0JnY2FJK0lhWXhnY1dWRFhlNDUvTFpNV0VEN3h0R0pock1mOFpScnNXcVBw?=
 =?utf-8?B?WkJxaWhsMm9yNFJxODNvYmJ4SnEvSi8xWlFqVzhYQ0ZUcjZ0Nmc1Z2JydWI1?=
 =?utf-8?B?cENMOEFuNXlrSU41T2pNVHkyTzRhK2ZGZEp3QkpIZUE0ZkdEME80Q3hQMFFi?=
 =?utf-8?B?TUV1WG5yRVZBY3BuWmJMMTgyRnFqWmJ6WFVFMldqZ0txb3d1NTdibHhPMDVs?=
 =?utf-8?B?SC9CWWJ4VlBBQ2hMeng2OHMzbnIxRFFzM1N4enJMbTVISUtmTTdKeWtkRG9V?=
 =?utf-8?B?eE5YNmtYUWxwMStlZDRTWTFJNlVpYzhkN1lUWGdHelpRTmVnL2RjUnMzTHFZ?=
 =?utf-8?B?eS9kOUhwbEQ3ZHFNK05idWFEODJzb1JFZTJ3cjh0MGVhNnRGQzdlcVVNeVBV?=
 =?utf-8?B?N2VKTTdyMmMzU1IxQ2kwZWtORHZwcGNHZnBBVDVMVjZKQ2tPOUdkRmR4YU5C?=
 =?utf-8?B?R0xudlFYMzIwcG5SYVVkQzNvdkhpVytiZDVCYXdFb1p3U1VCMlU2L05JYXVt?=
 =?utf-8?B?cXMzSCtyR1JRamRRb1lRbVZaS0FCZSs3Nit6UC9hcDV2V050a2NLSjFWNmpN?=
 =?utf-8?B?aVNob2lObHd5OVZoamFrck9Jbjdpak5mc3BrK1ZQY05xZ2poV21TbWR0dGc5?=
 =?utf-8?B?MUpLVTVhMmREeHVmcHErS3VQRERFbDUyWTZodDBwTFpLM2dCZUxEL2VPRU5R?=
 =?utf-8?B?RzVOZTJVMEpVUkdhYjhXL0VIWVozZ1FleTNGSmtXY2hkZ2xOL09vQjk2VktI?=
 =?utf-8?B?bDZmVTBVejhzZ3lITHpGRGxPSGtKYzNSYTBLcm5MbFNtQW5ZWUcraE4vR3BN?=
 =?utf-8?B?aUl5R1YrVng1ZG9wclFsMDNVZU5GUjhwVUVBUG5mcTdJdWZRbE5BbUxFR3ZK?=
 =?utf-8?B?S2JRQy9NRWc0dy9jbmN4ZzFWZ2VoRWtMQkZPVlo0UjVNMStCWE1sMm0yRGZ0?=
 =?utf-8?B?MC9CeHRKVUM1UVkrdnJkN1dYbU4rMXpXbHNhelVUZVpYSGFoMjhLdDlDV3Q3?=
 =?utf-8?B?NVJ3OGVyNVVpR1ZQN1dlK3BGbmFQTjdTb25SaVJEcXFFc1pXdyt3dUpMcXZD?=
 =?utf-8?B?ZUhqOFBraCttL3RicHJZRVNYbHZhSzdFdWhIYXZTTGlLaTY2R1EweEEvUndI?=
 =?utf-8?B?eFFrYWdhSWpWbHB3MXhJam5qU3JibXlYQnZScjBTcDNQWXowekdkbExXa1dx?=
 =?utf-8?B?b1R1Zjd1TXJRMFppbnN6T25ZS3RhSU1GTFdCNG4yWlJtQXBuUVJzT1phaDdj?=
 =?utf-8?B?QlVOWUM5a0RsaXlFTWx6eW1jRkl5VU1XZzdRWGxYZVkremZFRU9hV0dOTTRj?=
 =?utf-8?B?TWhlOEk1cnZ0SnVLeFhVZTBqdzBKZ3RpakxLcFpLZWNsRW1JRWY3VWxERkRq?=
 =?utf-8?B?RytORjNhTHMzdWlpcHl1VHNNdUV2c3lmZFBXUnd1cStXMG1FRmMwWmRBNVdI?=
 =?utf-8?B?WkRhOHNyNmFCb3JtMnloOEU2QTlrWTRaVkovU2JPbWdqcC9hYXd2eXVacmRq?=
 =?utf-8?B?a25FeFBoV3piaVE4Y0xpNXE2R3BseUYvN3N2bFI0OVNDQ1l2R2kzZ2dQYXJ4?=
 =?utf-8?B?R3JpdUZxNWtWRFFHUGkwNXFpeVljWjdLN2I4Z2pzODhCWUIwck1ZTFg2b0Jy?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5063a259-7744-4d14-532f-08de27e5a362
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:33:57.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9z6RLBaUSg+H+SY7aM0DX7gM1QW1reWCpeSuKtdHsCtnQ9GgLo06f8m3QgGWF9j3CSaIeNyf8sIuxYcEu97a4WcuERyqwf7V2V4wrgnefo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER driver now forwards CXL protocol errors to the CXL driver via a
> kfifo. The CXL driver must consume these work items, initiate protocol
> error handling, and ensure RAS mappings remain valid throughout processing.
> 
> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
> AER service driver and begin protocol error processing by calling
> cxl_handle_proto_error().
> 
> Add a PCI device lock on &pdev->dev within cxl_proto_err_work_fn() to
> keep the PCI device structure valid during handling. Locking an Endpoint
> will also defer RAS unmapping until the device is unlocked.
> 
> For Endpoints, add a lock on CXL memory device cxlds->dev. The CXL memory
> device structure holds the RAS register reference needed during error
> handling.
> 
> Add lock for the parent CXL Port for Root Ports, Downstream Ports, and
> Upstream Ports to prevent destruction of structures holding mapped RAS
> addresses while they are in use.
> 
> Invoke cxl_do_recovery() for uncorrectable errors. Treat this as a stub for
> now; implement its functionality in a future patch.
> 
> Export pci_clean_device_status() to enable cleanup of AER status following
> error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---
> Changes in v12->v13:
> - Add cxlmd lock using guard() (Terry)
> - Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
> - Change pr_err() calls to ratelimited. (Terry)
> - Update commit message. (Terry)
> - Remove namespace qualifier from pcie_clear_device_status()
>   export (Dave Jiang)
> - Move locks into cxl_proto_err_work_fn() (Dave)
> - Update log messages in cxl_forward_error() (Ben)
> 
> Changes in v11->v12:
> - Add guard for CE case in cxl_handle_proto_error() (Dave)
> 
> Changes in v10->v11:
> - Reword patch commit message to remove RCiEP details (Jonathan)
> - Add #include <linux/bitfield.h> (Terry)
> - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
> - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
> - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
> - Use FIELD_GET() in discovering class code (Jonathan)
> - Remove BDF from cxl_proto_err_work_data. Use 'struct
> pci_dev *' (Dan)
> ---
>  drivers/cxl/core/ras.c | 153 ++++++++++++++++++++++++++++++++++++++---
>  drivers/pci/pci.c      |   1 +
>  drivers/pci/pci.h      |   1 -
>  include/linux/pci.h    |   2 +
>  4 files changed, 145 insertions(+), 12 deletions(-)
[..]
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	while (cxl_proto_err_kfifo_get(&wd)) {
> +		struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(wd.pdev);

Why does this function need its own device reference? I think this
handler should match PCI AER semantics where the device validity is
caller guaranteed.

> +		struct device *cxlmd_dev;
> +
> +		if (!pdev) {
> +			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
> +			continue;
> +		}
> +
> +		guard(device)(&pdev->dev);
> +		if (is_pcie_endpoint(pdev)) {
> +			struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +			if (!cxl_pci_drv_bound(pdev))
> +				return;
> +			cxlmd_dev = &cxlds->cxlmd->dev;
> +			device_lock_if(cxlmd_dev, cxlmd_dev);

Ok, I think this demonstrates the problematic usage of
cxl_pci_drv_bound() and the presence of conditional locking is also a
tell that this is broken.

My expectation is the CXL protocol errors are exclusively reported to
cxl_ports. That means that all RAS register mapping must be exclusively
relative to cxl_port::probe() cxl_port::remove() lifetime. Once that is
in place this endpoint case melts away. The endpoint's job is to
register an endpoint-port to get protocol error services.

Given time is short for v6.19 I might take a quick stab at this to
demonstrate the proposal (or otherwise try to quickly discover why the
suggestion can not work).

