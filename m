Return-Path: <linux-pci+bounces-35149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD6DB3C453
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 23:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97E1A2760C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 21:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6348E258CE2;
	Fri, 29 Aug 2025 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JENb4jVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DF1B87C0;
	Fri, 29 Aug 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504095; cv=fail; b=XcnoAAmUkoBNmPpwcHundjjsEH8I7Pu9ykbjoJoGIuiycQ7Bw7zDeu8yOxqoYB9Aq9BPcSGhzIYJ86sExNMbDZPf7MpkIH/78jxiELbE0Yg4HbjzAMEr5bvPS2pZ5hWL20f1x7UpjR+ZyHwld61DIbYKOg/Moj5RMCb3pqKTc5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504095; c=relaxed/simple;
	bh=4cmjqLpYOGyTTc3wY3EVBWP2hS9SbH4e1HrGilbRBms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mkrrgfctd3TTb3FFVxax5UihVmrLIufQgpzRmyOeIv9W69dW8T49aDjSBw4F5EVKV84M/RAmSo86D2kA/F/S21u91zM1JZvOMj4SkmBUzIegjpQXe/Mn0j0KiyNBXvFoWP3CKVQchsmkhHW60jvPh6KS+KL3txisbdvyJ6zk1H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JENb4jVC; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR69o9QWYYLHy9RR2Dbs8gtgBVs0fmeV4uxtw0AUtejY2nqjzLBwtKXwCn5cu2gg3q2Y1oRFmQ0K7IkJDUV3bx5SIb9d3Y9N/sEqQDLPDf9UgHPIJsh0qV6sxkb/DVFTrKZ0o6J1MN56uCSTtNOIxHsgqVtOL39Q759hCVG3B0XNkHdHSoyqmSU2BzkggTkdPgPrgTafsGypnbYDXvxbX7vceSPWFlKN6MBPPpxnO6EdKQHk70cReum6GjEcp8ASDQOKY+EaElM0TLqehxKE0kmXf771RRCXOpxb+0EUW3Dj1Zxebb+ZxWZlWN4DLMP2lXcd1XBcse4Zg5WTWVjnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiJSOrSyqgT4Ne96Qh0+IzCyyKndXEMfbByse0xZIg8=;
 b=eNxCy7c2SGqbHQ6pbX/z3Hlcu3Uil/OBMuhJoNHi3sexgTDvc2Z6A5x+aLqOCOktm+X46kt8RsO4qwrt3r0XPia/71+6ylfsSuZepsvKDrnwX0JaQesMx1mLxoQIj3LlVRiUtYP+/fLbwqZwyO6gZN5UpKCs5mEkwjYHIN2Ug64YS/lc30+clvXi1lTMP3hCXkBvdwEEW3bpPpRO6aoAyrjvDHMg5F1EE4MBS1BkaX2sioTjab9kaEsA3aPVFstc99xH9V8v1qXVg8SeSuxiFBEFaWTNpZIdNWEciZYa/3g/KTBRvtPJOVhwG6zXXefncZuH9KCH05dgCsJWXMJM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiJSOrSyqgT4Ne96Qh0+IzCyyKndXEMfbByse0xZIg8=;
 b=JENb4jVCYI9d6yA5sMDqBYizfhbPPWFHRK5ySAc9fHYljsofHEIMR6cSCSNYBqr+NK5lZomFEK7gZPjxyk5JS+75wh+nNBh3mzOQ7FBdK9sgeOdzMZMQFsEcvsEUcpNOaczC1ChsMcU2R3OudY3ZuHDHmtOrgwkE/K8SOqJSXcMdyaRl54zPfNdkdQL29c9+SmGleh8rTD+IxWli7wJ+qWx5YHJgts0BCtpNAbbxVwZ46W5V4fu5gm/Ah1HzDmgEsXCFhmlea/LGabY9dWp8CupJQTRYwfoEhtxbK6GJXAZ/EaMNYx1AElXmDWE61+ybcOEE5IXobrBG9Gl6wHaOkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 29 Aug
 2025 21:48:06 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 21:48:06 +0000
