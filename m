Return-Path: <linux-pci+bounces-37829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D037BCE457
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 20:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79294058EB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663372FE598;
	Fri, 10 Oct 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xdv39stg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2E29C328;
	Fri, 10 Oct 2025 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121852; cv=fail; b=D8eLXjB7utDMHYUP6NI4Wl9Mtk3cl6kIeVxxzMA4HrFO32pcG3Zy2enhE4Vz4orjVPy3cxeNoQw2KJ9hDwjsLDWGioGV9PqoTQgVNSh1VSC8RnHczAg/lEQVBGpIakgAUvP+h7arRt/18+dsEBkPlD2Yj8YiOQRvRTT7JCSp35g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121852; c=relaxed/simple;
	bh=R/+h8GrGnlb9+k8WDCsTSyl0TuOzcvoA5vJ4ilVl/vo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=XI25Wi34twVEFz2QvnklzbhIyW+S/ufvnQOLLggPjnrAv6QbiDTrQt5yAmo8E4NBtGzdz5SsQhQRu2pKWWPi4eBWOn/A+fDZZ1zUTqh1B9F4l5Ahvl+avTfFcTS286+ymW5Lw7tsvoB7DCeYk+t2ekl6IdLxDGtZldDn/I+7Jfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xdv39stg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760121851; x=1791657851;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=R/+h8GrGnlb9+k8WDCsTSyl0TuOzcvoA5vJ4ilVl/vo=;
  b=Xdv39stg0maeQBqVG7rwI9ym1fB06zorHOrMbuEtqXICw5tZRK2UBAql
   NXnCAjUJ/ZPrcKSgQsv6eH6lGpn2ue+PAqAL/QtBQ8KJbZJmTYlkpktQL
   9OLFX9zmZ77LxfzgZ0Rw23ycC2JNJBVedF7EV8IlP8xGIIUOfyA4GB6Pl
   Pbhk2Jlphu/BB7+ZdP4C1FWUULpwPvpL71Kea7LAEuwKWI3ApIa3gdl0k
   op9vqpRK2RgDQPswZDXAYf0uKTi+NZcJabLLikWRVxP5htWSx91A1u+Ux
   MFxcWY+SsYr6bujyH09WIAM2RLB3Xn585cqfqGP1xqaFUfE5985fXiCPC
   A==;
X-CSE-ConnectionGUID: EOwFyqU9T+iPQYEtDCsL0Q==
X-CSE-MsgGUID: sA9PDbFnQSCnsM/08sZCyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="79788344"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="79788344"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 11:44:10 -0700
X-CSE-ConnectionGUID: KLapIPUuR+iEcz9ybjyvIg==
X-CSE-MsgGUID: aFaE1uhSToia83xMRsIY4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="186174208"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 11:44:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 11:44:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 11:44:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 11:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk+rE5YcsN+HxNMFrVSdoVsIdTa2PCV+r/A1VA+nmEpZlYDZ+C16to42USotncRWuYZlQjckXdDTbKkOisUzK1oc2J/qsmq+nnpB+tntYZfqeJ1rXcsk+5fv+NCfTWGyzsSgAnvvbQUTeRKakXj1IIE0a7syja470n1cV0x9OM5dokxlFmWq2ZaDO291m5KzV79mjbAlkaC7iqt0Pnu/jE+NniyNZXyHPnzsvbnPNH/5M78i2twRtQyNwYhzfpg/wyEYj843tQA/WuGsNSGaQMxhXD7jRWBCUvinEAViA2PZVferOGIoFX0H5icWbfl3WT3kvb/IzSrWjZZGx/OF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjkmodSzfrAj+qXCNfjqao7aluaZrtql75Q1cjkfvvc=;
 b=AcCyjOG470W678BpnNdu37amU5j6u+qdZNLIErkjz9tIB6+ryoTN6UXmIniMr6xa+dBhFVjMpf5Y+ny9EfkAUnb0FtvNIauOyOOMBDMWeNh9bdYTtilhUZDGuL23pxfXs+7JLz+vCSAWjEr6yEFjXNID3KUl9RqrsUquA8Q5WpglMh67xHj8jS25Bid+kTuB+IMB9mceFubAV91Ne1hZNiA4wxY0Rd7DxGZUe+SR1C5gXZTI4pCP3VHXHen+G2jFQIhrIpq6aeXsMNrxLAAHCiGot1E5RNBNiWD/duTaOz/8BzN0h1IB+EDx6UO1ayS97/PJhC0k41DTJd9Oh8cZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 18:44:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 18:44:06 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 10 Oct 2025 11:44:04 -0700
