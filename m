Return-Path: <linux-pci+bounces-37393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6284BB2B74
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 09:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF6019C2E82
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82C92C08A8;
	Thu,  2 Oct 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RtMDcGM+"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F827B35F;
	Thu,  2 Oct 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390890; cv=fail; b=jLsAwUxLSu11Z9kCmm0P9YWmnyn7GStqBcfr5luypjObiyAlKunQP5FnDuvXUStjH7pN7WIgRiIpM609IDNnigP3uI4x1fbKadIZhr4YUsYCyp78FO4l70pV2YXuDoNleKVco7R+yaaxjGv0CkPgFeYu4ujE0cpvOskDgw8uQHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390890; c=relaxed/simple;
	bh=RrLKaYXpvYm34ZCgX8S68H/UzkoR4FJlBmNKA7oyTJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBsiKR2syQhwZsBIdzzYs6+nd4iAjluBpW3KGujNvh/8MKfQLFpShIdNZF0Sl0SxtPlnkoSXjY4etkITCo5pPjYUrxXJbxUGVwc0bHSBMb7+oqZTKuko1TIVnmimd+gbBIASFKv2B62gWBBCdu+D6zs+nolwp7tIJKUo5bQMT8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RtMDcGM+; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBv1jPlsay/XJzkE84kriJsP4WF7PpuGjG7RYcosk7RaUtG+ZuMy97QLwGvFAt3vvsDIgh/BjnyqAq8XgmQiO2FdQDbUjcaewGexh/SeXJ8HhfO8cEB5+ohx5o9okkvxBdt5dFyXU2hhnG/7tXSVxSJAFYz5KnGac4uqXrmxwx2NSgggLbl/T3aaHVwO+HfkNe7wQpRQBdZvJOXL4EsLn1qpKvKl+QBva6DPzoPwImWs+IlYf/ERGceXrAm8Fh12WNlRy20K8HEyBcHaYh5CncEKFQ9n5D/uOw3fuv98oR4VBhV/772gp0UPAuze2A+f5os10UlLxEYr8SK0tOkohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrLKaYXpvYm34ZCgX8S68H/UzkoR4FJlBmNKA7oyTJM=;
 b=B5gCqLPojgWwsHDpMmFAvXngrv2jd0XUmXenhkDpaD0BU2dMVx5JCzfG1MpsARgcuWUBMJC3ePZ/MJj7R+iC/WO/RmoLB1uJSovIGIyeggH9hhTsrg2t7Iofp9x1a9as/T3i1xellDOtWuGRsYJ3okuMJb3cDftHEuhdIkNH+vfBy2t4lkpGzHbAOaDbxbwi4QWI7Zn59XQB+n0x4eLtdsSJpfpfmtXof0xa7tGkXG3YhKC5Bdz61tB/FjaTGoJzMz6Pctgs9a4Fj1U32l4hxo/iM4QUd0bfNosrvNPk/PaZxs5lNsGi18/far6uEc4L8BnIkrk9+yu5d3X78anuLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrLKaYXpvYm34ZCgX8S68H/UzkoR4FJlBmNKA7oyTJM=;
 b=RtMDcGM+vBiHYnEqV5DhVyhnXGJr2hnJgVocwlDbPgvUn4vJYPofbTQGI/bORQI8DFf6tmHWb+GwYHcwXwCXzLBhOE5pqFmaZZ5QLMKk2ka2shT8ImDVY/FISVCO6p9GtzduvURWulV+R8HqPaQ2upYPrFQD36NmB/MXXggbPmA431U0YYZgE1o4VRybLwiTIbUF3YZLqlgIY9uMT9O72PcBGONuYcnXsuup0rE98sKqPV5PFv0aphcdHMnOH8Zp0RlbUrhm/S81k1P46cZWci8KsXtRvFpLqq1Qc+URPY3CUeT8m/HbMmpjVT2XCn0u2GEFSlAQq1AHbsT5xjLenA==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:41:22 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:41:22 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, John Hubbard
	<jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, Surath Mitra <smitra@nvidia.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas
	<bhelgaas@google.com>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index: AQHcMlax46GxNkf23km9cIaKZr5arLSsb4WAgAILsYA=
