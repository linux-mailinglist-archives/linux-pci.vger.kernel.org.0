Return-Path: <linux-pci+bounces-45228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CEDD3BD6A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 03:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 938C230194F3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 02:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC801244665;
	Tue, 20 Jan 2026 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROsR9unN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE281ACA;
	Tue, 20 Jan 2026 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874988; cv=fail; b=H0hCacxWsqkSTB7PVroNuxgOq9i+Am3HPfQKGr94nSWiPWRiq+GRi+ZNApPkodxaDJHU/uzA/vMIzTC9p5CsJ1Dk9WwgwvHdcZ6MQzFB9OI35220sephol1mgk4HSdyYYZTgUL++pbh8dPL8/iNT8VvXfQxi4x4yPjjX1UAx3ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874988; c=relaxed/simple;
	bh=u4mVpFm+pnvoEzUd7S4g1SuDaVujasHwOUOudDi3/kk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=obzWKWBKJdU5uuye3d99WTP2dUxv0wSB16jumOqlzoJJYFUd31/znUNBMJxmlS70zCrzT+KkKZ24cieyQdp2w+H/OHcJLFvQnVJDlEzdNEZPfjllZTeR0IKoV8zYLyLEDydoCpnam3ZmaFhz5l5n3QPDud0oB+F+reFwMfDE87g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROsR9unN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768874986; x=1800410986;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=u4mVpFm+pnvoEzUd7S4g1SuDaVujasHwOUOudDi3/kk=;
  b=ROsR9unNsc1y0vlhEhqbHpeS0Ktuby5uyLy7v3ep2dAA/SwPzVjzs+d/
   EEZUZZXxwPa+Au1L9v2zXfbgQycgpxXTZ9kUakWxZ3AAhQv9jYGp46++1
   5YX9zCwrq5L/uObXGyndmruKr116/T40lkb9XT7s0XhsHHNtngkrWhOYf
   O0H/VuYOSU9NxaZzMgL+6OZ1RHV+5ohIwNTDZoVoLDH3x/J/dOk5m2W/j
   XldCptPcHEG9PW+sHi6HM7qHn9nOYBfNiHGZuNPgS/r6o2xhGZLw1ChBo
   nlV1Scmdr6Mw2+cs8bDLqxLBRsTcjoiy9GOtGcxyNyE5HeuE2Sz+BdUVc
   g==;
X-CSE-ConnectionGUID: W/Z92445Q+mE5mjKSeWRUA==
X-CSE-MsgGUID: Be7ZXfWjS0KILk2WlEasbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="92743293"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="92743293"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 18:09:45 -0800
X-CSE-ConnectionGUID: ChmdO/YpRoSEtR0p9PxNFw==
X-CSE-MsgGUID: wywfvVWaSxKMi0IvzFTNdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="205890908"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 18:09:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 18:09:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 18:09:44 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 18:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkwzP9HX8f5q3P5W4yOT5mTn1K9Cv6XrvNGrWopTUoJrhn0SXrJDADnl210e0i40+Sw61sXWBwGjiWwOlFzCoA1DApaiBRYkA9M11vKInKjK1qm4sDVXsI6v38hOEc2bhDdKUiBSu4DBlfbNSxsqPbXfrDsjm+RNDBkFgaNjdqd4QV82c9S0mxD8b+jXQG/n3WwLuk7Eh9S7wNZ/vbQ0uvIy+gWb+jSpi5EwNM2MGROv1QtJHjyX57zTfSYe8W6Y3XYtt2Uy3dxzl8fnwKirQIcgqlZ8TqTBpKSHcinTOoN4Vuvxb7SBqnRIlyBzMB2FpzPI3Vi98Puo1j/cqMOGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qto1DQhVcWh+3r22yJfr1rZfkIsPnwG6E237YGjTLSA=;
 b=ds5rPsfO2MZvncuu1yAXT00EwK6+TyxEFb54T4Opu/p6EvJopqWfloAMcQGS8PrcvRXf6drpnTbzKPqUk5ts731axrj9Cter1Cr82WVGitM8HJiDyP8Lqv1N5unsrryBPqOLy58VNhMvGHQU5NS2Dh7NPr6ifScFP5nNvJgLjI4IF2WhCoRsU9lamnB5XgH0BcqvvqR+Tg7Nlolg2XfthtljcaHRFZy6bKWXuHkJt/RN9hw3Zuyr1x5XZkFHP0PjjOn7W0ucn1ZnxYHwAM+NwfAATfT+c6JUwGmF1R2BOs6ttCapDmScWG5TI4Wc6Wwei/xgKC23YydObmtHJb4vkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 02:09:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 02:09:41 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 19 Jan 2026 18:09:39 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <696ee3e34f2d9_875d1004f@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114182055.46029-10-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-10-terry.bowman@amd.com>
