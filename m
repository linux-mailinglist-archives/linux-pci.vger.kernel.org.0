Return-Path: <linux-pci+bounces-33938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C9FB2450D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 11:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577DF17CF84
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16D2ED169;
	Wed, 13 Aug 2025 09:13:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022129.outbound.protection.outlook.com [52.101.126.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981652BE03C;
	Wed, 13 Aug 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076391; cv=fail; b=OhaMZyZHznp/pZrWz4qJBIeCEmI+62HiOUboGUaQpSukD4mG0GHmJQxEg6fwHe0/X63Vavy0ktsN8pKyQAOM0mufbDbrnaPzvC4sayCAVGeCmSSWLEQEcqpoihEdMyms2x1R6ErL2v2u4nSeuTLIfqoD5yV6dfvDVme9Lv5fR1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076391; c=relaxed/simple;
	bh=jAYqbaAwyPHM4O0KOAvUHni9Euk6H2Fe+zo1l36kAp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8Vo1PgBdcxYNeZFLGgM3tjRauDjBqkipEpQn6VYFfFdCzy6beXfYqC2Y5CNDgn2TPREaB3uG5WeJ6KoiYnqVdar5i8QkVKe0mtyW9qIprQEuoCLAW8kKT9Zuej92zdKdf1CR6MuFjv6PURdotANkYi8kbgwOk/jOtc4fTUhgz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o21Shg3pBwWdV/wpY5Ch1suuslDew6EZYzDKjbLZkEtPRt6ZrxsDqdOWlMjSDKfoKnKM5KLb/lS+BcmC8mWbrad3FGphxiprWnMSTTxaqOBO8/MHQ9MTedD7ZwkjTC6Kx90NLcFsEemTU1KY/w3bvHInAfOz0o/ST144/cUtaeRPzLE6locwGp7phkBjIgt6ikGl3IikUCxRF35YwLQ6gbmRMuLeC8JA9YF7VSYw8MXTn96meNlPJw/Sg8RWBbm6WhMa+XgDMdE4LYP7CzwSAw5BDFRCJzDCgzjC+xpgod+UA6692TgrTZcgnwJ/GXAHV41AA9VverwbfefjFPRk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDMfcfjpCeCli5WOiBGAMoFqxpFOckj1aNHLbUQeADI=;
 b=jxVQ0TkhIK0ydj73DErXpNiK5+FTEI+LvOGQeLuZSwNKI/A3W7mFv9jQu1eBJi2DOq6AAWVz1IOpXIQqfeOdGaJSakNpJ07Ky0i9BXyfGtu0z/O4RMpF5NPudEhZckAlgYr6ypOPVayKpIfonzYOTQ30WRZN1Ch94OuxcDhJELje6v4SRfgzdc/q8guetXmSPhQie1o2kZsSydbFNs95G/5E8+Cacqf9EYRtSWtjPj8m0Y6N8p2K6ujdMMORN0EtPyOU3JPMSS6VdqfBKsjXVhKFloX5lKjVCtMKmufVwwDdO0Dk3tQHZrENY7Pi6RRfXDPwUjB16KRTZw8VS1dayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) by SEZPR06MB7137.apcprd06.prod.outlook.com
 (2603:1096:101:232::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:13:04 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:8f:cafe::d9) by SG2PR01CA0156.outlook.office365.com
 (2603:1096:4:8f::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 09:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 09:13:03 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B9B0C400CA08;
	Wed, 13 Aug 2025 17:12:57 +0800 (CST)
Message-ID: <cb35dfbd-2fa4-4125-bd87-9f86405983eb@cixtech.com>
Date: Wed, 13 Aug 2025 17:12:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/13] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mpillai@cadence.com, cix-kernel-upstream@cixtech.com,
 lpieralisi@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org,
 conor+dt@kernel.org, linux-pci@vger.kernel.org, mani@kernel.org,
 kw@linux.com, kwilczynski@kernel.org, krzk+dt@kernel.org,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 linux-kernel@vger.kernel.org
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-9-hans.zhang@cixtech.com>
 <175507391391.3310343.12670862270884103729.robh@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <175507391391.3310343.12670862270884103729.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|SEZPR06MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b80d17-530e-42eb-380a-08ddda499b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEZyVHp5WkVybEJJV29yNGJwYzdGZkJuQ3FLRjNWejhCV1kzUzFsUXA0VTh4?=
 =?utf-8?B?VCttbkNXdmVvanlPWlRxSE83NksvREtpQ29oNGpMMVlYb1FjTTFFbWVKS0JI?=
 =?utf-8?B?anRBQmVFWktDZWUySUM0V3B1Z3U1WnJ5VGxUdERYY2hZKzZHcExGVHBhcmhB?=
 =?utf-8?B?YyszMWUyZXNzVms5SW91aGJvci9helgwWnpVYmpCb25wMVJMLzNXN2toRi9v?=
 =?utf-8?B?dUZJV2x5SVJ1QTVpQ3hhRFRqR0RGWkxjUk5GYnFyajArRE5YZlBvaGRHcGVq?=
 =?utf-8?B?ZGk4eWpEMkNoUzNCbzZWTVdXVDBocWVUZHlyTUtsNGpDZ2ROOGtScmpYTk10?=
 =?utf-8?B?bFk5d0swcEhVcU9LSnp6bnJhNS80Y3Q3My8raUI2WDg1NkEyTUFxVUNLWHlK?=
 =?utf-8?B?NlpQdXI5aFZUeWVzU1dxM2xSMWkyWXlJc21ydzVmbm1DdWt0bFFYTHZGeHpI?=
 =?utf-8?B?SzJnbk9VOW9RUTlwSWpBVW1XYVl0bklzTVdPc1RPWE5wVVc1S2lyWm50aExS?=
 =?utf-8?B?UzFRUkNKUHZzWlc0TzgzeSt6RXh0ak9YQkRrSkVOeTNkNm9tbWU1MGlGSURq?=
 =?utf-8?B?Zzhwc3NVbWM2YjVsZFlURGdTallhcmVnMkIyR2tPKzlSS05hS0cybUhGVHMw?=
 =?utf-8?B?UmNzZ1dMQ2o5VVQzVVJCRi9HUnBDZVVVZmtHVDVYMVdSU2l0cG4xeDdDd2xt?=
 =?utf-8?B?ZDA2MS84cERiczkrYmxxTFl4QUdteWMybWdkZlp1U2hQNnRkRVhBZEtydVJQ?=
 =?utf-8?B?TlVmN0xtdElPMkMydCtLTzRlbUI2WnVjR1ZnUTNnVnYwYVZ3MzlXTVc4azlu?=
 =?utf-8?B?Q0JETElZTUs1RTYxUTVZNSswNlJyU0xDOG1VL3JJMUNqZ29Ya3g5QndVQ0lD?=
 =?utf-8?B?UWlJV1BlWmdPanNiQTd1ak04YlVROWhZMmFNL0E1TTlEOUpYSXNpWEV4RmM0?=
 =?utf-8?B?cUYxRGpDNUlQQkFZa2YwNTZXT0hDU2JiLzdacnJDL3JnK0VlaVdvcE0xZXNz?=
 =?utf-8?B?VFAwV3o0U3pNUzJxMnF3cFd5aTI3d29OVEZXMGRaZXpwbnc4aCsxWHV1d2hz?=
 =?utf-8?B?RmNyN1hrdVpaLy92SFI5YStnYVUrMmNSa3hodGlJVEhxRHd2TjNvNGgzUDUy?=
 =?utf-8?B?TkhSVUN3Vy9qWXRnbzZLY3VROVFsTzl1eHBVdys4cWNWMUNORDd3RmdvM1V5?=
 =?utf-8?B?VEg3bHpvZWx2UlhwWkxlL2E4dHlTZG9JdEtQVHJFTzhKdkU3bENRbEhMdS83?=
 =?utf-8?B?WmZyb0t2VEZSQ1pGM1cyaTJVdytEeFJHRWovREVRTEdCRDNzTVhLQSthL0E0?=
 =?utf-8?B?dFV1bFdPSzI4bkNGalpaNGJQMDRYK1ZjQ3lGeExyNzFaVHRVT0U1TCs3aFFv?=
 =?utf-8?B?MG5ISXprTUtjM3dTQk1oUmM0SXozcGFxcGxLSHRObnl2dlJxNlJIMGZleHVs?=
 =?utf-8?B?UFFNZ2NHYVplMXZSdGdDRHJYNGd5TGwwTzhVNXVNUDlNSnVZUzRyMytkbzdR?=
 =?utf-8?B?VmVUeXZWU2l0djFjbEg4N2NVUmsyOHB4UXhzVWQ4ZHU0Qm5WWm9wcXJTWW5T?=
 =?utf-8?B?SXdnZFFkN0xrczN3V1RkdDJZWTNCMUxCSkJEU05XMUFsTDFsTnVaSzQ0YVBr?=
 =?utf-8?B?Zm0xaW5SclB1Ky9pQm03MjI1YS82VUdkOFUySVpiUSt5eEhKUE5QMXM0cTdU?=
 =?utf-8?B?aWpkSWFCb3FIdEcvaXNac202bHdlemdqak1OdzNmYkRBaEZrWmZkSmIrTWVj?=
 =?utf-8?B?cHJkUHhrVWN4MW9UOGRVYTFtZlErVVd4L25TVkJwOFBzeWgybmd3MHBkYisy?=
 =?utf-8?B?UE5TcHBHcHV0QTNyOTRJd1RkeHJYbklMMVJhNXRBclVCYjFIRlU4bTgxYk1K?=
 =?utf-8?B?ZGpILzRMUTF4bUtTemcyZ1ZNR2tDZkZWQm1kQVBxNWVOTktjaUFNQjV0UWtq?=
 =?utf-8?B?UVlFYkhnWWFaMTZYeVpWRzlQeGVtWkJ4MmVjS2NySHl5aUhKakkrN2RSUUFo?=
 =?utf-8?B?cnMvKzI0cERBPT0=?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:13:03.1401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b80d17-530e-42eb-380a-08ddda499b85
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7137



