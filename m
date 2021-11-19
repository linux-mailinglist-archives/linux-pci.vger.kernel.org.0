Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206A845767A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 19:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhKSSii (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 13:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234866AbhKSSih (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 13:38:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 917B161B54;
        Fri, 19 Nov 2021 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637346935;
        bh=1iuCJrrroxyBRRrky4+3AMjFr4bMyrudb971pvpl+vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iRL/BD2FGsRrKVTamNUCAsapUYeFbfDnQHR5Oyp1Q88BJ83actUdFiSpHP4J4FlDx
         ZwG5DED2tzLETfWAxEXKSckHQcdVupJ2NDGHVQAbzqYZj8cOk7mX/6UqG5/DSUeEKs
         XSc7r80YxBPRrFOdDBVMN4kALCRbJ9ST3R98n7WPAbz6UVX9OD+R5RGBwyqNYI70u6
         gwDZugdAwAfaFt7xaySY1IrRIEFEfFWPNGCFgPM89KLtCtDpsRdskvwFF+yhhfjqMJ
         DrW9aYrXjabNetJFR0M7K24Bx+j6pRF5lEr58/Vl/TNlS/2u5twDr6fz/uZz4dpFi6
         m+EzP9topnCBQ==
Date:   Fri, 19 Nov 2021 12:35:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 2/3] x86/quirks: Introduce
 hpet_dev_print_force_hpet_address() helper
Message-ID: <20211119183533.GA1949698@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119110017.48510-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 01:00:16PM +0200, Andy Shevchenko wrote:
> Introduce hpet_dev_print_force_hpet_address() helper to unify printing
> forced HPET address. No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/kernel/quirks.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index c4bc0c3a5414..7280125aed4d 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -68,6 +68,11 @@ static enum {
>  	ATI_FORCE_HPET_RESUME,
>  } force_hpet_resume_type;
>  
> +static void hpet_dev_print_force_hpet_address(struct device *dev)
> +{
> +	dev_printk(KERN_DEBUG, dev, "Force enabled HPET at 0x%lx\n", force_hpet_address);

Looks good to me.  Do we know the size of the HPET register size?
Could we show the entire range, e.g., "[mem %#010x-%#010x]", to match
other physical address space resources?

> +}
> +
>  static void __iomem *rcba_base;
>  
>  static void ich_force_hpet_resume(void)
> @@ -125,8 +130,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
>  		/* HPET is enabled in HPTC. Just not reported by BIOS */
>  		val = val & 0x3;
>  		force_hpet_address = 0xFED00000 | (val << 12);
> -		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
> -			"0x%lx\n", force_hpet_address);
> +		hpet_dev_print_force_hpet_address(&dev->dev);
>  		iounmap(rcba_base);
>  		return;
>  	}
> @@ -149,8 +153,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
>  			"Failed to force enable HPET\n");
>  	} else {
>  		force_hpet_resume_type = ICH_FORCE_HPET_RESUME;
> -		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
> -			"0x%lx\n", force_hpet_address);
> +		hpet_dev_print_force_hpet_address(&dev->dev);
>  	}
>  }
>  
> @@ -223,8 +226,7 @@ static void old_ich_force_enable_hpet(struct pci_dev *dev)
>  	if (val & 0x4) {
>  		val &= 0x3;
>  		force_hpet_address = 0xFED00000 | (val << 12);
> -		dev_printk(KERN_DEBUG, &dev->dev, "HPET at 0x%lx\n",
> -			force_hpet_address);
> +		hpet_dev_print_force_hpet_address(&dev->dev);
>  		return;
>  	}
>  
> @@ -244,8 +246,7 @@ static void old_ich_force_enable_hpet(struct pci_dev *dev)
>  		/* HPET is enabled in HPTC. Just not reported by BIOS */
>  		val &= 0x3;
>  		force_hpet_address = 0xFED00000 | (val << 12);
> -		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
> -			"0x%lx\n", force_hpet_address);
> +		hpet_dev_print_force_hpet_address(&dev->dev);
>  		cached_dev = dev;
>  		force_hpet_resume_type = OLD_ICH_FORCE_HPET_RESUME;
>  		return;
> @@ -316,8 +317,7 @@ static void vt8237_force_enable_hpet(struct pci_dev *dev)
>  	 */
>  	if (val & 0x80) {
>  		force_hpet_address = (val & ~0x3ff);
> -		dev_printk(KERN_DEBUG, &dev->dev, "HPET at 0x%lx\n",
> -			force_hpet_address);
> +		hpet_dev_print_force_hpet_address(&dev->dev);
>  		return;
>  	}
>  
> @@ -331,8 +331,7 @@ static void vt8237_force_enable_hpet(struct pci_dev *dev)
>  	pci_read_config_dword(dev, 0x68, &val);
>  	if (val & 0x80) {
>  		force_hpet_address = (val & ~0x3ff);
> -		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
> -			"0x%lx\n", force_hpet_address);
> +		hpet_dev_print_force_hpet_address(&dev->dev);
>  		cached_dev = dev;
>  		force_hpet_resume_type = VT8237_FORCE_HPET_RESUME;
>  		return;
> @@ -412,8 +411,7 @@ static void ati_force_enable_hpet(struct pci_dev *dev)
>  
>  	force_hpet_address = val;
>  	force_hpet_resume_type = ATI_FORCE_HPET_RESUME;
> -	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
> -		   force_hpet_address);
> +	hpet_dev_print_force_hpet_address(&dev->dev);
>  	cached_dev = dev;
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS,
> @@ -444,8 +442,7 @@ static void nvidia_force_enable_hpet(struct pci_dev *dev)
>  	pci_read_config_dword(dev, 0x44, &val);
>  	force_hpet_address = val & 0xfffffffe;
>  	force_hpet_resume_type = NVIDIA_FORCE_HPET_RESUME;
> -	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
> -		force_hpet_address);
> +	hpet_dev_print_force_hpet_address(&dev->dev);
>  	cached_dev = dev;
>  }
>  
> @@ -509,8 +506,7 @@ static void e6xx_force_enable_hpet(struct pci_dev *dev)
>  
>  	force_hpet_address = 0xFED00000;
>  	force_hpet_resume_type = NONE_FORCE_HPET_RESUME;
> -	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
> -		"0x%lx\n", force_hpet_address);
> +	hpet_dev_print_force_hpet_address(&dev->dev);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E6XX_CU,
>  			 e6xx_force_enable_hpet);
> -- 
> 2.33.0
> 
