Return-Path: <linux-pci+bounces-34789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C55B373EE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 22:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1E47C5987
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 20:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3C2BD5A8;
	Tue, 26 Aug 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HolLOsvH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159430CD81;
	Tue, 26 Aug 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240706; cv=fail; b=L5tBG6KSNeno3+eACdlUgTlirkeTBs58Lakhg8JITBJwJOF2hlTAqFhxK0D/bcjd0tuKDowD+VwX8p52OZFgfFdiBD0zqnqS5ih599wsxKN/N+OZIh/M2PrKeorv6rzZvic0T8TkF/yHpbsSBUSE4U7O7bnGiJEKT2ZqWJkUXUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240706; c=relaxed/simple;
	bh=6/kBMT28MF3qvy9Khk6SIhUO6D93TfjyGtDiT2gn4y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ql0dDLOUNluqllOsXz2VDJwZxr8mm89DMMNxM7q4HhBE7PPm3HqLW1VPatvT+9x7wg9qnNtb2LcskTGCrhGpwJIi0YDciN7tZ1dsY3FNbH1PgHSpHc1n8qhUMAK53VC+Phbe9i8eppBUpvH7BR2OY9Zn9hoAHzmN/v3b8Oncyec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HolLOsvH; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6LXefGFUnmNT0zxjRap26C2e2RzPVZIFmyA1R5/C/eGqQOXHMpd31Z5CRdF1A1AhrDVnUsivtK012g//hhseaBg81r2HTlBlcdErfmdP3GQly2Irxa/9b/fTPHLvntkwmHOHEngYfhrmdqK+cvM0BW9aZ2v7yyE27ozw5fbfhCYixDMeqRIzeqajI67JaqpVvJ+pGkDOt2Ax1GvyuXDkO+wn+OaAFlhVeizq94B3oC7KL7YTxM50PLotPnKelD0bDmn0yDVqun9/4+j2TDbo7UxdcCmprB4/UQMAfcGQcHm1IzulY8bPOpYE8XtBAmiHhPJO0NhhFBC/3n+g4RkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD5lK+SnFF70E+YvWG/sJMC9/FyWZB4vxzrznoIpV3g=;
 b=h/mu58xz4+Frqx/3mozIyDkP6zhOQWetU5tamlyRjw+QsZXMG+jXVFlcTwPlcj6fO/kSwEjY+kIG/3G4m/it6bxoJAa8xN0P7w+hQKwMqYZpRGo0opuJBFzvtgXA4UJ4kxTuy+3y3FpQh49Jx/1OkoyS7sN/4WiDGzGNku6MWrpsjXZXTn9Re29GVaW4ZQRKm55SMyWzRt47jO3c0Xjwzuau/6ZzpppTOQmz86+KtiuOM0bFwV5jB3XqAiTP2mUPbAxx5ckze2ZO9ADHWP6X33XAmb9/b9XiIX8IApE+8cpnAGHlckUSX6D7iiU7I27xdz4HRBqchB2jnmE5SxvNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD5lK+SnFF70E+YvWG/sJMC9/FyWZB4vxzrznoIpV3g=;
 b=HolLOsvHDY1o2VL+rnb0WHIXSBPAi4fmZO5UUHJ0iZDD/c+2U+uX4ISF+u91rppFZlUxR4lMmtA8wOghTjyAtZDCQ5caGBs1mYc4BoOreIldrKAjv6RtWKlUmk+oI3FMbyPg6/Gkw2waBSTHUTfKAuuxFRw5WmH8EG/GEIWCdcuRSOfXj3bKkfC08+8+xanP8VupjzGasgDJOt5bYWWYVv0h5uiYEHQcKiORMoWFAsAJa0HPA7dHYDKJq1RHcTuZQFltisGYzgLG0tDdwBtR323JddXkq4LMy8i+za/W3kCWGO7WE6TihO5HmPA6f80034SmUa8y/qFyoPAWWo4X6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 26 Aug
 2025 20:38:21 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 20:38:21 +0000
