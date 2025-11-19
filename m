Return-Path: <linux-pci+bounces-41578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17877C6C8F2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 77C3D241BC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF0B2ED16B;
	Wed, 19 Nov 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzLiKb5W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33A2E7BC3;
	Wed, 19 Nov 2025 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522421; cv=fail; b=MlF0DP/IRjkny8LKE+Yhc5pC/mYvg3DAXA8imdznparEKscY7l8SiDsPN6GNv9ZxhXBAMBZ066s/KMhH0uRSa3AnveV1O3fbf+KwwaAC9LTNCEw/b15t5sHfvo+g+JkRTm8hklACwRCO/grdmrFVGF5MEBrIb+71M5ESG2TZfWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522421; c=relaxed/simple;
	bh=ad9LvsxM31a72Yw55XnnQ4nBA0zmOpVULFTlYXtZlno=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CIDv+qqChJLh3f9nIYFkXf30xvzNGrGmlmqtvJjedtPtcO9n5MVjXvsK/Qui7LOxAY77ruez1Bp3F5gk6N+8zMmaEwgsscHibO3aoqrTXpb4ea8jhU1nhT23ncmIoaZy8jWnsSs1WtUbR4yi0ELcY8YlKeSUhHSUnx4hNiez50k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzLiKb5W; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522420; x=1795058420;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ad9LvsxM31a72Yw55XnnQ4nBA0zmOpVULFTlYXtZlno=;
  b=mzLiKb5W+YZp0wR8ShuvRBQs6TNxYbq6CEWswcvLis5LZvOPBCKKyb0L
   nPNeY3gfmm49vGHPdkKcCQ+8AMLdJgm4QOIo5sYHYpMgUagRfsAO5v1MJ
   EDaT4yjf4YH+jq8mkj6o2qwNlGiJYP6D/O/ffSIzP0qhz4ghZgWw4Zu1T
   tj0KUzMhRNWDyCRyqv135F7v+hK323ueVXmEoe9Zu6qj8Qf03blQFgM/f
   9qU8IqAFSlrhkROXXuah7B/lVYDK/ZxBw3DHSajubYeXMxKweQJoXyJ6h
   yn8SUBXW8yjvBgU+p+Znc6sBF85pFcuSpAVTYqGZ4E+AfZNLHKD7F+yXS
   g==;
X-CSE-ConnectionGUID: HFbapUxAS/e7yS6si2ef/g==
X-CSE-MsgGUID: 2CC2e2nzSIiTLUMF6l/TWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68163054"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="68163054"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:15 -0800
X-CSE-ConnectionGUID: iBzggx3eRMKadalyQDrdyw==
X-CSE-MsgGUID: DB8FSxE4SBmuqa338ftz6w==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:20:13 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFcg70vYEA+DKf0pO+wBVP3D0et9/TdxZft41B3uqyoEFHUSALQ4TJmbU+z2pHfQvmq/Pl/oTdE6M59VAsW8gLjweYlJ91UItSImy4if5BPDiy85xq7ZMm/fBm1kkhCVPiEdRjCorE2b+z3ZmvwRd+Xa3Dmzu2F9Ok8yTD+P/T0yQf7p6mRksLPPfvST+SKkAfE1UGTcW3zMQ030+l1YPYz5rQj0qb4bHvNx0n84iacwaADUD9iamFu8DRScDIcJmgJAg9RvnnuOHVSzm0wwsylekLFgvbUo3jzlpyPD9Pn3MUhlJWA9tmK3t3R/vjQXAOlJUus+xtmAkFiVXvUDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzxzBzJO4J7wXbH6dP4elsCxH/qGkYHBe5N5tThZMt0=;
 b=jFFDaVfs285UP+sYZcPc+agfGJkJQasy3fa4L8WnyegBGAdp+DnzEcFmgpqZ694mhfoAK6pRryZ743XWupkOyMePlSzMGGtIit0bmyaaPYvYyVDLslxrv/e9GxdQAJohc4DiovNOTmZY/yPaI77QB3qbKp1+GYXejw/V/iYg5lWg7pxwjy0dr5Zs5sVK8m2pTNQsgMapcMuBQ2s1uq7VN63EXhTipt5Y/7vC4wK+foedq+esHQxy6amAbAkpY+BFrbCZe/xJdAOSuyP3WMAtDv2OSZx9nDVYSdtN+y6PpXQgekY2MWA5kj9XxZcbGT1TK+Cxv4p2+r07dlNoMfcPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:20:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:20:10 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:20:08 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <691d3768d9ca6_1a375100ed@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-6-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-6-terry.bowman@amd.com>
