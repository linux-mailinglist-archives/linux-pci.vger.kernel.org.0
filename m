Return-Path: <linux-pci+bounces-4974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED000885F61
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4BC1C2268E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FDF3984D;
	Thu, 21 Mar 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOHJ6eqp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90D24A11;
	Thu, 21 Mar 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041240; cv=none; b=CWAHznqugVE2dHcCNjjHflJ+KiBwDG/q2Ncm1ha0VvT0foYgwzbp0E2z4AQaSdJemGbVYhMVWyglVl8tlnxzEJakDPktzjAz7rWjQH/fsL3UrzhFYsPNfVpmEdfjpy5FzN4/axw+5EJBntQTuI4XRYkx1I1yXHt+hlr064kKBtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041240; c=relaxed/simple;
	bh=ucmj0N8ydcrtXPBqqF7rrSK+p1kuNlHoPN4+ab+AFR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1YJs7tl4T+9BzOnnfOVPXjBcaPySpw6Pn9tUaQI7PsTcuDR4vQk/Zvv73vao0icA5yBZBAuoIaJ3AmVb7nljc0UvjNsM723Mk3otCqibZIi0HFb0Zoi/DZsm8zzqF76WLzdFLEIhBnd7w7BMsCGApRqggQI+0tLQGYCjbN0jyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOHJ6eqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B3EC433F1;
	Thu, 21 Mar 2024 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041240;
	bh=ucmj0N8ydcrtXPBqqF7rrSK+p1kuNlHoPN4+ab+AFR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOHJ6eqpPmSNlhLDJYZ4D0y3z8HF49nQVODZQ02VcgSQHV0iiKi/dZa6gENutaLwL
	 gw6fCVg2q3S0HzfmVWAOhYks+eRxl+E/9EHhtdpxQbt4BTx/J2Z0KWc4td1W8TuGGX
	 WIIEFtn0/ZvmX54mB2Mpz77rmj0QIBCGX+9Nz8ASWk8z8PzGZQ+HXCK8gD0Im78OG6
	 aJlkRwjUAL+pypk06qsxtT/2xvgHXMz2zgY52s6+aHgB2427KiHUIM4e4d34ELIkf8
	 vtb9lRlKAxAOXnFQ5s6i5zBsCsMuNAOQhGOLPZJBFojk8cjGlUHTv3XWZysxRH4HhG
	 2WydyZ4zXqQ0A==
Date: Thu, 21 Mar 2024 22:43:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: niklas.cassel@wdc.com, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240321171345.GA2385@thinkpad>
References: <20240304224616.1238966-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304224616.1238966-1-Frank.Li@nxp.com>

On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> dw_pcie_ep_inbound_atu()
> {
> 	...
> 	if (!ep->bar_to_atu[bar])
> 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> 	else
> 		free_win = ep->bar_to_atu[bar];
> 	...
> }
> 
> The atu index 0 is valid case for atu number. The find_first_zero_bit()
> will return 6 when second time call into this function if atu is 0. Suppose
> it should use branch 'free_win = ep->bar_to_atu[bar]'.
> 
> Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> it have not allocate atu to the bar.
> 

I'd rewrite the commit message as below:

"The mapping between PCI BAR and iATU inbound window are maintained in the
dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for a
BAR, dw_pcie_ep_inbound_atu() API will first check for the availability of the
existing mapping in the array and if it is not found (i.e., value in the array
indexed by the BAR is found to be 0), then it will allocate a new map value
using find_first_zero_bit().

The issue here is, the existing logic failed to consider the fact that the map
value '0' is a valid value for BAR0. Because, find_first_zero_bit() will return
'0' as the map value for BAR0 (note that it returns the first zero bit
position).

Due to this, when PERST# assert + deassert happens on the PERST# supported
platforms, the inbound window allocation restarts from BAR0 and the existing
logic to find the BAR mapping will return '6' for BAR0 instead of '0' due to the
fact that it considers '0' as an invalid map value.

So fix this issue by always incrementing the map value before assigning to
bar_to_atu[] array and then decrementing it while fetching. This will make sure
that the map value '0' always represents the invalid mapping."

> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u

This is not the correct link that reported the issue. This one is:
https://lore.kernel.org/linux-pci/ZXsRp+Lzg3x%2Fnhk3@x1-carbon/

> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

With above mentioned changes,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Change from v1 to v2
>     - update subject
>     - use free_win + 1 solution
>     - still leave MAX_IATU_IN as 256. I am not sure if there are platfrom have
>     256 ATU. Suppose it only use max 6 in current EP framework.
>     - @Niklas, can you help test it. My platform become unstable today.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b7..ba932bafdb230 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -139,7 +139,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	if (!ep->bar_to_atu[bar])
>  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
>  	else
> -		free_win = ep->bar_to_atu[bar];
> +		free_win = ep->bar_to_atu[bar] - 1;
>  
>  	if (free_win >= pci->num_ib_windows) {
>  		dev_err(pci->dev, "No free inbound window\n");
> @@ -153,7 +153,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  		return ret;
>  	}
>  
> -	ep->bar_to_atu[bar] = free_win;
> +	/*
> +	 * Always increment free_win before assignment, since value 0 is used to identify
> +	 * unallocated mapping.
> +	 */
> +	ep->bar_to_atu[bar] = free_win + 1;
>  	set_bit(free_win, ep->ib_window_map);
>  
>  	return 0;
> @@ -190,7 +194,10 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> -	u32 atu_index = ep->bar_to_atu[bar];
> +	u32 atu_index = ep->bar_to_atu[bar] - 1;
> +
> +	if (!ep->bar_to_atu[bar])
> +		return;
>  
>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

