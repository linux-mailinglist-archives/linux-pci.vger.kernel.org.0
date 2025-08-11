Return-Path: <linux-pci+bounces-33794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C6B216BE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 22:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FD1A247DF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAAA1DE4C4;
	Mon, 11 Aug 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMloxXsF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF62DA742;
	Mon, 11 Aug 2025 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945268; cv=fail; b=oalRGu8n4F2Ak1yGl/a1IzGV2W8NFUFpZFM71QjFewZokXuqk95DVtj2tooVMk1TxVxF6aMBKz4dBcOIk17pzGI9T1EN0jw2cheW+4/NbQtTVbj1903gSsRG7X5NC2NImLRz4YCM8Qm1vfkKP+959IpMdogL7r831oMm42XaHVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945268; c=relaxed/simple;
	bh=gF+L8ACrY7MYJIzqz0pNwhPrMNX5sP1viZZwbzqXBXY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=kCMe5oTuN6JDnFRqheS5AAYRtg2ktsQQgU3OlUNo4nP/C0llWDLBVQfdivYuXQ1p9Df9WVnD9YsNO9Kj70vKG/F4PpAkW7CMIcAw1G8QKpSrDHwNRTK4w88r1e8W9Hg9uRC67/XXI5nheTSObQxERbT9fTLIcesvLEFFYE5b+Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMloxXsF; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754945265; x=1786481265;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=gF+L8ACrY7MYJIzqz0pNwhPrMNX5sP1viZZwbzqXBXY=;
  b=NMloxXsFKrIbCOPfjPv3U3AYZpX+GyLiZdRO6vu+yLiSzjlbHD0C3xQr
   LGZgUjfq4Im8vj4N54ucy0kxZmr8/p9lZrzQbTKoUSABNT0VoJqZn3btp
   vvcK1+PD1trS4RwvMzJ/9DYhraKwrMi8OwGQg1+OGk5X7An0Y6SsmA7vK
   VSn7qkq5lg1ysl1HpGxXP4Mg7IBOwl6TKlviEi6jWSWK6pJ+W8+/qKeFk
   vAlbFVxxWP8i0oypthGqOWV2ITMli+crOYdcvZMI3HB25Rk3KM5RVGuDL
   D/3qABq6y9Y5+R0H6Z227QqYVR6bO6XH11NlguzxEA4Ffc3Dp+QZWwhX+
   w==;
X-CSE-ConnectionGUID: Wv/arq8OTimIaQ8cJIgUKA==
X-CSE-MsgGUID: B0y/WN8WQVGL2YcYLPtlGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57164214"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57164214"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 13:47:43 -0700
X-CSE-ConnectionGUID: nPRLb7T5TXOFggArLa8bPg==
X-CSE-MsgGUID: b+lBGGwXRxyH5yzArX6a/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170150293"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 13:47:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 13:47:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 13:47:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.53)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 13:47:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvHAlAR+rSW6FKJhyrSR5soWASoWb69/ws5ex1ZKw1vogC2l3RQ8cuk3wurRkaRXEP0VgwgnuSaorGm9X4dn5mRHMbjPQmOPFemQ7HRliEiTJ/sVTcrxFZkI1F2C9tF3k8OAaw+7bEaR3X2TFvSPLR1VhIWMWm5oxRUY/rb1sk27hSXDH9Cs+tNJ8iwY/Z/cR0tN3k8EYIc21XIpYNpxRAcLkXw3sqgLfi+Yv3Fp2/NFse6Km/VGL1RukCtl2dEIk3Opsl8tkSj9YMf38hvktW2xicISD6bR/0Go+MWWIg9CNhCpmhjOSBv06Vr3KYNusAGXewY86kdk/4jMx5zOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5w3O48g4sYnBzvD84HNWWoX+T+sZy9orVRzX3nme/M=;
 b=bfFw1+Ge3cKtDHhs2AeUWAJp6eMjilYh30lS7tGAe8Q/szKhfAqh+AhzWT00spsC9Kv7Sxn5yEF7ZHC/me7aAFTJJiMj/EYBr61ccUdoYC/FXO6GtgpOP4oBq4hf+8ZEmfhu+C6cIfPGD5ZcRmLRfxsfwtuqwgcKfBeSemPwJtIjZ00ztD1Ft5+mK2k0OGxcSYbFGUU/VhpJHw99aW1WSlZez7bFlWqIXF9IvRDmwwjXATQmCMY51njC4AplVwOtzAdCEC2g0rj8IGpR9Xosvyk4YZiigDxjy5AeLtGKuqagdCKebVXRCSR7YhbkEszwJH6cWgI1s4lyuinKX4Kkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 20:47:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 20:47:40 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 11 Aug 2025 13:47:38 -0700
