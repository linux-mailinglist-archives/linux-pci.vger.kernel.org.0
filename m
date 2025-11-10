Return-Path: <linux-pci+bounces-40795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B717C49A68
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D543A509D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E81E5B63;
	Mon, 10 Nov 2025 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMOsONUw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ECF2153FB
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814964; cv=fail; b=dEhUOBH37mLNPhJsUyBKTDvcmZa482RMKqkTt+8bTy98pI3r0umEW4P8cPVbVoWnpsQnI93Owe/MJe4As6v0yUbq2t8x8/pQHS8quTOIoovyVmfU7ZYmSDTxzZsov0k2rZGCEgIyWRrQWZnlCKuIUalGd48hWeVjNZsslrIVbZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814964; c=relaxed/simple;
	bh=WIuGC+Vwoi8yvuio32O3Yl3cz8QG4RW3Q6wmpkVHzd4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=is7g7XTum1ZcCaZGgsOMcIxGTmb+4K8dIo44Q642GsOqlpczANMK5L2yCci4EdZLsbHNOADXEuspMqK+1kaMqObb9jYHz4MSwChMp8Gv6AjmCxGwfgC+C+FkhGjgcuu1I/rQ5Ze7pLzDs2dqMgLPSJ7IOZa0AGpZDlM6wqFSP0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMOsONUw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762814963; x=1794350963;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=WIuGC+Vwoi8yvuio32O3Yl3cz8QG4RW3Q6wmpkVHzd4=;
  b=UMOsONUwVizRKYZb5FA9qinAuIYl8P3ous3HoEJcn53dXDlpFhTzRUMB
   bdxJNqhpZ9xu/2kK/yigh66MeudTsK5Fgy3qCpiUWiJ6D0oFoHbXj4dYO
   xQQN7xTvuwBO8UzO1iXdVa2ba3zrfrpBJ9ngnKqfwv8mG5eJVtQse6KMO
   kAKB0kWVFo892WnZkDN16IxuGg0PsK1Ylrks8m9ze6nTHZ9vgrtVzZUp0
   shr/Q+72cSw9aHUSVYZO1UutauvNlcEQJuc8J4SmYVM2VI3IQQQZrhA2t
   itSmRKhLfGSfNaDZeL0nA126d5SONUoYmJed4Lu8F1QlCIMAyXyJ4/R5p
   w==;
X-CSE-ConnectionGUID: /NZmpVzDSSq8ibsjYjfEPQ==
X-CSE-MsgGUID: i9MGDHGeSZ+dIMkBcp4x6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="90342740"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="90342740"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:49:23 -0800
X-CSE-ConnectionGUID: jqedjOolT7yQaU2zbckEqQ==
X-CSE-MsgGUID: ZTN50AApSCSSrro826Nsnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="226055567"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:49:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:49:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 14:49:21 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:49:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykuL/HPEKnWOG1hij9LBouW2wXj20EXpt9PBMIfIZcO2d0uAquFCedSNvzkrSykQ1yknqMuHHGBV72c5g+5ejehawTiNhi4CsT49R4HRGTPUuYw6M3bjV/hbbi9HAHktHGlVwAYOdPoapIFmUCPQXR+rJi3ft2gWeZLDK5Q/JtnARR5TsHi5EnAE8LyLyNjulSCZ/sgCUTqMpoRmNn7EaLs3Wfy0frf1T0xhFB1blQEQpWu6Pb7XpPquUSYfGkAWxKRfEtc0EB1xAxFYVJdHWiQsvVfdoJj1v8XfY21u1bLy6LstM2VXuvf3lPx+nqWIWjXFsOOSdlqqF962+k93GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljVuI9dt4NYSIQ55yyuqrWSue2hpfXmQ9Lqdinw8bQ8=;
 b=XX1/wM+jpEV8f1YIqGymqNMaLI/yAdSP10rvZfGmwGO5lmNss11XoEhO0Fc32okS7MAX6RwLD37y/MAnS37yKXwiIqjsMkuDaLG+hRDXv1RA3dNWVzDRgW6TCTN/5cbkKxDgpD/MmOdEY/B+xCd4NEw0zJ2/+nDUEt2hu9Vw8ZuhTqFJwBT7dkvT2ZRU0RAgcoHJU5ajfz2cwswY8F6x/OD9Emifdn/bQ0N0SGkacuLpwiRn7kCKfdSIRKZM98FfxoeGg3iGr+5IWLw3BU6eCzGE024PBdZnYWTBnTe82rZ/WONBG+3lIO/tx5+aEVoiEmAhe66QrUaJ0jHSELHpOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:49:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 22:49:18 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 10 Nov 2025 15:49:15 -0800
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Samuel
 Ortiz <sameo@rivosinc.com>, Jonathan Cameron <jonathan.cameron@huawei.com>
