Return-Path: <linux-pci+bounces-43205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E476ACC8B06
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7290E302770A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E9343210;
	Wed, 17 Dec 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rMI/435J"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE12586C8;
	Wed, 17 Dec 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986763; cv=fail; b=Jt5FRo3gPVO9PDJAJ537A2vk5WRyAJkYl+TqipDIEMBG+6ADCx4qoThWln6rjSChNP3JuLkDeLkRX6msfkx0R1SaJZ0SMn2y8rdQN7lTqGJ7Qb6M+dNMQPUIWgItKA2o6CO99Z9euAGJ+fp8bSgNDAwUnjDzLjZw5GuLwswmP6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986763; c=relaxed/simple;
	bh=LH3GH6ixd3ODfsq81h1vdrY+Yp1b6LWh1YeYW4xW09c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tag5surw3uPkZHz/EnB8BAWBy7PqCvEDMfl4Dm0xLbsWNONH407eKcCkWWoV6DmqznUbwBr7GUMyfD22mbPsgwAZ8sfEgxXeCcZ3LcNElxoMSGxqRqF6PXg+kqwKhFTe38hOEV7NbJoalu54geI0ewlzrijqRCT5yM+pV1yOwGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rMI/435J; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTngchto88gK8LufV/jpUIWEtm/FFssxXzfV0rd+H+8YhvIru/XvJvXhm/xT7I8X9pj34q5pAsBwG66V+kg6QVb9M6MxyUw6pOJXVNywoEfwn9HznX56bfr6FybouPLEWSJFpFeFYei94IjDSl3EjeF81xHNDF3rMOuoE1B1NNRZzXnsDdicwgkoPWnEizxEPkNtt6OeWRjYFIXK9IWkQnSi9CHep4nkCk4hA63CADC7GbY0wOSe0ImNIYhKnRiu348JFzGh6uYvHM8jAF/IohF5OBSLvqzi9uwjJZ25LESP3tCNpzKi7q7QxKiI1s8qe2PHsrAm7y9IomyWGSIZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K1tLnqhXSNXpxWhSRheuQDJKvfF3LYsPCzt2EIY34I=;
 b=JoStYKVmdhsCtocROawZnYaiYDYYiccJAlyH9BXxp0ZFpQQG2XJMk0U41Zg5JJQiUQTU5dEuZ6ejIKzIMj2Mqb9DPh4NWSOK1ziUYRbakl5BxR4NpcpYX0xvoc2Nb788qqlZENWCmR7f/X1H1sKmlzNOTqdWNGUc7mw8vlVJzRKQzCBhcCxvQHrTOqPQXqJnoHJ7SKgiovtqyrA/9wNgik3Yx+F8tqhaLlv961xV3FKyJzGDrox4kHjadPKVzMHqCjdU8YbEdeonElxf3FjiexfbEUzSQ7x4tpi4J1qi0NwmQlioJBIgPUPAfCr302bs8izCkHbgAY7zXJwVHgKDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K1tLnqhXSNXpxWhSRheuQDJKvfF3LYsPCzt2EIY34I=;
 b=rMI/435JcHgEqetAwBHdqKHrTcQqCAM9xIgJ08wBAc/NhGAOeADqWPJLDk1m6I3jO4tKo7pAMTFiDrSHRwsXCbcCjWKb75tY/3roqgeZu8BmZQJHqzu7+JD1QgOxjGeOEaqweqBP1y1T+/ftGG/kWlz7aEdv71EfoJflRnV1V+5Ff5E0WuoatUVCI055xumTcaP96kaxXNqWfFgf7IroF7JxvAcQ0kxT2P/D1YewPJBCn/QMKwiEpwvork7pIOX2Szr+Iphko/oE0FwrRlTIsoHMg+OEhWKBSmhalfQTHMVCTQFMrvHjBB32IIhu6bn6WA+fmP45SgxBWsugPN4m9w==
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:38:18 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::cd) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 15:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:38:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 07:37:51 -0800
Received: from [10.221.134.24] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 07:37:49 -0800
Message-ID: <22df4586-00da-408b-99c2-4592dade4d90@nvidia.com>
Date: Wed, 17 Dec 2025 16:37:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add quirk for ASPEED AST1150 bridge to prevent false
 RID aliasing
