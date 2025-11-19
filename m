Return-Path: <linux-pci+bounces-41576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E59C6C919
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9719A4F0A7F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50422E9ECC;
	Wed, 19 Nov 2025 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlMNFnAP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574222D4E9;
	Wed, 19 Nov 2025 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522420; cv=fail; b=GRvx6s4ViPU0tck9uijC2lSaL3g6H1iGcF96V/3vaRH6xaTtNs0SVUpmVyJHjAqfoeJOXEorwnigXqzdzkQUEKlb8UQE3V72OwJI3DpYVzNnfY/xzc43CBdU1G1GhYCRf5xxCbRSqiICS9nT3Kb0SiWiPVLB3N9S0dh9tD8qDmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522420; c=relaxed/simple;
	bh=jx+ncnJlaHBhslGjaxCCbnyNOsstOkwBW8vBgrVCJCc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=h1ERSumAe3BiEsgGWyljCe7diy4AflqIhsE8hKdhqHKzUhdF9k2zJz78Gy5Kb59aM4OG9Xh8nLFSVm5QMJ057Qo1yDxWIRXht4TAgryaa/tUOf3cDgkw6B66KaOVCFAWzJgj5rIbg//2NHXlrhpBcBzsUi/hWk0vjhko6j7hH6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlMNFnAP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522419; x=1795058419;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jx+ncnJlaHBhslGjaxCCbnyNOsstOkwBW8vBgrVCJCc=;
  b=UlMNFnAPsDs6rlIHUO4drfi6UXULlByEsW1LeVjvihhWPoJw9GiL4++d
   XnHGEHsPPoYq7NCdO/rFL5t7/MCHyfFcmlI05eWVRNQbSgyWHfKQi03SJ
   NXh2AF2ekKGc5q0bD8asqp1QKMJ/u8UBNfceJUKRD8YjqGSHOAkQI+JTd
   qPRK2jBSsriz4pdHgMhz4QeLWi+FOuswKL83ITM03afecDswDaj6wXqGU
   UvW3W2WVd8GoFA3ag+i9QMqRkVqtL9SiA1YK3O40acDA/CJGREKbmJyim
   L4MFHLp0ojPJHSFnmpgeLeKjDsplmbZr9OidrfuLfsWcLwqOP9cO9d1oO
   A==;