Date: Thu, 2 Oct 2025 07:41:21 +0000
Message-ID: <0859ec68-6db7-4884-829a-c1e06a6b481e@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
In-Reply-To: <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|IA1PR12MB8285:EE_
x-ms-office365-filtering-correlation-id: 2d60ccc7-912e-4641-dd46-08de01871528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFZab29GVlBLaERWcGJvQnExa0lZUHBRZFEyS2ZqVnozQVcyWW1YRWhnT3JW?=
 =?utf-8?B?aGoxMk1YNGdhMCtEOTFVcXlYaW1VdDVDQXBTQUxnMFo2YVJIVzRQajNrdFQy?=
 =?utf-8?B?TG1iUmY0MHBtaktreUg2Nk9uM3dmWVRaRnpGcElmbUQ1NHp4TTh2bGQ5SGdT?=
 =?utf-8?B?T2RRZXNtc0ZqV3ltbWM0anN2RzlPaFlXT1l5VzU1SmVrd0VZemtYN3VGbURI?=
 =?utf-8?B?OWJ2Q0hGTW5CWmgrcFE1YVV4alRrVzdSalNCbXd5K0s4UWZNV2lKMFVRcGI2?=
 =?utf-8?B?NENmSTRFRE1Lb0FOdlRScTQyS2x2V2VKRkFHbC9QQUZOWXlydEFackhUL2Yv?=
 =?utf-8?B?bHgzTUJVaXpsbldEaW05aDF2UWRtZWU4TGlnaFVZbjhtYkppaTB2bXdvZDlo?=
 =?utf-8?B?YkRYUHpFZlZVYlpYZFRFNStLMFJ5R2k1cXMxdXVwUkRNaU1JeHdtZmxYU2g4?=
 =?utf-8?B?SGdMMEQvT2JnSGErL3Q1aWNMSFJIWXdaN3RzOTdaNVQ0Wmw1cld5SnpzNXIz?=
 =?utf-8?B?SWxlT0JDaytObEZQZzBBM0lyQU1DSW5Obi95TUJXZFJHQVJZMTI2UEs4eDV1?=
 =?utf-8?B?VXU4NmVQU0RRQjVGT2FxNDN5SlFHazY0U25SUmFTbTdpb2hSTGdCN3VKRXBQ?=
 =?utf-8?B?K1BaSE1rd3NzMVJwcVh1Z2hBb2M4ZldHQjNKMmhXQ2pXRmlhODVpbmJNTmVN?=
 =?utf-8?B?YmZQLytNRWtaNVlXODl6cXYreXFxZWFFdk1YK0ZkeEJZRzMrd2JvQXQ0SmNt?=
 =?utf-8?B?TUJIVjF5MzNTZU13MHFVYmkxZU9PVk5NOWJLTDB0bmFBOXRSRVJycXJ2SmdM?=
 =?utf-8?B?K1JrQnVxWHRtZUJWa3RnL0pETEx5Wm16MmNNUW5XdXRIc25vdXZTS2pHSUw1?=
 =?utf-8?B?TE1JVEo1MjU3MG9zS2J2REtNNUp4VGJYbEZpVDA1SmVGT1R5UVZ0OGltWFJ3?=
 =?utf-8?B?anFHUmJZM29nRDhQdG1EUmJaOGRGa3RzMXJQZk1MdEFnSjZlQXVCNEN1OXhM?=
 =?utf-8?B?dUl6OS9PSjZoUU03VWpVZk9xc2wxcHo2dnBvemtQZlprakxhZmFiMUV5cEp3?=
 =?utf-8?B?MzZrclZyWE9HMTJZMjN5T1E4dU02WWxjWnhHRTJ2VTQrMXNCeTRaVHU3T2hl?=
 =?utf-8?B?OEJxbmVDZG5ZeksyMGgvN05hK0h0OUNEYkRRRk55MlVSLy9teWNIMUN2MDg2?=
 =?utf-8?B?YzJZOXVpYWp4SHZNUVRTK1pFa2VRQzB2Ti9RZVFmbWJ6TVF5VTNrTWxrVXdK?=
 =?utf-8?B?L3FjY2ZWTzY5S0pFUVRKUm9qaExRbTcyN1p5dFUyK0I5Zm1sR1lSQXc1OTdj?=
 =?utf-8?B?aDFHT25XQ0swaHdDNjJacFFiQWs5dllGWlZRZklFdWdQOFF6OHhqcUlLUnpw?=
 =?utf-8?B?cEdBeEdLRDNWSSt6SWJqQ3RQVjZrVGVJeGlmclQxSFVUbWhtRnRHYXJKL2NZ?=
 =?utf-8?B?Rnh3UVFpaWJEZGNFekpLdzJqN3BtV0ZzRlBLbVhscUlnc2Z2YkdnZENrbU14?=
 =?utf-8?B?b3lmL3UyUG9yeUNRejRoR2tjVWNiTlZlOFdQT05hSFk0cDJpeHZVdUEzK3Mv?=
 =?utf-8?B?TFN6cTBEeEMvZ0V1elJOaCtoOHVnQm8zaVZsSHBRWXhLYUprempPeWdXSjJS?=
 =?utf-8?B?M2RvOGI4c2VMTlNnQTFnSUNSaks1eTZzMGpEdDhNc0NHb1VpYityMWIycXlP?=
 =?utf-8?B?djMxOUI2WUpyMmpGYklMS294T3o1dWVoVGRTeVI0SUdlRmw1T1k3TnFtZXJT?=
 =?utf-8?B?VWVTU0ErUWhUUFBYZVJWSFpoYUZ6Z3NWb2JTbVo3dGZEZkRFUmZiZ0sySVZB?=
 =?utf-8?B?cjBWSzVxc2huZmgrT1Z0MEVXbm8yd3RUNzU2d2plR041RStRK2lnZGNPWHBn?=
 =?utf-8?B?U1l6eklRUklPTUpGZ2Y1NThQSzBtWWxRSUJvcnYvLzFPR21VUVMwT0l6S3dR?=
 =?utf-8?B?NEd1MU8vdFVzVFZ1REN0d0JGMUhVbjFWYnVWNGRTY2xRcW11K3FrTXVzakVS?=
 =?utf-8?B?ZXl6THVWMWxIcktFOGRXeHpvRzR5S3BMT1BzTTN4VUlEMGwxTVVpUnB6YXBK?=
 =?utf-8?Q?posvel?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEpLMG5ld0JiWnZYK2pWN0JnWW5yY3JKZUR4eHJFQlgwNWllTkhXTm0yRjJW?=
 =?utf-8?B?eHZ1aHdRK055ZVRlSDY1bEszMXZKTC9OMmo2Ry9NWVNPYzFLcHFURzhiUDd5?=
 =?utf-8?B?bFRYclYxWllaZHduRVpaQTlxVm1nRlltalVWQldGSndzMUVWd3hRNG1aSWZH?=
 =?utf-8?B?THkwbWlzcDFNOC9Edlp0bmtmZGJWWHhLUlJHRE8vUVVOanNFaEkxdGs5V3Rn?=
 =?utf-8?B?Y3l4emJLM0o4eXBZdUhaSE9xSXZMRkxGSDZzbktscG96ZnZlRVUxVlRVVU56?=
 =?utf-8?B?TUVIQU1LY1U3UHEvVkF3cUNDbnY4VzgwZWRXY2ozazRqVDlFV0Z4NHBTM2Ru?=
 =?utf-8?B?OTRnNEExdEw1SE5YMFZwUlVlQ3lJVXZtb2E0K3UwdWw4Zm9qY3R4NmM5R0U2?=
 =?utf-8?B?RTl3WnBESDlEZTB4SXVqWUpKZlg0V2kvTmhLRitrRUJHb3QySGNKZ0ROZXQv?=
 =?utf-8?B?UzI5WVliTFFHTEFVcWZEd1BMWnFwUUU2Y0V5Ym5QV3FFbkY2WmpUeVVZV2ZW?=
 =?utf-8?B?bEdybCs2REZRd1V1Q05pcWszNlZzUUJTNTVWUE5iZjk3amFNanhWZ2xxOEIr?=
 =?utf-8?B?Y1hUalQ1eDg1M2FZSW9zTURqaXg1YzJKUTVXbnJVOTN1cXVFMVB1RDJMd3hi?=
 =?utf-8?B?T1h3TjhBZkkweUFCc09iSVBXV3BrSzM1SytmQ1dVeDdyUmxPWW9XUFFPV3Vx?=
 =?utf-8?B?U0Z5REFLTmJLRytEUWcram0wUm9hRndDRzY2R2ZuWE5uRjc2ZWJWUGFVZ0N2?=
 =?utf-8?B?cmVBUjUrQ2FncXYzSjNrTTd2RTVsdnFhOGpPdHdJdmdpaG5QNHZEVXRLbWZS?=
 =?utf-8?B?UEtraFRwMkRPd1g5RW1acXB6UHcxaVRnUmp3cXE2RDdoWXhXNjBZOTFydlJi?=
 =?utf-8?B?aElybHdsUHNYL09GUmVwKzYvTEtyR1diUmNiK2J6Vmk5TW1FWCtqL01pMG4v?=
 =?utf-8?B?SjRvODVEem12QThTZjN1RW42N1V2NFVsRlVQNCthWkdEa3kwMzR3NU0xSmtm?=
 =?utf-8?B?WXdVcWJsVkIyV29odC9vK0VlTXdNdzB6d28vTUVWdllCaEtMeExkL1l6cGVh?=
 =?utf-8?B?RkJVbnEyV0t4SW1DMU44NGNPR04xcXNUMWJJemsrV1R4ZklHSEVkRUh1Sm45?=
 =?utf-8?B?bVJ3emQ1cFRlK0k3UVp4NStXTzd3S0hWekgwKzNxYmNsZlQvNWpTWlN3TElU?=
 =?utf-8?B?aHVLRmFzbmI4alluVWVNbjlLTm12VHBNT3FjcVlIbTNJWWl6WUNIOGtTaXBh?=
 =?utf-8?B?SlFaQThXclRHS0hac1RjYkozWHBadFQ1ZFBRbjFTaCt3Qnh6VWtMRHROczZt?=
 =?utf-8?B?eTcwckVzWnpsQTNOaFJiSkMrQ3R6WTEzaUgwcHlwMUJmWHlTaExVQlVjLzNq?=
 =?utf-8?B?VkwyWUhRZGgyQXFINkhpWGk0Rnl3UkNWN0ZBdTYybnM5cjJzMmh5cnBUV1Vq?=
 =?utf-8?B?RW45ZWxNNzhzMnY3L3N1Y3VzNGVZYnVrV2hnbTN6S0p6RGduU3U1NVBidGxz?=
 =?utf-8?B?clYrbDE3S1N0UEgycmt4QTFaL24rMXczelR1TzdRQ1pHL0pSbGt2K1d6SmJ6?=
 =?utf-8?B?SXJqbHR3dy9kTjM5dkIxTjlUWUMvZU9UNmw5Sk5MMGd0bHZPMVBQMW5xZDJs?=
 =?utf-8?B?QktwU1hETFRIWjNPWlMvL0hTUUh4eFlEb1ZpSzB5MUpNTy9sak03ZVhnbDJN?=
 =?utf-8?B?WkNSTGp0UEIvM1kzcVgzZEFTMWgydGJNMkF4bzRpMHlZQ2RvVk5XUDB2R2ph?=
 =?utf-8?B?RHdrdGZyS2NrNTZ0S0ErbGFWYk9lOFNZTEI2cHJyQ2dzNEo5N21mRVg3akpm?=
 =?utf-8?B?M0w4akNZd0VPRHUxQ1crOWVOcU1yWk5OT1NHeHBZMEpJbDBaVGxWVFRjMDNX?=
 =?utf-8?B?TDNXR1IzTjlSalhoNkN3bVQrWVh3WGhnVytZM240NW9SbVM0Y2NaV3dzejg1?=
 =?utf-8?B?NXpRVk9laWJzMjNrSlg3bzdRaWU2czVDbDcyV2MzdGVOYVhta1JYT0RRVnVX?=
 =?utf-8?B?c2laVXB6ZElVM0E0bUVKdUlaUm9xOTRiSTU3aFkyR05lcVdTOGdUM21MeFJ1?=
 =?utf-8?B?WExQeExrR01xWWVsbVl6RmRhZ0xENTVua1k4anB2WkRHYkI4eTVpT1ZUOVFM?=
 =?utf-8?Q?bLc0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C01CC55AF6BC014889B0F7A600A60B01@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d60ccc7-912e-4641-dd46-08de01871528
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 07:41:22.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Dl9kzER199jyPxC+zLJY41e3ttnaAQPvPPlMMQF/wKUy001uR/equGV4UgZnzDR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285