On 2025/8/13 16:31, Rob Herring (Arm) wrote:
> EXTERNAL EMAIL
> 
> On Wed, 13 Aug 2025 12:23:26 +0800, hans.zhang@cixtech.com wrote:
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
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: /: 'compatible' is a required property
>          from schema $id: http://devicetree.org/schemas/root-node.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: /: 'model' is a required property
>          from schema $id: http://devicetree.org/schemas/root-node.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250813042331.1258272-9-hans.zhang@cixtech.com
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

I'm very sorry. No errors were detected on my PC. I'll check my local 
environment and fix this issue in the next version.

If I have done anything wrong, please remind me.



hans@hans:~/code/kernel_org/linux$ export 
CROSS_COMPILE=/home/hans/cix/bringup_master/tools/gcc/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
hans@hans:~/code/kernel_org/linux$ export ARCH=arm64
hans@hans:~/code/kernel_org/linux$ make dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   CHKDT   ./Documentation/devicetree/bindings
   LINT    ./Documentation/devicetree/bindings
   DTEX 
Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dts
   DTC [C] 
Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb
hans@hans:~/code/kernel_org/linux$ make W=1 dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
hans@hans:~/code/kernel_org/linux$ pip3 install dtschema --upgrade
Defaulting to user installation because normal site-packages is not 
writeable
Requirement already satisfied: dtschema in 
/home/hans/.local/lib/python3.10/site-packages (2025.6.1)
Collecting dtschema
   Downloading dtschema-2025.8-py3-none-any.whl.metadata (7.9 kB)
