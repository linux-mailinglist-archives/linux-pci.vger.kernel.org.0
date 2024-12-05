Return-Path: <linux-pci+bounces-17795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497319E5D16
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 18:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AE6281C59
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE6224B1D;
	Thu,  5 Dec 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecgAG1XA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E2222574;
	Thu,  5 Dec 2024 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419661; cv=none; b=ufVoAvGokS7rzybS5aVSLmC8BzohUxQsBKfLbPoZtjZJaMh3aT8c/LVK4KBA3jfdAxWFTF4bxEIZHsX14UscSh1uTTrFUSGZNi+59OPjJFsWpHLfiWVpj41WZj4uyUhzEoy7EeR4+6AFxLmd44EQRvisMO8hwJ6U/y3LOKhe/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419661; c=relaxed/simple;
	bh=Ri91blaEJu7Ua+jUwYZXPSeBwql1Lk/K8YeLB3/SMrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RjVaVc5uTds2E0EY6fggWxyRheURLeA5fHDlCpc0klZ3ahoHEAX7VHWL8F+JYg1Io/B7Eroy+KCYN/c6kzSOi4YYwnwfzjTjbm0FVq09NVhS4kTMoC2AW9J1mDlsNflhARjuG9uswNPaxbrYraVjJz7uUoviO5eV+M7PMGiEMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecgAG1XA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88212C4CED1;
	Thu,  5 Dec 2024 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733419660;
	bh=Ri91blaEJu7Ua+jUwYZXPSeBwql1Lk/K8YeLB3/SMrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ecgAG1XAX0KLrXM6fWo9pl2oJJO6VYSY69RsMhWwXPBtDG+NAvyFaFri8BJEEnvJ/
	 ASsWy0ZWIpKjN9kJUkZdW9/sv+KdeWeToBjYbiiwzBGTUlerd1t9XqzBdq5RWVJKV2
	 g+yYV/Mwpkr8pUzeCmfkDUakzUxFNr+h0d+fg2YBvDgxh7auNQoif/C42tItTndx/f
	 PoS/aOSeWdlVhNEgucreK+/PAvsv7A0N1GXCpzH4y0EtPiYRB2K6PQ4KjWCGgD7z+E
	 iMJiUfUKBgLWtUhB9rCo9BzHrEloST1HnlsiibqwpZYzCt/GcYJAhNZASZH55UGlVv
	 3SUby2bfsHzOA==
Date: Thu, 5 Dec 2024 11:27:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: stm32: Add PCIe endpoint support for
 STM32MP25
Message-ID: <20241205172738.GA3054352@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126155119.1574564-5-christian.bruel@foss.st.com>

On Tue, Nov 26, 2024 at 04:51:18PM +0100, Christian Bruel wrote:
> Add driver to configure the STM32MP25 SoC PCIe Gen2 controller based on the
> DesignWare PCIe core in endpoint mode.

> +config PCIE_STM32_EP
> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	  Enables endpoint support for DesignWare core based PCIe controller in found
> +	  in STM32MP25 SoC.

s/in found in/in/ (or "found in" if you prefer)

Wrap so help text fits in 80 columns when for "make menuconfig".

> +static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	enum pci_barno bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +
> +	/* Defer Completion Requests until link started */

I asked about this before [1] but didn't finish the conversation.  My
main point is that I think "Completion Request" is a misnomer.
There's a "Configuration Request" and a "Completion," but no such
thing as a "Completion Request."

Based on your previous response, I think this should say something
like "respond to config requests with Request Retry Status (RRS) until
we're prepared to handle them."

> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +			   STM32MP25_PCIECR_REQ_RETRY_EN,
> +			   STM32MP25_PCIECR_REQ_RETRY_EN);
> +}
> +
> +static int stm32_pcie_enable_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	int ret;
> +
> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +			   STM32MP25_PCIECR_LTSSM_EN,
> +			   STM32MP25_PCIECR_LTSSM_EN);
> +
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		return ret;
> +
> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +			   STM32MP25_PCIECR_REQ_RETRY_EN,
> +			   0);

And I assume this means the endpoint will accept config requests and
handle them normally instead of responding with RRS.

Strictly speaking this is a different condition than "the link is up"
because the link must be up in order to even receive a config request.
The purpose of RRS is for devices that need more initialization time
after the link is up before they can respond to config requests.

The fact that the hardware provides this bit makes me think the
designer anticipated that the link might come up before the rest of
the device is fully initialized.

Bjorn

[1] https://lore.kernel.org/r/20241112203846.GA1856246@bhelgaas


