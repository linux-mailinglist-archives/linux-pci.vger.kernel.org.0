Return-Path: <linux-pci+bounces-13611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC9988C5C
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 00:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D3C1F21631
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 22:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFFD186E58;
	Fri, 27 Sep 2024 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBuUlxYX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAD1F931;
	Fri, 27 Sep 2024 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727475513; cv=none; b=pXi2HRfRU9896YkmYdwhCrulOXj7IBdg3C1QLuRX08n4U3c1n2CaXsYcEdHyno62DH/YA4wHilyiOZAoCk6ZKSfOCGNRQbwRBsfbaBXggV7hxJX3U9YhiYunKCKVZsoGIpp/3+HiXfUZKx051HM3sD1vkD/H7ia/g2KnsKiU5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727475513; c=relaxed/simple;
	bh=uMyaYEJZLNU05MeCrzdMNUO+M6h8+Xyzu3+DEW7cg3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFqltkHKjN/SJW6h0LkFnbBKwlNnIEEIqRbWzte0gUecycXSFRPvMkUlXEgUdQJgzD1SQo0A/GRQk8D8JJFL28GJK6TcTpFo0/Wu89aaOHc3zw/TJLv9prsQ0zLe9+CfBQ/ycQ6f9sbFg+3uQD90zGBKQO9CRzW/YjFilFNhs0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBuUlxYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B877DC4CECE;
	Fri, 27 Sep 2024 22:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727475512;
	bh=uMyaYEJZLNU05MeCrzdMNUO+M6h8+Xyzu3+DEW7cg3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBuUlxYXZsaFExSeyCRZG5b0/ei0hlt3jEIT0C1TrYuEoMPsm7OiKpm//pariQSyk
	 jipNJSO8TttPNtfpe9QGtBVyt9r77r1913wHJDCozoYCkAmum9FHwy641jCF3RN0Dc
	 rPYLCKyIE6GEi+mPqagxla73qKcqreJ8C2rDviOGATXcClVg9BK0knm8ojIKbUDCoK
	 BoTK+wTaPcxjaRU1ib8WXwLpcTPQ+f7YM8kPnn9lgk+pooqJVbXyXUwwt39lzfEXbS
	 QpFPz/RcMZsIrQ7dqV2xHv0JBQwKYDJ2/0TGPDwmbAzbAwPhyZeY5zIXln317pntx7
	 aPt9tHrpnYS0Q==
Date: Fri, 27 Sep 2024 17:18:31 -0500
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
Subject: Re: [PATCH v2 1/3] of: address: Add cpu_untranslate_addr to struct
 of_pci_range
Message-ID: <20240927221831.GA135061-robh@kernel.org>
References: <20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com>
 <20240926-pci_fixup_addr-v2-1-e4524541edf4@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240926-pci_fixup_addr-v2-1-e4524541edf4@nxp.com>

On Thu, Sep 26, 2024 at 12:47:13PM -0400, Frank Li wrote:
> Introduce field 'cpu_untranslate_addr' in of_pci_range to retrieve
> untranslated CPU address information. This is required for hardware like
> i.MX8QXP to configure the PCIe controller ATU and eliminate the need for
> workaround address fixups in drivers. Currently, many drivers use
> hardcoded CPU addresses for fixups, but this information is already
> described in the Device Tree. With correct hardware descriptions, such
> fixups can be removed.
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
> 'cpu_untranslate_addr' in of_pci_range can indicate above diagram IA
> address information.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - add cpu_untranslate_addr in of_pci_range, instead adding new API.
> ---
>  drivers/of/address.c       | 2 ++
>  include/linux/of_address.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 286f0c161e332..f4cb82f5313cf 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  	else
>  		range->cpu_addr = of_translate_address(parser->node,
>  				parser->range + na);
> +
> +	range->cpu_untranslate_addr = of_read_number(parser->range + na, parser->pna);
>  	range->size = of_read_number(parser->range + parser->pna + na, ns);
>  
>  	parser->range += np;
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 26a19daf0d092..0683ce0c07f68 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -26,6 +26,7 @@ struct of_pci_range {
>  		u64 bus_addr;
>  	};
>  	u64 cpu_addr;
> +	u64 cpu_untranslate_addr;

Let's call it "parent_bus_addr" as it's not really the "cpu" address any 
more. With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob

