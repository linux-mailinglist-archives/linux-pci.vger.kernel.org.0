Return-Path: <linux-pci+bounces-38512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55698BEB5D1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 21:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A560135FBD6
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B9C332907;
	Fri, 17 Oct 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQIuYTX7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F12FE587;
	Fri, 17 Oct 2025 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728209; cv=none; b=nUDbiKxS2XA1BsOLC/vP+a7jUQrt29Kuds/ZfWEycfueNypkCnBOG+idIJs2HVjI0ykQvF8WKf/Z2yYyz7z8yDeFGHCCq6XXE/MjdKamujzj++snavfSu21RQ6t/BrWCAI9lD4dLIXzXHUkx/gLBnpo9nuafCRWrtmRdq94GucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728209; c=relaxed/simple;
	bh=0f9esdWuiStJECWkAZn/SOlcYyopP8tRdxicHx6d+OE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sfos71s2ArwfzIVmIy1w0gWOlvOaVMiG5VJL2SkxAJxxk4+zib7R7b6kpGMTnK573JqlX9Cw/eFAQEuR2s1I04bvHNLyi7qMIAXvlztImXCeInkm/qHQsbE41Kfxma1R6H4llIqQdE8A18Kkfb4s75sMkUTaOriIZX6yU2YxOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQIuYTX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48629C4CEE7;
	Fri, 17 Oct 2025 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760728207;
	bh=0f9esdWuiStJECWkAZn/SOlcYyopP8tRdxicHx6d+OE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tQIuYTX7Y8ndmbugWjDJuqFowJB7D7ZiJxGsYXMan2X1frNeiQ8YGxQbMg/3yjLaC
	 mqcqv8ai0cWhv8xBVcbfBQpuQ5wQ0hZVJkOV7CsP44+KjcBLqFev+qnLGGbZIvaZp5
	 Iw6JDOMtoJtnRmlC4yfsSzjwuCDB8EyyQXkNoxXOLyB+CYFj1SNTamNdmpO1LynQVA
	 8NTSwP3+ugqRYINZ0tVfKinm8YF9hz2cD2+xDPe+Hzu1PCLOy/GHfbhg6Ti4v5S968
	 9IYlgNeSyv5X7YRW6lgBAjuE10VbPCOosZNhY+J2bpgkX+BawOq3FAYObFLenZM1y1
	 23bIt1hqFSnqQ==
Date: Fri, 17 Oct 2025 14:10:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Ron Economos <re@w6rz.net>
Subject: Re: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Message-ID: <20251017191005.GA1041995@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-ecam_fix-v1-1-f6faa3d0edf3@oss.qualcomm.com>

On Fri, Oct 17, 2025 at 05:10:53PM +0530, Krishna Chaitanya Chundru wrote:
> When the vendor configuration space is 256MB aligned, the DesignWare
> PCIe host driver enables ECAM access and sets the DBI base to the start
> of the config space. This causes vendor drivers to incorrectly program
> iATU regions, as they rely on the DBI address for internal accesses.
> 
> To fix this, avoid overwriting the DBI base when ECAM is enabled.
> Instead, introduce a custom ECAM PCI ops implementation that accesses
> the DBI region directly for bus 0 and uses ECAM for other buses.
> 
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Reported-by: Ron Economos <re@w6rz.net>
> Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -23,6 +23,7 @@
>  #include "pcie-designware.h"
>  
>  static struct pci_ops dw_pcie_ops;
> +static struct pci_ops dw_pcie_ecam_ops;
>  static struct pci_ops dw_child_pcie_ops;
>  
>  #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
> @@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
>  	if (IS_ERR(pp->cfg))
>  		return PTR_ERR(pp->cfg);
>  
> -	pci->dbi_base = pp->cfg->win;
> -	pci->dbi_phys_addr = res->start;
> -
>  	return 0;
>  }
>  
> @@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>  		if (ret)
>  			return ret;
>  
> -		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +		pp->bridge->ops = &dw_pcie_ecam_ops;
>  		pp->bridge->sysdata = pp->cfg;
>  		pp->cfg->priv = pp;
>  	} else {
> @@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>  
> +static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct dw_pcie_rp *pp = cfg->priv;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	unsigned int busn = bus->number;
> +
> +	if (busn > 0)
> +		return pci_ecam_map_bus(bus, devfn, where);

Is there a way to avoid the "root bus is bus 00" assumption here?  It
looks like something like this might work (it inverts the condition
to take care of the root bus special case first):

  if (bus == pp->bridge->bus) {
    if (PCI_SLOT(devfn) > 0)
      return NULL;

    return pci->dbi_base + where;
  }

  return pci_ecam_map_bus(bus, devfn, where);

> +	if (PCI_SLOT(devfn) > 0)
> +		return NULL;

This essentially says only one function (00.0) can be on the root bus.
I assume that someday that will be relaxed and there may be multiple
Root Ports and maybe RCiEPs on the root bus, so it would be nice if we
didn't have to have this check.

What happens without it?  Does the IP return the ~0 data that the PCI
core would interpret as "there's no device here"?

Regardless, I love this series because it removes quite a bit of code
and seems so much cleaner.

> +	return pci->dbi_base + where;
> +}
> +
>  static struct pci_ops dw_pcie_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
>  };
>  
> +static struct pci_ops dw_pcie_ecam_ops = {
> +	.map_bus = dw_pcie_ecam_conf_map_bus,
> +	.read = pci_generic_config_read,
> +	.write = pci_generic_config_write,
> +};
> +
>  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> 
> -- 
> 2.34.1
> 

