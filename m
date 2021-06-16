Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E112F3AA690
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhFPWZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 18:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231702AbhFPWZ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 18:25:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8433E61159;
        Wed, 16 Jun 2021 22:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623882231;
        bh=5jpgqPY1x83qs5b9HXo/R6RwFGHHgxmM+YqIOckLd8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JeEnLMTEZYCcZSFmUSzgEp7CDOeyaitOmjmyvqTor6jugDkiTMidtJ+z2xBfyf/Iu
         wu2xCdEwMdFSfZuQWNdFA6CqjIhoO7Mtv+dTAnqFYlVxGSO8D4mVuVzQXHj3uoRRDs
         EsBr0NcX25W6zW6jS8D1iaDCp5PG5/cjbd4dzPQYHDaWExqJEZeffw0sWVwIA/LGC0
         zwTm7obq9+Mdj2DjdrKvDZ9Lf8ghIAoWegmuAaW9tfBrvr+OcETnFms7+2O43VrE4e
         5C3hDlgCrXudwxD8b8mg/zWydsxWa1XWXPNx1XuBFRRvXP+nOkDCl6TV4YmNM9eITu
         Arrqze1rzdo+w==
Date:   Wed, 16 Jun 2021 17:23:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dynamically map ECAM regions
Message-ID: <20210616222350.GA3013952@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1lhCAV-0002yb-50@rmk-PC.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 03:18:27PM +0100, Russell King wrote:
> Attempting to boot 32-bit ARM kernels under QEMU's 3.x virt models
> fails when we have more than 512M of RAM in the model as we run out
> of vmalloc space for the PCI ECAM regions. This failure will be
> silent when running libvirt, as the console in that situation is a
> PCI device.
> 
> In this configuration, the kernel maps the whole ECAM, which QEMU
> sets up for 256 buses, even when maybe only seven buses are in use.
> Each bus uses 1M of ECAM space, and ioremap() adds an additional
> guard page between allocations. The kernel vmap allocator will
> align these regions to 512K, resulting in each mapping eating 1.5M
> of vmalloc space. This means we need 384M of vmalloc space just to
> map all of these, which is very wasteful of resources.
> 
> Fix this by only mapping the ECAM for buses we are going to be using.
> In my setups, this is around seven buses in most guests, which is
> 10.5M of vmalloc space - way smaller than the 384M that would
> otherwise be required. This also means that the kernel can boot
> without forcing extra RAM into highmem with the vmalloc= argument,
> or decreasing the virtual RAM available to the guest.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied with Arnd's reviewed-by to pci/enumeration for v5.14, thanks!

> ---
>  drivers/pci/ecam.c       | 54 ++++++++++++++++++++++++++++++++++------
>  include/linux/pci-ecam.h |  1 +
>  2 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index d2a1920bb055..1c40d2506aef 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -32,7 +32,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
>  	struct pci_config_window *cfg;
>  	unsigned int bus_range, bus_range_max, bsz;
>  	struct resource *conflict;
> -	int i, err;
> +	int err;
>  
>  	if (busr->start > busr->end)
>  		return ERR_PTR(-EINVAL);
> @@ -50,6 +50,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
>  	cfg->busr.start = busr->start;
>  	cfg->busr.end = busr->end;
>  	cfg->busr.flags = IORESOURCE_BUS;
> +	cfg->bus_shift = bus_shift;
>  	bus_range = resource_size(&cfg->busr);
>  	bus_range_max = resource_size(cfgres) >> bus_shift;
>  	if (bus_range > bus_range_max) {
> @@ -77,13 +78,6 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
>  		cfg->winp = kcalloc(bus_range, sizeof(*cfg->winp), GFP_KERNEL);
>  		if (!cfg->winp)
>  			goto err_exit_malloc;
> -		for (i = 0; i < bus_range; i++) {
> -			cfg->winp[i] =
> -				pci_remap_cfgspace(cfgres->start + i * bsz,
> -						   bsz);
> -			if (!cfg->winp[i])
> -				goto err_exit_iomap;
> -		}
>  	} else {
>  		cfg->win = pci_remap_cfgspace(cfgres->start, bus_range * bsz);
>  		if (!cfg->win)
> @@ -129,6 +123,44 @@ void pci_ecam_free(struct pci_config_window *cfg)
>  }
>  EXPORT_SYMBOL_GPL(pci_ecam_free);
>  
> +static int pci_ecam_add_bus(struct pci_bus *bus)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	unsigned int bsz = 1 << cfg->bus_shift;
> +	unsigned int busn = bus->number;
> +	phys_addr_t start;
> +
> +	if (!per_bus_mapping)
> +		return 0;
> +
> +	if (busn < cfg->busr.start || busn > cfg->busr.end)
> +		return -EINVAL;
> +
> +	busn -= cfg->busr.start;
> +	start = cfg->res.start + busn * bsz;
> +
> +	cfg->winp[busn] = pci_remap_cfgspace(start, bsz);
> +	if (!cfg->winp[busn])
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void pci_ecam_remove_bus(struct pci_bus *bus)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	unsigned int busn = bus->number;
> +
> +	if (!per_bus_mapping || busn < cfg->busr.start || busn > cfg->busr.end)
> +		return;
> +
> +	busn -= cfg->busr.start;
> +	if (cfg->winp[busn]) {
> +		iounmap(cfg->winp[busn]);
> +		cfg->winp[busn] = NULL;
> +	}
> +}
> +
>  /*
>   * Function to implement the pci_ops ->map_bus method
>   */
> @@ -167,6 +199,8 @@ EXPORT_SYMBOL_GPL(pci_ecam_map_bus);
>  /* ECAM ops */
>  const struct pci_ecam_ops pci_generic_ecam_ops = {
>  	.pci_ops	= {
> +		.add_bus	= pci_ecam_add_bus,
> +		.remove_bus	= pci_ecam_remove_bus,
>  		.map_bus	= pci_ecam_map_bus,
>  		.read		= pci_generic_config_read,
>  		.write		= pci_generic_config_write,
> @@ -178,6 +212,8 @@ EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
>  /* ECAM ops for 32-bit access only (non-compliant) */
>  const struct pci_ecam_ops pci_32b_ops = {
>  	.pci_ops	= {
> +		.add_bus	= pci_ecam_add_bus,
> +		.remove_bus	= pci_ecam_remove_bus,
>  		.map_bus	= pci_ecam_map_bus,
>  		.read		= pci_generic_config_read32,
>  		.write		= pci_generic_config_write32,
> @@ -187,6 +223,8 @@ const struct pci_ecam_ops pci_32b_ops = {
>  /* ECAM ops for 32-bit read only (non-compliant) */
>  const struct pci_ecam_ops pci_32b_read_ops = {
>  	.pci_ops	= {
> +		.add_bus	= pci_ecam_add_bus,
> +		.remove_bus	= pci_ecam_remove_bus,
>  		.map_bus	= pci_ecam_map_bus,
>  		.read		= pci_generic_config_read32,
>  		.write		= pci_generic_config_write,
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 65d3d83015c3..944da75ff25c 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -55,6 +55,7 @@ struct pci_ecam_ops {
>  struct pci_config_window {
>  	struct resource			res;
>  	struct resource			busr;
> +	unsigned int			bus_shift;
>  	void				*priv;
>  	const struct pci_ecam_ops	*ops;
>  	union {
> -- 
> 2.20.1
> 
