Return-Path: <linux-pci+bounces-44005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F3CF3622
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 12:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56EEA300819A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28BC31E0FA;
	Mon,  5 Jan 2026 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1hF00yG"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5431A07F;
	Mon,  5 Jan 2026 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614213; cv=fail; b=QYAjBhpUeKU5FIbYRkIcG2Iznz9mmprO/KPPB1CyATOf3d6WCWVTrvRroZFPGrHp4xQugkIP3GhG+u41X8lgBkAm7lqLOyF+6l/9XaQWQbVrNpvzribRK5VT+DqqR6xey+74pRdrigf10G8sXxc2TSW3Ww0LxeVYO/YZkVAp/AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614213; c=relaxed/simple;
	bh=taTKrM7jm4PtnP4o7/Xzpsx8t3NSrMy3lAI9lI5ZUr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iUWFNKfbEOfsj5luhh9HxEJagaRm6FBVqANUyIMVkHYOAY2WJk1eTp3Tpo0hEG7lQIx6+P6PGVuwelUHk9JJJHdsJEvg4lEHCARLPlHD/AaKYB9PItKFDmeb9UCAcwBzHDJrMUhcol43gyUuyn6hHUtgEKddv867PSBQQ4MUYjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1hF00yG; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6pDWO6r5UjZlb9OK/N+bydlciXbBMr6Icw2gjYuSsol8kQcOCjK1w1FYtiag6qh8lmcd4PN22ETXk6H22A+mrYpzTvodw3jDxK3QeeIUoQ0qlbKnicT1QiEviaqyyH0bnwdb/HuLadvfBQ17ODTW68kXUZvk3SwjvRM3M+oSZkKuXGNWL95AwVexETIjjYqwFnK7DI8uWuXYYPrRhZM22EttDjOK2mJnXw4XcyBMD/TOGIEMJk3apLKOMQXzAbp6LNh669ndlIZrqYKLfEekc4KiaZ/sjsz9+0NuZYzLNqkomFvZfpXo/ucymh4lSw3bbc5UpOV/U2TqWem6jA2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+Y3NPND3w2i55JwAykFa3/mdJ04az2DEXtfYiVia1U=;
 b=Odxp8T9hFIdQ7rZU1RVP+DDcTqjLCfYTI1zffn4Hm9JvMUeL3a5jjAW3MakxafoEuN2U66WM4Jb2vE5woADHBnXqQjQXrl4B8m93zeT/6Mrhn3cfCuUjRoE1qo4oGTJB4hENcXquAMQYdrOUWqU49yjYwOcpQhMt1BuBUKsahXjUPRIn9f06/L4qTvuQGPK3EfzIk1q09KX+c5+mD7jRj5LHX2yCQlZVrFCT9NoK8lJN0oUy1sX/oD15cX99AfqfLPX1tN3pS+ZBk4tAD52vjQBaiPX8bKADLEyN8WWp7KzCqhAYFDBY5EEsWva4hHW0dRh8O61QbKRQyWf3TI8p9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+Y3NPND3w2i55JwAykFa3/mdJ04az2DEXtfYiVia1U=;
 b=b1hF00yGdtPYfd1+FTB04m1qTS72Uq7NDKAD5EgW0RH0yHaw7RteWLo/9flMijBs+ygonI0rubfMuUdKkt2Z3CIVwP5eggP1qBZSnM/9/VSNszdJnQ67EH6W7X8fVOTw7dJ/LzWE2ham6mQ/PV6HOC2mLJV925sG8cieecZrtUPJm27kM6/wZD7AOJjmqPAgBXYKhdKBSEjpB8ixRb+e0JCRMuU8xnxsf9pdYEf94mDh0NAaAZ+f59NpKbX2MnzBpn8oDQQHlvXX38xbwPze8wvrTw64BJkp1Ju6KKDsfeOvpx5ia4CkYwTiP4gR7inM6b7VzgJNgYsRiakFxRLc1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH8PR12MB9791.namprd12.prod.outlook.com (2603:10b6:610:254::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 11:56:43 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 11:56:43 +0000
Message-ID: <7bfb3ebc-2e8b-4fcc-8d13-a6f3e0b7141e@nvidia.com>
Date: Mon, 5 Jan 2026 11:56:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
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
 <aVt_t3kxtT99wbwi@ryzen>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <aVt_t3kxtT99wbwi@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0525.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH8PR12MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: 83005e4c-4c00-4482-8f4e-08de4c517ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUR6d1RWQzVIY3hHUUNNTTBZQ0ZVVE8va0FML0hON1FPcEFDQzBJWjFnVXJE?=
 =?utf-8?B?UzVYQVBwbkdaTVlsdVdKOXFWb2lxelpRTUp5WHRmbTNwMUllS0dKb2pRS2V5?=
 =?utf-8?B?VzE4YXpmQ0hXUFRFSXMzRWgwVHFTY1g4bG1QT2tFTEVGTG94QTlrU2J3aFk1?=
 =?utf-8?B?eEVlSENUZXRORk9VYkNZNFF2Qi9QR3JWUU04b0h4YWh5RjNWTXlqMm00cW04?=
 =?utf-8?B?YVRiUWtGc0VDVmtLeStFSHJxbWl1S2JIMk5zWDJBd3JvVDhxaXZkaFk3VmJr?=
 =?utf-8?B?cVdSTVBCa1Rzb1F5NTZPZGRla1Y5OFF6UFpwWnNlcGt0ekxZN1Z2RkptQUZ5?=
 =?utf-8?B?VzlES3ErVHJ2UVQvQWJzR3l5d1ZsMnM4OExlNEoxYU1UNVVwSVdmMlYyVkNW?=
 =?utf-8?B?Nm9TUkdyVHo0TGxpeXpuS2pyUjljcnZVSzlUM2dmV0pxK1F1SXNXUzhGRWtW?=
 =?utf-8?B?ek9WblJhb3l6UDBGSk5COXFsWDRUaTlrcjJXSHVBUllBVEFHLzRSbzh5amJP?=
 =?utf-8?B?NnltTVEybDhTNmJkaFhxWmYyM0pjZFNSTWVtNGhKRW5IeFNVZHlIbUhjQWYz?=
 =?utf-8?B?OE9wZlM3a3hHaHJIMENsTUU4b1hmRUpMNk1UM2N6d1l3UFYyMFBLcEhJVEs0?=
 =?utf-8?B?cFUvaldQS25udERNUGIvSXRINFZWYW5TR0UxbHI4ajRvVWZxMGlqaVhxdGlQ?=
 =?utf-8?B?YWtQMEVGNS8vVTZ3cXhWT2lIN1NsaEI3c1dHVmJlTmJhMFZyQ1ZXc3lQMHAr?=
 =?utf-8?B?QjZqdlU1TSsvQVZpaUh2WVFjeXpkTXoyUWJDbitiY21SeXpTdndDaHJ6cTdR?=
 =?utf-8?B?anJtWURMYURITXZ3YWM0WS83bWEwcVIxcjM3ZEd5dmp2V3ZSaWpZd0N3bUtL?=
 =?utf-8?B?OGpqY3EzZjdIZkdwRGlwc3lWQk9kYjJVcnIwK1E3VFBiQzREOTdTWnk1VnhY?=
 =?utf-8?B?OFZqYzFnakNKbVM0dTlFVEkydElJdkRERGNZaXB0c2pnTDN4NHM5aEtEYlZV?=
 =?utf-8?B?YUdzL0F1blVSVUNvcjNwNU43ZmxmaEY3RG1lMDZWc0gxejNzNWZ1TmNLdkdF?=
 =?utf-8?B?c2ZNTTBTREt5WXBEUUl3cmF2WHBWa3g0b2ZHUU9ySVplTUs4cGFJMVJyUHM5?=
 =?utf-8?B?TW1PWDNFaUtBdW5qcDl1MmY2dWVRRGRGV0VyK2U4N1hIZTUxaDRheVhkYXJU?=
 =?utf-8?B?cVFiTHViZDJkVmovL2ZlQlZjVzgvRnBXZ3JoeGNES3d5VzZZYTVnRXpHN3RZ?=
 =?utf-8?B?T0hNdlE5N1ZLV1JJUExiemhPYkxCNUo1VnV4K1l6Wi9XbDdpWTlPbURnency?=
 =?utf-8?B?ZmpaWENGZEM5bDlzdWpYdy8vcWNoRU9VY2hMZE43c2FoaFNCRHBXQVpTNklD?=
 =?utf-8?B?U3ZRZnNpSS9xSHc4RC9JNTdpb2ZZdlpRb0RNNDUzRXBFMGM4S0JBQ2ZtM0ho?=
 =?utf-8?B?b0NJRnlXL2J6bld6dFdWbnF0ZU0zNFMwaW1DSTdCV0RKQjhGd1hDaFdVcWxa?=
 =?utf-8?B?OCszT0k5U3ZPWHVQemVUb3VmaytOSW1EL2VCZWFSQkwxT0V4bEx1YXgzQlpX?=
 =?utf-8?B?RS9UUXNQMG94TWZ0ODFyVGZSSG9yZ21tUG1Wcm91bGFZcWRpM3l3V0JXR1dv?=
 =?utf-8?B?T1RuYzF2MFRsR0dQcktkcHpQUFFldkhuSEFLSmJPbnR0ZG9Ub1FPVlBPRnd0?=
 =?utf-8?B?QkFEcVROT3dlUy82U24wN2hUdXo5LzhLL0FvQjBaYU1IUVcxY0RybEZZOGxa?=
 =?utf-8?B?R05YU05lYi83WFIvQlNRS1NJZTJvM3RJYzRsdlMrUG41ME1XWnRtUnQvY0xx?=
 =?utf-8?B?YllnaFNENnAyRUpHYVV1UVlXK2ZEVjY0SGliQ3c5aUp2blE2cU1jajZwcnRX?=
 =?utf-8?B?ci92UmNVL01CR1ZjbURxN0FMdlcwM0V3eFcxNjMrWlVWK0pJWTdwTWgvWTVx?=
 =?utf-8?B?U1EwaE84NnpCOU1sdy8yc1pXd2dpZ3RWTUI1dkEvcVpjWEs1aWJaaE5SSTF6?=
 =?utf-8?B?TDd6M2pGdGpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2s4NXBqUFRMeHk1MlRuZGx5em9MT1djWEU3TVNNOGpwVGZSMmlLYTRlNzZi?=
 =?utf-8?B?N0NNN0NHcVFaTERGWmZGTk0wK002SWJoL3RYeHlkYlJNMXhCZDd3cHNnZHdM?=
 =?utf-8?B?WU8wcnIzazFiSFJXSUxaOG5TWllEd21rcUZtQ2IwdFB6aHFzVnp3WWNlK0Rz?=
 =?utf-8?B?czV0VDJaK0pTWEpjMlIwT1B2L001VHl0ZTgvd2J5OVJZL3NGVHN2WVdtbzJp?=
 =?utf-8?B?eWhjTlU1Y1g2aWZRWlpQYThhdzlRU0FqeS9jbHo0dlNWTTZlUHNGMnd4cHFl?=
 =?utf-8?B?Qm1laFJsclM3MWZMdW4wOXpLQ3BPL1RaZHROMm5SK0EwcE1ldVZxbWZXSlZk?=
 =?utf-8?B?RWMxMDh3K1JTMEhJVmcxNE80MEczWm9XUkJNVDZxVDZpUHlmQXF4RE5SV2N6?=
 =?utf-8?B?THVuM3I5YTY4blFtSHNLSTRvNVd3MHdlOVpFNnZpTTh1c3V4SW1nUElMYW9m?=
 =?utf-8?B?SSttamlFQkJYWGZQVCtsa2RXVHVlVXJ0VlArTDN3ZUc0NkhibUpQTFNjaVEz?=
 =?utf-8?B?Z0l3YVhEWlAzRmZ6N3hXc1FwN2xlbjcrQ1lhN2NqYWc2cUU2b1d5QitFWGxy?=
 =?utf-8?B?NHIvNWxCZjI3Tk0yaGR5UHIzTUtoZjFzRW5NUS9mdEJIYUF2Y3VXWlJPRk9j?=
 =?utf-8?B?NDZKMlFNMzRYVGIwcEQ5VGo3SXJLblBBVjRMa2htbjJ4OHRIVXZ5UFg4TnFZ?=
 =?utf-8?B?YUtxMzY0UURYWVl3RnhSYk9sbzNuREUrSENFUzdibGhBckFjOUl2djJUOUc3?=
 =?utf-8?B?QU91bDM2NlFxNHV4MENZUFVDb2hvcWszUm1sTjNWekpsS2J5NEYrSUZ1NUla?=
 =?utf-8?B?RUFEdlFRelpRaXgvcXdtUkNIYmU0aE44MTZhcmNmQWVCNVJJWXpPS1ZCbUh0?=
 =?utf-8?B?UG8wWHl0UEMvUFdZS1U0MnhvYThYYlBtVG1GcTUrdFhXRkdSTTVEYkJMaTNR?=
 =?utf-8?B?aEdkNWpaUkN2ZjE4bEtPbVV1bDBKb1lBVEV1ZGgyNkJCQ2ZvR0haNGhReWQ5?=
 =?utf-8?B?NmhQbGtSZC94MWhEdnUvOEdLZUNRampXdXk1Yi9oTVdNbXFicmI4YlpuOU9l?=
 =?utf-8?B?VkhPbTFwS3F6UjRGaVA1dnNFTlVneFZiTldHZFZqUmNpTHQ0ZTc2cG9aYTVM?=
 =?utf-8?B?MlpnT3FERjk5L01xMk9kUEtBeHNYajRnTklITzZPU0x1akU1M0xVWmZ4MWl6?=
 =?utf-8?B?WHNrTWxCQ0lDM1h0dXBXNXIrUlBzS0d2b2FLR2VaV080WnZVY1VVTzNsdEJF?=
 =?utf-8?B?VTQ1T054bjQ0eVBQR3R5SnJnVllHTkxUalVpTHViU2VxbmppMGRFNlpWZHJn?=
 =?utf-8?B?UlBxckF0NXFwc0VXVmpuamZyN0dYU3lrWUxOeGJybG9QL0hsUWk3NHd4Q3Y3?=
 =?utf-8?B?UWtCRFRscHc1Q1RlUHYvak5hVFhQdXlUdzIyZTc0cy9KVEUxb3JMS0cwNis5?=
 =?utf-8?B?dUJnbktKY3hSbzNmZGlLMmpoNHB4NWNuQlFpM1pFdmZEZGc5RTVlKzNSNGhv?=
 =?utf-8?B?dlVWSW14aWRpUzNtSW9WM3lXVVdiajRiUlMrNkVIdFFlV3Z5aHpOV2FUMTJT?=
 =?utf-8?B?TktXd3RIVDJuc3M5a2JOSG1UWkYxcE5YRE9zZDI2elRyU2w1NDB4ZmhUSnRN?=
 =?utf-8?B?Yi8zeStzd1BJdWQwajlyNDQ1LzBHenlJcmIxc2ZFemFuVE5EbzZDYjl4bEpF?=
 =?utf-8?B?d0hTOFZIcEZMWHAvb1U4bVcxTkQ2WDNuL3A0SHVraGVUNWhZdGxQTFpHTTRy?=
 =?utf-8?B?blpmYzNodkhwQlkyMEZEK0xYSmNqMUN4R2YwTWkvZC8ycnNxcDduRTkxNHB5?=
 =?utf-8?B?RC93UythVHowMTVlR1lUNXFCUVZaWTBJNVVocHFrNlVkY1ZsVHFwTU9OZi9T?=
 =?utf-8?B?Qkk1YkcwV0xycWtrT0kzUExHQnh3ejBwRVhhZkFKUlRUdWFkMWdXZkUxNHYw?=
 =?utf-8?B?d0VSOXp3azFFMmhlZmtlY2hGdjhTcEdubERHYkNaazdFWS9UQi93OWl3TkFW?=
 =?utf-8?B?Y3A1QWE5RXNOTHdaREt1YU5iZEdta1VXcmo1MnUxSDBnRDk2c0FCU2RlOXNG?=
 =?utf-8?B?SGJmYzBLSVZxWmFROVZaS1J3V0dEcHFGWnYyUG5rV1hzczRPTDVRUndSQVEz?=
 =?utf-8?B?OTd4cVJxMkpsUC81bFZPUWM3THp2NkdKRXdSaWM4Z3d3STRKMjBweHpNeFBD?=
 =?utf-8?B?blpzSzlkeW5ubVNBbGsvUnd3TnFtQ2tXMkliTXh1bDVMcVRqMEpkbkVVT3oz?=
 =?utf-8?B?TEl0dlRVVmJwU0h0MkZLdEw4ckhVVVRSUU5RZWF0ZGhWYzRWaTVlZnZUdDBu?=
 =?utf-8?B?cFc3OXhoOHk2MlRXc3JZa01iMmM4ek51VGVqdlN3emZpaHFmU2R4QU91cVI3?=
 =?utf-8?Q?bDr1Smbe6F7WMJeQ21AK22SjLP3tsO2AknDYaI0v/rx7v?=
X-MS-Exchange-AntiSpam-MessageData-1: kZNj+Dgc8Oq/LQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83005e4c-4c00-4482-8f4e-08de4c517ea1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 11:56:43.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cW8U3fDYXbXY4XNGPpAZM2gLk1esfrBvRDF2OHAZmdLsLx2NrviachqBMyB2kuO013ETvnaZqUN5ww9YHxnb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9791



On 05/01/2026 09:09, Niklas Cassel wrote:
> On Mon, Jan 05, 2026 at 02:09:34PM +0530, Manivannan Sadhasivam wrote:
>> On Fri, Jan 02, 2026 at 10:58:15AM +0000, Jon Hunter wrote:
>>>
>>> On 23/12/2025 06:45, Manivannan Sadhasivam wrote:
>>>> On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:
>>>>
>>>> + Tegra maintainers
>>>>
>>>>> This driver runs (for both host and endpoint operation) also on other Tegra
>>>>> SoCs (e.g. Tegra234).
>>>>> Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
>>>>> dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
>>>>> reflect the fact that this driver is no longer exclusive to Tegra194.
>>>>>
>>>>
>>>> I vaguely remember asking about this a while back during some other patch review
>>>> and I don't remember what we concluded.
>>>>> Thierry, Jon, thoughts?
>>>
>>> So ARCH_TEGRA means that this can be enabled for the legacy 32-bit Tegra
>>> devices as well as the current 64-bit Tegra devices (such as Tegra194).
>>> Given that this driver is only used for Tegra194 and Tegra234, it seems it
>>> would be better to only enable this for Tegra194 and Tegra234 instead of any
>>> Tegra.
>>>
>>
>> The dependency means, whenever someone tries to enable PCIE_TEGRA194_HOST,
>> ARCH_TEGRA should be enabled. So as long as someone not trying to enable
>> PCIE_TEGRA194_HOST for 32bit Tegra systems, ARCH_TEGRA should work fine and
>> PCIE_TEGRA194_HOST is not selected by arch/arm/configs/tegra_defconfig. So I
>> don't see any blocker with this patch. In fact, many other archs do the same.
>>
>> But I don't like extending the Kconfig with per SoC dependency as it won't
>> scale.
> 
> We already have a patch from Vidya:
> [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
> that was sent 2025-05-08
> 
> Back then, the reason why it wasn't merged was because it required a
> similar change to the PHY driver to go in first:
> https://lore.kernel.org/linux-pci/174722268141.85510.14696275121588719556.b4-ty@kernel.org/
> 
> The PHY driver change was merged in v6.16:
> 0c2228731974 ("phy: tegra: p2u: Broaden architecture dependency")
> 
> So, I think we could just merge:
> https://lore.kernel.org/linux-pci/20250508051922.4134041-1-vidyas@nvidia.com/
> 
> (Assuming it still applies.)

Yes it does and applying Sagar's patch is fine with me. So it you want 
to apply Sagar's patch please add my ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


