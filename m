Return-Path: <linux-pci+bounces-26650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306EA9A025
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 06:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1043A5380
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 04:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258191AD3E0;
	Thu, 24 Apr 2025 04:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IckP2gBp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D601B4F1F;
	Thu, 24 Apr 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469250; cv=fail; b=Ywauwcpbobzh2Zi0FAzI3u/1uxIJDbJh7dyx/jbvMCUS4S5np745821gunWc8W8YxuqiRcIQ6YmY5VRG+hdFLdVjPcS+rBMvZoSupn0XRM/CHrBSc0EEtAAyefoWrSRJTXpk7J/H8JzBfRUagkaQshIynuVe0duVo5wMunMBCSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469250; c=relaxed/simple;
	bh=YDuV5yhKUScZP/Ud9F5Xk5fLooPsrVI8DiytWGgKlfU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XzS1VDaZwxWEpWqCz/5W28N1/dNg1Ws4tluasL843nh9AY9DcOp57C8S8NaeqIXDJvmBENDErehHM6y/jRd2dkTjmf/XX4fcfoFyAQOfsv5pbjcQUJg97Q7LBhIXXKEDSmVh5T3CLXIoVYxvtcstM5UYX9cmjqb2e4g1WC3k68A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IckP2gBp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745469248; x=1777005248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YDuV5yhKUScZP/Ud9F5Xk5fLooPsrVI8DiytWGgKlfU=;
  b=IckP2gBpr9doUH+fcMgso1B84doSepX5rLHA26dvUa5HAXrKOdGanWlD
   Tkk5S3aMOBOuChbRG8cUNduvd+utPyQuT4bKJokBQCYDQBMBBdv35c3vj
   GansktviB3PbLoHYIEdRW7JroelY2PwAd375mbM6HsBzsT/UQnCdcnR4h
   glANQES8G7AyW9KFaNdS0TMGXDsITawiCjS5OFF5rs4p/VUAzXEWBGyki
   lqASW4I5AWXqZg0I8NxmhfISHKZpUSHw0uQGNA3Lt3prZn25xKLxA7usw
   MoMRHy48Bjav6D3x+NA8uciUPmEJjMN9SiRizwcK8wMJJnmiiiaXSbgBk
   A==;
X-CSE-ConnectionGUID: lX50DLMzSn2ldir7waynPw==
X-CSE-MsgGUID: Er5oqAB2QJCT1F6lCDjw8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46957298"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46957298"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:34:07 -0700
X-CSE-ConnectionGUID: EdIYOYPTTTCosaX6kPRLiQ==
X-CSE-MsgGUID: yHJwrdrUSrSyE0qV+SLHKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="136583766"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:34:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 21:34:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 21:34:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 21:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3rRSGTA4TJPluz/yTbuqub7tHE6Aqc9DmOZDUyEhBMvjpGbIANz29mETye4Ezca2okm/K4uhGtmuU31ZeyeGEA1nqcgFp/sXiXVgzm/3X8Q44qKE39cleU/UmKQwXO1vc2jMwhdCrXNDnEYnNlUJAUhLxF0FwbA13d1Lf1M/QNAflvMgrVXQtC7s+xwM7tfDZ0+/wHDxQA0/2PVGIc2adTHw4Y78sCuMxzGaOzLC9Lym+Xwlj8yLelwiAketQwYIv9bGMqHuMSzk12+8scTdkPGwHjbHl8aZURBt0Txp0bMHtQwyD1Waym481B8g2rHKpQJtfFtiiVIawtfVmzGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDuV5yhKUScZP/Ud9F5Xk5fLooPsrVI8DiytWGgKlfU=;
 b=pbtg3YxP//Cqk+VcuW0w8Q4rW1lRJ8cXdktpQz49aBgbr1t6B/vtzDIlSJ0N146nuLcluQrExgi64GFWONrJaBHjt7aHOAYUMLh4SzZW2SC4x8YGOk/eFITaOFGj9Avtl0j2qCBw5ihVJ7j/UvlomG7BS9uSY/YJBChndB+LILct2RgFa2dzM+MCHO9HaU3qn/CCegnu+Ucw+OGTUKtdl+8QG7Bj8u2wNxvjwz9HvtyQkgg8SkAvfIBsI57h0tV9JbMJ6HqSthsF2LBOuCl2ek5ac9PvqmfBgl6l5eNdf7xVi5S2ymReK5VIHQ2KjKa1IIcldcW++N059mEk9GT4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB8023.namprd11.prod.outlook.com (2603:10b6:806:2ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 04:33:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 04:33:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Dave, Tushar" <tdave@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rc] iommu: Skip PASID validation for devices without PASID
 capability
