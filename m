Return-Path: <linux-pci+bounces-36917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC3B9D0AF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 03:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402511B25D6D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB82D24B3;
	Thu, 25 Sep 2025 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxMe1K2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D6E55A;
	Thu, 25 Sep 2025 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764346; cv=fail; b=IitZ4e6JCZAa3RidNCwixfasP4d3BImNu1ACFbFY0pHG5eaI/hO7NlERScaDB6T6+B7xYft5As1AK+FU0hH7zadrwGNZFJfQdBOO1/YZuJrAyD9j1QsKn47rRY1CDoA1dV2KLIorO5VibpvpPK04HPDDQ+wXW+kvTGldV01w48U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764346; c=relaxed/simple;
	bh=fCSSmDoZGQuGr/zTyNMx8tA/gH3yO2wQcAjtXtOWQnI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ULEfPER7OvCjiPjEJSMofHMAHsHaIJj6UFatT3+2pe2oj5TDDN+muWp5azFwAtLjc2A5zG9WkVqhXJAo47luMQbtdktdkGavCDpYTEfJWE+K3RvCrCcU52V9uWyjLuwVU1ahkB9B45aGCFtb12WgnCRRz6R2G7n85CKdhk+j2bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxMe1K2e; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwdfhCTJR4GNvwv+0stSIkY0Y+4oRudQBC43EFJBDKGEjZ1MaLtrba4Gp1Vx5g0D2koK6/ga6imnuahQF/FTxVfu2JApuBaG/n1jxcCQOqScLzjQe9oa9zSzeNrg+lsX6vSL1klI4Goy9iCQlnBugNIDfunOMfS+6SYcenGzdGx/EJ2j6h4MlV0dUHSo0VciyBzS0eb8ZBXdDgkHxr5fuAz8fEP5UE6Kr/H7Gez0+pem99wHPX4gTca5F7gAlrfnTJXhGJJDz4JDIjucaxiqZvYwMjy/InTHfpMefZMVrSGo2KqM1KPpIPwdNcIijSaVmRMqau/4ct8gBNvLk0Bprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umJ6j//XXlmncV8yIUu/SMJAkuMKMQYgckX+105Wl9k=;
 b=FKQLL7rcYfcwmKyg9I72J86fkdGNiNyiSrjGLH1oQvvyueJz4J0FoO18eGpLJ6H5mpzCUHZ/lBPI4+TuLzHsgFuXy38r2pmFlCtmPdP6t6fO6Du6eLIJlZ2+7Y3krBYATmfi8Xm8BCfW7xs7xtzJACgDIQs0Q6BiO49It08MIa9CUA8ktG0FKMJmsRUNdcw0RD4YC9bL2HOkMDX4iItk8mID7lI5irHrp2M8qWWoVLv5OUNnEsOM4n2Vrj/gjFLT2M6xpWrx336feuvYB0qaZ9p4RsNh8Zjvf3eVzFYCgSLVnJGezhXyFQffrn+ki96KnxLTSLVM8ftaXjxT+X/22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umJ6j//XXlmncV8yIUu/SMJAkuMKMQYgckX+105Wl9k=;
 b=kxMe1K2eGrdBBeFI4VbKGVT9UiR5D5v3hwveWc/CJpv97BqP52nRk2MJb9wG9wGTt1osWv3c3et0OXx43CW3BS3NF2/oEchue0OJ8cm/3m6GdvCrU8oUdnwX154mezn3ERg5sZrT2Zck+7xxpH+WKLKYPQ5hINx+j8HD3e+y5ES52UQ7tTOJPc+slBka23d7CPtS9FA9hMn6YRMQO5ZAKacmDwGJz1ZaOSZ8B5QlX34i7rLAF8/Fe+Fj1RS1j9zbjaadyqIy/FkhccOEqkhf6K0YaHIfOVUTR8UQPqrOxG/c7vPknsRBW8XAk6wxBNDgHcyuGa2SONBLzL7PCyD+5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 01:39:00 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 01:39:00 +0000
