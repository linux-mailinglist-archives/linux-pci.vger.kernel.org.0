Return-Path: <linux-pci+bounces-35042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB8B3A7CE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A70987DF9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4A33A029;
	Thu, 28 Aug 2025 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NniPVCL7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB12264B2;
	Thu, 28 Aug 2025 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401775; cv=none; b=DHp6EBqWXOCKPOpJ4yV/HcXPdVIZ+AdVG3/ym+A5v1RktZfWwAez69ufUGLbSfo5dtKsud6n+P+zoZR6FyBi7McqV8DmtDNuLpPOaEHFFJ/7F/xBgFnLY+m4n18eNqO9uN+iNWnGXB2w2e9Sx/pDP5cNCEz/cqw2Dv7YYHX4DGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401775; c=relaxed/simple;
	bh=D64Dcw+3Q7Bhw7cRL3Mx51sKXxd32kG6A6P2l/nGXPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FafkJa0bY9kuEfeINYH/pXw93JbhhRFvA8fR0nqzbToYx6aHI3qKhBJE6nbA3DO7r7Lnox6GChdmVskLMkWdF4jqWoPwW6Xtb9lHhpTaQ6/2ubYDhnCDsjvGnE5R3zr6aoNBnJxPixmOMtVIzrcqgaUT5wozYK+K49wMyRQ21V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NniPVCL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B7EC4CEF5;
	Thu, 28 Aug 2025 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401775;
	bh=D64Dcw+3Q7Bhw7cRL3Mx51sKXxd32kG6A6P2l/nGXPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NniPVCL70CJLdBOdxQoW1jaUw3KHNNjTpnByZBXqpMVCAZP6eWtTCp1uK0XEEB00u
	 kuHZ0awF3fnjhHf6IH6lJMdKgqVDcRh42ivtIHDLmJRs8ttBqcFf87Jy2jplZeLM3o
	 zV9PXCeb/dnaMbPIH0VPYOJ5JKvIpMI2uV6RRVexO3ZmIZaS4mStzp7Wgt12uDwPOi
	 Z6/VxNFYcJG2ZtfnAevv1gZT+T0kUpAtm+74fTBX9TXUh7C6HM99sp/lHozeiLbFng
	 gEsXq5bQHE6s2jopMhGWOQsPuHfUhZtsa+Fmx1U8CkEtQcw9dUK3tYt6YoW7TAwc35
	 /2mMgE9BOicQg==
Date: Thu, 28 Aug 2025 12:22:53 -0500
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
Message-ID: <20250828172253.GA949714@bhelgaas>
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
> ...

> +static int stm32_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	int ret;
> +
> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
> +		dev_dbg(pci->dev, "Link is already enabled\n");
> +		return 0;
> +	}

While looking at the "incorrectly reset" comment, I noticed
stm32_pcie->link_status and wondered why it exists.  It looks like
it's only used in stm32_pcie_start_link() and stm32_pcie_stop_link(),
and I don't see similar tracking in other drivers.

It feels a little racy because the link might go down for reasons
other than calling stm32_pcie_stop_link().

> +	dev_dbg(pci->dev, "Enable link\n");
> +
> +	ret = stm32_pcie_enable_link(pci);
> +	if (ret) {
> +		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
> +		return ret;
> +	}
> +
> +	enable_irq(stm32_pcie->perst_irq);
> +
> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
> +
> +	return 0;
> +}
> +
> +static void stm32_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +
> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_DISABLED) {
> +		dev_dbg(pci->dev, "Link is already disabled\n");
> +		return;
> +	}
> +
> +	dev_dbg(pci->dev, "Disable link\n");
> +
> +	disable_irq(stm32_pcie->perst_irq);
> +
> +	stm32_pcie_disable_link(pci);
> +
> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_DISABLED;
> +}

