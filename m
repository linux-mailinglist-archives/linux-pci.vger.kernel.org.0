Return-Path: <linux-pci+bounces-607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAB1808395
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 09:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740911F2251C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44201E48C;
	Thu,  7 Dec 2023 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fnLyhPMX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877919A;
	Thu,  7 Dec 2023 00:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf/giGn2s+UJ3GMlQHj6Zy11pPeOiumwjj0OKMLaRKaE22lxIsGJ2DQgGob36gjrXrqIXFOJI+4DM3tnteMboXUvnpl2O2b29OqVLugCrvPvQuh+mEeZDpiJHNCobm8WhxM/8/bbH+srGbt24AUWdwe8nB+6CSgv4XrKIDxFj0Kkuin79/9Mpd9VJ6TpTA11MFmazuxho9/0eBxgPu1LxrykxmPIT98JVQPznXaBR3ONGKFqpzwoy4N2K9Mw6cbHR+m8MbE52VCjDOaNmkHK7QfDfkqty5BjK6hPfWnhAISs7H3OFEE5w6lLx6VA66n2iMf4xRlylQj1XwpUIUgzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBnslKr4yNfFWfUez7V2Hfhm2rt61a1WmyK4DD1Qx6w=;
 b=WgdCrjgh2LDKKETTQgp6i1NUxx9tyafZA7CNSo2//P9IiFxmqle6MXT8RelpM1uv57XJCAsoTX3l+IC0pVZWl6KCfeyouXXEbZhTXT/38TMYSxlfpQGlQlYmyIYi8V4uH3kzm8++ho+C5XlSDPJ1aBixhe8WqQCSc6UGrGED2LoSUzegD7qBAG7uVGouluekVq/11krWKqwUOAKMTGF3oy8LrLmVQeAHi9SQqdSWN21QduFD8z9u7asWDsAqAbFCpnjgy3AL6swfANdi/cFCVNFEbDwEqZWdj7ITDXr2RXwag343Ldr2D17Yw1zKCZ8OXYd4VEWHsnb6wsQO5PdapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBnslKr4yNfFWfUez7V2Hfhm2rt61a1WmyK4DD1Qx6w=;
 b=fnLyhPMXdlwDzeMc1ALhORYsRT9pex3vd6vCGmj16VQilyKdjBEljJ9ux/rC0OohJRh6ZWR2finuknQUtBYozbbNpXoodM8MEdgZ80kbbq6N8Doi58znLeuKO7X/edpi4YQlEXt3ZuZ+TLoot+tBPRLurUekrsOjA3PIAaMN1U3B/fp35K6ghotbX3A4QoL7EbQOpAKn/NrsI2brDGWh/RP8J3pygHe/3xMMfJJXLE/bZCRexSv/QJUKw9fJ1wc2oEVRHo+p2jfkaQR+oI5gsQjPBriSl+cdWYzVC2M5nEXewQk408g6g+E3Dhn92v94jT5QYdOq0L8imiy1Qj111g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 08:53:59 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::1a50:8e27:5f8f:7c4d]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::1a50:8e27:5f8f:7c4d%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 08:53:59 +0000
