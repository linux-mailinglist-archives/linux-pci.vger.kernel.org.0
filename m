Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF939D41A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 06:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFGEj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 00:39:28 -0400
Received: from yyz.mikelr.com ([170.75.163.43]:33848 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFGEj0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 00:39:26 -0400
Received: from glidewell.localnet (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 975C84F043;
        Mon,  7 Jun 2021 00:37:34 -0400 (EDT)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        x86@kernel.org
Subject: Re: [PATCH] PCI: Add quirk for 64-bit DMA on RS690 chipset
Date:   Mon, 07 Jun 2021 00:37:33 -0400
Message-ID: <2233170.O0C0KFXLZ4@glidewell>
In-Reply-To: <20210604230257.GA2241499@bjorn-Precision-5520>
References: <20210604230257.GA2241499@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the review

On Friday, June 4, 2021 7:02:57 PM EDT Bjorn Helgaas wrote:
> [+cc x86]
> 
> On Thu, May 27, 2021 at 05:45:21PM -0400, Mikel Rychliski wrote:
> > Although the AMD RS690 chipset has 64-bit DMA support, BIOS
> > implementations
> > sometimes fail to configure the memory limit registers correctly.
> > 
> > Currently, the ahci driver has quirks to enable or disable 64-bit DMA
> > depending on the BIOS version (see ahci_sb600_enable_64bit() in ahci.c).
> > snd_hda_intel always disables 64-bit DMA with the paired SB600 chipset.
> 
> This patch applies to RS690.  Is there a connection between SB600 and
> RS690?  Trying to figure out why the above two sentences are here.
> 
> What is the implication of this patch for ahci_sb600_enable_64bit()
> and snd_hda_intel?  (BTW, "git grep snd_hda_intel" turns up no useful
> pointers; a specific function name would be more useful.)

The RS690 and SB600 were often (always?) installed as a pair on motherboards. 
Currently, the ahci and hda-intel drivers have quirks to disable 64-bit DMA 
for SB600. But those quirks are probably only there because the PCI host 
(RS690) used with the SB600 often has broken 64-bit DMA.

The SB600 quirks could probably be removed now. On my machine, ahci is broken 
without quirks, but either quirk by itself fixes the problem. I wasn't sure if 
a sample size of one was enough to remove the SB600 quirks though, so I just 
left them in.

I was trying to give context about why the issue was with the host controller 
and not a specific driver (other drivers only work because 64-bit DMA is 
disabled there). I'll update the message to be more clear. Unless it could be 
omitted entirely?

> > 	sky2 0000:02:00.0: error interrupt status=0x8
> > 	sky2 0000:02:00.0 eth0: tx timeout
> > 	sky2 0000:02:00.0 eth0: transmit ring 0 .. 22 report=0 done=0
> > 
> > Avoid the issue by configuring the memory limit registers correctly if the
> > BIOS failed to. If the kernel is aware of physical memory above 4GB, but
> > the BIOS never configured the PCI host with this information, update the
> > register with our value.
> 
> I'm guessing RS690 is only applicable for x86.  We do have a bunch of
> obviously x86-specific stuff in drivers/pci/quirks.c, but I think this
> could probably go in arch/x86/pci/fixup.c, where it won't get compiled
> for all the arches that can never use it.
> 
> Or it's conceivable it might fit in arch/x86/pci/amd_bus.c, since
> there's some code there dealing with the memory map.

This should only apply to x86, so I'll move to arch/x86/pci/fixup.c. I was 
hesitant to move to amd_bus.c since that runs very early, and seems to focus 
on setting up the memory map for the CPU using MSRs (along with the PCI memory 
windows). In fixup.c we can use the normal device matching for quirks.

> > Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
> > ---
> > 
> >  drivers/pci/quirks.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci_ids.h |  1 +
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index dcb229de1acb..cd98a01de908 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5601,3 +5601,47 @@ static void apex_pci_fixup_class(struct pci_dev
> > *pdev)> 
> >  }
> >  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> >  
> >  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> > 
> > +
> > +#define RS690_LOWER_TOP_OF_DRAM2	0x30
> > +#define RS690_LOWER_TOP_OF_DRAM2_VALID	0x1
> > +#define RS690_UPPER_TOP_OF_DRAM2	0x31
> > +#define RS690_HTIU_NB_INDEX		0xA8
> > +#define RS690_HTIU_NB_INDEX_WR_ENABLE	0x100
> > +#define RS690_HTIU_NB_DATA		0xAC
> > +
> > +/*
> > + * Some BIOS implementations support RAM above 4GB, but do not configure
> > the + * PCI host to respond to bus master accesses for these addresses.
> > These + * implementations set the TOP_OF_DRAM_SLOT1 register correctly,
> > so PCI DMA + * works as expected for addresses below 4GB.
> > + *
> > + * Reference: "AMD RS690 ASIC Family Register Reference Guide" (public)
> 
> The NB_TOP_OF_DRAM_SLOT1 section talks about incoming PCI DMA, but
> unfortunately the public spec I found (P/N 43372) says nothing at all
> about NB_UPPER_TOP_OF_DRAM2.

I had found it on page 2-57 (pdf page 63) in:
https://www.amd.com/system/files/TechDocs/43372_rs690_rrg_3.00o.pdf

It looks like it may have been added in a revision. If you're referring to the 
lack of behavior description, yes it doesn't explicitly call out PCI DMA. I 
guessed based on the name similarity to NB_TOP_OF_DRAM_SLOT1 and confirmed that 
DMA above 4GB works once the top of memory is corrected here.

Thanks,
Mikel
