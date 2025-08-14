Return-Path: <linux-pci+bounces-34018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD845B2592F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 03:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B5F1BC79C3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8EB2FF658;
	Thu, 14 Aug 2025 01:37:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023076.outbound.protection.outlook.com [40.107.44.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB5189F3F;
	Thu, 14 Aug 2025 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135467; cv=fail; b=Ru7WUN4sW3n6Gh0YncC0IW/JdpgvaCeKVMnwPeKXPsxu1XWxnio9j9Nb8TH20JksW7iVm4uAy0sEZeS4TuF7pD7OuheO7laKnH5RPNQSO4+yXVeOud3RfC3YMEDvEn/9jhS+MPbHeeDULUyxXrY/cDVuV5vhUmCHtmSyDHzmXSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135467; c=relaxed/simple;
	bh=CJaj3yslVEF3GLQCVsujTaXNVdj3DzhjiYmNdaPNnNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqbfZGnI17oKQtjWIeQHgXi4457wZaXw3IvG8lr037JbUhlamj/PugltubHFqVIjyTLO5vjS6ZNX36sCgbJB+7pJ9nGcLi5WsL5t3mTQEROTaX94rtpRZBVxMj5FOhXQI5p+huCq9OHvGX7Ght1U6ns7Pp/roqaXtaqBNncM5t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8balTbRZOPfnZ9nvkWbaLfXDg1/tlOKcT6xCOZQ7IrBQ09KTXqowWBq+UkIx9ZqF4f2dLW2KUx8GpbJsoAqrjJhAigT++VyEKA5dRW6qEdeThr+O0GHo5BZcjlQDZxD9+MolWP8R12gSXTNePny3pVnGl7EeieQmqcRlAaNfnCZV3GCLuIe9WTrkNkNjNPdAlIHuBfUdyDIiTlIHDTgO1f8ATwN9ka9QzAFuxSeuATWB0T0RlC9TXpQSU2eR+imO7sBE8XQe64UFcMO/LPvY9+8NbAkI6EbgwGtf8WnOTH9uYSWimZiKOhnQE80YwXeXYPb3Vj8uJDPvnsfRrpzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5SlmHeBtBrjKmqXgTcubHOV1JZUHMVkI5lsRQEau/A=;
 b=FJ3saKL5Ot0j+DTKCXcWLbaGueFh6FKGZAiH9ZBR2DMRcXOmkheBquC1TykIkkG2EUEFQYAB3QeG8e0zBjp2VC9UGk+3vOJiIAzapTqUSLRuogFzFDoSOToenPQXMRdtUYN+uvawCNM1zxYjhvZGonJU8i5Y/dfW3+MxyIvZ3KmgTdwNCYc5QabmiKtc62XWEJtl04hKRsKnoqDCbIluUcHNevBOTvjNmtfz6iBXlO+iiRM0TGTkrHMHyAYF4BbFZpR7TmudUeh5mBzBMARblN+tygL9P3oQ7M/D0pEBhxIY5iTpURpLQ2cgI1HZ0lB1d2qWEa5Y2mVJIW/3BiU74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OSTP286CA0068.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:226::14)
 by SEYPR06MB6663.apcprd06.prod.outlook.com (2603:1096:101:175::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 01:37:40 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:604:226:cafe::73) by OSTP286CA0068.outlook.office365.com
 (2603:1096:604:226::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 01:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 01:37:39 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 566E740A5A30;
	Thu, 14 Aug 2025 09:37:38 +0800 (CST)
Message-ID: <67928928-6e75-4683-9445-0c25a9d606b4@cixtech.com>
Date: Thu, 14 Aug 2025 09:37:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] Enhance the PCIe controller driver for next
 generation controllers
