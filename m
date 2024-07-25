Return-Path: <linux-pci+bounces-10808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF3993CA20
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 23:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B0728231A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A07D401;
	Thu, 25 Jul 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d34bvc7r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D81C6BE;
	Thu, 25 Jul 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942324; cv=none; b=a7X6M0U4V/rd4Gb1OidPMvnxodomLfU6va2F+ksyR+oKn6W9luVJ1TtDW2YxB6PyhnyVbE+au/ctgGM2QGW5JEsc7o6LBuxW7VLTNqaWY81WwH0Vb5mulSV55zwtffTrZ7FSTr0JfXx5FmClo0Q7BtF/wGvOYZbQHCCRSN72juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942324; c=relaxed/simple;
	bh=/AAXREcOI32vQxwZurvxUKNxXBgKObFukzNWPPKPbQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fLVHA1tbNnxa7sHESwLMW50j2if+X7UG5ozu5kC4tnct0JC8innpfj8ZRCk/BZcSApGS12T7ZEZ968yz9DsoyaC5E4kF8xj7jfhayMq63fXbto57Fdu0/Mvf8S0qwk57AC8h7/34wzB6uKnW8pJ4Fz6pzq7knQkUS0NTDAkrTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d34bvc7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90536C116B1;
	Thu, 25 Jul 2024 21:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721942323;
	bh=/AAXREcOI32vQxwZurvxUKNxXBgKObFukzNWPPKPbQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d34bvc7r+wjZ8jdKwdacrvuz2jNHK9IOxnKkWsYdF3d7Kb1QRX/i09je4/70KecOu
	 sq4c3XMfDYrrM6gRkarGgDjwd9B8L/IhQcFUOWkFlWnCk6m+7PVgQtSjs1xDrpxszF
	 0pNPN3nN9fBkverGNrd65UvRMQJrAbBzFYQS/9Z1OHWG+NXxbsCzZxh7Xr45KU8feR
	 vjWWNmIqcZ+G+uhBvxyNd/aaJxeGTkcEGNqK+7mVXTDPi+G5zaR2TjaVXvjxGEPi5F
	 Ov9azfqw5jbEmI8Gnz+QJX1688MISdTSleTRc+jPmFbxIlOZfqVj85dB0HYdIksD2l
	 jlTy9vFQK92cw==
Date: Thu, 25 Jul 2024 16:18:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH 3/3] PCI: j721e: Add support for enabling ACSPCIE PAD IO
 Buffer output
Message-ID: <20240725211841.GA859405@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715120936.1150314-4-s-vadapalli@ti.com>

On Mon, Jul 15, 2024 at 05:39:36PM +0530, Siddharth Vadapalli wrote:
> The ACSPCIE module is capable of driving the reference clock required by
> the PCIe Endpoint device. It is an alternative to on-board and external
> reference clock generators. Enabling the output from the ACSPCIE module's
> PAD IO Buffers requires clearing the "PAD IO disable" bits of the
> ACSPCIE_PROXY_CTRL register in the CTRL_MMR register space.

And I guess this patch actually *does* enable the ACSPCIE PAD IO
Buffer output?

This commit log tells me what is *required* to enable the output, but
it doesn't actually say whether the patch *does* enable the output.

Similarly, if this patch enables ACSPCIE PAD IO Buffer output, I would
make the subject be:

  PCI: j721e: Enable ACSPCIE Refclk output when DT property is present

> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 85718246016b..2fa0eff68a8a 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -44,6 +44,7 @@ enum link_status {
>  #define J721E_MODE_RC			BIT(7)
>  #define LANE_COUNT(n)			((n) << 8)
>  
> +#define ACSPCIE_PAD_ENABLE_MASK		GENMASK(1, 0)
>  #define GENERATION_SEL_MASK		GENMASK(1, 0)
>  
>  struct j721e_pcie {
> @@ -220,6 +221,30 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
>  	return ret;
>  }
>  
> +static int j721e_acspcie_pad_enable(struct j721e_pcie *pcie, struct regmap *syscon)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	struct device_node *node = dev->of_node;
> +	u32 mask = ACSPCIE_PAD_ENABLE_MASK;
> +	struct of_phandle_args args;
> +	u32 val;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-acspcie-proxy-ctrl",
> +					       1, 0, &args);
> +	if (!ret) {
> +		/* PAD Enable Bits have to be cleared to in order to enable output */

Most of this file fits in 80 columns (printf strings are an exception
so they're easier to find with grep).  It'd be nice if your new code
and comments fit in 80 columns as well.

An easy fix for the comment would be:

  /* Clear PAD Enable bits to enable output */

Although it sounds non-sensical to *clear* enable bits to enable
something, and the commit log talks about clearing PAD IO *disable*
bits, so maybe you meant this instead?

  /* Clear PAD IO disable bits to enable output */

If the logical operation here is to enable driving Refclk, I think the
function name and error messages might be more informative if they
mentioned "refclk" instead of "PAD".

> +		val = ~(args.args[0]);
> +		ret = regmap_update_bits(syscon, 0, mask, val);
> +		if (ret)
> +			dev_err(dev, "Enabling ACSPCIE PAD output failed: %d\n", ret);
> +	} else {
> +		dev_err(dev, "ti,syscon-acspcie-proxy-ctrl has invalid parameters\n");
> +	}
> +
> +	return ret;
> +}
> +
>  static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>  {
>  	struct device *dev = pcie->cdns_pcie->dev;
> @@ -259,6 +284,14 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>  		return ret;
>  	}
>  
> +	/* Enable ACSPCIe PAD IO Buffers if the optional property exists */

Is the canonical name "ACSPCIE" or "ACSPCIe"?  You used "ACSPCIE"
above?

> +	syscon = syscon_regmap_lookup_by_phandle_optional(node, "ti,syscon-acspcie-proxy-ctrl");
> +	if (syscon) {
> +		ret = j721e_acspcie_pad_enable(pcie, syscon);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.40.1
> 

