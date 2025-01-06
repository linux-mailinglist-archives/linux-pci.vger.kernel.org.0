Return-Path: <linux-pci+bounces-19356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F33A03186
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 21:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67E37A1940
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 20:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B941E00BE;
	Mon,  6 Jan 2025 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzmStWWR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0771DFE29;
	Mon,  6 Jan 2025 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196322; cv=fail; b=lhU1uqLY6wFwbcKAO7AdFKo0ueNDueK/BuGdgg2fNgcs/3bB1L5/2oB7BubQiVFN7AA7aKXUJSmACNjeYTRnvjwmYnNXvo0ljqvch3QB81fWPkbgmZCvwVnApcP+9wf0P9LbutZFFnGPJPvJmDCFULLXmoFq1FPSn8dThvNb4nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196322; c=relaxed/simple;
	bh=8tRwM4ElbNLrorCtwu/1NVSnM9yp0H6pT6vytA2m0SE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TR+p+VvFao/kKA9h58pF5EESdbl8LI321bh7Wi5EDhQJs+HsTYgEXjxs3Jv09KGkHhTv6gTQApcn3sdWc6VXFMTzii3Zt9xWUsIFX8EHRu/M1+ahZ4rVxb3nH/88E7mzoCR+Ul602TYnZiapf42pkodBkVkI3Fl2yt5UxMa2+3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzmStWWR; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5UFVKtxaZKgozSvh+ET3xuikS5KBRe3PQ3g8HAV9rw4P3n/sX12AE4U38t9o/DC0M9EtsKQMZMGqol8xzFyBID7QYw7sUu2ndbmsMTqWjk16ylrI0W6sPCzPZs8WDwxgjln7VTJz0tCSM0LhJZqowMFZ7SO9K747NA/lcucqAjvqqdmJvJX2kmBR+nipUgjHCZ7pFsrD6VTFZNmvaalMexF3s+88gg2y91RNABjZPfuPDdSxICDVm0qBUiUvsJamXq9TM4JkbAGenZ/Ba8hKJch5KsC4Katr4htmbclduAb5ApACxVILbK6f5Kz6h9dWoBQyPPn8k6VYuWQ93zOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8HVjR5vcJKmzOvU+sf7P4bL/MKE4laYG4UYBigXEc0=;
 b=xa94gxPFa7Z7YqRIVgAzxnpue3Q8y/wqrWr7cPpMfrlVN5zy7q5modmtCC0aNrJ4yQqTUcnZrt0SunLdrcuoBu9vGjutxrK1zgWVtq9NFjoPoIS1gLLsUf4GT71pz/fTBqwETkXQiNwSpyHI2hCfWau/ToJuI6ye0WuVzN59DugZDdVby863t1ldFYh4dnb722eUgBKfzijig7desK6h4CmfKIuxPLsHila1lqDnM5/nSnj+yrJ9soRIJeaQ4jbpE/7nw/MX4uxa00OiI3uGlN5cq71Kvizhb7UvTVFLgArtG9L+SLwoWyOolWZShOfypxRAjNfcNBThJZYKhLjq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8HVjR5vcJKmzOvU+sf7P4bL/MKE4laYG4UYBigXEc0=;
 b=pzmStWWRpBoFu3CCd9veJlAplmdfAdZ1Ns2z73G79mt59R/GXWzoSQySiEFou/sBqYsWWWd1bQGdmCwgyKP0fhZ4D85Ua0nOdkEz7tkc8k3loBVPUvDqOV6mlRRMwp/DktyLGEzIN3ePxLCIhXVQmg/MYah3m6VYSni8VHXoHCAMAnR+LmZ1JObQ1QVlZnP6F2amHmJCoavLs8GHR/qsnbB9+vHvAtnhHbttIChk+jnzJ9HCfSS4NnFPXe3q2SkicVTIOX4tkGHXgJJRT+l9EV6i3MMiVG0+B/93r2jMWIB8zWA/m7jMa4hJ7YmdVCqSJl3oVobTA6GZfV8Am5BN/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 20:45:14 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 20:45:13 +0000
