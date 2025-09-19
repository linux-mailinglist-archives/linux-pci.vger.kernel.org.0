Return-Path: <linux-pci+bounces-36550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB852B8BA25
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 01:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCFF1BC7FE4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 23:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E5A18A6C4;
	Fri, 19 Sep 2025 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYz6yz2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9971F523A
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758324747; cv=fail; b=qkvoIHbMA5H/lpp4owxCdwlT+pFLpPPvpem0sFyrtaDXebbf7VQ6vRIzFSlkXDrslqGGfCsc8a+Lqfu+QFKsR26utDiMKCVP/E6DBRXGxSFPdzf0UCt+kgdXT9E7lCrWCFEayp+LeLWLc+BFXAhTcqdU9O4qt2kJMnGBG8UDd6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758324747; c=relaxed/simple;
	bh=NlRQyEYvtDefHjqAEIe8hAujasO5tYezhlZ6X/ZRdmU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nxBnWcHvVbrZdfdb3QZyjisYZJGKmDmqH72Y9tCIVnBH9ss4yVi3wMHMQTKqYJradEIZfBFYtk3wFZ1+PJxHXm1gSzMUGcirOvS+mx4ACpPL8zOH7YfU1aI1/6u4h5f3rnzt9tqeq1QUooh15fkPNv3+qMCWIxrQcjNrVGN6a1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYz6yz2z; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758324746; x=1789860746;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NlRQyEYvtDefHjqAEIe8hAujasO5tYezhlZ6X/ZRdmU=;
  b=BYz6yz2z1kseiyXhqHdCo/dk+WZR92rGuFn/eYDu1ZiVSRqSwz8tEPdY
   n2lWkr+Kc/I9twVYjXTuve1+paTq3dbGycL4pS8CJXr/6IQlNRoRHgkjD
   Ma91I4wPtUbHwU1vIo3XUrbGHsouMfVslUfbz55wCZO2pXj1HsMNYRl2i
   AAsGw8ey0LNxUlJ19XuD+EVlhKodHGT/qQYv2uJ92hqwa1V7P/3abR/uA
   SX0GrxUJJK/2P08MH8Fgmepwy8zTF8n3Dc0LuBWzooCNFQCcyHcFoheNa
   0kRih1s6DZkFgvVTl/W/sfRisMxqSkQDEyK+IU825F9DZ9PIgTo2YF/s/
   w==;
X-CSE-ConnectionGUID: GbKSy0aUQkCtnze+Vx0hKw==
X-CSE-MsgGUID: 6XOyed8JSwi86bijk3tZZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60605371"
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="60605371"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 16:32:25 -0700
X-CSE-ConnectionGUID: nmkyxwjmTim8ndg7kp088g==
X-CSE-MsgGUID: CMIbPLMUSP2m6wR4YOLLDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="175568062"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 16:32:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 16:32:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 16:32:23 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 16:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFyGWvaQuYlKNonO/9wo6jeqdLzUhZaIR0hW8wI1UgmtTpZtLsYjHoDRAPcG8Lu+n3FClrM5R83IbQNaUqRzRJtn8/RYqexArClVea2cBBF8DrULL0AdDucVMfYr4BvB/NSCZK0rJFRozFij+1ztOrVedT97lXd9XXTmNp4Ok8zThwmIPqEe5+Q4SgBlQwuQFqNYLwq2yA2aL0E6Osar1XgueeoiFxnCAp4rFdDLQV7scSVe3xQiFePaUCFSTSYXBsi7hULMyGI/1Gzzso1S7xzGq4TrgVo1v9cx8mHIeiWa+FAZYRQevq8JmNqvOLucxmNMRUMBO9mcUw8sT1Ttfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGR7WA+odXRZSWnY6pD9HQvxOrBPa5+H5msd+Ox5pAc=;
 b=ZaFM6pXTVh0wjQtbpcTCNKFPajISh2A1whGRY4n/opLenqAlNGPZyl9/HdRP08ViVbc9Glus3ExHRYvTh9+MKaxxXy1tm0vbBKwJ84r2Xim0oyujspiFSYO5jgM4FbktEcAepFvYSXN0wlaNmjaIQ1NiMLH19MLRV0WKT7qitxcSinkA9KQWBGsChBK5ab9Sr7TjW5KybiP1TUU7zgvqr7+JSWnXtzOurlAZPyz9p53TXBKA+eMTslFuxJFt1GrLAY69R5gQ5w3kiTsJSEWTnax5J+wYQXvd2J/f6iLs5WtMN4KX0x7YpTURp+CQo7p4c5PFtyDFtmyIq80jionjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 23:32:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 23:32:21 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 19 Sep 2025 16:32:19 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>
