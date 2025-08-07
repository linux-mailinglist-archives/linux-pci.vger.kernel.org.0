Return-Path: <linux-pci+bounces-33506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42945B1D0F5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 04:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED2F626C98
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 02:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C71A841E;
	Thu,  7 Aug 2025 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNjvBB0T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592D1A23B0;
	Thu,  7 Aug 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534154; cv=fail; b=qSxo6s28nl/YTAQX85JFnYVr6TuaM1htQM79L5XXGKNV6NTTPX31tIH7XgB5p4DH9Wq43sC8gGkeTVtYVNZKNYBLD3dGOTF/6v9F93Pe7GYdfuxp4F3WSjSwr+J3WkWdsr5juDq4Imt5udZVhp/bDfHBOKnUapMYNbf8kRdubvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534154; c=relaxed/simple;
	bh=FbhU8Qm0xkH02tkXy9ETMDI8xGlVamHbpMXH9zYM+I0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fdB8q62xrEIg7JGuW3bri9SDy+ggxuXzDTbwPnWpC4Fq1Bn+a3vKQQVh6fOCcgQzC6VV9Gzjy+X6gBYOqpG8NOf8X1bLEZ02deLq47RXfkTCpe9pJlBosPVrvqJy34hiLStKuPZJGqzylpiYVCOCYPmrh7dpUWrmAKQ1tqBcDkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNjvBB0T; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754534153; x=1786070153;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=FbhU8Qm0xkH02tkXy9ETMDI8xGlVamHbpMXH9zYM+I0=;
  b=NNjvBB0TyT9tBHZUfco/6FX+xkaNNIUH1/IrEQJ39XXnSzyqdp4XN0BO
   F02EILM8eX4Du471DQkHZseVzC0im1YHe6LpiRjqTfdsX2gZIVYJC3eOj
   taBeViS2TpqZHv0yrYnkDygqjSzwpwxq/XZuQNjGeK28DQw7JVh+lBmPu
   32hCRnQSJmFlau9KaWWhIJyv5V1oePeIqxtaea9zRJGcdxE1xTeIspQhn
   nVtfuKRnKqMFzxJwgjZ2N1dzPmycymqxBqSI/hvbyPLWTHaDsNKNnZTrF
   LY1/ES4h0k1XyB2N/VVsz/e6+aJoyX56BknR466/K8SOB5HVFRpgtL6p8
   Q==;
