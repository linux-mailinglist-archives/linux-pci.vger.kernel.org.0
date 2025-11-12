Return-Path: <linux-pci+bounces-40961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA4C51146
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2F044F1CC9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF80258EC3;
	Wed, 12 Nov 2025 08:16:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023097.outbound.protection.outlook.com [52.101.127.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD49192B75;
	Wed, 12 Nov 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935390; cv=fail; b=RLCtEO1HmPJV0IlAv9VRxlDYZGx0sGWEkq/mJxSXjNG8YSr/+wJ0WhwTiOoCrSvclrriEMN6cR1eQYaDC8BJbqgJuKR4UiOW1baWuOQQB1OdiXxGQobMiD6WnHDQT3Tr1u6Oeu16t/yyisx+srIb6hYPc2cYE1CJyvQTopWx3vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935390; c=relaxed/simple;
	bh=B4vmzwFeFhNfcQh/hJdyaOTxemHAtP/wYr7DTEixFg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWptPuH3csM/r7HR+RbExCbsop+ec0kBnzqGrf9B6R9SsrSVtkv/8Ak+H22kCiU3Ksx7UNdnQDhfzQ8z9vo1xvrGjq+7Qcvj6Jg+kr9XR9OyNamykRRPQN3+fYywwIzfji/UAty/gsQgXa3TwjBvOL0AKjVKzCWCkda+DlKzM6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFQN9kbz7tUhVBf6Z0m9J8OPwskgW9EN/m89bHuXgTea6Ua5buYKpTn+ak+5lhjmpbM0XRBBTUQ3A1YXB4XhjLEEeiGursOc5ijV/REbDItcMkDEB9O72rqpCpcPcDyLGf56i1hNHGls+HJPUEl1UeewNyWP8jhmrIabdQKhdUx2h0+5sS5zEjAMvbwtRXmzZuwfNOkaZsOWIo0JYtacXAg6FcAf0UDMxUEOA8kDAtx52Aemv2EeNwxWvcmlmM7h8dFFWFA4yEdm9EC+0WytBNYIeh6KoriLWg3ql15Zbj45/tTsJLD7Jq2zOaaEcCLO3a+uLgulbFPbd5LxM1lvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfS25oS8hY1os5ebwj4UanmRQauctaa+HiRFK34WJts=;
 b=U7cuRJ1Tcg7nmMpbmmHEcUoMvFl+j45ltkiqXH81U4s7KWoQMl0hMc2qm2nKngv+IkLBcq0sVLy1VuagrtNbnPsu+aA5Mmd9I4tkAnaA68OAZFXLHXZc6vREcD66o8Ip6C1sd9nfnXMkJBQJrYWXKQsTYc6qWD8WzCVe9xT1Kh/bSK6NBoA7h/Bdl3d5cNohLqn5oUFEFGP50ibqZr+V+RMW63l6KkHNUG4xnFdYJle9kkSSV+PUvNZvDm+CUuEDGvdWMjsidxMAozAjrbDCKCyt5rVh4v5LbLX9tXbrmB7G/s8ir8YbfnHC2L81ag968oibR/CmBz7h36iquvZ42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=163.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) by
 SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Wed, 12 Nov
 2025 08:16:23 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::74) by SG2PR02CA0004.outlook.office365.com
 (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 08:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 08:16:22 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9515941C0160;
	Wed, 12 Nov 2025 16:16:20 +0800 (CST)
Message-ID: <58b37b3a-7bb7-46bb-8ad4-f4d2f152bf1f@cixtech.com>
Date: Wed, 12 Nov 2025 16:16:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] PCI: Configure Root Port MPS during host probing
To: Mahesh Vaidya <mahesh.vaidya@altera.com>, Hans Zhang
 <18255117159@163.com>, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, helgaas@kernel.org, heiko@sntech.de, mani@kernel.org,
 yue.wang@Amlogic.com
