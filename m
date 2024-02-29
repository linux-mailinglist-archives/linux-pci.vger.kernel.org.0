Return-Path: <linux-pci+bounces-4255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BAD86C98C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58B11C21327
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E987E0E5;
	Thu, 29 Feb 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+K5ELdx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149D62808;
	Thu, 29 Feb 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211394; cv=none; b=aPys5y0JIwsr6uyN2EJtcXjDnIYAy4PDBw1Vst1q16WTzlUrhiaABHux6EIIHnPP8//dpK8EQ/KxIomjLjYfgiEQau+5+yEtac5LF2L39z1LA00oQjntVjrACgQY8Dxte0xDLQJBUMWdgVG31ZAw1ThY0vq+62TDHduyVeR0Pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211394; c=relaxed/simple;
	bh=FH+JdudMBgehU68hfBDKn6/fbrAreS/wl1YC0HPz/Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHG9k/8XBiemfEHwn7EUgFgZxLw9pc1+9bX8jKDCObuWlu0vpEPAAA3ZjMqBMkSigOZM8VKT222kizpjh/88V23wZtUHPLs1KwfhojR/HHnj19Xup87EdmcUHFaGycz6VF/SgnFpV9yeUKnkamQIuDgoON2p7Cq3wz8UZrqAxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+K5ELdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4621EC433F1;
	Thu, 29 Feb 2024 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709211393;
	bh=FH+JdudMBgehU68hfBDKn6/fbrAreS/wl1YC0HPz/Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+K5ELdxqti6l+X3XyprWkioDJDWESK1Q8aUt7ODmuCvs+B1SkleCGS2eEqKuvXhc
	 QexaZ6oN8rwRdtzMCWk5hwhKaAp7YhoymoN8DvRIanJgaj90GMn1Ca3MbwYy2CygBW
	 odHLaxPs6AoXzDLZTk8XNgsv5e9HzgUV6/jt7F0kU0NSKDa7TcHHUS2XzwcsPssFbY
	 yyTfzN2vjbzjAV/RY4utg2ANfWB2XcDg7jBIBgwr3ZVoXrfOvihwUylOGhb0xI4tIh
	 joL7P9t4siWvMU3aFWlo9KSxQEMDCpcIs+vCy7QH9HFbq0VPuv2Gx4sqzIN8C8ym1q
	 +gtgrcmRWnWFw==
Date: Thu, 29 Feb 2024 13:56:23 +0100
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
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 10/10] PCI: dwc: ep: Add Kernel-doc comments for APIs
Message-ID: <ZeB-93jiX31cLJyP@fedora>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-10-64c7fd0cfe64@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224-pci-dbi-rework-v8-10-64c7fd0cfe64@linaro.org>

Hello Mani,

On Sat, Feb 24, 2024 at 12:24:16PM +0530, Manivannan Sadhasivam wrote:
> All of the APIs are missing the Kernel-doc comments. Hence, add them.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 92 +++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index fed4c2936c78..cdcb33a279db 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c

(snip)

> @@ -556,6 +606,12 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +/**
> + * dw_pcie_ep_cleanup - Cleanup DWC EP resources
> + * @ep: DWC EP device
> + *
> + * Cleans up the DWC EP specific resources like eDMA etc...

I think that you should mention that this is only for glue drivers that
use PERST# handling, so that other glue drivers do no start using it :)


> + */
>  void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -564,6 +620,13 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);


Kind regards,
Niklas

