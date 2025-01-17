Return-Path: <linux-pci+bounces-20025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F591A1477A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 02:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73653188D5BA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 01:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768E18B03;
	Fri, 17 Jan 2025 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/yR0akO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1F17588;
	Fri, 17 Jan 2025 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076897; cv=fail; b=OiWNpUPUT0TlP9efIkooWvRbMEjSbgAgoBZhiwVkCUvbxyjM9c3rPPDnKOOxZ3ymgTaQ16GvFfOsRG7A6OZ92qr33qu5tV9+icExpiR0hy+VddinwC4Yk40cYboZSN7ZEkXkEIQX1LYi3uK1B5ANf50BB6+WdCgBdpJ5nD8Oars=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076897; c=relaxed/simple;
	bh=KG8KYwKTt73AWGTuPaYH9OdlQtqrQ2XSpPdTRPiJzjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=szH9LoXy7wSJrbbFZt5gg14SGLtmbhssiqmuNQQ1yjwLyy8+vRkID3Gmn8PTy6EqnDKn3D5q48v46MJjNjFFwDb9KSLnAPtnK2JxfXa+6dctweZNnTPQTdETln956Iw9wJDy5mqxC+IIiPi+QYOLxs+k9ctREcmv1pSPaknMZhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/yR0akO; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETOOBfdQb3otuAqB6DBnBWIzurHZ/SAxKtG7+IG7iMJPvDutUrdpY3Bo83i9BgblfC8q5hFsqj0VaUCfGPtoKOArWiCELYiy+YBB8oMcu4BDg73xAkdMwKPXTYZhixADJ/16sG7gaDIhWnwXQ7/5TN7QXnJqlw1vu2uYJi0D7mwhTCAQrZRJYFai8p3bOY5vPlmMM77SLRbAEleIgYECof7tMkRxvB9VxHsqGFUNB1UHL20J0Cb/F6RYt0IBkqfVqefKS8eGHChhyObrNSMRM/agrdueuz8uda5LpVB6UUw/AvGo4XiJl1RAPoq9CDRxmVzf1MyEOAhs3WPVCeAYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjLFKlHkt7fW0LfosoOaXl4k6LO7YL5cSpEfymJxHcs=;
 b=KreTkfPsVbMJ1joN7u7gQvdI6rjwzwFctO44OUIUH+DL2m5KLbOKsmvAXM5sBrMy3fNPl6SoHqEk93xrrLqsKmXdeKIwzrkyPQyJXs1Ho0g9BaEbXJd94tjRHGFY7fWqcCGjCMuIdgaMuPp0H5Tjq4oBBO3fnX7m8tTdSExg8IH4PNjBt7hUVwsjtxUFlFMEv9VVlIaXTBigbxLjByKMhceUDz9NyD26ntl2GY8YZChRrJvndPkvunWXbaDReO7K6ihgcCLFiUXo9FrB407sCCEl3XkbOcVjSm0RCKe/NIgp0B7KUNTdLEWz8jM/vYRC+uuSJQsI0fndfsKFF65pPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjLFKlHkt7fW0LfosoOaXl4k6LO7YL5cSpEfymJxHcs=;
 b=j/yR0akO6GBBsmdoUdjUzFzMhfnwA1esRezGf13dPtavDaM+PWEGpHaTffQZCwQ7NGhlOBC4yqUKO3SkKYOrj88mLhfNn6JkCqYlIvjVeD8thk9E8mfg5CLg29sfpy2H8t9NSoM2SGaF/pp3khcLaLCfA9zx2lpLA1mK9vuMoN5EvNC9PME3fs/12nrcW33p3MAogkfqOgnhPtjbp/Ye+bSVvs4VTfcIxSa237sr/kVXK43x6dcAkbyqXu2ID2psQBoj1QoY3ynGMMB6Dd1gAQSjWyaJCymWULfdAbxSjbcIZut2glTCL6rc8yGZlFWxVib+WHon+jnxvwUa26vD8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 01:21:32 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 01:21:31 +0000
