Return-Path: <linux-pci+bounces-44600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B48BD17EAE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 11:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55C533012972
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12483876DD;
	Tue, 13 Jan 2026 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RENQkIMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7D344020;
	Tue, 13 Jan 2026 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299355; cv=none; b=pP+jUCFKlJuSf1qdCs00uXZOz4XV39SED3S4JPsNWKFZRaIcM/u5Zjws6c8oQqcXLy9iuBKpdtq8LiOvvIaHpeMbocX7tQia9/PiuWYsrvR7VluGOpzsBHTaIng4PYwp1IYkuAGI88fXLZlo53LVWN55kl3m2Pxp5H9VS0Ywnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299355; c=relaxed/simple;
	bh=Sc6cZO9/L/e3RSZOVEv5M+M/tKNpThn85L5DOA4OQ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+raTAHBxvEU5HGZPnAdJ4OmwlQ9zTRaUI1JcoUYxtcfL5/fs8Z/1arkxPn4QhYYSzuJPuYpRyE7BAgcWwU/PxwMGsBD1ayl0QNGeqVAAUc2JBtw1TxC5F/ZQc0Joqm6XMw9U5NEKIIhGrQIF5c7Hk9oeb4CJ5xKuKUfOPZ0SzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RENQkIMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB51C116C6;
	Tue, 13 Jan 2026 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768299355;
	bh=Sc6cZO9/L/e3RSZOVEv5M+M/tKNpThn85L5DOA4OQ1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RENQkIMBOeSWsTxPlertBALKQCvyKskmK3G6g0DilwdsBrUOSupUg2GJbAuBlKHEv
	 WpkpYhlp6w2ZXbzyfrlNBtvsEO9CY3cqu7mX4H2pzk+y5A4064QkkC30iH02uV+n5K
	 tBj8IauwrpBIQ7Ry0WfWRIfFnJC/ZEIGr0HhqUiq6jv4HBX2QJ4PCnOnJ/Cr+q7bqK
	 HeAQnnchFsxlDPAfuUp/5FIY/TujD7NK1wsF5jj64rG+Jm4XGeEMddW5ObG8g9nNW+
	 h8bOoyvO6qyN8WVBNzylRqfCb0y+lAyebIB6fK7EYKrm3Dq2e+naz/ehFmDTK8C2m7
	 691ItJr7oANbA==
Date: Tue, 13 Jan 2026 11:15:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
	heiko@sntech.de, srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
	rongqianfeng@vivo.com, 18255117159@163.com,
	shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com, vidyas@nvidia.com, Frank.Li@nxp.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 4/5] PCI: dwc: ep: Support BAR subrange inbound
 mapping via Address Match Mode iATU
Message-ID: <aWYbTt6UjlXb9Uk-@ryzen>
References: <20260113023715.3463724-1-den@valinux.co.jp>
 <20260113023715.3463724-5-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113023715.3463724-5-den@valinux.co.jp>

