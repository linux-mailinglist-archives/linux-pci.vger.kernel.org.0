Return-Path: <linux-pci+bounces-15381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748449B1295
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 00:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EB01F2179E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306A1D222F;
	Fri, 25 Oct 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNEiENyR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618D13D8B1;
	Fri, 25 Oct 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895464; cv=none; b=K3Gm4geXsuKhgshTA9DGxRkBk81xqINvEMBdLFP2PgQn5ruMSH32HTpolOqVk/DzhQNjRCxoIym0EFDonWs3EbdThpQXYQvUtalPphWXJapCeXOz+N3WwQxQ1HEN3zccVgUcxIFttoNtr5jwTAwDFpQeuuu+LYzZt2D0kecCK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895464; c=relaxed/simple;
	bh=e9UZsK6yoNGuTeM8ImClDT58R9Ad0kplRUUu9ysuAJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UbiI5Fjx7G2F/KVR4ltUo9+wDYwvlncDzmf+YnK7TdAVEnU75pLhi/8p+i5vtyfh6GMkd/iFA4dlw4BbWEM7C/zaM4530H+Z7rp5Jlw56PcVooIg+s7u592DGLLtbeYvVsHfwX9JTmRU2y1iGGAAFokwkRYjz+X/hafq2S/oLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNEiENyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3ABC4CEC3;
	Fri, 25 Oct 2024 22:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729895464;
	bh=e9UZsK6yoNGuTeM8ImClDT58R9Ad0kplRUUu9ysuAJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qNEiENyRow1zkUKlGDesaiB2BCDUXVV6QJFBiRhrK7QwB0dqBCWzpQL/G16crJrxq
	 tkqmEXINJDcVW98hnnk+gLaDxetCPb+SQ4ZJ7t+M9TCrQ1pvW+RjLNubTFBZiKFHOL
	 fKQNw25C8RCDbkbrZHdtoEIvm2k+/+TQHc/ycYL02WXA0Q95ue85LBZMUAOXG6U4z6
	 1Y1hes/gexQjwToENV6Z+FrqU7R0uT/SibpnwW+hs+ZrScxYYchmZxsOcIi4N73+yX
	 L/EV16/tyiKqhBkQCgCbLH8s9E6CgwB8nUTl22CYjCb0EvGC6OVUT7pP3Y7QBM0jPG
	 vOe8MRT+27rtg==
Date: Fri, 25 Oct 2024 17:31:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v4 1/4] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <20241025223102.GA1029107@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024-pcie_ep_range-v4-1-08f8dcd4e481@nxp.com>

On Thu, Oct 24, 2024 at 04:41:43PM -0400, Frank Li wrote:
>                                Endpoint          Root complex
>                              ┌───────┐        ┌─────────┐
>                ┌─────┐       │ EP    │        │         │      ┌─────┐
>                │     │       │ Ctrl  │        │         │      │ CPU │
>                │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
>                │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
>                │     │       │       │        │ └────┘  │ Outbound Transfer
>                └─────┘       │       │        │         │
>                              │       │        │         │
>                              │       │        │         │
>                              │       │        │         │ Inbound Transfer
>                              │       │        │         │      ┌──▼──┐
>               ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
>               │       │ outbound Transfer*    │ │       │      └─────┘
>    ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
>    │     │    │ Fabric│Bus   │       │ PCI Addr         │
>    │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
>    │     │CPU │       │0x8000_0000   │        │         │
>    └─────┘Addr└───────┘      │       │        │         │
>           0x7000_0000        └───────┘        └─────────┘
> 
> Add `bus_addr_base` to configure the outbound window address for CPU write.
> The bus fabric generally passes the same address to the PCIe EP controller,
> but some bus fabrics convert the address before sending it to the PCIe EP
> controller.
> 
> Above diagram, CPU write data to outbound windows address 0x7000_0000,
> Bus fabric convert it to 0x8000_0000. ATU should use bus address
> 0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Thanks for the diagram and description.  I don't think the top half is
relevant to *this* patch, is it?  I think this patch is only concerned
with the address translations between the CPU in the endpoint and the
PCI bus address.  In this case it happens in two steps: the bus fabric
applies one offset, and the ATU applies a second offset.

Unless the top half is relevant, I would omit it and simply use
something like this:

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

