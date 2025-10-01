Return-Path: <linux-pci+bounces-37315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8DFBAEE99
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 02:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B612A277F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB6422D9E9;
	Wed,  1 Oct 2025 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgmYmi1Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50C229B2A;
	Wed,  1 Oct 2025 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279962; cv=fail; b=iGvnP89Jw9QDtwcUefcly3ZRR4r6S6o9mSYRrGtLLb3xJpo5qi2uB2VpOZOBJu6HXFWWcICo7nBej1keQGfWcHH6BPT72R1V4LaCf25pQFkA5g7yV55zyYss3v4bVESicgZyoSiVJCkfuOxAtUwJ7WMP7UdItl/Tw1+1F4BsZ54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279962; c=relaxed/simple;
	bh=7OGau2i53hhX45l7pmKutiODhWMF3phCjYNtSRmCssM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Te94Brquca5b13VSa9fufD8CuWc2d98212wo5yYBboAGXqB9tIbhKP9J9KiCNMi16R72B8mVj6OHsIwjn3DTWR0KCUqNHwzqpMGoW9tQ+lvL6zK6qhJta/S7QyY8LcFAVRPPLAYOyq1/MLU8K7jvBCETqpwApFVvSS1lngylKf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgmYmi1Y; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759279961; x=1790815961;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7OGau2i53hhX45l7pmKutiODhWMF3phCjYNtSRmCssM=;
  b=VgmYmi1YtGvsVBLNZqDGjTZZMA7Xc+dR4zCBtE9QFNm0PCH8Pmu2j9FX
   J6rhYDr1wxfvv1fjM59AyBMgAaXHuDolZTiJwJzHZqCD3hshAmf+JpOMY
   XcH842M71kSUh8g3z21YnqZAatS+zyuNKDKAjPA/fF/tGfSd04pzG1gD3
   vkAJDgH3k0KLOiM6qK8BKjW4BtX8+wuLXBNkCUxyIuFHdHcLQ7o+9PGYd
   xknmEpCaFOt17IW3k+GUXvJ5fOZlyAiuSXOwZEx1Wg3kj5ITkOqREF9/6
   Gh2Lg1zwFuUNqSMktsWvM5UjwS9qpI11oP971XDxnw/UunrpddmKOidA/
   Q==;
X-CSE-ConnectionGUID: wQlqfmfZRKWu/LQYij4CDg==
X-CSE-MsgGUID: MIog6gJsSKSBVybwkSHBHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61586796"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61586796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 17:52:40 -0700
X-CSE-ConnectionGUID: yVqetfuES1uKcsfcoT7lcA==
X-CSE-MsgGUID: 6EsNM8SlT+Cfq3D/+a6sQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178250783"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 17:52:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 17:52:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 17:52:39 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 17:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn2Ma4sH6I1Ke+2fX7jpZ04w2RsEqBeiRPCjkiT3UCXMeK69HZBXtI56to1GTrngJrvZStYtb8fURkjQr8qVEeSII8kIfxeXu/ZLX6v33lNhgvY29K6PB//UHcqjjvgk3K0/ehkxUDwgPiyElRq+OSFk19EUpe5dBWz5itEScb9ft5d/obiAAD2KmOlzYK3sEIlWzjv5iwfQMeI8ge+7MMRtNkDICJ322R9jBs73I8DaGoRWeLpwMCSXBRLuiPm5loJSti8VRLYPQdLBpmNoQClTfrLW7pUeokZ610n6l/J939OQ46IymYl/vT7qu/5Fp+CKTmwa7W33Uz5nE3Oypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKDhkTQIjKEyC60Shjav94TTbqreDlIBFrhPinkH2dQ=;
 b=O/0e0h8ZIWFcd5GQUwlS0Gk6w9SSLej3tVzejdvNDrnujpVTkgyum/aRYpmLzqNRIeK/Fw+JNR/y7MhV01JmTofT7GwQCTeJbwHShj2ZjaQDVxWZPfTfeZqlPkKpJR2GW7Z2a032QGYdvH4iZpq4o8aVJYW06Ehs7O8HDrscebCp6cbfLXybyUNT9nsgXSrtzd1MvcQ9oSfL+vd2QGFrLGKS5J5W7Q3wGMDm0pmLnEpv+gd6NlW0h6wZZ7ZP27gLwNqeCab88FxjPU2dB2aJ+Fshkj/UA7F022I6oZNBggVKyq2QINJV1UvwoQAPfjfbrsicm3820rLLfCPHCBbF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 00:52:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Wed, 1 Oct 2025
 00:52:37 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 30 Sep 2025 17:52:35 -0700
