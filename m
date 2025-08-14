Return-Path: <linux-pci+bounces-34011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F0CB25801
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 02:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD48B7A9844
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB222FF64B;
	Thu, 14 Aug 2025 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bATbLodr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD22FF655;
	Thu, 14 Aug 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129761; cv=fail; b=Yn0Q72W1Xdq3ageauezj7SP/xnYDJ9RnZo4zQTsENwKzGbkhjivhnUE+E4zrcRTnCQbUEn5USJIBKZ26mAqbczRp3mbcIFAzuWl/QKO6FddLaRS0RlmWpGLgHm/5FJR0Eils/iUxbv9itrUR16Kv5O4T2324qtS7yhbsaE5NpHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129761; c=relaxed/simple;
	bh=2zTFMYbRp4+NTTa0NGUR60io8MmGD9A9d/95a5nxwsk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0cwdkpaAhwoKkZTRddMASi0CCsmpimCJjTzOdjvWeDhy+Oz4tYBg9aTl6uD2FDQJeMxeSPcdlqASprcmQmYxpyQ7KXLXJaFaA8b/FDf8G1vg//EN92QKBX91k7AmktJm1Jv4fHZ+jyRmJopT0DTES1wcK4EkHMJ39gpTNqPR8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bATbLodr; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ3EibTe+ZAeGcPtgcIFWeZFRx8gKLtJo/vGtgR1s9Ljh8PkM+VapR2E3RwjdIEr0AUUe118AdgpAua7j335nPJRFoaOSwHW1vOxQRxiBGtA+wHxfe9G94+BuIlEYAHPqmMy0upNfFKpm7CeUWJUOoKMfiIghWjNygN02OZaL78xgZtZm+iroCyw8BwsTSNYhC3syWy2ptKrVLsrB1zhlFuyA8xBl+04fR8M/3Rv9QNea51ssMSjYobHGMocF9l2agruyPcCR2aGpeL2C61fMK/i5nIU1O8nCvZwabAFRa/tMM84k4WSBOt2IB45610solVs/8yCPPcwmoi2fXmEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUThYgBNgMVqrwHy2zNzQ/kpHOfwrUYzYDijUK3d1Pg=;
 b=T1dPsFBai/STwXmKKF9osFjp1ffkbT9M+zevz9L8hUSIitBTUSnyF9Kg+PTqgXzWmT4s2vUCH+gWOsbGkj+NM0EhVRQdya6ex/7qYTLdp8x+TL8Vm9W77fvs1ud90Z0YG/6tmJlw1nkKVW1W2teANhAoDn3AR6diDvoOP/jSZSRCFasFBtg7/Nrt5ZMTQH9WTJ6qui6thiP2LxqvIeihImDZqUu34tADF78/E9668hoRMay8ZR1RkX/POQwOQTnDKlGOCKLjjT5jIzlEQEPGrkCpSqPM07mo0jkVJk9AJXUPSlEGTBiqOgszgwJGA9GvqDPJuRXDUip27vvHDOMzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUThYgBNgMVqrwHy2zNzQ/kpHOfwrUYzYDijUK3d1Pg=;
 b=bATbLodr5ytJatv3l+7dAyGZvn0IUYmk9LrMhVR33GV7Fqo7AnCe1jmJ2Q6bTNPlfFTPrN7k6HHLRysRZi7vRujbDsZAInZg218T+sY8rSjoMqEewFsiqfpGptWMrAlemzwE1eN5t//ut0IGOfPZoY7cPqHxRmy+PzswTtAWJamE/mehNBD6WwZ0/1lxpow7YdBUF34bfKwLBZ9YThjxIFky0ifjBIo/PGAG6jIxTY65DAlN20efdWVsnyOga/ZSNC2jXThDqOeABxl1cVUCQgM6QhMpwrA6xt51HVR3H47ksMiJKnNTX18Phwp4jdeFWoU0EyzajczEQlQ+IrbAbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 00:02:36 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.9009.017; Thu, 14 Aug 2025
 00:02:36 +0000
Message-ID: <86ca11a6-33f9-4351-ad67-bd6613439059@nvidia.com>
Date: Wed, 13 Aug 2025 17:02:33 -0700
User-Agent: Mozilla Thunderbird
From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: avoid probing non-display/compute PCI
 functions
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250813232859.224316-1-jhubbard@nvidia.com>
 <DC1PB630413R.33T95R794VWMC@kernel.org>
