Return-Path: <linux-pci+bounces-41575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B322C6C916
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 318854F03AC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0209E28B7D7;
	Wed, 19 Nov 2025 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1grnOCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B33224D6;
	Wed, 19 Nov 2025 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522418; cv=fail; b=SbbHptIR27Lu1+0286db7OPo/h57rkRDwcz/MXgzWMElXyv9uF1CRh0NfeG3gV/fi6cnTPEB78PMD50/ivLsTekUiLO0eR7fVRUYU2+MM1Yd3vRmpu0i9yyaGc1h/AaR29aY0Sc1Ctocvet9oqcQDUb2LkFDeBrzbqqRI2BSdH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522418; c=relaxed/simple;
	bh=/8FaWabjdzWkPpFoqHimPPg+hG5EN7bHJlzNjnZFWVo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=kk9k1wF6vK0k08oSkDNiIpo7VuQjTLUcfLPFEnJjHCygGIfuxiYwDr6GfIbacQo2GoQIo10GcuxnTiyytvy6vNTW+Zp21RrLBVmo8cAUOieYlYDvahBZNXDWc6T8y8NKgjJPWT/UXpr5+11+bEk3L3PSwMbuDDZLIiQXfXeYM8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1grnOCr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522417; x=1795058417;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/8FaWabjdzWkPpFoqHimPPg+hG5EN7bHJlzNjnZFWVo=;
  b=M1grnOCrycv62f++KN9NBwCz6AHKcTmZV4GIXvvhuVdbP98cP47UlAey
   KS6ialR3NseDzpCMBIW3trfBEYkK+TV/Pxj7LsErcMJGzx7hI3ZGjh9XO
   XgwMPgM1OcWo0I/lLBICRUIM7VczT18aeZKI0SZGEXKObSe2rovC5chB7
   ledhQXM+wW0d0FYCD4lX48clJdVdX8EkBxD00ymndqC0McnqxjzKzxx9q
   FQrIT1KY0beo5oiuEoWmkTkTFcqNCBrEVkSX39HqQQKDYyEV1RKycgylp
   M7zFMhP8vgw7NSLfKvEYdWZZmuZP+CwNB7RnPg4pB3euIuCNyf30sxjn5
   w==;