X-CSE-ConnectionGUID: 63rlOzSRTGGEOIU+MlZtfQ==
X-CSE-MsgGUID: BLodw/NDQFymcfKqC9kkIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="91032891"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="91032891"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:18 -0800
X-CSE-ConnectionGUID: 8jck9DmFQpWCsm8wh2fDYQ==
X-CSE-MsgGUID: ChabFEO4TWS0KreiKG4KKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="191374398"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:18 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:20:18 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lyz3r/CEhfxCbxlYvEjHfiPhWRQ0bWBrtl8qhw9OSlgYN3V/hwkzroxoGVjpBxCbzFygO/jxleNlFJjOnvwkf13TtCTU71/VvrYlx6VRBAzl4GL0a7WF+pzoyjmJ49Ir7MaI40Wg/nIgQrVCBCECwbRhCTcBfNtZ3sGuJR7FPyqDbKBv6T0Mpob1w5JMY/lOr4rxQ4nnYWX5VEjbECc2A2zwvMeM17iAuBIUL09iNiWXMhM0B+wUqUY9wZNG76kwTKTZZwRKsRPxExn66HLJrsvrRytOp0UBlU9wV0zgXOe6ckzz5n0t0FcR8LcmpIcFeuVhDV9Vj9p42iRrYFGLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyEJvMWwlEd23+CqM7s+v0ynS0GMUd5uNE4zDgZW+ro=;
 b=Q9zb/ijuiF3UFdztCw1vkqu9Mrm/T3RJ/woX9xNLxV4ogPOnaC1zcTGBcjSW+O4H0COJQpN35wdzAKzd/i3zgQj+OUW1fDBZs8tACjXx6u0iZnii02JzRY0SB7nA/s6GdwxC1flkMZA9tH4As4c/HIFvRsMeatYQZY0uKNQsoG/5ZMAQWi0+Z0uCNuuZi4tHnP9xvZ6Ug/kmIePvfgLFd1+wTh7q3ADi9LgaN3Nlm539iw4h9E5HKQWXuJrrAh8HYG3v5jFEqhq/WbGunH5ZuLrXpkUk6AaF6P7cMjznLMomiZVdgAOVy79Ib9ASLG9dFeKV9jxJOgJVMDTYOpbvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:20:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:20:15 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:20:13 -0800
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
Message-ID: <691d376d5a132_1a3751004d@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-7-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-7-terry.bowman@amd.com>
Subject: Re: [RESEND v13 06/25] cxl: Move CXL driver's RCH error handling into
 core/ras_rch.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: c51eb412-d254-447f-e385-08de271a8edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1pFNjUybU5zVzB0QXZmaTF5Y1hWZ3JrZ1Fwbld0RXRQV2p1L29NaktoU2dj?=
 =?utf-8?B?UWRBN3hzcnVnWURtamZBQWl5SzAxT2o4dGR1ajY5eTBOREpzUzdXcVJNWWFF?=
 =?utf-8?B?VGlpVWdwRjQ5MUhiNUtoQlhGQVJPTXExZHFHWW1SbnNVWGhmMzRUQXc2Ukcx?=
 =?utf-8?B?ZHNtRTk0cCtOVzNRcHNObGVGU2xlNTJCZ2hIaCsrQU41UTZySGtQQUMrdTlo?=
 =?utf-8?B?Q0FYbHRuK1puSktMTmVsUTNRUVVwSENxQXRQRktiYmpzMG90VmVaVjRLdTNY?=
 =?utf-8?B?UXFjeGxvcHhON05jbFcxZnRHRmttaTh0SGYvRlNJYXV1TlROYU5MRlVPc2Ju?=
 =?utf-8?B?NTFyampVUGdmTk1oQzltMURBOGUremNDSE5xSHB2dStOdDF3VFVHcGpxS2lG?=
 =?utf-8?B?V011bDQva1VVR1l3TkZvMW4xNmJEOHlSVXZyZ3NRcW9KNmhmZjQ4RHoyOVVR?=
 =?utf-8?B?eTM5ZlZRTzBsc2dtbTMwbzMzaGZwT3RaOE0wNTZkSElSTVVQQXNiZkUyQ3FC?=
 =?utf-8?B?ZWtVQjRXL25FQ3dEcjFnUlVCOEJyN1lHOCszd2w5YlhWUkhFZU9vQzIyalo5?=
 =?utf-8?B?dnRpYS9yd3llL3hTczduS0M5ZUNFY0NsMVRTc1dVc0VteDRvTTFHNDViRnZo?=
 =?utf-8?B?N3VJYW55bTBsUytrUFJIK0xQcnpISkM2UWJhTjE3RnBpKy9jaWtoNHJGR1hG?=
 =?utf-8?B?aTQ4SEZreEd3YVhiMFRPelJhNk04a3JMSEZOUTEweU13UUFLTDZ5UWZMN05N?=
 =?utf-8?B?RzV1V1pKaHBpVGI0WDltQVZRVU05SDd2RjFVSnZOc0tReTM1MzVYN2pXWmRL?=
 =?utf-8?B?UndIdUtuNW42Wm1DZ2JnamtOOGVMZm9Ua0FPckV3dnBUWDlXcitwV296eEM0?=
 =?utf-8?B?c2ZCampWWHRDcHFUOFEySVYzREpqbGswMzg5SEMwd2ptdUpacmhUNDZ3alpu?=
 =?utf-8?B?TWlTQytIZ09XeldLUEtsWW5Ba25qU29DNGRjenRGaENPZ2J6MWhBSWc1RnN5?=
 =?utf-8?B?TU1rOE9Ib3lvS0hpdGdpbTAwaHUybEdxdWZTbjBhbnd1V21OLzZxRTFOUW1O?=
 =?utf-8?B?UDQ1QlRaSEcrWUZxRk9mUzdSUmMrdkNCS2hhcUJpY1hWSU5sd2RkSmtxdnJ5?=
 =?utf-8?B?cllHMXJleGdrRTh6dVV4S0Z0aTdpTDk1N3JyQUV5MW9rWUliL2tmV0JGc0s3?=
 =?utf-8?B?RUYyb1N3WmFKNTJYb00yYS9xenpmNGVpbnNwSXh5SzVpSmV2WlU2Sm9FcUtS?=
 =?utf-8?B?c0hPd1A5bnA5SFFjTnNHcmpxM3FOVTl5VWFvdkZtTVhmUTZ5Q2VHK05FVkFP?=
 =?utf-8?B?VHNHN3Mzc3I1SjZ1a2l5WXVPZ2xDemVpK2djY0F5cWd0Ri9iTVc3Tm41OXEx?=
 =?utf-8?B?elNkbCtEK2o5QlNzQTJWQ21yeDJtRnREUy9VRytBRGQ1Y0orWlBvTGwyODNs?=
 =?utf-8?B?b1dTVm1qTWppekpZcmUxRy9LbFFhaGl2QVFxRkcvaE4zWkgzZndZU2l6VUxj?=
 =?utf-8?B?YTRmckxrT3RLYUFZYXVXQk9aMmdycXczSkFiT3pxdnRTc244dG1mYVIwOStq?=
 =?utf-8?B?VS9rbVdNVUlmOXB1RzM5RWE5d2FMd2hqVUVDN1B0aTE2RDNEdEc2OGZNZ2JP?=
 =?utf-8?B?b2RuY0xSZTdrSzJDV2ZNUjloamNvVXcvaTNYVmd3TVhSdys2ZSswa2pjaU9i?=
 =?utf-8?B?akp2K0daS2FnRXU4NjBVVGh5eStjSy9UbklZNk16U3duWndDVHc4ZktsNnRh?=
 =?utf-8?B?YjFodExXQ1NKZS9XbTVTa2tKd2hIb0VNSE1OUUJralFhYWhMVkVldVR0a1Yv?=
 =?utf-8?B?Yk5CYVdjOGxQY0VWQmE0VjVoZXhiY1BQamlzNUs1YU8rVWJOU1dUemd1ZFJI?=
 =?utf-8?B?UUdaQ0NlY1Mra09yQjM0NFJKSlJ0WFZaWFhkaW9keTh6NnhPOEdEbGY0ZDU3?=
 =?utf-8?B?ZzdOeHFCQ3dNL1lVSmxHUEdsVXhmN1M4Zm95aWdETHFYd0plNGt2cS9vckdH?=
 =?utf-8?Q?BqxR1T0czUwJab/WN5/aglauNccjG8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUc4SDh3NjdZV1RxMDFjVFNpWjlhWTF6czFVYUREdVYvR2ZJVlQxQ05pTU9O?=
 =?utf-8?B?YXRxUGMrZ2ZzRVRoVDZSSDlZTHk5aFcrVGpXSFpWTkhMQUw1TGtMbUdqMytD?=
 =?utf-8?B?c3c3NjFZMFhGcWR0cVJieVBlVzBLRlNEeTZUa0Vkbk5GTHlqWTBHdHBtdjZH?=
 =?utf-8?B?emFWaHk0OG1oNlUzK05CNS9lSHowa1J6d2ZDQjdleEtKdkJaV2RwbGtXc3Qr?=
 =?utf-8?B?UUhxQW45ZHFXUSs3bVpjbTgvczQvSWpsdVBHdmp6WU9XdTdFcVpiekhHRE91?=
 =?utf-8?B?RjF5K0RDQWY1aXZ5TWxoK016di9Ta0N3RTVnZEhXYWxTNUhqbSthajBEdzZj?=
 =?utf-8?B?Mk40NXBSWkFHOXZraEEwaG1yNmwwODRUSVFWTk94UXU2WFVHeVRwL0Z3TG5B?=
 =?utf-8?B?L2VUVzBka3lJOG1Xby9vVGMvOFlhVFQvSXFvc3VKN0cyQnArL09zYVdRckR1?=
 =?utf-8?B?RFdPbVMzOFJ5MDRmZmFLbzdCTWwrdDAwdC9SeVRpb3JrK0Vxa1NIZGV4SktX?=
 =?utf-8?B?RUJibWpKMlVZV3E1RG9tVHYzSjJNR2VnOU5IcmdHS1g1Q3YrNnVHdjJSUWNn?=
 =?utf-8?B?aEFkRW9XMmxjdVpIbTljeVpQNTFxN1BkcnZoN1FHUVhqQzU4bWJ5dEpmNVRK?=
 =?utf-8?B?N2pyS29vd1QwMktzUkpzQ2RScW8vMHlXT3FxZFFOdWRmQlh2OHlLSHQ2UkFq?=
 =?utf-8?B?VlExeGI5VnVSSGR3RmI4NHZjOGdZcVhHU3dzRlpFVmU4ZVBndWV0ajcydGVI?=
 =?utf-8?B?ZmNNQ1BsRzd4YXpPQ1BNc1RaWVhSU3VsUnBKZkJJbTF0SWptcTV0Vm5GQkhx?=
 =?utf-8?B?WS91MWVTN0lkK2s3aUcxVHRPTUMraEp2dTFyOEt5YVVYS24zUnMzczdwZzd4?=
 =?utf-8?B?VEs5Zm5lVDNpamJGVEtjQWEwVkNrRitUNDR4MkZ0RW1udGZIWnNqNE9CcUs4?=
 =?utf-8?B?S1Bjclh3U3hIU0JWVXpFOXVacGhiblJ0UVYrV09vNm5JenhEaEo0RE9zbFY5?=
 =?utf-8?B?MUgzMXFHbjQ5dHVCK0lsWDM2UUtUaUsweGFZRHllOWRyWVQxMGNWTnBlN3or?=
 =?utf-8?B?VWczOS9kQkZBeEc5U0YrNWxkWjNoeFhGZHE3ZjljM0UyV0F4aWtKLy9ZNExk?=
 =?utf-8?B?d1I4T0ZyV0R5ckFHZjAwODU5UkNaUlBxZDlyV3JVU21lWVZ0RGE0YjFJN08v?=
 =?utf-8?B?dzJDaFV1ODczUHBqREpjK2tKa2dSUjM2dDlYZzBpVHZqSW5aSU94Zmd4c2dM?=
 =?utf-8?B?VTVWUGRUQ0l0dHNXejZRTTdVNnJleTlKSjRibVdxcStXOTI1bmg5QTdQZEtn?=
 =?utf-8?B?Q2tTNG5ZTlZTaHFmZ2N1eC9KVGJwdGFzYVpTVDZMYnEzWXRGTVZWNXorSE9N?=
 =?utf-8?B?MkhqTnpvZ2FLV1pGQzdXWWFqUUtZWWY5bTN3Rkw5ZDFrdC8wTFpLUXVvQnZ2?=
 =?utf-8?B?SHVWd05pc1psaExGaUtiaUtKcVo4bG1zTjNMcVh6ZkN4YjRna0pMcjN2Y2lS?=
 =?utf-8?B?dHkrSUp3VkJLazk5RE85ZjFTclUyYUdCNzhXbEdYRSsvQ3ZTQnlIcjdKY3hL?=
 =?utf-8?B?NnAzcW40WUVlS2I1bCtqU21QRVIwTTltcmpkWUowa3paWWlzY29JckNac3Nr?=
 =?utf-8?B?d0FEMi82bk1lNWNCM01zbFhacnU5TUxtenZxK09tQk14VG1xam1SRnMrMDlw?=
 =?utf-8?B?Y1UvNWZFa0tVZ2VxWXhuRkdLN2ZjSTNBWThneFFUUDBzTFdzSFVZNGl6UTlO?=
 =?utf-8?B?NmRaYVU2U2lMaVNuVDhHRmE1V0g4VHlTWVhuQkYzNCtzRkNUYkJ3dHBGcFBT?=
 =?utf-8?B?WlA4TnVVTXYrcFFWdXZCSURpekQ5cFVWaW9pUjRVVEhja1VMTExoZ3NEUEF0?=
 =?utf-8?B?aUJEYUlDMnd4ZnM5dzA3YktSNHBLZDlUZWhVcm9hbUdDVlhVUlV2dC9ITUNI?=
 =?utf-8?B?TGxZTUdFUVE5dUJUZ0pxSElzVTl1L1Y1U1FjSzRnQU5GaUdxQ1FBT25Ra3ky?=
 =?utf-8?B?V3JaWEdvcnRQV0RlYWZXUmZtc3NxdkgwTlR0QUdjOFcvMlB0ZVZhNFZNVmRM?=
 =?utf-8?B?K1pGYlhxa2pRR3duTzk1MmR2OFZrUHAwSDQydzkwUTZkZDBha2p2SWwydHl5?=
 =?utf-8?B?ZUw4U1RIU2w5YWVYZ296RHRWc3FZcHBkK2RlNHFpVTVvWDY0MjFFVm82YkpX?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c51eb412-d254-447f-e385-08de271a8edc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:20:15.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxjvYV4fMqc5D5F9VH9LZF7pbUZ4AuVA32tplQUMlGNkzgrpT1wYEmt621e7WQevWwB3xed50UwnwTU5ziqlRSPK9qKXqPdm3hqK8b7Myh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
