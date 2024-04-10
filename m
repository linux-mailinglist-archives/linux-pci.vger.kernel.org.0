Return-Path: <linux-pci+bounces-6067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E089FF62
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDE41C226FC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A417F38F;
	Wed, 10 Apr 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/H41PwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515F17F38D;
	Wed, 10 Apr 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772232; cv=none; b=sa/sPWS4T2GcVWJfg0ucc1/e8uzfaxbohI/VI0bJBV7lyAh6clsXIil1MWJXXRsMexG0p7KqAsZbLO6XfwyNty+QGXwabr/pkQLOBUgHdLlH+HSebErRhHv7iCVqDMtZnOTnbHSYbgk9KG7+qu2mefKMQ467gSsL3kzxTwB5ZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772232; c=relaxed/simple;
	bh=60Tcl77NvZCMeT8KikNHcqBwOc2g8JbUZGX1cNmVaxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj93UOjEMtuNOOaRZeQ+AlXBojrPHRPXtWn1oWAjHTeuYFqkCbjGfG/ECVb75ldPjODycOaa9h7AApm3Fh1lZNDCf4cGSdE34xgnUNlEKkfrlkbmjKItAgDi0W2N8J6WkxA7QhNxU8nLC2ygX4l8aKuxhnINF68611Kbwrnv3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/H41PwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C2CC433F1;
	Wed, 10 Apr 2024 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712772232;
	bh=60Tcl77NvZCMeT8KikNHcqBwOc2g8JbUZGX1cNmVaxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/H41PwOpSK1LtcWh1b0nJT2kOvGIKRG24KhoBT9YXx16AAs+c9AvK/6pNWgJvTaj
	 CIQghGKSH/LE+bdfeWzLyLNDjgYD/FlJT5p3hRDkaqo0xh1JafXcUuE9Q3CSrRvEal
	 H7lgYxTd19uvBm4MT4g3kwKB8SPPDjqSXEZ1iBZ+TgBnNG3TBJHdnxHGHS3tHJx+7m
	 5RNhYKdPH8dzyX1JKTRMB3G89pDDNZx3ff6yds4DKHa34/Q/MsPgOoDiuw0MQ6h+69
	 OtclP5s95pBFZqPI+fNvTTSbFdkWUenCM1/KOu9AXHA+7VzXpni3MP6aTeob3pJrif
	 pQ5ge0kAkW80g==
Date: Wed, 10 Apr 2024 23:33:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, helgaas@kernel.org, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240410180341.GF16629@thinkpad>
References: <20240326193540.3610570-1-Frank.Li@nxp.com>
 <ZhPFmFYorWa-sfLp@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhPFmFYorWa-sfLp@ryzen>

On Mon, Apr 08, 2024 at 12:23:20PM +0200, Niklas Cassel wrote:
> On Tue, Mar 26, 2024 at 03:35:40PM -0400, Frank Li wrote:
> > When PERST# assert and deassert happens on the PERST# supported platforms,
> > the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
> > to the area that was previously allocated (iATU0) for BAR0, instead of the
> > new area (iATU6) for BAR0.
> 
> Nit: If we want additional clarity, we could also add:
> ""
> Right now, we dodge the bullet because both iATU0 and iATU6 should currently
> translate inbound accesses to BAR0 to the same allocated memory area. However,
> having two separate inbound mappings for the same BAR is a disaster waiting to
> happen.
> ""

Since Bjorn asked for the above info, it should get added.

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> 
> If the maintainers feel like this additional information is important, I think
> it could be added while applying. (But I also think that the existing commit
> message is detailed enough to be applied as is.)
> 
> 
> > 
> > The mapping between PCI BAR and iATU inbound window are maintained in the
> > dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
> > a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
> > of the existing mapping in the array and if it is not found (i.e., value in
> > the array indexed by the BAR is found to be 0), then it will allocate a new
> > map value using find_first_zero_bit().
> > 
> > The issue here is, the existing logic failed to consider the fact that the
> > map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
> > will return '0' as the map value for BAR0 (note that it returns the first
> > zero bit position).
> > 
> > Due to this, when PERST# assert + deassert happens on the PERST# supported
> > platforms, the inbound window allocation restarts from BAR0 and the
> > existing logic to find the BAR mapping will return '6' for BAR0 instead of
> > '0' due to the fact that it considers '0' as an invalid map value.
> > 
> > So fix this issue by always incrementing the map value before assigning to
> > bar_to_atu[] array and then decrementing it while fetching. This will make
> > sure that the map value '0' always represents the invalid mapping."
> > 
> > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > Closes: https://lore.kernel.org/linux-pci/ZXsRp+Lzg3x%2Fnhk3@x1-carbon/
> > Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v2 to v3
> >     - Add impact in commit message
> >     - Add mani's detail description
> >     - Fix Closes link
> >     
> >     Change from v1 to v2
> >     - update subject
> >     - use free_win + 1 solution
> >     - still leave MAX_IATU_IN as 256. I am not sure if there are platfrom have
> >     256 ATU. Suppose it only use max 6 in current EP framework.
> >     - @Niklas, can you help test it. My platform become unstable today.
> > 
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 5befed2dc02b7..ba932bafdb230 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -139,7 +139,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> >  	if (!ep->bar_to_atu[bar])
> >  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> >  	else
> > -		free_win = ep->bar_to_atu[bar];
> > +		free_win = ep->bar_to_atu[bar] - 1;
> >  
> >  	if (free_win >= pci->num_ib_windows) {
> >  		dev_err(pci->dev, "No free inbound window\n");
> > @@ -153,7 +153,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> >  		return ret;
> >  	}
> >  
> > -	ep->bar_to_atu[bar] = free_win;
> > +	/*
> > +	 * Always increment free_win before assignment, since value 0 is used to identify
> > +	 * unallocated mapping.
> > +	 */
> > +	ep->bar_to_atu[bar] = free_win + 1;
> >  	set_bit(free_win, ep->ib_window_map);
> >  
> >  	return 0;
> > @@ -190,7 +194,10 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	enum pci_barno bar = epf_bar->barno;
> > -	u32 atu_index = ep->bar_to_atu[bar];
> > +	u32 atu_index = ep->bar_to_atu[bar] - 1;
> > +
> > +	if (!ep->bar_to_atu[bar])
> > +		return;
> >  
> >  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
> >  
> > -- 
> > 2.34.1
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

