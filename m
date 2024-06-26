Return-Path: <linux-pci+bounces-9270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 936079179EC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 09:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE01F22CF7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7C15AD90;
	Wed, 26 Jun 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qt+FQ6tl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC61157A42;
	Wed, 26 Jun 2024 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387638; cv=fail; b=gImYTmBLATATht0yAj8nXFYnOq8dp0G2Rt43hP8QlyoiZZZUisNKDyA/tpJs6sgrsx2yNqotwzklpX37kpJUARqRFvRAbsa5dCw6sf/CW8QlBSkqnzgLasVJe0b2WDfyHpaarKQWygDF8iftXa0Gz65o91vhr1e+IPAUldtVlQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387638; c=relaxed/simple;
	bh=sM4Tbqpl45q23G1RPfSNn3LT0XB7/Giq6bGR4kbbOqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FH7yGdpzF/bfXsOo5lFabk97JAITp/vk+B38JSoQ+EWMQ8ygGk334X/SaeT/hEBRNHn3PmKixzBZe8LJ6+lccd+vHFM+EoRVXJIThBrjedyNbHnEzvHUp1Nud6YV80sw5bgiEqBLi6Okn0WMe5HJUN2XC32hEKsK/RUb5u4Bn40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qt+FQ6tl; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719387636; x=1750923636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sM4Tbqpl45q23G1RPfSNn3LT0XB7/Giq6bGR4kbbOqQ=;
  b=Qt+FQ6tltuToWa+SFkqoIxkKYZWaPAVdGyIbQrqlYlbhQNz3FIKLf70J
   4uvgw2LqPqrpzbnJcw5prZhZ0dgHKKWmUECJ7zV7A22vmXvYfpavdln9I
   Mzp/D5IPa0+svm1zT/b8d55/bM8a8bbFftDdvJDEdHCGhRnfo/gCmfmHf
   mtamGGcwURxO12e2VydrJqLou1Mbvi1DTEugyHFkrngVXv7viM1VPX8Cl
   wb6URQxyRabQnExru/hhNeaVsTayev+YB9sbg7Ek+GS16iKHD6cc7xsl6
   MgAQjifrj8XeF65036Tf95As3f1WCHI4Nunyq0X+eMfOdbo6HtSrOw0ue
   Q==;