Message-ID: <02809090-539e-433f-a13b-14bd17bafe54@nvidia.com>
Date: Wed, 24 Sep 2025 18:38:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: pci: display symbolic PCI vendor names
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
References: <20250925013359.414526-1-jhubbard@nvidia.com>
 <20250925013359.414526-3-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250925013359.414526-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:a03:333::34) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e35f72-08b8-40b3-e7ff-08ddfbd44d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzV2MERFYmZ6dVJMcFlDdFloK3JxeXk2cDhmUlVGTnErenRyZ2dRV3JTbEoy?=
 =?utf-8?B?eFBEeXZST1JiWkRwd1lVUyt5ZmZsSTVPR2UrQWZVMWxIVmJjWi9vZUwrWnU4?=
 =?utf-8?B?cVg0cjE5WkJJSDFZMWVSTHpqenUyTXVZWFl0NCtkUDJKOVBPY3BWc1d4ZHlt?=
 =?utf-8?B?RWU1NnZxQ3dCekFuNXRtYStvZm5uUEZ2ZTBHdmhyZnIxYW1WeERNalJqK2h0?=
 =?utf-8?B?b1ZuQUJ3NnZlZE40R1IrQjRNTlJtUHluQVR6eUFDRDZocTB0Nm85eFI4S2Mw?=
 =?utf-8?B?R2VEQVpFVk9wSFZ3TFJmUVJ1Vjd5Y0hiZkd6OEp4N3BBRURuTEQvbW9ieFpH?=
 =?utf-8?B?YTBIdGFyNkRheGMzcS9Ydk5GSDBLVmF2bkkzVlNNTDZaYyt5S21pejY4Zk1v?=
 =?utf-8?B?ZVZXZFFXVTZ1SVUwbHVpc2d6dThZRWpTVnF4STRYL1J2RWlHNVJHNG1CY2hh?=
 =?utf-8?B?Zm9IZFp6aUx2SVpTa2hkcVBsVkFTMW9HRVFtSURuUXhWQXFsOW9FUWlZdkY5?=
 =?utf-8?B?NGdEODdEb3NmNnRqWE51RCtZcUpmekxIVGNXdmpzNkNMK0tEVWdmcW52Si9K?=
 =?utf-8?B?dDlBTk4wcjF5YUpYRklMekhtM3NEVVdkcFhCV3VjN01sUWxiT2F3MktscGY0?=
 =?utf-8?B?ZVJCWnNwYUp0akk3cmovb2R2QUZhbVk2MWxKL2hodFp5K1BBdXVsSVl4MGtu?=
 =?utf-8?B?ZlRNQkh0b2tBMUhEdmV1NXl3ZU1PSk5meUo3WFVsY3BEemNaei9TOXFFN0Yx?=
 =?utf-8?B?NHhiT2hsQUVWWUU4dk9uZEIra0RkMlVQODFaL044MVo2ZzBBMEFpMkE4WXJR?=
 =?utf-8?B?YmNrVE9DZ1BWd3plSmZPdXhoMlVaT2srYTlybjlOTCt3MXZWN2ZJTWplTDM0?=
 =?utf-8?B?SXdaY3hYU2NwQlJUSU5YUTIvdmQwTThUdDRSaGJVM294SWpPWjZNY1NyVVRX?=
 =?utf-8?B?ZFFXNGtFRytWZTBTTEZRMGhXcStHQTlMT2cwSTFvZDFaTm80VlFPV1VCOHN2?=
 =?utf-8?B?TXVXWDZ5a1pkWXkzbDFldXVYZ0xkdEtDM3V4ZjU5MVhpQVgzZG1jOWZWbGl3?=
 =?utf-8?B?STVTY2dWT2k3czJSc2hkM0YvUXIremhMekRMai9Bc2hJWmYwdGJJeTFRNHgr?=
 =?utf-8?B?ZHlKZmZnZk9EL2UyRlpsLzJmQmtRa2pveWJZc3dYVExBN1VHb2dzNDhvc21P?=
 =?utf-8?B?bUtLUGl0QWxrOTZtWHF6UUlNdmVxZzcxYTY2UkYwdWY0UGFNeTFvR3ZkV3V0?=
 =?utf-8?B?NUk4WS9yTG1mdG9LeU1YelhWWXVjU25QdmdFSG9OMTMzcmplY0pRcmJQRnMv?=
 =?utf-8?B?a3NpQTRsbVlwUFNzOXI1WGRCdGRzWktvaEE3aFBHWjYrYVRYYk5tNUdXV2FH?=
 =?utf-8?B?ejBLY0ZwVDk0bDJWR3EwZVQrSHFlaGRkZk9pOVpkdGcydHJZYXBLK3AwdkN5?=
 =?utf-8?B?Nk1mU3l5cTkwUkE0SGs0YVhrd3liRm1icmhIdEVIbEVWTEVNWm5qdURPZDhY?=
 =?utf-8?B?UnBTNzg0eWZxMU84YU9DNDNuQ3hlVWIxaHdzc1pseFhBeURkM1BuTEdlMUI1?=
 =?utf-8?B?cDZtTldEOWhydzNDSDIrcUk1NGlwZlQ4a0hDa0pHR3FUajB2TzJjZEdWcEIz?=
 =?utf-8?B?K2ZuWkxlK1RrNUhlK1U0bksvZW1JWUJwd2xqbENlelAwSFV3dCtCcjZRaUk1?=
 =?utf-8?B?TDVkRnRMUWU0K3lLK3BYMVN4YTd4QUg5YzBRSUtNSXUwdTJoOFhqYnZzTUhr?=
 =?utf-8?B?eklKVExmU3FvOENFOUQwQXgxSW9LQTdaZ0V0aER3MC9xQzhHMzZSSnBFbm5V?=
 =?utf-8?B?SFFzTFZHNWxhYVJDd3JmYWNKTzUyU2x4dGVWd25HNlI1dngxMkxpSzZiNmZj?=
 =?utf-8?B?VjdSbm5zNHRlM3hpNmdrVE0wVThSWWxkMFZCTi9Za3VBVXUvdml0WkhjUDVh?=
 =?utf-8?Q?/sSGkaMVECW2gHYGKvyQomGVmqrmnRDu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnRlNFVrS0V1WjJOQWVBaVpWa0Z1TUV0UElYTWJyTmc0U2FTMTJtK090aGV5?=
 =?utf-8?B?U2ZJWE9FVlZzM1EzeG9MTE5qaGJ1RjdVbHJmcWZIUGFmY2hNQjVNbkJhb0RS?=
 =?utf-8?B?YmNVQUFWUWpWQ1UzRFJjU1BoekJPV3VJcnljK0FuQnhWSjE2VkpsaW9KUzQz?=
 =?utf-8?B?VlRGZFBQaVU5M0oycUYwczZIcW43cUtvaU13Y2t6NjJrRGs0UFhBR1NFcWpi?=
 =?utf-8?B?YTBic2dOYktUbjRadG1IaFBKTmtRL2VmUTZ6NmdQM1p6WkFSMUZPc281cHNw?=
 =?utf-8?B?TjJQb0NFVWozK2ZBZko4LzFoeG4rQ3R5MGZvQkVhSGw4WG52b2N1bng0anl1?=
 =?utf-8?B?T3llek4vdWJKdm85RXdySnlNZlB0SXoxWkVUaS9hZEk4ZVFIK1hkT3pyWGp4?=
 =?utf-8?B?ZGF0UUZkS3I0UXVVSVZYYVZvWGphY0VZM0s2RGlCaUxXWHFJMEhpeFhmY2tp?=
 =?utf-8?B?elpSdUx1RTRtRHl1STZKN0JOWGhwOTFBYmNIeFdLNjlsRDZBemx5QkVLOEdq?=
 =?utf-8?B?eFlCZWFXbVdaZlFaTEZta0s0aFpzVlA5VXlSVis1enZ2b1dmSHV5eko4OFFH?=
 =?utf-8?B?S1RwRmdBTTdXa2hnUmNXQXUvM3FUcC8xUkExSXBMeGE1RnFFeENobmN3MlJo?=
 =?utf-8?B?TmNFd3BrOGc5MldIVDgyZlYyNUU1M09RckFYN1BrZWU0UHU3TTVHcnRtOXU4?=
 =?utf-8?B?S1E2RVd3SnhUMktYMHdEWFB6aFhsNmxaTCsrekpyWHprWkZNSUQ0Rm9kdlVO?=
 =?utf-8?B?R0RQSm9HWGlQZDZCUU85RWZxSC8yNUVzYVA0RVNpZ3kvQnU1SnpJYUk2U0lz?=
 =?utf-8?B?eGlJUFRheUgrODF4bzlQTGg1UlQvZ29lYm4wMmZCRmpVRWplL3I1ckZmbkc2?=
 =?utf-8?B?RzR2WXhUeTQ1QlBaaHI1ck1NMXlWYmtSQTZNMDhCNG95K0oydks0VXpMV0w2?=
 =?utf-8?B?QTFWQ0dYTm1mYzJYR3hhbCsvVW1jUGkybXpOVHBmWTU3bER0ODE2VThRZ1ov?=
 =?utf-8?B?bFBKdzAyTldjSGtaTjJicHpCWXp4bHA0RmluY0ZyT01IZi9kYllDejNlRmtV?=
 =?utf-8?B?VFRoeVV0RmIxbTBieGlBQUVKdjNHWjloZERvN2hwWFNnb1JSNFFtOVQvY21E?=
 =?utf-8?B?dng0YjgxSXpTcVpjeDhKOXAwUVNMMVJ5M1RTa1FDZWo2M3kwT1g2bEhsVWJs?=
 =?utf-8?B?SlJVTGdOb2VQWXFUKy9MSzdtQ3M2SHc3VUVaTDd1cjV4bklpOTdZYzRibndH?=
 =?utf-8?B?SzJmRlluTVQzRGdLSFZ4aFIrNzkveEw0SWxzcS8yWnhjY0dET2NVT0xuTGRs?=
 =?utf-8?B?S3dpMGorNXN0MXdTblJTSzJTZTZEMXNoNzJnOFBtdUQrNDJXY1FDZ3RNa01U?=
 =?utf-8?B?UlQzWDB1aVU4ZHRuTTErOG5Ma1IzenQwOTRoT2tVTG9qZ0VBYWlReS9mcjZp?=
 =?utf-8?B?Rld4TlF5c2FkK2V1dFJpZ3A0RXZBQUNISUFWekl2Y1R4RXV4U1lNVjJOZThF?=
 =?utf-8?B?bzNWdUhsdGFIbWZaZG1yWkR4Y3V4YldMOHViTzB6TUZYNmNUQUk4amxrRWJq?=
 =?utf-8?B?M1BwM0ZLWWhRcDZFeElaYVRwelRidG5QMVIvZkpuSW9DSk9MYXR6MGtLQmY3?=
 =?utf-8?B?dlByb3poeTFHVU1kM0d6bVE5N0NiOW1OL0Nya2FsWGxGbThZbWtncEhuMjlu?=
 =?utf-8?B?Z0ZQOGJSTmRsRDl6M2NRajVJczQyKytCUS9kMWpvREdwTGJodlVDMU9LSW9s?=
 =?utf-8?B?MGNYRUc2WjlaSWRtUjk5RHdEbE5FUDB6ZTJyQklqUk5oSGgwTUloLzJMRW5S?=
 =?utf-8?B?dFNLTDZwRklLTjZGMzVBRWR4OGthUUhoS3lOSXpUaVI4YTltQS9KSnpvYVk5?=
 =?utf-8?B?OXlKQXFvRFhqUmVBejNvN1A5YzdWN0lzL3FqVERjSGQ1NnBHTFhqWFFxU3hv?=
 =?utf-8?B?TWdpSjUvUGxiSmhKa2grLzlKZ1B5eEtUZ0FYMmdTUjcwOGoyc3d5ejY1VGlV?=
 =?utf-8?B?VEMrV3cvUkpLbFRFTkxHb21tRm1VMjBFellnRmpxMjd0aXAzemVsSmJpcERR?=
 =?utf-8?B?dExNQXdmV2lWeEFYbGY5ZUppRk1kUUZrWm44SnlEUk5NSFlpeXJ4bmRTYW11?=
 =?utf-8?Q?lIZibITfMn+buLH7lpXbvJXnl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e35f72-08b8-40b3-e7ff-08ddfbd44d4e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 01:39:00.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUFtd9lCG1Q55/jTLHuSHT7g5/6xNshNY1X2Jaqez9qrv7QG95lZ8LuyM4Vexr14nx2ujMElla2M35ijeIs3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

