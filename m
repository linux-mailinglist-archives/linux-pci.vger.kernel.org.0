Return-Path: <linux-pci+bounces-5228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22AD88D8BE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BEA294ADE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E432DF92;
	Wed, 27 Mar 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9P2tUw6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFF23D7;
	Wed, 27 Mar 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527857; cv=none; b=m+JWvhog5MEVNwYp9IzZ6yaoDtN0FdmGo37iX6l6Nn/QJPhOrL3Eqc6Igjj7b+4uVg9T0ITn2F6WJcIS1bmrWhOFrS3Shi7IuB5E2VRszkqSSVnToNG17jj8RGfNnIRbHLQX3m8NRS87Q476MT91f5dEG7FNNu3aKf/5IBU7bv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527857; c=relaxed/simple;
	bh=3O9nZkHhgz3EfvIBaPtrSnSZtIgGhJoXhwNgfGO7CX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuM8BlSrv0Vi3Mc34CER48MKyLtAyVBCRYjuvLH2/tNq5ynzGELanQ9MJbrlL5olT74GOTe3FuHf86PrLJQNvvzSETqj1hPRNVWoMJPxKKROZcHmkvPOMb7zJmBFiw2ET5sryYibWGmSyDgyhS/8O0Q8shFEZEpM/ZQOMNYqp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9P2tUw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45900C433C7;
	Wed, 27 Mar 2024 08:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711527856;
	bh=3O9nZkHhgz3EfvIBaPtrSnSZtIgGhJoXhwNgfGO7CX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9P2tUw6edMJRhnwzoQrRs+XIKbS+xEweeBhXY3zZJ/RTj1R7mEa72z4U16yo2TFn
	 TTKFt09jLYgi53FcEGhDm66V9WckqMs2OYk5+vXbuIujHZJf73/C+nKdb+iA1xKIY6
	 rHkR+o+nsulOr5cG12CVo9mBfpkH1/g1HQ+1dAdY+m/PXy2bbfYTOUlHganupZ5qLh
	 pLD11oUCAnIfexzwab73/UDv/S5Rhf454RM6Xx784Fz2Pd4QsiNYieUTq33RxtDsm4
	 3Bbha4ZBIbxb7aP1ggVF9M/Fy+raS/QVk+WadLk70POHbqsgb7Flx63WH6p3JgFWs7
	 kPtY29Xau5cEw==
Date: Wed, 27 Mar 2024 09:24:05 +0100
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
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v11 8/8] PCI: endpoint: Remove "core_init_notifier" flag
Message-ID: <ZgPXpZgoMqVn8QHt@ryzen>
References: <20240327-pci-dbi-rework-v11-0-6f5259f90673@linaro.org>
 <20240327-pci-dbi-rework-v11-8-6f5259f90673@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-pci-dbi-rework-v11-8-6f5259f90673@linaro.org>

Hello Mani,

On Wed, Mar 27, 2024 at 12:05:54PM +0530, Manivannan Sadhasivam wrote:
> "core_init_notifier" flag is set by the glue drivers requiring refclk from
> the host to complete the DWC core initialization. Also, those drivers will
> send a notification to the EPF drivers once the initialization is fully
> completed using the pci_epc_init_notify() API. Only then, the EPF drivers
> will start functioning.
> 
> For the rest of the drivers generating refclk locally, EPF drivers will
> start functioning post binding with them. EPF drivers rely on the
> 'core_init_notifier' flag to differentiate between the drivers.
> Unfortunately, this creates two different flows for the EPF drivers.
> 
> So to avoid that, let's get rid of the "core_init_notifier" flag and follow
> a single initialization flow for the EPF drivers. This is done by calling
> the dw_pcie_ep_init_notify() from all glue drivers after the completion of
> dw_pcie_ep_init_registers() API. This will allow all the glue drivers to
> send the notification to the EPF drivers once the initialization is fully
> completed.
> 
> Only difference here is that, the drivers requiring refclk from host will
> send the notification once refclk is received, while others will send it
> during probe time itself.
> 
> But this also requires the EPC core driver to deliver the notification
> after EPF driver bind. Because, the glue driver can send the notification
> before the EPF drivers bind() and in those cases the EPF drivers will miss
> the event. To accommodate this, EPC core is now caching the state of the
> EPC initialization in 'init_complete' flag and pci-ep-cfs driver sends the
> notification to EPF drivers based on that after each EPF driver bind.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c  |  2 ++
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  2 ++
>  drivers/pci/controller/dwc/pci-imx6.c             |  2 ++
>  drivers/pci/controller/dwc/pci-keystone.c         |  2 ++
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 ++
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  2 ++
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  1 +
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  2 ++
>  drivers/pci/controller/dwc/pcie-keembay.c         |  2 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  1 -
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  2 ++
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  1 -
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 ++
>  drivers/pci/controller/pcie-rcar-ep.c             |  2 ++
>  drivers/pci/controller/pcie-rockchip-ep.c         |  2 ++
>  drivers/pci/endpoint/functions/pci-epf-test.c     | 18 +++++-------------
>  drivers/pci/endpoint/pci-ep-cfs.c                 |  9 +++++++++
>  drivers/pci/endpoint/pci-epc-core.c               | 22 ++++++++++++++++++++++
>  include/linux/pci-epc.h                           |  7 ++++---
>  19 files changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 2d0a8d78bffb..da67a06ee790 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -734,6 +734,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  
>  	spin_lock_init(&ep->lock);
>  
> +	dw_pcie_ep_init_notify(&pci->ep);

This looks wrong (and I think that you have not build tested this).

dw_* prefix indicates DWC, so it is a DWC specific function.

I don't think that you can use this function for the 3 non-DWC EPC drivers.
I think that you need to use call pci_epc_init_notify() directly.


(Also perhaps rebase your series on v6.9-rc1, I got conflicts when trying
to apply it to v6.9-rc1, because it looks like the series is still based
on v6.8-rc1.)


Kind regards,
Niklas

