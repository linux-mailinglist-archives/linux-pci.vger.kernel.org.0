Return-Path: <linux-pci+bounces-17477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5561D9DECC1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 21:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DF52816EE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 20:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB715E5DC;
	Fri, 29 Nov 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQiVBSEX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8E157A72;
	Fri, 29 Nov 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732913905; cv=none; b=eObrHJ4L86JHCYZyyfD8AsQC/7LjwA35el1GQnRzvtP29GK4S2+q9bYVm1ouDGBuElr2JcIPVgrxAvcJbquWLL8p6KNX67wztxrRWrWum/rDTPjZpPYlRflgKcxNDsihopYeyH+aPjgw0QjfUSwtA5SREZLoREHgnYtz9w86iVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732913905; c=relaxed/simple;
	bh=zZKblG1oW6ilUbzaYkY0HepGVylQVjpGP80Xxjdr6Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cafm3HZ7tL43rJWN/rIEGYM5efIncBiW9YP/rI2BaUsSRjSZDdIi8ctVuUCYHWIUaNb0oteE0qsgEZOApHce6qOpnXT78bH0rsrXeXB4CJP2K1NUU0PHoeaq4tMCtXEsJxU0suJ1J7PSk40IOwmeMrmOzQcadUPIB1rzd2/YmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQiVBSEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75BDC4CECF;
	Fri, 29 Nov 2024 20:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732913905;
	bh=zZKblG1oW6ilUbzaYkY0HepGVylQVjpGP80Xxjdr6Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KQiVBSEXjNg3lOwoGvXRCuJjrm7xatbZwYoYfv8aYFd2HC0x5IJwKuqgoADK5cx9K
	 +KX+jmQbgvhKJQM5fpzL2YlJNdEYoFU52WttObfeKoS51O5ro2RHnsjH0sbHk9v4jY
	 mZ01idn5tzWZJrtgbtOuJnR9QciqUf3vbKpMkiMsrzTUEVedYbbKlXa+qwBpRIpc7o
	 j+JCVS5cVlgBCevSGvuoEVGWDx9TIVWsyegp2YjjAfCfT4NCKKbPs/KphT0mSysSZW
	 8jgaVREpqN7BRnHS8uFMKh7fbOU8g8VMxSepgeHdPF4OoFOGbZAZqPDYvxd+5nR92a
	 F2eJxFgKs3hvQ==
Date: Fri, 29 Nov 2024 14:58:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <20241129205822.GA2772018@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126155119.1574564-3-christian.bruel@foss.st.com>

[+to Rob, DMA mask question]

On Tue, Nov 26, 2024 at 04:51:16PM +0100, Christian Bruel wrote:
> Add driver for the STM32MP25 SoC PCIe Gen2 controller based on the
> DesignWare PCIe core.

Can you include the numeric rate, not just "gen2", so we don't have to
search for it?

> +static int stm32_pcie_resume_noirq(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = stm32_pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	int ret;
> +
> +	/* init_state must be called first to force clk_req# gpio when no
> +	 * device is plugged.
> +	 */

Use drivers/pci/ conventional comment style:

  /*
   * text ...
   */

> +static bool is_stm32_pcie_driver(struct device *dev)
> +{
> +	/* PCI bridge */
> +	dev = get_device(dev);
> +
> +	/* Platform driver */
> +	dev = get_device(dev->parent);
> +
> +	return (dev->driver == &stm32_pcie_driver.driver);
> +}
> +
> +/*
> + * DMA masters can only access the first 4GB of memory space,
> + * so we setup the bus DMA limit accordingly.
> + */
> +static int stm32_dma_limit(struct pci_dev *pdev, void *data)
> +{
> +	dev_dbg(&pdev->dev, "disabling DMA DAC for device");
> +
> +	pdev->dev.bus_dma_limit = DMA_BIT_MASK(32);

I don't think this is the right way to do this.  Surely there's a way
to describe the DMA capability of the bridge once instead of iterating
over all the downstream devices?  This quirk can't work for hot-added
devices anyway.

> +	return 0;
> +}
> +
> +static void quirk_stm32_dma_mask(struct pci_dev *pci)
> +{
> +	struct pci_dev *root_port;
> +
> +	root_port = pcie_find_root_port(pci);
> +
> +	if (root_port && is_stm32_pcie_driver(root_port->dev.parent))
> +		pci_walk_bus(pci->bus, stm32_dma_limit, NULL);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0x0550, quirk_stm32_dma_mask);

