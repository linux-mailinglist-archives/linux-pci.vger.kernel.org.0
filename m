Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08056B72C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiGHKT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiGHKT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 06:19:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242AE17A81;
        Fri,  8 Jul 2022 03:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcrqwmYrcIn//JarQepsqMBN5zBOSon78ezP9/6f9BnmYcctOnMVbHqUSl2jZt0eO4ASTyAGS1lLH8Y82XQgyyJtxfG/36HhDGftNHJM2/PD/cjCN3d2GRdfLbbiZoi2nRcUEjCRSLUVOLFxctc+TY6WoXY1rvXcsrwonRt992FCHntNSWLVt2whUFSxzDu47Va/DIzTUaskmSTLGzEj67RiEGY7nUk10DvRNfSzArVfB80l8Os7MdxpDTgs+DfXe+fnPAGaFU5xiZMAxVSbBcttGrSH4iwnsChbjP6mAXoPj0P16FaQGq9hHb2ZcIpOo0NK5KXE6NsnfHu7sFj+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/4Oyb/5p3wBPhZOzKjnt2emO2qnESK7tX4e6527oWk=;
 b=Yd2yMud+oIU8MxjTP8s1s/YhSw9wM2k/zpylvYz/7CoKPx18Dv3edzr2r2qmJ0zuJKxpzyv97atT+o0rPjTghMynszPxKzb2GAiEhrp7MMBVSswInjltALRHNMxCS50xqGgNfDsRLmA6AunDEBk1c/1+q9cH8/y4c9mD5zxA0zAdk56qO5Uvk6ZBP7+MNywO77a4kw4A+uedecgnQTBaGvcVsJuR5JYrD7ZG/J6zvFoufnIXdn+WBKj9Ejm3CbrwZwT+C92dmva8WYdthU+YAdIN9iaVaHKi/QAD55MwBJX4I8KrjRMRvuFN/kKGPzRCvz78GARNAsNvj7dtrZ2C1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/4Oyb/5p3wBPhZOzKjnt2emO2qnESK7tX4e6527oWk=;
 b=Ki8dq4RcEjL5tKAlpH7JgUVypuy1IDwMK5hyx8B/+07/EsGpZZa0MkWXfJMdoaSeQ2NxVgjnp1WEU7zbPFwpnlznaPiDjb8ScN87gGL3eha7YWKadsdNPv3ZDNP52ceGAHM154lqSPh/6DWTQj//GzgtF7S2E+CmWh38aHc09cqXShF0pluTq4PtnU+yUP1bUXv1oi8wCqQsvq5vzlYXn0pAO8hBux4Zm5e31gDSZemKx0w152k1vRcrj+Ac5/L4nTcIS/L2BS9GAIkw4FsJJhE1RREmAs50a0c+iFe3HPP++GdKICRcem3+fZ7t+BF58b/waa8Fb48fvXrqBsTpIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Fri, 8 Jul
 2022 10:19:23 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5395.022; Fri, 8 Jul 2022
 10:19:23 +0000
Message-ID: <02f878e7-e83e-ff17-1cd4-c2d54eda4dbd@nvidia.com>
Date:   Fri, 8 Jul 2022 15:49:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] PCI: designware-ep: Move DBI access to init_complete if
 notifier is used
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Om Prakash Singh <omp@nvidia.com>
References: <20220330060515.22328-1-manivannan.sadhasivam@linaro.org>
 <20220427101820.GC2536@thinkpad> <20220707165751.GB5458@thinkpad>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220707165751.GB5458@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::6) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8e2592-09bf-4f89-cf72-08da60cb53d7
