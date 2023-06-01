Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E229071A1FB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjFAPI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 11:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjFAPI6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 11:08:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02FE63;
        Thu,  1 Jun 2023 08:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZfuJeAvm5p2kQdKRczh0lp43Uk54e0RDq2CapCHFOJYzQmErM2rig4BXtXrbVqRkvmI/ienS9g+34GJBnji7RAAuc6UY7vxyF4jKtgMcnkdMg8L3B8YN8Qpb5GH5Cd3CoDDPdXKJUFGOgP1OB/ELj4RV9VY376agQvlLqqxOca248aQ6rY+wrm/oF8yckopw7LDe59BkzwM8IfuO+4HQmURXjiJyOTE/fy6q8PxgaSujqh+VNQVOiBU9aAICJCqHfZuJai3K8LHE9nBPpWzPXILV1ATQRQ3UI2vpvHdSeBSIhL1GvHr1ztVQlDMPEKzmCLEUXAdRsSe1h5ge1t79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RV6ZYS1Yrchb9CvmD+jjDsU+j3fgcVrJBAWLC1zZL4=;
 b=PAqpuhNzLaXd0NObhqUNLwzdNAikuaNGe+4ARoZLhJ9yYHP2Cst9xb3L+q23fOIyIohvFMkS5vxfwpTgiVr7pKrVPGYpEXcXPQQu6JUtwKSyS97T4BCCK1ZJtnNZqAaNSiiY6mPS/2Thm7rOWYWzkogDjexcUtqCQDVUcUcRqT2CsUkdC6A3y9nUIhPbnRAY5pJ3sFZnsIkrJbm3QPRUfA5Ra5K00tJvD1xI279DMhRuIfZlVqexlf3AjHU+Pf+uyexWcDVPpCc6cPQNtVz1cbd4UM+3V5SVzUxawUMqjID4UhEN6P3Uf5SQ+2aqg8Bvk2Zkq8F8cPbxbOwpVd855Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RV6ZYS1Yrchb9CvmD+jjDsU+j3fgcVrJBAWLC1zZL4=;
 b=WKf35nvTF54pEfA3ZC/5K6u4WjD1hfRa82MP8WarzQb42yke8GIAtHZIe4a0cQ0yNyQGR6C0NXTtl1zUxrGwKErV0+KL/fLKMOkKqQ/HLYGBjgNNCL8VYgsuzYGOcS0k3FhpLvjh/gB7ftCy1TpMldBsTIv/2YR/wm/9cjJDwvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) by
 MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Thu, 1 Jun 2023 15:07:08 +0000
Received: from DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::5ce6:1e12:bbb5:716f]) by DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::5ce6:1e12:bbb5:716f%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 15:07:08 +0000
Message-ID: <e417f2c9-1fcb-cf57-3524-1408c9aae5fa@amd.com>
Date:   Thu, 1 Jun 2023 20:36:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware
 map/unmaping