T24gMS4xMC4yMDI1IDMuMjYsIEFsZXhhbmRyZSBDb3VyYm90IHdyb3RlOg0KPiBPbiBXZWQgT2N0
IDEsIDIwMjUgYXQgNzowNyBBTSBKU1QsIEpvaG4gSHViYmFyZCB3cm90ZToNCj4+IFBvc3QtS2Fu
Z3Jlam9zLCB0aGUgYXBwcm9hY2ggZm9yIE5vdmFDb3JlICsgVkZJTyBoYXMgY2hhbmdlZCBhIGJp
dDogdGhlDQo+PiBpZGVhIG5vdyBpcyB0aGF0IFZGSU8gZHJpdmVycywgZm9yIE5WSURJQSBHUFVz
IHRoYXQgYXJlIHN1cHBvcnRlZCBieQ0KPj4gTm92YUNvcmUsIHNob3VsZCBiaW5kIGRpcmVjdGx5
IHRvIHRoZSBHUFUncyBWRnMuIChBbiBlYXJsaWVyIGlkZWEgd2FzIHRvDQo+PiBsZXQgTm92YUNv
cmUgYmluZCB0byB0aGUgVkZzLCBhbmQgdGhlbiBoYXZlIE5vdmFDb3JlIGNhbGwgaW50byB0aGUg
dXBwZXINCj4+IChWRklPKSBtb2R1bGUgdmlhIEF1eCBCdXMsIGJ1dCB0aGlzIHR1cm5zIG91dCB0
byBiZSBhd2t3YXJkIGFuZCBpcyBubw0KPj4gbG9uZ2VyIGluIGZhdm9yLikgU28sIGluIG9yZGVy
IHRvIHN1cHBvcnQgdGhhdDoNCj4+DQo+PiBOb3ZhLWNvcmUgbXVzdCBvbmx5IGJpbmQgdG8gUGh5
c2ljYWwgRnVuY3Rpb25zIChQRnMpIGFuZCByZWd1bGFyIFBDSQ0KPj4gZGV2aWNlcywgbm90IHRv
IFZpcnR1YWwgRnVuY3Rpb25zIChWRnMpIGNyZWF0ZWQgdGhyb3VnaCBTUi1JT1YuDQo+IA0KPiBO
YWl2ZSBxdWVzdGlvbjogd2lsbCBndWVzdHMgYWxzbyBzZWUgdGhlIHBhc3NlZC10aHJvdWdoIFZG
IGFzIGEgVkY/IElmDQo+IHNvLCB3b3VsZG4ndCB0aGlzIGNoYW5nZSBhbHNvIHByZXZlbnRzIGd1
ZXN0cyBmcm9tIHVzaW5nIE5vdmE/DQoNCkluIHRoZSBlbnRpcmUgc29mdHdhcmUgc3RhY2sgKGZp
cm13YXJlIGFuZCBpbnRlcmZhY2UsIGhvc3QvZ3Vlc3QgDQpkcml2ZXIsYW5kIG1hbmFnZW1lbnQg
c3RhY2spLCB0aGUgZW50aXJlIGRlc2lnbiBhc3N1bWVzIHRoYXQgYSBWRiBpcw0KdGllZCB0byBh
IFZNLg0KDQpOVklESUEgR1BVIGFscmVhZHkgcHJvdmlkZXMgZ29vZCBlbm91Z2ggbWVjaGFuaXNt
cyB0byBlbmZvcmNlDQp0aG9zZSBiZXR3ZWVuIGNvbnRhaW5lcnMgb24gUEYuIE1vcmVvdmVyLCBW
RiBvbiBiYXJlbWV0YWwgaXMgbm90IHRoZQ0Kb25seSB3YXkgdG8gc3VwcG9ydCAqY29udGFpbmVy
KiBlbnZpcm9ubWVudHMuIFN1cmVseSwgdGhlcmUgYXJlIGFsc28NCm90aGVyIGFwcHJvYWNoZXMs
IGZvciBleGFtcGxlLCBQRiBkcml2ZXIgd2l0aCBEUk0gY2dyb3VwLg0KDQpMaWtlIHdoYXQgSSBt
ZW50aW9uZWQsIGl0IGlzIHJlYWxseSBkZXZpY2UvdXNlLWNhc2Ugc3BlY2lmaWMuIFRoZSBkZXZp
Y2UNCnZlbmRvciBjaG9vc2VzIHRoZSBiZXN0IGFwcHJvYWNoZXMgYmFzZWQgb24gdGhlaXIgZGV2
aWNlIGNoYXJhY3RlcmlzdGljDQphbmQgc2NoZWR1bGUvcmVzb3VyY2UgaXNvbGF0aW9uIGNhcGFi
aWxpdGllcyBmb3Igc3VwcG9ydGluZyBjb250YWluZXJzDQpvbiBiYXJlIG1ldGFsLg0KDQpaLg0K

