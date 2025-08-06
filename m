Return-Path: <linux-pci+bounces-33491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6436B1CEB6
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF5F18A26A2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3C2E36E7;
	Wed,  6 Aug 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zyw46QWU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02234A41;
	Wed,  6 Aug 2025 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517334; cv=fail; b=FgMt9IP/ocGyxWjDSiyykcez3Ky5dh26SXY9zaL0uu3RW0CUpLCsBePHnGQUHmqHjOWn+8mLYg5ZdTBvxU4ksy4RhYH8UXdA0PlHPOSSDsmBNB/fEviHKPsEkYTZuDRrq6HO0ivcRhQF0yc1jyiyLJgXBF1yzyXBrNYWEDQ3GIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517334; c=relaxed/simple;
	bh=5qW2RK5Yo+QRtG0kDH7+5V8AP5RNG1IYxFql7/aMec8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=QjVc95jqMvD/6cXNy8WD0dWdErfLaHR1cL2aBaFv4plhRpfgEqRgeqw3h4OXFpreAHnvcEhoMe5BNNu64rQqCq3wWwtEIrXdPlPgkyIVJ/SfRTLBbikgJX5k7CogG2rgGYGNL8HAlkDrQ0fvLLWvlSq8wbv1i+n4/Dmu6Asoh7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zyw46QWU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754517332; x=1786053332;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=5qW2RK5Yo+QRtG0kDH7+5V8AP5RNG1IYxFql7/aMec8=;
  b=Zyw46QWU6Uu/HyhBc8jVCF+GZbwU+wa1jLLeptyw8olqPrAPEfOhSHDc
   iKcJcE3ww8ODpvl8EEtG8AIdwH53G+EE+6BrKu2U5T+gbFpskGe3DUM2h
   JU02XbBedQim4UabnTZ1P1pt3KB9Xjh6wyzHuKMkESxAroE998a9/kJkS
   vaToofHx0UcKVgMr1DNUwWGA5FfQryuKWM9rMdO/9MgwLzBchKhuSM3rB
   UT67rbgiPe2iOfdUdIWur+ynhWXFC2Js9eLLKXpbZM2734D77R0AHzkm5
   MrpggY1uReVU5zyZYaUndmF5ULZO+9iIRqpOjDYL7VxqTYoF/XC/zx8/k
   A==;
X-CSE-ConnectionGUID: LGV0qNaXQmSPkR5r74RNyA==
X-CSE-MsgGUID: K88f2XJ3Sn2F66nlPB66kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56712520"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56712520"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:55:31 -0700
X-CSE-ConnectionGUID: isQjHx7rT6G4A6LXcTdFsQ==
X-CSE-MsgGUID: 0nV2JfDVTjS8cdUPQINEpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164402232"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:55:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:55:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 14:55:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:55:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbviDAMkJ8jvxF0rMTejYNwimRc5dTP6ywYyWoT3WVEQ0JsW8t26fPEqluHopRhcPzP7PifBMi4LTBSv0GV/lfW8baCI13P2Mq+3EBLwRTcp4VXf7dEGvcWRtyNphG5dezDo4Fjn0LrU/cNrV2qZzZAr67+mNOA58osa9+j20KrUTorpBGheyT0pUtPD4/CUGtTBBtOLXQiELBD4vdJKbqu+FHIzn14IXhkanVsKPbJHFSCNcFAjpxBqDwfB7GrZtaZ/otEPEmL16WJyAWtPASsPuwGfvV98RhZua666RrFJXXK4yPkVdzHb8BIgEYEDWXDbUxBpg/xck8k2rxta8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHjndsWvrouYzPDvP3iUvRRfesuC4zzNSNqi7vQjE98=;
 b=H/XuyWUuK1m5HPerYuW6V3IxJW/KWjbX2AcLnY74JnV4UM7mfse6+OvZyQZTG1PqSgH+gxaZ2Z5HvuzlEBHlRdBSMgRoCsWVHVVSO7oBa9AsUtwamDJ0YnpcZFf40wXAouraoT2wNavss941LCLIulVTw0NZ4MQVh+OjXtOrY0CliT1hZUqXr0DY6vx/I19o3SN7ImkvqSOaBImuEOoAqA+ERF1d1Zcrke+ONwisZ249RWXDXdmqGIO6QzollpbDyqT55cRBHapf2F4iLa884iJiMZ+0KcVRDManLG3XXLpgIKQr1+aRy9C0Lcb38ze6iv7G43uHRAB2+EFNSa05fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 21:55:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 21:55:28 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 14:55:25 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>