Content-Language: en-US
To:     Shunsuke Mie <mie@igel.co.jp>, Jingoo Han <jingoohan1@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230113090350.1103494-1-mie@igel.co.jp>
 <20230113090350.1103494-2-mie@igel.co.jp>
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20230113090350.1103494-2-mie@igel.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To DS7PR12MB5839.namprd12.prod.outlook.com
 (2603:10b6:8:7a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5839:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 2116fd83-4f41-4064-cb4b-08db62b1de08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Grfb5kIM55X055EegLBXYyoO7H51Pp6XJOjRcRjIPwBRVLATNw2Hu0lPrYUtd7aTsGYGI64n6zItkVip1a/Y/4llJ42dPTS3zAQM517/oIdCgLQPB1545wEaNOdL6isa4ga5OmG+ccuunP0Qeh7I9bQ9GdxcBk8s7PUb23Oes4LCHEXwUiopYJzfAvmGDNb3/Tuu0tfcnmuF1LEcsFGrmCs7uud4As1/6N5+23UGOemewleoEzwXyJVb1XhdvgP4sM1JV+UvckUq7ZwoxarQD6KBq1GPowYtkwQn70qrMB9Jhrn29jRA91agi1XPrS1/t3zgVoOiK9FZ0gGfQAGhdq6/4sWr7ttjdw9B3YhmuFTf++nkmW2kYa7Ap/qOCZXxbvWk2N3+lniy+3FiOQRs7s7ifuqZimcOh5m6HYWveKzGaLG8tEHyuUR591iEo+sfq/R7xfW8IJsHoGLCBEk5sdFlFGFftLc0HGBcA5PGx6XUfySGodOfsjrS2LzVJJYtU6rmEMf/MhEgBMAN6QjB+fKJpGVYBeldbgueY/EVuMpxujKam+oKnPr5mCPGNhJddGfuZUOZqURVxl7xnH9VLGpduwnhYC5trz5kWdHvVbpFPC0+KKwozcR3IhGuMlPyRpGfj+Lz6s5VxnAogHDfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5839.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(53546011)(38100700002)(54906003)(110136005)(36756003)(2906002)(66946007)(478600001)(66476007)(66556008)(4326008)(31686004)(6506007)(6512007)(26005)(316002)(7416002)(6666004)(186003)(6486002)(83380400001)(41300700001)(5660300002)(8676002)(31696002)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3pFYkZaczBmcGs0NWlhRy9xZWRBVUNSaTc0NWlYazFselRSTmFNaWx3akp6?=
 =?utf-8?B?eXQybkRscmV2Nm9sQ3VaTXJyTUdySS9pMUtyNTI1dXdjVHAycU5CMzBaQXhQ?=
 =?utf-8?B?K0laUTAyMlgxcWpHK09ydEtUdWFud1M3VG1nVXlTOHBsUFJOSlJuL2tvM0Ja?=
 =?utf-8?B?bzUxdWdwaEtFSi9Wc3F6aTJCdkYxbnIxNlRqYWhiZ05OQXVvSW41NWpBRnd0?=
 =?utf-8?B?NzBKSjNhNERLM2JQMTlUM3RtZmF0UnNsVDVKWjNzQlMzeFNmSDMxNDIxK3Fx?=
 =?utf-8?B?Uk8vNkI5ZmdaNHdxdktDSm8rZE5PenN5MkJ6MjhRWGExa3ZLQ3pMa2JJbVFQ?=
 =?utf-8?B?WVc5YnhCTVZjZ0ZjQUhoSCtpMUxmVm5NTk9kemZPOGlVTlZ1SnI0UnpHaHkw?=
 =?utf-8?B?Q2ExS3dtRGhSWDNuVHcyKzFCWG51MGlMWkk3bEpjK3QrM0toeEMyK2kvNjA4?=
 =?utf-8?B?REU3akN5RVh5MGVRNUdSOFVsaHhieENhejBTSVltNFpWbGo3NlVZKzN1V2NV?=
 =?utf-8?B?SS83cTZ2WG93VFU2QUsxRHhuVkFtRVFEelpVZnluV0pSam5pK252MEpQTGYw?=
 =?utf-8?B?QldwK2lXOVV6dW0yRDdnNnM1akxuSk5wRmcvbmsvc0ViaWdWeHMzaTQwWHZv?=
 =?utf-8?B?bWVTdnR1RVhHUjlQNzJCTVI5eGRWand5WXJXbXIzRW14M1FFZHQxd25RNzJz?=
 =?utf-8?B?Zk9SNzhsQkNzNS8yNHdNejJ6ekk2S2xtM3A5OXI0dHlpd25UdnR0R0hUUmxu?=
 =?utf-8?B?NDFkNjhuNDgvYlZJK09NeUNpNnBITHVMOTNSL3M1M1draFdsWXpnRmtLa2RX?=
 =?utf-8?B?RWRHTU9NVHZ3S0NyTnZCTlEzWEpHeDBzZFdud3lGNGtFZlFoUXFSa1phWVZx?=
 =?utf-8?B?ZkdlYllpT1lycHI1czExVnQwYUs1alV4QVJadmUybE90aFBmNi9YZytWL3Vr?=
 =?utf-8?B?S3I3SVhYbWt4eGNpaGFtL3VDalRFK0w2OWpUZ21YczAyc1NlMVhWT3QwOWhO?=
 =?utf-8?B?VDlrWHFEZWNjVGZrZDVCaHluN2FXWWQ5NXFiZzVkcVVHNG5jUWlZS1dCREl2?=
 =?utf-8?B?WlA1QWMwZkFlSXY4Ty9hU2RNNllqd3RBMGR5Vlk2S3laZ3U5dW1GanpqOHZx?=
 =?utf-8?B?MmpyU3lwN0tHOWVMMjc1d0QxcEQ2ZWJqTTJGT2JOZVhXaUFiNXRyS2ZOMjJl?=
 =?utf-8?B?VUZZWEZ3bzI4Yk9VS3drT3NoQm1OZFNtdHYzbVJqSVZUNzgvNGxBU21tSWRP?=
 =?utf-8?B?YW1Vb2IyVlZLaC9SM3BhdWNRSmYyaUJ2NWoyZmZOdXJGNVBKOWwwdnVkZ3FC?=
 =?utf-8?B?aFRPVS84MTBOQXgrZ0FjcnZxeEJJT2VmbVZPRG1QK2g3SGpUQjVDUy80dnRF?=
 =?utf-8?B?d2ZjcDhBQndPWnZoMWt1anNpWWVacmNTdHpsaHBseGI3KzhuNk9TcjFQWU02?=
 =?utf-8?B?akJ4Ly85d1h4RXBwdjJDOEIvd1dlV2ROWWpza3FIcVJPWTFYd3hBWFRheVpP?=
 =?utf-8?B?cFE3dkh1QzhmL3hXRmZiL3JnZjZRWnNKcEJHdzdHQjltRDEydERBRi9zNnRH?=
 =?utf-8?B?UC9Id0tNTzRjT2FvQ0hZMDBZQ280N1RXWkxudzAvV0RvYnluU0ExSFl1UDZG?=
 =?utf-8?B?U3c4OWE3WUxKT0l5blJBM25Va1B6NlRyS2ttRk40ZWtacVdnd2creHc4dWIz?=
 =?utf-8?B?anJ2Ym9BdERkWGVIRWNyWDdXM3dYMENvR2YvdVdYbGZRMEFBV25hUlJhanlx?=
 =?utf-8?B?WkR0ZDNBdk1CeDFVV1czTjA1WmVCQ0dJUWZKeXRRZGtNREpMbXdmVTY3TWVP?=
 =?utf-8?B?ZnRpL0tZNHVaL09DM1JmME5tbHQxcENLTndyT0FIZ3ZuZDZpcG9ndzBKWEQ3?=
 =?utf-8?B?dGIxYWZMbHp3aktRR3hPWklFVnQvbU9SM050dWdnQjk4Y1VJOE1ZdjFVakto?=
 =?utf-8?B?R2Rpa1cwMkdEVzNKRm5qV3BvbjFkNUZuOVBROXoyQVVqT0ZVbzB6R0QzRnNi?=
 =?utf-8?B?aDJlb09NekpUVWkrWngxSW5sREhiNXdVSm96RmEwOTh2WWwydXpWS3lYN3ZL?=
 =?utf-8?B?eXlvdjdDM0hpdy92WiszVE42c2VKMCt4Q3pIQWVxOFFoVUczYUp6bFBwNXJ5?=
 =?utf-8?Q?8K7HnfDgKMKopmHptpBtEVnn+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2116fd83-4f41-4064-cb4b-08db62b1de08
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 15:07:08.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yp1zWslCpJLrLDvJRh5Hka3b82TH9yVmi7MJW2g4Su6c8HbD/ukYx4A3lmjmxyYvaXRthyZQYNTdSXK3oMJOPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shunsuke,

On 1/13/2023 2:33 PM, Shunsuke Mie wrote:
> Add an align_mem operation to the EPC ops, which function is used to
> pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
> restriction of EPC. The map function maps an aligned memory to include a
> requested memory region.

I'd prefer all the PCIe address alignment restriction be handled in the 
endpoint function drivers and not inside the core layer (esp in map and 
unmap calls).

IMO, get the pci address alignment restriction using pci_epc_features. 
And use a bigger size (based on alignment restriction) in 
pci_epc_mem_alloc_addr() and access the allocated window using an offset 
(based on alignment value). You can add separate helpers if required.

Thanks,
Kishon

> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>   drivers/pci/endpoint/pci-epc-core.c | 57 ++++++++++++++++++++++++-----
>   include/linux/pci-epc.h             | 10 +++--
>   2 files changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2542196e8c3d..60d586e05e7d 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -430,8 +430,12 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>    * Invoke to unmap the CPU address from PCI address.
>    */
>   void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -			phys_addr_t phys_addr)
> +			phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
>   {
> +	u64 aligned_phys;
> +	void __iomem *aligned_virt;
> +	size_t offset;
> +
>   	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>   		return;
>   
> @@ -441,9 +445,22 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>   	if (!epc->ops->unmap_addr)
>   		return;
>   
> +	if (epc->ops->align_mem) {
> +		mutex_lock(&epc->lock);
> +		aligned_phys = epc->ops->align_mem(epc, phys_addr, &size);
> +		mutex_unlock(&epc->lock);
> +	} else {
> +		aligned_phys = phys_addr;
> +	}
> +
> +	offset = phys_addr - aligned_phys;
> +	aligned_virt = virt_addr - offset;
> +
>   	mutex_lock(&epc->lock);
> -	epc->ops->unmap_addr(epc, func_no, vfunc_no, phys_addr);
> +	epc->ops->unmap_addr(epc, func_no, vfunc_no, aligned_phys);
>   	mutex_unlock(&epc->lock);
> +
> +	pci_epc_mem_free_addr(epc, aligned_phys, aligned_virt, size);
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>   
> @@ -458,26 +475,46 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>    *
>    * Invoke to map CPU address with PCI address.
>    */
> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		u64 pci_addr, phys_addr_t *phys_addr, size_t size)
>   {
>   	int ret;
> +	u64 aligned_addr;
> +	size_t offset;
> +	void __iomem *virt_addr;
>   
>   	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   
>   	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   
>   	if (!epc->ops->map_addr)
> -		return 0;
> +		return ERR_PTR(-ENOPTSUPP);
> +
> +	if (epc->ops->align_mem) {
> +		mutex_lock(&epc->lock);
> +		aligned_addr = epc->ops->align_mem(epc, pci_addr, &size);
> +		mutex_unlock(&epc->lock);
> +	} else {
> +		aligned_addr = pci_addr;
> +	}
> +
> +	offset = pci_addr - aligned_addr;
> +
> +	virt_addr = pci_epc_mem_alloc_addr(epc, phys_addr, size);
> +	if (!virt_addr)
> +		return ERR_PTR(-ENOMEM);
>   
>   	mutex_lock(&epc->lock);
> -	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
> -				 size);
> +	ret = epc->ops->map_addr(epc, func_no, vfunc_no, *phys_addr, aligned_addr, size);
>   	mutex_unlock(&epc->lock);
> +	if (ret)
> +		return ERR_PTR(ret);
>   
> -	return ret;
> +	*phys_addr += offset;
> +
> +	return virt_addr + offset;
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>   
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index a48778e1a4ee..8f29161bce80 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -84,6 +84,7 @@ struct pci_epc_ops {
>   			       phys_addr_t phys_addr, u8 interrupt_num,
>   			       u32 entry_size, u32 *msi_data,
>   			       u32 *msi_addr_offset);
> +	u64	(*align_mem)(struct pci_epc *epc, u64 addr, size_t *size);
>   	int	(*start)(struct pci_epc *epc);
>   	void	(*stop)(struct pci_epc *epc);
>   	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
> @@ -218,11 +219,12 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>   		    struct pci_epf_bar *epf_bar);
>   void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>   		       struct pci_epf_bar *epf_bar);
> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -		     phys_addr_t phys_addr,
> -		     u64 pci_addr, size_t size);
> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			       u64 pci_addr, phys_addr_t *phys_addr,
> +			       size_t size);
>   void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -			phys_addr_t phys_addr);
> +			phys_addr_t phys_addr, void __iomem *virt_addr,
> +			size_t size);
>   int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>   		    u8 interrupts);
>   int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
