Return-Path: <linux-pci+bounces-33336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B1B19119
	for <lists+linux-pci@lfdr.de>; Sun,  3 Aug 2025 01:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1483A6F7B
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2261E7C1B;
	Sat,  2 Aug 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIh1bnNs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3020012B;
	Sat,  2 Aug 2025 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178657; cv=fail; b=F6v3SCrs4IL//VZB/6zkfgVErqBM9SyeXlCCVwwvmgqLa7TAomcyRyEE03/DM/oDV2kVjtzR+4OtOZAjto8TEF7TWHY67sVjh6bQFVydBzJWTJyiynSsKAU7msBVe9y+vPwsxvlTlSs8wpOUwHfzNLA6oxhVPLC3bx7Eyw/eyCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178657; c=relaxed/simple;
	bh=OS9Z7aUiknHZA6BthOWis4wAkRrym+7tH520/L8tZmg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=U1OPQajsN0M5P0wbmgr7NKuh3NnbximdJh36mQheVunjSsMAvF8I5KgB8eYYv2axuh9G83I+NZRAp0wxoqHrBMMJlokr/dplJ0erIyXsI5EggBGwkunl+px4E0+Ca0K8tRnmzgkWMrMVlCtuT38w/MhyIAxNPJ6pS6CSkOHjGXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIh1bnNs; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754178656; x=1785714656;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=OS9Z7aUiknHZA6BthOWis4wAkRrym+7tH520/L8tZmg=;
  b=KIh1bnNsUgd3IbOAlmiHEiY3SvS3f0B25uspLhErOHkqm2QajrawAGdT
   Q9m/gQY25n/diW3CfG2TrFs22YEv3G6N2jYfNmNvAwQsqTgJAOBuFssqs
   AvMDocacAl/CRU9UjaqKL2DsNJISMQ7vREv7HjWdxyG7O+lr8KeEw9ElP
   BVuuCw/w5Tw9tf67f2Mh/b9wt2sBSBxYWzo2osLqlKncYSGFSsNp83C4E
   fvVZZpAyX13VcSI8ZIPq4EKmGw4UJksq9gXp2y+NjyH3G4RNCH3PH4CsL
   SkRlw+uJQ4R2a7Kd24vDO/eE/R/M5ZvkexW87JZaac3ITIO7vfr7IB8rF
   A==;
X-CSE-ConnectionGUID: EXfWMcsIQrKj1qhJz7an9w==
X-CSE-MsgGUID: kcI28pa8QDe3AtnFHdI7aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="60314912"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="60314912"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 16:50:55 -0700
X-CSE-ConnectionGUID: HH7QfqMcThyKvLv53A7hvg==
X-CSE-MsgGUID: Ab/GixacQVGpfuO2USHUXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163131755"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 16:50:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 2 Aug 2025 16:50:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sat, 2 Aug 2025 16:50:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 2 Aug 2025 16:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpf19LBwpFX/8w2ViMBuONrSEVGPlhCV6/4RmBuG6Ni1t3kIbIXZo/1+GVFyjZWRzbAhcioIEOhpFm/3aTK5+Ade1MYQXK1netoArwKdgf+u5ByDN6gnhDjKSBVc1lA8IEgSSatwGEBfqhPnwTOI44WiRSdHPeFRiUI8jZ/XvndjpvRwlN3dUbR9Y0Gs3p+LBq4r5T9hvkBnR6lCBCq/t/ZFOi+WenYQrtKGaKksBbQK0nZXR9ekp3HyOB0xUWJO0u2yFV7p5JDYgD+GIiaGIA7jG9Z/JmMMDU0xhZ7Z81Rw+i7jSFpOtXzXh1oEUYsJEmE7ic3LQm5vH57p9jC7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tts63ruMAQW3j8+mBhjhDkViO9E+d5lDz1g2Rf/LhI=;
 b=gLHNP2y8wiV2duLdGgLNwgLIG2GyQ2F0wVMpjYili8znAk/GnDyS6gNQ65h2lTDUKuxEjTnll8lwf3HOPTU5KmuWn7EMvJEYOEOyV01MtPXqRZW20n45AUmA2K1yMzCnlGtoh6ooPrhYrFeccAAM0lGdxNiEcEyc848tIOuA6OofoBEvA0StwVQ+k8ENbaYLIDTP/gvFoYN2hNLtdYVqJa1v6jDe2NdUKnmUdgchGRQDcKNsDvUXGzgebT/h6QFLRjntkJHixJClVmMJFifKejqW33M8UQf8q3CKjFMm8MB4HCtadX4jBbOHoH2buqB+ZDMsurU1EXesGPet6D/Cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Sat, 2 Aug
 2025 23:50:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.8989.017; Sat, 2 Aug 2025
 23:50:51 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 2 Aug 2025 16:50:50 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>, <dan.j.williams@intel.com>