To: Jeremy Linton <jeremy.linton@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Greg KH <gregkh@linuxfoundation.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aik@amd.com>, <lukas@wunner.de>, "Samuel
 Ortiz" <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Message-ID: <68e953f484464_1992810065@dwillia2-mobl4.notmuch>
In-Reply-To: <f6cf20f6-0f19-4814-b917-4f92dad39648@arm.com>
References: <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>
 <20251010153046.GF3833649@ziepe.ca>
 <f6cf20f6-0f19-4814-b917-4f92dad39648@arm.com>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: c04da1e3-fac6-4e89-f9ad-08de082cfd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0RlMklrQlplYVBEWVQyN1QvQ3J0dUVyWTE2N00yZndyLzNGb3VWWVF3S2VC?=
 =?utf-8?B?WXA5WmIvK2swRHQ4Y0U2c2ZGeGpZaFYwWnRET3hrMVVacUlrK3BaWDN4Rjk2?=
 =?utf-8?B?NUl4YlZab1lmZ3hpQU85NUE5dXNVOWdBZExQVXNScHQrL1FzOHZWeVpQamFK?=
 =?utf-8?B?cEhJMUtMZmtuRjAwUVMxcldNYXFCMG1mT2IvTlJWZnV0VktQT284RnptaGpR?=
 =?utf-8?B?dGphWjExb1hVUmt0SDNUVTI3QVJ0UTVTWmdHNG8rZ0JSQ3pUQ0NqdGwzSG9I?=
 =?utf-8?B?UjBINGprODh4bXFzeDh2Z1poSHZnLzVUaHB5UGdKNmVOdnZrZWFrUWphMWlU?=
 =?utf-8?B?ZmI0MDVQdnRKREVDeXpPc2N2NGpxSnlUZERKYU5KVys4V2J1dk0zdlZ2YmY3?=
 =?utf-8?B?U3Mvc3AwZUNOT0N0SnNnbnViWVdueXQyMHJQclhNUitkMEpYWGFDTm43NVNM?=
 =?utf-8?B?KysvYVo1Q2RlV1hPQlcrb1FTM3lFVStveHhvb1lzMHJ0dzB0OG1UQkNFN0dF?=
 =?utf-8?B?OWlmdEhsL3MwL3BmamFDK2JyZjNaSlBGMWRJMDN3eUV0TFlhZzc2cFU1UzVa?=
 =?utf-8?B?U1VVbUpEVWNkb1RZTHRWWUFyTCtTYWVuU1pkRGF0SlFnWUpTbHAzblB5TUxt?=
 =?utf-8?B?SDVyZ0EvLzZTaXFFR090aXBCUEZTNmVycERPUkpWaTJ2ZVFUU3BML1NFbjht?=
 =?utf-8?B?Qk53Mm0xYzBVb1hRNnhCa1JpTERJL1k3MkR1V3g1VE9JRFlNNWNzbWdoblRw?=
 =?utf-8?B?bTVTRnVWU0lXZ1pxMmM1cFRpMHU2M2ZxcVNUYmZua2V6MDJpNmJlbmszSXZP?=
 =?utf-8?B?bGNCMTdsbEVVM05hcWpKallrbmhrVHJUTWxRazVuL24yeVFHTk1PY1pXeEtU?=
 =?utf-8?B?ejFXVkFVRjY5cTF3K2hFOE1zek9sRWp1L2hjNmZXdDExVXpmRHRrY2lnMDBO?=
 =?utf-8?B?aHR4SGo2c1RqYTBYR2NwZXhUWUxaMUs2UGZNbVpNRVpnR0Z5SnBCeFRuM2FC?=
 =?utf-8?B?dTNwMlpRWVhlc1J2czRUVGl3RVRvYnFFZmFoalc0Q0pMWVVPMS9WS0oyRWdR?=
 =?utf-8?B?b0o5blR4NExFaHNLdCs5M2ZVSVBZbHBYUnF6bGlGbnJ6UW1HQzZ1QTdlbzJW?=
 =?utf-8?B?SVpPRGVDd0UzcjI0V3NyZEZBWDgxTTdhOFYvNFlsM1paOTlZbVVIZ0hEb1pB?=
 =?utf-8?B?YzB5QU15b2tDSzFkZmlobS9YSnV1M2xtVm5PY1lXeUJvT3p4cVBHZWY2aDUv?=
 =?utf-8?B?YWN0SWVEVUlVYUkzVlgzUXd6dWhBUkg0V0VWZDJoeGxsbnpzVEpyaUI0RVlr?=
 =?utf-8?B?S0wwTUxGTHpIWWx4eEN2UXJ3NUxSaEU1WThzdExGL1diRWNLWjhLcFhOa3RS?=
 =?utf-8?B?TEVwZFBtODBlVEhIcVJza2ZwV2lFS1JvTVhSMmpLOW81bVVjUEZVb2F6V0Zz?=
 =?utf-8?B?T1NPSERadDM5cTNlZVoycm9rU1dsNytkOWVzZlJQQkczVkRtN1EvSnZZYzBB?=
 =?utf-8?B?KzBMZzA3Y0dwVWlFMjZ4b0x3SjRNamhRampUaldBNTNMa3pjeHRjdFJpU1lG?=
 =?utf-8?B?YjVZbGE1U05NcGIvaWNsNktCRlA4ODdRd3luTnlFNk1oa25oSkhzU0NHZEZJ?=
 =?utf-8?B?WnJ3OWtsVzZBU0lVSHQrTmRvQ0tEZVRUWFdHM1lrN0pBNVpNU211MlJoUktM?=
 =?utf-8?B?YWIxb1E2MTloUlJMRW5LdEJWNHFzMjR0UThnS2xmRkhmWitFVXYybURHNW5z?=
 =?utf-8?B?S3VIeE5ya2Y4S1orU0x2M3NESDMyOHRUdVl6aUFlZFZoOHdVRXRuTDNUUEJK?=
 =?utf-8?B?b3lsTndOSGJMdHQzeGZCMDQycldRLzhyRjViSFJIeTB2SmZnQkxkeVIzUnps?=
 =?utf-8?B?UnRkaGtJbFhPWGMwMFBIekZSQnJtVVlTcjNLWnV5TjBocGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVAyeE83T0YvMGFQTTNkd0RtcDZ3VFpIOGNPVnBrMXhQSmJEM0o0L1hVc3Bv?=
 =?utf-8?B?UzVnMHI3TkFHeTVjeThDZldBYzZQU3hzdEg1UFVBdHROS1ZTcUozWVpVMXU4?=
 =?utf-8?B?MDkrMUpQbno0NERVODRQVmIxQUduT09DVzQ2bDFUbThRSTRXM2pOQUFtQ25p?=
 =?utf-8?B?MGV6aWI0TnhrMGxjOTFFMjMxZTVnSXAvczREUFJaWFVaQnQrN0dUUDNiSkRS?=
 =?utf-8?B?bmRlSGZGTlNvU1RPRHNLRW0yRkk3Yzk0YW9sR3Nwck83bWNkeGl2QjR2dkxZ?=
 =?utf-8?B?aXFWelpTTHlMckpJWHZxZ0NUeEtkNEc4S2NYOTdzejNmSkx1QTdTN043S1VH?=
 =?utf-8?B?U1ErbXh4eHpCQlpzOUk0SXFhK2w3NHJSbXRUU0RBTWpEYkFMTXVhWGpHWmRQ?=
 =?utf-8?B?SU9ieGFwcCtiY2NHcGIxaHZVYlRQdWVxbnRENzVKMHRPSzl1Z0JKT3MwTHJ2?=
 =?utf-8?B?UDhmcHVFMytYU1BWVEJ4UnlNUjBRZ0Ryb3BLQVFJczI2b2JwU1c3UjcwU1N4?=
 =?utf-8?B?OGxOZExaY3ZhOXdMbURrVnZTVmNNbU5wNFdpSWhBbmpnUlBxSm5PYmpSbldZ?=
 =?utf-8?B?Qy9sLzZVQy9mNGdvNDhITmMvaWdIOXhNdFFrbW0wSWVDSUJPWTNjUm1INmpH?=
 =?utf-8?B?STRNV3lyaDJJWVg3QWhoRXNJaEh0allSbjlNY1k3M3dDQi92VE1tZitzeVBH?=
 =?utf-8?B?NWRiLzlxZFM5bVlTWWJPdnE5enBzditqSGVSVS82YUVVSHQvb2hXSktYbXJy?=
 =?utf-8?B?Y3JUeHlaOFMxcFpWbiszbU5DdkRFOHBCRk5HUnhFa0Z1d0hsMW01RzU1ZXgy?=
 =?utf-8?B?Znh2NHBPOVZpZ3RROElvQXo1NmRNZkMwd0Npb3RjQzZ4TEhtSyswVEI2Ukps?=
 =?utf-8?B?ell4NkFFR041YUFNOW9jRklEemtHVEpmT2xhSGpNamtnTHQzUGhRN1pGUTNS?=
 =?utf-8?B?U2JlaDJBOU43OEpKd0QxY0x1ZEhHZjAySkNlTkU4d0ZWdHduSmxVQlo0QW5R?=
 =?utf-8?B?THBCWDFGVm1zR3hTNmFacmFqbklPYk42NjZoUlZIdUFtRVJ5Y3pvVWlwK3dP?=
 =?utf-8?B?aUo3dDFMK3N1SDZlVkRqVUZDK2h3V3RyRjV5RVhQWlhNVWlQKzBjdkFuVzdn?=
 =?utf-8?B?eVFlYVdyUHFLVTZsbmpBYmlndzdUV2w4bkRhNXJuaE5kWWdpZ0pKajduNE9y?=
 =?utf-8?B?RzEvdlg3dCthUW51dXpDYThuYWF5NGZ6WUprcGl3TFMyWTI2ZmFDMVQrNTk4?=
 =?utf-8?B?TU5ER1ZyYlRvSlpDc1QzTG1mTHl0bDhiNFV0QUdGbUxLNFVmbUoweWhTblBu?=
 =?utf-8?B?a2F0TXdpMk50aHNQMDNLYlorRU5TeFNGRVNCYkhWVTh5bFczY3Y2dGZCbldD?=
 =?utf-8?B?RE9iMjJLbGZXdGk5Z0R2L0EzcnpPRnpsYmJBMXF0WHkwVjJSM1ZQSmQ2bXg3?=
 =?utf-8?B?VndhSTZkVFdUdnVkcU1XN2dRWVovWlNkdGNMYzFNVll4bHdoL1hSZHdaeUJJ?=
 =?utf-8?B?U0drRERad3U3Y1VDM05uUWw1Qlk4Q3ZQaTVUSVUxdEI3N1lLSkgyWk9LZGpt?=
 =?utf-8?B?UWY5bzNQaDltakJPL25hSXU1TVFTTVpjamhEMG9XdGhkWEpWMmJacEtOUExh?=
 =?utf-8?B?NC9oeXA1M3p5enE4QzFQRlNqUTBkd0IzMFV2MkVyS0czdW12a0Z1WlNtN0p5?=
 =?utf-8?B?QXJDMXFzSlN4dXJ6NElJR0ptVU1oTEp6NERuRytEOGc1UlQ2SW5pV25RSW0v?=
 =?utf-8?B?cmtOTzY2SWpscmJGbDdzNGNnZUowY3dmTXpTQ2dUTjNzbFR2L29iUExIL29R?=
 =?utf-8?B?Q2hCajZyY2RNK1dld2ZEVmc0VW5yVWhoYUhjanpFMFUzWnJJWEZrcFFMemZa?=
 =?utf-8?B?Wk13bjZDR0l1NGxMUzBKMVIrU3kyb2laVlJ2UHAzSDZiSEE1L3pvNEhyTHBL?=
 =?utf-8?B?YTRIZmJBQ2EyNEliQ2dxWFA0bUlQTWR6cnUzaFJNQTA2N2RtVGxlZG5WZVZN?=
 =?utf-8?B?R08xcUJ1YlZNakNsRHFveS9WUkRTdlBxY1ZnQlprVEVpdDRZNlY4cE1QZmNZ?=
 =?utf-8?B?OStFOUtoRDFiWHVrQUs2alZEeUZqOG9rQ2trb2pYR1lGeVJNbHJ1QXBiM0Zk?=
 =?utf-8?B?M2w5eEdtaGZEelBGNnVDOExuRkJldjB2Wm00ZjA3dnhjeUdhQ0JBUk1DcUZH?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c04da1e3-fac6-4e89-f9ad-08de082cfd94
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:44:06.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZPZMjFde7iDDfEZDT2G70nqITqqTUJGIWH6UvRYf61f4iSOOxMPl1Uvk7wMLUMYkrUnNiZfshsHxNVxHZMF2JR59MtEM+SGa/1Hw6cpo5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com

