Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E037264B14
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgIJRVN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 13:21:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43558 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgIJQRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:17:41 -0400
Received: by mail-io1-f67.google.com with SMTP id z25so7670891iol.10;
        Thu, 10 Sep 2020 09:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4VyKUTkJ3NprXsuyCpZOH0uNWIu59x7fnIzolQvDdak=;
        b=lYFNPptFVcQHRnptk8MHl2x6IAzthRbv6U7+Y+kkNo7TFz4ftZvDJ4bY+lPwox+VwN
         8WVUSFzBH1KRT9w1UDEzGFsJKY1JFMfBIhJnmbnyPx1dwb8GAeuROF5Vd1oghOOUc0WY
         8JvF7r79j5W3lELZcFXJibdpQeRBpQBu+Zit8MC1ZHWT3ZZg1/hcrEmRDvAOKpoRct8F
         mXHfyM6FEbe9JJQHLFmF5nzjAEeI21fWRJRRLQ8ORWyyY+DnKpWpuf1bglg+lDUnCbxB
         dAB6O40hLU7cjvavI66oKgzrsG1b10YAeCyTwA81h7lWNSC/btCJe52oIU84SG4/1PA8
         sLCw==
X-Gm-Message-State: AOAM533C58bTxXXMy/7zK0EVFrdYKhn2AyKJzeVD5DVJPGSscLopiOc8
        /6HbF/ie0pk6SgLD7r3ewg==
X-Google-Smtp-Source: ABdhPJxDsyX0wQ0s9lSHPOhYptoZFVQUuClzVlPybd7GK01Ra2Ylp3lvzEy0PHTy8vuMRjNY3D1pVw==
X-Received: by 2002:a6b:e017:: with SMTP id z23mr8166336iog.101.1599754631858;
        Thu, 10 Sep 2020 09:17:11 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o8sm3485893ilb.64.2020.09.10.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:17:11 -0700 (PDT)
Received: (nullmailer pid 466276 invoked by uid 1000);
        Thu, 10 Sep 2020 16:17:10 -0000
Date:   Thu, 10 Sep 2020 10:17:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 08/11] PCI: brcmstb: Set additional internal memory
 DMA viewport sizes
Message-ID: <20200910161710.GA456155@bogus>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-9-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-9-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 03:30:21PM -0400, Jim Quinlan wrote:
> The Raspberry Pi (RPI) is currently the only chip using this driver
> (pcie-brcmstb.c).  There, only one memory controller is used, without an
> extension region, and the SCB0 viewport size is set to the size of the
> first and only dma-range region.  Other BrcmSTB SOCs have more complicated
> memory configurations that require setting additional viewport sizes.
> 
> BrcmSTB PCIe controllers are intimately connected to the memory
> controller(s) on the SOC.  The SOC may have one to three memory
> controllers; they are indicated by the term SCBi.  Each controller has a
> base region and an optional extension region.  In physical memory, the base
> and extension regions of a controller are not adjacent, but in PCIe-space
> they are.
> 
> There is a "viewport" for each memory controller that allows DMA from
> endpoint devices.  Each viewport's size must be set to a power of two, and
> that size must be equal to or larger than the amount of memory each
> controller supports which is the sum of base region and its optional
> extension.  Further, the 1-3 viewports are also adjacent in PCIe-space.
> 
> Unfortunately the viewport sizes cannot be ascertained from the
> "dma-ranges" property so they have their own property, "brcm,scb-sizes".
> This is because dma-range information does not indicate what memory
> controller it is associated.  For example, consider the following case
> where the size of one dma-range is 2GB and the second dma-range is 1GB:
> 
>     /* Case 1: SCB0 size set to 4GB */
>     dma-range0: 2GB (from memc0-base)
>     dma-range1: 1GB (from memc0-extension)
> 
>     /* Case 2: SCB0 size set to 2GB, SCB1 size set to 1GB */
>     dma-range0: 2GB (from memc0-base)
>     dma-range1: 1GB (from memc0-extension)
> 
> By just looking at the dma-ranges information, one cannot tell which
> situation applies. That is why an additional property is needed.  Its
> length indicates the number of memory controllers being used and each value
> indicates the viewport size.
> 
> Note that the RPI DT does not have a "brcm,scb-sizes" property value,
> as it is assumed that it only requires one memory controller and no
> extension.  So the optional use of "brcm,scb-sizes" will be backwards
> compatible.
> 
> One last layer of complexity exists: all of the viewports sizes must be
> added and rounded up to a power of two to determine what the "BAR" size is.
> Further, an offset must be given that indicates the base PCIe address of
> this "BAR".  The use of the term BAR is typically associated with endpoint
> devices, and the term is used here because the PCIe HW may be used as an RC
> or an EP.  In the former case, all of the system memory appears in a single
> "BAR" region in PCIe memory.  As it turns out, BrcmSTB PCIe HW is rarely
> used in the EP role and its system of mapping memory is an artifact that
> requires multiple dma-ranges regions.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 041b8d109563..7150eaa803c2 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -57,6 +57,8 @@
>  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
>  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128		0x0
>  #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
> +#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
> +#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f

