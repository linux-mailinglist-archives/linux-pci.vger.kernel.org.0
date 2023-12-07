Return-Path: <linux-pci+bounces-602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3F8081A2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 08:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D9E1C215F7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 07:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94114F9A;
	Thu,  7 Dec 2023 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dH56+sbw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1810CF;
	Wed,  6 Dec 2023 23:09:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyK7Lus4VNI+dT5DuVyV9qEt0/emoMFT9YlfWZTbZ88Xpo2DBki9r5rH6VvcsVRValsme2gQ/KoJbpkKXot2r24oWuw9Z4FfWiexm4Lw8nB2wtW3qsPkj1nbzzwDiD0IYnFhNCx9JHinR9+VpwboSTYh95Wh2ZAfrrE9+CdrorP+NfR7wICFV9E5NxZp5zHakk41ePBBUb6NIovEURKcz4gn3PsEwyyp7i+VdZVBafj7KQbBX/pLB7Cv2GOHTFajBETB5jttKeanbGUAbD4f2r73ZDCrZ2qlHMgCEZqHfcLBVq5DgMVAEExA7WEMb1McIcWkkHx3EUAoSKMD0K7yog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpBUvs/Z6BkQbcubKZinO+Z5TK7x6akX8x1erIe9b3w=;
 b=CavVukIxCcvxm6zbIrpcdcL3uT2aRS7HZDu78nGiZyqngo94Jmx/Ds/inrC1MXLCgIv0bsVx3ZscvVPn8ZCquFMEoUwj81aVEpFHYCRd5vf9zc79X6sDEiZpir91zMtCqxnbMGmcdQLg1xtLr0PO71xNkHQYfss5bcZbgTJErkobMXkMTlVvNc53nDGY9EUTvPZBErvgKcJG/w9gDZvNSTtutDJ1B2lPwld2ksKXCUNJnEEvY0K3XFbXhfgewqnYROEHl8siGOx1d26hFl8AaTVJ+Ev/NbHEzSMMTbQpWk8dvOOSGTOCMDP7hDtdtiF9dOsW+Y1mmkHgN9QxBIeC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpBUvs/Z6BkQbcubKZinO+Z5TK7x6akX8x1erIe9b3w=;
 b=dH56+sbwZYwa2YcBNwlZb9JTBcvGT7fhQlQBgsWoHKEQdyLiRQrMuOxiGZFmBoh8OPXfqPfMmaJWVulCppizcY2h/OU8K2IVXL8UoIv4tpcUAflY6jcqEhGrxpIwXp/lhWm2UDOM+Xnu59sPUoA3W+3c7/FWfYccebW1/WY5Ccvz1CxCn9XsKeK4uBMP01jIlw0U9g8f8Hbs08z1UZ/3G6OYudKsGFTXTPKcYZT+4jiNRhILj0C+ELW4BUedo3EWyNbsZB/neTd8/88iCwOmlui/n/zuVnDo7jVeSnZZHmnloKG3PNEB69Smn0lh4GmJwsHeEBdxRcj5e5QHOcGIcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.37; Thu, 7 Dec 2023 07:09:17 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::1a50:8e27:5f8f:7c4d]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::1a50:8e27:5f8f:7c4d%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 07:09:16 +0000
Message-ID: <557bae04-13c2-44ea-bad0-9589c999c2cb@nvidia.com>
Date: Thu, 7 Dec 2023 12:39:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC,v14 0/5] Add DT based PCIe wake support in PCI core driver
Content-Language: en-US
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 bhelgaas@google.com, thierry.reding@gmail.com, petlozup@nvidia.com,
 rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
 jeffy.chen@rock-chips.com