Requirement already satisfied: ruamel.yaml>0.15.69 in 
/home/hans/.local/lib/python3.10/site-packages (from dtschema) (0.18.14)
Requirement already satisfied: jsonschema<4.18,>=4.1.2 in 
/home/hans/.local/lib/python3.10/site-packages (from dtschema) (4.17.3)
Requirement already satisfied: rfc3987 in 
/home/hans/.local/lib/python3.10/site-packages (from dtschema) (1.3.8)
Requirement already satisfied: pylibfdt in 
/home/hans/.local/lib/python3.10/site-packages (from dtschema) (1.7.2.post1)
Requirement already satisfied: attrs>=17.4.0 in 
/home/hans/.local/lib/python3.10/site-packages (from 
jsonschema<4.18,>=4.1.2->dtschema) (25.3.0)
Requirement already satisfied: 
pyrsistent!=0.17.0,!=0.17.1,!=0.17.2,>=0.14.0 in 
/home/hans/.local/lib/python3.10/site-packages (from 
jsonschema<4.18,>=4.1.2->dtschema) (0.20.0)
Requirement already satisfied: ruamel.yaml.clib>=0.2.7 in 
/home/hans/.local/lib/python3.10/site-packages (from 
ruamel.yaml>0.15.69->dtschema) (0.2.12)
Downloading dtschema-2025.8-py3-none-any.whl (120 kB)
Installing collected packages: dtschema
   Attempting uninstall: dtschema
     Found existing installation: dtschema 2025.6.1
     Uninstalling dtschema-2025.6.1:
       Successfully uninstalled dtschema-2025.6.1
