Return-Path: <linux-pci+bounces-35487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C455DB44B05
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 02:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E03C1BC53D0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E9E1C8603;
	Fri,  5 Sep 2025 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZZEUFbF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986291C5D4B
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757033493; cv=fail; b=INVakWFGkI4E7MebMjvSJqiMuejdhAiv7bcGiE2a0x0tic2VMrvUhb2/cIixhKUnB34k9rOSDYIT6ABNWchGxoPxGhGYQ5Z7REV2/dhFY6fi13enRITC8bVG+fhp8taOcSXyMcfjFIgDJ9pa9tKVIz9rOt/e3DuEeQEObZZeRPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757033493; c=relaxed/simple;
	bh=7RaNk6+zb8vizU0cV/y975jfWCYETUyopfLqpj72h1c=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=gkY78qKKqv7kaYPTqXqqom1/nQ5Z2j3IHMFwvlsEeHRwJPSTcQhGM5M/RO+rgTQHzPRq1OTsi8TcHo1b3d/z3/be3hFi09e6JKMwHNLQHF7ZBFvwIpj+pDnWRBtsT4+dtBDmGsd+cGp+x2zMf97X7sycOZluTIB9ILLBWdzpPXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZZEUFbF; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757033492; x=1788569492;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7RaNk6+zb8vizU0cV/y975jfWCYETUyopfLqpj72h1c=;
  b=JZZEUFbFfUEbP2ctmdGG63B+bKAlf+ZDe422VQ6dU43+M8PI1fPIbEZ4
   L3hcxWoDN1X0rWdcDrRy0G60GblBdSYhwiiaprfuG4F0SP1i0KG8SHBrx
   s6zFHl9sxFMIdJVe17l1pts9dCBhJaDsbqNeBBJ3h68c0Iilup5PHT1Mw
   KT4VTArWmZEH9SYBdCh3KL+1eaRz0YBksHwJOMGHYQUVwvxOq5WupAgnb
   G5bzRfYldnEH1J4SNB9pZamkaHn6GfA0oZI8Ay7xP2aJY/pEpXt/pg+XT
   NN+J2TSx3FlG79dh3fYAmc5sgNTQF3NhM+efMoSq2asojOAUK7I0ewdZ3
   A==;
X-CSE-ConnectionGUID: fpWzDuZ7SiqwGncY9sQN8w==
X-CSE-MsgGUID: n958O+qDQUO1SvCpNFNYqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70764108"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="70764108"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:51:31 -0700
X-CSE-ConnectionGUID: 5rX1H8ZMQk2zK+ANyYGEbQ==
X-CSE-MsgGUID: w7KM5gsuTs6rWKvlHhzZmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="171327721"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:51:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:51:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 17:51:30 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.84)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDJNU+/IVvxzRlNXdESIKK7qTdlnElPT0F8k+KuO49NUC6/4i38oG7WLA1TVsEeyKlwG+epe+PFb8sICuSOC2DOg5saddAVzKmG1qFaEjQmL28Fj37CZXlg+nOO7uBPt7xEK6YyqJOTnft3yw3SjdgGlj3iPw4O/GrAOO3EXMMZGoZ5TNStymsnHKNbhaLE8rfQtqIPrGmRGJPH/rtNnSqKY2+DpGbRqmdiaUX+BibAWv+zyTi+udWYf9booIWogtgkizOVBchm5z92ViKBUlBarRaxaTinF0eAXTeIw6/cYBoUi41OSYtIRmE3F8et3xdHt3i6zKO/2YIeVTmuitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0SITTDYi6xCTr9YZB1i8BDEfyZZfK7k1vFtB1Ev4jQ=;
 b=SoWnsjlH7QcDtZrgEl4sTFM6mDiIQdQ/EGfGSMKJvmh44+jNLswuuLz8InSm8XTN4WdbRTwCqy0L8oe9V7X9KKo5XY2z9O+v2As/22Fi4L7N1LRymoD4riOVhKjzB3kBDmjgZjW9oza095lFdmljWD8vUoG3EWnvZOw1UnZ/moVnBNdvlsmgW2941aRP60n5eUkIC9Ci6gfEZhDTd44RkaDSPH3lnRrnLJZ/JP65iizqCTlePSxHBcwzEt3IFhoAqimEddKKKo/zNxQmFV2EwoZtVpeiTFc7AsWTa8VbeWkgp1QIV33rJN6w3jy8fR6IU+yz6DCmg/8PZ5/cMxH4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 00:51:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 00:51:22 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Sep 2025 17:51:20 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68ba3408cf8be_75e31005f@dwillia2-mobl4.notmuch>
