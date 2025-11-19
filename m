Return-Path: <linux-pci+bounces-41579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46CC6C946
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6F814EB1E2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD562F260E;
	Wed, 19 Nov 2025 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FB9Urjfx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39AD2E974E;
	Wed, 19 Nov 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522423; cv=fail; b=s6JLLMvUaOCc1wQwkY/omoG4x8UJfkn+INWATNLM1P12hQ9l7m5ajzNFd6SawGHJDLQYQBvewmVtoRVofzief6sloObUSE3baGpyff2c5S7Fix5VA/1uT0F+Ug0FDZyhtcesQse1k1yY1auPwdQ3Tg99caDQCy8TM+eIUXfL+5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522423; c=relaxed/simple;
	bh=oMM6vTq6BYl5rS1Znogkq3/szVrhZyN06hn/WVbpHG4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=BpPN1vPZZ61c85ivj1nKhNHIs/CV4tPYMLikpPu14DKbPf9wQFU/K0x1xaILRbcLvnw1cXEKg9a+8/41csFjvvz8+oKpub9bKTGq2ptlNFJ8p5bfWov94izkwTAr94AqPnac+NzAq8kCqg4hmR9zTAZrXAdQPkJ5dGCQq8F8I9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FB9Urjfx; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522421; x=1795058421;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=oMM6vTq6BYl5rS1Znogkq3/szVrhZyN06hn/WVbpHG4=;
  b=FB9UrjfxT5eRuf1r9UH8gnCFWVFQeZjiPYPptDRkf92i2J2vwldKNPNN
   3rFv4TYiXcW8uTeOkSrBa+HwR59ldylM/YH3v9C3/DZQn+RWQrme95EHH
   VsRWSaO6abP5lMoqzEJ6F+3hez0+7ggycODC0O80m8yzPKrQdrFpj3NIs
   70fnpV42qg0Hf4zS0bDlFVTERWgDB1zpRVFy4u70Lp1i7fUaDr/OC63OD
   5W7XBWzzwfY+QPsOP0GzYVhRzi9they78tbqBcSVTAmepYH40KIf2reAz
   4ssfhonNIOf35QRHjFVk3tX+QtScNeI/W/7xNTB+LfpumAxxA7kOWkY8b
   A==;
X-CSE-ConnectionGUID: PIV4kLPATEC1xw8qxIrhVQ==
X-CSE-MsgGUID: yuMFYQIKTQGLOCV0bR05IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="91032898"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="91032898"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:21 -0800
X-CSE-ConnectionGUID: c2IpZWXmSpC3IpTJNseMMw==
X-CSE-MsgGUID: 5OiiBKxeRieSsCRsDW6Gfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="191374407"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:21 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:21 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:20:21 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.42)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM9VGSYLufegdBvdzve930UmvP/LpKIvssL74aVIQGlENX8RRUUYmXqiTkmI+UHv2Jr55roD3w+LRqkRAao74sZAjPurBxlrvkyfuOXpgb5eyNTRfGheySpkv9f5ML8cdABoKX8MT8zgKCzwDN/NaLVUf84LrnOm336kmtwksWGruajp1beKOhP03St643lNnSYNY8nc8nv5M2ZVVA61QAjdlCJ8zHBNJptCcCN+43knwD48V7p32/oSC2PBCAMALdK4WYJ18J0bTYChDH5ZB7l6efwLGxOrXzVvLyGGHotGbz/P6akegj+RJQmFYU5tDLONiBpXVjs4i1g0z/ml1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dESC4YKbzpVeL+2VHYQYHUnX5ziIYwE5Za7jaN8NJPI=;
 b=UoQnpe2gL9Mi36hrI13GIQBrdJ1KFdLpi/ZPjBkhusKmyOyETINGIqygMXrBwVRBBdEBEqxSMbRlZWScsuhaaofeHa+auncpN8fq4MpxR0S2+w0ZCuiB3Rm6vrr+N2kZZ8fqh0f11OPcQKFYN53c6Q8s7LitrFbLwgEwwSaA5RDQ7Il+pLUeppnV9sRgwv4783Z9yaG4NwWeiZpcSJp3U1KvKPwQ9sHa6xfJFBvK06D5hLgQE8JBhn+WIx4k9spe0EvfFugpEUDU1ewwbRN1aO50AuL/kVKg0gYLunAyajTHw4gze1cPBgPR1Brb7ziIXYnXeSshoNxDDMu/mNJzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF99DB14780.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::847) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:20:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:20:18 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:20:16 -0800
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
Message-ID: <691d3770de131_1a375100ba@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-8-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-8-terry.bowman@amd.com>
Subject: Re: [RESEND v13 07/25] CXL/AER: Replace device_lock() in
 cxl_rch_handle_error_iter() with guard() lock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF99DB14780:EE_