To: Gerd Hoffmann <kraxel@redhat.com>, <dan.j.williams@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <689a56ea3e8d4_270910076@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <mckkt3aiggiqogigbms4kcysaaqw5toieot5vvfw55smti4acr@mbwb2oe6jp7g>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-6-dan.j.williams@intel.com>
 <20250729161643.000023e7@huawei.com>
 <6892c9fe760_55f09100d4@dwillia2-xfh.jf.intel.com.notmuch>
 <20250806121625.00001556@huawei.com>
 <68939feeef7d9_55f09100c7@dwillia2-xfh.jf.intel.com.notmuch>
 <mckkt3aiggiqogigbms4kcysaaqw5toieot5vvfw55smti4acr@mbwb2oe6jp7g>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI device-security
 bus + endpoint sample
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4584fb-47f1-45c9-ce10-08ddd9185041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkFRY2FNL3RVZEpMZmhWdGNzUng1NlBpekxFTVpCeVA4S2JYQkFSWGhQR3Ft?=
 =?utf-8?B?aXk3OFdoSlZkRk5GdENUU3lVbUZsUHRjd3FIRXZvQlRQNEU2SDErcys0Z3o1?=
 =?utf-8?B?YkpISlJFL2RlL0dESktvTS94cFo4eC84VWcxOVZhYkxMT2ZlTE9jNUljRzJK?=
 =?utf-8?B?clpyOWhJWWR4cVZqYWRNb201d2JHUG1WTFEzK0ZuZmhpajBxdVh0T1NNdjR2?=
 =?utf-8?B?OWRmZ2pvLys0YWJSNUJZeWI4RUY4SW0rcnpaUkF1ck5SZWsrcDViQ1daWFV4?=
 =?utf-8?B?ZEp6ZHdvSXl6VXVYaFpyV3BLY0R1UnZxYkxYbmkvNlVDcDNHdEhYLzQvNGlx?=
 =?utf-8?B?VDVyZ2JFZVBNaEw0aGlCSDViWmRUN0NtN3ZDNTgxMHZBamt3Q0tsUVhpL1hh?=
 =?utf-8?B?aVg4b3ZjWWxNeUxFNUE3eHh6Mk90c3dXYWdXZjRNREJqVEgvVzVYK1BTcjYw?=
 =?utf-8?B?UnJnQVh3cElNWnVvcVFJUEdMcFEyZXB5RkdtYng5M3ppRXI4UWdXOHltbWdC?=
 =?utf-8?B?VzhmSzZoTHBPdXovdDFQRmpBY005UjZWazhmMGVJMzJSOEFheXpmZGk5Nm5s?=
 =?utf-8?B?YW80S21keVJBa1hvN0wzMy9vWDFTZDRRRFVPZWFmWWd6OHRGMUVKcTNqY1Zu?=
 =?utf-8?B?RFRhQm5RRDdVQ1NzUmJMZ2EybGtxRFhQVWc5NmxTM3dja3ZlRzY3aTVyTVgz?=
 =?utf-8?B?OUNFVlZrVU0rQlFLOTB2NzYrd0E1QytrNk5sQ1ROMFV1cG1KZk5NM2JLai85?=
 =?utf-8?B?QWgxWnJoV05KTXBpOGtYU2xsK2JtbTlXa21ZK0EvYjBFelFoN0ZsbG9JTkpr?=
 =?utf-8?B?T2NkN0FRRUoxSjdWQ21DVjl5N1ltdkJBTnJ3WnhySWM1WnMwM3pRQ2syeFpT?=
 =?utf-8?B?bTV6UW9ZbUlmMEoxbi9QWHRROE9velZ5aWwxT2VYV0NzSDJ5MENyenRodS9N?=
 =?utf-8?B?akd1eStKUGNTczlVUEV2TkE3SlJsVCsreTdpMWxORkpISG5vQ05wc1lhaTZL?=
 =?utf-8?B?c2lSQ2JKamdsN0ppQ2Jrc1JyWmpmQUY4em5yRVRhcnhTOUljdldiTUI3R0pX?=
 =?utf-8?B?a1M1d1IwcGFBTHR3Y2hoQXlNQnZaMHE4cTN3cHdQWE1ONHNSYy83L0lGbER3?=
 =?utf-8?B?NGtIWUpvSFlmMjd6dU42SXgzSFNJV1A3K0xtVlp1L3NkVXNjQjhkUzA5Sk9I?=
 =?utf-8?B?Uis5WEY3NWlvZ1BsNUx4ODc1d2pJQTg1SW9xSGNjRzd4aEtFQmhCS0FtN2Q5?=
 =?utf-8?B?WkRBYUM5Z0hmbnEvd3ROa0hJWXRuaUhlTSsrQXRTM1djNVRJQjRpZnZkRlFF?=
 =?utf-8?B?YzNocEp6R0gwYzV6aWk4RnlZWGtQQ2ZVM2t3M1VHYWVvRHBTd254dVdKR2Yz?=
 =?utf-8?B?c0FoZ1dVbVA1Q1FEejVFNWEyc1pRQ01mNmxUVzBVeHBOaEtlbWhqSUR6RG5o?=
 =?utf-8?B?RThzdGZpT3JrZE9xaTloMVlhTndNVVRPZjdDRjBaaGN3OTJQQ3hIWm1yUmF6?=
 =?utf-8?B?MTYvLzg0RVVSbkhYK01pUGlnQS9JQnVDQm5pMnphc1BqdDkyOVA0bE1OLzUx?=
 =?utf-8?B?cGRYdkptRUVOQWFxL0JUTk0xMnpIakZ6YzhXZUFhOUtNZVI2cm54bHJRUEVG?=
 =?utf-8?B?WW84RHE5U0U2OENybFc4RzYxbG42ZjVwSGhVSXoweitqRjFhbWJxeThsU0FM?=
 =?utf-8?B?dVlLS2plYkM4a2JwMStwY1daTHlKeWZBeG9XbFlFNkdjdlhOWGJFM2xrNmdw?=
 =?utf-8?B?M005bVBsNUFqdTlrdFlKWG5wNUVIUHlvZHRwV2IyR09ZQVdFaWRES2txSEVS?=
 =?utf-8?B?NEFBTjNBOVl5UmlTTDJLOTVkZkZrdlNYb2IyNG0xT0xGdlZ4Y1MwaEcvVEJp?=
 =?utf-8?B?NVdwNmNKNjFESlFGem9pL1lWR29kYmp3TFVkVURQdTY1bWRFd25SNlIra2FE?=
 =?utf-8?Q?eba3LyvVwUM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9idGVFRGR1eXBUYjhNWGV2ZkFBdDJDc2lpT3VMMFJXTlhHUVprTWV0TTJC?=
 =?utf-8?B?eS9lWWZOR1VsVWx3TXBMbUlxZHVsTmJUYzU3b1B3NFQ4MTA5Umw5Q1lQS3Vm?=
 =?utf-8?B?dTljaW5xNW9pZGVsOWxrUHJ3VDZodE5OZlJqYTBkZm9ZVkcxYUloOHg1cWp5?=
 =?utf-8?B?c2E5N1VjQ2ozdUVGNzJGNXZ5MlpGMExpeEtFa014MW5hSG80Vm9QNmo5Wm5D?=
 =?utf-8?B?TURDSFJPVTRYWXNueFpIQjBKa201RXFqNnNxSHprc1JRWFdwaEhQNEQvTUx5?=
 =?utf-8?B?OFA4WEdRNVpMZ3BXN29VWG00RWJuTkRtMnpiZ21ERmZXaW96S2FkcHZDR2NW?=
 =?utf-8?B?Qml6dlZlcURIOHdaaTNUV2xBZHh6ZDZnaGd3SnpRek5FYzhQOE1mV0JGZFpW?=
 =?utf-8?B?aENYenRFY0VWQkt5eHNkaytWQWxUQ1IzUFNYS3gyQkVqSWxCaU0vbDdJYjdU?=
 =?utf-8?B?dytjSHZRODJtUWpONFM0RkFLT1RqWTcwdU85VTdmUEx0U0FnWHAxZUs1VWNY?=
 =?utf-8?B?MnRSc3lsUFE2akVaUVI1THFRZTZSL05kTCtKaW9IYkc4L3ljdis2UDhUaFJ2?=
 =?utf-8?B?OGJGdFVraDAzWG0ydmY2MTRiRXhYSkh2RXo0b25keHJMSFhKSi9KclFpVDlD?=
 =?utf-8?B?ZmlDNStMM21kdGJMWlFjcGNmcnV1eGM2MlpPbk1FSW1nUUJjaGl3RnhMZTRn?=
 =?utf-8?B?WWdyeVB6NU1BQkpra2MwSFZSYkJ4S2lGVkVPK2dpRUZvZU85a2xPM29xSlU2?=
 =?utf-8?B?c1Rrdmc5YWdFVGdURm9sUGV0ZzA4KzQ2UkptUHBRbjFjRWdVNmF4QmE4dnJ6?=
 =?utf-8?B?VHNCK1BydWFYQVR2eFAxanVGWFF3eGZPS1FSWWhqLzFqa0FpME5rZHlWUGEr?=
 =?utf-8?B?K1ZBcXE4R3RQeVFvVmpyWmdPNkxhbG9oT1pINVV0RWtIZkRsRlcrTW9nTWt6?=
 =?utf-8?B?cEZDSXlzMzQzSDZYSnp2QXc3ZENuSmhmOFYzRUdheXBibSs0SnNLbTB0WHJi?=
 =?utf-8?B?NjNpOUgySnFodFY4bzl6ZHkzd1hqdEVvS3p4QzRDZTJLdzYvajdWS3RvSFNm?=
 =?utf-8?B?ZUR3YXdXQ1FYRFlDYnozVmFIOVA3NmdtbkNLTWpDNi9zbEFrVFQ2R0p2Nm5k?=
 =?utf-8?B?OW9qRWpMWkkvNDRmM3htVk5JNzdaVTlKWkJIc2g1aE5HSXFVZEFsZk1CTi9o?=
 =?utf-8?B?N21Uc0d2dGdMcm1CVWZ6QTRLL1VzY0Vub0ZUTytOVXhURkdwU2pjQks0SnJ4?=
 =?utf-8?B?Z3dnOHhaVHVrT29VT3hraSsyQmxvVVB0TmJTNU5MSUgreTVPZ3BZaE1lY2NT?=
 =?utf-8?B?ZjQvS04xczd3cDNnMFFadVNldkxDQTRpRUMyMWhjVEFmSmo5QS96TGJyRGxG?=
 =?utf-8?B?SkVEaGR6Y3pxZUNSbUhjRGpzeDFXRzFuc2FaMzFyZWdkQkVnM1Q5bEIycU11?=
 =?utf-8?B?c1E0L2N6dy9xVkpLS0lQM3dpUHBnMEJnYy9Va04wakpKb0JKSVVDdStRaHNa?=
 =?utf-8?B?SnA3M2plaFJjYTY4OTJiMG4xYWR5c1pmSS8zWGFxRXJHT3k4dTBlS0dWOXZs?=
 =?utf-8?B?d0p2L29NTWlFTG9rYko2Mnp1RktzNDBpN1VYNGV5RnhtbDZBRTR0cDJoMThE?=
 =?utf-8?B?WDcvUS9sRTlXNFB1dmtPMnBzZGp5bnNHSTZSaTJLMk1xcDlOR3h1K2kwYzV2?=
 =?utf-8?B?RnpFcUtpZ2dTZmlMVTFTRGxSRnRzbVdpWVNPVFpmVkpyeVErQmV4MTZSZUl2?=
 =?utf-8?B?Nnc1SVA0YUp3b0ZMMSt5ZzBMS2lINE9sa25sZWRtditlaG9zblYyL0QrZjVl?=
 =?utf-8?B?U1o3Y0NDZG51ZjVGUy9RTWxZTXdvVi96WWdBaWVKNldPcUdWVURzTWtMblpJ?=
 =?utf-8?B?azRzaVEyd2Y5ZTd1c3I2STZUT28yNVlwcDdjbFhpeXZTMzNudElDcFZKQnNO?=
 =?utf-8?B?WXlnSjNsbkRFck5CZ0QydGFibFN5WVlEZUQ4ckNaL3l0NmxXSlpGN1RTeEtW?=
 =?utf-8?B?ekU2T2lwVUl6NXBydC81ck1VRzI4b3ZkNCtPcCtGUE9qOTBtNGVEL3JiRHlI?=
 =?utf-8?B?R2pZVi8yZi9yNEVwQ3UyRGgrOFpLMzZrcUNmTUdXdmJvUXF2eWcwNHA2RzZo?=
 =?utf-8?B?bFVkcTRDQVJaeVdPWHNiaG9LeGltajBCUkhCbXZybjZSa1VETFNBaUF1bXFW?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4584fb-47f1-45c9-ce10-08ddd9185041
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 20:47:40.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuaRZGTw1zklb5wWP0npLKicMsvoTzeS8yCnDYA5m8csLLFtNXhUYAyy2Y9QIUUd3vhGQtoVPRu9rT++XvPeY4trEZ0dmU3jEUmWUUm49H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
X-OriginatorOrg: intel.com

Gerd Hoffmann wrote:
> On Wed, Aug 06, 2025 at 11:33:18AM -0700, dan.j.williams@intel.com wrote:
> > Jonathan Cameron wrote:
> > > 
> > > +CC Gerd, of off chance we can use a Redhat PCI device ID for kernel
> > > emulation similar to those they let Qemu use.
> > > 
> > [..]
> > > > > Emulating something real?  If not maybe we should get an ID from another space
> > > > > (or reserve this one ;)  
> > > > 
> > > > I am happy to switch to something else, but no, I do not have time to
> > > > chase this through PCI SIG. I do not expect this id to cause conflicts,
> > > > but no guarantees.
> > > 
> > > Nothing to do with the SIG - you definitely don't want to try talking them
> > > into giving a Vendor ID for the kernel.  That's an Intel ID so you need to find
> > > the owner of whatever tracker Intel uses for these.
> > 
> > About the same level of difficulty...
> > 
> > > Or maybe we can ask for one of the Redhat ones (maintained by Gerd).
> 
> Well, they are meant for virtual devices emulated by qemu (and the
> registry is docs/specs/pci-ids.rst in the qemu repo).
> 
> We made exceptions to that rule before (linux/samples/vfio-mdev/mdpy.c
> got one for example).  So feel free to try sending a patch with an
> update to qemu-devel.  There should be a /good/ explanation why you want
> go that route, and "I'm to lazy to get one from my employer" is not what
> I'd consider "good".  Also it's qemu release freeze and vacation season
> right now, so don't expect this process to be fast.

Thanks for the details Gerd. IIUC that samples/vfio-mdev/ example is for
a functional use case. samples/devsec/ is not a functional use case. It
does not need an exclusive id to enable some limited unit testing. If
samples/devsec/ ever causes real world conflict the resolution is turn
it off / refrain from loading it.

