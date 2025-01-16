Return-Path: <linux-pci+bounces-19977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF12A13DB4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05543A2BA1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2D22B5AC;
	Thu, 16 Jan 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghZsGw/a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782537082B;
	Thu, 16 Jan 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041562; cv=none; b=TjkRjBcVwkEKyxYJ6Dn8zIgyOP7aLcZP/GBcTB7ueMzCihE8jOnRpUAUZ4W8Zk/myrkEy3B2NXIn8T8OwUggl7awparYXNt8fXmPTiy8Qe/ThATjA3swZZzwqcKwoIt9jYG32Vv6pbfKNadsHaYmg7KJdaSPbdMHdYyf6HoareM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041562; c=relaxed/simple;
	bh=9SUodvvg1rGYUqIXFOOqwLz+xUmk/vUWLOe/vZPWUjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W6QV/iOUUwmhr736ry7SDGqLZwbcNTKwbEEyV2RmNkUtoUe2ZDKVoBbnQL0Y+Ln7RhKAb9OTiKJT5grSMjyfp6Ovq21wNg2nleXS7pJofWI6Jq1lljfRom7J460CRs4iCYwYx1F1uf/VroAZBN3P/rfl+6tc3zrp8JVywGUEMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghZsGw/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04DDC4CEE1;
	Thu, 16 Jan 2025 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737041562;
	bh=9SUodvvg1rGYUqIXFOOqwLz+xUmk/vUWLOe/vZPWUjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ghZsGw/aRdpoR6kljKlJeaZeVo3Vc94QQPFpq7jm7p8/L5LlkzigFUX56+Mb9Vq0P
	 8U0rN3ApGsb5ZZkN4/Lvqap9/VFcr5u62bjBP2E5s3jl6GZa9QS8KiKQuui1rxYxzG
	 qlc31wRqjgk37E7qPX1/riy9n8XeyY1dzDc0Zy9THmsIg7mn1i3xBEKvdrZ85O39+W
	 vKIg1TSpoia+kqD+EQp1FsP0Viip4hMsvMdz9VhNrKWdZyQ47+y6FLXGcBNDLXC0md
	 u5FdFkdQaMYA261Cu3/w2ZMatQDC05PCJady8+6rAoCoU6a4kvfD0FiXUxIfQPSTrD
	 tQ8gWAokc/FCw==
Date: Thu, 16 Jan 2025 09:32:39 -0600
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
Subject: Re: [PATCH v8 3/7] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <20250116153239.GA582080@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119-pci_fixup_addr-v8-3-c4bfa5193288@nxp.com>

On Tue, Nov 19, 2024 at 02:44:21PM -0500, Frank Li wrote:
>                    Endpoint
>   ┌───────────────────────────────────────────────┐
>   │                             pcie-ep@5f010000  │
>   │                             ┌────────────────┐│
>   │                             │   Endpoint     ││
>   │                             │   PCIe         ││
>   │                             │   Controller   ││
>   │           bus@5f000000      │                ││
>   │           ┌──────────┐      │                ││
>   │           │          │ Outbound Transfer     ││
>   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
>   ││     │    │  Fabric  │Bus   │                ││PCI Addr
>   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
>   ││     │CPU │          │0x8000_0000            ││
>   │└─────┘Addr└──────────┘      │                ││
>   │       0x7000_0000           └────────────────┘│
>   └───────────────────────────────────────────────┘
> 
> Use 'ranges' property in DT to configure the iATU outbound window address.
> The bus fabric generally passes the same address to the PCIe EP controller,
> but some bus fabrics map the address before sending it to the PCIe EP
> controller.
> 
> Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
> fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
> input address and map to PCI address 0xA000_0000.
> 
> Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
> the device tree provides this information, preferring a common method.
> 
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
> 	pcie-ep@5f010000 {
> 		reg = <0x80000000 0x10000000>;
> 		reg-names ="addr_space";
> 		...
> 	};
> 	...
> };
> 
> 'ranges' in bus@5f000000 descript how address map from CPU address to bus
> address.

Shouldn't there also be a pcie-ep@5f010000 'ranges' property to
describe the translation for the window from bus addr 0x8000_0000 to
PCI addr 0xA000_0000?

I assume the pcie-ep@5f010000 controller also has its own registers in
the bus addr space, separate from the window to PCI, and its 'reg'
property would describe those?

The similar patch at [1] includes:

  pcie@5f010000 {
    reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;

I assumed that [bus 0x5f010000-0x5f01ffff] is PCIe controller register
space and [bus 0x8ff00000-0x8ff7ffff] is ECAM space.

But that can't be right because ECAM requires 1MB per bus, and
[bus 0x8ff00000-0x8ff7ffff] is only 512KB.

> Use `of_property_read_reg()` to obtain the bus address and set it to the
> ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Why is this different from [1], where parent_bus_addr comes from the
'ranges' property?  Isn't this the same exact kind of address
translation for both RC and EP mode?

> Add 'using_dtbus_info' to indicate device tree reflect correctly bus
> address translation in case break compatibility.

'using_dtbus_info' doesn't exist; I assume this should be
'use_parent_dt_ranges'?

Sorry I'm so confused, please help me out :)

[1] https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-1-c4bfa5193288@nxp.com

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v7 to v8
> - Add Mani's reviewedby tag
> - s/convert/map in commit message
> - update comments for of_property_read_reg()
> - use 'use_parent_dt_ranges'
> 
> Change from v6 to v7
> - none
> 
> Change from v5 to v6
> - update diagram
> - Add comments for of_property_read_reg()
> - Remove unrelated 0x5f00_0000 in commit message
> 
> Change from v3 to v4
> - change bus_addr_base to u64 to fix 32bit build error
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/
> 
> Change from v2 to v3
> - Add using_dtbus_info to control if use device tree bus ranges
> information.
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 18 +++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h    |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 43ba5c6738df1..42719ad263b11 100644
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
> @@ -873,6 +875,20 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -EINVAL;
>  
>  	ep->phys_base = res->start;
> +	ep->bus_addr_base = ep->phys_base;
> +
> +	if (pci->use_parent_dt_ranges) {
> +		index = of_property_match_string(np, "reg-names", "addr_space");
> +		if (index < 0)
> +			return -EINVAL;
> +
> +		/*
> +		 * Get the untranslated bus address from devicetree to use it
> +		 * as the iATU CPU address in dw_pcie_ep_map_addr().
> +		 */
> +		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
> +	}
> +
>  	ep->addr_size = resource_size(res);
>  
>  	if (ep->ops->pre_init)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 4f31d4259a0de..5c14ed2cb91ed 100644
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
> 
> -- 
> 2.34.1
> 

