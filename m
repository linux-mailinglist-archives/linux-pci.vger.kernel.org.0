Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8C2D63C6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 18:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392726AbgLJRi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 12:38:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392749AbgLJRiw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 12:38:52 -0500
Date:   Thu, 10 Dec 2020 11:38:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607621891;
        bh=Jt/rS+Orf2uioeOupCM3899T+XaOSvBgyZaJeCTKt9Y=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=bocdeTmMqucA7yeYMkg3ZgCDzTCJYV86BzbmOfNN52hMUFnZkzLBkYXtashzdEAKZ
         8zdNDZt+TFjP4znVnxcxSalum/4p+obJO/zs+7QgHUDaPX3he6MzWDZBvhrm983aT7
         DvAYgPOUt5ftCErUiviftAFriRVVQ7diBQVjGlbuaFcLAkM8C+awYN04t9mYrBn8pT
         ncQNESZSuloce9kqD/aSsyvF/X6yxCoTQwXc0w/2jObMaFh0BPCfm7tZ8gOrrjNZ0O
         rGNNC91G1g09We5oeL9eGngFlsur5PfSTGprZIbk1TfFZ4B04dK/L/Z6GcrlhaAcP/
         ShSAJQOTYgH+g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, lorenzo.pieralisi@arm.com,
        kw@linux.com, heiko@sntech.de, benh@kernel.crashing.org,
        shawn.lin@rock-chips.com, paulus@samba.org,
        thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de,
        Alexandru Marginean <alexm.osslist@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201210173809.GA37355@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209202904.2juzokqhleusgsts@skbuf>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 10:29:04PM +0200, Vladimir Oltean wrote:
> On Wed, Dec 09, 2020 at 04:40:52PM +0100, Michael Walle wrote:
> > Hopefully my mail client won't mess up the output that much.
> 
> I can reproduce on my LS1028A as well. The following fixes the bug for
> me. I did not follow the discussion and see if it is helpful for others.
> I don't understand how the bug came to be. There might be more to it
> than what I'm seeing. If it's just what I'm seeing, then the patch was
> pretty broken to begin with.

I squashed the fix below into a pci/ecam branch for v5.11, thanks!

> -----------------------------[cut here]-----------------------------
> From b184da4088c9d39d25fee2486941cdf77688a409 Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Wed, 9 Dec 2020 22:17:32 +0200
> Subject: [PATCH] PCI: fix invalid window size for the ECAM config space
> 
> The blamed commit forgot that pci_ecam_create() calculates the size of
> the window for the ECAM's config space based on the spacing between two
> buses. The drivers whose .bus_shift from struct pci_ecam_ops was changed
> to zero in this commit are now using this invalid value for bus_shift
> in calculating the window size.
> 
> Before (broken):
> pci_ecam_create: remapping config space from addr 0x1f0000000, bus_range 0x1, bsz 0x1
> After (fixed/restored):
> pci_ecam_create: remapping config space from addr 0x1f0000000, bus_range 0x1, bsz 0x100000
> 
> Fixes: f3c07cf6924e ("PCI: Unify ECAM constants in native PCI Express drivers")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/pci/ecam.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 59f91d434859..9fda0d49bc93 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -28,11 +28,19 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
>  		struct resource *cfgres, struct resource *busr,
>  		const struct pci_ecam_ops *ops)
>  {
> +	unsigned int bus_shift = ops->bus_shift;
>  	struct pci_config_window *cfg;
>  	unsigned int bus_range, bus_range_max, bsz;
>  	struct resource *conflict;
>  	int i, err;
>  
> +	/*
> +	 * struct pci_ecam_ops may omit specifying bus_shift
> +	 * if it is as per spec
> +	 */
> +	if (!bus_shift)
> +		bus_shift = PCIE_ECAM_BUS_SHIFT;
> +
>  	if (busr->start > busr->end)
>  		return ERR_PTR(-EINVAL);
>  
> @@ -46,14 +54,14 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
>  	cfg->busr.end = busr->end;
>  	cfg->busr.flags = IORESOURCE_BUS;
>  	bus_range = resource_size(&cfg->busr);
> -	bus_range_max = resource_size(cfgres) >> ops->bus_shift;
> +	bus_range_max = resource_size(cfgres) >> bus_shift;
>  	if (bus_range > bus_range_max) {
>  		bus_range = bus_range_max;
>  		cfg->busr.end = busr->start + bus_range - 1;
>  		dev_warn(dev, "ECAM area %pR can only accommodate %pR (reduced from %pR desired)\n",
>  			 cfgres, &cfg->busr, busr);
>  	}
> -	bsz = 1 << ops->bus_shift;
> +	bsz = 1 << bus_shift;
>  
>  	cfg->res.start = cfgres->start;
>  	cfg->res.end = cfgres->end;
> -----------------------------[cut here]-----------------------------
