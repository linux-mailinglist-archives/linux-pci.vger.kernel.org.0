Return-Path: <linux-pci+bounces-24193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359AA69E44
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 03:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D52189EB19
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 02:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C51DF725;
	Thu, 20 Mar 2025 02:26:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC61EA7EC;
	Thu, 20 Mar 2025 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437616; cv=fail; b=FmNoI09Nz2izcZ2jaDJiwHYuX+21YrZ0cf+HgGABTqnTionSGu+YPvy5Ij6UQAofHODaKwtqIk8arPY8w8yL5hQ9UxDbagBE6P2etGjMeVf+QYCat2j0ZzSdJOBE+JSkrocHibvgLA6D1VeAfXDr2sQ4hv4hmA6QE+HXx0IVOmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437616; c=relaxed/simple;
	bh=BHsYFgiE41FcoSjOjw23THPX4f9bA1eTL1I8SighLK8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NpyLZ+M7tcUtBPh0cQLoxeSqnK/jq0WWGmZpGml2foIN9OKGLVA1WrsFZUeJ/RJ6cNi7o6Jo1oAWchFcMM03hYsr+zhVm4ndV5CN3OCm/zm19IjeqjCgrKR1esxN7GAEDN0e+Qlaoiq3gRVfeu/0TOCtzcgI9skBDG4zc93eSEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMeSyEb9yK+z7hgQ8oISFG/AICDiiE5+hpubcM7G1RLO+MoOFT/bEwwSWL8BwCa+CV8sjOts49Kvfot5MrfPEOaPXpJbmGlFzSM2KajzSZ5D4nPg/+adCRCfWZwgp0KZU7fKmFG9PtP6kEYenn/QYP0ut1jiEoH+hJJ4tEqech7wec/EdBVsH1DP9td/5GxTRnTN0Vtc54cV6iyT9H5miSW5kjEEjbAVusGFHj0nOWFKA87wJRBI+wP2EezCxjCc0Uvu/5GJp6O0cqsrJw80j6hudHFo+Vls8vKe9gJeZnYIcujKe3jci/++9vkZhQOE5jOzAqJSMDQXR+RAFEjk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpkXsU7WYybWjNsw1WLpPHUoJ9KveqBPI/gawB0qkZA=;
 b=xIwhCNXBjEYW+V61jNSPWkv2nnL9g8iDNmnUKC0gnesXcOShHbNDQBH4FRn+YEyQzVcHeVXOyJKzpOiwvzuhbQCVtxcocsmrWP5TybPqfxIKfAn4HnvaJTwHnOPRwRJ+/K61fnKdvwqvd+nVuYbR8V7VS5mfH9Sm4ojoeAZZHZlh4bwgE2YoVN810NtCzKs/WJevtYEfIl+p8BE/xtNFdZZNSkFzejVoXIsOHxCWUxP4DAWeWT21JtCPAOXh2FDg67a3qLlR8lTEUtnvimzpjmg35bxEOJBZuWSqRQ+t5aS73Q0GnsuBG+ydwjjs3IsjPNMVBwsixdbdrAvVZRf+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) by SEYPR06MB6522.apcprd06.prod.outlook.com
 (2603:1096:101:169::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 02:26:49 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:4:189:cafe::ca) by SG2PR01CA0183.outlook.office365.com
 (2603:1096:4:189::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 02:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 02:26:47 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id F25D74160CA0;
	Thu, 20 Mar 2025 10:26:46 +0800 (CST)
Message-ID: <2ac84de4-a421-4271-81e5-9b8489b37238@cixtech.com>
Date: Thu, 20 Mar 2025 10:26:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Loadable Module support for PCIe Cadence and J721E
From: "hans.zhang" <hans.zhang@cixtech.com>
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
 <a8966792-fa0e-4e8e-aceb-427819ae4ef5@cixtech.com>
Content-Language: en-US
In-Reply-To: <a8966792-fa0e-4e8e-aceb-427819ae4ef5@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SEYPR06MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 42576c14-5678-4fa2-a671-08dd6756aa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzU3QXVvdjUyL09tY2xuRXVYdjdKK1VqeDR1bXF1Vy9iWDM2bDU0dGVCaEtU?=
 =?utf-8?B?eFRIZzJ1b21HckxWREdNSE5LaUN6KzBlUDdlMG41SGVkeVptVVdsdFBZY0Ft?=
 =?utf-8?B?V1k0NTdYOC9rc3JDVmNsbmh5dDFITlY4NmhkVHE0NXp1em0wOFF4QzdXT0cz?=
 =?utf-8?B?TjlUc3pBb3Z5c2JVR1RoSndKbUJsSmxGbGk4VzNOZjhHTnpZUGxkemJXWEp4?=
 =?utf-8?B?OE1WeHdvbU1jeVlTbTJFV2NPOWZlZytGK255MWtreVhqOGNic1RRLzN4OWlx?=
 =?utf-8?B?TjZIOGRkeEtXaTNaeVNXdFFmYkZNZVBKYmhTYjhEZUl4QTJlN0xQN01tWHNC?=
 =?utf-8?B?T1RlMVZCTDV2bmtFYW94Um4yRFkyV1d0TzdDUWFPK1hGWXJuVDV4VzE5TnBp?=
 =?utf-8?B?WktWR0IxUFF6OWNMTXVNSTZwVlpYZzgra2NZTmk1TTVKbTBkUithcllJZU5a?=
 =?utf-8?B?VmlscE1OdHkxdkRaQ3kzWjlEM1dmZmh1ejlZczkrS2hPTm53YzVUdlBoWm5y?=
 =?utf-8?B?eUgwVWRhVWl2cnRYL1BJRE5LN1ZzNXhJR2VUbUVHdnBBVElzbGVUMGoybGtU?=
 =?utf-8?B?L2tUNlJYTWV0RnNoVEM0eDVoWUV1TUdoYXExYzhxa3p6VWZJYlo1T2dtTDZE?=
 =?utf-8?B?YlpDZlZIczE2bGNucG1zKzk0WUFNNjNxdEczaVFIMWpSbVpJTUNMTkJOMnRB?=
 =?utf-8?B?RXBiZzRLQVZFZ0k1VmlKM0VhSG5NZUdPeUlLZXBaSFJ6Vm1ibnR1Yzl2dVBX?=
 =?utf-8?B?cTZ4LzlsV3JZV0R4bDQvU01PVWxXdFE2aTBxM1AvL290dE1iSjEvekxKRjNi?=
 =?utf-8?B?YnZpbzJkRzZUNzNrZXJCTmtMS3FQUnlZQW9iUEx6bDhyMVovUGJQaG9YcUEv?=
 =?utf-8?B?MVpSTStMZ2doZEEreDVZNTE2TG1PbFc3ek4zV2YzV21Ra29Fa2p2bmhtN2pj?=
 =?utf-8?B?ZVZyMWx1dDkrb0VYbzUwR21NSzBRSFZKMXM0ZVg1NnJoTVl4cWZTS1hHemQr?=
 =?utf-8?B?UmRIQ1o4UngwemgzbG1jOEhaTDZhOE01aE5wNnc1ejhldjFwTkpRRFdySWI2?=
 =?utf-8?B?K2FxczAvS1huV0VDcWdMVnNkWVZqcFJLQWR0Q200blo5ellPYnNLUTVBckhW?=
 =?utf-8?B?UlA4V3JhK2pBdmhUZy9CdzJHUjBZNmIwWHRTdDRrVmdwRGg3aTd4MG9JVG1s?=
 =?utf-8?B?YzRGc0FWOFBIb0FvMThNZUVjVldtUVBBM08rUjFRRHBBTVlEWnh1U1QzeUkr?=
 =?utf-8?B?SWozUHJYVnJPQi9qM3BXcy9DbjJJbmtpS3FOZTNCT0NmeVZ1SCtrQmthRVF3?=
 =?utf-8?B?UjRDTEZHM3RzNGJLbjZRczJpZFlmL2orZ2JEbzU3bEljakFzNnBJdnZkcGM5?=
 =?utf-8?B?aXhBcWczTFl5UUoza3JyOTMvY0RFMFdvaVpFdEdqa1lzOG9YaFl5Nmxpall5?=
 =?utf-8?B?YWtuMEMxUVd6YitEYTUxUlBRTUNXNVo0clh6ejF4NDE0eThQL1BYdGVaQUpQ?=
 =?utf-8?B?ZmlvMTFCbFBsdDZMVlhMekc2ck1nVWJhWGVZYnlNUzdrNnN6UXhTSW54V2Nl?=
 =?utf-8?B?V3dsZGxoNG1RK1N2U003aHgvVkJoMElGdXJJeUg5TWlFUzA5VU5KaFVCaFFZ?=
 =?utf-8?B?a1Z1ajlyY0psc3JSbDYvTXpBbENTRjdMUFFGNjFMSlRoZXMxOS9SMVVkTFBS?=
 =?utf-8?B?VjJ5bllCcVVqd01USUZZeHFxUjE1b3NLTkpRZjJXZ0R5T1l1YUYxYkxVVkda?=
 =?utf-8?B?UFhNdCtTNzRxMVE2MVl2V0hRMTkyQWFDOHd2dTFCWVk3WFk5SGgwRHhsT0JY?=
 =?utf-8?B?S2RSb1hGOXV5eC9xbTR2dkpMU0Z6dkM1cU5lOWRMSUw5bGl1ZG92RmVoOVps?=
 =?utf-8?B?a3BpVUhONnIyNHp4TXViVkgrT0g0VW1WN0gxNlpHQ2dWcjAyL2RWRElpcjd3?=
 =?utf-8?B?L3hVcnNwVE1QT2lxLzFMeWFxMmNmVnptQVZrYTVCY041ZXNBYUthbXZUMVVZ?=
 =?utf-8?Q?Xjxn5klRYEPj+Fu6ss11Yh4DhcYoU0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 02:26:47.8924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42576c14-5678-4fa2-a671-08dd6756aa79
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6522



On 2025/3/20 10:14, hans.zhang wrote:
> EXTERNAL EMAIL
> 
> On 2025/3/19 17:55, manivannan.sadhasivam@linaro.org wrote:
>> EXTERNAL EMAIL
>>
>> On Wed, Mar 19, 2025 at 05:31:01PM +0800, Peter Chen wrote:
>>> On 25-03-19 14:25:34, Siddharth Vadapalli wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> This series enables support to build the PCIe Cadence Controller 
>>>>>> drivers
>>>>>> and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
>>>>>> Modules. The motivation for this series is that PCIe is not a 
>>>>>> necessity
>>>>>> for booting the SoC, due to which it doesn't have to be a built-in
>>>>>> module. Additionally, the defconfig doesn't enable the PCIe Cadence
>>>>>> Controller drivers and the PCI J721E driver, due to which PCIe is not
>>>>>> supported by default. Enabling the configs as of now (i.e. without 
>>>>>> this
>>>>>> series) will result in built-in drivers i.e. a bloated Linux Image 
>>>>>> for
>>>>>> everyone who doesn't have the PCIe Controller.
>>>>>
>>>>> If the user doesn't enable PCIe controller device through DTS/ACPI,
>>>>> that's doesn't matter.
>>>>
>>>> The Linux Image for arm64 systems built using:
>>>> arch/arm64/configs/defconfig
>>>> will not have support for the Cadence PCIe Controller and the PCIe 
>>>> J721e
>>>> driver, because these configs aren't enabled.
>>>>
>>>>>
>>>>>> @@ -209,6 +209,12 @@ CONFIG_NFC=m
>>>>>>   CONFIG_NFC_NCI=m
>>>>>>   CONFIG_NFC_S3FWRN5_I2C=m
>>>>>>   CONFIG_PCI=y
>>>>>> +CONFIG_PCI_J721E=m
>>>>>> +CONFIG_PCI_J721E_HOST=m
>>>>>> +CONFIG_PCI_J721E_EP=m
>>>>>> +CONFIG_PCIE_CADENCE=m
>>>>>> +CONFIG_PCIE_CADENCE_HOST=m
>>>>>> +CONFIG_PCIE_CADENCE_EP=m
>>>>>
>>>>> The common Cadence configuration will be select if the glue layer's
>>>>> configuration is select according to Kconfig.
>>>>>
>>>>> Please do not set common configuration as module, some user may need
>>>>> it as build-in like dw's. Considering the situation, the rootfs is at
>>>>> NVMe.
>>>>
>>>> The common configuration at the moment is "DISABLED" i.e. no support 
>>>> for
>>>> the Cadence Controller at all. Which "user" are you referring to? This
>>>> series was introduced since having the drivers built-in was pushed 
>>>> back at:
>>>
>>> We are using Cadence controller, and prepare upstream radxa-o6 board
>>> whose rootfs is at PCIe NVMe.
>>>
>>
>> It doesn't matter. Only criteria AFAIK to build the driver as built-in in
>> defconfig is that it should be a depedency for console. For some time, 
>> storage
>> was also a dependency, but for sure PCIe is not.
>>
>> Moreover, CONFIG_BLK_DEV_NVME is built as a module in ARM64 defconfig. 
>> So it
>> doesn't matter if you build PCIe controller driver as a built-in or 
>> not. You
>> need to load the NVMe driver somehow.
>>
>> So please use initramfs.
>>
>>> You could build driver as module for TI glue layer, but don't force
>>> other vendors using module as well, see dwc as an example please.
>>>
>>
>> DWC is a bad example here. Only reason the DWC drivers are not 
>> loadable is due
>> to the in-built MSI controller implementation as irqchip. People tend 
>> to build
>> the irqchip controllers as always built-in for some known issues. Even 
>> then some
>> driver developers prefer to built them as loadable module but suppress 
>> unbind to
>> avoid rmmoding the module.
> Hi Mani,
> 
> I think the MSI RTL module provided by Synopsys PCIe controller IP is
> not a standard operation. The reason for this MSI module is probably to
> be used by some cpus that do not have ITS(LPI interrupt) designed. Or
> RISC-V SOC, etc. MSI is defined as an MSI/MSIX interrupt that starts
> with a direct write memory access.
> 
> There are also SOC vendors that do not use the built-in MSI RTL module.
> Instead, MSI/MSIX interrupts are transmitted directly to the GIC's ITS
> module via the GIC V3/V4 interface. For example, RK3588, they do not use
> the PCIe controller built-in MSI module. Some Qualcomm platforms also
> modify the PCIe controller's built-in MSI modules to connect each of
> them to 32 SPI interrupts to the GIC. I was under the impression that
> the SDM845 was designed that way. The only explanation is that SPI
> interrupts are faster than LPI interrupts without having to look up some
> tables.
> 
> So the dwc driver can also compile to ko?

Additional reason:

Often in SOC design, the RTL designer does not understand the dwc-driver 
behavior and causes some RTL bugs, and the software needs to workaround. 
  As a result, the dwc driver of build-in cannot be used, and the dwc 
driver needs to be modified, which will make it easier to compile the 
dwc driver to module.

Best regards,
Hans



