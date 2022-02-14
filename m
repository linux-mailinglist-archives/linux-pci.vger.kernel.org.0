Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B077A4B45F2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 10:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbiBNJbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 04:31:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbiBNJbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 04:31:20 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377FCBF76
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 01:30:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id qe15so13950272pjb.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 01:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VcnEn/2NWd+/RTs+MullchxIkZjgGZxkU+9opOFbT/E=;
        b=gBTRLGlaAj4HJU+BV6EKy1c7SRjH3ZcYNjesOBAIUBrh/uJhWfqNl4nuvTvank74fG
         0Fll3ywyLTal5NaXfV95mwYlAMez8rk1khrDRLlKR6cGCIwsm79cmXPrFfb1qEXUy5QF
         XUpcU2pDxOq6U/6ODZq3rCeT/5yti0Vz6XB/gUKZDMsy9nxIV+889Bo3t1Ar5w/NkiY/
         QbN9Q7xhG5aqC1ykGXzg3frw8QOXhjXr8K2osJ7VypdPmuUuU9S91ig7qh8E6uomgVNJ
         TJlU2PasI8nha32acKj4h5iCGfQRiJoUopwJyYmHBNpTJToSexWQtID9cnFfcBB6eTZz
         0jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VcnEn/2NWd+/RTs+MullchxIkZjgGZxkU+9opOFbT/E=;
        b=1MPInLvB9J6UoONgw21YYTNFfirqrcOX+T6oqEb8A6l4LjO7zPC5pRbWmLQeESYXAY
         7D34r3RF91YGYNX7nQ9lBFeZAaYtwW4pFPvLaxpu+AHEfIpBukJkUf2rEscERGfQBbrV
         Sp1vJQoTZEzKJAyO8E1GwqG9QXoHWj0rR1LlfU9j/NMns6dgLtP9m66e8I62ZbfcyBEn
         kC3wwcbXHUSnwUWfKhGlUcqzcCpNKoxclpxzTJJlwR/NnBIEXAYBbmWvEILZdkmQaDjX
         fnRHbY40GLogrnUMLj1l/rJ1g45SPFg5oEFumUe1chKFnhtFWk/BjKqwm2qzjyTC3HfH
         xc8g==
X-Gm-Message-State: AOAM532uPQMKrRwp7B/Iqo7d5HoGo5Nc53Sg71ftuyfPHx8d/gyM+Fi1
        igES77GqgC/gq8hruSBzDcuy
X-Google-Smtp-Source: ABdhPJw+/gbE94SUWsRBzGerqbSwRwYgZd0xqI8AQd5IBANHze8aVI2ksk/Qqd2UmHldJ+0vAgxYEw==
X-Received: by 2002:a17:902:d88f:: with SMTP id b15mr13442997plz.44.1644831021418;
        Mon, 14 Feb 2022 01:30:21 -0800 (PST)
Received: from thinkpad ([2409:4072:817:5a6f:3104:62c0:1941:5033])
        by smtp.gmail.com with ESMTPSA id g4sm35616188pfv.63.2022.02.14.01.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 01:30:21 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:00:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 1/5] PCI: endpoint: Add ops and flag to support
 internal DMAC
Message-ID: <20220214093012.GI3494@thinkpad>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220126195043.28376-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126195043.28376-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 26, 2022 at 07:50:39PM +0000, Lad Prabhakar wrote:
> Add flag to indicate if PCIe EP supports internal DMAC and also add a
> wrapper function which invokes dmac_transfer() callback which lands
> in the PCIe EP driver.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 32 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  8 ++++++++
>  include/linux/pci-epf.h             |  7 +++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 9ed556936f48..f70576d0d4b2 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -239,6 +239,38 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
>  
> +/**
> + * pci_epf_internal_dmac_xfr() - transfer data between EPC and remote PCIe RC

Transfer data between EP and host using internal DMA engine

> + * @epf: the EPF device that performs the data transfer operation
> + * @dma_dst: The destination address of the data transfer. It can be a physical
> + *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
> + * @dma_src: The source address of the data transfer. It can be a physical
> + *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
> + * @len: The size of the data transfer
> + *
> + * Invoke to transfer data between EPC and remote PCIe RC using internal dmac.
> + */
> +int pci_epf_internal_dmac_xfr(struct pci_epf *epf, dma_addr_t dma_dst,
> +			      dma_addr_t dma_src, size_t len,
> +			      enum pci_epf_xfr_direction dir)

