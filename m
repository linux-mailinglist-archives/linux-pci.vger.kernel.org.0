Return-Path: <linux-pci+bounces-34935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA1AB389F8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 20:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DAC1677EA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A19B2E7BDC;
	Wed, 27 Aug 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/A4hCuX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0C23C4F1;
	Wed, 27 Aug 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321107; cv=none; b=AExw2Bnq7+ceWs8nMS5sAyYuwAZV3KuNdLv2kR2c2ZNdHFC+/WUl3M+jwjL9nfyzbYK4RMWpK+/Z0xo7jBz3PRt+hztNJwxqqt4YMSeaE1OvZ7zSP8mn6NBABNjispAfnT//Xhqk9W4UaU2CrrcUUKlLOqvJ3yQl3A+1OsMNioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321107; c=relaxed/simple;
	bh=k/tPNcfJ/qdnWRcsE6nXClRCEZmBAkB4S98CVmbWffE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JtGnJck9IV9bpJSrfzKsLhLYq6Xcgqhi7XgSBCF4SHBYdlJ3PuI7oWUmyhIwcxXVkuBo9KZ5SFprjPPJolLqvb8zfJhs+wz0QTsN9bIdCzxJ6+K4LY+nahUcTyh6YXkKQrQ3WK5OpgITag/5/RESRuJ17/VqeujeidZQYbo889A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/A4hCuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8403C4CEEB;
	Wed, 27 Aug 2025 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756321106;
	bh=k/tPNcfJ/qdnWRcsE6nXClRCEZmBAkB4S98CVmbWffE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p/A4hCuXnw78K2/C7/7U2ep3c3mB0WH5FKsFfvMkA9XgZ3H7LOX8UCUSWJNoafOwu
	 VJwzEpoV0FLpzBZU2Gw77yR4FhTSim9ud/WuydhPXNXtF/rGRXGfd+YK3F5on9j3m1
	 BS5UCJTAZLWfEiDJLhUiXABrbbSP1hTFOC4xOKq0sIZR+fCLsoqZpQlzLmgFotwXwP
	 JttlA+091dVHUkpQgd8HOqDX2sV3jjLpIwqXnPEyTY1NeHt8YuYy8Rg6HWDtPSKuuJ
	 jW3ADEJW9Z1TzPtmOWkaj5LY0S4P5ZnFSbOb2JCD/SeOL3yUWwPQSTKjtiQSTch1dj
	 WebNWWgPMD0CA==
Date: Wed, 27 Aug 2025 13:58:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linus.walleij@linaro.org,
	corbet@lwn.net, p.zabel@pengutronix.de, shradha.t@samsung.com,
	mayank.rana@oss.qualcomm.com, namcao@linutronix.de,
	qiang.yu@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, quic_schintav@quicinc.com,
	johan+linaro@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 06/11] PCI: stm32: Add PCIe Endpoint support for
 STM32MP25
Message-ID: <20250827185825.GA894342@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820075411.1178729-7-christian.bruel@foss.st.com>

On Wed, Aug 20, 2025 at 09:54:06AM +0200, Christian Bruel wrote:
> Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
> controller based on the DesignWare PCIe core in endpoint mode.

> +static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	struct device *dev = pci->dev;
> +	struct dw_pcie_ep *ep = &pci->ep;
> +	int ret;
> +
> +	dev_dbg(dev, "PERST de-asserted by host\n");
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to resume runtime PM: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = stm32_pcie_enable_resources(stm32_pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable resources: %d\n", ret);
> +		goto err_pm_put_sync;
> +	}
> +
> +	/*
> +	 * Need to reprogram the configuration space registers here because the
> +	 * DBI registers were incorrectly reset by the PHY RCC during phy_init().

Is this incorrect reset of DBI registers a software issue or some kind
of hardware erratum that might be fixed someday?  Or maybe it's just a
characteristic of the hardware and thus not really "incorrect"?

I do see that qcom_pcie_perst_deassert() in pcie-qcom-ep.c also calls
dw_pcie_ep_init_registers() in the qcom_pcie_ep_perst_irq_thread()
path.

So does pex_ep_event_pex_rst_deassert() (pcie-tegra194.c) in the
tegra_pcie_ep_pex_rst_irq() path.

But as far as I can tell, none of the other dwc drivers need this, so
maybe it's something to do with the glue around the DWC core?

> +	 */
> +	ret = dw_pcie_ep_init_registers(ep);
> +	if (ret) {
> +		dev_err(dev, "Failed to complete initialization: %d\n", ret);
> +		goto err_disable_resources;
> +	}

