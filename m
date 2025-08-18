Return-Path: <linux-pci+bounces-34192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B56B2A14F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C51A5605BA
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 12:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26351EF36C;
	Mon, 18 Aug 2025 12:07:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022087.outbound.protection.outlook.com [40.107.75.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D007326D60;
	Mon, 18 Aug 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518842; cv=fail; b=ZmrT/WPWEBNdfrN4tHgWnMrnM6KP1Vt+MoDS6BJRAQYqlmMTTa+AdQuGadacz1L6ZFyKrFy68UXxVZhmvSdNOZUCjNFsHZNY4g2z3bUrtDbN0YY0/3oXBWcBelwvUpkCUadEcohMIah67sOQY6PlgwAKv6ZaHGHO6Eamw1dv2JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518842; c=relaxed/simple;
	bh=UTG/zGxKDgE017witw9wNzMfHuJZ/ERJ5z3wnU7PStk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H82/w4l18coBQMhA18N1sGCwY0TDfseHYBfsko/FE8uN+JlKotPBq3TK+/zTv5VeVRMSzApU77TmKLKAyu/n+SPGasNB9DbQs0/m7D9OVMlbAiJQ+A4+PfOfOSD5T28gIiUzGTPglyRsk6Sd2OTUI/9XMVumNWEyW70p5bS0o/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4vVxtihQ2lMbBCAWcISnmyl5a+aMrNZ1bGWXyGFuVAGqMUIWynsyfxV0MYJssi7oeQffWNs2LjPHLOYR3D+YfV/YQ21y/RDLjDAC2iaNJhria2pPW3q5FqjauXsvUWMh87Xj+li3BKWaC3e/xEGZHiyZjmhjp1M+pdMkAXsqM8plHuFUfVv3UQoVG7hLZ80hGn2CvgspgH93sVllqBGbLmKMZyjQwJpb30ImwaoC5JVuWpxEDItkawWtRhuxlBD05WFlX4bJeQzSDTAXU1Z2WqY2g47IMo7u0DjcssosQzomEfXbWFOQ5Lu8Wauhjak38gtKy3cMn9jGI4onyV7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft7KGbguQ6Sf5nu0OCAls333k4UH+PyBiI8OJv6ZzHc=;
 b=ELhLQBwEg4P8aj/Q2qn/N5t8ONwRxaA+h6oKO3nXWtOCY6kY5pY8/p944gh83QbyxMaSO2YwN0U7/aeB2yg0Wd7sa8nfBSDuA/vvuEV80hp18BZBJhaHeYI9NUZEKQ1HeBvWwgEkhoRPWGKaqTipwpyANTGnbhgfcETx9Kxez9ka7ArlCAjLhrP6Ma0CplVAJ9fcQPqxdkerAEmS5RhlxYL/qIa/UWOOdbORKRC7RZ2tfpamOzdrFfiYgdhPUVv/yqfcpD4uN7FURiBDx+RJY269+p8/XasvgBPKQfYLrvGoG65c2M5bLNl5PLErjYLTgMS1ihyLgx7+/7LKBwFa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=163.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR0101CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::16) by KL1PR06MB5993.apcprd06.prod.outlook.com
 (2603:1096:820:d1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:07:14 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:404:92:cafe::3f) by TY2PR0101CA0004.outlook.office365.com
 (2603:1096:404:92::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 12:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 12:07:13 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id F31D840EEE9D;
	Mon, 18 Aug 2025 20:07:11 +0800 (CST)
Message-ID: <7018d38e-69c7-4566-a48e-037e401134f9@cixtech.com>
Date: Mon, 18 Aug 2025 20:07:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI/bwctrl: Replace legacy speed conversion with
 shared macro
To: Manivannan Sadhasivam <mani@kernel.org>, Hans Zhang <18255117159@163.com>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, kwilczynski@kernel.org,
 ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com, robh@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250816154633.338653-1-18255117159@163.com>
 <20250816154633.338653-4-18255117159@163.com> <aKDmW6l6uxZGr1Wl@wunner.de>
 <35f6d6f3-b857-48cc-b3cb-11a27675adfd@163.com>
 <cm35xzxgdepgxe3swq3q7pu6ikj7oqn7oihooldaj6dehzozng@ddyr7q3q55d2>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <cm35xzxgdepgxe3swq3q7pu6ikj7oqn7oihooldaj6dehzozng@ddyr7q3q55d2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|KL1PR06MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b8c2a0-c8cb-4fd9-edc1-08ddde4fc492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnByVklMenZDMXh3bUE1UzFyVVR2TEZaTG9FV0k2Z0JwbVl3cURJWXhOcjdq?=
 =?utf-8?B?aGR0N25HVXJ6YmtEUWM4M1prOW1oMW50VGJXSHY5dm96WTR1NGNKTXIxdGZO?=
 =?utf-8?B?c0tXVWFQT05UaU1HY2tJTjB5Q1g2bFRIUUJSb0ZzbXZZRExleFJ4bC9oMEY4?=
 =?utf-8?B?dWUrRlJMbzVQZTZSdkQraG1aNXExczFscGhyV2syNTlkVVRRL0pJTE5Ed25X?=
 =?utf-8?B?dFJsMHVnRHNNRWh5R1QvMm9iNzByKzlDbWNqTmVxYmtQeDZSdlFtcXllRlJx?=
 =?utf-8?B?TTRsbHAxbjg1T01JTGdTR0tsc1RKSWJCbFplTXdpaWZKaUdKSDZDN0hZc2kz?=
 =?utf-8?B?djdJRTIxY01oUlZ2N1RhdlM4ZnZpNHFqYnkyY0FwaExXV2hzTkJWSlh3cVhM?=
 =?utf-8?B?Q2h6cjRpZHlJTVYra3JCV1hUZUhDazlFOFNPc3NMRHlYam90WGtLenBaRTVL?=
 =?utf-8?B?QnVkcC9QbUt5REJzZGRscHZTRjZKblgxaFJTaWRNd2p4TmlqUXJPSWxFVFNl?=
 =?utf-8?B?eGtKam1zcEVpaGtaUHA3MzNiSzcvVzVsNUUyVE4zNGtGZ2pmdGxDc1FuVlFy?=
 =?utf-8?B?allyeUNzUkVya3MvR1E3Z0QwcVNNT1d6YnA0UTVmWW9xZG40bWQ5QWhsYmlr?=
 =?utf-8?B?SWMvdlFXOUR3ZUNzQ1d4c1E1Z243ZzdCQnpJNndUOW1WNDJJKzlTVll0eXNz?=
 =?utf-8?B?aVViTCtHUGY4RmYyK1Ayalk3TjE0QXhiRFY3RXNyMzNWRkd5TE1VSUxLT0tZ?=
 =?utf-8?B?Zk5tb0M4Y1hBYlNvc3I3SjNQRFdrVFNsRVRMc0RaWGZSeFN4aUZ5TndUUmc5?=
 =?utf-8?B?b1c3VVpCUHIzY3BZRnpiSG5UMGx0cGVLUG5oWTA5SFJHTHNSQ1dhRm5WVlJp?=
 =?utf-8?B?cHdrbWtMSHQ5b2NhcmpZTE44dTlBK2NPaVNCUmIvTGlvNTU3OSs0am9RbDBV?=
 =?utf-8?B?dzZOUlB3NStHaytGaEt1M01WbjRHRTYrbEhoTDB1K0tyQnk4aHp6THkzN21w?=
 =?utf-8?B?ZURzYkNxcytqS3hUakpoU1VrVnRLM2svRFUzNnNESVZyYkNRUE1mWGZTT1hj?=
 =?utf-8?B?Z29iOVNUakxEOWF4V3dSRG1Wc0YyQ0pBM3RlZVV6SDZFTDI5Y3E5ZjFtcFlO?=
 =?utf-8?B?eENQbzNiOW9YOHNFMEpJOWtaalVZUDdaTzZ6Sk4xdlRtNy9wd1BiakxDbGx1?=
 =?utf-8?B?SnVPYUNzZlpoSXlqYk1TWjJWRDh2OVV3MkRLNmNuYXRHZW5Uck5NWGhoWWQr?=
 =?utf-8?B?MWhyZlZOZWdXOGwvN1dwZ0NBanppcmdFRDJoVXEzNXJ3Qm95SWp1WEZYNy91?=
 =?utf-8?B?MVZVV3UrdmZ0dkMyMmlYdVpIWDRlNDZXVGllejZOVE9lK2w3TVQxbGNjZHBp?=
 =?utf-8?B?R0hyWU1XeVJXYkhmUEtTUHcrU1IzRUZjSnZBeDF6NnpmOWdjTjFLVXRHZmpQ?=
 =?utf-8?B?RisxOElIbU5BYjgxVVIrWWpSRzliS01NSEt0bHRqQlNZdForc01xc2NPZ0F5?=
 =?utf-8?B?MmprZ3J2NkV0QzlRVDVWSWsrR3RUNUI3Z1NLMkZpdnQzdXN6VmNkRHlBVkMw?=
 =?utf-8?B?NGk5eDg5dXhwTzBjOGJMV3lCQ1cxbmVkS3RSTnJVakJVaEQ0S2Roa3dUQndx?=
 =?utf-8?B?bVBFQUdwWmlwdnJvTTIyRmFIcUlZckI4OUR1U0dyVGpFVG9yMHp4UDBrUStQ?=
 =?utf-8?B?UFdLL2ovVTNPRmdSc1NFdVdFWmJpOFlDTWtxMHhwNkVuc3Y3VWhocE45Ri9M?=
 =?utf-8?B?azRHb0xOSG93akUzYUQrbHFpcFBNSFhBK3prMitlanFYc2EvQm5DR1dZZlBq?=
 =?utf-8?B?dGZVTnExWGlaaGJDbXZqKy9tdlFJMXVyQS9DSko1eGZhSVRRWmNST0hER2I5?=
 =?utf-8?B?WWVsMFhhSjBnMlIrRmIyajJXeVJHSjlkQjBqbklka0hmSUZOZ1NpZ2NpeFp6?=
 =?utf-8?B?aDE5UWZvT0ROT09rWk5QNENGNG5wMjA2R3VNV2QyNFA4QXBFeGRqL0JrclZD?=
 =?utf-8?B?dzd0T1c4QTdWdkJQb1hlVFFHaXdjSzlja1Zjc0tsSmhoWklZUlBYdFJ3MWhp?=
 =?utf-8?Q?imo+r4?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:07:13.6138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b8c2a0-c8cb-4fd9-edc1-08ddde4fc492
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5993



On 2025/8/18 13:21, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Sun, Aug 17, 2025 at 11:02:10PM GMT, Hans Zhang wrote:
>>
>>
>> On 2025/8/17 04:13, Lukas Wunner wrote:
>>> On Sat, Aug 16, 2025 at 11:46:33PM +0800, Hans Zhang wrote:
>>>> Remove obsolete pci_bus_speed2lnkctl2() function and utilize the common
>>>> PCIE_SPEED2LNKCTL2_TLS() macro instead.
>>> [...]
>>>> +++ b/drivers/pci/pcie/bwctrl.c
>>>> @@ -53,23 +53,6 @@ static bool pcie_valid_speed(enum pci_bus_speed speed)
>>>>            return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>>>>    }
>>>> -static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>>>> -{
>>>> - static const u8 speed_conv[] = {
>>>> -         [PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
>>>> -         [PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
>>>> -         [PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
>>>> -         [PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
>>>> -         [PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
>>>> -         [PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
>>>> - };
>>>> -
>>>> - if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
>>>> -         return 0;
>>>> -
>>>> - return speed_conv[speed];
>>>> -}
>>>> -
>>>>    static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
>>>>    {
>>>>            return __fls(supported_speeds);
>>>> @@ -91,7 +74,7 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
>>>>            u8 desired_speeds, supported_speeds;
>>>>            struct pci_dev *dev;
>>>> - desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
>>>> + desired_speeds = GENMASK(PCIE_SPEED2LNKCTL2_TLS(speed_req),
>>>>                                     __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));
>>>
>>> No, that's not good.  The function you're removing above,
>>> pci_bus_speed2lnkctl2(), uses an array to look up the speed.
>>> That's an O(1) operation, it doesn't get any more efficient
>>> than that.  It was a deliberate design decision to do this
>>> when the bandwidth controller was created.
>>>
>>> Whereas the function you're using instead uses a series
>>> of ternary operators.  That's no longer an O(1) operation,
>>> the compiler translates it into a series of conditional
>>> branches, so essentially an O(n) lookup (where n is the
>>> number of speeds).  So it's less efficient and less elegant.
>>>
>>> Please come up with an approach that doesn't make this
>>> worse than before.
>>
>>
>> Dear Lukas,
>>
>> Thank you very much for your reply.
>>
>> I think the original static array will waste some memory space. Originally,
>> we only needed a size of 6 bytes, but in reality, the size of this array is
>> 26 bytes.
>>
> 
> This is just one time allocation as the array is a 'static const', which is not
> a big deal.
> 
>> static const u8 speed_conv[] = {
>>        [PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
>>        [PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
>>        [PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
>>        [PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
>>        [PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
>>        [PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
>> };
> 
> [...]
> 
>> drivers/pci/pci.h
>> #define PCIE_LNKCAP_SLS2SPEED(lnkcap)                                 \
>> ({                                                                    \
>>        u32 lnkcap_sls = (lnkcap) & PCI_EXP_LNKCAP_SLS;                 \
>>                                                                        \
>>        (lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :  \
>>         lnkcap_sls == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :  \
>>         lnkcap_sls == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :  \
>>         lnkcap_sls == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :    \
>>         lnkcap_sls == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :    \
>>         lnkcap_sls == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :    \
>>         PCI_SPEED_UNKNOWN);                                            \
>> })
>>
>> /* PCIe link information from Link Capabilities 2 */
>> #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
>>        ((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
>>         (lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
>>         (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
>>         (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
>>         (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
>>         (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
>>         PCI_SPEED_UNKNOWN)
>>
>> #define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
>> ({                                                                    \
>>        u16 lnkctl2_tls = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;              \
>>                                                                        \
>>        (lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :        \
>>         lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :        \
>>         lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :        \
>>         lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :  \
>>         lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT :  \
>>         lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT :  \
>>         PCI_SPEED_UNKNOWN);                                            \
>> })
> 
> No, these macros are terrible. They generate more assembly code than needed for
> a simple array based lookup. So in the end, they increase the binary size and
> also doesn't provide any improvement other than the unification in the textual
> form.
> 
> I have to take my Acked-by back as I sort of overlooked these factors. As Lukas
> rightly said, the pci_bus_speed2lnkctl2() does lookup in O(1), which is what we
> want here.
> 
> Code refactoring shouldn't come at the expense of the runtime overhead.
> 

Dear Mani,

Thank you very much for your reply.


Could you please share your views on modifying PCIE_SPEED2LNKCTL2_TLS to 
the pcie_speed_to_lnkctl2_tls inline function? Or simply put the 
pci_bus_speed2lnkctl2 in bwctrl.c into drivers/pci/pci.h?

Previous version modifications:

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..b5a3ce6c239b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -419,6 +419,15 @@ void pci_bus_put(struct pci_bus *bus);
  	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
  	 PCI_SPEED_UNKNOWN)

+#define PCIE_SPEED2LNKCTL2_TLS(speed) \
+	((speed) == PCIE_SPEED_2_5GT ? PCI_EXP_LNKCTL2_TLS_2_5GT : \
+	 (speed) == PCIE_SPEED_5_0GT ? PCI_EXP_LNKCTL2_TLS_5_0GT : \
+	 (speed) == PCIE_SPEED_8_0GT ? PCI_EXP_LNKCTL2_TLS_8_0GT : \
+	 (speed) == PCIE_SPEED_16_0GT ? PCI_EXP_LNKCTL2_TLS_16_0GT : \
+	 (speed) == PCIE_SPEED_32_0GT ? PCI_EXP_LNKCTL2_TLS_32_0GT : \
+	 (speed) == PCIE_SPEED_64_0GT ? PCI_EXP_LNKCTL2_TLS_64_0GT : \
+	 0)
+
  /* PCIe speed to Mb/s reduced by encoding overhead */
  #define PCIE_SPEED2MBS_ENC(speed) \
  	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \




Current modifications:

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..d6c3333315a0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -422,6 +422,28 @@ void pci_bus_put(struct pci_bus *bus);
           PCI_SPEED_UNKNOWN);                                            \
   })

+static inline u16 pcie_speed_to_lnkctl2_tls(enum pci_bus_speed speed)
+{
+       /*
+        * Convert PCIe speed enum to LNKCTL2_TLS value using
+        * direct arithmetic:
+        *
+        * Speed enum:  0x14 (2.5GT) -> TLS = 0x1
+        *              0x15 (5.0GT) -> TLS = 0x2
+        *              0x16 (8.0GT) -> TLS = 0x3
+        *              0x17 (16.0GT)-> TLS = 0x4
+        *              0x18 (32.0GT)-> TLS = 0x5
+        *              0x19 (64.0GT)-> TLS = 0x6
+        *
+        * Formula: TLS = (speed - PCIE_SPEED_2_5GT) + 1
+        */
+       if (!WARN_ON_ONCE(speed >= PCIE_SPEED_2_5GT ||
+                         speed <= PCIE_SPEED_64_0GT))
+               return 0;
+
+       return (speed - PCIE_SPEED_2_5GT) + PCI_EXP_LNKCTL2_TLS_2_5GT;
+}
+
   /* PCIe speed to Mb/s reduced by encoding overhead */
   #define PCIE_SPEED2MBS_ENC(speed) \
          ((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \




In the future, I will try to find a good way to modify these macro 
definitions.


Best regards,
Hans