Successfully installed dtschema-2025.8

[notice] A new release of pip is available: 25.1.1 -> 25.2
[notice] To update, run: python3 -m pip install --upgrade pip
hans@hans:~/code/kernel_org/linux$ make dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
hans@hans:~/code/kernel_org/linux$ make refcheckdocs
Documentation/userspace-api/netlink/netlink-raw.rst: 
:doc:`rt-link<../../networking/netlink_spec/rt-link>`
Documentation/userspace-api/netlink/netlink-raw.rst: 
:doc:`tc<../../networking/netlink_spec/tc>`
Documentation/userspace-api/netlink/netlink-raw.rst: 
:doc:`tc<../../networking/netlink_spec/tc>`
Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml: 
Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt: 
Documentation/devicetree/bindings/gpio/gpio-dsp-keystone.txt
Documentation/hwmon/g762.rst: 
Documentation/devicetree/bindings/hwmon/g762.txt
Documentation/trace/rv/da_monitor_instrumentation.rst: 
Documentation/trace/rv/da_monitor_synthesis.rst
Documentation/translations/ja_JP/SubmittingPatches: 
linux-2.6.12-vanilla/Documentation/dontdiff
Documentation/translations/ja_JP/process/submit-checklist.rst: 
Documentation/translations/ja_JP/SubmitChecklist
Documentation/translations/zh_CN/admin-guide/README.rst: 
Documentation/dev-tools/kgdb.rst
Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst: 
Documentation/dev-tools/gdb-kernel-debugging.rst
Documentation/translations/zh_CN/how-to.rst: Documentation/xxx/xxx.rst
Documentation/translations/zh_TW/admin-guide/README.rst: 
Documentation/dev-tools/kgdb.rst
Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst: 
Documentation/dev-tools/gdb-kernel-debugging.rst
Documentation/userspace-api/netlink/index.rst: 
Documentation/networking/netlink_spec/index.rst
Documentation/userspace-api/netlink/specs.rst: 
Documentation/networking/netlink_spec/index.rst
arch/riscv/kernel/kexec_image.c: Documentation/riscv/boot-image-header.rst
drivers/clocksource/timer-armada-370-xp.c: 
Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
include/rv/da_monitor.h: Documentation/trace/rv/da_monitor_synthesis.rst


Best regards,
Hans

