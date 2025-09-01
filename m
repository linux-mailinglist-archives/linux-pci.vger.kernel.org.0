Return-Path: <linux-pci+bounces-35290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C44B3EE08
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 20:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5392C09ED
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35A32A836;
	Mon,  1 Sep 2025 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L2BJvXJg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDF324B33;
	Mon,  1 Sep 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752302; cv=fail; b=XNlOB+GoN/g4GMY+W60w1V8k6kpTLBRl2/irqFXpdSEv5eVSWPj4Ob2cfM2UsvvPZomaydM4ODo3xwDCnolLZAev6vTCxK4YNlwVqjBqxphFX1+T2AO+xsu/KD9UMQejLRv23Vna5aXLNRVeszK0pRc6AyW5kuqEoPN3pamKv1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752302; c=relaxed/simple;
	bh=SWhHEXxGIdLprxqePtMj5d43feCxhpF4SoxRif14lbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nMmTWZUPQ4I4W3glTrHABa/u5Sh6uiBtcROPS9TWUDoJ84ZD+uYUzuvfWwZ+7gECy8QywBQhe9wsNaSFT9M4Uva7saD30v0RS8/nijQ2Xs7YQzhJ34bORDRKlB6+oypA2OENoaeVmYk8ugWxSwIhMQACqhJlja+l71P46q8teWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L2BJvXJg; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+RL9BaDqqjp8vP9h6RpJlFy4b1F53HhJ4n0Q4GizL3ifH881nOv1KpUKgl6tgwaeotuSh75YdfwmLJeOHtllQQQJAX5Y8ebC2XrkAnSRuykCJVPhONPF6Rvo2doOOY4DyN7Lkzkf9X1C+s3Npt7uOcN3THL1S04gF1+4fFZsKo3UMHjwr4GSKayHh8jAEIkHEiV5EPolQApWZ0JoVa1dKM2S2NofrO7ml1+04EqPSsq0uVlEnseF4HBa2lGWShmzL1OlUKFXVKJ3AQqxw3NLHl+Qo0ILJAW1qqq0pU9wEk8hII2risXCWtpu1pcfbDVw0vwS++1TxulmBd7+wyNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA8K03HvpGM5Nxjlm4SmICOMAd6iAN9WR+HNhdh2LyU=;
 b=rvvOa+QwpJopJjQhvyJtUb35u/waqcxX73I5sy8h6btPnS05ycp/+AG/9FaoNiYpbEZaaoVe9EPOH6HMpO+CPFlHZoLLuiLbe+3lT5TqQB4bcf5b+c7m4vUedNERaf8iem0X22ZBTs+hK6KTEv4Crj+YQ2UgA9oQE/5Jwuj+b4KwZ4PQv7Q6cdP3uIzKSzRyvTQF/4dewazPOnRXP2NlAH59CzdgjxNJ04WA3+SUlvgplQzWEWtUCWyhEQqT3H40VKTpgoE2guXxtuFrBI/kGCA3kzX33iOtKLCJ6aGkycNvZEY46YTFNln5zjUFZsMT9EzhYK2RNsfG/z2X3c1Fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA8K03HvpGM5Nxjlm4SmICOMAd6iAN9WR+HNhdh2LyU=;
 b=L2BJvXJgB9qAUcRR9Z8UERlepT4QzHdWzNaobKM4Dbrk2cFltmTPNvN3QuZ224xr2BOQy16mbkMBCUJWKDGFKGeRGruHrEjpkM1wEWWHGBsyGRLuD6MtgsNfwxhmZBpLUQRcGHVLqWVipTT3ZRxAZrHny9/aSU9YcxrH7DFpatZtIvs7uLkkMSczh3eJO11BDuSq781qZJxjpbGvejtBLvvfY3OgojPksuUm9hAE6RC4gd11XI6dOlY1JLNbiBrDeP2xCeWifuI2ZCWMpkCK8w5c1x5wUD3k/c5Q/nNlx2ARjdw7iwiuTSrH1DNTg8ssq8vtjx0PEDqR/tyKPHfMKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 18:44:55 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 18:44:53 +0000