Message-ID: <0192e318-f89e-4152-ad79-d93d7a8eafc0@nvidia.com>
Date: Fri, 29 Aug 2025 14:48:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] rust: pci: provide access to PCI Vendor values
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>
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
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
 <20250826231224.1241349-3-jhubbard@nvidia.com>
 <DCE3ENGCR4T7.25B37IKXHCC8O@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DCE3ENGCR4T7.25B37IKXHCC8O@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: fc11fbda-cb4e-4876-d228-08dde745bc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHViYkphTTE4Z3h6QlhVRjdNS1dpTk9QTFh5bmR0MzJKOGFsT2J2QkdhRXJO?=
 =?utf-8?B?bnQyVzJxM20wU0NxOG9QRjhTUnhHRGdGdFlubVVLZEgzQjFOQ3lVNjdFalRp?=
 =?utf-8?B?SmFXc25vRnc2YzNrQTNIY3diYzZXcWdhajNIc0hqMVRSUFdLeUdnR0I0Qjhr?=
 =?utf-8?B?MEJHR3VSbks5eS9XR0ZlTmtGaktNZk5FMlFEMHBHcVFNN28rRVFKQVRvMzRZ?=
 =?utf-8?B?OHlRNlVJVFNicEM1ai9rQ1pRZzZjYmpyQTVCV3ozSmtCcXhwTEhBZGkrOEV1?=
 =?utf-8?B?bm1Vd3RvdVdqQlRDWkFrZGlaU2VJeWc5SUszLzVUdlNhMGk0ZW5vUTVWNkdL?=
 =?utf-8?B?WmFVWUZNb01Ta3VLa1NNNkM0OXprQ0FNNzhvRERCY0ZvaWlQcVFacTZwUzh2?=
 =?utf-8?B?QW5ESHU5cHhFdXJkQjNwQUZlRHBVaUJjUmRoejZBYmtHdi9KTTJ3UFhKTm1C?=
 =?utf-8?B?cUVBSFdjdTdIYVVaUjlwS21XMHBDLzQycXNubkZQRmNDaVN5eTI0Rkk5TDJj?=
 =?utf-8?B?a3V3Q213Yk1YK3hObVJrRm4vc2RJVzl4bnRvSlViR1piMmJyM2lWYUl6QlJ3?=
 =?utf-8?B?alJldTY4emNnSnZZRUdUZXRVTVJVTG9CczUwSGp6QkhuWTV4NW9zNjZMTUlj?=
 =?utf-8?B?M0dqNEQ2UFVRdXQwT2hlRUp0SDVDTjNBcTd2QUFQMngyNXJUU2dIeUsyZ0VT?=
 =?utf-8?B?clc5MzdsRHZYWjNpRWZJY0cwaHlMelY1eEI3MDZ3d2RWck5xeC9kdmU5NkZK?=
 =?utf-8?B?RUFhWFBlSFg4a0VrQWpaYklhK0doTFJJejRvWlYwamY2bzlhM2lFcjUxNnVJ?=
 =?utf-8?B?ZDVDcEppcjk5STF3OVpGbGlFM0tjT0I4bjF0TGw3Ry81OTErTmh6d3JrMHhW?=
 =?utf-8?B?bkszU0pvWVdRUmozdm9sekMzcEQzdkVJMkVHZ0ZjeHI4MUNNY3c3aVBvZVhM?=
 =?utf-8?B?VDZiNGoza2lsWkpYaEYzaDNZUVJrcjFTd2QvazBOWlZONnQzbXVhZjdEOTZa?=
 =?utf-8?B?SlFHNXgzaEZIaUNpTE5QQlpBNzV2K0lxakdTQzd0eCs3NlgzNDR5VHkwMURS?=
 =?utf-8?B?aGlmbjJJdm05NnFNV0FWeTExS3FFb25DajMzdGpCUHNGWjhuWm9FSGNyZ0VU?=
 =?utf-8?B?Qys1V21pRHpmWWE5SlVnZ0lLN1BRZVgzdlBwRWxOaEpLcjJqQ3RYQTAyelBp?=
 =?utf-8?B?MHd2VUUvZkpDa2VVZzUyUE51UTM2azNrUDlqUWxnUUFTU3VQdmN2NFUyaWI5?=
 =?utf-8?B?NVArN3pEZFZERzRqY281WkpWa2hwSUR6bXRqZUF3aWthMG9XeGhqMmlXVFpO?=
 =?utf-8?B?Q3FlU28vWGdLOEZ2eDJQbENJVmNkYThyVXFSQmx3cWI1TW8rSy92SmFrZW4r?=
 =?utf-8?B?elV6Q1NNWUo3ODBCYXpiUmwvNUt4bW9ROTlvS0t0V2U4ZmFoM0hXdnpMalZo?=
 =?utf-8?B?NTdIYnJUaTRrbnlKR2tvY2hBa0t4c1RaNVFkYmtvMVp6d0g0clBoeXN4U05x?=
 =?utf-8?B?cHJmb3hIUWEyZU53RCtRQTRkWFoyOWJmSnlNY1U4eU4rWTlDeEd4SmVVMEZW?=
 =?utf-8?B?ZUd3bmR0eWZ0aW5venY5cXRObmxkUEt3ZHp3SzI0cUEvK1NPaGJaU0loWFZ6?=
 =?utf-8?B?ZmhtUXQ3SnVQZEM2V05GYkIvK0ppT3dIejlaaU15UFBNemRNM2JYNWN0ZEV5?=
 =?utf-8?B?TXZOeTJrZXFqVlNSbW95b0NyL2llbGVIQlRVZkh2YXJsU0NUS2FlakpURE4y?=
 =?utf-8?B?Vnc3c3VEUmtmZmo3TXUvYmFxL2NUSE1ZRm12TGhobE51T0x1dzArakJiT1Bn?=
 =?utf-8?B?Y05DSi9pcU1BYmQvZkRCZUc1T1BaUjBIalJINjFONjkwVWFTMnE2UHpYKzk5?=
 =?utf-8?B?WHUxNGFERzFpRkozbC85ZjBIL1JhZFh6bXdGcTlwZFdiRzZhZ3N1ckozQTNz?=
 =?utf-8?Q?LwZYzV/Uayg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHNDYkVKVGljRm5WU09qUUFKUkt3aUxzRmdLL3Z5aE9YYVVBOHhWdnpycjgx?=
 =?utf-8?B?bFBreWZwcGk3c3kyYWpXUmpxay9pNURxajFUNzRPcGhhbXlOWjcvL2ZncllC?=
 =?utf-8?B?RWFkNzZrbllMTG81ZENOa0JlRmw5NDM3QkdDTm5HTGwzWldMZ05STitoOCt2?=
 =?utf-8?B?cVRoL0NCcWltdUd5bXpxL2lEU09DQ0RPTFZFQlpjSkE3TnNYN0pEaDdrUktv?=
 =?utf-8?B?dlRJSTNIT2dyMjBYb3VuaW5FYkZLMnRmalVwampXb0NrbXArbWkwcWJ5VHE0?=
 =?utf-8?B?ZGhhNGNxb3VtQzlwcE1raWN3Q0QwZHFLU0RDTnJXMVhDajJHUG4vTU1oOEJl?=
 =?utf-8?B?T0lEZFdmUEVvTlZ0ekhHQ2dkei9HQjFBMEF0VDdna3cxbkRXVWVBSTRQS1Er?=
 =?utf-8?B?ZWxoN2FUTGFROXVXKzlqU2pkd1VFVnhvaFdkM1FKVXFDVGFKVFQzcDdla1VE?=
 =?utf-8?B?WmFoTEcxNzk5ZEE5VHZ2RXNZdGZqTGgzblpQaXgwcHZNV25hUXhrM3NyS1dh?=
 =?utf-8?B?OFV0eWJESC9rYXAyOVp0d3lkSjJZdlhtd3lsaTJ6Q0tlU1krQlg0bUhtM1lU?=
 =?utf-8?B?UitqVm8vTmozN3NMWTMyRTk5QTM3WTVBbjZ6RnJqWGt5Ynlzd1B0NFMvL0FM?=
 =?utf-8?B?MEJFb1hHeFJ0RlBlMDNXMytxU0pnczdPbXdPenFUbzJJcHlPbjAzREM0MHFH?=
 =?utf-8?B?UzJsSmMyRFdvU3lPN29kdnZTQXlDVktWelhWeGkyWWFSTzdVK3pZbEZxVWpv?=
 =?utf-8?B?Qkt0ZFdPKzkyTFU2MXBzeTZDK2srazRQTzhlbDlkYXZTZ09nbEFmZ05wcG90?=
 =?utf-8?B?LzFlWFpyNENlSnlNdHZzTFZWVnh3WTd0aEZ4bXdlQ0c5elBmZkJyUktGUHdI?=
 =?utf-8?B?b2w5Q0kySDVjRVJjSG91WDZmVlBKS0dWMzFtbGlYWk12RVBHOFFkeEtMcGtK?=
 =?utf-8?B?a1RxYlBBLzA2Nm0weUN6OVRvVDFwekhqcGJ6ZFdxYS9VZDVJRFZVMW83VUV4?=
 =?utf-8?B?bEVhTUlGR1BuZ2ZXVFVHNGV4bzA0a0h1M0IxYThBZ3R0RGVWQ25jclBVN2Vn?=
 =?utf-8?B?UllrVVVwMEJwdUg0UlBBSnM0Rmd1bzNZR3c1Sm1CcjZrZnFoT3NScDN2VTBy?=
 =?utf-8?B?d3pYVUcyUHphakw1TlBKWThuOU9Mb3ptVVZMcGxsYVcrU0IwZE85SlR4WWFX?=
 =?utf-8?B?dWgxTnVCTDUwc3EzWGh3UVBoK2FQVEZoTFZKb3JWZDB2T0hMOEE0N0Q2YU93?=
 =?utf-8?B?QUZwRkFWWGxsT1grKzdsWTRmNkZHYzZaWmJhdjF2TDBJUGlSdXIzU0VFendL?=
 =?utf-8?B?ZGxoaCsxUHVqMGJnYkRaUjNnZmRBb20yY2tua2QvdTE5WE1vNFBYSksyaHJk?=
 =?utf-8?B?eTVYU2R1ejE4cDJZYU9CT2c2YW5ydjNvQ2tZeWRJbS83dzQvWUZZQUFFNDRI?=
 =?utf-8?B?ZXBNNWxYRWMwWkNYd0hSM1lwbWM4ckcyMDZndWZrYytuRS93ejNmNjE1cHNY?=
 =?utf-8?B?UHpvamVSU3Y2WTBkdEZPMmlaZUt4T20zT2pVamI4aVJqdUVDRy9Wb2oySm9j?=
 =?utf-8?B?UnMySUtETW0rTnZseUhLTGZNM1BnaFRISklkNVFVY3M1VklMSHpza2Q0V290?=
 =?utf-8?B?YUQ0WXRQbDI3cEZzV2cvTm1aZG54Wmt2SC9XL0M1ZkplbGJYRTdNNUpzYWts?=
 =?utf-8?B?U2tHZ2o0WmJoaVZGY05ObVRocloyZFB1eDcxWmJrazNRNWttNmlKYzA4K0dG?=
 =?utf-8?B?L09YWmhBYWUxYW1XV1JWZmtwUDZCaU8yVHpzR3MrTmxWTzZ1eGZySTRYQVdR?=
 =?utf-8?B?RlBGZVY2Z1RqZy94eVNQWUk2SlZQeGFsTlJGREpPVmNjV3J2ZjR3azZEN0dp?=
 =?utf-8?B?ZGRTdjBkWENnUUorYVlMNDFXbFlkK1hsNXd5U1VWVnYzbmJwNXVTbzdaMnVu?=
 =?utf-8?B?RzlyWDU1U0V5NEk2cTFwTEJjcm9qd1h6eSsrajBCTVZaV3h5ajRvMWxiYkRq?=
 =?utf-8?B?RUZmVEJCVHRNZ24rTGcvTERYWWF2UTZRem1JVExKZUhYT2JMV05RWUNwaUF2?=
 =?utf-8?B?NUtram1qa016bTZDN3RoUytSWXJZb0JQQ1o5eis1S0h0TmxyVFdiWGN1bXBP?=
 =?utf-8?Q?c1ba4dKsDpMhUvEqwECYpU8Km?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc11fbda-cb4e-4876-d228-08dde745bc9d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:48:06.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3fCR0kXu4j9vEfk1tccB67RuQp7mDFWBin7uLA0MZMGq6Tcfa+OTImMrYnsBNz/dECVGa7Abe5IFt7nXmhrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712

