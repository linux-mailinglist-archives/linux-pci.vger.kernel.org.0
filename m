Return-Path: <linux-pci+bounces-35147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6167FB3C447
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 23:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1AD567597
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61CD22B594;
	Fri, 29 Aug 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHP1Bdm9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE124207A;
	Fri, 29 Aug 2025 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756503551; cv=fail; b=NXv1Gk6kpVxJX8jn4UgXnsXC68976RbEeeJLmohQlsbjQ+0bqmAMHz/ktxmR/kFVsRRLyB22+EwpBQWRMvuy2NEKGABMwZhZN6CEyn+sbhQ6zvrAKKJErBmeVYWGXu3Xzu09H/sZZ82uKnYFE6HA89uD0HOEN2iPmUuVNsVpRlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756503551; c=relaxed/simple;
	bh=evqNDuWeVNeFDKp2xue8xst8vZ+MHKtYrokeoJNx1Og=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b0P7rTrQQInQylDdY4yhMExHsvp4JAGA4TCoCfoDDEQDuIT4HPLnbShKhIG9O0vUFGZp6MkJNvyM2xIeT2My5ullOO7VT48ThJs3q4QxF/4gkrYuDG5vGWibObRFMIX5t9QNcQqp9hJfVEZn4WmFZQuvR6YfAuDwYeL2DKhu2Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHP1Bdm9; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhHynK7HKoBW6yf7HKqekdjxf3eR0djExygMVPgmZtutC8hVKr9DGejJ17fncHw4GLI859gqrXlC3cSgO6We1cw02LB15lrZcJCaLCXKY0AarVQLaICh8sqBudYon9utboGccM2hC+wM1WGGUWRE1G0cL4SaWc4wMbqkyPsBBhKafwT/jtfmuGGkPS16rZaVLwsXHoKELY52rWkK5QcJWyCiy9VYW4Pj2YHUHNjUoHU/RVCequY0ToItAa6YFqINZiYK1EH88lQu6O50P9uwF2+FgofQox2PpPDcpotvxkCg2iArH16UMzN64KUjG81fUzClj5OS/Tj+03eZcmgUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CpceUK/MxzYs81cbHWbYdS+aJYm9Evu7OkeLVv4txU=;
 b=JApZ0MX4f/6krac9qGobcx1BrbK4WMCSeoz3v+PcQHtguMhN+VY8TG5hc9KDbw3HYi9OzMGSdPFPAH/SgurrPmRiVHbSaRyopUYZzT7Pd3dxHOibYRYK70wcaM14kims4BLyCWQ1iyFxFjOHD1hTIQhBZPENPfbw7TWo/AbnMrQzmA2sev6VHLl3lNLxx4D2/SaxdXxI1Kv99nrK0u9qmlpIW8DI9B1zz7UgSnqEPM3pWBYGsWEqptLmsDrYbkpOnGvWJEV9RsUOObtxFOkZLkGr7kvVplecCCnIsot/1EPQjCstdz1q9kRxd16/B/cMCaMomvsOB/2Cr3uDlGJKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CpceUK/MxzYs81cbHWbYdS+aJYm9Evu7OkeLVv4txU=;
 b=FHP1Bdm9k+2AKWFoLTn++NMqmQSefudCjGoOytURqgk3hIuHNazBX7PkPPYUJuisqulGZzVmMaY+AAMQ6CNDpNf+m/7djaUBc0WyDy854I6g/l8ifVwj4Da899tGKeY6VyCXN1gHg21xfk0b9jE4zP0f2rHBdHB3kPo6jEMS5oOl3KgU0QK70AUNDpQtbJJkl49iYDIbydtB7wsQ0l6w3QaMszgrbbTkq5GLBqe1/1VwzvLrYvw7VjXLj2jT3zh4IrLFtELbmdPyX9nOZ5MTvZV8U7mLWQFObZsBf0K0k2TZkDsCj5D0n7kQ7eS0HWE0yn29Sv/71eZi4JJvePfH4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 29 Aug
 2025 21:39:03 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 21:39:03 +0000
