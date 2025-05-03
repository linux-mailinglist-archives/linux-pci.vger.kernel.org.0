Return-Path: <linux-pci+bounces-27112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B81AA8113
	for <lists+linux-pci@lfdr.de>; Sat,  3 May 2025 16:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14A23B7A33
	for <lists+linux-pci@lfdr.de>; Sat,  3 May 2025 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335BF1552FD;
	Sat,  3 May 2025 14:36:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021091.outbound.protection.outlook.com [52.101.129.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02F367;
	Sat,  3 May 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746283004; cv=fail; b=Yfw9IdMaswelTDKVCEutZJm03diGWosQGlBGooyge1y0Gh7V27EsFi7CeVugiT4P+dPL8Ns79BmoM7QmN8G/1MxbqeDTFaQBg+5IbvrjefKB2y5h3vom0ikh3yd3JJA0dCveJa+TLmYK9RTBreqoFk/UnTM/SCkY/D7IMaDExl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746283004; c=relaxed/simple;
	bh=bdX9uZ4aBDPfRJd+Cq1cUO7FGQBMIW229qH3WmqYKIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVkG5OO/c5L8or6DegsLZvtxwIlkg2aMh7OPw9aFuf6HQnRE4rBCXxbf6B5uUD2YOK15eGTGwwEghlDz998+DWcvNynwnuseo4l7+MCeVcrHP/tqwslXVRjBR4jtPt4Yvs8xD3WczZzAkitQ1tnOzF8hKOQecf0/yM4SaHjJ29c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1Jn99GY0Z5vvhVeb4HxfhTNbfpiusJVqQbUddqrd39qCvE0stR3HCja8n1dW9AiXn1sxnuSZGhbrpXdfriH2dm+ULg/gQVvxw6AD8MNnw+Mh2VsQcmIexwA5U2sqwihkxoy/JP50FzaUkt8FNgUiPeXrx5HzP1NM2P1qs7Hsej8uUZsQ1lx4CZX/J7bKWw0neXErLb5Zdn7Vak6YUpUqSSvWiAI23Bo2zTB58uZiQU1m9SwCuwLGeMmbE//VltrtzgLYmhz8mIztjhpqWOYPOUdLI9IG9YAr7fK8kQJUVzmL4Kppxl4kg5MB/aEigavjnbyVBWSEMZ6kZqL/7HS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3dEtCBjQChu7SeoI4xxG8dNuxDLgmO92LQ3qPIljcg=;
 b=INaHg8x5lLa/zd0YswRLYBAeSufTVOuZeY+JrOYu+vjBqOy1pCzLDt/clN7Xmw20juyUBrilDh5sR0mjsfcTuB6Jo5Iz2NEIDeMol4M7fSC96SlukgRYPZzhtB2156v2zweokDRjL1CwZQ6XMJ6WQrRJIDzqbB/xhhjdCZ8gM2yNXPq/f2UmE2wSPDBrKabl3kBlrxLU/u/ycUIUA3iJLdN+XAkd9NzDnvKR92TMaS6d8LwPRizIVP03eZSmi6+wjRvFRZSiOdYS5y/486mvoefwdy9q3GJlEcpa1jTOYpGJns/7uTmAInX9Idchs0iSDTnIemoq79wrDFIOfcNRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=grimberg.me smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0276.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::13)
 by TYZPR06MB5843.apcprd06.prod.outlook.com (2603:1096:400:285::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Sat, 3 May
 2025 14:36:36 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:400:3c9:cafe::91) by TYCP286CA0276.outlook.office365.com
 (2603:1096:400:3c9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Sat,
 3 May 2025 14:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Sat, 3 May 2025 14:36:35 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3313641604E5;
	Sat,  3 May 2025 22:36:34 +0800 (CST)
Message-ID: <8c590b78-6f54-4ae2-9263-3553b5e27527@cixtech.com>
Date: Sat, 3 May 2025 22:36:30 +0800
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
 <433f2678-86c1-4ff6-88d1-7ed485cf44b7@cixtech.com>
 <58e343d9-adf3-4853-9dec-df7c1892d6b2@cixtech.com>
 <onw47gzc6mda2unsew36b2cmp2et3ijrjqlmgpueeko5vucgph@wrkaiqlbo2fp>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <onw47gzc6mda2unsew36b2cmp2et3ijrjqlmgpueeko5vucgph@wrkaiqlbo2fp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|TYZPR06MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: b666e743-01c4-4e7c-44d9-08dd8a4fe80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2o4V0I4T0ZnTG95NnRwS2dDU2pxRFgvYXJXVHZrWktRaEQwd1c5a3BYUS9J?=
 =?utf-8?B?d0FXQTR2WUwvc21DQlFobFRJNzI1NUlkcFNZU3FhOUJDb1YrVWFVVDY1azl1?=
 =?utf-8?B?SFNQcUNUTHBRSTB1STc5UDVaZ3NVUlltVG1jcVNiTTA3eGtaVnV5Tk51OUEv?=
 =?utf-8?B?bVVXNlA5S1pHaC9VZWRRVUVVeG03SWl0clVSaFlqekNvbUtvNXdCelNHOVdH?=
 =?utf-8?B?RDF4cEFzNU1vandDL01aUktnSmpaSEcrMXpOOTNVbkM5QXhHeGZmNHVBRW9J?=
 =?utf-8?B?T2dyNEpJUEMzTG9tWkUyZUJiY01BQkE4QjlPTjR2QjNQLzh6eWZseTliSGV1?=
 =?utf-8?B?ZHhyUWNrQmsxN1VJMnA0RnRDNGlHbnpWZHVBbHQ2Q2wrV0pxNHZudE0zMys1?=
 =?utf-8?B?S1VmRWxKa3BDbjZRR0NOSEhnbXdNMWR2alRZRkZUU08za3dDWVliYW9vUlRj?=
 =?utf-8?B?YUo4dFJwVC85MzBaNmpUaDVjeUVxK0dqemVTWVNTRXdrREdSK2JuK2pzU05G?=
 =?utf-8?B?MzVmeFFsYUdYWTBqMmdydjhITnY5T3NoTGFNMUdaSGh1MzV1YmRQNzNsNDdr?=
 =?utf-8?B?aTJiaVRXM09adm81UTQ1V3ROZE5kNW8vM3hMMDF1aGNGZTVSa282ZVF4cGto?=
 =?utf-8?B?dXdjVkxkNlFCNnYvT1NxalZSbjJJZ2g0M1ZOU3kveWY2WFl6ZFFqeDlrUXFo?=
 =?utf-8?B?V056WFlvQ1JBWmZkYXMxWW10TGRJRk9NNDVjbVB0dlJPZlVkYTduQWJQSjk4?=
 =?utf-8?B?SjdYc042SnFVYmJUQWtmZThFN0JiYi9qaFVhNHB6UnpWaFFLbFA1N1BoZjBm?=
 =?utf-8?B?UXpRd2diTEI0VGRpOXQxeVQ5amtrQktJTnZhbGI4R0F6d1FaWjVYWnFmSXFt?=
 =?utf-8?B?RUxZa2ZRUTYvNnhGa0N0WXRsWTdhZmxpR25VL2c3WE9GY3JXZ2x0dDRDeUxI?=
 =?utf-8?B?RmRnTzJMOFRjMDlnUUlucXdDQWNWTm9ZbUZER2lvQUJoQzRHclVBa0U5OXpE?=
 =?utf-8?B?OVcxTXhlOXZwV01LYWtxanIrRUFtcVJpWE9DekV6aUJqdDlPT25Ec1kyUVVi?=
 =?utf-8?B?bHh6c3g4MDJOTnI2QWNLY1Ard0s0UkpPMmhjT0pCaFJtb090MjlTRUJrV200?=
 =?utf-8?B?QUIzYkJNa2pIWWttb1lBVTQxajRDbEcweGFML0g4bS9mZTJWVXMyR010LzlF?=
 =?utf-8?B?N0RFWEpCRnVvdUtlaUNXdVAvTERDZUFqdXdxekltZ0VFbzJBamhENk9nb3NK?=
 =?utf-8?B?MlFTWnBHZE5WZlZXSnVKTWgxd1hJWXFwRWVZK0Y0M2RWQU1TYTYyVy8yaVUv?=
 =?utf-8?B?YW0vQ2oxVnhpdGpTWS9XWjh6QVdXNktPc21tVUpzZmxPWWV6NUdnRXF0RC9U?=
 =?utf-8?B?MHplUmlGSk0xdkJDRDB5V0RpWEZmMk9GY09JaHd3Yll6elV3VnBBWVNIVC9o?=
 =?utf-8?B?TFZLV0xXeWlJTjdhM0pNbnBWUW5XNk50Y01XSlNReUNIQ2hkSWQxOWYraVAz?=
 =?utf-8?B?b09zMjFMbUZKZlA3R2t6b2F6aUo4YVRTUFpwWEVXMUZteGVjMk9qQnovYmhB?=
 =?utf-8?B?cnZWZVRtMHFBUDhucnl3NHBFM29pSWY5QXB1REc1RHZ3YStncVVtWjFYaXV6?=
 =?utf-8?B?aFdFdEVORDdPaUpLSlZmaEJUeENDSmhORlVyUC9qMlZuSVhHT0xIS080UXV2?=
 =?utf-8?B?QUxCZTZ2R3NhTGJNZjZtRG4xMFIxb0RmZ1F6NmZwcmppWlFKSUprMkxuMEdY?=
 =?utf-8?B?bVpjZXVJTHN5ei81azB2dDRqd0ZxUHVMbm05Z1hCUGZhaDNSK20xTktnSndj?=
 =?utf-8?B?bW45UnMrbUJUU1BYS05jVU11MnJ0Zi95WUVuQjlwa2txdUlMblJNOW12S1VK?=
 =?utf-8?B?UkdwQ3g3NjVBMkRXODFEWElycUxIejBxdGxxeUpxOGszeXdETXRTWjZhdjZv?=
 =?utf-8?B?dzJnS1RYeFppRjBRK015RXRpVkVyc041ZHU1UTNVaWtGWnA1dDBKKy9qYWVS?=
 =?utf-8?B?bWJMaTJoaDNLT3duNnhXdjNNMXBmRlNFelVyNGdLTkNZQnVidFpmRlkwaHk1?=
 =?utf-8?Q?OScg+F?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2025 14:36:35.1307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b666e743-01c4-4e7c-44d9-08dd8a4fe80c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5843



On 2025/5/3 02:05, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Sat, May 03, 2025 at 12:20:52AM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/5/3 00:07, Hans Zhang wrote:
>>>
>>>
>>> On 2025/5/2 23:58, Manivannan Sadhasivam wrote:
>>>> EXTERNAL EMAIL
>>>>
>>>> On Fri, May 02, 2025 at 11:49:07PM +0800, Hans Zhang wrote:
>>>>>
>>>>>
>>>>> On 2025/5/2 23:00, Bjorn Helgaas wrote:
>>>>>> EXTERNAL EMAIL
>>>>>>
>>>>>> On Fri, May 02, 2025 at 11:20:51AM +0800, hans.zhang@cixtech.com wrote:
>>>>>>> From: Hans Zhang <hans.zhang@cixtech.com>
>>>>>>>
>>>>>>> When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain
>>>>>>
>>>>>> CONFIG_PCIEASPM_POWERSAVE=y only sets the default.  L1 can be enabled
>>>>>> dynamically regardless of the config.
>>>>>>
>>>>>
>>>>> Dear Bjorn,
>>>>>
>>>>> Thank you very much for your reply.
>>>>>
>>>>> Yes. To reduce the power consumption of the SOC system, we have
>>>>> enabled ASPM
>>>>> L1 by default.
>>>>>
>>>>>>> NVMe controllers fail to release LPI MSI-X interrupts during system
>>>>>>> suspend, leading to a system hang. This occurs because the driver's
>>>>>>> existing power management path does not fully disable the device
>>>>>>> when ASPM is active.
>>>>>>
>>>>>> I have no idea what this has to do with ASPM L1.  I do see that
>>>>>> nvme_suspend() tests pcie_aspm_enabled(pdev) (which seems kind of
>>>>>> janky and racy).  But this doesn't explain anything about what would
>>>>>> cause a system hang.
>>>>>
>>>>> [   92.411265] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0:
>>>>> PM: calling
>>>>> pci_pm_suspend_noirq+0x0/0x2c0 @ 322, parent: 0000:90:00.0
>>>>> [   92.423028] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM:
>>>>> pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 1 usecs
>>>>> [   92.433894] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
>>>>> calling pci_pm_suspend_noirq+0x0/0x2c0 @ 324, parent: pci0000:90
>>>>> [   92.445880] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
>>>>> pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 39 usecs
>>>>> [   92.457227] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: calling
>>>>> sky1_pcie_suspend_noirq+0x0/0x174 @ 916, parent: soc@0
>>>>> [   92.479315] [pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy:
>>>>> pcie_phy_common_exit end
>>>>> [   92.487389] [pid:916,cpu7,bash]sky1-pcie a070000.pcie:
>>>>> sky1_pcie_suspend_noirq
>>>>> [   92.494604] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM:
>>>>> sky1_pcie_suspend_noirq+0x0/0x174 returned 0 after 26379 usecs
>>>>> [   92.505619] [pid:916,cpu7,bash]sky1-audss-clk
>>>>> 7110000.system-controller:clock-controller: PM: calling
>>>>> genpd_suspend_noirq+0x0/0x80 @ 916, parent: 7110000.system-controller
>>>>> [   92.520919] [pid:916,cpu7,bash]sky1-audss-clk
>>>>> 7110000.system-controller:clock-controller: PM:
>>>>> genpd_suspend_noirq+0x0/0x80
>>>>> returned 0 after 1 usecs
>>>>> [   92.534214] [pid:916,cpu7,bash]Disabling non-boot CPUs ...
>>>>>
>>>>>
>>>>> Hans: Before I added the printk for debugging, it hung here.
>>>>>
>>>>>
>>>>> I added the log output after debugging printk.
>>>>>
>>>>> Sky1 SOC Root Port driver's suspend function: sky1_pcie_suspend_noirq
>>>>> Our hardware is in STR(suspend to ram), and the controller and
>>>>> PHY will lose
>>>>> power.
>>>>>
>>>>> So in sky1_pcie_suspend_noirq, the AXI,APB clock, etc. of the PCIe
>>>>> controller will be turned off. In sky1_pcie_resume_noirq, the PCIe
>>>>> controller and PHY will be reinitialized. If suspend does not
>>>>> close the AXI
>>>>> and APB clock, and the AXI is reopened during the resume
>>>>> process, the APB
>>>>> clock will cause the reference count of the kernel API to accumulate
>>>>> continuously.
>>>>>
>>>>
>>>> So this is the actual issue (controller loosing power during system
>>>> suspend) and
>>>> everything else (ASPM, MSIX write) are all side effects of it.
>>>>
>>
>> Dear Mani,
>>
>> There are some things I don't understand here. Why doesn't the NVMe SSD
>> driver release the MSI/MSIx interrupt when ASPM is enabled? However, if ASPM
>> is not enabled, the MSI/MSIx interrupt will be released instead.
>>
> 
> You mean by calling pci_free_irq_vectors()? If so, the reason is that if ASPM is
> unavailable, then the NVMe cannot be put into low power APST state during
> suspend. So shutting down it is the only sane option to save power, with the
> cost of increased resume latency. But if ASPM is available, then the driver
> doesn't shut the NVMe as it relies on APST to keep the NVMe controller/memory in
> low power mode.
> 

Dear Mani,

Thank you for your explanation.

Best regards,
Hans

