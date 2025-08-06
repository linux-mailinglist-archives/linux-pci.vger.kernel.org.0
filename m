Return-Path: <linux-pci+bounces-33495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E64B1CF17
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 00:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C69188FE0F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1C143748;
	Wed,  6 Aug 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="har5IFEa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08651F5842;
	Wed,  6 Aug 2025 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519434; cv=fail; b=da9b6xCqy8rXyoLK/zWHfaGvgDNrzvB96hDdzAiuYd4jUAAW9jKTLH0BmkiOwLYwWP8Tk1KRZZ441WXClgl4RE3M8N2wW/mhCRHLYWNNfqkD4+gsoBioHi7WqWdjlEy3H5q8BKF4fBBgIINaHubEcTKZubkTvwIu+EmQQrY3Fw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519434; c=relaxed/simple;
	bh=0GuNu/T0XOGto7yPKqZWi34ydC1dw3wBjj1UV7HH4Gc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=hVi5Ob20f57WJgAsBkqhZm+vxUBfyRUxpeuGlY4IlGvkwX1xIxhnpXODTV8gmF6CTT6c0HlML61Y4e/1PTHREz8gwMu3t85xhyh/R94NTvEB4Kl2mkHPt/a6k0l4w6b+37IrtXDL6ou8S2IWJqSQOBFpwPogB4qBu6IZnjPCMT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=har5IFEa; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754519433; x=1786055433;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=0GuNu/T0XOGto7yPKqZWi34ydC1dw3wBjj1UV7HH4Gc=;
  b=har5IFEa8GYDqFeKfzV2DXtEvxlDxCHeB3xkSrkD8cLCoplkHUvodOcJ
   HvDy+lLds0KriZnb6yiJ4hxgYo6Id0dE/2UfyOyeyNZIwR80xWlWwm0MI
   u2MR2kiY8z1YqY9WtX2zBEzqmBawIFIoZfrBmEVuuqJCPBEcZB3zKYGMq
   iyW8X+gljLL9m7R4N+0mvWvuRBpXMDSND4EBr8mu++bjoeH4mwU1n35gq
   Xq9FUbr4u9gJZAIYoA2pGLw8Rh1HnNL0yVLjc+XznMClOVq9jFp2UL1P4
   PwDxxS0hTJuTDQT9NAsnkhJWffmLeLRjlo6V6z1w8SUU4UNwgh/+muK/g
   w==;