On Tue, Jan 13, 2026 at 11:37:14AM +0900, Koichiro Den wrote:
> Extend dw_pcie_ep_set_bar() to support inbound mappings for BAR
> subranges using Address Match Mode IB iATU.
> 
> Rename the existing BAR-match helper into dw_pcie_ep_ib_atu_bar() and
> introduce dw_pcie_ep_ib_atu_addr() for Address Match Mode. When
> use_submap is set, read the assigned BAR base address and program one
> inbound iATU window per subrange. Validate the submap array before
> programming:
> - each subrange is aligned to pci->region_align
> - subranges cover the whole BAR (no gaps and no overlaps)
> - subranges are sorted in ascending order by offset
> 
> Track Address Match Mode mappings and tear them down on clear_bar() and
> on set_bar() error paths to avoid leaving half-programmed state or
> untranslated BAR holes.
> 
> Advertise this capability by setting subrange_mapping in the EPC
> features returned from dw_pcie_ep_get_features(). This also sets
> dynamic_inbound_mapping, which is a prerequisite for the subrange
> mapping flow. Note that vNTB already relies on this dynamic inbound
> mapping behavior.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 240 +++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  2 files changed, 231 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1195d401df19..b2ea2c2c986f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -139,9 +139,10 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> -				  dma_addr_t parent_bus_addr, enum pci_barno bar,
> -				  size_t size)
> +/* BAR Match Mode inbound iATU mapping */
> +static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
> +				 dma_addr_t parent_bus_addr, enum pci_barno bar,
> +				 size_t size)
>  {
>  	int ret;
>  	u32 free_win;
> @@ -174,6 +175,208 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	return 0;
>  }
>  
> +/* Inbound mapping bookkeeping for Address Match Mode */
> +struct dw_pcie_ib_map {
> +	struct list_head	list;
> +	enum pci_barno		bar;
> +	u64			pci_addr;
> +	u64			parent_bus_addr;
> +	u64			size;
> +	u32			index;
> +};
> +
> +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_pcie_ib_map *m, *tmp;
> +	struct device *dev = pci->dev;
> +	u32 atu_index;
> +
> +	/* Tear down the BAR Match Mode mapping, if any. */
> +	if (ep->bar_to_atu[bar]) {
> +		atu_index = ep->bar_to_atu[bar] - 1;
> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
> +		clear_bit(atu_index, ep->ib_window_map);
> +		ep->bar_to_atu[bar] = 0;
> +	}
> +
> +	/* Tear down all Address Match Mode mappings, if any. */
> +	guard(spinlock_irqsave)(&ep->ib_map_lock);
> +	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, list) {
> +		if (m->bar != bar)
> +			continue;
> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
> +		clear_bit(m->index, ep->ib_window_map);
> +		list_del(&m->list);
> +		devm_kfree(dev, m);
> +	}
> +}
> +
> +static u64 dw_pcie_ep_read_bar_assigned(struct dw_pcie_ep *ep, u8 func_no,
> +					enum pci_barno bar, int flags)
> +{
> +	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +	u32 lo, hi;
> +	u64 addr;
> +
> +	lo = dw_pcie_ep_readl_dbi(ep, func_no, reg);
> +
> +	if (flags & PCI_BASE_ADDRESS_SPACE)
> +		return lo & PCI_BASE_ADDRESS_IO_MASK;
> +
> +	addr = lo & PCI_BASE_ADDRESS_MEM_MASK;
> +	if (!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> +		return addr;
> +
> +	hi = dw_pcie_ep_readl_dbi(ep, func_no, reg + 4);
> +	return addr | ((u64)hi << 32);
> +}
> +
> +static int dw_pcie_ep_validate_submap(struct dw_pcie_ep *ep,
> +				      const struct pci_epf_bar_submap *submap,
> +				      unsigned int num_submap, size_t bar_size)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	u32 align = pci->region_align;
> +	size_t expected = 0;
> +	size_t size, off;
> +	unsigned int i;
> +
> +	if (!align || !IS_ALIGNED(bar_size, align))
> +		return -EINVAL;
> +
> +	/*
> +	 * The array is expected to be sorted by offset before calling this
> +	 * helper. With sorted entries, we can enforce a strict, gapless
> +	 * decomposition of the BAR:
> +	 *  - each entry has a non-zero size
> +	 *  - offset/size/phys_addr are aligned to pci->region_align
> +	 *  - each entry lies within the BAR range
> +	 *  - entries are contiguous (no overlaps, no holes)
> +	 *  - the entries exactly cover the whole BAR
> +	 *
> +	 * Note: dw_pcie_prog_inbound_atu() also checks alignment for
> +	 * offset/phys_addr, but validating up-front avoids partially
> +	 * programming iATU windows in vain.
> +	 */
> +	for (i = 0; i < num_submap; i++) {
> +		off = submap[i].offset;
> +		size = submap[i].size;
> +
> +		if (!size)
> +			return -EINVAL;
> +
> +		if (!IS_ALIGNED(size, align) || !IS_ALIGNED(off, align))
> +			return -EINVAL;
> +
> +		if (!IS_ALIGNED(submap[i].phys_addr, align))
> +			return -EINVAL;
> +
> +		if (off > bar_size || size > bar_size - off)
> +			return -EINVAL;
> +
> +		/* Enforce contiguity (no overlaps, no holes). */
> +		if (off != expected)
> +			return -EINVAL;
> +
> +		expected += size;
> +	}
> +	if (expected != bar_size)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Address Match Mode inbound iATU mapping */
> +static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
> +				  const struct pci_epf_bar *epf_bar)
> +{
> +	const struct pci_epf_bar_submap *submap = epf_bar->submap;
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	struct device *dev = pci->dev;
> +	u64 pci_addr, parent_bus_addr;
> +	struct dw_pcie_ib_map *new;
> +	u64 size, off, base;
> +	unsigned long flags;
> +	int free_win, ret;
> +	unsigned int i;
> +
> +	if (!epf_bar->num_submap || !submap || !epf_bar->size)
> +		return -EINVAL;
> +
> +	ret = dw_pcie_ep_validate_submap(ep, submap, epf_bar->num_submap,
> +					 epf_bar->size);
> +	if (ret)
> +		return ret;
> +
> +	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar, epf_bar->flags);
> +	if (!base) {
> +		dev_err(dev,
> +			"BAR%u not assigned, cannot set up sub-range mappings\n",
> +			bar);
> +		return -EINVAL;
> +	}
> +
> +	/* Tear down any existing mappings before (re)programming. */
> +	dw_pcie_ep_clear_ib_maps(ep, bar);
> +
> +	for (i = 0; i < epf_bar->num_submap; i++) {
> +		off = submap[i].offset;
> +		size = submap[i].size;
> +		parent_bus_addr = submap[i].phys_addr;
> +
> +		if (off > (~0ULL) - base) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		pci_addr = base + off;
> +
> +		new = devm_kzalloc(dev, sizeof(*new), GFP_KERNEL);
> +		if (!new) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		spin_lock_irqsave(&ep->ib_map_lock, flags);
> +
> +		free_win = find_first_zero_bit(ep->ib_window_map,
> +					       pci->num_ib_windows);
> +		if (free_win >= pci->num_ib_windows) {
> +			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
> +			devm_kfree(dev, new);
> +			ret = -ENOSPC;
> +			goto err;
> +		}
> +		set_bit(free_win, ep->ib_window_map);
> +
> +		new->bar = bar;
> +		new->index = free_win;
> +		new->pci_addr = pci_addr;
> +		new->parent_bus_addr = parent_bus_addr;
> +		new->size = size;
> +		list_add_tail(&new->list, &ep->ib_map_list);
> +
> +		spin_unlock_irqrestore(&ep->ib_map_lock, flags);
> +
> +		ret = dw_pcie_prog_inbound_atu(pci, free_win, type,
> +					       parent_bus_addr, pci_addr, size);
> +		if (ret) {
> +			spin_lock_irqsave(&ep->ib_map_lock, flags);
> +			list_del(&new->list);
> +			clear_bit(free_win, ep->ib_window_map);
> +			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
> +			devm_kfree(dev, new);
> +			goto err;
> +		}
> +	}
> +	return 0;
> +err:
> +	dw_pcie_ep_clear_ib_maps(ep, bar);
> +	return ret;
> +}
> +
>  static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
>  				   struct dw_pcie_ob_atu_cfg *atu)
>  {
> @@ -204,17 +407,15 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> -	u32 atu_index = ep->bar_to_atu[bar] - 1;
>  
> -	if (!ep->bar_to_atu[bar])
> +	if (!ep->epf_bar[bar])
>  		return;
>  
>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>  
> -	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
> -	clear_bit(atu_index, ep->ib_window_map);
> +	dw_pcie_ep_clear_ib_maps(ep, bar);
> +
>  	ep->epf_bar[bar] = NULL;
> -	ep->bar_to_atu[bar] = 0;
>  }
>  
>  static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
> @@ -408,8 +609,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	else
>  		type = PCIE_ATU_TYPE_IO;
>  
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
> -				     size);
> +	if (epf_bar->use_submap)
> +		ret = dw_pcie_ep_ib_atu_addr(ep, func_no, type, epf_bar);
> +	else
> +		ret = dw_pcie_ep_ib_atu_bar(ep, func_no, type,
> +					    epf_bar->phys_addr, bar, size);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -626,11 +831,22 @@ static const struct pci_epc_features*
>  dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct pci_epc_features *features;
>  
>  	if (!ep->ops->get_features)
>  		return NULL;
>  
> -	return ep->ops->get_features(ep);
> +	features = ep->ops->get_features(ep);
> +	if (!features)
> +		return NULL;
> +
> +	/* All DWC-based glue drivers support dynamic inbound mapping */
> +	features->dynamic_inbound_mapping = true;

I think you should create a separate patch, before this patch, that simply
sets:
features->dynamic_inbound_mapping = true;

Since that is technically a different feature, independent of this
feature, so it deserves its own patch.

With that fixed, this patch looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


> +
> +	/* All DWC-based glue drivers support inbound subrange mapping */
> +	features->subrange_mapping = true;
> +
> +	return features;
>  }
>  
>  static const struct pci_epc_ops epc_ops = {
> @@ -1120,6 +1336,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct device *dev = pci->dev;
>  
>  	INIT_LIST_HEAD(&ep->func_list);
> +	INIT_LIST_HEAD(&ep->ib_map_list);
> +	spin_lock_init(&ep->ib_map_lock);
>  	ep->msi_iatu_mapped = false;
>  	ep->msi_msg_addr = 0;
>  	ep->msi_map_size = 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 4dda9a38d46b..969b1f32dddf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -479,6 +479,8 @@ struct dw_pcie_ep {
>  	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
> +	struct list_head	ib_map_list;
> +	spinlock_t		ib_map_lock;
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
>  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> -- 
> 2.51.0
> 