CC: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	"Steven Price" <steven.price@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, "Marc Zyngier" <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Message-ID: <688ea45a14015_17ee100cf@dwillia2-mobl4.notmuch>
In-Reply-To: <20250802141750.GL26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
 <20250802141750.GL26511@ziepe.ca>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2eb3ef-951c-4770-2ce4-08ddd21f69a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHUwVGswaSsrVE9oZFNBd1lBMXdOYzhJRTlFKzY3Sm0yUmxlOUVqdGFMaDdU?=
 =?utf-8?B?aGlDMHlQbmlramZBVitSdUdOOWU0czdKaEdRWVp2c05BMUFON3RBK2xRbklu?=
 =?utf-8?B?Y0Z6d2FqUVpnbDEyY2JrM3ZJKzFiNEFiVjc1WFFvSWdmRXMzb3c2dHRxZHRo?=
 =?utf-8?B?S1lyemdFcmlZUTVxKysrYWQ3S3Nyb3RxaHF2cHVlRUpBTWc5WmNTRjJQdTJC?=
 =?utf-8?B?MnBQeVZZMkpqWFJXZXA2Zi9GMk8walJBNHBaY2lscjV2bmNpN0Jvcm5EZlZH?=
 =?utf-8?B?c2QxVVVRUWJYYk5UNGRDV243QlRnV0ZOdFJZUWNXaWZPTnpEbndYcmtXc0NQ?=
 =?utf-8?B?cTlhU0tieG1WaDVmbWlKaTRYb1F1aXlicThYWjduZ3NqOWlzOC9EUDd2ckxs?=
 =?utf-8?B?ZUhEa1cwNjdSRzZ2K0E2aU1JSHE2SitQRVdXa1VKWnF6WHlwYjkreFFMSzc5?=
 =?utf-8?B?cVJSS2U3OHZPZ3JLdVNkeXNHQy9EdTFUd25tS3dXRjZXRlFiWU5vMGtndTBM?=
 =?utf-8?B?b3I1RUk0ck5WQWxVMjkxOFlwS0Z2bVN5UUNPbXRwTXFSSDVMTG9MWUszSVpW?=
 =?utf-8?B?RERXMDd1c3pNcXVYdGdRSUVpSS8yMXFNRUZKdGRzZWJJMzBxWHJOZC9SSDJr?=
 =?utf-8?B?dG9KNVBWNXBEWFd5VnpNQ2NnbyszaEdpeGxvZjF4QjNXNEg1SUtFeTh5Wm1L?=
 =?utf-8?B?b3dyK29QdUR3eldzYkVFSmhYa2xuOVlpSXdwSmwrOExLazFKYW9WMFVSdDU3?=
 =?utf-8?B?UC9PdTBQME1udzNCUktCbW82SHg3QmhralZTbWZVNnhIc0JKMWxVUlhqWFJ3?=
 =?utf-8?B?am9xWWJmQkc2OTM1RmYxc2FBemFHV2hLSm85Rjk5cDJaU29JRkhreit0cWFq?=
 =?utf-8?B?ZFZzdlM4YzVEbWZCOUZPcnFDTWJQcXArdk11N3h1UjRxbDd2czZMbkFuU2Z2?=
 =?utf-8?B?QVk3Z3VMWTZzYTlnR0ZQdkxmYko5WHFFZm1KaFR2N2pFeW9NVEl4bzVBSFVv?=
 =?utf-8?B?ZEFMUlZqWnZsbUNuY2NmTUg3TDhyREpCdlY2SkhMTmVNN0M4U2s1RkFHa24v?=
 =?utf-8?B?aXl6dWtWdHBiTWFLRHdKY2pKK1h1QXZPNTQvd0M5dURvcTR2MmNuWnNKSUJX?=
 =?utf-8?B?Z2NMVWxZeWRDaXpjMUFnZmwzdkR4OGpPTUUyb2V2ZUsxSW5ZOTJ5VU1JR1Nq?=
 =?utf-8?B?aFJBUGZ6WVpmakdyU0JyQVN5UnQvZk9pcnk2TVc0MG5BUXpXSUxyYnp1Uy9G?=
 =?utf-8?B?QldPckhQcUtvbFhYYXFaQWl1dnlTMEdNMVF3NVhRRFdpOEVuQXRTdWk2MVVr?=
 =?utf-8?B?UEYrRk1waXZuZmU1ZW5wSEMrZHRUUjNiWnVCeTVNMkdCdjZZbEo5OWlzYnhw?=
 =?utf-8?B?cU5ZS2FicUxCc1JnT3RUTStIVGVwMnpZaHpoUDlNc3ZneVlGbEJIcGlsbEZJ?=
 =?utf-8?B?WGF4SXJ2M1dnNHlpdTlaWlFlV1BKZGxmNEZpKytRSlJMMnRPVXBSTVE4cnZz?=
 =?utf-8?B?OFpLTzB6WlF3WnBpVVBKbjZUVXNHVFV2Zmp3dkoxcWU2VG5XSFBHSllTY2VM?=
 =?utf-8?B?MWFVNW1peVZVUkYzVVdmTEZqZFh6SzZMRnBkYVplYnFNWE9yWExsVCtsdkRB?=
 =?utf-8?B?aCtvRUluRFM3T0FOUTQ0Ti9DdnEvbDQzV2hUMGhnWTA4YzFTMUVPbk9UMTY2?=
 =?utf-8?B?cmJ0cGJqZSt0bk5oQlNKV0thdTJIZ1dLNERtNmN4V1BFME5yaGI5a2EzdndN?=
 =?utf-8?B?QWJiYTArRHJwMGNsVUROc2M3U3pRc3I0cmZjd3VNNlJrbUZTYU1TTEgwNW1F?=
 =?utf-8?B?dXpaamk3elowWEpWNnNsMkVVYXErcnJlK21tL1AySGVndWVSUUtjSUFKdzhB?=
 =?utf-8?B?MjBQNWw0SURlbENrZmVTdVYrbHF5SGlRUnNZTjNMNUM0Ti82OWxGKzcwcTBJ?=
 =?utf-8?Q?efxbILnWt+c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1dYY2N3T2Nhb3pERzNOdFdxWkdvZUgrVURabzgyeVc1bjlWZTJjZmczdytk?=
 =?utf-8?B?d2hYQkhVUE5zcWs0dnYxVEdVd2pudVNIRHRacWJKY0k3Vm01MUN0cjRFeHlE?=
 =?utf-8?B?RDVuUFlOQ3pwNmphaGZtRFJhNWs0QktYZUtPam5uU0syWS9OSmQ1bnFwKzRV?=
 =?utf-8?B?SGl6MWVESTlIRUNjcmROYWN6Vk8wQXRLV0QrK0lHMVZ3NEcvTWRTWXBmVlIz?=
 =?utf-8?B?K3MyaVJoU0tnOC9vaWt1Rll1WkJXczkwRTJyNTd0NGhILzMyZ1g5QzhTQWVz?=
 =?utf-8?B?QWJIQmZ0dlBaT1hMdEZvV1VFaVcvQnB0NldSQ0dDUjVXU2ZBN29tTjk4ZUp0?=
 =?utf-8?B?VXkyVUw0NDEyTjd6di9TdTUwaFJoTUJ3dDdpdmxHOWk5cTJRU2ViTjJuMWtU?=
 =?utf-8?B?QW9YemU1emhTR1RSSXU1ODRHN2ZzVUNaWlpTQkZPeWJvb0IrYVhjVzBCakM5?=
 =?utf-8?B?OVFrQVVqUkJ2V3BPTFNjZjE4OXNpeWZNbk1QVFd0NUN6S2FobkFhOHhZU0R0?=
 =?utf-8?B?RFU1cGNkR21maHpUQ2wxTlJmbWNFZmdMd2lpNUxKb3lLUjBGLzMvWDJDTU45?=
 =?utf-8?B?ZGczeGEzR0NUcnFXbzU2SGRuS1pHTmlmUGJrcGJJNTZBTXQ4anJpdTNJL2NP?=
 =?utf-8?B?R0RELzZHMS94NDZPTFBmelFCOXZzSkQvSlJXWEdIc2tlazlwdUtIbVZGMVdl?=
 =?utf-8?B?SWdGYkJJM2RibHFQNnFLd2tDV05QblJFVEdLaGduK3pjMUxjVURVTS9zL29F?=
 =?utf-8?B?VndtdnFCemRueW1UaDZETTFRS1JkNm01ditQQmFBSXRHZktVZ2RUMFh6YWFO?=
 =?utf-8?B?U0dadnp4Sk5ZMzJqRkJZQ094L2lja21CMlJHWDZXODRnVmd6R0dKSm1GSEgv?=
 =?utf-8?B?djR5ZDRBNVU1UmxCanF4VG5qR2hBUkExcG5GazlXL010ODFONjdGREJobHFT?=
 =?utf-8?B?VjFDUzRCVEwvM0Q0WGw4S2lNdXBpcnFRMC9vb0JBa25US2xMOTdsVlgrQlBq?=
 =?utf-8?B?MG9QUHlVTlNxVTNEMHNTOWVFT2tYLzk3TWw3dnNqckRqcXdRMVd1anJBeThB?=
 =?utf-8?B?M29Pcm5VRWxjR1B4b0FkMlpLTDlDYXNEL0pidnZCMWczOVdNWFJTMGlzVU1S?=
 =?utf-8?B?SVh0RnhsZW1nUHIrMHY5dXhTbEF6Um9ubEc0R1R1UlNvdlRSaXE2eDh0RXZV?=
 =?utf-8?B?eUNCVXl6MFUrbGVXcjdEa1Q4WGQ4TDZoYXd1Y1RlQXllQytWMjh2MmI3N0Jp?=
 =?utf-8?B?bkhkNGxEaG9EMWVOdGhXV0V1WFFJOHF2Wlo5N1pBL05zT1hrVjZVcUw1OTRw?=
 =?utf-8?B?QU1yOVBUOVZNQ2VlMWo2b0g4elMvdFBZbUVEVG8wVFhhRGFTWEdLSVRlZlNs?=
 =?utf-8?B?Qmd3c0NVKzEwRHVDUzU4OC9kVFBseUdOVUtydDdHeVFzbHRJTXN6bStBL0lX?=
 =?utf-8?B?Y0R6bTB4ZXlkakNwY2ppdEZVOXhGelVwUnJlYTRBaXpLVVQ0c3VEV1FEVzZj?=
 =?utf-8?B?MXc1WHFkdXlBay9kbVVwd0RhZ3R2SDhHQUtOU2pLLzloc0R4NGdEQ0drSUdR?=
 =?utf-8?B?YjFReWtjNWoyNVN5czJVQ001Ri9BSTV1SmFiWTZKdGhjZWFPNXJLQnMvR3Yz?=
 =?utf-8?B?ZmVaWjZHSjhFa1BrRUpjUHhpS0NNa3o2NGk4bXE5NWtwMFI2SitHQ1lwU1VU?=
 =?utf-8?B?R0tqUENFbUFLbTg0Q0wxMEl4Nmt3ZVdWeFBPYlpPeHRXRXE1SWN6WXVJckdu?=
 =?utf-8?B?Y2dVbFU1TlpEQXBoOXFYNFlFL2F0ZE9pWEFmQ3l6YmlsY1FTSFJITjdIc0x4?=
 =?utf-8?B?TGd0QnZsYXhUSm12WmJEZTBWcEd4Z1Q5aFY3WmNlU1dzaDV0THdmYTNRUXlU?=
 =?utf-8?B?SmFjanNEclhBOVNkWE0wbEtXWUU4SC9CdDFlUnhIdm02d3poTnQ5Y0hHM3VO?=
 =?utf-8?B?M2xtK1ZTc2VneDJML3h1WnRMd0NieUlpaGNZZmpLMFRCY2F0OW0rSkZJeVVS?=
 =?utf-8?B?VjU1VjZRRXRvRnpKZmw2RWJOODdJYUIyVGlIRHJDamlhemd4L1dyMEVVTlBi?=
 =?utf-8?B?UnF5WlhlejN5RG00amNQUmR5S0h6UGJHVm5uWG9MTXJlemovMGg0aTRNRkxL?=
 =?utf-8?B?TnliR2pxdytnTDlqT1FDQW9BNy9KQ0t2bnhrMHJBeHNqL2NGdGhvU3VHK2JY?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2eb3ef-951c-4770-2ce4-08ddd21f69a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2025 23:50:51.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuWT5zC0lwjLTNAD0R9j7v2viHSrN5Sz4Ygy2jua21tn+166wWw4Yr7fJLkB+RRW+X5cyXxHpjb278Ei+Z5yVlw+u4i9arD9P41VuKQ/Mn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Fri, Aug 01, 2025 at 02:19:54PM -0700, dan.j.williams@intel.com wrote:
