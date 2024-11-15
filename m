Return-Path: <linux-pci+bounces-16855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36FA9CDBE7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B56D1F21942
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD71AF0BE;
	Fri, 15 Nov 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS7VomFC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D0192B86;
	Fri, 15 Nov 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664393; cv=none; b=GxJ08OYlGrhe5S6UOkSe8xvOpaRkMCuA2HdyfcN+4eENxmRTUV3r2wbxl1Gu1A4f3rengrJFLmDDJXk9EWVjXY+/ZS11aVoFaOw2w7yJ+8b6XhY2EYMIaL1lZK9PjE/o3g9OKMmH7kaD8znMTN8f2mvC9UvDmz7KHwIJ7Hbd7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664393; c=relaxed/simple;
	bh=LA+PquU5EOzHfhbQ9li0o4XBaqT+vOref1iMwYUFCYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnbmiwImZtkpkc2F/+zVQJ+pSHx56jKISFD2sWIGF0MbiIc8DWGowOhqeaj3nYLMSNjA4ZU5RntsWIvZ27GzLuiY1+CobM7Ii5UJyM0dkiGMk4OxBFJYCU3GFfZKO5SDo+zjVn4aEVkC5MDe8YEiUJcpgBrhGObQbCH4LZf9sbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS7VomFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED44C4CED4;
	Fri, 15 Nov 2024 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731664392;
	bh=LA+PquU5EOzHfhbQ9li0o4XBaqT+vOref1iMwYUFCYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dS7VomFCDmJFVoWc28AjaXgjfRiTt5VCE2WWnw5SvNiUIgRIO5kOdHMS8UhDVUnce
	 MZehENLsEV5K9u7eIGMXKN3bb582PDKkhbrp0EQ3vE8Q+U3EJWMG1Hruk/O18v+aBb
	 qODwEe8RmRf0O6v882Xh3lPEk30qlRU1UH8muuGq/VM3rFrQYPYd38+ziO2Pgbk6n6
	 U/GCniYZlWcBk0aoc+B9uepEURNgJ53fzLZzrOCrFm5BdjiDwgq9aHCgVES4Lu1KTs
	 Kqd/BYUMkUVSjfKMrYgt1l/qwgeB83+WP28t2khErqOcccwYrs24AAAsNq7IwEml5U
	 BojV1jkiRNjMw==
Date: Fri, 15 Nov 2024 10:53:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v7 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <ZzcaA4PMHRcsEaDt@ryzen>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
 <20241114-ep-msi-v7-3-d4ac7aafbd2c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-ep-msi-v7-3-d4ac7aafbd2c@nxp.com>

On Thu, Nov 14, 2024 at 05:52:39PM -0500, Frank Li wrote:
> Introduce the helper function pci_epf_align_addr() to adjust addresses
> according to PCI BAR alignment requirements, converting addresses into base
> and offset values.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v6 to v7
> - new patch
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 39 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-epf.h             | 13 +++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 8fa2797d4169a..a3f172cc786e9 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -464,6 +464,45 @@ struct pci_epf *pci_epf_create(const char *name)
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_create);
>  
> +/**
> + * pci_epf_align_addr() - Get base address and offset that match bar's
> + *			  alignment requirement
> + * @epf: the EPF device
> + * @addr: the address of the memory
> + * @bar: the BAR number corresponding to map addr
> + * @base: return base address, which match BAR's alignment requirement, nothing
> + *	  return if NULL
> + * @off: return offset, nothing return if NULL
> + *
> + * Helper function to convert input 'addr' to base and offset, which match
> + * BAR's alignment requirement.
> + */
> +int pci_epf_align_addr(struct pci_epf *epf, enum pci_barno bar, u64 addr, u64 *base, size_t *off)

Nit: perhaps rename this function to:
pci_epf_align_ib_addr()
or
pci_epf_align_inbound_addr()

to more clearly not confuse this with:
if (epc->ops->align_addr)
.align_addr()
(Ideally those functions should have been named align_ob_addr(),
or align_outbound_addr())


> +{
> +	const struct pci_epc_features *epc_features;
> +	u64 align;
> +
> +	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
> +	if (!epc_features) {
> +		dev_err(&epf->dev, "epc_features not implemented\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	align = epc_features->align;
> +	align = align ? align : 128;
> +	if (epc_features->bar[bar].type == BAR_FIXED)
> +		align = max(epc_features->bar[bar].fixed_size, align);
> +
> +	if (base)
> +		*base = round_down(addr, align);
> +
> +	if (off)
> +		*off = addr & (align - 1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_align_addr);
> +
>  static void pci_epf_dev_release(struct device *dev)
>  {
>  	struct pci_epf *epf = to_pci_epf(dev);
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 5374e6515ffa0..20f4f31ba9b36 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -238,6 +238,19 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  enum pci_epc_interface_type type);
>  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  			enum pci_epc_interface_type type);
> +
> +int pci_epf_align_addr(struct pci_epf *epf, enum pci_barno bar, u64 addr, u64 *base, size_t *off);
> +static inline int pci_epf_align_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
> +					   u32 low, u32 high, u64 *base, size_t *off)
> +{
> +	u64 addr = high;
> +
> +	addr <<= 32;
> +	addr |= low;
> +
> +	return pci_epf_align_addr(epf, bar, addr, base, off);
> +}

I'm not sure if this function deserves to live :)
Can't the caller just do this before calling pci_epf_align_addr() ?


Kind regards,
Niklas

