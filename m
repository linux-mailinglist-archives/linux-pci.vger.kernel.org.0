Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D710B583ECB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiG1M0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiG1M0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 08:26:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129A76050F;
        Thu, 28 Jul 2022 05:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLe+cRPcmr9kBvZcwR4ipo3Oigv+hzKn1mhsAkPPtxZrGzYL9Gz9doxlyfa0VXbEa/wELWLBSUIP3oGRKa41v4GzGADF0wahvw+2CQp6lbGYD6MlOhBbp3C/+NgFp7RIOGi2vEEImh4YRjN3rP1HQDPrZTq69EBwAn/hlrgTTt32VfQzTGzizD8EIeTmX57hdXYmvO64AyrvPQuk+Qa4uUIizf6/l7FWYJwJOZ4TEMMbtPwjziZTG74QNapZgpGtJ5yB/+jXb59Y9ZNe1J6O4jZwq3Jazq5y/W9mvXdk2QqdmnWN65InGsk5Ws7cd+5SVDuMt/o3z2lyjNc0R0eq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN9R5nzMSUFXmm7GQPaXiYSxxNnlJ5u/Fz+5vLYjkTQ=;
 b=SvzuFgE8lm1ReX1fO0NuMOyDu5Q2JmpJnR/tp4lpwTsCSnXwfPQ6OG8PCE9Fm6TdwN508vZCkVpTgMAhHcXLZwkrx6UkhSF8ehXKjw/8xawbangJ3bHFsb+EAmj2qFtmVcDcFjFS58ZbPsGVDThAZfhvGu7RexaQL9hi95E3roRasJCap71ZBO0GRW/rM9+lGNNdurrOqFIaMslw/lkaAbBKwWy+5tyj/piS0O8Ah6A1RO6yJ6MICpeN04Azi1VXLCuEAd1HvfrGLV2A4WEd+vvofxk+8qLzKDBVdYDFIM9Q0bkeLeGLDWAETxRKwBs0TLEJAsTIi25N2IjdHZHQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN9R5nzMSUFXmm7GQPaXiYSxxNnlJ5u/Fz+5vLYjkTQ=;
 b=Cmhkr0UKqOVf8RjbWbSMk6BbbxyM6p8dJhR7SxsJ3L94dZOrMcW+EaCXvAwDQzBnec24JOAWCc6L7tTyK42+1Jx5Sjed5BF0Tmot+HEMMXD0XSIm2wehiFpRe7KHsXmd0eIgoiuEjbxc7jcI9QYGJ6vam5R8GjcmJYvwgWeLTdhmEOCiztX/GXayMOWhq075XUhfEKvE9+gh9mGgSeNbUpahUGrqBNcZXo1wG1IrHgAPqB0hSADldlg8FwJOwonFXTJsPYEKnlXdeuEca5SnGXAL2zWWNxz+RcbJweDVwMeUzQR/9HlI9XY4KFvspcqzYfpG0fAdEooy4lo/hLrCGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 12:26:41 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9%7]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 12:26:40 +0000