Message-ID: <b1cbdc99-317e-454c-bf03-d6793be5b13c@nvidia.com>
Date: Tue, 26 Aug 2025 13:38:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] rust: pci: provide access to PCI Vendor values
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>
References: <20250822020354.357406-1-jhubbard@nvidia.com>
 <20250822020354.357406-3-jhubbard@nvidia.com>
 <DCBIF83RP6G8.1B97Z24RQ0T24@nvidia.com>
 <DCBIPY9UJTT4.ETBXLTRGJWHO@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DCBIPY9UJTT4.ETBXLTRGJWHO@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: b2075ed9-5779-40ea-8c59-08dde4e07f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXZDTXdZdjVRa3QvdUNOdVdOS0Q5aTVGMmsxenVURldFUU9ya2FVK2Y2em5O?=
 =?utf-8?B?NEVndmYxTkVDalJIc04vV0ZkVHlXU2tFYjkyYjFNazV3VTYrWnhEZm5FV290?=
 =?utf-8?B?OXpQUUEvdDJIUjlmTUkzSmcraVpIdnJRWVhJS2tiL2cyMTVTQlVmb2Vqd3Aw?=
 =?utf-8?B?dE1lYUdLSHMyYTdReDkwOURBeHRMUWloQWJFaDJHT1RVMWgrS2RoU3ZjU0xo?=
 =?utf-8?B?SzEzUnc1eVN2WlJMbXpTQ1dJVFhYQU1PVmFpS3BkWUR0QjNVOENRSGllS2x4?=
 =?utf-8?B?TlMzeUU2TFVCTExWRk9ZYVFqaTVZS2dvcnBiQTEveFByb2NjR2QxdGM3bXVN?=
 =?utf-8?B?Mk4xc1VGNHBWTVNUNVk2dXY4UUI1T3A5ODg0SlEwMm4raTdRVmcyL08rL0Fu?=
 =?utf-8?B?K3h4TURlSmJ4VnYwNDh4VFVaU1dUNzZLcjR5ME5uOUdvN3VZNEJyRDdYZVM2?=
 =?utf-8?B?QUExbDlEaFpYalBpNVM2STFScjl3VmloSkFJMkUzTEw3Z2JoQ0xSMlNEMG92?=
 =?utf-8?B?bm9XNmhNZEZKcHoySlk1enU1dERmVmx2NVlFbHNSbEtaalpxY2JPSFRKUTJE?=
 =?utf-8?B?UTJ6d0xJWmhEblU1VHhGVmZSMmxtTjQyZUxHR1BFV0dwWExyRW9VeGVHSmVV?=
 =?utf-8?B?eHFDanRnakt0Mk1SdEMvb2g5eFgxV2xZYkI2MXkxbmpGaWdoZGhOWTZnbWk3?=
 =?utf-8?B?TkVuTXpKRnYyY2FXRG94OEFhaWZ3aVlPN2lxUWl3Skx5ZVVIUkxrbW9GcUlo?=
 =?utf-8?B?T1p5OE1XaFdvNzJtMko0cmpIYUtxQmYrL1F0MmZKZHdJb3hPMGVhaGdYbzJM?=
 =?utf-8?B?Tmk2Y3JPSEFHQ0xlWVhSWVVpaGZCSThQV2VnOG02SC8yMU13dG1uNytKRzk0?=
 =?utf-8?B?TGExODgzV3FtVFUyWXBHRkEwVmFhUGpxdHNPa2YrY09DcmlIYXpvZm1VcVh5?=
 =?utf-8?B?alJwTDJkaWlVQ0Q4NTBDRm1FNTRHKzgrSXFQWlZHejJ4TlVka0FXMnlFNmRt?=
 =?utf-8?B?amFkTzJCOTFlRWVXaGZQcVE2akNzRUhSdWRCNnp1a3hTNjBYVnE2aDF5Tmpo?=
 =?utf-8?B?aHRnWkZVOFNqaFNEc1hQNC9iRVcwbWNlZHRsVHNRdngvYVhaWWw5cTRzdkR1?=
 =?utf-8?B?d3VzSVNSVUg3cTNNV2FGelNyeVF4ZzRXS05RQy9XYVJDdC9QYlJNRW9TOXBT?=
 =?utf-8?B?MEpobFNKT2J0MklkcTBZcHNSUGwxSHJqdkNXQ1cwK253L0pYMnlORWUwTDhC?=
 =?utf-8?B?SmJQb0JkeTZra2dldzFyYndhQnRMS3VCZVlWRkREVVoxcjF5NFE0VEJicmZJ?=
 =?utf-8?B?SGxSSDV4ZlBFejZ4WXBwalhCaDNRUVlWQisvVWNydDYwTHkyVlFucXExSUxD?=
 =?utf-8?B?TDQzOVI1TEhocG5yaFlvR2xWb0dPT2xhU3BINlhZK3J6RGNnLzB1MFdZeWN2?=
 =?utf-8?B?WkE0Y3Q1V0hmSXlOV2dkNFlYRFh6SEMzZFdTUStYTG5VNVMwdlIvWGw2R2dr?=
 =?utf-8?B?c3NpcEFuRFUzL3hzb0VSb214MkRUR2lWLytHY08xbDRXdklEM2MwdUlzb3Vy?=
 =?utf-8?B?T3hkUFVmcXk0VGNENmlucEI2QjZDV1RFWC9YS1NFQ1ZQd0pVQ2hkR2ZrMUI5?=
 =?utf-8?B?cFFxcS9qVjJ2QnVyZlp2dkJoMmRyd1E0WTZVS1VxdUdnTGtmZ1F2Y1g1OTdz?=
 =?utf-8?B?L01QQUdqRkdhMVFyQzdhTFNSWVZpanNiTER4R0czb0toQmFsRjVTdW8yQTUr?=
 =?utf-8?B?VnZNWjZhS3NIWmNQaUpadFlDRXZaZ005WGJxYkcyY29MWEVVb0RXcXRmRXVJ?=
 =?utf-8?B?QzMwMGhLdkdYK2dSQWkzMGpZTlBjaDAvQ0FBMVU0aXhYSVZ5SU8ybGpob0lZ?=
 =?utf-8?B?bXZseDQzTUxQVlFrbUhLUjZyVHJtdllpcVBnaWNmWmdXVUEwNDV3Wk9oVHVz?=
 =?utf-8?Q?wwO3LXzdVnc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlEwU1Z3cTM1ZGxyYjh5TktzaEJaU3lWeUI0ZjcxNWQ4WDNqRGRXYXM5emNy?=
 =?utf-8?B?eXp1Sld2Q1k1MnN6NnZOUSs5Q1dKdWV6cGhTakJ5VWJ4bExtUjlaRUI1d0NS?=
 =?utf-8?B?OCt1dVUyVmE0ejRUOUJDYWdKMkFPY0t1UlNuT1pCVVFHVWlSdzdsaXdCSGI5?=
 =?utf-8?B?SkZlRzhDK0lwMk12UldyYW1nUW12Rjg5RkJJR3JqM2cvNzAxSlVyVjhGdlR5?=
 =?utf-8?B?UlNEVCtINDh6VlhDZHdteU0rbTFHSEpHNnZBUlRjTFF5dlQ3N3BEMy9RUWF5?=
 =?utf-8?B?Vm40Rkg0TnU4T25TTDZNMTlmVTN1a0M1M1VRK3NnK3dGVGpMOXNOVUZlMjFh?=
 =?utf-8?B?dmc3enZUZDdrd3Z0cnEyMnhyYWV3amE0VUJDSDQ4Sld6ZnE0M0NmK29jeEtR?=
 =?utf-8?B?bGpmSW1IV3JqcXlFNzFRUlczdE4vUUsvTmRWRVEyblV5SEFadnI3ZGxXeTMy?=
 =?utf-8?B?VjBHVlJHZDZYTmJqRDJvZlE3cDBpdjc0ZzRpM2lnRGlsVVA5ZHpLb01rTnFC?=
 =?utf-8?B?eEdUdzAvckFYRVhCcGIxMzB5VlJtYWNZQnliemxidXIzc012dGtqZ0lJNWxp?=
 =?utf-8?B?N1EzQUJyeWNGRElNVVQ4RUUyMldwb1BGaGd0NEdwMlhKblcxTC9vTUF5Rm5t?=
 =?utf-8?B?ZnJjc0U4eDl6N3pqVTdEcGlJYUE5VExnTHFOdjlZQnA0Q21XZGVHTEMwbmtt?=
 =?utf-8?B?VVV5MmI5TjMvbnZIOVQvTExlSENBME4yazBGOVo5bHp2TUptVkIrM2dGNDVO?=
 =?utf-8?B?VVF1YVZNWTBHWm1CZ2RlL3RCeXlTaitmOWcvRWVWenNVRnhUam41U0M0bXc0?=
 =?utf-8?B?Mkg5VHJBZG9OUmtST3k2cTRtZ3kyQkhNU3NVZmRTbEhNT3g5U2VkV0lJRHpD?=
 =?utf-8?B?aHQ2Z3pVbFhGa2NWRXNFcUpEVldOZm1PVzFNRFcxNy9lZTVpZ1BjWThpV21o?=
 =?utf-8?B?bmd2eTFLY3JFbXpXWm1Vck5JU3MrTTNNQmpBcm5KZDREWFA4THZpMlgreWtZ?=
 =?utf-8?B?UkR4bWM4OXBFOWlBV2NZRCtTTkpISGV5SXQyZHMxM3hjMFFaaEdHSnI3OHU3?=
 =?utf-8?B?VHZaYXlxcDk2ZTg1ektvODlkb1hPTTN6N1VqUTZXU3lDZ29zSkNFOXdRTDF5?=
 =?utf-8?B?M2lWZkE2NVA1WEp6MDVuY1lsb1RVZjd6VkRkN2ZITVpRTzFZQkFRT2dKcXho?=
 =?utf-8?B?dkZHMDJMWWE3MFB0L0VFYStuV0pQV0plQ1pzK2IzWW9CbjBmeVRORVpqMlZE?=
 =?utf-8?B?Z0dSQ0RnQ1BRMEhLbGMyUklRT2FmSW1UNWRZWkcvUUpaNi8xQ3hwbUpyZUNR?=
 =?utf-8?B?ODFNSEJabWxDNjd3c09IWDNIbENiV0ZCZy8zWFZibUJ3aGZjcE5UeFZGZVFP?=
 =?utf-8?B?Ums4ZXd0ZWxJQURveFBBL0hrOEt2Vm5nc25aWU55N1dZV3hwVFRDUTl0MEhi?=
 =?utf-8?B?ZkN3MTdDU1NnQ3A1SWdSclFzU2F5cmc5ODU4UC9nRmwwc1JUcHlqcUhFZEZ5?=
 =?utf-8?B?TldLamdKbGFYU2s2azBLcHZJcmcwR3B3emV3enByTkpTNFJyb2s3UDlDSDhH?=
 =?utf-8?B?YXk4R2p1N0hEVUxycjFRdXdWTEhiUFZIN25NNS93K3ZESHBzQW81ZXlFdkNO?=
 =?utf-8?B?UTNhU1NBN0JXNFhwd3NLd0I5OCtFaGFtMGpTS1hrK1lxaU44S0czVE9oMmpl?=
 =?utf-8?B?cUVtNHV4S1phcEdtcHBDZ05pclM0OWVHTXhwSUlDU1BlUjlEbTVTNU1udEYv?=
 =?utf-8?B?b3pDV1lLNDBBU3Mwems5ZnR1NUNNa0F2YnY5RS9zUS8yTUsxRVRib2RRNHpp?=
 =?utf-8?B?YittSmg3cE5XUkVUMW45NGRlSzNtNmlDOTJna0FBUkszU3QxQ0dEMXJPbU5L?=
 =?utf-8?B?bmh5bEpwd2pQUmUrOUdHSUdPUXRTRm5jTXlaamV1UExWRXdGc3FaeXhHZHZy?=
 =?utf-8?B?by94bVFNVWVEbmViM29sMDlPeEdpZUNBSmFZUnhCZVA2d21xR3A5YmQ3cW5z?=
 =?utf-8?B?K0pQWnhhaFpxL0VNNlFoMWZmRjZnOWpPbjdPRmwxZThOVEhIVGFRYlZlUVo1?=
 =?utf-8?B?NS9IL1dzVnorTjh2SmlBbEQwU3J3NUVXZEJSRlg0dXVTank2alVQbHVCd2lo?=
 =?utf-8?Q?87XsCr/73yITTT2hdX++SUIdM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2075ed9-5779-40ea-8c59-08dde4e07f0a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 20:38:21.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Y5URSH4p9e4NoOLNrH3FmwFErIxcO3iNRLzVEpuhO5Y/vTvtSD3DjWIEfPRT/VOfAYT6FL/cEslulUrNV6c6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308

