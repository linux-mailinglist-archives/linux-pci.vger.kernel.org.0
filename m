Return-Path: <linux-pci+bounces-11718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000F953D89
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 00:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1996284B07
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F36155741;
	Thu, 15 Aug 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4ye+REA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393D155738;
	Thu, 15 Aug 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762058; cv=none; b=YyKeX6m2dboLOVnxezAFdQm20+lhZitDDvjsAus/9+843MnzYfM3j6cinyReTSsG8BSnHfXTEHElbqJY06gliaIlTCtyhVPOWGgUEDtKPHNq8E5ENei/XOVzVbTAoaub77u/kJU9NSBU61NgQrRSGXENc1XHqXPVN6hEgSU+VnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762058; c=relaxed/simple;
	bh=9XHVPuOM21bEOz3FW3/DgjnbThmqW6IhC1MOH6XtZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X/ywUtdO6+OGS+W7XETB3WKbLl712rdjcTZcLsNJkmJqNeLOJ60LgCuQ5q/HEkQuqWeRASXlxLayhBiSyf+MWib1SWQ6TCL3BFGwhAtLl4Wbp5LMaMpHYGmzSLWsR5sdXEPwUXf9cs7+1JswsnDGhNjhVh3KXEckvkgKUc4y4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4ye+REA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6395C4AF09;
	Thu, 15 Aug 2024 22:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723762058;
	bh=9XHVPuOM21bEOz3FW3/DgjnbThmqW6IhC1MOH6XtZdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q4ye+REATBbzETn8QfmcAwDfRN8Pg9I2MJgR1epmR2uv+PicZrizTJyXQuzbv1xVj
	 hLMexdv7dd8b88rBKx99jQ9EVOuerq47X3s9BdsM5XksPpIX91S8gqc1+21Mo7d8jB
	 fE0+C89AXp39DpH0VivqDLvLwVsSgMix2wj0OyCy/o8j5mI4qBO+iN5F2/XqQKxhak
	 lDhfgsMGyRolO+yoG1Gcp8nTj/m5iVunvTDeXdeL664aMSmHaAR3RL0e+gPBZinjry
	 UIMm/nI/+7uOoefhv59ckLWktJZVouhuWVEFS6kQTKc8v0ScibW9ao/9p2UO3zH2Tg
	 J1Q/C554v/umA==
Date: Thu, 15 Aug 2024 17:47:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
	robh@kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
	bjorn.andersson@linaro.org, sallenki@codeaurora.org,
	skananth@codeaurora.org, vpernami@codeaurora.org,
	vbadigan@codeaurora.org,
	Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v8 2/3] PCI: qcom-ep: Add Qualcomm PCIe Endpoint
 controller driver
Message-ID: <20240815224735.GA57931@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920065946.15090-3-manivannan.sadhasivam@linaro.org>

On Mon, Sep 20, 2021 at 12:29:45PM +0530, Manivannan Sadhasivam wrote:
> Add driver support for Qualcomm PCIe Endpoint controller driver based on
> the Designware core with added Qualcomm specific wrapper around the
> core.
> ...

> +static irqreturn_t qcom_pcie_ep_perst_irq_thread(int irq, void *data)
> +{
> +     struct qcom_pcie_ep *pcie_ep = data;
> +     struct dw_pcie *pci = &pcie_ep->pci;
> +     struct device *dev = pci->dev;
> +     u32 perst;
> +
> +     perst = gpiod_get_value(pcie_ep->reset);
> +     if (perst) {
> +             dev_dbg(dev, "PERST asserted by host. Shutting down the PCIe link!\n");
> +             qcom_pcie_perst_assert(pci);
> +     } else {
> +             dev_dbg(dev, "PERST de-asserted by host. Starting link training!\n");
> +             qcom_pcie_perst_deassert(pci);
> +     }
> +
> +     irq_set_irq_type(gpiod_to_irq(pcie_ep->reset),
> +                      (perst ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW));

1) There are only a handful of instances of irq_set_irq_type() being
used with IRQF_TRIGGER_* (all others use IRQ_TYPE_*).

2) Using irq_set_irq_type() in an IRQ handler is unusual and seems
potentially racy.  Almost all irq_set_irq_type() uses are in
initialization or probe paths.  I did see one similar use in an IRQ
handler (rb532_pata_irq_handler()), but the rarity of this pattern
makes me suspicious.

> +static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
> +                                          struct qcom_pcie_ep *pcie_ep)
> +{
> + ...
> +     pcie_ep->perst_irq = gpiod_to_irq(pcie_ep->reset);
> +     irq_set_status_flags(pcie_ep->perst_irq, IRQ_NOAUTOEN);
> +     ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->perst_irq, NULL,
> +                                     qcom_pcie_ep_perst_irq_thread,
> +                                     IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +                                     "perst_irq", pcie_ep);

The similar code in the tegra194 driver looks like this:

  tegra_pcie_config_ep
    devm_request_threaded_irq(tegra_pcie_ep_pex_rst_irq,
                  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)

  tegra_pcie_ep_pex_rst_irq
    if (gpiod_get_value(pcie->pex_rst_gpiod))
      pex_ep_event_pex_rst_assert(pcie);
    else
      pex_ep_event_pex_rst_deassert(pcie);

Could qcom work the same way by requesting the IRQ with
"IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING" instead of
"IRQF_TRIGGER_HIGH", and omitting the irq_set_irq_type()?

I know rising/falling is edge-triggered and high/low is
level-triggered, but surely qcom isn't completely unique in the way
its IRQ is wired up?

