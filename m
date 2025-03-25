Return-Path: <linux-pci+bounces-24685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF0DA705F8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E153A7225
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA411215060;
	Tue, 25 Mar 2025 16:03:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2109.outbound.protection.outlook.com [40.107.215.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA64A18;
	Tue, 25 Mar 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918597; cv=fail; b=nnfzMJSt9tWwzmeATM2pZxbCKSP75q2u+KdIQO+oPIzHp66yaOtKWYd5GhkXv3uvlLLiOZtzLDfPjfGPpkyDG9bafZ4ZvxPw9xNjTWPlCb2kPshRXTZN2GFHdEAB3/RGmAbGI8DLM950gAHEXsPlvqy7IbOuzmAicMVbUpf5JSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918597; c=relaxed/simple;
	bh=NQdZ3E1vkUnNmpmUzcxY/MOxMreZbSzYIJ79k2hvMKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sW2yPkBHcv/myNwkBJ2eGHpx57R/kKoZLalg22JAu+ofMMogziWKnx+X49Dqc5BBfw7xOgpz20GjiJDGzTLqnT7UXYoDxsPvudbRIHHlRC4+B5gdC7+HaOzPPcYQw2XTOt14MfKrMU+ZEBnyI2SXw+/FE8IQx1+tJmWl4f5/ZDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbis3r35toIMs1fHESUy4sxt0LHUm5v8OAq/uHJylz++zjalUa9pd1Y3yqf9qLqQYaFs7QJCzXdEiqeKYNU4tZUa6t+5nUf1WR0xmyVhgbAQe4JJmKXQNPxfQCya7ZsgD6nZYRZRyVUjQYzqszBBhLz2JoFOy1VXHmxj0NYWCIoR/nuS5dfHwAwh6PkcMqX0DE/KyvlegczVbFVEdxCTgZIFL17Xvjxli8k611ktzPTJHJXnso1ecr8N6QS1+NGyxJuowLx+YSRKeTT9Tj6M9LNEuBd0+H/s0AGO2lBUye/hTht5Tbyod8Sd768p3TivuQ8GheO4gHkihd183ulLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H0E1btw7ZiLx+evR48cALPGpiP2ei2e4Bo38LE3tkQ=;
 b=jxAi+oWsQTFn9mhU/QHTsqexHemNCtCeASavguKgGnlQKjqS7q6fATaOcGBMy0CHinMG64VPUR0t4FksfaFUWw+7fyw8iYgJhQFLm5rvKIa57b62tH72ZDw3qZloMMhZsYC2LBwo++VKqWerymk/mR00rYqOE3pwh1fC+ZRlDkYObRC8C7/GcfJ1rhgCGbXfQAsJ+8GdKFsr8WA4kTGYTBkRxkHHv8lrmmNYdPQLIwlZh0CnSY7POYb7fyE+Wk3jHiMRMOLzyH9sBYvfSBfK0tM7AV3RYc3fhKxGprBf0jOe0Kr00iA0KIipPHoM1FW46BHFQdD1duL1BlHtyab/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0207.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:385::20)
 by PUZPR06MB6054.apcprd06.prod.outlook.com (2603:1096:301:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 16:03:06 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:400:385:cafe::2c) by TYCP286CA0207.outlook.office365.com
 (2603:1096:400:385::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 16:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 16:03:05 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BDC994160514;
	Wed, 26 Mar 2025 00:03:04 +0800 (CST)
Message-ID: <96940e1e-a395-49bc-ac29-7ca86bfb8ad7@cixtech.com>
Date: Wed, 26 Mar 2025 00:03:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Loadable Module support for PCIe Cadence and J721E
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Cc: Peter Chen <peter.chen@cixtech.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
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
 <a8966792-fa0e-4e8e-aceb-427819ae4ef5@cixtech.com>
 <bkw4xm4jwe3iuf6sixxl4udosea3bhlwogfua66naf5echbyzv@dlwcbscedh6w>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <bkw4xm4jwe3iuf6sixxl4udosea3bhlwogfua66naf5echbyzv@dlwcbscedh6w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|PUZPR06MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb6a799-487e-4635-5701-08dd6bb687a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkRCc1VyZUNLRTZwUTRISXorOFQ3bE1nZGt6UWJNSFZMZmFudTYzaW5NU0dH?=
 =?utf-8?B?VnUybU8yVHpSMC9tSUJMOUQxZ3REazNwRURrNkUwcitZUXFvbFBoZ2xSR0tl?=
 =?utf-8?B?UjJpSkhRT3pRZ0Q4RDh3MVAxVkZmMldmRnJsZ1VZUnk4STlndWU1S29QalVZ?=
 =?utf-8?B?N2RRd0NsL1Z5dTd2bzZhc2tudHRINUJ6M05nbEhwbDhGOFFzQ0hXMkg5V0Nr?=
 =?utf-8?B?R1dzbXRIelVkWXUrQjZod255bWdReGxtQ0NTdm84OEs3Qjg1T2RaSWJpYVp4?=
 =?utf-8?B?QUZVRDcxTjNyUHBqZ0ZJdU5DYW42WGZCY0NBbFJ1N3dPejl3aE4xdUF1Vytz?=
 =?utf-8?B?czQvMHBPaVZFVkxaUDBLdncvNGhrcGJWT0M3ajdxdUxscUE3YXlEK0FKcFFC?=
 =?utf-8?B?MGljNVc1dW81RmxtYVpwMzcrdVlXWGFBMkdSS25CdHc3OERHK2VUWXM3Y3ZO?=
 =?utf-8?B?SEUzdElEMTdFbktwYXNhdEs3Q1VneVlTcDgrTVlpZkNSODJZb3FqOXpqRHEx?=
 =?utf-8?B?TUhRajJWM3dWWVJTMkIyak9ZdmNPRU1RaDlWK3I2dFJkQjFTc0JnTUJvUU1z?=
 =?utf-8?B?cXV0WUg1M2Rock14dlpYNDEvYVVZZFg0VzI5Y3ZJQmU5d3UvRlV1ZHJtbm5W?=
 =?utf-8?B?eXRqUFlJSVMvVDhFZDJNdW1nc3U3WTJ3NHpxb2FzcENpcXFYa0REbVRlU1dC?=
 =?utf-8?B?cTFjYjlwNmZqSGlJZFp4NDJSM2lMMnJzUzV1dUx3TjhFUTdGMHlqZHYzQUhh?=
 =?utf-8?B?TXcyTk40cEVvTG5KbytjRlJFeDVEbkRUWmczOWcvRjJZMytnaUZ4QnBMaEFk?=
 =?utf-8?B?c2pZYjlsd2UrYTFiZi9rWFFOazV4eGM1eDJGVGZDL3BtNWUxN1hQdjN4eUxq?=
 =?utf-8?B?bmhlc1JGWDBRVUJuaDhwRXgwZzhwYmNJeHFOWklnUTEvRDFWbWZReWdmWG5z?=
 =?utf-8?B?MlVSTHJ0N3Q3WEhHYVhrNmNrMHR2MHB5YmlrMXFqTnFRYUxlSjdDWGpwdGk5?=
 =?utf-8?B?Nms2Z2d3VlJOUFZyR2ZpNndmazUvSnhZZXYvczgzckpWT0JOZUZaOFFDYzZm?=
 =?utf-8?B?VThsKzNkTmxubTh2bXpieC94SWx6QW5uVzVDeHBhaEVYUG9lalJrOTk5c2xt?=
 =?utf-8?B?MEJVSjNHcFFWbnhyMUt6dUxoU3ZyTnh4SXdsWS9oODEzVEQzbWpscFMycHBw?=
 =?utf-8?B?bnB1ak1WZ2hibkVnWTZUV0pKYnhWNm1rTUpYdU5wanpJdVBrTDJRRDBIcXhR?=
 =?utf-8?B?QWplRitaSUtwSVJIbjJSNXRITmNXUnRZcXh5d1dwa3FJU294dHpWVTl0THQ2?=
 =?utf-8?B?SmNTeExqb2tmMldwYXQ1blBLbjl0b0hwaUJtVHdXU09maU5HeGp0VDhtMlBS?=
 =?utf-8?B?bllKOUY2MmljSlVmSTV0b3ZLeEtNUVdsSWVIbTYxOGo0SDJWaGp5WXFxS1FV?=
 =?utf-8?B?RXZ1TU8zNXk3RlQvT2poOGU0a3JHVWVDa2NmQUxsazEvbVZLWWdITjFFa0s4?=
 =?utf-8?B?QzZEQWR3MTExYmR1cjg2Ymo2azA4RHJBQmZ1MnQxR3B6WkxXeVdVbVlFSE9z?=
 =?utf-8?B?THBLRytsMnlDQ0Y5SFFWQzkwdVo3MEZkVFh4VG9SZHhESFhIMGxZamkybno1?=
 =?utf-8?B?Qlhpa09VS3o3Kyt6RTgvN0U1VjRGa3BidURLOUoxMTZmOVNFSmVzT29OdjNw?=
 =?utf-8?B?OTI1OUdtNkVKS0tGSlhodHdabHlOc24vZVNsRVpqWFZTUnFaQ2NOTE9YR3dZ?=
 =?utf-8?B?eVZhUkxyOUNHVXVJVEx4T1RIOTgrTHhqZ05XdXBsSXRIUUs0L3RtNHFvQUNq?=
 =?utf-8?B?SFhIUmh1VVR0bCtJbEJCSitlaDhqTmVISFBRZjNQaW5IbDU5Y0drQTFKaHly?=
 =?utf-8?B?a1VQd2NPRmttdmN4cDUyQUZuME5JVGdLR1R2aytKWmsvYmEvZXg4TXRTYW9U?=
 =?utf-8?B?L3BlMXJhVFpWa25vV1BhMmtybHVrQllXZEtwZ3Z1RVljSnVMc2UrMWNCcmMy?=
 =?utf-8?Q?V0qSStZmt7x8IlNBAyZfDDjF6DcDpM=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 16:03:05.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb6a799-487e-4635-5701-08dd6bb687a3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6054



On 2025/3/25 23:26, manivannan.sadhasivam@linaro.org wrote:
> EXTERNAL EMAIL
> 
> On Thu, Mar 20, 2025 at 10:14:02AM +0800, hans.zhang wrote:
>>
>>
>> On 2025/3/19 17:55, manivannan.sadhasivam@linaro.org wrote:
>>> EXTERNAL EMAIL
>>>
>>> On Wed, Mar 19, 2025 at 05:31:01PM +0800, Peter Chen wrote:
>>>> On 25-03-19 14:25:34, Siddharth Vadapalli wrote:
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> This series enables support to build the PCIe Cadence Controller drivers
>>>>>>> and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
>>>>>>> Modules. The motivation for this series is that PCIe is not a necessity
>>>>>>> for booting the SoC, due to which it doesn't have to be a built-in
>>>>>>> module. Additionally, the defconfig doesn't enable the PCIe Cadence
>>>>>>> Controller drivers and the PCI J721E driver, due to which PCIe is not
>>>>>>> supported by default. Enabling the configs as of now (i.e. without this
>>>>>>> series) will result in built-in drivers i.e. a bloated Linux Image for
>>>>>>> everyone who doesn't have the PCIe Controller.
>>>>>>
>>>>>> If the user doesn't enable PCIe controller device through DTS/ACPI,
>>>>>> that's doesn't matter.
>>>>>
>>>>> The Linux Image for arm64 systems built using:
>>>>> arch/arm64/configs/defconfig
>>>>> will not have support for the Cadence PCIe Controller and the PCIe J721e
>>>>> driver, because these configs aren't enabled.
>>>>>
>>>>>>
>>>>>>> @@ -209,6 +209,12 @@ CONFIG_NFC=m
>>>>>>>    CONFIG_NFC_NCI=m
>>>>>>>    CONFIG_NFC_S3FWRN5_I2C=m
>>>>>>>    CONFIG_PCI=y
>>>>>>> +CONFIG_PCI_J721E=m
>>>>>>> +CONFIG_PCI_J721E_HOST=m
>>>>>>> +CONFIG_PCI_J721E_EP=m
>>>>>>> +CONFIG_PCIE_CADENCE=m
>>>>>>> +CONFIG_PCIE_CADENCE_HOST=m
>>>>>>> +CONFIG_PCIE_CADENCE_EP=m
>>>>>>
>>>>>> The common Cadence configuration will be select if the glue layer's
>>>>>> configuration is select according to Kconfig.
>>>>>>
>>>>>> Please do not set common configuration as module, some user may need
>>>>>> it as build-in like dw's. Considering the situation, the rootfs is at
>>>>>> NVMe.
>>>>>
>>>>> The common configuration at the moment is "DISABLED" i.e. no support for
>>>>> the Cadence Controller at all. Which "user" are you referring to? This
>>>>> series was introduced since having the drivers built-in was pushed back at:
>>>>
>>>> We are using Cadence controller, and prepare upstream radxa-o6 board
>>>> whose rootfs is at PCIe NVMe.
>>>>
>>>
>>> It doesn't matter. Only criteria AFAIK to build the driver as built-in in
>>> defconfig is that it should be a depedency for console. For some time, storage
>>> was also a dependency, but for sure PCIe is not.
>>>
>>> Moreover, CONFIG_BLK_DEV_NVME is built as a module in ARM64 defconfig. So it
>>> doesn't matter if you build PCIe controller driver as a built-in or not. You
>>> need to load the NVMe driver somehow.
>>>
>>> So please use initramfs.
>>>
>>>> You could build driver as module for TI glue layer, but don't force
>>>> other vendors using module as well, see dwc as an example please.
>>>>
>>>
>>> DWC is a bad example here. Only reason the DWC drivers are not loadable is due
>>> to the in-built MSI controller implementation as irqchip. People tend to build
>>> the irqchip controllers as always built-in for some known issues. Even then some
>>> driver developers prefer to built them as loadable module but suppress unbind to
>>> avoid rmmoding the module.
>> Hi Mani,
>>
>> I think the MSI RTL module provided by Synopsys PCIe controller IP is not a
>> standard operation. The reason for this MSI module is probably to be used by
>> some cpus that do not have ITS(LPI interrupt) designed. Or RISC-V SOC, etc.
>> MSI is defined as an MSI/MSIX interrupt that starts with a direct write
>> memory access.
>>
> 
> Yeah, DWC MSI controller is not a great design. The older ones are even more
> horrible (using SPI interrupts for reporting AERs etc...).

Hi Mani,

Currently Synopsys and Cadence provide SPI interrupts for reporting AERs 
etc... This IP vendor only provides an alternative approach that 
actually requires SOC design companies to design according to PCIe SPEC 
and conform to linux OS software behavior.

I have a way to workaround AER is SPI interrupt. It can also use aer.c 
drivers. However, I have been afraid to submit patch, because this is a 
problem of SOC designers themselves, which does not conform to the port 
driver of linux os (aer.c). So it will certainly not be accepted.


> 
>> There are also SOC vendors that do not use the built-in MSI RTL module.
>> Instead, MSI/MSIX interrupts are transmitted directly to the GIC's ITS
>> module via the GIC V3/V4 interface. For example, RK3588, they do not use the
>> PCIe controller built-in MSI module. Some Qualcomm platforms also modify the
>> PCIe controller's built-in MSI modules to connect each of them to 32 SPI
>> interrupts to the GIC. I was under the impression that the SDM845 was
>> designed that way. The only explanation is that SPI interrupts are faster
>> than LPI interrupts without having to look up some tables.
>>
> 
> If ITS is available, platforms should make use of that. There is no way DWC MSI
> is superior than ITS. We are slowly migrating the Qcom platforms to use ITS.
> 

I agree with you.

> And btw, Qcom DWC MSI controller raise interrupts for AER/PME sent by the
> downstream components. So enabling ITS is uncovering AER errors which were
> already present :)
> 
>> So the dwc driver can also compile to ko?
>>
> 
> Only if the MSI support is made as a build time option and there is a guarantee
> that the platform will never use it (which is difficult to do as the driver can
> only detect it during the runtime based on devicetree).

Anyway, I would still like to request that the Cadence PCIe controller 
driver not be in module mode. Cadence also has a lot of customers, we 
are one of them, it's just that many customers don't have upstream. We 
are about to upstream.

This series was introduced since having the drivers built-in was pushed 
back at:
https://lore.kernel.org/linux-arm-kernel/20250122145822.4ewsmkk6ztbeejzf@slashing/

Hans:
The Cadence PCIe root port driver can not be made into module mode 
because of TI's idea. We should consider the ideas of other customers. 
If you have to make it module mode, I think all peripheral drivers 
should be module mode. Maybe I'm being direct, but that's probably the case.

Many thanks Mani for replying to me.

Best regards,
Hans


