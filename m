Return-Path: <linux-pci+bounces-27101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBD6AA771B
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 18:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326F74A402C
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB622550CD;
	Fri,  2 May 2025 16:21:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11303C465;
	Fri,  2 May 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202874; cv=fail; b=LYFDG3k1oFdqVHv8tWxlln4RHHtjdZAyUUg9F5+yQywp0F0itpV1QD0LzyI5sdQ89TbfIRDcP3c+tT5p8rRfn0YZtfpFaPEGWv3bo57eDCD40DvZkUYpXxztdJPzFmqaUKnUZG36+gO4o7LQT9BvoHCnR2KbGtNsJWpr1J/0Scw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202874; c=relaxed/simple;
	bh=ozOYn5MQIQ5x6+8zHOXmdg5Wt//VBFbEFpTU8X7Lg6k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gMpPjb2C2Jq5q7pA8qqlYxs7T3dviPfgC2mTBKq0VpfkMoTueiSGdqINcj2z66KJG/KNfeV261jToAKd8mWhHKNpn9J6zeC1b8XtDogjnmaNypF8nE+5UXwyLotwl9BXRCbdt4o2ZLMBDccVRE9K5yjPlYWAJbutFHKH4TftMtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cL6hSMRx7RhUme9Q/3Ga685DgPfqm6/uycM3sN8qg7aTkOMkeE10TXZAMgv5/Q4w8QKf4tTPJkv4ipcTJOjV28GWgogiN2A7rhmafmOxdQpbykVQvpw4ncURSr7LXYTKwn7yIH9epbYC6ezSoz0xWyj7gL1kUPuNfoSPpFYlK6s5w7/HpYs5dr3vc/qRMm+rPJmVxRcmHrD8qOxWPtA5QzdqxOWOF8IvA1OprkSWnrDK89cZbxdLRnSp1ZE2ZpFtcIXQNaaNkvGtoAwP+Wd3OA9hHjNSBRgRobH6+E6HaFppSsZgSSmLoQNkayDsQWWJo9fJDr7oFrsmNbO2gj0ocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4scuSyYAAyaEnnMzORyO07XR2GSyh3j5iCUK7j3lmU=;
 b=r2j5yjSEcYDfkduK9c707/LBEgLLPc+jnsiwjEc5Di6vb3ykwSJX603TMVm8rKjfmCpkJDQmAswaf9mNLeDUNJPPLPCunyaL1W50IHt18EhrigLCOvE4G+ARbFAK/P86oswEKxeraCYUhtmehpi0NLX/pZjO57DTgfqvxV4BE6skfqrReVWzRt7A6f5ic0m9EbU5U4aeqARj2D98EcPic/CcntVMtX1h+MPZXEHp53iB4fdootBU+KEEcQRTEp0/QKhKjxtLfBNsLtXtNfFHPt8AFq0MsD/oYTvuD9It2T/XvUMH9ycA1E6f37NI2MBPbOuI5WJNlP+uv9tYht/uNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=grimberg.me smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::22) by SEYPR06MB5254.apcprd06.prod.outlook.com
 (2603:1096:101:86::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 16:21:05 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:300:57:cafe::73) by PS2PR01CA0058.outlook.office365.com
 (2603:1096:300:57::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 16:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 16:21:04 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8743F40A5A01;
	Sat,  3 May 2025 00:21:03 +0800 (CST)
Message-ID: <58e343d9-adf3-4853-9dec-df7c1892d6b2@cixtech.com>
Date: Sat, 3 May 2025 00:20:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during
 suspend
From: Hans Zhang <hans.zhang@cixtech.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250502150027.GA818097@bhelgaas>
 <be8321e5-d048-4434-9b2a-8159e9bdba43@cixtech.com>
 <z4bq25pr35cklwoodz34pnfaopfrtbjwhc6gvbhbsvnwblhxia@frmtb3t3m4nk>
 <433f2678-86c1-4ff6-88d1-7ed485cf44b7@cixtech.com>
Content-Language: en-US
In-Reply-To: <433f2678-86c1-4ff6-88d1-7ed485cf44b7@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|SEYPR06MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: ede5cc35-0625-4bcd-6329-08dd89955670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enphbEhzY3ZrczdHdFNvNUhkZ1ozcHlhcXMzWkNzYlh5cEl4U3ZsM3VodkxZ?=
 =?utf-8?B?OUp6cVZ3b2FzL1ZLSmh6eG9ZcDNSYTRVcElSRFBMUHFIL1JZWTZ5ZmZ2ZERx?=
 =?utf-8?B?aDJuUU5YL3dhMWlLSDNVTlpzU2VvWEJncEFWY040N1I4V0c4aU15NjVyMlVi?=
 =?utf-8?B?eVFxMmFMNGxVdFhpOVhLQWFEbTRWQW5uM1JPRFpMdUtOUEZWWnpWMTU2QTJS?=
 =?utf-8?B?d1UrVFhlWTRWazVOM051alFFTlptZ09JSmVMdDNzcC9sOXUyOVhTalBLdHRm?=
 =?utf-8?B?cmJaKy9UUitTVUZXbldxWEhKTDB4dnVVVCs1L2ZISEtlVklLY28ra201TjdS?=
 =?utf-8?B?c0pNRTdUTGUxalJ0NmdXeWh2eUFyOUt5MTBjUEhoclZMMTY4UXRvcW04V3ZM?=
 =?utf-8?B?eW03TmUvM1JRK2xhTlMzTGVvNndIZE1yMUFISjRrK24vY01FNmo4THQ3azdm?=
 =?utf-8?B?WDN5Y2hTd21NL0thOStjOE1jaytOeHo2Z2Jzd0FIckQydE96WW1SVnFzWm0z?=
 =?utf-8?B?YzhZL0ZXQ00xNkJxUVNiZ200SDR6NmtHUmpJVFRYTWM3QkNDVG43WmtUWmpm?=
 =?utf-8?B?c21tTURCZmgxb21CT3c0bGlHOWpvQy8xSlozeVBiZWJlTE9wdThsZlJXcEo4?=
 =?utf-8?B?YmRRV1B1ZDZDMmlHTm9WZmFDK2tVRjJPNENnWE9rbVdxQVFFcENVWkxGcnZT?=
 =?utf-8?B?d3Fpa1ZxZW53NkJoL1NhMDhNajFPRGU3Wi9Rd2M3dWJtOHp4M3JNR0RtL1c0?=
 =?utf-8?B?TmxISjBKVlNqTXl4R3FNeU9xRllYTmE1V213MDZScTNJdW5uUW9QK2VNWFNq?=
 =?utf-8?B?cGR4QS9xSXYvSkp3bmNFNG90NVU5YU85b2J6WWJtTWhiZjJ2UGlTMFVNd3Bu?=
 =?utf-8?B?UVkxVlViUUpZWmpVM0lUZW9wMVlXMzNTL3ViRUNZcVAvQWx3c0tkOVpWYmhD?=
 =?utf-8?B?Tzd5eWdXNXk5WnNidWJJeUF4dEtUM1JrTFFxYmtVTkJqK3Jsdzk2OTFmNEtP?=
 =?utf-8?B?V3JPSTBhc2xOdVl6MG5STUNIT1FoYUJxMHlzL3NNYWdPMFNGbndkcHRNLzNs?=
 =?utf-8?B?R1NJWmM1c3ZPTVBWcXV5UFFScDRnTDVzZW1LWjlLUnlpZnhlbWpINXJlYTAz?=
 =?utf-8?B?NFVpdENHaHM3T1pXVWRQM2lLM0lZRU9KaERXdTNzUTR5UG4yaDFGRnQ3OUov?=
 =?utf-8?B?bE5LY1MwSTdRa2dzbDZMcTAvVzdDN3dCRmhTWWtZazczWk14ZjRnMk9QUWt2?=
 =?utf-8?B?dC9NanVVanNMbUlmakg4VTJRSnVJbzF3UUZHYi9mWjRuYno0K3dIZUoybDNu?=
 =?utf-8?B?bUVmd3BzakltYlR1dXoxeEtwa0plK1N3bDQ4VGxmbDR1SXBtRFRuNmp6UC9V?=
 =?utf-8?B?aGxmakpGdkRFNVNodktYWmZ5aFpNQ2VOcnBZdHFmQURpWnN4K1g1WUMrc0Rw?=
 =?utf-8?B?dzI3bWJxZ1ZqK3RORCsrSUYzMGVvQmlNWkdiQXdtL2daSGVBZkRMR3RHbEZj?=
 =?utf-8?B?SGk5cTNYQ0dSUnplZDRSem9oV2hhWC9PdXRqdFRNbE16NXlDekdmODcwWkU2?=
 =?utf-8?B?UUFNeTBJRkp2cW5MVXBuRTNnTWQ3b2E0d09LQTZhUTZiZVJReFJ5TWx5c29z?=
 =?utf-8?B?UjFBK0Z4dU41TGJjS2xodHhObEkxOXJJS1RXZG5FT1c3eko3eFhnaUJXUk44?=
 =?utf-8?B?cmE4VnBWNlRGSmhKT3RCcVAvdEJheGhUbWhHTE1sVXI3d25FcGJjSGJndFpw?=
 =?utf-8?B?Z0pNMm54WFhhTG9DVHRIck0vT0dZQ1NqNFJWZmRVRmlBNEFwcHVKck03ZVV5?=
 =?utf-8?B?eHY2aU9wRk41Z0lIdjRIOXVmVGxIam03U0k0N2ZKYTV5aEw3LzRGNzBzUzZN?=
 =?utf-8?B?OGRaMkpZbnVjWVducWIvb2FzUXQyMWhoNU5nclVMWWFzR0MxRkkrWnNad0k2?=
 =?utf-8?B?ZUU2eHhqK1IwMVhPTlZXOWpLNVFxdTBOQU1HSU5UTk00QmkzUG8xZG4vd2Zh?=
 =?utf-8?B?dXNramJLcEg1eWhTUzRyOWhYZ2h2ZXQ5ZFVUcVZma1R6U1lzNDg3ZXUyVFVu?=
 =?utf-8?Q?cMH4WN?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 16:21:04.4308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede5cc35-0625-4bcd-6329-08dd89955670
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5254



On 2025/5/3 00:07, Hans Zhang wrote:
> 
> 
> On 2025/5/2 23:58, Manivannan Sadhasivam wrote:
>> EXTERNAL EMAIL
>>
>> On Fri, May 02, 2025 at 11:49:07PM +0800, Hans Zhang wrote:
>>>
>>>
>>> On 2025/5/2 23:00, Bjorn Helgaas wrote:
>>>> EXTERNAL EMAIL
>>>>
>>>> On Fri, May 02, 2025 at 11:20:51AM +0800, hans.zhang@cixtech.com wrote:
>>>>> From: Hans Zhang <hans.zhang@cixtech.com>
>>>>>
>>>>> When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain
>>>>
>>>> CONFIG_PCIEASPM_POWERSAVE=y only sets the default.  L1 can be enabled
>>>> dynamically regardless of the config.
>>>>
>>>
>>> Dear Bjorn,
>>>
>>> Thank you very much for your reply.
>>>
>>> Yes. To reduce the power consumption of the SOC system, we have 
>>> enabled ASPM
>>> L1 by default.
>>>
>>>>> NVMe controllers fail to release LPI MSI-X interrupts during system
>>>>> suspend, leading to a system hang. This occurs because the driver's
>>>>> existing power management path does not fully disable the device
>>>>> when ASPM is active.
>>>>
>>>> I have no idea what this has to do with ASPM L1.  I do see that
>>>> nvme_suspend() tests pcie_aspm_enabled(pdev) (which seems kind of
>>>> janky and racy).  But this doesn't explain anything about what would
>>>> cause a system hang.
>>>
>>> [   92.411265] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: 
>>> calling
>>> pci_pm_suspend_noirq+0x0/0x2c0 @ 322, parent: 0000:90:00.0
>>> [   92.423028] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM:
>>> pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 1 usecs
>>> [   92.433894] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
>>> calling pci_pm_suspend_noirq+0x0/0x2c0 @ 324, parent: pci0000:90
>>> [   92.445880] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
>>> pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 39 usecs
>>> [   92.457227] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: calling
>>> sky1_pcie_suspend_noirq+0x0/0x174 @ 916, parent: soc@0
>>> [   92.479315] [pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy:
>>> pcie_phy_common_exit end
>>> [   92.487389] [pid:916,cpu7,bash]sky1-pcie a070000.pcie:
>>> sky1_pcie_suspend_noirq
>>> [   92.494604] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM:
>>> sky1_pcie_suspend_noirq+0x0/0x174 returned 0 after 26379 usecs
>>> [   92.505619] [pid:916,cpu7,bash]sky1-audss-clk
>>> 7110000.system-controller:clock-controller: PM: calling
>>> genpd_suspend_noirq+0x0/0x80 @ 916, parent: 7110000.system-controller
>>> [   92.520919] [pid:916,cpu7,bash]sky1-audss-clk
>>> 7110000.system-controller:clock-controller: PM: 
>>> genpd_suspend_noirq+0x0/0x80
>>> returned 0 after 1 usecs
>>> [   92.534214] [pid:916,cpu7,bash]Disabling non-boot CPUs ...
>>>
>>>
>>> Hans: Before I added the printk for debugging, it hung here.
>>>
>>>
>>> I added the log output after debugging printk.
>>>
>>> Sky1 SOC Root Port driver's suspend function: sky1_pcie_suspend_noirq
>>> Our hardware is in STR(suspend to ram), and the controller and PHY 
>>> will lose
>>> power.
>>>
>>> So in sky1_pcie_suspend_noirq, the AXI,APB clock, etc. of the PCIe
>>> controller will be turned off. In sky1_pcie_resume_noirq, the PCIe
>>> controller and PHY will be reinitialized. If suspend does not close 
>>> the AXI
>>> and APB clock, and the AXI is reopened during the resume process, the 
>>> APB
>>> clock will cause the reference count of the kernel API to accumulate
>>> continuously.
>>>
>>
>> So this is the actual issue (controller loosing power during system 
>> suspend) and
>> everything else (ASPM, MSIX write) are all side effects of it.
>>

Dear Mani,

There are some things I don't understand here. Why doesn't the NVMe SSD 
driver release the MSI/MSIx interrupt when ASPM is enabled? However, if 
ASPM is not enabled, the MSI/MSIx interrupt will be released instead.

Best regards,
Hans

>> Yes, this issue is more common with several vendors and we need to 
>> come up with
>> a generic solution instead of hacking up the client drivers. I'm 
>> planning to
>> work on it in the coming days. Will keep you in the loop.
>>
> 
> Dear Mani,
> 
> Thank you very much for your reply. Thank you very much for helping to 
> solve this problem together. If possible, I'd be very glad to help with 
> the test together.
> 
> Best regards,
> Hans
> 
> 
> 

