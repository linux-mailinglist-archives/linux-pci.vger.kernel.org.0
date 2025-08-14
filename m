Return-Path: <linux-pci+bounces-34014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52936B258EB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 03:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3585885FE4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827B2746C;
	Thu, 14 Aug 2025 01:23:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022108.outbound.protection.outlook.com [40.107.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D81E4A4;
	Thu, 14 Aug 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134634; cv=fail; b=BsgJqlUMQkJW346P/E2ftTk5EGVniekhH7byYU/AOJ4/Fx3b6FfevkJB5xWjWlzV/4lgwwFLSz2oE08P8/winOF8OnsDjicBFmHM3BMj6sIeDY1bZzL/JjFG9yPrZ3Df/ebpFhxKHPp86yOyWNczpZc92EP7pRim7WzeyDUoAA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134634; c=relaxed/simple;
	bh=oZ5q93fw7qJdoo7wpskKM1HX0VOP7RX9IzHRhPQPvWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUSeXyOkqpL4PAlEqle/TMjcueXQYGpMz+quoDfFc7iUTBNsWMR9c5f6/VmRfLMVuhJJKu5Ov8fz4+pw1a2lqzsBkM//2mjECxfPDM3KZwLSE4TYVGJ+v9ci8W0A71oHGhf4glZYpWMv3lPN/fQb0Z8jeoSHvcrdhAXEtcUpJ+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t98+NVawRbtlFr64Ky7Dv0W8ODxKlMAqCXWnm1yQVO++PRATHEw2WTTMtGqczrX68l1nxFRsJ5Q55WdHC3FrT6AVYAb7c5W3kuySZDAzJL7LJbsyGPc0SXDqNyIta7kg1eqJ3z1aI80IzcjyB2mOgFU2ZqAn2qVD2wYMml+2+Eimicc5lQYHWUfKlvVkjxQflPw8fVgjqCpr59y2Gu9cfhZcN+69vG9KaUoJgjmvWGrWi2dd0Nylfcx7QBCJNmZeUWb71AabhW/K/0r5qujzuNKNcnrCiDRYH09MMP8u+BzDZJBytmIv3hjdMyE4Yh4I1zveD3xTnG12k0wafuSiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJE4JbAg5QHrvTLWpnX4ABfrE9K9EfwG5bxETDQFwqs=;
 b=ZflrzScKsn+ucvCTYWu7Urhh9Zr7/THcUfz5afiS+ncfhV5d7M/nQFhWxgLX72qDCVWO8mnP/KmeYch/g3UA2Vu8IVb5xZrJiCgG0JpCL3PKIvGclmMh+jxnprzW9zTvPozRIe2vEed8kgvoj/PuDajWZDecpqKWos+OCIDP6CU8LRT1zHlqBie4afXZ0kTQbQdnpCJFVLEuKpVBg9j6kUnMI+fgu+/GTg47vFWjLmUv/n5MTQ25hVPaLNXIBHX+eCLmRcoklU1H1OzYusRkeUyMceIFAZJTtm/0UErsc4CUmUPoFYgJczh+W0l7k2jEI6zggFvGKFE8EKX/BDOumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0082.apcprd02.prod.outlook.com (2603:1096:300:5c::22)
 by JH0PR06MB7056.apcprd06.prod.outlook.com (2603:1096:990:6c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 01:23:48 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::60) by PS2PR02CA0082.outlook.office365.com
 (2603:1096:300:5c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 01:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 01:23:46 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9CC0444C3CBA;
	Thu, 14 Aug 2025 09:23:45 +0800 (CST)
Message-ID: <cbe7219d-c5c7-445c-9894-6a48618be91b@cixtech.com>
Date: Thu, 14 Aug 2025 09:23:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/13] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
 guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-9-hans.zhang@cixtech.com>
 <20250813154410.GB114155-robh@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250813154410.GB114155-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|JH0PR06MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7e0610-f261-4fe7-dd97-08dddad13757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWFkUUplV2ZrNnhXdGFEclBjRkE5MG93Vi93WEJPb1RsQmluQkdvWFZmYjZ3?=
 =?utf-8?B?TUVCM1FOK0VrcWcrVnR5WG9COGRvMkZCSzV1OUVFanVGdXdFS3lDdFVTdE81?=
 =?utf-8?B?c2JFa3gvam0yTlVIZkRiaVF6NWhreFJ4eXN2bXBQR0U5dU1pcUJDaDF6SGs1?=
 =?utf-8?B?dUcwZUFRU1o3aStCM2Zyc2xML2hDRnRUTmpOMVBtNUIvQnh1VkU3ZllXa0hj?=
 =?utf-8?B?TkNoVjZVeDFIYzN6aGZGaDB5ZVJmeGorOG9ZNjdZcitsdEsxMHA0MDQ2WXM3?=
 =?utf-8?B?SXpiU0c3UjkzakxDaEpkcjRFMndjS21lNExPdmhSWVhjS1hkeGtaay9kRlNz?=
 =?utf-8?B?V2NLZE1rRFBpcm12R3ZYcHY4cTZ3RnJucDNOS1VoRWhZa2xGVXo4RVpPbXlz?=
 =?utf-8?B?Sjk1dWhmMkF2ZWRGbkYzN04vczJLc2l4KzhpMVNMSjNUMkhuTzZMVXJsUWI4?=
 =?utf-8?B?VE0xVmtvaENQS3hHSnArSmMrRVFBdFQ3cjBrQzBuamlKTWlSb2dpd1VTSkVH?=
 =?utf-8?B?V1NBc0F5SkRmMHc3V3NCWWRTTnB3N2hnZHlYaC8rRUc0cnpZenA2UUdxYmhk?=
 =?utf-8?B?ZnhZTGNkK2lFYjR3NHFnRk5xZGNzdDdQcWMwVTNwK1VQZFM4RzY2dVhaK3M3?=
 =?utf-8?B?N25MZlhpTFZFOTNiOWF5SlBpZnhuYTRpYkZTbnVTN2NENWJLUGk5SnU4c2pp?=
 =?utf-8?B?R085eUpGRGxWbnlidElJelJidmlXTDBDS0JMUkFJbU1McncyNnJMbGgweThz?=
 =?utf-8?B?MkpHTW8zRGd0c1Vyd2pjejJoYmYyYzZoTjFuNGlPQWhMTzhvaHlYcGs1T3FG?=
 =?utf-8?B?U2pSblQzUWZCQnNFUEpXN0xTWXlkcUp3K3FQS21yM01oWnZFMmVKYjFYbVk5?=
 =?utf-8?B?bkFuTVBlL2FXR0xDUHdNV0EwS2p0WGZGODRXNHlra0V2dFdSTW4xRkp2WXhM?=
 =?utf-8?B?aXdGS2dpRHFlcm5NTlhCTU1uOGdkR1RnWDJHdmlxNWt6SDgya3JBZk5hMkkz?=
 =?utf-8?B?M1JVZlh1aFM5bmFTZmFDaGt5VGNqTUNUanh5Q2phK0pZaytYZlovcGZxQ2x0?=
 =?utf-8?B?SVV1enRZdFpONmxKTHovcVdxT21rSCtKdW9PRndOZkx3UzZhMlBZRlhNWDF0?=
 =?utf-8?B?Q0lrTGtwMzlLcHdka0JMQjRJYXZSVkdDSXdaQW9Mck9oRXljSzJJcVhtbmlV?=
 =?utf-8?B?M1BiNmNiZXVqS3pIN3pmd3k2cWJyVWhFMmVhS0lVSGFRL3puU2k0SENidlQy?=
 =?utf-8?B?WGcrdG1ickRUMWU4U1hWcncrd1VCdVQ2Zm5tSzRPeFRsY2ZMOUlNYnRaUWto?=
 =?utf-8?B?VkVBU2hUTm9PNHg2SnJ4ZjRtSDVFYXd3d0N3cFVrc2lSTkRrNC9tUlFob0Mv?=
 =?utf-8?B?bC9Sc0ZTK0dGSEZYRnUwTXFJNHBzdHR6cU5HaDRCYVh0MFY1SkVCR1FtT01p?=
 =?utf-8?B?Zm9YVGFkMXFHQms3TTl6dWxiYjB5SzBRVUVTeWRiK3lJOFErbVh3ZEoyTjVp?=
 =?utf-8?B?ZHhtQUtxWk5VTFpmbnhDR3VxemRERHlZbGtUWU44OWJrRTQ0cjFYYU40NzV2?=
 =?utf-8?B?T0oyZzdMN0FDanI3MnNURkhxZkM1aDlERVVxVVFYWFlBT0FqcytJSzNEbitl?=
 =?utf-8?B?cnlCL3c0SFN5UVJvR1RMcFJ2VmkyZGdRdFBlMU5xU3VPZ08yM2w5Tm94SFor?=
 =?utf-8?B?andCZmVGLzViS1BtNXFMSDRRKzN2Mzhwd084NjUzUlBFYkVhanhmWkovdmJw?=
 =?utf-8?B?S0x5S0ZDSEN5VTU5WkVpTDlOVmRwRkY4WmtrSUxTYnhudUZ3R1k2QWFYdGMv?=
 =?utf-8?B?bURXMG9STFRubE9saDJBbTJQSFd5bVQvWTRDZTR1UE1FdmR3REp3YnR0QjJZ?=
 =?utf-8?B?N2MxdFZRRmxHam5hOVlvV0V1K3A0aDd3WFdHQTB4cVNxMjVIUlMxS1Mzdk05?=
 =?utf-8?B?T3BWV0ZUTkFkaUxQTktZbWRRNUhxOVg2MC9QY0M2RlAyU3loNm9GOHB5WTJR?=
 =?utf-8?B?akdya1B3ODV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 01:23:46.5897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7e0610-f261-4fe7-dd97-08dddad13757
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7056



On 2025/8/13 23:44, Rob Herring wrote:
> EXTERNAL EMAIL
> 
> On Wed, Aug 13, 2025 at 12:23:26PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Document the bindings for CIX Sky1 PCIe Controller configured in
>> root complex mode with five root port.
>>
>> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>   .../bindings/pci/cix,sky1-pcie-host.yaml      | 79 +++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>> new file mode 100644
>> index 000000000000..2bd66603ac24
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>> @@ -0,0 +1,79 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: CIX Sky1 PCIe Root Complex
>> +
>> +maintainers:
>> +  - Hans Zhang <hans.zhang@cixtech.com>
>> +
>> +description:
>> +  PCIe root complex controller based on the Cadence PCIe core.
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: cix,sky1-pcie-host
>> +
>> +  reg:
>> +    items:
>> +      - description: PCIe controller registers.
>> +      - description: ECAM registers.
>> +      - description: Remote CIX System Unit registers.
>> +      - description: Region for sending messages registers.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: reg
>> +      - const: cfg
>> +      - const: rcsu
>> +      - const: msg
>> +
>> +  ranges:
>> +    maxItems: 3
>> +
>> +required:
>> +  - compatible
>> +  - ranges
>> +  - bus-range
>> +  - device_type
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +  - msi-map
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    / {
> 
> bus {

Dear Rob,

Thank you very much for your reply. I'll refer to other recent submissions.

Best regards,
Hans

> 
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      pcie@a010000 {
>> +          compatible = "cix,sky1-pcie-host";
>> +          reg = <0x00 0x0a010000 0x00 0x10000>,
>> +                <0x00 0x2c000000 0x00 0x4000000>,
>> +                <0x00 0x0a000000 0x00 0x10000>,
>> +                <0x00 0x60000000 0x00 0x00100000>;
>> +          reg-names = "reg", "cfg", "rcsu", "msg";
>> +          ranges = <0x01000000 0x00 0x60100000 0x00 0x60100000 0x00 0x00100000>,
>> +                  <0x02000000 0x00 0x60200000 0x00 0x60200000 0x00 0x1fe00000>,
>> +                  <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
>> +          #address-cells = <3>;
>> +          #size-cells = <2>;
>> +          bus-range = <0xc0 0xff>;
>> +          device_type = "pci";
>> +          #interrupt-cells = <1>;
>> +          interrupt-map-mask = <0 0 0 0x7>;
>> +          interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                          <0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                          <0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                          <0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
>> +          msi-map = <0xc000 &gic_its 0xc000 0x4000>;
>> +      };
>> +    };
>> --
>> 2.49.0
>>

