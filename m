Return-Path: <linux-pci+bounces-12389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C719633BD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2F11C2178F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC11AD3FB;
	Wed, 28 Aug 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVFp21+B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0C1AD3F2;
	Wed, 28 Aug 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879950; cv=none; b=YOoKS1RbMvmO9PP1j51+m6S2CKyd4boHnFkP8WE22lDmW2MdBOFwWaLjk9ITOkCZBYiTLR9UdJTprjayt+SFaa2eNCMR+fLmpTHoE/hPbIunAif3ekVLamR9vWHP9+272YLsYJ6YIcNxVrsDcLXm29/hIAT/vGfrdx4dQpmt8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879950; c=relaxed/simple;
	bh=49PHB8qyunhNwkqPu8maqVRtY1UPnUcFp4zqIf0kXcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uueqbK8OjbdiMtBr7cjiijbBaieYKm86fK4RL5xs11C+7V8tI14dxrvFZ+ZGNhTosyI4hsLlnODXZu7Vo4XB7cQusiqd8loXRPdJirxgJlu1e4gnkq64HPna4PHGGOd1BThu8qssFznKAO9NK9FayNpiQ3PL95zoRao1sCo4wo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVFp21+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E37C4CEC3;
	Wed, 28 Aug 2024 21:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724879949;
	bh=49PHB8qyunhNwkqPu8maqVRtY1UPnUcFp4zqIf0kXcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pVFp21+BRU63IIpfRMbslg+8XpR0EjCfJpCQik0ChLei1TqYjx+Huu9B+GgR30ELW
	 FDqVR2GpORk5bS++6AD4hEBeA14/Br+lrgnv7rfsp2HnPJcxwG+sJmd2mhWEHjFWtd
	 e8h38p7fw54LCX1XFpK/lzWHBTCTzw1jr46hC21QyuasPUC50Xq2F5jDXbGh1bqnQL
	 S8/NSn1O2jHXHY0mUd+cD8vX2tauqBnjYQQIVaD0Wv11BQnJ2ygq7UlIj9e+zdI3sw
	 tWjZB3RwR7tOTO+LYTqQNBDxpUUbCK3FbBguUI/FPvFN3a/RSMMIigUe8Xxq8AaYvT
	 E76oUpgeyQPoQ==
Date: Wed, 28 Aug 2024 16:19:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vigneshr@ti.com,
	kishon@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3 2/2] PCI: j721e: Enable ACSPCIE Refclk if
 "ti,syscon-acspcie-proxy-ctrl" exists
Message-ID: <20240828211906.GA38267@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827055548.901285-3-s-vadapalli@ti.com>

On Tue, Aug 27, 2024 at 11:25:48AM +0530, Siddharth Vadapalli wrote:
> The ACSPCIE module is capable of driving the reference clock required by
> the PCIe Endpoint device. It is an alternative to on-board and external
> reference clock generators. Enabling the output from the ACSPCIE module's
> PAD IO Buffers requires clearing the "PAD IO disable" bits of the
> ACSPCIE_PROXY_CTRL register in the CTRL_MMR register space.
> 
> Add support to enable the ACSPCIE reference clock output using the optional
> device-tree property "ti,syscon-acspcie-proxy-ctrl".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> v2:
> https://lore.kernel.org/r/20240729092855.1945700-3-s-vadapalli@ti.com/
> Changes since v2:
> - Rebased patch on next-20240826.
> 
> v1:
> https://lore.kernel.org/r/20240715120936.1150314-4-s-vadapalli@ti.com/
> Changes since v1:
> - Addressed Bjorn's feedback at:
>   https://lore.kernel.org/r/20240725211841.GA859405@bhelgaas/
>   with the following changes:
>   1) Updated $subject and commit message to indicate that this patch
>   enables ACSPCIE reference clock output if the DT property is present.
>   2) Updated macro and comments to indicate that the BITS correspond to
>   disabling ACSPCIE output, due to which clearing them enables the
>   reference clock output.
>   3) Replaced "PAD" with "refclk" both in the function name and in the
>   error prints.
>   4) Wrapped lines to be within the 80 character limit to match the rest
>   of the driver.
> 
>  drivers/pci/controller/cadence/pci-j721e.c | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 85718246016b..ed42b2229483 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -44,6 +44,7 @@ enum link_status {
>  #define J721E_MODE_RC			BIT(7)
>  #define LANE_COUNT(n)			((n) << 8)
>  
> +#define ACSPCIE_PAD_DISABLE_MASK	GENMASK(1, 0)
>  #define GENERATION_SEL_MASK		GENMASK(1, 0)
>  
>  struct j721e_pcie {
> @@ -220,6 +221,34 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
>  	return ret;
>  }
>  
> +static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
> +				       struct regmap *syscon)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	struct device_node *node = dev->of_node;
> +	u32 mask = ACSPCIE_PAD_DISABLE_MASK;
> +	struct of_phandle_args args;
> +	u32 val;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_fixed_args(node,
> +					       "ti,syscon-acspcie-proxy-ctrl",
> +					       1, 0, &args);
> +	if (!ret) {
> +		/* Clear PAD IO disable bits to enable refclk output */
> +		val = ~(args.args[0]);
> +		ret = regmap_update_bits(syscon, 0, mask, val);
> +		if (ret)
> +			dev_err(dev, "failed to enable ACSPCIE refclk: %d\n",
> +				ret);
> +	} else {
> +		dev_err(dev,
> +			"ti,syscon-acspcie-proxy-ctrl has invalid arguments\n");
> +	}

I should have mentioned this the first time, but this would be easier
to read if structured as:

  ret = of_parse_phandle_with_fixed_args(...);
  if (ret) {
    dev_err(...);
    return ret;
  }

  /* Clear PAD IO disable bits to enable refclk output */
  val = ~(args.args[0]);
  ret = regmap_update_bits(syscon, 0, mask, val);
  if (ret) {
    dev_err(...);
    return ret;
  }

  return 0;

> +	return ret;
> +}
> +
>  static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>  {
>  	struct device *dev = pcie->cdns_pcie->dev;
> @@ -259,6 +288,15 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>  		return ret;
>  	}
>  
> +	/* Enable ACSPCIE refclk output if the optional property exists */
> +	syscon = syscon_regmap_lookup_by_phandle_optional(node,
> +						"ti,syscon-acspcie-proxy-ctrl");
> +	if (syscon) {
> +		ret = j721e_enable_acspcie_refclk(pcie, syscon);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;

Not as dramatic here, but I think the following would be a little
simpler since the final "return" isn't used for two purposes
((1) syscon property absent, (2) syscon present and refclk
successfully enabled):

  syscon = syscon_regmap_lookup_by_phandle_optional(...);
  if (!syscon)
    return 0;

  return j721e_enable_acspcie_refclk(...);

>  }
>  
> -- 
> 2.40.1
> 

