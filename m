Return-Path: <linux-pci+bounces-31070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDAAED7B3
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78ACF17588A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82851241CA3;
	Mon, 30 Jun 2025 08:44:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023093.outbound.protection.outlook.com [52.101.127.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4D2E403;
	Mon, 30 Jun 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273074; cv=fail; b=DYc5OX6ZuOqdmo0g2CWkZBNecZIUBF3K0tYkfJ9o6T+LGMCz02d8jE2C2Wy1ExACdaUdlpVn7U4L5Fq3C9WhbKBY1uuGRNyh0RgNvAzKzvmo3d/b9b1WA5gLacLjAUmY8y1lxb4cdT0xCosHjIaLwhmM4qk7O1+n5027D2KnCqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273074; c=relaxed/simple;
	bh=CyXFZSTb/kHiN4vRt/nLWnfdKIqhGJVTtp/o/1t3CJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n28TKWVw9H06cA1Pvg9BzurabiJ8P3RCplCBT9Oh7zM7WXOKHIMElb+X3r+T2N6Rqm7OgU+1ZL4v2T2oHczwHqi1rYdnRRRiTQnPeAxL7P+Xj31y9SF/FzupOpVzZLr4fV7VD3MCDNVrTu1pa/c7LaI5XwlH4J8InJ0bVI3hnM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGqVnckmjxVo1img5Gml5CYWEsn2auyIUHZXqBpvN4R/5DdRqY2D+Z2dO4OXAbeO3mLh56ynBO6q2IBh0otkq7bwMU3+DTquIHPRjbEv8fRu7D+reGwtYCc2gkhihZhCysS7iiZaCqT4KLACTi2S1qXfkRYzVuIhYgTkS23jOSOWW9GM8VkSHDf4TENva+EG+29sNCgeNQd9TqjL3xB9m6uJDtmRulgt6OtqhLwGcmBc9n7qzhxWuY6pKpqO/FFNz10cbCaify+xk/HZk8yQCIovOLvmF0HoG+SqVOUuZRNiXtyyeqX5l2RHEnBd6uOMAv9/P3AP8P3v3l5D/zlXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ExwA+moTgxRZ8eMK4E2oidRAIgxHLrf75H1IM52s4=;
 b=ghmvBR5X3/AYRiX+p+LGC9R/+Q8Umuqrmyw6D6jDh/trzKfY+EAZnhZKIDrD8TOJP3qwqlyEHTYCvtDonhevHBCkefLA1N3teSt6AVSt6qBhn5I/4frwYrgk64DWODrbXTrQu1WmbvDpp3u7JuOMMhWhz01rLvbgh5aXgbUs3axKy4ZX68Jq4OZeS7XFJMsWWVklYU6kE15tY5rpI8Pz5HyNHkpl8fWkQyLeOYofuJx47pPnWLwxC/GRn6ZcAGOMcy6UNDCECMTt42m25R2PXpWhnv2qMHKELMY6kqF8pzLieCHLJxPut9g4/oY5N2+ROqzjEZEDJOR+kqeG8RLERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0359.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:7c::13)
 by SI2PR06MB5162.apcprd06.prod.outlook.com (2603:1096:4:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Mon, 30 Jun
 2025 08:44:25 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:405:7c:cafe::74) by TYCP286CA0359.outlook.office365.com
 (2603:1096:405:7c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.26 via Frontend Transport; Mon,
 30 Jun 2025 08:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 08:44:24 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0FFB644C3CB6;
	Mon, 30 Jun 2025 16:44:23 +0800 (CST)
Message-ID: <2402cd6a-c24b-4ad7-91ee-0fe369392131@cixtech.com>
Date: Mon, 30 Jun 2025 16:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/14] arm64: dts: cix: Add PCIe Root Complex on sky1
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-14-hans.zhang@cixtech.com>
 <20250630-proficient-fearless-rottweiler-efde37@krzk-bin>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250630-proficient-fearless-rottweiler-efde37@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|SI2PR06MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 192c99e5-4e31-4a0c-aa5a-08ddb7b250d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlFqMHBXT3lRY3J0UWpFdTllTnBTQWtvY0taVWRKUVorMUxxWEZCNCtHbjN2?=
 =?utf-8?B?VjhSaG1XeUtXV1NDa1hCelE3aTF5SFMxTDlyZEJ1WGhGK0s2dUd6dzJSK3hu?=
 =?utf-8?B?R2M4L0NCK3h2cnJSai9HbklraE9yTWUzMzlPNE9KZGdLZ05rVnNCc0hBV1Jp?=
 =?utf-8?B?QXh6alJkSGYwZEFrSVNBRE1xVWRFNlRmTWlHRi9nZnhQaFZLYzc1OHhFejc0?=
 =?utf-8?B?dTFqZUhUSUxrYW5ZVUxHLzNqTklqK09CcFAyQXpEN2xGTElPVC9lbUU1Z2Zs?=
 =?utf-8?B?RllrY2hIU3Y3azQ0V2haUndxSkR0bUdHTTB6anRGNEw4dXJycTg1QVVVSjRX?=
 =?utf-8?B?QTR1UmJUMFh5bVRxT2xFbnZtY3Q3MnozZFVVYmZsNE9kU01EdTl2NlBPNXlR?=
 =?utf-8?B?cWFOa3JQQjZLTWc3OHhFaSt2RHJHY05veGtqUW5LdGhOVW5NNEh6aG5Wc1kr?=
 =?utf-8?B?VzVjcUZPdzgxZWdFUzI5cTBJRGNxTkhJRnR2R3FzN2tSRVY0TnIrb1BXYkJJ?=
 =?utf-8?B?VjVxZ1lYQThMRnVMN3R4YWhtdW1oRkhVS1B3aVBGaURaZDdjaG5XMzBnTE8z?=
 =?utf-8?B?SlVjcnJMcXg4NWlpV0R5ZUVyKzkwV1FxbFdGdGZoUXUySG5Rakpkek9jYWFl?=
 =?utf-8?B?N0F2RDUyT1N0VC9mN01BeHZxUVF0VkxmeDRvNDFSRWczNERWaFIwdnIyNmVy?=
 =?utf-8?B?U3Nlc3o1N3dqQU1ZcnVmOTJUczMrZkllenNkUGo0NlErOGxDRWpZUytMZ2U5?=
 =?utf-8?B?dy9aNnh6V1hVZjlvTFZPbFB5RmtXa0lHek1MK1dNMTZQL2RGb2dEcHFpVkx2?=
 =?utf-8?B?ckRhVUdKYVA1TmZ2citNL1VuRmFJZ1pBZ052eXFyNExYNUQycVQrZzVMbUIz?=
 =?utf-8?B?R3VtYW9MOXh4MExXR1NEMFhHeGoyZG1MT01OdTVHZEs4cUthZFpKZkxVclBK?=
 =?utf-8?B?VmxZWkxEMEU5V2dHWHZrcGJwRVJScnBXdC9KelF1VHFhRVFMRW1mbFhLamtV?=
 =?utf-8?B?VDVvc21zazlXWFJoVVFUWC9QcnFPYXhmS3ZkbWZaM1c1dWdMVHdjbnN1VUZl?=
 =?utf-8?B?bFFTRTlZSVBlTmFaVUE3OEduWjRGeEI0YjJHbUI4WTZuZ1BIa095YXErR1Nz?=
 =?utf-8?B?K2M0bXBsY0hHNFpkdk9RSFhoMVZkMjRvb2FyMjZJd2lmeGRHVnBYYis5eWw3?=
 =?utf-8?B?YWF1bHZ2WHprMFN0NTR2Z2JxdmNJQmtGSUc1djB4UGg5VW1Db2JLZ0RWYW5l?=
 =?utf-8?B?NEt0TWltQUxvSElyaXh4TEsxcGM4K3cwQzVBSkgxZ2V5YTFBZWQzTnU1QmpO?=
 =?utf-8?B?VTdEOXR2QWxBNURCU015ZU9kMFhFV25SMURKazdyTW9WcGFCOFAxcHlNaVUy?=
 =?utf-8?B?dithVzJuOUhRRmFqNHJTRTVIQks4S0VyQjlwdGNaYngrejArQ1U1WG9BeXNN?=
 =?utf-8?B?TFRWTzJkeUh0MG1GeHIxNGYrRW9mMlBuTGlONWtxNmxlUGlvWW1RRXAyVmNy?=
 =?utf-8?B?M01QbzRqQkUwZllwSktpM2Vubm1VbDhIUXNBaXNmeXpvSWhTSnpwSEtob21h?=
 =?utf-8?B?RG5OYzg4OXExcGtvMUhkMkpPazFlMTFab2RQcGZRZm9ZVWlnbnUzQlFqRVdV?=
 =?utf-8?B?MzZjcENTT3VERWhQRElTTVdxTkJvK1hMekFaL3h1UVBuUWdvc2Yvb3FOQm5G?=
 =?utf-8?B?NVhRRURFcVEwclFtZjB0bUJZeGJPRlBGYkdZbWMway9CQlNrTGF3dkRMTmtR?=
 =?utf-8?B?R0JnZERFeUoxNE95QjNJMWpXSE5LUkx2eFdmSVE2WXBiLzZGQ0t3dTNrQjZq?=
 =?utf-8?B?ZzlybmxTclhyMXVjWWdGNDU2MGtKbHN1b1ZDNktSTUFHc3NxcWNRc3RQSDkx?=
 =?utf-8?B?M0hUTThEQUdpTlhvRUMrSCtNRlRqWGZ3WFcxamo1Y0E0SVNBK3pqTmpBTEs3?=
 =?utf-8?B?NmdZUThBT3hEUlVDWDJVdm0wUHR4SHYwVG5tSVR5SnhYc0dYNlgvQkdoZXZ6?=
 =?utf-8?B?cjhWL0tyWUpVaWl3dHdCbGp6WFRQNGVYeG1KVGlFSGlESDVNVW56alduT2l0?=
 =?utf-8?B?Y3JTQTU4NTFoOHdyRzREN2JtOGNPUlBwTWpidz09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:44:24.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 192c99e5-4e31-4a0c-aa5a-08ddb7b250d5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5162



