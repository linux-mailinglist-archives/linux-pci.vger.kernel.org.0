Return-Path: <linux-pci+bounces-17695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074079E427A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04221699F4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A5320DD63;
	Wed,  4 Dec 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzUcVkzg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA032202C39;
	Wed,  4 Dec 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332639; cv=none; b=pKmSd9xd2TFAAezsfwk8nm9bJXIrR9BT7+dqux9/iesIG2FFTFT4cG9lIHXctnWbG/MQbjtJ9yKRsG2ocP2BIgV8NUC6ZNxAY+06rOcQDn27Lsores3B79kjwVdFui9CC4BtKWLd7kBAD+ROOo12jPC48mhU5J21w+H7R9xyPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332639; c=relaxed/simple;
	bh=uSz+sEEw2oT3nyzLQJLoBEJ9EIAKnpYCcjWGceBwYHE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zsq3Q2jG4ZHs6K6ixZ3R63Vb8mAFAgYZvZcgBjbC0c39LVvV73cXzuHB1AXsBuZyULrqvoEr7KtvMcG5B4S9y9seOHnHqV2WBMzIJMw6V10zjGo0Fsbtb4XwaQzY38XbEOGtQeraUXJI36ETQwfoU4t8WDBX3XNg9UMOAKA6D7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzUcVkzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3789CC4CECD;
	Wed,  4 Dec 2024 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332638;
	bh=uSz+sEEw2oT3nyzLQJLoBEJ9EIAKnpYCcjWGceBwYHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gzUcVkzgIDOX+3sNoYZ2m5S8gUJkCgDRaK/qOGs/K9mg+UBc581dBYqWvYcPuVsHX
	 smVWpgPqSmAECm/MFpowLEdhRa/m6uL9dPnzuPJ4vvEnWSR04cfKNI73xz6STBe2w3
	 fcKl7kCelX0eX3rKmxLFFWY56VxNj4u5z6dyw1iwV/rcJKV9HuWQlTTSdeAaxrQ13L
	 qM/jayOL5o6IwK059iR0WvSdxKKRKwdPPdxAD/BbGiladrytgutwZkvbQhx6DSzQP3
	 T8mklJkZQM1Td4gHGr2q+XCam7Zh6eE+yvZ81qVW1G4x3kp2uslbhucxUc3I21eYPu
	 TEoF/iCYF5woQ==
Date: Wed, 4 Dec 2024 11:17:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v5 2/6] PCI: dwc: ep: Add missing checks when dynamically
 changing a BAR
Message-ID: <20241204171716.GA2691918@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127103016.3481128-10-cassel@kernel.org>

[+cc NTB list, since NTB seems to be the main user of .set_bar()]

Can we say something specific in the subject line, like "prevent
changing size/flags" or whatever?

On Wed, Nov 27, 2024 at 11:30:18AM +0100, Niklas Cassel wrote:
> In commit 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
> inbound map address") set_bar() was modified to support dynamically
> changing the physical address of a BAR.
> 
> This means that set_bar() can be called twice, without ever calling
> clear_bar(), as calling clear_bar() would clear the BAR's PCI address
> assigned by the host).

Unpaired parenthesis at end.

Apparently calling .set_bar() twice without calling .clear_bar() is a
problem?  What problem does it cause?  Sorry about my poor
understanding of the endpoint and NTB code; I'm sure this would be
obvious if I understood more.

Maybe a hint about the reason why we need to call .set_bar() twice
would help me understand.

> This can only be done if the new BAR configuration doesn't fundamentally
> differ from the existing BAR configuration. Add these missing checks.

Can you elaborate a bit on what "fundamentally differ" means?  Based
on the patch, I guess it has to do with changing the size or type?

And the problem this would cause is ...?  I guess it's a problem for
some other entity that knows about the BAR and is doing MMIO or DMA to
it?

> While at it, add comments which clarifies the support for dynamically
> changing the physical address of a BAR. (Which was also missing.)
> 
> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index bad588ef69a4..01c739aaf61a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -222,8 +222,28 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
>  		return -EINVAL;
>  
> -	if (ep->epf_bar[bar])
> +	/*
> +	 * Certain EPF drivers dynamically change the physical address of a BAR
> +	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
> +	 * calling clear_bar() would clear the BAR's PCI address assigned by the
> +	 * host).
> +	 */
> +	if (ep->epf_bar[bar]) {
> +		/*
> +		 * We can only dynamically change a BAR if the new configuration
> +		 * doesn't fundamentally differ from the existing configuration.
> +		 */
> +		if (ep->epf_bar[bar]->barno != bar ||
> +		    ep->epf_bar[bar]->size != size ||
> +		    ep->epf_bar[bar]->flags != flags)
> +			return -EINVAL;
> +
> +		/*
> +		 * When dynamically changing a BAR, skip writing the BAR reg, as
> +		 * that would clear the BAR's PCI address assigned by the host.
> +		 */
>  		goto config_atu;
> +	}
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
> -- 
> 2.47.0
> 