X-CSE-ConnectionGUID: dicecZW2RuiLw1u7n+J2Yg==
X-CSE-MsgGUID: v27W7THJRPOlJYGKLkK+PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56813958"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56813958"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 15:30:33 -0700
X-CSE-ConnectionGUID: 1h0T5X+dSwiIJDao786xrg==
X-CSE-MsgGUID: z+KjilrNSG6WLQx5brXUxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165253935"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 15:30:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 15:30:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 15:30:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 15:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNxISKkz0pTpoKWj8ku4Y63cDacUYBOfm+eCJV26gIIMGkG86uhSKPM5fzzLqFwOB7lvtj6tkVuOea+xFMICxVVhCf1WXo/+aawaV96vQlwzFS0sGq8CvnhXklfTy/OKv6YIospCRVVmLVwiVqYhZOf9jn9TUK6hj4dPvCElqIcv9fJjf8nFyDkRT0zsze72ysfWCaNhcpVk5T5E9Qc13Fy0D7clS8NASRrfepepe42BZuPQDh9qxGF3FrqEIXFUkDo/UoX5byzSlKYOH42rh/qDmx4lIOkNu1Jqwa68NmcnocuA8hKkO/dTfRQvAgqYUucZvwLgAjv9QZvHchwBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nju5gjVpg1/b5DoFLiw9FBl1I9AWpOAIUHWSuB2nq/A=;
 b=eKvIflhWEx6PYW+2ED+it+0Jnr4hCbld+9art+IGMmNeg4mJRKv170sctQyCpzr6cAP0l90cWk1dTLwVy5rMOFx7DNCgI5GcZ2PGYUPp/6yHQPPYGfKZwJqOV3FIQ+U33Q5EkNu4bQ9eZNCv2X5FQiicLoGL5/lAEM9v1pH4+Qm5UHH+L/Vg0CSs3Ts9UjtC0wCxks/+8P146r4Rysa4DZvPpHkT5a0FrXbcJWmh/LboCUuk52MophVYNGXB1xK8ZJAZ42WDdSu8frUbRJJ/Wvg81ztVx0nrFZpeot+cr8g+i57y9RB1RHhYA8+qtDFIcNWWa0D3h6kE06Zx5oy2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 22:30:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 22:30:28 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 15:30:25 -0700
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Message-ID: <6893d781a2543_55f0910095@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aJIo4riWyW7fRtal@yilunxu-OptiPlex-7050>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
 <aJIo4riWyW7fRtal@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f733d47-b38f-4219-3a7d-08ddd538d83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDd6Vm1ya3hoWGxKS3dxK0Z4UnBkZ2ZnNnFXcEwvQ0QzZHRPREVJTjBPVk82?=
 =?utf-8?B?VWFoWUxBeTEvWmRwZVlUY3JxMW5uRjUzd1dhQ016RCtWeUV1R0lNZ0k1clBW?=
 =?utf-8?B?NWJwMXpZTG5IQmhlbFdiaHF0d21CWjg4NERIZ2c0SndXeGd1WCtxYzVtTEty?=
 =?utf-8?B?Mk1FTmp0NmpmbUJsc3hUdjFHNDkxOENXRnh4VnZveU9nOEpRK3FlRTNMMm04?=
 =?utf-8?B?bG5lSDNYUEJBWEJSR0dXa3JkUVBFdjFYVzNoKzltZVkxK0hYVkJKVjZURjZy?=
 =?utf-8?B?b2VveWJBUDFEMGJ4M3NZczZMai9yVm9MTlE1RzltMmxibi9tZS9FSllZMHpv?=
 =?utf-8?B?L1p1eVpzQVhMRVNpSVg2T0Z5UWQ2RS9jOHhvSjBoU2R2eFl1OHpLaGNCTy9T?=
 =?utf-8?B?ZUdHdkZpVnF2T2s4c1FKdkJZSkU1c1g0SlJsNUhwNFR2OU1jVmhETC84V1lv?=
 =?utf-8?B?Wmkvc2NrZUgwSXFRTzVXUGJ2K1ZTMVJOclRBVEErUmMyVXE0YTBPT2FuMWtH?=
 =?utf-8?B?Qi8rcUJJZkpFb3o0TkpOblQ2eW9lNnppTlQ2OXdBT3BwRVJZZHpBbE5kNk1x?=
 =?utf-8?B?SFFjbWZvZWJBQlF0WU4vMGpEU3NmZi91ZkF0YVB5NVNkNnNrNTB0TTR5VVJS?=
 =?utf-8?B?cklFbk9jelJUR3RPZkFQaTIwVFhwMjZySlhmQzV4OUt0QkQ1ZkV3VWF5WlQz?=
 =?utf-8?B?bVEvaDBRcmhqSjhGYkloR3B4RkMrdG9oS243UGYvQ1pROXFidmtkaXNnMEJF?=
 =?utf-8?B?V3BxZG52ZHpKQ2c5ZGxWY3gwR0Z4MTJYenlsZUlwTGFxS2ExbkFkWWYyaTJq?=
 =?utf-8?B?TExPT1lhbHducmpJZlQ0WVQxU01SSUtBN2p5RGVUYlk4RnNtN3dXSkJLQmJB?=
 =?utf-8?B?Sk1QelhsNTlHUTJKWDRwdUlKQ3lsandCSFlHV3NpNVlpZUoxclREK0xqMHJo?=
 =?utf-8?B?YTRNMkxVSkp1UHRJNVRIQTVnWmttbU1DTWRXQlhTTGZKbW16eWN3QnliVzZs?=
 =?utf-8?B?eTE2aVoyaGJYWlIxd2pUWXBlb3hITEVKejNNYlYrK0F0ZGZKNG5leFp1aW5p?=
 =?utf-8?B?SURSc0JUcUVCcWJJNHVDMXRqaEZIcUZ2NHYyZ2NwbXlHNitSdGN5ekpiVU5K?=
 =?utf-8?B?b1BnK2xIeVhreG1EcnkzYXJVNy8xd05mMU5udGxwMFRJZzZBR3l1MDhBWlgx?=
 =?utf-8?B?ODRXWnFYVE1Sb1p0N2dWaHgrK1JHemtTZ29hRCtUY2duaWRuZVlyTEIwczRj?=
 =?utf-8?B?NEtxUEZLZEFMb0tvSUtPYWVwZ21yNkVjcW1DSG5md1B0VVM0MC8ycXkrNDg5?=
 =?utf-8?B?UTZmc1dpVDNoeHU4a05tYUo5M1NOYW4wNnJuMWtJcmdLNkwvZXNrbTZEZXVl?=
 =?utf-8?B?YkludjNvVWpuNUFQcU44YWkyaXBPbkVodmFnMW5Wbjc5ZUhhVTl2Znh5NVgr?=
 =?utf-8?B?YlpzQlZlbVFpK2hwbGI5K3MrdHpmdGUvQUtiSkt6WjBjMFcrbmUzckZnTWM1?=
 =?utf-8?B?dW5mQUFPSVl6WHI2aXdacmd3bzI2aStYNjdoMUM3bkFUYnFUSU43bUhKclNC?=
 =?utf-8?B?UllNRlBocG1VNTAyY2h4R0xlbUJNdVg5WHNad0tFbXBVVWsvZURNVS8xcnJF?=
 =?utf-8?B?Ny9OQ3Q3Vjc2R1lZVmtzOWJUcFUzVHFSZXlTL0RuNUtwQzVsT1lxZXdnZGs3?=
 =?utf-8?B?akVpODQ1dnIwazZnZThibHpFdzdXeHRvZ0NSZys3anRoNTJKQVl3L1FsZFMz?=
 =?utf-8?B?SXB4VThseHVNY0N1R1Rod1p2Ui9zUGNNWndDYTdQMUxUenRGYjlqUWVxN000?=
 =?utf-8?B?WUxDQjIyT2o0azNEQWk2aHRnWGpUdzN0bTR6bWwrM0xLWXA4N0IwL2g2OHIv?=
 =?utf-8?B?ODdRMCtvR2tNZFAzRGEybkFaSVN4Vnp3Q2V2U0p2OXM5cEJkTXMxZG5GZ2di?=
 =?utf-8?Q?3Oi9WQf/6KE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2x2bVZ1TnN6OURRdnJXaFF4enBmRU1vaTN4Z3hEdHpEZnlQQjMwNjhHemYv?=
 =?utf-8?B?Z0d3VEJCaFVBSmZ2VmxkMnlMdHFBYXU4UVBhZUJrSTduYnBRK2dIS1Ivbzd1?=
 =?utf-8?B?WjlZM2hyUXBzWTdhUC9CRENZZXZ2MTlmVjNiOS9nUXU4VTh4enI2dVlVRjlv?=
 =?utf-8?B?N2lBcE92SWhhODBHd3VTUkZHR0ZuYzkyV0VUQUJTbC8xQXg0SnhHSEljK2ZI?=
 =?utf-8?B?cGdjSUVqZ2wzYmZnZFVKNDZBcnRLWHNWWGNiSWhUcDU5czlmV24yelFEV01Z?=
 =?utf-8?B?Y1RkMzhHWUdMRjVxOWE2RFM0dis5aUo1TG9rUjlXcFZDVDJ0bm54V0pZQ2Iw?=
 =?utf-8?B?Ky9HdFUrN3ErTlRzUmpaVGRDWjg3MDZGemZ2dWFMNURQeHhyQU9iNmJsOU4w?=
 =?utf-8?B?bW5jN01MRmJwdUtNZFhSSGFITDhJRWxVY3dWR3lWdW1xYkI0SURPNi93enNw?=
 =?utf-8?B?MXhsTDBPRTFaNDRWNGFvUlpidzN1aHFyR2FkYlpJd0NPZU9TU294RU40N3l0?=
 =?utf-8?B?MG1nR2FxNDhXQ3lrUVpldUVJVnU1bEVNT21Wd0hGdFdYUi9FTExEbE9oUVc4?=
 =?utf-8?B?ejVDZ2lDQjVxRW9maDdiSlE5cFpBRC9ncnNHSEtXbERZMVNPbjFoTzFIdmdO?=
 =?utf-8?B?c0NVbVVUdEJmZmplZDk4UGZUL3RtREVMM0lkUU51YXRlcTRTQlBFK0VQK0kr?=
 =?utf-8?B?eHRWMWN5Mlo2VGRIODJtNlF0QUtvRTViWnF4QVVlajliODlMSmJkeDk0Tklt?=
 =?utf-8?B?eENWNnE1dEdqeHNQSHF2MllsWDk4YmJqYXRNdGhITjYxTEFiVEFNRHFBN1VZ?=
 =?utf-8?B?alJyMTF6MjFqbG1QQ05jV3F3cFNrMm9WckxLVS9ZSzBGWmxHbkwvcEVUZFFl?=
 =?utf-8?B?MEtHRXpJS09ZSmdvQlo2RVBna0hRRUM1Mld4RFVoakg5VGdBYjhDdmM4aXFz?=
 =?utf-8?B?TXVSd1pDQnFpZWdjTVNpQWV5TTlzU1F0N2toRzZaY010dHZPeHFPaVJEN3Z1?=
 =?utf-8?B?UE4vZTZxV1pTYmRyOG9PeUE5ZlVwU01ESHRzV2l1ZzVOcnVnekVxKzV6dmJh?=
 =?utf-8?B?NlFxTkRNd0hlcVVmSjZTZFVmUktlUzVnWkxkVWhoZmFVc2FHN091TXJMQWVW?=
 =?utf-8?B?cnJMSTRKYTNPRWppK0o2OTh5TjFySjRRT1N4SVlJVkFVNW9pOXBlL2czbklp?=
 =?utf-8?B?QkZUaTNuc084YU5COS9DWXVEbkl3Zy8vRGFMMFc1bmltN05xbUtmdzJ3QThu?=
 =?utf-8?B?T2VxbE1Ya0xqaHB3cTBFU0JUUS91V1BMYnlERHRISzZUMEh0LzVYS3hwR0V1?=
 =?utf-8?B?VHNjYWgrZXNqbmFKcThGeU9GSy9SY0JPNjlTM091TU1rb0FoVDRlVHpxL0Jh?=
 =?utf-8?B?WmRYVEg0ZXhaQUxlcG5CNkNadEFkaHkyKzBjclRZbkh3QUpjM09wWFRaK0N5?=
 =?utf-8?B?L2FmT1FOenF0YjExaC9KUjE3bmhMTjQrOFlxdXdyUXloT28vOXJQazVQbGM4?=
 =?utf-8?B?TDN5c25WZW9BUmNNaGFaWmFkenFkTU9HaGpFNHNKNDV1eWxmWUNRRnpIT2t5?=
 =?utf-8?B?U3NMMWFHWHArdlJ6bk9SekxnVUpkb1dhTzA4Qlh2K3paZ1g5S3FnaGtzTWpm?=
 =?utf-8?B?YUJSMVQ4UUFEOS8zQVBGRTRjWWJaZ28rTXBxekRseHYxZDY4UmJNeWdwQ2h1?=
 =?utf-8?B?SlNkODFmeThTaUdvdE1YU29IQzNFQWwya3FMVjdhcXc0bnBnelpkWEVKVWVw?=
 =?utf-8?B?WTZXYXhxSGI0T3RjSWtaTnRPTnBaRjgvL0svYldmdTZ1WXB2aVF4b3E5ajhP?=
 =?utf-8?B?d1QrVUN2R01kMzY4TllBbjRTcFdON0lRS1BXSlVnamNGd1ppZVBzZEJvdFgx?=
 =?utf-8?B?M3FxWDI0d1ZqdnNFSWh5RVV6a1dvMUZRL01JTVJCQTNOU2RLd1FYdWIxVURy?=
 =?utf-8?B?V3FFNTF4QnNGanRlMVVtdDhhellvZUZaaGlOb3UveGhmelF2UnptOGlqRnFj?=
 =?utf-8?B?VGd5UEl6eWxReFdWSE0zTm51aUVSOGljSUNBZ0ZQNVQzeWEvVnZPTGhqdDhS?=
 =?utf-8?B?R1ppQnNlQnVUR01hcU1aSFpsb2lSdS9sRWhaNnNnbFNmUStmK3JQZzJVdm9k?=
 =?utf-8?B?T2JyZWtQWXZKNUxXVUVSL3VENW9tOXoreVRtUFpqQlpaTGlBZlBnemdJRmJU?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f733d47-b38f-4219-3a7d-08ddd538d83f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 22:30:28.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY8VD0KVUyTYn5LXWn9cAIjqdqnvEcn2mD8Snl6D8QP25crKT/wiHHJ0LDY3lf5v2+LixJL9vrHUn+J6p4NlMLNAkdyTO/hlorfgxqivGnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com

Xu Yilun wrote:
[..]
> > +	for_each_pci_dev(pdev)
> > +		if (is_pci_tsm_pf0(pdev))
> > +			pf0_sysfs_enable(pdev);
> 
> Now the tsm attributes are exposed to user before ops->probe(), from
> user's POV, tsm link operation for this device is already ready ...
> 
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_tsm_register);
> 
> [...]
> 
> > +struct pci_tsm_ops {
> > +	/*
> > +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> > +	 * @probe: probe device for tsm link operation readiness, setup
> 
> So I think the probe callback is losing the meaning of readiness check.
> Users see the 'connect/disconnect', they write 'connect' and found
> errors no matter ->probe() fails or ->connect() fails.
> 
> Maybe just remove the responsibility of readiness check from ->probe(),
> I found it simplifies code when implementing tdx-tsm driver.

Oh true, that comment is now stale with this new organization as probe
is only about setting up any context to allow future operations. Any
"readiness" is determined in those follow-on operations, not probe.
Updated the comment to:

        /*
         * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
         * @probe: allocate context (wrap 'struct pci_tsm') for follow-on link
         *         operations
         * @remove: destroy link operations context 

