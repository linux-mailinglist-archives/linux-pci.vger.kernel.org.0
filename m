Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D973D5FB7AD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiJKPtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJKPsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 11:48:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C851ABD56;
        Tue, 11 Oct 2022 08:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4ILN/AJ+vKRvjFPwk73X7irUe5rO7u3EeXS5FexplzX1W68xe5ymKfD7rS+XyrC/B9aVkmvHMQx/zrYuKU0DW6VziY8dAedeHfMqvoK3LTuThi5AFOL8XRhoqCUSoN8GhAIzxmsgHQxyPK6dAb1xqi80dYQbIvOnPuryQ2fKdteUp44Kox48s9nQ9zreTGMNbYmS9J0hpwMdf0pyyjRqJ+WfC65qYumIDKbzEwwBnpBLHtPBEw6k3C3JwY9+b7dULhurK0Vxk8fRE7D4I2XqySbrZiOCMhDv1xMXDOnECWw3SxW64xUAfjfbPBkx1rN1I+tibZYtXyRkeq3qHzevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=407BxFOlJ8gCTY+2hzL2JftI6dpufJp3jAR9ylIHGow=;
 b=GqzTPpuCZHp8uD6QPy5wojD0bFmFF8gSU3I40swEmlkJ5ec2hx8X+6ljbZ4SvUoARovIC4mkGyqh+Fd+r5EZ033QcylmseC6j7TLTLKzUTCRxe8u24LuR78LbKh76V8vYqwnNkaXOShgGWACCoNWUCvkkWZHsbTd4XKqcPgcz5cr+W7AkzrIgOcm9cJdsYY8fitEFIM9w6ipP6jylX0iU1qH0D+z/YhT/mZi9+QXtFpENmxZovogM2oKp6DtHXtO5VK1Qyd5YkC1jCk4MZw04Ekohsd/cUkJZssUXfYr/ozAqzD8AeAhDzmt+Yy3O9r5pyagaLeesBKleCTf4akQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=407BxFOlJ8gCTY+2hzL2JftI6dpufJp3jAR9ylIHGow=;
 b=ED69mdagjCrzner84Dl74667FWsN2se21vc0qEfrNcL8ytsZxV4J84Oj4YsX2i+zSbJWtnM2hoScwD9QWi1A4VUw6eVuJ/PbqshHuaj2qpCI/6+WB3M11BKKtpEz6qGy7ezvJEPoKlLQSOr9KoeMza3RVJTjG+OrRz00rqVkA+2t7Lg4yuzbEdqSGE/RapWmagcvKg8DOEzas1sj2UQ3lG2C17z9HY0wLbOZO/EqYq6SIbPp5ORmd7UkglwIqrnn0YYBOUmnzkGoseaT7CeqGHrujnCARkq8Bl5/9GJZocOObiI84qQIy7oB7tNLtPpU8wn7s22AnAkYd58utbszLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.32; Tue, 11 Oct 2022 15:42:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 15:42:51 +0000
