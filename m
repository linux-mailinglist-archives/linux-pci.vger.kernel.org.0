Return-Path: <linux-pci+bounces-4666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A63876534
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 14:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5DAB239F7
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678D3FBAF;
	Fri,  8 Mar 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCQZriwB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5B3BBF9;
	Fri,  8 Mar 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904288; cv=none; b=X/Lu017eGdC9XYBpKsGMI9YzpMvhjmawd0erC4SMDuiqhr6G5jXK/fPd7X+0qRKipDEgGMA55qhYeYQejlQYtwN5PO7v0nURQ0ivaOT3sUp85KGRRZ8MY/BS126wtzGnDSk0t5f4ApVcT8mxrVE3eKnpAR6hPH8rC800kw3hTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904288; c=relaxed/simple;
	bh=LAdBrFiiqpPIYb+1fEVGEmGjUltxM7IwFgH3jq/rJDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWs1gBpQrDmPZFRvQmcKlXTRtphwNVhkUZmWn1VEmANWLVfMIEGYCkDCyShiJ9BibxBhDQuTGsHmzFP2VaJrhprP0zZ8TO61cf4OhzllvWSdefDb7GseAO1nfLFpWSiu5X0GeeAylulGMUl8tQnQMyfGIidhIe4Cf+PibHFFf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCQZriwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB0C433F1;
	Fri,  8 Mar 2024 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709904288;
	bh=LAdBrFiiqpPIYb+1fEVGEmGjUltxM7IwFgH3jq/rJDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCQZriwBir8HdF7tMJnCbXC/StQ5ZubtkrurJ/hNH5ABeLm3oUkbkLT4RFyY2E8eO
	 WhEOBptb0FP//rwCm3NEOkHagnEj5gf5qMnmPMe/qNH0seeYsh4AqBQsrYd+RbrnH6
	 pDRLKSmQdbkECwUTmu2Qx8EiSpSPwjGi1C/wfhV39qWSt9mOUDcyucPUwdWxl7RKKL
	 r8to3P6b356iIL9jCR8K8bfo8pwwI6jmqw7KiebRFq4G0i2mjya0l5XV7KTfiYE85w
	 umqtSbSKWbmwfLY0nu5JqX3tCAiDkKwWTsmoxH+sE6t5e8phFPQm6vRX5Q9girR6xc
	 MZOTZB3+scaNQ==
Date: Fri, 8 Mar 2024 14:24:35 +0100
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
Subject: Re: [PATCH v9 07/10] PCI: dwc: ep: Remove "core_init_notifier" flag
Message-ID: <ZesRk5Dg4KEASD3U@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-7-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-7-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:19PM +0530, Manivannan Sadhasivam wrote:
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
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 18c80002d3bd..fc0282b0d626 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -927,21 +928,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>

Hello Mani,

Since you asked for testing, I gave your series a spin
(with a driver without .core_init_notifier).


There seems to be a problem that pci_epc_write_header() is never called.

Debugging this, it seems that .core_init in pci-epf-test is never called.

If I add debug prints in pci_epc_init_notify(), I see that it does not
notify a single EPF driver.

It appears that the patch in $subject will call pci_epc_init_notify()
at EPC driver .probe() time, and at that point in time, there are no
EPF drivers registered.

They get registered later, when doing the configfs write.


I would say that it is the following change that breaks things:

> -	if (!core_init_notifier) {
> -		ret = pci_epf_test_core_init(epf);
> -		if (ret)
> -			return ret;
> -	}
> -

Since without this code, pci_epf_test_core_init() will no longer be called,
as there is currently no one that calls epf->core_init() for a EPF driver
after it has been bound. (For drivers that call dw_pcie_ep_init_notify() in
.probe())

I guess one way to solve this would be for the EPC core to keep track of
the current EPC "core state" (up/down). If the core is "up" at EPF .bind()
time, notify the EPF driver directly after .bind()?


Kind regards,
Niklas