Message-ID: <6e282e1b-39d2-4a08-bdd4-a9d02b2b7f74@nvidia.com>
Date: Thu, 7 Dec 2023 14:23:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, thierry.reding@gmail.com, petlozup@nvidia.com,
 rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
 jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
 jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
 viresh.kumar@linaro.org, gregkh@linuxfoundation.org, steven.price@arm.com,
 kw@linux.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, vidyas@nvidia.com
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
 <20231206153627.GJ12802@thinkpad>
 <c86e8f75-f74a-491e-9ac0-2431a6ec4b80@nvidia.com>
 <20231207075952.GG2932@thinkpad>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <20231207075952.GG2932@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: c18e7d28-c0a7-4709-9b55-08dbf7020d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uFc066SYW4OedTJuTeidad6wvRF2shd7cAuFmT5SXsFM71+NrbTmLDxDsV71/b8QhgMbV2BN44GfIindhojLX549gWFA9gqXkVva9qKn15pyb7tAcYoXQbk1QYSkrY2H9C1oN3wVoeoP5x1eLiLFoMRQGSxtvIyxTa6RfYKsnBOEfl4Ib2RwVKGPxIJLrFA55Zd408bO6yeX/URWSClrcbgg/nJYb6irk4QLupVQ88ngz/rkCTn6y4qZG1wQL59kbMeacF6mNvfWVw7CVWNtLSCh3U1owRizPo33VhQvWui5LAqhbnYcW/cQeFxnyTkGY7g21+2poGeB315veOBtT0slygkZbe0+iCfRfLDYCAWC2VJysJAVCIdzF4TFxo+vnp1soZn8ca7VyI/H6XIiatKcxW6oSW8qWNzgOcbf/MBm2fmK+wMFG1Bz7mzwj7TgFE9XXUCmXzZBWqd7SpTv0nkUPXoSce5gqcc8WBDmJCKpgQRq8SygYa71gXUPJnE1fUavV3nY7ZCIR+kMdLQvSkUJ3BUEeDhYniI3FvVeDlqR9ZT1uRA7I1TTuITfJmmvnN5VjJTpsRx62TGQNGWfkbH05D6RLgFGSnw0ab27TRz4WG335LL+OY4Rq6AeDSXSIOaVHYEmMbULeiMqnGGh/0S1+8GSLfjypfGLMgAWgVK4M1HN9/ozbzf4IBwDrfL1evMJjBdDCoEc7KtUEtyhxCFtUDTg0TuOwyFGMWPh4+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(6486002)(966005)(478600001)(5660300002)(53546011)(6666004)(66946007)(66476007)(316002)(6916009)(66556008)(8936002)(8676002)(4326008)(6506007)(86362001)(31696002)(38100700002)(36756003)(41300700001)(31686004)(2616005)(7416002)(107886003)(2906002)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTA3T1NQU01CTXRIaVF0TmhsLzlDaXRZRDBsS1ZFTTNGQ2dXeVpiOVJsa3U1?=
 =?utf-8?B?WGlTNGw2YWNLU2FtM3llU3RjSVh6SnE2M3RjaGNDQ2QvYUhGTXRhakQ2by9p?=
 =?utf-8?B?MUNNaDVhbHJYQ1VWVjNOWklZS3U0b2RsSzFteExJTzNUWERkZEdXeksxV0d6?=
 =?utf-8?B?Q0tMeVdZVTVDMzRuQWNWZ2Z5aW5OcVF1MmVzdk5QRm1DOXZGTHZneXBkb1Ay?=
 =?utf-8?B?aFpVNUliZjFrUm5lVFpGOTdPL3ArNFVCV2VLVFZZZWhQOTlja2VQZkNzZW9D?=
 =?utf-8?B?YkhhTTZwK05jb2YxRzJ3NG03aWtJbnJIalcvYVQxbHIvS3hOeTM1ZXlNckxJ?=
 =?utf-8?B?U2xyK3l5ZS9CL0I2dUNJOVRJb2N3UmJuNGtwQ2QvK1cxcXB4aEIxckNvM0l0?=
 =?utf-8?B?Ny83Y2tkRW9jN3dPTU1sVUJhblVjcFFod1cwTnNvN3lnS1R3ZXZUVklwekY5?=
 =?utf-8?B?MHNVN2pteGZoRWZtS3BVNGhsenYrcTdTVk1HUWd6OEpoWVAzN0ZNUEFpdGw1?=
 =?utf-8?B?elAxUS9DUjJNaDdoVVhMWmpzaXZvVExsbWpReDc4dkVEbEs5UE5mbW9rS3dQ?=
 =?utf-8?B?Y1VNNFlNUE0vb016T0pFcFJ0dWM2RWdpQ25ZYkwyRWRzcVdFVm9YcDRQUmRY?=
 =?utf-8?B?VmFweVZjaUx1M1BIV3dka0VvMFNUbGJ4V2FpclNpS0JlYlBPOE5wMzZIU3Js?=
 =?utf-8?B?WTFEMjQvcWlJRlVmWURlSHJIbGVhdEJtby9UMjU2cTRXdWo4Q3hDVkx6NWVL?=
 =?utf-8?B?ZW9YL1N4cFZoTTFXOXZPTUFNVHBNVTFYRmlDSWorck54ejV6eHhuNnZDbEMr?=
 =?utf-8?B?YlJkZ1V6MTNqQm5sRUt1dWdKNXNjOXpnenp0Zm5HY3VmOVVPY29jR3BFU2F2?=
 =?utf-8?B?bjJCUWpxSHVpYnJIN1ZNck5zNlI2eTBNL3RJTk15a3pzb09VNHF4WEk3Z2VY?=
 =?utf-8?B?WkxKbTJCUTZVckkxelMvc01QTnBhOFZxZ2tGeUpDSFZCUnIvNXI3RGtRMi9u?=
 =?utf-8?B?M3htb2VFRG9XaldhU0ZXa0NZZHJCZ0JoakEvMU1aMGpBVUI2OVlkVDU5SitB?=
 =?utf-8?B?Ump6dXNOLzlkRUJLNWIrZGJSNHR2ZzhHTWwwZWd3L2ZoN2dMREVJU2I5SkJ5?=
 =?utf-8?B?ZzlHbmg3NzByNGc5T1ZaRnIxamlmTXkrODhmWUZ0VkJSYUJMMGdSdmhBL0hM?=
 =?utf-8?B?dmFsYnVaY1JIRFRjcUVlR2IvK09KQ1QzcmtRd1liTlZFa0xBZmdEenVRY0FW?=
 =?utf-8?B?cGJJellGeGJIOXdNanRIQ3h1ZFdyR2ZWbTJrTEV3TjFYdGk5WGVBVjNkUU5t?=
 =?utf-8?B?Q0REdHoxYllwRWpkanpJQW9iWW1zclNjL0ptM25Na1NuOC9UYUQwR3BiMjBB?=
 =?utf-8?B?Q3U5YTlTNTdSeGNMWUgwSWJvZHZBWE5nUmtPenEvQTZvTG5BUm9kYXF2Ukxv?=
 =?utf-8?B?aGJ2M2ZxdVlBQ1MxRUwwd0JOdGk1SnN2ajh5Vi9UdjRtVS83VWsxMXNNbmJW?=
 =?utf-8?B?UzZrRjBJVm45TFE4M2dOMCtFemlTOVBHZmpsVS9GMk8zdjFoZjR0eG12Q01K?=
 =?utf-8?B?bllYZ3hzVVBZb3RBVFZTS012SDI5ejlkSzE1QmNKOXcvSTcrbm9STlhNVGVO?=
 =?utf-8?B?SHpvRU1Vd24wcjRtTmJQMnlSbkphYWoxYjg4YjRmQ0JtWDRFNDNuYnFNSmg5?=
 =?utf-8?B?WmxTbzQrcy8wa0g1OFF3S3Q3MlFTR2YyQ0x2emhTWkhVS1ROeW4rTFFEVlpz?=
 =?utf-8?B?L1BVZmpMQkd5Zi9lbDlLbUd5Mnl1Y1FsNXZoQzJtRk54OUpieTJ1TEpMODMr?=
 =?utf-8?B?ZXBtZGgrOGd1MnpRZmF5cDlZaEtvZGpMdDVrTDdTMGpiWFNoVWRLRUNudklk?=
 =?utf-8?B?dVlKUUMxZkMzcFo4MjBJZHFCVENLc2UySEtOYkdhWS9ZRkFXWDVyMXhlTW9n?=
 =?utf-8?B?cVdSK1JPSXd5ejVLUDYyNmtxL1lCb0V3MGpRUlBrQTA4cmZqY1pBMzlyNlQy?=
 =?utf-8?B?K3FxWkxxSFpGbkN0VGpPZGJuZkJzeEl6cVB6WHB0ODhWSEJiTUU1KzVsdU8w?=
 =?utf-8?B?ZEdjaWpNNzc0VnhvSlF5OTRQa3ZxY1lSbERmS3FKbUNEbXBHNlZIRFRtY2d0?=
 =?utf-8?B?UjJabFR2dzhBaWZwdS9WY2VCaXp3SVpHcHhDamN0Y2FHWG02OUtiV2c0MUtQ?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18e7d28-c0a7-4709-9b55-08dbf7020d7a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:53:59.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /m/wAy0N+cOo+S/HNyw4PB3o7wgycu949FgU4hRHx9Q/fsCXuTTuxWXI/frFASmyHmKjrU0Vh8KqYum4RL3xLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649


