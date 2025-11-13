Return-Path: <linux-pci+bounces-41063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D27EBC56137
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E4BB3454CE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DB632720D;
	Thu, 13 Nov 2025 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m3SR8fSy"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9BE32ED47;
	Thu, 13 Nov 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019414; cv=fail; b=pDmK1fYhlYVz6A5lKg9DkbcPyFv7EN18DWjXu8ygvr7X91I8WQhJjs5UdsgRGsGbgTcCptm4TXQoLX69SbA2vpJwWWtIW9lR3SH5xRydXIO84VtJayZVB6pGqu0Ha319wF65mydKiWyAtUu4ealGQbUy5X8Dhm44lxzj+b/RCUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019414; c=relaxed/simple;
	bh=GnNi0EcR1j/cNW8EwokuqkLppeTfAlV3dBW0aumIoHo=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=aH2xymEK6hcYXWs6ATrjESdzRcy9u06iAWwIR5vAzkcFuXNQNUKntZWhQHFBn5fmDms5Z1MC8xPvcvnpFz0dob10av0qDtJFjDLZTkFglaegtf9gCyvRnHpf0hTL2frMDGmpdx6UKbSRouO2fZJDsvwGdIWjb9jlIAfyEhiwS0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m3SR8fSy; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzfltSuZ6+nBHIqktdMyirE6P/eCfYkOvmlAUhWFY8k53e501/BC8Qpv7YztTwD/mpMwC0KOq5rG/XEMp2iBM+BkBMQQNJBGT4A/hZsrHbZuS1WBlZug//1WU3rIc9GaNzmi45ftoLKYH+hPtw4Xht4G9KNXOVy7iOCTnZbrTb2rxvrG7RtvsvZoejDMTrn9Z5V/HZTk1HYtIHFvHJgWNhhVK+fbZU3zDai+ZKCskmGQ8lZsY/sqr7KIUjOY6gy4f2uYdFR6jr/eJUPBS8HQYw/6elRrHu/QJqqVT6s5zlkwVUZhcUtRiHiLFv+4cDyfAVRvik+hTUIp9OQJC+n4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnNi0EcR1j/cNW8EwokuqkLppeTfAlV3dBW0aumIoHo=;
 b=t59k9V+C1znmhHpVVLZCsOiLdDItgLJmvsg6Mr9vgsRPFlgJ0gfY6QQv7lmySVEfrVtzTkE+Nm0ZAopAZyNXVhT+/GaxH90sc44mlKruhe/TqWNHHr+8d2NG0rBTfLiBdnmdfrq6enr+QJO3wcwWdqnMwcPg6pXJ7Gz1gCGQsyhzSSUtKCvLuhGXMyd7FLnDeGLPR+7LSRI5XjYzpNDdmjSKhM+ICHGLZSKAp6Xc1MvkiycWRqXNMSt6rrah0z5ObXnALdgT7CxXG5KNM06q4EmOgwCd1blKLgB1FlV5/RLcHHCvq8VYHu8V6WsYwPC8qeSo+5PcQSjPJcWVcIHgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnNi0EcR1j/cNW8EwokuqkLppeTfAlV3dBW0aumIoHo=;
 b=m3SR8fSyz7YhiZzWtDoblHM9Ry72SWaMUFnwvV7hhfEEQcLLj5jN/eAKFkn20dfriHSoNlY1VJ5V+bqyW5D7m1or3XR1kqRxxjkDvY0xkLMTsSMZTIGM1Z7BiIZwgqpWJfveAtlEbHLgMpRgNx4eVSHlNSMYFyOizBDD3EEBQOJsK1yytZEsJk8kAbzT11ycLRQvnX7MC4PJL4j0rfFZPhxkaew93o9/jiGtQ7T38J4fMGfCGMVb4U2+F8WxCMsYgSYRy4E32Vj8EzYYcEAAQj2/CrXjzx4G5SWZYu2HXrS1ZMbo6ZaNPK1o/N/W6wNIRe5s2VYzR6XGWlbQNRoWhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 07:36:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:36:44 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Nov 2025 16:36:40 +0900
Message-Id: <DE7E7VHVUUAK.3L556B20VZTJH@nvidia.com>
Subject: Re: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into
 Io trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-5-zhiw@nvidia.com>
