Return-Path: <linux-pci+bounces-32849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED0B0FC5A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 23:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD191CC2E66
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8226272E42;
	Wed, 23 Jul 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5QYzBwr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D31DFCB;
	Wed, 23 Jul 2025 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307766; cv=fail; b=Rg9klOK2kwK8is7w+sxiumGSV+QIbqy5/5RTGZmDIW1SyICjxtYAxKOoCRgpgixSrpd9JeWJjKQtmQTSXTnsqaCgPm2w1LuDhQqMyEgQ0mkc5Kjl72O27rI6xIeKLUYEkSxhl4y8xknWjfsLZE3gj0xGWkNHypGQA2b3xkKcdUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307766; c=relaxed/simple;
	bh=R1dtuzEJW2iVMeMkWumRv6r44qjHP028h6o8GQP6V0c=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=jBl5UFiGGjdZsq/ffE8T9hPtqjIbg7dGEtAo/NhI5DikPfSBFBDLbHR2BIL148uPhxPGjzyChjI9o/NWMdDmfXdBYyDsHKb77K1+BrXehtRH1xV4drX0YhoQyGPNNojStH+2FeU7o276n/gDlQqdJNHD3Y1W2gXrJ5avMkrX+jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5QYzBwr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753307765; x=1784843765;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=R1dtuzEJW2iVMeMkWumRv6r44qjHP028h6o8GQP6V0c=;
  b=h5QYzBwrFEzNc73kFss9V6FX5Uhh36G0lrKOK7EmkSkimBgTTAN+ag+l
   bRa9GXnB7jSr/R/beGAl4mVWhbUodOZNg2DhWZNs/dcSdVrMrUoDvolqK
   iN/0UlQ3rrmW/a8sKYOWLI1vldHPvMI9d+wiV+QZXP3iAXuisIRfhtS4a
   jHM1hcKQ8cADz2vsYPn/5eJw4oyE/35XgEATUJV6U318Z5QkiNJ8AAO/d
   HO73LnsxHDA2l81GplUAwiO1fK5CAzaNXXaVozC32V1brWFTtB5vK9hGV
   pz1NpG12xNlwO6dieOeAWjQRVnfMvhziEeVIlbhCXiYZI2g5pO8RLOKBy
   w==;
