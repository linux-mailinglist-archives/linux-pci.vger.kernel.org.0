Return-Path: <linux-pci+bounces-13532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8053E986AEB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 04:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6EA1F22444
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5FB17278D;
	Thu, 26 Sep 2024 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frspAm7M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FC4120B;
	Thu, 26 Sep 2024 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317571; cv=none; b=lrImTJFX0LSAqMrP/SZiw+DgGHEeUQ2N6O062xkEIITIy0XddM070JnM0tC008rgvgx1FraN5e8pr41FZO0T2zD8OcyWM3FmtG1fKdnNd91f44lC0MTjborf7lghHU6sriWZE/iCDvkaI15e4Kk0kXHSf9h6N39J7Wy6TlnNZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317571; c=relaxed/simple;
	bh=r5SI/RGSLPfnaDMdwQYTrj8PSSmy7YhHEr12h+MWAoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErIX4u2w441C2HnnDbkDM8rcwMHzvFZkmxELVoZjIaja3yg161gdro4ZNgeY99FoQz17tbNqazM656aZYj74WaaR0dDbDh+DDAQQK8mcbuAYWKdRoYi08HDWcpwMca/D+CPyN1BXP0pswE+Mb4i3UZRl2sF7aMr9ybHfDKVDup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frspAm7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC0DC4CEC3;
	Thu, 26 Sep 2024 02:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727317571;
	bh=r5SI/RGSLPfnaDMdwQYTrj8PSSmy7YhHEr12h+MWAoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frspAm7Mpmz1+1OkPVLEAsL/gO4dAcKalYn1V+qRG5s5F3chfbXw4j8c86lSDF7ET
	 d/LSuEOFje85dlrho0oNDIstDd2/Hy/jE9fbpWKuAL1ZHF2NOYW3xVBxKzUXF76yMl
	 8tq2l8F3N7DWB3v6o3hb3qyAwniLvGQ2rh0noD3xOZMwmafcSQTn1y/DT0vRzhGVtd
	 IfCn5dtDczmE6EY29yFIR1sxBmzPpUkM1XsBSGJpt1CT7herFW1ys9l6DNw/eMyskH
	 3GSK7M+nCmklE5AvkTdHIkppb+alBO4lhyfFpx58LHfbWTwpzYGx2Y4hksLE8a+rpu
	 MAHrsHi+GBxSw==
Date: Wed, 25 Sep 2024 21:26:10 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/3] of: address: Add helper function to get untranslated
 'ranges' information
Message-ID: <20240926022610.GA2360654-robh@kernel.org>
References: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
 <20240924-pci_fixup_addr-v1-1-57d14a91ec4f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924-pci_fixup_addr-v1-1-57d14a91ec4f@nxp.com>

On Tue, Sep 24, 2024 at 05:54:19PM -0400, Frank Li wrote:
> Introduce `for_each_of_range_untranslate()` to retrieve untranslated CPU
> address information, similar to `of_property_read_reg()`. This is required
> for hardware like i.MX8QXP to configure the PCIe controller ATU and
> eliminate the need for workaround address fixups in drivers. Currently,
> many drivers use hardcoded CPU addresses for fixups, but this information
> is already described in the Device Tree. With correct hardware
> descriptions, such fixups can be removed.

Just to be clear, you don't have to change the DT to add the 
intermediate bus? If you do, then that's an ABI issue.