Subject: Re: [PATCH v14 09/34] PCI/AER: Export
 pci_aer_unmask_internal_errors()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b3a454-506c-4e19-bb4b-08de57c8f894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjBRb1RWeEFtM0Z1eC93c08yc0o0U0NxSHZOV04zaFB0Tyt2N3VWbTBmR0pj?=
 =?utf-8?B?SXhJeWgwZjVsemI3S1lqUTZhVzREM1VQb0haMXNxalA2bjZEWFRGTzFNSWsr?=
 =?utf-8?B?Q2ZZRldjenQ3TTBGcE0wK1d1RGlFRWhTYWdhektQWjRzdndWcUlFdnhvYm5t?=
 =?utf-8?B?bk1aYnJkd2duSXhCcWVIcTl1L2VQNU16MGVUNjlwNCtIUVk2bzF4cUZnMit3?=
 =?utf-8?B?MHZyZ2lOTmlVNGRiWThRZnFlSjM4bDlqYlZmcFVLYlR2c0RubGk3M2FXU2Rn?=
 =?utf-8?B?QXNoRjcvYkxBUmdsUE5kZ2hBTjZWNWVYQ3dpUkluQkxjSml5T29Rc2ZmTUdX?=
 =?utf-8?B?ZUtjMG5CUjJ6TlJYdGFDcmQ0N0pwUHhCbHBIUVBaVzJ0N211NFhSKzR4Q1BP?=
 =?utf-8?B?QW5lTWgwZ05QUFdvZFRyMkZYbmFsL3gwRDdHWDN3bTZKbXhkSnh6Zzc0WHlR?=
 =?utf-8?B?SmcxcDJXai9xUU1zcmRyL1pTRWhFaktXUS9hU1lyUDlBTHhqTTh6K2dOaXNn?=
 =?utf-8?B?b004MXFWU1JaSXcyQTEvOEltd0NqR3hJa2s1WWE1bWVGTWZzKzlhMGk5Wmkw?=
 =?utf-8?B?UHpwT2hZem5aNFlkZ3AwOUxnTWRPNS9iViswSDlSSE9lZUFYdjNuTVY2WG1U?=
 =?utf-8?B?S0t0VnZZYVNiek81VVorVTBCT3RscXJOVEErQnkrME5QZHVZOFZhek1QQWhO?=
 =?utf-8?B?OFpFTDhnMzFhOGR6SFR2M3dRMjhITDA2eCtyWisybmxrb3B3T2hXTFZkWEdE?=
 =?utf-8?B?RHc3MXVQTmNpKy9QcStDUlJsMTdMUklQbDJNbGQ4d3FYaHN3QVJYcGkrakls?=
 =?utf-8?B?eDF5KzRHdWRONmlGaEJrUVNVa3hLL3JJWURTdWwram1uR0ErNTVQT1UwSTAr?=
 =?utf-8?B?NGhCNFhmQXUveXg2RTVWcENpeTRRV0VWdExxcmRxMzA3UnEvQ0g3RlhIOG91?=
 =?utf-8?B?Z1lsRlhNWHZ6THk3b0dmWC9wT0JLZDA0M2E2amN5VkpXRGg5ZUNJUzQycDBW?=
 =?utf-8?B?cmltQVlJTFFRb3M0Umd5THorckw2ckVNbEZQVHIxeDhVUDBGSVk5aUFkWFVu?=
 =?utf-8?B?VjY1RnlsZ0h5RDVOZkZPUG8yOTRSMTFRZFVQaUhDZnNSbW9kbm5aS1NJb2lm?=
 =?utf-8?B?SFhwNVFnWDBQbFdCRzdXc1cxT3BjSFJNN2Q0c3VuV0ZTYjlQTTMyVE1nV2cw?=
 =?utf-8?B?eWRVUmw4RWlNZnpFSTY1RElrWGhPcGgwS25iT1RSdzhUMng5QTZOaG1pWWVv?=
 =?utf-8?B?YkJhdDVxa0JHTnlnVXdhcklxZmFrLzVOL29OS0pOeVQvcHFwWEZ6RERjb2dm?=
 =?utf-8?B?MkFXc0dkcHBlV0JXdFlXbVhmbkt3ZEdmcnZNUGFkblhmRWhodWhCZlcyaTFT?=
 =?utf-8?B?aG5QRExtN2Vsd0FMTHRYbGNvaGlVRk5FVVViQmpKQTJBZUt1TDRtYm03SWs0?=
 =?utf-8?B?QXh0Y0ZVcWd0TDJJY1Ayc2lvNmp5S2VReFVBVTBWa2ZOLytQTTVQbFc0VjE2?=
 =?utf-8?B?eHhxSnE0bmF5RlRMamVXUDFqK0NqTkNUb0M1Z2F5N21oZnZMZWhtY0NaVDlk?=
 =?utf-8?B?NDBkWHl6Q3daS0IwYms5VktYa2dQaUF2ZlRsOFUvdEVzL1ErTkY2S1NyaTNm?=
 =?utf-8?B?c3dVbGwzOUFpQ0xRSDBSSmdYUmJEdUJQRTUvOEg0b3dkZE1QTDhvRk1vQURT?=
 =?utf-8?B?aUd6M0dINWhQMEx2M2hnTXd3MFNEUFE5UXBhREF3eWYzOEdaUmkyaTdFTGc2?=
 =?utf-8?B?SXZwMDdiQ2V4SThsbjRBVnlHbFdIVWk4d0tUTzB3ZmlJd0xhcXQ4cVJOSHNR?=
 =?utf-8?B?WGd4a01WQ0xJT3JRRGVxelZSQmNaVGpPTUQ2dmpDQ0JLNWJsY1NUZUVFdlVT?=
 =?utf-8?B?ZGx1WHJlWnArMTRPeUs0V2pIRkh2bHpJYW9mcTlzaTJLQ2w5WjVRTDhtTS9E?=
 =?utf-8?B?YkoxRStlUk92UVM3Sll5bS94SDhQSFcvcTRpR1lKMXM4T2NlTlcxUGJQMngv?=
 =?utf-8?B?enpPYWZ5SUsyWnFYWmtJaU9RZmJyN1pXc3hQMTIwUzc1S1J0LzUrdjZlMFZs?=
 =?utf-8?B?QXB1WTBuQ3VNZ25QSEk3V3lLZk5TdmpBTGZVOVI1anBScmpsSFBZS1RKeFc0?=
 =?utf-8?Q?I2UQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVozZGQvdWh5cEYrdFE2c3dYOUIya1dFeUc1dHUybXl2a1ExVFNFcCt1ejg4?=
 =?utf-8?B?VWZLcTlDYzVMVW5LdVZkdnk1NStPTE9HWUQ3TllmQTlYcVlzTTBGS3RrL0dx?=
 =?utf-8?B?eE5YclVRMFJCaWNhTWxXVEQ1R1pvU01QMVFCNU9PSDF2ZDJYUUVxdDZJUFlm?=
 =?utf-8?B?RUxSaURxMDlqWE9FcjRFeGF3SmdKV2lKelVkRGtIeXRrRHVzdG1uK3FVL2tZ?=
 =?utf-8?B?b0NHdU9hZjlKSk11MmFlOW5laUFXd3JWcytjaGRNSTJPQTZJSDZnSHJtRVd5?=
 =?utf-8?B?L2V1Z3plUy90N29OWkljTThmRWFXWFVxTHprd1V5NGQrWjNMaHZ4Y04wQU9F?=
 =?utf-8?B?NzUzMVMwSDhaZEdHQlgyNTZSSmVrNERTbTZpYWdpWmJCZ1h2U3NpOXJTMVR3?=
 =?utf-8?B?c21wSC9IWnZyMzN1TDhzV05aVkZCbnVpeXFPMjBnbWVvdlVZOVZzWVI2WmZZ?=
 =?utf-8?B?WDUzL05VU2c0Q0pmSjhDV1hMU3hyTGsyNmMvdDJCL3E2SUFOS0MxSEJkdkI4?=
 =?utf-8?B?SW1qTzhpbjBFcVpXYTM0bnkyUmFObmdMTmROY2I5TkZNeUV2Lzh0dzFPTSto?=
 =?utf-8?B?TWhQNzYvcXlzWExuMlpyU0Y0YXcrSSthOThMcjBGdk9zNFlXSTRXUS9rR053?=
 =?utf-8?B?ZDF1ODlwUVlISCtEcE9WcWFjYlZKVEJ1Q05OcUpuUjlub3pyWWRuNUtxellr?=
 =?utf-8?B?REZZWmtSNXhZdytFRnpXcDE0RDRKQnFwZzcxMlQ2NlM2WTNGcmZiMTZZOE5T?=
 =?utf-8?B?ZE9vSUw3NzZVbFNQaTZMd2taZVlpb0ljREJkS0NZWFUxOVdKTTdvcVMrSDJB?=
 =?utf-8?B?eFFzR3NWWXpub0pJYVVyM3lLcXB0cGtsMVVWYnprU2tkV1hJdDJtd1lEUUxY?=
 =?utf-8?B?Nk52cEpjK2wwNytvNEZQZU5PakNPSHlzNnJvaytNTTEzUEFNYzZuRWhmUTJn?=
 =?utf-8?B?SlpNVGRBdkhtMFBrOEdqeDF1K0JXR2VRNFN4VFRJazZ2YzdqUDB2bEp2cWF5?=
 =?utf-8?B?VGtPaGhWR2JLVXNUUDZ3WkRScGFTWTRhcFdnVDZkRWVWYllZMXdqZXFEZkR0?=
 =?utf-8?B?RFZYUWN6NWZKRDZ3S09nczM2a05KWU9mVUsrTFpoQ3l2VmplSGcvM3lYM044?=
 =?utf-8?B?MkNjd0VmbjRTUGJkTFpBMlhYMG9HTTZVL1FYTVNzNi9XTW1ML01rbHQ2ZUVR?=
 =?utf-8?B?ZnhCeDlUVWpFSFhqQy9XeVlJdGNVTm9EMEZ1V3NoOHIrRHJlbDBEdlBMSHNl?=
 =?utf-8?B?OUdaelQyaGpFM0VKeTFhK2JudTVEK1pKUDJLZHlDVFFPNTUyWDQvWXp4MWd2?=
 =?utf-8?B?Qi8rbXgySndUTHkxKzZmQzE3Qm9RWVYyZ3J4V2ZGenhidTJCdlhYWTlJbFRX?=
 =?utf-8?B?Vjc1RWVvTHhHV1huRnIxaDlEYm9ZVlJyb3BZWEtKSFgzc3lnRjU3eGRnNkRB?=
 =?utf-8?B?U2N6NTZZQ3NMcHZENVdVRW05UGQyWUc2Yk0wVDFiU3QzdFk1c1B5c0lVYUZR?=
 =?utf-8?B?cWd6aGNSdTFueHg2ekx3N3pNbmJnR3hmYUxiSE9zb2dyemh5a3V6QUQvT242?=
 =?utf-8?B?Q1oxMDUrY2V1YjFiNkc4RThLS0tuKytXWkRqYVFuem8rVlBEeEg4T0srTE1H?=
 =?utf-8?B?SEplZWg5d3VtTzU2aDBKejNSNVZBZzc4REptRGgwLzZTczNMSU1RSVUyWVdN?=
 =?utf-8?B?ZzdpTUFqcGlYd0wrKzdjWkVIVkUvR1hFSkJIUmdBam55OGRnL1lYUVErZ09M?=
 =?utf-8?B?YVJVa2kreVBEVUJsYlZrdmtTVTl4UTAzajlSa040U1Fta2pHUUR4bHVhY01X?=
 =?utf-8?B?VXE0dUdNODk3eTNKcERoY3BoWGtuYW4rZWdJYU9JMEZyZjhqblVQVnJtS0Vx?=
 =?utf-8?B?YkxpdXFMbHRqamZwWkY0YldtcSszYTkvcXBLOFFzaVZRclh5NDNybmpQNC9X?=
 =?utf-8?B?WnZ4ZGtTbHNLeTd6TFdyVnVYZ05kcnNjc0Vpdyt5Nk53QXRaMzhkUnJIWjk5?=
 =?utf-8?B?VVR5OTNSVVBYdDcya1ZZcEw5V0tiVzIyYzlWSjJnU3ZJaFUvTzJkaEs1aWFp?=
 =?utf-8?B?NElKeG1qcjFkK1FJazFkR0IveG03V3pzQzFxMVRYajdEeVVxYU0yQUJqOXpl?=
 =?utf-8?B?ZS8rY1hIM2RyLzBiQjRNYU92dVB4QkRCU3MrWUQwdHhnSmwwYWNLMnBYY1RD?=
 =?utf-8?B?dDk0emp2cFRSZFZIUXNJQll2ZHkyYU1YUTNhWEIrdjlXUDZYWFpCUWpwS3dm?=
 =?utf-8?B?OHo3MVM2U1VZVitlcjFwVEovRnhZcTdaSzZDbzZ0YzV5cmpubWpvYXdkUUd0?=
 =?utf-8?B?Yk9DL3V3eXg2VGJCakkvTVc5WFJTVjJ2aVMrclVGYUY2UHpkN1o1dVk3Smc0?=
 =?utf-8?Q?+sIVLocBu3TihSD4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b3a454-506c-4e19-bb4b-08de57c8f894
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 02:09:41.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anSjkDSvHEeWBRIqdH62qz5tP2c3fYrMOBzQizohZaHiOIsQicnNVdJc3aMQATsszsF49y7smpipFlt0Td3fE9mgwF66u8lGurlOleNl6xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8794
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Internal PCIe errors are not enabled by default during initialization. This
> creates a problem for CXL drivers, which rely on PCIe Correctable and
> Uncorrectable Internal Errors to receive CXL protocol error notifications.
> 
> Export pci_aer_unmask_internal_errors() so CXL and other drivers can
> enable internal PCIe errors.

