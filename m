Return-Path: <linux-pci+bounces-4618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12976875865
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 21:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C287128119B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CB64A93;
	Thu,  7 Mar 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq1Ij5cb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DF633EB;
	Thu,  7 Mar 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843483; cv=none; b=mDsZG34JUvftC//7TTbyewgqeR4Kbc9Fuv2ps+9qXORPqixqRTg9+8udhBROwFHf7EwauW3Iqlkq+vjG4g9HizN4hEa0tvXAWh8Qa5zvMCjSnDxf+IppdEICYxX5+ZEE138ZmshplK2zlA3EoX4Ulb1WRPt4YKlG9tRmTbYBBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843483; c=relaxed/simple;
	bh=SpBFTgDYCZL5HMSP744NvFE2koQBVmNM5L2jWkZki7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiFAQp6FQ4Y/ujplG3Glb7YwiXmjzef5Dm62T8uhQF8Q6q4xrw2A0Cq+wcmvHkt6Wq1Co0qKYs/x6Jl/ohQPXJlIWfjBhnabCjk9YRGWJENSO6wEIb7s0p37qKocNBK8QT1MZwlh43p27DSS6uazkLxDSBQ0K9K+KunooeL65Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq1Ij5cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF1DC433F1;
	Thu,  7 Mar 2024 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709843483;
	bh=SpBFTgDYCZL5HMSP744NvFE2koQBVmNM5L2jWkZki7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dq1Ij5cbXC/azz2ARqvH18GU6nblsiWGJekKh8qOtyucIW4GqCRnXVbQlQjtTDrOw
	 /QkuiKcsiHgteS5KrBFnY8QBf7g5BlAInJ5lA75KzFf02hYqh+iJTlYBkAhbD8wmcN
	 MlcgMIrkMt5PPDeFFLmBWkrNhXZOwrWOTp3JIHIa1DcLWTyDHzHrbHVGosjmEtufOK
	 o0H+MQGjAzJWkFcK+6eKhq8Yamb1XolFCnSNIjPhVH+lM9CvmbuF3VOGSHWZyqJXCW
	 Oxl2l5XBcGLAfAFnlpjupMrL2nAN7mCz8/RL4c9k3rUaviU69PmCBCh0FHzrbA6NLs
	 tlWLEc5gqsSpA==
Date: Thu, 7 Mar 2024 21:31:12 +0100
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
	linux-arm-kernel@axis.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v9 04/10] PCI: dwc: ep: Fix DBI access failure for
 drivers requiring refclk from host
Message-ID: <ZeokEJstpRSUPDTL@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-4-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-4-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:16PM +0530, Manivannan Sadhasivam wrote:
> The DWC glue drivers requiring an active reference clock from the PCIe host
> for initializing their PCIe EP core, set a flag called 'core_init_notifier'
> to let DWC driver know that these drivers need a special attention during
> initialization. In these drivers, access to the hw registers (like DBI)
> before receiving the active refclk from host will result in access failure
> and also could cause a whole system hang.
> 
> But the current DWC EP driver doesn't honor the requirements of the drivers
> setting 'core_init_notifier' flag and tries to access the DBI registers
> during dw_pcie_ep_init(). This causes the system hang for glue drivers such
> as Tegra194 and Qcom EP as they depend on refclk from host and have set the
> above mentioned flag.
> 
> To workaround this issue, users of the affected platforms have to maintain
> the dependency with the PCIe host by booting the PCIe EP after host boot.
> But this won't provide a good user experience, since PCIe EP is _one_ of
> the features of those platforms and it doesn't make sense to delay the
> whole platform booting due to PCIe requiring active refclk.
> 
> So to fix this issue, let's move all the DBI access from
> dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete()
> API. This API will only be called by the drivers setting
> 'core_init_notifier' flag once refclk is received from host. For the rest
> of the drivers that gets the refclk locally, this API will be called
> within dw_pcie_ep_init().
> 
> Fixes: e966f7390da9 ("PCI: dwc: Refactor core initialization code for EP mode")
> Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

I'm not sure if the Fixes tag is stictly correct, since there is
nothing wrong with the commit that the Fixes-tag is referencing.

What this patch addresses is an additional use-case/feature,
which allows you to start the EP-side before the RC-side.

However, I'm guessing that you kept the Fixes-tag such that this
patch will get backported. However, this patch is number 4/10 in
the patch series. If this is a strict fix that you want backported,
and it does not depend on any of the previous patches (it doesn't
seem that way), then I think that you should have put it as patch
1/10 in the series.

Patch ordering aside:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