To: =?UTF-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<aik@amd.com>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <68dc7b5389621_1fa210090@dwillia2-mobl4.notmuch>
In-Reply-To: <d58dfdf5-0058-a03f-dd75-5afb8ae69e04@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-3-yilun.xu@linux.intel.com>
 <d58dfdf5-0058-a03f-dd75-5afb8ae69e04@linux.intel.com>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 6001027e-d0d1-4b79-49d9-08de0084d0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmUwVys1OCtRQWhuc1AwYTJMT1N4VXl6N2xJSVFDa3JqSytQSnpveFlyNUxS?=
 =?utf-8?B?VW9oK2ZrWWFTQXM1b0F4VVNUbktzclAyQTlFcmhyTDdYWDEvQjhDZjVwUWpZ?=
 =?utf-8?B?SVc1ejIybDM5cXluMTFYSHZCdXQyT01wRWxkalFtTDZLL1ZGd1JoV2lkNzNX?=
 =?utf-8?B?OERsTEMvTVRBVzB2MFNlN0ZxY2dlRjR2aEdIcVhZOEZUSEtGQ1diS0QxVnFY?=
 =?utf-8?B?Vm5GM2FuLy9UaU0rL01tRzFscUV3QjFmRGdsUkhvcEYybW0yQ3ZPYjFnT215?=
 =?utf-8?B?d0NqTkx3ZkE1TGdRYVU5TkpmL0tDMndRSzJyMTFOQjFFWUNRemZlb1RnaXhk?=
 =?utf-8?B?elhIYTlPSVpnYVZKN0FZaVY3MlBzUkt2MGVZbFF2ejVleXpCTFExckhVaktp?=
 =?utf-8?B?VWloNmlURjhuTjMvYlJTNlp2dWoycW92QmFaKy9mWTJ6bnJUSGFDKzRZTUdl?=
 =?utf-8?B?OVNPTTh0Q29xZDhuSFlIYzR0QnhSdHdhdXVZY0swd3pNTGFLejhxdENzdDFS?=
 =?utf-8?B?YUdvbWJhckNkZlJ0c0FvYllkZUhCZmVLcE9zSmRLSkZQY1BnTkFMRVRLSlUz?=
 =?utf-8?B?Y0M0eTQvRzNjdWxXUjE0NFJwWjNQcHhObVhtaEs0YTVpaDhxRzFoQjE1QXN0?=
 =?utf-8?B?cS8wanYvZjllT1d3NUdMWWphUFIzaVNSVDBZYjcveEZnOWNuSktGU2FXZUN1?=
 =?utf-8?B?UzRhVzB3SlpURUlTbmg1Z2NFZjY4Y1ZiV1MrNE9rZHdXL2VBMTJTdnl1L2NX?=
 =?utf-8?B?OEdhRVRBMVRoUE9ORnY3T3NETDVjTnM0WXFnVHlsNG5CbXNNWE1sMWpDaytt?=
 =?utf-8?B?Tmo4OFpZdU5jZGllMUVhblBYblhoSmo2ekJPR0dUTnZrU003UW9pM2dnY3Az?=
 =?utf-8?B?TVdnS2FkaGZnNUhyTDVhR0I1a0lhTjd0UGNXUUVOV1JPM0J1VDRhb2RjS0ZJ?=
 =?utf-8?B?b2twbjlJZUMrZmdZWHB1cnRMNkJVbTQrZmZ4NlZ6bXN4WjRUZWQwWXd3ajJW?=
 =?utf-8?B?L3RMZWRXNi90bTA4OGV1dUJsR0l1S0VWbkhBVy9WWHhHWmp2OTVGa0g3Skcx?=
 =?utf-8?B?SGxBN3lQamxlM0ZhUWlEN3JkVG82Um10VFBBanFYUmpvSDUxMUFScklaSVpX?=
 =?utf-8?B?Q09GMS9SVTA1bDhiQmNDb0hYZHBuUTJkaWhxeHFycW1NN1B5NXZ6NnB0Y2ty?=
 =?utf-8?B?bXdvczgyT3QrSmIycmczbGh1a09FSmlYQVdYa3lhUnc0ZzJJMDc3Sll1NkNk?=
 =?utf-8?B?S2RNcEdqYnEzeWZoMDF5Z3lxZjR6SlJWaXZWSll2YlVZUklrOHQ2dDRWL0Jr?=
 =?utf-8?B?anZRSnh6dFpzUlU4dmgxY3hDYTJwc2NNamxWSnJHbml1cGRNdGY4a3piUXhk?=
 =?utf-8?B?WVZFbHlzWXlvZ1RMYmFPQW8xSFlCWlFESldmV25IREN3dE1iS2lpNmRveGNY?=
 =?utf-8?B?eDBPTWd6ZytjWXdXZThwZzlzbWNEY3Y0TXFudnY1Nzh4TC9NbUZEbGxtd095?=
 =?utf-8?B?c3pFUUExYW9UTE51SFFVSHVvSGtQWWF2V3ZEM1NIYlNRQzVld2ZrN2JRZzFr?=
 =?utf-8?B?cnIxSy81OGRyb2lpOFZqbXNyT2N2NXVnWldqNytnREk5M0RjdWcySERJZ2Nu?=
 =?utf-8?B?aW1Ya2hmbGdYWWxjSGFyd2tyY3JUS0tGanNTL242RVpENzR1UHpEalYzeStN?=
 =?utf-8?B?Tyt4bWN5VThCaFY5THV5blRBTTc2ZmRXR0Izd1FmVTRJVWowL2daVDQzelBW?=
 =?utf-8?B?a0ltSXFmc0owY09VMy8zYnRJRi8wYlBXRXVZdTFuUFFJb2s0c0VsdnVOWURY?=
 =?utf-8?B?MStHa1ptOHoxWlA5MDhtWjRTMllpVGNDVTlHZkVYUSt0b3l5Sm9VTjhoREli?=
 =?utf-8?B?SHhSS2xKak50ejhoNnJGVGFoazBDQ25yZGpoTWlIa0twdXFheW12RG9DWHlY?=
 =?utf-8?Q?n3wU46DYDqEFfKkXbzONIoK5GM+xdv82?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBGckpMK2hEQ2J0eHpnSGdISjNLRmNCUVVaN01FM0lqNnJLZk9Xdk11T015?=
 =?utf-8?B?UGtNL3htRW9KUUxSUWNGekpoY015QlowYjNNNjRlV3gxbmhkeHdsbVZtVFFD?=
 =?utf-8?B?Qkpra00remVyTzZqR2I0VmlNaFNtTmpaWEdCUHhmTUVtZW5jQkt5R1FGOXBV?=
 =?utf-8?B?Q0xwQlhNL1l0eDhFbVRsT1k5alBZNEh0OUlPcWp4L1h5SUNlSk9zTjB0Rzhy?=
 =?utf-8?B?cHFnMVE3c3VJUC9rdkF0dmdtSzI3WW5nNmdyMGxaQXo1WnFwQ0NOSG91NEFU?=
 =?utf-8?B?dnd5UFAzaUtuWXppV3kwVDZyeURBTmlNK1BrU01rc1UvNFdHQVJUSVNkdThX?=
 =?utf-8?B?b2Fsdlc5YUlSV3J3RjVpM0wydit4YWRScEZCZXJtRWpVNXBNdUMzb285aHdC?=
 =?utf-8?B?NnVRWFVmaVV3K1psdldmRDQzOERIUEhtczlBUUVURlpFMktTTmtVeE10eFAy?=
 =?utf-8?B?RXp5TGx6bGNUZzROQnZrYWV6WFJXbzFxMlJ1YjlLYi80Q1JWL1JXWUNWY2V0?=
 =?utf-8?B?V1JyWkdQdGs2dEFtM1pIS1hyUzdHM201M3RESGtPbkFGemxDT1U2QXhNcXYz?=
 =?utf-8?B?bmFSZlh5Nlg2NjdhSkJPVXVPcXVPTXBORk9TSU5oSzNZUG9GTXJjcjUzTjdM?=
 =?utf-8?B?MFFURzRQcHllcS92dDNzRGdoYzlsVkpOelp4bjVudmxNSHVMTmNYQ2hnQmxR?=
 =?utf-8?B?YmxuVzBPMFdiVUxIMm5mMk1BS2hpa2Rmc3RrM05nTUNRSGRYRXdLbVRUM3V6?=
 =?utf-8?B?NjdaVGk1WUlWaUJFa0ZZRzJ2b0h5MUFjMlYzL3FnYTltRnpMZ0xWWnIrWjkx?=
 =?utf-8?B?elRNV3hSLzBVSThwdHpaVGRMWlF1ZWNKT1hGMUpwUXJGbHZzTVRlek9Rdkxn?=
 =?utf-8?B?bE5abXJxYVQ5VmhhQlNEdkEzb1hYYUFpWFd2bUg4UGs3SjF0MHZQaHZKSDBv?=
 =?utf-8?B?Q2Z4SmxQQ1VnRXcyNzUvbXhFNkZxbDdFK2lsaGdwQUdHMmVrY0xDVU5STXQy?=
 =?utf-8?B?WGp5SkZQZ2V1VGRHRGwwMEQ3Y1paR3Qwd042cDVCZkE2SlV4MXBHRjR0MlFP?=
 =?utf-8?B?WEJFeTdkQldGZ0hZL0lYTmtKYjdNdnBPZDAvZkJ6WFJLM25QVUhZbjZGUWN3?=
 =?utf-8?B?b3dVNThZYkhacmJ3dGRZTHp1dkpNbnF0MHNCREZnOXJQL05zMWRPTldYU1lK?=
 =?utf-8?B?b1RGalk4aUpnWWZnSlFqSEJPWjBnTUlpeHdsWU5NQmhCRmdIRVBpL2ZYVVJt?=
 =?utf-8?B?bDk1OU5OZVBjS29wWmdZUDhoWCs2QU4yZ0dmMHVGZ05vTDE3aXlyUGlpRjUr?=
 =?utf-8?B?QnZkNHg3MCtjVlRmV1FSVDZwdzNCVDgyMCtOajVPelB3VVF1TElYdUp0YlV1?=
 =?utf-8?B?dE1hRHJsMUU3enlQOGdiK1FGT2p3WlZ2cWttWjBPTm92c3hONTJBQnRKZjNM?=
 =?utf-8?B?aFpZUGxjVWswRmpzV014NkxYNjhHNVlsTlU5Z0pVOUJHMzF2c3orTTdCcXlK?=
 =?utf-8?B?KzVKQS9ZaHlCREJ5b3FkUG1ma292TDRrRXVsTkoyd0RzbGwycVZWdVVvejJx?=
 =?utf-8?B?bjFXd0hyM2hCeTN0VFdIVEFTVHdPM0ZlSjIraFhacVk0bkh4VXJTd0dNWFJr?=
 =?utf-8?B?dEpVQ2tZbXpjY2o2MGFrMExrR3BuVnAwdS8yWGlCRVlybDVMMmRscW1kSkd4?=
 =?utf-8?B?TGlvR2czb3hOb2NJck1YSkg3R3RxZE5hazJFSVhhZTRGdjdFV040Y1B6d3N0?=
 =?utf-8?B?emh0SmhjbXZVZWxQMDgwcklwYXR2T21kWGNQTFM2V1JEdzAvcVg4dFZNYy8z?=
 =?utf-8?B?R2dNNTFYQnd5RjMxM1BJSUprdzZ1QnpHdHRvcExCeno0ZGZZNnM3S01OcXlR?=
 =?utf-8?B?Z3BtWDh1eXN4dzRvc25CS2ZUNXl1ZE5kZFhJeTlxQVhiY3BIMnI0YUl1SXJl?=
 =?utf-8?B?UU9lakpyQmhNVWVGY1lwK1lmVnJyemJhcGExOUJ1VzJweVZFVWF2UXlqcDRk?=
 =?utf-8?B?SlV6b1NDbG9Pd2dISHBCS3hvdzFTekNEamdNeWlGMkNWNmk4YytDdVpJajR1?=
 =?utf-8?B?RE5DeHpPcjQ2S3JycXp0ZEtGQlp1TXhHT1FQUkhDUVhZT2tzWkYzR0dabkFL?=
 =?utf-8?B?Y0tyYVJIbGp5OFNFYmZrdFg4b1Zwa1JLZlFYejdhQllUZFZkcWxLam9hUklq?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6001027e-d0d1-4b79-49d9-08de0084d0a5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 00:52:37.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDRPt//nDugceMQoOZ4CRL6wzxF4tTUz46BjyboGQooYzHT9jfaTIJpPRBDLpjQRxYVGKPY9zbc5VjEtFsZMa1T4Ggvi2m5u97lQ5pulmzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com