Cc: pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20251104165125.174168-1-18255117159@163.com>
 <e940eae5-16bb-46e1-83aa-47c6ff747083@altera.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <e940eae5-16bb-46e1-83aa-47c6ff747083@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR06MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fa7845-5242-434b-f508-08de21c3c3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEFGUTg0V1BwSWJuc1I3ZWYxM2hWMk1PR3FZeUhHY0QyeDN1U0RPRC83OWsv?=
 =?utf-8?B?N3VkbENBNS9CVXdPUEUvSml4Tlo2TmJLVzF5cEFRSmgxVk9GR3FXOGJjUUlB?=
 =?utf-8?B?a2RzK0ZsaVpSczRXQUN6V3VFTjZoUDBYZFdUQ2ZyZ0s5U2MvNFpHZFlWUVNS?=
 =?utf-8?B?OFIrRWZsQTVyVzhnaGFBN2VRSnRYQmY1QmZEUWNOM3FjY1liYmZ2NmI5VXRl?=
 =?utf-8?B?c045TmkvNE85VGFaRlhIaTVjNVNJK0E5UUVWWUFSQ0ZHREpobkxzYlpiM3Fj?=
 =?utf-8?B?aFBlaDArOEc5OU1KLzcyWGYrQnNOR0NJZytZWEc1VC9CdHg3ekFWS253Q05M?=
 =?utf-8?B?Z3NTUVZEQUg3eVg3NHFtVjRRdnRUam5RZDFodllVRWF0d0ZzNGF2Ykp6MVBX?=
 =?utf-8?B?SjJCbWtZRnZNZmltdHJtQjgxQStCZHhwdzl1alBqbVltdFZOV2tWd0pKcWR5?=
 =?utf-8?B?ekErS005Vmpvc1I1QnM1eGF2OHRnY0hya0ZueEQyRjJkMW1TZW1sT25DN1RB?=
 =?utf-8?B?WVp4MllpT24zWWZGZWc0VTg0SkJPNmpQc0Z4Rmp2OFR1R0FWcWQyQUV2TEUz?=
 =?utf-8?B?WmlPMGYxZ3gyM2g4ckc5MGRKL0l1NVc4eEtzU2Q1VHhxczFKQy9jZytJdDFX?=
 =?utf-8?B?dGtXeGdOa2ZDUFRUOXMrc0NrdllaQnRRWmErWVlCTW5JMm5peHRvQ3U1SEwz?=
 =?utf-8?B?Q3grdE5LMEFIaTBCalJwR0xWWlgweDFTdTdvMkE3czBXWXhGTzRPaXByZFJH?=
 =?utf-8?B?UDRPMUJUemtGbkZLSjNKSkFEclBjOUdOWGFXNTZyem9UTWl2UGl0MW9LVDhx?=
 =?utf-8?B?eFZEK3dEVlFWQ21SZzRWYklvQVU3R3ZCbE5DQURKZEtteTBiWlNWeXBZNkNs?=
 =?utf-8?B?T2JXcVRGQXpTdEJ6dWdTUldqN3N5djJWM2NnMVdNMGdtaXlwSjBJTkdsZzNM?=
 =?utf-8?B?MzFUWEZCS09kT1JXSzVZY3d6OUdaZSs1bzBvSDRJaEk3NmlIWmNBd2ZpdC8z?=
 =?utf-8?B?aDdjWnd0Sy9lb2dQZVlLcVdBak1mT2FWVlAxcDhYa090SDRxbTEzVmx5eXg1?=
 =?utf-8?B?dWlGL2pvbVN0MDhIWTFjaGR2akJITlFhTHhuU1ZKZWd0THRrK1o5Vld1ZDEr?=
 =?utf-8?B?dlBVS2s4d1YzK202N0hBTXlrcU5kMWlLamRsOGw0eWZISXhWdmRaSWtqOGlF?=
 =?utf-8?B?a3F6MHljK2FPL2hPbGxubytKM1YycVhoZmkwNldhZU9DYkFuaUQzSDVET0Nk?=
 =?utf-8?B?czBZeUdOL2F3aER1dGNCUCtpd1NoMC9ILzBySTlXKzIvV2MvQXRoajRmZ1Ux?=
 =?utf-8?B?Q3k4Wm5JNDhzQWhPT0ZGWnFCbzd2UzYzYmIwdFc5blRhbUx4M0UrTlVWYy9U?=
 =?utf-8?B?cTd3TjNhc3hxWCt4aktOekRpN040Y0U5OGF0YmJDQjNhSjZYeFVvc2RWWk5a?=
 =?utf-8?B?NStVUDRSNHNiS2tUMHl5bVpTMURPVWZlMWFMb0VDdGJZUkNuVjFuS1c0Q2d5?=
 =?utf-8?B?bzhtMkVOcGppdThCcGpsSXBQb3laTEJhcE5xM1dmdmp4NlQrV1luNGlxM21L?=
 =?utf-8?B?WjJESmxVTjZMMEdaSFNYTUlEQjNFSkpHMHJnZlpQZG5ONVV4YjJJcHhLSmRn?=
 =?utf-8?B?TkI5OTZadHQ3OGg3ZklKZ0I3MWZSY1FNTUFXczJHZHh1VU8xRGF1eHE0eGVC?=
 =?utf-8?B?RlRWbStIY0pmeTI2U0hyZkRGd1VEZjM2cnluT0xBOHpEd3FFRnBjMlBPYnZO?=
 =?utf-8?B?VzN0a1I4ZE1adUNiRFdsR3FFdnJKSVlXZUhWUmxEWWROVWVRajM5QjlqWUhU?=
 =?utf-8?B?NXFxaElFWnhIeGlyaExmVE5TY05ZTk1ieFROVEtsT2RtYTFBYWhYeE9BREFo?=
 =?utf-8?B?SDg0N21ka3IwcUxIaUNpN3ZNNDB0amxsT2RBaUNNQUIwQkNQZE04RlVaNXhB?=
 =?utf-8?B?VW0yUFlOTUM2NGJUc3dJR1EwR0ZOVjc0N2l0RWd6QlMrTmd3UXRBS1pBMkE2?=
 =?utf-8?B?NnFTSDkwVXhvcEJJOWYvT2tadmFlNXc1dnRNTmpZTjZ4WW52WlFNRjM2a1Z3?=
 =?utf-8?B?SEdYT3gyZXZ3VzZGTFVJUnVEWFBrNlF2emlUUlh0dC85UWRNTkZFNkluV1Ro?=
 =?utf-8?Q?2ehE=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:16:22.1239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fa7845-5242-434b-f508-08de21c3c3f3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6871



