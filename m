Return-Path: <linux-pci+bounces-35656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C607CB48A21
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0C6188BC2B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C222F90DB;
	Mon,  8 Sep 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYezjpwZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B42F3C32;
	Mon,  8 Sep 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327105; cv=none; b=YjuqV9YGvR8TDuqGNkol9QF9IWchNr2oqP6aWTmbg/LUBtoMUuSO5wZicNuHA4dwqqatpc7MGpzIJzp3RUQTnYah/zJPT9UcJD98DYzMMNECo27jEIymPVIHsSOgH7iVpkQijThUjQyjzjO5P9fPTnPkMDxmlCH/eslmc514H+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327105; c=relaxed/simple;
	bh=tLGJeEl1Qfk4okWB+c27DSowZIiqr7hdwRezt+R4Sf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBZFljjbIlQr4uSVlvpRGOLYZ5meRb17D8WKTqziZXk26aXyk/JO0KdwCOTmK3wm/N+nGRBkpRHmpwQ68Wsetbd2NVCYAaeCSDGrifCiwvn2akEB+McAuhFV2h6XKklAf2KcBpBtAaa0q2Et0fswPomVk397CmRZcMqLoMxTsfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYezjpwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2DCC4CEF1;
	Mon,  8 Sep 2025 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757327103;
	bh=tLGJeEl1Qfk4okWB+c27DSowZIiqr7hdwRezt+R4Sf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYezjpwZS+dI8jo9fGwzxt/K61AS9iJgYeAD4ZhJWPVE0YNxJ2Y1eg+O+e1GHesgx
	 5VRu4yJgN7kkzmVvRKmT9tRhJw+FBwgGc3B2JpZU0kK3SiRx8afxDRyWXEWhcBiTeb
	 H8FWSbCFQob+s4QU6BVcjkz1DXcpeKYQjIuPgfX35rToUA4+KrLlaBybzrmhiR/3B+
	 qm30HNHvcqvF8zIzGS1K1KoNFjuWp/d0T6hNl9zbjFwWjf0dG0uIOOW99ajW2vEOm3
	 tLajU3cIdgxOhB9k7BDsEiDpPGpFo1ciS6WBhDF0d5DI5yS9Fn633adNsFSm80IYkn
	 MoEN5CaxCAigg==
Date: Mon, 8 Sep 2025 15:54:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/14] PCI: cadence: Move PCIe EP common functions to
 a separate file
Message-ID: <rf2gdbe6mob6xq4la6k5wbng2r5xuteubshu74bwxj6h7lrixj@sosow2gmajqm>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
 <20250901092052.4051018-6-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901092052.4051018-6-hans.zhang@cixtech.com>

On Mon, Sep 01, 2025 at 05:20:43PM GMT, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Move the Cadence PCIe controller EP common functions into a separate
> file. The common library functions are split from legacy PCIe EP
> controller functions.
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Since you are not adding the CIX EP controller driver, this split is not needed.

- Mani