To: Krzysztof Kozlowski <krzk@kernel.org>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
 kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
 peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <cc4f69b3-4d9b-4a6f-a296-61ab5ffb9565@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <cc4f69b3-4d9b-4a6f-a296-61ab5ffb9565@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|SEYPR06MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e9ebef-d79d-4ac4-5a0f-08dddad3278d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1UxVmthVGlxNU9OQjJMU3UwUkgxWFB5VE5wd1lZa3hRUHdud1B0YTMzekhP?=
 =?utf-8?B?RjlTWjZBbjFYU0VVdkUreFJJZ1Y3ZzNoSDJrNklzRU81MzhsbTg5MXVlQzBP?=
 =?utf-8?B?Yi9LdW0xd2RNMEpFb3ZXd2dMN0ttZ3ZSS29BbFpOc090QTRXQnJVNWRRaExp?=
 =?utf-8?B?K01QQld0b3hWYlNyTnRCMWJDNFpHbDA3M3daNTkzdXNRZ0JkcWxHenNlRThj?=
 =?utf-8?B?dXRIaTlNdmZvaU9CWkdvQUlEODNXeUt2SGtNNW9tY2NsR2ZqdFZacWJMcFc4?=
 =?utf-8?B?QjZEbmJ6S0l3VFVIaENNY2RQdzAwWXRHbG9UUUFBbDQ1U0tBTjZ1bXJia3Fl?=
 =?utf-8?B?Z1NTUGhXc3FibTJxRmxqSDRMMHZ2VllHZm9iTWpXa1pTa1pRemlaeGhJOUJh?=
 =?utf-8?B?QTV0UEV0Q1plZTUyQlF4REE1dWdWMlhaRGthYmpXek11Y0x3UE1lbkxpM1dK?=
 =?utf-8?B?RUFkTXFPY1NYSFpiYnhybnRyTEJEVGNMd2ovUmQ0dmR6SWExNlFaNlVRTCtY?=
 =?utf-8?B?QjFkN2c4ZDY3dWc1ZU1PYUswbXhBc0k0K0ZqYlRmT0dvSEZjeE5GL1VOZVdq?=
 =?utf-8?B?ZWNsSUxoWnJQVkQ1OGc1UkVSeFY5RldyWWUxQmpmL1VOS1VvYVZURWF0eHNo?=
 =?utf-8?B?Rzh2VkNOc0lmNmlTSW4yVllyeU01Zll4Zm0vSDB4ZkFuTnlSaXhhaGpDWWtH?=
 =?utf-8?B?N3NIUmFOWEtQUXFwK2J1S2NwNXlKTmlCSFc4TXpyZDMvd241emVWL3VUM0lU?=
 =?utf-8?B?S3g1MDZRZGVxQU1ldG04bXdicG94R1V6aHNsSmRqV0dnVzJIYVRoY0Z4SUpw?=
 =?utf-8?B?eWF1S1lmK1B4ODU1a1FCbmFHaXpqV053WHZZeE5kTnZRZ1JCbERZY3JPdHFE?=
 =?utf-8?B?OWQ2dnM1UHJidXZqQzliVk4zVm5DWDZRbzBFdnJSNi9YNWVBc1hIM09KOERx?=
 =?utf-8?B?UVVTUk1xTjhtcUR4ekJpdDVwYlBHenRodC8ydlhhN3Ezb013aVE0RUdrWjVN?=
 =?utf-8?B?NGRIbkEwN3hNdkpUdnJsYkdyQWN0Ky85WW5TaWZNeVlKK29ibWtTdzgrNVdz?=
 =?utf-8?B?OWFUYWtZeEJtQWdMTi8xVHA1TE9hMUdhRThPZ3pIQUdlMENmVHRvMmpEMHdN?=
 =?utf-8?B?QlE5WUFnRlJqUkREUG5XRHd2UVB6eEVRVm5HN0s3WDFpbDkzLzdlMGxmOW5p?=
 =?utf-8?B?ZU5kU1RIZDJkbWhENDlUTmg1OUdObDEvanpnTk02VG8xRDhEam91L1NML1Vr?=
 =?utf-8?B?UEpHcnQzdWhNU3BaYzloeVVySHdEdlFOTnJmSloxMFFiZzk4RGN5ZElLYStF?=
 =?utf-8?B?NzY0aFNGWEpaRjNBWkpONHRYV0dVSDV1RE9MM2ZMUTRRb0grZzZYNzk4bXd5?=
 =?utf-8?B?SEIyVUNGVTNqWk5iVi9tSG9jZ01iZzZSdDI0dHVVR254TkFMK3dFQkVTL3Qy?=
 =?utf-8?B?b051MHhjUDFKUXVsbEkvRWxXbVJTWWdtRGFNNEFydElXRUZIY0lXS3doNm9X?=
 =?utf-8?B?eDNkUGdiTkRESFpRMC9zZ0NBbkVYS3NpcGJHMVBxTWtFa0MrUUxpSUkyVmpI?=
 =?utf-8?B?OU1hekt2WTRUSmpEcnpFelpBeEpNUHBIVHl4Z2pEak9kZG5pZG1wL0JGTE9Z?=
 =?utf-8?B?MHkzNk8zUjRReElJeVJiUllOY09GVjhqUWNJU0tZK0lFa3VWUTRROEVYYWtu?=
 =?utf-8?B?WFl0RkpRZDYzRVROMVBuYVM3N0FSRlRyTDQxL0didG42bUEzRUlpcTJaVVo3?=
 =?utf-8?B?ek02cndGclNmcVRMU2EzclFNd0lHbmliSkVNQlB1RlNuUkVsVnRFcnJpanNJ?=
 =?utf-8?B?S2RIejYrY28zOVRxblZZcjJ6YS81T2c3SzdyeUV4V1ZZU3NodTJJcmtaelh4?=
 =?utf-8?B?WEdhcmFCUGhobWZ3VEtNY2tFdnJwNEVVNXo4RXQ4bVZUOU9YdEdGUGY1ZEZs?=
 =?utf-8?B?OWM3dzdWdEpWc2RKQVMyak00K1VRaUhmNVZ0ZUZOdERsN05pOHE1VUJXajUw?=
 =?utf-8?B?eWpwM2xWUFJUeVBGR1BzZFJtSFFhYTl2M2dXTG8wakJEWXJjRU9rRWdqQTlv?=
 =?utf-8?B?RlRKMUQzSEE5UFl6cnJFeFpQREp0SVp2N2dXUT09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 01:37:39.0960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e9ebef-d79d-4ac4-5a0f-08dddad3278d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6663