Message-ID: <68cde80323710_105201001e@dwillia2-mobl4.notmuch>
In-Reply-To: <20250915171810.00003212@huawei.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-3-dan.j.williams@intel.com>
 <20250915171810.00003212@huawei.com>
Subject: Re: [PATCH v5 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd63780-4f53-4dc8-e196-08ddf7d4c791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWJhRHFEUG16RVQyWVhKa1lrL05pQUFpeDVWeDVsdllwUWI3QXNBM2Zpd1hD?=
 =?utf-8?B?U0FwUy95N0M1RlV4NFhLMC93OXNrMzQydkVMM2duRzBMcHlNN0I4bEw1elFR?=
 =?utf-8?B?ZHZEL2Nua1VwcDZieU9JTUZObXFUY0xDSTQ1NFJ3TWRRK3FjMC9SRDRra2dZ?=
 =?utf-8?B?YXppRmJ2ZCtiUkxJczlpTG4zdE5yOTlwWVZ0b2xEbE1PNGxybUc1cGNsendh?=
 =?utf-8?B?KytseitYQ1l6Y0JSeFRXNVJ2R2RqU1B3UlFjUkRaVzcwUWZXWDJvVWNCZFM5?=
 =?utf-8?B?WFRJNm56Vkx3M1llU1dPTU5BK1I3K1V4dWVOWllkQVk1MlhQUk5VellqZUMr?=
 =?utf-8?B?Tzlld0lSZ1VGdUZjR2taTjBKV1NKaDhzZUtTaTFOTkVORjhUaVhQL0d5UVJW?=
 =?utf-8?B?NlhkaUJGejNsSGxNQ0tpZjkvd2F4Y1NvaWFkeDdxam1QallMN0FEanpqQUF1?=
 =?utf-8?B?cU9CS1QyMFVUSTdFSU1RaGVvazRLVlFmUExXeHRxVmc3VFY2U3B1OVVoL1pO?=
 =?utf-8?B?b2lzUkxhdDlGcjlHYWFxNWVZUDZmb1BQOHR5NTZYemVGTXhiYVhMM2R0NzhQ?=
 =?utf-8?B?aXhUSnJZSGpVSXJxNExRZnYwQ1o5Rk9yKy9yem8ya0hFSVlBT0YwK2JOUjkr?=
 =?utf-8?B?RkxMMmJRUloxbUc0dnpaRk1pUGVVN08wL1pxRjlIdENFbjF1U1pBZHRCNnl4?=
 =?utf-8?B?bjBEU1lydkVkOGFDR3o0WkNKUmtwVExOWC8rN3hFNEhyZmF1bEpEaXM1WnVJ?=
 =?utf-8?B?L2R0aUVGRjBjSXhnWUI4MkZPRS9FKy82T0Y0d3I1NUVMaWlNNW4zcU8vYnZ2?=
 =?utf-8?B?VG1hVGl1YmZDQTI4T3BubU53aW1NQlBRdnhTZjU0R3ZMRWRvMzJFcUdNT0xi?=
 =?utf-8?B?WllOMmxMSjZoc1ZuckhjZVRyd01Xcmc4eFdaMU5UdVNhK0tsWDY5Y2d1M3ds?=
 =?utf-8?B?L0NuSFdLSUlKRHBRQU81Rml6aFRKZ1h1QnJUbUY3L0lvWVVPWmsxRlF5alZI?=
 =?utf-8?B?VnFBWnhRaldRckl6TUtuYXZXNU1rMXJybkFmL0xWNFp0anFaSDYwTi9qdnN0?=
 =?utf-8?B?WFpqTmFuckI0cG5HZExUeE5uL3UrNzJRR1ppdlhLOFBFbjlVMXNEa29DbVpD?=
 =?utf-8?B?YkR4N3JRVU4rNTlCaFAydDR5SGFUT1hIYjQydWZrbDNtZjJzb1lUN24vQkp1?=
 =?utf-8?B?NDVBeVd1L0F5Snc3RnRCVURNN0FBdS9Id3BLeW1JMTk5L2VRYUJzNHBGSGgr?=
 =?utf-8?B?bklwdndCWmphczlsUFBwMHVrbVVKWWFKaDAzbm1mc21QK3o2MGt5QytjYksy?=
 =?utf-8?B?RTVyY3VsV2xER2loc0JCUzBhY0MvaU5GZ3RuSjIwMU1GUittR1pqWDFzSDlz?=
 =?utf-8?B?aEJUT0ZCUzZUOHNZa1EydVRrZTBVT0kxVkdhcXpKRWRERjg3WjNGcks4bFVE?=
 =?utf-8?B?djN5UU1CSmhNUjRLR2had1FSUjEwK1F4ek5ReVhsZEwyVFQ1Z1lQRU1xdDlO?=
 =?utf-8?B?eTdLcUViTVJWQWRpNDYycUlNZHI0MW5kLzRURG5TQVVqY3ZVSEJHT3NPU0dz?=
 =?utf-8?B?aXkySkNPckdXTHMrNTRXTDQxc25MdGxtQnlVczdjaGZ6Nk52TCs0NktmVHJo?=
 =?utf-8?B?eGt6QXBBeWZsWlA4UkpQYW0vdVlpbVBFblo5RGo0UDkyUjU3dmJaM2ZCVDl1?=
 =?utf-8?B?THdJSDdXRkN1K2NBN1hsYmZ0NElaNVZaWkdPb1krbUFYUHVVekRPTlI3RWN6?=
 =?utf-8?B?SW9OdnBMTDBRQWxhRm5EZm81a2ludWxueE1lSHhPQ2VXUTVqeHVhYkVwd0lT?=
 =?utf-8?B?Mk9lRk9kV1hrQXJ6dkZsSWdyN2hGaWQvZXJRYmhCOFZqQjRwNDRjUmlqZThI?=
 =?utf-8?B?REJyalpwSHRXRjc5WU9uQWx1K1BOSUorOVNmYVRQWWtnNWJOQ2pSWmplaEt5?=
 =?utf-8?Q?anL9/7gAsfM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhXcDVJODYrcjkzUFBuVmNsZy9WdE1LOW9qaEJRTitjQ2tlSjFxbndkdnp4?=
 =?utf-8?B?TjZMRnZJTDVmTHFxZTAyVlRPcGJub29UYTZybUlPbTBLTjU5OVZvRGdKUXF0?=
 =?utf-8?B?Nitxb0Vzb0NUQjRCWlk0MkhXSUNjVUgxcWJYbUFRV2krVE4zL0dNZm9DeFJS?=
 =?utf-8?B?MlgwWVBuM1VIR3ExM3NITUF3TzdTYzMxME9hdWpNMGcyekVSME81aFRWWHZn?=
 =?utf-8?B?T1AvTm1MSUh5dVVGSXRuL2hmQnh2UmtWcmZSVTdha3UvU3Yvc0V4N1U3UEt6?=
 =?utf-8?B?ZDhqTzRVQ2JMQWF1Z2ZQL3lZUm81N2swNHFQeFVXaDhBL1VJNGxCcnBlQnBR?=
 =?utf-8?B?cEM5K0lkVngyR24xUFN4UVpwZllNSVZaTzU4czFJN0RhR1Z5QWFENG5vVXR2?=
 =?utf-8?B?NWphbDhzZVFnZWN0cFpFVkJmL1ArOEhwLzFpb2x3MjVobGkwdS9rRXpQTHJ2?=
 =?utf-8?B?Z1Y2K0Nra0lwRzUyOCt3bEdYR0tjZ0d3NE9QTitPT3NXQzBaM1hKd080dWVK?=
 =?utf-8?B?Zy95eDY2dDNqSjJtNU90S1VRRDhmaUttTGtlNyt4anRqdTByejU3bTlFYmY4?=
 =?utf-8?B?ejdLKzhydVE2Ym1QWk16N1hFRUVuL2x0MVQvQit5MnFnZGl2eUJGNWthN3dD?=
 =?utf-8?B?cko3THFhNnJWR012em1ycUdTT2JOaGVVM3Bmb2krUjFZek1tSUUrQUxWNHdK?=
 =?utf-8?B?ZjJVb1VBc0pJa2FWQUVHYzFNRXljbzNqWERvR1J5ekwveXhsMXV2SUtLNzFG?=
 =?utf-8?B?Y3VVM0dPam92YVZmeXRpWXpZM2hZL0dlVFpXazQrcXQwMkJBdlZTTk1sMkdV?=
 =?utf-8?B?bWphUWFjZlBuelFyRytaZytvZzFYdlhGRW5DVFZ0MHRWZzBkWXNDN0hwR0Ny?=
 =?utf-8?B?a0sydXNNd2kwMndjNDhvbVZ6dGd6RlhHRzZRampUdERVeU82R1htaXgvY2Y1?=
 =?utf-8?B?bFR0d0RYU21IK1lxeXdicjhVdjE1UHNtVVhlQWJOdGJkU0dCaHlIVUgrcWpJ?=
 =?utf-8?B?Snh4WVBiS2hOV21naUdtTUlheWJyaEtXMllMemxxQVVtblJzTWk0SXVMaEFR?=
 =?utf-8?B?OHovWG1mekJ1eThZbWo4emdLZGpsM2FjU1ZvZnBBTVNFbDFwZVFCaXVrcCs3?=
 =?utf-8?B?OVRUeXY5ZmtEWGE0MzRiWUtNSWhjK2Z1cWZQamFWTFpjYjNPcDB5U1VQNC9F?=
 =?utf-8?B?TFJUaFFXS3ZKNnJBeVdDZElFNVp4VWpvNVkrZHN6ZjIvaU1PbWlQNlliSDZ0?=
 =?utf-8?B?cnl5cmtsUFNZNmJJM2NrS3hqeUx4dVNwWDE1aHlTZTdja0w2ZUdQNi9QTW1J?=
 =?utf-8?B?MEFGd0JEL3lIVjBSOXFJKzV6Q25VSFIwZ00zQWMreXdOb1cydXIvTklRVzdw?=
 =?utf-8?B?NHNuQlBuWno4d3VlSFFIZkdxek1yOFRVVENjenFEWnVCTWs1THBBeDVVUm5B?=
 =?utf-8?B?MEpNNC9UbDdqbFQ0TFF0eWdTeGtjZUVOMnNVR1dnUFpzOUVHOTVOYk85WGtw?=
 =?utf-8?B?dTV5VmovQ1JnS0VuTDduUE8vRlFlb1F6cHRwZkR3dWxyK2RNY0Z6dmtJM1JI?=
 =?utf-8?B?ZHFPSXYyVlp5SUdRR0FaOFZFVjNVYkRoeEh0NGtZMUM5YndiL25WbytwTFJ6?=
 =?utf-8?B?eXR2VkFiTjVRR1ZNSVJCRm9ISGxITWtNUTVUSEhEN01GWE9PU0VJY0V1ZXZw?=
 =?utf-8?B?UURHTGNhdVVlSUMvajRpOVF4M2g0bjIyemhta21QRVNDeTJrM1BmL2hrZUw1?=
 =?utf-8?B?K2xnY3R3SEdvQlp3aVZNVHB1YmhkNmVKcVkrTjBhSVhtWVdDaVFKaTdScXBF?=
 =?utf-8?B?UHZDUk40eFEwREVFZFhSbjNLUTJscUhMTzlhMFFtWXQ4YzRldDc2N2UrSnV1?=
 =?utf-8?B?UExDZVQ3WitFb1JtOXZTMFFPZGF2Z1BuL09tMmJJS043OU43TXhHUXlKU0NZ?=
 =?utf-8?B?YThuWXhBUkVJb2h1U3ZQZE1qZUdsNlh3bkg5VTduVFUxNFdDQXc2cnU0ckli?=
 =?utf-8?B?czZzZ2Zxd1lpWHhmQ0xGRERGbWV2dS9USWpab0M2M3ZJMDIvbHJqRWdkVnpR?=
 =?utf-8?B?S1NrRTlwd1hrKzdYakt5ekFoNFVlOE1TZlA1djZRYnJkYnFXYVpjUUhQK1lG?=
 =?utf-8?B?bHBKbkc2dDZzUzBocXQ1bC9jTlhqdzBMV0NvdjdRYmp5MDJQTmdMS2VHT2Zo?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd63780-4f53-4dc8-e196-08ddf7d4c791
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 23:32:21.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Z1pUsz0U58jQpjUyizE8usvfwIR5NzoPvZh6BZxE2d7RzedVaDtAJYfmRsanMA/JbbKQDFgVohuXM5VmgbxY04Vf2NzMLFC1oSE9ameSXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 26 Aug 2025 20:51:18 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> > 7.9.26 IDE Extended Capability".
> > 
> > It is both a standalone port + endpoint capability, and a building block
> > for the security protocol defined by "PCIe r7.0 section 11 TEE Device
> > Interface Security Protocol (TDISP)". That protocol coordinates device
> > security setup between a platform TSM (TEE Security Manager) and a
> > device DSM (Device Security Manager). While the platform TSM can
> > allocate resources like Stream ID and manage keys, it still requires
> > system software to manage the IDE capability register block.
> > 
> > Add register definitions and basic enumeration in preparation for
> > Selective IDE Stream establishment. A follow on change selects the new
> > CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> > both a point-to-point "Link Stream" and a Root Port to endpoint
> > "Selective Stream", only "Selective Stream" is considered for Linux as
> > that is the predominant mode expected by Trusted Execution Environment
> > Security Managers (TSMs), and it is the security model that limits the
> > number of PCI components within the TCB in a PCIe topology with
> > switches.
> > 
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Some very very trivial things inline.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> 
> 
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > new file mode 100644
> > index 000000000000..05ab8c18b768
> > --- /dev/null
> > +++ b/drivers/pci/ide.c
> > @@ -0,0 +1,92 @@
> 
> > +void pci_ide_init(struct pci_dev *pdev)
> > +{
> > +	u8 nr_link_ide, nr_ide_mem, nr_streams;
> > +	u16 ide_cap;
> > +	u32 val;
> > +
> > +	if (!pci_is_pcie(pdev))
> > +		return;
> > +
> > +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> > +	if (!ide_cap)
> > +		return;
> > +
> > +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> > +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> > +		return;
> > +
> > +	/*
> > +	 * Require endpoint IDE capability to be paired with IDE Root
> > +	 * Port IDE capability.
> > +	 */
> > +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> > +		struct pci_dev *rp = pcie_find_root_port(pdev);
> > +
> > +		if (!rp->ide_cap)
> > +			return;
> > +	}
> > +
> > +	if (val & PCI_IDE_CAP_SEL_CFG)
> > +		pdev->ide_cfg = 1;
> > +
> > +	if (val & PCI_IDE_CAP_TEE_LIMITED)
> > +		pdev->ide_tee_limit = 1;
> > +
> > +	if (val & PCI_IDE_CAP_LINK)
> > +		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM, val);
> > +	else
> > +		nr_link_ide = 0;
> > +
> > +	nr_ide_mem = 0;
> > +	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val),
> > +			 CONFIG_PCI_IDE_STREAM_MAX);
> > +	for (u8 i = 0; i < nr_streams; i++) {
> > +		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
> > +		int nr_assoc;
> > +		u32 val;
> > +
> > +		pci_read_config_dword(pdev, pos, &val);
> > +
> > +		/*
> > +		 * Let's not entertain streams that do not have a
> > +		 * constant number of address association blocks
> constant fits on the line above and I can't immediately see a reason
> to wrap early.

Now I understand the "very very". So in this case this change destroys
"git patch-id --stable" and in this new age of Link: being deprecated
resending this to the list feels not worth it to me.

> > +
> > +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> > +/* Selective IDE Stream Capability Register */
> > +#define  PCI_IDE_SEL_CAP		0x00
> > +#define  PCI_IDE_SEL_CAP_ASSOC_NUM	__GENMASK(3, 0)
> 
> This one is a field so one more space needed

This fixup preserves git patch-id, done.

