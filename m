Return-Path: <linux-pci+bounces-32901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E73B112B6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 22:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57A41C27939
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68CF25484D;
	Thu, 24 Jul 2025 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTwi+MQQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979E223716;
	Thu, 24 Jul 2025 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390529; cv=fail; b=cnU/7oLgVR/jPPWf8/SfN7MiMBWxBi/0Zq8bcIPbZYZJW1Wu810WCuiE+zRLLP7sqCr3scK8YjI6uXV19uvjtsSd5JKDFCTghkfS5Q9i8aWoEOJRmsf5/zfhCkOM+i/7G0MXlDq0wUa6KWW8r0ZPmGLh8ckMUSmZQt5wpMXdXSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390529; c=relaxed/simple;
	bh=eFg9HQBE47FX3tbCWvFoDGrcodPi/I2mRnFd3FD8IA4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=TpbEr893yXeMEdX1nefWzXYqmnTDjNYXW/1l4rOuKxAcwnLHED6JprTp4cDmNZofZ9BH6KKlwIZS/gbQqlLH3ha/Y7lWY3hmqZ2VMECZieXxoy8U17tMT+eCu239T5tvGOUN2ROuiQFJRQlgpM73DA5sze6Lb/DG/79TMZERfMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTwi+MQQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753390528; x=1784926528;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=eFg9HQBE47FX3tbCWvFoDGrcodPi/I2mRnFd3FD8IA4=;
  b=FTwi+MQQ+U4LREKdnrKDwOVOhsamI5fJOIrs8g5q+TA4amymEgtVSGZw
   BJeSCbaeyP+V4nRdaEu/v+aGat+l2td+2uH/8Nzt/I7hxZ7yp/FFErgZ6
   oVp3R4PxG5Xbo+Q0lW/OuA7nU66UdSJI0dSr6RmhR6+sd2TCXxrLslaru
   bVyyVSjrbfqTUe97pfXzHx61IO+Eq02l/r3zqv1wegwEcZmNaIIRUSBlM
   CXwZBQrG/RxIbdYr2UBCgvXaw+OGhHi/70M7YR0FM4ivNDbTYh680AmAg
   pIDE0Yr3weiBT59qcQNvNLlm0fUvUVbHaph+lmUbIEzo52Mg8C4loL+ZN
   w==;
