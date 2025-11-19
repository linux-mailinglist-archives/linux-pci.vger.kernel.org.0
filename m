Return-Path: <linux-pci+bounces-41685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B69C71248
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8002B3458BF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EE2E7F1E;
	Wed, 19 Nov 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpK3fYTf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999DB2F12C8;
	Wed, 19 Nov 2025 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587408; cv=fail; b=DP1f0CZbQLb27x5RAIPitX1y+yMZ+sqLEkggyrFdUYi1cNCN4sF7JzP7Ob02aO9YLE/rHQx7IhV1pwnc9ScY10I2nd/76WJXJguA9k0en8bM7r3CuKClsAwiGEzz5I1vXPH7Q7rbkDH0mpakXV+n2QhDvdO/LOv9gHm3Nnp3gag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587408; c=relaxed/simple;
	bh=6IUjyhDXdtwHsv1HbzraaDg2QWsjkIUDfR8HdrYbSMk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=bchSGUmoFuOUvQ/RD7tPtZfmaK+dYI78yx8yjTPcAbz0+eARz3+/K9XsdUSEMA548XFzFdOLxChekZGqCDOP4i6GsIEJ8868r8zEz+eLDneMri8ewvfu4L5KKyErWxakOhKbYb7x0aRfhp5riis15JwDM/SzqswurFZduq1rsU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpK3fYTf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763587407; x=1795123407;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6IUjyhDXdtwHsv1HbzraaDg2QWsjkIUDfR8HdrYbSMk=;
  b=bpK3fYTfXEUCclG7rtBuYEDWsollcNg2P+YLB1KE6wnEQqVkiQ9DZMFB
   aOV1dhY85k1ZB3lXBcsDrDXmdf+TxVcqgFZgjG4afTzPpkG4l2JeFfbH7
   ir+C6fk0r/FKxBaAseQG6yGuKHyLgRnEO4eTSeHus3JJZhlXDfaGuzQNc
   tbvBdh3dWa2AWGcSh0s3hgUXScqQYEXg2wTutlW1acIpmij8UpMHGe+FY
   SWeyXTLP+tUPdec5ACuGvgbc9gL3G4gKrQ6e/l51IdPAHzUODLKFLzpsL
   /ZmJ0J6+AmSRq5cuIP7QwSU58Ldi9+GpvpsZuqXCnUl2codN3qaAM4Tca
   w==;