Message-ID: <220b0fe7-8b7b-cf9b-e28d-d9d81647fb80@nvidia.com>
Date:   Tue, 11 Oct 2022 16:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220928121911.14994-1-pali@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220928121911.14994-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 9063fbdc-5f46-4d95-703a-08daab9f4169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1zlZAd+ky/9SJQp01HyJKUbFR7MKRpWLk1qN69Yw7N5lsYfbf5fL6pGMRke/Cj/tRxFuMP0w5Uj5sSXhe8Isq5ksfKZEPv/cpz+BeHzyGgAaeVyE+idEIDqRRDNy5tyC4TJAWhH5fcX8J+L1F6ImU+bGuxFADy436dOLzghbBpNQZ8MxXnnXfD4pE+3f9lOafA9XBA64bLBwVFnX2Bhm9RQUkMxooDc7qk/dDZ/gIbdSo6e3aNqHAzu8NFjEV5aL+Ul/VKCuweCx8C8XWJKyude5mkBMxQqxg2uyXw7+unsYMoKlyeqGB3ooxRpUpc+d4SYqJC9bds5DtI3sbILDTxHYg/V7xLkosljif7hhVhOQZh7WDv42Msl4nWqnvPGDb1TsYW0fC/KG82WvduKlLIeVox8/mkdphht2eVogtlMsvibZiyPvcUXOSWtU+f3Vao3HzzvGtJTxovd4SUf/WO/XCm3kLV2313lLp3YQR9zRh4CuooeWrYRMMw+NR551XgPkgoqs8wCBC68KYmqAuy8fOE46ldWCpzJJBar6GPtiG4/WdnUkAYI039vcTDWW0ZuPpZgk7DeWuE+Lf/GmIhCFUEZa2HWe5GEYhwXp80OfDBM5ncctBeuWe+btylC8WuEhLnxLuuk1ikWJrJfXDUMFy5tZTtc9Peh0zWoz1WevhPkNRZHy6/fZzq/SeoMJMiOxCndWiEsIugm8v5pD5DfT3Yvz5WSq3Wl5z7XUc9Z0dQmUqwKKy1ja3tMSyEXGDnPxE1XxM0hZDlgCDoVGWMNlnSTi0cN93RRJZOxxhHRoBrltlZlaZVcPdKfiU6HkyX+y0evZ/p5WekKdcaZNpnfVLk0nqB2pj8gAGo0WueKFaUFFXeZfFtE/zCf1IyF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(41300700001)(31696002)(53546011)(26005)(66476007)(4326008)(6506007)(66946007)(6666004)(6636002)(8676002)(55236004)(66556008)(86362001)(186003)(66574015)(83380400001)(8936002)(6512007)(316002)(31686004)(2616005)(110136005)(36756003)(5660300002)(478600001)(38100700002)(2906002)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJhNVdjY2p4dzM2UnFMWnp1Sk0wSEMyRmVOSlA5U3JQeVdlM1A0VkNYN3JW?=
 =?utf-8?B?WWM0cmM0L2FVYkRiWnUyTzBpR2xmVDgzUnMvTnI4VmFrbng0TVhKeWtrN0pk?=
 =?utf-8?B?dVJhelIvVm40Qy93QmNEREpCakJYaUFsWlNzQkgvTmx5YXp4bkx6K3krME5m?=
 =?utf-8?B?QWdFemRpSkx4OXNyVUE1bzl2cDJ2LzZpRXN2V0VYczBXTHBLL3VCWXNXdGF1?=
 =?utf-8?B?RVNTYUJHNDVHOCsxZHRMejlzYzh2NE9GQkJnMk8xYU9Ec3JUeENJRm83Rldi?=
 =?utf-8?B?NjlORVFOYVNpZHJEUTVkQktxbGY3aGRGQ00rcms3cVVwVHJ5T1NtZVBYNkRa?=
 =?utf-8?B?NENMTDNZdnBmQ3NCa2hMUU1na04vRmNvLzBLZkNsbTQvdDZGeDllNDMrZ0lW?=
 =?utf-8?B?OGJ6V1ZoUmYwRGl4VjdUU2syM1VKMU4zZGhaVDdMM0lNSTNLaGlFcFZLUE9o?=
 =?utf-8?B?R1NWN2c5K09iTU5LR3NIem4zazFHUlNDR3drZGt0NHhvYm40bkZBODVVV3Vp?=
 =?utf-8?B?M0cxME9TSG80cGFrNWQ1TWtGaU55cnZZTlFIOUppTitmaGcyNUMrV0VKUllW?=
 =?utf-8?B?UHRGcG1hUk1ob3lMSnhNcG9EZmNtWWJUdHBkSnAxZzhDQ1UwcUh4L0REWXFy?=
 =?utf-8?B?bzZwTHU0RUo5dDNtOHBwYmFZRUNNUXQ1RExUSzdyZysrckRkYUFTNGZtTEo4?=
 =?utf-8?B?RUx6MDdVMzJKeTJ1ZVlidGNBZ1NPWVJtbkhaWWFWa0t5Mzlrd2Q1empDNGkz?=
 =?utf-8?B?b2NzS1oyeXJzQWVjS1IvRkhyL0pZYXZBUU1OUlFHUyt0Y2RidG40cjM5TlRD?=
 =?utf-8?B?S003NkdhUWRhekpqbjN3bG1pZytWNEV1VTR6MDlaM21FWHprTGFHWUEwZXNZ?=
 =?utf-8?B?RFdPTWlkd3BBc2ZvYU9lMkZJZUlEckk5bloxYXZlY1AydnJQTTVpTG5SSTdT?=
 =?utf-8?B?K2VaOGdRMGRlTE1DZ29nUlNicEpNSEwwcE5EZ3BZN1lCdEF3WENRRnl4b0Uw?=
 =?utf-8?B?czBDOUp3aXErcnhuMVFLZmU4Rklwdkk3OGxHZDNCbCs2cTgza0lJRlFqM0Vu?=
 =?utf-8?B?ZkVmRnZXcmFWWk5PNXBPckdLK2ptNmgveGo1djVFbm5IblVHTmU0Wm9yeUFh?=
 =?utf-8?B?Z0MwTHR6b2FyZWM2WnJSZ2FpcFlsRXA5MlA3UzA0VlZTRTRPWmxEb2pPSk85?=
 =?utf-8?B?bXR0QmtsdENJMlpackVacWxmQTZDNHF0NENzSGpzNGRoV0IwRWFPTnhWS2RF?=
 =?utf-8?B?Rm9kWFpYMVFKWGQwU2hJTERNcGZVQjFUSytOSVE0eEswOFY0K1JjeEF6S0R6?=
 =?utf-8?B?MFpTdHNKaTBZN3plTHhoV2dKRmYrOUEwRTVkTXJvK21HV2YyMzNVTFlrc3Zz?=
 =?utf-8?B?bnJVSUpLQlNYMnkzMC9neWN2elYycEp1cjJYV1Rna2NOL1BzZjdyOEdvWlly?=
 =?utf-8?B?aWQ2ZG5aTnR4dGZPUkwyY1djYWgrUzJZUzlGTEpYanhNUCsrVUFmYXVMbCtG?=
 =?utf-8?B?Q3BuWUhRd05RZVBHdWd5UEZCUGFTODJDdUFXdTk0ZVVQUjFTaXdwbHFwK3Jm?=
 =?utf-8?B?Yjc4emo4Y3Q0NkJVNE02VVk0MStrNHRGMGkyREs3bXBlTS9scUJkR0c1K1Bm?=
 =?utf-8?B?eHNGS1VVU1FFWnF3b21kK05UeVJwV1VyZUhmYVQyOUlmbDF5V0IvcFd2NWlw?=
 =?utf-8?B?U3FmTXE1UDNScUpEL25mQ1ZNTjh5OWttMm5iYmRoRVlLQVl2cmtQMURyTmls?=
 =?utf-8?B?MUZZVlozUWc3WDd4SjlrY3BoTjBWL0c2bUU2OU5GVEttOWlpcjB0aGUyNC94?=
 =?utf-8?B?Q3J0Ui9GWlMxRjgwcVpnbVdtZVYzU25sdjgxQTNkUjFLNitDT3V4UlpPbzF1?=
 =?utf-8?B?M1ZPckFtWGFRcmFwVHBJb1Rqa3JOTC9DS3BwUXdtQStPem93RFlSVVJ3eU1G?=
 =?utf-8?B?NnpWSTJrUmZ6ck1VMEhuZER3ZHVVVUNkOUUzais2OXB6OFpVOUZvbUN1SVJt?=
 =?utf-8?B?QXo3eHVmaitJWjFHTjY2WTNtdnBZRFg2VWpiUEJaSlFEYm1IejhzTnN0Q2VH?=
 =?utf-8?B?RXE5QkVMbXN2UXVqR3BSWlh0NEVDZDk0Q2pSVWZ6SXZLd3pYMUs0VmJ4SEZU?=
 =?utf-8?B?NVVya2xRVWJFTjN2UlhMejFxeTBRYnZEcXhzdWVaNmY2elcxZ3FRRmJNcXBt?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9063fbdc-5f46-4d95-703a-08daab9f4169
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:42:51.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qTfXtkh2DikCA3+jdm0E1Od9eFfvLOcgmXdJOwk4cP0sIeen05ZeGKigC1MYtCARHAqnb0ebUEgk9VFyTKdCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 28/09/2022 13:19, Pali Rohár wrote:
> Simplify pci-tegra.c driver code and use new PCI_CONF1_EXT_ADDRESS() macro
> for accessing PCI config space.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Please look also at this related patch:
> https://patchwork.kernel.org/project/linux-pci/patch/20220911113216.14892-1-pali@kernel.org/
> ---
>   drivers/pci/controller/pci-tegra.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 5df90d183526..c9924e75e597 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -417,13 +417,6 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>    * address (access to which generates correct config transaction) falls in
>    * this 4 KiB region.
>    */
> -static unsigned int tegra_pcie_conf_offset(u8 bus, unsigned int devfn,
> -					   unsigned int where)
> -{
> -	return ((where & 0xf00) << 16) | (bus << 16) | (PCI_SLOT(devfn) << 11) |
> -	       (PCI_FUNC(devfn) << 8) | (where & 0xff);
> -}
> -
>   static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>   					unsigned int devfn,
>   					int where)
> @@ -445,7 +438,9 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>   		unsigned int offset;
>   		u32 base;
>   
> -		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
> +		offset = PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn),
> +					       PCI_FUNC(devfn), where) &
> +			 ~PCI_CONF1_ENABLE;
>   
>   		/* move 4 KiB window to offset within the FPCI region */
>   		base = 0xfe100000 + ((offset & ~(SZ_4K - 1)) >> 8);


Our PCIe test on Tegra124 Jetson TK1 is currently failing on -next and 
bisect points to this commit. Looking at bit closer, the problem appears 
to be the PCI_CONF1_REG_MASK which has a value of 0xfc. Before this 
patch was applied a mask of 0xff was applied to the lower 8-bits of 
'where' and now it is 0xfc. So this does not work for Tegra as it is.

Let me know if you have any thoughts?

Jon

-- 
nvpublic