> 
> > On the host this establishes an SPDM session and sets up link encryption
> > (IDE) with the physical device. Leave VMs out of the picture, this
> > capability in isolation is a useful property. It addresses the similar
> > threat model that Intel Total Memory Encryption (TME) or AMD Secure
> > Memory Encryption (SME) go after, i.e. interposer on a physical link
> > capturing data in flight. 
> 
> Okay, maybe connect is not an intuitive name for opening IDE
> sessions..

Part of the rationale for a generic name is the TSM is free to assert
that the link is secure without IDE. Think integrated devices where
there is no expectation the link can be observed.

The host and guest side TSM operations are split into link/transport
security and device/state security (private MMIO/DMA) concerns
respectively. So maybe "secure_link" would be a better name for this
host-side-only operation.

> > I started this project with "all existing T=0 drivers 'just work'" as a
> > goal and a virtue. I have been begrudgingly pulled away from it from the
> > slow drip of complexity it appears to push into the PCI core.
> 
> Do you have some examples? I don't really see what complexity there is
> if the solution it simply not auto bind any drivers to TDISP capable
> devices and userspace is responsible to manually bind a driver once it
> has reached T=1.

The example I have front of mind (confirmed by 2 vendors) is deferring
the loading of guest-side device/state security capable firmware to the
guest driver when the full device is assigned. In that scenario default
device power-on firmware is capable of link/transport security, enough
to get the device assigned. Guest needs to get the device/state security
firmware loaded before TDISP state transitions are possible.

