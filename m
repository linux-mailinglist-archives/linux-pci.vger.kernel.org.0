Return-Path: <linux-pci+bounces-13833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E6990A24
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE368284354
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43701BC2F;
	Fri,  4 Oct 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp+ssbRM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1741E377E;
	Fri,  4 Oct 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063106; cv=none; b=uxISh8+CIvx1TkUq7ZhjjyY19JTwh9z5htaO7Z0wWLR56XmUKli0SLm+KCahtPxRXDjBx3GTJ37X/P/yjii8bsmJFOw0juEvflfmQxaqD3pF4aKZJ7CQLQvyMMN18MqUIfJcnoc4dz16UlzjutfSPdzxexGcIwyamAd1LRxbibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063106; c=relaxed/simple;
	bh=Uh9WqQBox/3PVQag7IgByDSw8XZvHs/uKrGtAQ1UpPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJLS7n5QG/yy2Ntm9cVHEk8mwy/3yJrbku0lKGRQE8v3iXiYQEjDMPjwFyzahlj1fMX2pI4Pii1BgWGBV/b3XzbrJawf/H4AgRiCIMVU18L45YEpvpCGiKKJP1M6/ge7xxyd4IzrDX/S2/RPcjQCwLzP5XbXk04kRRXOhj1cqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp+ssbRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2AFC4CEC6;
	Fri,  4 Oct 2024 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728063106;
	bh=Uh9WqQBox/3PVQag7IgByDSw8XZvHs/uKrGtAQ1UpPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dp+ssbRM4Puo3snZWtJkAYcsR8WTrxlkC8jQSzAMl8iJF7/lBs3NnQeigZYm530Je
	 LCSy5L3a1L2+VHdQT6Nk20T8PhSJ+czKfY7xwFod8RLEyAFNDFbN7+yZgw6ZulhrmN
	 Ff2vQrm2srUL/NB03sYPUinRY+DBuYLM4RwlUDAYMELPdnYr/E51rWEEXC16rZwidH
	 0V/sQehcDeswAuQeSFXbZU/Gj+cQg3AxNZ2V2U0os2lkUrPx6i7Jx0k9PtuLtcOWZP
	 gcMTrjA6NqlusYIfrGeAiYTnupO6GG3Y9yF2fRP6/vwgseOMvLEJwLpaoNmLqNJ99W
	 4xnsn0za+NCUw==
Date: Fri, 4 Oct 2024 12:31:43 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH] PCI/pwrctl: pwrseq: abandon probe on pre-pwrseq
 device-trees
Message-ID: <rog6wbda7rdk6rebjyprnofgz4twzpg6kt4pnmeap4m4hga532@3ffxora5yutf>
References: <20241004125227.46514-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004125227.46514-1-brgl@bgdev.pl>

On Fri, Oct 04, 2024 at 02:52:27PM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Old device trees for some platforms already define wifi nodes for the WCN
> family of chips since before power sequencing was added upstream.
> 
> These nodes don't consume the regulator outputs from the PMU and if we
> allow this driver to bind to one of such "incomplete" nodes, we'll see
> a kernel log error about the indefinite probe deferral.
> 
> Let's check the existence of the regulator supply that exists on all WCN
> models before moving forward.
> 
> Fixes: 6140d185a43d ("PCI/pwrctl: Add a PCI power control driver for power sequenced devices")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/Zv565olMDDGHyYVt@hovoldconsulting.com/

Opens-up: A whole bunch of new issues

> Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> index a23a4312574b..8ed613655d4a 100644
> --- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> @@ -9,6 +9,7 @@
>  #include <linux/of.h>
>  #include <linux/pci-pwrctl.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/pwrseq/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -31,6 +32,25 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  
> +	/*
> +	 * Old device trees for some platforms already define wifi nodes for
> +	 * the WCN family of chips since before power sequencing was added
> +	 * upstream.
> +	 *
> +	 * These nodes don't consume the regulator outputs from the PMU and
> +	 * if we allow this driver to bind to one of such "incomplete" nodes,
> +	 * we'll see a kernel log error about the indefinite probe deferral.
> +	 *
> +	 * Let's check the existence of the regulator supply that exists on all
> +	 * WCN models before moving forward.
> +	 *
> +	 * NOTE: If this driver is ever used to support a device other than
> +	 * a WCN chip, the following lines should become conditional and depend
> +	 * on the compatible string.

What do you mean "is ever used ... other than WCN chip"?

This driver and the power sequence framework was presented as a
completely generic solution to solve all kinds of PCI power sequence
problems - upon which the WCN case was built.

In fact, if I read this correctly, the second user of the power sequence
implementation (the QPS615, proposed in [1]), would break if this check
is added.

Add to this that your colleagues are pushing people to implement simple
power supplies for M.2-connected devices into this framework - which I
can only assume would trip on this as well (the one supply pin in a M.2.
connector isn't named "vddaon").

[1] https://lore.kernel.org/all/20240803-qps615-v2-3-9560b7c71369@quicinc.com/

Regards,
Bjorn

> +	 */
> +	if (!device_property_present(dev, "vddaon-supply"))
> +		return -ENODEV;
> +
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> -- 
> 2.43.0
> 

