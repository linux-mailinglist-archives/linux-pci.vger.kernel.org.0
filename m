Return-Path: <linux-pci+bounces-4243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375E86C7FC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 12:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46C12852AB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFBB7B3D7;
	Thu, 29 Feb 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEE4knre"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7087651BC;
	Thu, 29 Feb 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205807; cv=none; b=VsGWQe5nVle6g8jMqyxlzVawpZO5b0WSWK55tGt+QpfySLU0IoVsML7OydOnpBRdMy2gi/+KG0qjRYdHioAx5ARo3FnVRxdv1pPU6+jfjeWR2suTYKwABqp71rAOi4QFwZn810ZjRMjdxJQDDl8L/WR+9KPzXBUr5VAKX9lClK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205807; c=relaxed/simple;
	bh=WqUPAXlssCmtqdLpcCv+8iCzvErdAxK/S/ZBo23Kh1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtqJFMaiB086lHnEy0m2ineCuzQAG7uTSwS1lb+yVCO1shjOF+5nhUrbzGBPqRe63I+8abov72tc9XtV3w9ktNRJPtDfOwpfKl/5lGnBGpcws0pKu6XBxG9Ac7wSIt2v2RfjqQOH/wrEgmhnGiCXS39YfT34zDi1b4k3k55nw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEE4knre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8DEC43390;
	Thu, 29 Feb 2024 11:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709205807;
	bh=WqUPAXlssCmtqdLpcCv+8iCzvErdAxK/S/ZBo23Kh1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEE4knre18WNc+Z4ry/juSz4W7aDGP/Ez0hsT9XjtMow88AXfe7DMzTDAEdv4e9ax
	 m/VW/hBb8BKj8zGUvRBLGk4ycN0JQcBurj6JMEkdIoWbtZvxyDrGy0WCIEXqfpOgOC
	 mpH8LrNg4+WGaFQcu+AvriL8JoEiud/KdVdY2oruqydWUJyoZn9zzThq7jwdhNlLbM
	 hixtNQfLpwIhQu6r1cpguRalL6F/i1qeuTclO+Wz2ItlZeq9pVR9cXvCQ1PxrVmuzB
	 TCMC200o6tcmHtL8/ts6p8bYyjsdSegQ6Rvb4RGIPIkFR3g4IUX4/55AQa2eSVdadO
	 TtawRjDGmx5NQ==
Date: Thu, 29 Feb 2024 12:23:16 +0100
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
Subject: Re: [PATCH v8 07/10] PCI: dwc: ep: Remove "core_init_notifier" flag
Message-ID: <ZeBpJL1K_vAdmr2M@fedora>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-7-64c7fd0cfe64@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224-pci-dbi-rework-v8-7-64c7fd0cfe64@linaro.org>

Hello Mani,

On Sat, Feb 24, 2024 at 12:24:13PM +0530, Manivannan Sadhasivam wrote:
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
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  2 ++
>  drivers/pci/controller/dwc/pci-imx6.c             |  2 ++
>  drivers/pci/controller/dwc/pci-keystone.c         |  2 ++
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 ++
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  2 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  1 -
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  2 ++
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  1 -
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 ++
>  drivers/pci/endpoint/functions/pci-epf-test.c     | 18 +++++-------------
>  include/linux/pci-epc.h                           |  3 ---

pcie-artpec6.c:static const struct dw_pcie_ep_ops pcie_ep_ops = {
pcie-keembay.c:static const struct dw_pcie_ep_ops keembay_pcie_ep_ops = {

Where is the love for these drivers? ;)


Kind regards,
Niklas

