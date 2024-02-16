Return-Path: <linux-pci+bounces-3587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD963857B9D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 12:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72FE1C23CD2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3954768FE;
	Fri, 16 Feb 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpK+aqx5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22B7690B
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082896; cv=none; b=ccGehVPuHBpBbIXzC/+b6fkNE00mQuXUbqSHqwL1Vs/ZF51wEjwk6uXCF9fSHBXVFhs92SxpIhlVgDJjQ4Q5hHTIhfIbFxeytBPPrEbyskLICiz8RefCHzd2igBhG4UfkyevQDdS09cF56JhvFXwkzvwZUJH5sgjrHWSGiHkZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082896; c=relaxed/simple;
	bh=oXET3aKSI1V4rlsqHKZfh916aAs/mGOzF5YRdjv62+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRLk/+2KK2mk5f1/6gWQehW3k686KMij3/NcLuipdBn03DyXqowemi55filjSFT698QVCxZinFqOVq05ALBvXqTmA8sKwIzJvLAKk59b2He4yLdYxPiACOGfwAi8hh6xcm/5ah91Y4TGm0mj/KCVntZZuLAQvpGS0E6A2zdh9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpK+aqx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D131C433C7;
	Fri, 16 Feb 2024 11:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708082896;
	bh=oXET3aKSI1V4rlsqHKZfh916aAs/mGOzF5YRdjv62+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpK+aqx53/vAA8CZ5UmPfM0Z+durlbBVOGFr1ph5cCcFydNq5QTkrY1zVt4Mq4Chn
	 QYNbgkgxKdbRl/cosW8XwGi+6hvw6x61mW5HlZw00lJfVkRXaW+trYK49N0EPcHhN/
	 4L9d9envi+nH5SAEm4w8+58AvS+eZ0vV9pvs1ODbhtOo0nD/06aoy98rsJNpXjvwlc
	 VPlbBtgM7rxtXqykyi7msKiZWp0i96iACbHlnjEXtYYeqk5lv0Uu7WFJiWU/5yTXam
	 td6MqK8IKkAJoKxPS1sdQ2xkBIL19gdvbc8k6F/6c6p/8TKoHH7hfjSvPD2IffzC/j
	 D91yzyUJ/Wfeg==
Date: Fri, 16 Feb 2024 16:58:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: endpoint: Drop only_64bit on reserved BARs
Message-ID: <20240216112808.GE2559@thinkpad>
References: <20240210012634.600301-1-cassel@kernel.org>
 <20240210012634.600301-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240210012634.600301-3-cassel@kernel.org>

On Sat, Feb 10, 2024 at 02:26:26AM +0100, Niklas Cassel wrote:
> The definition of a reserved BAR is that EPF drivers should not touch
> them.
> 
> The definition of only_64bit is that the EPF driver must configure this
> BAR as 64-bit. (An EPF driver is not allowed to choose if this BAR should
> be configured as 32-bit or 64-bit.)
> 
> Thus, it does not make sense to put only_64bit of a BAR that EPF drivers
> are not allow to touch.
> 
> Drop the only_64bit property from hardware descriptions that are of type
> reserved BAR.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

One nitpick below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/dwc/pci-keystone.c     | 2 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 2 +-
>  drivers/pci/endpoint/pci-epc-core.c           | 7 -------
>  include/linux/pci-epc.h                       | 4 ++++
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index b2b93b4fa82d..844de4418724 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -924,7 +924,7 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
>  	.linkup_notifier = false,
>  	.msi_capable = true,
>  	.msix_capable = true,
> -	.bar[BAR_0] = { .type = BAR_RESERVED, .only_64bit = true, },
> +	.bar[BAR_0] = { .type = BAR_RESERVED, },
>  	.bar[BAR_1] = { .type = BAR_RESERVED, },
>  	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
>  	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index 265f65fc673f..639bc2e12476 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -415,7 +415,7 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
>  		.bar[BAR_1] = { .type = BAR_RESERVED, },
>  		.bar[BAR_2] = { .only_64bit = true, },
>  		.bar[BAR_3] = { .type = BAR_RESERVED, },
> -		.bar[BAR_4] = { .type = BAR_RESERVED, .only_64bit = true, },
> +		.bar[BAR_4] = { .type = BAR_RESERVED, },
>  		.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	},
>  };
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 7fe8f4336765..da3fc0795b0b 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -120,13 +120,6 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>  		/* If the BAR is not reserved, return it. */
>  		if (epc_features->bar[i].type != BAR_RESERVED)
>  			return i;
> -
> -		/*
> -		 * If the BAR is reserved, and marked as 64-bit only, then the
> -		 * succeeding BAR is also reserved.
> -		 */
> -		if (epc_features->bar[i].only_64bit)
> -			i++;
>  	}
>  
>  	return NO_BAR;
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 4ccb4f4f3883..bb9c4dfcea93 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -164,6 +164,10 @@ enum pci_epc_bar_type {
>   *		should be configured as 32-bit or 64-bit, the EPF driver must
>   *		configure this BAR as 64-bit. Additionally, the BAR succeeding
>   *		this BAR must be set to type BAR_RESERVED.
> + *
> + *		only_64bit should not be set on a BAR of type BAR_RESERVED.
> + *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
> + *		touch, then you must set both BARx and BARx+1 as BAR_RESERVED.)

"then both BARx and BARx+1 must be set to type BAR_RESERVED."

- Mani

-- 
மணிவண்ணன் சதாசிவம்

