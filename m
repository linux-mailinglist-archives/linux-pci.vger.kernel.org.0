Return-Path: <linux-pci+bounces-37375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D72FBB2001
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 00:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDCB1C0EB1
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 22:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89142D77EA;
	Wed,  1 Oct 2025 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sCggfCvQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCD2749D7;
	Wed,  1 Oct 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358155; cv=fail; b=qHua2Nj9z7QU7mlhEmPOLwcW1qEU4FpqtSQKw8uBAfwKbLRpkr8/WHunOTIzlFLWD8cOxlBxyLWt5Oti47C80CXKxSDm939TgS0cD6DiQqZMcS04V+bYUTvSHEcBDp+WNdbkPjyeZdasDin59e4zP8TOvxVWuoq2vg/FXMuraDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358155; c=relaxed/simple;
	bh=jTfTstgPIJ4iGZzhcElmeP+7LqPANzNXgTFvWDPOSJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LVbIK4/e1o4mhrSic7vFq+co9qFqMW8cvRx4pMaTkfTYJMdw0dkHLVmL6Moin/LpJ5rxUbBa2MnNMFcjYPeT/BbOf9VCrcR7U7aALjNMCbpt0o1mur2b1z/HCGTATmYp5P1UQcGRNU/NTf7BmLnv6RSRWytp+8ELeakDOnDy/uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sCggfCvQ; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tclnu0j8ALARMWQjgFwvK5Tz1DbkpVp5eJJ2LX3Et64C1YXK44yAZNTsiaW1knBaJz74ySDEc2s2Rag3VpkVo5DCe/t/gRP7o/TWfv7MJVe/kWgkuIOaPlEhlk1hVRAwco1w6BsDiKx9mnJfXtzF0Rg8Bp0nZ6wPd7A47148I5zZbk6QmSdrVxsyXCW6mASP190zrAylQ+rCJ0A4QEAXG62Ua0op50XAXUVBW0MD66fTDhd4wQJejyW6wWrD16J6gLuJ/uXzDjS0k1algMHBz/FVKIoxfdkRUtSFxX5jeb0fz4fzZoEK/X8bx7hOqoYShg73NysIxzviShWec4KmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG5JXN18FugtaVlbN6BLbHFSLqTI1bjZOb2v5hU7siI=;
 b=Ri6ZkrXa6tGdS+CcKba68MjuNJZGl6sT4xNIx2X2UwZUZslwRzNNrK2MM3O1INkJFStwlg1lT1ajlohneGPouIF1rB8cLD2Agxdaf6QqoVHFlZwCtHUpGG7ay82YTJogKRi8aaSvb60bMMXKt651xVj0eIbOYxiKmsC0Bby1CM20VGYy2B4W3O/ADoQdqWvrkRricFNYHcJUr7Oga5bjLsdDn+PqsMzLtywC2hTWD1cCmO2obVuEvqmkQcWmJ20rFPbl0LlSDPugSrM/1th2KLOKElgoyhtl02zAepGCHGg71UdgoRB9D3oquM5Dt4hOkXTPPwCsTeyQJCAOh0VOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG5JXN18FugtaVlbN6BLbHFSLqTI1bjZOb2v5hU7siI=;
 b=sCggfCvQlEmuyPEQJBpteM81ioXXXL3fVjMBtWLmRORCIJpd5F5ucjZPXKRkyoNr8ZLjuMvrbRcpVqGKhE4b6fAce6TZt5wEtby+/Y8GIH7Dt4hdyK60N8IU0z5EaN4S+IRtq+LoSq+9PsfeFIDixT4nBlCac73ThUrE5WLiuzY1gDixcl7U6SCHOgRsBvsMYv9N2zjNiYSPMzznUISut7yWdNW0EYG4o2A+TQTE389CNcfkRqntl2ICLlyWuWUR0tXhbw1sz1MmmXy5+OpqeneyNrefxcYnPHKIxIBKkPHreQXbEDR52KF6MrjvWlXaqkUSDH5lMg2Wl9fAFMjq7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 1 Oct
 2025 22:35:50 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:35:49 +0000
