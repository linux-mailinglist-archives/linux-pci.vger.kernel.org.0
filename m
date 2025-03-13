Return-Path: <linux-pci+bounces-23692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63470A603E0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 23:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89623B9AA8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 22:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920881F4E54;
	Thu, 13 Mar 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzLWuZS7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC011F461C;
	Thu, 13 Mar 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903492; cv=none; b=XTrTlknLqMPYaRGN6jRD8taMd8tLSShEIqIA/FICip0ro87qIplv8YKzxXYg0Qi4iytr4JSj/iU71hSef3hWNoDevsRrG/kXhxBjv7L6LzbWrMF32uax1kGJRmr9v6pZaDSBZiRNXwSb3DuEqz0djrbppxgTE7pCrlO/uZyh6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903492; c=relaxed/simple;
	bh=n/fMIbk7/ofFY+LwCDcEeg0lmVjyMvGkhfy6qwppqPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nFjqgW2j9/HjifNGuaO7mtbrEEfdbEyeuxcNFh8vFsPJEGf4OOXpbJTt6Vb1JPC+KTsaHOuE1u8/lmz8eP1pY0N/W/WEobr+AEobZ1E6UUAfw2caBwINzr64kPR59gJ2bdpbfh1hVaJZcP1ud7tXA2+C5GUhuXEwh+rQyd9O9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzLWuZS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A65BC4CEDD;
	Thu, 13 Mar 2025 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741903491;
	bh=n/fMIbk7/ofFY+LwCDcEeg0lmVjyMvGkhfy6qwppqPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NzLWuZS7oIEAF19Ms/byzIr0r2Ey7Lqizbb3ASZ+H1G9aXXx/e75fXptCLMSETOVw
	 vtUmM4AX43OxHsDLoq+qQVhRpCtEYqZ0RgTqD7UJSMjj24dXdFWDcHHBhD7LmQzeLr
	 Rw49mqMJwmmIc8ZtfEsoOaaYq42olzBPJwz1QtZkq41oy/BT8iSQSd+ZY7DCIVXf3o
	 Lc3sb8HLCcKPYECFF3uBgiGmZuDrqMEhwypWWXSe2UtoKNw/jk355vXyN2Z4VxYcLA
	 1PHzCr17ZO2bebssWu/3IwjJoDqv4hmbK+o/KTzvXoXYxu96YLKYPs8wPCrulmHj5G
	 AkyFkXg62gydw==
Date: Thu, 13 Mar 2025 17:04:50 -0500
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 06/11] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Message-ID: <20250313220450.GA755590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-pci_fixup_addr-v11-6-01d2313502ab@nxp.com>

On Thu, Mar 13, 2025 at 11:38:42AM -0400, Frank Li wrote:
> The 'ranges' property at PCI controller parent bus can indicate address
> translation information. Most system's bus fabric use 1:1 map between input
> and output address. but some hardware like i.MX8QXP doesn't use 1:1 map.

I think you've used reg["addr_space"] to get the offset for Endpoints
forever.

I just noticed that through v9, you used 'ranges' to get the offset
for the Root Complex (with "Add parent_bus_offset to resource_entry"),
and I think v10 switched to use reg["config"] instead.

I think I originally proposed the idea of "Add parent_bus_offset to
resource_entry" patch, but I think it turned out to be kind of an ugly
approach.

Anyway, IIUC this v11 patch actually uses reg["config"] to compute the
offset, not 'ranges', so we should probably update the subject and
commit log to reflect that, and maybe remove the now-unused bits of
the devicetree example.

I do worry a little bit about the assumption that the offset of
reg["config"] is the same as the offset of the other pieces.  The main
place we use the offset on RCs is for the ATU, and isn't the ATU in
the MemSpace area at 0x8000_0000 below?

It's great that in this case the 0x7ff0_0000 to 0x8ff0_0000 "config"
offset is the same as the 0x7000_0000 to 0x8000_0000 MemSpace offset,
but I don't know that this is guaranteed for all designs.

v9:
  [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
    https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com
  [PATCH v9 5/7] PCI: dwc: ep: Add parent_bus_addr for outbound window
    https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-5-3c4bb506f665@nxp.com

v10:
  [PATCH v10 05/10] PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback
    https://lore.kernel.org/r/20250310-pci_fixup_addr-v10-5-409dafc950d1@nxp.com
  [PATCH v10 06/10] PCI: dwc: ep: Add parent_bus_addr for outbound window
    https://lore.kernel.org/r/20250310-pci_fixup_addr-v10-6-409dafc950d1@nxp.com

> See below diagram:
> 
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff8_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
> 
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
> 	pcie@5f010000 {
> 		compatible = "fsl,imx8q-pcie";
> 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> 		reg-names = "dbi", "config";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		device_type = "pci";
> 		bus-range = <0x00 0xff>;
> 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> 	...
> 	};
> };
> 
> Term Intermediate address (IA) here means the address just before PCIe
> controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> be removed.
> 
> Use reg-name "config" to detect parent_bus_addr_offset. Suppose the offset
> is the same for all kinds of address translation.
> 
> Just set parent_bus_offset, but doesn't use it, so no functional change
> intended yet.

> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -474,6 +474,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->io_base = pci_pio_to_address(win->res->start);
>  	}
>  
> +	/*
> +	 * visconti_pcie_cpu_addr_fixup() use pp->io_base,
> +	 * so have to call dw_pcie_init_parent_bus_offset() after init
> +	 * pp->io_base.
> +	 */
> +	ret = dw_pcie_init_parent_bus_offset(pci, "config", pp->cfg0_base);
> +	if (ret)
> +		return ret;
> +
>  	/* Set default bus ops */
>  	bridge->ops = &dw_pcie_ops;
>  	bridge->child_ops = &dw_child_pcie_ops;
> 
> -- 
> 2.34.1
> 

