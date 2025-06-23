Return-Path: <linux-pci+bounces-30402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803CAE479D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B303BD8D5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16B8634F;
	Mon, 23 Jun 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwzDaKgT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03204248893
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690347; cv=none; b=O28eTVEZQflHVS1q13vSm1h16PvrwRB4OmnSYTqGN472WSIaQkD6ds2MF4O4wG+OuuNqb6PhkNIbZ7f3IEqaSbXwG1DM7qHNhPbfjIXO/JZNxolDAJxuJ6ZQkqrkd1VXWC8eh+lLxbxY4DLspki3Dd0aIeVl6z54Xu+tvOgDiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690347; c=relaxed/simple;
	bh=O0fKblcRUUtczRnaF4sL2xxs/9Y5m7xRAs+zvsoB5m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu2yl5XvXKtBqcfMWBDTDy+Wu55i4BQ5oRed47TcXO0Z+wJblTmeWlfWtMSHk22HmTCySRZRISj8e+tsQ7ua+V/uNvqTXr5NIeR9L65flnuZwirV2bf3wwvYOE/jOkDbV/6mHNSgv4koGog61ced+poWC2RLo2cpy86yMfImIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwzDaKgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EB8C4CEEA;
	Mon, 23 Jun 2025 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750690346;
	bh=O0fKblcRUUtczRnaF4sL2xxs/9Y5m7xRAs+zvsoB5m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwzDaKgTzs6IA0+qPO2Sf+toQ4H4ZpHoqWZPiKirtli4e4aoOBwipIJxy6+4ONool
	 i9IsmVhR+iQ6ggFAbnT2WMfMEZdndZf5RSmGADwOkv0ZwXHFPuSKwW8zJPJwNqVNFs
	 SlY9JmFo1mYoSGuASNZHJ4mmja4NxNtFglf9/Fpk1nzSnMiiNhUybxouP5L45y8QVd
	 n1xRHdVBMs3ZeswrKlmImixKHWH8yTQUX8H5eSz6r8/dj1zdZEVhKzkbjt52gK+Mlx
	 7hSwjeDIocg1kYlAuXBVonbzffYyFsKZ1jFjBbfOZOuFkrOjm+XCyLqmZHPYlZTkjA
	 dA/AZTROEcsng==
Date: Mon, 23 Jun 2025 08:52:24 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
Message-ID: <fpnu2jymgzicr23fygizjg3jnaddrzjorvtsgyzxiy25umurhq@yovbbyx36ibv>
References: <20250613124839.2197945-8-cassel@kernel.org>
 <20250613124839.2197945-14-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613124839.2197945-14-cassel@kernel.org>

On Fri, Jun 13, 2025 at 02:48:45PM +0200, Niklas Cassel wrote:
> There is no reason for the delay, in each loop iteration, while polling for
> link up (LINK_WAIT_SLEEP_MS), to be so long as 90 ms.
> 
> PCIe r6.0, sec 6.6.1, still require us to wait for up to 1.0 s for the link
> to come up, thus the number of retries (LINK_WAIT_MAX_RETRIES) is increased
> to keep the total timeout to 1.0 s.
> 
> PCIe r6.0, sec 6.6.1, also mandates that there is a 100 ms delay, after the
> link has been established, before performing configuration requests (this
> delay already exists in dw_pcie_wait_for_link() and is unchanged).
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c |  6 +++++-
>  drivers/pci/controller/dwc/pcie-designware.h | 13 +++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 24903f67d724..ae6f0bfe3c56 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -701,7 +701,11 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  	u32 offset, val;
>  	int retries;
>  
> -	/* Check if the link is up or not */
> +	/*
> +	 * Check if the link is up or not. As per PCIe r6.0, sec 6.6.1, software
> +	 * must allow at least 1.0 s following exit from a Conventional Reset of
> +	 * a device, before determining that the device is broken.
> +	 */
>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>  		if (dw_pcie_link_up(pci))
>  			break;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ce9e18554e42..b225c4f3d36a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -62,11 +62,16 @@
>  #define dw_pcie_cap_set(_pci, _cap) \
>  	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
>  
> -/* Parameters for the waiting for link up routine */
> -#define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_SLEEP_MS		90
> +/*
> + * Parameters for waiting for a link to be established. As per PCIe r6.0,
> + * sec 6.6.1, software must allow at least 1.0 s following exit from a
> + * Conventional Reset of a device, before determining that the device is broken.
> + * Therefore LINK_WAIT_MAX_RETRIES * LINK_WAIT_SLEEP_MS should equal 1.0 s.
> + */
> +#define LINK_WAIT_MAX_RETRIES		100
> +#define LINK_WAIT_SLEEP_MS		10

These are not DWC specific. So I'd recommend moving it to drivers/pci/pci.h.

Also, I'd have fancied a helper that does the link check with all delays taken
care of. But that involves creating a common link_up function and would take a
bit more work. So leaving that is fine for the moment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

