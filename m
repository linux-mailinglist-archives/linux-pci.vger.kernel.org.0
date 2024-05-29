Return-Path: <linux-pci+bounces-7954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61F8D2C5F
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 07:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF241F2473B
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 05:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3615B569;
	Wed, 29 May 2024 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvtjdFuj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F315B567
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960116; cv=fail; b=DNsyoeq2R1NQEs1SVH5KBz6v3GQeMx389kLuK3VTJAF6Ku01SRrQOJNMUfw1jjnQaAYIn2JrkC3e/5kchKDPuPPOt7nmkQEU45/6G1P8r2A+sTZmBvDf2koOZHHieYKKUxFDeKqOQqVI2xLaVHLHtd8wNnpgajnBIwwbHDC6Voc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960116; c=relaxed/simple;
	bh=xgINOr7EYECNSO0EGS4jlB3uVFgsslazvFt+a1ZtAms=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NhhrIaH92+4vOub1GsARkubhbyvi8Kha9RafntPCOgOA9N3+r1Ze+ya1CXYIip7GTW4hApQ5XyVBy6EQftmrPOIW0tviil43UgGePotB8SQTarYD/iy78/U9i/FBpL+BofEcHfOPGmpvUdxonJXrNkxDHrEYch/2DFNmVnWv8Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvtjdFuj; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960113; x=1748496113;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xgINOr7EYECNSO0EGS4jlB3uVFgsslazvFt+a1ZtAms=;
  b=bvtjdFujRrOdteoo30iud54BLDs3Nt1y+zMrz0/Yc4HZ0yMhp+2ZiCJr
   M7apI4TjnJLSI2+maS+GN/ll3bHDzKONNY6hiUi/VAL/2vq+meMh37EGJ
   LYu0vGBaqe6QMneiw6ZtnYiOpt7sLWbsILhYx+mKJRH4anOkc6naMLgQR
   C+XkwW1Gcm/T4DBYtn0Su7/ZiuGe8mcTa4IM+PlhQOxxrx5/B9kWbq3gu
   QWl3WI+k0lcowateznezdh91Qmnp5DgU2wy+rVmnXVkuwi/tk+BRDR9LZ
   mflTEYfx9KEoy+blKjOtGlEq4Ne2QKrH0Ombm68fMbGor3arGPEybRZqE
   A==;
X-CSE-ConnectionGUID: NFB4MW75QQqUGO+B+vLV1Q==
X-CSE-MsgGUID: Bh6BfJ/HT/+wAlchvmPhCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13183591"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13183591"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:21:23 -0700
X-CSE-ConnectionGUID: QH8hkrp2RwSmHyttU4HCRw==
X-CSE-MsgGUID: Y6qvUkLlRGaEXQl5S3pCRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35252737"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 22:21:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 22:21:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 22:21:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 22:21:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 22:21:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClEl39LaI9CIt5c4p/t2op6TPzusFobj7uhmi0BaTSa2jq7NMaXBtFD90sU88UBkbQ0w1S+jfFFYtDGMW3Clja8WM0Ix9/euZEtRVcqPdhXMkNSrL7bdvzkrDeXSA+oPuAF3LIMrJqzhy/bZEkAfRs5NB3C4ddS2Z/OQE6JARQ8htfc1OL2tZT86nYHucleMZ7/eGvCh6dZ5ArNLt06oR4CVolKA3VTH0GQs5tNegyBszcWhUHXazmOA8Zm1YxjTcoSv2TBT+b/hee9jcYbuKyIIjqaI0p8Y2VwR4miNpUNCztu2U3dEFC67r8bh3goWl7e7XHn+pvSr7vqfbDVTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YP1IYnG105rVdPgnJ6dXT7W6z/GI+xLh9SsYVBqh9Rw=;
 b=UqWQG+BcwdQ89k7vW9RlfJOnJgIvgJuMlAoGhs/H2krDyZWmKHSgdSL7YsNQIi2NF2agFMTsyg4iyEmpM98MrR/qi/jj7beIWfsdhQJMAx8Pzf2Q8dYWInoZXNqAVWq0C/E5WjFAnel8PGRDZIUle3lJgATMOhjri6/+ahaj/3OxQDdMVPWb386I+eR42H9L3yRMO4jL7v3uem5wGckS6Qnc/OwTYc74Z+hGPx/bpyaNfFzpovudTsRU2+/X1vZyEZvekwOwomnkdA6WLt29HXc0lf2SNn3xJbgOm16iH/+OdSv7Vju2RWSOvWB106T12xR1faQVswL5BxRPTs+XGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 05:21:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 05:21:13 +0000
