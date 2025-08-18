Return-Path: <linux-pci+bounces-34226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0AB2B338
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 23:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AE91B62512
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 21:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2518E25DCE5;
	Mon, 18 Aug 2025 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7KTK0hk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5C254849;
	Mon, 18 Aug 2025 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551337; cv=fail; b=boNPCLy7DsYyyshZGdwzsgFBv3Yai6YRCRc+SqtLiaPkFh5lzfNjpuGu54vsTnifv1TghJ04dbWWWX2Z0JCp3mtDpymGtT958xRsbp+mMd6vr5HIyKzxdamELEtMW2ETkCC9LW9QAuga+RnNLWQ6Ou+qSv81CAAc5ms25C9Gt4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551337; c=relaxed/simple;
	bh=bCUm7pn6uBZuUNosE4UcgsblJBGfxjK8T454+YtCYFU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=q7D67y6/ZmEydDfjGaXDisaFqPm3uyiMA/0lzoEXeU9+gHQnuqshsgc+CJzpbJr8dHArTB4X1DZMLSOSszbwNWVfNbFdk1Js8gwnLfirfWUQbYXQMnv0pmFv62Du7spiniZWiv42oQxSWvXzZjmRXW4xaRAP6M7YRvD2QWlzt2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7KTK0hk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755551336; x=1787087336;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bCUm7pn6uBZuUNosE4UcgsblJBGfxjK8T454+YtCYFU=;
  b=Z7KTK0hky9okvXrSbouGYDVJLoL5EE97bj8H8QrNYdo9w6DCwGSHMM8T
   qT4EViwpepVB8VnRoTLweRQOa3d5CTD68+TFbaxTzHiSQIgvE/D92gW0l
   4F0PZYYuA7vVMH2lPUN8gH0f/hldR8k86tovXCF1wzUnE+YBicSvPmdcg
   Mguy4y7moVOrh/ferxdpo5KMRUhXJh77X9ULrMlENS7m8ciihGG1SGIU9
   HIkl5lARGxKiWqhhRjkcHrre3sBMurVV8/jaBf6VnP1YQbUxzzlgAPsSA
   84beudqbpEb6q8Y+9bALQRGlVMPntiJtmpaENKBAyCPk9ImeW6gQOWgm9
   Q==;