X-CSE-ConnectionGUID: 4GEtZjp9TcmOaugHpleIpA==
X-CSE-MsgGUID: ORF/beNYSAGmrSVvfuvCoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="38954605"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="38954605"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 00:40:35 -0700
X-CSE-ConnectionGUID: xz9LUuOOT82QDk5mCJLepA==
X-CSE-MsgGUID: Z9v8CavuSKKcfNogjPqBqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44005258"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 00:40:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 00:40:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 00:40:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 00:40:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 00:40:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy3cFNcAbSKmD4x0JVCi8BfiMznlN4hT5yNUPMt/oV52rEvFNb2Lo1SoATWMzI4Eo+2XQTDz1AFJ2l2elQwpLy4R+trw8fUGKOFNPba5aCWtf3O5b0hivBk9exzcK+QjFs/U//AkctXSRpvoULpDCzsgHR6NZuztG0AO2HOKZqz566n/m1aN11nw85WpuHsmb3z3obVNuXB8rLE2+q0f8urx7+0QNvu5i6tgh/gftpgcACjk2xegTnnXHfRf4oNsq7L1CnN8rH15TiDklZr/p0og9QRV+C7xGndnuZbMyLMCSDBpG7bXIQAN0cJnyrQlwdhchpr9qq/xCkfFeFNjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM4Tbqpl45q23G1RPfSNn3LT0XB7/Giq6bGR4kbbOqQ=;
 b=ALqHrYwWNePsUSt1B+KkSy+u1ufeXyyy5BYiG4mTUwfQvsvvwwhR33vE94if6rlb0ueeUfXGi+agLuLG1osY6/Ty2A7VSYdRLWJrqX+nif48XhCNvq1EVeL/69kgOC2GE8Vi8KtX2GZi5/CxDa16JxoeFm+5FVv/NBL+vd5Zl3Ee0Z5KrqlPDbiP45Cg6BoZDqeLnMBvm8CTcXgpI9bWfADik62ePCn2I+gvYYd5bRSG2u3FnIlVV2+FeryuQBNV9gosYE2YtS+NUNItNLWHMsD57xeeZ7vwbZZ/svyp7J5CtqeO72l9VBGViJJD6DpHoAEeUCvlwXMQ0/kha4KOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by LV3PR11MB8766.namprd11.prod.outlook.com (2603:10b6:408:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 07:40:32 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 07:40:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vidya Sagar <vidyas@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "galshalom@nvidia.com"
	<galshalom@nvidia.com>, "leonro@nvidia.com" <leonro@nvidia.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "treding@nvidia.com" <treding@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC: "mmoshrefjava@nvidia.com" <mmoshrefjava@nvidia.com>, "shahafs@nvidia.com"
	<shahafs@nvidia.com>, "vsethi@nvidia.com" <vsethi@nvidia.com>,
	"sdonthineni@nvidia.com" <sdonthineni@nvidia.com>, "jan@nvidia.com"
	<jan@nvidia.com>, "Dave, Tushar" <tdave@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kthota@nvidia.com" <kthota@nvidia.com>, "mmaddireddy@nvidia.com"
	<mmaddireddy@nvidia.com>, "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: RE: [PATCH V4] PCI: Extend ACS configurability
Thread-Topic: [PATCH V4] PCI: Extend ACS configurability
Thread-Index: AQHaxxT5kigok8bC5ky/wdKAswAJjLHZpvjg
Date: Wed, 26 Jun 2024 07:40:31 +0000
Message-ID: <BL1PR11MB52718B54937B888AD9E394D78CD62@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
In-Reply-To: <20240625153150.159310-1-vidyas@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|LV3PR11MB8766:EE_
x-ms-office365-filtering-correlation-id: f3553d6e-cc78-49d1-8fe6-08dc95b341d5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?VTNOcUJJZnhGaG1MYzNJTGVDRVBjK2I1MTlrYkJGWEJZbWZ4UFpkVzRRVDlW?=
 =?utf-8?B?SmxPWGJ0L0FXOHdtU2h4YkppaGJqZlRPNEZrK2ExeDQwdDI2a2VuOUdDNTJY?=
 =?utf-8?B?dUdHUU5rVEpUUG8vc2htcFQxd3MvV2JtSzV6RFVtWndpbHZKUEE2YklyVUl1?=
 =?utf-8?B?VEdJVlVoMEVKRzFPVWY4NTVzQ25uZ251bVNQSUJyeGlzSUFpVHBkeHd5Umt5?=
 =?utf-8?B?Q3M1cndNd0FjUEtrbjNHVlArNzV1T2Z1Q1RwaHFpYVFha2FvZngwRXFjZ0lT?=
 =?utf-8?B?S0gwNkl1d2Z1V2FzTlJ3Zk1jMTNKMnVZL1NSTFdCMzgzLzhWM3J2MjV5VTg5?=
 =?utf-8?B?UGFoQ0NLbDFlNHhxSTJYQ3JUYVdWbHRheldodm90SWVWM05LcFZJYUp4eWgr?=
 =?utf-8?B?aW1KdXdMWHBmSkZhc0hDN2IyVTVZazV2dENZTVo5M012bFVPT28ydGN2TWl1?=
 =?utf-8?B?UHcrSzh6WFpEQlZONEJGeEJzWWNBL043V1o0TWFpOXdwWVAxMzhsenY5THBD?=
 =?utf-8?B?UForcUZzamd5R1FkZ0JhTURyRUZUTGx4eGlMZGVPWFpqVlBDdldTU2RDVWJT?=
 =?utf-8?B?UWkvYk1OUStLVmx1WVlqcS9tazFhZUZmd2diZVBndHVodExiN0tnYndHKzNk?=
 =?utf-8?B?K2RMNng3eUI2RmlzbEd0YVVkMU9WSXkxMUQ0ZC9DNXljUmlETXVNRGpOR1Bs?=
 =?utf-8?B?R2JKcUxKNEE3NHExVitCTWpIT2pDbi9RSkR6Skk3NXUrWDBHVjlpaDBkTzM5?=
 =?utf-8?B?QW52bXo1ckltVWxCcGJLc0RjYmJXcTMvak4rMFdQNUlBdU9rbzM4dHoreTIr?=
 =?utf-8?B?OTlHNjZHUGt4ZklpLzc3N3VZeWd2Q3pvN2toTi9zL2VXdjRzSUcxMGFsUVZI?=
 =?utf-8?B?UEJBaE9IeWN4ZzhhaklNcVpPSklTNDhCY2JXZWlHZTREclVIY1pMcHM5a1Nq?=
 =?utf-8?B?dy9qQWN3bUh2UU8ySmZzZExGZVBBdStyMFcwY0JXdEx2SkJRRHVlaFhzZGlY?=
 =?utf-8?B?aS9QQW04ZVFSQktWb3M2RHgrUHNJUGU2ZGVSZTNxZTRwVm92OHVRdjhCYUU3?=
 =?utf-8?B?Ujd5M2RQTTVyT1FSakt6QXFyK01sWUhGWWJFdzlsM1JlMU9kcUlZZWJ1SGli?=
 =?utf-8?B?Ukw1T1B1T214cCtrdFBmRDJUdlkrdHlyRXNRRDlLQ2hWaTFmL1BHY2QwN1o2?=
 =?utf-8?B?UVYzYlFGRTVOaGVaeXVkTTdJZWg1SVh6Q0hEUDdvZFhBdndRSTVXUTlSemN6?=
 =?utf-8?B?U2xXNy9xM1NNcEp2cG5PQnh1d0FLVFZrVGlXWjNvK0RjNnhvVWI5OGxsV0hk?=
 =?utf-8?B?cW1EamlIQlAyL1FBc25BQzdnaUl1MGtpOXZiMmhkQXh5WllRUEk0VXpVcklS?=
 =?utf-8?B?UFNuS2U2RlMybXhFb21pbEZ3VHp5OXlueXoxWXFPbVNIa3NZelpkUUU4U09L?=
 =?utf-8?B?eitHNkVNUUVMWTY3Ni8zUUtSYkdrZ2lmSUc2TUxRRkt6Q0Z6U0VqT1hDbXhI?=
 =?utf-8?B?UThuWFpCdEU3NUt5MlBvR0Z5emg4R3ZsQ28ybzNTMU9nN3cyNFNpT1lUQVAv?=
 =?utf-8?B?S3F3WGFLTnJSbzZLZmdJN0x1aUNWMU4rbFdtTXZVb05rNHdsN0E1cStONTlC?=
 =?utf-8?B?RVZhN1JSUitoY0I4bzg1TWJOeTkxRTlKbTRSTDFxZTEySFdzN3VVdVgxVTZR?=
 =?utf-8?B?alF2RlVRNVFpSU5EbVo2Y2o1VmxjdDlvZ1A0bWhUbVY0WGlWVzRxL0FYVUpH?=
 =?utf-8?B?NUxEbTZITFNZQ3hBQzJZVGlkZXpLYlViU1JyckxrL1ExdXN0enhxMU9YMW00?=
 =?utf-8?Q?0NEyA41iJ5BXvWh60jqK91zVEc85DLDkzk8LA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3o0dmFkV2E4SHNkOWcwb3lxSHlYUjFYeVZtdVBWblhHbExBSkVVZ1lybmtM?=
 =?utf-8?B?akdsMDBOd2syc1k0eDZZN0ZhS2haU1FYNkJLNUtGSUZqbXdNYVcxWng3R1l5?=
 =?utf-8?B?VXE1eWNNa3RpZ2I1OTlwZElNQVpWaVVGcEN3S3BzeW1lYmlML2xKKzM5RGRy?=
 =?utf-8?B?aVpmdVdqallqVDZvS0ZBbVFsS2lKVGFDazhSclBBdm9Bb1NVYVZpWE9zakhU?=
 =?utf-8?B?cFp2MlVGRldiejdzNVgvVEcwSnplNHZsd0tST2REZTgvb3JhcUhGTWtISExo?=
 =?utf-8?B?Vm5ZamZOdTRFeDBCRTNzWU5MTlNBTDZlZWtuY05zcVd4WFBEdU5kUllxcnFq?=
 =?utf-8?B?NUIwZFcwWlJCTmZnSWdFajJydElidkUzZ3RzSGpWNG90ZWs1dnRMemVrc0o5?=
 =?utf-8?B?bC9RSGdmRFZHek05eUhQa2RwODZHdngydzBPYUtTbXlPNXdLekc0bVNLTGRq?=
 =?utf-8?B?QVpoVUxQM2lvakMyWkF5V3owSDZjWjB5SldSUWQ5bnI3L3duMUc0WEhJRnll?=
 =?utf-8?B?dG91MFppdDhtZWh5aGUxZVRVSzJkZEpBNEFHM01vMksyVFdNOTFFN2Y1TDlt?=
 =?utf-8?B?QUMrMWZJNzZVQ2wwSzlwVXRWeE9IcTBBaWI1M2RIcjRkQWwxNXIwTE1KZG9y?=
 =?utf-8?B?Z2czaEo1T0Vxc0Jta3BoMXlZczFncUViYlBXWmNUUlhINGVNTHMvT0kvMzNk?=
 =?utf-8?B?V3RKemNPTjdKeW1ORlRhQVpZNFN5bjF6VGxFOTN0Q0p0RHdtUkRtTnZOUzhX?=
 =?utf-8?B?b0VZckYzRldIN3lKSGQ1aVRpNFZGUUFqNnUrdWl0cm5XN2YvTzJsV0VFRUIz?=
 =?utf-8?B?aDBnSUxmaDBlcXBWQjhUZ2MydGo1YitraGc3R2xFbitCeENTTWZnTWladHhk?=
 =?utf-8?B?czkyNW5Vb1I0NDN3amljZ1B2clB0NEN1VFhycCsxcWRjdHVuRndLWWdpcDZm?=
 =?utf-8?B?Ym9OUFVPR29CYVNRNjB6RjloeExVaGVFM292T1BnRGpJSitQOFJJQ2YvMXlo?=
 =?utf-8?B?TldLQlRqVldQV2JTc1oyb0JLVTVtemk0UndTTktZd3g3R2k3MEdNOGg1d3BZ?=
 =?utf-8?B?MHc1eTkzanhGQXBPTDVKcHBVRzVqTEM5NjRZVlp1b3ZTZFc4U21KU08xem5a?=
 =?utf-8?B?WjUyT3RaVHVHUlRCZmdEZDVUYzdPU0x6RDhwN3BMZUwrN2hKZXUyV0c5aXVm?=
 =?utf-8?B?ejVQME11UitlVC9RcmNBc1FBQmlsMy82Z2MyQUZySUw0bzdxQlJSMTJ4bzAr?=
 =?utf-8?B?RFVjUDhRUm0zNEFIQ0crZ1NLVm9oUmNuYjJIVUpsYUU1T2ttYktURWlPVWcz?=
 =?utf-8?B?NkRUdU05S0hRaGozMWxZNm9KTE1ZMXZFQ2JhNTUzbk1BeTY4Y0hWYUJFN3Jz?=
 =?utf-8?B?OVhtWXF2Zk4wWnJVZXNOL2VxL3ZTenp3MktmVzE2TUo2SXQ2SjR5VlI2SFZJ?=
 =?utf-8?B?Vk4weVk1Z0VneXF2WEtnZWpwTzlGWE1sL1VaelhlQm5NUlQ5VWNpZVNNODd2?=
 =?utf-8?B?YnJqdTNreW1TZG1TNWxuZm45aWcyN0tRU3JvbHRTQTZNeFR5UXFVcFRuUzZY?=
 =?utf-8?B?RGlibjhMd1RjbjI3cDFBU3FnMWc4WGIxZzdkSFNManA2V3d4SzZiRjA3WGIz?=
 =?utf-8?B?L0VHRE5IQkxraUdGQjhSSnhhcHFMb3Z6WGtvOGZUbW9tVjhwbGZGekxXeGhu?=
 =?utf-8?B?UmhsZnY5eGZpSisvSE1Sd3hiTU9EVDdZOSs4V0k0MzhqRGlJblpydFhJbU1X?=
 =?utf-8?B?Y2dkUzZscjF5RkhtL1JnaC8vMXYzbWIrUm9ZZDN6amRxS0hoa3V4QWxOdEhh?=
 =?utf-8?B?bWtqNmRuM3BtOURCWVFUU1NUQ3g3Qzhya2YxSFBvRHI1dWhqTUZxWTRHNS81?=
 =?utf-8?B?Z2RBcmhNS1JieXFBZ2FuQ1oxeHFLMGU0cFQxMGFGRmt0bi9ia1IvMHc1L01Z?=
 =?utf-8?B?a3gvOFFjWXRCeXFrRjZhQUpldHRtSHRabEhPV1lqeFRrOTRSSS9iYmhTaTRR?=
 =?utf-8?B?dVQ1WjVLWkNMUDZXZDh0MG1IRHRSdGE0SGZnSWcxTGZPdGgyeFh3M1BPZi9I?=
 =?utf-8?B?bmU0a0w1WWptenhVUGVhNkdoblpHRlVjWWVyejQyVWpMR3ZvN1ZGM215QWJs?=
 =?utf-8?Q?2if2LFKEOjVn8Gtg0Qbr3wQEr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3553d6e-cc78-49d1-8fe6-08dc95b341d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 07:40:31.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKA7x3dT/tB02U+7kHTKHmROc0/5PQxH6DTEqmlOqXBYyt1+yW1Beyrp34hafwn2C5p/SEark2s08CVD7MEEvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8766
X-OriginatorOrg: intel.com

PiBGcm9tOiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bmUgMjUsIDIwMjQgMTE6MzIgUE0NCj4gDQo+IFBDSWUgQUNTIHNldHRpbmdzIGNvbnRyb2wg
dGhlIGxldmVsIG9mIGlzb2xhdGlvbiBhbmQgdGhlIHBvc3NpYmxlIFAyUA0KPiBwYXRocyBiZXR3
ZWVuIGRldmljZXMuIFdpdGggZ3JlYXRlciBpc29sYXRpb24gdGhlIGtlcm5lbCB3aWxsIGNyZWF0
ZQ0KPiBzbWFsbGVyIGlvbW11X2dyb3VwcyBhbmQgd2l0aCBsZXNzIGlzb2xhdGlvbiB0aGVyZSBp
cyBtb3JlIEhXIHRoYXQNCj4gY2FuIGFjaGlldmUgUDJQIHRyYW5zZmVycy4gRnJvbSBhIHZpcnR1
YWxpemF0aW9uIHBlcnNwZWN0aXZlIGFsbA0KPiBkZXZpY2VzIGluIHRoZSBzYW1lIGlvbW11X2dy
b3VwIG11c3QgYmUgYXNzaWduZWQgdG8gdGhlIHNhbWUgVk0gYXMNCj4gdGhleSBsYWNrIHNlY3Vy
aXR5IGlzb2xhdGlvbi4NCj4gDQoNCkl0J2xsIGJlIGhlbHBmdWwgdG8gYWxzbyBjYWxsIG91dCB0
aGUgaW1wYWN0IG9mIGxvc2luZyBvdGhlciBmZWF0dXJlcyAoZS5nLiBQQVNJRCkNCndpdGggbGVz
cyBpc29sYXRpb246DQoNCnBjaV9lbmFibGVfcGFzaWQoKQ0Kew0KCS4uLg0KCWlmICghcGNpX2Fj
c19wYXRoX2VuYWJsZWQocGRldiwgTlVMTCwgUENJX0FDU19SUiB8IFBDSV9BQ1NfVUYpKQ0KCQly
ZXR1cm4gLUVJTlZBTDsNCgkuLi4NCn0NCg==

