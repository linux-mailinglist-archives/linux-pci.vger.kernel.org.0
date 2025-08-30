Return-Path: <linux-pci+bounces-35178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56BB3CB1E
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824E55E78E5
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB04205ABA;
	Sat, 30 Aug 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSkfDpQi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB86F2F2;
	Sat, 30 Aug 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756559894; cv=none; b=GWxen+1vvpbPg2V/wTFco3n+JKlCuucl9vLfX8kaRI/Cz/d/e9kKQjHvaWmbubyYwLeYBNMjL5noPb9qbeaPYjGM0F5SypbOHFyJO4GbQC3HW1qADga7F56wBZaC29N3wrSzdeWHREIhDI0FhqK5v14h/G1eZsy75xW9NCb/xNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756559894; c=relaxed/simple;
	bh=uDxH95ure9wekdoV70RkXRE5pysKH2g25txxKvRhYVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTidzjt8auT5F96CvhbF25RMkMrIv8jBTDvz06fyJ5MOYDzjgFFL/LvC+ztWXZzxXsGyNJ5ZCAO2O52usyDE1zQo0RwNLvnNX6eotugZAxJRhCJvL56DWpPKzIjbCko/srrCLMBfFhgOae8NtKp/723YILbMbE/LNxH3Dp+S/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSkfDpQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53343C4CEEB;
	Sat, 30 Aug 2025 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756559891;
	bh=uDxH95ure9wekdoV70RkXRE5pysKH2g25txxKvRhYVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSkfDpQiKnyxdWtvYQud3mEev8n9IURN2vdf6faDhmFow/yVw1y7NLBSl92LgxePZ
	 SHaAhYac+R/odWPfEe4Eeb5/vFvXl7zCJ8RpE4q0X6Fo73eTqtMaBw9vtrojwEizAz
	 7DIO3vOgj39duLR2O4mbrqU8vQtZTHN65dZtu2JCo3p/TeCKWBzgI/6iyVLMfB+F5Y
	 K0AGHiGVeEK9sf3ZfsrT+kwx9Vo+noSkaTDBRDDhcVH67VeXaGCcfjTrhjH4I54zdl
	 EUJ45TQW1mqNgXzZWVfCsekQNld2Mxsfg38ueK1vk96sbAJmy1gnqR/ONHman3YSm5
	 jT1JND7xfElCw==
Date: Sat, 30 Aug 2025 18:48:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/15] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Message-ID: <lsmes7ty2i2irzozpbwno562zi25lebxrcejd7biltjtsnb36z@6vhtqwrr4cpk>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-9-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-9-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:32PM GMT, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Add support for Cadence PCIe RP and EP configuration for High
> Performance Architecture (HPA) controllers.
> 

Add more info about the controller.

> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  drivers/pci/controller/cadence/Makefile       |  10 +-
>  .../controller/cadence/pcie-cadence-ep-hpa.c  | 528 ++++++++++++++++
>  .../cadence/pcie-cadence-host-hpa.c           | 585 ++++++++++++++++++
>  .../pci/controller/cadence/pcie-cadence-hpa.c | 204 ++++++

That's a combined 1200+ loc in a single patch, which is very difficult to
review. You should've split it into atleast two.

