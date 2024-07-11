Return-Path: <linux-pci+bounces-10171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CD192ED6B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 19:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826D128B1C2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40968166319;
	Thu, 11 Jul 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VweLSb3c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CD450FA;
	Thu, 11 Jul 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717497; cv=none; b=Z4cw74cet8dMyVNYtrBRiVa9q8KYQ0D0f+lLVTJKuvsb6rRx4j1jevS7LSksrAW1Oy8OuYDFuOUe4fC8IP7x7K3hzHbE4ELpieoBwAjRvvoue5IHZ8FSNkwNrfJSx78V1OEm9OHNMmxj7vmL+84kjvOnzVbY+a9ZW4Gamn4vXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717497; c=relaxed/simple;
	bh=8bA1Af5JkTKsPfzcax7n6cvmceZSVM+9DQAXTzJTRpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hVkl1p7txz8RPwZbPiaNiOZ0Yf3uFAKQIGGh3y/lEoKZrL9Qkw2P5X0p66L9zZr+uO4V8pGUIjdUCGxTbzJ0VROoXOxTLhSjjzeWRiKRuiHHtvqo/H9jnDble+acZve3gyaRKMNzVGmEcikkowmR4Pr+A75dkYC55gAL4KaHKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VweLSb3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B3EC116B1;
	Thu, 11 Jul 2024 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720717496;
	bh=8bA1Af5JkTKsPfzcax7n6cvmceZSVM+9DQAXTzJTRpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VweLSb3cn8veFY/O7cKAlfEIwL3f2HLsE7eAtPdboROuKAnEbFm8vDuj3NQQ0noao
	 dN7r3qfljVRi538GReGxRpj/BZP6uhySPravw3Uif9gWH09HvlUsmyMNqhJWCN2tiY
	 x0gVO7rJZxk8OL2BbRGPUUPmGfyW/FA4bQ35Lco/dQlFGfQ1t+daYbjcQ0dezjNRcQ
	 Js4nQR/KKCirmE+Yn0JLq6WCIHpsGVNO4Taf0Lk16eAsHo+vvB9oWCGeMwhv1D6zbn
	 irDjHcQbE+kCucOfJrocRzdzuxEnojQ+F1ZaM4ay4bcSKmAVQUE04h07Ef6Et2QUwQ
	 VbuDzDmJbTkxQ==
Date: Thu, 11 Jul 2024 12:04:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v6 3/5] PCI: qcom-ep: Add wake up host op to
 dw_pcie_ep_ops
Message-ID: <20240711170454.GA287440@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-wakeup_host-v6-3-ef00f31ea38d@quicinc.com>

On Wed, Jul 10, 2024 at 04:46:10PM +0530, Krishna chaitanya chundru wrote:
> Add wakeup host op to dw_pcie_ep_ops to wake up host.
> If the wakeup type is PME, then trigger inband PME by writing to the PARF
> PARF_PM_CTRL register, otherwise toggle #WAKE.

Wrap into single paragraph or add blank line between.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 627a33a1c5ca..d17e8542d07a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -97,6 +97,7 @@
>  /* PARF_PM_CTRL register fields */
>  #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
>  #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
> +#define PARF_PM_CTRL_XMT_PME			BIT(4)
>  #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
>  
>  /* PARF_MHI_CLOCK_RESET_CTRL fields */
> @@ -817,10 +818,34 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  }
>  
> +static bool qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no, bool send_pme)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> +	struct device *dev = pci->dev;
> +	u32 val;
> +
> +	if (send_pme) {
> +		dev_dbg(dev, "Waking up the host using PME\n");
> +		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> +		writel_relaxed(val | PARF_PM_CTRL_XMT_PME, pcie_ep->parf + PARF_PM_CTRL);
> +		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
> +
> +	} else {
> +		dev_dbg(dev, "Waking up the host by toggling WAKE#\n");
> +		gpiod_set_value_cansleep(pcie_ep->wake, 1);
> +		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);

PCIe r6.0, sec 5.3.3.2, says

  When WAKE# is used as a wakeup mechanism, once WAKE# has been
  asserted, the asserting Function must continue to drive the signal
  low until main power has been restored to the component as indicated
  by Fundamental Reset going inactive.

That doesn't seem compatible with a simple delay as you have here.

> +		gpiod_set_value_cansleep(pcie_ep->wake, 0);
> +	}
> +
> +	return true;
> +}
> +
>  static const struct dw_pcie_ep_ops pci_ep_ops = {
>  	.init = qcom_pcie_ep_init,
>  	.raise_irq = qcom_pcie_ep_raise_irq,
>  	.get_features = qcom_pcie_epc_get_features,
> +	.wakeup_host = qcom_pcie_ep_wakeup_host,
>  };
>  
>  static int qcom_pcie_ep_probe(struct platform_device *pdev)
> 
> -- 
> 2.42.0
> 