On 07-12-2023 13:29, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Dec 07, 2023 at 12:54:04PM +0530, Manikanta Maddireddy wrote:
>> On 06-12-2023 21:06, Manivannan Sadhasivam wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
>>>> Add PCIe port node under the PCIe controller-1 device tree node to support
>>>> PCIe WAKE# interrupt for WiFi.
>>>>
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> ---
>>>>
>>>> Changes in v14:
>>>> New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
>>>>
>>>>    .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>>> index 8a9747855d6b..9c89be263141 100644
>>>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>>> @@ -2147,6 +2147,17 @@ pcie@14100000 {
>>>>
>>>>                         phys = <&p2u_hsio_3>;
>>>>                         phy-names = "p2u-0";
>>>> +
>>>> +                     pci@0,0 {
>>>> +                             reg = <0x0000 0 0 0 0>;
>>>> +                             #address-cells = <3>;
>>>> +                             #size-cells = <2>;
>>>> +                             ranges;
>>>> +
>>>> +                             interrupt-parent = <&gpio>;
>>>> +                             interrupts = <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
>>>> +                             interrupt-names = "wakeup";
>>> WAKE# should be part of the PCIe controller, not device. And the interrupt name
>>> should be "wake".
>>>
>>> - Mani
>> Hi,
>>
>> Please refer to the discussion in below link, WAKE# is per PCI bridge.
>> https://patchwork.ozlabs.org/project/linux-pci/patch/20171226020806.32710-2-jeffy.chen@rock-chips.com/
>>
> PCIe Host controller (RC) usually represents host bridge + PCI-PCI bridge. We do
> not represent the PCI-PCI bridge in devicetree for any platforms, but only RC as
> a whole.
>
> Moreover, PERST# is already defined in RC node. So it becomes confusing if
> WAKE# is defined in a child node representing bridge.
>
> So please move WAKE# to RC node.
>
> - Mani

Hi,

We can define PCI-PCI bridge in device tree, refer to below device tree 
which has 3 ports under a controller,
with PERST#(reset-gpios) defined per port.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/apple/t8103.dtsi#n749

Also, of_pci_setup_wake_irq() in below patch is parsing "wakeup" from 
PCI bridge, not from the host bridge.
https://patchwork.ozlabs.org/project/linux-pci/patch/20230208111645.3863534-4-mmaddireddy@nvidia.com/

If a controller has only one port it has to define a PCI bridge under 
controller device tree node and
add wakeup interrupt property, refer to below patch from original author.

https://www.spinics.net/lists/linux-pci/msg135569.html

Thanks,
Manikanta
>
>> I carried wakeup name defined in previous version, but wake seems to be
>> sufficient.
>>
>> Thanks,
>> Manikanta
>>>> +                     };
>>>>                 };
>>>>
>>>>                 pcie@14160000 {
>>>> --
>>>> 2.25.1
>>>>
>>> --
>>> மணிவண்ணன் சதாசிவம்
> --
> மணிவண்ணன் சதாசிவம்