Cc: krzysztof.kozlowski+dt@linaro.org, jonathanh@nvidia.com,
 dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
 gregkh@linuxfoundation.org, steven.price@arm.com, kw@linux.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, vidyas@nvidia.com
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <feee5e5b-565e-8575-2bbe-61b35fa8f1dd@quicinc.com>
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <feee5e5b-565e-8575-2bbe-61b35fa8f1dd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::27) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e78989f-bb83-4924-5770-08dbf6f36cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m/AxCIQO2qXMEhY3JA6gVIaOClItHz/fk+IEJM/KvYP8N1XJzwWKGMJTpbqv3QmjwQmBuwvoSwchsFNpO42H0Uj0d1tmbAnBt9EVye4GWrU0L0c6uyrK2vI8KrvQAJ2HIFgncrwmOT3Ifmxgpl2iJ+tMWluGXRxamJqONUVstH7l6/Q7aG1TX/vFkft9lDnoVrkH1fNG8wecrTuZbi/PuIOm+d4eB4TbshM7u1yPGtdc2zkqKsO8rVs77xQCXq+XAsPIqadrUa1nhUs1S+lzqYUjhtOHU6+mHr4B3NdLRaqwTJJ0ZoEpG7cFZJrxpBj+OuXCbEmyenCg89GErD7Al6LqFXiEeekPmVD0WkRgcEqrkbrOsaKZQBvNiMqRmvtPm0Q9Kmps7HVhakvGB68F1Z0eS8jTL/lfPlt4cMrHzZkZZjt2DE09BjZIRY5NOnklumNA1b3ddYo7jhHFkp6QkPesVoj2N+tAvBCA0+b2yDFM70mny+gID0mG1xGS8YRmOqVfWkhnGQjRi8ncYuYCDQDxtu/5PJgFGyP/O1ppbPXDefuD5zVR1UDisQcB3Iz6PgkGJ4BOEhsIQiIRpfa6YIJPGdjVtb/qM6XJWbPzq/rxikPJkL2l/ChhR3Um/awnAKHNkJKIvBdgDeC0rhEfVMyoYeEm/jHzLsHXpbsBfV5niFPZk8WPzXGqsAUgcGY+a+dDXW0ySs+/V+xvesZtMkSrVoYWzmEfuweJTVfh668=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(86362001)(36756003)(31696002)(5660300002)(7416002)(2906002)(41300700001)(83380400001)(66556008)(66476007)(66946007)(316002)(478600001)(6666004)(966005)(6486002)(107886003)(2616005)(26005)(53546011)(6512007)(38100700002)(8936002)(4326008)(6506007)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnZTcVB2aEJyWHV2a1BRb1d5YjdKSElReEpMK2ZqWE85Y0ovZWhQVjR1Mmph?=
 =?utf-8?B?SU1EOFd1RENXMmthTU9xVGhTaVg0c0xzUUVNeVB2Z1B2TzBsTHpuL2tXb1BP?=
 =?utf-8?B?MUhDYld4THVOcFZ1Y2NVUjI1OTRwdmVzL3d4eWhjYTVYTTR3MncvYnNCbFNY?=
 =?utf-8?B?bXIwY3plSGNwU2ZrVmIyQmMxZzV6T2JhUUI4NGx0MHlESjRIdkh4akFBQzdZ?=
 =?utf-8?B?SWxRYVk3dlBmalhvREo1SHRyWCtHSTQzdWozQ283dG93WlJTRVlUK0FuK1lH?=
 =?utf-8?B?NlVkSkdXK1ZkMmQzckRqYUthQlpBUmtKVnpQbkVlVFFVTHdhc2NuZklEN2lO?=
 =?utf-8?B?OWovNWhTKzM4cWc5VUdiTXVpaWRscEFHTFZFa2RsQjR2TUIveG9keG9wd0ZK?=
 =?utf-8?B?WW5vMzRRK1BKUkx0YXpTTlpUcEcxcUhYQWMySk4ySjJUK2I5TThnU2JKb2dR?=
 =?utf-8?B?VndiRGFGTWR4dWFmcVdZdXB3aDQ1UExrcndvMVh4dyt0QTdDTjN0MDYzaEh2?=
 =?utf-8?B?RXZJNnZrblQyTUJnSkNGQUowUkpZQTd0RnI1TGJ6NzZIc0RNK3dkMU1pdjRl?=
 =?utf-8?B?VHFjM1BNWThYekJORmdRUFExcFN5d1VZaVlINEVQSStkTUtKeklLWWFwRTJW?=
 =?utf-8?B?dHkxUmRQY2gzZzNjU3JGSE9EMGdkUkRlYzVRRGVVYi8yVHIzem15dlpRTU5L?=
 =?utf-8?B?Yk5DM0dGL3c5dUZ3cmJqbXBWTktQSTduR01ITTRNT3phTlNLNVFzTis1NjB3?=
 =?utf-8?B?L0RUdTQ1WFNpbG5zSURYL1NOdmp4TlZsY2k5TUp4UlBiWXRLc1hOS2pvRnhN?=
 =?utf-8?B?TlJqNG9FcS93N3g0UkJXSEJyc0NFWitkVkVzM1VvWHJDemhXdFBBa1ErYURK?=
 =?utf-8?B?ZFFIVHBxbWVJcXJ6U1pjMnhlV3pWU0E1VjliN29ERVRHL1AyaXI1MEk2MDNy?=
 =?utf-8?B?akN6cm9NM090UjBZMWZqSmRpWXh3L1liRUJkQVR1dkp0L3p0aEVzclIxTTdv?=
 =?utf-8?B?S0k3WHJnc1NRN0plZjlaWmhJY0IvbmowWFVzbHRwQTZHVUJYa2h2VHRVQWpV?=
 =?utf-8?B?WGtxYnAvaWtmZWV0aXVOWHErTVVFdGhsSExseENySXB4djU5WUM3UmVsVVZz?=
 =?utf-8?B?RVhKeEZ0a0RYdjZTQTNCRHQ0R3ZhYnZZTG9JcVpIVUlCOXZxQVNIYm8rdkhI?=
 =?utf-8?B?Rm11cU4rOVI0RUk5M0NNYkVTTHZ2eDZvVFd3WkE3VGYybFJ0cEZhZnBtS2dM?=
 =?utf-8?B?UHRwYi9hbU9tUVpVS053cmFuaTlmUzloVXVyZk9jTDRuU3k5ZXBkaE9JenNB?=
 =?utf-8?B?S3BtRG95WmVlaEJuRCtEaGdudVQ2Qk02SGpnRFRWaFpKSU1XQ0VKeEVFRzBS?=
 =?utf-8?B?NjdKR0paUTVUV3E3d3orOVc4Tnh0eVdaRG4xWXlSMi8rVzB4T3Q4QWNiaExB?=
 =?utf-8?B?T2hKQVpIT3ZvMHI3UE9hc0Z1bUVXTmZGa3pyN29Kb0p3bU92Z0RIcnJUZnhO?=
 =?utf-8?B?OTVNZUZaOGN6a08vRUJKR0p0OTA0bmVGMGJLdWFhY3Y3S3Rkd09tZkIzbGEw?=
 =?utf-8?B?TGhlVHlsT2tIa3AzVHAwMFFDdFRJSTM2a3dHNWFKeWQzZ3hxYmtsMXFsRjVV?=
 =?utf-8?B?QS9nZ2hRWWw5U1NkZStQZnVsS0lUNWdGWnp1RkZYaHkzdUsrL0k2UG1Cb3Iy?=
 =?utf-8?B?MGVUZ0F0amhZTkwwZFB3dVJrSExITGhvWHliWFhYWEZsSkdZQVNWY3JUa04x?=
 =?utf-8?B?NjVEQmhEY3IzYTlpNWNCU2RJbTdiMEdKYzEwNXlUQnNoNTRRUTBlQzhCa1du?=
 =?utf-8?B?bVQvUlczRXJTYytBYzFHeXlHdDFjUTJiU2IwS0RZa3k3djl6ZFRZVFpWamZr?=
 =?utf-8?B?N1ZtcmJpTkp3NmRMbEdDYzFkazJvSDU5VkdIZ1M5bFNDTXdjUGhXKzdVT0Zk?=
 =?utf-8?B?emZZSG1uMWhFbm1STkFuYVRnRnBQMENwM3BsYXB6bHErTFMxd2NnSFpTdURh?=
 =?utf-8?B?RnVUeEVuNGRtNnBURnhGY3E2Ukk4NHlnVURUdlZqYlVsNWtyaUc2QUIwWU04?=
 =?utf-8?B?S1NMZzVFZk1VaHhhZG5GRmhEanNCcjJYaVZIMzhSQVFBUFlMVFlmNFVTWm9U?=
 =?utf-8?B?bEpXU3hPTFdxck1QSEU2V3hxRldQODMxbGM4VWN5eWhaNFdtL2ovQU1PQng3?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e78989f-bb83-4924-5770-08dbf6f36cb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 07:09:16.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BKykmKhyE989EnSA00+IlaxHQozJ4tRUY7pB0sqEn+fJxsezPJTrEhx0IEPOV4RiJCdkvjdxfv9VB6zL3rtKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367