Jeremy Linton wrote:
> On 10/10/25 10:30 AM, Jason Gunthorpe wrote:
> > On Fri, Oct 10, 2025 at 10:28:36AM -0500, Jeremy Linton wrote:
> > 
> >>> So you could use auxiliary_device, you'd consider SMC itself to be the
> >>> shared HW block and all the auxiliary drivers are per-subsystem
> >>> aspects of that shared SMC interface. It is not a terrible fit for
> >>> what it was intended for at least.
> >>
> >> Turns out that changing any of this, will at the moment break systemd's
> >> confidential vm detection, because they wanted the earliest indicator the
> >> guest was capable and that turned out to be this platform device.
> > 
> > Having systemd detect a software created platform device sounds
> > compltely crazy, don't do that. Make a proper sysfs uapi for such a
> > general idea please.
> 
> Yes, I agree, its just at the time the statment was around what is the 
> most reliable early indicator, and since there isn't a hwcap or anything 
> that ended up being the choice, as disgusting as it is.
> 
> Presumably once all this works out the sysfs/api surface will be more 
> 'defined'

It has definition today.

All guest-side TSM drivers currently call tsm_report_register(), that
establishes /sys/kernel/config/tsm/report which is the common cross-arch
transport for retrieving CVM launch attestation reports.

In the TEE I/O patches [1] a /sys/class/tsm/tsmX device will be created
by all platforms that support TEE I/O. However, systemd would need to be
careful to differentiate host-side TSMs vs guest-side, and that is only
possible when the TSM supports TEE I/O.

I would be open to adding a simple attribute to that class device for
this common "am I a CVM" question for systemd. Would just need to update
all the CVM guest drivers to register that class device in the non TEE
I/O case.

[1]: http://lore.kernel.org/20250911235647.3248419-2-dan.j.williams@intel.com

