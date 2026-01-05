Return-Path: <linux-pci+bounces-44004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E46CF35DA
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 12:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E27A301F5E9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876233B97A;
	Mon,  5 Jan 2026 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iCKFNfsr"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488E33A9FD;
	Mon,  5 Jan 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614115; cv=fail; b=f+FR2Q/r0ZAGBdEjpOJRh8kiDMSEUqRTOKos6ie2CCXRDvGRIf+3ktsHt+wRRZJx/BuqY8c/ASqUqm5irfg1z6613RqOVrx6J1uEDjnSVpb5j6ahBarXJDfS3Rlq5LBMjIEzfLqe2qWIg41dfCFa6TaDrrayMWOUvKHvD35nVd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614115; c=relaxed/simple;
	bh=/9jRLkbPrYWdZH84k/0GfKscF1y/Gv3B3edZrwvygfo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EcmmbaLCDPTgQwpwUdP4Viji4UyLBkoUzFLunhfmHwlvJTCXP8/yv1KMPTCGLushiou1CM/0JpdkBXC4hZvNuymzjLBxC6RHqJArvBLB76IwrAe8RTHVumEfd6uyFobOV3zJ9x/Vn2xb6qo9Ley9w77fh9AZfboXVLSm+/xlp3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iCKFNfsr; arc=fail smtp.client-ip=52.101.46.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4I7nY0wosDHM9ioPnjO4ngTXyCtxbxZeh6RBAEGlUpUqrinlHKuIiJtue/EoxDQTwxTgKONCnh3W9sKCgW8NMcF3VPczTqClPivhjKQAXqYGXUcxVFblX+J1K3i/vZC8pDkzceMiJaBu+rb91BYneqyosF9NM8+kkO4ESSlpACk/WrJtNAAEUxvKd8bEgmFtRDQ5Pnji64KRfdbNAg2c6iqHlE6htttPF2Co5eIqvkARw2909v7tMi+SjcUW6x0Caz2vkZwe0Fdpiv2JFNVJpqWa5G3iOUOakUqRcQpNjMCCoraACE0BNZ8Z4f00/ZLM4AbwWIJ1Rxh94K5q9kgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh6p28u+RaNXzPfYqu3Id/pef2G4Ct6U/t58XDxFXLw=;
 b=p831llJewj0h0TBES8m2aCjx5nUtKXXKWCUxsvus49P/usMW8Ub/PmFs28olrLhDud8G50EdIncUz8aC1FBk1cUr4M+CJyYp6n/Iu2OkNaZWgtY4XwGcGvvMhjP+FiLHV+FbRj3URbuQYoCuF1KrDN/r6gMmMorsFk6JpBN7qHXo78genDffQYj99Kt/AF4DKD9iNCzKRPVEfrZlMZyp9oCuhZaasslzth5dqEKL7E2BOlVhbBdv1xXGplAqP0ga2FAL6wP8scUynKy9ftXqyV+LERwhpl5Z9J6pO9bbBHBr0ABE5W7zxy6/ylpwmP7spbKOxZHpUbvwJm7z79/Bog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh6p28u+RaNXzPfYqu3Id/pef2G4Ct6U/t58XDxFXLw=;
 b=iCKFNfsriiQQL5ewfeDwtvqwrQELhjIYROn56ygo0kjz2FS5vNuuqQhRbW1b6FcZZh0PqKOMh34BfFbyUa4DLMzm9113E0Ma06n2rd4KJrq2AAm2GUEXzV8XADYwMvgwycR+ISsFv3Izw4N+7wlJbYuBuQyOyFG06SaJflWkwwfjSkXWcG3wKb09d77Rt6wqBJt3VEHM+2iiIDhBt2JEfCQHsU2A1d1tM3w1BUXEjq4TRekDPznY1ikksARRczNeEbv0jzxlWOmMki85C5elQWTCltfA5bEwtO9IvNZijWcsx7fz0lWz1nDreV36eaIrayfDkX964BowttoYiF9HfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Mon, 5 Jan
 2026 11:55:08 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 11:55:07 +0000
