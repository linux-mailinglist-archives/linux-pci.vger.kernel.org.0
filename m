Return-Path: <linux-pci+bounces-38737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF450BF0E5E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688101892CEF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD42C21F7;
	Mon, 20 Oct 2025 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQLkCkbO"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922E24A051;
	Mon, 20 Oct 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960659; cv=fail; b=QBlqVRLtdgn4L09NfLdD8fPrRNLS+q0WZlVD2ERA41nfg4VIVguIRQKs7eTKSY8HIQU7zb0VIoyNkksxfVhX0Ddumyl/+0SEgHhcy1aEB6HUuHEvSDPbCSwiOKjzPi1tKzEBHspv6j7u0gNC0VYyHP2N7dLXPhSvyTPWFHNf2/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960659; c=relaxed/simple;
	bh=mDApmAg1KE+qB7oC2E8aas95ownthIXglv1JLepdll8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=NgHihKNbxzufaTzzqOXKnDdsjiDpCxdX6L1M2EKCX/zY3q4suSURpR9CcmBzm/LnkirMLiaZ7EQ4M99d16WFspXMJRwe3zjeUvTOQZZFBRBt4mUL7tXCqrit48HaPFMZ//7I7U6xbh2PB9LZrcnHCDDrJ7QtFIJBdTV095HqF60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQLkCkbO; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRfggdBRCTbVOw9VLZwz9GoURfB+B+KKBrMTlRYM1jaaz59J6jFIoz9mQuobBjRhW77WHkeoKdLCe3sy3ZE/aPx69/A2MSX7wQKjlHaDmbqO5CULIjr7Y1sfHO6orPCiRcHZZfx6X0sQx01PLD3S+KlTw6qHF+j/XZABBNaQ39F6X9l8hMKf9LJuPjDp8Az+mNyJ5N2A/HYM80wa74F4AGB2Ox5GoX3Ra1LT4hmwMnns22bksmuUyy5uQCXFiisjvQpy9kyYJRNASlzsrKfsOIzQSprCWgHi6exzdmXAG/EOfdMwG8cqd0ES64rsg/XRu9A1e//sBsRzBahNb6MFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bxIRNSrGhPJaEZd1dFiaJI+kJbi9oF2Bw0BZzwj9sA=;
 b=ozmyR0aDoS0YblQIJ7YrKv9nojmZcUGGKc+oaY/FLFuIIjOeRFQsA+uLCj2CS9g8YDoXx7IsyxsqwW8DtfbEEDu/RMi2SWO49dpRHp2QNkuc/2uh8//VymrDNaIocaN9bumOVfEQv5+K+MeDppcF9gq7d1MsM9uZSWvHPI7s4fYh8wLsgAnkjJFKcZZnytxIJnTBDT4Ll4qrpTRoKB70W5rr1HZX3VQJMpYxmYXQw0ZW9TjgL3PqZ+iQSq1tnUkiMMLa+i0JheCeg+2v+K6sfTS8enXuWIcUWV47eF9h+ftfIISYbCofAPiXyMX/q8cmoNgRljnxnNGMhkpJvjzmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bxIRNSrGhPJaEZd1dFiaJI+kJbi9oF2Bw0BZzwj9sA=;
 b=oQLkCkbOYh9+xDT4iWDNGqCFAdG8M9xqtCtiC5HUmC16KOnIKi9pFrOP8wR1a6yjXM3cpZQsPIw8mlgV1xNn4ZkUkOizSOWkKnsy28CtLofdv9oNCi6P8ktGx9OHHZOuVmRCyr+VDdb78rgdICVvkTbavYIS0JFna0MRjNBpmyoE+n0jAMQXuN4KxdtU1IfIdCq7QXGDIKZy00QO+5MFHvljUd4zYRsVYx3ORT7NYjaT2caXrVS5Qkb1UHo3DOzGTQ4P8Bn8FP9aCfSOBCHhOSEGfHcTFNdPCPDDjAr4JMqU519J9pqDNV4aeNjWmdCXGQHrWsip74rwcxV4UoYOag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 11:44:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 11:44:12 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 20:44:08 +0900
Message-Id: <DDN4G9Z6PWK1.22MOQHN03BRNL@nvidia.com>
Cc: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <zhiwang@kernel.org>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: Re: [PATCH v2 1/5] rust/io: factor common I/O helpers into Io trait
 and specialize Mmio<SIZE>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251016210250.15932-1-zhiw@nvidia.com>
 <20251016210250.15932-2-zhiw@nvidia.com>