On 2025/8/14 03:14, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 13/08/2025 06:23, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> ---
>> Dear Maintainers,
>>
>> This series is Cadence's HPA PCIe IP and the Root Port driver of our
>> CIX sky1. Please help review. Thank you very much.
>> ---
>>
>> Enhances the exiting Cadence PCIe controller drivers to support
>> HPA (High Performance Architecture) Cadence PCIe controllers.
>>
>> The patch set enhances the Cadence PCIe driver for HPA support.
>> The header files are separated out for legacy and high performance
>> register maps, register address and bit definitions. The driver
>> read register and write register functions for HPA take the
>> updated offset stored from the platform driver to access the registers.
>> As part of refactoring of the code, few new files are added to the
>> driver by splitting the existing files.
>> This helps SoC vendor who change the address map within PCIe controller
>> in their designs. Setting the menuconfig appropriately will allow
>> selection between RP and/or EP PCIe controller support. The support
>> will include Legacy and HPA for the selected configuration.
>>
>> The TI SoC continues to be supported with the changes incorporated.
>>
>> The changes address the review comments in the previous patches where
>> the need to move away from "ops" pointers used in current implementation
>> and separate out the Legacy and HPA driver implementation was stressed.
>>
>> The scripts/checkpatch.pl has been run on the patches with and without
>> --strict. With the --strict option, 4 checks are generated on 2 patch,
>> which can be ignored. There are no code fixes required for these checks.
>> All other checks generated by ./scripts/checkpatch.pl --strict can be
>> ignored.
>>
>> ---
>> Changes for v7
>>          - Rebase to v6.17-rc1.
>>          - Fixed the error issue of cix,sky1-pcie-host.yaml make dt_binding_check.
>>          - CIX SKY1 Root Port driver compilation error issue: Add header
>>            file, Kconfig select PCI_ECAM.
>>
> 
> Where are lore links to all previous versions?

Dear Krzysztof,

I will add it in all future versions.


V6:
https://patchwork.kernel.org/project/linux-pci/cover/20250808072929.4090694-1-hans.zhang@cixtech.com/

V5:
https://patchwork.kernel.org/project/linux-pci/cover/20250630041601.399921-1-hans.zhang@cixtech.com/

V4:
https://patchwork.kernel.org/project/linux-pci/cover/20250424010445.2260090-1-hans.zhang@cixtech.com/

V3:
https://patchwork.kernel.org/project/linux-pci/patch/20250411103656.2740517-1-hans.zhang@cixtech.com/

Best regards,
Hans

