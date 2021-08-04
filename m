Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A593E060E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhHDQkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhHDQkW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 12:40:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3234C60243;
        Wed,  4 Aug 2021 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628095209;
        bh=3Kyek9w1qA9n8pYemGgc9Ahby2q7ijSKgZlPqfiGF/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hn3gmPbb0FkIk+XwMti9fqPhS8tVZL2kytiRkMRFDeMsDfj12vchnRhYyq2wedQ7m
         o506pThpHjErU1LUzA/TEa/0Wyc6KEVALg9o14eLHygbsZQpvMKLasbQUqzdBOAfxj
         6uYAM7ixsDy6aCwz+NnScBCJ0JzT+jPdWmavuFrud8K3T4AQjgijaawx3y2bNjsIaq
         hG/EQMPVJuLtoMGDopuv1RwG7DuABn6T4Yu8FR5u1f3JTgPoiCn/9/z+3mdm9jDD13
         axQe//zrviVZCFUeq07aaEmmqy3QH9lX/+Woz8qJcYvRW1reCg3R1FIz3kHxZN01qQ
         dPYSgLxMzdMQw==
Date:   Wed, 4 Aug 2021 11:40:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio =?iso-8859-1?Q?Migu=E9ns?= Iglesias <lonyelon@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergio =?iso-8859-1?Q?Migu=E9ns?= Iglesias <sergio@lony.xyz>
Subject: Re: [PATCH] pci: probe: Fixed code style
Message-ID: <20210804164007.GA1648919@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804144219.791004-1-sergio@lony.xyz>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 04, 2021 at 04:42:19PM +0200, Sergio Miguéns Iglesias wrote:
> Fixed the code style for "drivers/pci/probe.c".

Thanks for looking at this.

Read https://chris.beams.io/posts/git-commit/ and
https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

> Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
> ---
>  drivers/pci/probe.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 79177ac37880..b584822868d1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -110,6 +110,7 @@ postcore_initcall(pcibus_class_init);
>  static u64 pci_size(u64 base, u64 maxbase, u64 mask)
>  {
>  	u64 size = mask & maxbase;	/* Find the significant bits */
> +
>  	if (!size)
>  		return 0;
>  
> @@ -331,12 +332,14 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  
>  	for (pos = 0; pos < howmany; pos++) {
>  		struct resource *res = &dev->resource[pos];
> +
>  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
>  		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
>  	}
>  
>  	if (rom) {
>  		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
> +
>  		dev->rom_base_reg = rom;
>  		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
>  				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
> @@ -1376,6 +1379,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			 */
>  			for (i = 0; i < CARDBUS_RESERVE_BUSNR; i++) {
>  				struct pci_bus *parent = bus;
> +
>  				if (pci_find_bus(pci_domain_nr(bus),
>  							max+i+1))
>  					break;
> @@ -1880,6 +1884,7 @@ int pci_setup_device(struct pci_dev *dev)
>  		 */
>  		if (class == PCI_CLASS_STORAGE_IDE) {
>  			u8 progif;
> +
>  			pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
>  			if ((progif & 1) == 0) {
>  				region.start = 0x1F0;
> @@ -1948,7 +1953,7 @@ int pci_setup_device(struct pci_dev *dev)
>  			dev->hdr_type);
>  		return -EIO;
>  
> -	bad:
> +bad:
>  		pci_err(dev, "ignoring class %#08x (doesn't match header type %02x)\n",
>  			dev->class, dev->hdr_type);
>  		dev->class = PCI_CLASS_NOT_DEFINED << 8;
> @@ -2155,9 +2160,9 @@ static void pci_configure_ltr(struct pci_dev *dev)
>  	 * Complex and all intermediate Switches indicate support for LTR.
>  	 * PCIe r4.0, sec 6.18.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	    ((bridge = pci_upstream_bridge(dev)) &&
> -	      bridge->ltr_path)) {
> +	bridge = pci_upstream_bridge(dev);
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT || (bridge &&
> +		bridge->ltr_path)) {
>  		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_LTR_EN);
>  		dev->ltr_path = 1;
> @@ -2543,11 +2548,11 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>  }
>  EXPORT_SYMBOL(pci_scan_single_device);
>  
> -static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
> +static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned int fn)
>  {
>  	int pos;
>  	u16 cap = 0;
> -	unsigned next_fn;
> +	unsigned int next_fn;
>  
>  	if (pci_ari_enabled(bus)) {
>  		if (!dev)
> @@ -2606,7 +2611,7 @@ static int only_one_child(struct pci_bus *bus)
>   */
>  int pci_scan_slot(struct pci_bus *bus, int devfn)
>  {
> -	unsigned fn, nr = 0;
> +	unsigned int fn, nr = 0;
>  	struct pci_dev *dev;
>  
>  	if (only_one_child(bus) && (devfn > 0))
> @@ -3190,11 +3195,11 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
>  	pci_add_resource(&resources, &iomem_resource);
>  	pci_add_resource(&resources, &busn_resource);
>  	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
> -	if (b) {
> +	if (b)
>  		pci_scan_child_bus(b);
> -	} else {
> +	else
>  		pci_free_resource_list(&resources);
> -	}
> +
>  	return b;
>  }
>  EXPORT_SYMBOL(pci_scan_bus);
> @@ -3269,14 +3274,20 @@ static int __init pci_sort_bf_cmp(const struct device *d_a,
>  	const struct pci_dev *a = to_pci_dev(d_a);
>  	const struct pci_dev *b = to_pci_dev(d_b);
>  
> -	if      (pci_domain_nr(a->bus) < pci_domain_nr(b->bus)) return -1;
> -	else if (pci_domain_nr(a->bus) > pci_domain_nr(b->bus)) return  1;
> +	if (pci_domain_nr(a->bus) < pci_domain_nr(b->bus))
> +		return -1;
> +	else if (pci_domain_nr(a->bus) > pci_domain_nr(b->bus))
> +		return  1;
>  
> -	if      (a->bus->number < b->bus->number) return -1;
> -	else if (a->bus->number > b->bus->number) return  1;
> +	if (a->bus->number < b->bus->number)
> +		return -1;
> +	else if (a->bus->number > b->bus->number)
> +		return  1;
>  
> -	if      (a->devfn < b->devfn) return -1;
> -	else if (a->devfn > b->devfn) return  1;
> +	if (a->devfn < b->devfn)
> +		return -1;
> +	else if (a->devfn > b->devfn)
> +		return  1;
>  
>  	return 0;
>  }
> -- 
> 2.32.0
> 