Date: Tue, 28 May 2024 22:21:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	<linux-pci@vger.kernel.org>
CC: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>, Arnd Bergmann
	<arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
	<dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, Keith Busch <kbusch@kernel.org>, Marek Behun
	<marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
	<rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <6656bb4654a65_16687294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4ade62-f8ef-42e6-aadf-08dc7f9f286a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Lyt5Y0c3Y0xYSXdyelBzZ2VLRm5YUi92ZEpFbWlvSytpTHdIR3JmQ09lZEYv?=
 =?utf-8?B?TUhWaWgxQWFGZzF4WjFJenRWcWxaWElpd0ZsMStnUlZUTXBvZW8vWDRCNzh3?=
 =?utf-8?B?YVJjQjlkNHQ2ZC8ySGpTM3I5N05aMkVzejMrbW1RNEhNaVRJL055dEYvaDNG?=
 =?utf-8?B?VDJDVm5xNGRKMnBGWktMbjFlbFdOR0tCRzZiSVk3eXRmTkZJUUFTd0dFSWh4?=
 =?utf-8?B?dUZha0Z4SXBBWE9zTGU5V2lYaHUyVFcvUGNZaUNvdWRSYTFkRXJuYjd1OUhk?=
 =?utf-8?B?eG1zSDAwUklzK3B1OFF4Z2JzRUtsZDcvUkpkL1FKS2JoUzV5Z1FablV3czVm?=
 =?utf-8?B?UWEraXJyaHY5QUpudTVqZnFWWEgra09PQVFPUjR6N1dGZTJTc2d6WDFhRGtS?=
 =?utf-8?B?Tm50L3Jkam53M3VrWHlzSXluYUlQa0xBUDVta3lBdTdoNkpDNTNrQ1JYaXN2?=
 =?utf-8?B?NjloTFNMcjBZWnRqaUJaN3BsK1FWb0lnQjR3WnNJdGRQSS9EWkdFVDJVZEVF?=
 =?utf-8?B?MlNsVWRwdUdaY2MwY3E5a3BEU2hPdDJkRDF1RmhPdnlic2NHbm9YNWliM0Ix?=
 =?utf-8?B?UTFIUDNuSTZ5TWVkTmtaSm9GSTgydzJlNEhzL1l6amp1MHVSazNGZW14QlhX?=
 =?utf-8?B?RWRnYzZ3dTVac0pESU5LUVJjNjF3Q05TOWpHK3Q0aUdwOEJwaFFvaXVYSlZQ?=
 =?utf-8?B?dTNIcW9xY3BQOER0N2hoa3phN2dFYm9wa1l4WHhCWVh5K041aFlKakZpRklW?=
 =?utf-8?B?QUJ2dkF0NDBpTGovZXBFamZBTjdKUC93T2dGYnczazFqYVVpekp6V0M3dXRs?=
 =?utf-8?B?Qy9sNFJzS3UxajV3UUdNVjVwaDdhWUdBckpGdWVaWllZYWhZcFVmYnVsYVRN?=
 =?utf-8?B?YnJsNjFJQ1JaN3JQV3JlbEp6bTdmOUJyUGJDaFlzZ3BEc1VIWk0xR2hzcWZC?=
 =?utf-8?B?UDJ0TldyV3lLSklzYmxSaWxRQUFCZmFUWCtZTnJ1aFZmWDlDSTNOYWRWbDVO?=
 =?utf-8?B?K2R1cSt1aW1uRjZDNi8zdEZWZ1p6U05ETDRVNzRIeWxIQWRONWZtL1RyR3Bz?=
 =?utf-8?B?STlSQTBUQjdOTEtLbkZEekxqcUhJSW9wdkRhRFpSczhlUVZGK0c0bnJEbjl5?=
 =?utf-8?B?em1TSEg2dzFNdGxtQjZMbkR6QkR0YU5KckYzODZaalNTbDVpdzBzZk0wME1l?=
 =?utf-8?B?ektQV2lldkQxUTBTaUdZMXVWTGhMZHAydDNXbFdSY3BlTmcyQUFUOWZYY0F5?=
 =?utf-8?B?dncreDhKbzUxV0lHK1krUU1NVDVjVUFnbTArR2Y3Ly80cms2RUNEN29DZWlT?=
 =?utf-8?B?a0F2YTJuREZtQlc0ek9Pa3BhMTNpSDNKbzczbE91MTlwTTJNWitjWThFc3Ix?=
 =?utf-8?B?SGtwNlkxNWIxNWJXa0xUaXFFbTg5UDR6Q2J6bjQzQndkZGN2ZGRjSzJYdEcz?=
 =?utf-8?B?UUJNUXlKbnFmZWNYWlp1elprZjVDY2JSRUJtTHk4anp6WU1XN0dPdVlnOXUx?=
 =?utf-8?B?eWNZQVpXYzBUcDc1blVLL1B2cGpYOXVNNGVsRytyY1EzTHl1RkJwTk83WEsy?=
 =?utf-8?B?emtNOExpNTVHWVlDcFhEQmk1dE9OK2hJVDJkTzlWVkl2NjQyMUJrNlJEcEZP?=
 =?utf-8?Q?7CsKGAxVl8xm8TFLABUnm7rvGqd5b1Mcl45EVV2uVzZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXJodkVTNGt5N2JWVTdlZ1l2ais3T2NleHRjTkNvcVF2L25YSnhoM25uSE9O?=
 =?utf-8?B?VXBaaXdWYzhLdGc2Wml1dFdhSVE1SjhVTWdRdXFaK0hlODliRlo3MlJ1bmIw?=
 =?utf-8?B?Z1RmS0NvZDlLajg2ZXIzOWx0bWU3WlFYS3NEblNvUEN6d2x3SHJEL2tOMlJP?=
 =?utf-8?B?TXdDVEU3WUJxbFBCa1FiRkxYcXhlbjdvZExPOGdUNWhiWU1SN0RLaTE0czA4?=
 =?utf-8?B?OCtocHdTNUMzejJ6bzBVakpWdzBHRktlbVFXNWFuMDRnRFNRZHFKRll3VEFY?=
 =?utf-8?B?V2pjNzltNmJOWGt6NU1CMUFRS0VnNXJVTUgrQlhMYUNhOWdpY1RTZ1BZUU9R?=
 =?utf-8?B?Vi90U1dTaStPeVBUWDRJQmdrUXpPWDFnS29zcjIwVU03cEFPTm9YTHM1alAx?=
 =?utf-8?B?Vm9lbnpldGlEVTAzRUpxWUlWUjkxN1dKdVRyUXZUYmtHVVN6eVkvTi9lWU1q?=
 =?utf-8?B?WXdqM1FKc2pPTXdldXdRVE0ySmsvTTNzSy9QZ1JqanFva3JGemIyTnNQaUJh?=
 =?utf-8?B?UUp4MXh4YU1zWWhkTU1hck4zREpPT21zdDhNOE1RR1g2SG0vckR3QmdOcmRI?=
 =?utf-8?B?YXhhK2ZlQ3d6ZHhlenFKaXE4dG96SW5pMmRwdTBTaDJjOEw3bklKYlc0bHQy?=
 =?utf-8?B?RDZYMjdsOThMT2VsOUxLTGZjVVJaUmdKWk9YcDFZOHlqU24zVWdLVEFQaUxP?=
 =?utf-8?B?c0RMYUpUWVk4cXZNZHViZTBOdFdLY29ucUZLZkJpLzlvWThWLzlpYkFaS0R0?=
 =?utf-8?B?UlF0YXZsSjhnTStvdm9qRFZ6ZlhKZEdDYUUzWWpMcGtWMHF2MzhmSFYrVmMv?=
 =?utf-8?B?czdsME03SGo5MUpaMmIxUFcrVmRPK3g3OWZhOFRFd3p5emdPdjN4UHk2cTNM?=
 =?utf-8?B?bXpmTnFmbVdFYzlZMmYxNUhOemI1MnpQajNCVU52VGxaZ25lb0xGcGl5Z1Rp?=
 =?utf-8?B?UlJ3MGRlYm50Z2pYYlNRVlRBLzJwaHZ1KzNjQWx2UHNtcytHY2tQK3o2b2lO?=
 =?utf-8?B?cjIweVZMNTJpditwSlNpZ1l3SGNVbHdONzYvZnFrazBlTkNyMDhSRitwT0pW?=
 =?utf-8?B?NlZRSU1RTWFJMDdEa2ZLVGZBNFk4c2t0Znd5cU1KMzBYR3N0T3J0dFVYaWta?=
 =?utf-8?B?cTQrdjlZazh3MzBiNDNGSWFoUlNkQmhOckdSb0V3cDM5NnF6RjZBS1Uwek1J?=
 =?utf-8?B?T2RCSktGQnFyODNtc05nK1dEeVhMR2k3SG5kWEpGd2xnVFNvVUVVdG12M1FR?=
 =?utf-8?B?Q3krTGZvNUNLVXZXNlQzVC9UM3B5Qjd3R3hQUXJMNjFmNWh6QWVLRXM2bElk?=
 =?utf-8?B?VVZLV3hFNlJqTkRVc3JGZzcwS3lta2VvbmFPWWJkZlFocnUrZ0pwTkg4M01p?=
 =?utf-8?B?TFlMSzhwUkdTU0tRakIxVjVMbUdoMzdBK05LNERuYzYzQ3M0ZUhTS1ZOSUJ6?=
 =?utf-8?B?V3IrYkFZMXhNL1hPRE1wZDNqcXh1aXllaldmcjB3WjRQLy9KWjZJUUk2RVFx?=
 =?utf-8?B?dDg4M1NXb0gzd2pMU1JDMGhlVXVCQnIrVEF3dm55TUNWQUhvYlhoRVcvd0tV?=
 =?utf-8?B?MzJOYXFyb1pOVDlZRnJ0RDBQeHdZcnBlVlV4NXlTdGtoL045TEg3bDZrNjBG?=
 =?utf-8?B?NGtVQ2ZhNEFwSm5PUmgxNlpPcjhycEkxYWMxNERTRUFXdktSMTllTk5pc3B6?=
 =?utf-8?B?bmVXNWdRY2dZOUdZOXV1eHMvbm5JZ2M1RmtyZUJiQVNtbFlQMzE0aXdTSTNE?=
 =?utf-8?B?SGowVmM4VTJxSWFsalA4TkZzdTJhOWdEMWRwc1FzRGhMbXExcDc5RkFwWC9u?=
 =?utf-8?B?RUtJY2Q2WTRXUExGckFsUjNHdWwrOGwwYlRVbUxSazkzL1lTMUtTVGFaK21K?=
 =?utf-8?B?bEwxUVZkNWE0YnJaRWdXVU9VUThiekg2cEZmSWErZ2pDTisyNkhUZkZNVXdW?=
 =?utf-8?B?RjlpRmoyK2tIa1JzRVpLSXBmcHhycEpzaEwwd2Q3cHl4K3kxV2JrZ1RBSGQ5?=
 =?utf-8?B?aFFxVWxzLytOQzdNMGRGRVA1eDBWS3VmMUNoLy8yMVpxTDIrYVlqYVlMdkcv?=
 =?utf-8?B?TExaUkJGbHpRY0JkV0gvRGNHb2FTUGtuc2hWalFSR29vL2wwQmFGODBoeHZP?=
 =?utf-8?B?OUJsNWcvaGpzZjlaNlhjTWlnYmhRVnAwSndxbS9mZ2Q3eTVQYWxuekhub1pr?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4ade62-f8ef-42e6-aadf-08dc7f9f286a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 05:21:13.5869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gzb7SjfYTZvUsKbg49JwQcSXIiEPviYxi5VHQEFKIN91DskjRCdn/AADTYJ6S6oA/WYJbWhYydHAzr0izzBBV5yerzmhuVNLeSD3jKxs65g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