To: Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <iommu@lists.linux.dev>, <jammy_huang@aspeedtech.com>
References: <20251217133232.274942-1-nirmoyd@nvidia.com>
 <72c7fb61-a4b8-4443-86ff-84345fe1ced4@arm.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <72c7fb61-a4b8-4443-86ff-84345fe1ced4@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ba65fc-0062-4725-ed00-08de3d824b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YnFrZnJKY3BKRHhaWXk4dDg1d2hmOFNEam53d3V0Mm1uNWhFRmlidjIwQlR4?=
 =?utf-8?B?OXh0Z1FsNTJqNXk0KzN6NFM0ZHIycG9FQ3gzTnViam0vb0xjNWFQWjM1cFo1?=
 =?utf-8?B?cGx0MXdlb2NQZ1lUdUNHVWVrcHNOMFJvRTFzY3pTRGdpTHkzdkxNbFVGaXkw?=
 =?utf-8?B?aHhEZFFsdk1HZlJERGlaQy8vSHpVTCtYWnZadldodi81eHZ2VUJWUWhoVm1m?=
 =?utf-8?B?dXltb1lZNGxDMCt5emhxdWZYZEVYdFdPNW5mOTBUVXI4bVQyU1JzSzNoUTFt?=
 =?utf-8?B?WW1jVzlkOGNpYWRkZE9lVHJMUTBmQXpmTk5aU0xpK1FqTEs5Tk1sczdUOEkz?=
 =?utf-8?B?UTUrbVAwU0JYZTk2U3luL1k5SHlMVWU1Y01RWUUvTkxpeWNzOUNWZGZLaWx0?=
 =?utf-8?B?TGkwNi9NczluM2lld2dZalhxRThGRmlGT2UveHR5RlFGZkpyTEp5QnROZ1d5?=
 =?utf-8?B?bVM4YWRFRDRLV3o3R2xsc21adXB0K3Mzb1VGY2tDVjF3R21INFpaWE1jdnFR?=
 =?utf-8?B?Mnc4OXlkdnFXSnlSQ3pYK0RnUzVyY3J1eGM3L3hyT3ZhSFlhdkdPQlRLL2Zn?=
 =?utf-8?B?RGY4K2VWeDk2OE8xZWIrd3FxMkg0Sjg4UnludlRlL0JQMkxTeW51aXpoK0pw?=
 =?utf-8?B?Smc4dHBRSkppWWhxNWNoRUl2QzRNUUIydGM1WDVwZzdqSUoyZ3kvMStaUnVX?=
 =?utf-8?B?ZFU0anBKVHBHZVkyOE1vVVFJd0xTRWQ3ZlEvWjF2Umt3M2VwNHphZDJMM2xD?=
 =?utf-8?B?Y0pHSU0xS3NwbktET3pnTmxMMTVlbG5IeVBZNWFkaC84Y2xWUUI4eVdNczBP?=
 =?utf-8?B?UHpVREQ3NlpVdEp3T2ZKeEozS21uODJ5ZXU2NWwvaGJuclZzNTJCNzRxVmNt?=
 =?utf-8?B?WDZaM3hHZFhkV1hpUEFjTUlXLzlWNHgzQmFrcTJjUjFpcitudE9aYjRiUXlB?=
 =?utf-8?B?V29WWk8zbDlWbGZRMFk5VXE0OGU5Zk9rWVhZQ2FwZy84THFEOUNBRU8zazE0?=
 =?utf-8?B?Qk83T3JYNVZjb1hQdFdkbDlEVnl1bHMzOEh3S3NlZ0dnb2JrWVNYcDdjV2tB?=
 =?utf-8?B?TlMwNWc2clpweUJWdCtYOERuRjFRdVBCQ05MdUFmdnFLZWdPcWVCUVIzcjR6?=
 =?utf-8?B?eTRRei8rRVRiQi9LT3VaYk9oN21Yc0svQWJwaTZYeW93YUNBaS8rT0s4VHh0?=
 =?utf-8?B?ejlwa0xMLzkwRHRRVUxMMmFOWk9sTUFpQmM3cng3ejZFajhhVmo5WU1Hb1Br?=
 =?utf-8?B?MXkzSjZMQXVLbVdyK0xkZm42bHF5QUpiQUhSRGd0alpSb3JhMU5nRGtMcnd5?=
 =?utf-8?B?V085ZGpyNFQzNi8zeFhvUkJmSUtNRzV0QkJGWXg0UU5hMHhUTG84Vk9tYTNu?=
 =?utf-8?B?bHlvcWx5c1lRRTVLN1ViMmE3OXI4QXh6VDYrZTZTVXdOYXpKNmZ2eUQwWktN?=
 =?utf-8?B?dllvNkVSN256eVR4UFIrb3dXdE9IbWJjbVVHOXdJdXcyamtHY2dKSDMyVkRK?=
 =?utf-8?B?MGtEOE5CdHVkQXYwa3EreFI1RWRERytHa2hWZWNtbGsza0ZRRVE3VGFrTjBC?=
 =?utf-8?B?U0hJc0ZWMGZJOGQ0OVlwSkZMYTNFeEU4b0FpbHNWaFZIRXY3SzdLbGs5dWNi?=
 =?utf-8?B?MG43S0RvSU5XYTB2NWd3c2k4SnZDNlJuUjBZd2dzM1B1RlZCUW5VRTZ4b1M2?=
 =?utf-8?B?bnVNZXNVOVFyRFdxbWRpd0hTQm1CT2txMnVpY0M5TC9DeGthbXdScnhRUGRC?=
 =?utf-8?B?eEFCNUQwbWNXckJJWkpkRytUWW5zdnUzTmYzRXJBUW1zTVMybEFRc0V5WWNm?=
 =?utf-8?B?ZlJKZjByZzllMjA1WnZIWlRNVk1KemRuZUhhc3FVaGNmZUVIeFUxQ0swK1lz?=
 =?utf-8?B?c0NicXhpZ1dxQVB0VEw3RmFBSjVOUTR2Rm0xMEdUNE9MdzZCNVpQYVVoMy9U?=
 =?utf-8?B?Z1h1ekd2UHRqdXZFNGxUbFQzL2pFRkRGMDZrSlBjU3hmaUVhRURIRWk4NXMz?=
 =?utf-8?B?Q3dONWdkTHBqQ0EyN2Q4UkphbjNHTzRGaEYyQXEvZUhWNWpWZlhZOW52Y1lD?=
 =?utf-8?B?MENkTWpUdEM4UHNadXNuaXBPbGpJK2JsaVFEOXkzSE9BMUZXWncrVXZHeXB3?=
 =?utf-8?Q?rr34=3D?=
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:38:15.5395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ba65fc-0062-4725-ed00-08de3d824b9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649