Message-ID: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
Date:   Thu, 28 Jul 2022 17:56:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220727221415.GA250151@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220727221415.GA250151@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::20) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 910286c6-ed6b-42c9-c340-08da70946c4d
X-MS-TrafficTypeDiagnostic: SA1PR12MB6822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwumDv0srn4kHVytZ0JiNKLTAdtoHj0/2Go/5HmbMvGTRdu35cLF5uGrL89UVKVmMgPzkCaKWXbF3S/MSGWOZ+DxEy4RlTXPVlo/CSXM6tcj2O+9jDRtl+joHdEbKh6uPAsgzQXMbaAo9h1A2LpUCL2oFsq9hBOqebR/RYOLZiL4OjD+QnsLv7/RjoeszFM7ER06PdJM9y1KZTOfJh2K8Ri0Cce1fQ/DUCuE2FNKRjLVkUccvEmFQXupf1+02xHNSgo3vEpl28p//VRhv9h5It2dzTjuPSHK0Hl99kYa9JykL4Ahnwth7IDAeVDX8yjw00r9YRp5yYrSmQUVfZbCQDWsQH8d1GYrS8a4aJ+5r8FXoFL4OmHUAvUGWnV9dt1283xneoY+CQ3se0WtdnypaNXIkHcmeSFNJUtvegslZZ/lyiRPAR8MHjeXGeCzognLzGxHLCpkpXprB7d5OEV12wngl1+IO88wOEcPNmR/zu8jt+d/wfVc37lC1B+IGjJ17si3kYCACyuVvWxUMRVOUIW3GI7eDG4gJ8ln9HVIyv16aVZK3+MFST9DxEg9LkVUJizOT15/IOdlu4BrStBjuH4p4Y3pySEktKkfIILGwoCqo0c/D4DboYY2mt9/IAZ8IOzwMRKMsJnSOnRDtZHZTyS0Ts0vdehpVRvUljoGp9nmLbtAoI9ZER0iI2Bzd7f8Ms0VS9fvhVkByE+ar7XVcJY5XIhz4h13XpPqhOk8wOpvyA8nS33P5tP5Gx+ju39yHRjeQNrLWEDdW9iNkkqaod5GIbiPCSI9Z86KynTaUOCtCoFs2cKTt6fZgYL/si5kPiPwWFotnur2ONGY/Rpdpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(6506007)(31696002)(66946007)(38100700002)(478600001)(86362001)(6486002)(66556008)(4326008)(6916009)(66476007)(316002)(5660300002)(53546011)(8676002)(2616005)(186003)(31686004)(6512007)(26005)(36756003)(7416002)(6666004)(2906002)(41300700001)(83380400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXB4RkpVVjdQTXdvVzZBR21tSVExZjZwRzVSZi9iRWp0SVg0QjNUbC9ScGh0?=
 =?utf-8?B?bGpxRnVSbHQrV1J0M1lpRUZXaEttTGlFM1g5d1JLZjl0Q0V4eElVU3RNenpo?=
 =?utf-8?B?dTlHVWp0dmZDVWRpSC93bHo0LzBZZ0ZnRjZwODd0RWJGRGJ1dkxPdjZibDFv?=
 =?utf-8?B?TG5aUXVRNGJpbThLREllbTZ6bHBWWmtHNjRISWo3ZmRPYityYlU2anVMWi92?=
 =?utf-8?B?U1NYdUczTE5OM0ZtN1BXQzVySnJ1SjRYMUl0Si9CSHE5Rms2YTNRa0FXU3Jn?=
 =?utf-8?B?ODlsTi9aWDNUYTZ6MjhEVU02OFpuV3FHYncra24zTnU3R2xXMEFVS2d4Y0di?=
 =?utf-8?B?QU9hS2lXY3hLS0F1RXJmRTFCaXJ5aFdCMzdQUmFhRUFXdVFxL08xQXY3TjVX?=
 =?utf-8?B?L0p0THFPZnQzZWxlL2JWVkQ2N1VaNFVySnZMbi85cytHclRYdzUxRmF4U3Vm?=
 =?utf-8?B?dnJ1eFNnT1JwdEpNVUxiYktkSEJkb1ZOL2NVQklwZldqeHRzQjdGZlh4M2pE?=
 =?utf-8?B?bW1BQ0pjNFJhQXBKdkczTWhCQTlJUXFzZ1l0cTdkeWV5MmF4QjVpTHAvWm5N?=
 =?utf-8?B?RkZjeDhtRGdqSklUWEc0RDdoUktodFJjbHphZDVDeFl3S3FSOU80eSszK0U2?=
 =?utf-8?B?d1B5cXM5TDFlREdLQ2VWdFcraldhSWRMNmg2QWdpdXhUdmVpVXhsSlhGZE9N?=
 =?utf-8?B?ZERhVlBoMVI2ZE9lYXh0ckRqZXJmYnNMbTMzazNmQnJDWTNkMU9wM0VsSklQ?=
 =?utf-8?B?MU03clptYzAyOVgxYlRtcnVMbEtieWROZE13Q3ZuRFp6MElqOEdDZmZxenZJ?=
 =?utf-8?B?NmZoclo0OVBBWEFpNnRPRTdxMmVmWU9NME1JdWFEVStUdW9HMGo3eE8xNVpV?=
 =?utf-8?B?cmdCUzdLd2RJOVMxVlJ2V2g0YXRNb01yRFdFdEJuaklxREk0Z1BLenMxVW16?=
 =?utf-8?B?ZW1UZnN0amlBbDY0aWNiMmVoeExPdUJoL3l6aVB0VXRpbklpdnZiQmdJWGg0?=
 =?utf-8?B?V3ZEc05CY2Zxc2ZSNzgreDZkMVFaV0FyVHI0Z1lmSXk2UmRhcUIvRlhIYno3?=
 =?utf-8?B?ZVQrU2dQaUNVNWZTWUdmSWFIbFBjVkJmaU1JR2F3aDFxNUZwNFBaalVSQ0I1?=
 =?utf-8?B?MWdheVhXelZ4YTIxdzcyVENhMXlJN0xFc0NCTWlyZHF0U3pnOXVoQndsOG5W?=
 =?utf-8?B?K2lZUGE5OTJKSXNsd3M1bU1pckhjMmUrTmlRNmE4SXlrT3F5U3NkV0FtTTkx?=
 =?utf-8?B?NEJLaUI4K2llNFJjYzBEUlc5UlQyTlVYdFVlSmk1OEJ3Y291QjRKczJrRDVI?=
 =?utf-8?B?Q3d1MG1OcUpYZXQrenF4OHg4OW84aUkySlpVMVovL2hqYVpBUGhkK0FaNnpK?=
 =?utf-8?B?eXEzN1o5aTczblNYekduckhmdzgxNFViSGtibTU3bW0zbmFJbkllb0w5QjZw?=
 =?utf-8?B?cnVYVVJXd3B4UFdqZG5BTzBGN212OUZwNlFDOTFTRW9YTHpMZnN4MFNlTHg1?=
 =?utf-8?B?MjRZVHVGeTZIRzBuNC9HdUU3OHo3QWFNQ2hHYzYydzlMRzQ5WnVTbitjUHlT?=
 =?utf-8?B?emQvV1NmM216bGxKdHdmODZ1eWVKeXZWZ1NaRU5WQjBYWU16UVBqTC9rVCtT?=
 =?utf-8?B?OFhZREo2SWlROWRrU1ZUdXY4dU9Ua05xSGc2TVA3RGxOWFp1TUxHU0IweVhn?=
 =?utf-8?B?SFpmTFAvNTZTcTlMdzVUL2NubzhzZWplZGNiZUMwcDk2K1NwK0tnWlYzQTlP?=
 =?utf-8?B?Z3hYYlRUeURaRUxnNnlBYmkvZ2haNS9SOGdJbEVuV1VvOXVSWGE1NGd5MmF2?=
 =?utf-8?B?WmlLR0RRMllEeDNhMFFLQU42T21OdUkxMkIrMU41K0VLOUc1QkoyTVVScnZQ?=
 =?utf-8?B?TTgyVktiK0FDRFZXL0ZnMVYzQ1BSL2RaVk11dUtnZ2ZrdGQyLzhxWUZuRzhE?=
 =?utf-8?B?dUNTMnU4SHJrV1dWcm93M3VYbVZnTkhGUW1ERWF6dWxnWUU5YTl4cUZBVEI5?=
 =?utf-8?B?ekZwTStZeXJBbG5qWVhFYVlmSEhkdVNnY3BqemRVZGlseTZrc3JoRGdmZ25K?=
 =?utf-8?B?c2FCTTcvQlM1TXh1Nmh2T3RnKzJNamVOLzNsTG1yaVBnTEYrbytYMG5VK0ho?=
 =?utf-8?Q?sKXkymgUhxZZ3y2oNTa7ZYEGP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910286c6-ed6b-42c9-c340-08da70946c4d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 12:26:40.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SECykBKdYItx08UtJQlwJnZNd3Jx9gBNPrsAW1Tz9jri743ALEEXHHnn6Yw5+J/RbMRLko6pC+E6Crqep0I0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
