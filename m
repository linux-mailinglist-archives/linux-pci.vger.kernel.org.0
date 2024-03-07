Return-Path: <linux-pci+bounces-4620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C287588A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 21:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F461F24BE9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 20:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B464CDC;
	Thu,  7 Mar 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH712JAe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64281E865;
	Thu,  7 Mar 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843828; cv=none; b=eyoKX1RcufEMiP/EljlETKGKeTbdVLuPWoyjgX9r48oXduE+3x5K/BvXg/ZcEMeNRS901Ma/PH/ZQErWZckc9n8fcLeH+1HhFaEuhCglVbzTK9ckhmlF/S/Fjk2AijpVemfzaOLoNlIrqt4FJVV6jwEMfpDmmsaPvias7GMUZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843828; c=relaxed/simple;
	bh=eGOAWjsud1Ck55pN1j35rMAJfavIagxkoPDo64qggSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcEBRoMSBiWf0gKScrvYEzBWXy1g9JU9TdzzWHPaGDqIVEWX00FAq+jvYfZ90AXd5LyWGCsKb2bpF8lL4D3Y8U4MjDla4HoI5yY/xj2MNTIAExH+iQwcoW03gro7Bz4pp8Ucmjn+gKmFex1EC26QTZXjB+2owg8U1VJ0YFIhY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH712JAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FCEC43399;
	Thu,  7 Mar 2024 20:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709843827;
	bh=eGOAWjsud1Ck55pN1j35rMAJfavIagxkoPDo64qggSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZH712JAesiA+VYRacjgjemvYuwNC+u2uBeBcbpeuc4RDzFUcSpwBReDql9vSCIg6d
	 F93jh07hklNqj8HKW/f5tnNUFOiEOiJ/tjtfy9Tc/Jrw1hNHT6lF/+Qz8pkj9yoQ8y
	 +VtpiY/Yqxlrgz22AK+AXoXf8eI8bexciwarO3P1BFhzEOdWvA7fQ6eek7GRC9soYk
	 oL8S1zToSuXAd//ke4hVGX1dVjhSu+c6TgIhTuFy1FI9xpJGJ+iKB6Ljmnc+QfevSC
	 pRKNjOCUkQmB51EtN7aQQYHMVP7F4yYBqYg+jVI86Rb2bJrAmukaFXBeAhGileYxkF
	 Jx7SWbo+p/8Ow==
Date: Thu, 7 Mar 2024 21:36:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v9 06/10] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Message-ID: <ZeolaEIRYmKZjnvT@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-6-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-6-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:18PM +0530, Manivannan Sadhasivam wrote:
> Currently, dw_pcie_ep_init_registers() API is directly called by the glue
> drivers requiring active refclk from host. But for the other drivers, it is
> getting called implicitly by dw_pcie_ep_init(). This is due to the fact
> that this API initializes DWC EP specific registers and that requires an
> active refclk (either from host or generated locally by endpoint itsef).
> 
> But, this causes a discrepancy among the glue drivers. So to avoid this
> confusion, let's call this API directly from all glue drivers irrespective
> of refclk dependency. Only difference here is that the drivers requiring
> refclk from host will call this API only after the refclk is received and
> other drivers without refclk dependency will call this API right after
> dw_pcie_ep_init().
> 
> With this change, the check for 'core_init_notifier' flag can now be
> dropped from dw_pcie_ep_init() API. This will also allow us to remove the
> 'core_init_notifier' flag completely in the later commits.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  7 +++++++
>  drivers/pci/controller/dwc/pci-imx6.c             |  8 ++++++++
>  drivers/pci/controller/dwc/pci-keystone.c         |  9 +++++++++
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  7 +++++++
>  drivers/pci/controller/dwc/pcie-artpec6.c         | 13 ++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 22 ----------------------
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 +++++++++
>  drivers/pci/controller/dwc/pcie-keembay.c         | 16 +++++++++++++++-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 12 +++++++++++-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 13 ++++++++++++-
>  10 files changed, 90 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 0e406677060d..395042b29ffc 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -467,6 +467,13 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
>  		return ret;
>  	}
>  
> +	ret = dw_pcie_ep_init_registers(ep);
> +	if (ret) {

Here you are using if (ret) to error check the return from
dw_pcie_ep_init_registers().


> index c0c62533a3f1..8392894ed286 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1286,6 +1286,13 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  		ret = dw_pcie_ep_init(&pci->ep);
>  		if (ret < 0)
>  			goto err_get_sync;
> +
> +		ret = dw_pcie_ep_init_registers(&pci->ep);
> +		if (ret < 0) {

Here you are using if (ret < 0) to error check the return from
dw_pcie_ep_init_registers(). Please be consistent.


> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 9ed0a9ba7619..0edd9ab3f139 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -441,7 +441,18 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>  
>  		pci->ep.ops = &pcie_ep_ops;
>  
> -		return dw_pcie_ep_init(&pci->ep);
> +		ret = dw_pcie_ep_init(&pci->ep);
> +		if (ret < 0)

Here you are using if (ret < 0) to error check the return from
dw_pcie_ep_init().


> index 778588b4be70..ca9b22e654cd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -145,6 +145,15 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>  
>  		pci->ep.ops = &pcie_ep_ops;
>  		ret = dw_pcie_ep_init(&pci->ep);
> +		if (ret)

Here you are using if (ret) to error check the return from
dw_pcie_ep_init(). Please be consistent.