On 17.12.25 14:48, Robin Murphy wrote:
> On 17/12/2025 1:32 pm, Nirmoy Das wrote:
>> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
>> bridge that causes them to share the same stream ID:
>>
>>    [e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
>>                                      \-02.0  ASPEED USB Controller
>>
>> Both devices get stream ID 0x5e200 due to bridge aliasing, causing the
>> USB controller to be rejected with 'Aliasing StreamID unsupported'.
>>
>> Per ASPEED, the AST1150 operates in PCI mode where downstream devices
>> generate their own distinct Requester IDs. Set
>> PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to stop false alias detection.
>
> I don't think that's really the right quirk - that one effectively 
> means "RID aliasing upstream of this bridge is irrelevant", whereas 
> what you want here is "RID aliasing *at* this bridge doesn't happen 
> even though it looks like it could". With BRIDGE_XLATE_ROOT, I think 
> if you then put this behind a contrived upstream chain of additional 
> PCIe->PCI->PCIE bridges that *could* legitimately introduce further 
> aliasing, it would give the wrong result.

Thanks Robin. You're right - I'll send a v2 using the a new 
PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES quirk Jason suggested, which 
correctly handles only aliasing at this bridge.


>
> Thanks,
> Robin.
>
>> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
>> ---
>>   drivers/pci/quirks.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index b9c252aa6fe0..a7a1bf4c4354 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4453,6 +4453,20 @@ 
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
>>                   quirk_bridge_cavm_thrx2_pcie_root);
>>   +/*
>> + * ASPEED AST1150 is a PCIe-to-PCI bridge that operates in PCI mode 
>> (not PCI-X).
>> + * Although it reports as a PCIe-to-PCI bridge, the downstream PCI 
>> bus does not
>> + * perform conventional Requester ID aliasing - each device behind 
>> the bridge
>> + * generates its own distinct Requester ID. This quirk stops false 
>> alias
>> + * detection at the bridge, fixing IOMMU StreamID conflicts that 
>> break DMA for
>> + * devices like the USB controller behind this bridge.
>> + */
>> +static void quirk_aspeed_ast1150_bridge(struct pci_dev *pdev)
>> +{
>> +    pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT;
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(0x1a03, 0x1150, quirk_aspeed_ast1150_bridge);
>> +
>>   /*
>>    * Intersil/Techwell TW686[4589]-based video capture cards have an 
>> empty (zero)
>>    * class code.  Fix it.
>