In-Reply-To: <20251110204119.18351-5-zhiw@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 745bbdea-6b51-466f-28b5-08de228764c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDZGdDZuemt1cHR0TUVCTjIycE1CYjNiZHdmNGFySXhzYlZxbTRiV3R1MDdT?=
 =?utf-8?B?ZEZwaU9CY0RVR1F6eXdOOHprMUhGbE9WajhCT1ZzaWZ2bWZCMTB2Vm1MWCtz?=
 =?utf-8?B?VXI2UEIwdGtWQU11TGdndVJTSWl6a3dQOVZQVmdEYUZ0QjhVU1lPME03Zlp0?=
 =?utf-8?B?ZUt0SDdBUGYyQk96M2xVTUlzWnF6RlJZRXJ4dUNNZ2VEc0xTYXh5UTYyYWRI?=
 =?utf-8?B?ZEVEWUZSbWE5TjJkdGxjMmpZbVNoR2xaYUZqT084UFpBZkcrRjVHa09aYkFL?=
 =?utf-8?B?anp4dm0yL3BHZXhUMzFUandhUlBRYmtWZ3hsdWtuck4wZzFrOG9SMkY3NjZz?=
 =?utf-8?B?SStzb2JlS0E4cTZOSHhZWnc2Zk9LeTIvVm54YjBhWjB0RnlNdlo2a0hzcHlW?=
 =?utf-8?B?dW5pVU9FenlTTjZQUmdpdHJGQ1ZFZjMvUEpNU0RUK3Q3bjJqa3pIQXcycGQv?=
 =?utf-8?B?UHRyTFZoMjlzMGZjNGFIdEdFblVDZm9kZTZCUFljNnVhbFBWQXhESnFWazNK?=
 =?utf-8?B?QkVuWHF2aUFZUXplYXlUMWYrY3ViazRHcHhRWkk2SysvMTYzMlVDSm9Wbkwx?=
 =?utf-8?B?eDd1eENtZW5PVkhwNGFWdTJkbnkvQU9VeFk5RW11UXMwWEdndVFyNGZBVFN5?=
 =?utf-8?B?WGZDcVZtNGNPWmFUb3YzWmdja0lQYjhmZFNvallMTDZiUmx0ODZVQzVBcUJl?=
 =?utf-8?B?RitZSkQ4VUx1UDdnbGlvWVVWb3EweHZwVlZpcHZrb0dzYk1IUXJlOWFDbm5j?=
 =?utf-8?B?Yy9NeW95TWF1aGhWcEszT2pyeEVlV0RYclpLZThIS29DSnpCZEVSQjdIV0Uv?=
 =?utf-8?B?MCtZT1VHVVBkbGNCZWY2Z0M1UDNQUU83eEczcElVb3V1aEQxak02ditBOTVN?=
 =?utf-8?B?MUZLRXhEZ1lCQ0tuZEZCNHphQkhCc0pTbjJtcjU1TEh1aC9MN1NBdW1XOVdW?=
 =?utf-8?B?TW9rbTlVNUhpcHpXNkdib1A5T2VQc0FDQ09NS3lkM1UyWEluQ3Vhb1F1dTBk?=
 =?utf-8?B?SFJlQTlobmVWRmJyRzA1SG83WlE2SmU0a244SjdsRjR6TE04ZTNDUkdENXRC?=
 =?utf-8?B?clVyalpIazNnU0VnSXorcld6Vk1sdFl4WU81V0YzdlFCZGUzeEdrVXFRMytN?=
 =?utf-8?B?TGtOSDlzd1BIdkhFamlySlFRSE9jaWZPTFY1cDQzZGxnMTNmeDhQUC9qNGtx?=
 =?utf-8?B?SEpkcjlCeXF3bzB5eUs0TzVDNzFmYU52V2tjei9kdE5nUjZCK25oVHdxMVNo?=
 =?utf-8?B?am1GOWtHK3ZDeVJXRlZMSVlxcTlYcVVwYVAvcnZTNmxvUWVrQ3NMWWJPejE1?=
 =?utf-8?B?K1d2UU00TldTazBvVWtxUGg1eXlDMlhwQUNwVW5hR24rOGlxZml2ejZDVVh1?=
 =?utf-8?B?NjZoc3FuOWoyYzVtaUJIQVpLMldvRTNLVFNEMzV0Y0F4cVo3TG5xS3JRTXN0?=
 =?utf-8?B?azNwRGJHbFZOWDdWQWk3aTVwYWZJQWlhandkQk1TbFlUam1sUWZBWDhnRHE3?=
 =?utf-8?B?VmZ3UnBIejdKQkhzMTRxS1FYNU9zSzBxV0wvd25wZUxjNVRoZU5TYllET1Zt?=
 =?utf-8?B?OHZSRmF2ZGRFK3hxcGM0MTZZbVM3MWozQVlmejFKVzBVSCtWUVRYWXYwZlhv?=
 =?utf-8?B?cWdpb215K0lEV3B6aThzbFBsVE5zMmoveExoczRzdFFYaFl4bUU3VjVGcDE2?=
 =?utf-8?B?TDNkVUNFODNIdm9xdzlpWVJ1NkFOdTJjL3pXYWFuN29DRkdMRkZlWWdMSkJ4?=
 =?utf-8?B?cllVcGJoVkxMMlZCRFRmK20zRm1tbE5qcThZOGp1QU9rTE41ZEZUQmdrbUI0?=
 =?utf-8?B?QUtrcUo0VnliSDU3OGVFbjJuak42cFVLcGJrcTZ2bHZITkNYM0Z3TWpqUCtZ?=
 =?utf-8?B?b3hZNzhYcUxsUzhWdGROU083ekVwQndrL2NnTVk4clhOTUZ2Ty82bUdoVE9Y?=
 =?utf-8?Q?PuHiBBpR4GWKOTWkqZxTrBRu6i4htL96?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZC93RCtNT0t1VlcxUEZ0VjN0bFRKUUFzZWlrTGNTNmQwNThTbTgyUDJUeG9h?=
 =?utf-8?B?RkN1azgvTXdWcExwV2pPckRXTHJYZnhHT3h5dkVtMlQ5djk0ZEc0dmp6N1Zh?=
 =?utf-8?B?WjF4TllRT2xNc0F3T1YrdXZlMDFDYWZWb1VGaHN6Ykx2eE5obENKa0VEaG51?=
 =?utf-8?B?TkliN0I2MExNOEZNakltdFRMR0h0SzBET1VjVWoxN2lyQ0VVRXQxcW9lL3pM?=
 =?utf-8?B?WDl0MHBMRWQyeWxDcjNaTzNYWFAxL3dVLzlOSnhnOU52ZnRqa1hqMllNVHN1?=
 =?utf-8?B?QXNOaUhBb1Bab2pUc2dNVEpPRjN6REEwTW5NUUIzR0lSQnZBeHl2MnltcDV0?=
 =?utf-8?B?OG14ejJSdkZRK2REcGZNeWpvR2JGVVVJV3g1enV0WG5rVlozSklXSXAyK2tR?=
 =?utf-8?B?T1pkMlBFUkhDMlU5RmdoMDJpeGFuN1hmS043aFJlcEJtbXlpU1BUL05XV0Zk?=
 =?utf-8?B?c1pISSs1bnJYSWxNTFNkK0FwbUZYd3FoMjJKWGhMcUIrYXZEczM3R0dDb2I3?=
 =?utf-8?B?SkZQRFl1YlNRQnMzTzZVM1doeUx6elJaTzZPMWpHbjhBbHNUSm1rQjNJZUdK?=
 =?utf-8?B?RWErNWJWTWRKUVpLSUVzTjJkZmhBVlBXT1hVZ1ZjWTFTekthT3NRY1VuU1dh?=
 =?utf-8?B?SUdrcExOUTQ3MUJaYzNNOHpRWnpoMGpuYndxeCtVTVpqZmhwOWE3b1RMNVNT?=
 =?utf-8?B?VzkxUGJWQkNJNmREV1VTMVBMMEMxbnNheFRlUDhJQ2VzMTRFYkRITTdCNENm?=
 =?utf-8?B?SkRHanhvb0FXLzdFS2NyVTdYa3kyNWphREFvZjAyMTNQTENRemJHS2xQTDJX?=
 =?utf-8?B?UXlVSGZreFlUbzBGWGpNZlBwTWlYd3F3WmY4LzJXK25LR0NMclh2bmJ1TWlR?=
 =?utf-8?B?SjVISzN5MkdtTnY0SWVQUXhoa0FKWVhpck9DMGV3TEVNb0JRVFZOK0k4b3NS?=
 =?utf-8?B?MUJFY1RyZ2c5dnVpQlZCOXBUN01VeVIwOS9nRFBnaldac09QVHNUOCtWRU9O?=
 =?utf-8?B?ZmdPb2g5aURaSm8zNTVINTR1Q2k3ejUrVWl0MjFMbzFGSjlvQ0Rmbkh4TmJi?=
 =?utf-8?B?dFprZTU0aldka2FRdDd5REY4RnQ0N002bllpVitiaThvTUNYSEpOL0hoR3o0?=
 =?utf-8?B?ZUVVeXZMN3M0QjRFNFlkeUJhTHA5QkpESEZBazdJOTFscEduN21VQTZsdmY3?=
 =?utf-8?B?amcxcVNZRzNLSjhvTnN3aDFOeXJLTU4vZ08yQmV2cjMyd2lUQ3J6TVdSOTFN?=
 =?utf-8?B?SG5uNDhLVENSWUlEYVUrZm04elRGcFpsSzFnTmw2Rlg1dUdNL1hENlpSZmZM?=
 =?utf-8?B?a04wMHVaSldCRURCeE9DaXk2bmZpV0Q3Q29jSG4zZmxUMi9nOFBRWE9rcUhG?=
 =?utf-8?B?aThUQ1JoaFYwdXY2S1I1RkVvVEtsYkRDN3AzcTh3S3lCY2IrRkRlNzZEN3Bj?=
 =?utf-8?B?bTBNSnFobWtHTk95RXl5Z0xSKy9oWSt5NGM3MTYvUWlFZnZYU1FiVFNXMWZy?=
 =?utf-8?B?c3hZNDgxVXpVRWhuSWphUnYwUFcrRm9hb3lEc1M4Mi9TLzRVbWZRVFJhaTBU?=
 =?utf-8?B?bFUxbVlmVEhaUjFaNnNmSGRERHlNTktXWlpDa1ZSMTVFakZ1Zjg5S3ROdjgx?=
 =?utf-8?B?QzZqeUFoeTZJeWFZVnRBQTJ4ZUpKejBUeXBwZ1hXWXRFYzRUOGRrYk1NSEdK?=
 =?utf-8?B?TFhXUEFOWEtkZ1NwVFBLUjdDemNrQldVY1ZVcFluZ1JuOHZFYUE5TzR1R2dh?=
 =?utf-8?B?QjlVZ3FuMitveU4rOHZYL0xVQTU1NTU4SVRTQjdzc0Y2MnlLaXlUVjJDeVhV?=
 =?utf-8?B?emtyMzQybmsrTmk3TEdBT3JReENwQ0dxQzNXYVljOFJVL2o5V1dRb0pLa1hR?=
 =?utf-8?B?VnNHNTRIMytqVTBJdVlwcVNuSUhuQnQ3MWtiSE5mS003RWxEM2Fuby9OeGpi?=
 =?utf-8?B?VHRla21YUEdCVlB1UlBWcEYrTk9EcTR4MHhQVEl2N2RGcWNMZ0Q5ODNXNzZ2?=
 =?utf-8?B?NXFCSWR4QjFUcjc4VTNqQjc2UzcxNzVpL1B6akJMS09wRXpLb0pYNXFDd3NC?=
 =?utf-8?B?ckZxU0ptYytRK0RXbnZMRHlBWFJPdm5jdDNoTGhNTUgvSHRFZ0NBL3VWZVQ2?=
 =?utf-8?B?MVN1RXd4ejV5b2laVFI2RWVVNUpYQzg5Q0NKMjFxOENqRis0LzlBWkNKK2dJ?=
 =?utf-8?Q?MWqY0mt1pdrP6R8XQFQYJkZg9gXR5UDMAC0bMV9cJwbs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745bbdea-6b51-466f-28b5-08de228764c4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:36:44.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56t9Gh8hF9Qr+AaTFYVwiiGPnAoiO7sLrOhqPb9EAA0qbqjway0cHYhj31qO5K7fLOGwcn3FsFr6iGAgeDMxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

Hi Zhi,

On Tue Nov 11, 2025 at 5:41 AM JST, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct.
>
> To establish a cleaner layering between the I/O interface and its concret=
e
> backends, paving the way for supporting additional I/O mechanisms in the
> future, Io<SIZE> need to be factored.
>
> Factor the common helpers into a new Io trait, and move the MMIO-specific
> logic into a dedicated Mmio<SIZE> type implementing that trait. Rename th=
e
> IoRaw to MmioRaw and update the bus MMIO implementations to use MmioRaw.
>
> No functional change intended.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

This is looking quite good to me! I tried really hard to find stuff to
comment about, but couldn't. :)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