I do think RAS recovery needs it too, but like you say below that should
come with conditions.

> This seems like the minimum possible simplicitly for the kernel as
> simply everything is managed by userspace, and there is really no
> special kernel behavior beyond switching the DMA API of an unbound
> driver on the T=0/1 change.
> 
> > The concern is neither userspace nor the PCI core have everything it
> > needs to get the device to T=1. 
> 
> Disagree, I think userspace can have everything. It may need some
> per-device userspace support in difficult cases, but userspace can
> deal with it..

I do think userspace can / must deal with it. Let me come back with
actual patches and a sample test case. I see a potential path to support
the above "prep" scenario without the mess of TDISP setup drivers, or
the ugly complexity of driver toggles or a usermodehelper.

> > PCI core knows that the device is T=1 capable, but does not know how
> > to preconfigure the device-specific lock state,
> 
> Userspace can do this. Can we define exactly what is needed to do this
> "pre-configure the device specific lock state"? At the very worst, for
> the most poorly designed device, userspace would have to bind a T=0
> driver and then unbind it.
> 
> Again, I am trying to make something simple for the kernel that gets
> us to a working solution before we jump ahead to far more complex in
> the kernel models, like aware drivers that can toggle themselves
> between T=0/1.

Agree. When I talked about wishing for the simple TDISP case that is
userspace can always "just lock" and "driver bind" without needing to
worry about "prep", i.e any "prep" is always implied by "lock". That
should be the baseline.

