Return-Path: <linux-pci+bounces-27099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42516AA76B2
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 18:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A911C058FF
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57425CC76;
	Fri,  2 May 2025 16:08:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023079.outbound.protection.outlook.com [52.101.127.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56604146A68;
	Fri,  2 May 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202089; cv=fail; b=Q++lqHqFwcdWadVS7FTRCzGQpAH9XG896SYz3VyaQ/F/USO3YiU/79cmkfQekYgMqlLB8LsVjYWqawzPccGSEiSoyqTkPNxfb2bVY7YBQPHhS83LspwfzSYNJcieZnYwHsM0XHdVfEj7HIXwsYSvXhOAtP1qu4EcOKtqy2364Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202089; c=relaxed/simple;
	bh=AUWhvCBdr+7F/YZAjylLidkP4sR9HY/QzyrOXnOCk78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MneRVQw6j0ZJoN2sUSyZQeSkwTFVfQs1dO7XpB4+Qgf5eIT0aNaWAZuLqpJE8PBmT4ATOXRnrtgEVY5dXX3Bzb6nbUqPjHY9Y9/nFKITjAgklALOjuGVw25ABNBERdsp4qMIcO4+6HGUzcUiSGr+tg/gwAd7G/MRmq/TwkzMbKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q04zkAMYFWI87JAeib5wqhrJS83MyCaxMlUFlYXFQ46tN14Ih6dWBSGaf7Ix7lK5XOu5xDfxNEsevfjBCYH7gl1lQqjv6e3uU0n4tHg+xWDIY4h57/pIWkUVlSc5/g1aIH6A+75jmwAPiAqStuuTkQRIaGbm4nNN2t5jsxTNTjXOT6dU5ShUBen5PjcTgkotQk/KmUbV2z5oqzyN0prkB5fp3yaELBPkt2q7a0ZcYR4oDJ34whogFxTaq/7t84oAjOc4w/oIJP8YPLad0wcZBWxz8uagi0ndI+KSEEgtgvpYff6SqEIvOwitDec8ArRmpkO1G8DXhX78CpxwgIAiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU0qRaH89ItNGSqhBnkOyoQmmH18HgCEXlxos+cBjQk=;
 b=B5szNeJtaBQ2o6WOgNfeqYvGcwpN3Orx1Od7NrLHo/uxXNveoc3DETMHXoZvlIrtkahg8Zbc3A5xyALJZI5DdNbEoDhVfJISkz9MgAntSik9S5v9RJV7DJ2R0g3W73y42bqLC5M484pcYTDplydhLFPt+jOkKkXWluHcN0GprjrjTBhcFXQHME/2XMd62TBGN0Tn9R9GgZEOLpkQko+o8BGJ3FLwIlWW4WFEi3lmInd0am4Cnqxt73XibNnyRYWTjOl9wjRDhqhyYCJSgVASuZ60PQsvYt3xkz/hKU4EBffEMHL5Zm5QqPDWMlQfEFHbRrMBuyhZiYXcUs2U4gsbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=grimberg.me smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYAPR01CA0048.jpnprd01.prod.outlook.com (2603:1096:404:28::36)
 by TYSPR06MB6795.apcprd06.prod.outlook.com (2603:1096:400:475::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 16:08:02 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:404:28:cafe::52) by TYAPR01CA0048.outlook.office365.com
 (2603:1096:404:28::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 16:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 16:08:01 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2175C40A5A01;
	Sat,  3 May 2025 00:07:59 +0800 (CST)
Message-ID: <433f2678-86c1-4ff6-88d1-7ed485cf44b7@cixtech.com>
Date: Sat, 3 May 2025 00:07:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during
 suspend
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250502150027.GA818097@bhelgaas>
 <be8321e5-d048-4434-9b2a-8159e9bdba43@cixtech.com>
 <z4bq25pr35cklwoodz34pnfaopfrtbjwhc6gvbhbsvnwblhxia@frmtb3t3m4nk>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <z4bq25pr35cklwoodz34pnfaopfrtbjwhc6gvbhbsvnwblhxia@frmtb3t3m4nk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|TYSPR06MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd6e553-131c-4f28-db1f-08dd899383d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2pFWHBsS2FVQmhYNFVBWlNvbS91cnVXcCtqOGRJT2U1RVRYd3FBVGZkczNr?=
 =?utf-8?B?cXpjdnV1bnpKZjZXTmdFZnNzNk53eGZwOWlqck1aeG1JOHhmSGxERjlNV3M4?=
 =?utf-8?B?eGlCUVRBZlJDb1M5WVpJbXZ1N0s4MmZ5VHZxYkkyWU5JbWozYXQrQnlyQ2Iv?=
 =?utf-8?B?VzVLUVNwR1d4ZjZCZHZGMUo3cUFlcmp5M2cwV3ltS0hRR0dGRjN1QURlT2xq?=
 =?utf-8?B?d3lqWXVXSTRxcEhORGtxeWFvV0pQOWFGL21aSHRmei9BNzFNVVJlY3ZmU2V0?=
 =?utf-8?B?TXZGNkU1WDFGTWxTWkovQ0hOWERwRkpvV1YralhXMmNlQzczNFJBbDB5L0Vj?=
 =?utf-8?B?Z3dtcm90ZkpnenJGbzJ5Ni9YZmgzOHFCYVROU2k5UVF0YU1GNWdieTV5WmVY?=
 =?utf-8?B?cXVlWDRFak1uUlRuK3h3VGV2UzVvTkovUWpScXZNQk5nWGt1ZDFuWE5BVy9D?=
 =?utf-8?B?ZGJXdzIvdzl1cWJpQmRzMDFOY0hUbGtqTEl0Mk1QVU85Qlk3U0hBdWR2aUh2?=
 =?utf-8?B?MmE3cFF4Rkx1RjdvRjlMYzloYXJLWlJ3NDBwZUFuTUFCZ3FGMFFRdlJKUWNW?=
 =?utf-8?B?QXJmYkhSUFNNNEJDT0lRV21uaDhrTnFIMkg2T1E4VElEQjVjZE92YmppZEYz?=
 =?utf-8?B?a25WYlM3d09WSmE5TnorUU9PZHRLMklIek9PRi9vakhsRjJmcUViNTRFVlNQ?=
 =?utf-8?B?VnRKcXJxalFyTVJIQ2JFelozMmhwME1MZWtScWc2MkJEczhVYUNkZkpva1pv?=
 =?utf-8?B?b25SSit0bThUejVoNXFIL3h4Qlk4SVA1b0p4dU9LT1F3NzB2MEsvVWxkRjI1?=
 =?utf-8?B?TEJuZVpnVU1ibkFua3F4YlAzbVRBTmlLdHN3K21zUnZkOHJqV0NiaVVHVVVJ?=
 =?utf-8?B?SEQwbjRGNHN0UjhYUi9tTG9TcDE3VURLQnhVS1M5N1ZPTWprUHphSVpFM3Ur?=
 =?utf-8?B?NERuYUE3V0I0QmE4MkhscUFVNWFPejBVRWpXaGc4Ym4wcGFQbWhNM1VqUVp0?=
 =?utf-8?B?NDdMempmdlRRYjNJeDhBVzBLdVk5ZnlZcmxJd05YSkpQRDdTZW95Vk92NEM2?=
 =?utf-8?B?dE1CRFdOQmVGc25DamtYc3JtdHV4VElOdTRmVmQ5T3NoVGRMeWhRNzI1aVlJ?=
 =?utf-8?B?TExkZ0RlVDVlc0N5QTgyV2ZGa2cyM3YzeEhsbWxVajhNQXB0SWJaejhZUFhE?=
 =?utf-8?B?dWtZRm12NS9FZForVjN2dXdWY0hBUlFZZm5KTjYraUM5bFpaRmZwck1aMURO?=
 =?utf-8?B?K1o2eDNrdVd4cUYwWFhoNm1wVkVsYkYyaGlocXdhdkR3d3VvTmV3czM1QVZk?=
 =?utf-8?B?WEhFOUkycjV5M3EyVHVTOVdXbHE4cDBiWU56UCs5TmUweXYzUmpwMGNlSXFW?=
 =?utf-8?B?OWVoVjFqcDVXWGZkWXIvVnd5RlFTZGhoYXg5bDh2aDBncXI2b29DWk5odVlN?=
 =?utf-8?B?S1pycWYxL1pkc3dMNEFwSGJCMDNwNytPSjUwd1hsd3NTTkxBUmdBOXp6TUtM?=
 =?utf-8?B?U2JsVUpLdUlJQkhDeVd0S2Y5UzlzN1dUZkpTdnZtNWZnL2pjWGdGdDJKa0tQ?=
 =?utf-8?B?ckZKQ1RsTHJicFNaYlREb2JmTHlSODU5R2ZiRURmbmxKTWJwaVBSY0FTS3Zs?=
 =?utf-8?B?K3J3a1h1R1JzM0tNaU41c0lhd2hKYXp6VjhUaFc4ckVpTjFyWlVJMG9KeEV1?=
 =?utf-8?B?SkZzUDh0RGFZY2lRL2gwLzQ5QldsME9yem5kY0xsbTEzbzRTby93TXpJMVNK?=
 =?utf-8?B?MGJrV2IzNlVEU2VUSzBZS1VPaWpjTEtpQ1BUY1BsQ1R4WUY1QXlITlFucWw3?=
 =?utf-8?B?Y21PQjlNZGlIR0laY1NadS85QUN1c01WU082Mk5adWJ0R3pUVnpYdkVmdkxp?=
 =?utf-8?B?QjRGV1NBZjc3azRhaGd3eUR2dXVuYWxnUDNEeC84bDV2eWlrTTQ1Mkh3ZDJs?=
 =?utf-8?B?MkZEeXVlalVMaVU2dm9KRlNHcVk0R001NTBiK0VYM0NGQmNjbjF5QnQxbjRM?=
 =?utf-8?B?RzlvOVk5TUFoMWlRRTdWZFArbWpEMEJub0FlMjBqT0EwZ3JvdFZYZjluS0xS?=
 =?utf-8?Q?/Y+S5i?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 16:08:01.9178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd6e553-131c-4f28-db1f-08dd899383d7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6795



On 2025/5/2 23:58, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Fri, May 02, 2025 at 11:49:07PM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/5/2 23:00, Bjorn Helgaas wrote:
>>> EXTERNAL EMAIL
>>>
>>> On Fri, May 02, 2025 at 11:20:51AM +0800, hans.zhang@cixtech.com wrote:
>>>> From: Hans Zhang <hans.zhang@cixtech.com>
>>>>
>>>> When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain
>>>
>>> CONFIG_PCIEASPM_POWERSAVE=y only sets the default.  L1 can be enabled
>>> dynamically regardless of the config.
>>>
>>
>> Dear Bjorn,
>>
>> Thank you very much for your reply.
>>
>> Yes. To reduce the power consumption of the SOC system, we have enabled ASPM
>> L1 by default.
>>
>>>> NVMe controllers fail to release LPI MSI-X interrupts during system
>>>> suspend, leading to a system hang. This occurs because the driver's
>>>> existing power management path does not fully disable the device
>>>> when ASPM is active.
>>>
>>> I have no idea what this has to do with ASPM L1.  I do see that
>>> nvme_suspend() tests pcie_aspm_enabled(pdev) (which seems kind of
>>> janky and racy).  But this doesn't explain anything about what would
>>> cause a system hang.
>>
>> [   92.411265] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: calling
>> pci_pm_suspend_noirq+0x0/0x2c0 @ 322, parent: 0000:90:00.0
>> [   92.423028] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM:
>> pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 1 usecs
>> [   92.433894] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
>> calling pci_pm_suspend_noirq+0x0/0x2c0 @ 324, parent: pci0000:90
>> [   92.445880] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
>> pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 39 usecs
>> [   92.457227] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: calling
>> sky1_pcie_suspend_noirq+0x0/0x174 @ 916, parent: soc@0
>> [   92.479315] [pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy:
>> pcie_phy_common_exit end
>> [   92.487389] [pid:916,cpu7,bash]sky1-pcie a070000.pcie:
>> sky1_pcie_suspend_noirq
>> [   92.494604] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM:
>> sky1_pcie_suspend_noirq+0x0/0x174 returned 0 after 26379 usecs
>> [   92.505619] [pid:916,cpu7,bash]sky1-audss-clk
>> 7110000.system-controller:clock-controller: PM: calling
>> genpd_suspend_noirq+0x0/0x80 @ 916, parent: 7110000.system-controller
>> [   92.520919] [pid:916,cpu7,bash]sky1-audss-clk
>> 7110000.system-controller:clock-controller: PM: genpd_suspend_noirq+0x0/0x80
>> returned 0 after 1 usecs
>> [   92.534214] [pid:916,cpu7,bash]Disabling non-boot CPUs ...
>>
>>
>> Hans: Before I added the printk for debugging, it hung here.
>>
>>
>> I added the log output after debugging printk.
>>
>> Sky1 SOC Root Port driver's suspend function: sky1_pcie_suspend_noirq
>> Our hardware is in STR(suspend to ram), and the controller and PHY will lose
>> power.
>>
>> So in sky1_pcie_suspend_noirq, the AXI,APB clock, etc. of the PCIe
>> controller will be turned off. In sky1_pcie_resume_noirq, the PCIe
>> controller and PHY will be reinitialized. If suspend does not close the AXI
>> and APB clock, and the AXI is reopened during the resume process, the APB
>> clock will cause the reference count of the kernel API to accumulate
>> continuously.
>>
> 
> So this is the actual issue (controller loosing power during system suspend) and
> everything else (ASPM, MSIX write) are all side effects of it.
> 
> Yes, this issue is more common with several vendors and we need to come up with
> a generic solution instead of hacking up the client drivers. I'm planning to
> work on it in the coming days. Will keep you in the loop.
> 

Dear Mani,

Thank you very much for your reply. Thank you very much for helping to 
solve this problem together. If possible, I'd be very glad to help with 
the test together.

Best regards,
Hans