X-OriginatorOrg: intel.com

Mariusz Tkaczyk wrote:
> Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> managing LED in storage enclosures. NPEM is indication oriented
> and it does not give direct access to LED. Although each of
> the indications *could* represent an individual LED, multiple
> indications could also be represented as a single,
> multi-color LED or a single LED blinking in a specific interval.
> The specification leaves that open.
> 
> Each enabled indication (capability register bit on) is represented as a
> ledclass_dev which can be controlled through sysfs. For every ledclass
> device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0).
> It is corresponding to NPEM control register (Indication bit on/off).
> 
> Ledclass devices appear in sysfs as child devices (subdirectory) of PCI
> device which has an NPEM Extended Capability and indication is enabled
> in NPEM capability register. For example, these are leds created for
> pcieport "10000:02:05.0" on my setup:
> 
> leds/
> ├── 10000:02:05.0:enclosure:fail
> ├── 10000:02:05.0:enclosure:locate
> ├── 10000:02:05.0:enclosure:ok
> └── 10000:02:05.0:enclosure:rebuild
> 
> They can be also found in "/sys/class/leds" directory. Parent PCIe device
> bdf is used to guarantee uniqueness across leds subsystem.
> 
> To enable/disable fail indication "brightness" file can be edited:
> echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
> echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness
> 
> PCIe r6.1, sec 7.9.19.2 defines the possible indications.
> 
> Multiple indications for same parent PCIe device can conflict and
> hardware may update them when processing new request. To avoid issues,
> driver refresh all indications by reading back control register.
> 
> Driver is projected to be exclusive NPEM extended capability manager.
> It waits up to 1 second after imposing new request, it doesn't verify if
> controller is busy before write, assuming that mutex lock gives protection
> from concurrent updates. Driver is not registered if _DSM LED management
> is available.
> 
> NPEM is a PCIe extended capability so it should be registered in
> pcie_init_capabilities() but it is not possible due to LED dependency.
> Parent pci_device must be added earlier for led_classdev_register()
> to be successful. NPEM does not require configuration on kernel side, it
> is safe to register LED devices later.
> 
> Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>  drivers/pci/Kconfig           |   9 +
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/npem.c            | 410 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |   8 +
>  drivers/pci/probe.c           |   2 +
>  drivers/pci/remove.c          |   2 +
>  include/linux/pci.h           |   3 +
>  include/uapi/linux/pci_regs.h |  34 +++
>  8 files changed, 469 insertions(+)
>  create mode 100644 drivers/pci/npem.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index d35001589d88..e696e69ad516 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -143,6 +143,15 @@ config PCI_IOV
>  
>  	  If unsure, say N.
>  
> +config PCI_NPEM
> +	bool "Native PCIe Enclosure Management"
> +	depends on LEDS_CLASS=y

