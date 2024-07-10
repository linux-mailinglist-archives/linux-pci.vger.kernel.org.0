Return-Path: <linux-pci+bounces-10071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F392D14E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 14:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE571F2429F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 12:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4D18FDBB;
	Wed, 10 Jul 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUyTJ60d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E38189F54;
	Wed, 10 Jul 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613481; cv=none; b=BknMaXsqWGA9LRq8ewTwAuPj5+NDmOreFtCV0Ylb8B3WctyTiXg2q3ALDj4a3PNzpuv7jnKe6kCIxXgMegYOYGp8QAMAFN1eeBqZZSiHXzJGT0XWVFeQPigOc6mMaznNLpKagOPFkw3JMLLw/WBXa2EvQtpFDYjCF+gCeKcI4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613481; c=relaxed/simple;
	bh=anmv0a+fn6y4MHTHMBE3LLoyPKbYLm/tq9yeIVSpZxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lHJ1mzlf8rPtG7rHdzKwlG+oKI4DeUKBAcsDE4hASeGcFBtj1BOSTzADvoZBKvbPkdGRIGx9egIiilOHqocIVUW0hRNlZfVs5PmmomOgb+poMXGE4rTlIMY3H18VAtk9CM/O6Ooe4KjP2RuNv/3V/pZupsToF2lnQYLxaabT31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUyTJ60d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D33C32781;
	Wed, 10 Jul 2024 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720613480;
	bh=anmv0a+fn6y4MHTHMBE3LLoyPKbYLm/tq9yeIVSpZxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XUyTJ60dp3PVIKShstrNhultd0dVL3IrKGUZ/0uIjYz28fuPv/iWlAiiDjJeG/1AK
	 bdjfd3Bpf1PJdAywQZhTFfGx/nLSu0vD+yvCAQU/iN7jiBH6M3EqhVgudISK2KLKZ7
	 ongZVBqPs4pGWGpqMr793T5e6kQlZY57a3YFDMkxrwTF9Pm6nPWnqCvEzBE4IRXqPg
	 5axwV6tvC8fqjrD/v/OFnIYsdTnyctbNxaoKyJX1IkCHINoPoFXqaNsWErClbEPizz
	 /U8b+WaLcHd3QSPfarA+/Ny+c1pmRKTXl9faaut/2qsLmQE9duJZNTHiz3zMVuhjyH
	 EBmuA0K6S18vQ==
Date: Wed, 10 Jul 2024 07:11:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v7 2/4] PCI: qcom-ep: Add support for D-state change
 notification
Message-ID: <20240710121118.GA240905@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-dstate_notifier-v7-2-8d45d87b2b24@quicinc.com>

On Wed, Jul 10, 2024 at 04:38:15PM +0530, Krishna chaitanya chundru wrote:
> Add support to pass D-state change notification to Endpoint
> function driver.

Blank line between paragraphs.

> Read perst value to determine if the link is in D3Cold/D3hot.

I assume this reads the state of the PERST# signal driven by the host.
Style it to match the spec usage ("PERST#") to make that connection
clearer.

D3cold/D3hot is a device state and doesn't apply to a link.  Link
states are L0, L1, L2, L3,etc.  Also in cover letter.

I don't understand the connection between PERST# state and the device
D state.  D3cold is defined to mean main power is absent.  Is the
endpoint firmware still running when main power is absent?

> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 236229f66c80..817fad805c51 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -648,6 +648,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	struct device *dev = pci->dev;
>  	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
>  	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
> +	pci_power_t state;
>  	u32 dstate, val;
>  
>  	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
> @@ -671,11 +672,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>  					   DBI_CON_STATUS_POWER_STATE_MASK;
>  		dev_dbg(dev, "Received D%d state event\n", dstate);
> -		if (dstate == 3) {
> +		state = dstate;
> +		if (dstate == PCI_D3hot) {
>  			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>  			val |= PARF_PM_CTRL_REQ_EXIT_L1;
>  			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
> +
> +			if (gpiod_get_value(pcie_ep->reset))
> +				state = PCI_D3cold;
>  		}
> +		pci_epc_dstate_notify(pci->ep.epc, state);
>  	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>  		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>  		dw_pcie_ep_linkup(&pci->ep);
> 
> -- 
> 2.42.0
> 

