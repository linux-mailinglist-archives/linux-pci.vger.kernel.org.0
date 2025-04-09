Return-Path: <linux-pci+bounces-25598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8B3A832B1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 22:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7A47A5EF1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8E202C39;
	Wed,  9 Apr 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrcq5M/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBA1EB18C;
	Wed,  9 Apr 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744231166; cv=none; b=Etr8xEzfeHLY0cOMyIHSlajyt05xw0fhudBvDkt5P+Qkjq9T8y0kHp7pVS62CMt/ZEHKxjc7WmRvMkBd2w4ZO4qDeTetmCWGZZeCW+yRozn1Kc2QuhtNIpq4l2eBehdPF7b1i153PynGit1xL1T147JQ9YRJVCbZa1N68LRSRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744231166; c=relaxed/simple;
	bh=PXaRRTFy7bWWNGMulgtEHLLhwWsaJHDiExnPpSJMUqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b35ecuy3ngaSyEsYhu4/PwBizrPpkeiYWooVWEXf4KscUklgjV5LvjLR/GxqVp4fY6eMK7N5Mkjjkrj6RvW9E8uYMNqZOo8yC1dHuu+AUDLWEVPY/B+p1/mrrzeTMVQA8anSPcTpa7YzfuavcSJ6sVzZIk58OHjkIq2Rylxpj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrcq5M/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD62C4CEE2;
	Wed,  9 Apr 2025 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744231164;
	bh=PXaRRTFy7bWWNGMulgtEHLLhwWsaJHDiExnPpSJMUqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hrcq5M/9WJL/uZTfsfkfvnttmSUwSmNTgSasnH275o5mt4mrHFKgCqC2DwbI5tZqX
	 qSq1SZwRnb8dxZA23eYVF5GPS4Wvg2DhTxJilrc1vDO84zTMQWmo+bmdsSL3HgWFKD
	 EcnTPXo88O1Cr+2eWNZKbpMSIwVjZjHO54BjWWFOvhQreh0YwT88hmLCvRTp8wWW+i
	 R7xWr8TB0A81SIdG45MsfJfNqyNU+jV1izbnyw482/ZBA5dt2y9Ui9eCBlJ1ITAWqJ
	 Zs4XiV4KOC5gtNhz013rvnodETzfPM4r4kcrjrRlLR69T96xIvh13IDPUqa59EwREW
	 DNAvtJ1Z250CA==
Date: Wed, 9 Apr 2025 15:39:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] PCI: cadence: Add header support for PCIe next
 generation controllers
Message-ID: <20250409203923.GA295549@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1CE94EC3F4A0D6B9849818A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Thu, Mar 27, 2025 at 11:26:21AM +0000, Manikandan Karunakaran Pillai wrote:
> Add the required definitions for register addresses and register bits
> for the next generation Cadence PCIe controllers - High performance
> rchitecture(HPA) controllers. Define register access functions for
> SoC platforms with different base address

"Next generation" is not really meaningful since there will probably
be a next-next generation, and "high performance architecture" is
probably not much better because the next-next generation will
presumably be "higher than high performance."

I would just use the codename or marketing name and omit "next
generation."  Maybe that's "HPA" and we can look forward to another
superlative name for the next generation after this :)

s/High performance/High Performance/
s/rchitecture/Architecture/

Add period at end of sentence.

> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
> +	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
> +			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) + 0x04)
> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
> +	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
> +			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) + 0x08)
> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) + 0x0C)
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
> +	(GENMASK(9, 4) << ((f) * 10))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
> +	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b)))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
> +	(GENMASK(3, 0) << ((f) * 10))
> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
> +	(((c) << ((b) * 10)) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))

Wow, these names are ... loooong.  This would be more readable if they
could be abbreviated a bit.  "PCIE" could be dropped with no loss.
There are probably other words that could be dropped too.

>  struct cdns_pcie_ops {
>  	int	(*start_link)(struct cdns_pcie *pcie);
>  	void	(*stop_link)(struct cdns_pcie *pcie);
>  	bool	(*link_up)(struct cdns_pcie *pcie);
>  	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
> +	int	(*pcie_host_init_root_port)(struct cdns_pcie_rc *rc);
> +	int	(*pcie_host_bar_ib_config)(struct cdns_pcie_rc *rc,
> +					   enum cdns_pcie_rp_bar bar,
> +					   u64 cpu_addr, u64 size,
> +					   unsigned long flags);
> +	int	(*pcie_host_init_address_translation)(struct cdns_pcie_rc *rc);
> +	void	(*pcie_detect_quiet_min_delay_set)(struct cdns_pcie *pcie);
> +	void	(*pcie_set_outbound_region)(struct cdns_pcie *pcie, u8 busnr, u8 fn,
> +					    u32 r, bool is_io, u64 cpu_addr,
> +					    u64 pci_addr, size_t size);
> +	void	(*pcie_set_outbound_region_for_normal_msg)(struct cdns_pcie *pcie,
> +							   u8 busnr, u8 fn, u32 r,
> +							   u64 cpu_addr);
> +	void	(*pcie_reset_outbound_region)(struct cdns_pcie *pcie, u32 r);

Also some pretty long names here that don't fit the style of the
existing members (none of the others have the "pcie_" prefix).

> + * struct cdns_pcie_reg_offset - Register bank offset for a platform
> + * @ip_reg_bank_off - ip register bank start offset
> + * @iP_cfg_ctrl_reg_off - ip config contrl register start offset

s/@iP_cfg_ctrl_reg_off/@ip_cfg_ctrl_reg_off/

"scripts/kernel-doc -none <file>" should find errors like this for you.

s/contrl/control/

> + * @axi_mstr_common_off - AXI master common register start
> + * @axi_slave_off - AXI skave offset start

s/skave/slave/

> +struct cdns_pcie_reg_offset {
> +	u32  ip_reg_bank_off;
> +	u32  ip_cfg_ctrl_reg_off;
> +	u32  axi_mstr_common_off;
> +	u32  axi_slave_off;
> +	u32  axi_master_off;
> +	u32  axi_hls_off;
> +	u32  axi_ras_off;
> +	u32  axi_dti_off;
>  };
>  
>  /**
> @@ -305,10 +551,12 @@ struct cdns_pcie {
>  	struct resource		*mem_res;
>  	struct device		*dev;
>  	bool			is_rc;
> +	bool			is_hpa;
>  	int			phy_count;
>  	struct phy		**phy;
>  	struct device_link	**link;
>  	const struct cdns_pcie_ops *ops;
> +	struct cdns_pcie_reg_offset cdns_pcie_reg_offsets;

Why does struct cdns_pcie need to contain an entire struct
cdns_pcie_reg_offset instead of just a pointer to it?

> +static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_reg_bank bank)
> +{
> +	u32 offset;
> +
> +	switch (bank) {
> +	case REG_BANK_IP_REG:
> +		offset = pcie->cdns_pcie_reg_offsets.ip_reg_bank_off;

It's a little hard to untangle this without being able to apply the
series, but normally we would add the struct cdns_pcie_reg_offset
definition, the inclusion in struct cdns_pcie, this use of it, and the
setting of it in the same patch.

>  #ifdef CONFIG_PCIE_CADENCE_EP
> @@ -556,7 +909,10 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	return 0;
>  }
>  #endif
> -

Probably spurious change?  Looks like we would want the blank line
here.

> +bool cdns_pcie_linkup(struct cdns_pcie *pcie);
> +bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie);
> +int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie);
> +void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie);
>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);

