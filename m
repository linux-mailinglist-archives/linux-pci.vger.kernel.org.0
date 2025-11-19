Return-Path: <linux-pci+bounces-41572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C9FC6C922
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06F4C35AF9D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D681724;
	Wed, 19 Nov 2025 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWvbFtD7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50152224D6;
	Wed, 19 Nov 2025 03:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522388; cv=fail; b=P8ykyzhKQsq9xheQQeT9C0/layFNxU8rOtxh3y8cx51J14RQ1lRoXe4dQITJuum0eFG0Ja/eCr4SXBXRga/wbrCSMHEjAXCJzA9vAsJiNZIne7Kfs+9MDVzeE6V2W5XOfrsloPvM/NLuIzTiVBRy8GAJ9K4nr5ZPGOq4UEqRUuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522388; c=relaxed/simple;
	bh=pMv6tDLUwfFwOcU4tbzg0bhEYfEB4B0hlfpH4Aiu+Uw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=sTSZoklhGDkDhT9tNbJ8+BEiLrvXeZF7ARC/qnUOYhZQO934Yo/X2pU/xnei5ZAjxHJSk2YxIgY4G4PXZ0RWRrDmArREhmPtoGjAAkQkRwsRpj0w2N5z5oSho78P22ACeEQYpcyMZnNW6ygKd5irFJNWTyd5vlqkAxli0JmN2Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWvbFtD7; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522387; x=1795058387;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=pMv6tDLUwfFwOcU4tbzg0bhEYfEB4B0hlfpH4Aiu+Uw=;
  b=CWvbFtD78IfoOd5dimzLQ3YAlEZcfOW+nUjJAc71+ujsWG54kXt33k2B
   FCzE2vw+SOShfNYrafZJJsT8lqtlKVbUvN7oWftZimfif1Y6E48VHV48F
   +kjBdQuzEJcCvOMUKoK3Pc2VL9lLh5YAdxcwRlL0a8U6eoM3ycO2ljCr0
   JKx1QZeWhYSDemBQq8gVI3K+2MpREQm1C1/a7tcfbbgirf6SrY1CdhwS4
   ua/x+Et3IgimDzGcGxROyUYTzYUyZztIUrioTJG6tYA02wLTmXk6mTnbs
   NBL1Wb3GIqsDZAFf58iiYRxHHXZW59jm9Uw6ns3mVjoo7KtEORnJWbtRH
   w==;