X-CSE-ConnectionGUID: m91X5YbpQGGO9KG02q3hgg==
X-CSE-MsgGUID: 7PjRC/NzSyu2pJpAHsnxgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58219195"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="58219195"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 14:56:01 -0700
X-CSE-ConnectionGUID: C3sreLEPRjux9+9J5Uc+2A==
X-CSE-MsgGUID: +gYGmxkfTFGiDXfYHqIPpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="183415086"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 14:55:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 14:55:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 14:55:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 14:55:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8DGDhN90qeaxJciF9O8i/82wyRUGvW518fVxXCgibpxVNSaAnF16Ub6HPBKGe7Ic/v9thZS4AAG8/URDmIKScUuZ19hrp80zefYA63+jCt+QN+vKm7hXUK2mANfGmBgP27NyzIoZnRkgryjPOwhLMuZyrth3XRDvmoU6kmsZ3UU0T+El2HOv3szl9hMp7RuMKWf1+dRe5fsl9qYkXszss0fYsXigYarBZEzCtdscZERKQGGBOFDi5ETua9Rco/Z1X48HV2I7kJp0MUA9q6Ps+tSHdSeGqsfGIh88Q1B4oQFDS+03iMfflICgtMA7R2MWfPqtBUP8P84nIZ7gZY31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkha7uYghdf6KVgV0VFFZBV5tq9sCpjSwSDnVW/SOFk=;
 b=qyBEZOsB2lIkP7Zu81lUZyjVzvZuOFAJhMKmJGVK4oGNcQY5CQKlCs6hwd3/x5oAhTj9ElIuwmOEvEwv71mS76y37Mp5CgwSRloG3NnlCqUFrh3um+8AMysEf8bb59no6Acyz9Y2U6KQzWMSLM48qJufXNIuXBAkGstS8+2Q5iLkCJq1iNDhDdFMny8OeBSYfT6fCwHD1agBTKyhITb8U/hSNT+YDtQZQJ3pzcdb1weJZAXrvkhJ09UAfeNJDzhFfG6VgzjJtTSc7d0yvj4RxvFFiqtoXwDs8pR8RrhOyrkCxNlmkSwH9ge+pk1iAe6u5yVHkkkXx7h8JU4bp6IWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7209.namprd11.prod.outlook.com (2603:10b6:208:441::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 23 Jul
 2025 21:55:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 21:55:52 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 14:55:50 -0700
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
Message-ID: <68815a66459e4_134cc710012@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
Subject: Re: [PATCH v10 00/17] Enable CXL PCIe Port Protocol Error handling
 and logging
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 526d5ec5-9be4-47bc-61af-08ddca33b144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTZMdlNQMFo0aFFpZ0pSUERNYkYwLzZDUzA1akRUUUx4MzJucW9ibjFWc1ZM?=
 =?utf-8?B?YWowSWw5NlI5MDIzelQzRGJSc2FKZkZyWFdOclZDYVZtMld2cVR6WXByRFIx?=
 =?utf-8?B?Z3FtWTBJRVpxRE1tNjZkeVNCR05lOUZsQ0hxSVFIaFNLSTRQaUhETlpKdGR6?=
 =?utf-8?B?dDVET2tMVFVRdDdQTXRQTHFzbXovVGh1K0lKV1dsODg5UEJnclpUTkpOaWhs?=
 =?utf-8?B?ZW1QU3pkbXFpb2pTRTVPT3kyeVpWNldYSW9yVnVDVW9vZUtKcEZxczU2NjNm?=
 =?utf-8?B?TDdKYkM5MGtTa2hJMlFhZmRvRit3N3plaEVYT1k4Z0N2ZVRUeWFMNklwNndn?=
 =?utf-8?B?QVlwakJNb3NMb0dnNXFlR3VtOW9aRzRwWldLYnZ1VjhwcDk4dFlzVGN4VmdB?=
 =?utf-8?B?Y3RCdE8wa3hwbFptalhiWDV1U3g4aXp6YldoRzB6MVVTbVBjNVpLeldEeXdO?=
 =?utf-8?B?Sng0RDRDRUdET0VncUxpQkthOEExRWtCTDNWOXBjWlVpbDVMWHhnN21uSzIw?=
 =?utf-8?B?a0d4TVllQ0NBeWVTNXJQSTBEd2FjSkJlMVZJS3dMTGY2US8yaFBhdExyeHFC?=
 =?utf-8?B?ZDFUc2xmemhBVFRUSkhmckZ6ckhUVGFJM2xzUGpoTzV3R1U3UTJ0T1ZmZDc3?=
 =?utf-8?B?WHg3eEtUNXF0c0V0OVB5MXc3ZUFlK29JSDlzMVBUUWluNE1aL20yd0t3WXJp?=
 =?utf-8?B?LzhGMmF3aXB0Tjc0K042VEVSYVd0TTh3RjZWbEFmcjE2VnhxQWhDdnpQVjlt?=
 =?utf-8?B?aTFXSFJnZnNnVlV6eUgvbzlMb3FwTlIwVk5GNFY3MU5KUE9mZHJtcU1RM1ll?=
 =?utf-8?B?cUtXTmZnT1dnUFR6S0t5QlQwN1Y2azNOS0Mzb3RoYjlzT1U4RnZEL3hpdWZB?=
 =?utf-8?B?SUdKSWxZZ0JyMlRUeVprT25TRHhDZlNmZ2Y4bFg2dXBUSm9qWFBwQnNtczZt?=
 =?utf-8?B?VXpOM1BDb1JSdWk0QUUwTDZIVUlORis4aFpySldSdFArRXUzY3lDcU9HVjIz?=
 =?utf-8?B?K2svaDVML0RzV0NORHRURm9VM3JHc0dBOWxpZDZpUFRRNFVsVTB3ZEczcGV4?=
 =?utf-8?B?bTdob1R1K2M5QWZQNWhjZjZkb05PVmgrVUF2Q0QvODUxZldwUG1kZmxyWmgv?=
 =?utf-8?B?aThnWnVjZzBtUHpaRmlYeXNrNW4zNVFnaEs2YzBSc1hUVnZmV1VsYTFnQmsv?=
 =?utf-8?B?akhxeGVFZGF6UzdzeGcrR052emN5MEFXbzhGMVNMT0lYV1FxVGFreE93M24v?=
 =?utf-8?B?cG9xdEZzTGZpdXgwaVBtSksvSXpSOUFvYWRodGl2QVlpOFkwV2VheFBQQ1pn?=
 =?utf-8?B?ZUlTaXljNVF3ZlhsWnk5T1kxdm8zczNlM0tCTkU3RFVWcEZzZXJxMS9xK0xC?=
 =?utf-8?B?enJMTzlkY1lXTzJLQWxEWmI0Sy9jZFh1bGU0b2lNUTJ2dWJ5NDBXQ3RpR2pJ?=
 =?utf-8?B?V1lpWmJFRWVYQk01S0JvV1ZPdDhDcWpuQnRXdmt0bEl1bi9yTHRPRmhvV055?=
 =?utf-8?B?S3BxT1dRNUtySXY2SjVCc1d5cllXc1R3enk5N1YrWkNoRWV1R0JidWlKWlMz?=
 =?utf-8?B?ZWE1djhkRW5PcXRVR1lVaG8rdkZlNzZUeXE3Y25lOGxEazFVS3lZeGxIRkhQ?=
 =?utf-8?B?Q005T0JQcHhYNWNsZE5SQ0xsSTVJT2NMWXhvdW5WSHBGclpWeERibHhUaURI?=
 =?utf-8?B?YXFCQW16SVBXclFrL1FyV2p2dWdhUVg2TkZpMmJSbnM2L0I0elFka1FUUlNm?=
 =?utf-8?B?QWtBQ0plenRoTHpHbFhrM2Nrd2trYXVYbjl5NjVrRFRBSWl6eXJhV04zUU1L?=
 =?utf-8?B?TlZJVnFtWDQ2RVNCaUxPSHdocDYvVkoxWkVKZWFwQkdQTHpLSGxQQllON3lj?=
 =?utf-8?B?dktLdTdEOStWM3pKWTlBMzArMzl3RW5raEFxYWdoUFhUR3kxVmlFNzFicjQy?=
 =?utf-8?B?OHZSSDVBa3VTWTJwdWtCaG91Z01jNUtXZUpoMENNbWIxL3hHU2o4UlJIQ3g4?=
 =?utf-8?B?ci9QUTlpSmtnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTJqZU16NE8zdDk4VUUrU0xsVFRKMk9hNDVjTHpjUVk0VU9vQ0NjQWRibmVw?=
 =?utf-8?B?Nnd5bkRsdzBwQ3lBenhNUCtiOWNWN3N0WXFuOEpYLzV6WXFKQ1lRRnNpQy93?=
 =?utf-8?B?SDA5VDNaUEFtTGVzWXVjQU8rUkRjWEhnK05pK09BYzljZVZhYk1RMW1Jc05M?=
 =?utf-8?B?REJNZ1pmZlBiRk1XRm45d3AvTmhhSVJBUnRzZnNPUVY2a2ZraU9QVEtBSU5n?=
 =?utf-8?B?bzQva3dtcjVpcHNwOFNzSWg2M0dicUNVZEYrbVk5TjQxdjlLNGlwMjVXRjdq?=
 =?utf-8?B?RThpSWtWR0hwajhrWERtZENYOU1pSWlaaGFBdGJPR3FvUGprWUxlOG1zbVZ2?=
 =?utf-8?B?b2dSRTZpY24xMko2VndCTEt0Z1dGMlIwa1owKzFaVFpmaDFTdkZmbE5yL2V4?=
 =?utf-8?B?cjF0d2ZJRkFFbitqRC9lZVJGU3JhbHlTL3MzeExLQjY4NXNYaVoyTEIySS9m?=
 =?utf-8?B?MkpGdzRrUy9XWUFhUFBwSEJmM2U0ekVPWERRcGw1a3k4K2RkRFpYNXNoOUZw?=
 =?utf-8?B?ZGpRbkMxNk9PY1k2Q29iZ2Q1NzgxSkowcWRmcWxmOGptblNLNlJPcEpVd2FH?=
 =?utf-8?B?azVmeEFPVGFlckRQQjFZV3c2b1grZEp4YTg0SHUrVEl0TTAxSXBOV2d6dXVw?=
 =?utf-8?B?NDNLKzZJNEhLZU5wWktuTm1jdUp5Z3I3dHhwOUM0VU9WeGpKYjA3bkxoaHdT?=
 =?utf-8?B?ZkxrTS80a2hUTmJOVnh0d1djYXkxY0g0Qk41V0tLTE9WUTVaRnRlT2ltQVlL?=
 =?utf-8?B?WURxdU4zeWMycUVoMStEWS9PbjNDWVpha1Y4NmtJSmpEWXZuUmdYNVhrc2tn?=
 =?utf-8?B?OHNkRHYvMzZxbC9MK1h0VGlZQlBKK3NiWVFrNTZmUjN0b2ZZWmxHRnhSSXE0?=
 =?utf-8?B?cHM5QnpNTjgrSDdpV2gvNmVpRlgwTDU0b3UyWmRGdW5KVTROVmpaaHpsdHFk?=
 =?utf-8?B?YWUraVdMeHZIWmJBRTJqT1lJY0wyTEhhaWRhMzl1SmRDbHJWc2k2ckxKK0Fj?=
 =?utf-8?B?djhCZTl1VWNmV3lVVzBOQjBoSWIraExKamtLTElaZnJBMm83dFNWQU9Mck5V?=
 =?utf-8?B?RGJRaDZaN09rM00zNzdwcS9RNzl1RzhBZERFY3JYRFF4R0FGUkJOMWFkNXpk?=
 =?utf-8?B?ZGNXQmtDdDBMNkRSbGFKTmZ1ZUVvMFN6UDQvMGJKWDQ2ZVlsU09naC9rWGpu?=
 =?utf-8?B?WlZSMnVCY284NjFoZmdROEpzSDZGMjNTVUxJRTNrVmJteHhTZC9kMDRmdnFx?=
 =?utf-8?B?eUZDNVRoSm5tazczVTAyaW0xV2tDVUJTVUxyTzFrTE5vU2p3bGhqN3ZPNWZY?=
 =?utf-8?B?Slp0MzVtOFMzYW9ZTEZGV2lmY2VwN0tCZjh0UzYrcFBBMXRlUTlwM0ZVZDVj?=
 =?utf-8?B?QVlSWHN6MVpKWktUb3J0Rm41YXBGOFUrb2dsYmRRYy9zelN0NTE0Y3JGYnBh?=
 =?utf-8?B?YlNnMXgxVWEwS2xTdklZM1o1Y3B2cUhNLzRaUlhwQ1BXMzh6aCtpeWdDSnNC?=
 =?utf-8?B?YytZUmZNa2pJdU9FcWdWNUJ6QmFMemt1anZYYTQxK0MyWi9zTk9aMUdDZkNa?=
 =?utf-8?B?REVDeHQ0ODRDS0FseE15MitCVFBwYkFPUHRhcXcyUlpCcXVvSUVBVitYbUJN?=
 =?utf-8?B?ZVZMcENVckowaElDNmdWRjlKUlRnZXl6djNTVDVhNTVGbzdFK2JIMGxtcFN3?=
 =?utf-8?B?VVViMytGZC9XYStITHk2Tm41M0h4UzNvNFBNcHlpeEFHekh5d2lmK21zRWF0?=
 =?utf-8?B?UlN0R1NIb2ZKU3JCaXlRMEQvd3o3ckVKcWcvOUZFRHl6eFN1L0tXNFJpRzNL?=
 =?utf-8?B?RmpnTndyTDNHaGkzWGdwbHVVdW56OFhlYmR4NUduYXZBTGZjaFBpS09Qekor?=
 =?utf-8?B?bkNOa3BOWTAwYkpibXU0WXhGcFduMk9KSDUwNFU0aFQva0FISHFUaW9NdmZL?=
 =?utf-8?B?eWpmdFZGSTZtbitjaEF6cEhoWVA5M1V0cjlXWXBMSGJrdy93YmZEQ3ZNUFBH?=
 =?utf-8?B?bDh1MXRiaFVFSzU0akRhUk10OGoxQ05ibXVqUENndkhWeURORzlWR1JzUXdx?=
 =?utf-8?B?QnE2V1R3NUhXVjZOb3p5RDloeWU3SHlqSFgxaDBrTWlzeW9LQmFSd0U0TXBk?=
 =?utf-8?B?MGpXU3Z0Y0RTUzFOdU9INlRnMWx0VjJnQkZCYUlIellxVWpaNDFQUDFTNElv?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 526d5ec5-9be4-47bc-61af-08ddca33b144
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 21:55:52.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuDDbReuAHHcqyIeUVycUyx14W4+1BhahIQUABwVTp3aRosJpgmJ42MKpxsczeXWOmEGZf2zIgJHYTTkJMMFE3DJfl9zfhg5nCnPxgljArc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7209
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
> Endpoints (EP). The reach of this patchset grew from CXL Ports to include
> EPs as well.
[..]
> == Testing ==
> Testing results below shows the Upstream Switch Port UCE and EP UCE errors
> are handled as PCI errors. This is because aer_get_device_error_info() does
> not populate the AER error severity and status in the case of FATAL UCE on
> Upstream Ports and Endpoints. This is intended because the USP link to
> access the device can be compromised. The check for is_cxl_error() and
> is_internal_error() fail as a result and then processes the error as a PCI
> error. Also, the AER event logging is missing the PCIe AER status.

Are those issues "TODO" or permanent quirks of the implementation?

Although looking at the error message they all seem to correctly say "CXL
Bus Error", I guess I am not seting the end user visible problem of the
details you are pointing out here. I.e. LGTM.

[..]
> == Root Port ==
> root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh

Where can I find these inject scripts?

> pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
> pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
> aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
> pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
> pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
> pcieport 0000:0c:00.0:    [14] CorrIntErr    
> cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0 status='CRC Threshold Hit'

Hmm, why "memdev=" for a root port error? Will take a look at what
cxl_aer_correctable_error() is doing.

[..] 
> base-commit: 716ba3023561ccacfaa28f988d26717535b8fed1

I cannot find this commit in mainline nor linux-next. Please do try to
base series on mainline tags, or otherwise push a public baseline branch
somewhere. Helps reviewers and build bots.

