Return-Path: <linux-pci+bounces-15802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287BE9B945C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 16:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFA11F21ADC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530A1C68A6;
	Fri,  1 Nov 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l17+oQiR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718A1A3031;
	Fri,  1 Nov 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474801; cv=none; b=IZxfCuUHAYkR3zagp/CS0xxZv342fySe8aVp7cMoM55v6BdIKJfVeiTz00ArjD7z8TZWSbq2tv7QXl7w+pWMjRKc9Cg7pg59oLqwS+nTTIHnHL+HfTVB45+hK0Ib6XqlNchyoQJNBjnS3jJfx6/WX4dFkw3jaEPaweLKN92zVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474801; c=relaxed/simple;
	bh=vI/NQjc09w3VuPnsKmwpWg7tRMQmr0hd6fA4o85RJow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3syZRa+oZQxKnh1BWGU+TM/sOqk+s158cDrNonOqT8RTaTjP1OrBjiJNJhL9hWCod/FiZr0emBbMsZRBDICdvceL1Amjx2qp9lRSUm2fuZ8JMHn/HW0+GmDOuzA7WiyBo/JOqgDujnUuPa3yc4ulahCGJD8qzyqe+BJJTWimlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l17+oQiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9997AC4CECD;
	Fri,  1 Nov 2024 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474801;
	bh=vI/NQjc09w3VuPnsKmwpWg7tRMQmr0hd6fA4o85RJow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l17+oQiRKK/3oQp/BNFD92/hhW0liTn0T4m/LgT3ZXrAvEFH1q+HhjWU8KvzZqMjB
	 X3A/XR0gqiVN8nyxDO8hvEV4W97WPyPepjKr4b/1Z541TBKc0QIygoYa+jFKp6CI8I
	 6UPt6Iz2Sa0LTiuQ/DM2uCh6SQMQw2e/KXwH1/NvZB+ZC0ZoKyU/vxRsz6EbdHRbS2
	 X8DTxMdS1Fi51Ao+MYqkQdty4QP/+j1jLX/G1RY5q+XiBbcfa81prhYdQxEIY6gbCt
	 TRahNAjSOoOhC+gh+P8ULxS2iIR3zFxedEVwOVOebmJ8yGuO10cyU1n3VVHLHrfw/r
	 2csGzlh+TMC2A==
Date: Fri, 1 Nov 2024 10:26:38 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 1/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Message-ID: <ywuqtydbapfumelfu66237h65q2xb3rmvjtstiwvd24whn7rju@bcxldl2l4bv2>
References: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
 <20241101-remove_wait-v3-1-7accf27f7202@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-remove_wait-v3-1-7accf27f7202@quicinc.com>

On Fri, Nov 01, 2024 at 05:04:12PM GMT, Krishna chaitanya chundru wrote:
> If the vendor drivers can detect the Link up event using mechanisms
> such as Link up IRQ and can the driver can enumerate downstream devices
> instead of waiting here, then waiting for Link up during probe is not
> needed here, which optimizes the boot time.
> 
> So skip waiting for link to be up if the driver supports 'linkup_irq'.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..26418873ce14 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -530,8 +530,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_remove_edma;
>  	}
>  
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +	/*
> +	 * Note: The link up delay is skipped only when a link up IRQ is present.
> +	 * This flag should not be used to bypass the link up delay for arbitrary
> +	 * reasons.

Perhaps by improving the naming of the variable, you don't need 3 lines
of comment describing the conditional.

> +	 */
> +	if (!pp->linkup_irq)
> +		/* Ignore errors, the link may come up later */

Does this mean that we will be able to start handling these errors?

> +		dw_pcie_wait_for_link(pci);
>  
>  	bridge->sysdata = pp;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..539c6d106bb0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -379,6 +379,7 @@ struct dw_pcie_rp {
>  	bool			use_atu_msg;
>  	int			msg_atu_index;
>  	struct resource		*msg_res;
> +	bool			linkup_irq;

Please name this for what it is, rather than some property from which
some other decision should be derived. (And then you need a comment to
describe how people should interpret and use it)

Also, "linkup_irq" sound like an int carrying the interrupt number, not
a boolean.


Please call it "use_async_linkup", "use_linkup_irq" or something.

Regards,
Bjorn

>  };
>  
>  struct dw_pcie_ep_ops {
> 
> -- 
> 2.34.1
> 
> 

