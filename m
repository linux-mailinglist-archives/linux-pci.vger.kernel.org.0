Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D44664C7D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 20:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjAJTas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 14:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAJTar (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 14:30:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECBCBC87;
        Tue, 10 Jan 2023 11:30:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A1361866;
        Tue, 10 Jan 2023 19:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55A5C433D2;
        Tue, 10 Jan 2023 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673379045;
        bh=Z3VK4XjQQq+KEw1B3BXi5i7EA2vHGCfGtc50BK1cESg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BvzSqmM5VG/wtFQGgC8wSJpNGj6cgw68m0jQu72oiRnFxq9RH2qpedGzdleXXD71K
         bTBsYQxKBW9cIYMLJ5hW86luyWHFps5e033Rxv0V1np30bM6iPxMbEnOq3LZxcznoz
         BznUmmc9p9ltWZ/lTU/zDAJRJ7hEXXij4ac700Pigklzl426hos0/SURV2s3uNu2En
         JgVtQUOOkW+m5nkU1gJE61D6/3cQvy0UNYfSexkGczt7yic1BOCQ00rh6NRFweHxNW
         Z9ntIpgGQrsKhbJ7xwEtjqZfnJMi3Dzjj+lEcHbFdGHXsDUCmcXKyd6OnHFsgb3UXa
         AZBub3gX7p4lg==
Date:   Tue, 10 Jan 2023 13:30:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-pci@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20230110193043.GA1603645@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bdae72740db_5178e294bd@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 10:29:06AM -0800, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Normally we reject ECAM space unless it is reported as reserved in the E820
> > table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
> > means PCI extended config space (offsets 0x100-0xfff) may not be accessible.
> > 
> > Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
> > mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
> > normally converted to an E820 entry by a bootloader or EFI stub.
> > 
> > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
> > E820 entries that correspond to EfiMemoryMappedIO regions because some
> > other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
> > E820 entries prevent Linux from allocating BAR space for hot-added devices.
> > 
> > Allow use of ECAM for extended config space when the region is covered by
> > an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
> > _CRS.
> > 
> > Reported by Kan Liang, Tony Luck, and Giovanni Cabiddu.
> > 
> > Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
> > Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com
> > Reported-by: Kan Liang <kan.liang@linux.intel.com>
> > Reported-by: Tony Luck <tony.luck@intel.com>
> > Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  arch/x86/pci/mmconfig-shared.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> > index cd16bef5f2d9..da4b6e8e9df0 100644
> > --- a/arch/x86/pci/mmconfig-shared.c
> > +++ b/arch/x86/pci/mmconfig-shared.c
> > @@ -12,6 +12,7 @@
> >   */
> >  
> >  #include <linux/acpi.h>
> > +#include <linux/efi.h>
> >  #include <linux/pci.h>
> >  #include <linux/init.h>
> >  #include <linux/bitmap.h>
> > @@ -442,6 +443,32 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
> >  	return mcfg_res.flags;
> >  }
> >  
> > +static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
> > +{
> > +#ifdef CONFIG_EFI
> > +	efi_memory_desc_t *md;
> > +	u64 size, mmio_start, mmio_end;
> > +
> > +	for_each_efi_memory_desc(md) {
> > +		if (md->type == EFI_MEMORY_MAPPED_IO) {
> > +			size = md->num_pages << EFI_PAGE_SHIFT;
> > +			mmio_start = md->phys_addr;
> > +			mmio_end = mmio_start + size;
> > +
> > +			/*
> > +			 * N.B. Caller supplies (start, start + size),
> > +			 * so to match, mmio_end is the first address
> > +			 * *past* the EFI_MEMORY_MAPPED_IO area.
> > +			 */
> > +			if (mmio_start <= start && end <= mmio_end)
> > +				return true;
> > +		}
> > +	}
> > +#endif
> 
> Perhaps the following trick (compile tested), but either way:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

That's a great trick, and I wish I'd thought of it.  I have some
follow-on patches I'm considering for v6.3, so in the interest of
streamlining the path of this one to v6.2-rc4, I think I'll wait on
this until v6.3.

> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index da4b6e8e9df0..ae95d1b073c6 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -445,7 +445,6 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
>  
>  static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
>  {
> -#ifdef CONFIG_EFI
>  	efi_memory_desc_t *md;
>  	u64 size, mmio_start, mmio_end;
>  
> @@ -464,7 +463,6 @@ static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
>  				return true;
>  		}
>  	}
> -#endif
>  
>  	return false;
>  }
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 4b27519143f5..3ab0c255b791 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -790,8 +790,12 @@ extern int efi_memattr_apply_permissions(struct mm_struct *mm,
>   *
>   * Once the loop finishes @md must not be accessed.
>   */
> +#ifdef CONFIG_EFI
>  #define for_each_efi_memory_desc(md) \
>  	for_each_efi_memory_desc_in_map(&efi.memmap, md)
> +#else
> +#define for_each_efi_memory_desc(md) for (; 0;)
> +#endif
>  
>  /*
>   * Format an EFI memory descriptor's type and attributes to a user-provided
