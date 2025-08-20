Return-Path: <linux-pci+bounces-34397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6753B2E3E9
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 19:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B3E1C85B1C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE5340D81;
	Wed, 20 Aug 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sesxEUcA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B37335BDB;
	Wed, 20 Aug 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710417; cv=fail; b=KBwaBYsO+xVYzFIX4k8YuujpZBqXPvSJv64V2yr16BaCUIjcE0wm0wtsQIMSwpsx9HdX8udMhUlTSwaDrvHyzN47YlTxuiOyY80a880tnpdYnL0TqR+oYQts34mNe6X4MTd0avQyfO/GKBeM7N1CYcnN6Vac+q6Yy4vGwURchtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710417; c=relaxed/simple;
	bh=6qo++OTrVDkKRSh4/KUMRpQjpuE+1sbdr71ZFNYrmUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fbAA9nbDDm8QVq56f7ZyQRyGZowRUJBg+wWXFz3oH8KFScNeVUmJuk2I+6yh8+FQZXuChiChProqjyuRZR1mlCD95b4WMVWHRMrWI2S9HHnc+YlbBNXNiD+YnLo+PBwaHDe1keSHwGQ0ylZLO/0socmpEeQD05tZR17NLCe98yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sesxEUcA; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZALGRHhBpL2nNvm2nvBXi82zGrZ8ZO0AIwG1numnABYYADRjZ4kBpWPFjFVUNBbxbDTzG7id23oMgHwHSlNhPXO3FmUfgM0XGWQ7YhCtYRiSeiYrAgcZaEUeMdxzoOd9NRWprcBeiQuUugO+KAYSFWqfNFacsI6SaDCmIpuSCKIW+9z87G+mAZIqJ2u5hv75t2bXgtrRL9oRzrbZKeEvX/fUpETYvgZzhI01dtQnrMyuXwTI8JmPeARVSj+n039GK7GHDgS7LS8woVGihKAsvNbI+eMrOxB2jvhCzQOu9/BmcEkTrb1CMQZLDazuEqy49Nfh55A9wOC95DmVQD9nqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpWbzCUUbuGxcUgTDLSNPWcWwHPLj0zcCrZK0ChZFlg=;
 b=vHWgskF6p6qazvIwlWWRzsWDsdVeEiXS5zr8f2jomk5sEy1fYmVncwu2YRZB/cs+0cdZ6hxmoFxZhX/ShDR+PdyA4wa2z3XfN+79L9wPSDTMI11XIRCzrX95dnBFw4NdnmKz3Thp93KDnu53DP737SiDEX2czXm2kBmvgihF3r67vUp47IBGLMrZ9tSaTIsWvR5rjf7h0osmH/xUgl1lo3a4mmPRzB+UpAbE1DenUvXnYQed+AhenhJ0UAWgOm7zrHkusxw3D475Fgo24o70+NO10MEdm1P7qiZymaeds6LVNX/vIXaBek8QahB3rH9ixCtPq5Wa3mY4tVqbrJhpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpWbzCUUbuGxcUgTDLSNPWcWwHPLj0zcCrZK0ChZFlg=;
 b=sesxEUcAiIZy7WJ1bO/i5r3R4jbQpKmQNC331kP1TVwhRAR+eNXNWRw7+Swc9GGxahPL00yzk6rPbuVdD54rTrsuOe7BSpygRVJRH/84BR/W08yxWGwGWv8mJ8TjAumoBhcPhWpbAh3TH3JhQ9RddFzqjNXvZZG23uSsRcnuISVwCNxgdyaN3YN4EiqBflHiur7rqxROIqBtbFx+XGN2a1PeUvYjCCUVDc1tFguYv0Sr8L7D7P9Y5KsAyBspKv5mnrMqbbYUPLRca2VpsV7U/wYXGPdxbvoCoCL1CVMMAucexBu2fGay0j1rZfrp0CNs0qQUBN1OiIUsiK9WD5uBLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0SPRMB0001.namprd12.prod.outlook.com (2603:10b6:8:cf::8) by
 IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:20:11 +0000
