Return-Path: <linux-pci+bounces-20167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B3AA174C2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 23:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2403A38D6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 22:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE2F1684A4;
	Mon, 20 Jan 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV7tkE6X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058984689;
	Mon, 20 Jan 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737413061; cv=none; b=irY0VOA7al7S2SDGWF06/JZUy83M4GsdT7O82wMHdB1XR30MlxXBfxuL4MaFjqTs4GUolM8h2qjh3Hlp2txhQRXJfWjGDOO909ExfC+qyXnQUAWsB+80prNIAGvEEH/bFdG/OMe2j9kkWWhmuuGzTLgFLUR3qVW88s0l/wUfmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737413061; c=relaxed/simple;
	bh=v+/gog/rTF1u+nLKrw2nvLQT6ZQtvRngkq8OhjNlPmg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=roSOfJrBC7Rtq6z4W2mhS+kw+r7c/tJEfCCo89fD1HHXutxxD+cpnR6OphbsCItu2mhtEgJjnfgfOM0zc9NHU37lLcR5GjjRm0+E5+SKoUI3Hmat2YvYR2EALB+2LrW++nL17koOKWwUvYgMxISmFRbUVJjxodvo/6ObaDLLFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV7tkE6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C4AC4CEDD;
	Mon, 20 Jan 2025 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737413060;
	bh=v+/gog/rTF1u+nLKrw2nvLQT6ZQtvRngkq8OhjNlPmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sV7tkE6X7yWcqNtLlU8xzRfaJAst24tA9BFjGNxWFMPm2nWeVeZwOe1IzYni3vaKM
	 iqJmv7aHfdW3QdRjeYCyoy9ocvGcmFRf2o4MXfIf88DEoTN3flxpFarB6lrIX1vgj5
	 6j6skmq8hw19dQiwo0vu/ZgdNbuqlWSO96fcPKVLleisY5h6q2y4ayREqHOG9sTo49
	 dZ906KjQaW4frZmkliFoU9JXdNMEGuuHZX8gQ9heb7fZHmoERHTxHV0Ya36/QT1HU3
	 C1zNPsAt0GpZttX9obVOOSsyQkOpBswr5W9Y2frYfVc8BCVAEhQS1CqxMHoAEsBnQt
	 sk19RhhZ5zhZQ==
Date: Mon, 20 Jan 2025 16:44:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
Message-ID: <20250120224418.GA906057@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120182202.1878581-1-alex.williamson@redhat.com>

On Mon, Jan 20, 2025 at 11:21:59AM -0700, Alex Williamson wrote:
> Toggling memory enable is free on bare metal, but potentially expensive
> in virtualized environments as the device MMIO spaces are added and
> removed from the VM address space, including DMA mapping of those spaces
> through the IOMMU where peer-to-peer is supported.  Currently memory
> decode is disabled around sizing each individual BAR, even for SR-IOV
> BARs while VF Enable is cleared.
> 
> This can be better optimized for virtual environments by sizing a set
> of BARs at once, stashing the resulting mask into an array, while only
> toggling memory enable once.  This also naturally improves the SR-IOV
> path as the caller becomes responsible for any necessary decode disables
> while sizing BARs, therefore SR-IOV BARs are sized relying only on the
> VF Enable rather than toggling the PF memory enable in the command
> register.
> 
> Reported-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Updated pci/enumeration with this v2, thanks, Alex!