Message-ID: <691279fbe76f8_1d91100e7@dwillia2-mobl4.notmuch>
In-Reply-To: <aRFu0q6/tdrfU8Qo@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-9-dan.j.williams@intel.com>
 <aRFu0q6/tdrfU8Qo@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v8 8/9] PCI/IDE: Report available IDE streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1261ad-c3c4-42a0-83da-08de20ab6161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qi9VUG1SdFB4K1dZMDQrVkloV2RDdDRDWnYwQWVaUTMvV0xkaHJRRHZsVDdC?=
 =?utf-8?B?d0trYjRzem1tcXBpQmpLUFlhQXRGU2JyQTJhbXVlRmovbURoN054RHAvS3ZE?=
 =?utf-8?B?RWVCSG9DMGExc2wxcWVhbVd5d210U3REcGhpRW5FWkNEaDY2NmhXYkdxZGdN?=
 =?utf-8?B?VEpvQVBEWk90dFd2V1YzclZxWFNVYmIvOGt1VndYaHpKTFYzRnhKTkpDWnlC?=
 =?utf-8?B?OWlZczBUbldJdWJLWnhmZ3gyMXBGU3hJRXY2M0FtWTZtYWVuSm5tTlhxa3Q3?=
 =?utf-8?B?OGpEU1BjS25YT0tZejcxRk82TXU4a0ttZE0yd0xaMTQyREdtUFFjL0lPdXF4?=
 =?utf-8?B?Ymo5bHErWHVwOS9CbEhLYTNoSXFXSDJvWVptUktqUkEvMldoRWpVM3lCRFJx?=
 =?utf-8?B?MXFVazY0b2FraDRqMlJCci9HRnhNVHdXRkJrZm9tRFcweG1jOWhXUWgwdEZv?=
 =?utf-8?B?TUduM1BEend6eEhMYVhjRXo0aDlMQlFKR3o4dTVyUmRTNTEvelVqZS9xb3A1?=
 =?utf-8?B?Vy9tUElDTW5JNy9DRXJuTW1NVFE3TUFRU2dObGNGRTJ0U3JzOGRMdzI3V0Jn?=
 =?utf-8?B?VGw1VEpTTXNWZnE0NHFsaHY3WFA1UWg1U0xPVlFqbjhmQ09mMTNzaHk4L2FS?=
 =?utf-8?B?R2I5OS9XNzZOTjNoRU85cW00WElQT2xybzY5aENDK1c5TitpbWg0TWE2T29K?=
 =?utf-8?B?Sy9Vbi9QRXA2QnpRaml5aWFPUXFwamR6M2FnQnB3TTliZGRBVVBxcmhYeG5u?=
 =?utf-8?B?Z2wwZ1c2d3J4MEZXQi9JSzhDWDNlaGlGVkZwT1ZqeWEzUmxiZEFaK2dPY1E1?=
 =?utf-8?B?cG5ISDcwSEI4bGJJUndYK1VObUNyNzlsdzE4S0tMc0hEbk1WRzFYZHd6UHBU?=
 =?utf-8?B?TjhvK0VST1ZuT0dxWk9YYUMzMTJXSUo0RzAzZkJMOEpnc2JFcklpNE0yd0Vy?=
 =?utf-8?B?MW1mcW93RFM1aXdCT0NzZi9ub2w5K25kdURseUFpRDJPaFplZnFPRzBSYXRu?=
 =?utf-8?B?dEpJVmJmbExJb2hubHZHY0xDZzZNQ1d6dU5BSHM5cU9GT2RwZHdIWWc3SXFR?=
 =?utf-8?B?R3dndFh0aERDNlBaUCtCSHgxZXJyMDY5eUpzbzdxT3hBanEvNW00L0o3bFBz?=
 =?utf-8?B?NWE1MTZaQW8vOVUrNGZGb05Sd0VjRjRUaVByZ3A3MVYvbXdvbDRjWUppNW5H?=
 =?utf-8?B?RU5CWEczZm1xWEF5bWNkS1N2ZmpOSFluSVlEN1NSQnJnRitpNzdTb3lIeW4x?=
 =?utf-8?B?aDMxc21BVklmZENtWThJeVJWenNUcUJKQXpyeXNTclVmSW1CbHowbUxxRjZW?=
 =?utf-8?B?cUd0M0hDK044M1hQdm5hVExPWlRGbFEyTUswWXFJdkllT3ZhaGU1b001Zm1t?=
 =?utf-8?B?M0FyMDZOQ0FES292dDBrWkphNW0zV2E4NlBNdzd1dUdFSytodjdsU2VjQjJh?=
 =?utf-8?B?Snpkd2M1dWRpWm1iaUJiYjd3WlFNeWgxc3RiMENWS3Z1L1hXcTY1SzNTZklL?=
 =?utf-8?B?TjFrRGwvb1Fvczk1ZUV0M1JUczVJNHZINFc4aHAremt1dmhCR21DRWRmYXdS?=
 =?utf-8?B?MTlycGxXUkdUTWlGOHF0cHZLM3R3Tyt3VlRoUi8zSm5FM0VENUtycnhmYU5w?=
 =?utf-8?B?bXZpYmtuMFlkUGRZVkV3YW1JZk1adU83U1ZxRFFsQW1YVjRRbHFaTHF6SUZG?=
 =?utf-8?B?bVVnWmR1b0NBck1UeGFuTENmbVdvVWNVdHJCVUN3cTA4cEUwUzNScXhlcjlS?=
 =?utf-8?B?WWRSZlNCZjR1TGpaVGEybm9rZVdIT1dseWY1UzNZOEJ5U3hjZms3STlsR09H?=
 =?utf-8?B?UnpjLzZtaFJ6dlJDV1dSWndLd2lidWRyQ3krQ3FEMUVUNE1WTWJjaUlSN1RI?=
 =?utf-8?B?ZlBnKzhJUThLdzNadUJoZ3F5a3BPbHRUeCsvL1BON285NU1PR2tQZGMvRnVK?=
 =?utf-8?Q?H77/9k2GhjYISfLSHP4MrkzM6R9dQ2wf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dvbVZXNDRTZ0dwem02QzdPb21WNy80S1REVUIvcWE4RzlueUs0STFxZFJN?=
 =?utf-8?B?Z0IzV085cWQwWWN2MDdlSHZ3WjVVd1oxQWx3YWovL1Q4WU5QSTRXcXNHbGtO?=
 =?utf-8?B?YXNmSUlnNFB4NzE0V3JHcGw4S1pXY1phUjVnbnRGaWF5Q0QvSWp5bjRpZnR4?=
 =?utf-8?B?Q3gwWVhLQS9pck9ENXVKVERSeW82WVRXSVh4em1QNjJvRlFGZWdncTRKQW1t?=
 =?utf-8?B?SC9oMFBHdXlEcHU3enJnL09IelNGM2xZSm1hSUVlN2R3OGlaTWJ5TkxIMk1V?=
 =?utf-8?B?MHQyZTJJNTlnRnVhdVhvZVVVYU9VaDd3Y1NiOVo5UkJYanp1ZTg4M0czdlA0?=
 =?utf-8?B?bTZKNTNQbllPUE4zekE0ak5veGd4dWI2SGJGajg5dzNTbnZUSFZucTd5bHdS?=
 =?utf-8?B?Vm0zS0lmOFZPSmhURmtxSnFUYnNuWW1wS1hKUmRBVENnTjhEOXNnQjRZOVc0?=
 =?utf-8?B?dXR2MFM2NXhVTmh5ZlBta3dSRHVoeXd3ZWVYTnNiMUx4OVhPRmF4cnlicWNo?=
 =?utf-8?B?eUY0TVo4Zk0wODRMTS83b21nRlpHa2FzRnYzTERHbDdNampnMWpaNHlITVFk?=
 =?utf-8?B?Q2tpRDN0Zkk4NHd2dFJSNGY5YkNmejlmOCtQSFZWcWc5S0dkNWlFZmorZ0Fq?=
 =?utf-8?B?NGkvektoUWVvWk1aWHR6anNSTVhsdmlGaVN2NHVNOStORFBqOFdOYXRzWFF5?=
 =?utf-8?B?UUxFOVFLVTFvWjA1Y2VqNVRtOVg3OThxSmhLaEt5dnRYOXMvUjd6bTdGVjR6?=
 =?utf-8?B?TXNlclRycTRZNHhSanhxUHdmeGIwZHBrUW82aFY0VEx4cHZmYWplbzAyeDZ5?=
 =?utf-8?B?cVhVdWpyOXM0Wk5CY0szVGsrRU56b2FKODNyVkdZVW9LUkR1WVd1TkRKS05J?=
 =?utf-8?B?eU9xcDVRZnBod3c3UlNCRkVyVU4wRnIvTmN3YmVaT2o0WFdKVDJ1QmRhbVhs?=
 =?utf-8?B?QTlXWU95R3hBQy9CalJzRHdoUW9rOTVrb3gwOU5VVGhJTkRFRGZBdXB5MVo0?=
 =?utf-8?B?NkFCMFdBekptN0xiNDJwUzJSSkpjeVRwclE5dWFQVkEweDFham9uUW1HT21R?=
 =?utf-8?B?TG5ycE0rWTB6ZEwxRTc4T3Jubk9FNjB0clA4WjB4MXllb0Q5SnlKVDVvcU42?=
 =?utf-8?B?dlFtcGJLbkhLUHdYOElXdFZHVTNhbVVUbmtHR2lBcTE0OFVTaTgwVDNIQXNX?=
 =?utf-8?B?VzI5YmtQUTZBYVkvb1RMMVh6Sk81cEtQY1pvSzQ5SUp5dkpQQU9uQzg2b1FO?=
 =?utf-8?B?MXAxcExTN2dXOGN2SkN6RGhlTFRhMVRZeW1lUWlMOWZPR3MzVXRLb0N4ZkRG?=
 =?utf-8?B?NnVENnp3Qi9kbVJidjVzNGRpRy9jdXRGSXBROEoyVDRhVmJJcDZSU1hMWTM4?=
 =?utf-8?B?Nmx0a1E2U0lNd1lnY1dlU213V2NUREZDR3Nhc2ZLUTQ2d1ZGOXp3ckhZbUNV?=
 =?utf-8?B?SlZPUVEwUWFXVUsvekRRdHA5LzhEQW9sckNMSVBqUHg5RnJ0WUtTRURLS0RZ?=
 =?utf-8?B?MDFPOVpDUXp2ckd2NXpVYXJqWjVUNWgzNjEwVEp2YUtzenNxbXFuT3lhL1RC?=
 =?utf-8?B?cmdLQ0Nwek5wU2NxZ1FOU1NZeFJ3aEMzZCsyRTdIZ0MxcEJHdzA3SzFOMk1q?=
 =?utf-8?B?aGxEdXA1VzlJUmRHOVIyVXpwVnpURWpDemRrallNZzA0NnV4VDF0Q01TbFpW?=
 =?utf-8?B?Qmk1MnliK05wVVNETWFXaWgyL2xVbFByZWEyTC9CL3BWQ0o3NWE4Uk1YdS9l?=
 =?utf-8?B?bU40TzAwcE92dWs1QnZEOCtYOVVDT0ZOUXU4VGQ2c3Q4WTB1M2RUVmRVS2pp?=
 =?utf-8?B?U2R2N3oyMkl1bENpcjBRTGgrTG5sWFhuUUpkT1VrZTl5NTYwNXZJSlpZczJM?=
 =?utf-8?B?MFd1Rnd3WE81R1J0TGNKQUM0a3N6TWRpdUk4MEpwbldJWU05ZmJLeTNOMlE5?=
 =?utf-8?B?NUU5Vjk1RkJMQkxzc2pHaFp6M3ZxV2VKd0dzRjJJRmNzT3FHOXdkcmtLT1dv?=
 =?utf-8?B?WEtJdnVBTWxRNDkvajBkVXQ1MHRGUDdQK2V2YzRqOTM1VC9peVNtV0VwK0tZ?=
 =?utf-8?B?Rnk2VmlzR2E4OW9nWlFWbTg2YnU4QWtHdTZpMU9DOW9PQWdqbisrZDhDSnZM?=
 =?utf-8?B?VWdKa3QrNTRJeU5uU3l5am02Rm51RFpTSk5hdHZ6ZVNBZEtFZGF2MTYvUnAx?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1261ad-c3c4-42a0-83da-08de20ab6161
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:49:18.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVHZsTUkciNbROLC2+9FrOfsag6dt24WYbi+vlR2D5qQBIZjv7V3xQfN3a5RFAbjO4HSeVWKiqvd5mYuHbBL3pnMQbadzQAVkno3nw33dnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> On Fri, Oct 31, 2025 at 02:29:00PM -0700, Dan Williams wrote:
> > The limited number of link-encryption (IDE) streams that a given set of
> > host bridges supports is a platform specific detail. Provide
> > pci_ide_init_nr_streams() as a generic facility for either platform TSM
> 
> Should be updated to pci_ide_set_nr_streams().
> 
> > drivers, or PCI core native IDE, to report the number available streams.
> > After invoking pci_ide_init_nr_streams() an "available_secure_streams"
> 
> I suppose should also be pci_ide_set_nr_streams() here.