X-MS-Office365-Filtering-Correlation-Id: 272937fe-548c-4a1b-eefd-08de271a90aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3NrRjB4K1dIRGl1ZGdZTzJPVXFmU2NPdWZjR1lKMUVoZmxYcWpIODRPSTJL?=
 =?utf-8?B?RE1aUjZRWkZnSXV4WkRIdkJEcEd4dVdRS3hKMWVUTWZrRnRiRStWQ0dUMVFs?=
 =?utf-8?B?cVh6R0ZWd2J4MG0vTTlsVlUvOVBESmhlOGNNbmMvYjljcGtNWWxrL2swaTFk?=
 =?utf-8?B?WTZmZU9WQ1JveC9saEZoeWR1aHVTYko5cVZzbmpBZTlESTZscHpHSVdpU1RT?=
 =?utf-8?B?QldQTTZpaFNmMDRYNzZydlpxRzIxZFdhdnhXNTJMemZjVGtvTER5Q0JFdm9w?=
 =?utf-8?B?UGN4ZUNJY3RjNDVlSjdRWjFUeEsrRGVJT0YrN3Rabyt6ZGwwcHB6RXZ3UXRE?=
 =?utf-8?B?aUJmaG4xbnhLMThlK3dqU1l6K1NRNmdEZEVkQnFYTHlNOFZCa01wcTFPTFNa?=
 =?utf-8?B?UkZ1TFlDZHVsWWxDK3lQS2ZnUmZYMDhUdWt6ZCtUZ1FJQVg0aFI5SzF2UndK?=
 =?utf-8?B?c3I0cWV2Y2plUkFuUXdMRkdUY3o2UGxLOFBIcHdtbURKazRGQkxpalZBRS8x?=
 =?utf-8?B?OVRxbDYwYnJuNndzbXEvZFpKWU92KzhSTG1oNXdGYzV4ejJlSmxJQUs3VElO?=
 =?utf-8?B?bEVsNmVnQ2xqb1UrZDNOVDYvM1E2aUk2QVZ4U2F3NDEyZXpPQ1pSOVdSTVZh?=
 =?utf-8?B?V2IwY0NPOFlDajVCakFUVEtzVVRXRUl6dmgxVFd0UXBnRmIzSkhPR1Y1MWdC?=
 =?utf-8?B?YWswZWlIMzNwNlpCOE9sejU3OHhTQ3Urd2U2ak9BczBueDlNdjN6RXArMHRY?=
 =?utf-8?B?cnVsZlhES3lVazR1UHFwRDhZMG4rRFcxeWQ5bmhXbzRoQXZ2R2cvMktsNEFv?=
 =?utf-8?B?WFdaSnM4TVA3V3FJWFVYOU5XangyWFVscUtNOHlvMWFvcSthdTcvMUd2YU5r?=
 =?utf-8?B?NzRVWnpUNW82ZFFjUFF5OWtiVWd0QmpvSVhINS83aWN1OVhlbUlmbUY3TXQ4?=
 =?utf-8?B?ZVpFeEhGMnZyTkZnZ0FmT21nb25ua1BqYW9pZ0FOdFViMSsxcUtkY3NSQUNs?=
 =?utf-8?B?V21wQlJzZjV2YXVudzI5ZDgzK1BXL2VET25RaTJvNHdybGdhSWZ0NHdYc0VT?=
 =?utf-8?B?d0FDSkszS09HTG5pTFppRFVBcDROU1VvV2RGZDBWby9iNndMa1QyazBCblVD?=
 =?utf-8?B?bEplcVNBRjJBUFFHeklPVlBaTU9RdEtZYWRhQ25oellubGliRDZSaUJPczBn?=
 =?utf-8?B?Q1hOSWNCYjFkSTQ5dHVjL1l1SFk0am5xUGdGTXo2NFdHMVQ1ZGhxbDNPTk5x?=
 =?utf-8?B?Z3JnQ3ZZcnc1TnE1eVFVSmJFMURsVVRHWWFHZEdOcFdteEE4WW56QVBNeXQy?=
 =?utf-8?B?YmxGY2FtQUNPbEk2dDgyUDkvdGZLWHFpMDFnOS9yazV2blZNRjFxR3Iya0p3?=
 =?utf-8?B?TDhaSEI0WmNPWjJzV2R0eGhUd0lwa1A5RTNQN3pvRWtNWXg4UzV6RFVXTVlQ?=
 =?utf-8?B?bWJodjRWVXJERzUxdmVXVjNLZmlxMzNQNFZSci9EcU9DMTFMd09OalFpOGNC?=
 =?utf-8?B?YXZNVGp5SzM4bUpmNG9ObmxPR0tKMUpKazN3bWE2cHpxYVNDcUhtQy9pdlpR?=
 =?utf-8?B?alBIbkErRWFOMjBjUk00V2thMlhMTzdnazdka3VLM1JkTzRrTjRXZVJKaGhz?=
 =?utf-8?B?UDFhbHJheXRLY2RKQnp1eWF2OWVzK29RQ0NEL0kvazZpK082MnQ3RW10bHRJ?=
 =?utf-8?B?YzIvNGJ6dzZYc2U5dXlSMnFvNEhPdFpuSzRLcUt4eXhSRE1YbFNHdkt2U3My?=
 =?utf-8?B?d3pJNG1WaFB2OGxOMnI2VkpHWVlqZHlxVGg1M2xZOTQxWFV1cHpDWXhTdWsv?=
 =?utf-8?B?dmhGYTR6dWE0bjAvM3d5M3ZzdDVQMUIxRTNXUHNSbmIxTEdFNFpEWmp4YStO?=
 =?utf-8?B?YkRUK1Rtd2Q2SkRDYmJOOWpPczlOTS8wN04zUXZvUis2S3M4dnhkUkZzZWEy?=
 =?utf-8?B?bFFZYVBwWDlNbE93cFRsR0RTK013MEluVEZxUlhtdHVqTDIrekxJYXhpcXUz?=
 =?utf-8?B?blVHL0ttbFpLRzBkQy9IcHk1SVBqUDF4c2MxeFBqMS9SNS81YXdvV3FkTFBW?=
 =?utf-8?Q?7+h6xC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2htZUN5RUpLLzZ0T29vampPY1B0Qyt2bFhidjdaSG1sMzk3dmdWd0RKNVMw?=
 =?utf-8?B?ZTAvbFJTUk9TYnZkZ2pvKysrcGs2eXdJZUExUUlVL1RsYnBmc3NhNEZtVXBB?=
 =?utf-8?B?QWJiVGF2MXhvMk0xU1ltbkdIZDNRdDVyRzBGa0ZvT2VoK1NvbVhiditNQU9D?=
 =?utf-8?B?RW5adjhmeG9LRjBwWXd5ajQvVlJGOGlkRzl5TVF0UW93Z0pBYmt1cENPQjNU?=
 =?utf-8?B?cDJVZi9SclZMRm1RTFplQ0o5bzVRbXhKOTBsS0MrWGxQQXh0WjI3cFNKd2RI?=
 =?utf-8?B?TlhvVzhkRTE3U3RFZmJscTRMNml5QkV0RHdDVnN3T2o4Q3ZOb0VYOEozUEYx?=
 =?utf-8?B?SEd3bUYxNEloRFBFQWorWEw0SUg5MzFPdXFZblJCdkNnMFlkVUlnRkVNbUlH?=
 =?utf-8?B?M0U5UmpFRmxQWmUzaFk5WDJPWGlvcjZDZ1lJejZPT1pmQ1o4RmpuMVZHYU0w?=
 =?utf-8?B?enZYVFFtTmM5Vkd4MjM3Q0FVWFdvRHl2a2xwb0VlMzY0YzVRdFBUK1dOM2Zn?=
 =?utf-8?B?cGJFY3JDNWRwZkxBUXNCMTM5aGZRMmFWenVWSHlGclZMRWZSL3BkenZvRDhW?=
 =?utf-8?B?RDk3MG8yZld5Zk5HOTQveGZCZ3pVQk9DVjgyYWN1bmRwRUd6aHVTK0FDb1ky?=
 =?utf-8?B?Y21ncEEwWWdUMHdBSFdud0JuUDUrbnRBbmY4bndyalFFcGdkTEsycTd3QUM5?=
 =?utf-8?B?VWRHaGd1Qk5NbkR6OW1OSWRJK01XbDJmM2ZURGF3aWRLUEkyMTVtZmx6TEdB?=
 =?utf-8?B?dW5xSWFWRjZ4UVFSWGV1czFXTXdyYW9NUG0weFVROVZza01vM1VyL2Y3Z2Zx?=
 =?utf-8?B?bHc0MXhvNzZ6SDQvclE4ZWliMUZ4cXZDeXNaenhDTEJLZVlrTllqUEtYMElL?=
 =?utf-8?B?aEQ3L05NcW9WcUV3RmpjaHFZVFZoMzFLQkcxRGdoOFJJVWxwRktEZWxLeFl2?=
 =?utf-8?B?UWpjTDRkQUwrZjhqSm1KSXdWaEhBc3dBVGd0MENIRVBpVHI2KzFyWDU1Vnlk?=
 =?utf-8?B?UG0xTHFZZlJwWmQycDRTZ0Q4VG96NXFXTDhUdFJYKzQwSk1wY0J2cEFRdS9w?=
 =?utf-8?B?WlVTZXY5eTVRNHdUdytKVEJSK3F4bHRvZHlrZEpId25odHdwOUtjaTFHUElZ?=
 =?utf-8?B?Z1d1UUk4d2UrbHdpSWdDNWNPcTY1R1Y5NU1TSS9JT1lISExuUW1iWU03cTNM?=
 =?utf-8?B?TWxLZkZic2xJYkE0NGZOSXZEU0lmUEwrTWlkT05iTmlDYVZGSmtuWWxBZnVV?=
 =?utf-8?B?WGMwbndyVDl2QXBoMFpTcUUvaTQwbCtNVm5TaVFRRnUwM2VWNTRIbGlIMnZG?=
 =?utf-8?B?ZUJmdkRXRlRtdStkMCtpZ2NITmV2K3lrTEg1aDNwaWZaVzVtbXBpRmd4TDVu?=
 =?utf-8?B?VkZqR2lYekYrS0RuZnN3NEdNRDBpWTZraU1VK210N1NSei9STWtwK3N0VXlX?=
 =?utf-8?B?MXlsbnZDUjNYSmNBMDdWUS9aMUpPQ1Bqek9VYWJUcnNoUUc4YzRZbmU2ZWpC?=
 =?utf-8?B?ZXZGdHdBRmpsdUJDU2s5bmNtbmF0a3NCdW1WMVcvRXhjS1BTdlVhQ0E0T0VS?=
 =?utf-8?B?dXNOUjBtbFNpZStSbFNCRXFxQTcyZGhCc1l3ZEJPZmVqUXp1SGlDNW9RNEdH?=
 =?utf-8?B?c01hKzFVU3UyVm5rb0NJa1NlVXJFSFBESkZoRkdSWGtvSjkvYWFsejIzUmFw?=
 =?utf-8?B?YnhPQjhSb09kYUtHRGZrcEcveGZXaUVlTlV5SGVKR3p1N0VXU2FNdEtySEVr?=
 =?utf-8?B?dVlacWNBNmM4eHhTYmVtVUROVFVMOHpkQnlncFZIY2QrQllwZ21JOEtDMjdw?=
 =?utf-8?B?V2V0SkZPWFBveXROTGlsQnRJY281bjV5QmZiYlhTMjNSZ2VRcGZrdW53RWU4?=
 =?utf-8?B?VFc1LzJ1eGJBV3ZpZkdZQVdsN1l4NDhXekdwUkduTE9qaUJoS3Q5eGk3ampQ?=
 =?utf-8?B?Y2VSQmgyUk43SG5RS0R5Qy9SRzB0cm1kUG1uQWRPVGlyb2R0eTV2SFJKaFEy?=
 =?utf-8?B?T3RVcUtjem9HZHR6MWNPSS9vOURpVmRITFRxR2NCVCt4NFFSWEt4MHRvTWQy?=
 =?utf-8?B?Q252QkxqTHNNZzJ2OE01aUx1KzRoZlFpa01kMFV1dHRoMi9aNnhJbDNtOGg2?=
 =?utf-8?B?ejVodXM4SlFvRmY1aVhva3pvV3ZhL0UxNEl6S0hwYkdCa0tZbzN1My92aGc4?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 272937fe-548c-4a1b-eefd-08de271a90aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:20:18.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cgcYLQmvPRue1kLK4DiEAbFJvtIDJcHJV/XRxf0YTplEb7liXmOoqNBZ/rN0U/2S0TE4zDWvxVeYzKgYfS+AAcBiOVe9IErky9djDZk8N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF99DB14780
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> cxl_rch_handle_error_iter() includes a call to device_lock() using a goto
> for multiple return paths. Improve readability and maintainability by
> using the guard() lock variant.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

