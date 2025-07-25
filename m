Return-Path: <linux-pci+bounces-32906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26134B11550
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 02:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90AE4E83B2
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 00:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284F13D891;
	Fri, 25 Jul 2025 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YegZ8thk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DEE11CA9;
	Fri, 25 Jul 2025 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403944; cv=fail; b=TBDQhATxCjAcrRyeZ/78VcsJeWSl+s3Idn1ySYykQvaQduWdUERb9GFH8A0POOaFfuGAby9ZigbP10xN91XjyhJ6Q48xcEQaQU0OCiIfEDlsUA3hGJnA/DNH9Kc0ujjh6JdJMswHAOvLCMl1MomhxRImmcJYCgPXGx0jySRW8vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403944; c=relaxed/simple;
	bh=Gm8QK9803lAYSYzGrvrK3E/3jNXt6RPxmKeGm/K3nPI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ihADscmOqtw7auiiKLRLivnLwE8syLFycY1e1V63t9bKyBYYuDJ+FArUXC4TZgj+ZSGpNc/yLE+iztFCJL1shq3pjoMdVa0wiznr5n2Am0R8Qc4IbHrIhev/8EHZ1Mj4UYtUM1b0xAzRJisGir1iwrHcaqs8qTUj+fNRw4QL9Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YegZ8thk; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753403943; x=1784939943;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Gm8QK9803lAYSYzGrvrK3E/3jNXt6RPxmKeGm/K3nPI=;
  b=YegZ8thkMe+dnwlwnDO3YCmp2E3poIvOkm3tsF8Cgp1taCNtIbOLuwIa
   pZmDux/pTDRDF9LkILAj8sAW0IvqvlhyvX7FJZkmiUXK6WK4lUjCrB9YP
   LmlPAEg7livRDoMBPcxbp8ZjNmosgpq2bhTCFOBBMmdGFpieB8WrA9wcC
   wJIyHxvEBO7kZCvs2Vopdrf0eAGSMIWRHrUaHkDjyP+Qp8zHAbfzhvVBD
   pJ4+qLHJINPx0zFf50eivijRiLYnI7xQlo4niSRZpJffEgSHX+FVuztG7
   iSwMF+OtYPFNb7+U0ySrXluCVkK3Z54GOr1n0mUKVbnx2kChh4qEPLuhk
   Q==;