Message-ID: <ac350595-665f-46a1-aca5-167c5648337c@nvidia.com>
Date: Wed, 1 Oct 2025 15:35:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <20251001144629.GA3024065@nvidia.com>
 <20251001121631.7f2e68f5.alex.williamson@redhat.com>
 <20251001183030.GA3195801@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20251001183030.GA3195801@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 444894f3-df34-4d6d-7aa2-08de013adf0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekdDdGxFL3JwbFVLTk5oemlTM1BtdVJ3QXFFZ0pPU1dQbTlNOFFPYzlidmhs?=
 =?utf-8?B?TEU4NFg4eVNNSEZDKzNBZnpYZUNNMjJtM1FYUWJEVnBhL1pDdDU4TkJiT09x?=
 =?utf-8?B?OWlxZkNrWm1ZUGN4WEZMOHVuTElsNU9La2hubGJmWDBHdWpxOXc4U2NMMlRV?=
 =?utf-8?B?dnBaK1NEemthR2Ezam5UelJ0cFRhaDhsTzM4L2dNZGN3VE1iMzE4emF2TDRU?=
 =?utf-8?B?R3RzNmxKei9NaHZaSjJiUGxTZi9VWGN6bmhhc0ZMYSt0RCt6cW9DRExiOWFa?=
 =?utf-8?B?aC9XZ2dsSHZSWjJyOXhZZElBbkZRd3lWSklZMWZUelQ1eEs5SDg3TWZ6dTZV?=
 =?utf-8?B?Z3FqSC9sT3VOMm9OSERxRnRFM3p4dUNiNFhNbmplMmJWOTZxZDRTWDYvVTk1?=
 =?utf-8?B?SjNKVUdmVVBIbWFHNHZMNnZkVkFlcG43RmZhOG0xYXMyNnQ3NVQ4NTFncjJB?=
 =?utf-8?B?T1EwdGRGL3FpZm5SRWJDM1doTWpFbXhqQXdZR0t0TXJ6UWJZNlVtSC9wNW5n?=
 =?utf-8?B?Rk9qMlcxaXg0akNic2NHOW5OUC9kRGF4S1FCeHdSWTFqRmJKZ0xLTCtyQzRY?=
 =?utf-8?B?SWZBSmJRUkJsTXVNSGs5dE0yYXJxLzFZcG5BbEpHcGdYYU1HK0I0OEtsVXRn?=
 =?utf-8?B?d0pzRDQzR3F5cjNva1FJdExpQXdEYzhqdno5ZU5jWldmR3VrWkU2b1MyWStW?=
 =?utf-8?B?dFZpOCtGc0FCc0JkVXFqRkdVTS9qdXQrbWVYeHMyVWxzNVVwRkJaOVRXZnM4?=
 =?utf-8?B?RGN0NWxscUFXaE9tbDEvQ3N1VmdMdUR4Q2ZpNVhXRDNXbVA4UWFhT0hPOVdn?=
 =?utf-8?B?N0VGMk0zdGoyQnRLeTJCOFpHYnZFYzRoVzUvZ3VzdTVjK1BrcjduQkc2THlV?=
 =?utf-8?B?bjFNNkpmZ2VmUUt2YkE4V0lYWDdCQlJJZUtpTlRIWWJPbWxvcUtoZjNDMEpT?=
 =?utf-8?B?VVR0S09mcXJMYi9Sb21uSTNCRzdCWmdzbGtLcGtrdUR6bFBPbXA3NXdVelRn?=
 =?utf-8?B?WmFjb3EyQjhLTXphYnlHWmF5NVY0L2t3THhQOC9HTjhzd3pCcE5NenFqTXpi?=
 =?utf-8?B?dFVlOFRBRFdLYTNFSFBKUHB4eW9XbHNkZVI1SDhFdEtlL3YxL254OEtYbHpt?=
 =?utf-8?B?cDJ1bnRFeEpkb0tQNWNlRXlYTUZZcVlEQ1pZTEVsQ041TmZscUphUHJEVDhz?=
 =?utf-8?B?TTFoend0Uk9ZSTZrMXVwTU05SzdOalh6elp0bmo2Qmh0WWFsem1zRTcvWng5?=
 =?utf-8?B?WkJFdmZZM1ZsREFvZEIzK2hpVDQ5N2ZNMnAxV3J6SnJhRGw4Y1M3bkkxLzNJ?=
 =?utf-8?B?MjkxUDlic0h1NVh4TURpRFVHQmV3WXJvaW92ajNlbitVdVVWNDE4RE1NNmVv?=
 =?utf-8?B?RXRIZGxzazBBU0FQeW5DdVc4K2tzcVVZcFF4VlNYamt1Vk5JeU5IdGRJVjcw?=
 =?utf-8?B?WVNpS1ltcWJ3WENSWVU3djBWVTFvT1NNREtwbktKWDJUMC9Ud0dpZ0UyRDZl?=
 =?utf-8?B?SzF4OTR4RjlnUVVkOXkvdnBwRnp3NW5Na1J3MmJZTk5pbzFvaHRob3FwZ3Ey?=
 =?utf-8?B?dHdHMlFCNGhJMTVRbDdQd1BhTmQ5Wnp1K0tyQ3NJMzJtS1kxSHdWcXFtMHlk?=
 =?utf-8?B?Z21Zbk40bFhobm5TOTdaSjJGaU1QK2VKcUE1eGNBWGpIREUyU2JMMDJsc0NP?=
 =?utf-8?B?ZUQ5UDkzdDlXaWRJbkh0bzZNeFc3VXliT0pKV2I5T2hLQkxQZmVxK2tuMVFW?=
 =?utf-8?B?bnlpcHNMQ3dnaVY0MVdzWEljTUVQZEFJNVpkZ2xrVGl6YmJmSW5sRG04eUxa?=
 =?utf-8?B?R2hiZnJwQnBjZ0xucml5OVJzZDEzV1NJRTNDaGpIUGUrcVo0OWJGTGdaSGh1?=
 =?utf-8?B?MG53Z3V4RCtEekdHZmZaR3RLZ3RucWhrdXZzY0VJRXNtcy9xeXFUa1RiVnpE?=
 =?utf-8?Q?tVezdtaH67rWu6qm36p4CLztebwJJRlm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejF1cjZmcjNxUGlHMEppL21odVRXVjdSYlVhdW9jeElrTHRuT1ZPSlhSM0d3?=
 =?utf-8?B?WHJ2dVJ6TzhGNlJiUDAzY1NtdS9DRVJGUDlieFQ5NnpCQlYwTVhRdTE1Z3lG?=
 =?utf-8?B?TTB4OUI1OHpVN2t6QU00dDVZaVVVTFdRWHE1anRXTjhITFJHaG5uRGdOOUdR?=
 =?utf-8?B?ekliaGlnSk5FdlA5L3NESWxNaW9PWWx4cCthY1lKTHBOUVhmK2R4Ukh5cWlj?=
 =?utf-8?B?VkROQWVmOGVyU3hpdGhMV1Nydm5KUnFqa2NTQjlwU3hLTUJHbndKK1RwWG9T?=
 =?utf-8?B?K0gvM0NxRnZnYzB5YlhvYUpmcWgwaWJ4YkpEZmN2TWUyYjViaFJzNGNYdnpE?=
 =?utf-8?B?M2p4cnpKR2Q3SFVUcmp3TFFiN0FxRE8ycG5vdDFwdnR6aTMyN3hhVjRiZE41?=
 =?utf-8?B?c3NQRHh6WmdlbG40NlgwZy95bDEybUhrRFd1RjJISEpoMno1bXpORDR2T0Nt?=
 =?utf-8?B?MjVqbjllY0Y0djI2M3VibTNjYXNvaFc2bjB1Skx0Z05wdHI3ZlVpZ3ZFWFRZ?=
 =?utf-8?B?dWJxcG5lL0xLNGVXVENCR2xYYUdSckpPRVdPTmFLK0JaWkZFQnFMdWNWczlN?=
 =?utf-8?B?amI4Y0VKbkU3NWtEWFBNYXBLN1puOEY2bUdmU0lmV2lpZnkxWTJEZ2ZzenN4?=
 =?utf-8?B?OXd0dytSWk53YTFhZUJPYWVHUzcxdURDZnpGVklYN1V2ODJCMlo3Z25FdFhH?=
 =?utf-8?B?OFhuYXpKZy95cE1odU1sdXBMREdVWkdWTFpXYjZ1dUVURkh0ZGpHSXRxSnV5?=
 =?utf-8?B?QnBOMzYrWEZyOEJoYjJNUUtrVGtlaEI2c0RJU0dUTzkzdWNGZVIvUzc2Sk04?=
 =?utf-8?B?SG14Zk91SUtxV3VUWjYycFkyZEMzYmU5MkpzV0JUZmFzU1lFZ1pZRGI1MkNi?=
 =?utf-8?B?eWJxZ3FiQjhyMDJmZU1YZC9tZlhIMTR1akgzVTZVMEZzTFVpZ3pqMUlJc3JN?=
 =?utf-8?B?N3ZRKzRSbFNYNmM2U0QyNEZjRmV1UTUxV29vQ2s5TnFhQzgrYVZhc3VWa2lp?=
 =?utf-8?B?WVJEQktpR0E5WUgyeGR3YTEvUk0vaXViaHJZZmVldHcwa1FSMXNCYzBaS0pT?=
 =?utf-8?B?dnlrUHBMdFNQRFJ2Q2xoV3c3WWVPV3FsZThzNXV2OGtsMzlpTkpZY0E4bllt?=
 =?utf-8?B?anJLTU1xUXM2cWRPYUxzeTkvVDhxQldRTWtYVUw2L01uZysraUkzdTJXeGFY?=
 =?utf-8?B?U1JrZU8wVC9uUTRiM0ZNOXFqTUdkU2tHVWd1N3hxR2ExSElPeitrYjZrYXhU?=
 =?utf-8?B?cHB5aDZlRjVXK1NRbzh2QWFIOFRUR3ZUajBQd1lNNG8vY3Y0c1VtS3ZBNzdR?=
 =?utf-8?B?SzViSnk0elNJdlpxRVVMcmUyOXRQSEpCMWRaUURjUnZLckxOdGN0dEhZUURQ?=
 =?utf-8?B?c1RST3oxVHRqTmh6SVQ5SmpHWXYwSVVLcURPQU9jZE1kd2RYTDFybFd2clZa?=
 =?utf-8?B?cUdTdC9uNGFzaUhsdEszaGhybHh2OExPMTdEV21IZW9kRXJ2MFlEOXBUbEsx?=
 =?utf-8?B?Mm83alRyZm16dzd4WHNwLzdPNXprTGpQV1dOTDFhMCtlMnBuSThBcy9zTVlO?=
 =?utf-8?B?M2p6SHgvcllTMG04ZGtUK1RCWVc1TnI2ZjhtV0I1UFE0ZUlCeC9sSTBHR0lE?=
 =?utf-8?B?M1pmRE4rV1NOc2h5WDMzdnFlTmV0Y3B4cG0ranEvaHIwVko3eGlaWnBLdE53?=
 =?utf-8?B?ZVJPTlJjZ0xuZlByL0dQZS9sM0tDMiswdUdSd1Qybld1eFNoRkZzVWMzT3Q4?=
 =?utf-8?B?NlErRm03NjlxZkMwMXFES3JwcTRnYnpYazhsZlg4bTdlcUxmUW9LSUJVcG9E?=
 =?utf-8?B?V09UWDhEVU43eVFxQ21rTU83bnBUeVlia0lDb0hqdVZVY29vQTlEcGw1ZEM5?=
 =?utf-8?B?cVRxcDRsVHdEcjZ5MnRaNTJlejFYZndWUGRMLzdGdU1jREJtcUFOeC80UTIz?=
 =?utf-8?B?aC9Hb3E3NzFMNUllTDVlM0RKWnhvZGx0K2lYV3VhTmVqWkdtSzRRTEd3cVdO?=
 =?utf-8?B?WWZuUGRGTkJoQnpBQlpCNDBSdXpWWitPOFZBNlJ3MzJQT0gxNjhDWHk5OUli?=
 =?utf-8?B?YlhRblVwbWg2L0l6NERzdmRFNWFpUGtqbFR1V3N6WUtsSkhEREdBYXNnc2lL?=
 =?utf-8?Q?/dTmHQj76aM8a2fkDQtR9tBRB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444894f3-df34-4d6d-7aa2-08de013adf0b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:35:49.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwrwGxknBDQs88+vXBkUf2/jQNb41yzD8hDEvFcpBK57fEd0qCobZA5eZlhJozFIkRJlK/TSJeI9IEOYTphIzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