Message-ID: <c0cb3015-a01f-4148-9fca-1d42464376b5@nvidia.com>
Date: Mon, 1 Sep 2025 08:44:48 -1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/6] rust, nova-core: PCI Class, Vendor support
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
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
 <DCHNPZ8G5FP8.3VTQ0RQMQ6NT@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DCHNPZ8G5FP8.3VTQ0RQMQ6NT@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:303:83::26) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 31120a9d-e107-445d-7234-08dde987a3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnhVYXBtNWtKZUVIbzN1WXlVWGt3S3l5cGN6NlBiTTVwMlo1TUlUM2IyTkpz?=
 =?utf-8?B?WC80Skg2TXFXa1dBeXRYWnlTZy9nN2c1dWxuSng1cnB1TmxOSkhxS0lMY2dn?=
 =?utf-8?B?cUdtcmhvZzB2Ulhtek1ITVZ6ZU5zamhnRGhoSFhhbnJVWkhDTWlUL1NKQU1N?=
 =?utf-8?B?ZXVJbzhNVWFCU29YS2hqbjFIbElMOEk4Yjhmb3Zua3FRZVROa0pkbjdXN1Iz?=
 =?utf-8?B?RHowamxxQzMrcUlRcnN3M2Rub2RSMkpJYjZaZFpBZ01aNThaT3VDSVZIL3ov?=
 =?utf-8?B?dGpJNGZaM0cxaXoxb2lqdEFzdU5CWnh6dUYvRXJqVVhVaHpnTlZnTzk3UTNZ?=
 =?utf-8?B?UkN4eXg5SG1HaDUvNDIxZ2h0aTFNZWsyZDcwNU1jUnhlLzE5QWIvYWFlUVIz?=
 =?utf-8?B?UmhzNWFsRDVRZW1MV0pZNnB6RDBMaTR0ZFhlcXFYOEJKVENJVW1ISXIwcXhs?=
 =?utf-8?B?blpoZDVOY0FWVVY5d1hoRzVhMFU1Mkl0eWVlR28zVXpzRmorMldNdURYbnN0?=
 =?utf-8?B?aXBidFNBVkdac1FSejE0MXlsdXBsTXFDQkNHNkZaSExNNDVaWkJGWlJYYkNt?=
 =?utf-8?B?anVjb3lvbXJXR1JlMHc5TDZvcStQNktOU3lna3lCTGE0dERuaFBZUGlQd3BG?=
 =?utf-8?B?a3N1TlhQc0hQak9qaXhPYThMYStmb0YySWpMNGVpMUpYbzFlbUJZZno4YnNo?=
 =?utf-8?B?MUpJN2s4ekt4SEdrd3V5MVY3YWVySkhZZHFTU3NpbWZCU0pyK0FFbVJjUnda?=
 =?utf-8?B?NHVDZmNLcTBoZ0laTUpkaytxUDVuNUk1cC9NOE9jU2ExN09KVjJ2amlYWVRY?=
 =?utf-8?B?cWZhVjlrMm9tVWZMekIyQ2RZKzl5Q1prbkQzZExvS2VHUVhMUWc0bHFXM2x2?=
 =?utf-8?B?eFZ4QlhkSGxmNTdFYkFWTWpIcTJnMnFNYUkzWkVnQVpCRkFldWxWaXB0V0hm?=
 =?utf-8?B?TllzdmpOcUozMXlyMEtFeEppQzVyUkN4SUFXQkVGRDFucVJ6YmtyTmdubVRu?=
 =?utf-8?B?TmtZK1hUSmY1cFJpRnVWN1VFanJOS3ArRFNGY09TdDRETTMwT3pmTGt1NVE1?=
 =?utf-8?B?U2FHWmx2SERQT0YyeURwUjFpbXdjVjNmYXdtN2U2TEJDdTlKMHpXazR1eW4r?=
 =?utf-8?B?WThnL09pcGhWV09BM0F4WGs3L3JRcStrU0Y3QStPV3FweUJNclRJdDNQUlZ5?=
 =?utf-8?B?TXpJWFNXK1MxR0Y5S0Q5Wml0ZVIrLzQrVUMyTEdvb3lGQ3dyOEtEZ3Ivc3lT?=
 =?utf-8?B?ZkpIek52bkFRWjhEbDEyL2I1NE0xalVPZkFxbEdMY1FET2NWdDFGemNFSld5?=
 =?utf-8?B?aXZXK2d4aGdSWkVLVmlJeHBUYW8xUmVVK2Z6VGRmY3ZhbFJJcUNtRW1IUEJi?=
 =?utf-8?B?OWRCT1E5emdSYlRXamFUTlJIU0hwRHZyYmhSSDBFTnY1aDMvck05SFJxYTZr?=
 =?utf-8?B?UFpYRE5BNDlRM21WZnI5bVJ2Z0ZjREg3aUc5R2ZpOWxSWU9EMmxXbFFycSs0?=
 =?utf-8?B?NDg2ak5QSDhRWHR3NE1LTS9iT2srRkNlOTJNMU9VZDlDV0h1bnJHTkdHMzQ3?=
 =?utf-8?B?Ti9IQlZjSy9oR0o1U3F4ZHZVbU52LzBSYkpuRkR1Yi9SMWpwTzZNWDFrSUdW?=
 =?utf-8?B?Y095U0ZGUVRRMHhGZ25UMzQwdCtNYVVheTJmTWM1UkxYb1g2SDdUYmNGMkMr?=
 =?utf-8?B?YXZ4RXJHUFZEWUxDS0FsbklycytOTTZJVnp2OEtTL0xLUExqNmI5bUFzVkVo?=
 =?utf-8?B?Q0d5SXJCbkw1Z0JwODhjSXloYUpiL1ZrejFCQ0dtMWlqZlRiNFZQWWVSblMy?=
 =?utf-8?B?MFIvRXc4dGZJMGJzOVNkVFd4SXdIbmY3OFNPTVlpNVdnWGIyTVFkUnI1eEdl?=
 =?utf-8?B?VkhpcEpXWmJ5TnFFd3B3cTlaR2JOMjllNEREZ05jLytsSjdQM2F5b1IyUVpY?=
 =?utf-8?Q?z6Y4rQH8eT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlJySDFXcjM0TjU2UlNWUElDQWI5M0Uwdk9BenhZMnVXNFFKVEFsUVRDa3Vp?=
 =?utf-8?B?ZklhSUVOK215MXR0bVJuaFNNZkpXRnZuNXpVL0ZqTEFVWmdjNllHVVFVV1VI?=
 =?utf-8?B?ZTZiZVV1NDFoUXFNa3pMcFpWZkZoT1NyemdtQ01wTzd6V1pXY1U3THBhck9E?=
 =?utf-8?B?eEVsQWNPQjEyazN2WjkxMzVSSG9rWmlIZ1pqNDFRQm03WWovVDhkdVRnUm4x?=
 =?utf-8?B?OVN2TnNSUnJZV0FLa1Rya1pEdGNuVHdDbk1BK2U0bkdDY1hZOGV0WXlDaGpL?=
 =?utf-8?B?ZFN0T3FsZnlGMkpYemtJekswMmxXUHVNZTgwajhWMDZUazNneTVsWUZBUDZV?=
 =?utf-8?B?Z2ZYbGZCdWlrdnM0S1dUUHR5TTlPTGtIUHhYbW85V3RnN2RBOTd6K0gwdDZp?=
 =?utf-8?B?L2t2RWNlTkJaRnRkSUNNUWNYQ2s2dE5OcWpRaUdiTm1QdXVSK0I4Skc4QTFW?=
 =?utf-8?B?V1p1QTNucThLdHM3L045MjJ5bFNyeitDem5sdEkyKzNrdEFBL3BWRmxMZDhk?=
 =?utf-8?B?cjNmakFESWU2ZXh2TG5JZXpzaDhJOFZyVnI5Qi9lejlWUFhWMWkraWhNeHdU?=
 =?utf-8?B?UU5OU3I4K0JKWUNmY29rVEk0S3lQVzhzZzRYNjcrVXo1K2tFSm00ME9yL3JV?=
 =?utf-8?B?WjREQWFsMWlCdm5BT09FQ2wvSmxwTkZWZkNpU3hCL0h3OUtsNzdoUDFWRytR?=
 =?utf-8?B?U3BnUmp0bTQ5a09wZ2VBNXFEZktNSW9hY1dGbURNSFkvRTBlQnVaNVE1OUNZ?=
 =?utf-8?B?T2NVSWUzNk5YdjJ0aDcyR2phT0RUUzMvQStPb1NpREJHenc2YUcvY21NY3Nw?=
 =?utf-8?B?QmtNdGdnMzIzUTEwcTlGblpuciszcDlreWJ3b1NBUDkvN1hmNHpnbW9CMWtn?=
 =?utf-8?B?Wmh2R3kvN29ocVdSZkM1d04ycnZqN0d3bmpsQk5qVzU4d1NZLytDaHN6Rlox?=
 =?utf-8?B?Yk1PQjhzcUxhZVVZKzByYzNoOFFpVjZ2NnJMNC9MNWx2YjVnbEVzMWFuMGtO?=
 =?utf-8?B?VVdYQUFONFlydUZnb2VwZnplRTdiOU43eCs0ZFRZSUM4bjQrMllMdmFpK1JK?=
 =?utf-8?B?aXIrUTZ6cEtLbVQ5MXIvaFVwY1lRczY5U0VUUnFMeUlBaFFxcFZrUXRON2pq?=
 =?utf-8?B?aWN6dHpKUXhBSkUxQW95Y2lqNUNaVmgzVTZnTklyRnFKUE56MVVLYTY5L0xh?=
 =?utf-8?B?WVRyQThyekEwRVBVUFVKTjhmN3JKSzJSaGd5WDVBczhyZmVvbGVLRE9reVhs?=
 =?utf-8?B?WXFXYWV0aUcyL1QxODFqdGFtUGxjVHdBNlNLMW12aGZkaFBwTEpHNzNqV0pS?=
 =?utf-8?B?S0hLTVBxaE5kbFptQktQdkZ1Uml4eFM1YzFrTHEwdjJkenZqM0NZYk0vWHFs?=
 =?utf-8?B?Vk1sNlhwQXNMN2FsMGprTC9RYXE5ZFJDVVZ4M3RWcHFuUkxOVUg3TEZObFE0?=
 =?utf-8?B?Mk1HZk5hWlA0ZmhOVjlkbTdoOFF3WTNtL2FmZWNydEhCK0NaRkp5ZzNTU1h4?=
 =?utf-8?B?U1RMZmgzbVFwSWp5LzBYQTRYWUJpaUpHa3dSb0hyZUJac3NxaTI0OHlJOXlp?=
 =?utf-8?B?R1dXL2phQSt5ZGkrRnNabnJSWVJPZHpDMjNNVnB2VU9QKy9WazRZdkdQYVpK?=
 =?utf-8?B?Zk9DSUdxUU83MFlUd01oOVYzUVRld3VCT1MxaDB4Q1I1VFdsZy9CUGdVcVdh?=
 =?utf-8?B?TVdBOHJYNERaOGMrTXBVUVQxZ3lxK3l6QWpubFlGOFphTEp5cnFibmw0cU1x?=
 =?utf-8?B?Z3ovZHNIY3lXRHFLT2JMTHNaTS9zalh3QkM4SW44cE1vOTFVWXNrdlFWRlc1?=
 =?utf-8?B?SklkVERodzM4L2VXV0lrV0psK1NQcHFLbWRTUjQ3L2gyU1FqZ0tGN1ZzaXFU?=
 =?utf-8?B?bmRTMEV4VElyTUFNTDJBZU9oaFRiTFd5dWRtVkkxTzYrRW1DYVJrL0NSVjFX?=
 =?utf-8?B?U0VNSWNUL3lEOWNPOTBFSkZsSURiUlpQbzNDMWVZVStsNDlXSFJTOElpc1Zn?=
 =?utf-8?B?TmZ2a0tiSmo4bFB1ZTZNY3dHVFlGV0d4aXBNanYvcFF3dDZXTzVPWi82WEd4?=
 =?utf-8?B?OWd0VTF6UnBEYnJ4MUY0MzFCNGh2a1h3dHM4dXRHbnBkaGdWUWlWeFhaVzlj?=
 =?utf-8?B?aGRaMVFIUFVsTlNMRjdrR2xpYncraVpLdFdGTzFQQlNKQlNmYzc1N1NLWDFB?=
 =?utf-8?Q?cDResdf7ettiWmLC4XmNYtmpCsmWKppSFX6IVk4l8OxK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31120a9d-e107-445d-7234-08dde987a3fc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 18:44:53.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhPLrxcb9y/jEylFHrtfwnCcEdl0rE0S681SP/TOZrqbVzFb5LjM6t4oSYwtDBmmjjKpoZRg80HWWGu17DnzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