> 
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
>  │ CPU ├───►│ BUS     ├─────────────────┐  │ PCI        │
>  └─────┘    │         │ IA: 0x8ff8_0000 │  │            │
>   CPU Addr  │ Fabric  ├─────────────┐   │  │ Controller │
> 0x7000_0000 │         │             │   │  │            │
>             │         │             │   │  │            │   PCI Addr
>             │         │             │   └──► CfgSpace  ─┼────────────►
>             │         ├─────────┐   │      │            │    0
>             │         │         │   │      │            │
>             └─────────┘         │   └──────► IOSpace   ─┼────────────►
>                                 │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
> 
> bus@5f000000 {
>         compatible = "simple-bus";
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
>                  <0x80000000 0x0 0x70000000 0x10000000>;
> 
>         pcieb: pcie@5f010000 {
>                 compatible = "fsl,imx8q-pcie";
>                 reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
>                 reg-names = "dbi", "config";
>                 #address-cells = <3>;
>                 #size-cells = <2>;
>                 device_type = "pci";
>                 bus-range = <0x00 0xff>;
>                 ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
>                          <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> 	...
> 	};
> };
> 
> Currently all function related 'range' return CPU address. THe new help
> function for_each_of_range_untranslate() can get above diagram IA address
> informaiton.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/of/address.c       | 33 +++++++++++++++++++++++----------
>  include/linux/of_address.h |  9 ++++++++-
>  2 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 286f0c161e332..09c73936e573f 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -787,8 +787,9 @@ int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
>  EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
>  #define of_dma_range_parser_init of_pci_dma_range_parser_init
>  
> -struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> -						struct of_pci_range *range)
> +struct of_pci_range *of_pci_range_parser_one_common(struct of_pci_range_parser *parser,
> +						    struct of_pci_range *range,
> +						    bool translate)
>  {
>  	int na = parser->na;
>  	int ns = parser->ns;
> @@ -806,11 +807,13 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  	range->bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
>  
>  	if (parser->dma)
> -		range->cpu_addr = of_translate_dma_address(parser->node,
> -				parser->range + na);
> +		range->cpu_addr = translate ? of_translate_dma_address(parser->node,
> +						parser->range + na) :
> +					      of_read_number(parser->range + na, parser->pna);
>  	else
> -		range->cpu_addr = of_translate_address(parser->node,
> -				parser->range + na);
> +		range->cpu_addr = translate ? of_translate_address(parser->node,
> +						parser->range + na) :
> +					      of_read_number(parser->range + na, parser->pna);
>  	range->size = of_read_number(parser->range + parser->pna + na, ns);
>  
>  	parser->range += np;
> @@ -823,11 +826,13 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  		flags = parser->bus->get_flags(parser->range);
>  		bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
>  		if (parser->dma)
> -			cpu_addr = of_translate_dma_address(parser->node,
> -					parser->range + na);
> +			cpu_addr = translate ? of_translate_dma_address(parser->node,
> +						parser->range + na) :
> +					       of_read_number(parser->range + np, np);
>  		else
> -			cpu_addr = of_translate_address(parser->node,
> -					parser->range + na);
> +			cpu_addr = translate ? of_translate_address(parser->node,
> +						parser->range + na) :
> +					       of_read_number(parser->range + np, np);
>  		size = of_read_number(parser->range + parser->pna + na, ns);
>  
>  		if (flags != range->flags)
> @@ -842,6 +847,14 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  
>  	return range;
>  }
> +EXPORT_SYMBOL_GPL(of_pci_range_parser_one_common);
> +
> +struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> +					     struct of_pci_range *range)
> +{
> +	return of_pci_range_parser_one_common(parser, range, true);
> +}
> +
>  EXPORT_SYMBOL_GPL(of_pci_range_parser_one);
>  
>  static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 26a19daf0d092..692aae853217a 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -32,8 +32,11 @@ struct of_pci_range {
>  #define of_range of_pci_range
>  
>  #define for_each_of_pci_range(parser, range) \
> -	for (; of_pci_range_parser_one(parser, range);)
> +	for (; of_pci_range_parser_one_common(parser, range, true);)
> +#define for_each_of_pci_range_untranslate(parser, range) \
> +	for (; of_pci_range_parser_one_common(parser, range, false);)
>  #define for_each_of_range for_each_of_pci_range
> +#define for_each_of_range_untranslate for_each_of_pci_range_untranslate

You may want both the translated and untranslated address, so I would 
just add the untranslated address to the of_pci_range struct and return 
both with the existing iterator.

Rob