X-MS-TrafficTypeDiagnostic: IA1PR12MB6355:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWgXzw8HMNATelnD4ljl+SmMdLayjXJaoWVc5lqkOwH0+zds7PAuZILjA6+j5wR/St/fHKkFaUIV51cVDWfxusyJ31IyZrcHEwcr1gt+6j3r5a+fSh6V49NeOezT7qBZ7IteIObUcn3IDKsHcP5JGpu5b52bRAxbVo0N+wocOrnRuQPiv9CuZnnfDqwYXmpe4Ks3zYr4ztjCMMd3umnVLMuvRjoEWQxbUYcF6hAYbDHU6flHry2oLkPp3T0dmPIs53CzFDUlpdwfN3HQ5nLNb6KmsTRG5HRE3H8XW3o1loABMhtubzMfepInVUxh3R6P45JP+6KFY+kemRn7DTDeEYRPDXkAPbku/WwXTHV47cCitY8ORCwi0qbeKVemtHON9BK50NEpP82VyWi8lrff976jdb2/UOZnetW+shUkFr5ibyK3zTp3NfJjituASiPbfgeAb5d3ga53Z2BHrhL6r29glnkzD9y/ABTkujLhF+yU2VwsKqfbvTuQCi0eV8oa1Yoz4czzcprLfrZqSkMklYY8aMFJ5L0I6YGt1CukTnQcsjxXgkjLCRnX5E96jkoEkNzshaNH3dVMCtDz0MnC3+s6nmdUrEPIqeNzE+0GJjqWpjjcG0i53svbNrCRi6KRRTyIXq76jKeeV8EUgZ2TRyrrIhi3aAfiOI3pCPU/b1Jo8R0d6Mgzp447bWJED1c7A4zrnuYP5Msu0ADN72LL70k4q1ISRI+GlJAkmj+oM/gjxu8hO+eP0rxFK/W3h0QCcNLuR6+SIYSi4J70Djg0UNhwkR98mDSEruGKVgTnqItHItqwinAY0T5CG6vHPsQi8gHUAIU53ijSZC7Rg9PqGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(83380400001)(31696002)(6666004)(41300700001)(54906003)(316002)(6512007)(186003)(8936002)(5660300002)(4326008)(2906002)(26005)(36756003)(6506007)(66946007)(107886003)(66476007)(6486002)(86362001)(31686004)(2616005)(8676002)(53546011)(38100700002)(478600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUJQalNYVVMxREx6SXZTTzlJY3J0WllISXQ2UzVNMVU0a0dsWXFCVnBpOXFk?=
 =?utf-8?B?K0plemw3QlFHaHRjUSt1bEJXWEs1QTNaRmczbW92Yy8vOGFFNkRteHlPUjho?=
 =?utf-8?B?SGFBcXFDVDNNZEMvQjNaRWYwc0c3anR0VGhCYzZmZGFOSkNET2ZaSFdUVlA5?=
 =?utf-8?B?N1NCSzNHcWl3cytiY1pPUUNYdEgrd0lPbzdFN0xGSEFFZW5neWhpQTg4Z3Ft?=
 =?utf-8?B?YWY4enZTUElvUlUwSTZRN2pYcCtXbDJLNFhHNWtTb3owT1Y5STNXelJMY2tU?=
 =?utf-8?B?d1h5Znd6MTI4dGlqbEMyUVVaWldKclg2dXcwLysweDloOVRVaG91cEFPbW93?=
 =?utf-8?B?U2pBYzgzUitFcEtUSWFZZk1vK29ld3BFbXFCU1dXU1hJSEx6SzB4eFkxeFZa?=
 =?utf-8?B?R0t4bU55anNoUWdOMU1JdnFQdVVGNmNqQU9jcklZOFlxM1l3WW5GUWFSenFW?=
 =?utf-8?B?T201NWJ1VVFzaE9Ya3F3WDdxcUxqSk5uMWQyZEZBWUVXN2lieitpU3M5SUkv?=
 =?utf-8?B?cHZvajg4d29FQklrNDV4NFd0c0pDMllUcDYycEprYklNNUhiL1RNZE5RTGVk?=
 =?utf-8?B?ZTZGa0JlMUsyWXhPaUJJNFluNWpTdGEwUmJGMUR2ZkwvcVpsV1NSdGgxc3VW?=
 =?utf-8?B?M1NFaEh2Nnpja0p3UElwTkNlTzBkVVpkVEkydjIvMFJPWTc5S0RCL0RxVDYw?=
 =?utf-8?B?SlJWK3JwdXdPWFpKS2NqRXd3b1g2eEFUVVpnbmkrTUE4MXV0ckxISEZnSTYx?=
 =?utf-8?B?MXYwcE8yYlhzR3VZQkwrdVprUGM3QlBMS2NScDZmdnN0enFWakNuaFRWZ3J1?=
 =?utf-8?B?Nmc0bTFHQkZpQTIyZjBFeDdveVVZRTMwOHdHNDA0WmlGQ09kUW5yRXVWakNz?=
 =?utf-8?B?RjlSbHRMZnBObDZmWEpEdVgrR2Q0Wmh4aGdvMW5ZeU03Z2NvclZVWmxKaThP?=
 =?utf-8?B?MlQ1M0Q1Zzhacy80OUQwUEMyTUw0eEZXU2VhVW5XNnBjcmdkSmU3NEZXR3V6?=
 =?utf-8?B?YysraWllR2dQU0dRRHFoUzdaOW1hck5VZ2hlMFNvbXliQ082clY0NTQ5OGxH?=
 =?utf-8?B?MEFNdXBmR1lWakNNNmFTVG0vcVphSXRsU3IxZTRxK3c3b2QwVTFyOG55QUtx?=
 =?utf-8?B?M2hxdWhvRGpwVnF3MHZyNmhYMW1VT2V5SFM3UTUveVNsZTUySG5TV1R2dXk2?=
 =?utf-8?B?M09waTYza3lpcUZ3VTZ3T0FEVEc3VlpFYkpZMzBXZUJucVNRNHpWcGMvNlFl?=
 =?utf-8?B?SkpBU3R3ZnFiRy9scGpKc3liQXNJZVFrQzY0TFJKQnZIV1UvNTJmR1hrMU9w?=
 =?utf-8?B?TVhrMlJXRVR4UmxHVmV3RDc4cHMraEU3d1A1QTNEWitFZHNwdmFJQ2ZMS1pv?=
 =?utf-8?B?MzcvNVkydmprTnFDcmpnV2lZQUxBZ1QvblN5V05FVVhsSGs0dDhHbm9jbW5n?=
 =?utf-8?B?cTRqellTU1hJYWZpaHZ0dk5TYzYyT2E4TmpkRnNLNXI5b3hsTkVkYkNmTy96?=
 =?utf-8?B?ajVNQTF6VEg0ZmwzTWhvOW8xNDhqZWYrMndoQncxN2kwMmt5NURlV3lRNlVX?=
 =?utf-8?B?c2NEYzlxcVkxcjAyd3pNdE52YXo4bnhhU1RVUXIxY0ZVUVRYT3htbDQ2U3lH?=
 =?utf-8?B?NVRzb05NZWc0WDI0WWdjSTBaQnloV25aRmdCWWZJeDdxdzRtNC8zVC80QThh?=
 =?utf-8?B?bVJ2cFBPRVI2ajg4OTRXNHBhaFNOaGNGcnpxWjJSYkNVZmFLbWI5aE9UN3Z3?=
 =?utf-8?B?SmVsTnNaNGs5V2Z6ZUtKUFM1Nm9waTh2VjRvenNjTXByMGVPNVJDd2F0S3ow?=
 =?utf-8?B?bWFGelV6YW1VUFRWTXJFd3dZLzJPZzVIZSszMk5tL0JIb28vc29GNU04ZXoz?=
 =?utf-8?B?dWM4ZndiUnJNZjNHaW5DN291Wk1FMzFFMUtoMFQvS2MvVGMrVU1pdnMwaGdl?=
 =?utf-8?B?VFZTdHhPUHltTkZVVCtWMkZKTldUTjdtc2JQR3JTL1JNYldhVG1PR3puMVJ6?=
 =?utf-8?B?SFZJM2tNUkp1WUFic0xCNGFVZk12TTQrbXE5Q0o2UEdYOEZMci9Xdkg5ZmJG?=
 =?utf-8?B?eERTN1poUlRXT0ovbDQ2OFJmemlzRWJ5Z3dWdWFsTE1JcGQ5NjMxa2cvZ295?=
 =?utf-8?Q?SXq4ftETTWaLp1uFgTeA8eHnn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8e2592-09bf-4f89-cf72-08da60cb53d7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 10:19:23.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTuqJJU12FehpAsmvK47XvL8HQRqOu/oFcmqG94UKXNTPifDlCF1v1BP7jQwoquTWGwX3TZc7WqS4/G7f3edHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have a minor comment. Otherwise this patch looks fine.
I verified it on Tegra194 and it works as expected.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Tested-by: Vidya Sagar <vidyas@nvidia.com>

On 7/7/2022 10:27 PM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Apr 27, 2022 at 03:48:26PM +0530, Manivannan Sadhasivam wrote:
>> On Wed, Mar 30, 2022 at 11:35:15AM +0530, Manivannan Sadhasivam wrote:
>>> For controllers supporting the CORE_INIT notifier, the resources are
>>> supposed to be enabled in the init_complete function. Currently,
>>> these controllers are enabling the resources during probe time due to
>>> the DBI access happens in dw_pcie_ep_init().
>>>
>>> This creates the dependency with the host PCIe controller since the
>>> resource enablement like PHY depends on host PCIe to be up. For the
>>> standalone endpoint usecase, this would never work. So let's move all DBI
>>> access to init_complete function if CORE_INIT notifier is used. For the
>>> controllers those doesn't support this notifier, this change is a NO-OP.
>>>
>>> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> Cc: Om Prakash Singh <omp@nvidia.com>
>>> Cc: Vidya Sagar <vidyas@nvidia.com>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> A gentle ping on this patch!
>>
> 
> Ping again!
> 
> Thanks,
> Mani
> 
>> Thanks,
>> Mani
>>
>>> ---
>>>   .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
>>>   drivers/pci/controller/dwc/pcie-designware.h  |   1 +
>>>   2 files changed, 94 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> index 0eda8236c125..fb2bf4bf5ba0 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> @@ -636,6 +636,63 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>>>      return 0;
>>>   }
>>>
>>> +static int dw_pcie_iatu_config(struct dw_pcie_ep *ep)

