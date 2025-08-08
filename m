Return-Path: <linux-pci+bounces-33638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15633B1EB6B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 17:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E116F1882810
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3B283144;
	Fri,  8 Aug 2025 15:17:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023072.outbound.protection.outlook.com [52.101.127.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DEA23741;
	Fri,  8 Aug 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666270; cv=fail; b=IuqWSbAwHae+IRVp1zvvIBcQnmY1UL14ddvEA/FUV2fqXXfs8rYsYBp+dYDZ4SbMsVeH9UpH3F6dSykpSkhr7t9nMuyzjydz89ioFzmEzERsAvqRXhNw8E1gnJZO6diak3hTR+44dcNxdQsK1N+RznEfufcZzG9aC7gjAMV5D/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666270; c=relaxed/simple;
	bh=3V5a2n8uXnbEpisPB/uI7+rsDpwoRZ5rAiPGp+WTclE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9MwG9PEUIlRrgpf56PwfxRCcr/xqiKzKvKBa3et40K91uwMP+rsAtrVePoB1v7FyC9KmGc0Fq1EsiiEZjKCxV8a3cNCRGGFuYHiV8PNr92ok8UZwPaVtgdpn9HuVbBBmn8afjXtmQbBzpCAGhRm7fpMSuoHQVgo8YA9/PtFmD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6hYSv+Xqy8ziRAWvRkr8/h/pMs5kFieM5Wft+p6yAgCnTKVtJXS66Pd1vxI68rzCBbe5jQOb9zaZWhYJemANv1wuHPSS6GaPYoVTQlROvZqAjdHV1OJEaRRZuFKvoc2eHAQ2phK5ORXkIzolnCoLfgPx1e6qQLBiMfp1U+W9fALKCGa6LyzWE4dmOzahQ9GrTuBZNvxgY3yAxnGW7XEDPhSQ+yIih2chteMtEEKkOZys+cb2t6w3h0GjuYpo1cotC4iEzObAWb0vdydWhSdbnnLXc8jVqmIc9XSSRGt8PgXtZXTNkIsOfP8TV93hwHwJjQHqv6ruarCHdrPrSTkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAbSI6+6aomTRZ2qu5ibQKfPHNwjG5s9XEIsrYbF2eM=;
 b=iCZN/CDn1GPdHvvLAG0lRzwo7NI6/fqLbZ+Xql95kjfg6cA1rshzaxH0B4RTAWjFAcsnWA1DBs8dnoYtlYdl6hOoTlQLbYDLA5Y+nfN67kob0KaJU2YCFA6UptU9o2yQrB5itOHwsvFOQwz3hooAIbKAnlBEIyItxCr68aB1is5JPlCdpjxz5Nku/glDW++zE0kKw33FqZtZb8AWG+BnliHX4Tw8F1pFuCSA6uxFNPouLwlgT4+Dq3z2Hz4/4T08RaoEP+c+NUp/tV55pbPuIegN7Ef+/7gSdXnrWb3NGrNvSDz93vjzKdMB4UAvxr00kVFNUd3xnMLXGcnWKmY9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0082.apcprd02.prod.outlook.com (2603:1096:4:90::22) by
 TYUPR06MB6052.apcprd06.prod.outlook.com (2603:1096:400:354::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.15; Fri, 8 Aug 2025 15:17:40 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:90:cafe::96) by SG2PR02CA0082.outlook.office365.com
 (2603:1096:4:90::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 15:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 15:17:38 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 145DA40A12CE;
	Fri,  8 Aug 2025 23:17:33 +0800 (CST)
Message-ID: <296c1f17-999e-4117-9f09-5f2e844c4bdd@cixtech.com>
Date: Fri, 8 Aug 2025 23:17:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/12] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, guoyin.chen@cixtech.com,
 krzk+dt@kernel.org, cix-kernel-upstream@cixtech.com, conor+dt@kernel.org,
 mani@kernel.org, linux-pci@vger.kernel.org, peter.chen@cixtech.com,
 devicetree@vger.kernel.org, mpillai@cadence.com,
 linux-kernel@vger.kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 fugang.duan@cixtech.com
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
 <20250808072929.4090694-8-hans.zhang@cixtech.com>
 <175465973854.5889.2255011303498628193.robh@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <175465973854.5889.2255011303498628193.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TYUPR06MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4dbec2-d73b-442f-a6ee-08ddd68eb665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVhJd0dmMURRVThPRGdUcnZZWUp1dHd6TEJ5Q015U01NQXJXQS9YbXZDUzA0?=
 =?utf-8?B?czFsTElNSU11Wks5Ri9HenhnazFVdjBtQ2ZUR05SdTJKVElCK0VTRUVSL2Nl?=
 =?utf-8?B?dDRRK0VzV01QZkQ3NjYvRnkrd0g2aWRJbTgxSUxsSEptcjE2Qjloczd0Q29K?=
 =?utf-8?B?Zkxram9kYkoxcHdUSmNNQTUzTkZ3ZjVPMlRCNjdGSEM4RzBqTzlDcTM2UGUx?=
 =?utf-8?B?MU5ueXg0alRxZy8yb2ZUVk5TVVJXeEVqdzdNU3FCcjlST0dHRHBIbkdBZFIz?=
 =?utf-8?B?YnRDKzA5T2xGMXBVV2lJWURrZmZNNTd0ZHNkek96bjNKM0JqR3hrdGFXT2dv?=
 =?utf-8?B?K2w0WDFtTlRWeTd1K1lTM28yc0F0SjJybE1lQlUyc3J6R3AxdzliRVlNWEpz?=
 =?utf-8?B?OTNWd1Q2a3pMV2YzSmpjbEFZVGN1ZXZWNnlKcHlZbWVKTE1lcmJMZzVmMzdJ?=
 =?utf-8?B?bU1IWHVlRlBJSExKVGlpQjRPVC9sZ2NlakpPWWk3U1BBa20vZjFmSkxDY0lZ?=
 =?utf-8?B?YmtXUEFqNzd1aWp2RDhVV25WM2t1MHM4Qi9RZ1U1Ri83Njh1bzdWdTdVNEQy?=
 =?utf-8?B?Y2tRdHB6NGVNOFJQSXhScWFFUml5b2x2c3AzY2QvelZhY3BQdWRoMHF5NTZm?=
 =?utf-8?B?OUFDVnFGaERjMGtGRk9OaFVkZWpjQkNENnAvNTRBbmpJWnJDZFFDNDd3TG1r?=
 =?utf-8?B?Z0QzS2Z6K3hqckpoWEFWNDBHZDRucXowRmZuRTg1MmR3QjE1Vnh4K2c0SXdn?=
 =?utf-8?B?azIvY3NnbWRjRTZLUlNRcVJGaVVZTGwxWWlPcS9mRWhHdjVKQnVrYWRTSm9r?=
 =?utf-8?B?dUN2QTc2d3VxYUNyOGh6M3pvQXhMZUhBb3dnTkQ2djJEVVdXSjBkSDdQdEVn?=
 =?utf-8?B?bUJkZWE0QU04VDNPY3QvdGdlSGZTM0ZlS1MrTVp2cm5HTlJXL245Y0ErK2tB?=
 =?utf-8?B?aEFLSXFzelE2dlEyMkxteVVNZEVWckZVQkhlZ1JSejErTklrSHNTVFF3c0dF?=
 =?utf-8?B?VkRjcW5sdHB3OVhnalhJWHNCdGUxVVVmakJNeUJ2bjl3eHUzYUJ6RHAxbDVj?=
 =?utf-8?B?TlBDcVN3TWVONWFvUDczNHpmSWdVbVB2Z09PTGpaOVlxZ29ZRGJPVTZXVjM5?=
 =?utf-8?B?Z3BHU1VKbGhwU2lYRUJNdnE0clY5MHhzYytFcGR2MmZhL1NYcmhuWFJ3U2tD?=
 =?utf-8?B?cGJVbi9vRnBOdk9jZit1VnF3a3ROczl4c2NEWWJUeEU2c08vMFc0Y2JKZHJs?=
 =?utf-8?B?RllvZjVpUXh1ZkVselozaGRxV3JaYVh5Unk0S1oxQU1qTHR6bVJINXh1Q3dC?=
 =?utf-8?B?MHRNWmZaeGdVcDVRMkhZWFZ5VFlTRzY4THpuRHg2MlZaaWZlMkQ0N2VwM2lP?=
 =?utf-8?B?c2h6ZWRoZDVPVzJQaEZkQUs2ZkphcHdCamQraWRIaEdYdU5SNDZOZ1l3aVpO?=
 =?utf-8?B?MDgwblZSdWhPcUtHdk9TL1dPQjdJZnovcEFoS1NKRlpFWElId2hRbnB6aGFR?=
 =?utf-8?B?bGdaUFdDSUhyN0pMcG9YbHlodk1GcTZnOGdkb25GQmRZZDFrTUlUZTZHUVhW?=
 =?utf-8?B?NUYzY1J5Qis1RjdlNmdGcUNMeEJvZThQS2RtMWJlcGFETElhY2FiMGk4akg1?=
 =?utf-8?B?U2xMN3A3cTNjbzZBaUNSMjdvc3E4bi83THdpZGlIaDFqNEE0SUw3dk1iYzVy?=
 =?utf-8?B?KysrN0ZHd25VRzBnaWF1VFJxaVFoeDVTTnU3eGRBZitTazdMaWJvMndUOENu?=
 =?utf-8?B?Z2pBbXZtL3c5SjVKdE9Rc2dXdVh0WjZZSFVBSUZ5azdFNTE1UzYyQjg4Zmtz?=
 =?utf-8?B?anVLWkRUMkU2c1BYYzBXd0JORk1hM2FBUUlJYWJ0N2FhekVYZEhEY0NJTTNt?=
 =?utf-8?B?SlJoRVFyRUxaa3FkZ0FMZFVyUms2Zmp4NnFEZGFiL3p3ak1SU0RsWUtSejdG?=
 =?utf-8?B?cmY4bStqeVNqMitLN2UzSVNEZE5KcHkrbHRpN1JYdnBzc0VuN0V2UUMvRTll?=
 =?utf-8?B?bEhtd0c1ZG1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:17:38.8515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4dbec2-d73b-442f-a6ee-08ddd68eb665
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6052



On 2025/8/8 21:28, Rob Herring (Arm) wrote:
> EXTERNAL EMAIL
> 
> On Fri, 08 Aug 2025 15:29:24 +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Document the bindings for CIX Sky1 PCIe Controller configured in
>> root complex mode with five root port.
>>
>> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>   .../bindings/pci/cix,sky1-pcie-host.yaml      | 73 +++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml: properties:compatible:oneOf: [{'const': 'cix,sky1-pcie-host'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
>          hint: Use 'enum' rather than 'oneOf' + 'const' entries
>          from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dts:27.13-29.83: Warning (ranges_format): /example-0/pcie@a010000:ranges: "ranges" property has invalid length (84 bytes) (parent #address-cells == 1, child #address-cells == 3, #size-cells == 2)
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: pcie@a010000 (cix,sky1-pcie-host): ranges: 'oneOf' conditional failed, one must be fixed:
>          [[16777216, 0, 1611661312, 0, 1611661312, 0], [1048576, 33554432, 0, 1612709888, 0, 1612709888], [0, 534773760, 1124073472, 24, 0, 24], [0, 4, 0]] is not of type 'boolean'
>          1048576 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
>          0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
>          [0, 4, 0] is too short
>          from schema $id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: pcie@a010000 (cix,sky1-pcie-host): reg: [[0, 167837696], [0, 65536], [0, 738197504], [0, 67108864], [0, 167772160], [0, 65536], [0, 1610612736], [0, 1048576]] is too long
>          from schema $id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: pcie@a010000 (cix,sky1-pcie-host): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'msi-map', 'ranges', 'reg' were unexpected)
>          from schema $id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: pcie@a010000 (cix,sky1-pcie-host): ranges: 'oneOf' conditional failed, one must be fixed:
>          [[16777216, 0, 1611661312, 0, 1611661312, 0], [1048576, 33554432, 0, 1612709888, 0, 1612709888], [0, 534773760, 1124073472, 24, 0, 24], [0, 4, 0]] is not of type 'boolean'
>          1048576 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
>          0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
>          [0, 4, 0] is too short
>          from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250808072929.4090694-8-hans.zhang@cixtech.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


Dear Rob,


Thank you very much for your reply and reminder.

I executed the following two inspection commands. I overlooked checking 
the yaml file, and I'm very sorry for that.
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=arm/cix.yaml
make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb

After the release of v6.17 RC1, I will resubmit the patch.

Best regards,
Hans

