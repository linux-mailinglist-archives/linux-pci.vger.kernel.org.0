Return-Path: <linux-pci+bounces-13612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F72988D0E
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 01:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F09D1F21209
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A221898F7;
	Fri, 27 Sep 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrYKABT6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F279443;
	Fri, 27 Sep 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727481080; cv=none; b=MWqTYl6tPpNTAjE6ADC4ePU8j7up3B7891PzsO8TJT8brV3BnB46ED2Op+2IYpDIIuKwGRUzE/efONh6cdLjPmdVbgpD4ah8AEQ8s7SSScUW3qj7buN1EVpQ0ewU4MTe8dfeVU1oKVwQw6dTtSOYcUficBMYx3kPJ/mjFOfDzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727481080; c=relaxed/simple;
	bh=ewY/sv1t7nj53njmVivVzd//BFGp3FOUKqt7Okgo7NI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dGCq6Kt/tbc4JkR0/LN46Q74oDQEvbUgDpFObNfXOMBEMZEXtLaSLz44+ljk8BvIBZkvkEJl2M2btMFSfP4766ETLjWmpoQcwbwPFcYgmQK7PfOxt6wHDknz2lr91hpPoYe8isqCJqwdW2jtzBQi2i9PIZut9/Ty9tvQTtFlzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrYKABT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC6FC4CEC6;
	Fri, 27 Sep 2024 23:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727481079;
	bh=ewY/sv1t7nj53njmVivVzd//BFGp3FOUKqt7Okgo7NI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YrYKABT6UQnYignz9+180E4GcxNgMeqQQyEgAHmmbf7Bh897jAsp8D8U1v1pYffw9
	 IZ4lRZ2CJyVCSo5WQh3gU6/AGXEEOpZqTTCi7ObWJYdcTqBwL8qD1wRV0f7qh4UGlb
	 EE2TufiS4ABxVmTIQOGY93zl7Mj6eP9O2LL/C1bOos31Fn/K8MgoYrC1G68KyAsi4P
	 N1UbrNlDlEdnf9jAQ738cJGWW0HRi8bIKBWp2hhxeR1sg62oXg8UF+qoP9eWhg4QMD
	 9sADzU5wBKz+MnpBvlaY/39tSvOAol46oIGrtTbjdFKleKOI1Ru8+Px7KgzcCsW+EZ
	 QbEDrCh+r13vg==
Date: Fri, 27 Sep 2024 18:51:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
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
Message-ID: <20240927235117.GA98484@bhelgaas>
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

Instead of saying "required for hardware like i.MX8QXP", can we say
something specific about what this kind of hardware *does* that
requires this?

I *think* the point is that there's some address translation being
done between the primary and secondary sides of some bridge.

I think "many drivers use hardcoded CPU addresses for fixups"
basically means the .cpu_addr_fixup() callback hardcodes that
translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR",
"cpu_addr + BUS_IATU_OFFSET", etc, even though those translations
*should* be described via DT.

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

What does "IA" stand for?

I don't quite understand the mapping done by the "BUS Fabric" block.
It looks like you're saying the CPU Addr 0x7000_0000 is translated to
all three of IA 0x8ff0_0000, IA 0x8ff8_0000, and IA 0x8000_0000, but
that doesn't seem right.

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
>  	u64 size;
>  	u32 flags;
>  };
> 
> -- 
> 2.34.1
> 