> from the CXL Virtual Hierarchy (VH) handling. This is because of the
> differences in the RCH and VH topologies. Improve the maintainability and
> add ability to enable/disable RCH handling.
> 
> Move and combine the RCH handling code into a single block conditionally
> compiled with the CONFIG_CXL_RCH_RAS kernel config.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v12->v13:
> - None
> 
> Changes v11->v12:
> - Moved CXL_RCH_RAS Kconfig definition here from following commit.
> 
> Changes v10->v11:
> - New patch
> ---
>  drivers/cxl/Kconfig        |   7 +++
>  drivers/cxl/core/Makefile  |   1 +
>  drivers/cxl/core/core.h    |   5 +-
>  drivers/cxl/core/pci.c     | 115 -----------------------------------
>  drivers/cxl/core/ras_rch.c | 120 +++++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/Kbuild   |   1 +
>  6 files changed, 132 insertions(+), 117 deletions(-)
>  create mode 100644 drivers/cxl/core/ras_rch.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 217888992c88..ffe6ad981434 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -237,4 +237,11 @@ config CXL_RAS
>  	def_bool y
>  	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
>  
> +config CXL_RCH_RAS
> +	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
> +	def_bool n

"n" is already the default... but I think this optionality should be
scrapped.

> +	depends on CXL_RAS
> +	help
> +	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.

I can not imagine an end user or distro ever knowing that they need to
disable or enable this option. What is the motivation for making this
support optional going forward and defaulting RCH error handling off
after all this time?

...does it get in the way of VH error handling?

Otherwise the decluttering of adding a ras_rch.c file looks ok on its
own.

