Return-Path: <linux-pci+bounces-30492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA3AE635B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1E84A7173
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7416288CBE;
	Tue, 24 Jun 2025 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFITYZjc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5586288C00;
	Tue, 24 Jun 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763432; cv=fail; b=CxeLjc3Vc/nyO788ZWUZTS//poyXnPCPPwJ5OtUlxyWMugM//kLGmdTXHTQRs3eM4FTv4bVudvEWkZrrUomU4x+vWedux9vI/Yjy5AzIZkMKhAScmKA8x43m2JpmJXXGJUvqZBkybOQPi/iFa1fWFObGkgotwfBDtPG04if3zhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763432; c=relaxed/simple;
	bh=M3o9QFEClKIGQI+iIf+isvOfzjss4n/R/l/v25iIj3A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnnsYLUlM/nWPunA7eRfIuAMxGrP7/9WHquP6AiF+UUzMmXsBkff+u829uzioD2qKqCqvxfpCh5X9WHcgehGRUOpkvGvPRfL0hJSVhHXG6T6gjL620waKpbhdNr/gLWWMgkOz/WreoA1S9xNV10NOf2at+j65QjugHa3xQcPNug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFITYZjc; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750763431; x=1782299431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M3o9QFEClKIGQI+iIf+isvOfzjss4n/R/l/v25iIj3A=;
  b=EFITYZjcJHTEQQkmgpNG5DT4UuRDM1xpBT4vr7863KgYJAdnfYcw1LY2
   mh0hZhpdUS/E/9VZNBKo36liwtYd3u5I5PhpKljqi1yrFMymYis0iIe3v
   fqZzrE22f9Ivs7z2xll//QQpwrB9RSIl6/6PfBmbrfziv9pJSdN+aNry4
   /AWdFB3pUreXL2xtD5PmzeWKANN/t7+fRXNZXJzUUf1WIZMiJGIyZuJ06
   W4j4hPuHhjVlt94tBvo6Yb9fYX4+UN1WWaI1H3aYwLfkdmmTr6uHli2Be
   50y2KgbWQk8Y1UchpFe60WZkbxIJMMbO1Gf7lBKtH/R+Ui6Xfbw8Mg5TT
   Q==;
