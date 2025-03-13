Return-Path: <linux-pci+bounces-23685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B7A600F6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 20:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8527A5D8A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8E1F0E39;
	Thu, 13 Mar 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwAdaVuI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2718FDBD;
	Thu, 13 Mar 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893776; cv=none; b=MIeiGKbegINTkTs7SIGdP2LUI41UY/wHwcQS4moSjB3r1THnhf3QwGIk5jUdB1qVagSzGIt1W3r1GGv6AXTCD2tlCxqvxRK75V/pZUtFgAGvgkfzw8wiXjRwD4xbZDY98Ejcvug8V/LcxRnQtOSJ7k/89Gw0B3VttLdErXK0GTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893776; c=relaxed/simple;
	bh=TPxMt3+3ya/xiakX1ZCCMTSMgWKwulEPWUUTcrGsWsg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lx/T4uwHZWxy9C3edSgFn3Odauy2Bf59+LpOkAl2klKjjlLRuusOxyKpLp3YtBUn8IzeLPAzBUJpuymLoyfCeQZrNT0V7C+qEnbqMDA4wC8z8MxH8OuFc+NNUgB602PsSOpwBY5WDAU8d3HtVmKCqvJfb5BS+O47yHLIzbGs284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwAdaVuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA799C4CEDD;
	Thu, 13 Mar 2025 19:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741893776;
	bh=TPxMt3+3ya/xiakX1ZCCMTSMgWKwulEPWUUTcrGsWsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PwAdaVuI88bABqmdfBg5C1kTVcvgUmvX7VqesS1VWd0Ud8riwvyk+HvI2t4gYSCsF
	 d41BZvSxcnz1lQAmsDr3hBfnCdaZHzh0r2qhv+n/iIj9GqZ5cKXS0NrVM8ObiV0fPn
	 m9DkUeXjo6ZcsFiHos9vgjfyS5OHJSUWozwiIoR2A6gVYnsQqooIAl+jBHwyBpBhQ+
	 7YByORQoccpAEsbytgrm9nX1z2sov8VX73UEfGXFO9FUSeNYhAcIdPxls9tndIA7+m
	 T6QCBwUA6MqW8XpKg1RxqeBANdPXBbueMGPTRW7Bx+1GLuXrlaXZtOafVvGSzZWZIa
	 GQqLBeCwkR3Yw==
Date: Thu, 13 Mar 2025 14:22:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 04/11] PCI: dwc: Move devm_pci_alloc_host_bridge() to
 the beginning of dw_pcie_host_init()
Message-ID: <20250313192254.GA745234@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-pci_fixup_addr-v11-4-01d2313502ab@nxp.com>

On Thu, Mar 13, 2025 at 11:38:40AM -0400, Frank Li wrote:
> Move devm_pci_alloc_host_bridge() to the beginning of dw_pcie_host_init().
> Since devm_pci_alloc_host_bridge() is common code that doesn't depend on
> any DWC resource, moving it earlier improves code logic and readability.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index c57831902686e..52a441662cabe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -452,6 +452,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	raw_spin_lock_init(&pp->lock);
>  
> +	bridge = devm_pci_alloc_host_bridge(dev, 0);
> +	if (!bridge)
> +		return bridge;

This returns NULL (0) where it previously returned -ENOMEM.  Callers
interpret zero as "success", so I think it should stil return -ENOMEM.

I tentatively changed it back to -ENOMEM locally, let me know if
that's wrong.

> +	pp->bridge = bridge;
> +
>  	ret = dw_pcie_get_resources(pci);
>  	if (ret)
>  		return ret;
> @@ -460,12 +466,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> -	bridge = devm_pci_alloc_host_bridge(dev, 0);
> -	if (!bridge)
> -		return -ENOMEM;
> -
> -	pp->bridge = bridge;
> -
>  	/* Get the I/O range from DT */
>  	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
>  	if (win) {
> 
> -- 
> 2.34.1
> 

