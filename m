Return-Path: <linux-pci+bounces-24919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D6CA745AB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9116B5C8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C91B87FD;
	Fri, 28 Mar 2025 08:48:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5A1C6BE;
	Fri, 28 Mar 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743151717; cv=fail; b=t5fQIrvVivlKa+Tj0GWrh7z+r5q4HtMC92Ubf0ynMqcOktS1z8pLFAWPzBA4vv0oMro4qFIsA/4eRZoqtJ7PiOHU3LXzcteGn0410GFIYDBIkz3INF3teJriRUabtsfCrKjgmKNhLwzW+tqZayV5KimZd+AA898UkEsM+PhUJ5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743151717; c=relaxed/simple;
	bh=xXnBOBSULOhD2skRnACJ/byE2Edf7u8z/Nw+beW8NyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV+Fj2WH7zeMXpG5HuXNQWY+Nf8/gG/9Of/V0AZwUNoHTyErI/H63gQpcp1Ow+ETJlYONEBMJNHMuDtmUSwR5CpJHaWEMPpJAptvyeDGbfRsBbX+eHALDC6MhJAG5rBIq/mBvX384jGeXANqU5NwfdYTCPfxhCvUFQS/ZjzhiZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+d+x8YXYuq9Ls0gL08c8wJQG0SQGb/p5MC5wrMTeYlwkhGXIUtThrb9n6VsFALh6f1EAREcdpz5nmqSplohTi0RY97s0jJ6KJnP7sJV6FQChGilPH5oHfZXKHRI0HE0Lq9878x8dR9iOXBaUAEdaPOd2w/c1HDLNkW49eWXvr69zmHKxyKgxNK/FsbDzN7sLwBqfpb/5Qe3Y3a4h70IlccjAsijLTY9Dyz2pEPHZTW+rfNOpP7fiyP4sOhV3Tx6I1kY8eqZc1GaNJoTRNJFnoBqwNlxbBphOpCG2Cn33BzRhCyLxR9ak68nxXlX7ymu+AvHwetcrA22JmLYhITpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPOE3NVLvgMt6HVkW86Zy1q3QGqWtj2+1JccXytRWBo=;
 b=ZaKZE5YemBD9hA9zsV8Bwqs4tzC2OmVfcjM1vGLPl2rY8ha7AMN6oxi8ZkeOZjBJLlhaOCvgi9rGzk0tkdckjZH/8cdzqronfHk0AfafkHa0m9hUh1p+QPDeBqzcaTEF68qMq/HHfXBriVCfB0mgedLtExE+WlC3QA+ygiUn4kOwSPK+HKctasfIxy29mOtjxdCD/MOLGxN0yxFYZZJr5oLd1ydDDH4vwSbjo1oblppfpEKIuQ65Ahqfls4ffn/IOABnFfeoPEwha761EszBh6qmLRMhsoDqBUF9YM/+y8VineB7HHGukXT4ZiWcPcfO8KgAEkPTRYw/Xzwqjxj6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0062.apcprd02.prod.outlook.com (2603:1096:300:5a::26)
 by JH0PR06MB6416.apcprd06.prod.outlook.com (2603:1096:990:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Fri, 28 Mar
 2025 08:48:30 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:300:5a:cafe::ac) by PS2PR02CA0062.outlook.office365.com
 (2603:1096:300:5a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Fri,
 28 Mar 2025 08:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 08:48:28 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B90254160CA0;
	Fri, 28 Mar 2025 16:48:27 +0800 (CST)
Message-ID: <4bcc07b1-00ce-4ff9-bf23-e06b78950026@cixtech.com>
Date: Fri, 28 Mar 2025 16:48:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: pci: cadence: Extend compatible for new
 platform configurations
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111106.2947888-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250328-poised-dolphin-of-sympathy-e1d83e@krzk-bin>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250328-poised-dolphin-of-sympathy-e1d83e@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|JH0PR06MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4a9fe3-d727-402d-029c-08dd6dd54fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGFqQmhrMGg5Ym1lem5SWHRXbWNEUDZiY3k2TWVBa0x4ZlRUTEtiT21uaTVI?=
 =?utf-8?B?NWVUdmRyVHNvdzEwVytJNjBiWG9CQVpaV0F5c2lKb3BlSkpuRXhBYThhR1FU?=
 =?utf-8?B?aDEybVo1Sm5RRmRZKzllRG1WVnFCbmxKME8wUjQ1RE9ZYkVvd2s5bDhvZ04x?=
 =?utf-8?B?aHpXSmRVSkhSaWVicXpKemlrb0NzczZOYzYyQXlOeXlDRDA0Vmo4dDNXVGUy?=
 =?utf-8?B?N1M5QUpIYk5Zb3pKUGFBMHArMC9Db3YvU25mSGl2blVlTEE1MFBoKzRIeFdw?=
 =?utf-8?B?a1BHdmFoV2VkS2ZJTG9tZUpnam1OYWlEK0E5c1B4b3k3VEhqNloxeFdMM2FY?=
 =?utf-8?B?NVdsUE56M2NUR0tjS1k0disvdnNaZndZTkxiUVFsd1JRWCtkeVV5dkpmVFdh?=
 =?utf-8?B?ak1PZHdtaHh3L0wxTkpnNzBSbWV3b2J3c2gzaFZRbDBERkNkcXBUWmxaSlVp?=
 =?utf-8?B?bjFETTlncUx5bFdMcUgvcmNENXc1Zm9uVEN4SHl3TWIzR2ZkUWRHVTlmT2kz?=
 =?utf-8?B?SGhWV2dzbzRwRTFoeHRZeGZYK3E1NHNsTURmSmZvSEpDQUN3cmFLVEllK3Rx?=
 =?utf-8?B?RndtQ05WazBoUGtrclI0cFRtUE4xTmhsbmI2by9TekJ1K21zaS8ybDRoZlpr?=
 =?utf-8?B?aVQ0LzZWWHptOTZSUzFpYm1MSkk4L0diZ3o3bDBCWlVmS0JJSjJRL2dmVTc1?=
 =?utf-8?B?eFppSzh3d01LN1lvZWlETExoRFQ1R1EvWTh4UkxUTzF2MDRaVm5QUjZFZE4w?=
 =?utf-8?B?aUc0cFNhLzBpZy90QkhOeXRlbEJBV1g2b0szd0ZMdTRQbGNMZHF6dHJuWkdq?=
 =?utf-8?B?RUJVb3JRRmNyNTlsNUZFbm8wWkF6bWk5SzI1ZVZjSGRpYXh4Z1R6ejRoYlF0?=
 =?utf-8?B?Q0FvWnFZbFhvQUFsOGdPVmx2Y21tT3N6SzJ6V2x3QmQzd1FNaGZsNUNuNURp?=
 =?utf-8?B?blhJWUVZU2xBVGFuWEVUQlU3ZGMxQmN0UDAxVkE0cTczV0RhYmo5TkVxRFRv?=
 =?utf-8?B?NlNmd0hud0czdnBheCswdEEzT3BvWDh0eUR5V1c1UE5RME1KRW1tZjFHNnFF?=
 =?utf-8?B?RmtDSVYxSFZVT0pIZzBsY0lHNUVBaEd6STZzeGh3R0tWVTRSSXNZeWNoQnc0?=
 =?utf-8?B?MXRhYjJYNzFsc2xoZFlrV05GRUhYdjZEbnFLSEZPYzQ4OVpUZ205d1hOL01i?=
 =?utf-8?B?VTRac3ZRL0pMS2tSR1M4Q3ZEblVOa1o5bDluNXZoNEpGaWNVcVFXRFVHUUtl?=
 =?utf-8?B?Sk8rR2xEVnJQbDdrT1kxYlpSSHc5VUhVOFFvdEhjNHRHdTdEWHBHb0pKNUxX?=
 =?utf-8?B?SmdraFAyVVlTemlUYXUzTkg3N1pPQ2pnYmF4ZCtKVjVXbnU2Yi9DQXFoeEJX?=
 =?utf-8?B?OUx6QnFkS011cEVBYmM5amQ5bUVZZjBNQzhrVW5pMnZyUEtWUjNoMnE4RG1W?=
 =?utf-8?B?WmZCMnhIcjZXcksrS1ltL3FTVGcwM1MyOGJpdjBzRGRnbStmUGNIcmd3bU8w?=
 =?utf-8?B?OFZsb0tuMWZqanpmMDB0L1Z6L3JUa3MxQllVbDFueFhjWXByWnloMHA4NGg0?=
 =?utf-8?B?eFowdDBNUlgzdFg3UmI2elQ5ejM5R0IvdVlLdTgwSUk3SnI2cUsrR1kvRDRK?=
 =?utf-8?B?WkdEWXB2UnNrY2dueHduaWttMTV5TW5GbGVhOEdKRjlSMjdTNk15VkZhVE51?=
 =?utf-8?B?UzZqTGQ2d0Z6SnJyUzFFUG0rTk1MalpoOXhxdjhLM0RWVzhmMThCaHQ0Qm44?=
 =?utf-8?B?YnZEbit1MUd4NjZRWkxOK3RDTUhWUVcwNW55cTRRdjN2OHh3d1pPQ1Y5WS9z?=
 =?utf-8?B?M1BjdDB6alQ3NXhWcnl4bWRhKzFnRlk5TjY5bW9Nc3hzN2QrQWN0K2h3ZkVK?=
 =?utf-8?B?UXRFQllNcnRYSjNmVlJlcHlNK2VlWUUrNEJvQ3RSVWVoNEk1SmpvQ0YzV3Zs?=
 =?utf-8?B?ZDVlUnpsSUgvZGk0b2lwNjIrSE1HWnFQcXhGTWl5U21SRElZY1gxOEZzNUNu?=
 =?utf-8?Q?BJGuAkQk0y5qiHzuwrYs/qdzJinbSs=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 08:48:28.6637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4a9fe3-d727-402d-029c-08dd6dd54fb4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6416



On 2025/3/28 16:22, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Thu, Mar 27, 2025 at 11:19:47AM +0000, Manikandan Karunakaran Pillai wrote:
>> Document the compatible property for the newly added values for PCIe EP and
>> RP configurations. Fix the compilation issues that came up for the existing
>> Cadence bindings
>>
>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>> ---
>>   .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  12 +-
>>   .../bindings/pci/cdns,cdns-pcie-host.yaml     | 119 +++++++++++++++---
>>   2 files changed, 110 insertions(+), 21 deletions(-)
> 
> One more thing: SoB mismatch. Maybe got corrupted by Microsoft (it is
> known), so you really need to fix your mailing setup or use b4 relay.
> 

Hi Krzysztof,

I have obtained Manikandan's consent and we will collaborate to submit 
the series patch. Our Cixtech P1 (internal name sky1) is currently 
upstream. Because I need upstream Cadence root port driver, However, the 
Cadence common code of the current linux master does not support 
HPA[High Performance Architecture IP] is the second generation of 
cadence PCIe IP. Subsequently, I will send git send-email to pci mail list.

Peter Chen patchs:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20250324062420.360289-1-peter.chen@cixtech.com/

Best regards,
Hans


