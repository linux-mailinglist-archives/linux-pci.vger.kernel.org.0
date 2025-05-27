Return-Path: <linux-pci+bounces-28438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE29BAC47CC
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 07:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819EF1893AC0
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 05:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9951D5145;
	Tue, 27 May 2025 05:50:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021080.outbound.protection.outlook.com [52.101.129.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727713AD3F
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325008; cv=fail; b=Oh+LHjb/bjA1oGHP8vubfiETyVgRWahLxOGgSP6AuMz7yopJmsTl1AA6iRd3yO+jYbeMf1QCZHLCA+V4Jm6pGOH6isqQa9+W2fESlxlNlVT6P/3VRnjFFXJ8No0ZPL1DCiO+YbQKwg5bHB5SXkhkDcrjCpmOKcOP24ba+dRjUng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325008; c=relaxed/simple;
	bh=rzN41XowvwPDnkkV87NJLsQuYZn8TgNrRTebcTa+LPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxx0PREGqZTAKKm5YqbOLYMw1S/uJ+MvzgWECYm4hEOkOY978WePuWrbsQKDbWFobrxJJ0tApRhwGskpmNoKLCCSSesOduY6ZbBi5DF7KrCJXuSIEkFFiEVjHP9+EaVH5T/4URqgQRs2dWFufi+x4wZqGDrm8tsNWfkhWEWvZPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEWmJkaby7GqNRAAz56+gllfim0qicOm14SumICZCkjWLABcR3nd60Mtea/fHUuvDOo9ohNvCp0so2YuvP9U/A02zDuFNIwWys04CWXYA7STbW6IP+sEt77D8pL9Zkn1b0+II97170ucnCbz47+izGuM5ambP79+Jx1QXPaQ94NzMAbi7DmUDSzLkaMTzk+XI+JWJ0n5dX/BLr59wT8fL6XEbeFCRLtWfS4OVkZITRSkcx/Qs3Q5s8hxJJ6lOZF4cXHuucku67DaAh/oU2Gi3nZ4gZUGQoI2trPG33k4z6XcMNZjsOXm3EHIt7Cpbl8R0tp5Q77nmaNNyDsmkf5WeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OrrB3ImCCsbdSScX4P61dXRjg3D5A0TZ1e7zmgAd4Q=;
 b=llHjeD39wl3Xl6slZUuGJeQiy7WJ5A4LERfALDVB99/fWLfb5VZ6HpWhIplJjpeQQFc0GLftLvL7Z0siCHNCiOp7/Aye7BiGcfp8Q/Biv2quvQ6kXD9T50Dptq2mAh/K7jFheHiR97HODPcCMkieR/UM7aS8yaKcA53HDKVtCD9BrKhjuvdd+TTE2warQOPF1Bhoid+ZQ86U7gdOpNzjCXw0tcOe0AOf3c/EmxLo/dQijuag6brs5R4OquFxW6D9SeCRgFucFLZKTj4ae55XheSVUUveudZ114/YWbo5MSLClLqnVNizyJIbRGxqDk+3PyjWj+qbeay05LZyQUDTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=163.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:178::21)
 by TYZPR06MB6216.apcprd06.prod.outlook.com (2603:1096:400:332::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 05:49:59 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:400:178:cafe::54) by TYWP286CA0016.outlook.office365.com
 (2603:1096:400:178::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Tue,
 27 May 2025 05:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 05:49:57 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3B6DC400CA08;
	Tue, 27 May 2025 13:49:57 +0800 (CST)
Message-ID: <9c52c87c-236b-4e8b-b40f-92d5f39f944d@cixtech.com>
Date: Tue, 27 May 2025 13:49:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
To: Samiksha Garg <samikshagarg@google.com>, Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
 ajayagarwal@google.com, maurora@google.com, linux-pci@vger.kernel.org,
 manugautam@google.com
References: <20250526104241.1676625-1-samikshagarg@google.com>
 <39743267-6a2c-4a5a-9581-05b03e25477f@163.com> <aDVCronBm32GwF77@google.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <aDVCronBm32GwF77@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|TYZPR06MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: d7684a12-5f91-421b-8fb3-08dd9ce25068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFlkTis0cUR5Qmlwb1NFNE11c3VyRmQ3aWZNck5EWGg0TGZyMUZ6eEY3RFpt?=
 =?utf-8?B?NlB1M0lDc1UxaTNyUXdrYVZ6ZUVhNkJwNzVkQ00valRWaWE4UFZocERxMEw0?=
 =?utf-8?B?TnAwUVFDb29nTUNGd3B0VFIxQ1prTnRCdW4xdzZ5RUdmbEJ6Y1JLdXVTdU0x?=
 =?utf-8?B?eVoybnZRZHdYSEU0ekNXemk1WjJhWkJpVHlmcWFuYlpHR0Q5L3BHdFJQNGxH?=
 =?utf-8?B?c0NwdlJ1cll1OG9PMEtCM1BLTnpDV1FNN1ZCVG04eFp4WGpCWm5nUVlOWVhy?=
 =?utf-8?B?MHgxLy8zNVU2VXAwbU81NFV6VXphZDk3Qm13Zk1xTUxVOXVmSU1iQWtmcVpu?=
 =?utf-8?B?c3QvT2IxZWE4bEhwbU1uRU5UN1RibWNDbGtGUlkrd0pyNHhZS3lvODJ6R2lT?=
 =?utf-8?B?LzhoS3ZKdEhnRUt3Z3JkRkxhejJhYkhQOCsxd3djaDc4RDBKU0ZubnMreU5q?=
 =?utf-8?B?cDRCRTdtOHRSeVJ2STlodUROa2ZrQkhCYnVLeUpYL0tSNXV5djFPb0FQZ2pk?=
 =?utf-8?B?K0RYY0JQdzViZytUNGVRckQ4QlovNHFNVlNVS2N6WnJjRVVoSUhpRXlmOElT?=
 =?utf-8?B?NGdBVzJHcFZGSGV5Tlk5RUM1b0RmVm5OQThhVm4xUkpCK1BTb0JVZE4ySHVa?=
 =?utf-8?B?S0lVMy9RTkM3TEJqblZqVk16N0JneDhqamltL2ZGeE55dVNkdURUZktWcXhh?=
 =?utf-8?B?b3ZHSDREOUwzUkdGVEJ6VnAxcEV6OEFvenZtZmhGL3NYZjlBQUJSLy9SSStU?=
 =?utf-8?B?N2tIUVAwSnFHZGZtUC90QXorVVdhSzBpa0wra1AyTFhkRzRWbjZCOTY5dG9H?=
 =?utf-8?B?a1p0dUVIckZHQnE4UmZVQ0dmWnowNENDdkgvV2ozaTl1UVpCbEU5WThwYzZs?=
 =?utf-8?B?dW00T056c0puaGwrdkhEcTU0dkpySHNkM1hNYVNMeGw0T1JWRDRPSzVpMDNl?=
 =?utf-8?B?aXY2QlVZRkF5LzNhY2ZKZFpnTFhMZFJCczZJQUduTlRody9aKzVubEt5Q2gz?=
 =?utf-8?B?SVk1V0Zyd0JMSWd3RmFtMktCQWF4K1FRL2p1UkJELzZQbHdldmVFRU52OG16?=
 =?utf-8?B?WlJzWkx6RGVRVTBycWNYdjh0ZTNDaVl0SitsMXc0SmZFVW1HRHdEN3FNVEt1?=
 =?utf-8?B?MjJDZjhHTTVjYTFoa1FjUVhEZWpxdW44OUdLOWVHN0tLSGtMcElPTUhRK0M3?=
 =?utf-8?B?OWJrQXIvTmpoMEJpSXdPUUQ2ZUFsenNWN3Jtd3dWenV4dWxlU2FRQjQvdjho?=
 =?utf-8?B?UXo3QlZMSGFvZ09qdzQ4ZTFHcTg0MVVkODFpUWFwSVBDN3VVS2VkdWxLakJl?=
 =?utf-8?B?dFMwMXFmM0ZyRTBwY0JoTkI4U3JzRjdjdDVITVhXTlJRb0hPT2NYckNUTUNT?=
 =?utf-8?B?WThoVnczR2tqQnpBeVVWc3Zha0dVd0xoNVZiYUFKS2JWOE15RXZzak0xV3A4?=
 =?utf-8?B?TUZ3VkIrbDF3QklPY3RaQ1hSWEh6WThRdnVTSWFSZlliSk8zR3owd2pTb1NQ?=
 =?utf-8?B?am1vMTJpYlFVTXIwb29HM2dsMXpXdmJGOGdkVDZidnBHZVJpSWFrTmRjTnNn?=
 =?utf-8?B?TUVGVERlczU4eFBnbFArcC9wRkpBcFhwdWdUT3BKcmxDSWtoa3h1Yi9SZWF1?=
 =?utf-8?B?NmtueUhhWEg4S1Q1WUJWVnhEcm1DTEwwMjUxcW5KdUNiRGlha2R2NVFrcUpa?=
 =?utf-8?B?K2dodHJTUWlOZzhKSkNBM1pTWUgrekZyUlZDTUNHN0NBMjFQY0tzbG8rZ1l6?=
 =?utf-8?B?YkRSeTVSanVRQkp3QlVyS0tVQUE5TGpUYXM2TDRFTEttZFZLY3pYdW1QZE41?=
 =?utf-8?B?NFN4Z3JxU2ZldkxOVjErVWpTWVNVeDZjM1BsQWxYckpkS3ZQZm5BMXE1dmpR?=
 =?utf-8?B?QXFlQ3dHeUxKN2EzR0dIcE9Welcwamxha0dLTmFLejJtTXBmQzYwcTFpaEZI?=
 =?utf-8?B?VWVKN25rRlowdFU0d2NvMktObWZldVAyZHlwQndpRzhuU2htRnBUSktxRkFI?=
 =?utf-8?B?cElBa0hTRFNiUm1JRkVFZ3kzeW45dXg2Q1VaSTUwdGs5TlRjSElFQjA4cjNq?=
 =?utf-8?Q?Z9DTDW?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 05:49:57.9983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7684a12-5f91-421b-8fb3-08dd9ce25068
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6216



On 2025/5/27 12:42, Samiksha Garg wrote:
> [You don't often get email from samikshagarg@google.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> Hi,
> Yes I understand that `pci-keystone` is currently built in,
> which is why it can use `dw_pcie_allocate_domains` without
> the need for symbol export.
> 
> My intent with the patch was to make this API accessible to
> other out-of-tree drivers that rely on the Designware core
> and might have similar want as `pci-keystone`.
> 
> Since `dw_pcie_allocate_domains` is already non-static,
> exporting it could enable consistent reuse without requiring
> duplication or workarounds.
> 

Hello,

Just as Mani said, you need to upstream your Root Port driver. 
Otherwise, too many APIs need to be exported.

I have also encountered this kind of problem of yours. Actually, I think 
the dwc driver should be compiled as a module so that many SOC 
manufacturers can modify it by themselves. Otherwise, for example, 
Android GKI cannot meet the requirements. My previous approach was to 
copy the entire dwc driver and rename all the functions. Finally, it is 
loaded in the form of ko.

Best regards,
Hans

> Thanks,
> Samiksha
> 
> On Tue, May 27, 2025 at 12:29:18AM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/5/26 18:42, Samiksha Garg wrote:
>>> Hi Mani,
>>> Thanks for your response. I can see that pci-keystone driver already calls this function.
>>> Does it not mean that there is already an upstream user?
>>>
>>
>> Hello,
>>
>> pci-keystone is build-in.
>>
>> Best regards,
>> Hans
>>
> 