On 9/1/25 7:58 AM, Danilo Krummrich wrote:
> On Sat Aug 30, 2025 at 12:36 AM CEST, John Hubbard wrote:
>> Changes since v7:
>>
>> * Applied changes from Danilo's and Alex's and reviews (thanks!):
>>      * Removed a blank line, one each, from the Class and Vendor macros.
>>      * Moved example code location from struct Vendor, to vendor_id(),
>>        and introduced it in a later commit, in its final form.
>>      * Applied Alex's Reviewed-by tag to the series.
> 
> I think you forgot to align Debug and Display, i.e. Debug still prints decimal
> values.
> 
> Is this intentional? If not, no worries, I can fix it up on apply (which a few
> minor doc-comment nits):

Yes, I missed that one. Fixup on apply would be great, yes.


thanks,
John Hubbard

> 
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index f6ce8f8a2a4d..f534133aed3d 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -26,7 +26,7 @@
>   ///     Ok(())
>   /// }
>   /// ```
> -#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +#[derive(Clone, Copy, PartialEq, Eq)]
>   #[repr(transparent)]
>   pub struct Class(u32);
> 
> @@ -81,12 +81,18 @@ const fn to_24bit_class(val: u32) -> u32 {
>       }
>   }
> 
> -impl fmt::Display for Class {
> +impl fmt::Debug for Class {
>       fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>           write!(f, "0x{:06x}", self.0)
>       }
>   }
> 
> +impl fmt::Display for Class {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        <Self as fmt::Debug>::fmt(self, f)
> +    }
> +}
> +
>   impl ClassMask {
>       /// Get the raw mask value.
>       #[inline]