>> Platforms that cannot support their core initialization without the
>> reference clock from the host, implement the feature 'core_init_notifier'
>> to indicate the DesignWare sub-system about when their core is getting
>> initialized. Any accesses to the core (Ex:- DBI) would result in system
>> hang in such systems (Ex:- tegra194). This patch moves any access to the
>> core to dw_pcie_ep_init_complete() API which is effectively called only
>> after the core initialization.
> 
> I assume this is still broken.  I want to fix it.  I assume this patch
> fixes it and there are no known problems with it.  I assume this can
> be fixed so it works on all platforms, whether they use
> core_init_notifier or not.
Yes. All your assumptions are correct.

> 
> I'd like the commit log to be specific about where the hang occurs so
> it's easy for a non-DesignWare expert (me!) to see the problem.  E.g.,
> on tegra194, X depends on Y, but Y is initialized after X.  Say
> specifically what functions X and Y are.
X = DBI accesses
Y = Core initialization which in turn depends on the REFCLK from the host

Without this patch, hang happens when DBI registers are accessed without 
core being initialized. In the case of Tegra194 at least, core gets 
initialized only after REFCLK is available from the host. The way we 
make sure that the REFCLK is available from the host is by checking for 
PERST# de-assertion interrupt. (PCIe spec mandates that the host must 
supply REFCLK before de-asserting PERST# signal).
This patch prevents any accesses to the DBI/Core registers if the 
platform says that it supports core_init_notifier.