X-CSE-ConnectionGUID: 7JaYJNKaTy2zErjrp/qGPw==
X-CSE-MsgGUID: hGqrFiTFRaiP+/X13LMR8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65497534"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65497534"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:19:46 -0800
X-CSE-ConnectionGUID: dLycHRbqQGWZJjh7ktpGow==
X-CSE-MsgGUID: J6NeAyUsQPmOkCJjrmUsug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="196067499"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:19:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:19:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:19:45 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:19:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8bUYiiKrQruh5UB7zfbQhNjO/Jf9yAJTUcjYtSC6hds2q+cfk6JzINHt/ugfLhawT/HJAhrJVEWjV4F06HR0oItdeboWwFObdB4I8bsddc+sNlet+Yf6aztq34Znul4PC4ljN6kKCGX1IKAKw+UzryN8qcXmsIjJR3DbCJ4ghT1SFF3R7TJLENdDbMGo8rPX6W2dxlohCEYjCM3ry+o6gCW+uCwzW8X2Z9YwAtNmzdOe5oO75d1KeBOD9s8N2YaTmPbj4OKNogGSAgSBU/rb+JHFP7eEv8S2qtPieB0B4cmHYuMrtuHOBHTk0l+eE5xm3bpr+21awN7K+y0S6j4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLJAkDM4sqFC/qUkrCJpXCKv+WzngWSuuUnAdVONySE=;
 b=uPaBKHL7wGe3vW1Ut2lDJW+35Z85sKeZhM57mKZbiaHQJgOT1ok/SmSMJfQ5eec9N5bLRcwbv+NS0VzrcyiiF+z9KGnIAYUQUSF/Sp4TiZLr6SCEAjM/G+lq+DgP79PhSm9htiV9hoDVWEanotLGxePH4dE+zfqiBJSTfVy25bRL9ccrkQolA/sVSMiS6tME4qOXGTyS5DHoKwmvGXV2CZIIs79oSHnUXG8OikryFQNN52lu1cc8UgZ+SgCBV2SpLSqzdOVzVMWvl4HQwaM48Vw1i8+S6tMzVpSp09zQLbySRfEI2onOVT5gtPvRyyLfHth67EnvJplLsYNOEg/9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:19:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:19:38 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:19:36 -0800
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
Message-ID: <691d37481e71d_1a37510042@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-11-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-11-terry.bowman@amd.com>
Subject: Re: [RESEND v13 10/25] cxl/pci: Update RAS handler interfaces to also
 support CXL Ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: fd89ba7d-c880-4913-d371-08de271a7861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REtlaW9Wa2RWczl6TE15bGc5M3UyNXFORmlRVXJuZ3BtaWptRUk2TGRwZzVs?=
 =?utf-8?B?Z3JiM0hQdGd2OWJIOW5SWVZEYTd5SFZGZW5Wa1Q5TW5mV2xscnpHemdDZ0hq?=
 =?utf-8?B?bVQwdjdpSmEwMHJQNEFVZkc2ZndWVExDL0pMVC92cDE1ZmlhSGJDNTEvamlt?=
 =?utf-8?B?VnIvYTZTMFR0Q1JFTnduOWlJKzBIN0dWZFhXcHVaR21jb201ZEE0U0ZGS25N?=
 =?utf-8?B?NHJvTjZmK09kejJGbVpCWEwxYUltOEZyY05FWDVISyt3UVU0S09SR0ZoRXk5?=
 =?utf-8?B?YlVWMjcxcHBUMWlWV3dKUXV3b05vdE11S0d6MzlPUDBOdmNIL2U2dmtOd0VY?=
 =?utf-8?B?NnhBa2xGNkczM1VWMWNTN25kWHh3bHI0WFdESjlzQ0VBVkppNUhZRm0vVVFV?=
 =?utf-8?B?STZPaklUc01BTzV0T24xOUpVYzNVREQxeUl2Q1JMbW5YNkNRZllPUFNsTWF2?=
 =?utf-8?B?NDFya3NCMnpFbFgvSTNjNkx2b1ZhS2x5UlkxZGFQWmNnWDg5N1hadDFHSWZJ?=
 =?utf-8?B?a1RMVGxJWEVrZ1Vla2VEZHNoNk5FOXRJSkJNWjcvd1RtVXU3YVh4bm9BbDd2?=
 =?utf-8?B?YS83U3BFaEtrLzNOdVVOS1ZkMklRKzRwSUpVOHlic0t2c0xqVlNxdUljbGdH?=
 =?utf-8?B?c1laSzU3UEVOdmIrYnBBYzEzSHp4Q3NPcU1HaEVhWU16Yjc4NUZ2bitoZHN2?=
 =?utf-8?B?WlFsZk9Vd0RQWXh3c2tpOEV0bUFDbU9yT3VmelNBZGFiYitSVDNWUjVDWEor?=
 =?utf-8?B?bE9JaU91bWMwUXpPTlV0OWVyVnU2cHBqUUM5bjZuZjYxdzlpUk1VK3VxMUF1?=
 =?utf-8?B?MWFCMzlBRXJHUUNoelozWC9WUi9xYTlxZUIvajJTZEJMaS9YK1Q1djZSZkQ3?=
 =?utf-8?B?WlVKVWxCbk82UWZaQzFORTdjdW9FNm5uUmJZQ0N2WFRuZER3MTYzUnlMWERF?=
 =?utf-8?B?bXdvWmliaXhVdHJTSHdKUzlFWWFnakw2dy9qTkFyeDlZT0U0RVg3K0NUNDl5?=
 =?utf-8?B?L1poQlczQ3EvL0VxeDl2LzFVVHBDekxjbDNoWXpva29RTm1ZWC8yd2VvaCtF?=
 =?utf-8?B?NFR3QXJ1Sk9VbXg1TUpSd0pIdSt2alFnNm1Gb3NoYWVVSVV5QklvQjJvQlVH?=
 =?utf-8?B?ckpnenR0NmhEOVpsU2I4SUpWSkVOT04zdk5KREtCMi96STZDTElEVDdIZGs2?=
 =?utf-8?B?UFJBaU9IK3d1aVJKSDFvZHBRc09YcXI2TW8yTytsYzlmdHYweEx0aWREU2ZD?=
 =?utf-8?B?d3Vxc00xSDJLK0dPSktZN2FkTyszUzRBbTVaRm5TV3A1UjJDRkpVZHh3bVZP?=
 =?utf-8?B?MCtrTCtxak43UUNHbmFGVEplM2dLQXRjcXByM29ycEZmajRDS3N1aHpiay9i?=
 =?utf-8?B?S051NlBhbHB0WlZxNkwrSkFHSEh1Y2lGc1hWMUV2VDdtbkpmcW5BZG1oMjdR?=
 =?utf-8?B?bTBUNWVDYjkwNEVFYzJHYUtmTlN5VEgxa2J5Ykp0bGFJWTAybzd2NDFxb0ti?=
 =?utf-8?B?T2lGVGJwK0ZSVVVLU24rRkc5U0hxZDFGOFpheUMyQmZXdFN3K2MxazgvTTB1?=
 =?utf-8?B?a3pFRkswZS9DYjZxTWsvekNYbGFiUnBVeVJnb2s2VnlGMXZpdzVha04reUhh?=
 =?utf-8?B?ME4weXBrUzNsRWg5eDVIUHd0NjQ5Y0JUbzFJOUczZ3o5UUY1dTRnT0UrSVpJ?=
 =?utf-8?B?RDRQYVp1akdVRHUySTFJMFVlVWdVRjRTRHd0UHhobEJweUhYZit5VXROeFhU?=
 =?utf-8?B?RWJ5YUJ3TlhSVVUwamhUcHUxOTVpcmJIZzZPaWxXOHBBZE5UTGJvcU93VXZH?=
 =?utf-8?B?VHdiUmtFRzdCMUs4Rkl1NlBMOVNDWmd2MkdFWExHZjNpU0d5Y2IvblhQS2pB?=
 =?utf-8?B?KytzOVNNcmlxOEVmV29JbGZsbEgxdlhzNG1sbEFTTG5nS3ZKUlRVYjcxSzZo?=
 =?utf-8?B?V2pzUjZwd1VKOVNrREJQaWhrb3lmRzQ4Zy85NVZGU0pFVlI3K1ZIRFZ4ZHEr?=
 =?utf-8?B?QWtLT3IrVzM5b1g1Z3VtQkVoOVAzTGNDaVh2UkozMU5ab0x6c1A1NVJNaXpW?=
 =?utf-8?Q?ctZS0D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek1YRFlHR0FkRDg4KzBvc2V5SFVKRDF3NGE1bTA4Sms0NlMzZGNBZEpYRUls?=
 =?utf-8?B?TVo2UzVYYnErQWEvZkQ2ZDdJMXIzeTJSa09iL2JsTnl6akkzSDU0ZUV3WjZV?=
 =?utf-8?B?bm1pYnJKVk8xQ2FOSlk3b09lUmVOL0w5d0svWjdLeWdCRElIM2VKNFBvZmV3?=
 =?utf-8?B?K0FKNmFNOTFUa1REQ1IwQVBoaDIzMWJOQi9xL2xrejFGQlQwdTQ4NVhjditW?=
 =?utf-8?B?Uk1ObHFwUnJYR3FqSXBZR3lPYjI4MVhqQ2JXR2VQZ1FORkkzU0QweG91d1hn?=
 =?utf-8?B?OHgxRTJFQlJLUWJWV2ZMcGp1QWl1WXQwWTl1L2tpcWQxb09RNkt1SHBucytm?=
 =?utf-8?B?dWRvQy9vZVVYQ2pHMHRFNmVQSVpUaDFTNUhkYkJRQk40NEpPdXorMHdVMlpv?=
 =?utf-8?B?d29TeVE5Z0pUWUdXTElqamhTUzBERk94M21zalVaRC9GSC9NVmNmNERrR3FJ?=
 =?utf-8?B?eEExOXIzUmtCT29nMERHSlJXNUEwaGo3Z28zdnNwSWNsd2E3ejg1QnFUVkd1?=
 =?utf-8?B?SzBVdnpoa0g2ZWN1Q3I4elh6TWthUlNSL3F6dGpMcHlIRmphRWhVMVBkZWI5?=
 =?utf-8?B?aFh3WUdnUS9qREM3RFVDcHVYN1JFdkYxYjJFTFZUYmVrOXM5QWdOaVRZUTZD?=
 =?utf-8?B?TE1sYkE3Y2t4ZmVyeDJGMGhTNGdVaFRpTVhOWVROVmNwbTBHL3ZJTEhNVFpE?=
 =?utf-8?B?THkvTFJZQkVmbEZTUjc0RVJCbTArQ3YrNWVRVVFiM1hSNFByK1ZHUUtnVUQx?=
 =?utf-8?B?aVFNOS9ldUlOTUZ5YUtNRE8vRG1lZzZpUnk1OC83RTlVNE9OTjdua1NkSzlZ?=
 =?utf-8?B?VkFaQ3d0TTYrT2RUNEp1SUtkRFhwalJKM2lFR0pmOFJEOVF1YWE0M2ZVdVc0?=
 =?utf-8?B?dERIb2pkU01idVIvUDB5TC9EcE1MMG9FNHhRZnZuUjROanRlbjJnVXFHMHo4?=
 =?utf-8?B?b0trSWJReXZVcFZaTnlwNXU0Y1pIZ2JpNHFKQmtCd09JbUowbmRFT3FZcGs0?=
 =?utf-8?B?ekl1bHNZdHhWelJCTitvUS9zVjI0bnZEdXZRWWlOeHUwWnJCT1RaTUppVDA0?=
 =?utf-8?B?V3JuTkZ6Q0E2YlV3NlJrWmlQaWtvQ3lhTzBvYVRVVFNCS0xMVEZMSktzZnhU?=
 =?utf-8?B?RERXZWhDcytycEFpd0F6c3E4aDM3aDlWWkhhSTkwZU5GYUcrVXBwalBjOEsx?=
 =?utf-8?B?bUpYMHJLcHVXRGJSZ0JJbk9UNm9TM2hqUEFTb0NmRzEwcDh2QXpjK3hBeUMv?=
 =?utf-8?B?SDBKQVl2em1UMzZWWlMzRUIzZXRvTFI2cUFicXp2Y3RTWEZGMCtZWHpWb1c0?=
 =?utf-8?B?cmpvZWFLb3oxcTFPZGYyVUR6ZnpVWnhLeVBHOXA1cFNTRmtENDdFS2VXeHFR?=
 =?utf-8?B?ejluVmUrRm15YUx0aU51UFllS1FZTVVCV0lla0Q2M3g5MFRWbUlWdUNiSkhi?=
 =?utf-8?B?bkhiSENNU0lwTGxlbE13L3VWUHVRUTNxN0haaVZRUjdnRGxxM09IbGlpRzJH?=
 =?utf-8?B?N3N3MWZkN0MyRlZzclNvRTRjbWt4TFZDNHBTejk0RVAzeG1GbG5icHI4YzZE?=
 =?utf-8?B?SmhRSVJKd3lOMUpzcFhmamJ5ZDNjTGxTemg1TElPTkhHdmJxNXRQM2lKQ3BY?=
 =?utf-8?B?dHhxRElqZXRJR0oyVE4vYXdSWE5QckI5T2YzTEU4QmRkdC9DUlNqcTBRWUZH?=
 =?utf-8?B?SjhzMC9vcjYyc2xzWVh2ZGhNbmEzeUl5bmRwSUhTRzJINkFtd3BmQno5Rk03?=
 =?utf-8?B?Q3hRL0laek9WRXlYSlQ2bDIvTTRtYXE0N1dzZWtvOWxvb3NyYTJaZ3BqZ3Vj?=
 =?utf-8?B?bGVLcnVEWkxjSWFBOFpRN1VuVGdYek1VTzIwdnY5REQ5ZWtwd2dSUkRJL1Bq?=
 =?utf-8?B?eFY1dkxZbW9JT0JKRjdNbXdvMTRxVlFSWEowNUVCdHhwZk5jVmtjY21wN0Mw?=
 =?utf-8?B?K29ibWpjaEpUcFRkd0loM0prZTZZWStNTEtEL3RPd2hxeXEvblRJYkQyYXpj?=
 =?utf-8?B?VnNQUzQzdVpFN0psREZOcjJtSUh5QlN2U1B6dUdBWWZlL2ZuWEQ1OStWd1ln?=
 =?utf-8?B?ZlJXWHVUdTVZNUhqTlJTd1FBS3BNZmo4b1l2NjdqUXhqcVNpRS9zYU9URXd0?=
 =?utf-8?B?Z2d1LzBqTUVCb0Zzc1o1WHFCVXN5MEhzQWF0dUE4czZlUkpzTGxEMnBhUDVo?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd89ba7d-c880-4913-d371-08de271a7861
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:19:37.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99i/3ZpWJ5MbNhy4GOpyIpEyi5sZwf+/RY3tHDOn8ATHDaDM/bm/vMYbwB3Jmtycm0A3eXevT/LeRCJbzKsgvgZotAGWlfvJNNZui+ZNowM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL PCIe Port Protocol Error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port Protocol Errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
[..]
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index b933030b8e1e..72908f3ced77 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -160,7 +160,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> -void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -172,7 +172,7 @@ void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);

This indeed looks like an equivalent conversion, I just worry it does
not work if this function get re-used for protocol errors on non-memdev
(port) devices.

For now, at this stage of the series:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