How about "pci_epf_internal_dma_xfer"? I think DMAC is somewhat platform
specific so we could just use DMA. And "xfer" is being used more commonly for
"transfer".

> +{
> +	struct pci_epc *epc = epf->epc;
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc) || IS_ERR_OR_NULL(epf))
> +		return -EINVAL;
> +
> +	if (!epc->ops->dmac_transfer)
> +		return -EINVAL;
> +
> +	mutex_lock(&epf->lock);
> +	ret = epc->ops->dmac_transfer(epc, epf, dma_dst, dma_src, len, dir);

internal_dma_xfer? It doesn't look perfect but I can't think of any other way to
represent it as an internal dma callback.

> +	mutex_unlock(&epf->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_internal_dmac_xfr);
> +
>  /**
>   * pci_epf_free_space() - free the allocated PCI EPF register space
>   * @epf: the EPF device from whom to free the memory
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index a48778e1a4ee..b55dacd09e1e 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -58,6 +58,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>   * @map_msi_irq: ops to map physical address to MSI address and return MSI data
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
> + * @dmac_transfer: ops to transfer data using internal DMAC
>   * @get_features: ops to get the features supported by the EPC
>   * @owner: the module owner containing the ops
>   */
> @@ -86,6 +87,9 @@ struct pci_epc_ops {
>  			       u32 *msi_addr_offset);
>  	int	(*start)(struct pci_epc *epc);
>  	void	(*stop)(struct pci_epc *epc);
> +	int	(*dmac_transfer)(struct pci_epc *epc, struct pci_epf *epf,
> +				 dma_addr_t dma_dst, dma_addr_t dma_src,
> +				 size_t len, enum pci_epf_xfr_direction dir);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
>  	struct module *owner;
> @@ -159,6 +163,8 @@ struct pci_epc {
>   *			for initialization
>   * @msi_capable: indicate if the endpoint function has MSI capability
>   * @msix_capable: indicate if the endpoint function has MSI-X capability
> + * @internal_dmac: indicate if the endpoint function has internal DMAC
> + * @internal_dmac_mask: indicates the DMA mask to be applied for the device
>   * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
>   * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
>   * @bar_fixed_size: Array specifying the size supported by each BAR
> @@ -169,6 +175,8 @@ struct pci_epc_features {
>  	unsigned int	core_init_notifier : 1;
>  	unsigned int	msi_capable : 1;
>  	unsigned int	msix_capable : 1;
> +	unsigned int	internal_dmac : 1;
> +	u64		internal_dmac_mask;

internal_dma?

>  	u8	reserved_bar;
>  	u8	bar_fixed_64bit;
>  	u64	bar_fixed_size[PCI_STD_NUM_BARS];
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 009a07147c61..78d661db085d 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -32,6 +32,11 @@ enum pci_barno {
>  	BAR_5,
>  };
>  
> +enum pci_epf_xfr_direction {
> +	PCIE_TO_INTERNAL,
> +	INTERNAL_TO_PCIE,

I think we could just use "dma_data_direction" as we are anyway transferring
data between host and device.

Thanks,
Mani

> +};
> +
>  /**
>   * struct pci_epf_header - represents standard configuration header
>   * @vendorid: identifies device manufacturer
> @@ -209,6 +214,8 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  			enum pci_epc_interface_type type);
>  int pci_epf_bind(struct pci_epf *epf);
>  void pci_epf_unbind(struct pci_epf *epf);
> +int pci_epf_internal_dmac_xfr(struct pci_epf *epf, dma_addr_t dma_dst, dma_addr_t dma_src,
> +			      size_t len, enum pci_epf_xfr_direction dir);
>  struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
>  					  struct config_group *group);
>  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> -- 
> 2.25.1
> 