Message-ID: <cd20f283-bd92-47c9-a336-fe9ff46d82ed@nvidia.com>
Date: Fri, 29 Aug 2025 14:38:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] rust: pci: use pci::Vendor instead of
 bindings::PCI_VENDOR_ID_*
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
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
 <20250826231224.1241349-6-jhubbard@nvidia.com>
 <DCE3EV79EX7N.DCIT9JWFGXGG@nvidia.com>
 <4b525afa-1031-4f99-a1ab-e89af77616eb@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <4b525afa-1031-4f99-a1ab-e89af77616eb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 076a4659-5486-4f5a-06af-08dde7447907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnIwRXoweGhaUnVBcGpTejhjbzFNd01rblg1WDNzUkMySHdpcFZPdzhwTXlx?=
 =?utf-8?B?alY3YlVmeCtvaG5CL29vNERFME9lbmR4UUxUNDRTRGVodHVZV3pvaXhKZXVl?=
 =?utf-8?B?RHA3eEJ2dm5DbGppZ1djbG1kMkJyY05wcFNaYk1FUXJ1anNBbVVFdkpneDV1?=
 =?utf-8?B?MDlUeEIwcWVobzJyOHg1MlVaaVgyYlN2ODhpcjRpaDlrRUpRTmx0bkFyZFlC?=
 =?utf-8?B?NUZ4c1B2R01kVnpQNVVpaUJ2K3BlZXQyNU9CeUJ4UnhpS0lqOFR4b0wzNEUy?=
 =?utf-8?B?WUVMM0o1YlhPejF6L3E2b1BES3E4QkhGejdDUk9obHFqWC85TU11ell0N0FO?=
 =?utf-8?B?YkMvZjMyZTJUb0hHQWpXaDJYcDd1TnUzTENUNzl2clQ1VnFBOFFQbjRNNlpw?=
 =?utf-8?B?SlVWN1poL0M4a2ZucnkyNkM1dHlMaGFsa01JWFdHQUR6TS9YTmtiQm5KdGUx?=
 =?utf-8?B?UFl1czNrR0Q0NVZuOXBFdlVOMGdBTFdFR29melhwZklGaEp2Y3BKSzBLaEdX?=
 =?utf-8?B?cmJnRVE0N2xuaHQ1S2xMcS9JVVh6NG00ZVZtYUxHZTgwT1RoSTcrNGFiUXlG?=
 =?utf-8?B?M0ZoNUtxeHF2UEJxRm1ZUEhtMXNQeEJJUFQ3b3pqdTB4cjg5VGROWU5CaUpM?=
 =?utf-8?B?TjJxckhmU1l3UzlHRDd5TTZYREpqMEZIQmlDWUdYU2VXbXc5cXBQMWdDakVG?=
 =?utf-8?B?b0l4UnRyYlh1SzdacnFzVFowU21RRm1vbCtVek9FNmxYb1RNRWRFdFc5Q3pO?=
 =?utf-8?B?OG1UY1pCeHA0U0RPeVlaQitsUDhIeU90ZW5pc2pIUTBib3VkUjNZZVBHSjMv?=
 =?utf-8?B?SGxuMGxiNnpyd0V3czBBRElMTVZsblh5T1BpVGx4SjVreXE0bnowMlhOeVlO?=
 =?utf-8?B?SEtPRnNzOHJocExvK2Rxd2JFTnd2UXdKTnBLUkxtR0E4UGhyTkZlMUhJZ0xL?=
 =?utf-8?B?YlUxOTNxc0MxVFZnNjBEK1F5N0pnQmcycE1vZkVoY0QvekhtV3JRcFZ2YW90?=
 =?utf-8?B?b0JTRFZSVXY3MXdzRnBwTytDaklOMDFobk8yOU1vL0pFNlFySmptK3VCODdO?=
 =?utf-8?B?VE4rTzNlQ0ZUOXkxL3oyWlYyd0ptRFo5NDFxWkpPaVltVGx0eVZubzFwempN?=
 =?utf-8?B?d2xyR0lLMzUyVHJTS3BIQmJFMWRRMGVRTTg4ZjUvcU9hMGtsRWF5bzZTQzRP?=
 =?utf-8?B?YjJkbGJkK1dSanpZenFrZEhqb2IrMW1OdXlRVDVxUDhnMVdPbXZybjZaRGU3?=
 =?utf-8?B?OE5TWjZwYXlmandYR2xDVW5NUWxyZERieTZMTUJDOFdQL0xkR2hqNHR0UVAy?=
 =?utf-8?B?c01sZjRSQWF2eWpLUXB6Z3JwWmFkTkh1QmNjR1VOdlVZdmY2VS9tNmYvWnNy?=
 =?utf-8?B?VkI4Ums4cE5mNHIxaldiQ1BSNm1xamRUUnd4aWJnblV1eFI5QUs0TTlrK3Ax?=
 =?utf-8?B?NjRQNEdsNHlzVmIyeVkrZHRITjVFNUQxMFRhOHZiTHZjSFpydlFNbnpPNEpx?=
 =?utf-8?B?VFMrVjJ4UnU1QkFZRXF3STBxdzFKR1VnNElNdmlvbGV1ZktPb0FuQlo1aTZz?=
 =?utf-8?B?bHhPcElDc1luOWp2WWVwZ1ZoL3dmdlMrT1dMVkpzTGs2RjhKM0RITzBRZzhi?=
 =?utf-8?B?bDlIbElRSFNXV0svTThkRGVSYnIweXZnTlFGWCt1YVlzUjRpdUVaUENCSTRC?=
 =?utf-8?B?N2p1ZEkza2xQSzltTWlyd05DSnViNGJWUHhFUUthcTRtbmNwZHRzSldiMWlz?=
 =?utf-8?B?eVpyUk5VN0E3SVJ6VXpJMXg3YzJTMGp0UTVZdkhYcEJQUGZSYVM1SHNjdmFv?=
 =?utf-8?B?b2ljSms2UUpJdVJhNEhXNWFlTzZlK3FiTjNGK0F1eUpGR09uOVloRnRFTWkz?=
 =?utf-8?B?MWFxbjlkaHFJS2p5aVN1ZHJlUUNzSUtudFVSN2E4NnNGM1NKQ2xKSHorUHVr?=
 =?utf-8?Q?iGECed+6BGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVTcUd4Qyt2Yko4dEh6N1dOSXFRVlloZFMzWUY0SkR2TmJPdHFLNWc1Nk5k?=
 =?utf-8?B?SU8wM0lKT2hzU01PdmZwMUVDMFg1T2hVeExsOW9uaGQ2Mnp0eGdGSlFCKzV5?=
 =?utf-8?B?VTJ4MFFFM2xITXVHK2lFV3Z1ZDJXNVlaRjVZWVJUQTF3bnUwdis5dFB6bE11?=
 =?utf-8?B?M1ZWaTR2Vi9QbVovMmNXN2VQTlN3NTUzWWV6cFZFNEhnL3Nob0J0a0txSExl?=
 =?utf-8?B?eDZLU0NVdHFjUDZpYjZMeFBuVStZNDJ0ZVkweGJwOVNGNXh4UHh0SXJuSzlv?=
 =?utf-8?B?M3FzYUlIZEozcDI2em5KYzFQYXVLZldRRTVqblk4Y0lVaUFMK0ZDYmxaZmk1?=
 =?utf-8?B?TnhQVS9MWkxTQ1Jvbkd2cVVWWGw2eVRaMU5NcGlpdDM3TGRKUFMrRmZwTUVV?=
 =?utf-8?B?MFpLU0twa0dNenlqRkZjSXd4eG9qd2hDM3pQTCtaMG1HQ2hKbmpOUjBTQVB4?=
 =?utf-8?B?K0xWNU5zM29SNlI0LzJjQzJyYURMVVlIR3RUMytnRVNaaXZ0Q2Q5dlpGcUVL?=
 =?utf-8?B?aXlETStzMUJpRGRRMGpFZGVpbDlPRWMzcWRUQXJMRitQcm4yTXZTVDIrZ0RJ?=
 =?utf-8?B?cG1uTlJTRmRaZGNsSGRyQ1hsYlo3cytKazBvMzAwT1p2SDhPY3laWkxKaytV?=
 =?utf-8?B?ZFppZjZoTE1QbSs2MHdTQWpTNkxDcUxOQlBKV0hTNlo5Q3NRUEVxTGZhNHZK?=
 =?utf-8?B?Wjk5ajBHMXUyUnRacjJrMklVODNGWnh1a2VSNWthbkRQSGt5WUZVUnM2N1Mw?=
 =?utf-8?B?dXRuaWVOYXN1QnpTTmZaKzcvczdmK1BpOW4vK09aTHlSN0ZrakhNbDlOMGZm?=
 =?utf-8?B?TVFURnlBN0lOUmU2b2JkdGhENDBDM1hOSHJoekk0Z3I4eWdBZ2xxVTNVNnYy?=
 =?utf-8?B?ZnNzYXgxa0lvQUZMam81WWJWOTVVcU5CWDJ4NUd2Z3VpaXczTlZtZlk5RDhm?=
 =?utf-8?B?eWZhbFh2RG1TTkVMejZvVVpBUWVLT1lydjFvTU5yWiszVVM0K0ROdnZJUWta?=
 =?utf-8?B?WFRqb3lFWUp2bTR3WWVrV3dFTEtyK2FtdWxkbVFLbmpzS0xMbUlvdmNQNHFJ?=
 =?utf-8?B?U1JjdmtySmg5YXBOUkR4am9tUU5veDMrZWZ1ckwvdG90SDI1Z0tqbXpaZVJ4?=
 =?utf-8?B?UjRKZkU2bERyZWt0S3RrMS9WYXQ2bVUxUDc5Wkc2UVNaN2hhd211N1cxZGpB?=
 =?utf-8?B?K0NZdDlKQXFhWnJJK2xYbCt0SHhsNHZLTCtZM3JEc0ZyYXJuSDRlWHhOQU91?=
 =?utf-8?B?SkZsejVlTElJZzFpZzkyWk1QRHFkZGhuS2FpaCtRaGRGekk5ejRBcTRWdVQ2?=
 =?utf-8?B?Zlh5MitOWTcvWEJ5aWp5MzBGSnAyRVJrTm9RTFgrQnZIa2xUOTJ0OFR2dHRG?=
 =?utf-8?B?UWlpVUNaM2ErbTV0K3kzbWRhVVZJNFl0MHl5dFd5RENIT2Z2TGtuVnovMU4y?=
 =?utf-8?B?dDRKSlNFSlJnWGZENWhvTFFtbjBScGhjd2w1djNqbG1ScHl5YWNFQzJhWGFq?=
 =?utf-8?B?SHJjbi9JZGJKUE1IL1Q4d2ZnaVJJSGpkNnp0b1pZWk5lZXBtNEhOM0pCSDZa?=
 =?utf-8?B?ZWpBNFo5VzRqbTVTT3ZiRjJhUmlxdkdueDU1c05ORXhHTU83VVVBd0EzVEtJ?=
 =?utf-8?B?MXNvaTNFdy9WNEs0R0pLYmlwZ3cwY1E5dU1LYTFZeER2NHFNR2dDazE0aHp2?=
 =?utf-8?B?ZXFUcWVGV2tqL29yNWppOTJpNGxXNFp6SmxWZHpCM2JzakRwSnNRS1dDVEpU?=
 =?utf-8?B?S3RPWmNiZG5ueFg3ZHVqNGVZS3hpdDAyOGZGLzROWVAxclMwY1RQNFBFaUhi?=
 =?utf-8?B?cE9HVG8yV2hVbjRVZlN1QWhWa1E0Sk82ZXgrbVpHN2lqQkdoWkpCZmpYMSt2?=
 =?utf-8?B?RmYxSjVNM21KNGJsRVhMZDdiUTZrN0xwWlloVjJHVVVicThGd1dzMkpmdjR5?=
 =?utf-8?B?WmhGVGI5SEo3UzFaTmdyeDl0OGZxUkhXZjYzajBPRHZLOFdjMVVxcXgwa21Y?=
 =?utf-8?B?VTZTcjU5NHpSVGlEWElkQXMvR3J5MVpKaG05RElHZVEyeW1UVUVKRnZqSk05?=
 =?utf-8?B?Mmd3N0orSUt1Q0dUMGMreHJ0bUU0bEhqU3NNbTRINGFpQ3IrTW5xMk8zVFg5?=
 =?utf-8?Q?ghzLOMRzetu1mE9VeBZ91mZ2e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076a4659-5486-4f5a-06af-08dde7447907
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:39:03.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dpfIUi0bKXDaujJDJjFhmKhiJ0kfl/bCIbyyHlO5fWrOXy5SfPtySZ130L6C7irnYohsFgVmi/AgM/0h0zibg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380

