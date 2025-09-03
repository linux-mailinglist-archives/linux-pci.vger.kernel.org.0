Return-Path: <linux-pci+bounces-35384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913FB42212
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 15:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D9D3A37AC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E610942;
	Wed,  3 Sep 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhPBV4dX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAD1B042E;
	Wed,  3 Sep 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906798; cv=fail; b=qgR2pV5vJarlTSecJHoarNfUT06hnDVyMdG8Hoa26EhE8qjuYNaQJuBO7i6WPdhZg0xGRv40QzO2YwR3KESy+rYB5ZQOZd1J8VzITS1h1gz67et9RGXpzXqZBltXPyr8FDZ6sxlN/UCGjfnfVAV6qWZIU4vPBCKfhUx4jl9x1dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906798; c=relaxed/simple;
	bh=q4v7rw45hgrx6U5GkVRSnDTPRwzECAuRpJjIoIBXSzk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MR+DEq6LB4ihqfhtamlINAJK3GD1LUFGVzab4ZC35k4B39882J9i3n11TaEky3gr5NGXizYIe14K/usPgFEm4LL26Dkg+K8zM7rDWPOdXqlKcOk0GChxpXNuTcI3JAmJXx5f+sbsV1e4Szwuq6wuT/RRmugOIZ+DINnnxvL71d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhPBV4dX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756906796; x=1788442796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q4v7rw45hgrx6U5GkVRSnDTPRwzECAuRpJjIoIBXSzk=;
  b=hhPBV4dXiyT7atpbYkJITI1bSZloNWN8NtVTMfoluLQ4f6Tn+QSe0aPb
   BwJETCCCSCu0ro7qXMeol4W+r65sAj4rcZSEmz/VvaLsnUP2vk0WRWl9K
   bOO8KQecOdBSbVNa5wzlLnqs6umEXcovNJ3uDsClmErhK7YyKltMAirJN
   1RyNE3HLvl4rkWjyXJfBO/yfehWZOCIfquxb/TBJAO5sUa5lZ6SFXS3uj
   C/VqKcspM7trtF/fg7I9Rt9mztbLyZ2l0sKwRAQPIC5s79IQt/zE5eClS
   baJm6lgUSgzD4dNudOuEWUfN8+Le8hs87YfzOF1gcT+4eZzTKrHUFW7z4
   A==;