X-CSE-ConnectionGUID: Wlz5CtblSkCEQprYE41Nvg==
X-CSE-MsgGUID: QNN2hauNROWx0IjaJa1ArA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57892659"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57892659"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 14:08:55 -0700
X-CSE-ConnectionGUID: FD0wm6LkS6KQLKnY5lFlcQ==
X-CSE-MsgGUID: yJprPCHwTlenIaG4hG5+zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167627423"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 14:08:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 14:08:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 14:08:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.84)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 14:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv67jVeKbFWIBLV4ZeiEU8F5NvnaBvq5Jryep+NvoxRfjjo3/uGl3s5vz6DFl/ddQvjM241JNM5tD91KoY9O4S/wq/pW4fxkLshdQfAVUJBmDmV/ncsc0GluH8AbWYIPo/olXM3GcgkXgD2wMji2Xoy18KsV3623Y+x2rgms2+Zwt5ESu8gyhDj75/9T+RRLlRFPPqnijwZ/y5vHiLlwiy5cnPlROQGGMPCWR6CvlNEk7FjIX/7rcc1mYTW+MFseINibQnVzoHya4vM2bwwJp2yQF1UUoyU05ldIvBdf+EULs681aYNwPRZos2CWPCgajcNkr5OjBHl4/+9CuzYQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVdUd6yU7hCXGxkPyce3e8gqgw4tlcspmef+iLwYbb0=;
 b=qZOYVakxCCFYPZr9HyzOUowsv2yJar+kcntZLh0vMaIISZvIKzkhJaUFkJDOhr/ePX+fKaHCHO7gIEtpRFTRSisyzAFNMZM+E4qKQn5gQhTPZpEEH1FFAqy0NRJYqdUuGs0If9gZpoyBa4f+G2MtbDHofJtOb/zj78pNYCLiPH3/2WLg+NUKz4c1LQj843t+aI3w/UJCf6bH15HGqa7rtmsqUVgLEKTGCMgSdkElEhf6mcQE32DLAyEiSyrPlRMCHYbVmW0gWsz9ZJcC5k2DADUvmgeedxkCM9q8y0HjazBVO+ittHlJHZ4KbNfkhHpu5OONP0wcSiOtCFh1lD0VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 21:08:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 21:08:48 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 18 Aug 2025 14:08:46 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <68a3965e9d678_50ce100b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <be66626f-a871-495c-b7fa-42cd3f497245@amd.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
 <7b6782da-1318-4dab-8230-e59a729f8f11@amd.com>
 <689d3e97760ba_27091004f@dwillia2-xfh.jf.intel.com.notmuch>
 <be66626f-a871-495c-b7fa-42cd3f497245@amd.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: f26021f6-0947-41e7-b0a3-08ddde9b6cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXZ1N2FLS2ZhbmpoZGl4cjd1c2gvc20wTWc2ZTJzSkVPTXZseC9RQWR3NGRG?=
 =?utf-8?B?TG9KR1lhVXBPYTBFSU9CMjBZMHZKVlVIRzVHSUZxUWtrT1dXalVKOTUySVlu?=
 =?utf-8?B?bGRJUW5vZ0RGNnYwZ05OVE9wSXJBOVlWTTVKVko5L1loalA3VFhGZnlabk8z?=
 =?utf-8?B?b2FsdWg3OWxsYng2NU53UGZ6TzlNbkw2Smhva1RFbXM2dlUzUmRSWE55Zkp0?=
 =?utf-8?B?NVJjVkY2Rk9EMm5vUDE1VUJQM3d6cHhXOVljQW4xRzZCZWJFd0dsNlpzRDYx?=
 =?utf-8?B?ZVBUOU40TkdyTjRXak9Ib0ZFamZ4NFUwSGhuTkdFamhrREdKTFdCWld6TEk4?=
 =?utf-8?B?YU80TXRjMFFsdXliQ2JKdi9tWnphYkYvWGQ0YS9GN3ZPUkNhYWN0R3pad3JL?=
 =?utf-8?B?SHNCamlIOGExN1NHdmcrdVBpbnI2Vm5iYUtaMk1NNUhnR0d1b2Z1Q3dEZDE3?=
 =?utf-8?B?NkxnMXJOY2pjcW54UkY1eWIrYlNpand1SGhGZnRwSmUvRGsyTnRHM0FrSkZq?=
 =?utf-8?B?MXNjRzhpWVlMWnFKeWVRQm9jYmZ2TStwR2ZyS0IwRTBFRS9CWmg0bmxiWnZO?=
 =?utf-8?B?VGJwUTlXR3FKeWNHblA3L0IvT1d0d3VEU0QvQ2JkY1RHOXBzY2ltcU9qb0gw?=
 =?utf-8?B?cDl2cm9abFNUZWhRczlBZDVacEVMUFlyT1RUUGYrSmVZL0VpU3NNVlZkdW1M?=
 =?utf-8?B?RGxCRUZobTBaeUo2WHVOZXhmME1kWGlqaUtoNVFGK2RzWE82d2c0anAvRjhK?=
 =?utf-8?B?d1IreVcvMGVhWE0zQ1ZSOWxDbEFJZ0tSMTNRUGhwMTZEK3FpblNXbTlQQ2JV?=
 =?utf-8?B?UXc0NURXNUVkWVFyUlN1RjRSNm1HZXhhRWVYK2RlTmlhWkVXM1Vyd0JpaXlj?=
 =?utf-8?B?a2lQdXBmNHJvZ0RnT2h2bFhZN3JTWFBFM2x4Yk50NEJRWGE4S3pWZkpPaC9m?=
 =?utf-8?B?dGJHTmdCUTcyQ0QrSmRwMHE4TkU4VlNHSGxGNEIzcDQvcEdYa1l0VFFON3lE?=
 =?utf-8?B?L0o2dHNPdlRKU3RUdjJuc2JzQmQ5SEV2OHl4eWtHMXZhTkZXTlpVK2xOM3lo?=
 =?utf-8?B?cnE5bmlscUIrSGM4Ym41UEdXa0QwQ0krQ3daczBqODBLZzN3SmhPOStSaElw?=
 =?utf-8?B?YkZTWFg2UDJoc0tmOWwvNkJGTCt4ZFVZekRRVCtTd2Izc1N5d21BMno0NjFH?=
 =?utf-8?B?SWdGbjVrZzBTNEdlQ2NRYStpTnB4Sk4wVDdIdFprSGRubXJDdjg3eGtGQnNH?=
 =?utf-8?B?QmRxT1k0NVBUdnV0T1VMeHZhOC9uWTBBeW1UREVtZ1N4YmZydzV3cGJ2Zi9B?=
 =?utf-8?B?ejg3YjNvNlRUSXNLWU9aOXF5TWpRa2N2MkJQcnR2VnR2cWJVZXRlT1hsK2pa?=
 =?utf-8?B?WVd0aXBsdG94UkdqMjZGY244Y1JURjFXdDEyOFg5MCtKZU9SRVZ6eEo5NTI3?=
 =?utf-8?B?UWlQSGgyZXhEbXphTEhnT2JUbEVFb3JrYUtjNWxWTHNmLzQ5eG5kT2VCdnM5?=
 =?utf-8?B?MUFHYTNiYUVza1FlTnl3MDRITSs4QVZ4ZXc4cjNVSHdSNkFVc1BhRGtvOWdy?=
 =?utf-8?B?Ujh6TytGOWxpNVBLSWF5cE95MENPYy9tcm53cFZKdksrdjRJQ0tqbVcxbUFm?=
 =?utf-8?B?VWJvUlJjSXBMS2RwK3pwMURCZG5WdnUxTk1KV2lpSTEzVEp3eGhvUjNQa0tk?=
 =?utf-8?B?c3RHT2dwSHRzRkw1ZXNTNFB4NUsvWkZLZlNMbk4wcEtrNzE2ZktCNVBrZkUx?=
 =?utf-8?B?dFpKUUZ3OHhCZmVyWFpNQTV0M1hzSi9EeHpkdmtwZVBqNFB4eThxdk9ZSDYy?=
 =?utf-8?B?a3dDbmRjYm9vOEl4V1lDK0RIb01pdUs1WExXVVNDaXZpRStTTVkyWEE0eTRv?=
 =?utf-8?B?N3ZOaDU0RlFBK0JlY2szbEczZ0Uvd0UvOXRJQWIwb3FsZDhwMksyME1va0dJ?=
 =?utf-8?Q?LgFHn0alnow=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhwZG96dkFmV3pKYzJlU1ZJQVl2aFJYS09JWk43ZUZsTjFPZnVUSnd2QTFH?=
 =?utf-8?B?ZVI4VGFkVU1QdmpQczFOeVl2WVFsd1ZaZ015UXFVcUxTQjJGRlB1RytUVzBK?=
 =?utf-8?B?NGVaTHJhdGNNMWw2OUpMeUE1Ky80OThtRkpPV3ZmNG9LZjhUa050MHdORkoy?=
 =?utf-8?B?MFlHSGZTV0IzQW9GMGg1M3RJVWRub0RMRHFzdm9KY3BxL1pYSjFHQVRDcnJM?=
 =?utf-8?B?OEx6VllhREkwNk1EUHM5Q2IzVkhidzBKUVNmaXZXbzBldVorTzYxQWdWaVRT?=
 =?utf-8?B?Mi9zdGg2cEc4clNDVGFCcFBYME9GakhFbG9SVVBXQVZFYktrVEgwNWlzVW1q?=
 =?utf-8?B?ZVZMbWtxeUxrL0lJUmZlalFTU0pOOWtNdDFwTDFXMWY2KzRiTXp2Y21Qakxs?=
 =?utf-8?B?cmxCOVlVWUozcmJ5a0FPS0RLQnl5MWs1ZWJ1THdCN0lkVFZESzJHbUpRUlVL?=
 =?utf-8?B?RllKN0lwZDZaU2JGUU5sdGFyTU5sSzMwY1FxcWFnUzNFalZvM1ZWekRNaThh?=
 =?utf-8?B?UG12TjdjQ3ZPZzJDalBqRWNlc3oyMXgxL0p5Z2dPeEZSY3ZyVjg4ZUc2ME9i?=
 =?utf-8?B?cW9ya2lCbjJyUkxXd0UxRlFjcG15MkJ6Nlo4RDVkcXlhUnZVaUkwNDdyY1E3?=
 =?utf-8?B?MGNXMVpFSnhEYXl1M3psOStsN2FrckJjUTc2WmxGV0hxdXhqMkRTUm1lWURx?=
 =?utf-8?B?cGZEeXE1eWRXNHBCQi9zbldhM2x4Yk9RaDZhK1poOEY1VzBqbnZGaVdTS1Iw?=
 =?utf-8?B?M3pnaWo3VFVnYkprdDNxajJxWXM2Vlh5bXJYZGV0TlhEeWxxUzZzd2lmK0RJ?=
 =?utf-8?B?TG1sUTBQdjhkVURQUU1VWnJ6TjBVVm91TFozWFJyQU9Fb1JjTWlxQk9Qc00v?=
 =?utf-8?B?R1NVVDNwTUN3LzJKRlo2b3RoQi9WMVN3MUk3M054Y1J0VEJOSkxlWTllSmpN?=
 =?utf-8?B?eHRsc3JwZ0dZOFJnT1JZaENuSzdGT0oxSkNabjhtcU41cTlHeldjK1kweENq?=
 =?utf-8?B?dEhQWktpWXJkL2ZBSnN5OXNoMExLa0hpa0duWmxvUk8vSWRpQVlNcUQwVWZZ?=
 =?utf-8?B?bVBWYmYrUG1QWG9QOWxXVUhaQm8xMVhuZHpNQXBQVmV3dTRVdlJTd0ZaUUlz?=
 =?utf-8?B?azk5K05vdEFFN0M3NTJwZk0wc1BCYkVnalg4SGpCcjgzWEp3TFArVXpuUHZx?=
 =?utf-8?B?Wlk3WU9iRjJ5d20rNkhqZGJ2WjUxbDBGbjRrNGg1cGFLa29kWUpHZFV2dkkx?=
 =?utf-8?B?NFcvSlY3ZnRoc24wUzJ1QUVvZTRTSEZvT2J0eFY5dVhaRmNGbUprY3NOWU8w?=
 =?utf-8?B?UytRWU9vd1FITWIzRFdhTHE5K01rekw3MkxqWDhXSDVOWEVIejY2bEhHMldp?=
 =?utf-8?B?TCtjdFYrbXQzS2lkVm5aUDM0ZlZ2VTU0YkxqaTlEK01SS09URHNxZjRlQm5T?=
 =?utf-8?B?QXlYemhIRUVySnowcFhWQ3VWMVZlaG4vc2ZkZjdtaGNqMDhGNEF3QVh0R215?=
 =?utf-8?B?cU1FZW5zL21BWFdkVFVOZDA3VFd4NGV6WFhKRVZhdklYZzBySHJQNzg1dFdS?=
 =?utf-8?B?cEc1NEVqbGtlakJRcjFTZ0s2ek91NWJ4eXRhV0ZZTGlVaDB6U1B2ME8ycStF?=
 =?utf-8?B?eFNHNGdCS3gxakdNeDNsenovZzFiWTM3ZndvWmtOb296TXR6UlRhanVVcVdH?=
 =?utf-8?B?ZktGYXhaUXVvQkRuajRodHVSK3ErSVZka096bG5id1Y0S3RjOXBNR3RaRjNY?=
 =?utf-8?B?bjY5L3VPaDZ1K3gwK2gvSXBBQkhveTJhamlrdXA0cE81R0U5bjB6YkdTSnc0?=
 =?utf-8?B?RmYxU2FzUTVZUmt6SzljdjN0U0lHQWcwOUVkUHV5N1UwaUI2R1ZhV25YZ1JV?=
 =?utf-8?B?eE91NFdZcHFKdmdiOStvQUU3UlNUb0p0OE40OTJpdXVqaG4wcHBvRzJTdHFh?=
 =?utf-8?B?Z2E4U1F2elRGUzRITGtldGt1cHBEN1NrR29sMGlueFFoVW1GVGkyWWRmYjhn?=
 =?utf-8?B?anovZlU3M0RzTWd0SUZyazYwaHY5bCtpWk03VDNmWHhXUEdGbVdrVVZ1bjBI?=
 =?utf-8?B?c091WWpxSElGSzE0V2h1OTR4VlZYalFUakNyVyt1Z2prSzNRY3NxVkxoVFJ4?=
 =?utf-8?B?WmphcEVmUzNRRURWRGd0bnh1eVg4bGFMYncrMFhDdnhENjdmZ1RPNnhJei93?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f26021f6-0947-41e7-b0a3-08ddde9b6cd3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 21:08:48.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8evK+Cz2uRf12AZ1VoLo3tBC3wnP0ql1diy7G9LD28rALg1ggbRb0RhkD5quCzEcXA4Hx5PiPASKFmwuiKP8UGme2keUT1M+4+MnaN8Uymc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 14/8/25 11:40, dan.j.williams@intel.com wrote:
> > Alexey Kardashevskiy wrote:
> >> On 18/7/25 04:33, Dan Williams wrote:
> > [..]
> >>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> >>> new file mode 100644
> >>> index 000000000000..0784cc436dd3
> >>> --- /dev/null
> >>> +++ b/drivers/pci/tsm.c
> > [..]
> >>> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> >>> +			     const char *buf, size_t len)
> >>> +{
> >>> +	struct pci_dev *pdev = to_pci_dev(dev);
> >>> +	const struct pci_tsm_ops *ops;
> >>> +	struct tsm_dev *tsm_dev;
> >>> +	int rc, id;
> >>> +
> >>> +	rc = sscanf(buf, "tsm%d\n", &id);
> >>
> >> Why is id needed here? Are there going to be multiple DSMs per a PCI
> >> device?
> > 
> > The implementation allows for multiple TSMs per platform [1], and you
> > acknowledged this earlier [2] (at least the "no globals" bit).
> > 
> > [1]: http://lore.kernel.org/683f9e141f1b1_1626e1009@dwillia2-xfh.jf.intel.com.notmuch
> 
> Right but I'd think that devices (or, more precisely, PCIe slots) are
> statically assigned to TSMs. A bit hard to imagine 2 TSMs in a system
> and ability to connect some PCI device to either of those. It is not
> impossible but not exactly "painfully simple".

The simple case is the typical case, single TSM. If a platform invents
multiple TSMs then it needs to define a protocol for userspace to figure
out the rules, like "match TSMs to devices by PCIe Segment Number", or
something similar. "Painfully simple" also means not pre-constraining
the ABI just to mitigate future userspace complexity. In the end the
kernel is allowed to not need / have an opinion about this detail.

> > [2]: http://lore.kernel.org/b281b714-5097-4b3a-9809-7bdcb9e004dc@amd.com
> > 
> > One of the nice properties of multiple tsm_devs is the ability to unit test
> > host and guest side TSM flows in the same kernel image.
> > 
> >> I am missing the point of tsm_dev. It does not have sysfs nodes (the
> >> pci_dev parent does)
> > 
> > The resource accounting symlinks for each each IDE stream point to the
> > tsm_dev, see tsm_ide_stream_register().
> > 
> >> tsm_register() takes attribute_group but what would posibbly go there?
> > 
> > Any vendor specific implementation of commonly named attributes.
> > Contrast that with vendor specific attributes with vendor specific names
> > that the vendor specific device publishes.
> > 
> >> certificates/meas/report blobs?
> > 
> > Perhaps.
> 
> Hm. Those groups are per a TSM so no device's certificates/meas/report blobs there, right?

True, I was thinking of a per-device TSM driver supplied attributes
similar to 'struct device_driver'::dev_groups. Both that, and this
@groups parameter to tsm_register() can wait until a solid use case
arrives.

