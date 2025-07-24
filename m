Return-Path: <linux-pci+bounces-32860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22345B0FE54
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 03:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A071C285E4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 01:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87C2B9B9;
	Thu, 24 Jul 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icM5jD3J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABF1E868;
	Thu, 24 Jul 2025 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753319835; cv=fail; b=GgBUZ8V3Rn5pPdt45wN0ZASMofGa2N24wggL8orOL+UedC5ukVT0hU6DYlzcrRYT3gfQsYGZfs/q0erporgy2Q1LUkM1pUgMdZsPMmLIog5FKQ0Mj4guJxrOLuKvu+HdvggUig24Ja0jrFPxCDSQS9PXq30I52iL5RYYZDVFdhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753319835; c=relaxed/simple;
	bh=tit41qWyYeWl/pas/C5sdb6YGYCZN0sBykaOKu0z+OA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fMUVlLaR1wLRvYXtwEf4GuhA8xY5gcLqcm6Je5HHbNHJjJWjmJyIsbURs0S8m6Lxw9lLV2JPtFbnxbKyUvcKt52kErHA8CNepLNbKGikjbZLYl90PS5VVm62XM5782CzyY5yW3SVN6pODrV/+l8WU6NoWK+Kd8P20x6kBzIrF7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icM5jD3J; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753319834; x=1784855834;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tit41qWyYeWl/pas/C5sdb6YGYCZN0sBykaOKu0z+OA=;
  b=icM5jD3J9xQwv842YVewNRQdLMmE+dv+4lKD3gB9J3AAYt2x1HKna3wk
   jgXPt86/nb3BLaw2c6u8ZXDaoxHx5e/d+M1v5IYEAPwrmrBTK7wGqZu58
   4iNTFmVb5UwnW1b3+RoaUX6xj468ZKkG3AgmF8Hs3BkHqAmDfwEdjoeSB
   QWmf0Aiebm5h5xG6AZTDxWvx1xE08GWzyATirAuVBW7fmfmKr1L7GkR5j
   zpG3eWpR1HpJEuQFAMle2lmEud2ikwLAkPrySlGX02TkEiUDJ9mYEu9QY
   dOwIRRtG58JHQWYhfeevXXsgnDbrOhuTaAHWXVLqfgC7aiGMBD9DD8dXM
   w==;
