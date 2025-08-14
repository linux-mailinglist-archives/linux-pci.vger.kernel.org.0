Return-Path: <linux-pci+bounces-34016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E1B25907
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 03:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069245A23A2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0415746F;
	Thu, 14 Aug 2025 01:29:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023079.outbound.protection.outlook.com [52.101.127.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E515E5C2;
	Thu, 14 Aug 2025 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134998; cv=fail; b=u6yhQWff2Xdg27s52+LEBE6rpA4IvrZcHD0xL4SGhCEtBdetC//8JwnJweo0h83fG3o7nbtEPDPuMNKIOqgqbIWmHCv1PNKvO5MIqouW3Q5v6AtXVcrQ4IhzIiMgAcVJLVr7ajjQLRsHRRjxDkAup0InF0Tq6Wj9GaVk6oKRx3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134998; c=relaxed/simple;
	bh=ptQo96hpOtnGgZAeaNRUaZNJTG58oIvnSjWxWyCvjKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrCoc2Ldhq2QixZowZ24rAgYc8vOf+XP3mxTTvTlMVD8VUBG31GboOvhY668b7QJoAoJLH81HOLHYIAuCgLMxaY78ANgB6xUD89Mrns3RLjdqE4E/6WuYtNiJ9xXnQxDRYVrcIZOUCcxKbGRXjMj84xaA2uVHyzyvErprtlpp8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnvPq5T5sUpxkiY+9ueIe6grBqLkFIY++w0WtbnVeWyc+xW8X4fYwTc9z0fadIfhabjBRv8wiNKRSGvvaUKj+GF5+37ht7hZYkDEr5iDj6WIJFNKTjVHlM5cPwiAMwGdozuWRlGmoqYd6J0aVQJOfJlU46IQiB9fwTd7GgXwl8ipI+GMCT+khCa7A/8H2aplJwR1lvNTRZ8XoFbpeEhr6xi7vADtcZD0NXidad1kEs+sTk8W+FATlfKyThNZcCBpXy/BY/GDezzLaEQ4d5P9BkhI58Da0Rq1h/CU4ANCb+fWwE4/vPIaIwbRV+EVKyX1AdDfrcyH1qyx7ACBw7WOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNwd/QRMBAqmiGeN+XARuaw1UOVS2v8ZYplUkTmZcp0=;
 b=JRfywWdctZjpYmp69ZuOkpshzkFxxGOgUMLuO2f04M2WCWVCKK245jzEEGox7fvmf3Crg8IBJ42A9sKfHj5K1KpMmLIAUutTq0VTjCbRHTbbYdneXjx1BIHGOrTgZXg+lsvZcbFp0U7SLE0QZXHbK7xFN5RDMeP0dFmr9C18Q2x6jtaeTtOw98AaiwWZ5UQWmbTboz18BuSGXRH+70+Q+BP8gERmfSr19NsTQCd8J+1ivGxUcuiZ8hqSbWe5b3wQEC88UV1sEmKwArZmYAG/VZW9O71FDVEV1PTU++mUNBwtvDzf47VNEbgHXmu9XYVGYTGLJU0jYCZB+EpC4Z8hhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0091.apcprd02.prod.outlook.com (2603:1096:300:5c::31)
 by JH0PR06MB7199.apcprd06.prod.outlook.com (2603:1096:990:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 01:29:48 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::6f) by PS2PR02CA0091.outlook.office365.com
 (2603:1096:300:5c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 01:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 01:29:46 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6FA1344C3CBA;
	Thu, 14 Aug 2025 09:29:45 +0800 (CST)
Message-ID: <c05f3e8b-b205-4d6b-8423-23edbfcc9f2b@cixtech.com>
Date: Thu, 14 Aug 2025 09:29:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/13] PCI: sky1: Add PCIe host support for CIX Sky1
To: Krzysztof Kozlowski <krzk@kernel.org>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
 kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
 peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-11-hans.zhang@cixtech.com>
 <beaa6802-8abe-4cc7-a852-8ecbd60a536c@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <beaa6802-8abe-4cc7-a852-8ecbd60a536c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|JH0PR06MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f36768c-18ea-47f7-9086-08dddad20dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3dGNmFqalZ4bjVLL0VPeTVaMTdTRnh2WUc0K0RrVmRaOXBZNnlMWDh3R0tm?=
 =?utf-8?B?eExVbWozOVdiTjJRRzIxZStlSGl4L2xXdm1XbmloYjkwOTc3R3JZeEZXaTZK?=
 =?utf-8?B?QzFJajJsVDVIREF5bmFkUXl5UVErSm1CemVxcmM1ZC90QmxVTFRFNUlCMWVv?=
 =?utf-8?B?cTFocnF6KzRkVG9Vd3lFOHVqa3EwZ3hSWlArd2Mxd0FVcmdUdE9FaEZGODlk?=
 =?utf-8?B?T3JrUi93dnBCRUQ3SEtldkRYdzFEeStHWlhsRXV3OW5DbTBGZ2NaMGJnYnRv?=
 =?utf-8?B?VHdLTHNBZG81Q1BRODlrV25zOHZ0YTI1b29PMW0yY1l1eTdheHhlL0Q5bSsx?=
 =?utf-8?B?QXpGcTBlTlhFb2FWRVIrWXFJSjlYYnhHcHNlQmU0K2cvcC9Kb2duNlJhWHY1?=
 =?utf-8?B?eHVBYk5GaDZKdFoyVy9PZnlkY1BIdGtoeWFScm9HNWZFekVoTUtSOTBTNHJw?=
 =?utf-8?B?UU9oSnd6c3I2MGxiSmhudVVaVXF0VTdwMHpBMjZicVNUWThqaFE0T0VhdWdM?=
 =?utf-8?B?d1VydEJIR3JCRHFidG4rYjdHNExwczBOcGFuN2N2a05oc1g2cHZ1ZFB3Qlla?=
 =?utf-8?B?cUtaSGJaWDA2T1BjbnJzeEFEMjZjeGUvc2J4NzhXU1J3ZzdubkhjSk55R3do?=
 =?utf-8?B?ZWtINElaaUF4K0ducVVtN1FPRVVDUW9tMEt5VjNCc2hxaGdhbFpaclg3dmVt?=
 =?utf-8?B?SzVWVnlRTFlBZ1RXMW5kZm5wQ2JNc1BncTVFdWU4ZmZYd2RwYitDZUczMlZ6?=
 =?utf-8?B?RHdFZFVnWTNxRHkxNy9aeEN0TnlUODdzRFd1MFNkdWpneTg0bmJEWG9qOC9t?=
 =?utf-8?B?MnlOOThOK2RjMm8wOHJLeVNxTW5LeEljUE1iTHZHSklmZ1lVVk9PMGpydzFO?=
 =?utf-8?B?RnpUZTVacHgvM3BJbEVNTnExMW1TV2dQbE5wU2gzdzNOY1JFcTJNcGtYS1lM?=
 =?utf-8?B?R3ZPWXpyMFk4MXZZT00ra2ZmSGNSL0NyNnlldERnSnI0OS9pdDRrb1Q0bkcv?=
 =?utf-8?B?QlltTldYZ3RQRGRta2ttbEc0dUNPejFLaHl4NWFnSEVlSkJ2eUczM2NUVGQv?=
 =?utf-8?B?aVUrbEJKQ1BYNEJzRityclRibEJNb0lIeHd0MUpnelFHTTdqZXJJalowQlBY?=
 =?utf-8?B?OG1ZWEs5Sm1aWWRaTVRFU2Nvbm5iaXpWeHBiZ01DSUlnRzVJa2wzZ09IWDdI?=
 =?utf-8?B?OTQ3bGpUaDlwL3o0RlZMbUUxSHdBZzBJcVM2ZVhzSElxTVdUQUljQXArNFVt?=
 =?utf-8?B?aS9GQjJteHViVmRyWnJIZk8xZ3dHMTlqRCtnV2JEcitlY2p0ZVNpbHhlQ0g3?=
 =?utf-8?B?YURacFFQbnd6ZllvOWJwVVEvS0RkdDR0eGVOeGs3RC9DQUFNVWlQdHluUE5R?=
 =?utf-8?B?VHU3MHFJTVRrVlg2R09sOE81WW4vUHZRN0FzUnRFRnh6S29KQ3cvL0d6YVQy?=
 =?utf-8?B?cUd0TXRXbU1McHNiU1ZVUTVwbnhOQldjZnBVYnVLODJqdE5Fd0dUMHhJNU51?=
 =?utf-8?B?K3l2R3lkS1pVbTF1MGtVY0hnL2twSFN5anphUEdyZmFibHpVQ05vM3N1eC8r?=
 =?utf-8?B?TEN5TE51Z2ZWUXZxK2ZHQ3FrSTRhOEtOU1FsMVhWbGppdjArUDZ0TU1yWnI0?=
 =?utf-8?B?cThKbUNxVFJWMjM2YnJhK3pVdnNsZFF4NkpGbk03Y0Rlb0NlZjBsR1N3SDF2?=
 =?utf-8?B?NDFGNDBqQ2VMb294c2dnTWVKakI2NHRpa0xSVm1WalBxZWJQUmRMYVcrWlFS?=
 =?utf-8?B?bllUcnYzNm5PczkxbWFSSTBnZjNpQXlTMGdWdVJ0R1NNcGZZQkJ1TDg3VDV4?=
 =?utf-8?B?dVFlSWo2UzVITGExamlMQ01CSngyZXM4a3gyamZIL2d4THlCSFBQaUU4YjYv?=
 =?utf-8?B?THp6dnkrRnNWNDkrZWtrNDVMQzFZNmZTZlNUMTl3L3kwWHRaNHpjUFg4a2pY?=
 =?utf-8?B?RE9NZlFjVkNaajJLVWdTQ2UzUTNkVHBXdW02R3MzNGsvQzEwcnFpbEI5Mm5P?=
 =?utf-8?B?MTJ2SUtnM1VKaEpXV2ZJY1pib0FHM3BESTZrMmpxQk5BY1pkaXVPYUNESFll?=
 =?utf-8?Q?HVEc1N?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 01:29:46.3594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f36768c-18ea-47f7-9086-08dddad20dc7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7199



On 2025/8/14 03:16, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 13/08/2025 06:23, hans.zhang@cixtech.com wrote:
>> +static int sky1_pcie_parse_mem(struct sky1_pcie *pcie)
>> +{
>> +     struct device *dev = pcie->dev;
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct resource *res;
>> +     void __iomem *base;
>> +     int ret = 0;
>> +
>> +     base = devm_platform_ioremap_resource_byname(pdev, "reg");
>> +     if (IS_ERR(base)) {
>> +             dev_err(dev, "Parse \"reg\" resource err\n");
> 
> Syntax is return dev_err_probe, and without \" so grepping works
> correctly (see coding style).

Dear Krzysztof,

Thank you very much for your reply. Will change.

> 
>> +             return PTR_ERR(base);
>> +     }
>> +     pcie->reg_base = base;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
>> +     if (!res) {
>> +             dev_err(dev, "Parse \"cfg\" resource err\n");
>> +             return -ENXIO;
>> +     }
>> +     pcie->cfg_res = res;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rcsu");
>> +     if (!res) {
>> +             dev_err(dev, "Parse \"rcsu\" resource err\n");
>> +             return -ENXIO;
>> +     }
>> +     pcie->rcsu_base = devm_ioremap(dev, res->start, resource_size(res));
> 
> Why aren't you using wrapper over get_resource and ioremap? Isn't
> devm_platform_ioremap_resource_byname exactly what you want?
> 

Thank you for the reminder. Will change.

> And if argument from previous versions was - you need to backport it for
> ancient 3.10 kernel - then it would be a no go.

Ok, will change.

> 
>> +     if (!pcie->rcsu_base) {
>> +             dev_err(dev, "ioremap failed for resource %pR\n", res);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
>> +     if (!res) {
>> +             dev_err(dev, "Parse \"msg\" resource err\n");
>> +             return -ENXIO;
>> +     }
>> +     pcie->msg_res = res;
>> +     pcie->msg_base = devm_ioremap(dev, res->start, resource_size(res));
>> +     if (!pcie->msg_base) {
>> +             dev_err(dev, "ioremap failed for resource %pR\n", res);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int sky1_pcie_parse_property(struct platform_device *pdev,
>> +                                 struct sky1_pcie *pcie)
>> +{
>> +     int ret = 0;
>> +
>> +     ret = sky1_pcie_parse_mem(pcie);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     sky1_pcie_init_bases(pcie);
>> +
>> +     return ret;
>> +}
>> +
>> +static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
>> +{
>> +     struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
>> +
>> +     sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
>> +                                   0, LINK_TRAINING_ENABLE);
>> +
>> +     return 0;
>> +}
>> +
>> +static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
>> +{
>> +     struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
>> +
>> +     sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
>> +                                   LINK_TRAINING_ENABLE, 0);
>> +}
>> +
>> +
>> +static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
>> +{
>> +     u32 val;
>> +
>> +     val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
>> +                               IP_REG_I_DBG_STS_0);
>> +     return val & LINK_COMPLETE;
>> +}
>> +
>> +static const struct cdns_pcie_ops sky1_pcie_ops = {
>> +     .start_link = sky1_pcie_start_link,
>> +     .stop_link = sky1_pcie_stop_link,
>> +     .link_up = sky1_pcie_link_up,
>> +};
>> +
>> +static int sky1_pcie_probe(struct platform_device *pdev)
>> +{
>> +     const struct sky1_pcie_data *data;
>> +     struct device *dev = &pdev->dev;
>> +     struct pci_host_bridge *bridge;
>> +     struct cdns_pcie *cdns_pcie;
>> +     struct resource_entry *bus;
>> +     struct cdns_pcie_rc *rc;
>> +     struct sky1_pcie *pcie;
>> +     int ret;
>> +
>> +     pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> +     if (!pcie)
>> +             return -ENOMEM;
>> +
>> +     data = of_device_get_match_data(dev);
>> +     if (!data)
>> +             return -EINVAL;
>> +
>> +     pcie->data = data;
>> +     pcie->dev = dev;
>> +     dev_set_drvdata(dev, pcie);
>> +
>> +     bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
>> +     if (!bridge)
>> +             return -ENOMEM;
>> +
>> +     bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>> +     if (!bus)
>> +             return -ENODEV;
>> +
>> +     ret = sky1_pcie_parse_property(pdev, pcie);
>> +     if (ret < 0)
>> +             return -ENXIO;
>> +
>> +     pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
>> +                                 &pci_generic_ecam_ops);
>> +     if (IS_ERR(pcie->cfg))
>> +             return PTR_ERR(pcie->cfg);
>> +
>> +     bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
>> +     rc = pci_host_bridge_priv(bridge);
>> +     rc->ecam_support_flag = 1;
>> +     rc->cfg_base = pcie->cfg->win;
>> +     rc->cfg_res = &pcie->cfg->res;
>> +
>> +     cdns_pcie = &rc->pcie;
>> +     cdns_pcie->dev = dev;
>> +     cdns_pcie->ops = &sky1_pcie_ops;
>> +     cdns_pcie->reg_base = pcie->reg_base;
>> +     cdns_pcie->msg_res = pcie->msg_res;
>> +     cdns_pcie->cdns_pcie_reg_offsets = &data->reg_off;
>> +     cdns_pcie->is_rc = data->reg_off.is_rc;
>> +
>> +     pcie->cdns_pcie = cdns_pcie;
>> +     pcie->cdns_pcie_rc = rc;
>> +     pcie->cfg_base = rc->cfg_base;
>> +     bridge->sysdata = pcie->cfg;
>> +
>> +     if (data->soc_type == CIX_SKY1) {
> 
> 
> Dead code or rather if (true) code. Don't do it, it's more difficult to
> read.

Will remove.

> 
>> +             rc->vendor_id = PCI_VENDOR_ID_CIX;
>> +             rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
>> +             rc->no_inbound_flag = 1;
>> +     }
>> +
>> +     ret = cdns_pcie_hpa_host_setup(rc);
>> +     if (ret < 0) {
>> +             pci_ecam_free(pcie->cfg);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct sky1_pcie_data sky1_pcie_rc_data = {
>> +     .reg_off = {
>> +             .is_rc = true,
>> +             .ip_reg_bank_offset = SKY1_IP_REG_BANK_OFFSET,
>> +             .ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK_OFFSET,
>> +             .axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON_OFFSET,
>> +             .axi_slave_offset = SKY1_AXI_SLAVE_OFFSET,
>> +             .axi_master_offset = SKY1_AXI_MASTER_OFFSET,
>> +             .axi_hls_offset = SKY1_AXI_HLS_REGISTERS_OFFSET,
>> +             .axi_ras_offset = SKY1_AXI_RAS_REGISTERS_OFFSET,
>> +             .axi_dti_offset = SKY1_DTI_REGISTERS_OFFSET,
>> +     },
>> +     .soc_type = CIX_SKY1,
> 
> You have only one device variant, so this entire pcie_data feels redundant.
> 

Will remove.

>> +};
>> +
>> +static const struct of_device_id of_sky1_pcie_match[] = {
>> +     {
>> +             .compatible = "cix,sky1-pcie-host",
>> +             .data = &sky1_pcie_rc_data,
>> +     },
>> +     {},
> 


Best regards,
Hans