On 8/25/25 5:47 AM, Danilo Krummrich wrote:
> On Mon Aug 25, 2025 at 2:33 PM CEST, Alexandre Courbot wrote:
...
>> Naive question from someone with a device tree background and almost no
>> PCI experience: one consequence of using `From` here is that if I create
>> an non-registered Vendor value (e.g. `let vendor =
>> Vendor::from(0xf0f0)`), then do `vendor.as_raw()`, I won't get the value
>> passed initially but the one for `UNKNOWN`, e.g. `0xffff`. Are we ok
>> with this?
> 
> I think that's fine, since we shouldn't actually hit this. Drivers should only
> ever use the pre-defined constants of Vendor; consequently the
> Device::vendor_id() can't return UNKNOWN either.
> 
> So, I think the From impl is not ideal, since we can't limit its visibility. In
> order to improve this, I suggest to use Vendor::new() directly in the macro, and
> make Vendor::new() private. The same goes for Class, I guess.

Correction: when I went to implement this, I discovered that there is a better
way, which addresses both Alex's and your concerns. 

The incremental diff below shows how. It provides:

a) .from_raw(), which in this case matches conventions slightly better
   than new(). (I'm still learning that the Rust way is a bit different
   that the C++ way! haha).

b) Only the parent module (in this case, that's pci:: ) can call
   Class::from_raw(). This is exactly what we need. Fully private methods
   wouldn't work, but leaving it open for any caller to construct a
   Class item is also a problem.

c) Restored infallible operations, and with it, Alex's request for a
   reasonable behavior here now works once again:

       from_raw(0x10de).as_raw() == 0x10de
       

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 0faec49bf8a2..40047a7433b1 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -418,7 +418,7 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
     /// Returns the PCI class as a `Class` struct.
     pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