I folded in the following to this patch because opening up internal
errors for PCIe drivers in general is not a goal.

1:  cb9a15481d8c ! 1:  7433e0204753 PCI/AER: Export pci_aer_unmask_internal_errors()
    @@ Metadata
      ## Commit message ##
         PCI/AER: Export pci_aer_unmask_internal_errors()
     
    -    Internal PCIe errors are not enabled by default during initialization. This
    -    creates a problem for CXL drivers, which rely on PCIe Correctable and
    -    Uncorrectable Internal Errors to receive CXL protocol error notifications.
    +    Internal PCIe errors are not enabled by default during initialization
    +    because their behavior is too device-specific and there is no standard way
    +    to reason about them. However, for CXL an internal error is the standard
    +    mechanism for conveying CXL protocol errors.
     
    -    Export pci_aer_unmask_internal_errors() so CXL and other drivers can
    -    enable internal PCIe errors.
    +    Export pci_aer_unmask_internal_errors() for CXL, but make it clear that
    +    they are only meant for CXL and the status quo for leaving them masked for
    +    PCIe in general remains.
     
         Signed-off-by: Terry Bowman <terry.bowman@amd.com>
         Reviewed-by: Dave Jiang <dave.jiang@intel.com>
         Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
         Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
         Link: https://patch.msgid.link/20260114182055.46029-10-terry.bowman@amd.com
    +    Co-developed-by: Dan Williams <dan.j.williams@intel.com>
         Signed-off-by: Dan Williams <dan.j.williams@intel.com>
     
      ## include/linux/aer.h ##
    @@ drivers/pci/pcie/aer.c: static bool find_source_device(struct pci_dev *parent,
        int aer = dev->aer_cap;
        u32 mask;
     @@ drivers/pci/pcie/aer.c: static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
    -   mask &= ~PCI_ERR_COR_INTERNAL;
        pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
      }
    -+EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
      
    ++/*
    ++ * Internal errors are too device-specific to enable generally, however for CXL
    ++ * their behavior is standardized for conveying CXL protocol errors.
    ++ */
    ++EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
    ++
     +#ifdef CONFIG_PCIEAER_CXL
      static bool is_cxl_mem_dev(struct pci_dev *dev)
      {