>  drivers/pci/controller/cadence/pcie-cadence.c |  11 +
>  drivers/pci/controller/cadence/pcie-cadence.h |  74 ++-
>  6 files changed, 1403 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
> 
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index b104562fb86a..de4ddae7aca4 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -1,6 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-common.o pcie-cadence.o
> -obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
> -obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
> +pcie-cadence-mod-y := pcie-cadence-hpa.o pcie-cadence-common.o pcie-cadence.o
> +pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-cadence-host-hpa.o
> +pcie-cadence-ep-mod-y := pcie-cadence-ep-common.o pcie-cadence-ep.o pcie-cadence-ep-hpa.o
> +
> +obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
> +obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
> +obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c
> new file mode 100644
> index 000000000000..a5366ecec34f
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe endpoint controller driver.
> +// Author: Manikandan K Pillai  <mpillai@cadence.com>
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/pci-epc.h>
> +#include <linux/platform_device.h>
> +#include <linux/sizes.h>
> +
> +#include "pcie-cadence.h"
> +#include "pcie-cadence-ep-common.h"
> +
> +static int cdns_pcie_hpa_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
> +				     phys_addr_t addr, u64 pci_addr, size_t size)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 r;
> +
> +	r = find_first_zero_bit(&ep->ob_region_map, BITS_PER_LONG);
> +	if (r >= ep->max_regions - 1) {
> +		dev_err(&epc->dev, "no free outbound region\n");
> +		return -EINVAL;

-ENOSPC

> +	}
> +
> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> +	cdns_pcie_hpa_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size);
> +
> +	set_bit(r, &ep->ob_region_map);
> +	ep->ob_addr[r] = addr;
> +
> +	return 0;
> +}
> +
> +static void cdns_pcie_hpa_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
> +					phys_addr_t addr)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 r;
> +
> +	for (r = 0; r < ep->max_regions - 1; r++)
> +		if (ep->ob_addr[r] == addr)
> +			break;
> +
> +	if (r == ep->max_regions - 1)
> +		return;
> +
> +	cdns_pcie_hpa_reset_outbound_region(pcie, r);
> +
> +	ep->ob_addr[r] = 0;
> +	clear_bit(r, &ep->ob_region_map);
> +}
> +
> +static void cdns_pcie_hpa_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
> +					 bool assert)
> +{
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	unsigned long flags;
> +	u32 offset;
> +	u16 status;
> +	u8 msg_code;
> +
> +	intx &= 3;
> +
> +	/* Set the outbound region if needed */
> +	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
> +		     ep->irq_pci_fn != fn)) {
> +		/* First region was reserved for IRQ writes */
> +		cdns_pcie_hpa_set_outbound_region_for_normal_msg(pcie, 0, fn, 0, ep->irq_phys_addr);
> +		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
> +		ep->irq_pci_fn = fn;
> +	}
> +
> +	if (assert) {
> +		ep->irq_pending |= BIT(intx);
> +		msg_code = PCIE_MSG_CODE_ASSERT_INTA + intx;
> +	} else {
> +		ep->irq_pending &= ~BIT(intx);
> +		msg_code = PCIE_MSG_CODE_DEASSERT_INTA + intx;
> +	}
> +
> +	spin_lock_irqsave(&ep->lock, flags);
> +	status = cdns_pcie_ep_fn_readw(pcie, fn, PCI_STATUS);
> +	if (((status & PCI_STATUS_INTERRUPT) != 0) ^ (ep->irq_pending != 0)) {
> +		status ^= PCI_STATUS_INTERRUPT;
> +		cdns_pcie_ep_fn_writew(pcie, fn, PCI_STATUS, status);
> +	}
> +	spin_unlock_irqrestore(&ep->lock, flags);
> +
> +	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(PCIE_MSG_TYPE_R_RC) |
> +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
> +	writel(0, ep->irq_cpu_addr + offset);
> +}
> +
> +static int cdns_pcie_hpa_ep_raise_intx_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
> +					   u8 intx)
> +{
> +	u16 cmd;
> +
> +	cmd = cdns_pcie_ep_fn_readw(&ep->pcie, fn, PCI_COMMAND);
> +	if (cmd & PCI_COMMAND_INTX_DISABLE)
> +		return -EINVAL;
> +
> +	cdns_pcie_hpa_ep_assert_intx(ep, fn, intx, true);
> +
> +	/* The mdelay() value was taken from dra7xx_pcie_raise_intx_irq() */
> +	mdelay(1);

AFAIK, this 1ms delay is not fixed per the PCIe spec. It depends on how the host
interrupt controller detects the level triggered interrupt. So I don't think
this 1ms delay will work with all host systems.

> +	cdns_pcie_hpa_ep_assert_intx(ep, fn, intx, false);
> +	return 0;
> +}
> +
> +static int cdns_pcie_hpa_ep_raise_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
> +					  u8 interrupt_num)
> +{
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +	u16 flags, mme, data, data_mask;
> +	u8 msi_count;
> +	u64 pci_addr, pci_addr_mask = 0xff;
> +
> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> +
> +	/* Check whether the MSI feature has been enabled by the PCI host */
> +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +	if (!(flags & PCI_MSI_FLAGS_ENABLE))
> +		return -EINVAL;

-EOPNOTSUPP

> +
> +	/* Get the number of enabled MSIs */
> +	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
> +	msi_count = 1 << mme;
> +	if (!interrupt_num || interrupt_num > msi_count)
> +		return -EINVAL;
> +
> +	/* Compute the data value to be written */
> +	data_mask = msi_count - 1;
> +	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
> +	data = (data & ~data_mask) | ((interrupt_num - 1) & data_mask);
> +
> +	/* Get the PCI address where to write the data into */
> +	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
> +	pci_addr <<= 32;
> +	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
> +	pci_addr &= GENMASK_ULL(63, 2);
> +
> +	/* Set the outbound region if needed */
> +	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
> +		     ep->irq_pci_fn != fn)) {
> +		/* First region was reserved for IRQ writes */
> +		cdns_pcie_hpa_set_outbound_region(pcie, 0, fn, 0,
> +						  false,
> +						  ep->irq_phys_addr,
> +						  pci_addr & ~pci_addr_mask,
> +						  pci_addr_mask + 1);
> +		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
> +		ep->irq_pci_fn = fn;
> +	}
> +	writel(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
> +
> +	return 0;
> +}
> +
> +static int cdns_pcie_hpa_ep_raise_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
> +					   u16 interrupt_num)
> +{
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> +	u32 tbl_offset, msg_data, reg;
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	struct pci_epf_msix_tbl *msix_tbl;
> +	struct cdns_pcie_epf *epf;
> +	u64 pci_addr_mask = 0xff;
> +	u64 msg_addr;
> +	u16 flags;
> +	u8 bir;
> +
> +	epf = &ep->epf[fn];
> +	if (vfn > 0)
> +		epf = &epf->epf[vfn - 1];
> +
> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> +
> +	/* Check whether the MSI-X feature has been enabled by the PCI host */
> +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSIX_FLAGS);
> +	if (!(flags & PCI_MSIX_FLAGS_ENABLE))
> +		return -EINVAL;

