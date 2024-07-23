Return-Path: <linux-pci+bounces-10627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4E939749
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 02:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B760F1F214DD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 00:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0F18D;
	Tue, 23 Jul 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEL/P4CU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D327F;
	Tue, 23 Jul 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692984; cv=none; b=Yp1+tnfP/HYArOcDBCmDAc1tYwRMPdI5uAlH82LAQCa4L/LVZUhDNnKeFdT6WCIMzAMGtdSp6HX9CR85QlPojxKAQhLYp15gyZyh+sc7/w49XmzN1VYtq90OyDrqWtCV2bTViBf2p/D79VeuRoyMGp9fO6sXp1Ttxwc8yqWMk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692984; c=relaxed/simple;
	bh=rPjuKAHh2mMylZtOXK3SmJ7ia4SNrnnT32h7SOGIGuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndUIiFFENv3TuPRSoy/xiDJzBGOrutw8SNBikCVTmLOa0kIv7D7Bm2x7oYForDeU62ezpUmID2Vrlg5BH5Gb+/kYwafBhDwm8+tmhVuYjWpvCe8WQZEFot6LcnECecDO8Vcb7UynAyJvMovxkAEHLzIVn45nUafF8vs8ge2d8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEL/P4CU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF71C116B1;
	Tue, 23 Jul 2024 00:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721692984;
	bh=rPjuKAHh2mMylZtOXK3SmJ7ia4SNrnnT32h7SOGIGuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uEL/P4CUU5u4zNCVYjNmmVI28VJ/tuoDbofbsZ2je/0bxEfosEq7XwyWNWX/AKsKO
	 /8RdkAP2GrasJYWkRhQJYab+49XsuxTxR8IOgZdPkzc1icLsFYMz2aJlXq5AR76Guz
	 fjDo+2UZPyGeixlRm0loYbo8sAWkLXP08c6UGRzsvu6JwyrHdHB8MAKgfYk74+Hyzl
	 4MnuE9GpNphPK+V9yR9LxjwE6t6BSmxHR+Bdzf43priujbZICgGorB6q+YQ4Lk0CxU
	 oRWftRt44a9hbDySEFli2kax3KGUo+DYENXyOzPhsPlGBiJrF8Wt72HGGHKDR3G5cd
	 Rf/3HQaW/ulcA==
Message-ID: <b4256f7c-350b-4fba-ba49-a91ee463b8d7@kernel.org>
Date: Tue, 23 Jul 2024 09:03:01 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>, rick.wertenbroek@heig-vd.ch
Cc: alberto.dassatti@heig-vd.ch,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/24 20:57, Rick Wertenbroek wrote:
> The current mechanism for BARs is as follows: The endpoint function
> allocates memory with 'pci_epf_alloc_space' which calls
> 'dma_alloc_coherent' to allocate memory for the BAR and fills a
> 'pci_epf_bar' structure with the physical address, virtual address,
> size, BAR number and flags. This 'pci_epf_bar' structure is passed
> to the endpoint controller driver through 'set_bar'. The endpoint
> controller driver configures the actual endpoint to reroute PCI
> read/write TLPs to the BAR memory space allocated.
> 
> The problem with this is that not all PCI endpoint controllers can
> be configured to reroute read/write TLPs to their BAR to a given
> address in memory space. Some PCI endpoint controllers e.g., FPGA
> IPs for Intel/Altera and AMD/Xilinx PCI endpoints. These controllers
> come with pre-assigned memory for the BARs (e.g., in FPGA BRAM),
> because of this the endpoint controller driver has no way to tell
> these controllers to reroute the read/write TLPs to the memory
> allocated by 'pci_epf_alloc_space' and no way to get access to the
> memory pre-assigned to the BARs through the current API.
> 
> Therefore, introduce 'get_bar' which allows to get access to a BAR
> without calling 'pci_epf_alloc_space'. Controllers with pre-assigned
> bars can therefore implement 'get_bar' which will assign the BAR
> pyhsical address, virtual address through ioremap, size, and flags.
> 
> PCI endpoint functions can query the endpoint controller through the
> 'fixed_addr' boolean in the 'pci_epc_bar_desc' structure. Similarly
> to the BAR type, fixed size or fixed 64-bit descriptions. With this
> information they can either call 'pci_epf_alloc_space' and 'set_bar'
> as is currently the case, or call the new 'get_bar'. Both will provide
> a working, memory mapped BAR, that can be used in the endpoint
> function.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 37 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  7 ++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 84309dfe0c68..fcef848876fe 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -544,6 +544,43 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_set_bar);
>  
> +/**
> + * pci_epc_get_bar - get BAR configuration from a fixed address BAR
> + * @epc: the EPC device on which BAR resides
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @bar: the BAR number to get
> + * @epf_bar: the struct epf_bar to fill
> + *
> + * Invoke to get the configuration of the endpoint device fixed address BAR
> + */
> +int pci_epc_get_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		    enum pci_barno bar, struct pci_epf_bar *epf_bar)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> +		return -EINVAL;
> +
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +
> +	if (!epc->ops->get_bar)
> +		return -EINVAL;
> +
> +	epf_bar->barno = bar;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->get_bar(epc, func_no, vfunc_no, bar, epf_bar);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_get_bar);
> +
>  /**
>   * pci_epc_write_header() - write standard configuration header
>   * @epc: the EPC device to which the configuration header should be written
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 85bdf2adb760..a5ea50dd49ba 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -37,6 +37,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>   * @write_header: ops to populate configuration space header
>   * @set_bar: ops to configure the BAR
>   * @clear_bar: ops to reset the BAR
> + * @get_bar: ops to get a fixed address BAR that cannot be set/cleared
>   * @map_addr: ops to map CPU address to PCI address
>   * @unmap_addr: ops to unmap CPU address and PCI address
>   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
> @@ -61,6 +62,8 @@ struct pci_epc_ops {
>  			   struct pci_epf_bar *epf_bar);
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			     struct pci_epf_bar *epf_bar);
> +	int	(*get_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			   enum pci_barno, struct pci_epf_bar *epf_bar);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> @@ -163,6 +166,7 @@ enum pci_epc_bar_type {
>   * struct pci_epc_bar_desc - hardware description for a BAR
>   * @type: the type of the BAR
>   * @fixed_size: the fixed size, only applicable if type is BAR_FIXED_MASK.
> + * @fixed_addr: indicates that the BAR has a fixed address in memory map.
>   * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
>   *		should be configured as 32-bit or 64-bit, the EPF driver must
>   *		configure this BAR as 64-bit. Additionally, the BAR succeeding
> @@ -176,6 +180,7 @@ enum pci_epc_bar_type {
>  struct pci_epc_bar_desc {
>  	enum pci_epc_bar_type type;
>  	u64 fixed_size;
> +	bool fixed_addr;

Why make this a bool instead of a 64-bits address ?
If the controller sets this to a non-zero value, we will know it is a fixed
address bar. And that can avoid adding the get_bar operations, no ?

>  	bool only_64bit;
>  };
>  
> @@ -238,6 +243,8 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		    struct pci_epf_bar *epf_bar);
>  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		       struct pci_epf_bar *epf_bar);
> +int pci_epc_get_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		    enum pci_barno, struct pci_epf_bar *epf_bar);
>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		     phys_addr_t phys_addr,
>  		     u64 pci_addr, size_t size);

-- 
Damien Le Moal
Western Digital Research