Thanks,
Vidya Sagar
> 
>> ---
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
>>   1 file changed, 49 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 0eda8236c125..9feec720175f 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>>   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>   {
>>        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +     struct dw_pcie_ep_func *ep_func;
>> +     struct device *dev = pci->dev;
>> +     struct pci_epc *epc = ep->epc;
>>        unsigned int offset;
>>        unsigned int nbars;
>>        u8 hdr_type;
>> +     u8 func_no;
>> +     void *addr;
>>        u32 reg;
>>        int i;
>>
>> @@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>                return -EIO;
>>        }
>>
>> +     dw_pcie_iatu_detect(pci);
>> +
>> +     ep->ib_window_map = devm_kcalloc(dev,
>> +                                      BITS_TO_LONGS(pci->num_ib_windows),
>> +                                      sizeof(long),
>> +                                      GFP_KERNEL);
>> +     if (!ep->ib_window_map)
>> +             return -ENOMEM;
>> +
>> +     ep->ob_window_map = devm_kcalloc(dev,
>> +                                      BITS_TO_LONGS(pci->num_ob_windows),
>> +                                      sizeof(long),
>> +                                      GFP_KERNEL);
>> +     if (!ep->ob_window_map)
>> +             return -ENOMEM;
>> +
>> +     addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
>> +                         GFP_KERNEL);
>> +     if (!addr)
>> +             return -ENOMEM;
>> +     ep->outbound_addr = addr;
>> +
>> +     for (func_no = 0; func_no < epc->max_functions; func_no++) {
>> +             ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
>> +             if (!ep_func)
>> +                     return -ENOMEM;
>> +
>> +             ep_func->func_no = func_no;
>> +             ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
>> +                                                           PCI_CAP_ID_MSI);
>> +             ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
>> +                                                            PCI_CAP_ID_MSIX);
>> +
>> +             list_add_tail(&ep_func->list, &ep->func_list);
>> +     }
>> +
>>        offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>>
>>        dw_pcie_dbi_ro_wr_en(pci);
>> @@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>>   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>   {
>>        int ret;
>> -     void *addr;
>> -     u8 func_no;
>>        struct resource *res;
>>        struct pci_epc *epc;
>>        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> @@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>        struct platform_device *pdev = to_platform_device(dev);
>>        struct device_node *np = dev->of_node;
>>        const struct pci_epc_features *epc_features;
>> -     struct dw_pcie_ep_func *ep_func;
>>
>>        INIT_LIST_HEAD(&ep->func_list);
>>
>> @@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>                }
>>        }
>>
>> -     dw_pcie_iatu_detect(pci);
>> -
>>        res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>>        if (!res)
>>                return -EINVAL;
>> @@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>        ep->phys_base = res->start;
>>        ep->addr_size = resource_size(res);
>>
>> -     ep->ib_window_map = devm_kcalloc(dev,
>> -                                      BITS_TO_LONGS(pci->num_ib_windows),
>> -                                      sizeof(long),
>> -                                      GFP_KERNEL);
>> -     if (!ep->ib_window_map)
>> -             return -ENOMEM;
>> -
>> -     ep->ob_window_map = devm_kcalloc(dev,
>> -                                      BITS_TO_LONGS(pci->num_ob_windows),
>> -                                      sizeof(long),
>> -                                      GFP_KERNEL);
>> -     if (!ep->ob_window_map)
>> -             return -ENOMEM;
>> -
>> -     addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
>> -                         GFP_KERNEL);
>> -     if (!addr)
>> -             return -ENOMEM;
>> -     ep->outbound_addr = addr;
>> -
>>        if (pci->link_gen < 1)
>>                pci->link_gen = of_pci_get_max_link_speed(np);
>>
>> @@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>        if (ret < 0)
>>                epc->max_functions = 1;
>>
>> -     for (func_no = 0; func_no < epc->max_functions; func_no++) {
>> -             ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
>> -             if (!ep_func)
>> -                     return -ENOMEM;
>> -
>> -             ep_func->func_no = func_no;
>> -             ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
>> -                                                           PCI_CAP_ID_MSI);
>> -             ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
>> -                                                            PCI_CAP_ID_MSIX);
>> -
>> -             list_add_tail(&ep_func->list, &ep->func_list);
>> -     }
>> -
>>        if (ep->ops->ep_init)
>>                ep->ops->ep_init(ep);
>>
>> @@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>                        return 0;
>>        }
>>
>> +     /*
>> +      * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
>> +      * step as platforms that implement 'core_init_notifier' feature may
>> +      * not have the hardware ready (i.e. core initialized) for access
>> +      * (Ex: tegra194). Any hardware access on such platforms result
>> +      * in system hard hang.
>> +      */
>> +
>>        return dw_pcie_ep_init_complete(ep);
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
>> --
>> 2.17.1
>>
