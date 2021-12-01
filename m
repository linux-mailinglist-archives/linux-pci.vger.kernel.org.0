Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA3465501
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbhLASTh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 13:19:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52802 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhLASTg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 13:19:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F341FCE1FF7;
        Wed,  1 Dec 2021 18:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA97CC53FAD;
        Wed,  1 Dec 2021 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638382571;
        bh=yOSDJMZjtWPYabp4viUFNlvsKGXcYL8j4zIuPOAf+nY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lNi2ifO8yG9kYNWfcv8AiQr/J/nGS8Z81b4pAUyt9JuAsa+WmHYkfijTzWHJ/vxoX
         8gFr4eLY6X+tMtyg71rr40oOVpqd/Q0HweveIGrpF0K86bq8oL1BMP2vehMM7HBD8B
         mqYDaP6KesBBbqwbGX8lBjviNbQj04gYu8kaRt2T4nXhi8TU5sJa4E7RVh/Ev2Ffck
         NJyCovBk4cEMMaeyBMpZ+mTIBNbBd9eHWb0aU5TX1lj+zinquNkYFj8tS7q1FtD3N8
         jFhrr10ONkIbGWfgVTSrzIpI6j1kvQyDadd2c6/jFV4ISxcATIXppBc5dN5DpeXttk
         go7bvWa+PYhSQ==
Date:   Wed, 1 Dec 2021 12:16:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/5] PCI: mt7621: avoid custom MIPS code in driver code
Message-ID: <20211201181609.GA2831753@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115070809.15529-4-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/avoid custom/Avoid custom/ in subject.

On Mon, Nov 15, 2021 at 08:08:07AM +0100, Sergio Paracuellos wrote:
> Driver code is setting up MIPS specific I/O coherency units addresses config.
> This MIPS specific thing has been moved to be done when PCI code call the
> 'pcibios_root_bridge_prepare()' function which has been implemented for MIPS
> ralink mt7621 platform. Hence, remove MIPS specific code from driver code.
> After this changes there is also no need to add any MIPS specific includes
> to avoid some errors reported by Kernet Tets Robot with W=1 builds.

s/this changes/this change/
s/Tets/Test/

The patch doesn't touch any #include lines, so I'm not sure what the
last sentence is telling us.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 37 ----------------------------
>  1 file changed, 37 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index b60dfb45ef7b..9cf541f5de9c 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -208,37 +208,6 @@ static inline void mt7621_control_deassert(struct mt7621_pcie_port *port)
>  		reset_control_assert(port->pcie_rst);
>  }
>  
> -static int setup_cm_memory_region(struct pci_host_bridge *host)
> -{
> -	struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
> -	struct device *dev = pcie->dev;
> -	struct resource_entry *entry;
> -	resource_size_t mask;
> -
> -	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
> -	if (!entry) {
> -		dev_err(dev, "cannot get memory resource\n");
> -		return -EINVAL;
> -	}
> -
> -	if (mips_cps_numiocu(0)) {
> -		/*
> -		 * FIXME: hardware doesn't accept mask values with 1s after
> -		 * 0s (e.g. 0xffef), so it would be great to warn if that's
> -		 * about to happen
> -		 */
> -		mask = ~(entry->res->end - entry->res->start);
> -
> -		write_gcr_reg1_base(entry->res->start);
> -		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> -		dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> -			 (unsigned long long)read_gcr_reg1_base(),
> -			 (unsigned long long)read_gcr_reg1_mask());
> -	}
> -
> -	return 0;
> -}
> -
>  static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
>  				  struct device_node *node,
>  				  int slot)
> @@ -557,12 +526,6 @@ static int mt7621_pci_probe(struct platform_device *pdev)
>  		goto remove_resets;
>  	}
>  
> -	err = setup_cm_memory_region(bridge);
> -	if (err) {
> -		dev_err(dev, "error setting up iocu mem regions\n");
> -		goto remove_resets;
> -	}
> -
>  	return mt7621_pcie_register_host(bridge);
>  
>  remove_resets:
> -- 
> 2.33.0
> 
