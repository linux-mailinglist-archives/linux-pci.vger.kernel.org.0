Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6286766E909
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 22:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjAQV6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 16:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjAQV5R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 16:57:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0BA53E5F;
        Tue, 17 Jan 2023 12:41:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B50B06153B;
        Tue, 17 Jan 2023 20:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D29C433D2;
        Tue, 17 Jan 2023 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673988093;
        bh=9vSCvidurA7NN50P4dOMjeVPl/22ufhHiPbZ/5hpRbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hLxUnXr/h5rkjsavwaN7w9C1HbDO68wwmvBcpI1EfGM+LG+r9v9nprdw0PWk96Kdq
         OD/t1jTfbqamiLMfMpw0nDNiC61xAwah0vccuJVDIN87UNHZusXGe1xEqHqnDlShqF
         vW9YB+rrYll/QCrCdMga4LoiXMeEGQDVIwdmjRPOExSDNKRFxvn+nPof7RsRbE4M2Q
         S+x+tN+aK6k/X0xtLhFA98rxZLv/2kfPd1uuFn/EyDFBDN94YXiJR/pYu1CEokMCKe
         te8nMHrkJDKAhyG1uhf++S5eYMTNcPzqbab6DA516oKKuWo6xMKskLKYwh+EVc3bKS
         ++q4LDn4F1ctA==
Date:   Tue, 17 Jan 2023 14:41:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware
 map/unmaping
Message-ID: <20230117204131.GA145312@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113090350.1103494-2-mie@igel.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 06:03:48PM +0900, Shunsuke Mie wrote:
> Add an align_mem operation to the EPC ops, which function is used to
> pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
> restriction of EPC. The map function maps an aligned memory to include a
> requested memory region.

I think this does two things: 1) add the .align_mem() function
pointer, and 2) move the pci_epc_mem_alloc_addr() call into
pci_epc_map_addr().  For 2), I would expect to see
pci_epc_mem_alloc_addr() being *removed* from somewhere else.

Anyway, both are significant and should be mentioned in the commit
log.  Possibly they could even be separate commits: move the
alloc/free first, then add .align_mem().

Another question below.

> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 57 ++++++++++++++++++++++++-----
>  include/linux/pci-epc.h             | 10 +++--
>  2 files changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2542196e8c3d..60d586e05e7d 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -430,8 +430,12 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>   * Invoke to unmap the CPU address from PCI address.
>   */
>  void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -			phys_addr_t phys_addr)
> +			phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
>  {
> +	u64 aligned_phys;
> +	void __iomem *aligned_virt;
> +	size_t offset;
> +
>  	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>  		return;
>  
> @@ -441,9 +445,22 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (!epc->ops->unmap_addr)
>  		return;
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
>  	mutex_lock(&epc->lock);
> -	epc->ops->unmap_addr(epc, func_no, vfunc_no, phys_addr);
> +	epc->ops->unmap_addr(epc, func_no, vfunc_no, aligned_phys);
>  	mutex_unlock(&epc->lock);
> +
> +	pci_epc_mem_free_addr(epc, aligned_phys, aligned_virt, size);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>  
> @@ -458,26 +475,46 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>   *
>   * Invoke to map CPU address with PCI address.
>   */
> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		u64 pci_addr, phys_addr_t *phys_addr, size_t size)
>  {
>  	int ret;
> +	u64 aligned_addr;
> +	size_t offset;
> +	void __iomem *virt_addr;
>  
>  	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>  	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>  	if (!epc->ops->map_addr)
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
>  	mutex_lock(&epc->lock);
> -	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
> -				 size);
> +	ret = epc->ops->map_addr(epc, func_no, vfunc_no, *phys_addr, aligned_addr, size);
>  	mutex_unlock(&epc->lock);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
> -	return ret;
> +	*phys_addr += offset;
> +
> +	return virt_addr + offset;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index a48778e1a4ee..8f29161bce80 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -84,6 +84,7 @@ struct pci_epc_ops {
>  			       phys_addr_t phys_addr, u8 interrupt_num,
>  			       u32 entry_size, u32 *msi_data,
>  			       u32 *msi_addr_offset);
> +	u64	(*align_mem)(struct pci_epc *epc, u64 addr, size_t *size);

Is there a requirement for multiple implementations of .align_mem()?

There's only one implementation in this series
(dw_pcie_ep_align_mem()), and it only needs pci->region_align.  That
*value* might be DWC-specific, but the concept really isn't, so maybe
there could be a generic function that uses the device-specific value.

>  	int	(*start)(struct pci_epc *epc);
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
> @@ -218,11 +219,12 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		    struct pci_epf_bar *epf_bar);
>  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		       struct pci_epf_bar *epf_bar);
> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -		     phys_addr_t phys_addr,
> -		     u64 pci_addr, size_t size);
> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			       u64 pci_addr, phys_addr_t *phys_addr,
> +			       size_t size);
>  void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -			phys_addr_t phys_addr);
> +			phys_addr_t phys_addr, void __iomem *virt_addr,
> +			size_t size);
>  int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		    u8 interrupts);
>  int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> -- 
> 2.25.1
> 
