Return-Path: <linux-pci+bounces-3046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A30847BD3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 22:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2581C2387B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA98839E4;
	Fri,  2 Feb 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS8zPrba"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D58061F;
	Fri,  2 Feb 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706910874; cv=none; b=bKk266JYJcoJxTm7pGc5qmQi5A1TnrWn/5/5ZQaip2WL+VahS5u0TQBVTniufXOpt2LXyFBwrgvIJnJwS2DwDgoWr9jhorLlbNUew7yyk1iITpIOm6/AVROhdKcebWmaAVrvw6Je2Al9Vzsnsxu6vJXYFG1XlNHQu/FhosXBP1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706910874; c=relaxed/simple;
	bh=g2E+c2yAPlr4mynw8XRrEWwtZ0cuRU9sb/1VLjj4d+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IKdNyXOUvfs9dcG9KL9NzF1C9/fEr41UyaEp2EKRHi/yverhuh7MDqPUtBXFYQlFwg/BzhIIQOoZmDVy4gZjLqSCuSMbBriMSatR4H7cG5H1tBFS9ad5yrxpwMPEJL3ooJZp5K6bg8y69DMEsnYDSt3AZlY3CjE63hN8tH6J8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS8zPrba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E936C433C7;
	Fri,  2 Feb 2024 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706910873;
	bh=g2E+c2yAPlr4mynw8XRrEWwtZ0cuRU9sb/1VLjj4d+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NS8zPrbawxvDfY0Eh7Q6yuZ1sIPxS165/J7/2Y7tKanOBPLD+4dB3IXc8L5YVGy80
	 bSWHpRgxY9QHX90pQtSVPTYdQ/RF+IJfmh4C9vwg31doe1ucpeQzgA1E6HsCWaqTHZ
	 WCHB5KJ5V0wkgI2ydWwMccY0UpKEymbcFn/iIF/oxzC7FMfuTNMEXPOkifc6HJT1KX
	 AjBVnvpt9LpUJv70WYr8CkRldTO5/oVEKraxwJZLD566+Vag7nYVd32hSm516qWbzq
	 RYeFz6sshI5fm5CjbRRLRy0SymKXAinGlASjWBOzggBE/yLhBhaEvy48n0tB++7L6V
	 ClG0C1+ZWvgsA==
Date: Fri, 2 Feb 2024 15:54:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v9 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <20240202215431.GA728556@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119171122.3057511-6-Frank.Li@nxp.com>

On Fri, Jan 19, 2024 at 12:11:11PM -0500, Frank Li wrote:
> Avoid use get slot id by compared with register physical address. If there
> are more than 2 slots, compared logic will become complex.
> 
> "linux,pci-domain" already exist at dts since commit:
> 	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).
> 
> So it is safe to remove compare basic address code:
> 	...
> 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> 		imx6_pcie->controller_id = 1;
> 	...

I have no idea what this is telling me.  I guess you don't want to use
IMX8MQ_PCIE2_BASE_ADDR to decide something?  That much sounds good:
the *address* of some MMIO space doesn't tell us anything about the
function of that space.

I expect the "compatible" string to tell the driver what the
programming model of the device is.

> +	/* Using linux,pci-domain as PCI slot id */
> +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> +	/*
> +	 * If there are no "linux,pci-domain" property specified in DT, then assume only one
> +	 * controller is available.
> +	 */
> +	if (imx6_pcie->controller_id == -EINVAL)
> +		imx6_pcie->controller_id = 0;
> +	else if (imx6_pcie->controller_id < 0)
> +		return dev_err_probe(dev, imx6_pcie->controller_id,
> +				     "linux,pci-domain have wrong value\n");

Maybe I'm missing something here.  It looks like this driver uses
controller_id to distinguish between hardware variants or maybe
between two Root Ports (slots?) in the same SoC?

  imx6_pcie_grp_offset
    return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;

  imx6_pcie_configure_type
    id = imx6_pcie->controller_id
    if (!drvdata->mode_mask[id])         # <-- looks unsafe
      id = 0;
    regmap_update_bits(drvdata->mode_off[id], ...)

(This "mode_mask[id]" looks like it will reference garbage if the DT
supplies "linux,pci-domain = <2>".  A bogus DT shouldn't be able to
cause a driver to misbehave like that.)

That doesn't seem related to "linux,pci-domain" at all.

Bjorn

