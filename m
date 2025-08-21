Return-Path: <linux-pci+bounces-34481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA668B30096
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 18:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C231BA14B8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0522E5B2F;
	Thu, 21 Aug 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QJEouX6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46D2E54D0;
	Thu, 21 Aug 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795289; cv=fail; b=ChUAj05N4xIIINgI4oR2pRTTVEOXiX9/cQS6x6wYeGSBVXmO4VhB+CXr9Elmf2UkDcx+Gd5xSQXvqCdwyNvpT3FJWTktCkISFDjRF4dT4kMP02oZMnLzOHmwK711P72NIjxxjfwIuFkNhNPWIygx67CScnE+hnglmY5aJ5rKX2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795289; c=relaxed/simple;
	bh=AbCrbnl0pQCQ5LvjhdYSbi1Kf+HOf8YSVQJz6vOhV8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=myVMo9khW2oM5OP7U8+kKdlkp/I4Hp0KIxsjrNtK6RWEsZudEO2LSdm+wpZ2sPe3fkykTvMv5SQCXrwkH04s0B7moTZikX/HFCJYxX/ogZ/J3k1wSG5sE3Q2FPeZTEn6ZFrz/6+566tyjGlTAdp4IpeSd6Ph7d8rJturqFGd81k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QJEouX6L; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgklujLEB+7LRLc06JUIdot0xn//O7qo7hlqYAQ8ZIwCya0mxGzxIg2LLsMAs/f/vLZy28sM7VqRBpNuH8LkcR9oLoC47SI/A9AGwEXn8SgPmNeWt+LqTlZSOXGTjzQ38VOr8vHlKoJGBlIIpSSUZFEh0B3LbHFCPqU2lS/laTC7H0xV9W4v0EoouwdvxlqR+s3zeZaTKlGDrXjsfPDyUBaQmFYRuN9b2md1ebOW5a+plYy74z/6A36K3xdneY/9VIz1XJBqQRc8ZN5TKAMAVHp2nGuZnlgdZ6kthtjKFNz+MrQ5ULlXmX9XkueTMwP5jOzj7SBue/vJjxLAv7emJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFcpwRPkQmWF9nwqs/XptvyBEYuN+mhdjd/NfjW9rAg=;
 b=juyXfzrsHd5o6pFv10lexGk8hQqEp8wSkR6MK4oYopclRjc/69KNPNADytPpIoQp98q0DnY5/R8CLGaa/zu4H2LCz9a3slD/CO07EStMVkOox5DXa47FVmoIYw3dhmJ9BOaSBR56JydEkqTbZThYr8CObh35Hk5GmCJg8t+EH6jQBwu3IT6PaFGDI2hxn0QaFPbiLtQHzgD4I/QXRybJthKQIx+T6a0MNd7KfE5BO0Wtnev+7UJNFDxV9wUUTjUESKO7KjNfmGlU9NNJsu/06gasb9NDm57B3qbnQgNu12g8N1jwxAhT4x64CUpNrpaVHrXXV/nw9d4qYSVRpxiawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFcpwRPkQmWF9nwqs/XptvyBEYuN+mhdjd/NfjW9rAg=;
 b=QJEouX6LW0/zfP+6qBgIa4AzenEELgHaH3rvZhtzu0dY4g/YJy1LaVuW62KGymWxWNYIbEhGon61ayoI0JaEeXJEpfIE776Wnc0vI7jiJEI/PbPxlkhqg2rAAN5wP9SPwo2rV7D2bpk1SYq4rcxRRL1ZER3z7pZ6GOsSIkfiGSgp6Jyi9LkTa7OCpEeYVHjFWFbBGa2zL9+wEtzXJY1fXTfonEfQg2NspD0nUVBlhM+0DJ7cFzBkKF65N96SzafbalgCmQyLceMTm8sAqW7tdkCV++cEUpJ2kahwc4NX3utkyxPJ0U8PtmT78lQQ4fGSguUCisECOx5sYPjmy5ozng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0SPRMB0001.namprd12.prod.outlook.com (2603:10b6:8:cf::8) by
 IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.16; Thu, 21 Aug 2025 16:54:43 +0000
