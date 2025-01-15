Return-Path: <linux-pci+bounces-19929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1EA12EF8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 00:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA061886AFA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF61DD9AB;
	Wed, 15 Jan 2025 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndMSRS4a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20D1DD9A6;
	Wed, 15 Jan 2025 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982272; cv=none; b=gqKzne3WTxVui4vOU0LgUtxG1uYQY9HMJUP8GXqjCi0C3ddg9AAXv502zB7tBXPinfw2yaB6fhdNHZDH54nl7cTXIRywC2aemj2hu35yapSlrGLHf76AGVAF8Grygsim/VKoREvlo+RDygXW4jAmDQpkbO/Du+LLGWqhIVlOQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982272; c=relaxed/simple;
	bh=wXuBoyyk9ETcMFkcjs1CAzvucCe5P+ktEzNq56RKFKc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=No/NU1gruIXVQkKC8VFhv5m1hLXq0OyIZEGJJL0hUWEUhshUrhtozO8nGunHLoFCE70WzaF9sYC1NxP4AMwBl7wNT24vyXCkIVvLJvzY8ly2HxRkRGh5GbgXlx5xOjyCNdLls+J1zADsbV6Pmz6EhlV3no+nA00jC/nAzN2k+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndMSRS4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EF6C4CED1;
	Wed, 15 Jan 2025 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736982272;
	bh=wXuBoyyk9ETcMFkcjs1CAzvucCe5P+ktEzNq56RKFKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ndMSRS4aPOQkcBRM8NZ8koAU62dLa6PMuBifPbWPnqACBtNUs7AkyKfx3Ng/ZaVHa
	 b/TPH3VpMkqnRFVnjBO9OfxflS9K7ZA9gYYrMy8V0YbO4mTbrf6x8whUPSok08TE64
	 E1qG2kySB8p3WLmzqXPakm9gS4SF6cI3x1FRKAxd4z6ovPSwnsh1ZHoTo2Kw67J/U9
	 UWHXiZBMXR/buiJsuaNEWw3/vRb/KFCKk/XbzAMDL3YN4eFDGZTYjPP8pdAahioTw1
	 8KzQdBlCVlpgm83ybNQPfdNWrjE147p9LYRlSPmZXEa3pKZsjTq74/r3ZYZfZJgSJ6
	 4e3/DcgTV8OkQ==
Date: Wed, 15 Jan 2025 17:04:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: dwc: dra7xx: Use
 syscon_regmap_lookup_by_phandle_args
Message-ID: <20250115230430.GA560547@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112-syscon-phandle-args-pci-v1-1-fcb6ebcc0afc@linaro.org>

On Sun, Jan 12, 2025 at 02:39:02PM +0100, Krzysztof Kozlowski wrote:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
> 
> There is also no real benefit in printing errors on missing syscon
> argument, because this is done just too late: runtime check on
> static/build-time data.  Dtschema and Devicetree bindings offer the
> static/build-time check for this already.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 5c62e1a3ba52919afe96fbcbc6edaf70775a69cb..33d6bf460ffe5bb724a061558dd93ec7bdadc336 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -635,30 +635,20 @@ static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
>  {
>  	int ret;
>  	struct device_node *np = dev->of_node;
> -	struct of_phandle_args args;
> +	unsigned int args[2];
>  	struct regmap *regmap;
>  
> -	regmap = syscon_regmap_lookup_by_phandle(np,
> -						 "ti,syscon-unaligned-access");
> +	regmap = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-unaligned-access",
> +						      2, args);
>  	if (IS_ERR(regmap)) {
>  		dev_dbg(dev, "can't get ti,syscon-unaligned-access\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-unaligned-access",
> -					       2, 0, &args);
> -	if (ret) {
> -		dev_err(dev, "failed to parse ti,syscon-unaligned-access\n");
> -		return ret;
> -	}
> -
> -	ret = regmap_update_bits(regmap, args.args[0], args.args[1],
> -				 args.args[1]);
> +	ret = regmap_update_bits(regmap, args[0], args[1], args[1]);
>  	if (ret)
>  		dev_err(dev, "failed to enable unaligned access\n");
>  
> -	of_node_put(args.np);
> -
>  	return ret;
>  }
>  
> @@ -671,18 +661,13 @@ static int dra7xx_pcie_configure_two_lane(struct device *dev,
>  	u32 mask;
>  	u32 val;
>  
> -	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-lane-sel");
> +	pcie_syscon = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-lane-sel",
> +							   1, &pcie_reg);
>  	if (IS_ERR(pcie_syscon)) {
>  		dev_err(dev, "unable to get ti,syscon-lane-sel\n");
>  		return -EINVAL;
>  	}
>  
> -	if (of_property_read_u32_index(np, "ti,syscon-lane-sel", 1,
> -				       &pcie_reg)) {
> -		dev_err(dev, "couldn't get lane selection reg offset\n");
> -		return -EINVAL;
> -	}

Wow.  I believe you that syscon_regmap_lookup_by_phandle_args() is
equivalent to both:

  - syscon_regmap_lookup_by_phandle() followed by
    of_parse_phandle_with_fixed_args(), and

  - syscon_regmap_lookup_by_phandle() followed by
    of_property_read_u32_index()

but I can't say it's obvious to this syscon- and OF-naive reviewer,
even after tracing a few layers in :)

Bjorn

