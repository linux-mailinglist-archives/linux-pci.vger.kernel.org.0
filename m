Return-Path: <linux-pci+bounces-24192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E1A69E28
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 03:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A629886F44
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD31DE892;
	Thu, 20 Mar 2025 02:14:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7651DDC0F;
	Thu, 20 Mar 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436854; cv=fail; b=XIHwFOIamFZ1OKAcIKH7XKfHXUbPpfdp7m6nP+UmUO7/Resk6jVWYz7Npc0fzlf2MBgw2xFd4F6ic9X66H1iWvRG7iLQBVJrkZBiRiIY7tghnpF5ZS6hYvyoKj3c7jDAcHNV3asduIfGsakqZyUccE1jR7BntkfjlAHQkBZTWJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436854; c=relaxed/simple;
	bh=mGa40P14z87q9UhinjwTTzefgdX4h+CpXVvtj4KtKSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P46z5DeFzsHSQIcZ3tubAZjT9j/Khd9ald/KZq0zxQuLpFhepabyqFwi2t62psqDVOagIt07EJjsw/lgKLhi2+VUCPC7nMmnGH6BQwQTT6kiqmJRLVGW2hdnv1+F78gDGjfhcysdjFuUZzKiwVGG2WtnIBNJvuFeVAqrmAkdB2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPgrQHdo2dbK7fLMrNqXarrIjU85hGMmbnHK4JFcPW7DsjOzuOOmv6LcIHBPzg8vVsinKqRgZ87kWNVlsBN11UVz1KzBpBpzXVrA3ohTLo+rm6VozFo5Z/8v2Vs8xmFV9weWo6Mmxor1sDxIARfX9kJqhmlx/ICzU1uaGg57s9U/aBXnoqX0iRNJBTkxvX9ZL3C2XajHaCgfqpv7m9vuYejL529eM4j+1mvwVnatuPAtE6zSdib4oDxGefP+c8GlDrOPNeLlxAfHZpHai+F0nmfx4dwUp6ULrDTgYdKEBTEVXsT6takkRw0nV6gu/fFhJE4fqS+0NUEzDOD09Ypozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO8uAZnfu0nzvmrRg0SbaV0AmWMoDGkZFQkPpU7xqAY=;
 b=RO3SxeYXP3JbW6omGSxxf/LRN0CtyK1KdZigqwnzk0HLbq8QmL5AHPpsgDjD+FysplQuYp8JrVq3WhQd3EHxcsizx8AgfwMREx8UavDtfZltKehx6veAxyH4IK00g3CUiIfvdAOALfdbcWb/9JR29oimfQZbNW85E3qy7NzvZQIT0/SAEvuQfsvQ/+uovgnkzg+io1do69tRb+HjfH4Zl4MYmSs8pQhXJqhpcXp0U8zrKuadzj3N+Zw1llU9YgklDAC9IUIf0icItll1iUAizLvcRXT+11T+roIzJAJ8FgjzEbeJOTU4X5/S7fMY6rnydqRDPyIUlJnlDRI/T7fuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0012.apcprd02.prod.outlook.com (2603:1096:300:41::24)
 by JH0PR06MB7055.apcprd06.prod.outlook.com (2603:1096:990:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 02:14:05 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:300:41:cafe::51) by PS2PR02CA0012.outlook.office365.com
 (2603:1096:300:41::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 02:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 02:14:04 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6A5354160CA0;
	Thu, 20 Mar 2025 10:14:03 +0800 (CST)
Message-ID: <a8966792-fa0e-4e8e-aceb-427819ae4ef5@cixtech.com>
Date: Thu, 20 Mar 2025 10:14:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Loadable Module support for PCIe Cadence and J721E
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 Peter Chen <peter.chen@cixtech.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "kishon@kernel.org"
 <kishon@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>,
 "wojciech.jasko-EXT@continental-corporation.com"
 <wojciech.jasko-EXT@continental-corporation.com>,
 "thomas.richard@bootlin.com" <thomas.richard@bootlin.com>,
 "bwawrzyn@cisco.com" <bwawrzyn@cisco.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "srk@ti.com" <srk@ti.com>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <Z9pffxeXHVOsoi4O@nchen-desktop> <20250319062534.ollh3s5t7znf5zqs@uda0492258>
 <Z9qO1f5MgNcwO5A4@nchen-desktop> <20250319095511.hf3y2c6vbbnm3ien@thinkpad>
Content-Language: en-US
From: "hans.zhang" <hans.zhang@cixtech.com>
In-Reply-To: <20250319095511.hf3y2c6vbbnm3ien@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|JH0PR06MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d0263f-7156-4daa-d885-08dd6754e353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWR3VmNZUDhpYUtwVE45Z3JHaXNjNGhQT0tUM2RwRm8rTnZFOUNoa1ZCV1Mw?=
 =?utf-8?B?RnA5SEkxWlpXSlcxcDJVem1IRjNJL3pRaGZOM0pabVpRWDB2OElibW82dmIz?=
 =?utf-8?B?QXpiV1Vvd0FuRDVIU2VWaEtIZ0x5VHU5MjNtUzQvbE5ZdmJUYXhWOHBXNndT?=
 =?utf-8?B?UEIvREpaMThYZU5Obkd5ck56SXg2VVhkYVF0NkZNc3NBbDI2S2pEa1RYT0dI?=
 =?utf-8?B?VnRFVUh3aFZ3Z09rZWwvY3lKV2xGckg5TWxRd3M1MEhRVE9jeUlpaGpRdG9p?=
 =?utf-8?B?NE14YWhiekMrOEN3dDdYb0NsMDh5NWxxSFFDRGdzYkQxTk5nWC9oY29SSWRI?=
 =?utf-8?B?SThRa2FNWDV5M3lnbStHMFU5Nnl2aTRNakpRdDFBWjZEV1EydDNPU1NseFBw?=
 =?utf-8?B?d2JrS2ZYaEZRWnVlb2JxY05kTVREcjdzQ2ZEYmhVcHF0YzBRdW1aSXA5TTFw?=
 =?utf-8?B?SExKNjhhWVFRbnhjck5nWjJuZ2QwMVkwVFAxNXhPQ2VwTHQwQ2NpWksvcGRM?=
 =?utf-8?B?L1RGRG1JekUyWjU5c3N2UFVxYjFwazVvS044ajh1TVZIYkhkc0c1SXdMVE9x?=
 =?utf-8?B?RTFITERTUkVjVEx3ZE0zYllUYlMzSERVQzBEV3F5enI3Q3U3Zm5TNjIyTGYz?=
 =?utf-8?B?ejdNbTA1MGh0NnRZZWdQMzMvSjR5aEN4Zm9qQUlHNkhlYTk2Y0swblpMcERj?=
 =?utf-8?B?aThnWlQrcVgwbDkySVd2Y2NTUk90YjlOcnRKYUx6bWxqN1pMRkJQQ3dLRmJP?=
 =?utf-8?B?ejcvMTdiVXJrSlNURjlEQWtTRUJWM1NWU3dHMFRvOVFNRWpkR3FNZDd2VVUv?=
 =?utf-8?B?MW1PTGd2NHVuektEc0Y1M3JJY3gxeUhwZm9ORzM2bGR4VzcvcEVUcURTWFk4?=
 =?utf-8?B?U0VLMGpsRlp0TjY1SHdYS0xkdENnVXJDRUlTQzFnM1h2eHgyclNVWVd3SDlw?=
 =?utf-8?B?NDEyVGtZVjRjZVJCRG10aHkxdU0rU2N2UFlUQm9CZzE3UlptendoZjNyUVFl?=
 =?utf-8?B?ZjNoaHQxUzNqUFlVT2FZT0dya05rNGtMeHM3Uk96cDVBTXljdEd5SFlWVzda?=
 =?utf-8?B?MElvdEdvNDJMYjV3V0M5d3VkRkk5NCsxYmNKSVVscGtoWGx4V0NvNzByUEsv?=
 =?utf-8?B?T2kyUVV2a0VuSUVsNC8ybjhwc0ZNWVhBMjUrSVJueHpUdFBBNFltSUF4dVdQ?=
 =?utf-8?B?K0JXZ2djTHpnSEVya2l1T21teWQrMmg1SkFLZ0FSSEFJU0RPQW9GMlJuMFRL?=
 =?utf-8?B?aWt5TXFIODJiaEZyc2ZLZUdPelpUZ3hUQmRaemFMVE84YzdFbkJZTzY3d3dx?=
 =?utf-8?B?VEhzRFRGZEpyVmF0T29EZHJsYkFxU3o2Yll5UXhKZDlkT1hGbktueDBPWU5G?=
 =?utf-8?B?ZjAwNHQ2cWRQanA1eW1yYkxjNzNBREI3a0Ixb0xRaU5LQjFxQWN5Z011UmRu?=
 =?utf-8?B?Qi9vTnJzd3NnQnlvR3dHRHo0NUNWWnUxc0krcmpybDhQTS9MeXNqVmhMc2Z1?=
 =?utf-8?B?ZHB5Qlg4UVQrSDcrNnA2SjNsWis5Mmp5WmJjSHJLNHVTNC9yWk5UNFA5azVY?=
 =?utf-8?B?K3AzL05YZ0hxa0NxS3ljMmRpOGZSMnh6aXFBNHR0d3hBck03THRSQ3MwY2dW?=
 =?utf-8?B?cnNFMjdrSDVybUtoUEFNd3JrWnVxTTNvL0IybGNCWno2Y2FNSVZCTkk2QlUx?=
 =?utf-8?B?amRqS1FicFFaR0tNQ2RuYVl0bS9QZXA4bzdKUHRRL2xLaTNzTm11ZzdXRU5S?=
 =?utf-8?B?VDRaZm5UQndoVUtzSzBjQ1liU0VRY281c1RrZE5FQ3QrZDVWTXN2clJCRmZI?=
 =?utf-8?B?enJoYlpmcExvR1hrMjB2YU5IOFJ1eGtMYnJmb0F4S1VpeGRQVi96TDFlcWVp?=
 =?utf-8?B?V0FpS1NRVzlHQXA4SVF4SUovZERjakprTzJWZHJBamlja0h1Mm01S2FPcDI1?=
 =?utf-8?B?ZmJxSDlGdXk0Q2M3bGROODBiMGh4VEhWUVhRNHE0OG9YdmkvQkltRVl5Y3BH?=
 =?utf-8?Q?g2iHpJPHbt8c92txD5AMR5pZD6g2Kg=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 02:14:04.3126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d0263f-7156-4daa-d885-08dd6754e353
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7055



On 2025/3/19 17:55, manivannan.sadhasivam@linaro.org wrote:
> EXTERNAL EMAIL
> 
> On Wed, Mar 19, 2025 at 05:31:01PM +0800, Peter Chen wrote:
>> On 25-03-19 14:25:34, Siddharth Vadapalli wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> This series enables support to build the PCIe Cadence Controller drivers
>>>>> and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
>>>>> Modules. The motivation for this series is that PCIe is not a necessity
>>>>> for booting the SoC, due to which it doesn't have to be a built-in
>>>>> module. Additionally, the defconfig doesn't enable the PCIe Cadence
>>>>> Controller drivers and the PCI J721E driver, due to which PCIe is not
>>>>> supported by default. Enabling the configs as of now (i.e. without this
>>>>> series) will result in built-in drivers i.e. a bloated Linux Image for
>>>>> everyone who doesn't have the PCIe Controller.
>>>>
>>>> If the user doesn't enable PCIe controller device through DTS/ACPI,
>>>> that's doesn't matter.
>>>
>>> The Linux Image for arm64 systems built using:
>>> arch/arm64/configs/defconfig
>>> will not have support for the Cadence PCIe Controller and the PCIe J721e
>>> driver, because these configs aren't enabled.
>>>
>>>>
>>>>> @@ -209,6 +209,12 @@ CONFIG_NFC=m
>>>>>   CONFIG_NFC_NCI=m
>>>>>   CONFIG_NFC_S3FWRN5_I2C=m
>>>>>   CONFIG_PCI=y
>>>>> +CONFIG_PCI_J721E=m
>>>>> +CONFIG_PCI_J721E_HOST=m
>>>>> +CONFIG_PCI_J721E_EP=m
>>>>> +CONFIG_PCIE_CADENCE=m
>>>>> +CONFIG_PCIE_CADENCE_HOST=m
>>>>> +CONFIG_PCIE_CADENCE_EP=m
>>>>
>>>> The common Cadence configuration will be select if the glue layer's
>>>> configuration is select according to Kconfig.
>>>>
>>>> Please do not set common configuration as module, some user may need
>>>> it as build-in like dw's. Considering the situation, the rootfs is at
>>>> NVMe.
>>>
>>> The common configuration at the moment is "DISABLED" i.e. no support for
>>> the Cadence Controller at all. Which "user" are you referring to? This
>>> series was introduced since having the drivers built-in was pushed back at:
>>
>> We are using Cadence controller, and prepare upstream radxa-o6 board
>> whose rootfs is at PCIe NVMe.
>>
> 
> It doesn't matter. Only criteria AFAIK to build the driver as built-in in
> defconfig is that it should be a depedency for console. For some time, storage
> was also a dependency, but for sure PCIe is not.
> 
> Moreover, CONFIG_BLK_DEV_NVME is built as a module in ARM64 defconfig. So it
> doesn't matter if you build PCIe controller driver as a built-in or not. You
> need to load the NVMe driver somehow.
> 
> So please use initramfs.
> 
>> You could build driver as module for TI glue layer, but don't force
>> other vendors using module as well, see dwc as an example please.
>>
> 
> DWC is a bad example here. Only reason the DWC drivers are not loadable is due
> to the in-built MSI controller implementation as irqchip. People tend to build
> the irqchip controllers as always built-in for some known issues. Even then some
> driver developers prefer to built them as loadable module but suppress unbind to
> avoid rmmoding the module.
Hi Mani,

I think the MSI RTL module provided by Synopsys PCIe controller IP is 
not a standard operation. The reason for this MSI module is probably to 
be used by some cpus that do not have ITS(LPI interrupt) designed. Or 
RISC-V SOC, etc. MSI is defined as an MSI/MSIX interrupt that starts 
with a direct write memory access.

There are also SOC vendors that do not use the built-in MSI RTL module. 
Instead, MSI/MSIX interrupts are transmitted directly to the GIC's ITS 
module via the GIC V3/V4 interface. For example, RK3588, they do not use 
the PCIe controller built-in MSI module. Some Qualcomm platforms also 
modify the PCIe controller's built-in MSI modules to connect each of 
them to 32 SPI interrupts to the GIC. I was under the impression that 
the SDM845 was designed that way. The only explanation is that SPI 
interrupts are faster than LPI interrupts without having to look up some 
tables.

So the dwc driver can also compile to ko?

Best regards,
Hans


