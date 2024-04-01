Return-Path: <linux-pci+bounces-5498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC49A894474
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 19:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33421B21CA1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8D4F200;
	Mon,  1 Apr 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUBkPuxp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BED4D9E9;
	Mon,  1 Apr 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993636; cv=fail; b=TMO3LFwZqHDWCozqIy+eVOPOkKiiZPUmHYibHUt/NVa+Z38En+TgxObrt4jx7hLbem6gXJSYd92hqDGgfUc5/9/YycKbjqmY8av4SBJsHpOnK810x1osKFn50pDAO4CykLOMdX05V7B+Tk/SSQpKzl/581XJ77g510XT63iy6J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993636; c=relaxed/simple;
	bh=Pcn+6c8DM22p426KSS8TLc3rAodzeJoSjvSWZTT+qpE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kuVazi5yTwPIdd1dueYl1vPhgGShC21TKK8+37M4pNO2lR1kJ9eJrd7gMV7PWhHznIIrhSE+nTrcxRG8PpB3nFMbAtOFYkeB7EIArgVMywrgfnDdWWlEpw1pP/spUoI9b8kSavMHISwxYClf5OyEynhmoX2fAcv7DoKVjXpEDlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUBkPuxp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711993634; x=1743529634;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Pcn+6c8DM22p426KSS8TLc3rAodzeJoSjvSWZTT+qpE=;
  b=lUBkPuxpDLvRI5q73maoaCglfWucCcNRoyJcHkJYL/4QQBAYcYD7v/9K
   ROkX2GILHp3+FyG4/W2YnElP1UrBhIcf6k6hIvAqGMwIksfteYF5TePK9
   yA867A6+dYigw/K+NwsJ8ePYcxFsWKuZP3jfFFgKuS3HIPjXKYxRxudmW
   dIILNFKY7filh9Bx9q+dJE/F49hOP7Y7K92X/i+mi+P0F7+QBuHuLos2M
   /XVtO4s920vfOgMlKuYDWjtVGpS1r+gEgHFCm7iYydnJBJAupTlexQD+Y
   y+GPrreIKXt6VsrrlmiovymzjSQeAeIImlcCeJRUZdGrpLV+LVspcwFr6
   w==;
