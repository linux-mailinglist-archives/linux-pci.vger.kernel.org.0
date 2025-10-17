Return-Path: <linux-pci+bounces-38418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD5BE652F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 06:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77EF19A6FAA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 04:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344AE29DB6A;
	Fri, 17 Oct 2025 04:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bg+F1nON"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791F334689
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760676068; cv=fail; b=XdpmAPlcuKbUmK2KXqzYxtCYUp3rIPWcRtjwCJxuWUA6HobIJth75k1mlYb7HbIv9EUnNxBsTxX5F+0PEXPJmnTy4WvNxLHZzctfrAkPjtifgn2g502NLGL1FMGSNwFjIntHlO12f9fZibdZ8vhAfDBQIyHJhUO/OLTLtzD/UeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760676068; c=relaxed/simple;
	bh=qbr6LJluKP7fooLg3O8zfYL2sW9CtM+jhcLPVO12kDk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=AWzp/OZxg5UlRnwlNUIdMUGom5rJc8b1+K+qdKW/gObPkUvcL4IgnettZExzP6yRcvx7fHlsKTZhnZiVBcQEQzH4mfNM6oTheCkWpcWCPrED5BLK7qUuv/B6V4413h01te59tm+faT1WnLfnBuWdZBHPYukn+tcOg+zQCpV/NPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bg+F1nON; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760676063; x=1792212063;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=qbr6LJluKP7fooLg3O8zfYL2sW9CtM+jhcLPVO12kDk=;
  b=bg+F1nONt/7O/SyIEd9IcUJn83jV1HR8JuT/t94WCFdNf84Tn4Q87inn
   lR/gEsUY7hN+m8PcOHd+Oxq8zc3TwzYhuzVn01RwHOgx40Z3JGR3KP7ri
   dJ2VJUehsEh+3arBhGG9hi+6lAUlTIskl446ypRinJskMfyvqc1TeLDtF
   Ux/R6pk68tWsYQwjZKfpZ9Fi4bk5eVajLTmSSVdmBYtDqX/xm4RbDjPdZ
   SjJhhwzG5o0hKieWwyJXOD4GOy5hh1ebkS/rN2Ipe47wlqc/88EPeNxrT
   On7iFMvM+obsMkCnMJzGV5TNjCMLBjL735f6bthriaqPGz6z52LZ2vcjU
   w==;