In-Reply-To: <20251016210250.15932-2-zhiw@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:405:2::24) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbfa951-e6e4-43af-85b5-08de0fcdfd12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlpRGpzVDV5TTQ1U0NvTnlNTWtQZXl1Zkk1T2xudTZvZXZJV3RZWVpSVjJw?=
 =?utf-8?B?V2hWYW1kd0k2MlZPUkNHK2MrQ0lUUWxhekRoNHJJU2wyQ2Y5VklEM01vcXBw?=
 =?utf-8?B?NWJlbXRBY1B1THJiWG5xaC9QVVZscU90S1lWRjRuVjRscXBUaE1NUkNiTUNh?=
 =?utf-8?B?UWllUUxEVXNPaENkbU5kRi9UbEJLVkNsbUp2L1dOVHArbXNkVlhqWkdkcTNC?=
 =?utf-8?B?ME1wV0hmZnVtNkcrd0FHVlk3akhsL25MVU1zTnN0N2hXUXJCbVRyMlo2aU01?=
 =?utf-8?B?ZzlEYW92Y29oTWdoeU1OSUk2RS9IQ3VKSTRXUFBJeUhwZFN1YXZmdEhXc3ZJ?=
 =?utf-8?B?TjNqMGpuZjZrN2RtRVZ6V1Z6VTlJTzRJcDVmSGhCV214Wk1tNGVlRVA4T1lQ?=
 =?utf-8?B?RVMyRnVRLzZ5UnRsaEZFazdNR1c3WGJwNVdvTmExV3UxTEZKeUl6RzZRTE1t?=
 =?utf-8?B?a3g2amR2WjMvTE81aUV2QlNDS0VwM2pvN0tmbGR4UkFId04vQ3RxbkwyeWlN?=
 =?utf-8?B?eEpXYk1nRlJ2ZExxTDNRaDJwMDJBZEtBN1NoRk5QOUhNQTYzOFZmV2RmNHBC?=
 =?utf-8?B?eElFYmtJWnNXVTdBZHp6czNNcmYzMFR6Z2lzU01WdTNxSWIzdHNPNWlTKy9Z?=
 =?utf-8?B?LzZ3TjBvRG9qd2xtdWdKcGNMUnVhYnVPQkRYTTlWdzBKNUUyZFpXNm1Hb0xV?=
 =?utf-8?B?Zi9CVUNMSWJTY1BGQWhJZVZJQUREZDdHWEJDTk9keG9KTmJCelJLRi9yd2tU?=
 =?utf-8?B?RHViM0lZc2VhQ3RWbklkZ285VDlTbjJhN2NwZXZkTTUrU2lWWmdrK3dCN0JI?=
 =?utf-8?B?KytBOEJBRVgyQStnSzArOGs5Q2M1ZnRUT29xR0RPV0pNZHRSOGFPQ3F3OXVP?=
 =?utf-8?B?RGkzYlJTWHpSem5SR1NDZjFpZjJzcWJscmdJL0pXQ0RMTkk5VGQ0R1IwOFNC?=
 =?utf-8?B?Um9xTHUyRThJc0RSR0h2UmltZEZwMGEzeHlwOStZdFBXbVc4ekpEZ2VOOFg4?=
 =?utf-8?B?S2QzTjFOZ1Vrd1kxTlo1bXpNaHlpa09CL1lLUkNzUlY1eEpNT1VhMUtIL2dR?=
 =?utf-8?B?MTFpMUZ4VGhtUVZqSzEraTdNY1VBVnI4d1g3elJiWWgxaHRQaXFYM3NXcTNR?=
 =?utf-8?B?dXFQSFJKb2lqQmxuZGdSK1JRNnk3MkVYVHJESEdNZEo2QURRa2dHWU9jUlps?=
 =?utf-8?B?NGVoMTh5YkwzcTlGVnMwdjVlWDZMQWhOdVJZOUNla0JGMVNrMldHQ3BFeUYw?=
 =?utf-8?B?RTlRaWhsZ0VuVEtXQ3JSWmhxNmh3a0lTbkgzM1VaakVRTFc0MDdEWVhOVHYy?=
 =?utf-8?B?dEx6WHFpb1FjeXArUGFaamNDVVlMRmE2U2dyS281dlhSc0xFMnpuRGMzTlhZ?=
 =?utf-8?B?blpYQ2Nld3JZT2Q5VkI3NDBacWVDeFZtVGZkWVpOdnBKQm02ODJmajVYcmR3?=
 =?utf-8?B?RSswWG5uS2J4OG1yUkp2aUwzT3hhUnZpZzRZb2J0b1l4TUkvTDR4UXhxSEZT?=
 =?utf-8?B?cUF4N0VpSlljTC9pcVFoTXU3VWpqMUJrYk5NN0FFNUtQUWlERnloRFcwY3U3?=
 =?utf-8?B?SnVuZHlBWXJMbUc3b0V5Y1ozb2JER3l5U0VmUE5KRVBBY1RaSWJiT09CK2VN?=
 =?utf-8?B?NDdDNmhLQm9qTE5NQ2RlSUp0MGdXeTJSZTYrU2R5RnJZU0M4a2FEWmtyY2Zu?=
 =?utf-8?B?emJmT2FBaERXNnNxcFdJOGxTRUZzNUQ3Q0dxWGhQb2JlWlVrcGJZSjJhWW55?=
 =?utf-8?B?aVZoTkVtR0NrazFQMXZCZHljSjBXM2gxa0I5VFpZYStkcHlzc2ticHdQbWdN?=
 =?utf-8?B?SktYWUxMNzdtU3pSdTdZSTFlOEVWSDFqcGcwSzFqa2EyN2ZGRm5XNlpTOUN5?=
 =?utf-8?B?UFdVSVZKUDRpRVJyVWdRUnhzMXIwRDJEY1hQcy91SmdScEdEWDZuWkFTSE5I?=
 =?utf-8?Q?FZxeqxUxOIP/V5wLZDWI3fog9pDozec3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei95UWFYRDRGZEhEcUhRbk1tbEE0KzA5TG1ZWVZyWUlWeHBDeVg4RjRheWpp?=
 =?utf-8?B?UGU2emNyVEFQRUh4eEkxNDZXNGFNVkQwYVNZeHB1TGVKd29VMEZua284YkFU?=
 =?utf-8?B?NkxCdEhvQmZXcml2SllTbmhTa2RZZ3RIZkJoMUY1ekR2a0xtTW9udjI5ZnNl?=
 =?utf-8?B?cHFGTm1PL0hHR2xQQzdLVzM5MTBITWxoSGR6TUdNMGVLdGZVdElDeGJhMVdF?=
 =?utf-8?B?WGJKNnloMlVhV1BVTHNsWkx5YXB3WThQR3VTUGtkeW9xcjFqKzRyWlIvcGdh?=
 =?utf-8?B?cWF1dUlmVXpubG1IMGthank3VHJ3RmNXN054NUFJZElFcm5lVGw5Ym5HRGZZ?=
 =?utf-8?B?T1VKYnNPNDVLZWtQbFY2dSs4MHJnREZYNTZjKzd4bGJMSlk0ZW5XZkhZajB1?=
 =?utf-8?B?dFYwejVtSjVIcGRmQjNkM0cvcmJQb2N3R3owK0dNZmJrZEdTaWE2YXI3YW5l?=
 =?utf-8?B?Q0FmTzJoSFVyOEdKb29tUmtKcEk2Zi9xSlBGOElha3FVNGxHTlgvYkJRelpa?=
 =?utf-8?B?M1A5cDVkdjRpQnpBN0dZRjJxM0gzUzhwa21yaFJReUsxMFhDTTVXaTRIOGd6?=
 =?utf-8?B?OGpLVS84SzQ0VUxYWTRZZlVJKzhCSnAzSTUvQUs3cFh4bjdJdGpGYlBhV21w?=
 =?utf-8?B?UnVtbFlqL1pvRmRSRmJSSkpzelhUWGQ1MFRSNVV5R3o0RFpRU1NJKzZnQU9O?=
 =?utf-8?B?L0Y2YTFMdVYrV1hYcys1K082S2t4SG44N1BqTGQ1SlIzT3prb2hyNWgrV0ZP?=
 =?utf-8?B?REcvSlhiK2ZRRmtTUEc0aWx2TEZZRWxkOXRMUmRiUXE5WENQbjZ6c3gzZnlr?=
 =?utf-8?B?clZtYTBId0NOTnBVN28wSGQ2TmxVVDVBbGpkUk0vWUtWNEdsK2RaU1UwK0po?=
 =?utf-8?B?MFhzcnJQTzg3Yi9MaHdadkhVS1dpTjMrVUFzMUhlSjQzR0pIOGFucW8xMUhN?=
 =?utf-8?B?bnYyd1U0N2hjYmswZ2s2SGJZSThqalZWQ3FBZTdMRSs2bFNFZDR4OWFXbEZW?=
 =?utf-8?B?QXkrRGJoVk5zSFFNQTI4T2lWTndESWlrdFE1OHZnOW9GWVB4MlFSTmNBcmZS?=
 =?utf-8?B?aEJRSWs2UThIQ2dMRDZIbVpRSUlqZVY3VHJkM1ZzN0ZEL1lKTHFlS3kzN3Fa?=
 =?utf-8?B?c2NVdTh0eVlzSVp6czh2Ukpnb3JsWHVqRUZTYmRxaGNVQUdYTlkvWm0vclhL?=
 =?utf-8?B?N0FUQnArMUxma1RoWW1aV2RudFN0c1FFcHFqZERwNzUrcWhpRWNQWVNOQjFU?=
 =?utf-8?B?QUllTjNUdWlTTTY0NXZGdmlweDZhKzBZeGxHTG0vemtqa2NKWjNTUktEV1VY?=
 =?utf-8?B?c1phNnA4RlZCMUVSZU4zWkFNSnJkZjd6aVBRWlVNbCtnTWthcEcxcXVPUzdB?=
 =?utf-8?B?bUFsY1NPcm02R1pyWjRHSFBTWWt0UlBsSC8rNzZSSjFORTJZM3Z1cEEvMFdi?=
 =?utf-8?B?MWNOTk9MLytjM2xLbjZMRHk5dTRJV3pNcDdFWFBZWHRibG8reDg1dUpMV3lS?=
 =?utf-8?B?THArdksxRjUrQVJIdVJhVC9IVytTZCtEa0VXTjNZMjgyMG1NdWJDdmZtbit2?=
 =?utf-8?B?OU9rWnA4NVhDRlJYYUJITi91OFl3TFdhNzRpZCsvYzM3Y1ZrNkNETTNjZzdN?=
 =?utf-8?B?bjIyczlRbEVYQWN1SlJ1WVpmdUhrWm1ZaVZzOW4rcjVQWlZkek9SaHRxWkRJ?=
 =?utf-8?B?c0tDQjh4a2dDZFh0clMwSHZBbHlZR1FIOGlDc0V3TzFIM1F1aENzVDViYzc2?=
 =?utf-8?B?c2pOMVk4MlZza3k1ZGIxUVdxbmlVUExWVlVvRXJvRWFacnBGMW1mdU9aVWU5?=
 =?utf-8?B?Mkw2dUh5UWZyZ3J0a3FqSDhxTkN4bzJxVy9UYlpyMzF0cVNJM2pQYjh0M295?=
 =?utf-8?B?UmwyUzV5Y21VTDByTjAwelR1S3ZMMHZldnJKMGRkZG1SWExTNnBMc0x0SnNt?=
 =?utf-8?B?ekpZRHJQNytzam1nSjJ1TjBqUjUrNmFydUN3WEcrVzRpYlhLVUhtNXMvelR4?=
 =?utf-8?B?NVhuVjhVZldjdUVhMDNrMFBRREpOUTIyTS9HN3dLZlZ3TzFKbVBYc2g2YTZI?=
 =?utf-8?B?ZUFkcjFlZ3NwdXIrdTBwL0ZJK2JOekxlczYyMDBqTVZaTEdqZElUSGU3U0lC?=
 =?utf-8?B?anBKUU1TdklsbUpiaDk5b01MQ3pTUVB2cnZxWlV5eUs2QkFrc1NXK1p1ZmNn?=
 =?utf-8?Q?jFZJX/f/8nykNptf4eGW/QNUoT3CLbIlrv0mpizYjwgR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbfa951-e6e4-43af-85b5-08de0fcdfd12
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 11:44:12.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho77/ud8qqrJYZCJeaWXBBbhqpKnQWiXXSFO+hNZTxGOaMOgbkZwI9SxZCMldXabDgfnef0btlPjBlcJYSTlPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

On Fri Oct 17, 2025 at 6:02 AM JST, Zhi Wang wrote:
<snip>
> +/// Represents a region of I/O space of a fixed size.
> +///
> +/// Provides common helpers for offset validation and address
> +/// calculation on top of a base address and maximum size.
> +///
> +/// Types implementing this trait (e.g. MMIO BARs or PCI config
> +/// regions) can share the same accessors.
> +pub trait Io<const SIZE: usize> {
>      /// Returns the base address of this mapping.
> -    #[inline]
> -    pub fn addr(&self) -> usize {
> -        self.0.addr()
> -    }
> +    fn addr(&self) -> usize;
> =20
>      /// Returns the maximum size of this mapping.
> -    #[inline]
> -    pub fn maxsize(&self) -> usize {
> -        self.0.maxsize()
> -    }
> +    fn maxsize(&self) -> usize;
> =20
> +    /// Checks whether an access of type `U` at the given `offset`
> +    /// is valid within this region.
>      #[inline]
> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> +    fn offset_valid<U>(offset: usize, size: usize) -> bool {

Is it ok to lose the `const` attribute here?

Since this method doesn't take `self`, and is not supposed to be
overloaded anyway, I'd suggest moving it out of the trait and turning it
into a private function of this module.