X-CSE-ConnectionGUID: E1c8C9OISYSkLjICx0+ViQ==
X-CSE-MsgGUID: a75DINfWRtqG4xO9aCeZFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56672989"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="56672989"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:10:31 -0700
X-CSE-ConnectionGUID: pEQvSl+qTW6My03fjQHpuA==
X-CSE-MsgGUID: LsihWYVzRK+YZzLiDpFJrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152412593"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:10:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 04:10:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 04:10:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.47)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 04:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6fg8B5ewy+ShlM7SNbSVtkiYdHEW+osUbv8WK1Ba5uUF2+UpUgGjrn9Rimumla+CJUk9VesWbkqdqQWZi6b+r/gvgfnIYPpbOU0ZJt+jaEUY5yMfZg7R5eGMrYy+0WVVzEqW8uOroZm0xkeoaBInF7V86auDpsTy3XiPh7kHqVxW+8qf7v8/cj+7PtndpUEFoRUqxXMS59QU2JLWPljhsvHHEsFbP483okVR8rajpdLVhq5ppdpvwWAuPDoE58hgYRYVHWsU/gGHhldADFSOHe8uSY2jkdYJSjKI0oGkTkcBx/d5KCmzLzL8unlvbzIPMU3auhNJwM1d8nJIyJctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xKA8gweVnZuLpp6B3KiXyQA2qXBif43WH6g/2RMbP0=;
 b=A2ryc6WTMvzj4VpkaVjtpB0jdai0O06wr2qCOW1GNN7qsZ9oiNwH1FyNI/ejoXbwdvG+vvBSSzqXCZdi1h/8GLWdP3vdRddZzn/ttshu2orALSUDwUTOYyuVEdpDky3LPrIE/MQwC3wf/GpDAy0g7G5+QEXwwr1nWX0Vn8cPEm5LmCkASmlKPRPZMP2fmcYU3mzmeNBr6/DrXQXB5sUnv8JT3Lo4yKgWWuPBb4qeepf+AMRiZPHUP2ATnsKUK4YpRu6V5jeb6EHxF/IDiQQuxNu9iPWYN+Uemxr9UBoK6A/92gnPm2KP640SFvr3OhgMCe0K9hBrb/10t+2Lh2ChUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17)
 by DS0PR11MB7803.namprd11.prod.outlook.com (2603:10b6:8:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 11:10:13 +0000
Received: from CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3]) by CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3%5]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 11:10:13 +0000
Message-ID: <9bf4adca-ff30-44f8-b9a9-431b02dea620@intel.com>
Date: Tue, 24 Jun 2025 16:40:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,09/11] drm/xe/pm: D3Cold target state
Content-Language: en-GB
To: Badal Nilawar <badal.nilawar@intel.com>, <intel-xe@lists.freedesktop.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-10-badal.nilawar@intel.com>
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <20250529111654.3140766-10-badal.nilawar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::12) To CH0PR11MB5249.namprd11.prod.outlook.com
 (2603:10b6:610:e0::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5249:EE_|DS0PR11MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: d021eef3-1d43-4ef8-d534-08ddb30fb095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkZrZys4T3dLYWhvcnFjbWh0MHB6UWJFN0E3ejd2d1lvOFdwUGxFVW1ncWhz?=
 =?utf-8?B?YW42eWo4bnBsL1Rsc09ac2dwb3FQcHJzZ0FrRmlTUHdLeUxVWnRrRWd2elgy?=
 =?utf-8?B?V1JTbFNRTDBpaStLVk45VUlqOGhaQVZyMnd4ZGIrZERkTTBGRWNkMVZSKzk5?=
 =?utf-8?B?QUtoQlRNSm9SeVVKbE9vcmxFRXR3Y1BPM21UaEZQdDFPMUdQbHdrS0dseDd2?=
 =?utf-8?B?QkFJZjRlMHNvK2h2NVhKRU5NTlFLYTMxS0wyc1Q2TmJMZDdtWFF4cEplOU10?=
 =?utf-8?B?cS9ZaW5YVWsyK1VOcW41bXMrZzQ5UERNTVRSVHQ1UjhVMm96ekhqanVvNFdP?=
 =?utf-8?B?SzYrdmVza2RtNkdWSGtQajE1WVBtT2RpZkpaVFBLSFFPQ2E3VTdtNGlsVXhs?=
 =?utf-8?B?Z01UY3htUFNPeDJmNGpRcFlPVWFsWHcwV3o5UVRxVWpVTFNGLzNJcEM5UjZ5?=
 =?utf-8?B?ZUNIb01tWWVRVUwrOFE5eUc4NW5VNlZENk1YWmp1YVlEUUVOODVod0UvalpG?=
 =?utf-8?B?VXJkQU1Nd1lqTHp1dUN2SjY3WUhOSUJtN1ZuVFVVUG5oWHRRVUQxbm13cG1Q?=
 =?utf-8?B?NWZkZ3V0RlZDS21IOFJNMXRjeDVDbktVc3RwYXNYL0ZTZGVJNkFhb3BnN2dn?=
 =?utf-8?B?ckMwdlRPdGFwbzhqZkNha1BEOVNpamNHTDY3dmpZWlQxOFIwNmVja0p6Ymsw?=
 =?utf-8?B?OEFDSDl2TTJzcVprRlVZeFRLYy9iQjlHNitQTW91emVTWk5WVmFIdlhZWmZi?=
 =?utf-8?B?emRBeDVmSklrWnhobFNMcDFEcFFheVp1bW9iTW12ZnFoTlBtWkVaQW9tOWJh?=
 =?utf-8?B?TDFIdmxWNitBVDA5clFmWlRlRTFtN3c3NHY5MUg3aTVBQnFDbTZFV3BrWDJ5?=
 =?utf-8?B?L2JuQ0Q0QUorUThLRjBGSUNodjVsNkF1a0ZJU21tbjArUE9EclIwbmV2LzRH?=
 =?utf-8?B?ZlAybkladEk1YTFqYVMwS1AzajNUV1EzcHNpV0NvejBPZ2gzUTNkd0FlZHNS?=
 =?utf-8?B?aUlna1lHeUt6VGhnUW5QdjIydXpiemZ2YndCMFJxb1A4V2p5VFZoRTdzengz?=
 =?utf-8?B?WTUzRnFvcW5lVlU3Q1EzVXVEeUQydEd6THZDRC9BSG93Z1BlU2tRZHdwOEZN?=
 =?utf-8?B?Q1FCRjVPeitKUFB1dmw0cExLaEZUYUFQZW90SU1CdXdacVhkaEFNSFdmRWh2?=
 =?utf-8?B?T2Q1SHZvWW4zT3I4OHNuWTZMVWdUbGZQTXZIcjh2QXhMdkdLMlJFdGdzcjR2?=
 =?utf-8?B?QWRsK2djL0haekkyZ3Z5VTFtUlA1SFp4VldCM1RmMUZCdGZDbU5RNmNUalVy?=
 =?utf-8?B?QzZsTFpyWHd2TVhTZHErZUpEMTdHeTVsb1dvU2dFS3NqSWhkN0VuVkpoc0Vw?=
 =?utf-8?B?dWZJa2p0bHNQL0tubnZCMXNxK3VUSXdVeXVyR29ESnpsSzFnV2tUMFB6dnFp?=
 =?utf-8?B?V3lrUm1wU1l6RnlVUnEyVisvZTlyc0Q0UlRQMzV1bk1VMk5XTjNpT1lhU1BX?=
 =?utf-8?B?eE9LbDdXaXlTTFpPYkh2M1pTK0V3ZTU4TExlVnpkYUF1Y2lRZUxpeGd1NGo4?=
 =?utf-8?B?SG1ieUdEZ2cxKzB3Visrem4wSVE2UDRRS3UyTjI2cHQ2M0xmQW5ZdkprMU9C?=
 =?utf-8?B?Vm41RXhZc2dNd1VIZWl5NWdvazF2S1ZoZ01hSjBLZWxOK1pzWHVScHFEeHRm?=
 =?utf-8?B?RzE0YUdySWtiNHpEbExqN21RVjBDVmY3ZzZneEVvWnQyTVYxUmV5M2V4WXFL?=
 =?utf-8?B?SzY0ZEF5RmY2djZDempPNEtuTXV3YjA3TnBxeTNOQzdUbnlGMko3b0ZyVWlO?=
 =?utf-8?B?ZVppdVVuRG9hcFBkWXBBbkJFVEhLT3F3L2JQMlBRb3dZM3FwMFNieUNSQ0th?=
 =?utf-8?B?SUhuRFZlL2xvQVBuU1k0NnJkTytPaGVlSHNTUDFVT0NmWUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5249.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHMvSVRKclhuQU5WOU8zQ1Z2SmVRSmNKNWYwankydmdMT2hwbXl6TzRnVjU0?=
 =?utf-8?B?YXNRSnZ1WFpQU1dOTHh2dzFaWDg5bytrV2NIUDF5MnZCdGxFSFJvd2MwV1Q1?=
 =?utf-8?B?enVjWmNSNTVPdW5GS29HcTVJQ25ER0FzUjlZbFM3SG5GYXBJQm84SzlxZFVK?=
 =?utf-8?B?K0hKblcwdGNpaXZlMUdLUjRmdU1SZ3ZIT1FTYUpSZ3hRZDVSMEdmSXg4Wkdm?=
 =?utf-8?B?VkZvSjFYemY2TzNxWmdqY055b2svYy80UlNZMXFKNjF3UEhRN0R4aFh4YUMz?=
 =?utf-8?B?MTlTVU9vM243Q3BWbkJXVld0U0RmOVBzMnR0SWU1RUg3bVdRandUK0x4S3lx?=
 =?utf-8?B?MmhESnpwakRJU0ZHNXFQWWdoV1FFNTNjOExvaHlSb0hFS2l0VTBkVDhWWlBI?=
 =?utf-8?B?ajh6cVRrbzBwL3JjcUZZL1RHLzNHaEwwYVhYUldMbVJzd2dwZVpqKzJKSks3?=
 =?utf-8?B?THB5OXFNeVBGMmRnQlUraGtVUWtydytmc2xBRUFzbGtVOHVqZ0Uzclc4bWp4?=
 =?utf-8?B?L2dpQkNTaWEyZHRRenh3NEZWK2J3cjhZblkzSmtxM2xjRXN3Wk9ZY1d2SldV?=
 =?utf-8?B?Q0huUnp3bzVhR2ZPOHRGdWFyc2JDV2ZyU0YzS2kzYVV5Y0RUa1BmWitvQ1V4?=
 =?utf-8?B?ZDlnaDE3SzAzVGgveGRtTlBzTzd6d3QvZytDK1M3eXRMaXBQMFg5RFQwYm5x?=
 =?utf-8?B?Mm1MRDVKNEVZdll4Z2lJTDVod1Y2T2JFRjI0RW01dzQxamhtQ1hhbG4yRUR4?=
 =?utf-8?B?YzZHNnpudEw5QU5VYzU2dHFBWmZVOEdKOUxjMWtMNVBUTEpmYkFrWVNOYW5h?=
 =?utf-8?B?N0ppSmdzMVBlcDdXY2wyWWgweWJHZUZ6Qkl1elM4eDNsRXdYYTZBd1lNSElz?=
 =?utf-8?B?YUpRaXJiRFhWK2Z3U1pwTlVlNFVaL2EvV21KT2p4WmhXTGZTeFV6a1pUcGZa?=
 =?utf-8?B?bVQxYTNLN0xEcGw1eW1uNEdxa1d3MjFlNlB2S1RKeXo2QjAyelhpcURMTnl6?=
 =?utf-8?B?SmtwUUoyS0FqaDUzSHowSTN4WWRYUEpUNGhwOXByb2lxUUc4cGRxZTJLSHRv?=
 =?utf-8?B?L3VnRTdCRU5yOHhRTVZPTUpjYktscUR3RFJyNjdDZGkwVmpYTDlQYlBQR2Qz?=
 =?utf-8?B?KzFCL05hd1RaazJaTnJLVURSdmI1S2t4RWV2QW5waFBwSlBWMzZackFaMVZj?=
 =?utf-8?B?UG43enNkbllBZ2NsbHhwK0h5TFdhRlhMNUFuSzc0M3dyWEJQeWVXK1F1QTBX?=
 =?utf-8?B?YUxSQ2J6OTdLUm1VQ0dnQ3RTd2JDd1dONGFmMk5IUTJsVmdPV3paNXpVQ2VC?=
 =?utf-8?B?eXQ5SWFTVkRLWEM1SUNKQVdkZjAweFA4NXp5WjZOUXlhVFk5VG92MkNjdSt3?=
 =?utf-8?B?MUk4RDcxRDZQaTUrOWl1cnVVV05LV29nYlZCVUJLQ3BUN0ZGNCtKeFJCdUY5?=
 =?utf-8?B?Q0RJZm5lWkQyRzhXRmxIZjB0QVRSNklrVVVtYmlndXhKRTBla2lHd1BOdGR1?=
 =?utf-8?B?NlZOQi9wZzVMclRlU3ROaTloT21FL00zT2xPanZMak5vd05kWUc4bm1GVlZS?=
 =?utf-8?B?WVN0R0lFZjFIblJWVTJxR3lSYlE3ekRTd3RQYmxnOXdMaHdWaWRCUzhaazhX?=
 =?utf-8?B?R3pST2h4ZXJUUEJYOWxmbXVOQ1c3WEtpa1ZIODJGWWMvUnhQZ3FmdVdjdW9G?=
 =?utf-8?B?TXBpeTZNK1NYamQxRDhOUlcxK1paNDZPZmF4QXFPL3BEZnZETE9NZFc5M01Y?=
 =?utf-8?B?ckFnR2lscHRqQ3VZTG54Sk5yR05pSG9VR0c2OWdSQmVhVkR4K29zSjdxUWVE?=
 =?utf-8?B?bWZWcGtjdXZ1RXREWVkwMlo4cVpmTGkrUWZPSDVxUkk3N2VJbTlwTWRpc3hq?=
 =?utf-8?B?NUJTQ1h6WVFEeWtGZFREZW1TK1NyaUNNRHhzVGxsanV5cXNTNmY1WGV3dWtp?=
 =?utf-8?B?bVNXWHo5Z0VjdGlKVXhXZ1pVRnhYZzZ5N2t4T0hyUkNzSzl6TDNSckdCNVdw?=
 =?utf-8?B?QjljaTE2bEN3RmRRYU5yVk5iTUhnTlQ0TE5pMUFZZ0drRjhiL0JHeFlBd1F4?=
 =?utf-8?B?Ukp3ZVpmSUdodVBaLzVjWGRsMWJZbU1mTHl1ejJheVBRVnJxTWZYYWlWZjQy?=
 =?utf-8?B?dFBVczJrM2hveGFSZWRaVVlJYjBJUDFYMlRNUzJBRFRmczAvSEo1Q293ZnlJ?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d021eef3-1d43-4ef8-d534-08ddb30fb095
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5249.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:10:13.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzcULdYICtwh+lB+WnVpbY3VdD4aVdQ3Yb/j5yLiWmac2xF6z/JH76SBxWF4P/6oh77PYKAJGl0gZ/0jyv/OkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7803
X-OriginatorOrg: intel.com


On 29-05-2025 16:46, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
>
> Trade-off D3Cold target state based upon current vram usage.
> If vram usage is greater than vram_d3cold_threshold and GPU
> is VRSR capable target D3Cold state is D3Cold-VRSR

rephrase above line to,

is VRSR capable, then target D3Cold state is D3Cold-VRSR

> otherwise target state is D3Cold-Off.
>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pm.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index b86e95493cb5..1e061bfc3e52 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -113,6 +113,14 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
>   			 &xe_pm_runtime_d3cold_map);
>   }
>   
> +static void xe_pm_suspend_prepare(struct xe_device *xe)
> +{
> +	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
> +		xe_pm_d3cold_target_state_toggle(xe);
> +	else
> +		xe->d3cold.target_state = XE_D3COLD_OFF;
> +}
> +
>   /**
>    * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
>    * @xe: xe device instance
> @@ -128,6 +136,8 @@ int xe_pm_suspend(struct xe_device *xe)
>   	drm_dbg(&xe->drm, "Suspending device\n");
>   	trace_xe_pm_suspend(xe, __builtin_return_address(0));
>   
> +	xe_pm_suspend_prepare(xe);
> +
>   	err = xe_pxp_pm_suspend(xe->pxp);
>   	if (err)
>   		goto err;
> @@ -948,10 +958,14 @@ void xe_pm_d3cold_target_state_toggle(struct xe_device *xe)
>   
>   	if (total_vram_used_mb < xe->d3cold.vram_threshold)
>   		xe->d3cold.target_state = XE_D3COLD_OFF;
> +	else if (xe->d3cold.vrsr_capable)
> +		xe->d3cold.target_state = XE_D3COLD_VRSR;
>   	else
>   		xe->d3cold.target_state = XE_D3HOT;
>   
>   	mutex_unlock(&xe->d3cold.lock);
> +
> +	drm_dbg(&xe->drm, "Xe D3cold target state %d\n", xe->d3cold.target_state);
>   }
>   
>   /**

LGTM.

With minor commit message change above, this is

Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>


