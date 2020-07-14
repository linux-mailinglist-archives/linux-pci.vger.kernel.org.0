Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D511921ED0B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 11:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgGNJiE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 05:38:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:49242 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgGNJiD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 05:38:03 -0400
IronPort-SDR: 1WKREpBCE6jHMPLVVfqE/PTlZI99Y/bU3zHTMoOodBHwT2Ldn4M8d8sAeKYnzm5Qus7ggSNUeR
 r8PdGQTkDKPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128415135"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="128415135"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:38:03 -0700
IronPort-SDR: rPc3ddxpIP2vZOiJj8CvrtWE/cGTTFuHIvexdjo+ykQGR91El6PpdcKOPXJY6xT4YcQRzIJX4j
 d2Z0dfcTtg0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="299476886"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 02:38:00 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jvHNx-001kdY-6c; Tue, 14 Jul 2020 12:38:01 +0300
Date:   Tue, 14 Jul 2020 12:38:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] x86/PCI: Get rid of custom x86 model comparison
Message-ID: <20200714093801.GI3703480@smile.fi.intel.com>
References: <20200713194437.11325-1-andriy.shevchenko@linux.intel.com>
 <20200713210201.GA277654@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713210201.GA277654@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 13, 2020 at 10:44:36PM +0300, Andy Shevchenko wrote:
> > Switch the platform code to use x86_id_table and accompanying API
> > instead of custom comparison against x86 CPU model.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/pci/intel_mid_pci.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> > index 00c62115f39c..d8af4787e616 100644
> > --- a/arch/x86/pci/intel_mid_pci.c
> > +++ b/arch/x86/pci/intel_mid_pci.c
> > @@ -28,10 +28,12 @@
> >  #include <linux/io.h>
> >  #include <linux/smp.h>
> >  
> > +#include <asm/cpu_device_id.h>
> >  #include <asm/segment.h>
> >  #include <asm/pci_x86.h>
> >  #include <asm/hw_irq.h>
> >  #include <asm/io_apic.h>
> > +#include <asm/intel-family.h>
> >  #include <asm/intel-mid.h>
> >  
> >  #define PCIE_CAP_OFFSET	0x100
> > @@ -211,9 +213,16 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
> >  			       where, size, value);
> >  }
> >  
> > +static const struct x86_cpu_id intel_mid_cpu_ids[] = {
> > +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
> > +	{}
> > +};
> > +
> >  static int intel_mid_pci_irq_enable(struct pci_dev *dev)
> >  {
> > +	const struct x86_cpu_id *id;
> >  	struct irq_alloc_info info;
> > +	u16 model = 0;
> >  	int polarity;
> >  	int ret;
> >  	u8 gsi;
> > @@ -227,8 +236,12 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
> >  		return ret;
> >  	}
> >  
> > -	switch (intel_mid_identify_cpu()) {
> > -	case INTEL_MID_CPU_CHIP_TANGIER:
> > +	id = x86_match_cpu(intel_mid_cpu_ids);
> > +	if (id)
> > +		model = id->model;
> > +
> > +	switch (model) {
> > +	case INTEL_FAM6_ATOM_SILVERMONT_MID:
> 
> Is there a magic decoder ring somewhere that connects
> INTEL_MID_CPU_CHIP_TANGIER and INTEL_FAM6_ATOM_SILVERMONT_MID?

Yes. And the idea is to get rid of it.

> I don't know how to verify that the new code is equivalent to the old.
> 
> Or maybe the new code is *better* than the old, in which case the
> subject/commit log should mention that it's fixing or improving
> something.
> 
> Also, there are a number of other places that check for
> "intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER":
> 
>   mrfld_pinctrl_init
>   register_mrfld_power_btn
>   mrfld_legacy_rtc_init
>   mrfld_sd_init
>   spidev_platform_data
>   register_mid_wdt
>   sfi_parse_devs

>   atomisp_css_input_set_mode

This has been pending in Mauro's tree.

> Maybe they should all be changed together?  Or maybe this needs an
> explanation about why some places need intel_mid_identify_cpu() and
> others need x86_match_cpu()?

No. The rest is subject to huge clean up (complete removal) in the future.
I don't want to waste time on something which I will remove for sure.

-- 
With Best Regards,
Andy Shevchenko