Received: from DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e]) by DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e%4]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 17:20:10 +0000
Message-ID: <737b6b23-69b4-41da-884d-477696329a24@nvidia.com>
Date: Wed, 20 Aug 2025 10:20:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] gpu: nova-core: avoid probing non-display/compute
 PCI functions
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
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250820030859.6446-1-jhubbard@nvidia.com>
 <20250820030859.6446-3-jhubbard@nvidia.com>
 <DC7AZL4OWXTY.2F7TRSCZYNK6S@nvidia.com>
 <DC7B2I88PS4K.TJAD25XWXK9K@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DC7B2I88PS4K.TJAD25XWXK9K@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To DS0SPRMB0001.namprd12.prod.outlook.com
 (2603:10b6:8:cf::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0SPRMB0001:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 665c6202-7574-410c-420f-08dde00dd13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2NrcGZDbjY5VDdlTEQ5bi9hNk1laWpNMHVCMGtaZm5rT3FGWkhOeVVDdzBZ?=
 =?utf-8?B?NFNaZ2ZJdUpLc0hIWldITTJjK1RuRmc2NU5ZMmhndEVRWHdpRDNPRnFaR3V5?=
 =?utf-8?B?aFNkaEJvbWIxSjQvblc5R0VpcGlWckJwWGcyUUJrdCtSZWFGS2k0OUpudHZv?=
 =?utf-8?B?SHBJUFBFNHhhbW5ZdElHSmYraTNybUNUUm14M2EvdVI0TzRsL0hhU2dxZTJ3?=
 =?utf-8?B?eEdNcnp4UHovS1RuYXlXbFFXMmoraDM1QmptWUlGcEo2cVNDdmJwajdsaWU3?=
 =?utf-8?B?VGE2bVY2dkFxdDFaY3lNVkZuaEZuRXR0eVoweVlCMFdZRU9odjlCdE91bHVv?=
 =?utf-8?B?Yy9iMHBLbGtxREZERVdXSU9yN0orbjMwelowdm5obVYzbzZHblZmaUNNQ1Fw?=
 =?utf-8?B?VnVsQVZFdmtlenUvNzY5czlEQmVPQlduSktwbEFRbEMvUlBheWd2MFpsOUI5?=
 =?utf-8?B?Z2l4ajBUY2M4YU5YWXc0NGtOVWtxaEp6QTVLRlNTV01qVTlzdG9RSzdBZEpC?=
 =?utf-8?B?TDUrbGhMSlA5MlQvUUppUzgxM1RwVnBDaTdWRFNkN2xSMmFXMGNwRVZja2RW?=
 =?utf-8?B?MkNENmNRcnV2ak4vdGtaaDJ6SkMvM2dYSnNZTGtiNDRxVEp0dVBCZWNOWmxV?=
 =?utf-8?B?WnJEZVZXY3gvRFpWMkdUYndreUsydkdjQzNQUEViRDVQc2dteWErTWpUS1Bp?=
 =?utf-8?B?dWRaNU4yVXdFVDlZWnFvQzdrYk9hT05KY0UxbGFmRTdKQ0NOYnFmUlkydWxC?=
 =?utf-8?B?TVNieVhUM0tNTjZHeWlBTzlIK1BvSXhMRit6bnNMNU9jRnI0TFZYR0wvRWNB?=
 =?utf-8?B?ZEVFY2Z4MHc4VHdYL1dGdGpCZzNZaDlqRHU1amVwZmlzVis3V2hPZEpZdGFR?=
 =?utf-8?B?RXZEVXN2TWZibDhFMzRMaC92cStGSjN2L1UweVUzN1FON3JKTysrcVF0b2xw?=
 =?utf-8?B?OTY4SG85bUFzaWJWT21WTE9vYXVuNnNoV3FYekp0dzRPelZWdDVWZ2hObkMy?=
 =?utf-8?B?ZnZ6ZWp0SFhqQ1ZqcklZL1Q5RU1vVHhLa2xBaTIvSTFJb1JrTjlKd205aHB0?=
 =?utf-8?B?QzZKWmVIMHRBbVRSTEIvNzVSVFlpdWF1VW5EVmo2bFBJQXF0eVdYdGt2OEpK?=
 =?utf-8?B?ZWgyUU13N25ZSDBla0VyWU5ZelFESS9RUmhmTVBxK0dBYk5kaWVSd3p1S1Zl?=
 =?utf-8?B?Sll2cHdpU0ZmQmVKcnZnWnY1NW1qVU4xMmN4QnNVQUovWDFSWVh4ekVxRENO?=
 =?utf-8?B?eVVrSXhNRDA2QVBUNVhJZ09lK3dNVnhMOURUVkYwSHA5ZGovWU5zZEdpSGsr?=
 =?utf-8?B?TnVFWG1zVU0yNVErSjV2bGx6TTZqbEdEZG1MRmt6c01VQXBBYm5jeWZ1dGdC?=
 =?utf-8?B?Y0lWWnZrVytPczFoZWFqS3ZoUmIwMFpTb0JQd2g2bUVkMy9lZFlqL2tVVWNy?=
 =?utf-8?B?V3lqOXVDNTQycE1TV0MyNjhKcjNSY1QrQkRkOHBLVDNMa2lvUXlweHBTa3lT?=
 =?utf-8?B?ODU1NHlJK2R6Z3pQMjFiSHNSVThhMnAxdmxJcU0rZTMwaE5qLzU3MXNqcVBk?=
 =?utf-8?B?NHREWWkwV1N4TGVwRk5jNVVDRDN4R1F0blE3NXZJSll4MHZXMzhBS2g1dHl5?=
 =?utf-8?B?V3ZUODF3Yk5XN2xRcFFoVjVjYStKSWdBdk12OEZZWlp2NGhmZlA5TjJQMDRp?=
 =?utf-8?B?ci8vVmJhd3dJR0NaSVZBYXlQRkpFS1NPTTVmQ016QnpveWNxeVNUakRCUWFT?=
 =?utf-8?B?NGRTaGMza3crZXFMKy8zN1pRazZJZ1I1ZlF1QUQ2anZzNGlNc0UrZmpOWHJZ?=
 =?utf-8?B?UXpxTVFsYTRDRFY4bk9sdnBvdCt0bjV6b1pZRXR4V3JDdDBoTmVIcW9qWS8r?=
 =?utf-8?B?TFFhcXQ3d0QxUGF0Tkl0bU9TVENoMXlPdWpPRW56VTZhOG4xdHVnbXA1Y0J2?=
 =?utf-8?Q?jNGVLfEy2/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0SPRMB0001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R25jYnFCVTZwenRYdXpzZGMzTXc1VnVFak1qSktISW1OazNjK0pDbUdZSjFm?=
 =?utf-8?B?OE9Ud3NtWmxtRDAvNGhobmlQc3RIaWtLM0FtUkhPbVNtbEtPWnBpQy8wemZG?=
 =?utf-8?B?MEF5MzBSSUwrSzgzeXowaGZJTExsemRtaVlrUmdlb2p1c1VXQmVsQzdnQjA4?=
 =?utf-8?B?WmpCTnIvVDFNWXQrSFF0ckJXM09NOGE2NHlnZHRmY2ZKWEFNNVU2S2xUb3NM?=
 =?utf-8?B?YS9ERS9NMFozaFlNa3lCNndySFVYVklwZjJQWDVFUE9QMG53a2RhSXAybTly?=
 =?utf-8?B?aHpDb0R5amw3L3k0aG9YTXJ3NVhYRzh0bU4rYnBJN0xwMFRDbGhVcUQ3RU03?=
 =?utf-8?B?U2U2dGxYU2R1Sk5tb2pxcDUxZXVJVFBsMDBFb1FlcGxyK2I5dS9taGpWZnlR?=
 =?utf-8?B?cGJDdzFFc1pBTUg1M2JmQlQ3SnpyTTcrbldsVzZHZUJENXBoQmM2Rzd2SkU0?=
 =?utf-8?B?L0htQ0JQOGRhUGRwaEQ2bW8yZHl5bkZHRTVZV1d4bVFCd0FIRU00dVVML2g5?=
 =?utf-8?B?aUFPN01qSElJZkRqcjg1Ni91U0VwdGlqazR1Mm03ZVdQbmZzblo2ZDA3QitM?=
 =?utf-8?B?SWUyK3htU3FrUDl2NXNESHRLRTBPVHlCYkd1RnJSM0NXQXBYSVFLbEE3TEhU?=
 =?utf-8?B?M29CVm1kbnpvU0YzU2pRTTlqM2pBOWgrTUhZZVJlS0FsaVdFbjc1WER3RVpx?=
 =?utf-8?B?OFJYVU1uWGd1UGhEaTFQYUsrZFlPaUpGQUdHdWdyQ0F3Y052ZDlxaEhKNmZw?=
 =?utf-8?B?aGw5TmhnYnh6NTI5ZGFkUWpCUG40MzBoWldiRzd5a1UyWHYwWTZUY2c3NGY2?=
 =?utf-8?B?LzhtbXVPUXE1V1hTWW5GOUN2TjVMMFZ5VXYxa0tZQklVeXhPVEtCejl6QTJ2?=
 =?utf-8?B?d2UyOWhSblN3WHlydFE4cU9DK2dZVG11WThTZWpSQjI0UWJNZzhRaktkQWxk?=
 =?utf-8?B?M2NvanRQZktoajg1dDZzaTAyRm9lL2c2RzZhSFVtTnVhQVJMSU9BZWJYWE0v?=
 =?utf-8?B?SEN5MEdWTHlEOHRSTVp5UERnZnExYi9YY2hKZi84NDdkYUt2VlRYaGtLbW84?=
 =?utf-8?B?V0xqWU5CM3B0SHFVVFJsM2ZSY2Z3TFV2MnJ1elpvc28rQUNMTnFFb09oclpB?=
 =?utf-8?B?bExEOXIxQzMvaDB2c3BZNnJ0ZzNVam83OFBCSFRZOWdNWDFNMVBUZ2YxTW03?=
 =?utf-8?B?enZvRCs4aFJWbnRqRUZjU1V4NGl3TXFwL1ZvanY4UWwyTktTVGNaUlZGNUdL?=
 =?utf-8?B?NnkrUnlTK3NuUWUrc1o4S0ovVExJNkZPNWpucVFubGJkMkZKZC9zZ3ZKc3p1?=
 =?utf-8?B?YmZiNDAyUjIxaVRPZFc5UGhLYkV6NW5oRkI0YXVtYStCUUhKZ0phY1JpOTln?=
 =?utf-8?B?czNlbW5lTG0wY3RoZk1KTG56bEkyS05WRlo4VC9vaVJvTVExdFZuSXJ1SnVs?=
 =?utf-8?B?Q1p2b0l3T3pPb1NmWThHdFZiQW9Vck5wNnFpMDhTYWFIanFQR1NRQU5GWndl?=
 =?utf-8?B?cmlxRFFIbStKbjMwRk81Tk9JcVBqM05obEYvbWJuTjA3dTd0UFJWdEZCd3h5?=
 =?utf-8?B?VVdhV1N3ZzhTaXlzNDZwSHQrNWZvRXRNaW9wU1hSYVJJdUZFUmwwdWVIdFJ6?=
 =?utf-8?B?cUU3a0J2dGVOOURJeW9ndWhORFduc0l4c3Z1U2ttMXBXelQ0b3NMRDZUV2dI?=
 =?utf-8?B?TkUrQ21hYmlrajRjY2dPRGtWV1RnNDVsRlpCVHdlemwwcEM0azY3WUFDNU1u?=
 =?utf-8?B?Y2JFaTBaQlk0NzFlbm9zRExUZzk2SDMxalBhUC9VdS9KVDB5NkZvTFRCd3Z5?=
 =?utf-8?B?MjlXVmxYWHNmN1hTUWxTdmRiR1Z3em5Gb0N0bTBxNHF0OVRGRkJuWVRHNWNN?=
 =?utf-8?B?VzlicFREUlZSRTlkeDF5UE9EWTZrMUR5REFJcGlZc2VROHZ2RVV0S2toNHdD?=
 =?utf-8?B?NThLeHJIb1VzSFVJbUJZN2lmUDRTRXRSOU5sVVRvTlZzTVNoRjlLTExRVGkx?=
 =?utf-8?B?Mm5sbHFwY3NKcHFjZlczeGkvdHNreUpGVkdDOWtoV2oydm5TU1JpZkI5YjFh?=
 =?utf-8?B?Q0NZcU5xcmxDOXFmcENVUGZOcUZLc2VKY3lBV25wb2pJN1BqM3NhMUx5YlBV?=
 =?utf-8?B?VU81S2wwRUc5cFRHN3BxeGxUS2FIZTU0dTJLblFNTVFNd0NHSTB2d3BvS0p2?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665c6202-7574-410c-420f-08dde00dd13c
X-MS-Exchange-CrossTenant-AuthSource: DS0SPRMB0001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:20:10.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQJJmjqANyRzHWPjMBs9aHmxH+SDtnt7Dm5886refELPAkouYdorFiMPZEtVPzfS0fTqCaz1iHeRrBuAQjGGGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758

On 8/20/25 6:56 AM, Danilo Krummrich wrote:
> On Wed Aug 20, 2025 at 3:52 PM CEST, Alexandre Courbot wrote:
>> This is making use of `from_class_and_vendor`, which is modified in the
>> next patch, requiring to modify this part of the file again. How about
>> switching this patch with 3/3 so we only modify the nova-core code once?
> 
> I think that makes sense.

Sure.

> 
>> I also wonder if we want to merge 1/3 and (the current) 3/3, since 1/3
>> alone leaves `from_class_and_vendor` into some intermediate state that
>> nobody will ever get a chance to use anyway, and one doesn't really make
>> sense without the other. WDYT?
> 
> Let's not merge them please, the intermediate state is not that bad, currently
> we deal with raw integers for representing vendor IDs as well. So, patch 1 is an
> improvement even by itself.

OK.

thanks,
-- 
John Hubbard


