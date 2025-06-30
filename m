Return-Path: <linux-pci+bounces-31069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D7AAED74A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B657A1DE5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3471E5702;
	Mon, 30 Jun 2025 08:29:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022075.outbound.protection.outlook.com [40.107.75.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B4634EC;
	Mon, 30 Jun 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272170; cv=fail; b=jmdnNZws1Mt+56M2kbzsR9HkZFAWItA3lpd1aByPjoTx7vWhIzjMJq29kvB5QICha54gzKuyvoD04YB9cW9sE23Zp4qiC6qchEpu47hogVdocTLdTdbAxv7kxGgjaFkm9eb9ZHRblU3ehavBVLyJoZSDuqcyc6w0FCnJnt4kIWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272170; c=relaxed/simple;
	bh=oLKVBhaW+sXJbr45ws9E9tdXcwGQsKn0yVLcqdni8Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r22dxwuqmiJvN4g17VXML9iTL7dttecGNb/eCTFvk41QiH2mLtvNr625+9slJfjz7ckQSJqz9FYW3RNBVj4YhZkTI3EGBAUR5CdTwyEHp0HLBIml86O88Tnn0WEwqfAUCICfmsFsCsb+s4x/xi1x8BvZQ8leC1T7AqQxafWBBUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H412sXX7v2bQq2lppOtXyKyULGI4OY8t1CG0meIlV7P8y7arotztdcLBXyL2rKr+wKhuTEslCV6mD09Zfo+RxXq4/FJw+dxiniq/Zs0419zmov9Jr62fHFQhrCDCZn5GMvaQjFZ1KZpoHB5X14l9GVmFRvhz6ROmy9mDVdkbcB/S/glo/JrK2r/vpQVHjN2r8fxxRjF/peD2RPvIpILp+AHQfzg8FEVkR+kLFSH0yRfbTx8AQ5lKVFsRx/VO+fXdbqkDbsE5wG+o7atu4E2xqOkhyz4jL6uFS4UM8Bn0G5AL5FfZYFCvbP3asKOc0oB5SXJ//o/4nDmZki+cY56gIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bi98fsaaV09RiwOkQ4KCDxYweHwHXmnhOJpttXiPUk=;
 b=GHWcdKV+XN3A8nQu+kJeAlY+b4rZeB+a+IaH1ag+JQhw0LFRtWaDucVT4bHgXWXdgVW+fdjPXVxwTiv6YSAvixY4B/6Ch4Z1cV+FGWSPGY0yTVDLlBqs1McMLn/PwOJYZJh/ReYfQrIK/eKr7sJVBbi500QiNje9xsNhX2noAvwBFi/DyXJXQT9VxZGKgAc4m4Pm2lOcwZzdL0xQay33/HvjZD6+lVMH70DHYiptAue+3IC/dyaVSSogVmkkinAZyWEO5rPXY2PQAsgiMuBH8s7Z2ShfEEVocFSn7Re1rtGx5uzrJBCwTiMnG5b+i66xp13mBYhLn7C37nG2aU12sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0044.apcprd02.prod.outlook.com (2603:1096:4:1f6::6) by
 PUZPR06MB5520.apcprd06.prod.outlook.com (2603:1096:301:fb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.28; Mon, 30 Jun 2025 08:29:19 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:1f6:cafe::82) by SI1PR02CA0044.outlook.office365.com
 (2603:1096:4:1f6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 08:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 08:29:15 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AA1B244C3CA1;
	Mon, 30 Jun 2025 16:29:14 +0800 (CST)
Message-ID: <bb4889ca-ec99-4677-9ddc-28905b6fcc14@cixtech.com>
Date: Mon, 30 Jun 2025 16:29:14 +0800
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
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250630-graceful-horse-of-science-eecc53@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|PUZPR06MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba43878-2565-41c0-037d-08ddb7b032ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVg2MnBqL2dPWlNBZ3FNZGl6MjM1amdGODRUakdZSE4vN1pPZ3BKTlV0WWNu?=
 =?utf-8?B?V3VkMERtT0JNOHRPUXpOa3RCaUZhaFpEajd5UUNjQTBxcDlhK0taVVFIZnhL?=
 =?utf-8?B?SVprNHZxK0tGTUF5ZlE4UU9ldTJaVnQyWlJmWVNsYzEreTFxblgxT0RJUGVj?=
 =?utf-8?B?QTE5TGV6a0c2WHdhRzdxd2l0Mm1iU3VIblNmNWhaTnlkWm9qS1ZZZXhHQ2ND?=
 =?utf-8?B?cjRWK3JmRVNySFdVczg2dWNzaEI5YnBBMEluemM3ZlUrV0EyR1kxMi9naXY1?=
 =?utf-8?B?OW9wcWR2UEh5bXdhSEhGVlZTUjdneURZdGx5OGI1eGh4KzQyVVJiMXVEcFp1?=
 =?utf-8?B?cWc3NG9Ebytsb1pHMmZ5TFhZME5FMk5XemJkTEJnUWE1VnplQXdsa3VHOGlH?=
 =?utf-8?B?ZFNlT3JaejFHN0dUNHpYYkFYSlB2UDBFZXJyQ3lUNFRubkFBdzJVc3o4RlRT?=
 =?utf-8?B?cWpBeHRucTV4MXJYeVFySUVwWjhDdE9Ka0VldVR1Z1lkZndBMVIwSGh2Q3VT?=
 =?utf-8?B?NHVCQ29mVWg3T3lnYlgrWVpKVk1NZmR0L0VxbDZ2c3NaZStWNURoemR3dmFo?=
 =?utf-8?B?N1NUL2J4RXNrNVJEQXlqWkQzK21MUVkrd05SYUxvZWo1VHVrZUErS2xHMys4?=
 =?utf-8?B?NFordUpyNTFsTXhvNVRneldFOG9FajgxdUJHa3g5dzhRWFF0aFhyUXhYckFK?=
 =?utf-8?B?Y1F3WC9TelVPUTloc2N1L1JuRUZWZzhqSno5bWRWYlllNEViN1JRY0NoRDMr?=
 =?utf-8?B?UjZBU1grRnBRNmRRN3oySVBLL214OUJ2bkVYWDhkV1hwZGM2S3lMMmVOY0tB?=
 =?utf-8?B?eGV3TDBTTlg2bHlmdTVpVFJraHNnSVluRVZkZFlnREdxalRUY2txUHA4aWhC?=
 =?utf-8?B?TVdYVTdUKzJHaHNyZCtQdFJ4RUs4V3IyWEMybjE4MHFnbG9xVkVubUZOK3Jh?=
 =?utf-8?B?RTFTYTBReUx2SXhBQ3ZTLzlJVlVsaUJTZllJRTVVb1liSHU1SXVSTk9WVDly?=
 =?utf-8?B?SkZ5TkVGMDVRMExCNVBKRy92VW51NkdvN1pyQk5KTWxJU3JXdGV0blovTkQz?=
 =?utf-8?B?L0ZsNFRrQ2M3T3lkQzcvU0haMll5NzJmeEl6K1piR0tWeFlwV1c3ODNwN01J?=
 =?utf-8?B?YUlCemYyTHBBUkpPb1MvUnZNQ0MyN1hBVTRkeEZJSlhWQ0tFL2E2NFNxSEhL?=
 =?utf-8?B?M0VodlgzeHdzbDg5eXk4bnVoYjIrUE1xaXBJMXlTWVMrSjg1SXFrbWdyMXJi?=
 =?utf-8?B?YUZMSHhjODlRdHcxdGVVemRkc01mblhlUCtwVGpzbjdKKzlyL2ViRUNQWlVh?=
 =?utf-8?B?d0IwSE51VkVZVzFvb2t4NGRHbjg5WHMzeTlSclNnY3ozWURseWRPMTVzWjV3?=
 =?utf-8?B?UVFtb3BGSlBOMDVNUjVrTzJyZlNLbm1uUnB0VkN4Tlo0YjNRa1RKTUpuRU1h?=
 =?utf-8?B?NUFQSkZxbjhacWtUa0tJSHJ1ZW5zQWdyVVZpVm4rUkNUWktXNDdibTFwUkZY?=
 =?utf-8?B?ZjhNdGthNmhCbTNienllZmluQ0JzbUo0czdzVHhmT01Tamx5cThGQllOOVhG?=
 =?utf-8?B?UUIwbHRGUTZURHA1cDhDKzR5V0RhcUdMdzU0UDhNVmhTUE80WGljTDhUZGZU?=
 =?utf-8?B?eldFVDlrSkdzWU5paDFaa01ORmFtdEE4T3VTekE5WUh2dnhSUklzV3d6bkN3?=
 =?utf-8?B?cVNPcWFmVEdIeEduVUdBWTYwdTVhdUV1UE91YmRTdGIwUWlsZlplREZvUENH?=
 =?utf-8?B?K2ZtMWxhYmlmbDV1cVRvajBZam5aN01JeFl3Z0lDZXNHS3R1WkxVMnpaV0R6?=
 =?utf-8?B?R3d1Zk9zVEJDY1BMZFVxWkU1WXY1aW5GZ296SlVsdk5EUmlJQXV3WVZDdE9T?=
 =?utf-8?B?T1EwQmdPOTY1YVdmd2pkWTEvTGNsR3l4REhRWDBZNVdscnArUngrRWxYemlz?=
 =?utf-8?B?VFU5K1RzTDVQekZOSXNXOVRJUDdmcmdGQzBicGJMa3B2TE1xK01BUFdlSU5r?=
 =?utf-8?Q?yc3tthlH+xShQRci2Nf7YPYXOrAtMc=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:29:15.2442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba43878-2565-41c0-037d-08ddb7b032ff
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5520



On 2025/6/30 15:26, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Mon, Jun 30, 2025 at 12:15:57PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Document the bindings for CIX Sky1 PCIe Controller configured in
>> root complex mode with five root port.
>>
>> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
>> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
>> ---
>>   .../bindings/pci/cix,sky1-pcie-host.yaml      | 133 ++++++++++++++++++
>>   1 file changed, 133 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>> new file mode 100644
>> index 000000000000..b4395bc06f2f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>> @@ -0,0 +1,133 @@
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
>> +  - $ref: /schemas/pci/cdns-pcie.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: cix,sky1-pcie-host
>> +
>> +  reg:
>> +    items:
>> +      - description: PCIe controller registers.
>> +      - description: Remote CIX System Unit registers.
>> +      - description: ECAM registers.
>> +      - description: Region for sending messages registers.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: reg
>> +      - const: rcsu
>> +      - const: cfg
> 
> cfg is the second, look at cdns bindings.
> 

Dear Krzysztof,

Thank you very much for your reply. Will delete it.

>> +      - const: msg
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>> +
>> +  interrupt-map-mask:
>> +    items:
>> +      - const: 0
>> +      - const: 0
>> +      - const: 0
>> +      - const: 7
>> +
>> +  interrupt-map:
>> +    maxItems: 4
>> +
>> +  max-link-speed:
>> +    maximum: 4
> 
> Why are you redefining core properties?
I see. Just add it in "required". Will delete.

> 
>> +
>> +  num-lanes:
>> +    maximum: 8
>> +
>> +  ranges:
>> +    maxItems: 3
>> +
>> +  msi-map:
>> +    maxItems: 1
>> +
>> +  vendor-id:
>> +    const: 0x1f6c
> 
> Why? This is implied by compatible.

Because when we designed the SOC RTL, it was not set to the vendor id 
and device id of our company. We are members of PCI-SIG. So we need to 
set the vendor id and device id in the Root Port driver. Otherwise, the 
output of lspci will be displayed incorrectly.

> 
>> +
>> +  device-id:
>> +    enum:
>> +      - 0x0001
> 
> Why? This is implied by compatible.

The reason is the same as above.

> 
>> +
>> +  cdns,no-inbound-bar:
> 
> That's not a cdns binding, so wrong prefix.

It will be added to Cadence's Doc. I will add a separate patch. What do 
you think?

> 
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.

Will delete '|'.

> 
>> +      Indicates the PCIe controller does not require an inbound BAR region.
> 
> And anyway this is implied by compatible, drop.
> 

Because Cadence core driver has this judgment, the latest code of the 
current linux master all has this process. As follows:
int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
     cdns_pcie_host_init_address_translation(rc);
	cdns_pcie_host_map_dma_ranges(rc);
	   cdns_pcie_host_bar_ib_config

So this attribute has been added here, or is there a better way?

>> +    type: boolean
>> +
>> +  sky1,pcie-ctrl-id:
>> +    description: |
>> +      Specifies the PCIe controller instance identifier (0-4).
> 
> No, you don't get an instance ID. Drop the property and look how other
> bindings encoded it (not sure about the purpose and you did not explain
> it, so cannot advise).
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 4
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - "#interrupt-cells"
>> +  - interrupt-map-mask
>> +  - interrupt-map
>> +  - max-link-speed
>> +  - num-lanes
>> +  - bus-range
>> +  - device_type
>> +  - ranges
>> +  - msi-map
>> +  - vendor-id
>> +  - device-id
>> +  - cdns,no-inbound-bar
>> +  - sky1,pcie-ctrl-id
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    pcie_x8_rc: pcie@a010000 {
> 
> Drop unused label.

Will delete pcie_x8_rc.

Best regards,
Hans

> 
> 
> Best regards,
> Krzysztof
> 