I would have expected

    depends on NEW_LEDS
    select LEDS_CLASS

> +	help
> +	  Support for Native PCIe Enclosure Management. It allows managing LED
> +	  indications in storage enclosures. Enclosure must support following
> +	  indications: OK, Locate, Fail, Rebuild, other indications are
> +	  optional.
> +
>  config PCI_PRI
>  	bool "PCI PRI support"
>  	select PCI_ATS
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 175302036890..cd5f655d4be9 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> +obj-$(CONFIG_PCI_NPEM)		+= npem.o
>  
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
> new file mode 100644
> index 000000000000..a76a2044dab2
> --- /dev/null
> +++ b/drivers/pci/npem.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe Enclosure management driver created for LED interfaces based on
> + * indications. It says *what indications* blink but does not specify *how*
> + * they blink - it is hardware defined.
> + *
> + * The driver name refers to Native PCIe Enclosure Management. It is
> + * first indication oriented standard with specification.
> + *
> + * Native PCIe Enclosure Management (NPEM)
> + *	PCIe Base Specification r6.1 sec 6.28
> + *	PCIe Base Specification r6.1 sec 7.9.19
> + *
> + * Copyright (c) 2023-2024 Intel Corporation
> + *	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/iopoll.h>
> +#include <linux/leds.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +#include <linux/types.h>
> +#include <linux/uleds.h>
> +
> +#include "pci.h"
> +
> +struct indication {
> +	u32 bit;
> +	const char *name;
> +};
> +
> +static const struct indication npem_indications[] = {
> +	{PCI_NPEM_IND_OK,	"enclosure:ok"},
> +	{PCI_NPEM_IND_LOCATE,	"enclosure:locate"},
> +	{PCI_NPEM_IND_FAIL,	"enclosure:fail"},
> +	{PCI_NPEM_IND_REBUILD,	"enclosure:rebuild"},
> +	{PCI_NPEM_IND_PFA,	"enclosure:pfa"},
> +	{PCI_NPEM_IND_HOTSPARE,	"enclosure:hotspare"},
> +	{PCI_NPEM_IND_ICA,	"enclosure:ica"},
> +	{PCI_NPEM_IND_IFA,	"enclosure:ifa"},
> +	{PCI_NPEM_IND_IDT,	"enclosure:idt"},
> +	{PCI_NPEM_IND_DISABLED,	"enclosure:disabled"},
> +	{PCI_NPEM_IND_SPEC_0,	"enclosure:specific_0"},
> +	{PCI_NPEM_IND_SPEC_1,	"enclosure:specific_1"},
> +	{PCI_NPEM_IND_SPEC_2,	"enclosure:specific_2"},
> +	{PCI_NPEM_IND_SPEC_3,	"enclosure:specific_3"},
> +	{PCI_NPEM_IND_SPEC_4,	"enclosure:specific_4"},
> +	{PCI_NPEM_IND_SPEC_5,	"enclosure:specific_5"},
> +	{PCI_NPEM_IND_SPEC_6,	"enclosure:specific_6"},
> +	{PCI_NPEM_IND_SPEC_7,	"enclosure:specific_7"},
> +	{0,			NULL}
> +};
> +
> +#define for_each_indication(ind, inds) \
> +	for (ind = inds; ind->bit; ind++)
> +
> +/* To avoid confusion, do not keep any special bits in indications */