On 8/28/25 6:25 AM, Alexandre Courbot wrote:
> On Wed Aug 27, 2025 at 8:12 AM JST, John Hubbard wrote:
...
>> +macro_rules! define_all_pci_vendors {
>> +    (
>> +        $($variant:ident = $binding:expr,)+
>> +    ) => {
>> +
>> +        impl Vendor {
> 
> Why the blank line here? (same for the `define_all_pci_classes` in the
> previous patch).

Removed in both places, thanks!

...
>> +impl fmt::Display for Vendor {
>> +    #[inline]
>> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>> +        write!(f, "0x{:04x}", self.0)
>> +    }
>> +}
> 
> Possibly an exercice for a future patch, but do we want to display the
> vendor name if it is defined, rather than its hex code (which is more
> the job of `Debug`)? We could leverage the macro above to do that. The
> same should be doable for the PCI classes.
> 
> I suspect strings for all the names already exist on the C side, in
> which case we would want to reuse them instead of defining new ones.

A reasonable suspicion, but actually, they do not yet exist. So I think
we could just add them on the Rust side.

> 
> Note that I don't think this needs to be done for this series - it's
> just a thought as I was looking at this `Display` implementation that
> looks more like a `Debug` one.

Good points. Yes, I can do a follow-up patch.

thanks,
-- 
John Hubbard