Message-ID: <4d5224c6-bc0b-4ca9-9f1a-71d701554b3d@nvidia.com>
Date: Thu, 16 Jan 2025 17:21:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, vidyas@nvidia.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 sdonthineni@nvidia.com
References: <20241213202942.44585-1-tdave@nvidia.com>
 <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
 <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
 <20250108151021.GS5556@nvidia.com>
 <0ea48a2b-0b6d-49e2-b3f7-ab4deef90696@nvidia.com>
 <20250113200749.GW5556@nvidia.com>
 <6ea9260b-f9cd-4128-b424-11afe6579fdc@nvidia.com>
 <20250116190118.GW5556@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250116190118.GW5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:510:339::10) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e8b5f9-dea8-4a63-1099-08dd36954654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFE2Zld4SjBSVGdURHl6K2dSeGZScWxaalIyYjZvK0VsRmZYUDF5dU1odjM3?=
 =?utf-8?B?WUlDaklnbG55YXQxemV0aUFHUDFTTHFKOTBMRG1yM2lNTmtYb1gzRmZvalc3?=
 =?utf-8?B?WWI5d2xzbDhCRnEyMnVSelY5bG1mSWVJdldqcGs5ckM4aUsxWXBzT0tDaVNw?=
 =?utf-8?B?akU3Q1R5czYzMFVGMVVCRDVQN1NvVHMzUDhFOWVSTm9ONzJzbjBPT3h1Qjds?=
 =?utf-8?B?MHBtQm1BdGxkOWVsREpuVkQ0NkdoemlmVURBNVVXelphbHR4cmdobjFnMFZ5?=
 =?utf-8?B?dnhJU0NUVzBRQ1NpQ3JhZ3JiUkZmMkRjNFc2bkgrQzBsUi9WWDI2SVBwRWZj?=
 =?utf-8?B?SEtod2h3YTlmMU1tTFBkN0Vzc292K05VbE53TXIza1BMa1VublQ2dUM1Wk84?=
 =?utf-8?B?VXNsVWladTBJSUYzKzlVZ2xRN1N2ZU9Bd09BWVlZYlpkaXVDM1E5Qk96eW1p?=
 =?utf-8?B?Tlg0UGdoSUVYRWIyTnp1UVo0WERsZlpIemhKQ0VvMm5UYS9kMlVQeVRvSWo4?=
 =?utf-8?B?VHI0YlZySDBiUWpXdk5tb1VJcWNyQ3RhUks1K0VGVzd5Z3ROLzNXaThvL0g0?=
 =?utf-8?B?amNJL2QrTVFBRW5UbXpGWFdxWXdpRit5TGxBK05Ic3k3TWNjVUdLVGJobjBa?=
 =?utf-8?B?V1BBYmlNNWNmNElpVGFlNU1URkpOUzFZV25xZWRnVWNrRHQ5UXJrMXB4Um5I?=
 =?utf-8?B?ZUZYMi9kYkdlTzJNQi9RaXZ2aHppRWJJSnJKNFd5QlhPZFk3cVhEdjlleHh1?=
 =?utf-8?B?Qkt2aytEakd5VmgwUHZFbVMvaEZ4Zjh2R1p2aFNoVGtnbDdaRUYyTEtOaDZ2?=
 =?utf-8?B?RUxnNVYrbDVVK0l5NTNpL0JQOHJCT0R2VUlkemY3Wm1zb2JjME1UcG41R2h3?=
 =?utf-8?B?RGVWcGk1ZzIvZ2RVOXVDSVZ1b0hhRVgxMFJZM1praUxpdXcxTlFnMnZyc2JY?=
 =?utf-8?B?NHc0a3dkUlVvcXBDdGdJNHlIL0kwSUZyRDA4Nm8zS0dNSStZMndNenl1d0x2?=
 =?utf-8?B?cG0yQy9WeG8wWGVqSkJyY201QXNpZG9PbERINFZnOWtMUEluUzBSTGdPKzJy?=
 =?utf-8?B?RDBBVXhQYnhUQlN4QUhYK0VqVXlPSTVrRXNKTVRtU2NuckVPTXhhRGpKZE5n?=
 =?utf-8?B?R0xSOTJ5aGltd0gvU3ZPMm50TUdOOXorVUJhemcvMzlkQTVqc3JyaXhheS9p?=
 =?utf-8?B?RitaYXdER1JjaUxma2F1Uk5KTFRJbGxUNVpxZy9iU3duQ2Q4dUE2bUIvdHFh?=
 =?utf-8?B?MnNNejJ2aEYvZGprQ2dScmRBc1pOcnVYWDBIc2lpWU1oZjViZnk4cFBSL0JT?=
 =?utf-8?B?VDU2Zkd6aDdkZGZJNHRPQmZZdzkwTFkvRFk2ZTFNaXhxdlQ1MmQ4ZkFSdjVH?=
 =?utf-8?B?ajhjVXk4RVVjVUdjcjV4WTR2ejZFL1NhaUw5QXp4OExReUVDOEZtWllpTUJy?=
 =?utf-8?B?N2VYYkpTVEh0V2phMmYraE5RaW9kSURIY1FYQ2ZoMzNZRFFscU5WWGtEeFQv?=
 =?utf-8?B?NkxwdzJqR0RsSzFhU1NyRGhFNzNTbUdJL2hnQmo5ODVmOTd2bFpsM2ZLRGpz?=
 =?utf-8?B?dnVJUHExVlByaGJ6ZzhoeGxCU0k1NGxxRTRxNFJPTlRndjR6RlMyZUJNV1FC?=
 =?utf-8?B?cS8zZjdMZW8rd0VFelRpRU4xR3VEWkoyb0J6aTFicnR4V0ppWWd0MUFINStN?=
 =?utf-8?B?LzRNSndlU2c2TFV5NUt5aitsTXJ4ODZaZW5kSmJqSnZpMFU3OG5MbEpnL2dy?=
 =?utf-8?B?SmVCQkVtekFncngrbmNaN2RTemRlK1ZsbGNpY1FMMjV0MEpUQ25HUUxFL0tM?=
 =?utf-8?B?WUtUWThJZ2liQXhNMVNabC9CazBpUm9TbStSN1A4K3pTMWxWY3c1TWxPR3I4?=
 =?utf-8?Q?vfxEWk10ODT40?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czVrQjRXdTg1YVFjYmJhODBVejZ0bzRFRnlRc1NaczhKWlFkbmltN0tWMzBQ?=
 =?utf-8?B?Tk9ONVhKeGJvdEJidlhjR1BtUEF6V2wwdG9LS2kxY1d3VlJvRjRTdklBMGVG?=
 =?utf-8?B?TzAzTEdQYkM0UC9NVWwxWWxNT01mTUZzYk5LTTYvVHNGbXoxbEcraUh4YXQv?=
 =?utf-8?B?ZG5DNDZILzBWc0JhZnRXcDZjTHBEWmlFeHcra3ErZG9Ub0MzMG9QbVNkTGNQ?=
 =?utf-8?B?QlZWRjlpYTNJMjFENkttclJkc0krWjAram5Pa25hMFkyQ3BiWDdqVyt3SDVm?=
 =?utf-8?B?Uk54QzN1dTRrM1ViSitKZDR0WE5SNVA4aHRzQWZTbGxMemtkZG1sMEh1Y2Vp?=
 =?utf-8?B?N2J2YWRLMEVvZDJOWnBxSnNpTDlTUTl0OHB1RTNLNnFzWkRKRzFSdEpzOEwv?=
 =?utf-8?B?NHZVQmxLSEZuL0tnSi91OXdXVm42bk9rZFd4QmI2QlozalRaUDE1M3hXbjhK?=
 =?utf-8?B?b0ZRZ2pHYzBodlQyazNoYm9GRzJMeXIzQU4yUktzSlRVY3QwZjZ2ank0c1Av?=
 =?utf-8?B?emkyU1hlSFRYbktwNEtnOCtvdldqczIvdHB4RW4vbkFVUlUzSDhUbk1mcGRP?=
 =?utf-8?B?aHFBR2tSWkVXNWxtOXlaa05kd2NpdmpYZWhBdVdaQlhRNS9UeElLYXJxUEZW?=
 =?utf-8?B?TVM3THVKcVFZWTF5WERsMktmNEdKRGgxZzUyRnU0UGJlOUxCdFZrN0pvYWxI?=
 =?utf-8?B?a2NKOW5NSi9EYWZwQUpzeVFDRHFyejYvd2o5QUtXeGk1SHU3eXFmaGNqWGRs?=
 =?utf-8?B?dmVDZlVYTHhZMnNZQWJiRktTVU5Vbi9rSUJsZnp4ZHljdVFaMFUzdUhzTURS?=
 =?utf-8?B?d0FzWUlybFhwa21BYUh4dk9keWQrNWRnMkNNMFhCZ1pIeEJNVWd5RjZ4N2Fy?=
 =?utf-8?B?WG1ZUXA5NEJyU1lHMUhhVzI2aGtmOWFZTG9kcWZqS2x0UG15YWtZcmMwUFJO?=
 =?utf-8?B?RG0rd0xDbXBOVkdBaVNUQU5zRGI0TGZRRWFQZXZRMHJqelllYkhvNkJHc3Jr?=
 =?utf-8?B?cjVTL2dIcndPWXRiUXdMd0l0MysrOFduSnFZemkzOGZuaXYvQVlaR2dKMEhZ?=
 =?utf-8?B?dkNpd2FCSy9xczlML2FpeXNrMUhZR0piQ1NMbkdOVkNIenp0ZGxwZVprMDNG?=
 =?utf-8?B?K216cXpMTVJjVGswYUtZMnQ3UnBPaTZZNjlGYitwK3N2L0dKdFFXOWFydHUx?=
 =?utf-8?B?TjA1a3piVHNFRFRpWXVPN3ovU0lrTmlqcWlVYXJSTkZWM2ZWVkVKVWJxUjNR?=
 =?utf-8?B?enlWbGV6YzNLRVJqK0cwSmdKS0EwVitqZGsxeDFUZDNZaWpUR3BIQXJPUWRE?=
 =?utf-8?B?aE9Fa2FrS2RDTVdLeUlrVllMWkNOTk8rU3VaWG81RGJEaVFEOHpnczlCY0tk?=
 =?utf-8?B?MmNoMWZSSXdzQ1Nwelg4dkJRYnJLTUdLUG1ncHNmZWJpQVFSODVieTlYWFdC?=
 =?utf-8?B?VWxHSmpab1EzOFFtWS9WVVlNcDhNQVRVeCtjdVljUU44TVgrRlVUSEV0TzNt?=
 =?utf-8?B?cW4vTDdsVHVWU0U0cE14ZkZhTmxwYWUxTThRNE9Qd2FwOVdHVHZVV2hCQjhh?=
 =?utf-8?B?aVpuWmtEcFQ1anRsSk50azdHMjBVbFZrOXJOU0lCQTQrbjhkVTZmeGIvVzdO?=
 =?utf-8?B?dDBFMVFHdk4xRGN3T0FiRXRSd2tsNmpJN0RXb0J3bFZ6WW4vYlJya2ZXSXZy?=
 =?utf-8?B?TkNWeStuZDVyRmtPeXJ2Z3RvdnhidkpISWMveUVXeHo4d3VlMWtENUhLbGMx?=
 =?utf-8?B?czBPemI1UUFLSUdBSTNVT1dTOTdYd0ViRWZjNGJscXBSVnZIQzZYbFBOSWpV?=
 =?utf-8?B?UXRVYnhUVEMvdlp0R3UyN0pTRzVnSXpoWXhwVm55c0I5Z3BjZWJkRmlFZTJN?=
 =?utf-8?B?cUplNkhwS1hNZ1hkUnVFQXRpL3NVeEFzc05Pck1VZmpSNkxXVFJjb0JaU3p0?=
 =?utf-8?B?VVRWN2FvaUlmYXlIQndKNFkrU0xocmM2alJQQmRpMXJmVUlBTHA2N2RMRy9J?=
 =?utf-8?B?VGEydEFFWkt4K3BZYjB6dVY1ZU1ac1o5bkt2c1FsbVdZd2VFMzFtSlNjU0x3?=
 =?utf-8?B?TGVlbWhXdVpGbzZ4WDJFSk0rUHZIUFJKckFIUEFoY24rb0ljekxuNWt5VXhK?=
 =?utf-8?Q?nuKer+oJpcCogTOo89XMWCceU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e8b5f9-dea8-4a63-1099-08dd36954654
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 01:21:31.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5exYM60eKlbqSgwHY9fupIwkct/91HO2/FggaSI3KMj3p9YKr/FoCEHRWRgm2Qezl7PboJpHZtOzgwk3jjkJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447



