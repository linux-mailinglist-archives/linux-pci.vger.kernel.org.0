Return-Path: <linux-pci+bounces-1616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13282282C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 07:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA111C22E20
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 06:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F64A14;
	Wed,  3 Jan 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jqm5mxAe"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53D1798A
	for <linux-pci@vger.kernel.org>; Wed,  3 Jan 2024 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAr1C+0EJe39JOBvWhOiCTrSdbtmOwnewiwvJUZhzNboIpLfPX0bvQaA+20d7sMayJNQrhlPIScmHyQLvPrpcv2s+oYAbkBvQRUugrFGRxA6FIqqkfZ4XICbZ8bpDov6F5Fmh6JQ76pBdCzA6EnUFAT62k6BZ4zYqgc12gFH62pSfUS2wXJzpFSyqCgX4dfimzSPWg4WSt0rm8vBTido3djukAD2miATfuxp9XVqQiopMxxz5jNd9MV5NZChgDy92/Wfhp55MI9clOefirkHuIM9Rsg+So3SPc9Tahzphd9un634g2bpUenve/UYJE38p6cEZqnzXR0wBqF3UY3c2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bL/zSjhXjfJkkMFK36v8qGiumu1GtIf5++BF9UBEKuM=;
 b=JvVvU9/NFeWZMTkqEyr5sqz/6ic5IFbfUsL7oUeJ7uc4JZ07QQPf9F1pgPV8RuSzE7bKOu0J3/TSxPZ8hBMAU6bOiifZVDy0rUp3mxEbXr0JvpsJxe38tA/1FP+xq8YZh5YJ3ErXTOYRhwx0Hqlv170lQ8QSwjjuJhzO8oGC8gtgLOpiBO7/mjtRn4+vDikX5wYLkIleH+mIGg8Qx6K4FdFCqp/fM8f9Lr/hGTEc6wGPsbxgEYzhCbF7QTbnnPZm1toYtQkFIQWiKNBsQMdLGvuVQPdkuWuQcEnJ2Mx402gf1yp8ghH35StrHmb0t2V11FjLEYTmviHxRmgDsKP9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL/zSjhXjfJkkMFK36v8qGiumu1GtIf5++BF9UBEKuM=;
 b=jqm5mxAewk4VnbsDomDKui29DGL3vqNypLPNqZpK+rZRm2DhnHkWn1c0guWuKTOD/6NhHgn445688LspD6GNcttPzPz2Of04SMeooRMHGU5bybqo7H3D7I5o1HyTZoMhHZebyRbGmMarhetdAop9775OPGs9Z9liLGPf4/eia4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:03:45 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::4821:25c:ab91:94f3]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::4821:25c:ab91:94f3%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:03:45 +0000
Message-ID: <9b6360d7-8880-f522-b368-3ca3b1694cd3@amd.com>
Date: Wed, 3 Jan 2024 11:33:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
To: Niklas Cassel <nks@flawful.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
References: <20231128132231.2221614-1-nks@flawful.org>
 <20231226221714.GA1468266@bhelgaas> <ZYwRK2Vh5PLRcrQo@x1-carbon>
