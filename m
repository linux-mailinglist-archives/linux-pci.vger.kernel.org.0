Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A156171F6C5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 01:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFAXnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjFAXnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 19:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F83192;
        Thu,  1 Jun 2023 16:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8ADB64AED;
        Thu,  1 Jun 2023 23:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBA4C433EF;
        Thu,  1 Jun 2023 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685663014;
        bh=LK1OcRJR2YaCdVUPe9jtyPLWIHcju1UVxCsjRu7wb1E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fRaq7ksNki6R3iFjEBjNrHgnjQiwnra3W2xmbAHUhAnCBuQFKXDcRJpMr2ej/N1hp
         3NjsJs/T9pCHxtYd8ImStsvau/wOvApJacdBWa7Cb74rTF2P2S1+HzFRMkj1YlBftk
         hn+qR5oigmVwh9sJnTtJ8fzDWAeVDdP4cIyhgpyskMqEphwoQPLN53dN/Al5z5xOoQ
         XQVMpZ6iNvmvjy5LHfixTJS+eqEc0jAV6895wegC4GWCuYxd0jPS+1mM++ORkaBSSf
         TLYl5FhGHEN1Fdx9h9yfFbrwDMOC4fJqY1h7wHLWfmFG6lqr7zsG8OepyQ3vITAfGN
         eqFUybFja+X0w==
Message-ID: <978b63ac-90b5-b909-d259-0668b77f1cc8@kernel.org>
Date:   Fri, 2 Jun 2023 08:43:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware
 map/unmaping
Content-Language: en-US
To:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230113090350.1103494-1-mie@igel.co.jp>
 <20230113090350.1103494-2-mie@igel.co.jp>
 <e417f2c9-1fcb-cf57-3524-1408c9aae5fa@amd.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e417f2c9-1fcb-cf57-3524-1408c9aae5fa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/2/23 00:06, Kishon Vijay Abraham I wrote:
> Hi Shunsuke,
> 
> On 1/13/2023 2:33 PM, Shunsuke Mie wrote:
>> Add an align_mem operation to the EPC ops, which function is used to
>> pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
>> restriction of EPC. The map function maps an aligned memory to include a
>> requested memory region.
> 
> I'd prefer all the PCIe address alignment restriction be handled in the 
> endpoint function drivers and not inside the core layer (esp in map and 
> unmap calls).

That is a really *bad* idea ! Most function drivers should be able to work with
any EP controller hardware. Asking these drivers to support all the alignment
peculiarities of every possible EP controller is impossible.

> IMO, get the pci address alignment restriction using pci_epc_features. 
> And use a bigger size (based on alignment restriction) in 
> pci_epc_mem_alloc_addr() and access the allocated window using an offset 
> (based on alignment value). You can add separate helpers if required.

That is too simplistic and not enough. Example: Rick and I working on an nvme
function driver are facing a lot of issues with the EPC API for mem & mapping
management because we have 0 control over the PCI address that the host will
use. Alignment is all over the place, and the current EPC memory API
restrictions (window size limitations) make it impossible to transparently
handle all cases. We endup with NVMe command failures simply because of the API
limitations.

And sure, we can modify that driver to better support the EP controller we are
using (rockchip). But we need to support other EP controllers as well. So API
changes are definitely needed. Working on that. That is not easy as the mapping
API and its semantic impacts data transfers (memcpy_from|toio and DMA).

I do have a patch that does something similar as this one, but at a much higher
level with a helper function that gives the function driver the offset into the
allocated memory region to use for mapping a particular PCI address. And then
this helper is then in turn used into a new pci_epc_map() function which does
mem alloc + mapping in one go based on the EPC constraints. That hides all
alignment details to the function drivers, which greatlyu simplyfies the code.
But that is not enough as alignment also implies that we have to deal with
boundaries (due to limited window size) and so sometimes endpu failing a mapping
that is too large because the host used a PCI address close to the boundary.
More work is needed to have pci_epc_map() also hide that with tricks like
allowing the allocation and mapping of multiple contiguous windows. So EPC ops
API changes are also needed.