On 11/12/2025 4:06 PM, Mahesh Vaidya wrote:
> [You don't often get email from mahesh.vaidya@altera.com. Learn why this 
> is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On 04-11-2025 22:21, Hans Zhang wrote:
>> Current PCIe initialization exhibits a key optimization gap: Root Ports
>> may operate with non-optimal Maximum Payload Size (MPS) settings. While
>> downstream device configuration is handled during bus enumeration, Root
>> Port MPS values inherited from firmware or hardware defaults often fail
>> to utilize the full capabilities supported by controller hardware. This
>> results in suboptimal data transfer efficiency throughout the PCIe
>> hierarchy.
>>
>> This patch series addresses this by:
>>
>> 1.  Core PCI enhancement (Patch 1):
>> - Proactively configures Root Port MPS during host controller probing
>> - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
>> - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
>> - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
>> - Preserves standard MPS negotiation during downstream enumeration
>>
>> 2.  Driver cleanup (Patch 2):
>> - Removes redundant MPS configuration from Meson PCIe controller driver
>> - Functionality is now centralized in PCI core
>> - Simplifies driver maintenance long-term
>>
>> ---
>> Changes for v6:
>> - Modify the commit message and comments. (Bjorn)
>> - Patch 1/2 code logic: Add !bridge check to configure MPS only for 
>> Root Ports
>>    without an upstream bridge (root bridges), avoiding incorrect 
>> handling of
>>    non-root-bridge Root Ports (Niklas).
> Tested this patch series on Agilex 7.
> 
> Tested-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
> 

Hi Mahesh,

Thank you for your test.

Best regards,
Hans

>>
>> Changes for v5:
>> https://patchwork.kernel.org/project/linux-pci/ 
>> patch/20250620155507.1022099-1-18255117159@163.com/
>>
>> - Use pcie_set_mps directly instead of pcie_write_mps.
>> - The patch 1 commit message were modified.
>>
>> Changes for v4:
>> https://patchwork.kernel.org/project/linux-pci/ 
>> patch/20250510155607.390687-1-18255117159@163.com/
>>
>> - The patch [v4 1/2] add a comment to explain why it was done this way.
>> - The patch [v4 2/2] have not been modified.
>> - Drop patch [v3 3/3]. The Maintainer of the pci-aardvark.c file suggests
>>    that this patch cannot be submitted. In addition, Mani also suggests
>>    dropping this patch until this series of issues is resolved.
>>
>> Changes for v3:
>> https://patchwork.kernel.org/project/linux-pci/ 
>> patch/20250506173439.292460-1-18255117159@163.com/
>>
>> - The new split is patch 2/3 and 3/3.
>> - Modify the patch 1/3 according to Niklas' suggestion.
>>
>> Changes for v2:
>> https://patchwork.kernel.org/project/linux-pci/ 
>> patch/20250425095708.32662-1-18255117159@163.com/
>>
>> - According to the Maintainer's suggestion, limit the setting of MPS
>>    changes to platforms with controller drivers.
>> - Delete the MPS code set by the SOC manufacturer.
>> ---
>>
>> Hans Zhang (2):
>>    PCI: Configure Root Port MPS during host probing
>>    PCI: dwc: Remove redundant MPS configuration
>>
>>   drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>>   drivers/pci/probe.c                    | 12 ++++++++++++
>>   2 files changed, 12 insertions(+), 17 deletions(-)
>>
>>
>> base-commit: 691d401c7e0e5ea34ac6f8151bc0696db1b2500a
> 