> > Userspace might be able to bind a new driver that leaves the device in a
> > lockable state on unbind, but that is not "just works" that is,
> 
> I wouldn't have the kernel leave the device in the locked state. That
> should always be userspace. The special driver may do whatever special
> setup is needed, then unbind and leave a normal unlocked device
> "prepped" for userspace locking without doing a FLR or
> something. Realistically I expect this to be a very rare requirement,
> I think this coming up just reflects the HW immaturity of some early
> TDISP devices.
> 
> Sensible mature devices should have no need of a pre-locking step. I
> think we should design toward that goal as the stable future and only
> try to enable a hacky work around for the problematic early devices. I
> certainly am not keen on seeing significant permanent kernel
> complexity to support this device design defect.

Yeah, that is the nightmare I had last night. I completed the thought
exercise about driver toggle and said, "whoops, nope, Jason is right, we
can't design for that without leaving a permanent mess to cleanup".
The end goal needs to look like straight line typical driver probe path
for TDISP capable devices.

> > driver that expects the device arrives already running. Also, that main
> > driver needs to be careful not to trigger typically benign actions like
> > touch the command register to trip the device into ERROR state, or any
> > device-specific actions that trip ERROR state but would otherwise be
> > benign outside of TDISP."
> 
> As I said below, I disagree with this. You can't touch the *physical*
> command register but the cVM can certainly touch the *virtualized*
> command register. It up to the VMM To ensure this doesn't cause the
> device to fall out of RUN as part of virtualization.
> 
> I'd also say that the VMM should be responsible to set pBME=1 even if
> vBME=0? Shouldn't it? That simplifies even more things for the guest.

