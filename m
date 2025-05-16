Return-Path: <linux-pci+bounces-27868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C60AB9EF4
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD57A31BE
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89219ABC6;
	Fri, 16 May 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdOgFTIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3696190072;
	Fri, 16 May 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407129; cv=none; b=eMevCeU7YqUu196dZQun7hK6l2qbzDYwKmS09VPEdphxZ467yJzPUgMx91Q5TmegekhyHhooervW+m/72LgMnaXaIdqOpZI127gfpKCmgTKwtGfR+B41ESj0ZxtW76XMzbj1XEkYcsdCuSrZhe/WtXQW4Iz8tdLkpKy3Qubz4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407129; c=relaxed/simple;
	bh=55iUVdRf8GgLkjcVLgOYJa2jXmc6dM9rV3Kcs4cqta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRlCAzvwBPkn8+ltJz7q/Qj07j/iqDaYfpmf4fd7hFZ/Ss7cTJQg5DIynf1v1C8SZ6l2TbJVzD2wBbxb9rBMjF7605U4GC+BfAhxhvu7HkW5oDTGHcA6KJ+TLjJsCt6KUgh9YqNZ27V9f2WDxbRyb3jKynfnmsXqupj/+1NTOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdOgFTIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFADC4CEE4;
	Fri, 16 May 2025 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747407128;
	bh=55iUVdRf8GgLkjcVLgOYJa2jXmc6dM9rV3Kcs4cqta0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdOgFTIoB2YAg3QDa42y1s9/xyLo7YNoh8rLX5uw582mSABYqxhBr6+Zpb5THkkFi
	 VSs1IxMhG/NKoySBwekPY04K56bhuE6SCdnDH3ZBvTzHWBnXDqgINiph9AzungJIlm
	 yHgq67x+VMNcpdhiKCFmlCXGxay3ghGgdD2yY7Fp/MR41wiPy6nTgrM+bwcuWwgCB5
	 ddA8dgaI22VapYj8rVuETSHnz0OExHAbZ1z2cjaU/s33JKW28bERAw2dZEDJGo1wlI
	 XNLN2Hd0LlGPbn8wy9aHefiWRL9UlXlhZUDO5zKr1cGCo9Ik56jMOAm+UGEHWKYVU9
	 7iDg7XC+RQpHQ==
Date: Fri, 16 May 2025 15:52:00 +0100
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, thippeswamy.havalige@amd.com, 
	shradha.t@samsung.com, quic_schintav@quicinc.com, cassel@kernel.org, 
	johan+linaro@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/9] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <q4rbaadr7amsrtwaeickdjmcst77onuopir5rzpvixa7ow7udk@txwsmidjs3im>
References: <20250423090119.4003700-1-christian.bruel@foss.st.com>
 <20250423090119.4003700-3-christian.bruel@foss.st.com>
 <gzw3rcuwuu7yswljzde2zszqlzkfsilozdfv2ebrcxjpvngpkk@hvzqb5wbjalb>
 <c01d0d72-e43c-4e10-b298-c8ed4f5d1942@foss.st.com>
 <ec33uuugief45swij7eu3mbx7htfxov6qa5miucqsrdp36z7qe@svpbhliveks4>
 <7df0c1e5-f53b-4a44-920a-c2dfe8842481@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7df0c1e5-f53b-4a44-920a-c2dfe8842481@foss.st.com>