-EOPNOTSUPP

> +
> +	reg = cap + PCI_MSIX_TABLE;
> +	tbl_offset = cdns_pcie_ep_fn_readl(pcie, fn, reg);
> +	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
> +	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
> +
> +	msix_tbl = epf->epf_bar[bir]->addr + tbl_offset;
> +	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
> +	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
> +
> +	/* Set the outbound region if needed */
> +	if (ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||
> +	    ep->irq_pci_fn != fn) {
> +		/* First region was reserved for IRQ writes */
> +		cdns_pcie_hpa_set_outbound_region(pcie, 0, fn, 0,
> +						  false,
> +						  ep->irq_phys_addr,
> +						  msg_addr & ~pci_addr_mask,
> +						  pci_addr_mask + 1);
> +		ep->irq_pci_addr = (msg_addr & ~pci_addr_mask);
> +		ep->irq_pci_fn = fn;
> +	}
> +	writel(msg_data, ep->irq_cpu_addr + (msg_addr & pci_addr_mask));
> +
> +	return 0;
> +}
> +
> +static int cdns_pcie_hpa_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> +				      unsigned int type, u16 interrupt_num)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	struct device *dev = pcie->dev;
> +
> +	switch (type) {
> +	case PCI_IRQ_INTX:
> +		if (vfn > 0) {
> +			dev_err(dev, "Cannot raise INTX interrupts for VF\n");
> +			return -EINVAL;

-EOPNOTSUPP

> +		}
> +		return cdns_pcie_hpa_ep_raise_intx_irq(ep, fn, vfn, 0);
> +

No need of newline

> +	case PCI_IRQ_MSI:
> +		return cdns_pcie_hpa_ep_raise_msi_irq(ep, fn, vfn, interrupt_num);
> +
> +	case PCI_IRQ_MSIX:
> +		return cdns_pcie_hpa_ep_raise_msix_irq(ep, fn, vfn, interrupt_num);
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +

[...]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> new file mode 100644
> index 000000000000..b2e570f2c047
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> @@ -0,0 +1,585 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe host controller driver.
> +// Author: Manikandan K Pillai <mpillai@cadence.com>
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/list_sort.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-cadence.h"
> +#include "pcie-cadence-host-common.h"
> +
> +static u8 bar_aperture_mask[] = {
> +	[RP_BAR0] = 0x1F,
> +	[RP_BAR1] = 0xF,

Use lowercase for hex.

> +};
> +

[...]

> +static void cdns_pcie_hpa_create_region_for_ecam(struct cdns_pcie_rc *rc)
> +{
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
> +	struct resource *cfg_res = rc->cfg_res;
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	u32 value, root_port_req_id_reg, pcie_bus_number_reg;
> +	u32 ecam_addr_0, region_size_0, request_id_0;
> +	int busnr = 0, secbus = 0, subbus = 0;
> +	struct resource_entry *entry;
> +	resource_size_t size;
> +	u32 axi_address_low;
> +	int nbits;
> +	u64 sz;
> +
> +	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (entry) {
> +		busnr = entry->res->start;
> +		secbus = (busnr < 0xff) ? (busnr + 1) : 0xff;
> +		subbus = entry->res->end;
> +	}
> +	size = resource_size(cfg_res);
> +	sz = 1ULL << fls64(size - 1);
> +	nbits = ilog2(sz);
> +	if (nbits < 8)
> +		nbits = 8;
> +
> +	root_port_req_id_reg = ((busnr & 0xff) << 8);
> +	pcie_bus_number_reg = ((subbus & 0xff) << 16) | ((secbus & 0xff) << 8) |
> +			      (busnr & 0xff);
> +	ecam_addr_0 = cfg_res->start;
> +	region_size_0 = nbits - 1;
> +	request_id_0 = ((busnr & 0xff) << 8);
> +
> +#define CDNS_PCIE_HPA_TAG_MANAGEMENT (0x0)

Do not use inline definitions. Define them at the start of the file.

> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_TAG_MANAGEMENT, 0x200000);
> +
> +	/* Taking slave err as OKAY */
> +#define CDNS_PCIE_HPA_SLAVE_RESP (0x100)
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_SLAVE_RESP,
> +			     0x0);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_SLAVE_RESP + 0x4, 0x0);
> +
> +	/* Program the register "i_root_port_req_id_reg" with RP's BDF */
> +#define I_ROOT_PORT_REQ_ID_REG (0x141c)
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, I_ROOT_PORT_REQ_ID_REG,
> +			     root_port_req_id_reg);
> +
> +	/**
> +	 * Program the register "i_pcie_bus_numbers" with Primary(RP's bus number),
> +	 * secondary and subordinate bus numbers
> +	 */
> +#define I_PCIE_BUS_NUMBERS (CDNS_PCIE_HPA_RP_BASE + 0x18)
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_RP, I_PCIE_BUS_NUMBERS,
> +			     pcie_bus_number_reg);
> +
> +	/* Program the register "lm_hal_sbsa_ctrl[0]" to enable the sbsa */
> +#define LM_HAL_SBSA_CTRL (0x1170)
> +	value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, LM_HAL_SBSA_CTRL);
> +	value |= BIT(0);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, LM_HAL_SBSA_CTRL, value);
> +
> +	/* Program region[0] for ECAM */
> +	axi_address_low = (ecam_addr_0 & 0xfff00000) | region_size_0;
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0),
> +			     axi_address_low);
> +
> +	/* rc0-high-axi-address */
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), 0x0);
> +	/* Type-1 CFG */
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), 0x05000000);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0),
> +			     (request_id_0 << 16));
> +
> +	/* All AXI bits pass through PCIe */
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), 0x1b);
> +	/* PCIe address-high */
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), 0);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), 0x06000000);
> +}

