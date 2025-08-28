Return-Path: <linux-pci+bounces-35041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8A5B3A78F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA80AA02D1D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A0334732;
	Thu, 28 Aug 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXMjNa1O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CDC1A5BBC;
	Thu, 28 Aug 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401384; cv=none; b=trPAYKml3PfVK3na9ZnXshGz8L9r3+YW8JBnITvd9SsohqeHdGHRbBGUM4MiL3NifLLQH/cJL57BTZsTblCtB+Jdyp9289j3SDXZsGEGv++qu2Jp+mU2tvDz8g8tWHrPLv3pOBCrCwXdnPJGOCfdo2tHVvdkItrce0Jgwkix75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401384; c=relaxed/simple;
	bh=Kmt4M/Z2w+PlibUTUari/qi5WTPoz/7V3tEAWMttjcs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hWIBbbR6mJAfFQfU0UZ3pHkUGoH6rYU1u1FWFp04F4Z/nCoRDkTQN0QsParaZCkELL0lT4DJzpW4JN602EZw8itlYqraKE4BnTTfiBSURtiJihCN6IE/ac79DhBtTwRrmcFhO589yfNpWngwmaj0jJg9zuJdjdXvxYrkYNpSYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXMjNa1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE76C4CEF4;
	Thu, 28 Aug 2025 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401383;
	bh=Kmt4M/Z2w+PlibUTUari/qi5WTPoz/7V3tEAWMttjcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lXMjNa1OLazCVKdubqEGCO/lXhyt1mqLJQfntrNgnF2MeIfopD2JSL24bzM3r9g9r
	 2FQ23qtLYZLlOH1o3RU26+tDTfmBIwux0hZ2dKZe/xQpgbAQud8uJWbM0fsG+dMUdm
	 vuO8pvW/zTg9XPl2CMq9Z8VxXu5j9D0/OjmzDW/WoUCZae0+h9u1t6E1C5SEkwh5S6
	 NiPEA3+OmmoeyhCYFFjVSDB0YGXiGktNmSWf4gX+mqBVSG5R/MRlGpN6c5OR5n+hbw
	 y4YzH8G2J8JZrbEx1Ub9PxBMWtap5lkFUZqod4nTSCoJBR5XHfFeXcOEwGeXkdFT2B
	 CJQt+pQ4f0P9g==
Date: Thu, 28 Aug 2025 12:16:22 -0500
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
Message-ID: <20250828171622.GA945192@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9133348a-f6a4-4425-98e2-a784a7620b3a@foss.st.com>

On Thu, Aug 28, 2025 at 02:12:57PM +0200, Christian Bruel wrote:
> On 8/27/25 20:58, Bjorn Helgaas wrote:
> > On Wed, Aug 20, 2025 at 09:54:06AM +0200, Christian Bruel wrote:
> > > Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
> > > controller based on the DesignWare PCIe core in endpoint mode.
> > 
> > > +static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > +	struct device *dev = pci->dev;
> > > +	struct dw_pcie_ep *ep = &pci->ep;
> > > +	int ret;
> > > +
> > > +	dev_dbg(dev, "PERST de-asserted by host\n");
> > > +
> > > +	ret = pm_runtime_resume_and_get(dev);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "Failed to resume runtime PM: %d\n", ret);
> > > +		return;
> > > +	}
> > > +
> > > +	ret = stm32_pcie_enable_resources(stm32_pcie);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to enable resources: %d\n", ret);
> > > +		goto err_pm_put_sync;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Need to reprogram the configuration space registers here because the
> > > +	 * DBI registers were incorrectly reset by the PHY RCC during phy_init().
> > 
> > Is this incorrect reset of DBI registers a software issue or some kind
> > of hardware erratum that might be fixed someday?  Or maybe it's just a
> > characteristic of the hardware and thus not really "incorrect"?
> > 
> > I do see that qcom_pcie_perst_deassert() in pcie-qcom-ep.c also calls
> > dw_pcie_ep_init_registers() in the qcom_pcie_ep_perst_irq_thread()
> > path.
> > 
> > So does pex_ep_event_pex_rst_deassert() (pcie-tegra194.c) in the
> > tegra_pcie_ep_pex_rst_irq() path.
> > 
> > But as far as I can tell, none of the other dwc drivers need this, so
> > maybe it's something to do with the glue around the DWC core?
> 
> The RCC PHY reset is connected to the Synopsys cold reset logic, which
> explains why the registers need to be restored. This point has been
> addressed in the reference manual.

OK.  I dropped "incorrectly" from the comment because I think future
readers will wonder about whether or how this could be fixed, and it
sounds like it's just a feature of the hardware that we need to deal
with.

> > > +	 */
> > > +	ret = dw_pcie_ep_init_registers(ep);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to complete initialization: %d\n", ret);
> > > +		goto err_disable_resources;
> > > +	}
> 