Message-ID: <e2e314ad-82a2-4aed-adc5-c1fa45762972@nvidia.com>
Date: Mon, 6 Jan 2025 12:45:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, vidyas@nvidia.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 jgg@nvidia.com, sdonthineni@nvidia.com
References: <20250102232614.GA4147007@bhelgaas>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250102232614.GA4147007@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 1538b41c-1e53-47af-841f-08dd2e930513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTA2dHFaa2txY0g1c3lrYkJxK01RbzNHckFmV1JtYkpNeVM2aXZSaGVrK1lF?=
 =?utf-8?B?MmJZRzJqVlVuTDUrc3I5d1hMY3NRSHhMNlNaV3N0b3U0TWcxa05rdVVRck9m?=
 =?utf-8?B?TjVha1B0dDBFVGYrN3VPTlVyVTBtQXdpelJHTVhqNStNVHVHQU5PN3FxQkxG?=
 =?utf-8?B?U2dYS2pPaDcwS2o3WUZsTTV3S2E3L1Y2VjNrYVMvU2hhRXBvdjJSajVSRFRp?=
 =?utf-8?B?WGN3R1ZnVkdTdnhuMVBIVU9yWVBWS2ZRUkI5YkxqOHFCQ0NncVZPWk05a2o5?=
 =?utf-8?B?WXFpNkJDYXIyd3BteW10eFprRW54RGJ6bFNpRUwwalhvQlVpVmsySFR0bG9R?=
 =?utf-8?B?a2VwMXNUZFVSU2gwLzY2QnBmVXFXZDFVc2pXN2dUQnpVcUR0T0ZHaHRYN1hI?=
 =?utf-8?B?MjRyU3BLU3FNcFNac3dFekRGNVNKVk8wdGdIeTZUeGZxWTExd3krcnNmSnVZ?=
 =?utf-8?B?VjE3UFRxamx3V0xaWWd2TjUvVm5BQnptVFZ0VHpMYTN3TnJRK0lrV0F0UkI4?=
 =?utf-8?B?V0xVS01POU9PWkxtejRZdExta2d5OWFVY0VOOFVuRGQzRTFkU0VGYkpSN0hN?=
 =?utf-8?B?VHY0ajVGOUpLY3RiN05ONzZMcUFxb3QwSDRneHAvakFiWHJCN0tjcDYreENY?=
 =?utf-8?B?dHhSeUtJekZDTDlvN0Z6YkFUNXdsRkpuYkZyL2VQbjgrM1Fib0lSQVFLbmVa?=
 =?utf-8?B?VjFaeGVPSzUrd09STjdTWDkwSUFPR01hays2d2FWNkQwc0VkMXlJOTlNVjdU?=
 =?utf-8?B?cm9Xd3dobi9ENnM0MzY2UFhFZDBPTG11M2R2cGlKQUtsSDBUQ0VNU3N3Zjl5?=
 =?utf-8?B?aUU4MXhCV2xpTmsvZWttMktRcVJhWDlaNmcyVFFFVTRtSzFZYmEwblRoMVVi?=
 =?utf-8?B?K3RvOE0yMXVwbCt3L1JBRG9QUHZ5RiszWER6ZzZlcWQyUFl3TDlKMVErdC8x?=
 =?utf-8?B?bHphWHZ3dng1ak42V0t2QVMzSmJhVEh6SnZjbnI3dnUrUnplaERDTEhnM0VH?=
 =?utf-8?B?cGdOT2k5bjNjWDVpTVZSeC9COGM4K3dVV1J3NERDUVVSZnF0bUg4MUFWR3hv?=
 =?utf-8?B?bVQwTlBTa0hMYVVlaHdTN0R5MXpNNktzczRBZU1JMW1adWw3cjZ0N1ZqVUh2?=
 =?utf-8?B?ZkwycnNVdHFCd2dKY21CL3JpTzNEL3M0d3pQVU1yUGdPRFgzZ2M5RHl3UmNP?=
 =?utf-8?B?OVBrS3ZTTlpZVlltZ1kzcUduNVB3dXRYN09UQmNrV0FSN2ZYbE1BSERWOFBG?=
 =?utf-8?B?VXBaSVZsYm95UjdoSmtrdEZHR0lQek1QMFl1K0NydGdPT1lhZ2hUMkovOUs3?=
 =?utf-8?B?TjBWNFRvdVZEYzc4SUYyR0NaL0hmS0RZalMzYzM5OEUxVmYrKzFpRzlESExt?=
 =?utf-8?B?S013MDZDK2NVRThRVnRmRnFuWGx5NUQxS3VSUTFNWmNROERITlpBeHVFUjVT?=
 =?utf-8?B?WndhcXdLcHNhd2RwdWJKa2xGVDc3enZWUUhrUnd1b29LdWxzTExPS2lYYWdW?=
 =?utf-8?B?Q3hPNXVpNGVvUXFtMFpoc05xUHJYRUFpVmFRWnVDOXNnYUR3R3Q2c1BLcG92?=
 =?utf-8?B?eElKcFVmeVd2aC8wQ3kzYWNuTHQ1Z0dkdExqNDI4QXNlbmdCOVp4WVFyVy9V?=
 =?utf-8?B?WXk1clpnREJHamh4djZZVVJ0K1dZSlNZS3pkL1h3MEwzMkkzZW9QNStRU1RX?=
 =?utf-8?B?cUtwc3l4S3pvZXNpSTk1V1F6SldMV0tEdGxVajk0VE1UUTFWUnNyWlRuM2Fs?=
 =?utf-8?B?d0huMkJVYURnQ3NBdkdEZlZGOGFjZ3dWaHpRZnV3RUhLTjBRZ0piTDF5L1dl?=
 =?utf-8?B?UVZZNHlFZytQS0xUY2lOdWpRMnc0aTdkcDZGUVRRRk5pbEI0OERWeEdycDR4?=
 =?utf-8?Q?DjrHCVa/Ft5uM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FNSmxmQUVJTDFobk44TEpJRWtXYXZuMjZMQjYyeTBuUEoyNXpXUlM4S1po?=
 =?utf-8?B?WDVMdUYrRitwVk1oamtCamZvanAvbUJoYy92M09WY0VKZjJ1L2RzbC84blRK?=
 =?utf-8?B?RE9ZanVMZHBaZ1lXaEtUeEFIcWFvMUFKZVlOTTczdHNCdTRVczViS2hRM2RB?=
 =?utf-8?B?QmVJSGhFd29HSnppZlBsRjlIWG5DNFlZMkpXVjdPY1V1Y1NxTXVnRmFoZ1NL?=
 =?utf-8?B?UjR0TFpYbElOTVlOSXRDVnN5aXVhaW9HMWdIRkZZVFRxcnpKTGgzbWV6VVJG?=
 =?utf-8?B?K0Ryd3NNY0doRVJydmhIUDlJZGE2ckNjVzZRUGdyV2diNjJyRWdSdVljMmZL?=
 =?utf-8?B?NUdxMkprVE5ZajlnUHZNejJtSzZYV0hJQnRBWmc2c3VnSlprRHVieDFJYWpV?=
 =?utf-8?B?eGgrSTFNd3ZneTBuU3k4OUloWFNrSkd4dHZJaEx4clFvTzBJOW9EbXlpU1hI?=
 =?utf-8?B?c1pKMytwNGwyZ0NKeGl0ZVRRUmZlVVVYTDBicGNwektOc2U4T0cvUmoyaUxz?=
 =?utf-8?B?d3dLbXdKeGxwUXZPSzJIcm0rb29PNXcveXZZMDRoZkl0UkdUVlNUZStSNWw0?=
 =?utf-8?B?UXdXdmk3S09jd2lBWFhwRkZjUVVNMFV0TFgyZ0g0djRieGY3TXBkdU02OXht?=
 =?utf-8?B?RndNZ2syZVQyREhXU0JjOGo0enljdlZ4NW80b3VHMUU1KytLcmpTNlpWcDdj?=
 =?utf-8?B?WGRyWW5EOHBmT0pTZWd1VnlndWpZdU1hWitFZEREQXplR2JhQ3ZBSkE0ZFFU?=
 =?utf-8?B?WGl3NkRSV3BLZE5XNFkxb00zNXQrMmhrb1N1L3RnM2JmQkIvUnc3K0lkZWdp?=
 =?utf-8?B?QWVjN0JzRGUxN1lWL2tLRTNtWXg1My9UbWZqQys0TUVIWDB1bjVCOTRUbmNG?=
 =?utf-8?B?V25IQXdoeFNCR1c4L0JDT3Q3d2dDSjd2K1Y1Mm91MVpmVVRRaWlQZDhZcStE?=
 =?utf-8?B?aFdIZkxEWnFVemRmVUx4alRWR3RpRmNEbTMzRUFKTGVvenA5elYrTU1SWE5n?=
 =?utf-8?B?NFdvUi9YdzR4bkRINjgzWXlBeTA4dERtSkJZOXFpU28zV2oxNEVUTUdGdkYv?=
 =?utf-8?B?VjNZenN3eUhKYkVtNWxFbUp1Qk1xUjJYM3owV3hxOGVNMUltVTA0dnRZTlh3?=
 =?utf-8?B?Njd1Yll1Sk5VVFhLMDVDbytsSnY0S3lMMWFYY3BXT1lPWmFwZHRkUnI2Q2x0?=
 =?utf-8?B?eG5VcUNJY0tVcE5Lak1na0hJNm9aYXB5OVR3QVRZZ3k0VTZZQndtaEVTd0lW?=
 =?utf-8?B?aVJMblpmbTlEYXh5ajc1ODRWSy9iT2JtcVE1TFA3MEc2Um8wWGNMdmFma3pF?=
 =?utf-8?B?anFLOEliVmFPcUlQaDkrQTJzNG9wdjFJRUVHSDVHM3dSU3NIc2NRSXEwdDBF?=
 =?utf-8?B?UHo1QW1wMFlzemc5cG1FRGdlQklCclhZdlpsSm5TdndHRFVRd0M3TjF2SGdO?=
 =?utf-8?B?UGFuMWVxb1piRHNBc3NFWDdPOFNIdlZEckYxalBSNFFHR0F6bkNEV0NFMC9X?=
 =?utf-8?B?eVE0V3A3SnUyQ2dxSCtZb3VTcUQvdTJSN0xtSHoxaU84TE83dlNuUUZHT0Z3?=
 =?utf-8?B?QjJKOENkVWttUjI1bGhUYUU0K1ovakpDT01qOGpTNjQyMmk4VWZ2Zk5JVHhM?=
 =?utf-8?B?U2RLdW5sZTNhRmswTWJZbHZpZzRueXg3VmorVUcxZmI0K05FblhqZmFsaVV1?=
 =?utf-8?B?VmNLWGRqNXhJNWs2aVBoY0czd0l5dDdrODhnY21sT1cvdUlDcnYvU1BwYVd4?=
 =?utf-8?B?clNCb2dJVWRuNnQ0a3dGVjJFa3hqUUV5Q2hEeldIdkUzaHNlRkVwSUowR2xJ?=
 =?utf-8?B?OVNYYUhKUzBWcWdTdXJJS0RMdzBGai9BZEo2YzhXTWp4dDZjV1dHUjQxTzVM?=
 =?utf-8?B?UENVTk5PaHRQZFVCQW53Y1d6dVhaT21rSkZCQUZDaHVHUTVZYzBucUkxR3NI?=
 =?utf-8?B?dURGZHZOWG14WnJzOWdNREQwdlVqSGVwa0hwUW5ucEhITGsrblZqWHgvY0xX?=
 =?utf-8?B?VVFYUUpDVWhsZENiQUlPSjlvdnIyZHJFY1M0RkFHdU1qQjNZL3o1QUhPcEVH?=
 =?utf-8?B?WFhZTmh4eUFGcW5nVzlzMVFoZ1NRZzV4UEZBMFVEMndOckZzalNIeHhPemJV?=
 =?utf-8?Q?uXJtaDzBeC1tl8+rx2JE0a2SR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1538b41c-1e53-47af-841f-08dd2e930513
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:45:13.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDp/yVlGliWe78a3pSdVl8bq2NOYjQyBFVr0v1VtFfiJJZaaYnLg9Z7DR8N0NN2Pe/dGxMXrd2Raa0XYlRX7pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763



On 1/2/25 15:26, Bjorn Helgaas wrote:
> On Fri, Dec 13, 2024 at 12:29:42PM -0800, Tushar Dave wrote:
>> Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced a
>> bug that fails to configure ACS ctrl for multiple PCI devices. It
>> affects both 'config_acs' and 'disable_acs_redir'.
>>
>> For example, using 'config_acs' to configure ACS ctrl for multiple BDFs
>> fails:
>>
>> [    0.000000] Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p" earlycon
>> [   12.349875] PCI: Can't parse ACS command line parameter
>> [   19.629314] pci 0020:02:00.0: ACS mask  = 0x007f
>> [   19.629315] pci 0020:02:00.0: ACS flags = 0x007b
>> [   19.629316] pci 0020:02:00.0: Configured ACS to 0x007b
> 
> Drop timestamps (unless they contribute to understanding the
> problem) and indent the quoted material by a couple spaces.
Thanks Bjorn. will do in v2.

-Tushar

