Return-Path: <linux-pci+bounces-12846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52796DFDA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F419528DAB0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E81A0724;
	Thu,  5 Sep 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW+wBkXH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1F50271;
	Thu,  5 Sep 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554013; cv=none; b=PpZVmzPyqZSflds2OMDBwPjjFXeku22J136wovz+dWBUShBJxcnAgKsweZSU1euHXT+KEAzRY/vfXEHDoTt2f/rNqqlS0BxymT36+pWUTbAl5pxz35xEArXcu7z2Y5e9KOqAhCQ0A4XKAKdgSboLXCeGrho6NuReaQ96cZ9kZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554013; c=relaxed/simple;
	bh=9Tk0qytElXOqijUu2mwaQ/iNQpnr3HTIkzbW8O/Fgio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uRoJxA+1zfwc/jR8tnYOhb+cWSurTV8ftSnO1fnTgqbSWf/XPXYfpBS/dBGqyzEMcEPomDoGKjYrArjspPmqW4RcrToiobSfkXvF2dMjcBoUuu7NmWDU8+LvPBg3uIXagxu5YLLbRNXYr8gFM4c6yB0K1sWlEa8lCWribUX8JW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW+wBkXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B71C4CEC3;
	Thu,  5 Sep 2024 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725554012;
	bh=9Tk0qytElXOqijUu2mwaQ/iNQpnr3HTIkzbW8O/Fgio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gW+wBkXHJDhGVXXAfJCPQj2kpceVBR+QWpc5EB5VaM3VbU5KzSYjuyS+kU0KHYUgr
	 Vbw7YD74hyIp9ASlVYw9i/S5T5hvkcMNS9g/sUfc0qUDPsWVcUe83qD/tkw+3Zopkl
	 gakIRnJo3HMLUH5yZ4lTGGxnc6tViQlacP8tMH8RsMzC0ubDQA5nzKrqqDH95p5brW
	 cxYC6wohcOlvlYD7LAPD+Eg0h5S+xtyw++MGlyUy5KeL/zsq62UTBqy+mp8R6fB01I
	 piX0p5So+agRaK10NXmxRvxmrVanNSNsu9iQFOQ7iTY653UNcqqm8TUNkQVWBoRWym
	 eScmz75uH8lrg==
Date: Thu, 5 Sep 2024 11:33:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH v4 4/7] PCI: keystone: Add supported for PVU-based DMA
 isolation on AM654
Message-ID: <20240905163329.GA389144@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <361441d35d781b3c474b05921634bcae08d1a7b4.1725444016.git.jan.kiszka@siemens.com>

[+cc Kishon, just in case you have time/interest ;)]

On Wed, Sep 04, 2024 at 12:00:13PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
> from untrusted PCI devices to selected memory regions this way. Use
> static PVU-based protection instead.
> 
> For this, we use the availability of restricted-dma-pool memory regions
> as trigger and register those as valid DMA targets with the PVU.

I guess the implication is that DMA *outside* the restricted-dma-pool
just gets dropped, and the Requester would see Completion Timeouts or
something for reads?

> In
> addition, we need to enable the mapping of requester IDs to VirtIDs in
> the PCI RC. We only use a single VirtID so far, catching all devices.
> This may be extended later on.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> CC: "Krzysztof Wilczyński" <kw@linux.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-pci@vger.kernel.org

Regrettably we don't really have anybody taking care of pci-keystone.c
(at least per MAINTAINERS).

> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 101 ++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 2219b1a866fa..96b871656da4 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -19,6 +19,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/phy/phy.h>
> @@ -26,6 +27,7 @@
>  #include <linux/regmap.h>
>  #include <linux/resource.h>
>  #include <linux/signal.h>
> +#include <linux/ti-pvu.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> @@ -111,6 +113,16 @@
>  
>  #define PCI_DEVICE_ID_TI_AM654X		0xb00c
>  
> +#define KS_PCI_VIRTID			0
> +
> +#define PCIE_VMAP_xP_CTRL		0x0
> +#define PCIE_VMAP_xP_REQID		0x4
> +#define PCIE_VMAP_xP_VIRTID		0x8
> +
> +#define PCIE_VMAP_xP_CTRL_EN		BIT(0)
> +
> +#define PCIE_VMAP_xP_VIRTID_VID_MASK	0xfff
> +
>  struct ks_pcie_of_data {
>  	enum dw_pcie_device_mode mode;
>  	const struct dw_pcie_host_ops *host_ops;
> @@ -1125,6 +1137,89 @@ static const struct of_device_id ks_pcie_of_match[] = {
>  	{ },
>  };
>  
> +#ifdef CONFIG_TI_PVU
> +static const char *ks_vmap_res[] = {"vmap_lp", "vmap_hp"};
> +
> +static int ks_init_restricted_dma(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct of_phandle_iterator it;
> +	bool init_vmap = false;
> +	struct resource phys;
> +	struct resource *res;
> +	void __iomem *base;
> +	unsigned int n;
> +	u32 val;
> +	int err;
> +
> +	of_for_each_phandle(&it, err, dev->of_node, "memory-region",
> +			    NULL, 0) {
> +		if (!of_device_is_compatible(it.node, "restricted-dma-pool"))
> +			continue;
> +
> +		err = of_address_to_resource(it.node, 0, &phys);
> +		if (err < 0) {
> +			dev_err(dev, "failed to parse memory region %pOF: %d\n",
> +				it.node, err);
> +			continue;
> +		}
> +
> +		err = ti_pvu_create_region(KS_PCI_VIRTID, &phys);
> +		if (err < 0)
> +			return err;
> +
> +		init_vmap = true;
> +	}

  if (!init_vmap)
    return 0;

would unindent the following.

> +
> +	if (init_vmap) {
> +		for (n = 0; n < ARRAY_SIZE(ks_vmap_res); n++) {

Since the only use of ks_vmap_res is here, this might be more readable
if there were a helper that would be called twice with the constant
strings, e.g.,

  helper(pdev, "vmap_lp");
  helper(pdev, "vmap_hp");

> +			res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +							   ks_vmap_res[n]);

Seems like we should check "res" for error before using it?

> +			base = devm_pci_remap_cfg_resource(dev, res);
> +			if (IS_ERR(base))
> +				return PTR_ERR(base);
> +
> +			writel(0, base + PCIE_VMAP_xP_REQID);
> +
> +			val = readl(base + PCIE_VMAP_xP_VIRTID);
> +			val &= ~PCIE_VMAP_xP_VIRTID_VID_MASK;
> +			val |= KS_PCI_VIRTID;
> +			writel(val, base + PCIE_VMAP_xP_VIRTID);
> +
> +			val = readl(base + PCIE_VMAP_xP_CTRL);
> +			val |= PCIE_VMAP_xP_CTRL_EN;
> +			writel(val, base + PCIE_VMAP_xP_CTRL);

Since there's no explicit use of "restricted-dma-pool" elsewhere in
this patch, I assume the setup above causes the controller to drop any
DMA accesses outside that pool?  I think a comment about how the
controller behavior is being changed would be useful.  Basically the
same comment as for the commit log.

Would there be any value in a dmesg note about a restriction being
enforced?  Seems like it's dependent on both CONFIG_TI_PVU and some DT
properties, and since those are invisible in the log, maybe a note
would help understand/debug any issues?

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void ks_release_restricted_dma(struct platform_device *pdev)
> +{
> +	struct of_phandle_iterator it;
> +	struct resource phys;
> +	int err;
> +
> +	of_for_each_phandle(&it, err, pdev->dev.of_node, "memory-region",
> +			    NULL, 0) {
> +		if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
> +		    of_address_to_resource(it.node, 0, &phys) == 0)
> +			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);

I guess it's not important to undo the PCIE_VMAP_xP_CTRL_EN and
related setup that was done by ks_init_restricted_dma()?

> +	}
> +}
> +#else
> +static inline int ks_init_restricted_dma(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static inline void ks_release_restricted_dma(struct platform_device *pdev)
> +{
> +}
> +#endif
> +
>  static int ks_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct dw_pcie_host_ops *host_ops;
> @@ -1273,6 +1368,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_get_sync;
>  
> +	ret = ks_init_restricted_dma(pdev);
> +	if (ret < 0)
> +		goto err_get_sync;
> +
>  	switch (mode) {
>  	case DW_PCIE_RC_TYPE:
>  		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
> @@ -1354,6 +1453,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
>  	int num_lanes = ks_pcie->num_lanes;
>  	struct device *dev = &pdev->dev;
>  
> +	ks_release_restricted_dma(pdev);
> +
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
> -- 
> 2.43.0
> 