On 10/1/25 11:30 AM, Jason Gunthorpe wrote:
> On Wed, Oct 01, 2025 at 12:16:31PM -0600, Alex Williamson wrote:
>> I think the question would be whether a "bare" VF really provides a
>> useful device for nova-core to bind to or if we're just picking it
>> up
> 
> It really should work, actual linux containers are my goto reason for
> people wanting to use VF's without a virtualization layer.

This is a solid use case, even though we don't yet have it for GPUs.

> 
>> fair bit of software emulation/virtualization in the host vGPU driver to
>> turn the VF into something that can work like a PF in the VM and I
>> don't know that we can require nova-core to make use of a VF without
>> that emulation/virtualization layer.  For example, aren't VRAM
>> allocations for a VF done as part of profiling the VF through the vGPU
>> host driver? 
> 
> The VF profiling should be designed to work without VFIO.

So we'll need to add some support to nova-core, in order for that to
happen. It's not there yet, of course.

> 
> It is was one thing to have the VFIO variant driver profile mediated
> devices that only it can create, but now that it is a generic VF
> without mediation it doesn't make sense anymore.
> 
> The question is how much mediation does the variant driver insert
> between the VM and the VF, and from what I can see that is mostly
> limited to config space..
> 
> IOW, I would expect nova-core on the PF has a way to profile and
> activate the VF to a usable state and then nova-core can run either
> through a vm or directly on the VF.
> 
> At least this is how all the NIC drivers have their SRIOV support
> designed today.
> 

OK, so I really like this design direction, and we can go in that 
direction.

However, I'd like to start with this tiny patchset first, because:

a) It's only one "if" statement to delete, when we decide to start
letting nova-core support VFs directly.

b) This series simplifies handling of VFs for the first use case,
which is vGPU running on VFIO.


thanks,
-- 
John Hubbard