Message-ID: <6893cf4d5788d_55f0910022@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729165853.00007b3d@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-10-dan.j.williams@intel.com>
 <20250729165853.00007b3d@huawei.com>
Subject: Re: [PATCH v4 09/10] PCI/TSM: Report active IDE streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4789:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9a61da-e201-4423-e8b8-08ddd533f490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDlBVE9ML2RJREdrcjBESGladVhON0h3ZE15ZzNXbTRBaXZBb3BQUGJTamJE?=
 =?utf-8?B?WGl3LzFNdlNCZ3RMZkZ0emRhTFZxS3VabzdPZ00xdUdrMklGZmNTcmF5cnBQ?=
 =?utf-8?B?OEFRTTJiY3NaOVFPRjd5UEJUSmJPeWdFYkowbnoxR3czMThVL0VpcnZuV2xN?=
 =?utf-8?B?UWgyTDFSdjk1b1l6cmlGaHJ6V2trSk1YY2ZlRzVYVmhhYkg4MC9EWko5M0hQ?=
 =?utf-8?B?RndlRUZ3OGsyakdtQWZvSEJJMlhVYUYzdEp4Y1c4U29ZaHFtRXBseGtkK3hF?=
 =?utf-8?B?Ni9ITzZtTmNWMXpycFlkbW9tdzlkUFdreUNkbWhBMG02Slk0cmRWdG85RTVL?=
 =?utf-8?B?MkFDZnd6djZSWmMwQXFKaTV4dlhEMi9WaWJlMGdweXpFZkt3M0M5bHNKMTFR?=
 =?utf-8?B?aEVIWnBwaU9SYUJlT2E1UzIzWGl1N2d0ZVBqSUdmWEZienF3MHdtdTNnakJO?=
 =?utf-8?B?Z3dkUkIvYW5LU2F1YkNNRTJpcTVNdTE5d0VDVU1sMTJ5RDZxN2RPRWhyeitT?=
 =?utf-8?B?UEthUHNBMHRUc1ZWTTYvR3J0dW8vVTFKVDhzeVZ2NEs0R2lwcW1EQk5pdEVH?=
 =?utf-8?B?ZWJJb2RNcjBxTi9zMXN1d3ZHWWJRQVRURlFDWTZyRGRQcjFsa09qZkplWHhm?=
 =?utf-8?B?MHc3T1dhSDhzcWt6aFhuWThXNnB6TnhFa2IrZS9XUko5VkVkVndicGVHNTlL?=
 =?utf-8?B?RXEzeEg1QlFVWVpYRUo3KzNTMWxTY0UxcGVCcGx5bUZtVlpKL2diTW43dVpu?=
 =?utf-8?B?TlJLdENoSDU3cmJTcjE5V1hNUVE4WDVEVE1TTzVMc1YrL3psd0xWM1c1aU1Z?=
 =?utf-8?B?YUpBc0RQdjNpUDRJdGhlcThycFVGOFN1emZzaTAvckhoWkU5MjdKUldiWGxy?=
 =?utf-8?B?TiswK2VpbTVxUjdNRWM4dnJoNi9EeE81ZU1Za0tPbHVVVEtGbFlEeXNJQnhG?=
 =?utf-8?B?YzVkdmIrVEoyQmpsQjh3bDl0VktKVHZtOG16TEhtRTZIT2dzdkZpbjZjRjVZ?=
 =?utf-8?B?Q2E5ckYwMWI4NDhBUGlYbHhJelVUVlZManBTUkZJWG05S3dYbS9KMUxub244?=
 =?utf-8?B?NDdsVVhXU0Z3SThNLzdDUnA4d0JGL2RiQkg3bGUyMHFCd2R5QU5Wd05BUHNy?=
 =?utf-8?B?dk1hZzFaWTdjSkVMZVZ0Mk9HRW85WmJyK3FydGp3YkUxQjdQMzgzZGs0bWNx?=
 =?utf-8?B?VFBRSk1ldHBkOHpmZmxZMEF3aEh4MXIycSt1NDJiRisyWHQ2d3pDNm5zYXpC?=
 =?utf-8?B?dTNQUEk3MVhubCthVTU4YzQrb0Q2Zk1wVW96aENTSFVoOUJHOEhmMnd5Qnh6?=
 =?utf-8?B?WE5aai94dlI1cnF3ZGFReW5YanNGazVuTWkwTm80STVXMWJhL1JHekdNYUVq?=
 =?utf-8?B?czlvblN0WnEzL0lYUTZXOGhsaU11RDZsdXJkUU1pNFNUUlQ1Ykl5T2dMK0JK?=
 =?utf-8?B?bmxoeGU2Q0RzbVdWN2RoWjliRldDRCtlWjhZdktCTmZqd0VvQkUycm5lcUpr?=
 =?utf-8?B?bFk1R3JFR1U2dHY2NzB3aWx5RWtzSEJ0cEN4ajR4WkNhWHlnQlNic0RMUkZN?=
 =?utf-8?B?Z2RzS2lwZUtXM3VGOEJVL0haT2F5N1U3eWVnTy9Kek9vLzNvV2NjWXh3SHN3?=
 =?utf-8?B?YmFCWnZpN1REVVJsbjc2WkVXaVpoTVVPM1VRWXJ0cVl4N0RLZDJNNXBZRCtK?=
 =?utf-8?B?NWh3UkJmcXdXTFl5NGF1TTVRYXFsK2ZOWnNtM29jb2R2ZmhxbGtzTHp1bUxj?=
 =?utf-8?B?cUNDUHAzRzVzcU16VlprM0w3eTNOblRjTXlXdEZVT05WZ0FwZGNueG9oUVNx?=
 =?utf-8?B?Uno3dHBQdlAxUkR0c2JjdFVaSU5yTUMyczZQYTR5TlFnWXJWb3RtbjBWTTJU?=
 =?utf-8?B?T0kwM3pwUlV4VnJ5MW83MXVUTVRJeHFqMGlYb0g3dDVpQm9vbHFFUUxQRk84?=
 =?utf-8?Q?IrtDbjJJAWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk04YTlvK2pvcTNPeUhpVE8waE1wYUlEV1dUOWQxMnF6RHgwMGF3ZlVrSWxn?=
 =?utf-8?B?Vks2Y0txdHBrRlpaTWVGZHM4c08vcEFneUVxa1hac0pwZk9UaFVpU1hOd3VN?=
 =?utf-8?B?VEJBOUlYcUUyOWptS2I2THFBUTR5VWF0endxMWRzNlhJLzNxdE41MzhxbVNp?=
 =?utf-8?B?Mk9uZ0lKbXhSSzdWbEhoVHUxc243VVJkZU9lMjhYNzBFZ2RJWE5GSlpRYmNx?=
 =?utf-8?B?R3MrR2tSRjh6eGJuRzNrY2htRTV0TjM3c2pvMUcxMlNoVFVrNlhrblcyKzdi?=
 =?utf-8?B?UFRnTGM1eGVmTHJhKzViMG1jS0dPaUJnMXN2TjdtVWJjRldKWTA4TVpTcnVm?=
 =?utf-8?B?M2UvNW1hRVFZaVBXSEtCSmhiTnMvQzMzRWF5RWxvQ1k2VjdnVXM3aWc5LzBi?=
 =?utf-8?B?TXBTTmJIeTJkVDNMUTZjN1J2NTN1MkY0R0hkSnAvOFBucXp5dVFtdGRLK2V6?=
 =?utf-8?B?V2doNkQyV3NNMzhORkdsUEZTSjZ3VGhFcW5Gb3V6dEdkYnhQWTVUbFBDMGhN?=
 =?utf-8?B?ME4wbDJ5RE80ZkluQ3pOWGZVQmlUaEI0cGtGUUtjUi9DQk9SRGp0WTFpODJT?=
 =?utf-8?B?dmVoNkMxRmFDb0RObTRsbm1ndEJhTkZuaE9xZlRwcTFIUWROb3pmZVRjVG93?=
 =?utf-8?B?Y3Y1N3p6b2J4eW10cWpodjF6T0VTVnREUFgzU2pDQzlsSld6ZHl5TmRYRGJG?=
 =?utf-8?B?a1dNd2Z2R2E5M0RQOHFPM0RWKzBuYllLTVRnUk5SVXE0VUZHK3VzZ0JPWnAy?=
 =?utf-8?B?UnRZem00YUdrTHlxRm94Nmg2UFA0UHlHU29zdmtYYlN6Z3d0Vmk1clBEMzZF?=
 =?utf-8?B?K2NnSVZKWTA1aTRtcUFlcnhJYjlYQ3VSMHRMWVFpQ20xU01RUWdibCtEeGZI?=
 =?utf-8?B?WFZUMUtYaXVvRlVJNVpOcXJlUktuU2NxQTRlVjZ6OStSakJiekgwQ0trSEVj?=
 =?utf-8?B?VEFUbHFRd1hjdE12RGpqd1NpTFpnQWx6cHJhTkFsRTVmOHRnTEhjWTBkNjZy?=
 =?utf-8?B?QXI2LzBCcUNqRDlOSnZIMHQvMThhdEpOV2EvY1VmV2dYM0JOZDJjc1R4V3Z6?=
 =?utf-8?B?ZUt4cDkrdE1SdWFKZmpxMHRBWnZsWGRCb3MzcFBOSWRkNnlLci9PL0FQZnk5?=
 =?utf-8?B?cUZ4SWhKa08yeEtyQUorcU5hcU5HNWlCcVlDWnRuZXBNR3lxM3g1Q0pQeUZU?=
 =?utf-8?B?ZG1LN1hRSHFRUWs4aFBXMW9iUFpEOThrTGFCcGprdzY4QVlmRHlvT3UzZk03?=
 =?utf-8?B?dU5zQ0FyVmUrcG55L1ZMTzhkMWFsSDJJZE0wR01sbmRqSmQ4OXlLZ2wwWkpE?=
 =?utf-8?B?aFNwUzlwVm1kUG5DMEx6b2MrbU1PemVoSm5QUi9qV01WQ1duc0dwV0xaUlQ4?=
 =?utf-8?B?OEMzdUFlY3I2NzcvdldwbGUxRlVwbEhzbUs2M1p3L0pNNEtHYjE0UXJGanhG?=
 =?utf-8?B?dXNWR1ZSOVZpSFQvYUZQL3hEZ1F4WHhyeHN6eXdLWFp2WFlsVTNJRU01Vmxn?=
 =?utf-8?B?cWRxNGJ2SEtKK1BYTkZTczZPVy9rMU8vbEJVNnFjMDNoWEdJVDJzYzNyRWpM?=
 =?utf-8?B?eW5YbUFsTUhtQXFXYXhKcXQyUzBTVVcwdWRXNXhtZXk0SWROQ3FFb0thbzdF?=
 =?utf-8?B?UFR4Q0M0NXBHOU9nR1RPbWM5Rk5xRkU1RWxKcWl6Y08xTURIdzYreStrYmdY?=
 =?utf-8?B?WWhQcjRUMEU4MUxDemhjdlZMR1VFcDI0aXV5ZURmcHpQOWFydEQrRWcyYU5p?=
 =?utf-8?B?M3BvaEFiL1dsYWswbGNrTDZzdSs5VldDWnRxK0xTb2ZFcjlXSVBPNUV5eU1C?=
 =?utf-8?B?VEhGR3VoeFF1MTlMSkVyTDNYd1ZQM1hoMXN1T0hhRERqakRuQ3FLaUZydzBR?=
 =?utf-8?B?a1VvNEltdjBTL01JUHd4WmozMkoxMzVCalVYOWJlU3V5c3NvQlZsNVZLb1ZF?=
 =?utf-8?B?VUxzZ3ZWcWlEV01mN1ZXTG12S1ErVnJiOGlGcFJMQUF0TWUzR3ZrTFFVRHh2?=
 =?utf-8?B?a3Qrd0dkNUhndzFhK21SWXVEN2xMcVE3dlgzaDVnU09XdlVDandZeUVrSlZi?=
 =?utf-8?B?Tm1nRlY3aXdsTVdZVnhSUFdrTUdneFJPNzJwQVpKUnVRL3R4NVZqQWhHdkpP?=
 =?utf-8?B?dXNSNktNVUJqRitqNXhzMDlzOGVhdUQ3bWpTWDBIWVpobUJ3cDVYRlkybFI5?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9a61da-e201-4423-e8b8-08ddd533f490
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:55:28.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsTQmijIxz33nd7MHDs61adCwhXihQXRihfn9vvHzRtsgaPsbDe298+tvy4QgT1EK/2HG7bmD0uyoA4/VmYi5QC06Ov3XifQlhZ8ykp0Jbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 17 Jul 2025 11:33:57 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Given that the platform TSM owns IDE Stream ID allocation, report the
> > active streams via the TSM class device. Establish a symlink from the
> > class device to the PCI endpoint device consuming the stream, named by
> > the Stream ID.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial stuff only
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
[..]
> > diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> > index 093824dc68dd..b0ef9089e0f2 100644
> > --- a/drivers/virt/coco/tsm-core.c
> > +++ b/drivers/virt/coco/tsm-core.c
> 
> > +/* must be invoked between tsm_register / tsm_unregister */
> > +int tsm_ide_stream_register(struct pci_ide *ide)
> > +{
> > +	struct pci_dev *pdev = ide->pdev;
> > +	struct pci_tsm *tsm = pdev->tsm;
> > +	struct tsm_dev *tsm_dev = tsm->ops->owner;
> > +	int rc;
> > +
> > +	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj,
> > +			       ide->name);
> 
> Fits on one line under 80 chars (just)

clang-format agrees.

> > +	if (rc == 0)
> > +		ide->tsm_dev = tsm_dev;
> 
> I'd prefer 
> 
> 	if (rc)
> 		return rc;
> 
> 	ide->tsm_dev = tsm_dev;
> 
> 	return 0;
> 
> but don't care that much.

Switched to that.

> 
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
> > +
> > +void tsm_ide_stream_unregister(struct pci_ide *ide)
> > +{
> > +	struct tsm_dev *tsm_dev = ide->tsm_dev;
> > +
> > +	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
> > +	ide->tsm_dev = NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
> 
> > diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> > index ce95589a5d5b..4eba45a754ec 100644
> > --- a/include/linux/tsm.h
> > +++ b/include/linux/tsm.h
> > @@ -120,4 +120,8 @@ const char *tsm_name(const struct tsm_dev *tsm_dev);
> >  struct tsm_dev *find_tsm_dev(int id);
> >  const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
> >  const struct attribute_group *tsm_pci_group(const struct tsm_dev *tsm_dev);
> > +struct pci_dev;
> 
> Not used.

Good catch, missed cleaning that up during development.