X-CSE-ConnectionGUID: LocFg4hmS86z3lu0wZAmXg==
X-CSE-MsgGUID: oVclBTMxSyqDARPFZuBsSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="62861596"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="62861596"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 06:39:56 -0700
X-CSE-ConnectionGUID: LV3cW5UdStOMXd4L0aByCw==
X-CSE-MsgGUID: ap6pGCLcQnCMboJFuvxxHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="175961385"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 06:39:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 06:39:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 06:39:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 06:39:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sluEPseopw6cF/XTwepw2xwYY9j31bo3hIfb1JNfX7KA9YIZcL8WvuAZhffpYeFzWf7++Smq28S8z0H5D9BGtK85AVAi4R/LJCcBZKjudkJlJ8N50L0vyggpcpqj0O37Z2rfgD+drYCMnzc9tAQQB0NUG0Y2+GagjmDfqCo/JPqeFK7QsmOzYZZZwCJHi0Q8iJ5Ehb10jki2PUkoJlXeAGDf5UEGn0RXMeVeYcw7hcjS3WsGVKe366+qR9Qz/28AHZRpisPyoQ5xKSVkCYo8qWSZu3vuaXhjNdH4bN025KTaVqZ6KsjykUQQo+i5wCrIgmq8vFeUXdzU9K0xc64irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfL2WS4xp6Q9oxyq28nTZmRYej/bM1nRWj6a+GL61OY=;
 b=AxGS/pGArbUCAsmXI62DCPIeJGz6tfsv0piCaOtYfmUSteMSrZHuHnEPWaj8cwb6ed2DsXrvJ1zb6SIVcuKxjUwzW/vT7Cs4gzmRTauSj/8TqORj5onvzvi5t+slEinrMbHCO2t3CDNubHE7t88hB8MTHZX7/ZcWmRv2xRc1wUwLVfU3+lP1ci1WIqAWgAc6ppWhWgbUl75A9HVCPCkH1Tg7nQCVwaTlnYT31+7PAFkXJ4lxDgA6OCuKYxOHDtAfN/V7NadHfV1lwpYzXwbBdxY/zU05GBRlY22ty5du7WdDRzLHUMfnsbFpgRDVEm5AzJ1iPm0hEZEjUx8c+Nkf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by LV4PR11MB9466.namprd11.prod.outlook.com (2603:10b6:408:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 13:39:53 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 13:39:53 +0000
Message-ID: <1c71973c-a171-4d58-b985-2afe5521bdd6@intel.com>
Date: Wed, 3 Sep 2025 19:09:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,06/11] drm/xe/vrsr: Initialize VRSR feature
To: "Poosa, Karthik" <karthik.poosa@intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-7-badal.nilawar@intel.com>
 <b0092e98-4f2d-4d29-8200-ef71099786ee@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <b0092e98-4f2d-4d29-8200-ef71099786ee@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::15) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|LV4PR11MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 626b3dd2-3d7e-4d77-43dd-08ddeaef5cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEdvcFQwYXZ3R3Z5a1VEUXZjRzZpUW8zUThPY0h5cFBYZ21lZC9MTXZzaytl?=
 =?utf-8?B?TmFwdFZLUSsxTE55RUh2NXdTRHpjY2VHaGU1Vk5ZNFlHaFRFM3pMNzg5aHpO?=
 =?utf-8?B?SExNbVptQjNuSFlJbmlWYTkxWGlNWEF6R0RMV0VTbWNQQU5iWXkxOGRMQmpT?=
 =?utf-8?B?OUo2SnIzano4Q045M3kvWmNjbk0zc0hkSDZxUGIwZWxmS0pvb2w0aXhkeXJB?=
 =?utf-8?B?MWhDL3RRWHZwTUNhVTIvVFdlTy84ak14WkdBMXhmSklQbmhtc1Nzbkw1SkdK?=
 =?utf-8?B?clZzWTdJRXozUDdIMzNlSEY3a1lJUitGaklNQ3dPc294NW16bm9BUnNucStu?=
 =?utf-8?B?TlpESFMzRXlUUThjdHZFNzY1OWt2aFFMaE8vY2JnZ0t0ZzZtZElNQStNd1Vz?=
 =?utf-8?B?NzNRRHdSWDkxY29FMzBxM00wL01sL29LQXJjNlNzN2g3TEZTNWtMWkJjbTlO?=
 =?utf-8?B?cXBRem1UenVicFV3L21jallxc3h0VVIyTStaRGFYUytSVDQvRC9DcmlpLzNM?=
 =?utf-8?B?ZDJpMnNTWm9CdGhJellGSDZreXk3Rm5zQWhrNjlndUQ5Ym15STlIYkxPWlhW?=
 =?utf-8?B?TktxWUd4eVVwekd0b0xHcG1zcjJsci9CWHFTMjF6N09jVk5HZXY5emVOYW1n?=
 =?utf-8?B?TnlpNFlUZmdGVXJ0T01ERFdnMFM0S21tMHh2bmJkbnJVMmQ3elJKeE5Pdlcx?=
 =?utf-8?B?MkduT3dUUlVMYzVyNWowWGxmOVZ3TWhJeXZDMVFIQk1kbzNId2dYQSsyWHU3?=
 =?utf-8?B?c0J2ZUZ1VXZNa09tb1lWMDVPdzE3L3RST2thMFFYdmVUQWI0Q2pKRWpVR2RV?=
 =?utf-8?B?NWRRWXZlekY4L1daaEdMTjNGOHg1ZlVjMjJLNjZYMDhhUFdJRTZrRmhSYmpO?=
 =?utf-8?B?dDdNaDdzZlVVRzd1TjNDS0xmZWhVOFBvZW1BZVJNcnd0cWpvRGMrcXVQdWV2?=
 =?utf-8?B?QmZ2UmxNR0dBM2VjemllZE5JNXpHQ0YraDlEa3VUTE9XNGZtZE9rSWR3QXJU?=
 =?utf-8?B?bUhxMVByMTA5bHYrKy96RzBuVVRkOVUxMnF5SnhvVHRyZkVnM3ozZ1NHRjMw?=
 =?utf-8?B?YzE1WnI5UE1CMG1jWVZYbTJhRFhBcDU4VUlGYVVHTm41ZGNXakEydUxJRThZ?=
 =?utf-8?B?MGRJVzFoWVNiOEllOXZuVEtTc2VIdXpaSFZEQ0ZCRGY2NUYwalhiL2dtMER4?=
 =?utf-8?B?a0dwNTZXeXRDeUZKREJ1Q01pYjh2TDg3cW9uWkZvbGMwSEF4RDNHUWI0aW5M?=
 =?utf-8?B?aFdZYVFiY3lDQnhKS0loM0dPc3ZJMVZ5WjFRMkJ1S3FPUW9pRHplZWRESWlx?=
 =?utf-8?B?WUpidVMzeG9xUHlUNnlIUnFiRHc2K2lja3hERjJoT2QvOC94QmFCNHhGODV4?=
 =?utf-8?B?bnBFbzhKcVVyS0FoSFpjellmc1FnM2xsTy9jYWx3YXpnYUhkNG15MnVSOTdS?=
 =?utf-8?B?dmRuVHBEYm5MSDRGcEtxZlNTV0wyOGdJQUJpRXdkUUp6alFVYm5DWGhoV0Jt?=
 =?utf-8?B?OHNNTWcyQ2ZrUmROTWdpeEp3TlFXNU1UYjlVTW9WUzlpclBZcHJjcU1MdmFu?=
 =?utf-8?B?UzVrNWF5RTJuU0pQazRHZGN0cit4MzN5ODdnemJubTMzMnF4K0FxVUJyMjh4?=
 =?utf-8?B?OFBTRkxZNlpmVWVyb0pHcWtTcEJReVdjRi9tUjNjSDZYMHVTUm9TbTl0OFd5?=
 =?utf-8?B?TWZjc3V0VVgvaVgvMVM1WmNpVGpFU0Q2enQ0b3JKOHFnMHdGU2xGd1Z2UU5X?=
 =?utf-8?B?czUrNFMyOFY3eGMwVm80ZTczUmN4OHpzQTVyeW44YWdJbDV2ZmI3dzdZL29F?=
 =?utf-8?B?dWQ5bUVOVnZoM0xGNVBLQnVFNmhhYjAycVNFdjRxK0tMY1Y2S2xSeng0R01w?=
 =?utf-8?B?YnMxWXRrN05KLzZTdmNxbHV0MDJPR0M0T2t6UEovOHZiY1RoZFBtZnpHN28z?=
 =?utf-8?Q?YdmVi8rTNl4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lnVHJBVE01eHNIUlhEVmdWdFNIMktjVlZJQmlrREE1MmdYZXQvK21VTGUw?=
 =?utf-8?B?ajVJM1JaWTVDQ0g4ZkdGUk9ZaUp5UEE4ZE5RbGZYY2dab1U3NXNIbmlwTVNw?=
 =?utf-8?B?REk1NTF1T1JrZ2hMODh0dkFTeU1oRWFMWEsxREl5QkFmSTN4SlRSTWVvcWhT?=
 =?utf-8?B?M3hxMEVGZW1DRHo2aHUvbkloMUw3L2hKWE9lY3NLWW5sQWQ3NmlJOUQ3QVpB?=
 =?utf-8?B?aTJaSTJsVkVkTlJ3QjJnN1JjTkpJcDdOSnZjWHlhaGQ4OGgwaE5MOEs4S0pj?=
 =?utf-8?B?R2lQZkM4VSszNDVKQlhHYzRFVWlrUDFRbk1UYjBIVWtLeVFYK1FsMUlabDcy?=
 =?utf-8?B?ZmtGbWhRSHdkRzV1bEc5aTJPTGFJQkF2bjl1djlNNUhiZDFIWW1rK2NXMnFk?=
 =?utf-8?B?QmNlaWRIOG04TVArVHRwRkpXWGJ2WGUzaUorNysyK0dqdFRIZjZQVTJNMDhG?=
 =?utf-8?B?T0FMN0puMGlyZ0lQUm43VS9WUnNSRDQ4cTRPbVpnSGZRWHJjWUlyUUpoTWlm?=
 =?utf-8?B?TlZCcGQvdFdEa2pvZTNubnE0M1F1ZEYrV0t1RGhSazg4L0NvN1lSK2s0UUZt?=
 =?utf-8?B?Ly9zV20xcCtyUG1NT2lzbXFHd0ZsZG5MYjhER1ovMjFCNDk3UGtQQW5HYVVK?=
 =?utf-8?B?WjhUWCtLU1BzeHd5OFdDNVpMYU1HRVIvcUZ2UVhVcUZBeFBwVU1taHVpSlZo?=
 =?utf-8?B?OTIydHpqTEVRbmkvM2pzeW16R3lyRlgvVzZnSnByRXA4Q0VQcEVoYXpqdGVZ?=
 =?utf-8?B?aXVOcWI0YkQwTDBlV2loRm9nVVhheTJRTVk3U3AyNE9wS1d1OFdVMDcrdm04?=
 =?utf-8?B?QnRlalZSZEQraFRQaFFCcDRYcVRZa0M4cmVGMkZjRUIrVUlJZEI0Y2FNZUpn?=
 =?utf-8?B?bWdXb2VBMXJ3S21YRHBXTHNpYmI2T2MrZGhLNVNjUGZFeDFldU9mdEF5Qjl3?=
 =?utf-8?B?SnR2Rm5PaVY0dGQvNHJyLzlHeXpWTk0yK3U3TnlPN3o1a1BKK1p6Nzd1QnFV?=
 =?utf-8?B?WVZwYkd5MXV4Z1FlcFhrWmpVSTMxVGVWc256TzZ4bnlZbGZHdlhZd2lYWk9J?=
 =?utf-8?B?QTByQ3dxbDhVVmEwTlhYNWVGOVhqMFkrTjk0L2g0a290UHdYeUI1ZitaN0ZG?=
 =?utf-8?B?OVFxUGpnRmQ1WHVXYVc4a21pOVRSQWxuMTZiTWtmc295N3gyYXdSM0xnK1Zw?=
 =?utf-8?B?d28rK1pnT085c0NncHV5bEJnbHMzd2VWYmg5c2grd3c3VVAvUWcxL0prTksr?=
 =?utf-8?B?VUNTbmZ5b04xUEFXMjZ5SEZnYzVKSzc0U1dKekozOWs5YXhMZHBjNGFRdGdW?=
 =?utf-8?B?U0ZPdmpMQmUzbHZFWlF1N1I4Sk9BSGp0ZG1HTTUvanRCMFJkVGNKM0ZwTW9V?=
 =?utf-8?B?TFNENTlVZFZ6a0kzOURPQUxvenZGVFRwWVFzbDZESFoxRlBWU2RFbFZMWlVv?=
 =?utf-8?B?VDhWY3FaSVVPT2V1M3NxWWZRcWg3Szl0OHlyU0VuMUhGb1NvK1lTSExlY2ll?=
 =?utf-8?B?Y1MvREZKaWJMdVVMS2lvenlpOUI5eTdhM2RrQ2dBdktDN1M4dEU3SnV4cVdw?=
 =?utf-8?B?TDNOcHpFV1MyTUxpSzRySFI3UGpSWlhiaHFmS1lLa2Q5L05zUExnazJTbDNt?=
 =?utf-8?B?RlFRRlRKakJUVUJjU3BzN3l0S0FudTI5ck1TMHloM21KZUE2RWh2SzdVUkdr?=
 =?utf-8?B?QVJGR1h5OUtnajZaV042c1dQaXpzWVd3alVkaS9ZcGwzTnA0NExNZUNuK2Vu?=
 =?utf-8?B?SG9MNXhqZmJFWnVjY0pyUGN2N3Y3T3dTakNMMFl2ZEZLejdsSU16Nkx4ZFkw?=
 =?utf-8?B?aWNGTy81VVgvcnZLbmZ2Q21IcE9ObFZNY0hLcmtZT2REYmZzY240dGtzT3dV?=
 =?utf-8?B?dGhZZE4vUjJRd1g4QkRtS0RMUlNEbTJieXl5S0pzS2pUK1Rkck1MMldST3VJ?=
 =?utf-8?B?em9oVHl3eWt2N3VPRldPUkJ2c3JZSG5nOG1VdENYbGVGZTlIUFFpc1o4Zmhl?=
 =?utf-8?B?VFVkZ3lZVS9BZGFBUng3MlBKTkd6MThjazE0NUtKenZ1alo3NXhwb2tJYlkw?=
 =?utf-8?B?R2I0NkN5OFR6NDY1My93bU8xb0M1V29yL0JoRkpkMjVVUXVPVkc2N3piMk10?=
 =?utf-8?B?U2p3dGoxTHpIcEtzNCtadXppR0x2clJMU0hOd3B0UTc2eFVka1FYUGxDMmNO?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 626b3dd2-3d7e-4d77-43dd-08ddeaef5cc9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:39:53.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzaiearpKWedv70ZfNcxH0vETxmngL/e6P/9p6+M7Mxj1Iv/B24FnNgiBHPv6Pa69G9+m0NzO5fYkn4CXHRiUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9466