X-CSE-ConnectionGUID: t76lulaeTPiIZvPeNEHIqQ==
X-CSE-MsgGUID: Pzwbs0TqREa1fEgQ7RbdfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="63028070"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="63028070"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 21:41:02 -0700
X-CSE-ConnectionGUID: Ff+00XCNSMO/KCOMAuFY9Q==
X-CSE-MsgGUID: APn2/BKKQx2Os2N8vkdVFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183115654"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 21:41:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 21:41:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 21:41:03 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 21:41:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7gWAGWalSbMXNmTxKe4ZhBS2BEOrga8tcdIBig3iFO5jaboq8HS/hZmS34/FJ/g+1MqEn2KXFCdPQkYQJDc8rhgYEPFwMlmThdJrsQDGl89q71n6obhZxzgIkheBXBJdp7Oh7xDnWPaEx0uk0au5b5+iD4xJsHqPjnVnJOWsVu2soaZlk2xA1vzacAaidUoiIEo62gEtw1+n8t3enIWAiAOeVLz6idoaIN3zVEuQb3kvX+UJQX8mJtuX89aisD+1s2nwO46IJm1NICmabm1GRiT23XWgYLiAD9MW8V6PKuVBeZqWly6z3G3PXoD0fVhBElDQZXThOq2JCbOpYFW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBNyEwXhkYjZJ31rLOKrxpeqMOtmS19zr3Jw4l0lvl4=;
 b=lBciGjTZgvwTNFfnczUEDxfqPkFE+5sTT1VPOCgBX9dB39e+r3P8TzUC3farB0rzkm1Krr6pHPnSJa+7JrJv7gOgqWdpD1N9FCl/tN87iTXh295cEynupmolYGfer01YV4s9vAPY1nDbg+ibOZYK/6Eod5FNBD/fSrgvYHTRrU27k7inn5yqXqMY/dNliP0pEZQp5dVSVKrXFntVLFigcLp5OM3zDDqQfWGZLT+Z9KH+0099JaFi4aJToNs9+WIOtx/J4yMS7ODGzy6JVKoWUFGY1ook5goXAh3h4UisQqItmGNDG620nm0GgGcWJPM42K9j0GnadPWO3UJHCrzOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH2PR11MB8836.namprd11.prod.outlook.com (2603:10b6:610:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Fri, 17 Oct
 2025 04:41:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 04:41:00 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 16 Oct 2025 21:40:58 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Message-ID: <68f1c8daae384_2a201001e@dwillia2-mobl4.notmuch>
In-Reply-To: <3d100559-8eb8-46cb-94b3-34ca9fb6dd96@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
 <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
 <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
 <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
 <3d100559-8eb8-46cb-94b3-34ca9fb6dd96@amd.com>
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH2PR11MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a5e091-aef2-49c8-22d3-08de0d375f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHA5aG5scklOSDY5dy9ncGIwcmpBc3gvSnZhSEw2L0xvd3BjM0g2UTNjLzVu?=
 =?utf-8?B?UEZ2aFQ5OGllVjVJT1d3bTFoREFWOXhuMG85MW1XVHFFelNqekFHRnEwZ1ZP?=
 =?utf-8?B?anRKNEVRS25NbE9DeWJZaTRQYlRCRTFGc0xGb3lrQ3p3NXVKWStxNVBSdG9m?=
 =?utf-8?B?dU91am9KMXhxRGlSengrZHB6dXZVR3ZnRVA2K0YrcjVrVW5aYjBHTjFqMTM2?=
 =?utf-8?B?SG1RMVVmSVJ1YzBiYkV1MGlCSGY0TG1JSE83Z1NyY3ZldUI5UVA2UWpVVWJU?=
 =?utf-8?B?eXBFQi8xcUNZcDNCcVlwNk9RVGsycXZSQzA1NW42d2FTUVE3Y0lsT01tbFRD?=
 =?utf-8?B?RENXUnZvZlpmNmk5V0dnMUQwZzBIVUZsR1ZhdXJNZVVNdjY4ZnZaZ09wRzRO?=
 =?utf-8?B?VjdRSjNzQ1RubVlWV3VHeHNLL2k1R0NEMmpQRytpVzRwWnJIeVFvSC8za2Fl?=
 =?utf-8?B?K3V2M3N4VTJEK0lxUHVVOGNDcnJCYWFhanA2Vmg2aStRWHJIRHUySlNvS1hI?=
 =?utf-8?B?OUhsVmUrRjBSd3dTT1lRRlFhU3JzdGJiS1E4UVJrVnF0NTQ0WmpOYW8vTXVX?=
 =?utf-8?B?ZUw2SGhZR01pemE2NWFSL0JWVUgxazYrd05ZL1RFMDd1WVhkRCtEcnlJczF2?=
 =?utf-8?B?UVhST3h6aDk0TWRvcjRmcVJjUDJzYXFiT0R2cVlaZTNQSjV6KzdLWkdFMmwz?=
 =?utf-8?B?a1Vaa2RYUmZ2OXNBSEw0bUxMRW9jekNCb2ZlTUNJSnpZTDFFYU1XK3I5Q2Rv?=
 =?utf-8?B?ZEV1NnZWVU9HMW5EUWZMVDU5STVxVjVHSlhnZHhyUEN6NWRtQXFsQ0lSdWFO?=
 =?utf-8?B?aGxBQVJQaXBOZTUzK1d4djg2dHpBc3U5d3lEM3JFZG9rWk03V2E4RTd2K3A0?=
 =?utf-8?B?ckhjYlVXUUxRNzhtTTFVMXI0RG9tSkwwaDFleEM5Rmw1cFkydmtSOG5JREpW?=
 =?utf-8?B?KzNUZnkyVU9FQ3ZtU1JjdFF1a3NSMm9SSFVTbDNmV1lmWk5DTkxJZ0FtblBK?=
 =?utf-8?B?ZUpXRXVmKzQyUWFmdHdNMFZQQU1MQzhCUFM5Zm16S0F6OGwwOU9vNm5Ub1VQ?=
 =?utf-8?B?ZUdYYXlXSWE0YjI4Y25LUlFTUjdyYi9YNmw0NkpWRDJ0QTQrbEMyUXVJbnNE?=
 =?utf-8?B?MWhVMnhTcFdreXlwVlFySTVWSGhYUlY2RzNONU1lbTRUMGYzMUI1WmtXUDkv?=
 =?utf-8?B?bjRVMG84bFFYQWNQVUdicEV0eFRJZ0dsTlA4YVUxaFYxZjJUV0E4T3haS1BE?=
 =?utf-8?B?ODgzM0d6YTdwdEdHNXptSGhzYkp0WE94MVBtVUZyWTZSNVVNUG1CSVltOTBX?=
 =?utf-8?B?YTFESk1yMnpVcDgyVHpteWJ4Y24xL1RQV21GU2tDUGdydjMwb0tWcEs3eEk4?=
 =?utf-8?B?Nk9oazlJTzhpVjUrdE15cmJZeWVtbEMzbE1oWGVMekVST3plME5VdjlsRDU2?=
 =?utf-8?B?NjdjOXh4ekMwYUFQY2RreTBhQVo2Snpvb1JNU2VvZUQwNWtQeVR6UVVjek8w?=
 =?utf-8?B?L05mTE1WTDJlVU4xUmlrTnE5UXIrYXFFdlJhazd3ODlNaUtmeEt1N3FyVDlF?=
 =?utf-8?B?ZzVjNlpxWFQyZFI3VXZaVzhDUS84dTd3QWlVZ09COExIQ3JhR0t2R3BsRVRI?=
 =?utf-8?B?QWVSWEVoV0ZiWnYwQ05MSm16WEszbnREY3pwTk1GUWRRNDRqdWVZMFowcnl0?=
 =?utf-8?B?MW0wZUFRWVh1cGI4aFZ4K2JYSmZJSGZMQStVTm9kOTRNalBSVXlieVZvSUVT?=
 =?utf-8?B?SE9BNEFqVjU1cHhjU0prallOeE9YbC91ZzV5b2lXUnFsV3ZUdmZPRkNrMW9v?=
 =?utf-8?B?RjExc25QcVhQOERSL2FITXp1dk5QSG1XRy9JVWdGbk0vcmFEaUxvRjJZRlNY?=
 =?utf-8?B?UmRKU0c5V2Y2L1ViSktZRTB5czB5YzlKN0dkaDMva2dMbXY4dE5HV1VvdmNO?=
 =?utf-8?Q?0+AuTylk2xpkcAz89FSWPmdOMV1yW5nJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnlQYU15OEpidENlY1JwSFhOeG9aNkhKdWo1SENNcDF4MlhCeWZRZTJ0NmVX?=
 =?utf-8?B?SUNoYkwvQVhpSEQyeEJYMkh2eTVGRlRIdzJ0T3IxTTRaZGY3eVVtR3MxWElC?=
 =?utf-8?B?aU1Bdy9xd0t3QVB4cmxaT3A5blJzazZua2Rja3F6UTJyMjA5NDBKd3k5d1ZJ?=
 =?utf-8?B?Mk5LTmhlMEsvRVk3VmdLUFFtQlNMVkZqa3hDOVhPYWxubUI1Z05MRnZVNEx5?=
 =?utf-8?B?ZWxSZ2VpazlrZjVZMUt0NUtKdXdXRENKUkJoZ3hkdTZIZHU2b3ZaemhySE1Y?=
 =?utf-8?B?M2FCN29PNG5SdUNlTUtSUk1yQ3gwd094V1BSWXZGd0p5bmt5cG5HWUJ0ak1w?=
 =?utf-8?B?eCs1VTFLL1R2RlRXRjZpMW9vMmdYSVY4MzRkSkR3U0FUOXRSSGd2YmVreTJ6?=
 =?utf-8?B?dGJUOThXUXB2SU9vdS9rVFZJTktEV0N0UVh6NUZYV3BJdXR2Qm1oM1Zvdkxr?=
 =?utf-8?B?eEJKMVE4NHNPNlRneGxkL1RSQy84djZRTUtwL1d4ZytYa01UR1NLdHlRV0RH?=
 =?utf-8?B?TjBTdDJtYzFyUVFiTmRkZGJ0U0ZOSGVvSG5QTSs0N1M0OE5PZW1HVm41cCtq?=
 =?utf-8?B?R3V5cWFhQXdST0d6L2lIN0x5QW56Q0RIYVY5WU9vZnJDald2VFpJYnhFN2pM?=
 =?utf-8?B?U1ptanFZUVlYK2ViTmpTQXNERG9FNWpoTmtabVZCemlVd0NnN1dkVTI4ZVZq?=
 =?utf-8?B?VDdpM2tXZkFiVjhRdHM2cjlBeVp6UjNtWTN1WVgvbkt4R3ZscmJVN2czM2hy?=
 =?utf-8?B?alZEdUdmeHlLWlRJL3VyYnZWWVVYMWxqTVlMN2x0RythUEtrbWt4Wm1YSVdV?=
 =?utf-8?B?eVdHQzE0N3dyZkRVL0tDemFuSzVlRDVpRDN1bUg0Sjg2WXVPakw3M3BJN3c3?=
 =?utf-8?B?aHc1QUZRWjVjbWhZREhZUGRIUSs2S1g2Rit0Ym5wR2lqVjBNMTR1UTRJSmZC?=
 =?utf-8?B?c1htY2JNb0FKMEVob2NSNzRVREY1bGNHRW4xRU5IWmlUTW0vaWJYZE5UZEdJ?=
 =?utf-8?B?T1V1NUxJSUJmdXJSTVBDZWkzTGxBWFBZcmFvcGk0Yzlacys4OTZyajZIVVhN?=
 =?utf-8?B?emNTbjJNQW1GVU80WDUwZDBZVkNFT25US0N1R2h4b1BuRmVoQjV0TGE1Wi9w?=
 =?utf-8?B?RDY3WmpRMXhML3AwcDF1czhadC9ia1hJWWhuUDBJL25sTzFPd0V3TTdLRElp?=
 =?utf-8?B?bG5tbk1zWDdFdWJGdFgwTHVsbGhPdWxma0NZZytMTFZEWVhZR3IzNm9iRG8v?=
 =?utf-8?B?eDVXZGNwZVBwVjBZeGpjcFhWYlVzdDlBeVZaSjUrTStuU0VMY250eHdGVWZm?=
 =?utf-8?B?d1RiclBuTlFiZGk0cG5vMVh0eGU2OEQrN29OdHNMd1IrM0hEMkhsblFpTDli?=
 =?utf-8?B?bVV1RlVoQ3NGakE1cjROVkhINTFFWk9qaFJGNmtyeWJSdUVZK0tJeWZCeU1H?=
 =?utf-8?B?cWN1NHl2cVZhdDcrU1pKcEEveDd2SU9kZk1mODA3bFVLaS9DYkpaNGdESTAz?=
 =?utf-8?B?SzAxNDBSek1mekNhdjRjUkJBakJGbGFPTVdRWTNraVRoUS83cGFNZWQyS0hm?=
 =?utf-8?B?QzVoVjVPNEJoZHVHUU5pMHdhV0tWa2loK2lpRmNwSktZWlFIbEltYXRrYzZm?=
 =?utf-8?B?aEoyL2pzZUFZY0lIdWpaOUVQMGtpMURrRXQ2ejd2b2Q2R1ZudnlRcHFGWUZL?=
 =?utf-8?B?M1hMUW9hZkU2Ky81YnVCL0hpRENqbko0MXlLaWhEL05KQ3V3cXgyZlZQV1NS?=
 =?utf-8?B?U2V2blliQWZhaTNlUUtYZm1Edzl5S2orNkdDbDFFRWxXcUpXU0U1WllxeHdU?=
 =?utf-8?B?c1h0ZTgxYW1ZNUZ5MW9VTmtYVzJ1UWF5L3hRVWhkYUJQT0hjc1gzdXlTWVpv?=
 =?utf-8?B?SFlDb1lsQkR6d0dlenZYTmVPN3lHWVkxOXIrSVFDQ2FlV1JpWWdyUENtc3Br?=
 =?utf-8?B?OUhlZ3VKWUN3eitnVkIzRkZvWW4yb0NxakZsdzhCM05yVzBJWFNsUDRGODZu?=
 =?utf-8?B?NzJYZWpsU1ZqVUJUTzRBUW5VWEVrSjhtc3h0cG5MQ09BZHE2WnpwMW5NM1dj?=
 =?utf-8?B?VCs0WnN4UCtnZC9JRG1wQnhzVDFtSlgxWmJjYitxM3RWVHBWQlBqN09BUEd2?=
 =?utf-8?B?S1ZPS0kxd3Rva1JiUkVaYVYvS0YzSlh5cDZaUGQzeUNJQmpMQkJKWEZWM2tQ?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a5e091-aef2-49c8-22d3-08de0d375f30
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:41:00.6462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSsXGr+h8PBDgLP9BSUzQZdPOenA8yhibqEmPTVAYly2qTCrhNtvzSAxsB0V0kTP2d7xcquy2TYy/lcBchL9CxYN47P+EEtgrWV1sdDFjQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8836
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > +	/*
> > +	 * Now that in use ids are known, grab and assign a free id for idle
> > +	 * streams to remove ambiguity of which key slot is being activated by a
> > +	 * K_SET_GO event (PCIe r7.0 section 6.33.3 IDE Key Management (IDE_KM))
> > +	 */
> > +	reserved_id = find_first_zero_bit(pdev->ide_stream_map, U8_MAX);
> 
> 
> pci_ide_init() is called when PCI is probing and at that point no
> stream is enabled so reserved_id ends up as 0.
> 
> Since my platform only wants 1 stream, should I have called
> pci_ide_init_nr_streams() with "2", not "1"?

Hmm, no I would expect that number only needs to reflect the assignable
id maps.

> pci_ide_stream_alloc() fails to find a stream - fails in:
> 
>   struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
>           pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
> 
> as nr_sel_ide==1 (my EP has just one stream). If I go with
> reserved_id==0 and set ide->stream_id=1 in the PSP TSM driver, then
> streamindex#1 gets programmed (which is beyond the end of IDE cap)
> with streamid=0. As if reserved_id is actually reserved_index but the
> device wants me to reserve an ID.

The intent was ID reservation, not index. Will take a look, but first...

> We could simplify it by assigning something like "255" to all
> unused+disabled streams. Thanks,

I thought we were still waiting to to determine if this behavior is a
quirk of a test device, or something that Linux is going to see in
production?

Yes, I want the reserved id to start at 255 (unless BIOS already stole
that id).

In any event I will send out v7 without this, but include it in an
incremental update along with the address association support from
Yilun.