X-CSE-ConnectionGUID: 5oyBG3dKSciRLkInANiqdw==
X-CSE-MsgGUID: DyjZ8EUvSCOeijFUgFAQrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43332970"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="43332970"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 13:55:27 -0700
X-CSE-ConnectionGUID: Bi0i8xTpQKGnQSRb93oTfw==
X-CSE-MsgGUID: AYfN+wP6S9m3qCl7ppSN5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="191463912"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 13:55:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 13:55:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 13:55:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.73)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 24 Jul 2025 13:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByUm10/JQoQ6nkLi0y7oQkPUBWocOp0sYmFhL6VGjVXab91dmQY47g70oh1JfdAHQgw7k42dfBAx6ObVNLqQPeNTcLMwz/+MFLhwO1Cpj4v7Bgr3MmMUGLYh64nDrjp6sMdsuaqTNq/XoyliYM6T3y8BhKuP2JIL4yrZcvHWy332wuCzmLWyteBqd32UVDhtm458BRGj12BJ5gqG7/Mpe5gbL+yaQJHkSo+RZld/E/jDEiwwLt8RgjMysKF5sgP94BkW8jRwRD3tRZP7itDjXMCyLv1NnIYh9ybVIyWXQRvUSvQ1olTodV0Se52YvS57l2bf6c09Bxis+nbhl9ITyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aFWg5KfuTBMZvCDXV+m1RCAg0nW3BAcaPqhvnxfpZg=;
 b=oqITn9mmOfnh6/u/oeSTjw9MT2WLov3E3GVX/B+m4FFvDNYM97LShariNlzjK+N1E9TZHXJyKUe9OXQ5ri9OqlvUACbivQm7cpz45WjsFU9mu8Jd0yZpNh6n55lXrJu1BtKfSVvARV4TfsUMfWQbFpCrBrnnrgAUzH/J1REUCwBIljMb516UrRPGCLb57KZCgVBlytprJiD5XELKOVq0Qb17vpgP1L2NErA+3Azwfx8sCWC5j9/D972iCWMn4yMKy9TBPWdo+2B/ISGSZHX3yQCGTHUHzx9j9sU3Cgx2ENcX7ufKwCW1R4psViY8VuIkZ00puxYpsuKo+1uYydXrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH7PR11MB8059.namprd11.prod.outlook.com (2603:10b6:510:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 20:55:18 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 20:55:18 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 24 Jul 2025 13:55:15 -0700
To: "Bowman, Terry" <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <68829db3d3e63_134cc710080@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <3734d11a-724e-4478-afab-27e7d3d9c95c@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-6-terry.bowman@amd.com>
 <688193f446411_134cc71007b@dwillia2-xfh.jf.intel.com.notmuch>
 <3734d11a-724e-4478-afab-27e7d3d9c95c@amd.com>
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH7PR11MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 293c7d89-2df6-4879-92f0-08ddcaf46591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjlUMEE0SldhYXJsQ0dlTXM3d3JVd3YyUjBMWGxja0Jidm5LbTRqQ2o4ZHgv?=
 =?utf-8?B?MStpY1JBTjlRUldqOEFERkdSUHBKdUlLTlhOc2V2Vlk1UVdlMmRpOFhLdkg5?=
 =?utf-8?B?VkZyTkRkNmZNUEl1NllwQ1M5RURSTGJ4S2VUeFkreXkwSm5vZ3k0eFdKcWZu?=
 =?utf-8?B?OEUrYUtPSFBuL0FEZHM3bXhYQjFrOGkvWHJwZFB2d0JWbElFK2NaSDhXUW1M?=
 =?utf-8?B?RUd4VXE1WkJjMlArcnFxUnRxVjRiSGl6UGViS0ZIZ3pDcHE3Vm14Skszak1i?=
 =?utf-8?B?UmRDWXFvMVNIWVV5TmhydUJuckEvaEk1dDlzQjU5VG5YcXc2TXdhS3Brb0No?=
 =?utf-8?B?MERqSzg1eUx3SmZ4L3hacU5DdFphbS9sUHh4RUFZVndKR2xWaW1lLzR0cHZp?=
 =?utf-8?B?K1dVWFFHSDZzMTZjYmFSanBmU2pBRVMxY1BZVTYvRlFVekt3UjFOZkNXZkgx?=
 =?utf-8?B?OWthVHYrUVZzbzN4aUQybEVHZnhpdmM0RCtyWXdHVnNNdzdmY0RZaklBT2Y3?=
 =?utf-8?B?VmFuaWxPRUowMjJZdVdsTmlCMmtUSjRCSjVPVkZDbUdBYnQrTktNT0tiVS82?=
 =?utf-8?B?TGpscnNJcmc2RUpRZTAweElhMzhzaHVLUXF1SWcvSXYvaDJmV3B4QkRCdDJm?=
 =?utf-8?B?bzlVTS9kTVNIYUJMMHliYXpsSzFPUkk0RHkrU0I5QzlvVUV4ZnlyUmFQUFFz?=
 =?utf-8?B?aE9tb0lQczNEOUVMVDJoZDVpek1zdHFFVi9aUTBzbDY5ODh1aHRHSkVta2Fj?=
 =?utf-8?B?bmlXMldxN0U3NmV5akVhdkt4WEJjVDhUczZLMFQzSDV6bWUvZjJWQlNWS2hl?=
 =?utf-8?B?Z2J6QlZndm5zSTZTemlMVW5kTmgrdGpwdVNTWkpTY3FoRENWdFlKZE9ZeVFq?=
 =?utf-8?B?Z1lBbEZ3dCtuYWQ5TjZnVno0RDFteGRSUWdBU0ExK3Y5M1BBemJuRW53cEpM?=
 =?utf-8?B?ejJUZTRFY3VhT2JkL1l1eG5IdHNBaXFHRjlQT1MvbUJWbm9KOVovQ2lSZVVB?=
 =?utf-8?B?NDFhSytscGd1VHdiQXpqbzZuRm10WHpiVU5Wc1NBNmpSYVFhWGY4aGRLbmMx?=
 =?utf-8?B?blBDVHp2SnBkRkVuQ1M3Y20zZXEvVmRjYWZ5Vng1Z29VOGJsNXJYM01WOUhC?=
 =?utf-8?B?aWRVZXI2NG0vbGJhTUZPRW1BRGk3SHlYOGZ4MVNETlZxck9yeHBCZDlmalhP?=
 =?utf-8?B?QS9DZTYvbTNkY1YwV3FOcFhyajZZWDl1bmtSMDNnalF0ZzcxR1hYVnIwakd2?=
 =?utf-8?B?bjI4QlppWUlBa1lZTUZ4cjZpMjJML3lMcVN0SktLQmtONVducGM4SnZvZjU1?=
 =?utf-8?B?SGxFRzBROERpU08wOG0rRGpNYnNrM3RHUDV1d1Q5NFRZTjhYbkd6UytFejlC?=
 =?utf-8?B?a1B0V0hiSVM1WlRjSkNvV093WUJZSEZ2Z3JLZW1pQ0RXVHpFc3ZhTnd4YTdY?=
 =?utf-8?B?TGZkZ28xMVMwWnVzd01CRGw4T1JaR3FGR2p6SGRFNExmcTliR0NxUEJGZGla?=
 =?utf-8?B?VVZsc2lEd1NsNGdnRllIVTV2UTJxVVJyczA3N3FrVnIvUHF6Z1pXNXhEMjFD?=
 =?utf-8?B?bWFTRTU1cXhkVU9TblVmRXJoMGE2UFM5S0RYVHVOOVRRZUJNcGE1SVRac3J0?=
 =?utf-8?B?dzZSS2pqbkhSbDc2L3dTS04xeFkybVZrQWxCWTNTS2tHMFhTQzZMNDROemh3?=
 =?utf-8?B?YzNoOS9Qa1p5UlRnUzNwVVR4Y1UwUWhvaWxSL0dtWWZwTXluSVBlMnNzcG5i?=
 =?utf-8?B?ZGhmcDY0MjN0TnQzK1hETDExeGU3L3orWHIxQlg5RnVndUtVRkpZbE5FcUV5?=
 =?utf-8?B?R2thWHhVM2ZlQkJLaWtLeWpDYU04R2x5bWUxMVloUlRGbE1iWWdLeVplSnFR?=
 =?utf-8?B?aldQR3FJLzZmOUFhQkdJUUlSWlNZVzhwcHVNM1Z1N29aeWhtdXE1Z0o2cVdX?=
 =?utf-8?B?K3o2T3JRSFBoSjh2Q0toVytuaDVsZzRxc1NOM2diaUNvZC9SMjdpbFQ5L3Zj?=
 =?utf-8?B?Y0NZalZKYlNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yll2ZFIwUEFmQVkwVUo4MUkzWGV3MS9sUXVmOFVOWlYyMWZTeFFaQWszcTly?=
 =?utf-8?B?d0oyQzFZNEZQS3JiYW1lWVM0eFRCWkJHODVoeW5Ici90TWpSQUZjb1RxQzhC?=
 =?utf-8?B?d2FNOEpHZi9tMUErdmNDMDR2UURXMWRxMEtHZkpERy9ndDVpTmg5OUJyOXlt?=
 =?utf-8?B?S3R2dEhja0NPTVM2OTJtR1lmeE40WDlEcm5JWjdZbDZscEUzWk8yUG92MFlk?=
 =?utf-8?B?YStxa3g4aVhhY2dzMVhMaXJhWll3R3ZWRUNVSkY5ZHRMYU5mRDdvKzhXQTRz?=
 =?utf-8?B?Y1lTRW9Gc2JKaHhvTzJlcGkyWnZwZGFsU3h6WXZSbE12MGpPNVJYTnVXZzY3?=
 =?utf-8?B?UTBTZkxhaU9TVW03TDBRZjlaZFZ6WWtHWWMxbnBpV3pjTDRJSG5aTHhVVFN4?=
 =?utf-8?B?b1U1dW1aOGtWZjUyaWgrcEE3VXo5Tkt6UFFTbFVBOHdXZlgrZzd5cmJlMDhX?=
 =?utf-8?B?TEEydlN0V24zS3l3Qys1d0ovV1ZtTWk0ak1YTjBLT3d5cWIrbUo0TGtZSXQ5?=
 =?utf-8?B?YjZjeEU4M0ZxN1QwZ2FrTjFxSXFFOVp3RTlyUWtyNXEvOFlZQzdsVEFKOTdL?=
 =?utf-8?B?azJvTW1Kc2ZEak9WRVMzWnVDWC83YUZOZ3ZFNHVuMkR4YWxST29JRzVhbXJm?=
 =?utf-8?B?dkJTeUFzYUUxdlRYRUZxRm5RcXh0U3dZckJLOHlyQ0h4NythTXRLbjY2eklN?=
 =?utf-8?B?c090L00yVjYzQXRtUUtmQytvUEI1ekN6MW9xM2hWNjY0TGh2RXJyZno1QlEw?=
 =?utf-8?B?NW5MdDNjc3JZSTNxc1hqZ1VHNUlLZnN4aC9RaUtvVTd4bFlQWUhkQnU5WGJh?=
 =?utf-8?B?OUY4YVpac3AwSFdEczFsZVREaFdNaHlYbmptQ3l2WUFTenJrT09HVDR4UXA3?=
 =?utf-8?B?Mk13U2RKSUlWdTByWU9JT21adkVzN3M1V3FHMWJwZFNtSkpLaDQ1ZEVvMGNr?=
 =?utf-8?B?REoxL1RTRHNhc2VlWkpJRXF6enFuQStmVk1tWTY2MHptVjMxalQ2U1NaMzhV?=
 =?utf-8?B?K0ZydTBCVGUwSnhiQldqS1FWbkN3emJTSkVZWnFaK2p0YVRNb2c3TmcyK0k5?=
 =?utf-8?B?T1hreGRIdTdYNVZDbVB0SWpPT1B0citBMHN2dC9yMFIrazUvRk5pbVRqRHhM?=
 =?utf-8?B?WmRGU1VDcTcvWFRVRnJrRG90blJ1T0N4T0ZKcnREVGd0RkxHbkVrU2NyeGFI?=
 =?utf-8?B?Rlk4cVlrcEZlSm0zU05vaWlPd3E5a250dHVvOTl0VFY2MXlwOGpPcjlmVzBM?=
 =?utf-8?B?ck9zVFVzMEx5VUduUmpSYUVnNEMzaVhTSmFZY3hQQ1V2RGhQZW5MOVFKMUhC?=
 =?utf-8?B?R3k3eXhvZTZtdTNKMDd4ZGxGTmlhWmFZYjJ1WFpmWVEwalpPNHdlcG1Kd2NI?=
 =?utf-8?B?aHZZNUV1SzRLTmZNM1Z3c1RlM0NTSG5tLzlwazdLV200eUVJT2lxUmtOeUxE?=
 =?utf-8?B?WG9PY2RPZlRibmx6V3JKQTRjVlZHUzdCdnhtd2dUZGl0MEdhb3VsQ0NSLytJ?=
 =?utf-8?B?cXpvUGtxZVFxOTlRd3FLdXErL3c3WjltcTAwREpiOFhQaFNUZnlmK0h6RjJv?=
 =?utf-8?B?R0xLWWMvclZUYU1HTjhEbmlTOWdJcDVFWG5mdkhxeXNYb0tKSDl4a1lyUTVR?=
 =?utf-8?B?WXNia3dWc0pLZnp5dE5GRUtYWUJEbXZwblh3MmxQUUY0Q2p1QjE5eWhIZ0Fo?=
 =?utf-8?B?bkdmbmtIVFhKN1FHUG4wOWt3OXBhUmpzOEt2RFM3bmJaZExQc2NQUkZ2a1FF?=
 =?utf-8?B?WGVnNjIranpibzdGM2ZKQWxVRGFqdFRkOHA1eDBNZXFOOU5pNGl4ZzF6RFhW?=
 =?utf-8?B?eWV2bkJqQW56ZkFOKytQVU1yb0FRTUFCcTBseHVRWHpWdURIVjVac0dOQXZ1?=
 =?utf-8?B?dER4Y2tTc2JBZFpJNXlrbmVaZGR3T2wrQmdMc3ZrTm9sWUJma0NvSlA0S01H?=
 =?utf-8?B?WWxoclY5SmNlK1NFTENDOXAzazdEN3hVT3ZFVWRYMEY3cWJWTEluZC9mdEZS?=
 =?utf-8?B?cDQxdFJBZlorRzR3SnZjdmE4V3ZUZlg5YllHeVhGNDh4SGdEbnBxUGV4bDVs?=
 =?utf-8?B?MHl3YUxtd1VQMEwveEtnNWU0WlVWVDczbTJrQ3dqd3lYQ1BzdlBnUmMveU1u?=
 =?utf-8?B?SkhhZ1FhK01DMXdWLzNnUnk1bEdsejJiU3dwWFFsV09MMTVJNHJCR2pFSklG?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 293c7d89-2df6-4879-92f0-08ddcaf46591
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:55:18.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LzJeHPjHy6SNlFqE9ExhcuMk9+/rOdfaldxzTenARoO0rOwao2nQpC/iXEj43U6GFRa1mSKV0ZuRCT6/W4PO0nBxeno+cHnU9Iu9csu4jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8059
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> On 7/23/2025 9:01 PM, dan.j.williams@intel.com wrote:
> > Terry Bowman wrote:
> >> CXL error handling will soon be moved from the AER driver into the CXL
> >> driver. This requires a notification mechanism for the AER driver to s=
hare
> >> the AER interrupt with the CXL driver. The notification will be used
> >> as an indication for the CXL drivers to handle and log the CXL RAS err=
ors.
> >>
> >> First, introduce cxl/core/native_ras.c to contain changes for the CXL
> >> driver's RAS native handling. This as an alternative to dropping the
> >> changes into existing cxl/core/ras.c file with purpose to avoid #ifdef=
s.
> >> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
> >> conditionally compile the new file.
> > I see no daylight between CXL_NATIVE_RAS and PCIEAER_CXL, one of those
> > needs to subsume the other. I also do not understand the point of
> > "NATIVE" in the name. Will not CPER notified protocol errors be routed
> > to the same CXL error handling infrastructure as AER notified protocol
> > errors? I.e. the aer_recover_queue() path?
>=20
> This change and comment is planned to be removed in v11. Instead of intro=
ducing this=C2=A0
> as a new file. The same changes will instead be added to pci_aer.c/pci_ra=
s.c Dave Jiang
> is introducing here:
>=20
> https://lore.kernel.org/linux-cxl/20250721170415.285961-1-dave.jiang@inte=
l.com/

Lets just put it all in cxl/core/ras.c, I don't think we need to have
fine grained file distinctions between the "native", "aer", and "ras
component registers" cases.

"Want CXL error handling? Need ras.c."

[..]
<trim three pages of context that had no new comments to respond, please
 trim your replies>

> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index 0b4d721980ef..8417a49c71f2 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -1130,8 +1130,11 @@ static void pci_aer_handle_error(struct pci_dev=
 *dev, struct aer_err_info *info)
> >> =20
> >>  static void handle_error_source(struct pci_dev *dev, struct aer_err_i=
nfo *info)
> >>  {
> >> -	cxl_rch_handle_error(dev, info);
> > No, can not just drop what was working before, even if you restore the
> > functionality in a later patch in the same series.
> >
> > I would expect that this patch at a minimum maintains RCH handling and
> > forwards anything else to the CXL core for VH handling.
>=20
> You want RCH handling to stay here in the AER driver or does the patch ch=
anges need=C2=A0
> to be reworked to present the change better?

Stay here. The cost of exporting PCI core functionality for this one-off
seems not worth it.

> >> -	pci_aer_handle_error(dev, info);
> >> +	if (is_cxl_error(dev, info))
> >> +		forward_cxl_error(dev, info);
> >> +	else
> >> +		pci_aer_handle_error(dev, info);
> >> +
> >>  	pci_dev_put(dev);
> >>  }
> >> =20
> >> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
> >> index b2ea14f70055..846ab55d747c 100644
> >> --- a/drivers/pci/pcie/cxl_aer.c
> >> +++ b/drivers/pci/pcie/cxl_aer.c
> > With the RCH bits moved to its own file then this file would be 100%
> > concerned with typical CXL VH error handling and deserve to carry the
> > "cxl_aer.c" name.
> The plan was to move all the handling to cxl/core/pci_aer.c or whatever i=
t is renamed.

It would need more justification to overcome the perception of "new
exports for code that is already on a deprecation watch"

[..]
> >> diff --git a/include/linux/aer.h b/include/linux/aer.h
> >> index 02940be66324..24c3d9e18ad5 100644
> >> --- a/include/linux/aer.h
> >> +++ b/include/linux/aer.h
> >> @@ -10,6 +10,7 @@
> >> =20
> >>  #include <linux/errno.h>
> >>  #include <linux/types.h>
> >> +#include <linux/workqueue_types.h>
> >> =20
> >>  #define AER_NONFATAL			0
> >>  #define AER_FATAL			1
> >> @@ -53,6 +54,26 @@ struct aer_capability_regs {
> >>  	u16 uncor_err_source;
> >>  };
> >> =20
> >> +/**
> >> + * struct cxl_proto_err_info - Error information used in CXL error ha=
ndling
> >> + * @severity: AER severity
> >> + * @function: Device's PCI function
> >> + * @device: Device's PCI device
> >> + * @bus: Device's PCI bus
> >> + * @segment: Device's PCI segment
> >> + */
> >> +struct cxl_proto_error_info {
> >> +	int severity;
> >> +
> >> +	u8 devfn;
> >> +	u8 bus;
> >> +	u16 segment;
> >> +};
> >> +
> >> +struct cxl_proto_err_work_data {
> >> +	struct cxl_proto_error_info err_info;
> >> +};
> > Why not use cxl_proto_error_info directly?
> At one point I thought there was a good reason for using it later in anot=
her case.
> I'll use=C2=A0cxl_proto_error_info directly.

Maybe that was more the CPER case where the CXL standard mailbox payload
structure is wrapped with a CPER-record envelope? In any event, I think
it is safe to drop that indirection.=

