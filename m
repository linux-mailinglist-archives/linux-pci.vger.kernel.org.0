Return-Path: <linux-pci+bounces-8437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D3F8FFF38
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E82881DA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1455815B97D;
	Fri,  7 Jun 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0K3tGbO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A6152511;
	Fri,  7 Jun 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752139; cv=none; b=H6JlL+dSLEMxqUhTFMCFDvFqOtvxsVAFhR3KSjfzaF/icxVLhI2bn1SAK9p1M141lZmh4KBSUVfDxXAn41cSU/xVViTNIDB97K8cNWbRRq6/KKRAo9MuCLCOvuD/gPeXUYjQFDLqoUzUnwUaJVUW0jtRxSkAERFoPwK7n2+nyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752139; c=relaxed/simple;
	bh=i87Nc6pwMyOziR5UsyM3i5Jx7xdBUnjr6/ThfnlGrVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpF1HqftmrTErJCq4lfmnRKitTUQ63bAZCth6Mmki6UcWzxUcXjg6y9jEuDDyyA5Ty1976A+mO/SER3tidZg9gOpP4PlBhg9e07nCxtT0wwlLISWvtj90hmuorYcixD1l/a4+euEZ0v6UXZvHjwgxfEaX1YAofoxSRhRXesIS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0K3tGbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBACC32786;
	Fri,  7 Jun 2024 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717752138;
	bh=i87Nc6pwMyOziR5UsyM3i5Jx7xdBUnjr6/ThfnlGrVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0K3tGbOG/KlWvHC/ZEtFlYqv3Nb5yevw2PW0nItTW6wfEYD+fL0Uytt5tzqebPJm
	 6a0fESmeZBYbIFmpZtH0PobfZq9VKeCGEI1vUSzLFHWev8XyEzJwd1+9HhGHRem9JC
	 Zc7G23Pk+TCQFw0COQem39+1Mpevm3+HXgWZuDk3l4OoBnUqY4fQ18oa6reGth02CP
	 VDznnmzmbTu9Dt9xxylw9oYAvmQnQY9qCnNzoVVWRPJyQuB7qMEltbnCgOLvfYMJ07
	 Q0bvzFTTCh3Kork9WnKl9VJWG1EKWOuBEqJXCd1922kkSLk5EpMbndeisk7U5rB5UW
	 a76JBfNY9vaDw==
Date: Fri, 7 Jun 2024 11:22:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH 4/5] PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Message-ID: <ZmLRP2pYds3LkmdQ@ryzen.lan>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
 <20240606-pci-deinit-v1-4-4395534520dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-pci-deinit-v1-4-4395534520dc@linaro.org>

On Thu, Jun 06, 2024 at 12:56:37PM +0530, Manivannan Sadhasivam wrote:
> Now that the API is available, let's make use of it. It also handles the
> reinitialization of DWC non-sticky registers in addition to sending the
> notification to EPF drivers.
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 2324e56c9bfc..02a2a871a91f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -641,7 +641,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
>  		dev_dbg(dev, "Received Linkdown event\n");
>  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
> -		pci_epc_linkdown(pci->ep.epc);
> +		dw_pcie_ep_linkdown(&pci->ep);
>  	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>  		dev_dbg(dev, "Received Bus Master Enable event\n");
>  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
> 
> -- 
> 2.25.1
> 

Like Siddharth reported, this patch is already in pci/next.