X-CSE-ConnectionGUID: HG4t+mHvRYC4LRIlJHzIHg==
X-CSE-MsgGUID: uYYgdrZ8TzKPEcPZy6Vnmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10952520"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="10952520"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17864832"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 10:47:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 10:47:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 10:47:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 10:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/mJqMtTyojZiatb9PxY9vsPHB5Ni1k2g38XO2TLEfzjTx6aBp91wmdyt/fcD+ChKilArrlmGoZYK0xXGp41lUoeOlhm/ufF0WDzIxo9L8EV54lFys0+HNyl94Sv5wvCszx5UrBJtX/NwAd0mKIlmL0aNWRTkbQrNmn06sCfOuORUfRJPh2KLAzZAQJ5Li0uAYoW2s6Starn7GTfAIj6apgdoifUejUvKYpRB7fgmsjQelpMNVeglxLPtSaE3xzRBgN1GK5sNDHollfcKEIb+Hgf/cYWfOB18sJPD0FoiL6neWyoLNqRPsLwaECT0p3Fwh1g2Wdc+a/QnIOv6R7kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxJgDQQ/jNJww4EjgeFE3l4DV6h8aWW4qWy/ZZXxbxM=;
 b=fR8Mqltb+obbTXB1txLkm1KJFbaydcfsqp0w1mBonzp6Nmscq6+rfEsPrm2JE5wNUbXH8AfyyiN2Jm38TcDEZMAZnwNh6n87o6ry9QHyiGvHalNtGT2J3u917G1EZ9+5H5BKLtxzhBfXeSSmmdZ+eac4tqEPDRnIP+KOt+Ga1EL+G99zB0aFRKeWwyT3pqMVujxWrWuMCtNSWRmmIB9XvFz0m4aNOqvsoCpg2ekfLo4HNbocUq03tuGnGSPN2qxnKshBrWeXn+NaoYIgKSEyfgczgF+F4bFv0afTqfeOboJY0tgTYQMWmowlCenwITKoxVFKNmw4SfjH/3wkUgWS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8238.namprd11.prod.outlook.com (2603:10b6:610:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 1 Apr
 2024 17:47:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Mon, 1 Apr 2024
 17:47:09 +0000
Date: Mon, 1 Apr 2024 10:47:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>, Dan Williams
	<dan.j.williams@intel.com>
CC: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<linux-cxl@vger.kernel.org>, <y-goto@fujitsu.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Message-ID: <660af31b8541e_15786294ae@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
 <mj+md-20240329.221545.11188.nikam@ucw.cz>
 <660767abc418d_19e0294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <mj+md-20240331.010245.99093.nikam@ucw.cz>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20240331.010245.99093.nikam@ucw.cz>
X-ClientProxiedBy: MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8238:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoK4HXJ0KuPtTqB49GJAOuCHVPfhuPHBxLKmpNEVBI5d+4Jx1RfahqkhmD+RyxG3Ox6/Su3wgBLM1cMNIqRNlECxJhrTHOKuFfgMVieJZMHULsQcU/6XLI66nOrQp1XEhSaJA2bd/tjdLz6E0MHhZvKQQtJnKH56UI8Rr4XM4RnTLHQM94wgZYLUJ8uajqf38YHQfg3ntGCYbzvze+GRQQLuAq7bLeqFagIOCwVAN7hYvYYWF6wUCvXz+RKw5FM3snsSl8+ckwY9VxvNavkPphA/7JgFtNhUy+mwTMkXTjpydj9FfC2NgZ87PSU5aKxTuG+qrgTJjvGEjaF35DPMQlBE1/7Gy26I3L68ou85MBLkJcOXPdzdNYDi31ogFLT/56eUyAk/flsNC30t+hjKCI3WxA6QklFUkBog/e5UMEgVulLOg5fk7uYUdrxoopj8auK/WLlwNtofQjNdOp+3RvjaAYTrKEZ4J2yH2D50OVD+RUxaVw9uw3EmHoSqBQ9LkVrj2EeTjH4N3UqZodN0+xeiNvcjBJeYFQiJ2GnhHYVB9e5uaK5qZdCFOvCXArGysw+WHsgkv+omNjuh2sj8qVsPNi941zxlYQYNU2tOUr0vJ2a2D4FydkSAkdRsx1I4TuntealNGFnFMEJ9IWkPAhuGJTlFlRdwGG1qCJ2vjHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9GVy9NYm5YV0duZXBPbGJXclFPanBxK2N0ZnNWZHhKNTNRZW5FVWsycTNr?=
 =?utf-8?B?aFVreE1rdWdrQnc5NytnRGwvako1UGNBbHYxRllTL1NITTIwTFM5RTdpSUhO?=
 =?utf-8?B?elBZU1ZHR2Y4dzlVWkkrRTVEL2lPNVR0R2pzMVBUQ1dhZC9FanUrWWRLYkY1?=
 =?utf-8?B?Wktia1hsRDEzbmdZWVN0ZU9VbnVkbko5T2RLMU94SmY5NnpZSkJ0c1NBdTB0?=
 =?utf-8?B?UE9WSnBzRi91eHgzY2FlNzI5YkJpWk52MVVCR1JtVm1uVVdnQ0J3Mi9UVEsw?=
 =?utf-8?B?cFBBS1RiZVlTK1g4THQyeVFqZ2JpYW1GNWNpYy9JSWczNmlsOGF1SHh3OThP?=
 =?utf-8?B?Z0UvNldyZUJvdXg3c2k0UzJGVkE0MG1GSC9OQjZvNVZDZVppOTEzUHZCWDh3?=
 =?utf-8?B?UGl0YTFZdTYvRU5XR2ltMkN5QzFmbk9udExvRFpOQWd5Qm9VaHRoa205NCtQ?=
 =?utf-8?B?S1BlaEY0WTFzU2FTamtrS1RUWDRRNFd2K1VTSXZqdkVIamhCbnVzU2hWR2NE?=
 =?utf-8?B?dFFCVDJxYnl2RGJ6WWZPeUd3RXBua1Y1SGtpdGVPQ3pjZmRUVjRYL0pnVU5L?=
 =?utf-8?B?aVQ4TkczamFEZmJZVmxFeUhXRC83dVE1Q2tyMTdFcWN0ZTl4eTg3UlhnMVVQ?=
 =?utf-8?B?NjllTW5CbDhGbWhXeEFFaTZ1L3N0NWQ0UXpYUFpQYU05WDE1YURVekU3aWxo?=
 =?utf-8?B?amJaUW9BRVd3bWNxRkNXZW9FSWhFZFExVENTdWhlNExvWWtSYmtDOWY4bkxz?=
 =?utf-8?B?VnVHSXNtQWpqbEMvallwR3Bmb3RYNUFhdDVTK2lRN2VKeHZ6M1hSUS9lKzV6?=
 =?utf-8?B?empORmFOUC9hSVNoOEsyYWpFUlBnT3RTSG1kOGJ2K2s5VjZHU0NQeW9pWmkw?=
 =?utf-8?B?b1ZDL2s4ZklRS2kwMWUwT2x3YmU4MlZZRFB1WVRLUUd5bHVQVmFlWklITzQ5?=
 =?utf-8?B?UGRwcnFTQWlOL2MxTml6bGFpbHM2NVZGTHdibzROYkJpdmdXTnYyZVQ0QWRz?=
 =?utf-8?B?MDZtWm5WSXB2ZTBkb01hdCtSR1k0WFFsTFVwaWJldFpyNzFtcU1NNkp3U2xK?=
 =?utf-8?B?OG9Vcy95bkg2eTFqcWE4L1RtYlNTMlZlMUt5eGQySW84WE9ybGc2SzFjNFJl?=
 =?utf-8?B?aGZHNGFpN2ZVZHdyUVRmUlFYdnMySzRxOHBZMFZFME9scXlYQ0YxN3ljc2VN?=
 =?utf-8?B?T0VPM091NEdrRlJZajlvNVpHR09LdW1NUXcxV1hoQWNDdFhJQ2ZJNzVMN21v?=
 =?utf-8?B?WnkvSjRyeWkyNzl6Q1Vjb1pkNVlQV1dSRWlCb3JJSlRYNGRvbEhuNEFscGI4?=
 =?utf-8?B?YStvYnRTemRHTFdncUJMUHdLZGVQeGd0LzJNUGVIQVFXS3N5M3JaVlBpV3Vh?=
 =?utf-8?B?YkpBL0IwQUUzQmdBdWxyZThGUnBhWVU3dTdkS2xsTlVFbGVOaU5aUWdPRFc4?=
 =?utf-8?B?cTFQNzBqMFBQWG5sbThOMmp0TWI4QTJvM0tYUXpEN2xXemJDRGdybWRQNE9i?=
 =?utf-8?B?K0k1NnpyVm94bDhOdkZ5TWlmTk5WekdpRGlKRlVyQ3lQZmxMaGdmemhEMTQv?=
 =?utf-8?B?M0Y3WTFsUVNZVC9WRXZkcHI5cmtUWXlRcVB0ZWJ4ZmtNR3daVXBoMDF2YjdU?=
 =?utf-8?B?bUNPU2lRQXRvYTdXSXdEb2U5RHl5WG4vMXhIV1Fqb2R6RFNzUVV4clZhblUy?=
 =?utf-8?B?azlwUWVSVmZpdXEwQU9UaitDRkJjNWRMbFBVY29tY2FoRHZFakZMVjdhRUt2?=
 =?utf-8?B?TFBXcHluWDh1MnRZaG1ZZWJQTHh4K1lrdGtPNmdxbzB3bEhxeC9EbXM2cVV6?=
 =?utf-8?B?QVZBNXI5eGFlVnRxbWg1SW52U0RkMDcvbWt3K1k5T3o1aFMwaUdoa0ZqR1ha?=
 =?utf-8?B?Z3NTNDJRRTUva0JsSHIwdFYxUnNaV2VReThEVE9kRTEvdmhlMDNHRCs2UFBS?=
 =?utf-8?B?ZHhwRDhaUXVtcVoxdVlMeWpyM2JqWkpMQks2WkxDb2ozZ0VkQStBM2RwRzZ4?=
 =?utf-8?B?M0hWMTExVHhDS3pVNk94V2Z1U3dNVlBOSkZtUStuenExQWF0QTV1YVcxL2g4?=
 =?utf-8?B?YStRT2grT1FLVmh0Wlp0djg5OE1xTlRqYUtJbVBoMGRXS213L281Z0xzeFZR?=
 =?utf-8?B?U0lIbXZIZEwwQXZsTHIwUVVNenlDaU9FODhVUE0vTWx6Wmh5VllKdUt0aElu?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a54f8360-fa01-496e-94f6-08dc5273c146
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 17:47:09.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WON3oKF5wJFqCLXH4fM09calcd0XWAdpP2MMWk9uT1tuJH/5eMh7fTyarWA+EpPxnyl3Xb9SfRa+2TLoA1HKg9/jCct3DB4/xQ5wi5FVtaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8238
X-OriginatorOrg: intel.com

Martin Mareš wrote:
> Hello!
> 
> > > Does it make sense to look up CXL RCD information for all PCIe devices of type
> > > PCI_EXP_TYPE_ROOT_INT_EP? Shouldn't it be done only for devices with the CXL
> > > capability?
> > 
> > I think so, would this fit more naturally in pci_scan_caps() with a new
> > scan for DVSEC caps ("PCI_EXT_CAP_ID_DVSEC" in Linux). However, isn't
> > the trouble that this needs a DVSEC scan for CXL to know it needs to go
> > back and fill in details that normally in appear in the base PCIe
> > capability scan?
> 
> I would prefer to display all CXL stuff together (i.e., when showing the
> DVSEC caps). Is there any reason not to?

Together with the DVSEC caps display makes sense to me as well.