Ilpo J=C3=A4rvinen wrote:
> On Sun, 28 Sep 2025, Xu Yilun wrote:
>=20
> > Add Address Association Register setup for Root Ports.
> >=20
> > The address ranges for RP side Address Association Registers should
> > cover memory addresses for all PFs/VFs/downstream devices of the DSM
> > device. A simple solution is to get the aggregated 32-bit and 64-bit
> > address ranges from directly connected downstream port (either an RP or
> > a switch port) and set into 2 Address Association Register blocks.
> >=20
> > There is a case the platform doesn't require Address Association
> > Registers setup and provides no register block for RP (AMD). Will skip
> > the setup in pci_ide_stream_setup().
> >=20
> > Also imaging another case where there is only one block for RP.
> > Prioritize 64-bit address ranges setup for it. No strong reason for the
> > preference until a real use case comes.
> >=20
> > The Address Association Register setup for Endpoint Side is still
> > uncertain so isn't supported in this patch.
> >=20
> > Take the oppotunity to export some mini helpers for Address Association
> > Registers setup. TDX Connect needs the provided aggregated address
> > ranges but will use specific firmware calls for actual setup instead of
> > pci_ide_stream_setup().
> >=20
> > Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> > Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >  include/linux/pci-ide.h | 11 +++++++
> >  drivers/pci/ide.c       | 64 ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 74 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > index 5adbd8b81f65..ac84fb611963 100644
> > --- a/include/linux/pci-ide.h
> > +++ b/include/linux/pci-ide.h
> > @@ -6,6 +6,15 @@
> >  #ifndef __PCI_IDE_H__
> >  #define __PCI_IDE_H__
> > =20
> > +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> > +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> > +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> > +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
> > +		    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
> > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
> > +		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
> > +
> >  #define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> >  	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> >  	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
> > @@ -42,6 +51,8 @@ struct pci_ide_partner {
> >  	unsigned int default_stream:1;
> >  	unsigned int setup:1;
> >  	unsigned int enable:1;
> > +	struct range mem32;
> > +	struct range mem64;
> >  };
> > =20
> >  /**
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index 7633b8e52399..8db1163737e5 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> > @@ -159,7 +159,11 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_de=
v *pdev)
> >  	struct stream_index __stream[PCI_IDE_HB + 1];
> >  	struct pci_host_bridge *hb;
> >  	struct pci_dev *rp;
> > +	struct pci_dev *br;
>=20
> Why not join with the previous line?
>=20
> >  	int num_vf, rid_end;
> > +	struct range mem32 =3D {}, mem64 =3D {};
> > +	struct pci_bus_region region;
> > +	struct resource *res;
> > =20
> >  	if (!pci_is_pcie(pdev))
> >  		return NULL;
> > @@ -206,6 +210,24 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_de=
v *pdev)
> >  	else
> >  		rid_end =3D pci_dev_id(pdev);
> > =20
> > +	br =3D pci_upstream_bridge(pdev);
> > +	if (!br)
> > +		return NULL;
> > +
> > +	res =3D &br->resource[PCI_BRIDGE_MEM_WINDOW];
>=20
> pci_resource_n()
>=20
> > +	if (res->flags & IORESOURCE_MEM) {
> > +		pcibios_resource_to_bus(br->bus, &region, res);
> > +		mem32.start =3D region.start;
> > +		mem32.end =3D region.end;
> > +	}
> > +
> > +	res =3D &br->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
>=20
> Ditto.
>=20
> > +	if (res->flags & IORESOURCE_PREFETCH) {
>=20
> While I don't know much about what's going on here, is this assuming the=
=20
> bridge window is not disabled solely based on this flag check?

Indeed it does seem to be assumining that the flag is only set when the
resource is valid and active.

> Previously inactive bridge window flags were reset but that's no longer=20
> the case after the commit 8278c6914306 ("PCI: Preserve bridge window=20
> resource type flags") (currently in pci/resource)?

Thanks for the heads up. It does seem odd that both IORESOURCE_UNSET and
IORESOURCE_DISABLED are both being set and the check allows for either.
Is that assuming that other call paths not touched in that set may only
set one of those flags?

Otherwise, the change to mark the resource as zero-sized feels a better
/ more explicit protocol than checking for flags. IDE setup only cares
that any downstream MMIO get included in the stream.=