X-CSE-ConnectionGUID: d8Z9kl6kR5K4O2zYoenKag==
X-CSE-MsgGUID: 8m6UDbkKQuakYyosmuxX5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65346719"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65346719"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:23:26 -0800
X-CSE-ConnectionGUID: OxaW7i/5TaqX7vosl5J5lw==
X-CSE-MsgGUID: lGr5EjJqQsma4r5yGWK2Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="190424582"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:23:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 13:23:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 13:23:24 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 13:23:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qik30W1DnE2XhldxaagMWsGnaObYItXb2rPSmYVXOTpcVMViaAw8yN0shU3BJ9iro30tMK1VpNvjtNHixPZdJlheIpVwwyob2RDMRLrYDw8YZWLoUSmZXJkUYObSuq0W+C5f79qYZIMGzVkZxWT/x1kgXVmwwx8NZz+1l9cDlrGqcSotcl9AQtZYJif4GvejnarM7Ax+qNJP1h9/9Yw4PVY0i4apsK+LjwP+qHdwwrpJBIU+qlVMsY8cWqIvgVQGqhtXepC4sAhtZJfmfdVmiPmeKKo2lSO51TDts63r8cqkDU0/4rb9RmBKUypplLFW64Jgv5TdKhw9nGg+69p01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d80riYltEwdSXUf8eurWEAyVLT9L3b9gVVao9tSSaMs=;
 b=K6QRq1K1+0ZhtwS0OHvYWPWFtNQliL/wELI5FDGQfsaMAKG9p22uUPD8MYY+DiYm8Ghz9pFL+1n78zUQWtjjST6FoqOOAR6mfDP0/gYsgo51CjguJ7u8VftRyWn6SMbQAouzm6TjaWIknVQswf11tdsk/6DEDxlyFWU8RpcBlck3q7Zii2QEN/6QALFxL46Mo0DsC0Q5fl4UxfWPGjHzxLqKac3KSYIF5FnuqGUUG7efhIck4DjMc7C+pzC4AZzCoAVbNTENFw5c6z7o+rhJUCeT5xEm2aexK88T6tNf+whSkMXQyDCx9wFXXOlXOvkSlxZLmuhmwoVn0VJHN9BZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9398.namprd11.prod.outlook.com (2603:10b6:208:576::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 21:23:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 21:23:15 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 13:23:14 -0800
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
Message-ID: <691e3542c1b2a_1a37510046@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-13-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-13-terry.bowman@amd.com>
Subject: Re: [RESEND v13 12/25] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c32e03f-513b-4b64-c13a-08de27b1da12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW8xdE9ibEh6dXdxYm9WUHd0SC9RQlhHMHBqUW9HRit2WFZmZ1hCMmszN3ZO?=
 =?utf-8?B?Ty9mSlpVNTAwV1M0RmpYQlh5Nnh5YXdjSU01RUN4eWhPOGlDcjhMK3lYTkls?=
 =?utf-8?B?Nm5vZHRvT1J4KzlNT3ZiTHBMZUNpOUtmK2VJNU5xQUdOdy80K1E0Tzk2bC9D?=
 =?utf-8?B?ZFJFUmI5Yi9RTTFzNXNxN2VsWmIrWVhXSE1IK29mUW9ZdGhKWGpNenphbXpI?=
 =?utf-8?B?dnlmei92NWR1UGJBeC9RRCtoMUgxUFRBblRHa0RkZ0YxZmlKR01Mdk5zbmgr?=
 =?utf-8?B?UEozOU1yTTZqZGwwODJXZ3hQL3ZhOXJWNHpCbXhHOGZuTmt3WTFGUU9lK1cy?=
 =?utf-8?B?OVN2b3Z3WVpJQ2dudEZpQ3Vab2tXbitvVDlmdGR0c0twSmMzZUNGVTFGdUlv?=
 =?utf-8?B?ZGVzZjMvMmNxZTZTVWs2bWZGSjBpUXVaS0xlc0Q2aW9LMGl1N1B0ZjVpZFUz?=
 =?utf-8?B?djI3VkVacGdBWnczdDlDTk9yZEtEemNSN3cxeWhRaUg4VUhlV2ZRTjRPYUl0?=
 =?utf-8?B?MVFMMDNQd1VtNE8vSVVRQThjbzlJVEZqWTRHdjdEZ3NHR1JsVGRDdzFWWlJ5?=
 =?utf-8?B?UWZGd0I3MWEycnBQZjNodGNvVDdWYlJjb3krckNVcm5DK3oySVl6U1o1MFh1?=
 =?utf-8?B?RTNiS3ZCTjU5Uzd4TFUvNDhWRFhzZmxGVUNNNVJEVktQUlRVQUs4Y0IxQ1I3?=
 =?utf-8?B?SXBxdmhJTTVSK293SEw2Si9TRnF3RTBYUEpRbjBqWHhNLzR4VVJ4dTFIb2Zi?=
 =?utf-8?B?N1JYOHB4TDBDTENNLzBOeG9ZWEd1OG45ckIvL3R6MjJqR3VlWXFLVWpQYVJt?=
 =?utf-8?B?dmxWMWo0cHpVRGRDTk05bjU2WlNaM2hqWng5bHVBS3pYY1lNQ1JIQXdYKzFC?=
 =?utf-8?B?VFMrbHZPd0ZjT2dhZldvWFN0MTZTLy81WlpRVFN3TWZLVHY1MTFzemh5L0ZN?=
 =?utf-8?B?NmRZN1BzcDhORW5HdE9wUS84TXFSekNMOUQyODR5UzhDbkYxZlUvdHJKL1NM?=
 =?utf-8?B?b2VoSDl3SXNqdnBvT3R5S29oazRwQnRYK0dheTQ4Mkd5SXorbnZSRmdoOFVD?=
 =?utf-8?B?SnB1bFNrVW95OTI3N3duTDFQQ3ExU1hYT0FFcWpVVHRZa1pROTZXQlVEYTBK?=
 =?utf-8?B?VlFaSkQ3MGpWNjFibVAzbmQrYW5zTDMvYXJ5SnlVK3lqWFR1MVYrMXl3NHpl?=
 =?utf-8?B?bW5FTXVHNUZZdFgvR29PL2RXc0lCQk5BL2hYSEgxTlluQXZRdzcyQzVKYmtI?=
 =?utf-8?B?QW9ueVhnb1V4ZUtmVVlFVGJudTZMUmFLcTNoSU9yUlc2MjNuUTV0MFlGNEZ1?=
 =?utf-8?B?dEpJWnl4R2E2SkhpQjdPT25SeG1zalo3SzZVNE1HUnVJOTcvL2JDQk41VnVn?=
 =?utf-8?B?ZTlJbXZmaGc5TnhwK1VXNDdFOWpKdEJ4aWxkZVRxcHVLVk5jZmxvbitzU3B6?=
 =?utf-8?B?ZWVaN0U1aTl3Q3ZUQ3I5YldkSUNqWTJxL09jbGdLaDNpdTZnWitEOWRtNldI?=
 =?utf-8?B?R3lDcTVRaFNNMlhmYWNnaHdkb0VZSXcyVEdjUmFFZVFPS3BRS2IyOUFpaHhQ?=
 =?utf-8?B?dktOdnUyZEh5bkF3TXg3eEpMK1lTelNVN21zUHNnZ0FkdVFGeVRFWWhFNzFR?=
 =?utf-8?B?RjRNbVZsZnM5ZXc3SU15OTltYmN6RHVQOTJlUVVkRVMvYWN2OWhYV2pGYlli?=
 =?utf-8?B?UFFDbjRkandDMCt2ZFQ4SHFxSlg4U3hiRFBGSml2Yis0ajZ5RDdLY2I5dm51?=
 =?utf-8?B?VGdYSTh5NDROdEtwZjdxLzdKV1FDVUR3cHhRYm10ZzlnKys5UnFFVzF6dzBp?=
 =?utf-8?B?T2FES3hmTVVESVB3SzZNbjNKc0lmV2lxQmtxZGx0RUlBbzk4V3lPUWVSTzRO?=
 =?utf-8?B?K1Nmc2tMNjlBQ1BnOHY1bUZ1c3BhYm9TMFBEUTBjR25GditSZHZQbEtIa1Bz?=
 =?utf-8?B?SDBEclEzRjVuWURRVkNjbjEzTzFycERZeGd2MDVyV0piT3R0U3NudzhxdlZq?=
 =?utf-8?B?dUJEKzkzelJjWUh3b1VLcWZkaG5HR0pVMkZpc2pubFd4a1ZkdUVjYlBxeXUz?=
 =?utf-8?Q?B3/dO0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hqWlY0UTZ0TDRxbDZ3MkdlTDJOWlhxN01jTnVvRGpLcFk5aHRDb1JsNHE5?=
 =?utf-8?B?RVYwd2krREJJT0J6b3dFK0wvQ3F4SXlac2ZLZTZOd3lKKzUvQU5PODVYYWZS?=
 =?utf-8?B?SzNMVEFIZlVvNWNJVEJiL3ZZZmRNL0dlM1dwN0YzSHE4elJ6cjZCNlk4TVA0?=
 =?utf-8?B?RzhVK3lZWWtaeHdqN01pYmQzcUpGaUYyMmVYZ3hYcm1pSjE3R01IbGNCUmpT?=
 =?utf-8?B?Q1I5N0ZDMnFtdjZoVGw4UDVKMnhSNEZNVUlrbFIwNmllazhDMERCSmhLTTFm?=
 =?utf-8?B?NU51RjBrZm52a1RrMFVQdk43NHVIdkVpK0dDYVo3dVJHdVBzeUlNR1RkdW9I?=
 =?utf-8?B?UGFLVHFHRnJWakRIejNGQTJnLzI4QmR0VytvL0hkbHdIMm16bzZWK2VleURQ?=
 =?utf-8?B?WGJpcFY4c2I0dmxrZk85RE5LVlN0ZEFsbVFiL0gya1N4b09GMHJvVVMrTHFK?=
 =?utf-8?B?Y2J2VWJvcUxNQ0RmQnZHVUhja3NpTHlqaFVwZTJIQk1nL0xueUV1RXNaeHJx?=
 =?utf-8?B?aE9YWmFQdDNqaXlSVGNJT3lZTFU5MXA5bm9NVUNpQW53WlJOMWFSNlhyU0pt?=
 =?utf-8?B?c2l3aGtrSXl1Y1NsUmw4SUN4Umx3cDNrYk5jcnBvNE5LYlRqMWMrRVZRUHl2?=
 =?utf-8?B?Y2UzQmp3LzZNajVWdFh3TnR4SGhXbnU1dlE1RDFnYVdYSmhLaGJCeG8zUFNx?=
 =?utf-8?B?ejFhMmUxUTVrdlV2TW1ydTEzUmc1ZFhhR0JMdTZDNno5L0hlYjhyWHMrZUZV?=
 =?utf-8?B?TUF0RDR1c25PM2N5NUowbWdQbEJoWlNKMkczV2plWmZrbDBPc3pMaUo3TFdi?=
 =?utf-8?B?TzdjS284RUFtRjVYWnhmY2djSzUvZTlVQWhPRDQ3M0NUZ1hnNEFaRUU3cFZZ?=
 =?utf-8?B?d0U0bk1MQkU5N244dFNkd3ZNZks4cExjcCs5MmFTbXlRQ2pMamZlU0h2UVU0?=
 =?utf-8?B?aXVXR1Y0aHd6eTNPcm0xUUJFN2xkMkNMMzNWYnN4emtpNFZDRnBFMWVTc1ll?=
 =?utf-8?B?aWF0NklycGFXMlIyNUlIaWF1K0d2MXFML2V3RkRTS1JEZ1c2WURlWXNRUjY5?=
 =?utf-8?B?UktPdHcwalU2ZllMTDRMcE9ma09rSGl0SlVOck5qZGorWWlGVmN6ekRzQnZG?=
 =?utf-8?B?MHJVdGJWNUR3ejhFZUwvZ1A4dzJsMUNyUEQwMDdGZDdGeWk1NDk2dGNDejRO?=
 =?utf-8?B?QmE4cU5YSXBUbForTCtJZDE0TWRLTW9UTGVsVXFQblYrblN5R0Q4TjltV2Uv?=
 =?utf-8?B?WWg3aEQwT3NRT0U0aWJNZjUreklyTGxadkNXVG5nRTQ5TmQrK2I4aG5sbVFF?=
 =?utf-8?B?Y1lpSGdaUVBuL3QxTkg4dFdKb0RWbHcvQ0lWYmtOTDJjVWxFdVZnaVpwUzBI?=
 =?utf-8?B?QlJTVWkvMUpScStSWUZrbXM4UzFGM1FHZWhUVlpwUEN2QTBFV2FsMlNrYnU5?=
 =?utf-8?B?VGtGVG9HMWVWWmpSellreGxIQ0JwZk1ZNzBwVzhwUVc0ODFOU1B3K24ycW05?=
 =?utf-8?B?QVlPWkRiVStMalJEKzJ0NVgyanhoUHU2N3Z0TTBhcmJNRWoySFRtQXpzWDRh?=
 =?utf-8?B?TFd1ZFBKVW1EQTNOZUU5THAraDVKRTZzdmtML1hEUGt2aC9FR3FqbnJtekNR?=
 =?utf-8?B?UUdyYThTd0lzTUhvUDg1Qno1MnZkb1lQNlBKd0UvYlgzS2Y4SmxXNzZ3Mm5l?=
 =?utf-8?B?RUw2UHNFa2NtVnJQZ1dCT3BtRlhMVTFUanU3Q3Z0UkNmR09ybDlnSXZyVlNv?=
 =?utf-8?B?cWM3QW5RdG1OVk9OWm1hMENvaHBrZktVY0VEMWtKUnVpSmJFUlNtWklldHUr?=
 =?utf-8?B?VmhlWk9VUmdEVmI0cEZQN2kvMHdqT0crYkJYZUQrKzAxenFoSzNlMENWaUxB?=
 =?utf-8?B?TjZxcmdLTUhac1VRenFhL2Y3VXJtbWdSSmRXWHljOVZCV2ZKUkpKQ3hLMUkx?=
 =?utf-8?B?Q2FPV3hxK3JZRU9NeUgyMEttcjcya1dOSWxFUFBCYlAwYlVhdXRNai9qQTZx?=
 =?utf-8?B?M2xKcHdjMTdGL2NMMFdFc3ltQmNtR3QzNGVQdnQvTk1Oa1lTdVBnaU1KSmpu?=
 =?utf-8?B?WkhLZ2F6TW1qRzVPa2tJMGNOeE1ZVTJCS2pOckRURkMvcXBOQ1c5Z1Z2TmRa?=
 =?utf-8?B?TWNieUNzN2ltSEFSR3Y5Vy8wdTRFRmlFaVBnYkxKckZ2WkErTzExYmM5NFlI?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c32e03f-513b-4b64-c13a-08de27b1da12
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 21:23:15.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FFd89934l4to1f8UmRxLx/QHCRHNI1rzwD/Wlw+ZN2xYM1oZy8aQAeeJNrkoUK9yePKcReyGKJ686f0iR6wKp/c+SpWya+DrjMenEFFyrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9398
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL currently has separate trace routines for CXL Port errors and CXL
> Endpoint errors. This is inconvenient for the user because they must enable
> 2 sets of trace routines. Make updates to the trace logging such that a
> single trace routine logs both CXL Endpoint and CXL Port protocol errors.

No, this is not inconvient, this is required for compatible evolution of
tracepoints. The change in this patch breaks compatibility as it
violates the expectation the type and order of TP_ARGS does not change
from one kernel to next.

> Keep the trace log fields 'memdev' and 'host'. While these are not accurate
> for non-Endpoints the fields will remain as-is to prevent breaking
> userspace RAS trace consumers.
> 
> Add serial number parameter to the trace logging. This is used for EPs
> and 0 is provided for CXL port devices without a serial number.
> 
> Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
> unchanged with respect to member data types and order.
> 
> Below is output of correctable and uncorrectable protocol error logging.
> CXL Root Port and CXL Endpoint examples are included below.
> 
> Root Port:
> cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
> cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

A root port is not a "memdev", another awkward side effect of trying to
combine 2 trace points with different use cases.

So a NAK from me for this change (unless there is an strong reason for
Linux to inflict the compat breakage), please keep the separate
tracepoints they are for distinctly different use cases. A memdev
protocol error is contained to that memdev, a port protocol error
implicates every CXL.cachemem descendant of that port.

