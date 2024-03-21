Return-Path: <linux-pci+bounces-4973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D5885EBB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A59281AB3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CC13398E;
	Thu, 21 Mar 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8sbbHfY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93E12B7E;
	Thu, 21 Mar 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039286; cv=none; b=bfQ1fUvGR4vBNcjQVP+vRwMUA/yXIrR9iFHma5OwFfhmbj0vnnjAsXIXVouFqRsGoAATHNHuxX0vMesnY7zwW8XXscQYfCZF0/Pfpfs10bYQo68pYqrtORMWU8+C9VAnIGkkoYjO743iM9//zpGZKMF0HlRWyh7ROgMpsQNYa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039286; c=relaxed/simple;
	bh=8bV00x7Pzvtk3NQyt5ix3BHWHoDGeDZ7GuVakht0b30=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V6Rmo4k2Rovj4jb6mDOHf6gjzhFLCy6fsnIuECoMk8bh/TR2WYe3KPgPu+uiI/3gBQjeiZ+qNxfIkWoGBdV0oOscSZZ2XIEl3435BXnQ3I+VbLJ34F0UoyooBibtwukYPL0m1fCT5KD79jyoFvrvkhwz+Jt3ZzW0VbARuQKw7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8sbbHfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946D3C433C7;
	Thu, 21 Mar 2024 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711039285;
	bh=8bV00x7Pzvtk3NQyt5ix3BHWHoDGeDZ7GuVakht0b30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=s8sbbHfYgexIMqUZNv5hMXCl/ji/E79vlFazre57BmyAJZrjwdC8Of/v4ZhupqiSc
	 YR27wGhywp+Cgz+Ye5k1S8ZGq+TQ/rDGyqHx94vk2MTQ37aipL5fvhzYmyw9kdz+4Q
	 RRi8R2B/U14benzOGBk+bI1Ep5xkWozomidVyeSdf7kGeKrC0m1hzvxtWFLtcstgRv
	 Hx0OvmL9J8ab1vP+KS/6vI7nYwPUB5BDOeghfeZBktSyyBexDFlPQeGsa4AOwCq83A
	 DqlY5ILDs2zYXbORIGN6/3tvJpwH2Z49/eFIUo3RhuYwqJIpcD7gCwmsEcETAMasWI
	 WX55OtOpNd5Tw==
Date: Thu, 21 Mar 2024 11:41:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: niklas.cassel@wdc.com, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240321164123.GA1325373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Lorenzo, Krzysztof, Manivannan: any thoughts on this?  I don't want to
ask Linus to pull it during the merge window since this hasn't even
been in -next yet.  But we could consider it as a fix for v6.9 if it's
urgent.

IMO the commit log does need to say something about what the actual
user-visible problem is.  I can't tell what breakage this fixes.

> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
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