Subject: Re: [RESEND v13 05/25] cxl: Remove CXL VH handling in
 CONFIG_PCIEAER_CXL conditional blocks from core/pci.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dda4aad-e9a4-4cc9-2a31-08de271a8c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEJ3dVp6bGNwRGdvU0txNi90bXlBZ3JxOW9RSkRmM1IwTm4vS3N1SFZwaHJC?=
 =?utf-8?B?TTZFR2t0ZUNHQVVsOFloSXBXTXlYTUVSdkxjRGZQbXVQQnRJSnhYRGtrVkxO?=
 =?utf-8?B?SEU5V0RDbHlTcmJFakNrbkFBUThTRFZtM005bFg1SGRVczQ1c3g1STMwYVpq?=
 =?utf-8?B?N1E0VTdjN2QveFN1Z2pDalJwOGRUeEVsVmJHdFNJb2h5azJ3Z2NiRnE3dnZn?=
 =?utf-8?B?ZEg4OS9yaVdHU0xaelpKd2VFdHpjNWJvcXFTMjRzSGIvSnhxbEdBcG9DTjEv?=
 =?utf-8?B?bkRsS1ZaR0ZhZG9uWEo1MVFTbXlqOW9KTEdSaFdCZSt6MC9HdTdSMjl2V1dP?=
 =?utf-8?B?dEhOU2RZSi9aa2hUTU1iV0Y3bXB5Zm5remsxUndWOW1DSmtZWVBBOThjSG42?=
 =?utf-8?B?S0NxUHZWQVBWZXM4R2hvMEVMMFNBeFBSb2lTbXZJazlDbjYzbWtzd0ZycDRu?=
 =?utf-8?B?d1pmR28rU21CV0IvM1d4UXFoNkMreFpXYXhzK0FqK3ZhclEyS0REdC9naGV1?=
 =?utf-8?B?dGJESjcvQXlhNndZdy9ZbzFVNm8vRXlmaTFUcjViZnlxMzUxVlNzVFJnNGt6?=
 =?utf-8?B?SEtPbUd3NTlacGNxQ1dmOGkycXlzMkNmNzczbm0rZjVIbkd6aWVQQ2pGRVRt?=
 =?utf-8?B?UUJWbWlEaVd1M1d0clk4STdzUG5iZnF4QU1YWi9tWWYyVnExeXdwaUZ6SDh6?=
 =?utf-8?B?d0FJSUN5NGhOMitzbk1odDc5NU4zVnJtY0NKano2TWtHNFlmeUhtYVIwWWtw?=
 =?utf-8?B?Uk91R1RHRThqRjdCdGt5T2RWTlJ2RHMwMXlNalQwY0hoS2tXMGFTcnNPQjZw?=
 =?utf-8?B?M0FnWUgxZmNYb3VpR3ZreENabDJQMHFJN3pkY1NjaXJBOWZ4NHZDTlMxbFJr?=
 =?utf-8?B?VVhqK0h3MC9UeHFucnZMU2RRUjhpQ0dKbnFLOGU4TUVFaU5pV09mWVFwSzhN?=
 =?utf-8?B?RlpiZS9ldW9ibElhZ21BZ1BFRHdZKzl1WFkxN3VPYk9hbkVnVlUxaGphdnVq?=
 =?utf-8?B?TVQ4UGMvUVpmb05LQzBSTGcxZzJHMHo0eE9oTjBlSGpsVHkyUjNzNGI2VWR6?=
 =?utf-8?B?aFJnWGVjeDF0ZFkwbittMVZUbjJmT1YzQWxhWFJCUjNjMlpCVjJWSmxYTm94?=
 =?utf-8?B?bnhNOS84eThLbDFCT0xTOVdXQTdqODhSYU5NUlE3RlNqSzBwTGZ0ZEswZ2VJ?=
 =?utf-8?B?KzFtc0V4OGZDUWdmK2Q1WEMyMG96NUYxVFFqdkpWckR0VXJtalV4dXc2aEt3?=
 =?utf-8?B?RFJScUNvYTQ3czlweG9Pd05TNTlkejg1Qmh6TEFpZnhJcnp4KzBZUmk0SEMy?=
 =?utf-8?B?N1dpSzQvNGdBbUtEbVRjWUNMcjV1VGZTVFlrWXAzYXEzTUNSUzN6ZllWR05u?=
 =?utf-8?B?cG0xZGV2QWVVcmJ6a2ZSL1NnRmNZZGtBRWZvSWdsUmovTUN6MUVaeVBZeXZl?=
 =?utf-8?B?c0Z5aTJWVGoxTFFKaHFWNmlMbVZPNDFidzJvWDM3cE1TT2x4YWZQS05jeDN3?=
 =?utf-8?B?dUpReTNpZ2NCNWdiREdzWmRodmFnZXhvMzB1ajZlaGl0QlNkZm1GR2NDNVIz?=
 =?utf-8?B?RDZkY1VNMXBZY3ZVWHlSbFVVU2RSTTNxNTVzUWJIclNuclp3MElmaVAxV3NY?=
 =?utf-8?B?RzExUnRxUXNxa1ZnVEFFWWFwZXVGV1p1NHFaNFpJdmpHQU9XZTQzQnNtVDBC?=
 =?utf-8?B?RGhQbkgxWUpRcG9PU21SVXdqUktyLzZseGFmNDJUSU54UDR2SFdPRnpkOU1k?=
 =?utf-8?B?RFdqQ3J0YnBLWStBSXBibmttdHQ1Q3VuV1hocGZnNDRpbmI0M2FqanFHbURP?=
 =?utf-8?B?TUx6alpJNUdnK3Q3aTQyK0pDbUlMSmFSN05zYVF6dWtCUGhSbXhHMVpzaWZW?=
 =?utf-8?B?YmFYR3ZsQkNmNDdyOTRmUE1NS0I1RFNOWlp6OEp6VEJXejBBRTBFQzh6Z0My?=
 =?utf-8?B?K29HMW1YaWF1VDRvS3lxN0VmYlUyU0RMMmZUWm83bmRDWDFNQVpSaW9xVGtP?=
 =?utf-8?B?Zk01MEhWLytvVTV1NzBNQ1l5VzFsSzM4Z054K1hWMEhCS2JOOEZrdWRPWjFW?=
 =?utf-8?Q?xDm/3/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1E1Z1ZYUVNTYXBBR2F6U21Zb2VFYmdQNUxpY2lGNTllNUpUbmVvbHh3NC9o?=
 =?utf-8?B?UEY3YzVxbUM4YTFDejFUTDZKaDREVXBJVXdEMVZPN0lwemh6ZlNLMFUvMndy?=
 =?utf-8?B?aCtVdjVvUThoaDkwTXJJMjJ3bjVRQUFOOUdNOXMyQ3ZoWXlHeHRqVVIyQWVs?=
 =?utf-8?B?MVY0U3JDQ0xBNkFwd1JDTjRpOEMvTkUrRFpkKy8wc0dEanNRUDA1TjJKdnlJ?=
 =?utf-8?B?K1RpZlE1c0pzc2pLSGlzRDJ3MmI0NTUxK01mMkxIRVRkRmN4bUZvOXpKQkZC?=
 =?utf-8?B?Z3JjTVY3Tmk2WDc0TFBtOUdsa2Y1djMyM1JpbWdVNjBodjZsa2t5MEE5cnd5?=
 =?utf-8?B?QWRwZUx2QUJHZmpiWXpubVRLckRMNWJtYUlhckxxZ3duNHRPbzJKWU0xSVFF?=
 =?utf-8?B?M3BYTjFJdTZoMk9jczhjZkJ5eElmNk5CUG5zeExtY3dHUXdpbVBSanhYaU9F?=
 =?utf-8?B?TXZUL0VOS1Y1MUhHNG01WEZ2UVJ1NVpVWnlQRzVRNkpqYTA3M1FseURPNXhX?=
 =?utf-8?B?emRUSHlrQW53NW5wMGR5YWlPdFRCL0o0bDg4ZjYxOVV4dnIwTDBVcDNrVGN3?=
 =?utf-8?B?WUtYK2dUTE45ZG9QS3NMVEtpa2o3U2VXQ3B4THZ1TmN4cy9yMTJ1Q0RtaUMz?=
 =?utf-8?B?UFhZb3JkL2hycUtjZEpQaitaNjZrV0tkTkZxa0tHSlpDOE5kN0hFbXY1QnY2?=
 =?utf-8?B?aVNIazBjcW9pczFNQjBZckJQUm1tOXFRU04zWFlXWGNCZDdTWnRZdDViRjIv?=
 =?utf-8?B?am9tQnJSajVaeGpnMGpBZm44UjJmV25NMGIrakhJRDByaVRxdmd3MzZiY3Rh?=
 =?utf-8?B?RDdaZkpiQ3pYZHEzcUNDdmRXZmQyYXpSbkY2UkVIRk1DY1U0bnVyaFdyU0FB?=
 =?utf-8?B?alZWVi80ZXdVWVcwc245dEdlS2JIVGtjaGpiZ1NFSWtjK1UvdGl2T043S0o2?=
 =?utf-8?B?YnViY09QUXcvL0NhUHFTZEhBQ2wxVG4wWmg0US9UM2Y2TlRaSk1hSDBwZFNV?=
 =?utf-8?B?L3ZIZkg0OFphOFQ2czZOTE5vZTkyc05XcnkyTnJyeDE2b3JXL1BVQjBiTEtz?=
 =?utf-8?B?ZmRQRnNVK1pxSW5tUi8ybXBZN050b3dhK2VIMHFQY1RMakdhSW9IVDRxekNQ?=
 =?utf-8?B?L2dnK2IyTGhnUjB5eHQ5UXAzVmF3T09oZklSVEpuLzhkZ1NxQlU5eW5hb2N5?=
 =?utf-8?B?dDRHbkRWNmx6RUV1eU8vZHlSUkErbE9XeUxYUGhUaWdqT2JWZ2VlY205U3FU?=
 =?utf-8?B?cGJwTnVEMnV2SGRUTFE0UHBUSFA1M2kxZExPd2xCTnN4YzdxYUJRK056V1ZN?=
 =?utf-8?B?TkNmZGp2V3pwaDJLcE9YaytTbHppb1R2THZkREtCRkpsb2tTdjlibXdSVmpK?=
 =?utf-8?B?b3lramY0MVVGN1crZ1ZiYldENy9KTmNaRU4xSFIzY0oxaXEvbHhaeEVFQmpO?=
 =?utf-8?B?a01ZUDNkdnRJamUvS1lhQVFnSCttRG51QjZKNUhBUkNrNVhHN1pXQ0MxVStv?=
 =?utf-8?B?SWMrLzlWaFBwQ21DRVMxdmw2TmRCSkxvZzBvY1lIY1BMT29EcllOMXVSTGlH?=
 =?utf-8?B?VWcwLzgzaW8vSit6SFkydGtmbHlGS1ZSSWZzSEc0a0VDZ1FLU1FEcGdUSkQr?=
 =?utf-8?B?Y1d2ZWhXNHZSQXoyM2F0SCs1U3hxaVdjZjJGVHl4bm9GU1NnY0lxU0ZlUkdz?=
 =?utf-8?B?NG4xSnlobFBQYWJ3cWpHbkV4MnVFa3ppYzR6M0VEWGxObk45cEhjSFViWDhY?=
 =?utf-8?B?eUE2Mzh5WS9vaFZuSXFkNW5HdHRZditZSHpIOUZGVnd0YngrQ1ZBNWNCVzZh?=
 =?utf-8?B?cXBIMllnd2dEaURaUWhOUnJNUXhVVWxZdWtQWk1WNnIvZVgyaVljbjAyOUk1?=
 =?utf-8?B?T3ViSHhUMUxYclFJOVlDNjdFUTMzQkxNTEQ2WlVrK05uMy9wM2JpS211TU5x?=
 =?utf-8?B?RVZPdTBRSlUzdEdkQ0o3TXE2L1NmeSthY2k2cWZLanNmT2VQR3phS0pqVDFB?=
 =?utf-8?B?M28vMXBIU0lEWGhyUU9BY0xYTElZTndVSko4SjJEczRhdFVpa1h2WUJsUnVa?=
 =?utf-8?B?eFFNUGtpdHVhWHpZblRtcDk5TG1LbWJaVmlmTXR6Zit2ZXpCSmk4RTk2SzJW?=
 =?utf-8?B?SmRVdUJ0T2VtMUtQNStXQ0RmVzN6bmREV0JCd1h2UnZDRFdxNXRTRHN3czJa?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dda4aad-e9a4-4cc9-2a31-08de271a8c0a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:20:10.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: in1NW3VAXoPUJ/zFNM2+8+Bv90vkbZgAZtJ+O0MaliNVRb8drmG0p+sWOv2AHfCsQbPLxBFLtFkBO2MsAMr+gWNFLrXA66A3dJ04PfOEYUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind the
> config. The config will depend on CPER and PCIE AER to build. Move the
> related VH RAS code from core/pci.c to core/ras.c.
> 
> Restricted CXL host (RCH) RAS functions will be moved in a future patch.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