X-CSE-ConnectionGUID: i+rikt/rRGSu/oPYK8TWcA==
X-CSE-MsgGUID: SJF6kRsnRiWQcf7XrQre/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55436316"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="55436316"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 17:39:02 -0700
X-CSE-ConnectionGUID: 5JVnzAP0RAmGiudjtBPZ/A==
X-CSE-MsgGUID: +u3UbRkzQnydYKPjqz7Riw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="160574043"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 17:39:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 17:39:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 17:39:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 17:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlWzfjhE5ajGRg+RvXlJitC0I8z3UdrG3DQ3gTqGIAgW+1DQAhbPJce1lpEzC50YmpgxUWuTUwtV08LQ1q7ZSFejcYH5ssggcijcCoNN4Z7MMdvZ6Icm6c+wAkLka2pWNCIRBG9rH6fvoWx7+Nr+wEGH+gQykxjlKcuNTvUmcQO0w7q7QMmPKewS85qH64SUfvTdpZB2Ivm+IBfiPcLAkg/ZOA+VN0aTAUmlBUlTdcKAceLQwEvDqs2VGxvv5cyFdwt+UdISx1T6mHLRsMQdhJPhmYw/x+0/VYjqEtlHytu3uFzTHI5j/s+68jPpgOhtyee2I7iX8Fb3fDAqgpZCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUni+7eGaG6uTfkaImDK5WzknBpmJevkzCuxu3/4X7Q=;
 b=nktnRyyTyPrCEAy1K5IBWwSGoYHOm+riuIRkm8zHYX1SyfrAEgf/6s4f+uLix52zkN/z1FgBt9lZW4DuFx3D1MKhptV7VfL0GwYImU3fgSH4bd32v/eS7Rn9c7nFTuPn+EOlm2K9szGagxD+pXU/eSeHK3Sl08SbUjc5YtVBDi9Uu9NgEx4VJw/VQIR9etZwDPOEyDBoV8hwOkHlRdrlCbBUfC7spbfZinCnWR1N3ok0JTCdwN0T23fadhHXcsKbUKlDCbQie5M1xw/dbmNzMA+dvOyzBmCjRV0+vi/VwEtRoY5m8oJOA/MuxhUN/K6PhJ04u6LgwNDFVjndd0eEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5771.namprd11.prod.outlook.com (2603:10b6:a03:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 00:38:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 00:38:45 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 24 Jul 2025 17:38:42 -0700
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
Message-ID: <6882d212cefff_134cc710099@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626224252.1415009-7-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-7-terry.bowman@amd.com>
Subject: Re: [PATCH v10 06/17] PCI/AER: Dequeue forwarded CXL error
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d44e0d-a634-4ea6-c5fa-08ddcb139c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVFDTzhCc0VEcEFDdWFCUzBJejFRSUMwS1p0NldyODNjSGFQSFY0cEZKK29M?=
 =?utf-8?B?U1I0NG9aN2tMRnNyVVdiL09UWG52VWl0VHpvTDJBVzk4bjZ1Uk5Od2U4bkJI?=
 =?utf-8?B?SXJacDR6Rjk0VjdJRGNES0lWS3JFaDRxN3VYb3Brb1lERVhBcHFnOWhWdUpu?=
 =?utf-8?B?VVdaQlJGbFpJYkpFVGVvSnlwbFd1cTVKeTZtbHBNVTJYb1JGMFVJSURkQlBM?=
 =?utf-8?B?RTI0SlJzV1MzazVCc3N4cXBqYkJNendlSS81Wis3cGRFMXM0Y0puQXhZcC9m?=
 =?utf-8?B?WDl0b0RNV05RMmxXaEU2Zm51aEtMU2wzVjFMNTkxQlBIT3RMWjljd05UN2hO?=
 =?utf-8?B?REp1dHltSmRFNnQwK2V6a29ETHFka1BkQjAvQ3QwTStxVHZwZGVFc0hUdXpC?=
 =?utf-8?B?WU9WTzVxQzFKNWhxWHF4MVk1WkhsVUlMbGx0bW9LTVV4VmNJSjFuZDVYNEJk?=
 =?utf-8?B?M0xQejlXcWJ5V1JNdW1QV2FKYmNXM2FHMVRoUG81dzRoc0lsQ2VnNEcvd1Vu?=
 =?utf-8?B?NzZ6Wjg4NmY5VjhOUjkzSkVtQWpValZEbDMyTkJGRmdCMnNNTis5K09UR0lJ?=
 =?utf-8?B?cWVBTkFvSUR4RkJHc2dPd2xibzMrQmpGVUhZZHVjZG8vTHQzTTZLek9mYVZG?=
 =?utf-8?B?bS9CN21UQ1hnS2pqcW1paldWVTZ4cDBqc0FqZHZMeXBGcUdFYTZQNFVtMzk1?=
 =?utf-8?B?cytpMG0zRzBsMEd4RlFmc2tsclVQWkw5Sm9FWWtEeFRoQ1NOTHcraGdmNHkz?=
 =?utf-8?B?Y084QjU0NWZkV3hLWTVkL3laQ1l6WGxUWDdkOTljdXQwT0JTSWt5VlhQY211?=
 =?utf-8?B?N3gxZ1ZhQmo2TGFsQVRQOHBiam9rS280YzRpZWo0TlhwTUlieEQ5ZjMxTVRL?=
 =?utf-8?B?d1ZtT1BEWjBLTVBmdmpWOVkrdXlFYWZvSnlkbkh4eXV1YUNOT3o3U0JpMXh4?=
 =?utf-8?B?NmphRmIzS3Z2OG1MUXU4MWM3d3E4emlxUThmcXAxTEYrMjJpYWlZaVphMVZN?=
 =?utf-8?B?bDR6OEU4UVdXdmdVK0RxVXFpVmV4MUM4VlpkS3gvcTIvbXhzeWwzMnYvOGVF?=
 =?utf-8?B?Z1htUFZOejVMeG5nL2lValNSSmNGcGlGdkg0TElmTTgxYjJTUDhnRnBYRHVm?=
 =?utf-8?B?NjVCSWZON1ZLdW1pS2cxbkpwRzAyaGUzSmNrOTMzSHZXOEhJVWkwaTZyK1hU?=
 =?utf-8?B?VFJENk9VQ1RpYSs5ZlNiZkJrN3haeURkZEVxQXNKaE9WS3Y2MlBVR2MyRkMv?=
 =?utf-8?B?YnRYNC9qOFJOeUh1TkVIU1hsS1U3bEZRWXVCZXg5NnJnaHBmTGZKeHo4c2Jk?=
 =?utf-8?B?UjllZzR2MlVaTTduOTBXMjBlSk9IR010M2taT3RCZ0thTkt1aFNIMWJHQytX?=
 =?utf-8?B?UGp5ZjJaTURLMmhLdko5ZmRSdmZEaVVIbGs4STNWeWZiYjFwSmhIOEtrR1lC?=
 =?utf-8?B?b2ZoQ3cwdmdUUDNIRnBvWTYyS0dMejZLSGYrN1krWExxVDYxc2d4LzBodkdw?=
 =?utf-8?B?NEZKV2FTTTh0QUZsMzY0Sk14aHlpbnF5cmlqdjZ3R1NzRitmQllERFo1R2pJ?=
 =?utf-8?B?SWgwdWs0bkVyazltRFJvOEQ1V2RuZlJqd1MvSEwxT0hUZXkreEtiMU8wakFT?=
 =?utf-8?B?NG1Sa3JLL2ptdXJYb1lMd293YVhxVmpDR2FqZ2JiUG9UdVZzcDJaRThMb2R5?=
 =?utf-8?B?MnlEM25aZkpRbExrZ2U1YnZxSUVydTRwSWxUamt1d3dsaldSUHk5REVFVWtk?=
 =?utf-8?B?S0xyemVtYUNPVFNETzYrdDUwTnRGOVF6ZmZvTGRLcEw3VERMb3N4TFdOaSs4?=
 =?utf-8?B?WGRmL3duN3RmbEQyaVhjWVc1QWF4OGsvRzBVME1GcUlONUttVThyVHVWS1ZP?=
 =?utf-8?B?MlVxdE1ZczF1R1lTdjIzWFZtQWt6VUJPSUYwMFFraDFNU2tnMU5HWmRmc1dq?=
 =?utf-8?B?RStjemErbkhSTDVpcjFhZXJRS2paZGptRTlvdmx3NHZCNERsaEp0WDRqUjJY?=
 =?utf-8?B?bzZNVHRxS0JBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUkxOUI5NUxoWTEzT2xXTXpQaWdZVUhrVzVXaE04TlBkWlM3YjJIMmQ3QWhE?=
 =?utf-8?B?YVRndWxNMUVXM2dNdlpmYldzdm9JN0pFT0phbXRzU1JyeGZZWXE1cEhsUWp6?=
 =?utf-8?B?VGNvZHZaOFNQaVhoMkkyc250bS9WeDJWWC8wT1hUQUswMnFxTWxuWVpaUFRD?=
 =?utf-8?B?dXA4c1hKWWdyK0E0d1FNYVpGRUN1czRRYmo3emRQUElkdnRJZjhrTjVybWhz?=
 =?utf-8?B?Nmt6TXorTG11bkJ1dzJtYXNsdjhQS24ybTR2SDZIY3pnV3RPb3hqTVdwbHFO?=
 =?utf-8?B?QS9qNm8wNEtvem9ieFVGcGp3TUdWWHpnNlhDVTBMVDVvalJrS2YzNHdXVnJ6?=
 =?utf-8?B?bEdscnM4RnRmeXUzcUJxSmVqbWQxUkcyeTR3S2h5dHgyREU5THkxS2VNV3FK?=
 =?utf-8?B?SzN2Y210OVhVbVdrY1F0eGRWSHVGc1ZBVnVZUmxaaGY2S0xjcko4b213bFBq?=
 =?utf-8?B?cWNOS3lsNms0ME5KeEd3Uk9rUzZla3hWbE5QcCs0YVl5Q25PMWhDOEZ5UCtG?=
 =?utf-8?B?M29CREZuaVFWTTJlVzA2U2dVL1RQUS95SEl2VlQwaXVpWkYyYU5vUGJUc3B4?=
 =?utf-8?B?ekNKdnU5NHFoVG9ZdUdiQlIwSml0bU5XMXladGZicEwrUFI0c2ROZnluWVY1?=
 =?utf-8?B?VEJqcGtVVUhySFZ6SG45M21YSTZtTU0xMnFzRlNuUUduaVRsY1pPMkY4UG1L?=
 =?utf-8?B?dDdJSjdBVytUYlExcGhVeHA1bjZ3Y2FJaDNaN1NCeHlEUnVtem1MQm1sTDFu?=
 =?utf-8?B?bnNRRVBIcHg4YklCMHRZZys3ZGh4dW1LZEVpa0k4T3AwMXRrckNoWXk1Nyt5?=
 =?utf-8?B?RytmN0dEcDNYWXRHZzNEMncydHdwaFhNTE5aOWtSZDZBanBpYituNms4c3pM?=
 =?utf-8?B?dUUyS24rZXd5Tk1WMTNacE5lMW51RUVFVGdWWkxYY1g0anZqeTJNL3lxMjdy?=
 =?utf-8?B?d3lYMkl3Yysrb3FOV2NsUjl3WWl6UnNucithYzZ4Kzc5eDUwbm15aVQwNG9o?=
 =?utf-8?B?Vnp4dFJscnlIeTRJL3NkdHozYzRJYWxQUnBrcVRqOEkwMkEydWhONnp6b3hI?=
 =?utf-8?B?eFZaV01NRVhGcWJNQlNqRTU1OEJFdkVzeWh3V3ZocTVOaHFId2NmdFd5d0Uz?=
 =?utf-8?B?TmJubjJpdnRSN1dZVGdsODdvYUJWcFo3Mmd5SGFjNlQrZEV4TXdtTDZQQmhS?=
 =?utf-8?B?ZnQ3dEUyakhPL2JpMzBlTytNaktzUlFENjlVUUp2V3R2VGRXeWU4UEVGdDlP?=
 =?utf-8?B?TWVQS0ZWSFU2RkNiRVhIL3J0M05hd0JGckE4dDkxS1E0WXc2OHFta3U1T2RG?=
 =?utf-8?B?Q0VtSXhJbzNRSDVNNzVtM3lJZzd5QnN3UXl0MEpPNlFBWVNWSXlXY2NMajJD?=
 =?utf-8?B?L1pidHlybmE4THNPL1JmVFJHVnhxWk9lUTgrWSsyanc0MjIvcDd6SzVYTmtv?=
 =?utf-8?B?aGdpTUZpckU5ZVFRU3NlRWxzSXMwQ0VEaHBvT25QNlNKY2t4UUQrTVpCdU42?=
 =?utf-8?B?d1NNeENuSnNFZHE3b2tWU1VNWVd0cVFZUmNKWmdMV0c3aDRVTGYrcmROZmF0?=
 =?utf-8?B?bitEN1hSQ2ZtKzBYTHQrZ3dYT2U5Z29wZEtqUGoxY1BvMDNSeG5YcXRDdFE2?=
 =?utf-8?B?TWNIWjB6aEovbktXck9kUjQ2NTNJbXdNd2JtT2pYYisxbUREQUd2aGQ3Y2hQ?=
 =?utf-8?B?Um5lNWRoRHB5STRGY0Z6MFZLOUZWenRGb2hxclIvNUF5a3VjV3RIQisraUVu?=
 =?utf-8?B?d0lyZ2dyeUZUR1FicE5sNzdsaEhUSWNWM1dGQzhZNmtROUNyeXh4OVpmc1NG?=
 =?utf-8?B?T2FIR2tEMFF4dFBHbGJGUlFWZ2hLaENGSjEreVVHVHQwUkNrQjNhNlRTem53?=
 =?utf-8?B?em1kUTNkMk9hblZBM08zSU51eno3RVA0c3o2QVRsY2JXTFlCZGliN2J3dUdu?=
 =?utf-8?B?YW41dE1ZN25ZS3QzQXpPSzlhUGlvclhVZ1A0WTZXQWZqdXlNV0FXWTJoa29w?=
 =?utf-8?B?aWJycDIzZkdBRm5hb3ZGNitnb3FKcEsxOVBQWFFETjRjS2YwU05qRFcvZ3NV?=
 =?utf-8?B?eUNwemJ1ajJqdlRKUzlkTythUnNtTHpaSUtSWTkycVlUTFFTZVg4NGQ1M1Fh?=
 =?utf-8?B?ZkQ5K2c0cmZZSlptcFRuVEJ4U1hGMGZ5L0pDYm5qS3FlcG5YQzd6VVNUVm4w?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d44e0d-a634-4ea6-c5fa-08ddcb139c89
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 00:38:45.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/XxGyn8SEyU50IsWoJRT80ZBZZ7Nafjn50HPSP9IPPHCY9UM4l387wtpQhc+j9F+K5k+o8GDMJzQmq1Vmi008WeQlRrO8Yw1Zniv+CvFEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5771
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER driver is now designed to forward CXL protocol errors to the CXL
> driver. Update the CXL driver with functionality to dequeue the forwarded
> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
> error handling processing using the work received from the FIFO.
> 
> Introduce function cxl_proto_err_work_fn() to dequeue work forwarded by the
> AER service driver. This will begin the CXL protocol error processing with
> a call to cxl_handle_proto_error().
> 
> Update cxl/core/native_ras.c by adding cxl_rch_handle_error_iter() that was
> previously in the AER driver. Add check that Endpoint is bound to a CXL
> driver.
[..]
> +static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(err_info->segment,
> +					    err_info->bus,
> +					    err_info->devfn);

So this patch in its current form is about restoring the RCH error
handling code which we already talked about should probably stay as a
special case in drivers/pci/pcie/.

For v11, where this code can 100% focus on VH error handling, my
expectation is to not see any PCI topology walking, i.e. no
pci_get_domain_bus_and_slot() no pci_walk_bridge() etc. If all we cared
about were PCI details this code could have remained in the PCI core.

Instead, my expectation is that motive for a kfifo and calling back into
the cxl_core is cxl_core has a parallel universe of software objects
('struct cxl_port') that can experience errors independent of the errors
the PCIe core cares about. It also has a cxl_port driver model that
knows the lifetime of when RAS registers are mapped that the PCIe AER
core can not know about.

So, the PCIe core has already done the device lookup before this point.
Just pass that device to the cxl_core directly, and then use that
device to lookup a cxl_port and/or cxl_dport directly.

A useful property of passing a 'struct device *' to identify the error
source device is that it supports cxl_test emulation of CXL port
protocol error injection.

