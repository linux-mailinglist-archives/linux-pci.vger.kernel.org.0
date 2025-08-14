Return-Path: <linux-pci+bounces-34013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F5FB258E9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 03:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BDCD4E1B50
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB513B284;
	Thu, 14 Aug 2025 01:23:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023121.outbound.protection.outlook.com [52.101.127.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CC8F49;
	Thu, 14 Aug 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134583; cv=fail; b=EGoebkRwiofNs/2nrbregeheb73ctoWsBwzCa1BB2fvxB+p8Gu3oOuH9yVCQTPrSc/igBbyDMu+BsEcJnwpd4myZ1g6KV9ugzfgAgppREx+5MG6yK4NIYzQzGniBX+MbJV3pFVolBdeovaIrlnEcCdVLYH4VsBnRqg11WOYFri8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134583; c=relaxed/simple;
	bh=iCbCS7tdp2roTCWYKqQsh8i75wB9zLUYDVrCqU5tePI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltWsrgMClPzwWPzViScM2jw4PUWHb1PMs0/L4Sviq3V3gtgyb85dALA2OdbITvSTVgyx3kgaVP6+pbFCzOkrwaeaoFZ4/KsSAIn93He4kNloypLOfpeWGhLX7OAVB9noxpiupQ1V08s0yMv5WjITtRMuiO0WBL0YcaoLMN20rGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/sHVe+0P+hdEVHjy5f51b6y2GmUXXwvIXhMtL0wa8F2Jzq036Wkq5CNy7wKLsNUj3sr+U922KkZb7UQofrG+thgUAAoRQDJ1ER572G2IVlCF9JSfTeB7WEKGMePfVMI568/wxTSJht9DvHKMUeLmiRdgjVd7Sb8FFlSqQ8KjN0fotImNbhjmUhHMbNuVUXqNXu+eoOER61qWsV4RxIpRX1JubQtY3bDd2T9Kqul1t97wa+pJZRBnuT0wzFRB2wc4mfcj2wbDFCIrZdNb7kvroa2tO7Ud8dn/qjpdfY+1y2DPVVcc1NsDePvPZaQ4KZhi349BcOEiLy9X+Lt3/NzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlBESoKd81/WZmHkV5cTBM0zmxJqmTnHPdCRF4EKuCM=;
 b=krQbAO0LEiIg8YW2GsNG3YNvQV1y0eGSKEzg0zycYbRkyFdg9B6xDXnbW1Am5KpLThkjkVZiq2IKu7gl1Ohc0xyVd4uAe+ilar+8ARwepHD16bXJmMzdyNfEtKIWhcW0NcvFo9WdUXhB17l0FIJinzejvHkGPYzvbSywlwlMM6jL1rw2e7t+6Iy7HSL4vR9FPZD/tButQgu5aWEeD2+qBuFW2pAxgqYYEkyZcXyB1rFXvEpxURI27HvGxitvkV4vo0NxvhJEbDBzgy4ypxjtyo98u0jb2Kxo++VOtIUI/by2wIFKXVftJtTPs7rjqsVa0CR2uFdQOjRDQP8uWmXzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY1PR01CA0184.jpnprd01.prod.outlook.com (2603:1096:403::14) by
 PS1PPF5B542C4C3.apcprd06.prod.outlook.com (2603:1096:308::251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Thu, 14 Aug 2025 01:22:52 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:403:0:cafe::35) by TY1PR01CA0184.outlook.office365.com
 (2603:1096:403::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 01:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 01:22:51 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1EB3044C3CBA;
	Thu, 14 Aug 2025 09:22:50 +0800 (CST)
Message-ID: <70300a06-c466-4d0d-a870-78ebfb684563@cixtech.com>
Date: Thu, 14 Aug 2025 09:22:50 +0800
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
Cc: mpillai@cadence.com, cix-kernel-upstream@cixtech.com,
 lpieralisi@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org,
 conor+dt@kernel.org, linux-pci@vger.kernel.org, mani@kernel.org,
 kw@linux.com, kwilczynski@kernel.org, krzk+dt@kernel.org,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 linux-kernel@vger.kernel.org
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-9-hans.zhang@cixtech.com>
 <175507391391.3310343.12670862270884103729.robh@kernel.org>
 <cb35dfbd-2fa4-4125-bd87-9f86405983eb@cixtech.com>
 <20250813154328.GA114155-robh@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250813154328.GA114155-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|PS1PPF5B542C4C3:EE_
X-MS-Office365-Filtering-Correlation-Id: 3099d4a1-2aeb-4ac5-8af3-08dddad1163e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1F6U05DaEI3ODJnSzdxWjV2NUx4T0VHMnVtZ1BuSmczMS92VStUeTduN2tN?=
 =?utf-8?B?cXd2akNPY1UyNlBrc2dFdUpqZ1dCdDF4KzUvM3BKcVJpT2xITmhEWUMwdXRa?=
 =?utf-8?B?bzF1S0VYdmxVSGJaRWxBNXEvMGwybjk4YjlwaFNSTVZhaGswS3Z0VTVQUE52?=
 =?utf-8?B?d0pPUjZRUnk0UWZJR0ROYkFpR1FGb1VYVUZYd0x3RkltUFFjeVhkbEJQUHNY?=
 =?utf-8?B?KzViNWFuekpyLzZSY0VTRVpBVTBEazF2cVNvUk9iaTd0UmJHRzBZM1FSUURN?=
 =?utf-8?B?RkcvUFYrd0U2UmFzbWZ0L0N2R3RrYkFmMTJIT1pkVVRMRVFuQ3haanlQZitX?=
 =?utf-8?B?Ylk5cnRVbnZOdDNQM0FyNytLVVFTdFdxZDc4c1IzRWR3dTZCNGhlVElRSmxN?=
 =?utf-8?B?VTJiTEVXcjJHbkp3dTRnMm1jZFh4bW9ybk1FaWhrN3NSdmEwbDhuUVNFcnMy?=
 =?utf-8?B?NGNuQldvcnZCRWxSNkoyUHJ2ZTJ2c3hISm8zNEMxcGJUQjZVVUQ1ejd1Ym5n?=
 =?utf-8?B?TnpENU1JV2Z1RkdQVjBhOFFtczJRU3RtWmZ1RVd4cGlQV0tzNFhINmV2Q2Rs?=
 =?utf-8?B?Ym5HVTBKWjhiR00zemtnOVh5T0lWN0FhZTQwNnV4TlJGUGFvTFBMT3NQZnI5?=
 =?utf-8?B?ajh6WXM2dmF4NGhtY0VxS1ZWdjR5cWdKSyttc21yYzI3clBpcWRsc1gyUnds?=
 =?utf-8?B?bHZIRGppaTU1RGFMRWZoZm1jcGZQZXAzOVlRb0xQVzlOS0pYK0ZrTDV4MVRx?=
 =?utf-8?B?SDVOR1dkTS8rbWY4ZVJ6a3c5R0ZLL3pFUmtpR0dOVzY4T0liTGtCTWJRTWV0?=
 =?utf-8?B?MHdBY1l6WHRKUVc2RWRHOWxhWlJKdEtGK2hUUFpOZk16UEVESmlqdWtGVGJP?=
 =?utf-8?B?L1p6QjV0NmlZNk5EVm92VXBHOGozRG05Nit3L2oyTHdMUGswc1Z2d2MyeUJr?=
 =?utf-8?B?Z3NncmRTUWxpTTB3NTM3dERPYk9Db25qRE90ZjFmUk42c0pnV3pJUEN0dnoz?=
 =?utf-8?B?VWlhOEhsZTZidk9yQXlkYWJUSm1nN1NzOVZRazhOa0VFekVnWTRiK3BUaWZo?=
 =?utf-8?B?Q3JsY1dWbWNRb3pHcGdtVHhabHRFUEFoSWUxOEUvZHluMWM1R1ZCUmlVUG5x?=
 =?utf-8?B?VlhBa2xjRzV3dk1NMVZIbW1SQ1p5T3N0SFpXV1hDbi81aUd4TEFFNzg1S1F3?=
 =?utf-8?B?MjlyblhHYnFNMjEwVktPaDN3dGpCTkg1SWVKSlpzdktnc2poMlkzTTN4TlNt?=
 =?utf-8?B?S3RWQndBWVNwRnFLZG5FTkxKc0RLM2hkWnhDRCt4ZjVaSHB2R2pXdGxPNkR0?=
 =?utf-8?B?TjkyNys2ck4xUS82L2FpZDdtTGRvOUdVQWV0NGNEckpsaFliQTU0eFAxZGNQ?=
 =?utf-8?B?WjJ6MWdsT2NlWWgrUjl0TE1uYUN4dzF2ckNtYktwK3BONVZsZW1nSlREK2Zm?=
 =?utf-8?B?MCt0SkJzRmx1alpkS24rN0pWOEJWUFhVRDI3M1hRQlI1NVAxcmc5WVNweHln?=
 =?utf-8?B?OU1ILzdTdmRMUnBFS1hGVVZyQVB4eHRlZlVDazMwYlA5S1ZRKzVIclQ5bUR0?=
 =?utf-8?B?WHhYSEFxT21KLytpV2ZKYjQ4aDliK2V5TVlSVW5Na0hFZHR4OE45RG53OFls?=
 =?utf-8?B?ZTZTL0hFbXlxY2ZOSTJHeHowYzkzM2QxOWVKcm1DdlNvSmRQR01tVjNIS1lJ?=
 =?utf-8?B?bUxBQ29kaGZ5VmFLVldkSmpJZDY1alpYci9mRjk4WjNBcFd0U0pobnpUK0x1?=
 =?utf-8?B?WHkvWHlSSUYyTnQzREY4K0dsL0hkenNLUThoVmo1Zko4QW5PYTRjYmhjK21m?=
 =?utf-8?B?V1BDSGZXUGdmMUc3ek4wNzNZRTgveGJaaGJjQnArN28wZjJaU1R0ampPczEy?=
 =?utf-8?B?MkNUeDlsdE9vSDNoaW55TzhyOEFXWmErQStDc3d2RGxzSE5XWjB1V0VhRlVZ?=
 =?utf-8?B?MEJkdE1CVEI0VTFUUzV6U09Yc2h3SkhmYXR1M1hyZTZOSUZqWE9rZXZCenBV?=
 =?utf-8?B?TkJSMElxWW9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 01:22:51.0658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3099d4a1-2aeb-4ac5-8af3-08dddad1163e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF5B542C4C3



On 2025/8/13 23:43, Rob Herring wrote:
> EXTERNAL EMAIL
> 
> On Wed, Aug 13, 2025 at 05:12:57PM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/8/13 16:31, Rob Herring (Arm) wrote:
>>> EXTERNAL EMAIL
>>>
>>> On Wed, 13 Aug 2025 12:23:26 +0800, hans.zhang@cixtech.com wrote:
>>>> From: Hans Zhang <hans.zhang@cixtech.com>
>>>>
>>>> Document the bindings for CIX Sky1 PCIe Controller configured in
>>>> root complex mode with five root port.
>>>>
>>>> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
>>>>
>>>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>>>> ---
>>>>    .../bindings/pci/cix,sky1-pcie-host.yaml      | 79 +++++++++++++++++++
>>>>    1 file changed, 79 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>>>
>>>
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: /: 'compatible' is a required property
>>>           from schema $id: http://devicetree.org/schemas/root-node.yaml#
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: /: 'model' is a required property
>>>           from schema $id: http://devicetree.org/schemas/root-node.yaml#
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250813042331.1258272-9-hans.zhang@cixtech.com
>>>
>>> The base for the series is generally the latest rc1. A different dependency
>>> should be noted in *this* patch.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit after running the above command yourself. Note
>>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>>> your schema. However, it must be unset to test all examples with your schema.
>>>
>>
>> Dear Rob,
>>
>> I'm very sorry. No errors were detected on my PC. I'll check my local
>> environment and fix this issue in the next version.
>>
>> If I have done anything wrong, please remind me.
>>
>>
>>
>> hans@hans:~/code/kernel_org/linux$ export CROSS_COMPILE=/home/hans/cix/bringup_master/tools/gcc/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
>> hans@hans:~/code/kernel_org/linux$ export ARCH=arm64
>> hans@hans:~/code/kernel_org/linux$ make dt_binding_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>    CHKDT   ./Documentation/devicetree/bindings
>>    LINT    ./Documentation/devicetree/bindings
>>    DTEX Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dts
>>    DTC [C]
>> Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb
>> hans@hans:~/code/kernel_org/linux$ make W=1 dt_binding_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> 
> DT_SCHEMA_FILES limits testing to only the matching pattern.
> Ultimately, you have to test without it.
> 

Dear Rob,

Thank you very much for your reply and reminder. I will check it 
carefully again.

Best regards,
Hans