Content-Language: en-US
In-Reply-To: <DC1PB630413R.33T95R794VWMC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a139bc2-6f52-4580-1a86-08dddac5e076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDJzalhEQkhKRVFDaHgrOEJJb084Q3BaUW9uckp5N0Z3b0RnN0gzRlV1YXpk?=
 =?utf-8?B?ZU1lRkZnTEp4cElZUFNOaVprRE05YWRuakNOZDRZS0RTR2VsdTZ5cG8vVVc2?=
 =?utf-8?B?ZGtrM2x6TTFPdlVlaGJSSE9FbURSdm9BN2Q1VzZNeVlOQlRiN2FRK2ZOMXk0?=
 =?utf-8?B?VDRkSUxueVJwYlhFdDdRcUlDWGdPb21HbHdqc0hLd2dZTkxvN1ZucHBIaE11?=
 =?utf-8?B?UjA4Q1Flb0R2cEoySjI4bE5HRmdib25vOTJyZERRT1NWd3EvWFhlWmtZOGZq?=
 =?utf-8?B?MzVrK2xidjdFRS8xM1lNL3pUUFRmTVpDNWhQM1AwZGVhM1VjdTcxYmtyZEEy?=
 =?utf-8?B?Z00yRXlWc3NlK3l6cFl3YVlUVHp3WWkwMXJPcjd6dm9hYnBtb0p0Wk44Q1Bl?=
 =?utf-8?B?U1J1NmdkS1FXWTZLTHlUQnZ6WHkrTDJmR0krbDFaOWRhdzg1TTcxcVRLNytz?=
 =?utf-8?B?UDBic2VodDZEclZpWDV6OFNKc0R1RlVsbHFCYlRpMXhlNU5SVEZrVVFyQzd5?=
 =?utf-8?B?UUNqZGpnUWpXeHNTcDFzdWhBUytMMTh3TXVTNy84WU90QkJWMi9LdzVFb1Q5?=
 =?utf-8?B?N1g1M0l5UlhEbEluNkNwUmY2Qnk5d1pUYXhXT0VBdld1OWVqOXF6Y05GbG16?=
 =?utf-8?B?bVk3OTBxN2xtNzQvTVdrUitKL3VOcjlRS2FHSlBQTzFhb1AxT21RdEdhYyt1?=
 =?utf-8?B?TG5GeDhFMC9ZaXF1eXQ3TEpILzdYdmxSbHNVczNuZm0wYnRDOWYwOXhDdkVW?=
 =?utf-8?B?TzBHRUxnMjJDaG1IbG9zbFFHZ2l1VlJJNUMwMmU5NmRxYldvNlQ4UTZ0Tjky?=
 =?utf-8?B?RkFWV004MUlHUjQwMU1ocGRpNU9GaG8zNEpXY1YrS1hGTzdySlJVdVh0SnVK?=
 =?utf-8?B?UXFMVlNQdFY1d2pzR3R4Uks0cDNKb202NThjeEU3WHVsb202V2lXUENRcXl5?=
 =?utf-8?B?UHJ4Z09yQVBPNUI3a0UxNW0vZllKQ1ZBd05wNUYwakdDT0k4eHI0dGIwTTZH?=
 =?utf-8?B?VnpnMnVBNUs3WU04a29PMDlBK1VvdWhyamY5YUxTcUJkM1VaaFgvanZIU21E?=
 =?utf-8?B?cHhtK2VBSEVLK3lIaFFEMWZZZDA1cDhsSTVUNEUySEd2TkhWVkYyUGcvbnRv?=
 =?utf-8?B?MmozYmVqdU1FcDFkZzRXV3pEWmdtMlpsc2hUZFlSbDFKdVlUNjJINU5relVa?=
 =?utf-8?B?aFpBTWNXMXVMRW9xeDNTZ1VxbHFTa2RhNXh2eUhmZWIveDhqZ0V2dWF5Ukc3?=
 =?utf-8?B?UkRpOFlHZ1J4bnFCZjM2enpmdEJjMllyUUVSUkM1Uzhnd0UyUXRMOUc5emYx?=
 =?utf-8?B?b3RyTS90aWxuV2k1R3ptUkFPM0taQjNJckozTUd3Tm5wWVdpQW5RVmFVdS9Z?=
 =?utf-8?B?VlR3WFpqZDFQTVVzYTEyQUNRWkxFUmV5TU5uUEVCUVQwcktlNDZnNEZudkhn?=
 =?utf-8?B?T0FkOGdNeUJVQzdiZkNOM1I4TjBXZTZvV2lBQ1ovN0NzbmF4cXlkMGN2UDZ1?=
 =?utf-8?B?UXJQdEhCWFJwc0taQXc0WGZPYTBSV1ExcWJrWHZjOTlNeFB1S2JCRG5WbHg3?=
 =?utf-8?B?WjdDUkRxMW56b3VyV0x6RjBQMjEwS1hhSTFLckM1WnFCV3NDQ2hNeHFiZEwz?=
 =?utf-8?B?WUxuYWFkNEoyRHNwdUZZdDJsK3M5YnRSYmNjTzBPYXJHTXpzS3FSMkJRNmNQ?=
 =?utf-8?B?K0t4dmNHZ1REeW9UYmZWODA2bHhDLzZDeElzSk5ZYWU1Ry9CTTk0cnd4bEVW?=
 =?utf-8?B?TTI2NjY3Nmg2N0JreVEvc3VRaE9nbGFwMW1JNWNXcDBrTm5KNlk2YktBbDZG?=
 =?utf-8?B?T2xkVXZoMW9sRHpmR1pacVBOa0FUTzJWYkNjR1JSYmtXaEE0NWZWbWEyYVJh?=
 =?utf-8?B?VjNLcXhSak1SaENoM2pWOWJQdjVEREtONUNlVVBxbXp1MGpLb2R5dnE1OXVo?=
 =?utf-8?Q?+nlt1Wx22VM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEJ4eTA5TjFjL2JQZHhvUFpaU2RHd0JqdmEvSlRWMzNONHFxZllmOWtDOWZw?=
 =?utf-8?B?TWtBNmtCTmVPVEhrNE5JZzBrMlpQTFluakNpTS9vNVZuS3lhK2grWlpleGZG?=
 =?utf-8?B?RjQ4TFVIS3BIaEFvNzB4ZG5GcFZRbThOUUkwdnhFajVjbHNrbWNRbS9EUC9P?=
 =?utf-8?B?RmU0Z0lCOTV1ZXc0ck9reXRWUEFSZWlwbFNWM05hV05jU2NYYmx3M25sWVIx?=
 =?utf-8?B?NFpPaW1vVDFpeGRRaEFDTHZIWm9mNTVnQ1lldU1sRmkwVEFlSWdOY1hsbGRx?=
 =?utf-8?B?cmR0NnhuTzU1S3pvUExoZU5aa3ROellJWk5RZWJ6cW1ublM0MnBzS3NneDEz?=
 =?utf-8?B?dHd1elFsNVQzK1RHMmQyUmg0NEE5K3NUWFZ0MWFjakRHRWtVV25pakQyOUx0?=
 =?utf-8?B?YnI3UU1tYzljeGlEL0cyRWhBME91Tnh0U0N3THZRQnZPOW9JWkg1S0ZKRWU3?=
 =?utf-8?B?c3dhOVRYbThveXlzdUdaR3B5QkVSamVZWE5QN01KeGN1QnBFVkJRRU05S043?=
 =?utf-8?B?ZGpubHp5a2ZxNmZSZHBReTBUY3NkYVk2bmszdEQ1RFZHZVFJdVo1QXUvZVdp?=
 =?utf-8?B?TVM1R2c3ZGpOVk5sQTMyNFBPZUtFeCtyWUN0SzVjSWc3eldzWjBGMTYvUjUx?=
 =?utf-8?B?VWRFMWEwUnBGQVNnSitZcnlFZS9pRmRFM1ZRRWY3M2NOQmlqaEJvVTN3Vmpm?=
 =?utf-8?B?RTBNQUh0SkxQNGVBTmJ3OThaaHgwZjRRa21YQ1d3cnV5ZFEydW5SM2x2UmFv?=
 =?utf-8?B?c2hGVTV3Y09ocW8yVlBOOG43d2FvS1JEVjhjbU41cTFiOGhmS29jb3ZhUkJ4?=
 =?utf-8?B?MTNHdHV5ZWpFVFhkb3RpTGZDaVF4Nk1uLzBUcHNubjZGaHdiemsvWDMycmxC?=
 =?utf-8?B?OTBFQW1kcmk5UEVQZjlsaE55Tkk2aWNRaWZuWC9GSkNPUWlNbUhYc3pTZ1Fy?=
 =?utf-8?B?alI2cE00ZzVpaGt5QTkyc1ZXUnpvbG9XQkpCS0FzL3k2RG9iVThLR0wydjF6?=
 =?utf-8?B?aFBkbzgybEtEL09ndU8vc3NpSkhENHZFMGt5Z2R1MjlNY0dFS3pXOGRaS2J2?=
 =?utf-8?B?Z1lMTWUrSnNIQzBWZ05oc0xrM2l1dUgvVWtTbHlNYlE3cEdZZlJXZVM5dE5o?=
 =?utf-8?B?ZXE2MzM2ZFhNSkxIZWtWVVFxOXljZ2F0ZEY1Z0Z6MUdIRjgwb0R6NzgvdC9u?=
 =?utf-8?B?T3YrQUpRZlk4aXJ3VmpvaDVpejVkZDFoS1dYcWJncjYrVG93alhqZlYrT2Vx?=
 =?utf-8?B?cGIyb2MrenRRSklsRlcvZHRUNlg3NlNzUmZ0RFRvSDZJTzVYNzVwOTkyREY2?=
 =?utf-8?B?b1l2UXlQYkxaUTVXNXNxN25QRjlhNVVNdTY4WFViMS80SWxleXJwTGpPeG1p?=
 =?utf-8?B?TS93UTBIa21TYXo4TEFWZkVrR1N5TUFsdm1BVm51SEVHeVpzNWRYcjFFQk0x?=
 =?utf-8?B?TUcydWFFYjFLQ29XUmZVZlN4S1YrcU0rL3gzWFZ0QXF4UXRQeDdrWEgrS3RN?=
 =?utf-8?B?K2l0SXZUTjdiY2w2c3pUWHRTMVZSSnptNlQzTmtTWGVIMW91am8zcmZ6akZK?=
 =?utf-8?B?bVl5YWlhUWZncmJvcjVIM0VialFsNXBMam5IYk5nMHpvQ0lMWVlCZHB2V2dQ?=
 =?utf-8?B?bnZIT01ZRnJwUU5jVkZIMGRTN0VrMUZhT1BsUVZzYVdxMERQMWtHZlBiL2JR?=
 =?utf-8?B?MzVyQndrTC8yN3dJeEVST2NScGZRRWFwYk9CS2xzTVlDdVdKNitWaVlOdDd0?=
 =?utf-8?B?dC9QM0V0UkFpNm9MajZaTSs4M25GT1BJamJ5N3lzc0tTZ3k5aEpnaG9sQTBU?=
 =?utf-8?B?Qkk5UTRVRlBjdWlubHFyR2VSZGVqczB5MHNjdzdmS3hpUnpqMkIyV1RoSXR0?=
 =?utf-8?B?QTc2NkJjM1V0YjJ4R1IwSWJ1bHFuQWQ5Q1pZRFo5WHlHNUs1cnpKSjJiSDgw?=
 =?utf-8?B?dGFUSzhsSlM3UzV0Z0t3c2pCOGVtblpRemR0RjdHVkpaTUhjenA4c1pDekxs?=
 =?utf-8?B?bmFGY1VFTit5TmxOMDY4VzRHYUgvN0c5cmIzTkdGcGhLb0Q5M3RTdDZQck9K?=
 =?utf-8?B?TlVYb2hFYWx6Um5LNFQ3cFk3OXg2UkU3Zkg1a01yYUo0TzRZSGdTa3czRUhz?=
 =?utf-8?Q?Pv9sf+dzUYcwj5ATCbEltxizy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a139bc2-6f52-4580-1a86-08dddac5e076
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 00:02:36.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLog0VXJ2FlbT77g1GAV7pxI84cUqdpo7kQ0Ddv9EDgmpgZfrxhvt1vUHmHvX1ssHes+cLbiQHbuU4ixA+W4sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252

