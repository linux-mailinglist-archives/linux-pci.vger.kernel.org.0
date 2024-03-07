Return-Path: <linux-pci+bounces-4617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7F7875805
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 21:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79144287562
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9571384A2;
	Thu,  7 Mar 2024 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1dNhY9a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A71DA2F;
	Thu,  7 Mar 2024 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842462; cv=none; b=etwwWcn3tq5iQzsI5Gt+bDgilRulqbJspRMCFN2jf4xC0Z5GN/H5DlF/ZxnzHS7LTw85dpS/hwaHqDmBrix5SZRZPzykjTgN3PQfI8D4IAhRyrOaO9osa9PjIPVGGNiLi+VypdD3wmVd9il2bQ20O+7vHfpyxFDDzs/ct/wQ0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842462; c=relaxed/simple;
	bh=9g/TyhNGfCR/iMnSye5VRUmHHWo7BgK2gWR+z27+UT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xyc9qKDmF+eApIFmnEh+OGhzjVdhz/jASYINKKggD1Q/eMaUcv0CO5ZArVc7DNsI91CEoK01mAfMI+VmySrPMNn5bDq9yB7wb6IlUolpuiknZwT9H6Ocor3B8syitUEz1QLTxfD5CRUu08nfCo144cg7Bu2y2ey0qlCl/0xWiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1dNhY9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127C2C43601;
	Thu,  7 Mar 2024 20:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709842461;
	bh=9g/TyhNGfCR/iMnSye5VRUmHHWo7BgK2gWR+z27+UT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1dNhY9aEBZdeLadUrmkw3KVNJC43yd+/r60Z1+72kT3Quyl+APc7qLQipcl8d8EM
	 JvQPq0542qirZbinHyPb1MB51ltlkKY9VSf1NpLvr2mH+5BZLENnTNqxwv3SWVqo74
	 5eL6TmB+xGwpyg3kuuG4BfPcOfVVKVsHBtUzhZuhlLGjMBgZyzHkLgTY4rHVzBmyBz
	 nlbnWNSc2y8wOIANU03Q79If0DyOSBRaFxckaPRk9ZfYfpl5xuryktU/yt2N1KsC1S
	 o6sZSJtjofvkdBb6rua6VV0NhR+zf7kNk+vsTcB0EHDcvyfS8YpAxOrX3g6kqdjeON
	 qzNwC7PLd2sNA==
Date: Thu, 7 Mar 2024 21:14:11 +0100
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
Subject: Re: [PATCH v9 03/10] PCI: dwc: ep: Introduce dw_pcie_ep_cleanup()
 API for drivers supporting PERST#
Message-ID: <ZeogExV6wbNdpdEA@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-3-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-3-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:15PM +0530, Manivannan Sadhasivam wrote:
> For DWC glue drivers supporting PERST# (currently Qcom and Tegra194), some
> of the DWC resources like eDMA should be cleaned up during the PERST#
> assert time.
> 
> So let's introduce a dw_pcie_ep_cleanup() API that could be called by these
> drivers to cleanup the DWC specific resources. Currently, it just removes
> eDMA.
> 
> Reported-by: Niklas Cassel <cassel@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/ZWYmX8Y%2F7Q9WMxES@x1-carbon
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 11 +++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h    |  5 +++++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c       |  1 +
>  drivers/pci/controller/dwc/pcie-tegra194.c      |  2 ++
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2b11290aab4c..1205bfba8310 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -564,12 +564,19 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> -void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
> +void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	struct pci_epc *epc = ep->epc;
>  
>  	dw_pcie_edma_remove(pci);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);

Since you are not clearing the iATU bits in ep->ib_window_map and
ep->bar_to_atu, this will "leak" resources, so depending on how many
inbound iATUs the platform has, by simply the RC toggling PERST,
will cause an error when calling set_bar() after dw_pcie_ep_init_notify().

However, because you have said that you will address this in a follow up
series:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

