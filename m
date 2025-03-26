Return-Path: <linux-pci+bounces-24716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D941A70EAA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 02:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F70177545
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C5E74040;
	Wed, 26 Mar 2025 01:56:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866684086A;
	Wed, 26 Mar 2025 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954211; cv=fail; b=iSIJyXA/hm21HeYHm/jeNfLYQ0rK5Fo1UjM11Pm8tp2rWFQc6oJIpOn/e/iU+hlHOk449inEo2fRj2QAflUwUPF2baDaBipZ6MxG19GNLMGVFezzr0O883DsvxqtSmbfUP3CE35pkiDL9187SrMNpAdH2i9XoE0LIeQeHUFMVZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954211; c=relaxed/simple;
	bh=PA2pS+GKLbDTH8FyKEqCwS03134DTnjlBItude3iZn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhRZ6b+QDsruEuuL+GVOw0wx7ZPZ+shReEbgtfLpPuAafWQLaTzbuGW6waw47liSQyPSj4W7XPKtJE5/dxGPE7zWBrAMqFaoPH6EUtWvPEQuTqnjUFKTrng6P8PhQ6RGf3RetaKmVsKG7ybRJj4HGQXmG+lJjkuwl0OG6Bprzms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnkrTRahDGFEmqZ+RXfHVSZL00tu+DQ//Q0s6n+DC7vaEn8DqnLRPDAk6pEge9/3aYSnSzSF0uyKYMUSFg3SaUF0AVbZga6S8ceMKQ7QXS+Vbn19RbaCQIETD63GhsoGm8kUoTTaekXSlBZvB0iS6B4BI2LUeXZGJeoGAkWoL4ur40Xt6imBMa1TIWrIPRIBus/HdiqpxUMdeJxun0KUAmEw+jpZc1VubITv2cA3uAQszhFJ1F1SqWDhiuQBeVu43dI1q3x/GF5h66DOauZyo01RjP8VkNqmnuxVRyyHjAxJezGj1S3ap2bsmb6pKi+0LMBQG3GCIUjtf+76VL6BhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PugqvdqHcuCBZvNsgBPKrpw/hgFa+/7KSaVbwkc1FK4=;
 b=eJA3WIwj3wTMXHVKz+Dc9D0TIXA5QFL9POvi/ukhlvuLimEjUluyrwTN/p3onx0iA8W0WPCQ5agj3tIN3ioJYhY3Fse4UXOw3RPQbIAmNDgw+YmDJSw8yimN5/x2CeJvl/UpolIewjJhtKLm1jsjMVrnm64a0SWB+t+8j0t2pXguSOn+CvvwTSU5fWg0xSEziemiFMSMqJddfjC5gsjzVRy40r6Doo+vf8zg+4goDNoLq8wkNbDupzUvOO3WkrT982Tbrn9lCKfWYS4svUOA3sSg0W/dBh3Eqbbt7kAtIJ6KaSRKQUq+1+MBaqfQ0w0D6mPaVwH22POn15qjS8PTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR0101CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::12) by SEZPR06MB6689.apcprd06.prod.outlook.com
 (2603:1096:101:17c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 01:56:42 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:404:8000:cafe::27) by TY2PR0101CA0026.outlook.office365.com
 (2603:1096:404:8000::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 01:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 01:56:41 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4934A4160CA0;
	Wed, 26 Mar 2025 09:56:40 +0800 (CST)
Message-ID: <9ba07a35-ec55-49ba-9484-e2ab9e511534@cixtech.com>
Date: Wed, 26 Mar 2025 09:56:39 +0800
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
 <96940e1e-a395-49bc-ac29-7ca86bfb8ad7@cixtech.com>
 <2sxwud7mllpbtymfvlw5sshv3fhz3rpk37x23x5ywpzle2qlg4@7bsqhcimnfqp>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <2sxwud7mllpbtymfvlw5sshv3fhz3rpk37x23x5ywpzle2qlg4@7bsqhcimnfqp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|SEZPR06MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db02264-cf18-42e9-7f6d-08dd6c09743d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFBrQmtWWWR1ZG43K1c5c1pnVGFpSEwvUGpzSThUQkprK2x2a2w2cDdMQS9y?=
 =?utf-8?B?SzdrbC9QQmFPcklCUUdXQkRGZVlyT1p5Q2hmTEFtMzlTTGNOZDIrZWF2VWE0?=
 =?utf-8?B?RmVPUTZpUU43SEhPTFhUMk9hN3pUTDltT3VTNC9NWEphT0lLNFlHZGNEUmls?=
 =?utf-8?B?NnRQMDlseVFZQ2tKT3c4UHhrNDNIeGIvNUxSQkhUVUgwaGlvTzJGV0NBWlFw?=
 =?utf-8?B?cVJ4RUZ0c2sveW9Yc2w5d1Z4MmN0VXZGTUd6SUwzMi9uZXlNajFVazNQaHlJ?=
 =?utf-8?B?RTh4YUwzTDNsc3BrbFF1cHhqWGN5L3U3Mm1RS00xQ2VkMkhCUDhIZGlQTUow?=
 =?utf-8?B?TStWbFV5cHIzMnhiTUVoWHAyYVRyZHptbXJHelNsaW9iTlN2WiswSE9jUHRl?=
 =?utf-8?B?dU41bVRiMUNudDRPOGNrWkplcEhMYUlUcmJUUUlCVW5UVGVYZG1sdkpBdmF4?=
 =?utf-8?B?TlRzWVhDdWV5dVlhTTIwZXVnRlUxNGRvTXRtMjF5OUpYb0NBRDdZSHdUL2Vq?=
 =?utf-8?B?a3BGUTlVVzVBc0ZvMS85bTZjbjVCeE9ubUdmMDdqNkoxeEliNFRYSG1KUWNq?=
 =?utf-8?B?Uzd5Q1pzWGp5SzEzb3hkbDhZWG05UDh3K0g2T0FXNnlIVVJCQjY2Zy91N3V2?=
 =?utf-8?B?Vk5VREg1RVM3ZHcySms4Um5ydEp3YndzNSt5c1c2VjFHNkRvTWliM3pKeTdD?=
 =?utf-8?B?aUR6Vy9mWWdjQlVPbzRkWU1aR3M2aTdWZEp1Vm9QdlJueXc3ay8rSllQQk5U?=
 =?utf-8?B?SFdmRU1yeVR1TW15czE2c2lPakxJMTZSQ3F0UDREMTJXRDA1c00vcU1ZYXNv?=
 =?utf-8?B?dWgzWkJRS0tDZVl6SzM2Y1g0MVFhV0FWcTBIcVY2RnNhcTh5bmFtRHJMOUpk?=
 =?utf-8?B?QTl1VUJkenpGODJWT3lLMjFYSDJTUnhkTDB0TzZwTWp0alQ4dnpOSVRHbUlH?=
 =?utf-8?B?Vkh5OVZpd0E1ZHo5MkFndmJNM2VMU0pwaVpnZ1ozYnJ0Nk1vbm1YZEl2TTB4?=
 =?utf-8?B?WEJGOGtNRGJyVHRJbXNyeUJ2aDR0cmlESGlUMHk2YmNYS2xiV2hRdFM0RTh2?=
 =?utf-8?B?clA4ckxlQjk1SngzU3B4WFJxMDgxNHZoUVIzaVZBdUdSVzFSdXh6V2Q5MlJm?=
 =?utf-8?B?U3lZNXRzQ1BjWndiV1RWR3B1TmtDZFo2MzNCSGRwRDlDRmxYeDJlcVF2U2gy?=
 =?utf-8?B?RmN4dDlvaXVTZzJrSW5NZTBLOFM3V0NpNS9yUVppem5ydGhqSHA4YkpRMmJG?=
 =?utf-8?B?NUoyOFlXQ1RJQVozVTlIeVpMYnNUNUNpYm1mZnF2cnFVd2RyNEJYeEVxWTda?=
 =?utf-8?B?dXlKTkl1TSt4bkdjQmRvdFc2amtsbVRPbGx6LzZjM1hzMHBWSU16Z010SXBn?=
 =?utf-8?B?R1RaOW40bmppNGhPOWdiNXJDUy9KQWtaWlFPT241blA5WXNWNmdNa2cwbnpM?=
 =?utf-8?B?enZvekJhM2hOUVI2bnBlR1FUL0pReENJbjlVZXVaZEJMVE0yYW1YNmJYR0Ev?=
 =?utf-8?B?SE5BWGp5c2N6Y1VqOG1vMVhUSFozUXNCc2NkL3BmQ3FBUFVSNTloNS9MSFg3?=
 =?utf-8?B?cUcydTMxdE5KWUN2RVlKaFlwZndhVk1TWWVUNVFEdXJXT0RGeS9IK2ljaWNG?=
 =?utf-8?B?ckw5Tk9pUWxjTndrV2RXSHkzS3E5YkZ3K1djbHZDd2dXMUhUQ2JaNWJHK0Q5?=
 =?utf-8?B?WlVSZ0xDK2k5djU2WHA0SmU0ZjZQQTZhNWo2ZHBxNkxrcDBqS2phTDcyOFZm?=
 =?utf-8?B?dzBxWGtWcDEwb09lN1ZvWXBEY1Vab0hVUS9PTmtLM3dnOW16SUE1bUhWV01S?=
 =?utf-8?B?bjNVd2c0YkI4ak5odGMxdnkyZ0RxdDJ4cWJHWHJJWjc0dEgzSUNsNXdBV0ph?=
 =?utf-8?B?WmJoejZXN3dsSjdhQUw0TUlsK3hadHFacVNrMWhCOFMvVnJHTE5La01NbEFu?=
 =?utf-8?B?ZWdZVWRkQ3NvVS9ITHZyQUMvcEZJdGJYenNhU1diQll2NUY3K1daQm5aeVZN?=
 =?utf-8?Q?TNbRIPBj0yt29AqHKIGgWHUmnX7ytY=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:56:41.4826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db02264-cf18-42e9-7f6d-08dd6c09743d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6689



On 2025/3/26 00:36, manivannan.sadhasivam@linaro.org wrote:
> EXTERNAL EMAIL
> 
> On Wed, Mar 26, 2025 at 12:03:01AM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/3/25 23:26, manivannan.sadhasivam@linaro.org wrote:
>>> EXTERNAL EMAIL
>>>
>>> On Thu, Mar 20, 2025 at 10:14:02AM +0800, hans.zhang wrote:
>>>>
>>>>
>>>> On 2025/3/19 17:55, manivannan.sadhasivam@linaro.org wrote:
>>>>> EXTERNAL EMAIL
>>>>>
>>>>> On Wed, Mar 19, 2025 at 05:31:01PM +0800, Peter Chen wrote:
>>>>>> On 25-03-19 14:25:34, Siddharth Vadapalli wrote:
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> This series enables support to build the PCIe Cadence Controller drivers
>>>>>>>>> and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
>>>>>>>>> Modules. The motivation for this series is that PCIe is not a necessity
>>>>>>>>> for booting the SoC, due to which it doesn't have to be a built-in
>>>>>>>>> module. Additionally, the defconfig doesn't enable the PCIe Cadence
>>>>>>>>> Controller drivers and the PCI J721E driver, due to which PCIe is not
>>>>>>>>> supported by default. Enabling the configs as of now (i.e. without this
>>>>>>>>> series) will result in built-in drivers i.e. a bloated Linux Image for
>>>>>>>>> everyone who doesn't have the PCIe Controller.
>>>>>>>>
>>>>>>>> If the user doesn't enable PCIe controller device through DTS/ACPI,
>>>>>>>> that's doesn't matter.
>>>>>>>
>>>>>>> The Linux Image for arm64 systems built using:
>>>>>>> arch/arm64/configs/defconfig
>>>>>>> will not have support for the Cadence PCIe Controller and the PCIe J721e
>>>>>>> driver, because these configs aren't enabled.
>>>>>>>
>>>>>>>>
>>>>>>>>> @@ -209,6 +209,12 @@ CONFIG_NFC=m
>>>>>>>>>     CONFIG_NFC_NCI=m
>>>>>>>>>     CONFIG_NFC_S3FWRN5_I2C=m
>>>>>>>>>     CONFIG_PCI=y
>>>>>>>>> +CONFIG_PCI_J721E=m
>>>>>>>>> +CONFIG_PCI_J721E_HOST=m
>>>>>>>>> +CONFIG_PCI_J721E_EP=m
>>>>>>>>> +CONFIG_PCIE_CADENCE=m
>>>>>>>>> +CONFIG_PCIE_CADENCE_HOST=m
>>>>>>>>> +CONFIG_PCIE_CADENCE_EP=m
>>>>>>>>
>>>>>>>> The common Cadence configuration will be select if the glue layer's
>>>>>>>> configuration is select according to Kconfig.
>>>>>>>>
>>>>>>>> Please do not set common configuration as module, some user may need
>>>>>>>> it as build-in like dw's. Considering the situation, the rootfs is at
>>>>>>>> NVMe.
>>>>>>>
>>>>>>> The common configuration at the moment is "DISABLED" i.e. no support for
>>>>>>> the Cadence Controller at all. Which "user" are you referring to? This
>>>>>>> series was introduced since having the drivers built-in was pushed back at:
>>>>>>
>>>>>> We are using Cadence controller, and prepare upstream radxa-o6 board
>>>>>> whose rootfs is at PCIe NVMe.
>>>>>>
>>>>>
>>>>> It doesn't matter. Only criteria AFAIK to build the driver as built-in in
>>>>> defconfig is that it should be a depedency for console. For some time, storage
>>>>> was also a dependency, but for sure PCIe is not.
>>>>>
>>>>> Moreover, CONFIG_BLK_DEV_NVME is built as a module in ARM64 defconfig. So it
>>>>> doesn't matter if you build PCIe controller driver as a built-in or not. You
>>>>> need to load the NVMe driver somehow.
>>>>>
>>>>> So please use initramfs.
>>>>>
>>>>>> You could build driver as module for TI glue layer, but don't force
>>>>>> other vendors using module as well, see dwc as an example please.
>>>>>>
>>>>>
>>>>> DWC is a bad example here. Only reason the DWC drivers are not loadable is due
>>>>> to the in-built MSI controller implementation as irqchip. People tend to build
>>>>> the irqchip controllers as always built-in for some known issues. Even then some
>>>>> driver developers prefer to built them as loadable module but suppress unbind to
>>>>> avoid rmmoding the module.
>>>> Hi Mani,
>>>>
>>>> I think the MSI RTL module provided by Synopsys PCIe controller IP is not a
>>>> standard operation. The reason for this MSI module is probably to be used by
>>>> some cpus that do not have ITS(LPI interrupt) designed. Or RISC-V SOC, etc.
>>>> MSI is defined as an MSI/MSIX interrupt that starts with a direct write
>>>> memory access.
>>>>
>>>
>>> Yeah, DWC MSI controller is not a great design. The older ones are even more
>>> horrible (using SPI interrupts for reporting AERs etc...).
>>
>> Hi Mani,
>>
>> Currently Synopsys and Cadence provide SPI interrupts for reporting AERs
>> etc... This IP vendor only provides an alternative approach that actually
>> requires SOC design companies to design according to PCIe SPEC and conform
>> to linux OS software behavior.
>>
>> I have a way to workaround AER is SPI interrupt. It can also use aer.c
>> drivers. However, I have been afraid to submit patch, because this is a
>> problem of SOC designers themselves, which does not conform to the port
>> driver of linux os (aer.c). So it will certainly not be accepted.
>>
> 
> Right. There is not clean way afaik.
> 
>>
>>>
>>>> There are also SOC vendors that do not use the built-in MSI RTL module.
>>>> Instead, MSI/MSIX interrupts are transmitted directly to the GIC's ITS
>>>> module via the GIC V3/V4 interface. For example, RK3588, they do not use the
>>>> PCIe controller built-in MSI module. Some Qualcomm platforms also modify the
>>>> PCIe controller's built-in MSI modules to connect each of them to 32 SPI
>>>> interrupts to the GIC. I was under the impression that the SDM845 was
>>>> designed that way. The only explanation is that SPI interrupts are faster
>>>> than LPI interrupts without having to look up some tables.
>>>>
>>>
>>> If ITS is available, platforms should make use of that. There is no way DWC MSI
>>> is superior than ITS. We are slowly migrating the Qcom platforms to use ITS.
>>>
>>
>> I agree with you.
>>
>>> And btw, Qcom DWC MSI controller raise interrupts for AER/PME sent by the
>>> downstream components. So enabling ITS is uncovering AER errors which were
>>> already present :)
>>>
>>>> So the dwc driver can also compile to ko?
>>>>
>>>
>>> Only if the MSI support is made as a build time option and there is a guarantee
>>> that the platform will never use it (which is difficult to do as the driver can
>>> only detect it during the runtime based on devicetree).
>>
>> Anyway, I would still like to request that the Cadence PCIe controller
>> driver not be in module mode. Cadence also has a lot of customers, we are
>> one of them, it's just that many customers don't have upstream. We are about
>> to upstream.
>>
>> This series was introduced since having the drivers built-in was pushed back
>> at:
>> https://lore.kernel.org/linux-arm-kernel/20250122145822.4ewsmkk6ztbeejzf@slashing/
>>
>> Hans:
>> The Cadence PCIe root port driver can not be made into module mode because
>> of TI's idea. We should consider the ideas of other customers. If you have
>> to make it module mode, I think all peripheral drivers should be module
>> mode. Maybe I'm being direct, but that's probably the case.
>>
> 
> It is not about one company's idea to make the driver as a module. Linux kernel
> community in general strongly encourages developers to build the drivers as
> module unless there are exceptions (which I have already quoted). If you keep
> building the drivers as built-in, it will result in a bloated kernel image. For
> sure vendors would want *their* interested drivers to be built-in so that they
> do not need to package the drivers in initramfs/rootfs, but that's not a
> practice which is encouraged by the Linux community.
> 
> So I'm in favor of making the PCIe controllers as module if there are no
> technical issues.
> 

Hi Mani,

Okay, you must be more thoughtful than I am.

Best regards,
Hans