On 8/13/25 4:50 PM, Danilo Krummrich wrote:
> On Thu Aug 14, 2025 at 1:28 AM CEST, John Hubbard wrote:
>> NovaCore 0000:c1:00.0: GPU instance built
>> NovaCore 0000:c1:00.1: Probe Nova Core GPU driver.
>> NovaCore 0000:c1:00.1: enabling device (0000 -> 0002)
>> NovaCore 0000:c1:00.1: probe with driver NovaCore failed with error -22
>> ...
>> Bad IO access at port 0x0 ()
>> WARNING: CPU: 26 PID: 748 at lib/iomap.c:45 pci_iounmap+0x3f/0x50
>> ...
>> <kernel::devres::Devres<kernel::pci::Bar<16777216>>>::devres_callback+0x2c/0x70 [nova_core]
>> devres_release_all+0xa8/0xf0
>> really_probe+0x30f/0x420
>> __driver_probe_device+0x77/0xf0
>> driver_probe_device+0x22/0x1b0
>> __driver_attach+0x118/0x250
>> bus_for_each_dev+0x105/0x130
>> bus_add_driver+0x163/0x2a0
>> driver_register+0x5d/0xf0
>> init_module+0x6d/0x1000 [nova_core]
>> do_one_initcall+0xde/0x380
>> do_init_module+0x60/0x250
>>
>> ...and then:
>> BUG: kernel NULL pointer dereference, address: 0000000000000538
>> RIP: 0010:pci_release_region+0x10/0x60
>> ...
>> <kernel::devres::Devres<kernel::pci::Bar<16777216>>>::devres_callback+0x36/0x70 [nova_core]
>> devres_release_all+0xa8/0xf0
>> really_probe+0x30f/0x420
>> __driver_probe_device+0x77/0xf0
>> driver_probe_device+0x22/0x1b0
>> __driver_attach+0x118/0x250
>> bus_for_each_dev+0x105/0x130
>> bus_add_driver+0x163/0x2a0
>> driver_register+0x5d/0xf0
>> init_module+0x6d/0x1000 [nova_core]
>> do_one_initcall+0xde/0x380
>> do_init_module+0x60/0x250
> 
> This is caused by a bug in Devres, which I already fixed in [1].