I am confused by this comment. What "special bits" is this referring to?

Make sure comments are something that can help you remember 5 to 10
years what this function is doing.

> +static u32 reg_to_indications(u32 caps, const struct indication *inds)
> +{
> +	const struct indication *ind;
> +	u32 supported_indications = 0;
> +
> +	for_each_indication(ind, inds)
> +		supported_indications |= ind->bit;
> +
> +	return caps & supported_indications;
> +}
> +
> +/**
> + * struct npem_led - LED details
> + * @indication: indication details
> + * @npem: npem device
> + * @name: LED name
> + * @led: LED device
> + */
> +struct npem_led {
> +	const struct indication *indication;
> +	struct npem *npem;
> +	char name[LED_MAX_NAME_SIZE];
> +	struct led_classdev led;
> +};
> +
> +/**
> + * struct npem_ops - backend specific callbacks
> + * @inds: supported indications array
> + * @get_active_indications: get active indications
> + *	npem: npem device
> + *	buf: response buffer
> + * @set_active_indications: set new indications
> + *	npem: npem device
> + *	val: bit mask to set
> + *
> + * Handle communication with hardware. set_active_indications updates
> + * npem->active_indications.
> + */
> +struct npem_ops {
> +	const struct indication *inds;

@inds is not an operation, it feels like something that belongs as
another member in 'struct npem'. What drove this data to join 'struct
npem_ops'?

> +	int (*get_active_indications)(struct npem *npem, u32 *buf);
> +	int (*set_active_indications)(struct npem *npem, u32 val);
> +};
> +
> +/**
> + * struct npem - NPEM device properties
> + * @dev: PCIe device this driver is attached to
> + * @ops: Backend specific callbacks
> + * @npem_lock: to keep concurrent updates serialized
> + * @pos: NPEM capability offset (only relevant for NPEM direct register access,
> + *	 not DSM access method)
> + * @supported_indications: bit mask of supported indications
> + *			   non-indication and reserved bits are cleared
> + * @active_indications: bit mask of active indications
> + *			non-indication and reserved bits are cleared
> + * @led_cnt: Supported LEDs count
> + * @leds: supported LEDs

It would help to describe the locking model here since the comment for
@npem_lock is not adding anything useful.

> + */
> +struct npem {
> +	struct pci_dev *dev;
> +	const struct npem_ops *ops;
> +	struct mutex npem_lock;
> +	u16 pos;
> +	u32 supported_indications;
> +	u32 active_indications;
> +	int led_cnt;
> +	struct npem_led leds[];
> +};
> +
> +static int npem_read_reg(struct npem *npem, u16 reg, u32 *val)
> +{
> +	int ret = pci_read_config_dword(npem->dev, npem->pos + reg, val);
> +
> +	return pcibios_err_to_errno(ret);
> +}
> +
> +static int npem_write_ctrl(struct npem *npem, u32 reg)
> +{
> +	int pos = npem->pos + PCI_NPEM_CTRL;
> +	int ret = pci_write_config_dword(npem->dev, pos, reg);
> +
> +	return pcibios_err_to_errno(ret);
> +}
> +
> +static int npem_get_active_indications(struct npem *npem, u32 *buf)
> +{
> +	int ret;
> +
> +	ret = npem_read_reg(npem, PCI_NPEM_CTRL, buf);
> +	if (ret)
> +		return ret;
> +
> +	/* If PCI_NPEM_CTRL_ENABLE is not set then no indication should blink */
> +	if (!(*buf & PCI_NPEM_CTRL_ENABLE))

It feels odd to reuse @buf like this.

I would have a local @ctrl variable and before returning do:

   *buf = ctrl;

> +		*buf = 0;
> +
> +	/* Filter out not supported indications in response */
> +	*buf &= npem->supported_indications;
> +	return 0;
> +}
> +
> +static int npem_set_active_indications(struct npem *npem, u32 val)
> +{
> +	int ret, ret_val;
> +	u32 cc_status;
> +
> +	lockdep_assert_held(&npem->npem_lock);
> +
> +	/* This bit is always required */
> +	val |= PCI_NPEM_CTRL_ENABLE;
> +	ret = npem_write_ctrl(npem, val);

@val is too generic a name when it is known that this the control
register value, how about call it @ctrl directly?

> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * For the case where a NPEM command has not completed immediately,
> +	 * it is recommended that software not continuously “spin” on polling
> +	 * the status register, but rather poll under interrupt at a reduced
> +	 * rate; for example at 10 ms intervals.

I think the use of read_poll_timeout() obviates the need for this
comment. I.e. read_poll_timeout() is self documenting.

> +	 *
> +	 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of NPEM
> +	 * Command Completed"
> +	 */
> +	ret = read_poll_timeout(npem_read_reg, ret_val,
> +				ret_val || (cc_status & PCI_NPEM_STATUS_CC),
> +				10 * USEC_PER_MSEC, USEC_PER_SEC, false, npem,
> +				PCI_NPEM_STATUS, &cc_status);
> +	if (ret)
> +		return ret_val;
> +
> +	/*
> +	 * All writes to control register, including writes that do not change
> +	 * the register value, are NPEM commands and should eventually result
> +	 * in a command completion indication in the NPEM Status Register.
> +	 *
> +	 * PCIe Base Specification r6.1 sec 7.9.19.3
> +	 *
> +	 * Register may not be updated, or other conflicting bits may be
> +	 * cleared. Spec is not strict here. Read NPEM Control register after
> +	 * write to keep cache in-sync.
> +	 */
> +	return npem_get_active_indications(npem, &npem->active_indications);
> +}
> +
> +static const struct npem_ops npem_ops = {
> +	.inds = npem_indications,
> +	.get_active_indications = npem_get_active_indications,
> +	.set_active_indications = npem_set_active_indications,
> +};
> +
> +#define DSM_GUID GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,  0x8c, 0xb7, 0x74, 0x7e,\
> +			   0xd5, 0x1e, 0x19, 0x4d)
> +#define GET_SUPPORTED_STATES_DSM	BIT(1)
> +#define GET_STATE_DSM			BIT(2)
> +#define SET_STATE_DSM			BIT(3)
> +
> +static const guid_t dsm_guid = DSM_GUID;
> +
> +static bool npem_has_dsm(struct pci_dev *pdev)
> +{
> +	acpi_handle handle;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return false;
> +
> +	return acpi_check_dsm(handle, &dsm_guid, 0x1, GET_SUPPORTED_STATES_DSM |
> +			      GET_STATE_DSM | SET_STATE_DSM);
> +}
> +
> +/*
> + * This function does not use ops->get_active_indications().
> + * It returns cached value, npem->npem_lock is held and it is safe.

What about this function would make a reader think it was unsafe? It is
evident that this function does not call ops->get_active_indications(),
just as it is evident that it does not call kfree().

Would a better description be:

"The status of each indicator is cached at init time and only updated at
write time. brightness_get() is only responsible for reflecting the last
written/cached value."

> + */
> +static enum led_brightness brightness_get(struct led_classdev *led)
> +{
> +	struct npem_led *nled = container_of(led, struct npem_led, led);
> +	struct npem *npem = nled->npem;
> +	int ret, val = LED_OFF;
> +
> +	ret = mutex_lock_interruptible(&npem->npem_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (npem->active_indications & nled->indication->bit)
> +		val = LED_ON;
> +
> +	mutex_unlock(&npem->npem_lock);
> +
> +	return val;
> +}
> +
> +static int brightness_set(struct led_classdev *led,
> +			  enum led_brightness brightness)
> +{
> +	struct npem_led *nled = container_of(led, struct npem_led, led);
> +	struct npem *npem = nled->npem;
> +	u32 indications;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&npem->npem_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (brightness == LED_OFF)
> +		indications = npem->active_indications & ~(nled->indication->bit);
> +	else
> +		indications = npem->active_indications | nled->indication->bit;
> +
> +	ret = npem->ops->set_active_indications(npem, indications);
> +
> +	mutex_unlock(&npem->npem_lock);
> +	return ret;
> +}
> +
> +static void npem_free(struct npem *npem)
> +{
> +	struct npem_led *nled;
> +	int cnt;
> +
> +	for (cnt = 0; cnt < npem->led_cnt; cnt++) {
> +		nled = &npem->leds[cnt];
> +
> +		if (nled->name[0])
> +			led_classdev_unregister(&nled->led);
> +	}
> +
> +	mutex_destroy(&npem->npem_lock);
> +	kfree(npem);
> +}
> +
> +static int pci_npem_set_led_classdev(struct npem *npem, struct npem_led *nled)
> +{
> +	struct led_classdev *led = &nled->led;
> +	struct led_init_data init_data = {};
> +	char *name = nled->name;
> +	int ret;
> +
> +	init_data.devicename = pci_name(npem->dev);
> +	init_data.default_label = nled->indication->name;
> +
> +	ret = led_compose_name(&npem->dev->dev, &init_data, name);
> +	if (ret)
> +		return ret;
> +
> +	led->name = name;
> +	led->brightness_set_blocking = brightness_set;
> +	led->brightness_get = brightness_get;
> +	led->max_brightness = LED_ON;
> +	led->default_trigger = "none";
> +	led->flags = 0;
> +
> +	ret = led_classdev_register(&npem->dev->dev, led);
> +	if (ret)
> +		/* Clear the name to indicate that it is not registered. */
> +		name[0] = 0;
> +	return ret;
> +}
> +
> +static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
> +			 int pos, u32 caps)
> +{
> +	u32 supported = reg_to_indications(caps, ops->inds);
> +	int supported_cnt = hweight32(supported);
> +	const struct indication *indication;
> +	struct npem_led *nled;
> +	struct npem *npem;
> +	int led_idx = 0;
> +	u32 active;
> +	int ret;
> +
> +	npem = kzalloc(struct_size(npem, leds, supported_cnt), GFP_KERNEL);
> +
> +	if (!npem)
> +		return -ENOMEM;
> +
> +	npem->supported_indications = supported;
> +	npem->led_cnt = supported_cnt;
> +	npem->pos = pos;
> +	npem->dev = dev;
> +	npem->ops = ops;
> +
> +	ret = ops->get_active_indications(npem, &active);
> +	if (ret) {
> +		npem_free(npem);
> +		return -EACCES;

get_active_indications() returns an errno, why translate to "Permission
denied" which is likely to make someone go cross-eyed wondering why root
is getting "Permission denied".

> +	}
> +
> +	npem->active_indications = reg_to_indications(active, ops->inds);
> +
> +	/*
> +	 * Do not take npem->npem_lock, get_brightness() is called on
> +	 * registration path.
> +	 */

Delete this comment. Just put a lockdep_assert_held() in
get_active_indications() and take the lock for caching the initial
state.

> +	mutex_init(&npem->npem_lock);
> +
> +	for_each_indication(indication, npem_indications) {
> +		if ((npem->supported_indications & indication->bit) == 0)
> +			/* Do not register unsupported indication */
> +			continue;
> +
> +		nled = &npem->leds[led_idx++];
> +		nled->indication = indication;
> +		nled->npem = npem;
> +
> +		ret = pci_npem_set_led_classdev(npem, nled);
> +		if (ret) {
> +			npem_free(npem);
> +			return ret;
> +		}
> +	}
> +
> +	dev->npem = npem;
> +	return 0;
> +}
> +
> +void pci_npem_remove(struct pci_dev *dev)
> +{
> +	if (dev->npem)
> +		npem_free(dev->npem);

Just put a NULL check in npem_free().

> +}
> +
> +void pci_npem_create(struct pci_dev *dev)
> +{
> +	const struct npem_ops *ops = &npem_ops;
> +	int pos = 0, ret;
> +	u32 cap;
> +
> +	if (!npem_has_dsm(dev)) {
> +		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> +		if (pos == 0)
> +			return;
> +
> +		if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
> +		    (cap & PCI_NPEM_CAP_CAPABLE) == 0)
> +			return;
> +	} else {
> +		/*
> +		 * OS should use the DSM for LED control if it is available
> +		 * PCI Firmware Spec r3.3 sec 4.7.
> +		 */
> +		return;

I assume this is a TODO for the next patch that add DSM support?

> +	}
> +
> +	ret = pci_npem_init(dev, ops, pos, cap);
> +	if (ret)
> +		pci_err(dev, "Failed to register PCIe Enclosure Management driver, err: %d\n",
> +			ret);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fd44565c4756..9dea8c7353ab 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -333,6 +333,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>  
> +#ifdef CONFIG_PCI_NPEM
> +void pci_npem_create(struct pci_dev *dev);
> +void pci_npem_remove(struct pci_dev *dev);
> +#else
> +static inline void pci_npem_create(struct pci_dev *dev) { }
> +static inline void pci_npem_remove(struct pci_dev *dev) { }
> +#endif
> +
>  /**
>   * pci_dev_set_io_state - Set the new error state if possible.
>   *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565..b8ea6353e27a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2582,6 +2582,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->match_driver = false;
>  	ret = device_add(&dev->dev);
>  	WARN_ON(ret < 0);
> +
> +	pci_npem_create(dev);
>  }
>  
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..1436f9cf1fea 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -33,6 +33,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	if (!dev->dev.kobj.parent)
>  		return;
>  
> +	pci_npem_remove(dev);
> +
>  	device_del(&dev->dev);
>  
>  	down_write(&pci_bus_sem);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fb004fd4e889..c327c2dd4527 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -517,6 +517,9 @@ struct pci_dev {
>  #endif
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
> +#endif
> +#ifdef CONFIG_PCI_NPEM
> +	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset */
>  	phys_addr_t	rom;		/* Physical address if not from BAR */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..97e8b7ed9998 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -740,6 +740,7 @@
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> @@ -1121,6 +1122,39 @@
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
>  
> +/* Native PCIe Enclosure Management */
> +#define PCI_NPEM_CAP	0x04 /* NPEM capability register */
> +#define	 PCI_NPEM_CAP_CAPABLE		0x00000001 /* NPEM Capable */
> +
> +#define PCI_NPEM_CTRL	0x08 /* NPEM control register */
> +#define	 PCI_NPEM_CTRL_ENABLE		0x00000001 /* NPEM Enable */
> +
> +#define PCI_NPEM_STATUS	0x0c /* NPEM status register */
> +#define	 PCI_NPEM_STATUS_CC		0x00000001 /* NPEM Command completed */
> +/*
> + * Native PCIe Enclosure Management indication bits and Reset command bit
> + * are corresponding for capability and control registers.
> + */
> +#define  PCI_NPEM_CMD_RESET		0x00000002 /* NPEM Reset Command */
> +#define  PCI_NPEM_IND_OK		0x00000004 /* NPEM indication OK */
> +#define  PCI_NPEM_IND_LOCATE		0x00000008 /* NPEM indication Locate */
> +#define  PCI_NPEM_IND_FAIL		0x00000010 /* NPEM indication Fail */
> +#define  PCI_NPEM_IND_REBUILD		0x00000020 /* NPEM indication Rebuild */
> +#define  PCI_NPEM_IND_PFA		0x00000040 /* NPEM indication Predicted Failure Analysis */
> +#define  PCI_NPEM_IND_HOTSPARE		0x00000080 /* NPEM indication Hot Spare */
> +#define  PCI_NPEM_IND_ICA		0x00000100 /* NPEM indication In Critical Array */
> +#define  PCI_NPEM_IND_IFA		0x00000200 /* NPEM indication In Failed Array */
> +#define  PCI_NPEM_IND_IDT		0x00000400 /* NPEM indication Invalid Device Type */
> +#define  PCI_NPEM_IND_DISABLED		0x00000800 /* NPEM indication Disabled */
> +#define  PCI_NPEM_IND_SPEC_0		0x00800000
> +#define  PCI_NPEM_IND_SPEC_1		0x01000000
> +#define  PCI_NPEM_IND_SPEC_2		0x02000000
> +#define  PCI_NPEM_IND_SPEC_3		0x04000000
> +#define  PCI_NPEM_IND_SPEC_4		0x08000000
> +#define  PCI_NPEM_IND_SPEC_5		0x10000000
> +#define  PCI_NPEM_IND_SPEC_6		0x20000000
> +#define  PCI_NPEM_IND_SPEC_7		0x40000000

Given no other driver needs this, I would define them locally in
drivers/pci/npem.c.