On 9/24/25 6:33 PM, John Hubbard wrote:
> The Display implementation for Vendor was forwarding directly to Debug
> printing, resulting in raw hex values instead of PCI Vendor strings.
> 
> Improve things by doing a stringify!() call for each PCI Vendor item.
> This now prints symbolic names such as "NVIDIA", instead of
> "Vendor(0x10de)". It still falls back to Debug formatting for unknown
> class values.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/pci/id.rs | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index 6e081de30faf..63db4d5f5617 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -135,6 +135,18 @@ impl Vendor {
>                  pub const $variant: Self = Self($binding as u16);
>              )+
>          }
> +
> +        impl fmt::Display for Vendor {
> +            #[inline]

That #[inline] snuck in somehow (it's not in Class), but it should
not be there, because this expands to many lines of implementation.

If there is a v2 I'll remove it, otherwise maybe we can just ask
the maintainer to snip out that line.

thanks,
John Hubbard

> +            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +                match self {
> +                    $(
> +                        &Self::$variant => write!(f, stringify!($variant)),
> +                    )+
> +                    _ => <Self as fmt::Debug>::fmt(self, f),
> +                }
> +            }
> +        }
>      };
>  }
>  
> @@ -160,13 +172,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>      }
>  }
>  
> -impl fmt::Display for Vendor {
> -    #[inline]
> -    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> -        <Self as fmt::Debug>::fmt(self, f)
> -    }
> -}
> -
>  define_all_pci_classes! {
>      NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
>      NOT_DEFINED_VGA            = bindings::PCI_CLASS_NOT_DEFINED_VGA,            // 0x000100