If you don't want a big "Endpoint" box including the CPU and bus
fabric, that's OK with me, too.  I added it because everything on the
PCI side only sees TLPs that contain PCI bus addresses, and can't tell
anything about the internal implementation of the Endpoint.

> Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> the device tree provides this information, preferring a common method.
> 
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
> 	pcie-ep@5f010000 {
> 		reg = <0x5f010000 0x00010000>,
> 		      <0x80000000 0x10000000>;
> 		reg-names = "dbi", "addr_space";
> 		...
> 	};
> 	...
> };

I guess bus@5f000000 includes a "ranges" property because that
translation from 0x7000_0000 -> 0x8000_0000 is fixed or at least
not touched by Linux?

And the pcie-ep@5f010000 address translation from 0x8000_0000 to
0xA000_0000 *is* programmed by Linux and therefore can't be described
by a DT?  But I guess Linux only programs the *PCI* side, and the
parent side (0x8000_0000) is fixed?

AFAICT, the "reg = <0x5f010000 0x00010000>" part is not relevant here.

I guess this implementation assumes there's only a single aperture
through the Bus Fabric, right?

And also a single ATU aperture through the endpoint PCIe controller?

And also that there's only one layer of Bus Fabric address
translation?  The fact that only a few DWC controllers have this
translation suggests that this part of the picture might be external
to the DWC IP and there could be more variation.  But I guess there's
no point in adding code for topologies that don't exist; we can deal
with that if the need ever arises.

> 'ranges' in bus@5f000000 descript how address convert from CPU address
> to bus address.
> 
> Use `of_property_read_reg()` to obtain the bus address and set it to the
> ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> 
> Add 'using_dtbus_info' to indicate device tree reflect correctly bus
> address translation in case break compatibility.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - change bus_addr_base to u64 to fix 32bit build error
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/
> 
> Change from v2 to v3
> - Add using_dtbus_info to control if use device tree bus ranges
> information.
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 14 +++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h    |  9 +++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 43ba5c6738df1..81b4057befa62 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -9,6 +9,7 @@
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  
>  #include "pcie-designware.h"
> @@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  
>  	atu.func_no = func_no;
>  	atu.type = PCIE_ATU_TYPE_MEM;
> -	atu.cpu_addr = addr;
> +	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;

Tangent: Maybe dw_pcie_ob_atu_cfg.cpu_addr isn't exactly the right
name, since it now contains an address that is not a CPU physical
address.  Not a question for *this* patch though.

>  	atu.pci_addr = pci_addr;
>  	atu.size = size;
>  	ret = dw_pcie_ep_outbound_atu(ep, &atu);
> @@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct device *dev = pci->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
> +	int index;
>  
>  	INIT_LIST_HEAD(&ep->func_list);
>  
> @@ -873,6 +875,16 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -EINVAL;
>  
>  	ep->phys_base = res->start;
> +	ep->bus_addr_base = ep->phys_base;
> +
> +	if (pci->using_dtbus_info) {
> +		index = of_property_match_string(np, "reg-names", "addr_space");
> +		if (index < 0)
> +			return -EINVAL;
> +
> +		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
> +	}

If this translation were fixed, I suppose we'd extract something from
a "ranges" property that contains (child-bus-address,
parent-bus-address) information.  So I suppose "addr_space" contains a
fixed parent-bus-address, and is setting the child (PCI) bus address,
right?

If so, I might add a comment here for other readers who come this way.
(And me, because I won't remember the next time I read it :)

>  	ep->addr_size = resource_size(res);
>  
>  	if (ep->ops->pre_init)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35aa..f10b533b04f77 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -410,6 +410,7 @@ struct dw_pcie_ep {
>  	struct list_head	func_list;
>  	const struct dw_pcie_ep_ops *ops;
>  	phys_addr_t		phys_base;
> +	u64			bus_addr_base;
>  	size_t			addr_size;
>  	size_t			page_size;
>  	u8			bar_to_atu[PCI_STD_NUM_BARS];
> @@ -463,6 +464,14 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	/*
> +	 * Use device tree 'ranges' property of bus node instead using
> +	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
> +	 * reflect real hardware's behavior. In case break these platform back
> +	 * compatibility, add below flags. Set it true if dts already correct
> +	 * indicate bus fabric address convert.
> +	 */
> +	bool			using_dtbus_info;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> 
> -- 
> 2.34.1
> 

