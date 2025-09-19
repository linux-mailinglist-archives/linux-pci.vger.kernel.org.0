Return-Path: <linux-pci+bounces-36541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE3B8B30F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 22:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD62E7AFB96
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8670129D281;
	Fri, 19 Sep 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaOj7Kh8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0E29BDAD
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313799; cv=fail; b=T+TQiAgVIG5OP6mf5EeQlmk1AoSl+4Jj/CZkrHeBBJHaKDe45+2Wkg1KgkXbSgvU6gBMchOeOgrvuX5BaCx/ESNiO0ZpiuMDEVk1WntBPrMYN9d8cgtCkI0EaMZxmH7TIDSzS5NF28dXPFYrsiihNTgI2x/2RnnGshNnmZ2shyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313799; c=relaxed/simple;
	bh=hbFRIvvwpa1GUFP/Gz9THK9hxgjrM/cruSn9WiEB6Pw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=G5x66Kvgd5QuuHVsKYr7RA/5UuSBKqcoPjccKYNnwHp+IOZCMfpjRh8ZU80W80NyU501nV+4TT7PQ8OrNpesUEF0hDNdqC6bHdtWutzl+JipuumUf6a3l5CDJFclpoV1jzfE9UqTcRZEz5bp5LEIWAhKOAvRNhUxZKxaIdgfKZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaOj7Kh8; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758313798; x=1789849798;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=hbFRIvvwpa1GUFP/Gz9THK9hxgjrM/cruSn9WiEB6Pw=;
  b=FaOj7Kh8ktUJ5vUnoKljxgn5bTbC6R0PxtXnmlwdrWxRC+Dd95RI6WKQ
   s1I1K21ckA812HQJdml4zQdMfv/+2m8hobQZJsi0wtbjgOSZ953a4LWfD
   tNhGJFASB/QuorO2YI/vTasjRnN18DaMSNgYuItsuPZNTYtI5UJv/Eya3
   kcNx3iEqIzmz06txVFf2LML9+oAjaNPoSETUQ1AeFKb22NQWNSppV28CP
   VCU7BJzvIuMF7cWTgUN5kF9s0Bcn+IPoRhM6GWdOEmVokN15ggETIOpHF
   UUTvbAkz6oAyD9AtU54Z3U+f6SIIUicf3FGIZK0bWzJAAwTPBiWtniESC
   Q==;
X-CSE-ConnectionGUID: +HxEQzdiTZ2+3DfSF79kfA==
X-CSE-MsgGUID: fUbpVtGDTPKzMGSKG6QG4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60596112"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60596112"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 13:29:57 -0700
X-CSE-ConnectionGUID: NeIBt4LiSFqejlhLQsdcKg==
X-CSE-MsgGUID: KyPnM0daQHy6iw5HVDyZ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176360356"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 13:29:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 13:29:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 13:29:56 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 13:29:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrLoqeD28cPJIU/SV8Eu8duB5Wkf9zmPxk/AQjh9TXlOR+rBlDp0mvTANoJql3+J88qyLjdHnuSQWZnrzZdf2CJ7mCYOBYaPClTfhAt/YCYzp2x7O2mxTisCmzZRo88EZa7Oal1MgsCQh1C77UV2QxIak4lxjZo2ilchKiFGKX/Wrh+kjicZwpYfQPSmdgNebrDcR5TeIxo3+Wc1gpVa4A12h9YdMTTNXi62vx8ahiIPQRrhUgjXY1ajXrA7KO/PRZpukK+orHzYPqBqIEnrDC3oA9GBG0EgiHc8h2iCnR7Lab25Bv1PzUC8B/HeBjMIR9VL0/tJkynt1YOTyzrDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VGeeszAifN5yzokwLYwgO0CbpeipQMMI92hXqr7n54=;
 b=cmMgRxTfHsbr2bKtSrkpp24237myHe9K+VCL3YlzEoQY8FZOFLyg7YMQI9x4xQKmE5ZiTSPDJ25K1rY6KPK99NY5Vj7CwHQ5Sl8cox+5NGSH7ztI3YFHgBKFQ2B8i8s/KGYe8D4nf/LZZumWSWUYvfAFVFFYP3Hv615bjTlv1Z07Mxq1nEk+avXKzMArFEwKneOGWmS50X3B9J846P2T5IVgFVPNRY1IdOqjxW/jv0y+vXzxY3z6YDUYceg3BLZTZXyduoVfc5cr7Z/SMDqcQPsGP6mAHOlqBseEWGkIKGLyLaykYZunOTyXYzXlRb85/u7FQ+4T9ZtLygeIhSsjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF2FCF00E1F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Fri, 19 Sep
 2025 20:29:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 20:29:54 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 19 Sep 2025 13:29:52 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <68cdbd40f27f9_2dc01009a@dwillia2-mobl4.notmuch>