On 1/16/25 11:01, Jason Gunthorpe wrote:
> On Wed, Jan 15, 2025 at 07:11:25PM -0800, Tushar Dave wrote:
>> @@ -1028,10 +1032,15 @@ static void __pci_config_acs(struct pci_dev *dev,
>> struct pci_acs *caps,
>>
>>          pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>>          pci_dbg(dev, "ACS flags = %#06x\n", flags);
>> +       pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
>> +       pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
>>
>>          /* If mask is 0 then we copy the bit from the firmware setting. */
>> -       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
>> -       caps->ctrl |= flags;
>> +       caps->ctrl = (caps->ctrl & mask) | (caps->fw_ctrl & ~mask);
>> +
>> +       /* Apply the flags */
>> +       caps->ctrl &= ~mask;
>> +       caps->ctrl |= (flags & mask);
> 
> caps->ctrl = (caps->ctrl & mask) & ~mask == 0 - so this is kind of confusing.
> 
> What we want is to take the fw_ctl for all bits where mask is 0 and
> take flags for all bits where it is 1?
> 
>    caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
> 
> ?

Yes :)

-       /* If mask is 0 then we copy the bit from the firmware setting. */
-       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
-       caps->ctrl |= flags;
+       /* For mask bits that are 0 copy them from the firmware setting
+        * and apply flags for all the mask bits that are 1.
+        */
+       caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);


I ran some sanity tests and looks good. Can I send V2 now?

-Tushar

> 
> Jason