X-CSE-ConnectionGUID: HAtak71STwqd0ienfhu/4w==
X-CSE-MsgGUID: jqQa4ZYKTpGaQ9FcIw9wfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59275514"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="59275514"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 18:17:13 -0700
X-CSE-ConnectionGUID: c6xGg60ZQheLD3A+9pym6A==
X-CSE-MsgGUID: T3tXK6RASlWUsrbspHklnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="196981434"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 18:17:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 18:17:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 18:17:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 18:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNRqZHk4hfzsfQxjhRtpMq5OYQVE14o1hfu7r6d09jd1csMDlqgRgJNXH51ovgksqkExSShD8REqJzy7Wl6PPd8EyuvPDkrCVYje4UVW8IVS2YYCUqADqing4MHicZjwdeLsEzfqUcc6Dk8EFRNwvBXnlJYe14aFtz9pkVSW2whlILWouJbTtx92bCbiu/cQnIYT1Z4PXgSup6yCF4fsCh9Oi7mkl99tKsdJ4Gz4qV+rrP2+O5W8Qn1AQYZ91XAM1qn0fnPgAMwMUzrYFkTBnSAqwIj3Brhm5ThzTwo57Btp0xvTiUFLt/Xz692An/iT69NUFMUIptC+e0YkwPsCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3883WIDY9MmNQH9VGZsWX66Zdju1YYt0ClcoN2w73o=;
 b=SipoWLqHCrxr2IjhgkqjEoutRj0xmw55nDMgebDxnS22dQfYGPWUhLMRbaYQ7vcWDMQS/WujGX9G7rmCi9PDMHAOZVxlfnKTXNZKxWW3G8haiulxCeq/ZDBS+xoEWw7mYdyr+ILH6FdapbpEZ6o5RnWQznqgkZh7QdZUZoq5sJ5NxQBlue/PB6hTjwqxWWMv7+o2Kv5b4V/47u6xDt2a/Kp5I96y/sSoasjTBMYFtoB1VRbvpxw+JTBIzpOjt/PjkeJplWBbxSE/P2Eco/zDf0u889qebeQnipyG5wBhMHHKGXzyajDEpoDaQw3X2ZmsEJS3D90s8s7TtnvkLZW+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Thu, 24 Jul
 2025 01:16:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 01:16:29 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 18:16:27 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <terry.bowman@amd.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <6881896b8570_14c356100de@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626224252.1415009-5-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-5-terry.bowman@amd.com>
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 06326a48-3c29-40c8-4fa1-08ddca4fb7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHhnRTVneVFtbXlqK2laWUZnU0l3akVlMittNzVmNTk5QjBqZERiZG9uTTlY?=
 =?utf-8?B?OUJXQTBmTE90R0x6cWFyT2hWWVVaRTlROTBoLzdraFM2V3Qwa1F5NTBzSjNH?=
 =?utf-8?B?V2laaWlwbGlOOXpzSU11aFJDdk5sSUttZXBMSS9zUlJhWEszZFB0K1RZVXBN?=
 =?utf-8?B?YzAzdmpCamxFS2Q1TUVodmpDUHQ2UDBCT0dJa2NnOFJzSldpcVQrOGs4eDBP?=
 =?utf-8?B?NFlGaWlwWlVtUzJXVnd1UDdRbSsvalg0ZzR6KzdXRjVZOEg1R3hyT2U3R0ll?=
 =?utf-8?B?Qm12bHVZb252V0w0WnNIb2VuOVlnV0kyVzRnUHlMd0ZxWjE1am5pM3ljT0JD?=
 =?utf-8?B?OFRjbTlrdndPOU5qejVPaUtvWkp2enRTbk94elhiNnZtMmdjZXB6WHFWcXZp?=
 =?utf-8?B?TjQxR1A3bk9IcDh4dWVCMjdqZXlPQWs0ZGV2amprQzU0N2hEMjFLdm1rUERZ?=
 =?utf-8?B?dWVTUUdCK0ZRK3E3bWd6M3lYR0hRdldGdnc5Z0twWlRjdFUwOUxtWUJIYjA4?=
 =?utf-8?B?Q3JYZ3FLcXhMNnRHd1FSdU1VNVJpQXRob0VhU0QxOXFFRzJMVkdISnNsLzkw?=
 =?utf-8?B?dytQUXhRVERNZ282cnVZa1BzdzE0RE9PL01EaDhVVXFuaWdKNW83TlNjZWlV?=
 =?utf-8?B?MVBMaU5JYTdJOVNmaHg1UE9MY2dNOTVxeTlZRFhwWDhYcW9mY3VMOFc0WWI4?=
 =?utf-8?B?aDVyM0c2Z2lWd2pGOTNKMkJCSDlFNUpTUkF3UEtCZUNXVWFydmtvMWVhK0lF?=
 =?utf-8?B?a0VuQzZPbUFQd3lZYUdpZ1YwNDJMWmZYeVVWeGFKSzJKUFFGeEhKQUd2S1Yy?=
 =?utf-8?B?TjdqVUQyRWg5eHR5OXBNUGY3MFdydnMxWjZuTm9QL3U4L1VIK0NTTVJBRGhD?=
 =?utf-8?B?aDRpZWQwcXNvSCtLdWVVYkE3ZDhkUmFwU3pQMU9CMFNIUCtOS3oyQUZwL21K?=
 =?utf-8?B?UmZRaTVqd3loWTVzdlp2RmFneGo0V0dRdlFIVGluVXB5aWZqTFBxSUhKRHp3?=
 =?utf-8?B?SnljMHNwQS95ZG5IUHdIajB5TXBnWUJIVFFHZitsSk00YXBWb0xLN1l4UE5s?=
 =?utf-8?B?WHhWTjJkTzdBcm02ZWlNVU83MHQzcDlSbHBoWGlzVkJIN1MzWnlRaVBlZ3Qv?=
 =?utf-8?B?azEwdVFSa2ZkdGJaTXdnanM4cS8vMFlCUDN2aHJzalgrRlVXQnIzREgySnpS?=
 =?utf-8?B?eDd3U2VDYWdhV1NPRDUra2QraWdyRFhyZ0s5Wm1oN2M1eG5RZStGU3F4cXlt?=
 =?utf-8?B?c0lqZFRuSWtVRnJJWHhOdSs4WEx2RE1UbDc2R3ZDU3Y3c2ZZWkFUVm4zUWVU?=
 =?utf-8?B?SjExVlZaSi9XMGsrZEdrSk02TmlqSXJLdjNBY3R6K216Y05LMCtjcHVHZU5W?=
 =?utf-8?B?TkZEc1F6YXpWSE9YWGZScGhWM0VKT1E0anFUbmt1OXVZdEZGNTBlVkpxRFFG?=
 =?utf-8?B?VEtHZVBDQW1pNjdDQVNZKzlkcEwwVm9USzlGY1E5eFVUMDNVbXltR1JyNks0?=
 =?utf-8?B?QVh3TXBmV2JqbXRTV2JDUWdWK21JL1pnMXBWcUJaYitwbi9wNE96UmZsUDVM?=
 =?utf-8?B?SHlOK0FlWU52VHhKZDBSLzNITTAxajBqUDA0R0t0dmZlOVVNVGtjb0tGandD?=
 =?utf-8?B?dXN3NlppSmhSWWpRcSswazJsRWZVRlpJNjFENEgzQ1hCM2Raamx1TnBHT3g1?=
 =?utf-8?B?RFh1cm4zaldiZUN5czQrblBEL2gxejNPVnArazE5dzBwWFlCZTh4T050R3VD?=
 =?utf-8?B?b2FlQ1IvdU5McmNLTDBPR1VXRDJyd2lOVFhIcTY3UERlR3RhUWhtMHo2eFhj?=
 =?utf-8?B?Ny9tMS9XNzYrd3AwTjRxTzE3RjhwTWVWM0JwUlNLZHVWWUNYNUZSaWQ3TDRw?=
 =?utf-8?B?c1N1N0RiR2tYR2RrTEhSNk9BNURrUEVUUy9ETSt0WklIRVM4S1BySHEwcnZw?=
 =?utf-8?B?WEx2eXEybDhpL1J1Wm5ibk5kcmhjbFNEUGdSdkdjU080QlNSRWdpK1B4d09y?=
 =?utf-8?B?YXhjNWxCZWd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEt2RjBxc29lM3k1ZWdKazVBQ0ltdGVnN2U4eldLRnBQQzVvbDRKT0dlQllk?=
 =?utf-8?B?ekJIWVo3SFdQdWVGbkQ4REptMXAxcnF2UlJlWStLRkJCdFBRQnYzVHpZZkFO?=
 =?utf-8?B?Ly9VRHk1ZjdyYVJ3N0ZrK1BuVTV4TFk4dG8wc0dZYTFDT1IrZk1LL3l5L20v?=
 =?utf-8?B?UVFBZ3hjOWkvQWE3K2UyczF3eWlhUWZneUtRZGlzTytYQ1ZiZXR4alovbVVE?=
 =?utf-8?B?TDdsTjJNTmJQNHRjTEJsYW5hTFRGaTNXQldxZ0xTTlhBVTY1bzdEdVh2RUpT?=
 =?utf-8?B?RGVkSW1DSXZnZVhJQXcyVlpVbDBXbUUvSzFEa1k5NktzUUZldTR2Y0QxeDIv?=
 =?utf-8?B?M0VOV2t0U2hpRDR4T0pOdVFWWUtZTXpFc3lFNWx4VERQWlVCdmdlMjgyT210?=
 =?utf-8?B?U0RuVGNWZlBZdGJodERkVXBwa1BsbXJuVzdwWkV1R1lxaU5wYUJjeWczV0Iy?=
 =?utf-8?B?TzM1eEo2M0JGenMrSUxIam5JaU9QL2RDOG5GMWxCdjU1UWMrSXlMWDFjQWkr?=
 =?utf-8?B?cXhucHEvY1h0bGdtd1JaYnNjaDdmeVp6aE1SVFFxdFltcVdncDZadCtKM3dC?=
 =?utf-8?B?cnpxUTkwZ3dybldYbzdOdEdHbnhaamhTdnE4QWNzdE5EVDMxKzFYb1NUYXBr?=
 =?utf-8?B?clladEZ0UmQ2MkR2OVlxaTdGdUVhdWFTMUdYWnVIRmJPdnFqbDROOHk0N1Ay?=
 =?utf-8?B?WkdPVXd1U21oWFdKNjdFMXNGTXJsT05XM0xJYTRFVjlKY0p4ZTQyZVlzWThQ?=
 =?utf-8?B?bmhLL1RlZGRmcFZxY25vRFlxUVpBeVZ3TEN2WkNGTUN5enREYWpMZHVCa0tn?=
 =?utf-8?B?cDRGSFBzRkowSElGRDB1OFlEb2FhN2ZhaTdPMldJRmdsVmtDOEV3dTY5TUFW?=
 =?utf-8?B?d2lrWWQ1QUY5bmY4ZkpaZnRrQVFkOGI3K2VRTFd3b1M3ZEZ3c0t5WWNDNWh4?=
 =?utf-8?B?c1RUYk1QU3QyQ09kNFMrejZCUlBESEFjTUQzaUlXalh4Z2cyVDRJdTVDUnBw?=
 =?utf-8?B?bTNYeVZaajgyMHdDUUE4WERKZDdBYnF2blAvNGNlaHpqOUR0K1JLc2Q0Q2J3?=
 =?utf-8?B?aDhoclh5YzlrSFdOVDIrMGpCMlI1WlpKU1B4aFJkZ0ZkUnd4SkEwQjFVT0lB?=
 =?utf-8?B?NFI4QnlBVU5qTis4STlaYTNyeks1b3QxNjBDd25kUlA4UGhzNjBLQ1hWN3JQ?=
 =?utf-8?B?RXN1dlNmUG9KTkdnV1hnZjJoZXlCeEw1UUlqWndpV0JXYURxYXRVL3NQNjJ6?=
 =?utf-8?B?eDVDL0pYaXFobXNWNUNqVnJpZmxpSkQyendlNkI3a3J2aGcybTk1Rml4b3BK?=
 =?utf-8?B?UDYwd05BalRpSjBTYWl6bkVUNVF1b1BONU5KR0FYTGFXNEJoeUVLSTlkU1h6?=
 =?utf-8?B?OUlacUxqbms3d3Z1V0d1N2NhZmM0ZmRYQXNIUkFwaVptUjQvTXhZMTRZMDJ4?=
 =?utf-8?B?djhjdXV5TUZaQVU1VEd0VzFTSGh1R2trbWpGaE14azYyaWFQVUh1ZmJNQVpj?=
 =?utf-8?B?S3pIbVIrUllLVE1XelhWK2QxR1RvMkxoOUhyK1lkeklyOUd5eTQxUWYwV3BK?=
 =?utf-8?B?WkpDVm1hMExmcDY4NEdyN05CbC9wczdrZVNETVlrejZ3dWxxTEd0THNHRkd3?=
 =?utf-8?B?MjlVMXgvcmVWcm1tTk1VUkdVR1dZZS9nenNEdjh6UDYwL1hZYUt4anVIVldU?=
 =?utf-8?B?VkxjUWpLQVBMWnFBdlJoZStadExXRWQxQkd6azZUbG9jVE9iS1ZocmFVTUpR?=
 =?utf-8?B?SnVZWGVZTWgvRjVBa2JDVENhcHNSVjMyQnZweGdkMlpYcnlrUUZZaWVpZ3Nl?=
 =?utf-8?B?YkhFd2pHMFh2b2R0bFNOWHEydE9HdVBHcklZd0VXZ29kdlgrQVV0ZFprVCt5?=
 =?utf-8?B?VVhSL0FubFpzRkVGbncvTHZpNHNjcWhsTVZsdE9HdjdBUEtwaHpjbGE2UXhj?=
 =?utf-8?B?cTNkRnNCc1lhcDNKZEgwSTZMUmxnZS8weTJjK1dCNTZpcGtiU0tUQ2dlN2Zx?=
 =?utf-8?B?OElGRlM2dGlOV3dRTzB2cnRlajlsRU5BLy8zOEJyaGI3QmZiM0M4QU5VUmp0?=
 =?utf-8?B?a2pXRk1jUENNV2x2enJVQW5MT3ZXb2JHN3E3QXNFNzA4dTI4cURHcVcwTGxz?=
 =?utf-8?B?aS8ybllPMktXR1ZZQ01Ga1B3MjBBSUhYRGUwNWpyZnFUNW5uY1JHanlUVjZR?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06326a48-3c29-40c8-4fa1-08ddca4fb7ba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 01:16:29.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8yG8mzjdZzEuoAke8j9LgDFTbk8nFoQQXKyocPTrEb2LroIWpxXDOtZuyKnT7KfCRrskcwIMp3/B/GKMx1KUBL2bT1a/iMijhHoUDMbbOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL AER error handling logic currently resides in the AER driver file,
> drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
> using #ifdefs.
> 
> Improve the AER driver maintainability by separating the CXL specific logic
> from the AER driver's core functionality and removing the #ifdefs.
> Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
> new file.
> 
> Update the makefile to conditionally compile the CXL file using the
> existing CONFIG_PCIEAER_CXL Kconfig.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

After reading patch5 I want to qualify my Reviewed-by:...

>  drivers/pci/pci.h          |   8 +++
>  drivers/pci/pcie/Makefile  |   1 +
>  drivers/pci/pcie/aer.c     | 138 -------------------------------------
>  drivers/pci/pcie/cxl_aer.c | 138 +++++++++++++++++++++++++++++++++++++

This is a poor name for this file because the functionality only relates to
code that supports a dead-end generation of RCH / RCD hardware platforms. 

I do agree that it should be removed from aer.c so typical PCIe AER
maintenance does not need to trip over that cruft.

Please call it something like rch_aer.c so it is tucked out of the way,
sticks out as odd in any future diffstat, and does not confuse from the
CXL VH error handling that supports current and future generation
hardware.

Perhaps even move it to its own silent Kconfig symbol with a deprecation
warning, something like below, so someone remembers to delete it.

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..da88358bbb4f 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -58,6 +58,13 @@ config PCIEAER_CXL
 
 	  If unsure, say Y.
 
+# Restricted CXL Host (RCH) error handling supports first generation CXL
+# hardware and can be deprecated in 7-10 years when only CXL Virtual Host
+# (CXL specification version 2+) hardware remains in service
+config RCH_AER
+	def_bool y
+	depends on PCIEAER_CXL
+
 #
 # PCI Express ECRC
 #