[...]

> +int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	struct device *dev = rc->pcie.dev;
> +	int ret;
> +
> +	if (rc->quirk_detect_quiet_flag)
> +		cdns_pcie_hpa_detect_quiet_min_delay_set(&rc->pcie);
> +
> +	cdns_pcie_hpa_host_enable_ptm_response(pcie);
> +
> +	ret = cdns_pcie_start_link(pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to start link\n");
> +		return ret;
> +	}
> +
> +	ret = cdns_pcie_hpa_host_start_link(rc);
> +	if (ret)
> +		dev_dbg(dev, "PCIe link never came up\n");

You are not supposed to fail the probe if link doesn't come up.

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
> +

[...]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 1174cf597bb0..f2eb3f09b21a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -7,6 +7,7 @@
>  #define _PCIE_CADENCE_H
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci-epf.h>
>  #include <linux/phy/phy.h>
> @@ -42,9 +43,9 @@ enum cdns_pcie_reg_bank {
>  };
>  
>  struct cdns_pcie_ops {
> -	int	(*start_link)(struct cdns_pcie *pcie);
> -	void	(*stop_link)(struct cdns_pcie *pcie);
> -	bool	(*link_up)(struct cdns_pcie *pcie);
> +	int     (*start_link)(struct cdns_pcie *pcie);
> +	void    (*stop_link)(struct cdns_pcie *pcie);
> +	bool    (*link_up)(struct cdns_pcie *pcie);
>  	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
>  };
>  
> @@ -76,6 +77,7 @@ struct cdns_plat_pcie_of_data {
>   * struct cdns_pcie - private data for Cadence PCIe controller drivers
>   * @reg_base: IO mapped register base
>   * @mem_res: start/end offsets in the physical system memory to map PCI accesses
> + * @msg_res: Region for send message to map PCI accesses
>   * @dev: PCIe controller
>   * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
>   * @phy_count: number of supported PHY devices
> @@ -88,6 +90,7 @@ struct cdns_plat_pcie_of_data {
>  struct cdns_pcie {
>  	void __iomem		             *reg_base;
>  	struct resource		             *mem_res;
> +	struct resource                      *msg_res;
>  	struct device		             *dev;
>  	bool			             is_rc;
>  	int			             phy_count;
> @@ -110,6 +113,7 @@ struct cdns_pcie {
>   *                available
>   * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
>   * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
> + * @ecam_support_flag: Whether the ECAM flag is supported
>   */
>  struct cdns_pcie_rc {
>  	struct cdns_pcie	pcie;
> @@ -120,6 +124,8 @@ struct cdns_pcie_rc {
>  	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
>  	unsigned int		quirk_retrain_flag:1;
>  	unsigned int		quirk_detect_quiet_flag:1;
> +	unsigned int            ecam_support_flag:1;

ecam_supported

> +	unsigned int		no_inbound_flag:1;

no_inbound_map

- Mani

-- 
மணிவண்ணன் சதாசிவம்