True. Although, now I am going back on my PCI core burden concern to
wonder if *it* should handle a vBME on behalf of the driver if only
because it may want to force the device out of the RUN state on driver
unbind to meet typical pci_disable_device() expectations.

Alexey had this, I thought it was burdensome, now coming around.

> > > From that principal the kernel should NOT auto probe drivers to T=0
> > > devices that can be made T=1. Userspace should handle attaching HW to
> > > such devices, and userspace can sequence whatever is required,
> > > including the attestation and verifying.
> > 
> > Agree, for PCI it would be simple to set a no-auto-probe policy for T=1
> > capable devices.
> 
> So then it is just a question of what does a userspace component need
> to do.
> 
> > I do not want to burden the PCI core with TDISP compatibility hacks and
> > workarounds if it turns out only a small handful of devices ever deploy
> > a first generation TDISP Device Security Manager (DSM). L1 aiding L2, or
> > TDISP simplicity improvements to allow the PCI core to handle this in a
> > non-broken way, are what I expect if secure device assignment takes off.
> 
> Same feeling about pre-configuration :)
> 
> > > The starting point must have the core code do this sequence
> > > for every driver. Once that is working we can talk about if other
> > > flows are needed.
> > 
> > Do you agree that "device-specific-prep+lock" is the problem to solve?
> 
> Not "the" problem, but an design issue we need to accommodate but not
> endorse.

I hear you, let me walk back from the cliff with patches.

> 
> > > But I think we can start with the idea that such RAS failures have to
> > > reload the driver too and work on improvements. Realistically few
> > > drivers have the sort of RAS features to consume this anyhow and maybe
> > > we introduce some "enhanced" driver mode to opt-into down the road.
> > 
> > Hmm, having trouble not reading that back supporting my argument above:
> > 
> > Realistically few devices support TDISP lets require enhanced drivers to
> > opt-into TDISP for the time being.
> 
> I would be comfortable if hitless RAS recovery for TDISP devices
> requires some kernel opt-in. But also I'm not sure how this should
> work from a security perspective. Should userspace also have to
> re-attest before allowing back to RUN? Clearly this is complicated.
> 
> Also, I would be comfortable to support this only for devices that do
> not require pre-configuration.

That seems reasonable. You want hitless RAS? Give us hitless init.