Message-ID: <44fc1031-14e4-4340-a4b8-74fe524c3ee0@nvidia.com>
Date: Mon, 5 Jan 2026 11:55:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>, thierry.reding@gmail.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mayank Rana <mayank.rana@oss.qualcomm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shradha Todi <shradha.t@samsung.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Inochi Amaoto <inochiama@gmail.com>, Vidya Sagar <vidyas@nvidia.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251126102530.4110067-1-flavra@baylibre.com>
 <xh2att7wpqowricyifxmoaijbhtrtoht25pomu4voosfctf36e@4p27y7rezz22>
 <e900f082-fb3e-45c6-a94b-935132190249@nvidia.com>
 <5cwg6tg2y2q4mkns5zblenvhhovnz52dp5bo4uyghs4yledh3v@7apj6wwy3kjf>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5cwg6tg2y2q4mkns5zblenvhhovnz52dp5bo4uyghs4yledh3v@7apj6wwy3kjf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::7) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a3f0aa-8db9-426e-394c-08de4c514590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWpVcUpPc2x2UDl3M1lWaElQTnNBb3MwWVpCemxZa1d3NmxkZjVWNlV3TWs3?=
 =?utf-8?B?YUlhSDY3SmNrZHFldXVwZHhXOHNVaGZKUnN5MnA0NEJ5QXpSSkE5MitDU1Iv?=
 =?utf-8?B?Z1lLZnRxWmlxVUJCWWxDZ2lJZEtaNmdSYkFrT252Y3l6OE8xTjJhZmlhNlYv?=
 =?utf-8?B?U25SUUN0UHBJNW1NSnpHQTROVDF0R0EwRDJHZzY2RldhRnlCczM2SUFadkFi?=
 =?utf-8?B?MENjckk5dGZMTld3Q1MxajZ1QW96bVgrdlAwRTkrdkNZQ3VPL2JzbE1OY1p1?=
 =?utf-8?B?ZWV2RmNBbUpYYlVwemJadEYrQUN4dWE4THBiMXhvcFZvWEdRa3poejhWZzdr?=
 =?utf-8?B?VHFqL1RtVU9oSHR6eEFRR0RTNEFEbjNGbVowSDBWVDdaaWt4cW9zZmxKUnpa?=
 =?utf-8?B?WEIrODgvelJMRUplMG4ybVpHbkhvNDNtV2FzL3Y1VWNiN0ZnczNBbTZCejFU?=
 =?utf-8?B?MUlSMTdNamZFaGY5UzBoQ0JoQjZkaFBCMnZtQ0VvempGZXV0K3FsQ3pRT1I4?=
 =?utf-8?B?ZXlqZ3NjSDN3SEFmQ0ZRazNXK3ZUcXZFR2Y5MVh2SVFwNnlZUEx4ZTkrWVEw?=
 =?utf-8?B?UGUyNUZMbFB4aFpwN2ZOcGt4MlVubHdCQmcyNWErV2lCUXlEbS83Y2hYanhw?=
 =?utf-8?B?WHRmaXRpUWM5MFAwL0RVc0tTOGI3RHFZeFg4V3BBK3VqNHZzTUozN2d0bytU?=
 =?utf-8?B?N1hZOVdITDl2S3I2Q0NCTXUrTGNJb0VXbWRTYUNFMEE5U2oxaFE1aHRzMlF4?=
 =?utf-8?B?aE9IdDg2UUdOcWdSN2RaKzkybE5PemExMy96MHRBMW1lY2xSc0d4czVOVXVr?=
 =?utf-8?B?UDZ2VkhpZXp2S2pROHVWbFlnWFpKMFpLbG03TjFVQWV5MEFlVThBL1ZXSzBN?=
 =?utf-8?B?dUtuVGFqc0hsM042QmJFR0lUNjFGYTR2eXJWTnJGT0l6TFZ1Z20vbnJEb2l5?=
 =?utf-8?B?WEFEYkQvL2pLemU3UHFHQkw0Z0V5Q1BBMlhuc1pIL0FvUytZaGJEZHdtS3VB?=
 =?utf-8?B?U1ljd0daOUpQVSt5QzZDYzFNcm95RjV2SzhLSk44UjJFbmZpWWlISzlRVHZO?=
 =?utf-8?B?cmVEMmR4c0kvaEFYbUxSM0orelNQUTBiUzdWczlQUTFXMWphajdnaDN4NTFy?=
 =?utf-8?B?dFdvNmZwV052aGwxR1ZQQ1ZBRGg0VjM3UlJwVEtiRlhJRnB1Z3ZSb0huazlj?=
 =?utf-8?B?VGErbThrNVJMSnFqdlNIYVFqSEV1eHhhelc1R1hGMGRuWUJEcU5aWER6ZUVj?=
 =?utf-8?B?VmZFWXBLbDhKS1p0R0FiVFlwSThFd0dpREx1L1hVL2tjZXBqc0pQK0dLcUU4?=
 =?utf-8?B?YTVFbTZOclloS09pRVVhb2tOb3JxeDNTVTBYenVNYWZyMkMwblJ6eXRWUDBa?=
 =?utf-8?B?R3NHekovMzhNdUlTdGwvMm9KdnB3cWdxVlpEQ3dneXVPTC9sWWFBMWxScUEy?=
 =?utf-8?B?eDV5MDAzZVhOemlTSVVLbTljRnk5U1IrVFJNT2x6MFJXMmdDbzFPbC9TUzU4?=
 =?utf-8?B?cEE3WFlydU9yZUQrU00rR2NnM2VlVFJrSlVNbnY2R2htTm1KQmx2QWxsUFhT?=
 =?utf-8?B?YVZNcFZSS2ZxZkZheVVqekR4MFdTUGNNNzlCeWhaODFQWk9NME94eUpNeS9P?=
 =?utf-8?B?T2tiUGxla08wKzZkai8ycnBCdUFGSzRpK1E0R3lSZzVkaklNQmZvYTBtck4x?=
 =?utf-8?B?RXM2cGxtdFpmNGJUbXpuZk16anRvZnRrQnhCTmtZMnVSd2RyeG42WXVjN2NT?=
 =?utf-8?B?VVgvaWRJZWh3OHVtQWhCOG4rTXN6NDZmTm1paEJIZnB6bHcyRU5mcktFd1RW?=
 =?utf-8?B?QllGQi8zME92ait6R1daeThsUVhUU2IyUHF5U085VXduQkRjaUo1NS8zNDA0?=
 =?utf-8?B?bGE4MGpMNDZ5TUNpV2xtYzYzc1NVdmxSVGc5djN4UkxHVnlKek9zQ2dzVENL?=
 =?utf-8?Q?DSA6PveWvyw5+6vZWCEsjQDGJXXtMoMN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWRQSWYvL2NGbVFUSFIrYlp2QzNyeVU3ejNXWEdrZWdHZ1htWlN1cWV5TFZp?=
 =?utf-8?B?MEJOcmVJdDhLd0xwck5TUFVKcUtwK1E5L1FyelpvL3RhemJLYk5ob21ueVpW?=
 =?utf-8?B?MnNWUzFvRVVQOEwydEREU0hOY1VySVpuaHcxdTFSYSsvcEtuSTFJZ0FZdVlP?=
 =?utf-8?B?Q2F1bEZCQkVDTXRvMG14RG1iY2RJMkJoZDAyV2owcTcva29nZ1lQTzFqNml6?=
 =?utf-8?B?SmJONkhOTUFKOGpYUDdlRk11aFBNd2FXNDJIeStzNjlIVVB1eWszSktiL09m?=
 =?utf-8?B?RVdkVzlNNHJSTVA0RlV5OXp5RXdIYUkxY24zTTdvdjF0QVVCVFBXZ2U0bVFE?=
 =?utf-8?B?UnpvYlpoQVFFeUFGaXdBL2w4bmVieXcwLzlEMDM5MUI4YVZ0a0pMOHB5d01H?=
 =?utf-8?B?UUVmUnVvTndmTGVOYXFXUTdrSTRnV245SldBNjVXZ3ZqbVpJZ1RkWk1LM0JL?=
 =?utf-8?B?SmZOYVpqWFVzS0t2d2xlaEdmQ09VeTd6RnhRVDlqVkRmQ2orVnVpdGpnUTE2?=
 =?utf-8?B?Q3hTUGhya1NNSjY2MTNwNmFQRDJzM2Y3eG9NZXExVVcwYVJJYjhqd0JLUVpL?=
 =?utf-8?B?R1VrRHlZVURKZUNuUmNWS3kxNVZRL1RCeVYwdjlHRGJ6NTFhNlR4bUpqQnE1?=
 =?utf-8?B?MFI4akxKcmlZbkpUMGFWZ3NuRlVsQlJhYVRIK0Z5eVNxN3JqbG9ZOXkwUHhY?=
 =?utf-8?B?cDliaHFJcS90bDR2Y0Nxd2haZHRROGFCZnFJa0pwQ3ZxQ2l2cWFDS3NYUVl4?=
 =?utf-8?B?c0lvRUJIeVpuTGZCU1E2ZzI0TDhGeDZ0dmNaWnpuU1dCQ2ZzUGo4Mzd4ZVpR?=
 =?utf-8?B?cWpGc0hqa3ZJN2dlaDJRdHQrWEFNaG4reEp6U2wxSTVIc2pFUWJlTXpSbU1V?=
 =?utf-8?B?Q1FqUjVPakdZR1VwQVB5aG9ndlRidk14RHpsYVBLTHVFcHRySlJmTktHWTRV?=
 =?utf-8?B?cTN4QmhrNzMyME9GVEVpTHVYSjYzcnNFeC9wVlBxYXN1MXZtYlFpeWN5bFBM?=
 =?utf-8?B?Vkl3VHlmelNBc3Z6a2plMXRqL3huQ0dVU1FKK1M4WUVKRE05eWUwRXRVNDBY?=
 =?utf-8?B?RmErQkZnNjQzRU5zNGdLUExJajR4dlpUQzc4bWtiNzl2a1VxTHFYR2dScU9u?=
 =?utf-8?B?UzZ4SGFFZDc2SmNHZXJwK2JHMnVBcXlsK3dCWjFrakZ0K0lRRHNQSUgwRjQv?=
 =?utf-8?B?YmxORkhEb0VweTRQSkQzT2xaZ1RKR0p2Y1UzYW1VT2t3OWFLd2s0VHlRL0Ry?=
 =?utf-8?B?WFNRS1BDakdpOXdpenQvWEQweDJGeFd3WkdVMUFHQ1B5L1QwT1IrNS9DYmhE?=
 =?utf-8?B?UTUrSkNHVkpmNEJYQ1ZaVTNXSkdqNEJqNEZXT1NZb1BxbXovaXhZbFlTaGZV?=
 =?utf-8?B?aWRqNFJQUmQzbTV3SGpyOVkvY0lOa0VVcjBqdUZ3azJLU0tXb0JJZEJxRi9N?=
 =?utf-8?B?clA2ekZ3WU9KVHNWc1lodHZZNnpOTEhnc0twL2pFMy91MmU1amw0RzNTcEF0?=
 =?utf-8?B?ay82TjV0cUtiTm05SDRBdkN3TFJ0VE5Bd0tsNzA2N2duVDdnZlRFUDhWZ0JJ?=
 =?utf-8?B?ZUhUdXo4Q0FGT1luRkphY1VjQmsvTi80NUJNb1VoZ1ppcHkrRGtsdXRXRzJT?=
 =?utf-8?B?U3p2Zm5PYWZteWIweUNwR1VQUG9oSmtGdTJVcExMbEgwdGVWbDV3YUN6SDd0?=
 =?utf-8?B?d0xMTmt5Q1FLMU1BVk5jb3UvTENnWnBzc0d2VXpJbGIrRFhQeDFkdW8wRjU1?=
 =?utf-8?B?Rnk0U041dW5tTWpGalgzdTBydFBIdTU5ejRERG9abVpsSEJDeGY4Vnlxd2x2?=
 =?utf-8?B?VUZCSk1mRnZES2lxa2dXbmNvNitWZk5LZnJ2VXFsTUNNZnduQlFza2JEeDRQ?=
 =?utf-8?B?VXd4K0gySjNJWkxINkt5cDlGSm1Odkcyc0U5RDQzMTgyME1lU1htQWg0MGo1?=
 =?utf-8?B?MVBEUVFEZjJMSXRsNU1yRTVHK0RPVktwY0ZJMlB6Wkd0TU5oeVNDcCs3bkhu?=
 =?utf-8?B?eERLTEprOXhmdnhKR1RNZU5xK1N1ekEyT1FqT2NiV1pIakE4SlkvZCtVb0p0?=
 =?utf-8?B?YlZMVUV5dUV6ejBYQzc5T29ZTVlUZWYyd3Y4L0k4Z3dtZGFJNktUVjllZVBa?=
 =?utf-8?B?cVRqK2QzdVlKYklxc016aXhraHdHK25UQlhsRUtiRHVLVXRTZ0pJdU5GUmtX?=
 =?utf-8?B?b2dLZVJCbjZjTlFpandlMzduajBSc1JXaDRkSGRYVWplRkVKYzg0WXN3TFl0?=
 =?utf-8?B?YmhxdDBUZmpSakkzWE5pOWUrTUNsUklOdE4zeFlNR0RXcHlVU01PbWo3c1oy?=
 =?utf-8?B?QVZnajBlcEtyNHg4Q3p6cWFxSHh1R283SnM2L2lFZVFqL3ZYQ01SL3M5cUtm?=
 =?utf-8?Q?H5Nj7Sy5ViAY5XOD0msWtvW4eHRmf/4kKXe7cfIN9Xo2q?=
