Return-Path: <linux-pci+bounces-23115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB5A56853
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7853AE3FF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A2184E;
	Fri,  7 Mar 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl9P/RG3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7668218AAA
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352094; cv=none; b=kHOpTxY3xsLdYffq5Y+Hq1VbpRSgjTAsGIafye30jiFsWLAZz9EBekvw3pTAEa5dm5Tx1xsYu1UgYiavTP0fPpt1QZIEpdJqHcyDBXS7GZ9i0jhCHfT7pxioTRCbu7+feGrmKzOSQTTqFCAXgb7fDkKdSRDs5Tto3GXx683gdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352094; c=relaxed/simple;
	bh=o++8AbjLnKG67fjjbqh+Seu6MUpSl6qOpkn3heug49c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9TEZyoqZtCERYDq83AMeSoysCwXTGr7S4pZZ8X3FmjGweHCRqYf1QAaAUf8WS9YbRZDAlW8rdzm8tCEpkX0nictutyQtdjyU10TwQzHjgQ81Iag9Awo+GeoJk5XZao1eLFOMJGC4uYrvB7+Ui+6Rb3pslQeKdLxLGnKSLUGbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl9P/RG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B9FC4CEE5;
	Fri,  7 Mar 2025 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741352094;
	bh=o++8AbjLnKG67fjjbqh+Seu6MUpSl6qOpkn3heug49c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tl9P/RG36mjArjrPMuVoJxw4NPF2TJoOaX3p4XTe1cWVhMkEYICRGkM0k/evbBc8B
	 4wm3gQelmk7l0A1XALEwI1yUB/Gxzo1U/4pPtxR0klVNpT8su9cIm53LSgoi8hKTNc
	 qaegaefGPEBpjAlteSNbpCxDsE5Ayz/ZHZHY0f+FVCnngl64iVdp0iw7sykoAnVjeq
	 iEpp04jEvNpfOcWH7oRZ8d6Fd/KZMSCAxHy9CLcxYFHdIldEhnhfDONubak2RZvVpq
	 1fYH+4gi9odhGu8EoXuirXzQ/EQSAmPaE5xJpbV3IpIxaw12bU7TcdjOr4q8uFXsbo
	 ODh731ig4J/wQ==
Date: Fri, 7 Mar 2025 13:54:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: ep: Add dw_pcie_ep_hide_ext_capability()
Message-ID: <Z8rsmQpCWp2yVZ92@ryzen>
References: <20250307124732.704375-4-cassel@kernel.org>
 <20250307124732.704375-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307124732.704375-5-cassel@kernel.org>

On Fri, Mar 07, 2025 at 01:47:34PM +0100, Niklas Cassel wrote:
> Add dw_pcie_ep_hide_ext_capability() which can be used by an endpoint
> controller driver to hide a capability.
> 
> This can be useful to hide a capability that is buggy, such that the
> host side does not try to enable the buggy capability.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 38 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  7 ++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index a8568808b5e5..d671fea1e7c6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -102,6 +102,44 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>  	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
>  }
>  
> +/**
> + * dw_pcie_ep_hide_ext_capability - Hide a capability from the linked list
> + * @pci: DWC PCI device
> + * @prev_cap: Capability preceding the capability that should be hidden
> + * @cap: Capability that should be hidden
> + *
> + * Return: 0 if success, errno otherwise.
> + */
> +int dw_pcie_ep_hide_ext_capability(struct dw_pcie *pci, u8 prev_cap, u8 cap)
> +{
> +	u16 prev_cap_offset, cap_offset;
> +	u32 prev_cap_header, cap_header;
> +
> +	prev_cap_offset = dw_pcie_find_ext_capability(pci, prev_cap);
> +	if (!prev_cap_offset)
> +		return -EINVAL;
> +
> +	prev_cap_header = dw_pcie_readl_dbi(pci, prev_cap_offset);
> +	cap_offset = PCI_EXT_CAP_NEXT(prev_cap_header);
> +	cap_header = dw_pcie_readl_dbi(pci, cap_offset);
> +
> +	/* cap must immediately follow prev_cap. */
> +	if (PCI_EXT_CAP_ID(cap_header) != cap)
> +		return -EINVAL;
> +
> +	/* Clear next ptr. */
> +	prev_cap_header &= ~GENMASK(31, 20);
> +
> +	/* Set next ptr to next ptr of cap. */
> +	prev_cap_header |= cap_header & GENMASK(31, 20);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writel_dbi(pci, prev_cap_offset, prev_cap_header);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +}

We should have a:
EXPORT_SYMBOL_GPL(dw_pcie_ep_hide_ext_capability);

here too for it to work with PCI EPC drivers that can be built as modules.

Tell me if I should send a v3, or if you can amend this line when applying.


Kind regards,
Niklas