In-Reply-To: <9ca082b6-ff38-4401-860e-e40d4437c3a3@amd.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-5-dan.j.williams@intel.com>
 <9ca082b6-ff38-4401-860e-e40d4437c3a3@amd.com>
Subject: Re: [PATCH resend v6 04/10] PCI/TSM: Authenticate devices via
 platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:303:2b::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF2FCF00E1F:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f9ab70-c586-479f-08f1-08ddf7bb4aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGpmbmNLaFJCNkpTd0ZITkREVE15OVU0dlhGSlArdVZ1NWZiR25mbTVmeFJT?=
 =?utf-8?B?QS8wdlllenprOU5KRElYOGFxbHcxM05rUklHc0d4bTJSbUQzaFFmZTBqTkRR?=
 =?utf-8?B?K1pUNjlHcjYyQTZLN2dXZURRWjBUYm5kZit3SjRwMkRmc3dseCtTQkxqMlVV?=
 =?utf-8?B?cXhHbGJ2eTNERHJVWUQyb2VHeURxeDZ5Tno1cXNER0NUeUdjSjlpckVKWkhv?=
 =?utf-8?B?TXJ0UXg3T21xa0RJaTduMFYxREd2SXgrUTY0TEVZdXNhLzdMODRKL3lZaU42?=
 =?utf-8?B?cmJoMUFuWnFmb3N6ZU4zOTNaMUx6bU5HdG5TaDFvUE5URXdmWGVWaSs0V2Rk?=
 =?utf-8?B?RUZrWUxkQVFhUm4rM2Njamk4dXVLYnhXcTlVT01NZzQ2aWxleHJZbE0rR2U2?=
 =?utf-8?B?WUYxdmFkY0pDTUNRUTMxUFFHZmpwSzVwaFBDY2JKNjFqaGRUa3hkUXlvNnVk?=
 =?utf-8?B?WE5HN0hOWk53WGZsMmR1UmVDbEljaWx0MjNPSnUrV05qL3dwbHNqdXdLZ2hK?=
 =?utf-8?B?bU0wTG4wMkVOWUh3dFNJcHlJNUdNNjR1YzMxR0Y5MmhUOTQ2YmhXR3hSUU5u?=
 =?utf-8?B?RURsRGNSeFhIbVhPaXBTakdsSmloalk1TE1KVnNhYTU1SGhtRVZtNUFCRzNS?=
 =?utf-8?B?dDVDb2R6RjJzQW5ZSWVVbWI2L3JvblM2Uk9DeGRpVVVwbGk5bG45cGRLMk9w?=
 =?utf-8?B?SEFHaFdjTGhKTjlIV0lUN1ZuL0VFOEtnNWxPRlNkWjBPTCt1aHN3ejBEbUdz?=
 =?utf-8?B?T25xZVd2UDlUQ0JIYkZrcUNTUXJSVCtXdVlNdzdRQ0RJT1BlazRaQ3M0NHRD?=
 =?utf-8?B?Qjl5a1p0NDJydlJpKzNlbkVlTkpvbnh6MlFSWmF1eTN3MHJ2V0lrNzBqWGhl?=
 =?utf-8?B?V3VoWTZxaW5tNGV5Q3pnMkxSb2Nrc2IrZkNoc1RneTJyY2lNZGRabi9odklQ?=
 =?utf-8?B?Qk0zR1k5MlhsM2tvb1JQTjY3dFlJQ1NmMnFwWFArcExsbEZnZk1ubEtHbzYw?=
 =?utf-8?B?WW9qRmVkRWtJbU00VXpHV2ZsY2tkcS9VSGFFZ0J5dmlQVFhVZnRFVHhVbkZq?=
 =?utf-8?B?Q3BpWEl1Vmg2OVJrSnhPMHNEeHAxTktndWw3NHFpNFVabFhoMWgvOFZMb3hB?=
 =?utf-8?B?V0F3ZmtGN3dmam5VTWs3MHM2VmJ6eXl4QUtyelM2emQweUxOSmxZMUMwRjBL?=
 =?utf-8?B?TXp6cG1QT1NPcjFqWlRzV1BUL1dxY3ZvMGtCYTYzcE9Nd25JUVNjNlBLS1pI?=
 =?utf-8?B?WXdjbDV4alhyTWZqekpGU0lIZ0lvSTZoWExBdE5VZ1FUL3AvRjFoUTdxUWp6?=
 =?utf-8?B?eERkSGU1SkU2dCt4RDNVL2xjZ29SR0JQbVZNS2FYWUhMQktDaWRxRlAybGRU?=
 =?utf-8?B?RGtiK0hYQUUySHRCb2paWVVYbXVGdXlITGNDZTNrQkQ4NkZkQlNGSFByK0Vi?=
 =?utf-8?B?UjRWdWVpbS85ZnBWbDN2NUlDcW5RZnkvd0NXeVBtaGpQQ3JLQ2s1NEs0aG1W?=
 =?utf-8?B?anIrQnRDbkluZmZrQU5NQ1E1bHB2WDRIZWc3b1MxQlEyQVplRk1vTWVUOFdt?=
 =?utf-8?B?NXFSWDZSVVJBWjJNdks0Q3Fsd3YzYXVPb01LcnlCUFV3cE9CbWRuU3BwR3I1?=
 =?utf-8?B?OHN3b3pKSDdJZHFyWkc4WUlPTWEvNkkyUjZrVWJxQkZHMlJlekNDS2ovdGFB?=
 =?utf-8?B?aFhtY2lMZ3F0N0kvZ3N6SEg0Z1EwbDJ3QmRmaldxYU90RHZVNm1hNS9TSlJX?=
 =?utf-8?B?dFptTmlUMXMyclVWWFhJWXBRSlNZOEYxVFJWTXRtVnpMQml0b0pET29GTjlR?=
 =?utf-8?B?T2h0YVJXclEwTVRiM1Bzc2ZSUzVMOUpLZnhqUlM3MEZYV3lka3BSRG1Fc1FD?=
 =?utf-8?Q?CJzc6MMaHjY+O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUpiaUJCMmxONUVtWDVyVlBEMXdrM2lzNVYwb0VSUGpId2FjRE1Lak1KRm4y?=
 =?utf-8?B?OWErVXhCNXNENWNIM1czbkRUdWQvcHJLNE9PVnl2eG1zaC92UitJVUw2bW9v?=
 =?utf-8?B?SWVBOE43N2dZNlhRbnY1YWdyanZTZ0xXR3NpODlSSGlvTWg1NEVwMm5vMmlj?=
 =?utf-8?B?WUttdDNFRk5wZ0JrUCtHU2JZR3BrVTgrNXhrditZT3Q2Y0MrNlJyeGRWcTln?=
 =?utf-8?B?ako2VkNLamRkNEZNbWRKV2JkNmovMlBlVjRkTFRHcjlzK09DN09ndEpOK05M?=
 =?utf-8?B?UHl3b0tjSUdVNFNrNG9YZi9LMlBjVTdOMVJsdmlVWHdDTmVKRGU3aDFYakZp?=
 =?utf-8?B?SEN4YWNQZUdXWnFCMWkrL3pMWGdOMjd0SUlRQnVsaWh1ckc3NW9pZmc3eWIz?=
 =?utf-8?B?OFFpdys3TUtIYWxRSE16eHVnNWMyeFFOaCtqRXc5a2E1aHF6R3U4c2s4SXpV?=
 =?utf-8?B?R3FzMjNuNnFmWnc5MjZ6dk1vVjdSMFM5cGU5aGF0bzZRbTNSNEJvTnh5SUU1?=
 =?utf-8?B?VzB0NDFDZTI2akthRUpyUFZLazdudENYbmxrenNJTEFQZHZOeVdTdjNoZTBE?=
 =?utf-8?B?cXgxREg5MFNsQmcrcHBvUk5VUkxOZmxpZzI3NURvUHdQUWE1ekIrVGxsNTNR?=
 =?utf-8?B?ZFJqK0Vtd25YbUtMUUdVSXRvSy9WVzF0dkZSbVRuT1FhWnZ1bTdNTVRFWWt0?=
 =?utf-8?B?SU92RmVOQXZaMWljNjBIeUZYQVVXOFdIUDNFVEcrWnFsR1lhY3N4NnlTSEsv?=
 =?utf-8?B?ZG1pMGNNbnRhOFUrR1g4VFlxb0dQT2JjdGRJQjRrT1N4M2lXN1AxN2czajJH?=
 =?utf-8?B?OS85SVVHQjNGbUQxRTUxZGFFeWVjYXZIeitVcTI3QjN0SS9IUUJSUTlKUStX?=
 =?utf-8?B?cVdjMXRjZ2RLZThaK2dxcGVxZVdXcHVqeU4zWTF0eVo5aGNBVGpoaktlVUox?=
 =?utf-8?B?T3RsWVJMc000TThjUlduMHREUE53dFJ2NUsxNTRtN2NKSWhNQ2VNVFVVUEd2?=
 =?utf-8?B?czdHQkRySlZPV0RIQnYrYm5VSVAvL2Q2OWJBQVcyYkhvVjNtMWp6YVNpc1lm?=
 =?utf-8?B?K2ZWTlUranpLdGFIczFLRmNiS05oZ20zYmxLNXc2WjM5UW1paGdUVkNFU3Fx?=
 =?utf-8?B?emlPU0pGaVZiczE4MU9PRGM1RkRHV0VGVFp1QVBsYTRTNVFJbkQ2SXRDMzFu?=
 =?utf-8?B?cnNLMnpRY05BcCsya3JqYmxMSnhIdEY2d3FmcWdFUFVPZWNjTVdMMFpNK0dj?=
 =?utf-8?B?WFZXWlhmNU5nNld3dHE4YzN5akl3SnpoZFA1TjlzQzh4RytHeFRxeVJOK09j?=
 =?utf-8?B?Ui9nUGRMMTY5ck8rMDBDTVBqVjk2MDdyVXFYWmJGOVZVN2JFS2ZCOWxKODd4?=
 =?utf-8?B?dTdNS2toalVsL0dNeE9tcG45MTFDQUtVKzZXY29mRzJHVDhWRXY2ZFdYYlpF?=
 =?utf-8?B?ZE8zSkh5c043RzVVYVluZnplbFVQamFzQWhhWm9RL0JBdGRnK0RpUy9Qb2dS?=
 =?utf-8?B?RlBJemFwNGg4NkJNQjFBMHdtZ1FkVE10b3pIM1M4U21RcEVuc21kcnRYbUlU?=
 =?utf-8?B?cy9JazdqTElaY0VDeGsxS01VYzFGZ2hxZDAwb3FHb25KN2JaZlhTL2NlMkNq?=
 =?utf-8?B?cEhNc2lBdTZjb3lrbXMxUXhlbDlrRVBmdGduVURHQWh6K3BiQi92c2RSM1RW?=
 =?utf-8?B?YnRQelcxSlI2Ryt6Wld3RDNyZFNxZm92YkRLbWNVWEQzbi9GQURjMUR5d2xh?=
 =?utf-8?B?ZXhkdll3T2RRV0NsakY3R3hqRTVUNE1jSGNCaHpIVnpjbEVQc0pWY0dzcnhh?=
 =?utf-8?B?QXF2UzZGSnd0SDFXMG9vUFBJQVFDT05IMm9IdVdtQ3QrTmU5enZuQnJMbkhp?=
 =?utf-8?B?MTFsV2puTUw5dFc5Z3dKT21md3RrQmN6akZjR1I3eWlKQ2wxQzNvMU14OUhy?=
 =?utf-8?B?MFlhYkIzUXd5NHVoN2JVa3VYcndmTHByTTNyWjE1cVVoMWxlUCs1YjJvQ25l?=
 =?utf-8?B?Y0NmZk9KSWk5MUZsUEdLSGhiQitUdEIyZFlMeExYeEZpQlE0czVyN0g5dEc5?=
 =?utf-8?B?Ry9SZllMY3I0QkN1YzJYUUY1TEdFaWNiUGFtZ01wei9rQmJacVBiSHBkNS93?=
 =?utf-8?B?Uks4dmlSZ25SQ0NJUUxSNjRWZFowYVBsTEROTmFkelVjVlJSTUVSY3ZMdENp?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f9ab70-c586-479f-08f1-08ddf7bb4aa7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 20:29:54.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cMnnA5smdnIG5ou7cOdmHxAeFYcRPawkTd+KSPN3sSNaCIQbOvUIRc3pSuBoEApcN22dumUOuPOO7j7vo1b6sZswSTVQG46v6Fn0qR8yQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2FCF00E1F
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 12/9/25 09:56, Dan Williams wrote:
> 
> [...]
> 
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -15,6 +15,10 @@
> >   
> >   struct pci_doe_mb;
> >   
> > +#define PCI_DOE_FEATURE_DISCOVERY 0
> > +#define PCI_DOE_PROTO_CMA 1
> > +#define PCI_DOE_PROTO_SSESSION 2
> 
> These are "features" now:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4db6be0ceec490f639d2e47449ffe3dd6db7679

