Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB022966ED
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 00:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372677AbgJVWFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 18:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372572AbgJVWFU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 18:05:20 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF769C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5KB3nf4UeodmfioteMdNLE6bfKBGuLsolvX1C1f8NOs=; b=dPtd0EmQBJNqthqMWmsFqreB1
        3OcEN3HqWbsw9H5xZBJ5I12z6+AV8MK0GSZoyQ0/miMrXygrARpw22eRXgBIJyOu7Pr71moEk6Sno
        fiQEPAfErF/KnATNTCtk8Q9N1UKrsmGB2VDnDAL5UwTVFjzbZVqn81vB39pPnSGKEr5GCeexmKAQz
        961BJvVMJVDFm2D2RV1a5/NpVC7b6BdcKxFiBCHC6e4YEh4KNVR11ITo+S8UiFHSZ+aQe5kMoIQSw
        xy7hnk04EuJM49wF+bC0nMt41Z7R2jpX9Qo0sxPiq15JVsTBoaS60Ikg3f7rLpbMWYuaxgNKITe2q
        oRbSPUsUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49698)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kViho-0002d2-RG; Thu, 22 Oct 2020 23:05:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVihn-0007lo-KM; Thu, 22 Oct 2020 23:05:07 +0100
Date:   Thu, 22 Oct 2020 23:05:07 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rob Herring <robh@kernel.org>
Cc:     vtolkm@googlemail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Fix duplicate resource requests
Message-ID: <20201022220507.GW1551@shell.armlinux.org.uk>
References: <20201022220038.1339854-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022220038.1339854-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 05:00:38PM -0500, Rob Herring wrote:
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

Still doesn't work.

mvebu-pcie soc:pcie: resource collision: [io  0x1000-0xeffff] conflicts with System RAM [mem 0x00000000-0x3fffffff]
mvebu-pcie: probe of soc:pcie failed with error -16


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
> ---
> Untested, please test.
> 
>  drivers/pci/controller/pci-mvebu.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index c39978b750ec..c6fc8bd5e77f 100644
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
> +		ret = devm_request_resource(dev, &iomem_resource, &pcie->realio);

I think you're trying to claim this resource against the wrong parent.

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

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
