Return-Path: <linux-pci+bounces-26145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1442A92BD3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 21:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC64C1B668AF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 19:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D81FDE12;
	Thu, 17 Apr 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3givaiB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B301BC9F4;
	Thu, 17 Apr 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918269; cv=none; b=cAQ0enewnZh8znRb7v88V9zIyEqsf1weXvJHx3Dbqluaq0LQi7Elk/O9/oxrR12I8X21xHQcQLuF2UZHmH146sUODsZp22HxSK5+Ol6kH0YPC1h/0AiWu9S+TiS93RSBCHwo0wVg80DoUGkzXGC4Ay7/GllsD8+c4fEj4ths104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918269; c=relaxed/simple;
	bh=9AX6tVfbkd+pSYNXJrk75ytubbBqDkCzzjRuH1cCBcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZqdLkEOV78BYJzDUdm2uozf0Z9HopwJ82Mhx4FSFag2STs2DhcBXR4QCafTrw8XHGHuWFk7o0GMask2cudbueipEMtAzSO9F6zWs1kSOpUOriCRIx+zTOUOubVR+cT9z0FcQuHra+N87fRazmJZ2Df/7FtXMg4U4S4FOqpTfYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3givaiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2777C4CEE4;
	Thu, 17 Apr 2025 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744918269;
	bh=9AX6tVfbkd+pSYNXJrk75ytubbBqDkCzzjRuH1cCBcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C3givaiBZ9ajgF4VdBGY/2PGt6kDEdJY24QBrLscfHSkVIs0JkxrLLvGUy+aPIisL
	 YVNGCEBiKXeq9hfyPYEqqSKRPl0Z3mlXn2i3faLy0ZNTymx8+GLAuBu+n7nE7k3x/Z
	 QgAU+7feL5Z8uN5PuRXAlTm/xeolipSvGwMGfY2HDVDqUiTU2hI5V/yvoOR25vCtGU
	 ymP47NCvBN/B4vrjSmLdtg2CXYzhSa445aOwMOWSm3bjLqTx38HkmE6mMBh8ZSU8ZX
	 EixnmcB4+POaXdUK22IXvJTtR/Ylgd4aIZh29brR0Km7YZBrFgZJjFd3mTrXBQRWxQ
	 8+gNBWETf42RQ==
Date: Thu, 17 Apr 2025 14:31:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	thippeswamy.havalige@amd.com, shradha.t@samsung.com,
	quic_schintav@quicinc.com, cassel@kernel.org,
	johan+linaro@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/9] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <20250417193107.GA123243@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417131833.3427126-3-christian.bruel@foss.st.com>

On Thu, Apr 17, 2025 at 03:18:26PM +0200, Christian Bruel wrote:
> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
> controller based on the DesignWare PCIe core.

> +static void stm32_pcie_deassert_perst(struct stm32_pcie *stm32_pcie)
> +{
> +	/* Delay PERST# de-assertion t least 100ms he power to become stable */

s/ t / at /
s/ he / for / ?

Could also remove "100ms".

> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	gpiod_set_value(stm32_pcie->perst_gpio, 0);
> +
> +	/* Wait 100ms for the REFCLK to becode stable  */

s/becode/become/

Could drop "100ms" here, too.

> +	if (stm32_pcie->perst_gpio)
> +		msleep(PCIE_T_RRS_READY_MS);
> +}

> +	if (stm32_pcie->wake_gpio) {
> +		wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
> +		ret = dev_pm_set_dedicated_wake_irq(dev, wake_irq);
> +		if (ret) {
> +			dev_info(dev, "Failed to enable wake# %d\n", ret);

I guess this refers to the "WAKE#" signal in the spec?  Could
capitalize to remove the question.