Ah, thanks for the heads up. I will just append this fixup for v2 of the
TEE I/O series rather than resend patch4 again... unless something
bigger comes up requiring a respin.

-- 8< --
Subject: PCI/TSM: Rename new DOE defines from "protocol" to "feature"

From: Dan Williams <dan.j.williams@intel.com>

Follow the lead of:

b4db6be0ceec ("PCI/DOE: Rename DOE protocol to feature")

...and move the new PCI/TSM definitions to "feature".

Reported-by: Alexey Kardashevskiy <aik@amd.com>
Closes: http://lore.kernel.org/9ca082b6-ff38-4401-860e-e40d4437c3a3@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/tsm.c       |    2 +-
 include/linux/pci-doe.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 724a58e3ccf1..f0202e52ce2d 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -464,7 +464,7 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 {
 	mutex_init(&tsm->lock);
 	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
-					   PCI_DOE_PROTO_CMA);
+					   PCI_DOE_FEATURE_CMA);
 	if (!tsm->doe_mb) {
 		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
 		return -ENODEV;
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 7d839f4a6340..bd4346a7c4e7 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -16,8 +16,8 @@
 struct pci_doe_mb;
 
 #define PCI_DOE_FEATURE_DISCOVERY 0
-#define PCI_DOE_PROTO_CMA 1
-#define PCI_DOE_PROTO_SSESSION 2
+#define PCI_DOE_FEATURE_CMA 1
+#define PCI_DOE_FEATURE_SSESSION 2
 
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);