On 2025/6/30 15:33, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Mon, Jun 30, 2025 at 12:16:00PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add pcie_x*_rc node to support Sky1 PCIe driver based on the
>> Cadence PCIe core.
>>
>> Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
>> using the ARM GICv3.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
>> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
> 
> Where?
Dear Krzysztof,

Thank you very much for your reply. Will delete.

> 
>> ---
>>   arch/arm64/boot/dts/cix/sky1.dtsi | 150 ++++++++++++++++++++++++++++++
>>   1 file changed, 150 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
>> index 9c723917d8ca..1dac0e8d5fc1 100644
>> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
>> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
>> @@ -289,6 +289,156 @@ mbox_ap2sfh: mailbox@80a0000 {
>>                        cix,mbox-dir = "tx";
>>                };
>>
>> +             pcie_x8_rc: pcie@a010000 { /* X8 */
>> +                     compatible = "cix,sky1-pcie-host";
>> +                     reg = <0x00 0x0a010000 0x00 0x10000>,
>> +                           <0x00 0x0a000000 0x00 0x10000>,
>> +                           <0x00 0x2c000000 0x00 0x4000000>,
>> +                           <0x00 0x60000000 0x00 0x00100000>;
>> +                     reg-names = "reg", "rcsu", "cfg", "msg";
>> +                     #interrupt-cells = <1>;
>> +                     interrupt-map-mask = <0 0 0 0x7>;
>> +                     interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                     <0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                     <0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                     <0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
>> +                     max-link-speed = <4>;
>> +                     num-lanes = <8>;
>> +                     #address-cells = <3>;
>> +                     #size-cells = <2>;
>> +                     bus-range = <0xc0 0xff>;
>> +                     device_type = "pci";
>> +                     ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
>> +                              <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
>> +                              <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
> 
> And none of the two reviewers asked you to follow DTS coding style? If
> reviewer knows not much about DTS, don't review. Add an ack or
> something, dunno, or actually perform proper review.
> 

Understood.

For the arrangement of attributes this time, I referred to the following 
submission:

linux master branch：
arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
pcie2x1l2: pcie@fe190000

Submissions under review:
https://patchwork.kernel.org/project/linux-pci/patch/20250610090714.3321129-8-christian.bruel@foss.st.com/


Then should I follow the following documents exactly?

Documentation/devicetree/bindings/dts-coding-style.rst
The following order of properties in device nodes is preferred:

1. "compatible"
2. "reg"
3. "ranges"
4. Standard/common properties (defined by common bindings, e.g. without
    vendor-prefixes)
5. Vendor-specific properties
6. "status" (if applicable)
7. Child nodes, where each node is preceded with a blank line



Best regards,
Hans

> Best regards,
> Krzysztof
> 

