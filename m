Return-Path: <linux-pci+bounces-31107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E27AEE808
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 22:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D103188C9C0
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822A22DFA3;
	Mon, 30 Jun 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUVHTrYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369922DFBA
	for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751314744; cv=none; b=NUh9XXkDwvfp60WQQzeNCCzrNsZFQ56x5sMVGY3dSdRWZG3LWXLWrVkNAv3cIm3zHlz56C2XQ76pwGvwUBVE/mOf6iEQ2FdgTazIO+YnG/0mqGBKpNpvXuxb6Bxna/+3QsiMtExXxa3Bveivhgy71STBTXy69Bfv+j1AlS4mRoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751314744; c=relaxed/simple;
	bh=thuuUSbTybwXUzPkCuAE7KRTZ8ZhuDy4d01sh2uAd7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kn7nNdORlz8ukyawl1yaC2vjdsbr7+h7MydeIf85nqvaDyw0hwNO5F/NygslWPgKk5K3wfIN/ED0CcZ6RMxuOa1+5RzbkErpUkVv7H2hAX5MIIb/Klm+Gq61LALNLpgkNpIslWiqAroyzg02IYVc0qzBPZzQko9fGzizD17Z6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUVHTrYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB575C4CEE3;
	Mon, 30 Jun 2025 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751314744;
	bh=thuuUSbTybwXUzPkCuAE7KRTZ8ZhuDy4d01sh2uAd7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XUVHTrYIO7KLvE49uGWiD/tGzrUuY+LKghu+JinzWlE3Sya4P1PeFMvOtegXBuisz
	 Q/n4PwW9aqmfCke+p3lnClK+4ivmDCah+k6Qg1OE06z7GrdJ9i8ksbESYNgdxJR42W
	 IMWutwuNTsCITJvh5SRIMJAtvaDz0wHAJNMxxc05Qj4NoF/cwqjE3T57FqktVtxeuy
	 ZFQbLZJ1ZWmspMYxNuN9WmS7tG+FECXXWf7BHWIrgIJXwopzasF4gfMRl3v67AO5JE
	 IVqzpl71c5JrGSuK9gKbnSdaZDJQYvZyHr6rKzkpt0lukaBEfZK1fzXbYgyIGNa2o0
	 Eko0oH/jBh57A==
Date: Mon, 30 Jun 2025 15:19:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <20250630201902.GA1798294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625102347.1205584-14-cassel@kernel.org>

On Wed, Jun 25, 2025 at 12:23:51PM +0200, Niklas Cassel wrote:
> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> training completes before sending a Configuration Request.
> 
> Add this delay in dw_pcie_wait_for_link(), after the link is reported as
> up. The delay will only be performed in the success case where the link
> came up.
> 
> DWC glue drivers that have a link up IRQ (drivers that set
> use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
> perform this delay in their threaded link up IRQ handler.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4d794964fa0f..053e9c540439 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -714,6 +714,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		return -ETIMEDOUT;
>  	}
>  
> +	/*
> +	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
> +	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> +	 * after Link training completes before sending a Configuration Request.
> +	 */
> +	if (pci->max_link_speed > 2)
> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);

Sec 6.6.1 also requires "100 ms following exit from a Conventional
Reset before sending a Configuration Request to the device immediately
below that Port" for Downstream Ports that do *not* support Link
speeds greater than 5.0 GT/s.

Where does that delay happen?

>  	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
>  
> -- 
> 2.49.0
> 

