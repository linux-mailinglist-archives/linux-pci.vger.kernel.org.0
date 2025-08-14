Return-Path: <linux-pci+bounces-34015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50BEB25905
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 03:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C00D621D59
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6B183CC3;
	Thu, 14 Aug 2025 01:26:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022129.outbound.protection.outlook.com [40.107.75.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221F2746C;
	Thu, 14 Aug 2025 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134814; cv=fail; b=FVaJkkvLwkVtxDmMlpRolZnnnvVAgADLLGf9p4y90lwc+GGbzQaPWraRqOm8GAG3jQDXF5ciltixKk//xst1rb8VS+VoflfkuFYD33DapK/l4d32qjGpDo5pKFcYLJkaqNM82VWsKQwFF2Ce8VOb5jUd/METScZViPUpMtaEiTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134814; c=relaxed/simple;
	bh=LBjtW1pxynV5KHt983MrqYJBd0NFGaDgpGyJMiZdUEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGBeoBooPibK+B6XvbGjIIel2O/3PjREKKpPbvOlVZFPmbzI/mUAyh2MWhLwdRo0tZLHAntoniJTCdiBmAsJPR6PAPQ1Eq84aRRO/xCYSbCqSskP2xB3wbzpGmgdty7GFvkbH5rlLZauc4CdqDPFfD4ExX4J6dYgSt5RL+QDzg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukFz04n9r2FjgLPz2YYBu4jqqMfCfUTRiswm4wpBVAriyI1MwTJXuEQBzz1YHOmIHU/MVaw97GIN5Uy5x8t8OuFxB6siGvpJoG9cx9lhm/pTJgtuBXY1Cuh4mdD39R/3WkkesOK6VnxzRmlhv+juh1wQh/364r761E50Z7V6Sk2/fac0WDsnMKbe9tgklbLldHrF02+kdr7GkQQn5r/HU8mx9/zqNBW4tN4fQJWrmkzJXRgXALh+9iyyVSH04uuHB8BRjewweidD/HMis5Z1PPHZfxtYN40OySB/WmIZLhfaNHo+ajx2AMSOa0omtwKNVXags/eVpcP8gDm+wdn2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNF/NiqZPrY3fHXqolOaRItraMqvhxmtP23Ms1WYOsE=;
 b=S+vZ+pDWWRDGNQW73UDyPNf0IYAq6yGUDUMnK18whl44tw7ybVJ/V/z1M8kn36QxJ6BSeA4C6G6pB0xRpoyrppa3MehISzUDM6mpKiMH81lF5q8Fte2tRvXr/E7SthdaqcmICLEU1W0wo9y5PsvTo0zxq5ng3eYi8trnW9kJK8adDxxBUsR5hasbVqlGvfy+DgB92W9d+uma4HkJ2aSylZjQdGMzy3NW6Yp8QqK0phzKxIsg1ajGW4CqWM8HovGCaDjZ1TEqOUNea6LCD91H4MCcHiN7oAzhrE2QFlRmttJS/FVGL/69jE8qBB5R0MYWJnC4m8Wd5MDAX42el0dyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) by
 PUZPR06MB5828.apcprd06.prod.outlook.com (2603:1096:301:e8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Thu, 14 Aug 2025 01:26:49 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::f8) by SG2PR06CA0184.outlook.office365.com
 (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 01:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 01:26:47 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B6D9644C3CBA;
	Thu, 14 Aug 2025 09:26:46 +0800 (CST)
Message-ID: <b3a8e19b-b3cf-43e8-af9c-d0624f20a104@cixtech.com>
Date: Thu, 14 Aug 2025 09:26:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/13] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, "Rob Herring (Arm)"
 <robh@kernel.org>
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
 <bc185397-2588-4dec-8bca-c4ebd34919eb@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <bc185397-2588-4dec-8bca-c4ebd34919eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|PUZPR06MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 1943d3ed-bdcc-4067-dc23-08dddad1a329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJ3VE95SzIxMldLenFBbzZYbUNYTmpJQTZLTmNBRTlXOVdSR3dvVUducDlm?=
 =?utf-8?B?RlE4b21JZWtpbmNQK2QrRW9DUk5LcDVqV2NzQVpBK0ZVQWo1TlMybUxoWUZO?=
 =?utf-8?B?OHFSQzlGZGxnMWYzc3lXS2UwZ1lQZXlFT3ZFTk9yWHhTaUhXRXR6UStqM2FZ?=
 =?utf-8?B?TW9ZeWpMdk5CUXVmNGlBQit0S2xKSlA0N21SM1o3M0FINzFSeHluNDNkRXo5?=
 =?utf-8?B?Mng3aC9jL1Z3TDJGdWRySVJqeUVwTTFkU1RCajMzTnFsdmpqVVJ0RG5xamhB?=
 =?utf-8?B?VmFnalZsV1U5VnBXaW1WRUJZUHExWDNQQkdWRFpobFZXTVB6eWNYdldWN1Iz?=
 =?utf-8?B?NlA0R3BFc3ZNZ1hEcElQcG5lRU55NitXK2ZFRVFvSHZPM2NPSy9CVXpRTk1m?=
 =?utf-8?B?aFdHZWtnc0FZUnRsV1A2Yi9zbkhvSDcwam45UVlYWUk1N2JKL1d6bCtRZDZw?=
 =?utf-8?B?M3psTlJINkgxTVBhK2tFMXZDMkR1TnJ2TkQxYWtmd2QwNDc2dGZFMmNNZmZX?=
 =?utf-8?B?T25HWW5xU2plbm1YUDUxMERYTDR0YWF3WG9abXh3RnJ4M3BrMWErREhoRm54?=
 =?utf-8?B?bXpmRnY3WUFEV0FDVkdlakRPelMzSjhmOHBEZ2xML25vZWFWdnRBeVZ2YUt2?=
 =?utf-8?B?R29waWVOTnBGNlMxbzYxMGZIc0lNY3ArdXp5WFVRTlFjZmtKd2s5YmtQdlF0?=
 =?utf-8?B?c2czKzFlQXdCNGFzdVV6N1BoK0c2N1FqUTJMeFRNRFpqL3dST3JZbGNJRHpT?=
 =?utf-8?B?S2xzOVFUVjVTcVJ0RGVFRkdNUE9GOWNzQ3RKaDdjTWNhVjZqMi9iY3IzOEtm?=
 =?utf-8?B?ak5zV1F3b1k1UGhlUXovZXVKd2pDL2Vra0RaL2drRkptRE12dlFGdDZJdmN3?=
 =?utf-8?B?TDhxcEZtZ1BEUUtESk9DV2FiWEliM2hpVTFuNjZ4a3NjYm9WSlVxN2c4SUpF?=
 =?utf-8?B?U21YcFZLSlNVRkZ0SSs3M241Ly9Mb1NpbGFXT0VHeWpLMC8xdk52Ti9SeVBG?=
 =?utf-8?B?ZlZhUVczY1B0Zjl6bFhhbi9tbzVoNlNWRjR2d1VXTDQrMW8wYXU1bXY3dlJ1?=
 =?utf-8?B?TzJ3U0o0Lzh0QWpTM0FxaGZJMEZtcis2R2crQ2ZlL0JkSmVPeXFDdTZkNTds?=
 =?utf-8?B?a3RIT1RiWGdGZ3kvM2UxS01jSzlGVW91OEQ0S2Y3SkNZT1ZjcCtzbTBzOWU3?=
 =?utf-8?B?ZGVmOW1odU5YUjhXZDQyZlgxdVRpSldhU1VuaTZhUDJsRndMTVdiTlk0R2pn?=
 =?utf-8?B?Nys1bXlneVkzMUs0TkpFOWRvVU82TXZsbGp3dm9LcmZOMUc5TGJGUnlFOFlx?=
 =?utf-8?B?ZFFKZGtVMjloVFNPSThhTFU1SHJTbm1aSU4zdG9jbGVPS1p0T0dpS0ZPb1pD?=
 =?utf-8?B?Y3BUUTkwZTA2R2ZtQ1NKbWFoS3VSWWZFaDFtbkwwdjJtRExXQlZiVkpwbXZi?=
 =?utf-8?B?M3QveDZiQlJKaGg0L2JRbG4yRFBLN0VabHA2cG5qT1JOdmdUN3o1MGNBU20r?=
 =?utf-8?B?NnhHWmdGRWN1WmJINHFwWndOREhVZEhwRkpjaGRNZnFJOGt5L1llOW1CRm5O?=
 =?utf-8?B?dEM2NzJZQWZSL2lnRC8xZFZERzEwY2NZN2lwQ3MxY3lBTWI5bThXWVArNDhl?=
 =?utf-8?B?MVpENGJ6Q3ZlTXdOa0YraFU1aU9YM2xiRTB4TDU1dzNOSVMwQXMxQVY2aFFo?=
 =?utf-8?B?YVdCYXJVdUhzOUpPMGJQdHFvb2loZ25pNFNKMU9pTTBDdnRJc1BTVGROQTJo?=
 =?utf-8?B?R2pLRGFRU1RXM2VzcHNXSTRNSUxwc3RyaEdYMGQ0cnRQT3ZnZVkrTXhEOXdn?=
 =?utf-8?B?MVRGZ1BTbjE2aThEcWs0OHlPVmRQbHpkU1ZzaUgvQ05HWnBmMXRqMklMSk8w?=
 =?utf-8?B?c3ZnUllRNlhncjBsUkZCeUpaUXZFZW54MFVoUVlkY09iTy8yZ3RoUG1VUXlr?=
 =?utf-8?B?c1dtM1plN3BYbmJhTUtlNXQ3U1FiTTRoN1U4Smc5VkF4T0I3UnBROWVhZDdW?=
 =?utf-8?B?THpqWjhlcXF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 01:26:47.5164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1943d3ed-bdcc-4067-dc23-08dddad1a329
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5828



On 2025/8/14 03:08, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 13/08/2025 11:12, Hans Zhang wrote:
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
> 
> Your code is not correct. You are not supposed to have there root node.
> Please open ANY (most recent preferably) other binding and look how it
> is done there.
> 

Dear Krzysztof,

Thank you very much for your reply.

I found a recent reference example, which will be fixed in the next version.

Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml

Best regards,
Hans


