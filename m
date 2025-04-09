Return-Path: <linux-pci+bounces-25585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B48A82A47
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09603B836E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205E265CC5;
	Wed,  9 Apr 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZudEVGyV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689069D2B;
	Wed,  9 Apr 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211876; cv=none; b=SlgChnB+kDxXq0XV2QgINkXUQy+3WgQF8H9NnpukwlMIEYM63CuXbMwuSM6JkQ1R6ZCVX+y0lcY36kITI1raF6HtonEj2qFLcEhaTbHUgAtxqIT5Esr5FhlucgV0jsDBP19tPyhYtnMSnoNWtWJycNn8o81JCmN+AbNGCjrC6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211876; c=relaxed/simple;
	bh=B6CnZZxOmRj9WjoB7zj7+BLt3gdS8mqjcbG4sbdSz5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PzrD1bk67ABiiDFnoaCp6fWJPvZtnnfu+Uncub5Ufurc1BoPMOI41SCWBNE1FGWXwwVTZNisTvw3RQT92evyPglQNxIRkOBXoaQQ1FsrgpCI6VcFqy7MtDuTEeeArq5evJuYcG0cNx94PDo6z7FDz6tnTCgeDG4yTVyMG67dHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZudEVGyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3CEC4CEE2;
	Wed,  9 Apr 2025 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744211876;
	bh=B6CnZZxOmRj9WjoB7zj7+BLt3gdS8mqjcbG4sbdSz5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZudEVGyVTVqKJEXjfUOMN0q53Rs+fb13Tyxnu5nKHUFpP5TjefHF4RyfHZM37oiJJ
	 UceMCe6PkFwazZdBel2mQOUdPca4uD6UVROcd7d8f1vtTmheTsaSrT4EtIWm3VcAcb
	 VVD7GQWgIC+ik/IS36cIuxepH8887a/8oGw/05u1+mJaqv1FoXhjHJOMaMOLPAqxXn
	 o7HwhF8ncBwsZZkoG+2nLTPyTVA+S6r9CAXkFIxDLgZ8pdM58/3qdhpzOsjnkxgNxy
	 /ZaDUlnwEHRNOAUb3Od2Al/G8bGB1kxsGdiM9rgJ3wIh+SibyOfiglTRJebyEIToCh
	 1bIzHBi1eRplQ==
Date: Wed, 9 Apr 2025 10:17:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] pcie-xilinx: Wait for link-up status during
 initialization
Message-ID: <20250409151754.GA283974@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409144930.10402-1-mike.looijmans@topic.nl>

Please make the subject line match previous changes to this driver.
See "git log --oneline drivers/pci/controller/pcie-xilinx.c"

On Wed, Apr 09, 2025 at 04:49:24PM +0200, Mike Looijmans wrote:
> When the driver loads, the transceiver may still be in the state of
> setting up a link. Wait for that to complete before continuing. This
> fixes that the PCIe core does not work when loading the PL bitstream
> from userspace. There's only milliseconds between the FPGA boot and the
> core initializing in that case, and the link won't be up yet. The design
> only worked when the FPGA was programmed in the bootloader, as that will
> give the system hundreds of milliseconds to boot.
> 
> As the PCIe spec allows up to 100 ms time to establish a link, we'll
> allow up to 200ms before giving up.

This sounds like there's still a race between userspace loading the PL
bitstream and the driver waiting for link up, but we're just waiting
longer in the kernel so userspace has more chance of winning the race.
Is that true?

> @@ -126,6 +127,19 @@ static inline bool xilinx_pcie_link_up(struct xilinx_pcie *pcie)
>  		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
>  }
>  
> +static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
> +{
> +	u32 val;
> +
> +	/*
> +	 * PCIe r6.0, sec 6.6.1 provides 100ms timeout. Since this is FPGA
> +	 * fabric, we're more lenient and allow 200 ms for link training.
> +	 */
> +	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
> +			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2 * USEC_PER_MSEC,
> +			200 * USEC_PER_MSEC);

There should be a #define in drivers/pci/pci.h for this 100ms value
that you can use here to connect this more closely with the spec.

Maybe there's a way to use read_poll_timeout(), readx_poll_timeout(),
or something similar so we can use xilinx_pcie_link_up() directly
instead of reimplementing it here?

> +}
> +
>  /**
>   * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
>   * @pcie: PCIe port information
> @@ -493,7 +507,7 @@ static void xilinx_pcie_init_port(struct xilinx_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  
> -	if (xilinx_pcie_link_up(pcie))
> +	if (!xilinx_pci_wait_link_up(pcie))
>  		dev_info(dev, "PCIe Link is UP\n");
>  	else
>  		dev_info(dev, "PCIe Link is DOWN\n");