Hi Krishna Chaitanya,

Unfortunately I cannot follow up on this series now.
If you have a platform with same requirement, please verify and publish 
new version.

Thanks,
Manikanta


On 06-12-2023 20:14, Krishna Chaitanya Chundru wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Manikanta,
>
> I don't see any update on this series after comments.
>
> Is there  any plans to take up this series.
>
> Thanks & Regards,
>
> Krishna Chaitanya.
>
> On 2/8/2023 4:46 PM, Manikanta Maddireddy wrote:
>> Below series [1] attempted to support DT based PCIe wake feature in 
>> generic
>> PCI core driver. This series was left at v13 and final comments are not
>> addressed. I am continuing this series from v14 by addressing all 
>> comments
>> in v13. I dropped rockchip device tree patch because I don't have 
>> hardware
>> to verify it. Instead, I verified these patches on NVIDIA Jetson AGX 
>> Orin
>> Developer Kit and included its device tree changes in this series.
>>
>> [1] 
>> https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/
>>
>> Changes in v14:
>> Updated commit message for DT bindings patch to reflect that DT 
>> properties
>> are tied to PCI-PCI Bridge.
>> Addressed review comments on PCI interrupt parsing patch.
>> Dropped rockchip device tree patch.
>> Added Jetson AGX OrinDeveloper Kit device tree and Tegra PMC patches.
>>
>> Changes in v13:
>> Fix compiler error reported by kbuild test robot 
>> <fengguang.wu@intel.com>
>>
>> Changes in v12:
>> Only add irq definitions for PCI devices and rewrite the commit message.
>> Enable the wake irq in noirq stage to avoid possible irq storm.
>>
>> Changes in v11:
>> Address Brian's comments.
>> Only support 1-per-device PCIe WAKE# pin as suggested.
>> Move to pcie port as Brian suggested.
>>
>> Changes in v10:
>> Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
>> since dedicated wakeirq will be lost in device_set_wakeup_enable(false).
>>
>> Changes in v9:
>> Add section for PCI devices and rewrite the commit message.
>> Fix check error in .cleanup().
>> Move dedicated wakeirq setup to setup() callback and use
>> device_set_wakeup_enable() to enable/disable.
>> Rewrite the commit message.
>>
>> Changes in v8:
>> Add optional "pci", and rewrite commit message.
>> Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
>> Rewrite the commit message.
>>
>> Changes in v7:
>> Move PCIE_WAKE handling into pci core.
>>
>> Changes in v6:
>> Fix device_init_wake error handling, and add some comments.
>>
>> Changes in v5:
>> Move to pci.txt
>> Rebase.
>> Use "wakeup" instead of "wake"
>>
>> Changes in v3:
>> Fix error handling.
>>
>> Changes in v2:
>> Use dev_pm_set_dedicated_wake_irq.
>>
>> Jeffy Chen (3):
>>    dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
>>    of/irq: Adjust of_pci_irq parsing for multiple interrupts
>>    PCI / PM: Add support for the PCIe WAKE# signal for OF
>>
>> Manikanta Maddireddy (2):
>>    arm64: tegra: Add PCIe port node with PCIe WAKE# for C1 controller
>>    soc/tegra: pmc: Add Tegra234 PCIe wake event
>>
>>   Documentation/devicetree/bindings/pci/pci.txt |  8 +++
>>   .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 11 ++++
>>   drivers/pci/of.c                              | 63 ++++++++++++++++++-
>>   drivers/pci/pci-driver.c                      | 10 +++
>>   drivers/pci/pci.c                             |  7 +++
>>   drivers/pci/pci.h                             |  8 +++
>>   drivers/soc/tegra/pmc.c                       |  1 +
>>   7 files changed, 105 insertions(+), 3 deletions(-)
>>