X-CSE-ConnectionGUID: 3Q5xq7heSZmVS/vdEvpDig==
X-CSE-MsgGUID: 8oBzNkfNTielDKM6Hm4tMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56825387"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56825387"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 19:35:53 -0700
X-CSE-ConnectionGUID: VorWwNgXTLSFjsqgBZQqsw==
X-CSE-MsgGUID: a4uJicltSH+U+HCvQF1v0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169058722"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 19:35:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 19:35:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 19:35:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 19:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm5dq5ks4uDA9rHHPgY6EtsTvgpoa2Ijs7fVxjzcW4b/1waus4aKfBYBsYKxTsHg9WjkVNKiN08fTLLBqmBPhjQTWIoW7Ft4tqA0zQXngUwMvIT+nQMg58cbQIJ5Em3Gx7Zml/MNLDHnWQqMtXn+Fck+fYnj623uaKPVRpToK8MzC0cLPv5CsJizIjeJGKbWSM64aiZB0FZhZkkOWSjNCybUPmHhPjj4RGGm4BsYBip6mQSGtU/go+gT/p53ElBoZ1q86zeoJTi/dVFP1oX9FqJnrRR0JFGQZWbJ3Yx42a2IAO3jRAIfK27eAd4BO+ctIs8FwRwPEZjqMn0eA5+FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hT/zwjesOlPpB+cS6xyxfU5ytHBdRQsYYAeKbJhOf8=;
 b=Wz9gFH55y/GVGW0Da3YVyBQv2teSbjUT/pvkBZL1abp4lfoDdw1L79dFUSdfYO0QQcRNATg1vXwkc3mr7UN9b9njS5/z8ydDEDpY57d3/LXo67NhG4zR5flmI1UATQAucjrl4fgE0p92sJ8vMckYY3qPe4cJz3DVuZZo69FN+otZpi5f/23bZs8iD06DlGmlg9ce5aeCaUshPtJSiP5o3cggj5EFcWAEnoQe99tyDC+OC9ZhAonNNAAcgTD+0Ay2mNBgPzxypPAK69gz9bAPu+mFiFKcAZoWeY9+5kGeJpXYuKC3biOqZd97Z/HAU1f5xHoCC0Kk+aVoQRb+bct+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 02:35:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 02:35:42 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 19:35:40 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <689410fcb5bc2_cff9910036@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250806121026.000023fe@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
 <20250729155650.000017b3@huawei.com>
 <6892b172976f7_55f0910067@dwillia2-xfh.jf.intel.com.notmuch>
 <20250806121026.000023fe@huawei.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 143ca835-0682-4471-cd68-08ddd55b1aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cllhSmVTMGFhZXVuajRNMlhrZlBqTW1NTlpFQ2xBcXRLejgxMzcrRHJZUGZG?=
 =?utf-8?B?d1NtYVVZWGFqRXI2WUdQTm1iNk5kSUNUTUIvMThKeHdwekUxb2RsVkdyTDcy?=
 =?utf-8?B?eGFYajlna1p2clJ2d1Z0akNIbkEvdFhlb1c0OWMzM0VQcFFYNDlNaU5tYkE0?=
 =?utf-8?B?aHk4MTVEOXkwS3c2ODNNM3dsMHYrUGQ0MGwwS1JNZk5vVzAyM2gxSzY3RXpv?=
 =?utf-8?B?MHpRcW40THc2Rit4VmlMK3lsOUtPT2VJY29VaEp0WWJWTkJZTEtjdnF6bi9T?=
 =?utf-8?B?TmNmT3F1RU1MSE9aR3ZHNVlwUXY0bEw0Q1J2VnJoNVhxUFplbnlHcnFIVEE1?=
 =?utf-8?B?bi9BQjNLbk5EZmxiTEVmcmM4U3FlY2pYcm9JbllNQVFrMmIzaENaMkdMZ1Vo?=
 =?utf-8?B?OWd1bDZHTWpGT3dua2xueExqRHJBbWhJMDlITmtqNDFITVBjSlpjSjVObGh0?=
 =?utf-8?B?ZXVmZXRjajZOMlI3K0lWRDJyVHdJeUhIdGIxZ2FDMGQyeTVNQjFPNzdsOEMz?=
 =?utf-8?B?S3o4QmZFRW9vSUsyVk81VjJibmRTOXZWZnBkWkt2Kzd3T0dhYWgwejAxdFlN?=
 =?utf-8?B?bC84SVZ1L1VyMXhwVmNWSWNLUDlXelBPRHdEMVhVaCtKMys1VS9QVk00eTZq?=
 =?utf-8?B?Y2xuSEppT1AvSDc0NGw2SWFDaU4yOXV4V2FzVG5Ka1E3R0RXQXNoNjM3Z3Q0?=
 =?utf-8?B?Y1RYK0JWRkhndUEvajlMRUNvU0FqMUdNRThSTTFZbUxPcVo2WmxjYmhpaXow?=
 =?utf-8?B?d0hQZmJzQTlXVGh0cDU1UkdWZFBJREU3SGVaMk1tMlNTSFBUajI0TFdRMS9F?=
 =?utf-8?B?RmVDUkV6bmhNaGNta2hYc2JENWFGWDFmM1BpemhyWlRkNjdBM1ZzZGZ0TzBk?=
 =?utf-8?B?Uzk4dXhxbGpZQVgvb2lJMFQ1NzcrWit4V1d1OU9sM1gvLytVbTdVVDRnUURN?=
 =?utf-8?B?aGJqb3ZtZWF4WG5PVU1SZDdZWkdnMTJMNENZeTNYK0tWUTVueWRHVVBGYWRG?=
 =?utf-8?B?MGdqZEg2ZE9vemo4RHg0RENKU1RRVGhlamk0WGFiM1hsSlBxcHFSNXp3Q1Vn?=
 =?utf-8?B?Q0l4eVVaZG9ZOWdUYng3aU9ObFlwTlh1Rms4QTQvbCszTDFZMXhiVHdGRlJm?=
 =?utf-8?B?WUVNN3d3VEd0a2t0Q3JNYko1VzhyTmlDY0pkQ0pxQ291Y1VzMkYyanUzeFJo?=
 =?utf-8?B?c1drT3BUS1JPS2dnUk0wNWIrZWlRckwxVXExc0pBMTZOVlpIQmp1eE1DM3B2?=
 =?utf-8?B?SitMR0V1VXdjK1RnWnhiUDNRUDRINWZqckpRZkxnUXNGWXRsMjhjZm9ycDJ1?=
 =?utf-8?B?RytKbVI1dkppeVZhNkJ3a3owc0I3UlRkV29ucDY5em5HUnJnR29EOXR3K1Aw?=
 =?utf-8?B?bTEyMXcrNm9nOGZuTHhDVWdhdFNvcHg5aUUyNnlpcW1MY1B6RlY2a1o0dGhT?=
 =?utf-8?B?b0M2cERlaWVCMVJ0Y1NJS21tNUpSU1NxNjR2UUZ5alpCNlc2bEN5cXgzeEVv?=
 =?utf-8?B?MXNaTWJPaWFMVXh1S0RsZzU3R2N3dVpuWDVWUU9INk45Njl5dWRsb1ZYbm9C?=
 =?utf-8?B?VDJEdEtxUlp0MnkyZG1EcGxqdmVSR1N6V0toQWd4OGROaFA5U0x1MUIyd29P?=
 =?utf-8?B?dzZpYmY4cHBncVBTQnZOcmhjS1hqZmxJRzNqUkxkbVo5cFhIZm5uMVRSK2Zu?=
 =?utf-8?B?ajRhZ2ZBWDZTWXJUSkJ5d1NFZjNIWnF3MGh0WnFmYjN0bm1kN2FoK3hXNUxP?=
 =?utf-8?B?b0xndUJxSCtQR2o4MVFWVm5ob21PTG01NlZreWhVVkRsZHAzZURCSG9YOG9w?=
 =?utf-8?B?cEVQbDgvZ2Z6WlVQV3M4dGtUejJxa1pJdTVMOUZDN2hVMWJrbnd5UC80SVBX?=
 =?utf-8?B?cE5UMEpVbnk3SUlQL25uWmZkNVBrL28vL3ZJbzlCTkwzaGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUp1ZlhnT2kyaXNpRFNnMFk1RGhTY0ZjWk1IcHhIbWRiM0pCeTNPNVJVZm5t?=
 =?utf-8?B?V21xL1BxVjVkSlh0M1ZvdjFKVGxSTkRqZ0JvK01nemNMYmJhRFUxZ3NmaGFz?=
 =?utf-8?B?OTRXTkRGalBZT0ptYzRjaEZQUTRkYnZXeWVOalAySWx2em1DMXdMUWRlY0o1?=
 =?utf-8?B?N05sMUU4eGFOQVRnaEloKzZ0dEhsdmVoM0RKN2x5U3kvL3hXRVFWZW8zNHFy?=
 =?utf-8?B?U0ZpTEpieWVvUFFHNjhiQXV0L3QvZU8vRHhaTzFRTzFGRDBMMXVjV0J4VENM?=
 =?utf-8?B?MDQ0ZlF2QUhjQUpGclhXYnZSNmdydFg2RlBMelQrUkhrVTB5OVc4bzhjRGxR?=
 =?utf-8?B?RGxydy8yZXAyemMrazJrM1NEVHQ2WjR1Q0FRcjdXbmVqcC9Lb2RnRnRaa1Bk?=
 =?utf-8?B?VEVuMnNWSHFPYTFEK3QwM3ZwTXJraGY0RU4wN29aOFM0UFI1SWcvWXFjVjFk?=
 =?utf-8?B?OWJBdzNHUVRaMkh3b1RIblVVQkg1Nk9BVGw2TXpwU0YyYTBPQlNMVXRWNHl6?=
 =?utf-8?B?eExGTVlEWDJ6TklBTCtiaGRpUGFoNzFSMmZ0V2R5dEhocGtmZEU2RnJ2Smcw?=
 =?utf-8?B?Q2IrTFRwZzkvd3ljckp0cmZjNW9pMDNHSi9jbURKanlSY1FqTUZlMEJRdmt2?=
 =?utf-8?B?dmpoNm9Taml1cHBnUVBxRXZrNWR6WUxpbzNUbGNJQnNqaUpwSzBlZnpRM0Zi?=
 =?utf-8?B?eWllZURaMFIvbGdub2VCWCtUdG9PY2kzTDl5Nm41eSt5QzlNRWltVGJIMWVU?=
 =?utf-8?B?NGJaNmFuZE8vM1laUitRTGJlcFZuMFBKQzVjR3ZJWmM5NlF4NVdBWlVxcnZw?=
 =?utf-8?B?OFZGdUEwZlhndlI5QXhwdjB4ZUZPOHM3QjI5WnkyMGUrYzEvRy9KNzNyaVlE?=
 =?utf-8?B?eGRSUGw4VExCbjA2Mk4yZjZnMnBXVFJTUTlzSENMWW1XaFNRQ0FqSmpESW1G?=
 =?utf-8?B?ejhLRHNuZCtlUjFNenNPTG96RmJRdERxZWdGaytVMnVTYW1KM01sbVFTaGJB?=
 =?utf-8?B?Y0p1bTgraWxObFlxYktSZ2xmWkE2ZXV0MlA4NHVOM25SZVNPZmtyUXp4WS91?=
 =?utf-8?B?TVREVXRFZndUbmRvVGVtQmFpS1MzQ3R0L01SQkRXaFpKNngxSkRWZmFGTHJi?=
 =?utf-8?B?M0l2cTg1R3dpaGUwOHlHRFY1eXYrL2NoRE1uUnVmNHFKb2crbHgzTUw0RkZr?=
 =?utf-8?B?aGgxWjh6WTZ0bkdZOE9LdFZ4dHU2ZTJJcW1MTU9JUm45Y2VpcHRmQzJIYjRL?=
 =?utf-8?B?TExzMDk2bHRTLzNRaDdnMm1Gcit2OFVycEhCVUh0RjMrdVZ3bkxibU9aS0Mw?=
 =?utf-8?B?dXRQZVQwejFNWjZtQ1pGQ3JRcWhZSnQwcWxVYlY4ZkRia0ZaRUl5Z1YveEZQ?=
 =?utf-8?B?b0JDZFhDSEZ4djJGZmx3dEErM1R1MWtPVFREN05RSUJtdjUraDhTQUk5c1Nv?=
 =?utf-8?B?TFRXSC9BUStvZ1hXTG5SNkFmb3VJTHdzbGxLUzZkSVlQL0RTcGg3OU0yUEp4?=
 =?utf-8?B?RjhTYjc1cjF5S09Fck9oT0Rhd3NyUWtlWVBRS2NCSDBic0R5aEhUaVhZb1RE?=
 =?utf-8?B?a3NJUnNIYVVhdFcvbUFlMC8wUURKZTIzd00rYVNWSHN0Q1JKSkdZY3FHelFK?=
 =?utf-8?B?eGZweVlPUExZVEw2aWxhOGMycDY1VVpRVFg5Yjk2L2w5aEZ1dDZwbTc5VWN2?=
 =?utf-8?B?Zm1vYyt3UnVtK1phVTNTVkt5K1NzQUp5SG1SMXU5Y1hvNHZYZHAxd3Q0VUgv?=
 =?utf-8?B?Mkpka3VRRW9paTdnYStDb2xTMWsrTTJuOEJDaENBeXhOZ1RYeEtLTGdoVFlo?=
 =?utf-8?B?Sk5EZkkxYTNrWXZwYmxiTENaSUxyL1haSkdlbUtYak1BWFROZ2Z3YWorb1Ey?=
 =?utf-8?B?MVlWMk5nbUxLa0lXajB0cTlVaERueE1nQmc2SE9SaUpwalEwTFltbFVLeTFD?=
 =?utf-8?B?alEyUTRqZ3BrMTUrL01EWmt4Vyt5Y2dwUEQ4V1I4MDh4S3M5LzUyMVdhdzNu?=
 =?utf-8?B?R1FvMFA2cVZHdUZnVlpWcXdoamNBdysrYjdsbVhqeVBMeTY5TXlnelRFa0NI?=
 =?utf-8?B?UzhnZUlGdmUwUXJPVFdKdEJndmQweEViMG9kcCtYczRVZnJubCtzUlR6MytU?=
 =?utf-8?B?U2NqM1hkNmkxbUlheTBnVWhVUHBLQ0o5OUMwdWYrSHlTbjBvL2x5UC9jMjJW?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 143ca835-0682-4471-cd68-08ddd55b1aa8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 02:35:42.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqsiKLn3U+qzwELrqQDsQdVVr6EO4tUzI+4Co1TGik2hCh28wjHbyxVBHowRA0m4XAigKB/wcRhtfH0KpcqzGxabF54kHOep5XOxt5FVg3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > > > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > > > new file mode 100644
> > > > index 000000000000..0784cc436dd3
> > > > --- /dev/null
> > > > +++ b/drivers/pci/tsm.c
> > > > @@ -0,0 +1,554 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * TEE Security Manager for the TEE Device Interface Security Protocol
> > > > + * (TDISP, PCIe r6.1 sec 11)
> > > > + *
> > > > + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> > > > + */  
> > >   
> > > > +static void tsm_remove(struct pci_tsm *tsm)
> > > > +{
> > > > +	struct pci_dev *pdev;
> > > > +
> > > > +	if (!tsm)  
> > > 
> > > You protect against this in the DEFINE_FREE() so probably safe
> > > to assume it is always set if we get here.  
> > 
> > It is safe, but I would rather not require reading other code to
> > understand the expectation that some callers may unconditionally call
> > this routine.
> 
> I think a function like remove being called on 'nothing' should
> pretty much always be a bug, but meh, up to you.

I should have noted earlier that tsm_probe() on subfunctions might fail
without failing the 'connect' operation and unwinding the subfunctions
that did probe successfully. tsm_probe() should rarely fail, it is just
subject to kmalloc(GFP_KERNEL) failure in most cases.

So at shutdown time tsm_remove() will opportunistically cleanup just the
subfunctions that probed.