Received: from DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e]) by DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e%4]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 16:54:43 +0000
Message-ID: <753aa207-a2ed-4836-9525-5fbf68aff6ef@nvidia.com>
Date: Thu, 21 Aug 2025 09:54:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] gpu: nova-core: avoid probing non-display/compute
 PCI functions
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
References: <20250821044207.3732-1-jhubbard@nvidia.com>
 <20250821044207.3732-4-jhubbard@nvidia.com>
 <DC81S5SN8N76.YH4323TLNHJK@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DC81S5SN8N76.YH4323TLNHJK@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To DS0SPRMB0001.namprd12.prod.outlook.com
 (2603:10b6:8:cf::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0SPRMB0001:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2fe914-27a8-41e3-dd37-08dde0d36d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXc1dE56c0RTS3NmRFBRcE13ZmVsN0hmTlcwUlQwNU5hWGorSkUrZXQvSHlW?=
 =?utf-8?B?WXl6aVl5M3UzUExQOFFuc1JRd1VIbjdwSTczOTlpOVVGVm5IZlZtMGhiMTNy?=
 =?utf-8?B?U3BpSXRDT1J4clBrNU1VeXlOeHl2a2lGcDF4SmRSN2R3c3NIcWtwQWlENVJm?=
 =?utf-8?B?UWJ6UXp2L3dxVnNVa3VLemdiTFhKeFVhUDdUZ2pqQnpDOS9CT3B4RVMwVlRL?=
 =?utf-8?B?ZWd5dGZFNkRPNWdDalFFL0J5eERrNnhzeGNCTHRjc3N3L2ZkSjdsc0o4aUZB?=
 =?utf-8?B?TGw3U1ZGUkVsZlgrYzlVTWMyc3dGVkV4cDh6R1ZwZ0IwUmVSSkNQbURqVStX?=
 =?utf-8?B?VlpKRVM0OU84VDZhMXhrUEROWi9hM1VYRVdOMkZZSFpiV000WTZPNDdia3p4?=
 =?utf-8?B?cDJCc1VrOE9wRHg3V3JmQWNVajltQWd2eE1Qdkg5WnhqSGNiZGx4Ujk5THBt?=
 =?utf-8?B?SmUwbjVtcWNXMFErOWV6M2xOaURkWmVlcjhheU81MExZOEhxQTR0RlhJeElx?=
 =?utf-8?B?WWhvd25uVEJOdHRob0pUcm1xRHNKa1IyeWdvZkdaQjhYWVZTeGhuUUhzWThV?=
 =?utf-8?B?ZVp0L2ZlbzQxL1NFNFBEdUk2bmNIZlE2UzRMZXN4NGtLR3J5RUpsTENVN0Vn?=
 =?utf-8?B?Q3UrdjZtR1NUMWFDK1FlNVpPL1J5R1ozMXJnejdRUmtuR0FybWpqUEVOVUxX?=
 =?utf-8?B?c093eE5lOWFYMXpSZ3V3TGVBWFd0Q0JpcTUvTC9iQk9TY2wydjdxb2g2d1pK?=
 =?utf-8?B?S3F2ZVMzWmVvZVVzRUpZV1JieXpvNEdNSTFTeGJrTnVHdERQZi9idVRkZTlG?=
 =?utf-8?B?Z2lXanAyWXZmWGNLd3g2bmo2WmJDbkZTcG9GaEI0VGJZWks3TjNTWGNxTXJV?=
 =?utf-8?B?c1JlM1BFUGw5M0tKWm5HbEt4TjFveHR3NTVNbjFZc2RnMXdzcEN3R0VuQTVJ?=
 =?utf-8?B?ZTEzVUVVK1o1SzRUS0Y2d01XRHRSMTM3T0ZCMGJVZWw1QTlSenRjOXF0cGlP?=
 =?utf-8?B?aEkraDUzbGlCejdyUUdPZTk1N0xPdytua2t0WUpRT05QNGhybGNyUVd4M3RB?=
 =?utf-8?B?UkJ1WW5QSHZiUFRWUUNaWUJySmZUSFlLOHR0MmZYZXpxNExhRXh4YnJqZmdG?=
 =?utf-8?B?bldINDdDanhRRDBLSy9ZaDFwL1hxQVdNYUxscXAwdGlBTHFDMDZaZlJBZzUw?=
 =?utf-8?B?SVpUejRXMHVxalNNSlpsaFRsTUdoZjV3SG9FUFJaRHVOUTBzcmRnQ3EwS01M?=
 =?utf-8?B?RFIrTklPek4yTnVjY3AwR2pObHZOMEpwNHJlRWYxQ0ZvRDNCa0ZJMFpXbmtk?=
 =?utf-8?B?bmZwYlhtOVhJaTQ0ZkYyRzdHWVNCQlZYRFhJT2h6K0FCQStKekZIRDNSVDcz?=
 =?utf-8?B?cktrUHl2TzZtZ1I5RVd3TytXQlIwKzRZUW5NeGExM0owMFd3akh0RUJaVnZO?=
 =?utf-8?B?OVp4YkZGWnNobmFxZ0t3VTNrRThLUUQzUkYvRE96ODZyR1p4WUYyY1lGLzZJ?=
 =?utf-8?B?KzhQTjJNWE9FUHBha0tWUVFsT0lETS9KY202RlRwS3F3cC9sZ0Q1Q2MzUko1?=
 =?utf-8?B?KzU2cm1PM2wyeDBlRVI5OVdvR1pyWjFBc1JOSGRUYVkyKy9nV3NNV3A3aCt2?=
 =?utf-8?B?cmhzeXRVWTNTVlg4THEwTFo3d1dIai9KS1VxRTdZdlBrRUdDVjRlWS96TDE4?=
 =?utf-8?B?Z1I4WEsxVm45YkpQTUJka0FOQXV6Yks5SmJ1cEU5MjFjK1BBdWdocmVWOThX?=
 =?utf-8?B?UVJUcEcxaDRaOTFuTFR0djNYemNQNXh2Z0Y5dng1b3ZIeGp3eThrbnZzeStw?=
 =?utf-8?B?cXc4blVZeG93eHFra2VpclN4VGxpdUgxSTdkaGkzY2xzdmFJTm50QlpzME80?=
 =?utf-8?B?Z0dqRWpudm0zMUp4dmFUVm5ybVVMSlRjbW8yMlB1TEszODJnVVhTR2FlRll4?=
 =?utf-8?Q?D7iduid4maQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0SPRMB0001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NExpQ0dUTHJ5WVphQUdBL3JMdU5sTWlrbEdSMTZOajgvRHJidWZvY0hnQkZm?=
 =?utf-8?B?WDc5c3owbUppSGQzWkVVS3RncVdySTN5QXpkYSs2ekhscUYya1h1WjBSMkdn?=
 =?utf-8?B?Z1RKZGtDNXVoaEo5aFdkQW5DcE1YSm5aUmNoeCsraWFHb1JVTStacGJ4SXNi?=
 =?utf-8?B?MzZ3QlN1bTF6VEI1VjFVTEFZbEpzYzM0VGNyN0tzSVQvU3dDSkl0d1h4VDBt?=
 =?utf-8?B?M29GeW5qUkVIWGNBdUdFNlczYmV3UEVCSnNRcDJWdzIrQWVhSUc0ZG1uSDlN?=
 =?utf-8?B?cnlMOWZhUElPeTFZWnpMc09Ib214RGlvTlBDam51QmxPeXdBVHVDWkpzeTk3?=
 =?utf-8?B?NlhIcnRYSG1jSlNNdTNpVlpiSWxzWVEwQTRjcVVsMmdRUlRRQmNaeVFxL3d1?=
 =?utf-8?B?QzkycGRTZFRnd0tmejViRmsvWWpoelhJT2YwL0JZallXcjQxaDdYLzhnS2lH?=
 =?utf-8?B?Q2VtZXVuaU11VituSExqT1RQM2pDU3FGY21vY1RHckVXYStMK2wydW5uRG0w?=
 =?utf-8?B?dEYyVFEraWlWRUN2cnMvY0h5Qk84SFpzOHhMQUdHNUhRNUs1KzBkcHBuVUVk?=
 =?utf-8?B?RFFBZU9EWUxsVTExQWZpZkorblQyVFFTWHc1RWd0akQvaXFEOXZZemMxY0VR?=
 =?utf-8?B?a0dRNHh2bklCS3NMT2pWb2ZTaWZTY1ZTWmtXdzNLeXN0cnRDMTY5TUszNHJJ?=
 =?utf-8?B?OUhUdG5oZDhyNXUrTlIwak04QUVNSnRhcFRFWjRQeEtueTlLU1I2MEw2eTFq?=
 =?utf-8?B?OTdBUUk4dlR4M1EyZXBTSE1SRm53VGZtYjh2SVNtbUtUczdkeXd6NE5QTThU?=
 =?utf-8?B?TlhaRFY2R3RzRy8xczVCcmRCU05ENXpPb3FCcGdvYnIxS0h4TjlLeG5MQVdQ?=
 =?utf-8?B?dSt0SDBsc25Pd1pRUlRsRlJBemdUK0pwSXlLZjliVm1WY1hJNWNaQ1BaTkRE?=
 =?utf-8?B?d3YzV0huRS9lUlAzZVFYZDMxM2QxbFY3eUtDb2o4YTJHNU10VHFlaUJVOUU2?=
 =?utf-8?B?TnJKbkk2bkVuVEFuaU5EcnFNbDI0TXI1cVBvS0h4S2p3K0NvQU03ZTFUTHNp?=
 =?utf-8?B?MG9OU2JvSGx6OEJaV1NJNXFsdjdTMytvNGRBajhsSHY0S09EeVVOVlYyRFBq?=
 =?utf-8?B?Yy9nQ1hpWDEwbXloK3JLbTdzMmZEKyt4YUlieVF4Sm5QdTJpQTBiOCszdGtD?=
 =?utf-8?B?WjVkZW1nZXEwRmdVV2FJckErdUFXVEh5b0doWkdsTXAreWUyeTFSbnFhRlFr?=
 =?utf-8?B?cnlhVUFaTm93ZUVhajNEWkVaMWl5WGp1SFlvRm9HWHFrdUFGQWRnRzV6SHJS?=
 =?utf-8?B?dGlybXRiSk5yMS9iL0Y0SUV4S0JJTzNSSjcxSmc4Y3ltd1ZnV3M2U3ErTVpm?=
 =?utf-8?B?UnErZTM3TlhJZmlkYXBJdXB2aCt5bFY3UFFoR3IxWG1rSEc1a0wwN0orSTVX?=
 =?utf-8?B?Znp4eHo3T2Qya1YxTFBqTE1sdWhSb0VFeWc0and5dXBuckZ0WXd0MGdGSkpT?=
 =?utf-8?B?d2lHUWtJT2ZReGJ0c2FHVXAxcy9veHM5SExkRlo4cy8vdzVOVDlldk9Majk2?=
 =?utf-8?B?QUhST1NKS2lMbkIzcFJVK29jSUYwVXlFNVlWUlBFMHQrbldJN3pmazg3VHlj?=
 =?utf-8?B?bGZOZHZhUm5ISmExY01EOE5aVTlkbmlXaGl2aG5kSGo2S1FtbzlpSXVzU1ll?=
 =?utf-8?B?cGcxSk9yWGNMZjJMOTRUSkNjY1ZyZjdhdlJnRmxFbjRaL0FubmlSQy9TWFpu?=
 =?utf-8?B?dCt3aVJhUmp6Y2N4TnpRdHlyUkpUS01nN3E2YU9OazlSNUkvaGFaOW1MOWZM?=
 =?utf-8?B?L1Z1ajc5ZGU4V1hERXdMMVh6Zy8xWnRRZHdpaGJNcW81L1BFMXl3TDB4MlVu?=
 =?utf-8?B?ckk1WmtDZnFUNEtnVGF4eHh1THE4TVRGTEREZHBoRHBoVGhkaXpaMTA4K3F6?=
 =?utf-8?B?UVNGOEV2RXBzdHZDOWxyTFkwY09vVVY4aGwzak1iT0JPVCttam5vMVBRTy9r?=
 =?utf-8?B?SkNMYVVFWWVOMG11aU5UNFpDU0tRb3JIK1ozYjVrRDRiN0Npc2lJa2tyb084?=
 =?utf-8?B?T2F1YmdSMDRwanU3SUNEME1uL0NueUp4bFpMWTNLcW1sNm9LK1pUdm1HY28r?=
 =?utf-8?B?eDlBSldVak9rejdkQ0JFZ2puMnc5cVRxYmpiQTg2MTZLU0FTVFV1ZXZzRVdH?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2fe914-27a8-41e3-dd37-08dde0d36d2c
X-MS-Exchange-CrossTenant-AuthSource: DS0SPRMB0001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:54:43.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsYI5IwyuSd2D6yCoz5TBdUDRS1uyIbLDjmFD7eR3x/Knai1N5smtGz+VDWVZDOmSdu6/DXzx8+8u3LHjGPt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

On 8/21/25 3:52 AM, Danilo Krummrich wrote:
> On Thu Aug 21, 2025 at 6:42 AM CEST, John Hubbard wrote:
>> NovaCore has so far been too imprecise about figuring out if .probe()
>> has found a supported PCI PF (Physical Function). By that I mean:
>> .probe() sets up BAR0 (which involves a lot of very careful devres and
>> Device<Bound> details behind the scenes). And then if it is dealing with
>> a non-supported device such as the .1 audio PF on many GPUs, it fails
>> out due to an unexpected BAR0 size. We have been fortunate that the BAR0
>> sizes are different.
>>
>> Really, we should be filtering on PCI class ID instead. These days I
>> think we can confidently pick out Nova's supported PF's via PCI class
>> ID. And if not, then we'll revisit.
>>
>> The approach here is to filter on "Display VGA" or "Display 3D", which
>> is how PCI class IDs express "this is a modern GPU's PF".
>>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Elle Rhumsaa <elle@weathered-steel.dev>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   drivers/gpu/nova-core/driver.rs | 33 ++++++++++++++++++++++++++++-----
>>   rust/kernel/pci.rs              | 21 +++++++++++++++++++++
> 
> Can you please split this one up in two patches?

Sure.

> 
>>   2 files changed, 49 insertions(+), 5 deletions(-)

thanks,
-- 
John Hubbard