Thread-Topic: [PATCH rc] iommu: Skip PASID validation for devices without
 PASID capability
Thread-Index: AQHbtL2yOAbHjZNF4EyIVgcAEB+bLbOyKAeAgAARPbA=
Date: Thu, 24 Apr 2025 04:33:14 +0000
Message-ID: <BN9PR11MB5276C04C1B1ED8F8DB7B5EDF8C852@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250424020626.945829-1-tdave@nvidia.com>
 <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
In-Reply-To: <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB8023:EE_
x-ms-office365-filtering-correlation-id: 5a1898bc-3226-455b-2711-08dd82e92103
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEtOVk5rZjQ3dEtMK0wraW1zVW92ODZxZmVsN2tmWDQxNTBhZ1hobjlvWnA3?=
 =?utf-8?B?YkluS3piNnZpV080NXNYakovVlJ3NnVoVDZqYmdoMmViTGZCZ3hHeVVodHRU?=
 =?utf-8?B?aXhSVWhHb29oYXU4elFHcEFKQURhRWRlQSttOXBabFFyZnBWM2FUWkxTQ1Nq?=
 =?utf-8?B?Z1lHNUIwRmxIa3BPZVZGT3pGd0dEelJTMGhJS0JXYUc1M2xTT0JFajdoSldF?=
 =?utf-8?B?Q2YwMnpKUEJSSlFTOGdIdkQ2cGRDcDBPdVYvQ1pxRWJRVE82a0dPS2YzWVFL?=
 =?utf-8?B?ek8vMEQvNlJMMXRLMlJVYm9uR0RMZnEyNVNrYzI1VmJNRkVaNXJadCs2dzVt?=
 =?utf-8?B?RUZJeWVNMlV1clFwK2d4T2lRTlJlbVhlQkhGM1FSamhJcXcvV3ZoR3pLMGN1?=
 =?utf-8?B?Zkl2R3NwVlVUbmtPNVM2czF0a3hwQVYwb1J6TmlWTFJZVXI2T01JcjlCajho?=
 =?utf-8?B?SlZZazVINnRuRkREVnlvTkhIRzZwcmVtN0pFbCs0ZVErc3FnR0tIYmk5SFQy?=
 =?utf-8?B?NFFjVkkvTldNTFdaTktLaXNuTm1mc3ozM1BpZ1JobzJSSXYwdnNudkZIUkpk?=
 =?utf-8?B?ZlVvcHUzcVVpMFl4dnZvbjVFZ25UZVBGK0MxMFQ4Yk1xbmV3aGlHTzUwR2s2?=
 =?utf-8?B?ZythanBmTW5iak5sTlVHaU1GRGx1UmJXdUdrd0F1ejE4ZnFBekYxU1l6M09R?=
 =?utf-8?B?TDNHV0tGVlNSNVdNNlcrL1dERWJWdHF6QkRrcjlvRmpqVTdRVi9qRGYrNzJa?=
 =?utf-8?B?bitDYitnRDBqRUtPZGt0TTMwUmlUd3NNOUkxRGhSYUR6RjJWRTlnZWg1eTdp?=
 =?utf-8?B?U2s3bXA3M2RUWExxc254WHdzb0YzUmNEQThTSmJsanJrcFlCME5lRWRETTB4?=
 =?utf-8?B?ZDMrWDh1VXkzN3BLeDJDZEErWTk5KzFzV2hVQW5uamlhVWh6K0ZWMEl5QzNE?=
 =?utf-8?B?QnBwQ0xVaERJOEo3d1dDd2xQcGloM3VEQktualZCY1BNMXlqVVdwRHRLYXUy?=
 =?utf-8?B?SnlhZEpOQ2RSRS9pc0xaTXZQdDNpNlIyTFJtUk40Z2FsQjBXSm5jRnd5MXlY?=
 =?utf-8?B?NElwbFJqYU4wUnF4V0wvaWJaVTM4cjRQZUxTTStUdzNGK0hTSUlMbGljSWlC?=
 =?utf-8?B?Yis1bE1MOUJ3NEd5ZWVWTTNxUHB0OVhidElaUGY2U1hsdnB3Kzl3THJDUlNW?=
 =?utf-8?B?Q1ArT04vc3Q1d3pCVGNFM01xWFl6dXpobVZ6NFk2QnNZaWxhYzE5UWRNRWlM?=
 =?utf-8?B?Wm8wZkhna1gzbmN6ejlUZUhPd0RkUHdVSUJpK2FOcDdhbGNpSHNUbnlkWFVS?=
 =?utf-8?B?bTdwVWVZQjBTdlBhc1F0YlphUzVXVk44dGhzcXd0MG5HckVxYW82TXpTd2hu?=
 =?utf-8?B?QXVFY3pYVEd3Vk1lN3Y5amN0RUMvQWlHMEttK2JoYWVWQ0l3Nm1SQ0JBeXho?=
 =?utf-8?B?dlFJOTVaRkU5OHF2QU4rTzQ0Q3gxNnZMblRzTXQybnZFdHpwejNvL1BxQmZr?=
 =?utf-8?B?ak1yb2VkZDhXdVhuMlIzTGhVZTFxMlUyOW5xL3BSUGN5V2MycFFTZWZPaHZY?=
 =?utf-8?B?MUVaeFNCNW1VRTVYKys5VDROQWVhWEgxa0UreUs5Qlh5WVU0Smk3OGZPUWVB?=
 =?utf-8?B?QkRFM0VkY1VkWmgweTJIMlRQVzBHMmFmNmdEckhOb3MxQVVCMVJwU1BxTTFQ?=
 =?utf-8?B?YWZyK0c4TXozTkNFSytBYVNQdFh1b0tMM2diNnNURlN0Ylh6c0ZBWlpCeVNU?=
 =?utf-8?B?RVN0bFJMU2owekplcXN6dUlUMmN1cHA1QmdnMnE0UHNRL014bjB0eDBRQURJ?=
 =?utf-8?B?NW5WaXZyZHRoNTI2OVVRbCttamx1ZTFIRlBmSElBR2w0bUdsWFdNY2hmRVN5?=
 =?utf-8?B?S0xLNHM5N2JSWk9wSkhuN1FleFZ2aEpxM0N6d01sdTNLaTZOQkFHc3czT2Iv?=
 =?utf-8?B?MTkzdXVmcU5WdGlRdDZucnNVSzFjdjhwaVdpWGwybUg3eEZRR3UzU2FxMDAr?=
 =?utf-8?Q?J8NkDuZPOCBrh//hrFkk2m9d/kQAnQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTQ2aFovQ1NyMy9pbXkvRDVLcGRrcStmMmE2NUxyRlNHdFBYRG9DemtGdDRY?=
 =?utf-8?B?TFB3c0g2NjN2cmtacnJibGlYaitORHBEUHl2SFZIYzViNE9vVVgyNjFua3lM?=
 =?utf-8?B?S0pDUW8rSEFqSDdhWk53UU5BbzRnRUk2MUFoYjRJQ2NTd3czQm92d3VzMkdD?=
 =?utf-8?B?ZUhwVk02NnliV1JQdDhLcnpzNVQzeTB2Rm5KNzVtdXlYYUMwMlVTM2V3eUtP?=
 =?utf-8?B?SzI1dGprZXpaNjJNL0xabHVqRTlMTlBOWDM4WHdzQk44ZitTUFp5V3B3cEtF?=
 =?utf-8?B?UFVBcm1hNWlYRWw5ZTlyZXFHZmx5Vnd2M1lxRzVhNFB4cUUwNExwajk2OTJI?=
 =?utf-8?B?WkwvcFNjN3FvZk1TaE5NMEJjTHYwUEdQdnJuc1dtVGx3S0plTnJOS1h1M3FQ?=
 =?utf-8?B?MFpUNVVsMi85UWtaWEVkRWlYSDI2d2c4RC9KMEx5dWR0eklnY2JoeXFXdWdx?=
 =?utf-8?B?N1RxTjBRTkFHbU4wWUNvMHY2bVVzOHI4dXR6a1hZek1HNU1TRWVyNFl4TWkr?=
 =?utf-8?B?bnV3TGsxRTkyYmE5bGFGeStialUrbWNZSXNDeThTcFVtRW1xWkg4bzFFSmk3?=
 =?utf-8?B?MW11ODNtVjZBZjZxVURBRFBLd1luVTQzR1dkQi9jaXRpeld6WE9VUTBFUSs2?=
 =?utf-8?B?Tkh2S2d6WVNzRkExeWlsYW8wRmVySER1ZUlZazhFWnczaTFSandxeVhGb21C?=
 =?utf-8?B?ckdzS3lLRWkrWk9pbFNMMlM0RDcrajAxTW8zN2ova09mbkROK3FLUXhON05I?=
 =?utf-8?B?b3BzdU5iLy8zVFduMS9HQjgxV0pXWitUYXZINlVrQWpJbGtWUi8wclhkbEdE?=
 =?utf-8?B?RkJ6MnRhVGVJK001VlpPdXh2VGpmM1pCWlFVbjg1bitlTHZqNHZraEE4OXNz?=
 =?utf-8?B?eEF6WXNRQXRyK1NRN1I4VTluem91Qk1EUnh6OE94VHN2M2Rhb2hhMWsvb1Uw?=
 =?utf-8?B?TFBDL2JlL0NZQTY2YSt3QU1LNnE2cTJvREZLeTAwMGtYSEgxU1BUQjU1YWJL?=
 =?utf-8?B?M2ZwZ2VyMHBFMXhmc3kybGZXTHBmdWRDUm1taVB2WnpqcmRDUEdkU1lhUnJD?=
 =?utf-8?B?WEREZ0tvaC9iaEE5cmNTbWpUUHRLcytXSTF5bHpmdUovUjVpRGFZWWVzbkcy?=
 =?utf-8?B?Zk9DY3lldzBsOTBQd3NIelVONWhMY3hXNUF4WjJjdWVHWTJsWmg1OGJ5aTBm?=
 =?utf-8?B?R21GMUQwdmNMQ3ViNUpLa09XVThjRVJXc3VhenBtTlJzamJYR1I0ZFcwSkJj?=
 =?utf-8?B?VXhpYzdrQWg5cm1WY2ZYUzBLWXdXYXo4T3RyczFVM1N3V21Gc2RiZWt2SHls?=
 =?utf-8?B?YzNxUHZJdExuWi9WSE1GRndvZE5wa0RrUS9Ec0FvRHk1dVp4aSt2dG1EdktR?=
 =?utf-8?B?QWszckgyYko0TngzV1JWM3hJTVh6NlM1RHNZRjlFdzl3cGNTMlEvVmU4b0ZK?=
 =?utf-8?B?ZzJIMy9PM09UWjM1RkhWUFNBcDdpVlBMUVhVSHNoOGRmK25YVlE3b05VOFpr?=
 =?utf-8?B?VGRSY1ZhcWJSTmFmRVlUWHg4ZTBrUHVVYzVnQkJQeUVMOWR1QkpVYzQxYXV4?=
 =?utf-8?B?dkRDc1hNaHFtUE50bWpIcmJUeUFNVURMMUlHSWFBZTFJTFBzYjYxYURTQS9k?=
 =?utf-8?B?a3dpb1FmNU8yNm5xa011aEpncm1lcU9RaWVzZDFMTStvVE5EWnBsS3hRZENp?=
 =?utf-8?B?S0hJaDM0aktndnlqdVg0ckw0WWhQcmZNaUw0eXVVazZoK0dRUFRGZjZhR0Yy?=
 =?utf-8?B?bFEwbkhSSnd2OFpXMGVmc0k4THB6UDloWEpjOEJlZkRsQmxrakJWeWR1ait5?=
 =?utf-8?B?SWZJWGlSd3E4ZUJjNUFtSmI1OHpSNEtUWE5JaGpTODBOb0wrRHpsZXBoOHhV?=
 =?utf-8?B?UHEzSGpHNlJ6NS94dWI3cGZTWVJZekh3ZlBiRFpkYVpIQ0Y5ZTB6NDFWbjk3?=
 =?utf-8?B?aUMwTk9yem1zYzlrNm1UOURubjhBVFU4cCtseTZOL09yaEgvazhNTzJ3aW4r?=
 =?utf-8?B?RUdrU2NGRC94enR1R29jait6bzBFWHRjVGd1MDNwcGtPK2JWK25TRWZvaEF6?=
 =?utf-8?B?Y0lJbVlrakdBM1NHRXdJeHpiUXg4cXNndkt1Y0ZsRW04ZVFMZUhZZ2tBYjR3?=
 =?utf-8?Q?uLywzEAV32qy1UtklnaBJXCnD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1898bc-3226-455b-2711-08dd82e92103
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 04:33:14.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylHN3imyD6R+5RygtecTbAyNUcExIh8HK3GF+hWmLLQHSfSfcAs9DrsMpIoWlhwSs4SZcQ82IL8eejQrX7SmNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8023
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMjQsIDIwMjUgMTE6MjcgQU0NCj4gDQo+IE9uIDQvMjQvMjUgMTA6MDYsIFR1
c2hhciBEYXZlIHdyb3RlOg0KPiA+IEdlbmVyYWxseSBQQVNJRCBzdXBwb3J0IHJlcXVpcmVzIEFD
UyBzZXR0aW5ncyB0aGF0IHVzdWFsbHkgY3JlYXRlDQo+ID4gc2luZ2xlIGRldmljZSBncm91cHMs
IGJ1dCB0aGVyZSBhcmUgc29tZSBuaWNoZSBjYXNlcyB3aGVyZSB3ZSBjYW4gZ2V0DQo+ID4gbXVs
dGktZGV2aWNlIGdyb3VwcyBhbmQgc3RpbGwgaGF2ZSB3b3JraW5nIFBBU0lEIHN1cHBvcnQuIFRo
ZSBwcmltYXJ5DQo+ID4gaXNzdWUgaXMgdGhhdCBQQ0kgc3dpdGNoZXMgYXJlIG5vdCByZXF1aXJl
ZCB0byB0cmVhdCBQQVNJRCB0YWdnZWQgVExQcw0KPiA+IHNwZWNpYWxseSBzbyBhcHByb3ByaWF0
ZSBBQ1Mgc2V0dGluZ3MgYXJlIHJlcXVpcmVkIHRvIHJvdXRlIGFsbCBUTFBzIHRvDQo+ID4gdGhl
IGhvc3QgYnJpZGdlIGlmIFBBU0lEIGlzIGdvaW5nIHRvIHdvcmsgcHJvcGVybHkuDQo+ID4NCj4g
PiBwY2lfZW5hYmxlX3Bhc2lkKCkgZG9lcyBjaGVjayB0aGF0IGVhY2ggZGV2aWNlIHRoYXQgd2ls
bCB1c2UgUEFTSUQgaGFzDQo+ID4gdGhlIHByb3BlciBBQ1Mgc2V0dGluZ3MgdG8gYWNoaWV2ZSB0
aGlzIHJvdXRpbmcuDQo+ID4NCj4gPiBIb3dldmVyLCBuby1QQVNJRCBkZXZpY2VzIGNhbiBiZSBj
b21iaW5lZCB3aXRoIFBBU0lEIGNhcGFibGUgZGV2aWNlcw0KPiA+IHdpdGhpbiB0aGUgc2FtZSB0
b3BvbG9neSB1c2luZyBub24tdW5pZm9ybSBBQ1Mgc2V0dGluZ3MuIEluIHRoaXMgY2FzZQ0KPiA+
IHRoZSBuby1QQVNJRCBkZXZpY2VzIG1heSBub3QgaGF2ZSBzdHJpY3Qgcm91dGUgdG8gaG9zdCBB
Q1MgZmxhZ3MgYW5kDQo+ID4gZW5kIHVwIGJlaW5nIGdyb3VwZWQgd2l0aCB0aGUgUEFTSUQgZGV2
aWNlcy4NCg0KSXMgdGhlcmUgYSBkZXRhaWxlZCBleGFtcGxlPw0KDQo+ID4NCj4gPiBUaGlzIGNv
bmZpZ3VyYXRpb24gZmFpbHMgdG8gYWxsb3cgdXNlIG9mIHRoZSBQQVNJRCB3aXRoaW4gdGhlIGlv
bW11DQo+ID4gY29yZSBjb2RlIHdoaWNoIHdyb25nbHkgY2hlY2tzIGlmIHRoZSBuby1QQVNJRCBk
ZXZpY2Ugc3VwcG9ydHMgUEFTSUQuDQo+ID4NCj4gPiBGaXggdGhpcyBieSBpZ25vcmluZyBuby1Q
QVNJRCBkZXZpY2VzIGR1cmluZyB0aGUgUEFTSUQgdmFsaWRhdGlvbi4gVGhleQ0KPiA+IHdpbGwg
bmV2ZXIgaXNzdWUgYSBQQVNJRCBUTFAgYW55aG93IHNvIHRoZXkgY2FuIGJlIGlnbm9yZWQuDQo+
ID4NCj4gPiBGaXhlczogYzQwNGY1NWMyNmZjICgiaW9tbXU6IFZhbGlkYXRlIHRoZSBQQVNJRCBp
bg0KPiBpb21tdV9hdHRhY2hfZGV2aWNlX3Bhc2lkKCkiKQ0KPiA+IENjOnN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBUdXNoYXIgRGF2ZTx0ZGF2ZUBudmlkaWEuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pb21tdS5jIHwgOCArKysrKysrLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9t
bXUuYw0KPiA+IGluZGV4IDRmOTFhNzQwYzE1Zi4uZTAxZGY0YzNlNzA5IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUu
Yw0KPiA+IEBAIC0zNDQwLDcgKzM0NDAsMTMgQEAgaW50IGlvbW11X2F0dGFjaF9kZXZpY2VfcGFz
aWQoc3RydWN0DQo+IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KPiA+DQo+ID4gICAJbXV0ZXhfbG9j
aygmZ3JvdXAtPm11dGV4KTsNCj4gPiAgIAlmb3JfZWFjaF9ncm91cF9kZXZpY2UoZ3JvdXAsIGRl
dmljZSkgew0KPiA+IC0JCWlmIChwYXNpZCA+PSBkZXZpY2UtPmRldi0+aW9tbXUtPm1heF9wYXNp
ZHMpIHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIFNraXAgUEFTSUQgdmFsaWRhdGlvbiBmb3IgZGV2
aWNlcyB3aXRob3V0IFBBU0lEIHN1cHBvcnQNCj4gPiArCQkgKiAobWF4X3Bhc2lkcyA9IDApLiBU
aGVzZSBkZXZpY2VzIGNhbm5vdCBpc3N1ZSB0cmFuc2FjdGlvbnMNCj4gPiArCQkgKiB3aXRoIFBB
U0lELCBzbyB0aGV5IGRvbid0IGFmZmVjdCBncm91cCdzIFBBU0lEIHVzYWdlLg0KPiA+ICsJCSAq
Lw0KPiA+ICsJCWlmICgoZGV2aWNlLT5kZXYtPmlvbW11LT5tYXhfcGFzaWRzID4gMCkgJiYNCj4g
PiArCQkgICAgKHBhc2lkID49IGRldmljZS0+ZGV2LT5pb21tdS0+bWF4X3Bhc2lkcykpIHsNCj4g
DQo+IFdoYXQgdGhlIGlvbW11IGRyaXZlciBzaG91bGQgZG8gd2hlbiBzZXRfZGV2X3Bhc2lkIGlz
IGNhbGxlZCBmb3IgYSBub24tDQo+IFBBU0lEIGRldmljZT8gVGhlIGlvbW11IGRyaXZlciBoYXMg
bm8gc2Vuc2Ugb2YgaW9tbXUgZ3JvdXAsIGhlbmNlIGl0IGhhcw0KPiBubyBrbm93bGVkZ2UgYWJv
dXQgdGhpcyBkZXZpY2Ugc2hhcmluZyBhbiBpb21tdSBncm91cCB3aXRoIGFub3RoZXIgUEFTSUQN
Cj4gY2FwYWJsZSBkZXZpY2UuDQoNCmNvdWxkIGFkZCBhIHNpbWlsYXIgY2hlY2sgaW4gX19pb21t
dV9zZXRfZ3JvdXBfcGFzaWQoKSBhbmQNCl9faW9tbXVfcmVtb3ZlX2dyb3VwX3Bhc2lkKCkgdG8g
c2tpcCB0aG9zZSBkZXZpY2VzLg0K