Ah true, after this switched to the new model of initializing to max by
default, failed to come back and fixup the changelog.

> > attribute appears in PCI host bridge sysfs to convey that count.
> 
> I don't see how it appears later. 

It still holds true that the attribute appears after registering the TSM
driver.

> > +static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> > +
> > +	if (a == &dev_attr_available_secure_streams.attr)
> > +		if (!hb->nr_ide_streams)
> > +			return 0;
> 
> The previous patch unconditionally initializes nr_ide_streams to 256, so
> this check is not functional for "appear later". Maybe remove it.

It is still valid for cases where pci_ide_set_nr_streams() is called at
runtime to make the attribute disappear. Not that we have those cases
yet, but the mechanism is that this attribute dynamically appears and
disappears as the IDE configuration changes.

> 
> > +
> > +	return a->mode;
> > +}
> > +
> > +const struct attribute_group pci_ide_attr_group = {
> > +	.attrs = pci_ide_attrs,
> > +	.is_visible = pci_ide_attr_visible,
> > +};
> > +
> > +/**
> > + * pci_ide_set_nr_streams() - sets size of the pool of IDE Stream resources
> > + * @hb: host bridge boundary for the stream pool
> > + * @nr: number of streams
> > + *
> > + * Platform PCI init and/or expert test module use only. Limit IDE
> > + * Stream establishment by setting the number of stream resources
> > + * available at the host bridge. Platform init code must set this before
> > + * the first pci_ide_stream_alloc() call if the platform has less than the
> > + * default of 256 streams per host-bridge.
> > + *
> > + * The "PCI_IDE" symbol namespace is required because this is typically
> > + * a detail that is settled in early PCI init. I.e. this export is not
> > + * for endpoint drivers.
> > + */
> > +void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr)
> > +{
> > +	hb->nr_ide_streams = min(nr, 256);
> > +	WARN_ON_ONCE(!ida_is_empty(&hb->ide_stream_ida));
> > +	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
> 
> Also no need to update group, is it?

Unless zero is forbidden as an argument to pci_ide_set_nr_streams().
That base expectation of "available_secure_streams may disappear
dynamically" is something that userspace needs to contend.