Nice timing! btw, I scanned through rust-for-linux emails, and wasn't
immediately able to connect it ("fix leak...") with this crash.

You might want to add a little note to that commit description, to
mention that it also prevents a kernel crash in some cases? 

> 
> With the patch in [1] nova-core should gracefully fail probing for the
> non-supported device classes as expected.

Beautiful. 

> 
> However, I think we still want to filter by PCI class, so the patch is fine in
> general. :)
> 
> Few comments below.
> 
> [1] https://lore.kernel.org/lkml/20250812130928.11075-1-dakr@kernel.org/
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/driver.rs | 13 +++++++++++++
>>  rust/kernel/pci.rs              |  6 ++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
>> index 274989ea1fb4..4e0e6f5338e9 100644
>> --- a/drivers/gpu/nova-core/driver.rs
>> +++ b/drivers/gpu/nova-core/driver.rs
>> @@ -31,6 +31,19 @@ impl pci::Driver for NovaCore {
>>      fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
>>          dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
>>  
>> +        let class_code = pdev.class();
>> +
>> +        if class_code != bindings::PCI_CLASS_DISPLAY_VGA
>> +            && class_code != bindings::PCI_CLASS_DISPLAY_3D
> 
> I think it would be nice if we could provide a Rust enum for PCI classes, such
> that this could be pci::Class::DISPLAY_VGA instead.
> 
> Of course the same is true for PCI (sub)vendor, (sub)device IDs.
> 

OK, will do.

>> +        {
>> +            dev_dbg!(
>> +                pdev.as_ref(),
>> +                "Skipping non-display NVIDIA device with class 0x{:04x}\n",
>> +                class_code
>> +            );
>> +            return Err(kernel::error::code::ENODEV);
> 
> With the prelude included you should be able to use ENODEV directly.

Yes. I should have noticed that, sorry.

> 
>> +        }
>> +
>>          pdev.enable_device_mem()?;
>>          pdev.set_master();
>>  
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> 
> Please split the PCI part up into a separate patch.

OK, will do.

Thanks for the review!


thanks,
-- 
John Hubbard

> 
>> index 887ee611b553..b6416fe7bdfd 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -399,6 +399,12 @@ pub fn device_id(&self) -> u16 {
>>          unsafe { (*self.as_raw()).device }
>>      }
>>  
>> +    /// Returns the PCI class code (class and subclass).
>> +    pub fn class(&self) -> u32 {
>> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
>> +        unsafe { (*self.as_raw()).class >> 8 }
>> +    }
>> +
>>      /// Returns the size of the given PCI bar resource.
>>      pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
>>          if !Bar::index_is_valid(bar) {
>>
>> base-commit: dfc0f6373094dd88e1eaf76c44f2ff01b65db851
>> -- 
>> 2.50.1
> 