> ---
>  drivers/pci/controller/cadence/Makefile       |   2 +-
>  .../cadence/pcie-cadence-ep-common.c          | 253 ++++++++++++++++++
>  .../cadence/pcie-cadence-ep-common.h          |  38 +++
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 233 +---------------
>  4 files changed, 293 insertions(+), 233 deletions(-)
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.h
> 
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 9bac5fb2f13d..80c1c4be7e80 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> -obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> +obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-common.c b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
> new file mode 100644
> index 000000000000..efdab21fd2b5
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence PCIe endpoint controller driver common
> + *
> + * Copyright (c) 2017 Cadence
> + * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/sizes.h>
> +
> +#include "pcie-cadence.h"
> +#include "pcie-cadence-ep-common.h"
> +
> +u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn)
> +{
> +	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
> +	u32 first_vf_offset, stride;
> +
> +	if (vfn == 0)
> +		return fn;
> +
> +	first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_OFFSET);
> +	stride = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_STRIDE);
> +	fn = fn + first_vf_offset + ((vfn - 1) * stride);
> +
> +	return fn;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_get_fn_from_vfn);
> +
> +int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
> +			      struct pci_epf_header *hdr)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 reg;
> +
> +	if (vfn > 1) {
> +		dev_err(&epc->dev, "Only Virtual Function #1 has deviceID\n");
> +		return -EINVAL;
> +	} else if (vfn == 1) {
> +		reg = cap + PCI_SRIOV_VF_DID;
> +		cdns_pcie_ep_fn_writew(pcie, fn, reg, hdr->deviceid);
> +		return 0;
> +	}
> +
> +	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
> +	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
> +	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CLASS_PROG, hdr->progif_code);
> +	cdns_pcie_ep_fn_writew(pcie, fn, PCI_CLASS_DEVICE,
> +			       hdr->subclass_code | hdr->baseclass_code << 8);
> +	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CACHE_LINE_SIZE,
> +			       hdr->cache_line_size);
> +	cdns_pcie_ep_fn_writew(pcie, fn, PCI_SUBSYSTEM_ID, hdr->subsys_id);
> +	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_INTERRUPT_PIN, hdr->interrupt_pin);
> +
> +	/*
> +	 * Vendor ID can only be modified from function 0, all other functions
> +	 * use the same vendor ID as function 0.
> +	 */
> +	if (fn == 0) {
> +		/* Update the vendor IDs. */
> +		u32 id = CDNS_PCIE_LM_ID_VENDOR(hdr->vendorid) |
> +			 CDNS_PCIE_LM_ID_SUBSYS(hdr->subsys_vendor_id);
> +
> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_ep_write_header);
> +
> +int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +	u16 flags;
> +
> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> +
> +	/*
> +	 * Set the Multiple Message Capable bitfield into the Message Control
> +	 * register.
> +	 */
> +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +	flags = (flags & ~PCI_MSI_FLAGS_QMASK) | (mmc << 1);
> +	flags |= PCI_MSI_FLAGS_64BIT;
> +	flags &= ~PCI_MSI_FLAGS_MASKBIT;
> +	cdns_pcie_ep_fn_writew(pcie, fn, cap + PCI_MSI_FLAGS, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_ep_set_msi);
> +
> +int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +	u16 flags, mme;
> +
> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> +
> +	/* Validate that the MSI feature is actually enabled. */
> +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +	if (!(flags & PCI_MSI_FLAGS_ENABLE))
> +		return -EINVAL;
> +
> +	/*
> +	 * Get the Multiple Message Enable bitfield from the Message Control
> +	 * register.
> +	 */
> +	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
> +
> +	return mme;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_ep_get_msi);
> +
> +int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> +	u32 val, reg;
> +
> +	func_no = cdns_pcie_get_fn_from_vfn(pcie, func_no, vfunc_no);
> +
> +	reg = cap + PCI_MSIX_FLAGS;
> +	val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
> +	if (!(val & PCI_MSIX_FLAGS_ENABLE))
> +		return -EINVAL;
> +
> +	val &= PCI_MSIX_FLAGS_QSIZE;
> +
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_ep_get_msix);
> +
> +int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
> +			  u16 interrupts, enum pci_barno bir,
> +			  u32 offset)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> +	u32 val, reg;
> +
> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> +
> +	reg = cap + PCI_MSIX_FLAGS;
> +	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
> +	val &= ~PCI_MSIX_FLAGS_QSIZE;
> +	val |= interrupts;
> +	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
> +
> +	/* Set MSI-X BAR and offset */
> +	reg = cap + PCI_MSIX_TABLE;
> +	val = offset | bir;
> +	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
> +
> +	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
> +	reg = cap + PCI_MSIX_PBA;
> +	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
> +	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_ep_set_msix);
> +
> +int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> +			     phys_addr_t addr, u8 interrupt_num,
> +			     u32 entry_size, u32 *msi_data,
> +			     u32 *msi_addr_offset)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u64 pci_addr, pci_addr_mask = 0xff;
> +	u16 flags, mme, data, data_mask;
> +	u8 msi_count;
> +	int ret;
> +	int i;
> +
> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> +
> +	/* Check whether the MSI feature has been enabled by the PCI host. */
> +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +	if (!(flags & PCI_MSI_FLAGS_ENABLE))
> +		return -EINVAL;
> +
> +	/* Get the number of enabled MSIs */
> +	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
> +	msi_count = 1 << mme;
> +	if (!interrupt_num || interrupt_num > msi_count)
> +		return -EINVAL;
> +
> +	/* Compute the data value to be written. */
> +	data_mask = msi_count - 1;
> +	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
> +	data = data & ~data_mask;
> +
> +	/* Get the PCI address where to write the data into. */
> +	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
> +	pci_addr <<= 32;
> +	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
> +	pci_addr &= GENMASK_ULL(63, 2);
> +
> +	for (i = 0; i < interrupt_num; i++) {
> +		ret = epc->ops->map_addr(epc, fn, vfn, addr,
> +					 pci_addr & ~pci_addr_mask,
> +					 entry_size);
> +		if (ret)
> +			return ret;
> +		addr = addr + entry_size;
> +	}
> +
> +	*msi_data = data;
> +	*msi_addr_offset = pci_addr & pci_addr_mask;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_ep_map_msi_irq);
> +
> +static const struct pci_epc_features cdns_pcie_epc_vf_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = true,
> +	.align = 65536,
> +};
> +
> +static const struct pci_epc_features cdns_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = true,
> +	.align = 256,
> +};
> +
> +const struct pci_epc_features*
> +cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> +{
> +	if (!vfunc_no)
> +		return &cdns_pcie_epc_features;
> +
> +	return &cdns_pcie_epc_vf_features;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_ep_get_features);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Cadence PCIe endpoint controller driver common");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-common.h b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
> new file mode 100644
> index 000000000000..7363031b5398
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence PCIe Endpoint controller driver
> + *
> + * Copyright (c) 2017 Cadence
> + * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> + */
> +#ifndef _PCIE_CADENCE_EP_COMMON_H
> +#define _PCIE_CADENCE_EP_COMMON_H
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/pci-epf.h>
> +#include <linux/pci-epc.h>
> +#include "../../pci.h"
> +
> +#define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
> +#define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
> +#define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
> +
> +u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn);
> +int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
> +			      struct pci_epf_header *hdr);
> +int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc);
> +int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn);
> +int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> +int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
> +			  u16 interrupts, enum pci_barno bir,
> +			  u32 offset);
> +int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> +			     phys_addr_t addr, u8 interrupt_num,
> +			     u32 entry_size, u32 *msi_data,
> +			     u32 *msi_addr_offset);
> +const struct pci_epc_features *cdns_pcie_ep_get_features(struct pci_epc *epc,
> +							 u8 func_no,
> +							 u8 vfunc_no);
> +
> +#endif /* _PCIE_CADENCE_EP_COMMON_H */
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 77c5a19b2ab1..747d83ed2ad3 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -13,68 +13,7 @@
>  #include <linux/sizes.h>
>  
>  #include "pcie-cadence.h"
> -#include "../../pci.h"
> -
> -#define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
> -#define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
> -#define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
> -
> -static u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn)
> -{
> -	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
> -	u32 first_vf_offset, stride;
> -
> -	if (vfn == 0)
> -		return fn;
> -
> -	first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_OFFSET);
> -	stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +  PCI_SRIOV_VF_STRIDE);
> -	fn = fn + first_vf_offset + ((vfn - 1) * stride);
> -
> -	return fn;
> -}
> -
> -static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
> -				     struct pci_epf_header *hdr)
> -{
> -	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> -	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
> -	struct cdns_pcie *pcie = &ep->pcie;
> -	u32 reg;
> -
> -	if (vfn > 1) {
> -		dev_err(&epc->dev, "Only Virtual Function #1 has deviceID\n");
> -		return -EINVAL;
> -	} else if (vfn == 1) {
> -		reg = cap + PCI_SRIOV_VF_DID;
> -		cdns_pcie_ep_fn_writew(pcie, fn, reg, hdr->deviceid);
> -		return 0;
> -	}
> -
> -	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
> -	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
> -	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CLASS_PROG, hdr->progif_code);
> -	cdns_pcie_ep_fn_writew(pcie, fn, PCI_CLASS_DEVICE,
> -			       hdr->subclass_code | hdr->baseclass_code << 8);
> -	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CACHE_LINE_SIZE,
> -			       hdr->cache_line_size);
> -	cdns_pcie_ep_fn_writew(pcie, fn, PCI_SUBSYSTEM_ID, hdr->subsys_id);
> -	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_INTERRUPT_PIN, hdr->interrupt_pin);
> -
> -	/*
> -	 * Vendor ID can only be modified from function 0, all other functions
> -	 * use the same vendor ID as function 0.
> -	 */
> -	if (fn == 0) {
> -		/* Update the vendor IDs. */
> -		u32 id = CDNS_PCIE_LM_ID_VENDOR(hdr->vendorid) |
> -			 CDNS_PCIE_LM_ID_SUBSYS(hdr->subsys_vendor_id);
> -
> -		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
> -	}
> -
> -	return 0;
> -}
> +#include "pcie-cadence-ep-common.h"
>  
>  static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  				struct pci_epf_bar *epf_bar)
> @@ -222,100 +161,6 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
>  	clear_bit(r, &ep->ob_region_map);
>  }
>  
> -static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 nr_irqs)
> -{
> -	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct cdns_pcie *pcie = &ep->pcie;
> -	u8 mmc = order_base_2(nr_irqs);
> -	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> -	u16 flags;
> -
> -	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> -
> -	/*
> -	 * Set the Multiple Message Capable bitfield into the Message Control
> -	 * register.
> -	 */
> -	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> -	flags = (flags & ~PCI_MSI_FLAGS_QMASK) | (mmc << 1);
> -	flags |= PCI_MSI_FLAGS_64BIT;
> -	flags &= ~PCI_MSI_FLAGS_MASKBIT;
> -	cdns_pcie_ep_fn_writew(pcie, fn, cap + PCI_MSI_FLAGS, flags);
> -
> -	return 0;
> -}
> -
> -static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
> -{
> -	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct cdns_pcie *pcie = &ep->pcie;
> -	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> -	u16 flags, mme;
> -
> -	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> -
> -	/* Validate that the MSI feature is actually enabled. */
> -	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> -	if (!(flags & PCI_MSI_FLAGS_ENABLE))
> -		return -EINVAL;
> -
> -	/*
> -	 * Get the Multiple Message Enable bitfield from the Message Control
> -	 * register.
> -	 */
> -	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
> -
> -	return 1 << mme;
> -}
> -
> -static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> -{
> -	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct cdns_pcie *pcie = &ep->pcie;
> -	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> -	u32 val, reg;
> -
> -	func_no = cdns_pcie_get_fn_from_vfn(pcie, func_no, vfunc_no);
> -
> -	reg = cap + PCI_MSIX_FLAGS;
> -	val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
> -	if (!(val & PCI_MSIX_FLAGS_ENABLE))
> -		return -EINVAL;
> -
> -	val &= PCI_MSIX_FLAGS_QSIZE;
> -
> -	return val + 1;
> -}
> -
> -static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
> -				 u16 nr_irqs, enum pci_barno bir, u32 offset)
> -{
> -	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct cdns_pcie *pcie = &ep->pcie;
> -	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> -	u32 val, reg;
> -
> -	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> -
> -	reg = cap + PCI_MSIX_FLAGS;
> -	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
> -	val &= ~PCI_MSIX_FLAGS_QSIZE;
> -	val |= nr_irqs - 1; /* encoded as N-1 */
> -	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
> -
> -	/* Set MSI-X BAR and offset */
> -	reg = cap + PCI_MSIX_TABLE;
> -	val = offset | bir;
> -	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
> -
> -	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
> -	reg = cap + PCI_MSIX_PBA;
> -	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
> -	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
> -
> -	return 0;
> -}
> -
>  static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
>  				     bool is_asserted)
>  {
> @@ -426,59 +271,6 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
>  	return 0;
>  }
>  
> -static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> -				    phys_addr_t addr, u8 interrupt_num,
> -				    u32 entry_size, u32 *msi_data,
> -				    u32 *msi_addr_offset)
> -{
> -	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> -	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> -	struct cdns_pcie *pcie = &ep->pcie;
> -	u64 pci_addr, pci_addr_mask = 0xff;
> -	u16 flags, mme, data, data_mask;
> -	u8 msi_count;
> -	int ret;
> -	int i;
> -
> -	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> -
> -	/* Check whether the MSI feature has been enabled by the PCI host. */
> -	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> -	if (!(flags & PCI_MSI_FLAGS_ENABLE))
> -		return -EINVAL;
> -
> -	/* Get the number of enabled MSIs */
> -	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
> -	msi_count = 1 << mme;
> -	if (!interrupt_num || interrupt_num > msi_count)
> -		return -EINVAL;
> -
> -	/* Compute the data value to be written. */
> -	data_mask = msi_count - 1;
> -	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
> -	data = data & ~data_mask;
> -
> -	/* Get the PCI address where to write the data into. */
> -	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
> -	pci_addr <<= 32;
> -	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
> -	pci_addr &= GENMASK_ULL(63, 2);
> -
> -	for (i = 0; i < interrupt_num; i++) {
> -		ret = cdns_pcie_ep_map_addr(epc, fn, vfn, addr,
> -					    pci_addr & ~pci_addr_mask,
> -					    entry_size);
> -		if (ret)
> -			return ret;
> -		addr = addr + entry_size;
> -	}
> -
> -	*msi_data = data;
> -	*msi_addr_offset = pci_addr & pci_addr_mask;
> -
> -	return 0;
> -}
> -
>  static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
>  				      u16 interrupt_num)
>  {
> @@ -607,29 +399,6 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	return 0;
>  }
>  
> -static const struct pci_epc_features cdns_pcie_epc_vf_features = {
> -	.linkup_notifier = false,
> -	.msi_capable = true,
> -	.msix_capable = true,
> -	.align = 65536,
> -};
> -
> -static const struct pci_epc_features cdns_pcie_epc_features = {
> -	.linkup_notifier = false,
> -	.msi_capable = true,
> -	.msix_capable = true,
> -	.align = 256,
> -};
> -
> -static const struct pci_epc_features*
> -cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> -{
> -	if (!vfunc_no)
> -		return &cdns_pcie_epc_features;
> -
> -	return &cdns_pcie_epc_vf_features;
> -}
> -
>  static const struct pci_epc_ops cdns_pcie_epc_ops = {
>  	.write_header	= cdns_pcie_ep_write_header,
>  	.set_bar	= cdns_pcie_ep_set_bar,
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

