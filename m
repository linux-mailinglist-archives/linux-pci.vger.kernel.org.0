Return-Path: <linux-pci+bounces-19770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993BDA112C0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD397A3A41
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7220CCC9;
	Tue, 14 Jan 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTkSd/ls"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5E8493;
	Tue, 14 Jan 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889144; cv=none; b=MnPVhfseukfsew79+9A4pKPRLVOiM48HrrLbO/4hRUgfGn54jxtK5CgDDiio1rC6ErpnJA3Q4GZ3KK0lOQyTvV7gw8Kqx+A7Dlrb7IWnpAOyOsviOzlnucgrVKK6xXO7oPAZ2RzZTMebFYue/ug+8dqfFUebul+dmqr2l+ghRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889144; c=relaxed/simple;
	bh=j5+QlpIMYId8de/vPcPQZROkeaf0+OsNA6B/r6x/eow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a0yiFwOcFPiMwWdnbTVXYuqvRZZynMiH7qC5mUi8Vc5NV02gvSplmJtBd7Am7mfJkKo2Iwb20TJpgK3MY5QQw0GPPmsK0k+pJA+2LqqctMpqfjEOmcob2s87L9tvDtA+YajVTc82wTXt2EIRgcQRfDirp4zQx0HcFn0FXSA9ato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTkSd/ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E43C4CEDD;
	Tue, 14 Jan 2025 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736889144;
	bh=j5+QlpIMYId8de/vPcPQZROkeaf0+OsNA6B/r6x/eow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nTkSd/lsfwgurxdIOlgpN8KqJxMb/OU4VueKA1sx2aCsQ0iMrCKyf4quqY2hn/+Mq
	 V4gXPap4CRiXvsXcZf4leD42wV2G2igGRKLzxOE5B6gzDFjuM8Ay9zCCmc3lUTHz5z
	 ZNshOe448F0EImpvW70avVUL4u0EruMf2YmmiZyPiPczHwow+M4bMbm+c/NrGjvKnZ
	 zSChKx9hkD2uvSrHNjv+hqr5inlEqirohL1QkNPjQFRdXUm+Ut1ov4HaAzJgjlxOhp
	 Zn1gpiC8xpxLhoseJr57KPOcFgIi93UQv63Ys4346ZyDmtlOQyWnSTSy1BxZB7bt3T
	 zA+eC9ZQDc2zg==
Date: Tue, 14 Jan 2025 15:12:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com
Subject: Re: [PATCH] PCI: Batch BAR sizing operations
Message-ID: <20250114211222.GA487541@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111210652.402845-1-alex.williamson@redhat.com>

On Sat, Jan 11, 2025 at 02:06:51PM -0700, Alex Williamson wrote:
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

Applied to pci/enumeration for v6.14, thanks.

> ---
> 
> This is an alternative to the patch proposed by Mitchell[1] and more
> in line with my suggestion in the original report thread[2].  It makes
> more sense to me to stash all the BAR sizing values into an array on
> the front end of parsing them into resources than it does to pass
> multiple arrays on the backend for status printing purposes.  We can
> discuss in either of these patches which is the better approach or
> if someone has a better yet alternative.
> 
> I don't have quite the config Mitchell has for testing, but this
> should make effectively the same improvement and does show a
> significant improvement in guest boot time even with a single 24GB
> GPU attached.  There are of course further improvements to investigate
> in the VMM, but disabling memory decode per BAR is a good start to
> making Linux be a friendlier guest.  Further testing appreciate.
> Thanks,
> 
> Alex
> 
> [1]https://lore.kernel.org/all/20241218224258.2225210-1-mitchell.augustin@canonical.com/
> [2]https://lore.kernel.org/all/20241203150620.15431c5c.alex.williamson@redhat.com/
> 
>  drivers/pci/iov.c   |   8 ++-
>  drivers/pci/pci.h   |   4 +-
>  drivers/pci/probe.c | 132 +++++++++++++++++++++++++++++---------------
>  3 files changed, 97 insertions(+), 47 deletions(-)
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
> index 2e81ab0f5a25..5ca96280d698 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -164,50 +164,75 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
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
> +
> +		/*
> +		 * All bits set in size means the device isn't working properly.
> +		 * If the BAR isn't implemented, all bits must be 0.  If it's a
> +		 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR,
> +		 * bit 1 must be clear.
> +		 */
> +		if (PCI_POSSIBLE_ERROR(*sizes))
> +			*sizes = 0;
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
> +	u32 l = 0;
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
> -
> -	/*
> -	 * All bits set in sz means the device isn't working properly.
> -	 * If the BAR isn't implemented, all bits must be 0.  If it's a
> -	 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR, bit
> -	 * 1 must be clear.
> -	 */
> -	if (PCI_POSSIBLE_ERROR(sz))
> -		sz = 0;
>  
>  	/*
>  	 * I don't know how l can have all bits set.  Copied from old code.
> @@ -221,35 +246,30 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		res->flags |= IORESOURCE_SIZEALIGN;
>  		if (res->flags & IORESOURCE_IO) {
>  			l64 = l & PCI_BASE_ADDRESS_IO_MASK;
> -			sz64 = sz & PCI_BASE_ADDRESS_IO_MASK;
> +			sz64 = *sizes & PCI_BASE_ADDRESS_IO_MASK;
>  			mask64 = PCI_BASE_ADDRESS_IO_MASK & (u32)IO_SPACE_LIMIT;
>  		} else {
>  			l64 = l & PCI_BASE_ADDRESS_MEM_MASK;
> -			sz64 = sz & PCI_BASE_ADDRESS_MEM_MASK;
> +			sz64 = *sizes & PCI_BASE_ADDRESS_MEM_MASK;
>  			mask64 = (u32)PCI_BASE_ADDRESS_MEM_MASK;
> +
> +			if (res->flags & IORESOURCE_MEM_64) {
> +				pci_read_config_dword(dev, pos + 4, &l);
> +				sizes++;
> +
> +				l64 |= ((u64)l << 32);
> +				sz64 |= ((u64)*sizes << 32);
> +				mask64 |= ((u64)~0 << 32);
> +			}
>  		}
>  	} else {
>  		if (l & PCI_ROM_ADDRESS_ENABLE)
>  			res->flags |= IORESOURCE_ROM_ENABLE;
>  		l64 = l & PCI_ROM_ADDRESS_MASK;
> -		sz64 = sz & PCI_ROM_ADDRESS_MASK;
> +		sz64 = *sizes & PCI_ROM_ADDRESS_MASK;
>  		mask64 = PCI_ROM_ADDRESS_MASK;
>  	}
>  
> -	if (res->flags & IORESOURCE_MEM_64) {
> -		pci_read_config_dword(dev, pos + 4, &l);
> -		pci_write_config_dword(dev, pos + 4, ~0);
> -		pci_read_config_dword(dev, pos + 4, &sz);
> -		pci_write_config_dword(dev, pos + 4, l);
> -
> -		l64 |= ((u64)l << 32);
> -		sz64 |= ((u64)sz << 32);
> -		mask64 |= ((u64)~0 << 32);
> -	}
> -
> -	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> -		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> -
>  	if (!sz64)
>  		goto fail;
>  
> @@ -320,7 +340,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
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
> @@ -329,10 +353,28 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
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
> @@ -340,7 +382,7 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
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