On 8/28/25 6:59 AM, Danilo Krummrich wrote:
> On 8/28/25 3:25 PM, Alexandre Courbot wrote:
>> On Wed Aug 27, 2025 at 8:12 AM JST, John Hubbard wrote:
>> <snip>
>>> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
>>> index 4b0ad8d4edc6..fd7a789e3015 100644
>>> --- a/rust/kernel/pci/id.rs
>>> +++ b/rust/kernel/pci/id.rs
>>> @@ -118,15 +118,14 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
>>>   /// ```
>>>   /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
>>>   /// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
>>> -///     // Compare raw vendor ID with known vendor constant
>>> -///     let vendor_id = pdev.vendor_id();
>>> -///     if vendor_id == Vendor::NVIDIA.as_raw() {
>>> -///         dev_info!(
>>> -///             pdev.as_ref(),
>>> -///             "Found NVIDIA device: 0x{:x}\n",
>>> -///             pdev.device_id()
>>> -///         );
>>> -///     }
>>> +///     // Get the validated PCI vendor ID
>>> +///     let vendor = pdev.vendor_id();
>>> +///     dev_info!(
>>> +///         pdev.as_ref(),
>>> +///         "Device: Vendor={}, Device=0x{:x}\n",
>>> +///         vendor,
>>> +///         pdev.device_id()
>>> +///     );
>>
>> Why not use this new example starting from patch 2, which introduced the
>> previous code that this patch removes?
> 
> I think that's because in v2 vendor_id() still returns the raw value. I think it

That is correct.

> makes a little more sense if this patch simply introduces the example as an
> example for vendor_id() itself.
> 
> I think struct Vendor does not necessarily need an example by itself.

I'm not quite sure if you are asking for a change to this patch? The
example already exercises .vendor_id(), so...?


thanks,
-- 
John Hubbard