> 
> Thanks,
> Kishon
> 
>>
>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>> ---
>>   drivers/pci/endpoint/pci-epc-core.c | 57 ++++++++++++++++++++++++-----
>>   include/linux/pci-epc.h             | 10 +++--
>>   2 files changed, 53 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 2542196e8c3d..60d586e05e7d 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -430,8 +430,12 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>>    * Invoke to unmap the CPU address from PCI address.
>>    */
>>   void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> -			phys_addr_t phys_addr)
>> +			phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
>>   {
>> +	u64 aligned_phys;
>> +	void __iomem *aligned_virt;
>> +	size_t offset;
>> +
>>   	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>   		return;
>>   
>> @@ -441,9 +445,22 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   	if (!epc->ops->unmap_addr)
>>   		return;
>>   
>> +	if (epc->ops->align_mem) {
>> +		mutex_lock(&epc->lock);
>> +		aligned_phys = epc->ops->align_mem(epc, phys_addr, &size);
>> +		mutex_unlock(&epc->lock);
>> +	} else {
>> +		aligned_phys = phys_addr;
>> +	}
>> +
>> +	offset = phys_addr - aligned_phys;
>> +	aligned_virt = virt_addr - offset;
>> +
>>   	mutex_lock(&epc->lock);
>> -	epc->ops->unmap_addr(epc, func_no, vfunc_no, phys_addr);
>> +	epc->ops->unmap_addr(epc, func_no, vfunc_no, aligned_phys);
>>   	mutex_unlock(&epc->lock);
>> +
>> +	pci_epc_mem_free_addr(epc, aligned_phys, aligned_virt, size);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>   
>> @@ -458,26 +475,46 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>    *
>>    * Invoke to map CPU address with PCI address.
>>    */
>> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> -		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
>> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +		u64 pci_addr, phys_addr_t *phys_addr, size_t size)
>>   {
>>   	int ret;
>> +	u64 aligned_addr;
>> +	size_t offset;
>> +	void __iomem *virt_addr;
>>   
>>   	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>> -		return -EINVAL;
>> +		return ERR_PTR(-EINVAL);
>>   
>>   	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
>> -		return -EINVAL;
>> +		return ERR_PTR(-EINVAL);
>>   
>>   	if (!epc->ops->map_addr)
>> -		return 0;
>> +		return ERR_PTR(-ENOPTSUPP);
>> +
>> +	if (epc->ops->align_mem) {
>> +		mutex_lock(&epc->lock);
>> +		aligned_addr = epc->ops->align_mem(epc, pci_addr, &size);
>> +		mutex_unlock(&epc->lock);
>> +	} else {
>> +		aligned_addr = pci_addr;
>> +	}
>> +
>> +	offset = pci_addr - aligned_addr;
>> +
>> +	virt_addr = pci_epc_mem_alloc_addr(epc, phys_addr, size);
>> +	if (!virt_addr)
>> +		return ERR_PTR(-ENOMEM);
>>   
>>   	mutex_lock(&epc->lock);
>> -	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
>> -				 size);
>> +	ret = epc->ops->map_addr(epc, func_no, vfunc_no, *phys_addr, aligned_addr, size);
>>   	mutex_unlock(&epc->lock);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>>   
>> -	return ret;
>> +	*phys_addr += offset;
>> +
>> +	return virt_addr + offset;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>   
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index a48778e1a4ee..8f29161bce80 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -84,6 +84,7 @@ struct pci_epc_ops {
>>   			       phys_addr_t phys_addr, u8 interrupt_num,
>>   			       u32 entry_size, u32 *msi_data,
>>   			       u32 *msi_addr_offset);
>> +	u64	(*align_mem)(struct pci_epc *epc, u64 addr, size_t *size);
>>   	int	(*start)(struct pci_epc *epc);
>>   	void	(*stop)(struct pci_epc *epc);
>>   	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>> @@ -218,11 +219,12 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   		    struct pci_epf_bar *epf_bar);
>>   void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   		       struct pci_epf_bar *epf_bar);
>> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> -		     phys_addr_t phys_addr,
>> -		     u64 pci_addr, size_t size);
>> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +			       u64 pci_addr, phys_addr_t *phys_addr,
>> +			       size_t size);
>>   void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> -			phys_addr_t phys_addr);
>> +			phys_addr_t phys_addr, void __iomem *virt_addr,
>> +			size_t size);
>>   int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   		    u8 interrupts);
>>   int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);

-- 
Damien Le Moal
Western Digital Research

