Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82E76E42F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjHCJUB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjHCJT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 05:19:27 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10463581;
        Thu,  3 Aug 2023 02:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDAZW0AqyN85VR94MnWp58+jhYbuNM5qgrZLcN7sZv9E4f7Zs4gcHLAUEqACrVN8hmg978L6/mWLFO+xPmnZcMVz2Q1taNcjg+BjMYfXvhDeGuYO0mtZCTzfebwdJQ4uvcdJYBWJQaP5Pmp1SRYq8gA5QRoIw7wyGhSJxdtondWqKCZ59+agW1us2e9+SOEffKwIPRppYBV2GQdFVBfn+8K4l+4jcYxNgnMfxjq8VW9Y2/ewgUANO3/fYttTni52vfhZGZ5GEwHLiZk79pwO3hwKSp6fQWFrA6t0qPIJOXq80QXM7DCqePciaAasqHenHqE4rREiizXpK50trTMU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhIKFtHfK46fym8IIIMH007olXQTDVF1QfKtKiPWQ2E=;
 b=jy9CyV+x7X3TCP1PFlrAOpPfkD38VirVmqS5nHmpDXhFU8/+ZiAtmlkRKnciMh4LvzIxdkHEHYeKiYTBrbYYCOddY3pB6mIzWPW2l3TWpWEJoyWfKwzmXYxBiGlpQBalD1jn2c6tqJGFCJ+yIiXICC2vWYvmM2T8jKmb8COsI7seWwWUmMujaFeOmnZgs7fj09IBbXPWB/+W7zc65xTa2BRIZigdKPa20EdW4DXq0UPGDAa5/zDsQlyYb0tvaDhFMTpPDLLW1IBCvqJ1d+AreewPh9tBfoCgN4WojRfGLfZe+7VVZGUuSGzXwrkhjC8h2lm3+PySSO9N59jPxOE4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhIKFtHfK46fym8IIIMH007olXQTDVF1QfKtKiPWQ2E=;
 b=mvyBAa0w1zZuOBV97hKvffwXKlOGDpM+DHyxgyHEgt1QqEnt0CV8r2GpTsIhXTcDFJTSZWhrikopTMd9YTVuGmR/YJOEzhnkUxBTYO2FXy/PPpT0reW6yxgI9u3Ky86qnvVLmf90TYYyuXv6j342S4des7pWrnIiFNRYJOxqBkimR3T5M4bmOR//KK7BKW08G5rTX6VjwdTSnau/+JAs81sOBc8ZyZp2kDmDZfGP3KigZLo44Hxui5K2qKSzSmY4elbq0peZhgX+1VizOG9MwArbIj4juJr4z98kPTE+Vi1pg2+hqq/2nfL28+k7upKVujXb56aWL5ur7df0KMZTfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 09:19:23 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b1:f0a0:1b20:1bf5]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b1:f0a0:1b20:1bf5%5]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 09:19:22 +0000