Content-Language: en-US
From: Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <ZYwRK2Vh5PLRcrQo@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::14) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 62517e74-43da-433e-87d7-08dc0c21beb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8I242c+yUmC50wvr/NXo2mMxR0QhQXIt6ktygbSDMe6r/n82jmQfqFIttK46cCLj7TY0ba4u5NscXayX3L9ABmpCzMiZR4KL4WQANQAeSaEBL1QlYVXVir8Mo/1Yp6HEv8ojAh8DIr6/inrOBiQ97PZJGvI/2aO0Bvrq5U4Q9fpLL55bz/m9Y748udGVO/sW9FeAQ7By8ea7bzivtxTWbGGVGEzvbCor4klZuqrX/GXHZvOOwO9QeKFEbeiyRk+99RZRqWizpmk5yVB0my/dYYXiICIB59/HyRFk1l8MTnlILbOyP9+u05nA0E7fXfrTEb5FA1INDQwbcXHXdyV3eo9Rvu+gdCgStpvI5+C5OqfZInt3CuEX1YALKirfK8eFWrh+/IgfFtCc38qakDR/5KPrp5N1yPBGsApmeRIQ0JgKWxDVf7x39aMtHBH23uLyo1sQyVjr3B/XC7Kr+ImqmCm8RZdPA/kJTSXwi0fREp9kjSNMpWfLDSgE9Eel7hVYCkRSZyX/skhYeMCXZ20GREj3PAWdtn2sMMRJ/Ln0XVcB2s+Agp5eaqpo9ercaCOwNmaJBNe1qtPHfpMcGCyhaP0SZIadEiMwNFwRFsDOelpfkHthTqad4jZSafCM6KZWG/ByCrimYQabH0/BJunwFrMtOaQUs8T16bcO+m/ptM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(2616005)(66556008)(38100700002)(66946007)(83380400001)(110136005)(36756003)(66476007)(316002)(54906003)(478600001)(31696002)(966005)(6486002)(5660300002)(2906002)(7416002)(31686004)(8676002)(8936002)(4326008)(6506007)(6666004)(6512007)(53546011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzVhVEhxeE13SDF4REJ0ci9ZcjBZS01mZzZvcGhzb0EwenZ1WU9HTmh5ZFBO?=
 =?utf-8?B?ck1weXIwVk5TdzhXOFpkeTByZnRPZVZDZElkSlhNR2wzT241Uy82eU9nUlRC?=
 =?utf-8?B?aTNYQW9zZ1VzUmFhK3M2OTNPd2Y5Q3NPclpEM09CbGI0RmovWDB1OG9mZEFH?=
 =?utf-8?B?UzhOaE8vTVZhQzd5L0l5dzV2ZlR3V2dLZW52QzhnVS9qbUp1VmxXU3BmSFU0?=
 =?utf-8?B?UGxtQjBpdjFsRllxaC9YOVpINW52c1FqaFBxSFkrTmpYa1F3OG9Nd09qQlRB?=
 =?utf-8?B?ZkhYd1hIVFprRzczc3lScFg3Yzh5TlladE8reWhvQXFqNHcwdDdTNTBWaXdR?=
 =?utf-8?B?d2I0eG9pVVEyeS9wL29Tbitod0QyYlN6S3N2UENFSTk5NG1sT2Y3bTcwU1hZ?=
 =?utf-8?B?U3NTRGwzejR0MGs4d3hKN2toVjQ0bllrd3ZESnBkQllFbS9CVjRSUTBGbVlR?=
 =?utf-8?B?aXo2Mk4wRTdTZWZNcUF6b1lJdjRpVU52L2x1L2JOZFl5OFlwWXUvc0FQVmNv?=
 =?utf-8?B?Um5BOWhta0RUeXFxQU9xZW11ajlOV2swR0dPVkErZXorOExHb2poR0lJdDB5?=
 =?utf-8?B?WVJQVXhxaHV3SlA0eEJVbWt1cUxnbTJXUTZWa0pydlF4RFUrcW9WeGhSVkNy?=
 =?utf-8?B?dmFFTlAzUy9GWDkybThRY0QzT3ZINTRndlpNZm9UWW40eXpYbDJmazZNSUVm?=
 =?utf-8?B?R2doT2VvTVIwQTRmdTB2b1JVZ0tTaEo5MzJFSEpLQWpxTEpueXBORWVXbkJs?=
 =?utf-8?B?SDVTQ0tTS1d2SE1Da0MzV094b0xkMFlPTGVMaExYaFRvRzM4a3JCa3NSdnFX?=
 =?utf-8?B?ZWtMeTBRMWNmQjZqaDcwTEVqcjVPbGNYKzZDZ093RUNXV2JNWStmNlRNZVVx?=
 =?utf-8?B?NXZBdDVnUUQ4RXZsRlVhT3YvWm40OHJwaGZJUWJ0MDVHeFZrU1QxUEJ4MWJL?=
 =?utf-8?B?Z1U1YUxSRWhIZW9vV0V1cnpReWtCb3lyNnoxeU1SNFQ2ZG94V2RSbEprOGY3?=
 =?utf-8?B?cXpiZEN6cVZsNUVtRyswRDFXMG1iKzhFY0NRanJFM3NrUjB3dEd5cXl1M1NL?=
 =?utf-8?B?cEZEREUrejVGaUVESE4zRmlONW1KZytSdzg2Z3M0bjdFYUJIb2lUTWpiWnhB?=
 =?utf-8?B?RTNLeEdWQjZvZURwV214MU0vQUtkaHBjQmdtNm5LNWhvRWFMZFpEdHVQRklG?=
 =?utf-8?B?Wk9yQkpNSTNTbDFOOXZKT3NmSWNEZzRPS1E1WWRRVVBXOGdJWEFUUzI2MDRJ?=
 =?utf-8?B?MTBnaHNMZEZiOGl5Lyt4VElyWGJDZXVIZEkybmUvMlg1UkZ3MEtuY1hHb2Jh?=
 =?utf-8?B?TE1UcHFoeEc3TGRjcE9kRmNmcjVoUWVRWi90YzZPdVpSaGdPemlUNk1LRk1x?=
 =?utf-8?B?cEp6UHd0dGJDaERKYUcwRmthS29QcUpKbmF5K01IR1NHZkt4bmxXUkdSWDhI?=
 =?utf-8?B?SnF3ZXhRYlRpbVJoekMvV0t6WlNOS1JudmR1VkZLQS9TaUN1NFg2ZFVleTB6?=
 =?utf-8?B?WkxMSlptcmVtRlBBRFRyMTBoSTZxR3ovRUY3UjB4enB3dm9YRFJDWXF6K2JP?=
 =?utf-8?B?elFjTVRzSGJQbW5ZS1ZPUkEvbVNCMjB4VlRXUDZYUEdWZGRXQjVSbCtoaEhO?=
 =?utf-8?B?Wlk5RFRWQVJZcEtkWEp2dTlmdFJuN2Z4NDJiT0NtODVDUFpFdTU2U2JpeXdu?=
 =?utf-8?B?YXVHR25DbFFjZG1sYjVSVitHODNjcnl3Um5LNkwzQ29SbEFPdzFPSlhhRlBU?=
 =?utf-8?B?MDJmL0lKM3pLUTZJR29PWWFqRHJNLzNIdmlSK2JOQkUvSEZBK2JSRk9RVE5h?=
 =?utf-8?B?d2EwOGp6MjhCYkdpUXd0Skk0bTAxTks2SVkwMjEzZllFVytieWhEQnJWZFBU?=
 =?utf-8?B?QTJGOTVwVGowQVByUHFwY2FjRHEvM1c1bHRCY25SMG9OVGEwbElObzRKZXpI?=
 =?utf-8?B?SDVRYmljT1VJbWhsVVA4MGdtbUdCVjV5eTJOQXpNdDF0dGV1QkcyWnJoVzdP?=
 =?utf-8?B?R0xnT1poTjZEY1R6OC96ZTVudmxBZnNycFArcjhZS3djc0h2dW5JV08zcmNC?=
 =?utf-8?B?L1h0Ui9QWUUvMU1YZUQ3Z29hN0FkTU5qSXhSd3NFbEpNSUZOV2FrbFpjemVZ?=
 =?utf-8?Q?8i/BDJoOyYBoheHDnAyXEiSmr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62517e74-43da-433e-87d7-08dc0c21beb6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:03:45.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2kEKsDivPuvu0ls6SoCUpcSjp56hj0Zw3L+88fGcpseuxDYIY7yNJLnsCFeJBF3BjG11YAJdtVnrmYIPbxqlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

Hi Niklas,

On 12/27/2023 5:27 PM, Niklas Cassel wrote:
> Hello Bjorn,
> 
> On Tue, Dec 26, 2023 at 04:17:14PM -0600, Bjorn Helgaas wrote:
>> On Tue, Nov 28, 2023 at 02:22:30PM +0100, Niklas Cassel wrote:
>>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>>
>>> Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
>>> correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
>>> support iATUs which require a specific alignment.
>>>
>>> However, this support cannot have been properly tested.
>>>
>>> The whole point is for the iATU to map an address that is aligned,
>>> using dw_pcie_ep_map_addr(), and then let the writel() write to
>>> ep->msi_mem + aligned_offset.
>>>
>>> Thus, modify the address that is mapped such that it is aligned.
>>> With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
>>> dw_pcie_ep_raise_msi_irq().
> 
> For the record, this patch is already queued up:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc
> 
> 
>>
>> Was there a problem report for this?  Since 6f5e193bfb55 appeared in
>> v5.7 (May 31 2020), and this should affect imx6, keystone am654,
>> dw-pcie (platform), and keembay, it seems a little weird that this bug
>> persisted so long.  Maybe nobody really uses endpoint support yet?
>>
>> But I assume you observed a failure and tested this fix somewhere.
> 
> Yes, I verified it on rockchip rk3588.
> 
> I'm working on upstreaming rk3588 EP support:
> https://github.com/floatious/linux/commits/rockchip-pcie-ep
> 
> Right now rk3588 only has support for RC in mainline.
> 
> 
> The fix is only needed for platforms which:
> 1) supports MSI-X
> 2) has an iATU alignment requirement,
> so where epc->mem->window.page_size != 0.
> 
> pci_epc_mem_init() calls pci_epc_multi_mem_init() which
> initializes epc->mem->window.page_size with ep->page_size.
> 
> $ git grep page_size drivers/pci/controller/dwc/
> 
> So it will not affect pcie-designware-plat.c, nor pcie-keembay.c,
> since they don't set any ep->page_size.
> 
> It will not affect pcie-tegra194.c, since it doesn't use
> dw_pcie_ep_raise_msix_irq().
> 
> Looking at pci-imx6.c, imx6_pcie_ep_raise_irq() calls
> dw_pcie_ep_raise_msix_irq(), but:
> 
> static const struct pci_epc_features imx8m_pcie_epc_features = {
>          .msix_capable = false,
> }
> 
> so while pci-imx6.c will call dw_pcie_ep_raise_msix_irq(),
> I assume that it will return early, in this if-statement:
> https://github.com/torvalds/linux/blob/v6.7-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L596-L598
> 
> That leaves just pci-keystone.c (am654 compatible only).
> 
> I don't know why no one has reported this bug before,
> I can only assume insufficient testing.
> 
> I guess you might be lucky and happen to get an address that is
> aligned to the iATU alignment requirement, but that is unlikely
> to happen when rebooting and running pcitest.sh multiple times.
> 
> 
>>
>> And the failure is that we send the wrong MSI-X vector or something
>> and get an unexpected IRQ and a driver hang or something?  In other
>> words, how does the bug manifest to users?
> 
> pcitest.sh fails the MSI-X tests.
> With this fix the MSI-X tests in pcitest.sh passes.
> 
> 
>>
>>> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
>>> Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address")
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>> ---
>>> Changes since v1:
>>> -Clarified commit message.
>>> -Add a working email for Kishon to CC.
>>>
>>>   drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> index f6207989fc6a..bc94d7f39535 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> @@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>   	}
>>>   
>>>   	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
>>> +	msg_addr &= ~aligned_offset;
>>>   	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>>>   				  epc->mem->window.page_size);
>>
>> Total tangent and I don't know enough to suggest any changes, but it's
>> a little strange as a reader that we want to write to ep->msi_mem, and
>> the ATU setup with dw_pcie_ep_map_addr() doesn't involve ep->msi_mem
>> at all.
>>
>> I see that ep->msi_mem is allocated and ioremapped far away in
>> dw_pcie_ep_init().  It's just a little weird that there's no
>> connection *here* with ep->msi_mem.
> 
> There is a connection. dw_pcie_ep_raise_msix_irq() uses ep->msi_mem_phys,
> which is the physical address of ep->msi_mem:
> 
> ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>                                    epc->mem->window.page_size);
> 
> 
>>
>> I assume dw_pcie_ep_map_addr(), writel(), dw_pcie_ep_unmap_addr() have
>> to happen atomically so nobody else uses that piece of the ATU while
>> we're doing this?  There's no mutex here, so I guess we must know this
>> is atomic already because of something else?
> 
> Most devices have multiple iATUs (so multiple iATU indexes).
> 
> pcie-designware-ep.c:dw_pcie_ep_outbound_atu()
> uses find_first_zero_bit() to make sure that a specific iATU (index)
> is not reused for something else:
> https://github.com/torvalds/linux/blob/v6.7-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L208
> 
> A specific iATU (index) is then freed by dw_pcie_ep_unmap_addr(),
> which does a clear_bit() for that iATU (index).
> 
> It is a bit scary that there is no mutex or anything, since
> find_first_zero_bit() is _not_ atomic, so if we have concurrent calls
> to dw_pcie_ep_map_addr(), things might break, but that is a separate
> issue.

There cannot be concurrent calls to dw_pcie_ep_map_addr() in the current 
code path as pci_epc_raise_irq(), pci_epc_map_addr() and 
pci_epc_unmap_addr() which invokes dw_pcie_ep_map_addr() takes EPC lock 
in pci-epc-core.

Thanks,
Kishon