How about using dw_pcie_ep_iatu_config() name? Just added 'ep' to be in 
sync with other API names in this file.

>>> +{
>>> +   struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> +   struct device *dev = pci->dev;
>>> +   void *addr;
>>> +
>>> +   dw_pcie_iatu_detect(pci);
>>> +
>>> +   ep->ib_window_map = devm_kcalloc(dev,
>>> +                                    BITS_TO_LONGS(pci->num_ib_windows),
>>> +                                    sizeof(long),
>>> +                                    GFP_KERNEL);
>>> +   if (!ep->ib_window_map)
>>> +           return -ENOMEM;
>>> +
>>> +   ep->ob_window_map = devm_kcalloc(dev,
>>> +                                    BITS_TO_LONGS(pci->num_ob_windows),
>>> +                                    sizeof(long),
>>> +                                    GFP_KERNEL);
>>> +   if (!ep->ob_window_map)
>>> +           return -ENOMEM;
>>> +
>>> +   addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
>>> +                       GFP_KERNEL);
>>> +   if (!addr)
>>> +           return -ENOMEM;
>>> +
>>> +   ep->outbound_addr = addr;
>>> +
>>> +   return 0;
>>> +}
>>> +
>>> +static int dw_pcie_ep_func_init(struct dw_pcie_ep *ep)
>>> +{
>>> +   struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> +   struct dw_pcie_ep_func *ep_func;
>>> +   struct pci_epc *epc = ep->epc;
>>> +   struct device *dev = pci->dev;
>>> +   u8 func_no;
>>> +
>>> +   for (func_no = 0; func_no < epc->max_functions; func_no++) {
>>> +           ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
>>> +           if (!ep_func)
>>> +                   return -ENOMEM;
>>> +
>>> +           ep_func->func_no = func_no;
>>> +           ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
>>> +                                                         PCI_CAP_ID_MSI);
>>> +           ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
>>> +                                                          PCI_CAP_ID_MSIX);
>>> +
>>> +           list_add_tail(&ep_func->list, &ep->func_list);
>>> +   }
>>> +
>>> +   return 0;
>>> +}
>>> +
>>>   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>>   {
>>>      struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> @@ -643,7 +700,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>>      unsigned int nbars;
>>>      u8 hdr_type;
>>>      u32 reg;
>>> -   int i;
>>> +   int ret, i;
>>> +
>>> +   if (ep->core_init_notifier) {
>>> +           ret = dw_pcie_iatu_config(ep);
>>> +           if (ret)
>>> +                   return ret;
>>> +   }
>>> +
>>> +   if (ep->core_init_notifier) {
>>> +           ret = dw_pcie_ep_func_init(ep);
>>> +           if (ret)
>>> +                   return ret;
>>> +
>>> +           if (ep->ops->ep_init)
>>> +                   ep->ops->ep_init(ep);
>>> +   }
>>>
>>>      hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
>>>                 PCI_HEADER_TYPE_MASK;
>>> @@ -677,8 +749,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>>>   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>   {
>>>      int ret;
>>> -   void *addr;
>>> -   u8 func_no;
>>>      struct resource *res;
>>>      struct pci_epc *epc;
>>>      struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> @@ -686,7 +756,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>      struct platform_device *pdev = to_platform_device(dev);
>>>      struct device_node *np = dev->of_node;
>>>      const struct pci_epc_features *epc_features;
>>> -   struct dw_pcie_ep_func *ep_func;
>>> +
>>> +   if (ep->ops->get_features) {
>>> +           epc_features = ep->ops->get_features(ep);
>>> +           if (epc_features->core_init_notifier)
>>> +                   ep->core_init_notifier = true;
>>> +   }
>>>
>>>      INIT_LIST_HEAD(&ep->func_list);
>>>
>>> @@ -708,7 +783,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>              }
>>>      }
>>>
>>> -   dw_pcie_iatu_detect(pci);
>>> +   if (!ep->core_init_notifier) {
>>> +           ret = dw_pcie_iatu_config(ep);
>>> +           if (ret)
>>> +                   return ret;
>>> +   }
>>>
>>>      res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>>>      if (!res)
>>> @@ -717,26 +796,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>      ep->phys_base = res->start;
>>>      ep->addr_size = resource_size(res);
>>>
>>> -   ep->ib_window_map = devm_kcalloc(dev,
>>> -                                    BITS_TO_LONGS(pci->num_ib_windows),
>>> -                                    sizeof(long),
>>> -                                    GFP_KERNEL);
>>> -   if (!ep->ib_window_map)
>>> -           return -ENOMEM;
>>> -
>>> -   ep->ob_window_map = devm_kcalloc(dev,
>>> -                                    BITS_TO_LONGS(pci->num_ob_windows),
>>> -                                    sizeof(long),
>>> -                                    GFP_KERNEL);
>>> -   if (!ep->ob_window_map)
>>> -           return -ENOMEM;
>>> -
>>> -   addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
>>> -                       GFP_KERNEL);
>>> -   if (!addr)
>>> -           return -ENOMEM;
>>> -   ep->outbound_addr = addr;
>>> -
>>>      if (pci->link_gen < 1)
>>>              pci->link_gen = of_pci_get_max_link_speed(np);
>>>
>>> @@ -753,23 +812,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>      if (ret < 0)
>>>              epc->max_functions = 1;
>>>
>>> -   for (func_no = 0; func_no < epc->max_functions; func_no++) {
>>> -           ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
>>> -           if (!ep_func)
>>> -                   return -ENOMEM;
>>> -
>>> -           ep_func->func_no = func_no;
>>> -           ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
>>> -                                                         PCI_CAP_ID_MSI);
>>> -           ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
>>> -                                                          PCI_CAP_ID_MSIX);
>>> +   if (!ep->core_init_notifier) {
>>> +           ret = dw_pcie_ep_func_init(ep);
>>> +           if (ret)
>>> +                   return ret;
>>>
>>> -           list_add_tail(&ep_func->list, &ep->func_list);
>>> +           if (ep->ops->ep_init)
>>> +                   ep->ops->ep_init(ep);
>>>      }
>>>
>>> -   if (ep->ops->ep_init)
>>> -           ep->ops->ep_init(ep);
>>> -
>>>      ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
>>>                             ep->page_size);
>>>      if (ret < 0) {
>>> @@ -784,12 +835,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>              return -ENOMEM;
>>>      }
>>>
>>> -   if (ep->ops->get_features) {
>>> -           epc_features = ep->ops->get_features(ep);
>>> -           if (epc_features->core_init_notifier)
>>> -                   return 0;
>>> -   }
>>> +   if (!ep->core_init_notifier)
>>> +           return dw_pcie_ep_init_complete(ep);
>>>
>>> -   return dw_pcie_ep_init_complete(ep);
>>> +   return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>> index 7d6e9b7576be..aadb14159df7 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -242,6 +242,7 @@ struct dw_pcie_ep {
>>>      void __iomem            *msi_mem;
>>>      phys_addr_t             msi_mem_phys;
>>>      struct pci_epf_bar      *epf_bar[PCI_STD_NUM_BARS];
>>> +   bool                    core_init_notifier;
>>>   };
>>>
>>>   struct dw_pcie_ops {
>>> --
>>> 2.25.1
>>>
> 
> --
> மணிவண்ணன் சதாசிவம்
> 
