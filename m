Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A043DE2F4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 01:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhHBXQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 19:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232588AbhHBXQy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 19:16:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DCBB60EC0;
        Mon,  2 Aug 2021 23:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627946204;
        bh=3ptfVM59zuF6UcjTL1TI2rMJkJS7oye0pG8ghT5vEmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y0SIXoT9NyYYYfU9X6oKmpBTSgusjlgb4xakAEd/TK6RFo+w4De7J2fo30tNiLYjP
         F/gBXwN7yZnqNj/AjBjaj5DcNqbtwbj3T+1CtmEtxB2zxHmwdEGokGqm9Z+bxKBN6E
         IZhcMR7JLBOwXAKhYf5mbPi0vLlklMsxBv2rmQB+qG8AHkeCgrdqkEzxgreGo4qkkE
         KF0R8IpPJFDW00CBacLD9bpONGKpGNT41dpq4ID6w4b3tIvFzD7iMVzT+AQolEdqPc
         K87g4tnLDodIiPFdafhSsQsnyA4nPvhNpghsSOY6+lU8LprPbD6Po0yUK2S257OG7C
         EtItq7fS7VMDg==
Date:   Mon, 2 Aug 2021 18:16:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] x86/PCI: Introduce pcibios_is_irq_managed() helper
Message-ID: <20210802231643.GA1474171@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730205355.26504-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 30, 2021 at 11:53:55PM +0300, Andy Shevchenko wrote:
> The check for irq_managed flag along with non-zero irq is an idiom
> for x86 PCI implementation. Introduce helper and switch users over
> using it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/pci.h   | 4 ++++
>  arch/x86/pci/intel_mid_pci.c | 5 ++---
>  arch/x86/pci/irq.c           | 4 ++--
>  drivers/acpi/pci_irq.c       | 4 ++--
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index d2c76c8d8cfd..ac25470c9558 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -92,6 +92,10 @@ void pcibios_scan_root(int bus);
>  struct irq_routing_table *pcibios_get_irq_routing_table(void);
>  int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
>  
> +static inline bool pcibios_irq_is_managed(struct pci_dev *dev)
> +{
> +	return dev->irq_managed && dev->irq > 0;
> +}
>  
>  #define HAVE_PCI_MMAP
>  #define arch_can_pci_mmap_wc()	pat_enabled()
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index f04742caf62b..0da287bcabf5 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -230,7 +230,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
>  	int ret;
>  	u8 gsi;
>  
> -	if (dev->irq_managed && dev->irq > 0)
> +	if (pcibios_irq_is_managed(dev))
>  		return 0;
>  
>  	ret = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
> @@ -290,8 +290,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
>  
>  static void intel_mid_pci_irq_disable(struct pci_dev *dev)
>  {
> -	if (!mp_should_keep_irq(&dev->dev) && dev->irq_managed &&
> -	    dev->irq > 0) {
> +	if (pcibios_irq_is_managed(dev) && !mp_should_keep_irq(&dev->dev)) {
>  		mp_unmap_irq(dev->irq);
>  		dev->irq_managed = 0;
>  	}
> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> index d3a73f9335e1..ce3927b68f9e 100644
> --- a/arch/x86/pci/irq.c
> +++ b/arch/x86/pci/irq.c
> @@ -1210,7 +1210,7 @@ static int pirq_enable_irq(struct pci_dev *dev)
>  			struct pci_dev *temp_dev;
>  			int irq;
>  
> -			if (dev->irq_managed && dev->irq > 0)
> +			if (pcibios_irq_is_managed(dev))
>  				return 0;
>  
>  			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number,
> @@ -1280,7 +1280,7 @@ bool mp_should_keep_irq(struct device *dev)
>  static void pirq_disable_irq(struct pci_dev *dev)
>  {
>  	if (io_apic_assign_pci_irqs && !mp_should_keep_irq(&dev->dev) &&
> -	    dev->irq_managed && dev->irq) {
> +	    pcibios_irq_is_managed(dev)) {
>  		mp_unmap_irq(dev->irq);
>  		dev->irq = 0;
>  		dev->irq_managed = 0;
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index b63954c36e86..b463bdd2dbb5 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -397,7 +397,7 @@ int __acpi_pci_irq_enable(struct pci_dev *dev, int polarity)
>  		return 0;
>  	}
>  
> -	if (dev->irq_managed && dev->irq > 0)
> +	if (pcibios_irq_is_managed(dev))
>  		return 0;
>  
>  	entry = acpi_pci_irq_lookup(dev, pin);
> @@ -486,7 +486,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
>  	u8 pin;
>  
>  	pin = dev->pin;
> -	if (!pin || !dev->irq_managed || dev->irq <= 0)
> +	if (!pin || !pcibios_irq_is_managed(dev))

This file may be compiled for x86, arm64, and ia64, but it looks like
you only defined pcibios_irq_is_managed() for x86.

We used to have a generic pci_has_managed_irq() that was the same as
your pcibios_irq_is_managed(), but it was removed by 67b4eab91caf
("Revert "PCI: Add helpers to manage pci_dev->irq and
pci_dev->irq_managed"").

I'm sorry that pdev->irq_managed got added without a comment by
cffe0a2b5a34 ("x86, irq: Keep balance of IOAPIC pin reference count").
Even reading that commit log, I'm not sure exactly what it means.  The
log says:

  So flag irq_managed is introduced to track whether IRQ number is
  assigned by OS and to protect pirq_enable_irq(), acpi_pci_irq_enable()
  and intel_mid_pci_irq_enable() from reentrance.

>  		return;
>  
>  	/* Keep IOAPIC pin configuration when suspending */
> -- 
> 2.30.2
> 
