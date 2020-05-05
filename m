Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01511C61D8
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 22:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgEEUQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 16:16:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:17834 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgEEUQR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 16:16:17 -0400
IronPort-SDR: Ed3clJRLkSEFP9PsnuTp4NXbordS9j25n90/QdN+VkhOzYvUx4aE84Zq7mvDtJZ20dY/IyTZhw
 tNsiipAbmlDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 13:16:16 -0700
IronPort-SDR: +PMTPGEsUOJ8I/GGDGQrnbeGVvU8kXGjPRg/T/JvFXytEtiIyLN7zQqY2UWeLl1FjMUzGgCHYg
 a+XoYrFq/Yqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="251004329"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2020 13:16:16 -0700
Date:   Tue, 5 May 2020 13:16:16 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Raj, Ashok" <ashok.raj@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
Message-ID: <20200505201616.GA15481@otc-nc-03>
References: <20200501184326.GA17961@araj-mobl1.jf.intel.com>
 <878si6rx7f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878si6rx7f.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 09:36:04PM +0200, Thomas Gleixner wrote:
> Ashok,
> 
> 
> > Now the second question with Interrupt Remapping Support:
> >
> > intel_ir_set_affinity->intel_ir_reconfigure_irte()-> modify_irte()
> >
> > The flush of Interrupt Entry Cache (IEC) should ensure, if any interrupts
> > were in flight, they made it to the previous CPU, and any new interrupts
> > must be delivered to the new CPU.
> >
> > Question is do we need a check similar to the legacy MSI handling
> >
> > 	if (lapic_vector_set_in_irr())
> > 	    handle interrupt? 
> >
> > Is there a reason we don't check if the interrupt delivered to previous
> > CPU in intel_ir_set_affinity()? Or is the send_cleanup_vector() sends
> > an IPI to perform the cleanup?
> >
> > It appears that maybe send_cleanup_vector() sends IPI to the old cpu
> > and that somehow ensures the device interrupt handler actually getting
> > called? I lost my track somewhere down there :)
> 
> The way it works is:
> 
>     1) New vector on different CPU is allocated
> 
>     2) New vector is installed
> 
>     3) When the first interrupt on the new CPU arrives then the cleanup
>        IPI is sent to the previous CPU which tears down the old vector
> 
> So if the interrupt is sent to the original CPU just before #2 then this
> will be correctly handled on that CPU after the set affinity code
> reenables interrupts.

I'll have this test tried out.. but in msi_set_affinity() the check below
for lapic_vector_set_in_irr(cfg->vector), this is the new vector correct? 
don't we want to check for old_cfg.vector instead?

msi_set_affinit ()
{
....


        unlock_vector_lock();

        /*
         * Check whether the transition raced with a device interrupt and
         * is pending in the local APICs IRR. It is safe to do this outside
         * of vector lock as the irq_desc::lock of this interrupt is still
         * held and interrupts are disabled: The check is not accessing the
         * underlying vector store. It's just checking the local APIC's
         * IRR.
         */
        if (lapic_vector_set_in_irr(cfg->vector))
                irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);


> 
> Can you try the patch below?
> 
> Thanks,
> 
>         tglx
> 
> 8<--------------
>  drivers/pci/msi.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -323,6 +323,7 @@ void __pci_write_msi_msg(struct msi_desc
>  		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
>  		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
>  		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
> +		readl(base + PCI_MSIX_ENTRY_DATA);
>  	} else {
>  		int pos = dev->msi_cap;
>  		u16 msgctl;
> @@ -343,6 +344,7 @@ void __pci_write_msi_msg(struct msi_desc
>  			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
>  					      msg->data);
>  		}
> +		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
>  	}
>  
>  skip:
