Return-Path: <linux-pci+bounces-33448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4ABB1BD98
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 01:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FA3169C83
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 23:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87F29DB76;
	Tue,  5 Aug 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ7LF/cq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2324113C;
	Tue,  5 Aug 2025 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437958; cv=fail; b=WpJCIQ1vzJHoZJOg7Ykmn/q1HXoUm+bx9JoFAsxAXoUy76neI+D+F4vEZENwJtien6ROHc6+OL51ed2WiaNxT0gMZRZgzKyZdLvpv74C/t/g1vBnAzZWiYO7xTQISsvS7viN6okVoRVEAzdEDNXWEK9IefX5wh4v0JxGiTraDWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437958; c=relaxed/simple;
	bh=26TB4QKZUiIfSCbk1/txGBIqZOKEo8OsQhQDpCXaZf0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=co7kG8mKFGyJiNSMAgFYlLH0Esw9kCjv4u5//I/lLnAATRIjRXdDb1YaRJArN1j0ilkSoSD2rHhQb7gv97P91x3XSyiGMVI3KZx9bGjBwJh8LceZY3fg5Rf4u6wsHBBU5bHWsZQ1e+4M/mhCikdLRjmK4ECIsmPQiDAMVz7CMq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJ7LF/cq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754437957; x=1785973957;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=26TB4QKZUiIfSCbk1/txGBIqZOKEo8OsQhQDpCXaZf0=;
  b=XJ7LF/cq/ywpRKiR5JzRNuIg7ubnx99i9FcLDr9fVjvR8JqrC+0aRiNN
   GcqSkIjtnAkxwSennA69e3TdxVWWNk512tqRv/6vswZcr9I78N8NrA5Vx
   iytkzImh7ObIKww2wrfRnuOnTGVJSH4RmcBAJv4jKLDhsIOIthai4uOKp
   oqfSalnaHgw1Z19lzGhJratE25J+Bf3OTyQ7qBo6PPrwFDyzNAjJhCz5e
   yhWkkK3L13kKonNZHYgQ1gWI9FBoBRtdUStZRuKMEkmz6eTmchDYQcvvI
   OQexqEPcweyMdZ8Mpvzh4bBxrbUHwrWz7WSEqbBH9XJLBQ2oyeTNJTe4X
   Q==;