Message-ID: <55e8a27b-580f-8b33-f069-a05cc5322cbb@nvidia.com>
Date:   Thu, 3 Aug 2023 14:49:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230801204015.GA49719@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230801204015.GA49719@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::23) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3991d7-19b2-41f2-b40e-08db9402b8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzEds/hiO8rtyUHSngtGWJj1vIrfKVvQgV8U+rChYGow2/F62EwiYFYxKWTrVNFx5jkwDqVbX3omwYbZUkqQlSdOswzlFjB4uoD0L0KQ7x9NubtuYATqt2q4tiDpuiRIqo+K/+yn3gd9pphe9B5V7eoHv6QiyB8+yba5dN1uyyZAGfCG/ofelVEtw4pe6XF+aqjmvTAK9JE8+WMghy7qRRLnOCcgNkZcF/xE09zAyODPnJ2l05mnuj0BVHfbOD29XYEeBezf5hUfu9mbi5sbWEsDArb9Zw0oCenzzrD1HRwZ/7Pr2HVnkPleznimsMx2NaXlvbLqbY7qFgTkFRt45JKwTb1wVc0mzjUnrwh5GbmelWdVn4qAUBQ0CLm9kCQT9zecSQndIOlGlsRm6BFLFrFzZQmQdY41QlSJOqwpFcjoaKqNPePrwMsQbvwcHJCMQLpOQV8Ou09kAmKX9R6TnLHGrMWg8ITIsPnfQi1G5z2mSSfbpBjpo/7h8mjeLzyxwap0HbUWepJiRBfmMot7ZCmNgZHNyQNKuYaz9UO+CVxh7lQZYc79Lmh1Z/O9jSGJSc8HOPMTonoNVtEwmaM0uH5c9d4vJ7opCl9l9NH87+/xgtsdVSIlLgQcNw3jmbvksg/R7z0ea/7tU/QGVQpSYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(31696002)(86362001)(66556008)(66946007)(66476007)(6666004)(6916009)(6486002)(6512007)(2906002)(31686004)(4326008)(36756003)(478600001)(83380400001)(38100700002)(41300700001)(2616005)(7416002)(5660300002)(8676002)(8936002)(26005)(53546011)(6506007)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aElrdmUwNUVwalpOeXIyWWNnc3JRZnN3cFFSc2JzS2RFdGhwMXZRNUVsRkVy?=
 =?utf-8?B?VFk1amVZcUQ3VjV2L25GMVpJazM0ZjlMUERtaGdJK2JKTi90WUhlK1lBUkxF?=
 =?utf-8?B?Q3pzQ21vK2pKZWJnaGdZelFOUjhxMnloK3NOV0UvYXhzc2FUWmRnUWNNY1F2?=
 =?utf-8?B?ZnRRa0xTc0E4ZkFGTlhDYkpHWlh0cVdwUEV6ZTZZRVNaT1FGa25sandwaEVk?=
 =?utf-8?B?aWZNZzNWYjQ4V3MzdTRrTkp2a0hPWlc3VkZjS2xVbVc5K0xRaDlsenU2RWxq?=
 =?utf-8?B?dm5Vbm9KZWlYc3poWmZROUpQQkxyMkdPczNNVFlhVFl0cTVPTzNaWkVEMDU0?=
 =?utf-8?B?VTlxcGhQcXBaMEw2RW5US0JiRk1idzJIL0x4MGV2MktRV2JtT0NUTE1lNnFy?=
 =?utf-8?B?VnhPb1dPRUptc1FtcWJnbzRrSCsvaGc4aTFqS2hmYTFManQ1TVlZSkROS0Nn?=
 =?utf-8?B?U09YTGRNL2c4emRqMC9NVUVkRmMzQjVla1RuZVE5TDJJVEQ5T0MzL2F4cXps?=
 =?utf-8?B?SzhXdU1IOVB4NXI4RnZCZUgvMWgvd0gwaHNXTStvRndCZnJKR3ZzYXpiV1hH?=
 =?utf-8?B?SDhOWjU1VE9wR1BDMDFlMnJwdVVFWVUyTmF1ako3VXV5bTNROEFFY1AxRnRB?=
 =?utf-8?B?dk50Z2FOcnc3YUo2eGpaZXgvQVJOeER2SmdnUXUwOGlwUm1qL1Z6eVREcWVx?=
 =?utf-8?B?SGtrYVJRblBaSUFwbFM4SXRoRUh6Y0RsRkgzanhOZUFkajcyTEMvVDVLWHBn?=
 =?utf-8?B?SVU3YkNJelNHV0NJd1gzWk1KZTFmc3IvSWZYZmlTNnJpcjgzeW1UTzhrdU41?=
 =?utf-8?B?eXRDZWkvaXFyKzdQU0xWZXd4QWFNbStrVUtMeHRTV2ZUTlZUZ3d4RnQ5OXp5?=
 =?utf-8?B?bnlIa0RPbHJIQVZ6elk4VlRmQVJZWDNRam1uRmxsMjE3bURiNG1YdkUrUzcw?=
 =?utf-8?B?Nk1NTGNaMys2WjBBUHd2aklsODNwaFFwdjZzcTNBY3Z2aEZ0OG1NNEFjNHRS?=
 =?utf-8?B?YVhnSlE2SERobnY3dXEwS0xVZ3MzMjEzV2EvYmpNMUxFYXF0aStHVkREWDMz?=
 =?utf-8?B?eTgzMXg0UVUyV1hVcStXYnU2OC9HdlpzVWFqWFFTRWRrTWUyTlB3VVltK0Vz?=
 =?utf-8?B?VkhXYWRVa0tIMW5EV1h5Y0NXMVpCZ09ONDNzZ0NHTGoybEZ1WjMwMlJYRk9I?=
 =?utf-8?B?OVlyNGsxcThGV3p3S0UvQ0h3dFhvam9DKzk0QkNHSUplZGZITFRoWll5ZjNp?=
 =?utf-8?B?bkwrd21iaHRoN1pUSmdycno1SXRjWFduenVWRWs2bFN3Sk1hLzBIVDNldW9V?=
 =?utf-8?B?UDhkN29ESHBXYzR5S3pGRmJUOEdXZ2JKOS9mTWZxa1o5ZW5nZ2hpbERTUTND?=
 =?utf-8?B?Y0lrUEhTKy96d3V3T3cwSWZLM1VydlJEZ1d4Y2JSSVlPREVNZlJ1NVZvcGhM?=
 =?utf-8?B?amgxOXY1RkU5Z0xvbVFia2RPekJyQTlESXBIUWtBL2RIYmNvRCsxb0gydDd6?=
 =?utf-8?B?WVhhZzYwM2xlaHhEZ1JlNk1MNHU3VWg3R0F2RG9kUnZKN1k3VDVaQis1bG9Y?=
 =?utf-8?B?c2g4WkQwT3YzRldsRXQ3ZmlaVGRaR3NJUXY2ZVBFbTYyZkRXV0FEUWVzMDNZ?=
 =?utf-8?B?QThZRnE2MGRya05RVnlIWDZGWG5LVlg5UDBrZ1MwVnAvOFdEYTlSRTFjazEy?=
 =?utf-8?B?VVBaSUYyWnpRQ3k0TmJacDNyaHF5VTIvbEROSDV4c1V4UUdRekF4aDhnSzlB?=
 =?utf-8?B?ZDFnZ0lMWGpCVkgvdUptUWJoM0JLZGFiSHRMdVplK0tqb2VoazZobVEyK0Vy?=
 =?utf-8?B?eFZWK3Z1NjNKLzlOU3Z3cksxbFN6bXh4UytnKzZZQ2VNM2liTnRLQWdWU3ZC?=
 =?utf-8?B?UGdIOE52a3hpZmUxRVcxRkIwRlpVTnZsUjRzQllaOGpVTTluWTFtRkRFM2Ra?=
 =?utf-8?B?SFdzakRwMHZzWk9adVZ3eTFBUi82RGgwcCtKajl6bndSZ2wyeHVDOWhFSFhk?=
 =?utf-8?B?Z3FYUGhaNFNacFR0TmN2OTdvTjEyVXFXMGo5Nk5kMERadTd6amFCVGVmK0ZK?=
 =?utf-8?B?UG5oTm5ENDZDeVZlTVhQMjhseUh0VmpSQmFycUVZeE1uM21pR09oQWR5WUVP?=
 =?utf-8?Q?EbIZkxfwWqqcE17kbZ3eXkxP4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3991d7-19b2-41f2-b40e-08db9402b8d5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 09:19:22.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luR+GSgxQVJXlHF/Rku1YPV1NCAHXPeA/vt4pbGf2Ma4EtbEsdsieLcRz8FCp/SXYz4RAWyK0U2Jh7xLFwiL9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/2023 2:10 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Jul 18, 2023 at 08:22:21AM +0530, Vidya Sagar wrote:
>> After commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
>> payload"), we set MPS=256 for tegra194 Root Ports.
>>
>> By default (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*"
>> parameter), Linux configures the MPS of every device to match the
>> upstream bridge, which is impossible if the Root Port has MPS=256
>> and a device only supports MPS=128.
> 
> Thanks for pointing out that I broke this log by omitting the mention
> of a switch.  Is the rewording below better?  If so, Krzysztof can
> amend the commit.
Yes. The below rewording looks good.

Thanks,
Vidya Sagar

> 
>    After commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
>    payload"), we initialize MPS=256 for tegra194 Root Ports before enumerating
>    the hierarchy.
> 
>    Consider an Endpoint that supports only MPS=128.  In the default situation
>    (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*" parameter), Linux
>    tries to configure the MPS of every device to match the upstream bridge.
>    If the Endpoint is directly below the Root Port, Linux can reduce the Root
>    Port MPS to 128 to match the Endpoint.  But if there's a switch in the
>    middle, Linux doesn't reduce the Root Port MPS because other devices below
>    the switch may already be configured with MPS larger than 128.
> 
>> This scenario results in uncorrectable Malformed TLP errors if the
>> Root Port sends TLPs with payloads larger than 128 bytes.  These
>> errors can be avoided by using the "pci=pcie_bus_safe" parameter,
>> but it doesn't seem to be a good idea to always have this parameter
>> even for basic functionality to work.
>>
>> Revert commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
>> payload") so the Root Ports default to MPS=128, which all devices
>> support.
>>
>> If peer-to-peer DMA is not required, one can use "pci=pcie_bus_perf"
>> to get the benefit of larger MPS settings.
>>
>> [ rewrote commit message based on Bjorn's suggestion ]
>>
>> Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
> 
> 4fb8e46c1bc4 appeared in v6.0-rc1, so this wouldn't be a candidate for
> v6.5, but it does sound like it should be tagged for stable?  If so,
> Krzysztof can probably add that as well.
> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V4:
>> * Rewrote commit message based on Bjorn's suggestion
>>
>> V3:
>> * Fixed a build issue
>>
>> V2:
>> * Addressed review comments from Bjorn
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 4fdadc7b045f..a772faff14b5 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -900,11 +900,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>>                pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>>                                                              PCI_CAP_ID_EXP);
>>
>> -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
>> -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
>> -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
>> -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
>> -
>>        val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
>>        val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
>>        dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
>> @@ -1756,7 +1751,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>        struct device *dev = pcie->dev;
>>        u32 val;
>>        int ret;
>> -     u16 val_16;
>>
>>        if (pcie->ep_state == EP_STATE_ENABLED)
>>                return;
>> @@ -1887,20 +1881,16 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>        pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>>                                                      PCI_CAP_ID_EXP);
>>
>> -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
>> -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
>> -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
>> -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
>> -
>>        /* Clear Slot Clock Configuration bit if SRNS configuration */
>>        if (pcie->enable_srns) {
>> +             u16 val_16;
>> +
>>                val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
>>                                           PCI_EXP_LNKSTA);
>>                val_16 &= ~PCI_EXP_LNKSTA_SLC;
>>                dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
>>                                   val_16);
>>        }
>> -
>>        clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>>
>>        val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
>> --
>> 2.25.1
>>