> ---
> 
> v2:
>  - Move PCI_POSSIBLE_ERROR() test back to original location such that it
>    only tests the lower half of 64-bit BARs as noted by Ilpo Järvinen.
>  - Reduce delta from original code by retaining the local @sz variable
>    filled from the @sizes array and keep location of parsing upper half
>    of 64-bit BARs.
> 
>  drivers/pci/iov.c   |  8 +++-
>  drivers/pci/pci.h   |  4 +-
>  drivers/pci/probe.c | 93 +++++++++++++++++++++++++++++++++------------
>  3 files changed, 78 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4be402fe9ab9..9e4770cdd4d5 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -747,6 +747,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	struct resource *res;
>  	const char *res_name;
>  	struct pci_dev *pdev;
> +	u32 sriovbars[PCI_SRIOV_NUM_BARS];
>  
>  	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
>  	if (ctrl & PCI_SRIOV_CTRL_VFE) {
> @@ -783,6 +784,10 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	if (!iov)
>  		return -ENOMEM;
>  
> +	/* Sizing SR-IOV BARs with VF Enable cleared - no decode */
> +	__pci_size_stdbars(dev, PCI_SRIOV_NUM_BARS,
> +			   pos + PCI_SRIOV_BAR, sriovbars);
> +
>  	nres = 0;
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>  		res = &dev->resource[i + PCI_IOV_RESOURCES];
> @@ -796,7 +801,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  			bar64 = (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
>  		else
>  			bar64 = __pci_read_base(dev, pci_bar_unknown, res,
> -						pos + PCI_SRIOV_BAR + i * 4);
> +						pos + PCI_SRIOV_BAR + i * 4,
> +						&sriovbars[i]);
>  		if (!res->flags)
>  			continue;
>  		if (resource_size(res) & (PAGE_SIZE - 1)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..6f27651c2a70 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -315,8 +315,10 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_timeout);
>  
>  int pci_setup_device(struct pci_dev *dev);
> +void __pci_size_stdbars(struct pci_dev *dev, int count,
> +			unsigned int pos, u32 *sizes);
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> -		    struct resource *res, unsigned int reg);
> +		    struct resource *res, unsigned int reg, u32 *sizes);
>  void pci_configure_ari(struct pci_dev *dev);
>  void __pci_bus_size_bridges(struct pci_bus *bus,
>  			struct list_head *realloc_head);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..bf6aec555044 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -164,41 +164,67 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
>  
>  #define PCI_COMMAND_DECODE_ENABLE	(PCI_COMMAND_MEMORY | PCI_COMMAND_IO)
>  
> +/**
> + * __pci_size_bars - Read the raw BAR mask for a range of PCI BARs
> + * @dev: the PCI device
> + * @count: number of BARs to size
> + * @pos: starting config space position
> + * @sizes: array to store mask values
> + * @rom: indicate whether to use ROM mask, which avoids enabling ROM BARs
> + *
> + * Provided @sizes array must be sufficiently sized to store results for
> + * @count u32 BARs.  Caller is responsible for disabling decode to specified
> + * BAR range around calling this function.  This function is intended to avoid
> + * disabling decode around sizing each BAR individually, which can result in
> + * non-trivial overhead in virtualized environments with very large PCI BARs.
> + */
> +static void __pci_size_bars(struct pci_dev *dev, int count,
> +			    unsigned int pos, u32 *sizes, bool rom)
> +{
> +	u32 orig, mask = rom ? PCI_ROM_ADDRESS_MASK : ~0;
> +	int i;
> +
> +	for (i = 0; i < count; i++, pos += 4, sizes++) {
> +		pci_read_config_dword(dev, pos, &orig);
> +		pci_write_config_dword(dev, pos, mask);
> +		pci_read_config_dword(dev, pos, sizes);
> +		pci_write_config_dword(dev, pos, orig);
> +	}
> +}
> +
> +void __pci_size_stdbars(struct pci_dev *dev, int count,
> +			unsigned int pos, u32 *sizes)
> +{
> +	__pci_size_bars(dev, count, pos, sizes, false);
> +}
> +
> +static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 *sizes)
> +{
> +	__pci_size_bars(dev, 1, pos, sizes, true);
> +}
> +
>  /**
>   * __pci_read_base - Read a PCI BAR
>   * @dev: the PCI device
>   * @type: type of the BAR
>   * @res: resource buffer to be filled in
>   * @pos: BAR position in the config space
> + * @sizes: array of one or more pre-read BAR masks
>   *
>   * Returns 1 if the BAR is 64-bit, or 0 if 32-bit.
>   */
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> -		    struct resource *res, unsigned int pos)
> +		    struct resource *res, unsigned int pos, u32 *sizes)
>  {
> -	u32 l = 0, sz = 0, mask;
> +	u32 l = 0, sz;
>  	u64 l64, sz64, mask64;
> -	u16 orig_cmd;
>  	struct pci_bus_region region, inverted_region;
>  	const char *res_name = pci_resource_name(dev, res - dev->resource);
>  
> -	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
> -
> -	/* No printks while decoding is disabled! */
> -	if (!dev->mmio_always_on) {
> -		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> -		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> -			pci_write_config_word(dev, PCI_COMMAND,
> -				orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> -		}
> -	}
> -
>  	res->name = pci_name(dev);
>  
>  	pci_read_config_dword(dev, pos, &l);
> -	pci_write_config_dword(dev, pos, l | mask);
> -	pci_read_config_dword(dev, pos, &sz);
> -	pci_write_config_dword(dev, pos, l);
> +	sz = sizes[0];
>  
>  	/*
>  	 * All bits set in sz means the device isn't working properly.
> @@ -238,18 +264,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  
>  	if (res->flags & IORESOURCE_MEM_64) {
>  		pci_read_config_dword(dev, pos + 4, &l);
> -		pci_write_config_dword(dev, pos + 4, ~0);
> -		pci_read_config_dword(dev, pos + 4, &sz);
> -		pci_write_config_dword(dev, pos + 4, l);
> +		sz = sizes[1];
>  
>  		l64 |= ((u64)l << 32);
>  		sz64 |= ((u64)sz << 32);
>  		mask64 |= ((u64)~0 << 32);
>  	}
>  
> -	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> -		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> -
>  	if (!sz64)
>  		goto fail;
>  
> @@ -320,7 +341,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  
>  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  {
> +	u32 rombar, stdbars[PCI_STD_NUM_BARS];
>  	unsigned int pos, reg;
> +	u16 orig_cmd;
> +
> +	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
>  
>  	if (dev->non_compliant_bars)
>  		return;
> @@ -329,10 +354,28 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  	if (dev->is_virtfn)
>  		return;
>  
> +	/* No printks while decoding is disabled! */
> +	if (!dev->mmio_always_on) {
> +		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> +		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> +			pci_write_config_word(dev, PCI_COMMAND,
> +				orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> +		}
> +	}
> +
> +	__pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
> +	if (rom)
> +		__pci_size_rom(dev, rom, &rombar);
> +
> +	if (!dev->mmio_always_on &&
> +	    (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> +		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> +
>  	for (pos = 0; pos < howmany; pos++) {
>  		struct resource *res = &dev->resource[pos];
>  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
> -		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
> +		pos += __pci_read_base(dev, pci_bar_unknown,
> +				       res, reg, &stdbars[pos]);
>  	}
>  
>  	if (rom) {
> @@ -340,7 +383,7 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  		dev->rom_base_reg = rom;
>  		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
>  				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
> -		__pci_read_base(dev, pci_bar_mem32, res, rom);
> +		__pci_read_base(dev, pci_bar_mem32, res, rom, &rombar);
>  	}
>  }
>  
> -- 
> 2.47.1
> 