X-CSE-ConnectionGUID: +w5yNV99RqCDeedg5bAUHg==
X-CSE-MsgGUID: 6yjfsRFkSJCbiKB62xHmGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60579471"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60579471"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 16:52:37 -0700
X-CSE-ConnectionGUID: tLKI3RzYTf+LXtITKUACMA==
X-CSE-MsgGUID: 3sOiDsreSpCBH89idoy9ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165045555"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 16:52:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 16:52:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 16:52:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 5 Aug 2025 16:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA87CLr/A50S4wxOMw4clC0jQKJAidPxiqtl7+/F9fp4xRC/LNkf8A48sxXvEe4ve0E0RWQAQeYpiJMF2xVEjJP8pwicVhV2thHwMMPTvhF5Lp+OwPm9kMUMZtn5rgLmn9rOY6/I5wgQYKCtGa5cU0BIsNYskuZXntv9ThrRcx/QoHNzZhGaiPoYSJ1X8tTOuFpDCAq6HLh53tz0lFA61BiLd4bkAuIIycwo6UrTKVJB/rYu8kfrhxy+q/x+In5T4yNZwG+bvd7L18RtNJa1BMAAC+cEjDgXNYUzsTvMYJWsuF0xibKPTnud9dMTqPEr3Z1sQUomrUoSDMQKuQSM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0O8RAh9mFnXH4ylbePnGKS9W2JAarvMK2OoAtwo/ig=;
 b=wzLR55NgPawqWRqNJ8ggIPt6+5q5/zFqgMtd5rwHZfeJ1Y7gWXXAm1sfE1XDUj8Zvehf5eAIm2h0t0wc7LI/gt8CqKOHtn0aEgjV4QxPBmGp7Tt0sECRjUiM5mNA5yzQfD9qLizUjo00+GceEgyT5urA1TyeZwbCF9VAkUUnga85A8rfK0Hl/QXrPciTMHqDWrOGRLEcZN3E2KEfvJFAeqDTjZS/hLaF9w81T7gHqNeuyIdlcj9pyBWxJEWag42s0EcAmMuaHH3YlQXDu689U4Jv6TdvGR4z0HE1jjz1neKz5EKhx8E8z6icmurE6FmKU50kDrDx7uXX3Xnt18PcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6962.namprd11.prod.outlook.com (2603:10b6:930:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 23:52:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 23:52:33 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 16:52:31 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>
Message-ID: <6892993f3ed0e_55f0910079@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729140623.000068a8@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-4-dan.j.williams@intel.com>
 <20250729140623.000068a8@huawei.com>
Subject: Re: [PATCH v4 03/10] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: d57d113f-9df0-4062-dc05-08ddd47b2548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TldXUnFkRkN1VlBhdWlTa3lCMnNvUE9pZVZTRXZOQmVkbEZWWVlGSVBHUUxo?=
 =?utf-8?B?eTRyRHgyMkZpdmwyS0todG8rMEpmQ3V3ejk3V1FwYnNlS1hSYVR0WVptODlW?=
 =?utf-8?B?S1RlMDJjV3pMSytzeGl5TCtNU21mdktnS1p6VW0xblJOOG5tRWVNY3UzVGlk?=
 =?utf-8?B?Q0t1c0tteTdWempQdTkwdHdCMDN4UW0zOUpmQjZ1U3k1UEVranJJdXlTR3Bi?=
 =?utf-8?B?cFFvZ0MwZDZGd3RaZ2NTbEZIWlgwYUFGaERMb3dwZ0p3WXY4aFo2TTNrd2xX?=
 =?utf-8?B?MGdMcVp0TTAxYW5iZUlOMTJrR1lTRnhIeC9zQ2RqQWpncit2YzlseXdxeHZX?=
 =?utf-8?B?NVhweXNCeDl3T3k1bUVSSjZSZHpZeGJHZXc0R2IvTDkwc1loYnduLzhzaUFY?=
 =?utf-8?B?b25jdUlkdnhlZWd5Q1RRcjNxZGVvbG9yTDBNZ3JMMklsdEFGQlVRYlVVbjFF?=
 =?utf-8?B?R2xrT24yaHlOVlpBTkJyM3lMc0RLVFBjSUNiUzZSZGdUYWtsTEZ3VmNYV2tz?=
 =?utf-8?B?NHkxaVJxTkhJQnhPRjlIUlV0N0NBbXJWdk05Mmg2VzFZYkZjT0VQeURiT1R5?=
 =?utf-8?B?Nm5iUDJFWnV2TDM4WHllNW9wWm1lbjB4bFNkVlBwODNBR0pWYTJYdzE0SUkw?=
 =?utf-8?B?SjRqWTFSc3E2WDdWY1VXdVJmL2wyTUhGbXM4UWVpeVNKUWtrK3BNVElYQzAy?=
 =?utf-8?B?ZTh3V3BCZU5KaUlEMHdFTi9Yc2czM29Lek5rZEU5SlFSWmwzNXVsMStUYm1Y?=
 =?utf-8?B?eUdEWVNqQjArREoxRHJKZ3N1THdNQkgrd1ArZEdMQ3VZMlpod29RbW9WdkpJ?=
 =?utf-8?B?eXJ0MjNwMDV1OVlZaUNQYVM5NnlnOC9iZTR1Y0E3VnFGY3BFaC8vQWtlaHNN?=
 =?utf-8?B?YzJDcmxnemhCNmZDd01EVHBMQXl2bnpTKzlLMGRoaTI5K0V4dHA4N2ZYczhu?=
 =?utf-8?B?dGxDekpNYkdnaDQzalhSRlNsUXoxeHhieHBzaEdQSVFSU2dDc3ZUTTBSbEhM?=
 =?utf-8?B?UzZuWGdkdWEra2dXTUl6ZDA5YnFOZmZTbk42N1BZOTJkMUdLL3RpUWVleDlO?=
 =?utf-8?B?djU1WHk5c0thRmVLbVFKdDRRVlI5d05CbTVpNjdRSFNVS29sVlBldXFMN1hE?=
 =?utf-8?B?eDE0L0lDYlZvY1FaQmxrM05HeHExUnA2ZXc5OUFjYXlNa0lFMm4xTkNYU2N2?=
 =?utf-8?B?bnBPaWVjbkNKRXJNVGwxSForam1qVlkwaGhsT2ZaTWc3ekk2bFYzaXoxdi80?=
 =?utf-8?B?SkFZRlpTRmluQmdtOW05RDZVOHFtYnBUTlc5eW00cGFEc0RFNzVIWU5PVzVj?=
 =?utf-8?B?V2dwbjB0NkFyNU8wMVlSRHRtdG02MzlycW1zK0VYTkVaRkVPeCtrQXpjYUN6?=
 =?utf-8?B?UklkcG5Ia2NnRWlOZ291eGR1WWlnTG5tRG9ZZXdSMUwvdDVIV013U01ZaThy?=
 =?utf-8?B?KzZzMjIzMUhVMDVnd2R2ZFE1U0wrYWZCenZWREIxWnJZa2RvWDNmM0hZZlhj?=
 =?utf-8?B?SUp2NjNtUkRoQ3RYWWpQYjM2aGp1R1FWNCtGa0VHNXpaUlJIaE9LMmFneEV0?=
 =?utf-8?B?YTVRbnVqeWFBWnNMZE5YdkJlcGtKc1k4VGtyd3NTVHpYczBHbXZSRER2Z0Zn?=
 =?utf-8?B?NEQ3cEtCbEFpcXJndW42c0J5LzlRQjZZMnI0VVBDVW9LQUk1SVlnTjIwbjdp?=
 =?utf-8?B?T1BHMEpNanEyTzFCQzltOFhGSm5kcUV5NlQyUERUaXl6WXF1OGpkcjBGaW04?=
 =?utf-8?B?TU44cW95QTJrSzVqWFcvUEpDUXcvYjUwdG9DOXMvTG85SFJRTWVHM016dkt4?=
 =?utf-8?B?TEFET0gyRkpDczFrWEt5ZUo4N1c0VnVZMGVQRVpCN081U2kvajFyWkVaSTBO?=
 =?utf-8?B?emhSNHFqcDJ2V2laZXZLdUNKZXViL0JZamxXKzdzMm1BbUtVS3ZKWm1uMU9S?=
 =?utf-8?Q?/U85BmvISXg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzJhSWFRS2dSVGx2R2l4ckMvRHExaEhjKzFuSGFObGtnOWFCTWhtYnhnNDRJ?=
 =?utf-8?B?MlgxZjZ6WWM4T1lnUUFHK3I5Zzh5NHVVdHBCSGJuZ1VKeUZ1WjZQSzBzUDdS?=
 =?utf-8?B?cUZoczdRRHE4UGNtUzAzY0JJa3Y2SjB2dDFKNXJReG9uSzJJek9qV2h2MVR3?=
 =?utf-8?B?SmRPd3p3ZnN3WkNya1BZTkI1Y0dXQ09UTEFKdFBLN2FrZWJjb0ZxTE44MjFD?=
 =?utf-8?B?QTJQSXl1UUYvd2lOb29lSGxwU2ZvaWRPQ2NTRTNyYzl4cTg4ZXpFSHRvdUlR?=
 =?utf-8?B?elRyWFhRbFVjM0xZUjVuSnhaVHV5VDZyWUtYNmtOUldMNGY1c2JETnlObGZw?=
 =?utf-8?B?VHU3dmdwaVA1ZU5BTE81RHVnMDFYMzI4MUNLOWZSTkF0bm1NRVEyckFxWXh3?=
 =?utf-8?B?UGxZZExlT3pLQlBDNHVVc0V5UmIzdEl0VU1keHJ6am1FQVRzUlF2SSsvdnVE?=
 =?utf-8?B?RWNoVGI2aGZvcU9Zd2RxL1U3alhDaUNoZTBjYVlDMGlCSExsdUR2MkVIOTJR?=
 =?utf-8?B?VSs0Wjd5VnFveHZ0emNRUjZ3RGV3ZWlOaVcxcTIydmJGNnk3NHVzK3Z6T0FR?=
 =?utf-8?B?NU0vcFVlOENBYWNEM0RxL1dSd2FiUEVUejVGVDJZRTArWGl0MHB5TjBhVFlS?=
 =?utf-8?B?TXpGTnE4VEtDTm54WExybzFEaTU5anludzQ1LzNiL0JvRTV2WVYzNnl1SFdP?=
 =?utf-8?B?N3QxRy9CL2oxOVUrdThRVDJXQ0o3c3plS3ovS2hiOHpTWDlPaGh4YVErRTNM?=
 =?utf-8?B?R09LRGlOU0RVcTlnTk5Ud0ZhdFVreEprU0M0Z1FtS09DOGJZTlFtTCtYMy9y?=
 =?utf-8?B?UGtsTjNvaXJOWWgzdHpUK0x6SEJPejB1c1VSaVlqbkJhUyt2bWlIeDRGODBF?=
 =?utf-8?B?dlU0Smk1Q0xXMFk1Zmp2VEZQVzZyWGljbll1VGt0Wklsc3owZEhXejRqWkhn?=
 =?utf-8?B?T1Z5aFg2aEIvTTZPSmYwMFBoY05SWlBEUGt0dXFucytEMmo0bWdmUUpoS3li?=
 =?utf-8?B?Z0pzTVF1Q0dJTlNjc2ZaMTN3eWJJSW5TdGMxZDRDRlUwTjl4Z0xCSktTL1pp?=
 =?utf-8?B?UkEzMWpkT1RSeGVCczIwQURJa2ZKUzd5TXhKd2tCbGdBWk9zdThWcUlqNENj?=
 =?utf-8?B?UXc3Y09KM1N1MXdSUFlWd0hNRGZJZDJSdjZ1cFpSVGpjRTdHbWxHZ2lyUnpO?=
 =?utf-8?B?OG5ORUJRcUt0SUhaN3kzcHdMZ1NqU2JGUXg0T1N0aWhLSWRGeEdCVlhUWmds?=
 =?utf-8?B?RHVmbDNGbGR1YytIQ0xuTWNYRFhrWkdubEtveEFSdFNSVWNjbGNxZEFjRDNx?=
 =?utf-8?B?UDBSMGhnaHZGdyt5cWpLQXVaSkRDRGhvVndka1pkT3VwY0EvejY0Tno4ZFN5?=
 =?utf-8?B?VDZVYzFUL1Z2d1ZtZTR1MWd3alVzTVdxNFFWSVJ5aVFUMDFVNGw3a2RsVW1D?=
 =?utf-8?B?ekwrN0hFaVF5c3dpVERFeXVMbW9kc3pkWTJXRXpXemZOZEZVZ1VnK0hWRGZM?=
 =?utf-8?B?TVFvWVl5MWZPNU5uSDlBTUNKN0IzL3dXZGdpZTZHM2hUMkh3Z0NSZ29KMGJP?=
 =?utf-8?B?cDZVQzNGUXdPZHcrN2hIN2JhNVp1L0l0NS9MODQzU2V1dkdFWUN0RndRQmZL?=
 =?utf-8?B?RG11Nit4WmVQb1d6dVZ4ak5LK3FoSFRyc2JIckI3U0NOK3pCeE1ockh3a2dG?=
 =?utf-8?B?anRvVGpVRmVQTnJWSzhBWDQ2VXZzK3U2T3hncDJCVnk0WUk3U1hyRVJ6aTI2?=
 =?utf-8?B?TFNjNVhOOUNNZ3gyeTRqWEVQUWF5Y1pCalB0dUQ1OE1qdldPN2N4cEdOS0ZN?=
 =?utf-8?B?NElvWGg1UFFVNkRmeU9wU1F1S1lQeDhmTElXcTB3b212MUttTnZrQ0hoNndS?=
 =?utf-8?B?TmlZRFhhTUcxS2w1MndHb0lrenZUajZEcGJsSGlnUzBoRFlDWUIyaG1HRjFV?=
 =?utf-8?B?RlhuMnJ5MHdEalpNMUxDZ1pqc3B5VWFQbmpaLzQ5MHZuSHhyY2Q4SndHQ285?=
 =?utf-8?B?cjFSMmlOVnBUbGVScXZCbEh0cFBMMzF1cldsTWFoa0RBb0Vwck5DVXVUTGVK?=
 =?utf-8?B?V3g0Q2hxTExxTm55QTg5UUM2Sk41bDdxcE9YVXM3VlBiT3BacHFsOENvamdH?=
 =?utf-8?B?ZCtzZGgrOEd6QmFHMm55TjRmLzB4WHlsTVUwTG9pSElDMWxPVzJ4cDhnN0pu?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d57d113f-9df0-4062-dc05-08ddd47b2548
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:52:33.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3NCaUjDLqOSX1zG1nz1SM3aOB+jVfe53e0YsPMXB5y72dOPpmU1qWkQJXSuwieOg/uTEer0e+jGGauRywnQh/hibgoqT5nUmyc99sWabIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6962
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 17 Jul 2025 11:33:51 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
> > Security Protocol (TDISP), has a need to walk all subordinate functions of
> > a Device Security Manager (DSM) to setup a device security context. A DSM
> > is physical function 0 of multi-function or SRIOV device endpoint, or it is
> > an upstream switch port.
> > 
> > In error scenarios or when a TEE Security Manager (TSM) device is removed
> > it needs to unwind all established DSM contexts.
> > 
> > Introduce reverse versions of PCI device iteration helpers to mirror the
> > setup path and ensure that dependent children are handled before parents.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A couple of trivial comments.
> 
> Probably want to +CC Greg KH on next version given bits in drivers/base

Oh, true. On last revision I copied him on whole series. Missed that this
time.

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 69048869ef1c..d894c87ce1fd 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> 
> include cleanup.h perhaps for access to guard()?

Sure.

> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index 53840634fbfc..7a4623f65256 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -282,6 +282,46 @@ static struct pci_dev *pci_get_dev_by_id(const struct pci_device_id *id,
> >  	return pdev;
> >  }
> >  
> > +static struct pci_dev *pci_get_dev_by_id_reverse(const struct pci_device_id *id,
> > +						 struct pci_dev *from)
> > +{
> > +	struct device *dev;
> > +	struct device *dev_start = NULL;
> > +	struct pci_dev *pdev = NULL;
> > +
> > +	if (from)
> > +		dev_start = &from->dev;
> > +	dev = bus_find_device_reverse(&pci_bus_type, dev_start, (void *)id,
> > +				      match_pci_dev_by_id);
> > +	if (dev)
> > +		pdev = to_pci_dev(dev);
> > +	pci_dev_put(from);
> > +	return pdev;
> > +}
> > +
> > +enum pci_search_direction {
> > +	PCI_SEARCH_FORWARD,
> > +	PCI_SEARCH_REVERSE,
> > +};
> > +
> 
> I don't really care, but given there are only two sane directions maybe
> a bool reverse as a parameter to __pci_get_subsys() would be sufficient? 

I dislike reading:

   return __pci_get_subsys(vendor, device, ss_vendor, ss_device, from, false);

...in isolation where I must walk the symbol to the function to figure
out what that parameter means vs:

   return __pci_get_subsys(vendor, device, ss_vendor, ss_device, from,
                           PCI_SEARCH_FORWARD);

...which is immediately clear.

> 
> > +static struct pci_dev *__pci_get_subsys(unsigned int vendor, unsigned int device,
> > +				 unsigned int ss_vendor, unsigned int ss_device,
> > +				 struct pci_dev *from, enum pci_search_direction dir)
> > +{
> > +	struct pci_device_id id = {
> > +		.vendor = vendor,
> > +		.device = device,
> > +		.subvendor = ss_vendor,
> > +		.subdevice = ss_device,
> > +	};
> > +
> > +	if (dir == PCI_SEARCH_FORWARD)
> > +		return pci_get_dev_by_id(&id, from);
> > +	else
> > +		return pci_get_dev_by_id_reverse(&id, from);
> > +}
> > +
> This file seems to use 1 blank line only between functions.

ok.