In-Reply-To: <00c6ea3a-8c23-44d6-80a5-d2c0cd0d9cc3@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <00c6ea3a-8c23-44d6-80a5-d2c0cd0d9cc3@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce46694-0e25-455e-0f88-08ddec165577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enFRUVUxWk5SeWw1ajYyME1hK3RiQzVvZ05iaTlQMlBVU2FrcXhhS3ROMkll?=
 =?utf-8?B?RTBoWkt4U1dzZ1ZRdmZITWY0ZG0rMWQ2UEZ1d2M1T1psdnFGSFhnNUdkOWRV?=
 =?utf-8?B?ck9oWkpwYi9VeEQ5cUFQeVY0ZHZQa0Z5TFBEcXZpM0JqaW12QmlIby9UclYx?=
 =?utf-8?B?bXNMZnB6MkFEbUUybENRN2wzVjZaY2lCekVkTWR4VHNncU15aUFBMGhtL3FI?=
 =?utf-8?B?WXJUaWxUVjhrWkd2aU1pOFprd0NaZXFnbXhTU251V2ZnQTJLdmFLeDVwNjFY?=
 =?utf-8?B?a0U2Zy92b29QbVh4MWFyWHk2MkIraGNHci9zNUNUbGYzbFRKMktWa2xLeU9V?=
 =?utf-8?B?WHNRVHRPVjk5a1FXRzVWdC9aT3dEN0tnYUhESE9GcnVSQVpGejM5R3VNeTdx?=
 =?utf-8?B?L0ZQVjBxZ1VQTFlmYnFGMXhUL1I0R0p2alZZZVpmZVZaUVhtcDZSMFRrNkYr?=
 =?utf-8?B?QjdteXkyeC9LVFFLR2JuZC92VGtKd3BuZW1vbUtLTXhLeVJyR0lsNWd2ZHhG?=
 =?utf-8?B?S0lySEVUZDF6VmNnVjdMc0FKdGxkdlUyMjZnNzZrNCtYd2V3SUk2UDU0STE2?=
 =?utf-8?B?MFBqeWhKcXFyMEpXRWhJaGdQMFRJMVRVTzYyUkNlWEFvdGxjVURDc2FVbkta?=
 =?utf-8?B?T2Q1YjNlSWNONHlrUkVMTkNNaDZLSk03Ukh6aXBOczBTU2RRRGEvYitqb3Fm?=
 =?utf-8?B?R3diTWh1OTlRTW5JN0M5NUpwZzM1cEhtS0pTb01KVkVtb1VjVFdUK2RzZldL?=
 =?utf-8?B?b2EzWXBQdldxdWxRR0NuaDB4MFlpL0FhL2ovRFVwSUdTL0tFdko1YTBqTnAw?=
 =?utf-8?B?UlVWSlQ2cjRoNGlKY0dxRUZjbHhTWHp4bjFkbDAzSWl4ajJWeWE5cUUyaVZl?=
 =?utf-8?B?S0xLUFE5WWp5bnFQTlFwRjJPTklrM0NvN01wVjU2VHRieHMrMTlOTGF0NTR4?=
 =?utf-8?B?d0F2akZINXQ1S3NRZjlNNHkvZVVHWFY5WmRyb2dYUDg5V1ltbzc4b1hoVTZE?=
 =?utf-8?B?L1A1MzVvYjF5eE5oaU5nbE1TSnVsTUhETWZKZjVzT1dvVDBrRnloVjVRcnVH?=
 =?utf-8?B?L1Z6cFVlOTVrT3pLRW1MS3Z5TVhMZmpyNXJROWNIK0xBVEVHR3NjNlQ5RkJC?=
 =?utf-8?B?aURIeE4zU2dBZW9ZRlpuMGhXbHN2c1FaRUNEMUxWWm96eWlOWmdxMzVBOU1V?=
 =?utf-8?B?U2FxWUZpUEdKdHRIbllZSlJBbkd2MmxRQVBNWXhndVEwVGlIVERpMXNxR1I5?=
 =?utf-8?B?YjlSZ3VxSmZ6NVVyQ2sydzJnZk1pM3VqcjB4Wmx4MDQ5NE5vRHVUVXNUeEs2?=
 =?utf-8?B?MHgrSzU0RDQxNXEzVFNWWGdrRWluN0tKSm1tdXJhZm41YnM2UTgvQnpxYXBk?=
 =?utf-8?B?WGxxekJRSFRWV1JXeE5RU3hhTGFyZkxCQXQvSkk0aUtrRWo4V0RlMTlZeXBU?=
 =?utf-8?B?SHd5OUJRa2kvZUo0ZE9oOW9rbTVVTWdra3pNNFBxSThtQXE1MTQ5MEc2elZE?=
 =?utf-8?B?Y1JnaHY0MWIxc1ZOMjZONVRKdmNqNFR2Vk03RWRiVmVZQ0MyVzV1YmRSZktr?=
 =?utf-8?B?SWhwckp0Sk15eTVtYk5sT1pUWENHS1BsRVUvWTVzMmtHU2ZCbVhuSHoyM0hU?=
 =?utf-8?B?akc2Yis0NmhLSENadExoUnVlV2JhbFBoUWFWN3h0MGxQMHE4dEJhMGxvMmR0?=
 =?utf-8?B?b1NYY3FWN1VIRFFCLytPVU1zQmpyR2ZnLytlbE1kRndSVUYzS1hZbDZIWmtP?=
 =?utf-8?B?d2czc3hCNnhPc0lRUU9EbVdPSmlROFB0V2pNL01NdXlINy9KSjVLMjFCM0dw?=
 =?utf-8?B?cTFaeTB0WnB3V2xzM09FcmRtTUdPNkpBM2d4ZVBoVVcvcndmV09XSW56aDls?=
 =?utf-8?B?N3VOWFZEUGJmSW10Z2lBcndwTWtpYTAwSUV2WGdITWdxbVlVV1ZJYVF3R2t4?=
 =?utf-8?Q?HXP34PJ9nms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnl3eUl0VDJseVY0NHU3bUpZWnB0dm5ybThDNk5qV2hWWmJnMEE0UEkrRHpp?=
 =?utf-8?B?cm96UXVZZEE5N2hiVUI5bG9VSm15TDBndnhuVldTYk5vNHp3VGVjdDRsYWJ1?=
 =?utf-8?B?QlZLeXkxbFNJeU9lSDdWR042eGpTcCtoUjNoL0RjWi9RUnBtRS9HaE9zK2tW?=
 =?utf-8?B?Ri8xUzF6dTA5K1UwUGpMdzQ3emlqL21DOGxTckY0ajdrakx4b3UvWXlEdTFi?=
 =?utf-8?B?WDF6SW1GYXg0aXhqMi9qeDVETmNONmw1aGdLSms0eitFSnYyeVlncXplU2Nl?=
 =?utf-8?B?c2NPbGs1Nnp2dDFIcVBmOWNWT0lmdUFLT1UyM1pQSlEwd2hZRC9WZEcxeTB1?=
 =?utf-8?B?YTlRTFo3OFVFWlVqRXdTZ1FLbFY2T05sSlZXbVAxVndKcHlQbmdrZ3AzTlNE?=
 =?utf-8?B?c0prbVhybi9MQUtWVlMySkF4QWxGdVZNNVZDMmVUa2dOV3cwNmlXam5wVVBu?=
 =?utf-8?B?U2plVGhyNEFjaE1Cem5CTkJDd1NxUmhRSWhDV2wxN082MW1ycHhsU1RpUkZZ?=
 =?utf-8?B?TXJWTWI1Q29vY0o0SEdnaU9OemRrOHovWW9oN1hvWDB4T0pqeHdwWXlBR0lV?=
 =?utf-8?B?MzVFUTlyR2kvb050dnJJOGoxUUtrUjExR05SbGFwOW1peWlZeGVkb1NvYXRJ?=
 =?utf-8?B?QThxN0xZdFozcXdTVDdJMDNHSnJ6S09vRktRVnRlcEd6dnRYcXZEVnhDQ0o5?=
 =?utf-8?B?Tm9QTG85M29wbWk1WUNSQW5QWHNzWThBYWNHbjlBQzRMekIvVDZSYkM0aTdp?=
 =?utf-8?B?a0pSSWtmcUprVVJyOFEyd1cxcHZ4YXIyUDQ1eldEVFdlV05KVUhCS1NvaDIw?=
 =?utf-8?B?NkoxRjdRSll6S0IzRTBvRVRCclZ4L0hHdG13VGFOKzA5aUxQYzZ3Z1lhb3F3?=
 =?utf-8?B?OU5Zd2VkajJUQmtHdjVMRUhiQ0hmS002dnlCQnprb2xQSVgyQ2ZITXkrTU5k?=
 =?utf-8?B?ZFlHeTJzUUp1NGYxbHMrRXZvbWNJRlV5WnM3bjBNZk5DSG90THIxWlg3K2Rr?=
 =?utf-8?B?QXI2NmthdVlJbUp2TnFJUEFmREF6dTRJZktCTGFlSGFKS3Y3WGJJd29CcDBF?=
 =?utf-8?B?bWV4bFNzQWRKSmFURjZhL3RZWmdyUEczSTlvUXYvbHppU0VwUGZyL01uWmdU?=
 =?utf-8?B?U1F6aE1Beks2bmhEOURUTlh5c1dMUS9LN3VieDIvRUxHd1FTWmZIaWp0VXgw?=
 =?utf-8?B?Ums1RTFzMGFMOWwyY0F1V0tTWVBQTi9iQjdFNjhpR0VocTc5b0l4K3NtaUdm?=
 =?utf-8?B?VkVFdFFkUnhIRlZXR29HR1luSlVRUGVxT2FmdDZXUVJYRFVQdm9qYk5adUU2?=
 =?utf-8?B?amhoLzFxT2hiUUJLR0ozODNEK2tmYWlpd2psekFheWFlbXNkRTNEaTF5bXZ2?=
 =?utf-8?B?Z045ZkVRdzBZaDZyN3BpSTJDdC9DemlTQVpIQlhIZm9UdkI5ZFpMY2RlY1JP?=
 =?utf-8?B?RitnNkJRVjlSSXkwb054bmNzU0w1L3dENGdOR0tUWEl5V2VYd0FmME8rZHFV?=
 =?utf-8?B?RlE1MktpQ05ZL1J6RUJRZ0oxVVI3TXVaL04wNGVCZE1qL3FjVmJGUitHUDJY?=
 =?utf-8?B?Y2FaYWl3ZzJBcWdnK2EyZUtod3ptK05paUpTTmVBa2hYNEhJRzNNTWEzak01?=
 =?utf-8?B?UHVFTFNPT0x5MTlkVFVMeTJ0L3FUMVIveWZZdk1SbDRTeCs3bFZHbjVqemhC?=
 =?utf-8?B?Z2dSYVI0U2xTOHJNVDNWUXdlcUNhaTZuRTk3aEI1OGZyT0NabXRraXJZakF1?=
 =?utf-8?B?V1pGR2VOSk1Kd1I1WU1mUUxWTlk4ZVJiWnJvRjFCN2JSUHdLcmJnWEJQd3Z4?=
 =?utf-8?B?MVZIY3J6bDh5ZHJlTGVFMnFBRk9lTWg5bkNIS21pa0JmMm5CQkJFVFBvZ1VQ?=
 =?utf-8?B?R01GbVE0TkUwU3piT0ZjbDdsZDhVaVBVZjVYWjZYcE5NUFZETDZsWUJqa2ZQ?=
 =?utf-8?B?SXZnOHJWTEpWUldCYXljbW9PZm9sQnhrKzNqL3doWEdTMDNWRTh4bUgwSEhu?=
 =?utf-8?B?Z2hZOEliQU5DUGErNWRMcE41Y1dPeTZLQkxTS2w3QThDakhHWkpJVnBjVm93?=
 =?utf-8?B?N3NvNGJEbnBkSDRBeXF6NjNDSWZ4OFBjeFo0enFUa1pCZnZTK01nbEJ4cVZp?=
 =?utf-8?B?TGMydHBkb0gxcUE2SmxJOUdqNDM0dUxiWU45RUhEaTkzNTVFb0MzbFdxeFIz?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce46694-0e25-455e-0f88-08ddec165577
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 00:51:22.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHL9gmmw7s5M884KPZEhABxIpEjU5ZwZAaVHFUwrKDCJOQfKObipb/rve/OVtSlyKlb/IhJha/LREUOzFa9lq6oh+BuqtNk/u91CbMmN/aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > +	/*
> > +	 * struct pci_tsm_security_ops - Manage the security state of the function
> > +	 * @lock: probe and initialize the device in the LOCKED state
> > +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> > +	 *
> > +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> > +	 * sync with TSM unregistration and each other
> > +	 */
> > +	struct_group_tagged(pci_tsm_security_ops, devsec_ops,
> > +		struct pci_tsm *(*lock)(struct pci_dev *pdev);
> > +		void (*unlock)(struct pci_dev *pdev);
> 
> 
> So, following the remove() example above, this guy should take struct pci_tsm*, right? Thanks,

Agree, done.