-        Class::new(unsafe { (*self.as_raw()).class })
+        Class::from_raw(unsafe { (*self.as_raw()).class })
     }
 }
 
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 1291553b4e15..399436ffaab9 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -51,24 +51,15 @@ impl Class {
                 pub const $variant: Self = Self(Self::to_24bit_class($binding));
             )+
         }
-
-        /// Convert a raw 24-bit class code value to a `Class`.
-        impl From<u32> for Class {
-            fn from(value: u32) -> Self {
-                match value {
-                    $(x if x == Self::$variant.0 => Self::$variant,)+
-                    _ => Self::UNKNOWN,
-                }
-            }
-        }
     };
 }
 
 /// Once constructed, a `Class` contains a valid PCI Class code.
 impl Class {
-    /// Create a new Class from a raw 24-bit class code.
-    pub fn new(class_code: u32) -> Self {
-        Self::from(class_code)
+    /// Create a Class from a raw 24-bit class code.
+    /// Only accessible from the parent pci module.
+    pub(super) fn from_raw(class_code: u32) -> Self {
+        Self(class_code)
     }
 
     /// Get the raw 24-bit class code value.
@@ -235,5 +226,4 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
     ACCELERATOR_PROCESSING     = bindings::PCI_CLASS_ACCELERATOR_PROCESSING,     // 0x120000
 
     OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
-    UNKNOWN                    = 0xffffff,
 }


thanks,
-- 
John Hubbard


