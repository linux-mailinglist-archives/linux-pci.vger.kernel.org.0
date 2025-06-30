Return-Path: <linux-pci+bounces-31087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7978AEE27C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 17:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D693B976C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9566628A1D4;
	Mon, 30 Jun 2025 15:31:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023087.outbound.protection.outlook.com [52.101.127.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E6289833;
	Mon, 30 Jun 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297471; cv=fail; b=TG/CIHimhx/bzy1qY2Tsh5yveZk4SYZYKAmuxOOJ4tEhioGq7LFOceGRMWSpuepxdxC2Ut43QdNSryG4DZr/Q7encKHAo+iVe4kXzYs2wWr726V/mlk0J+W5eLlvwE96GfXD5sVnWDGFTQxx+m5arAfVfVhYayQ2ab9er1d2piU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297471; c=relaxed/simple;
	bh=yX8x003vyIsNbCO6RlCObrlKI+RcF4FV0ym9gI/o1PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScPPRLVQeBtsQpau3dBM9wc7eRVmCx9yYnXylMX3D+nvo4x6Fz9F/kg6vMhvfHdSFkUkV385Sgk65CxhVmtmVqwX2DARPzggplxgRhfy/MbXyffby1mj+4FNyLxMPTyNWtmtSfSJCL+UAIKfFYNci2YivmYzHp+3y/oIfsYR17s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hL+s2OohcJ/u8TUMfh3vVTf5+gS3ucHH4xHOkoutZuvjc/2Zq+MRyTgNuqXGN/tjds0FRLkWYnSkbvMWVWa6z6Hn4R6Tq71+56z9MBKW+yAi46vYBIKxUH8YFN1IftmumobXQG0GX56XXXzQ8XJAx5zMdzCH/ANmnnJom+pu7LnT11PH0iabwYa9r+is5umbqeL3ZdJ2xkBtGA9mgB3HJc4DXDaiDdcUy7ArHKOG4mHc1iwE58O4MzH034uNX14WiD06Zs7FsH+PqAJ6DdVqGtsEQHJoZ80Xk/zj7odDnlUfhzvzKaJTwsD5rf/bp1RUxHlwjqElEEUA2hKIxmA3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poJ7pVu9ML5fjnDj9uQOulq3KTWzwJ1V/gML+eu9qM4=;
 b=tBz1CIY14GRIJVUS8fEes6L0+35n1FcA40dZM+Z6Q8k0QYmtGyPJ1Cj6DSQdLpwsnhMbeCLl53+s+BNa9983yzxIgo1m4gEE/3dNKJrHhH0dTtVodHw3vUbvawRmdFNueX8IKWUZOT81+4Le1JPHMiOyPtMAl9/evCfAe5maG1Nqk6vBxv9byGPTwIEAGuWg9MQSUT1t6hD9DaAwyd40GmT+G/hvVAD+PXPPzG8K+8BrOEfy0MnDRju53wMnjvPM9eG0cd0H7+UpZglpE8Rc1JyJqZwCmSN001pjtqIy5UOHVOxZneeIJJjl4aLrKMPkSCetKyiXKMjI41YOGbSD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR03CA0024.apcprd03.prod.outlook.com (2603:1096:300:5b::36)
 by KL1PR06MB7009.apcprd06.prod.outlook.com (2603:1096:820:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 15:31:02 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:300:5b:cafe::8d) by PS2PR03CA0024.outlook.office365.com
 (2603:1096:300:5b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.17 via Frontend Transport; Mon,
 30 Jun 2025 15:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 15:31:00 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 92DD144C3CAA;
	Mon, 30 Jun 2025 23:30:59 +0800 (CST)
Message-ID: <2b608302-c4a6-404d-9cc5-d1ab9a6712bd@cixtech.com>
Date: Mon, 30 Jun 2025 23:30:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
 <20250630-graceful-horse-of-science-eecc53@krzk-bin>
 <bb4889ca-ec99-4677-9ddc-28905b6fcc14@cixtech.com>
 <5b182268-d64c-424c-9ada-0c3f120d2817@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <5b182268-d64c-424c-9ada-0c3f120d2817@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|KL1PR06MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: d46002c7-f4fb-4e64-8979-08ddb7eb1e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlFQbzlQTGwrYms0OHAzOXgxcU95L2dvcmUvb3J0QnNHbC90Z1J6VTA5M0Js?=
 =?utf-8?B?RDFFQ3Z0SkJyZ1hxZ3hua3ZydFIwOFgzcjQxZi9iQTBIODVlbTVra3NINmZZ?=
 =?utf-8?B?cXNJY1l1KzdncENkR2dOalZ3T1BrSEpPZmxvd0RvbHQ1YWJaeFZTT2w5ZFRw?=
 =?utf-8?B?QVE2K29haUFhaCsvL2EvV2tWNW9LVUl2Yk5JbnRyd3IwZk1NZFYzNWorUFlW?=
 =?utf-8?B?WkRXMnNyVjZOUUlPU3dSYnhTdGc0WHRlK2ZFdUdMY2JOVDRibnpGNlYvZE5l?=
 =?utf-8?B?amY1Rko4MDgwS3gwRnhkVHZtUHMxY29adWR3UVphT1gvYyswSDgwT1FlVFFL?=
 =?utf-8?B?MzMzSkVHYzBiZHBVUTFXOUhVOFJ6T3VIVFhYaG5qSktkbk1TbG9Hb2xCUjI2?=
 =?utf-8?B?YlF6dmpVZ1ZvTmI1WGYyck5HdkJCVDBKQ1duZ3UxR25mcHZnYlBOTGM4VExM?=
 =?utf-8?B?TFZQak5QWGxtQW80aEoyc1k1QkN3NUJHaTNhR0ZmMUI3WjhHTXN2TFQ4azRL?=
 =?utf-8?B?TzVWdHZ1dHNCWWxuSTFHQ1I4eGxDdjhoU1FGZEd3aVlmTC9yWDZGVGxhTWc3?=
 =?utf-8?B?SHQwbGVVRENGTGVUYW54YnFRUkdSdW1EVGFBU0Fsem04c1NEVzdSWmExdDM4?=
 =?utf-8?B?OHdjVzRVZEQrdTNMVGVQcFdMZUp2QTYzd2lvbGl5ZmhXUmtBK3pBcEdBOTNh?=
 =?utf-8?B?bko4TTlQS2xSL0FkcG9XNmV2VExEL3FieXhtbkFmWndVRHdmcy9FNmg0SlhR?=
 =?utf-8?B?NlRUQ2doaTB2MmpvUDVhZXRYdS9lSm1Paml3bkdDaWdFblpQY2FkN3d4WStI?=
 =?utf-8?B?Y09Lb2h2U1YybnJWZ0loTCtnT2N2YnR5Vy8xcFlMRzRMYVFwMnhhTW1tK1M2?=
 =?utf-8?B?NEtqTml3N29jcVBPbnNLZTEvcU5Td0JFUTV6MDEyUGVXdHV6dmUxK01zd3l1?=
 =?utf-8?B?ekN3dzBYTUFUUHhEa3gzL3JBeUhsRnRGYUVZL2ttYlhQQ3VvR1JId21pTDRZ?=
 =?utf-8?B?VDA5R21MbFg1cEtLVkdBczdJcEdxMElPelJYMEEzYk5pOGdQUlh4Q0xQcXdo?=
 =?utf-8?B?d2lPL3hVdEF4bDNKUWxKRkhhUUhzODZJY1N3bVNvalBVdS9pTi9DSGI5ay8y?=
 =?utf-8?B?ZEE3SC9HVE5nYmtnY2krZ0tZS0l6UGdVMXgreEpGRW41K1V6ZFNyOTJLN0RL?=
 =?utf-8?B?NFQ2dy9VUFNUckl6NEVOMS9VVXFZczJwdVp1SVh4VHg2WEJ5NDRtZzJWYmRj?=
 =?utf-8?B?S2pVeHpDeDhhclorNksyQzZRcW1QNlRqa2Q0cjBGV2Z6alBXbHY0cWFFVjcy?=
 =?utf-8?B?UmdYTlhtWUlwVkdhZ29yNW1aLzdkNDY3UlVOb056WDlkcUM0aDFBczBiaGp1?=
 =?utf-8?B?aE1XbXVtcjYrOW5HbVZmSXVOMTZVdmJDbjVwRi9PL0dKQ2JGUm9na0FyQzdv?=
 =?utf-8?B?TVlVdlk1cWE1UmtXZnlSQ3VFeDZ3YmVmQ1dVTEZ6MytoLytzTzVTeGsxendY?=
 =?utf-8?B?cGtTM01oR2NnS3EyUTJyakxtNTZvMzV0VDcxUDc0cUIvSGlkVU80QTg3S2pT?=
 =?utf-8?B?VEN3NjVNaFZ5dml5TEVjL2tpaDZXdnBVQUVoNGlUeHFTaWJoSVZGRUdMemtL?=
 =?utf-8?B?T3VjeFZOTW93dWw5aStSWnhGOEtjVVd2OVh4ckQ1Wi8zaTVhVW1QV1VTS051?=
 =?utf-8?B?U0VKWFBKdnZjZzMrTDJCSldDYnV4U0xsKytQS2QwNWljQ1h6d21QdnJXWStN?=
 =?utf-8?B?S3paMUNlZzAzU242OXNaRnJ0Ym42bkphVTBWZWJGTndwRVI0NVc2bm93LzVI?=
 =?utf-8?B?bDNDczNSSlEvUnc4dFZlRi96eFdqdFdSaksycUY1SG1Xc1JUWlNjQW91S000?=
 =?utf-8?B?a2JDWjcxbVVnRys1YTVkcmpyNzhZZWdKK0ZTWnoyV2hnUUplRjdGT1JKdE83?=
 =?utf-8?B?RDVuWFNiSGVidWJlWnlGSUJrS3VMTDFaRGlJSDhOOUFqZTMySnJyaW1ZT204?=
 =?utf-8?B?RWw3TC9iUjBYeERtUkFUQldlTlBSUDNKYWFrMk14Y2lPOUNqS3NhVVNneUpa?=
 =?utf-8?Q?FXSMLc?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:31:00.5865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46002c7-f4fb-4e64-8979-08ddb7eb1e32
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7009



On 2025/6/30 19:14, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 30/06/2025 10:29, Hans Zhang wrote:
>>>> +
>>>> +  num-lanes:
>>>> +    maximum: 8
>>>> +
>>>> +  ranges:
>>>> +    maxItems: 3
>>>> +
>>>> +  msi-map:
>>>> +    maxItems: 1
>>>> +
>>>> +  vendor-id:
>>>> +    const: 0x1f6c
>>>
>>> Why? This is implied by compatible.
>>
>> Because when we designed the SOC RTL, it was not set to the vendor id
>> and device id of our company. We are members of PCI-SIG. So we need to
>> set the vendor id and device id in the Root Port driver. Otherwise, the
>> output of lspci will be displayed incorrectly.
> 
> Please read carefully. Previous discussions were also pointlessly
> ping-ponging on irrelevant arguments. Did I suggest you do not have to
> set it in root port driver? No. If this is const here, this is implied
> by compatible and completely redundant, because your driver knows this
> value already. It already has all the information to deduce this value
> from the compatible.
> 
> 
Dear Krzysztof,

Thank you very much for your reply.

These two attributes are also in the following document. Is this place 
out of date?
Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml


We initially used the logic of Cadence common driver as follows:
drivers/pci/controller/cadence/pcie-cadence-host.c
of_property_read_u32(np, "vendor-id", &rc->vendor_id);

of_property_read_u32(np, "device-id", &rc->device_id);

So, can the code in Cadence be deleted?


I see. It will be removed in the next version. The vendor id and device 
id are directly assigned by the Root Port driver based on compatible.

Best regards,
Hans

> 
> 
>>
>>>
>>>> +
>>>> +  device-id:
>>>> +    enum:
>>>> +      - 0x0001
>>>
>>> Why? This is implied by compatible.
>>
>> The reason is the same as above.
>>
>>>
>>>> +
>>>> +  cdns,no-inbound-bar:
>>>
>>> That's not a cdns binding, so wrong prefix.
>>
>> It will be added to Cadence's Doc. I will add a separate patch. What do
>> you think?
>>
>>>
>>>> +    description: |
>>>
>>> Do not need '|' unless you need to preserve formatting.
>>
>> Will delete '|'.
>>
>>>
>>>> +      Indicates the PCIe controller does not require an inbound BAR region.
>>>
>>> And anyway this is implied by compatible, drop.
>>>
>>
>> Because Cadence core driver has this judgment, the latest code of the
>> current linux master all has this process. As follows:
>> int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
>>       cdns_pcie_host_init_address_translation(rc);
>>        cdns_pcie_host_map_dma_ranges(rc);
>>           cdns_pcie_host_bar_ib_config
> 
> And you cannot fix or change drivers? How does it matter for discussion
> here?
> 
>>
>> So this attribute has been added here, or is there a better way?
> 
> Of course, like every other driver in Linux kernel. This is FIXED for
> your platform, so set it in your CIX driver.
> 
> 
> 
> Best regards,
> Krzysztof

