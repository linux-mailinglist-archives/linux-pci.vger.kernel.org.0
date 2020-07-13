Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDD21E1D0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 23:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgGMVCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 17:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgGMVCD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 17:02:03 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D6A20809;
        Mon, 13 Jul 2020 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594674123;
        bh=KqSDB8Bh+e71r06v1jUAQSMlkEWpWNCT6uUWuSAGjJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a5lGW02iGVR1Y5dpf9ezM2VX+snId6bcKjZXTjPtuVmH5wbOCYMfgoikUDYHfI/FO
         QU33h+48Mo+f+ez2RDQcYCw4cyxb1JwVHCNI1yzqSM46NFvao1mG5uy4MLPjpQyXrh
         0+3KEzUlQwir00atEnCtAjtEZP/nKOkyCqP+j3Cs=
Date:   Mon, 13 Jul 2020 16:02:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] x86/PCI: Get rid of custom x86 model comparison
Message-ID: <20200713210201.GA277654@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713194437.11325-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 10:44:36PM +0300, Andy Shevchenko wrote:
> Switch the platform code to use x86_id_table and accompanying API
> instead of custom comparison against x86 CPU model.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/pci/intel_mid_pci.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index 00c62115f39c..d8af4787e616 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -28,10 +28,12 @@
>  #include <linux/io.h>
>  #include <linux/smp.h>
>  
> +#include <asm/cpu_device_id.h>
>  #include <asm/segment.h>
>  #include <asm/pci_x86.h>
>  #include <asm/hw_irq.h>
>  #include <asm/io_apic.h>
> +#include <asm/intel-family.h>
>  #include <asm/intel-mid.h>
>  
>  #define PCIE_CAP_OFFSET	0x100
> @@ -211,9 +213,16 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
>  			       where, size, value);
>  }
>  
> +static const struct x86_cpu_id intel_mid_cpu_ids[] = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
> +	{}
> +};
> +
>  static int intel_mid_pci_irq_enable(struct pci_dev *dev)
>  {
> +	const struct x86_cpu_id *id;
>  	struct irq_alloc_info info;
> +	u16 model = 0;
>  	int polarity;
>  	int ret;
>  	u8 gsi;
> @@ -227,8 +236,12 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
>  		return ret;
>  	}
>  
> -	switch (intel_mid_identify_cpu()) {
> -	case INTEL_MID_CPU_CHIP_TANGIER:
> +	id = x86_match_cpu(intel_mid_cpu_ids);
> +	if (id)
> +		model = id->model;
> +
> +	switch (model) {
> +	case INTEL_FAM6_ATOM_SILVERMONT_MID:

Is there a magic decoder ring somewhere that connects
INTEL_MID_CPU_CHIP_TANGIER and INTEL_FAM6_ATOM_SILVERMONT_MID?

I don't know how to verify that the new code is equivalent to the old.

Or maybe the new code is *better* than the old, in which case the
subject/commit log should mention that it's fixing or improving
something.

Also, there are a number of other places that check for
"intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER":

  mrfld_pinctrl_init
  register_mrfld_power_btn
  mrfld_legacy_rtc_init
  mrfld_sd_init
  spidev_platform_data
  register_mid_wdt
  sfi_parse_devs
  atomisp_css_input_set_mode

Maybe they should all be changed together?  Or maybe this needs an
explanation about why some places need intel_mid_identify_cpu() and
others need x86_match_cpu()?

>  		polarity = IOAPIC_POL_HIGH;
>  
>  		/* Special treatment for IRQ0 */
> -- 
> 2.27.0
> 