Perhaps make 0-2 an arg and then you can just do:

u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB_SIZE_MASK(memc))

>  
>  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
>  #define PCIE_MEM_WIN0_LO(win)	\
> @@ -154,6 +156,7 @@
>  #define SSC_STATUS_OFFSET		0x1
>  #define SSC_STATUS_SSC_MASK		0x400
>  #define SSC_STATUS_PLL_LOCK_MASK	0x800
> +#define PCIE_BRCM_MAX_MEMC		3
>  
>  #define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
>  #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
> @@ -259,6 +262,8 @@ struct brcm_pcie {
>  	const int		*reg_field_info;
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
> +	int			num_memc;
> +	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  };
>  
>  /*
> @@ -714,22 +719,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  							u64 *rc_bar2_offset)
>  {
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> -	struct device *dev = pcie->dev;
>  	struct resource_entry *entry;
> +	struct device *dev = pcie->dev;
> +	u64 lowest_pcie_addr = ~(u64)0;
> +	int ret, i = 0;
> +	u64 size = 0;
>  
> -	entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> -	if (!entry)
> -		return -ENODEV;
> +	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> +		u64 pcie_beg = entry->res->start - entry->offset;
>  
> +		size += entry->res->end - entry->res->start + 1;
> +		if (pcie_beg < lowest_pcie_addr)
> +			lowest_pcie_addr = pcie_beg;
> +	}
>  
> -	/*
> -	 * The controller expects the inbound window offset to be calculated as
> -	 * the difference between PCIe's address space and CPU's. The offset
> -	 * provided by the firmware is calculated the opposite way, so we
> -	 * negate it.
> -	 */
> -	*rc_bar2_offset = -entry->offset;
> -	*rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
> +	if (lowest_pcie_addr == ~(u64)0) {
> +		dev_err(dev, "DT node has no dma-ranges\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> +						  PCIE_BRCM_MAX_MEMC);
> +
> +	if (ret <= 0) {
> +		/* Make an educated guess */
> +		pcie->num_memc = 1;
> +		pcie->memc_size[0] = 1ULL << fls64(size - 1);

Use roundup_pow_of_two()

> +	} else {
> +		pcie->num_memc = ret;
> +	}
> +
> +	/* Each memc is viewed through a "port" that is a power of 2 */
> +	for (i = 0, size = 0; i < pcie->num_memc; i++)
> +		size += pcie->memc_size[i];
> +
> +	/* System memory starts at this address in PCIe-space */
> +	*rc_bar2_offset = lowest_pcie_addr;
> +	/* The sum of all memc views must also be a power of 2 */
> +	*rc_bar2_size = 1ULL << fls64(size - 1);

Use roundup_pow_of_two()

>  
>  	/*
>  	 * We validate the inbound memory view even though we should trust
> @@ -781,12 +808,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	void __iomem *base = pcie->base;
>  	struct device *dev = pcie->dev;
>  	struct resource_entry *entry;
> -	unsigned int scb_size_val;
>  	bool ssc_good = false;
>  	struct resource *res;
>  	int num_out_wins = 0;
>  	u16 nlw, cls, lnksta;
> -	int i, ret;
> +	int i, ret, memc;
>  	u32 tmp, aspm_support;
>  
>  	/* Reset the bridge */
> @@ -826,11 +852,17 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	writel(upper_32_bits(rc_bar2_offset),
>  	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
>  
> -	scb_size_val = rc_bar2_size ?
> -		       ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
>  	tmp = readl(base + PCIE_MISC_MISC_CTRL);
> -	u32p_replace_bits(&tmp, scb_size_val,
> -			  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> +	for (memc = 0; memc < pcie->num_memc; memc++) {
> +		u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
> +
> +		if (memc == 0)
> +			u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> +		else if (memc == 1)
> +			u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK);
> +		else if (memc == 2)
> +			u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK);
> +	}
>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>  
>  	/*
> -- 
> 2.17.1
> 
