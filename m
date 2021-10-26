Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35E843BD4E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbhJZWhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 18:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhJZWhu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 18:37:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6AC86109D;
        Tue, 26 Oct 2021 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635287726;
        bh=I9zp1fCJIGBRVHF2yfNDWbCvvH7cEodJYib3wjSH8aA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gcMr2CyR7abR+LPIV2H8aZlZmDs0pNYmaH5PaboLMGlWQSf4ZOGoVLWY5Bfg9UMA/
         Db4MW12YdkJng+wSdBJ0YX0r55Kuyyw4xrpTu+b6dubd4qrojm/f4oFnPj0hzuUA2R
         y8NaiWENPg7v8lb3AvfiXXEI2JcWGipbk7tml0fDcOMGX6xO6veUAETnquwD5gZy7q
         uJwcRVZPoDALBDrfJbMdjx3ll2Id8BD6GNdtqKVdGYNfudY0OMCLrJtGMZBptWknJF
         xBLM1lfGAFRgFV6ZHHqN/ct9kGhMe+zqUBqGPQ4oGtCq5ruoyUB8+imneV24+kCzV0
         4K5EnByEB8jWw==
Date:   Tue, 26 Oct 2021 17:35:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Use unsigned int type explicitly when declaring
 variables
Message-ID: <20211026223524.GA173774@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013014136.1117543-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 01:41:36AM +0000, Krzysztof Wilczyński wrote:
> The bare "unsigned" type implicitly means "unsigned int", but as per the
> preferred coding style the preference is to spell the completely type
> name explicitly to remove any possible ambiguity from the code.
> 
> Thus, update the bare use of "unsigned" to the preferred "unsigned int"
> to keep the style consistent throughout the kernel code base.
> 
>  No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Dropping this for now because there are approximately a zillion usages
like this and it doesn't seem worth fixing them all:

  $ git grep "\<unsigned\>" | grep -Ev "unsigned (char|short|int|long)" | grep -v Documentation | wc -l
  22112

Go ahead and shame my poor grep-fu :)

> ---
>  drivers/pci/controller/pci-thunder-ecam.c |  4 ++--
>  drivers/pci/msi.c                         |  3 ++-
>  drivers/pci/pci.c                         |  5 +++--
>  drivers/pci/probe.c                       |  7 ++++---
>  drivers/pci/quirks.c                      | 12 ++++++------
>  drivers/pci/rom.c                         |  2 +-
>  drivers/pci/setup-bus.c                   |  2 +-
>  7 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
> index ffd84656544f..e9d5ca245f5e 100644
> --- a/drivers/pci/controller/pci-thunder-ecam.c
> +++ b/drivers/pci/controller/pci-thunder-ecam.c
> @@ -17,7 +17,7 @@ static void set_val(u32 v, int where, int size, u32 *val)
>  {
>  	int shift = (where & 3) * 8;
>  
> -	pr_debug("set_val %04x: %08x\n", (unsigned)(where & ~3), v);
> +	pr_debug("set_val %04x: %08x\n", (unsigned int)(where & ~3), v);
>  	v >>= shift;
>  	if (size == 1)
>  		v &= 0xff;
> @@ -187,7 +187,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  	pr_debug("%04x:%04x - Fix pass#: %08x, where: %03x, devfn: %03x\n",
>  		 vendor_device & 0xffff, vendor_device >> 16, class_rev,
> -		 (unsigned) where, devfn);
> +		 (unsigned int)where, devfn);
>  
>  	/* Check for non type-00 header */
>  	if (cfg_type == 0) {
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0099a00af361..bdc6ba7f39f0 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -579,7 +579,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>  	return ret;
>  }
>  
> -static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
> +static void __iomem *msix_map_region(struct pci_dev *dev,
> +				     unsigned int nr_entries)
>  {
>  	resource_size_t phys_addr;
>  	u32 table_offset;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..fa4f27f747fd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6324,11 +6324,12 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
>   * cannot be left as a userspace activity).  DMA aliases should therefore
>   * be configured via quirks, such as the PCI fixup header quirk.
>   */
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from,
> +		       unsigned int nr_devfns)
>  {
>  	int devfn_to;
>  
> -	nr_devfns = min(nr_devfns, (unsigned) MAX_NR_DEVFNS - devfn_from);
> +	nr_devfns = min(nr_devfns, (unsigned int)MAX_NR_DEVFNS - devfn_from);
>  	devfn_to = devfn_from + nr_devfns - 1;
>  
>  	if (!dev->dma_alias_mask)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index d9fc02a71baa..51c0a33640e6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2550,11 +2550,12 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>  }
>  EXPORT_SYMBOL(pci_scan_single_device);
>  
> -static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
> +static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> +			    unsigned int fn)
>  {
>  	int pos;
>  	u16 cap = 0;
> -	unsigned next_fn;
> +	unsigned int next_fn;
>  
>  	if (pci_ari_enabled(bus)) {
>  		if (!dev)
> @@ -2613,7 +2614,7 @@ static int only_one_child(struct pci_bus *bus)
>   */
>  int pci_scan_slot(struct pci_bus *bus, int devfn)
>  {
> -	unsigned fn, nr = 0;
> +	unsigned int fn, nr = 0;
>  	struct pci_dev *dev;
>  
>  	if (only_one_child(bus) && (devfn > 0))
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4537d1ea14fd..67107840ce84 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -501,7 +501,7 @@ static void quirk_s3_64M(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
>  
> -static void quirk_io(struct pci_dev *dev, int pos, unsigned size,
> +static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
>  		     const char *name)
>  {
>  	u32 region;
> @@ -552,7 +552,7 @@ static void quirk_cs5536_vsa(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
>  
>  static void quirk_io_region(struct pci_dev *dev, int port,
> -				unsigned size, int nr, const char *name)
> +			    unsigned int size, int nr, const char *name)
>  {
>  	u16 region;
>  	struct pci_bus_region bus_region;
> @@ -666,7 +666,7 @@ static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int p
>  	base = devres & 0xffff;
>  	size = 16;
>  	for (;;) {
> -		unsigned bit = size >> 1;
> +		unsigned int bit = size >> 1;
>  		if ((bit & mask) == bit)
>  			break;
>  		size = bit;
> @@ -692,7 +692,7 @@ static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int
>  	mask = (devres & 0x3f) << 16;
>  	size = 128 << 16;
>  	for (;;) {
> -		unsigned bit = size >> 1;
> +		unsigned int bit = size >> 1;
>  		if ((bit & mask) == bit)
>  			break;
>  		size = bit;
> @@ -806,7 +806,7 @@ static void ich6_lpc_acpi_gpio(struct pci_dev *dev)
>  				"ICH6 GPIO");
>  }
>  
> -static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
> +static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
>  				    const char *name, int dynsize)
>  {
>  	u32 val;
> @@ -850,7 +850,7 @@ static void quirk_ich6_lpc(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc);
>  
> -static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
> +static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
>  				    const char *name)
>  {
>  	u32 val;
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index 8fc9a4e911e3..e18d3a4383ba 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -85,7 +85,7 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>  {
>  	void __iomem *image;
>  	int last_image;
> -	unsigned length;
> +	unsigned int length;
>  
>  	image = rom;
>  	do {
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 2ce636937c6e..547396ec50b5 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1525,7 +1525,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
>  {
>  	struct pci_dev *dev = bus->self;
>  	struct resource *r;
> -	unsigned old_flags = 0;
> +	unsigned int old_flags = 0;
>  	struct resource *b_res;
>  	int idx = 1;
>  
> -- 
> 2.33.0
> 