On Fri, May 16, 2025 at 10:37:16AM +0200, Christian Bruel wrote:
> 
> 
> On 5/15/25 13:29, Manivannan Sadhasivam wrote:
> > On Mon, May 12, 2025 at 05:08:13PM +0200, Christian Bruel wrote:
> > > Hi Manivannan,
> > > 
> > > On 4/30/25 09:30, Manivannan Sadhasivam wrote:
> > > > On Wed, Apr 23, 2025 at 11:01:12AM +0200, Christian Bruel wrote:
> > > > > Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
> > > > > controller based on the DesignWare PCIe core.
> > > > > 
> > > > > Supports MSI via GICv2m, Single Virtual Channel, Single Function
> > > > > 
> > > > > Supports WAKE# GPIO.
> > > > > 
> > > > 
> > > > Mostly looks good. Just a couple of comments below.
> > > > 
> > > > > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/Kconfig      |  12 +
> > > > >    drivers/pci/controller/dwc/Makefile     |   1 +
> > > > >    drivers/pci/controller/dwc/pcie-stm32.c | 368 ++++++++++++++++++++++++
> > > > >    drivers/pci/controller/dwc/pcie-stm32.h |  15 +
> > > > >    4 files changed, 396 insertions(+)
> > > > >    create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
> > > > >    create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
> > > > > 
> > > > 
> > > > [...]
> > > > 
> > > > > +static int stm32_pcie_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +	struct stm32_pcie *stm32_pcie;
> > > > > +	struct device *dev = &pdev->dev;
> > > > > +	int ret;
> > > > > +
> > > > > +	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
> > > > > +	if (!stm32_pcie)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	stm32_pcie->pci.dev = dev;
> > > > > +	stm32_pcie->pci.ops = &dw_pcie_ops;
> > > > > +	stm32_pcie->pci.pp.ops = &stm32_pcie_host_ops;
> > > > > +
> > > > > +	stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
> > > > > +	if (IS_ERR(stm32_pcie->regmap))
> > > > > +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
> > > > > +				     "No syscfg specified\n");
> > > > > +
> > > > > +	stm32_pcie->clk = devm_clk_get(dev, NULL);
> > > > > +	if (IS_ERR(stm32_pcie->clk))
> > > > > +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->clk),
> > > > > +				     "Failed to get PCIe clock source\n");
> > > > > +
> > > > > +	stm32_pcie->rst = devm_reset_control_get_exclusive(dev, NULL);
> > > > > +	if (IS_ERR(stm32_pcie->rst))
> > > > > +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
> > > > > +				     "Failed to get PCIe reset\n");
> > > > > +
> > > > > +	ret = stm32_pcie_parse_port(stm32_pcie);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	platform_set_drvdata(pdev, stm32_pcie);
> > > > > +
> > > > > +	ret = pm_runtime_set_active(dev);
> > > > > +	if (ret < 0) {
> > > > > +		dev_err(dev, "Failed to activate runtime PM %d\n", ret);
> > > > 
> > > > Please use dev_err_probe() here and below.
> > > 
> > > OK, will report this in the EP driver also.
> > > 
> > > > 
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	ret = devm_pm_runtime_enable(dev);
> > > > > +	if (ret < 0) {
> > > > > +		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	pm_runtime_get_noresume(dev);
> > > > > +
> > > > 
> > > > I know that a lot of the controller drivers do this for no obvious reason. But
> > > > in this case, I believe you want to enable power domain or genpd before
> > > > registering the host bridge. Is that right?
> > > 
> > > We call pm_runtime_enable() before stm32_add_pcie_port() and
> > > dw_pcie_host_init(). This ensures that PCIe is active during the PERST#
> > > sequence and before accessing the DWC registers.
> > > 
> > 
> > What do you mean by 'PCIe is active'? Who is activating it other than this
> > driver?
> 
> "PCIe is active" in the sense of pm_runtime_active() and PM runtime_enabled.
> 
> A better call point would be just before dw_host_init(), after the PCIe
> controller is reset :
> 
> stm32_add_pcie_port()
> clk_prepare_enable()

also...

pm_runtime_set_active()
pm_runtime_no_callbacks()

> devm_pm_runtime_enable()
> dw_pcie_host_init()
> 
> with this sequence, the stm32_pcie_suspend_noirq() is well balanced. does
> that sound better ?
> 

Yeah.

> > 
> > > > And the fact that you are not
> > > > decrementing the runtime usage count means, you want to keep it ON all the time?
> > > > Beware that your system suspend/resume calls would never get executed.
> > > 
> > > We do not support PM runtime autosuspend, so we must notify PM runtime that
> > > PCIe is always active. Without invoking pm_runtime_get_noresume(), PCIe
> > > would mistakenly be marked as suspended.
> > 
> > This cannot happen unless the child devices are also suspended? Or if there are
> > no child devices connected.
> 
> If no device is connected or if one is active, without
> pm_runtime_get_noresume(), pm_genpd_summary says "PCIe suspended" despite
> being clocked and having accessible configuration space
> 

This mostly means the hierarchy is not properly modelled. So the PM core doesn't
know that the child devices are active. You need to check the genpd summary for
PCI bridge and endpoint devices.

If there are no devices, then it is OK to be marked as suspended. But I would
assume that even if an user hotplugs an endpoint, it would just work since there
are no runtime PM callbacks populated. Only thing to worry is that, the genpd
core may turn off the power domain if all the devices in the hierarchy are
suspended. But we do have some workarounds for that, if power domains need to be
kept on. So let me know.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