X-MS-Exchange-AntiSpam-MessageData-1: xWosOOTVEMjkzw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a3f0aa-8db9-426e-394c-08de4c514590
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 11:55:07.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvfb+ZFMuLFCNKCEo97+RVs5qk9U2WEniS5C8FWeRyutKWe0RHv8x3EHyUOfB8xLQrf9PVI/yr6QzkdmFSq/Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578



On 05/01/2026 08:39, Manivannan Sadhasivam wrote:
> On Fri, Jan 02, 2026 at 10:58:15AM +0000, Jon Hunter wrote:
>>
>> On 23/12/2025 06:45, Manivannan Sadhasivam wrote:
>>> On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:
>>>
>>> + Tegra maintainers
>>>
>>>> This driver runs (for both host and endpoint operation) also on other Tegra
>>>> SoCs (e.g. Tegra234).
>>>> Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
>>>> dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
>>>> reflect the fact that this driver is no longer exclusive to Tegra194.
>>>>
>>>
>>> I vaguely remember asking about this a while back during some other patch review
>>> and I don't remember what we concluded.
>>>> Thierry, Jon, thoughts?
>>
>> So ARCH_TEGRA means that this can be enabled for the legacy 32-bit Tegra
>> devices as well as the current 64-bit Tegra devices (such as Tegra194).
>> Given that this driver is only used for Tegra194 and Tegra234, it seems it
>> would be better to only enable this for Tegra194 and Tegra234 instead of any
>> Tegra.
>>
> 
> The dependency means, whenever someone tries to enable PCIE_TEGRA194_HOST,
> ARCH_TEGRA should be enabled. So as long as someone not trying to enable
> PCIE_TEGRA194_HOST for 32bit Tegra systems, ARCH_TEGRA should work fine and
> PCIE_TEGRA194_HOST is not selected by arch/arm/configs/tegra_defconfig. So I
> don't see any blocker with this patch. In fact, many other archs do the same.
> 
> But I don't like extending the Kconfig with per SoC dependency as it won't
> scale.

Yes normally it does not. However, in this case it will only be used for 
Tegra194 and Tegra234 and not any later devices.

Jon

-- 
nvpublic


