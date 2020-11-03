Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CF92A502C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgKCTcR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 14:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgKCTcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 14:32:16 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26511221FB;
        Tue,  3 Nov 2020 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604431936;
        bh=2K5q4ZQyuHLsG5CbG0sHnQmUZC/OMN8cG5tnBnbW8+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=viyvm34vrTDTK4zgvVTJIno48nrwpNSyfY9wJSB6QIs8TKbjJOscmp1r7X+lsKgI+
         20T6eIOv0ZPKd+mkIc/AbJCMa+QFEtpOVpiGSMXGkiqElTIP5LPlxDLaT/4xEc+VIY
         2sbb0MaALmCKV+f9qqANvlORne3Cfg1auHtYYtTQ=
Date:   Tue, 3 Nov 2020 13:32:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     vtolkm@googlemail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: mvebu: Fix duplicate resource requests
Message-ID: <20201103193214.GA258358@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023145252.2691779-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 09:52:52AM -0500, Rob Herring wrote:
> With commit 669cbc708122 ("PCI: Move DT resource setup into
> devm_pci_alloc_host_bridge()"), the DT 'ranges' is parsed and populated
> into resources when the host bridge is allocated. The resources are
> requested as well, but that happens a 2nd time for the mvebu driver in
> mvebu_pcie_parse_request_resources(). We should only be requesting the
> additional resources added in mvebu_pcie_parse_request_resources().
> These are not added by default because the use custom properties rather
> than standard DT address translation.
> 
> Also, the bus ranges was also populated by default, so we can remove
> it from mvebu_pci_host_probe().
> 
> Fixes: 669cbc708122 ("PCI: Move DT resource setup into devm_pci_alloc_host_bridge()")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209729
> Reported-by: vtolkm@googlemail.com
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied with Jan's tested-by and Lorenzo's ack to for-linus for
v5.10, thanks!

> ---
> v2:
>  - Fix copy-n-paste error with ioport_resource
> ---
>  drivers/pci/controller/pci-mvebu.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index c39978b750ec..653c0b3d2912 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -960,25 +960,16 @@ static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
>  }
>  
>  /*
> - * We can't use devm_of_pci_get_host_bridge_resources() because we
> - * need to parse our special DT properties encoding the MEM and IO
> - * apertures.
> + * devm_of_pci_get_host_bridge_resources() only sets up translateable resources,
> + * so we need extra resource setup parsing our special DT properties encoding
> + * the MEM and IO apertures.
>   */
>  static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> -	struct device_node *np = dev->of_node;
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
>  	int ret;
>  
> -	/* Get the bus range */
> -	ret = of_pci_parse_bus_range(np, &pcie->busn);
> -	if (ret) {
> -		dev_err(dev, "failed to parse bus-range property: %d\n", ret);
> -		return ret;
> -	}
> -	pci_add_resource(&bridge->windows, &pcie->busn);
> -
>  	/* Get the PCIe memory aperture */
>  	mvebu_mbus_get_pcie_mem_aperture(&pcie->mem);
>  	if (resource_size(&pcie->mem) == 0) {
> @@ -988,6 +979,9 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>  
>  	pcie->mem.name = "PCI MEM";
>  	pci_add_resource(&bridge->windows, &pcie->mem);
> +	ret = devm_request_resource(dev, &iomem_resource, &pcie->mem);
> +	if (ret)
> +		return ret;
>  
>  	/* Get the PCIe IO aperture */
>  	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
> @@ -1001,9 +995,12 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>  		pcie->realio.name = "PCI I/O";
>  
>  		pci_add_resource(&bridge->windows, &pcie->realio);
> +		ret = devm_request_resource(dev, &ioport_resource, &pcie->realio);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return devm_request_pci_bus_resources(dev, &bridge->windows);
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