X-CSE-ConnectionGUID: ZnfEzfX6TQa9JA8Xbh6qUQ==
X-CSE-MsgGUID: N+4Z156MSv2Lhy9qq49DdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68163042"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="68163042"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:11 -0800
X-CSE-ConnectionGUID: EE/gWnnBRH23fnzL0qkR/Q==
X-CSE-MsgGUID: jkzZxls8S6KtfPLVWsyN6A==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:10 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:10 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:20:10 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcYuM1wuQPCaCqMlvzhZK50fj5hmzEfk6SzKRk6KFZXouudKGGb6aYA83VX5kzUFrMYibZ5Uc97WNNOfRinWl/hF19sFJDLXi03GS+o8nY8KDWxYfva7YHk/Y4wli4wU3W6inCaurt3ibaoTdqNmlRLS1/9TXUZJgBOLuiw38Npt+vD5/8p6r1llDAZbT/nQ67JlQBQK+uqjZWi5mY57hzLE3uDt/vUuDnH6Te2ThLR3nf58hJoVq1pu50vSlPTq+qRYvL44vrRaxA917bPkmnSWDIJITfxctDWCpxBktg6QuPxZui76cU3uewGNFXUvThw4qjqQD2RSbXnNelUpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdxaHEaUMJ9QxWuT0FeVJR3iImzuMnWRmMUez7dd+7A=;
 b=taP9s/SpvuZAHHW64NTNwv4/DuL4letElFWkU1MUJTM8A0GM775+czhC9YEOYRx9/LVaTqh2FB/QOk1nmZ18MBvAQ/IgyZkcguLSvBUPsPiGW5sDWCvJkMRt8UjudyBDK9Ih4l6ocNtXa36fH6OSoz342J2x+2Go5hhezT2acKQsgFYTlXh7MQvQmSeRpdykXkQdyNFGLX5EhQrhK2k+Mt8S2lo4aL13u99b1YCvzGM1D2mPNnGhv+GTjvMLyk7Hx3D5rupdmH5PzYMgymcCbDJAFJNyZvm41jGBHvit8yDZJN0AEWPjGNWwqdIFhf4ZZ+AHKapkEISO//5056tSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:20:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:20:07 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:20:05 -0800
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
Message-ID: <691d3765d4532_1a375100ec@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-5-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-5-terry.bowman@amd.com>
Subject: Re: [RESEND v13 04/25] cxl/pci: Remove unnecessary CXL RCH handling
 helper functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c880ae2-056f-4cae-2c3d-08de271a8a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1JjNHV4ZXVESUQxOHJlaVJJdENGdWMwWjVXbUUvWGtEWkIyck1ZUExJUzNU?=
 =?utf-8?B?Wml5cVZoQytyT2tNS3RSelpGNDBwWXVBL2V0UWowM3hMNHVPdjBRU1RYakhD?=
 =?utf-8?B?UE85V0RFL08vNFAyV2dXNTg0MW00eXYwMkhCZDdrZkxYRENGTzRDNmZLa1pB?=
 =?utf-8?B?b0FoNzY4cTNoMlY1VzdGRWptN2M3cVJTOWRtMUkyUHJ6bmpLT1Q5L1IvVE9D?=
 =?utf-8?B?RTFlcEs3eXJXbjV1aTRJN0RkVkRJalgxUDdHWlBsVXFhK1ZuampnZkdrNUFY?=
 =?utf-8?B?VFAxUldCNmU4QXhiQ2VZWTg1OU9EdUJBRDBJdmFyWWRzdTNmcjRqR3JVNnph?=
 =?utf-8?B?Z0RZUHFQZitwVU0vTnZzaHdwejdNTzFtTElxdHlkdHFjRjkwL25nRml4RlFr?=
 =?utf-8?B?Q0tWT1hySkcrMUpzYzF5TnZrMkF0UnI2OUN1Y3Fham5IQjF1cWxEZUdyakVS?=
 =?utf-8?B?MWJwQkRMVjAzazVxUHg5Rkc3ZzNiMlBTbHA4SHlVbmI5VEVVdEVkMlRtYVJr?=
 =?utf-8?B?OGtPWERZMGFXaCtxWXNHR09xQUsxR1YwVmNsOGJpTTlVbHlzU0lRSnlWVEd5?=
 =?utf-8?B?ZkJvTDVYNkpSWkkzNUNjRG16NmpRZTFKWExST2t2b0llOUNGSk9CTURFd01s?=
 =?utf-8?B?SGNLYWU4YksxejVDdWZtWTR6c0tZaXlXVm1kdFYvTmxKREozYWR1Y0w1b2tx?=
 =?utf-8?B?SHlrQi9UTEFOd1BvUWNWT0JienlWYzVnMDBmSGRsM1BsYVM4MXl4Sjc5OEpC?=
 =?utf-8?B?c05jc0VWWk1vU3BVdmNrS0syWTRUcnBNMEQ3bE5zbUh4OWptVEVGSTJnVFlw?=
 =?utf-8?B?WFRnSWdKeHZsWkErMGRqcVFJQVZPZWI1ZzFDeWF0RjRSc3BXSHlQeXFuSVAx?=
 =?utf-8?B?QW5qRnozdUgwZTBLZ0Mya2VRZmc4bEZmdVhsUE41OUJpT1FtKzRkQ0k5TkJt?=
 =?utf-8?B?VDN0UWFORHlneTA0ejAvZTJ1Zm40U3gxYTlCckUxRjcvWDZweTcvbHNTRUpi?=
 =?utf-8?B?VjY0WTI1TitMYVFITlI1WGs1NEd5YXVXSkJ6TGUzcnlvM3J2NGRGNWk2L2tP?=
 =?utf-8?B?QjV3Wkl6RHZzWXpUaEtuZEN4Y2hyT2pUSXUzQmNSQ2lxQkNXeFN4ajZEYk5m?=
 =?utf-8?B?WHhtK09iaUFFNU1oSUdPdXI3RTRPUDA3ZW5RSFBsWk9PMUc2K2I1T1l2SEZ2?=
 =?utf-8?B?VmluMWpNVDBXUE5lQ1daeE16WXJTWlYzTFVISjd4QzdPaDBkaDkwOXhNTlRL?=
 =?utf-8?B?b2FCcHV6TnA1dVNIaXViMzVWZ2l6S1MrTTFOcml5YytMZXRqK21ZSnFqZUtq?=
 =?utf-8?B?OEFiZWNuMmpJbDV3bmgwOCszRlBvdmQ5RlEzZThvajRVYnRPSnRCTEV3OXZ3?=
 =?utf-8?B?dUtETjZzZktSa1dwdXpSd2JiMENsZjVWS3ZzOE1ISmZRMCtNMlFjNGtyWVF0?=
 =?utf-8?B?N05uOU1EYlVrTlEwU09Fd01RcEpJL0pma1RScTZhU2RaWWdKL2czVU0reDha?=
 =?utf-8?B?cnpBRFhPK0hvZGlVM0dZSzJaL0dyVDczS1kzOFdUV294SzA3NWNhY2hPTURu?=
 =?utf-8?B?RnZUOUpndkxWeFlaK1g4QzVlL1JHUC84Z3BYcjZNSXNDNUo4Q0lEWTFPdDVW?=
 =?utf-8?B?bkYxalhlcExqRFRibVNVSlZQQUJ4Z3ZzZFc1WS9xbUFjS00yQlFobWpsRXFG?=
 =?utf-8?B?eW9SbTBqV3pNRjlvNTZNTjREcTBIU0ZuOVdIcDRuSWkvUzV2dFhLdlBVNXJS?=
 =?utf-8?B?ak9RV1k3U2lkc1orZGdGRmRmTlg1Ums4OVNHWE1tODZ1VTdsaStOaXcvbVNp?=
 =?utf-8?B?alhaNWREMGxzWmVxYXFaRE1HL25aK3ozVllLR0p4bDVUNWd2TmQvSWhnWmNY?=
 =?utf-8?B?OGhiRUlmc3YyR0gwNnRHZXNuMTA0SVFpdDlETEs5bWlmL05KR0xScDVSZHFK?=
 =?utf-8?B?VEFGV1V3SGYzNEhKb0FHdEJNRURPNVhTMEZpWENZRExvOTh6L1BlKzhIdC92?=
 =?utf-8?B?c0VPaldmNXlYRW95aklBcndUbHcydVFqTHJJSmVvNE9vdVZQQ21pcDIvMllm?=
 =?utf-8?Q?Qs2gfn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtUVWxlTFR6bGVRdWRXaUluTmZsbzNSRzEvNVlQVDJTUStPZmViUk1NbFlK?=
 =?utf-8?B?Nm16UkxlRWk3VkNTUDV1VkxSS3ZpTVZENFEwbWRNL1ZoZ2MraXN2bDQ1cUFQ?=
 =?utf-8?B?UStxUHY2T1hBVzNodmZmbkdzS0FUbFc5MTFLMm8zTitzQWlNRkUxTTUzSlFC?=
 =?utf-8?B?QXhrcXR4YmxtanhMN25wN1RsM1FuS2tIQ3JHVVhGMk5WckFOUmErTFo0dUF4?=
 =?utf-8?B?dHdXRW84RnZaWjFHUCtnaWxaSk44WFZBMXdoVWFFYnFnU0RvZDlIYkxsTTdF?=
 =?utf-8?B?WlhGTG9PY2VhdkhJb1UrTEd1eS8rS2dxRExBQWRuVnpYVnpkTk1zVWxQUHk3?=
 =?utf-8?B?ak10MmxzbkFBOGNLRnlHdmZKaWVPS0FmdDJidytwRlliK3NtL1Z6dVhtMUlS?=
 =?utf-8?B?RjBtSjFnRjc1TlI2NTgxd0NySnNIZlVtVXd4L3BrN2libnp3RWxsNk1NUVNQ?=
 =?utf-8?B?aUhCa2dqbEJmRlEvdk42RVVyUys5bUZINGhFV2xndHNVM1Avc25QbW4yKzNx?=
 =?utf-8?B?Tm5YQlpLeGtPTkJlTC93NVNVUTB2d2FnbTRPcTlwcjMrLzVJQzc4Z0pGcWVX?=
 =?utf-8?B?aW82NXB4SXRGd0tmbkI1Rm9NbS81NkRXUnY2UGFVcnRpWGpraTJSWnZnV0xH?=
 =?utf-8?B?bnVPa1lQSXgwUnZWcVdrM0pQWXZRdEw2YjlZbFJnNTlpVlN3YnJyR2tGQXdn?=
 =?utf-8?B?clRjSHFuTTBMQmVicjhtdG53NkFrRW1RREUzaFcxNy9kVHd1TW5xSTR1SmNT?=
 =?utf-8?B?dVVyZk16SW5aTGRMNHVnR3B5bHV2M003YmhEdzZZYU5meTl0cGNZUlY0RjFK?=
 =?utf-8?B?dk1Fc3M5eHN5Q2JKTnhLNWlDZzUxV25vK2ZtdXZ1M0JTdTI0MSs2N0JsNDJo?=
 =?utf-8?B?N3RjZ2d3bDMrdWQxVE85OEl0UmZEa29pZk5UM3YvRjRYbXZ6QW0vbVVNK05P?=
 =?utf-8?B?N0NaSHFyVVhTMGgzOXBSekNPS2RsRVFZbXR5KzRGMkJacmxJNVUyTjFFQzhh?=
 =?utf-8?B?d2RoZDRqRnBOM1hnV0luVkpCQzdaUEo3Y21PVmR2V0ZGQ3lPWlFvNWVZMnhZ?=
 =?utf-8?B?Mng3SlBHVERKUEozZWZaOUdjWmE1YjI1WDJrQUwvUi85UmFWb1lPZEtPTUt5?=
 =?utf-8?B?OWVjSi9YZStRcjJoMVZJL1B2SXRlVzJoUlhmNFdUaHFEQktDTFZkdys0MHZP?=
 =?utf-8?B?ZDZuMzdOT0tFQ1dCMS9LaURmMm5aWEJJL2wvMzNsTzNwV1diUnRLd0NadlJX?=
 =?utf-8?B?cHA3bFdsaDh4VEIwVjllWTB4WlVHRjFiWi9XWHB0V09LTC9jLzlvYWwyRGxF?=
 =?utf-8?B?RVN5WW15OWw1MUg5cmN5RUpsMFNGTlhZcGY5Q1NGWnRYU0pmQjJ2Z2tIRHVT?=
 =?utf-8?B?Qm1pL0JwV1dLUDkybG5ja1A1eGVzL1lyMlpkcyt2akxWajFyMkp4NWgySWRi?=
 =?utf-8?B?N0xMS3JhMEtZMldmNis5L1l0VWZuN0VoRnMyMWdQVnQ1WEx6d3dQWkFjemQ5?=
 =?utf-8?B?MVZKV290VHM1eWZWb0xPV1dKSDkxMWNWRFpFMHVsOThhWHo2SWdHUTkrN1RH?=
 =?utf-8?B?YVp4S0o2OFVFQjRyM0UvSkJGOUJCYVBOWFJ4YzJJZVlIY1ZOREtydHpKY2Z2?=
 =?utf-8?B?VHhWWjIvK05vYVpqUzNRUllyNW1hUllmc29pYTNNUUNYVVpMak9Pa1RaS2lG?=
 =?utf-8?B?V0xpS1BmWWVxbjRZVEY0VkRGazFZQnZVcWE5TTFiVVowa1ZGVkk4OFRZRGY3?=
 =?utf-8?B?SkFZQVNFck1kMjhSQ2hzK3ZMb1YyR2l4UTZFN1d2enltOWZ0SDdQZCt6aG4r?=
 =?utf-8?B?Qk5wMmVsL1hBZUhqZTNxdzJxSkNZc1lhZTlRcE84T2lWVllqWStIZmRrUlRI?=
 =?utf-8?B?bkp3ZlY5N3M3VGc0a3NrVVZZUzFCNjB2c3I1YkNRNERJNEdwMFdvcDd0V1Jm?=
 =?utf-8?B?SnF1SDRLditkcjhlb2N6TTNWa0o1NWZIdTBEcFZLUElnSkVldi9KQnFHdDJ1?=
 =?utf-8?B?bzJ3VnRPdzcyWmk1NmI5b3FyV0luUDZ2bGJtMHFBb2JWK3Nzc3hDc3lma2x5?=
 =?utf-8?B?bko4bDRFVnpNTFdpUkNRK0dlWUJtSmtJeDBma1FFdkw3OWVhTVU0bUVPNWJ2?=
 =?utf-8?B?aW9wZklQM1N4TmRrU2J0U1JHZXErU241a3JQZDJMNTMyT09RbENaOWRCU1lG?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c880ae2-056f-4cae-2c3d-08de271a8a41
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:20:07.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfL8qU4j22hQm7jJxmiVSOCn/IsKtBgKuJklHhSl5pUH5I1qfbVccetUV3zGcCCk8qRznzY8gJBo1wWmTHv7fWD8JA11f82db4wneqxZlwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
> to Restricted CXL Host (RCH) handling. Improve readability and
> maintainability by replacing these and instead using the common
> cxl_handle_cor_ras() and cxl_handle_ras() functions.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