X-OriginatorOrg: intel.com


On 24-06-2025 15:58, Poosa, Karthik wrote:
>
> On 29-05-2025 16:46, Badal Nilawar wrote:
>> Add the API xe_pm_vrsr_enable to initialize the VRSR feature,
>> requesting AUX power limit and PERST# assertion delay.
>>
>> V2: Add retry mechanism while requesting AUX power limit
>>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_device_types.h |   1 +
>>   drivers/gpu/drm/xe/xe_pcode_api.h    |   7 ++
>>   drivers/gpu/drm/xe/xe_pm.c           | 105 ++++++++++++++++++++++++++-
>>   drivers/gpu/drm/xe/xe_pm.h           |   1 +
>>   4 files changed, 113 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device_types.h 
>> b/drivers/gpu/drm/xe/xe_device_types.h
>> index 3a15b3a252fd..5f9a1a358468 100644
>> --- a/drivers/gpu/drm/xe/xe_device_types.h
>> +++ b/drivers/gpu/drm/xe/xe_device_types.h
>> @@ -7,6 +7,7 @@
>>   #define _XE_DEVICE_TYPES_H_
>>     #include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
>>     #include <drm/drm_device.h>
>>   #include <drm/drm_file.h>
>> diff --git a/drivers/gpu/drm/xe/xe_pcode_api.h 
>> b/drivers/gpu/drm/xe/xe_pcode_api.h
>> index 127d4d26c4cf..f54ef03799d4 100644
>> --- a/drivers/gpu/drm/xe/xe_pcode_api.h
>> +++ b/drivers/gpu/drm/xe/xe_pcode_api.h
>> @@ -43,6 +43,13 @@
>>   #define        POWER_SETUP_I1_SHIFT        6    /* 10.6 fixed point 
>> format */
>>   #define        POWER_SETUP_I1_DATA_MASK        REG_GENMASK(15, 0)
>>   +#define      PCODE_D3_VRAM_SELF_REFRESH    0x71
>> +#define        PCODE_D3_VRSR_SC_DISABLE    0x0
>> +#define        PCODE_D3_VRSR_SC_ENABLE    0x1
>> +#define     PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY    0x2
>> +#define        POWER_D3_VRSR_PERST_MASK    REG_GENMASK(31, 16)
>> +#define        POWER_D3_VRSR_AUX_PL_MASK    REG_GENMASK(15, 0)
>> +
>>   #define   PCODE_FREQUENCY_CONFIG        0x6e
>>   /* Frequency Config Sub Commands (param1) */
>>   #define     PCODE_MBOX_FC_SC_READ_FUSED_P0    0x0
>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>> index c9395e62d21d..278f2eeeaab6 100644
>> --- a/drivers/gpu/drm/xe/xe_pm.c
>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>> @@ -5,6 +5,7 @@
>>     #include "xe_pm.h"
>>   +#include <linux/delay.h>
>>   #include <linux/fault-inject.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/suspend.h>
>> @@ -23,6 +24,7 @@
>>   #include "xe_guc.h"
>>   #include "xe_irq.h"
>>   #include "xe_mmio.h"
>> +#include "xe_pcode_api.h"
>>   #include "xe_pcode.h"
>>   #include "xe_pxp.h"
>>   #include "xe_trace.h"
>> @@ -260,6 +262,107 @@ static bool xe_pm_vrsr_capable(struct xe_device 
>> *xe)
>>       return val & VRAM_SR_SUPPORTED;
>>   }
>>   +static int pci_acpi_aux_power_setup(struct xe_device *xe)
>> +{
>> +    struct xe_tile *root_tile = xe_device_get_root_tile(xe);
>> +    struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>> +    struct pci_dev *root_pdev;
>> +    int ret;
>> +    u32 uval;
>> +    u32 aux_pwr_limit;
>> +    u32 retry_interval;
>> +    u32 perst_delay;
>> +
>> +    root_pdev = pcie_find_root_port(pdev);
>> +    if (!root_pdev)
>> +        return -EINVAL;
>> +
>> +    ret = xe_pcode_read(root_tile, 
>> PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
>> +                PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY, 0),
>> +                &uval, NULL);
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    aux_pwr_limit = REG_FIELD_GET(POWER_D3_VRSR_AUX_PL_MASK, uval);
>> +    perst_delay = REG_FIELD_GET(POWER_D3_VRSR_PERST_MASK, uval);
>> +
>> +    drm_dbg(&xe->drm, "Aux Power limit = %d mW\n", aux_pwr_limit);
>> +    drm_dbg(&xe->drm, "PERST# Assertion delay = %d microseconds\n", 
>> perst_delay);
>> +
>> +retry:
>> +    ret = pci_acpi_request_d3cold_aux_power(root_pdev, 
>> aux_pwr_limit, &retry_interval);
>> +
>> +    if (ret == -EAGAIN) {
>> +        drm_warn(&xe->drm, "D3cold Aux Power request needs retry 
>> interval: %d seconds\n",
>> +             retry_interval);
>> +        msleep(retry_interval * 1000);
>> +        goto retry;
> Instead of indefinite retry, can you retries with count, ~3 times, 
> after which we can return failure.

Retry count is not needed because as per PCI firmware specifications, 
section 4.6.10 Rev 3.3. Firmware is not permitted to return a value
in this range more than once for each _DSM instance (located within the 
ACPI namespace of a single downstream port DeviceObject),
unless there is a subsequent invocation of this function before the 
previously returned retry interval has expired.

>> +    }
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = pci_acpi_add_perst_assertion_delay(root_pdev, perst_delay);
>> +
>> +    return ret;
>> +}
>> +
>> +static void xe_pm_vrsr_init(struct xe_device *xe)
>> +{
>> +    int ret;
>> +
>> +    /* Check if platform support D3Cold VRSR */
>
> This can be rephrased to, "Check if Xe should support VRSR for the 
> platform."

Here with has_vrsr we are checking if DGFX platform support VRSR or not. 
If supported, VRSR will be enabled in Xe kmd.
I think let's keep the comment as it is.

>
>> +    if (!xe->info.has_vrsr)
>
>> +        return;
>> +
> Can you add a comment here also, viz "Check if GPU firmware supports 
> VRSR" 
Sure, I will add.
>> +    if (!xe_pm_vrsr_capable(xe))
>> +        return;
>> +
>> +    /*
>> +     * If the VRSR initialization fails, the device will proceed 
>> with the regular
>> +     * D3Cold flow
>> +     */
>> +    ret = pci_acpi_aux_power_setup(xe);
>> +    if (ret) {
>> +        drm_info(&xe->drm, "VRSR capable: No\n");
>> +        return;
>> +    }
>> +
>> +    xe->d3cold.vrsr_capable = true;
>> +    drm_info(&xe->drm, "VRSR capable: Yes\n");
>> +}
>> +
>> +/**
>> + * xe_pm_vrsr_enable - Enable VRAM self refresh
>
> as this function does both enable & disable VRSR, this can be renamed 
> to xe_pm_set_vrsr(xe, flag)

IMO, _vrsr_enable() is a more suitable name than _set_vrsr. Since the 
subsequent patches don't involve disabling VRSR, I can remove the flag 
and retain only the code for enabling it.
Note that VRSR is internally disabled by pcode upon exiting D3Cold. 
Therefore, in subsequent patches, VRSR is re-enabled each time before 
entering D3Cold.

Thanks,
Badal

>> + * @xe: The xe device.
>> + * @enable: true: Enable, false: Disable
>> + *
>> + * This function enables the VRSR feature in D3Cold path.
>> + *
>> + * Return: It returns 0 on success and errno on failure.
>> + */
>> +int xe_pm_vrsr_enable(struct xe_device *xe, bool enable)
>> +{
>> +    struct xe_tile *root_tile = xe_device_get_root_tile(xe);
>> +    int ret;
>> +    u32 uval = 0;
>> +
>> +    if (!xe->d3cold.vrsr_capable)
>> +        return -ENXIO;
>> +
>> +    drm_dbg(&xe->drm, "%s VRSR\n", enable ? "Enabling" : "Disabling");
>> +
>> +    if (enable)
>> +        ret = xe_pcode_write(root_tile, 
>> PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
>> +                     PCODE_D3_VRSR_SC_ENABLE, 0), uval);
>> +    else
>> +        ret = xe_pcode_write(root_tile, 
>> PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
>> +                     PCODE_D3_VRSR_SC_DISABLE, 0), uval);
>> +
>> +    return ret;
>> +}
>> +
>>   static void xe_pm_runtime_init(struct xe_device *xe)
>>   {
>>       struct device *dev = xe->drm.dev;
>> @@ -374,7 +477,7 @@ int xe_pm_init(struct xe_device *xe)
>>           err = xe_pm_set_vram_threshold(xe, vram_threshold);
>>           if (err)
>>               goto err_unregister;
>> -        xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
>> +        xe_pm_vrsr_init(xe);
>>       }
>>         xe_pm_runtime_init(xe);
>> diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
>> index 59678b310e55..ba550281b130 100644
>> --- a/drivers/gpu/drm/xe/xe_pm.h
>> +++ b/drivers/gpu/drm/xe/xe_pm.h
>> @@ -35,4 +35,5 @@ bool xe_rpm_reclaim_safe(const struct xe_device *xe);
>>   struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
>>   int xe_pm_module_init(void);
>>   +int xe_pm_vrsr_enable(struct xe_device *xe, bool enable);
>>   #endif

