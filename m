Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA926838FB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 20:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfHFSvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 14:51:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:5993 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfHFSvi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 14:51:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 11:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="182053414"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2019 11:51:38 -0700
Message-ID: <1565118769.2401.120.camel@intel.com>
Subject: Re: [RFC V1 RESEND 0/6] Introduce dynamic allocation/freeing of
 MSI-X vectors
From:   Megha Dey <megha.dey@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, marc.zyngier@arm.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com
Date:   Tue, 06 Aug 2019 12:12:49 -0700
In-Reply-To: <20190802002442.GI151852@google.com>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
         <20190802002442.GI151852@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-08-01 at 19:24 -0500, Bjorn Helgaas wrote:
> Hi Megha,
> 
> On Fri, Jun 21, 2019 at 05:19:32PM -0700, Megha Dey wrote:
> > 
> > Currently, MSI-X vector enabling and allocation for a PCIe device
> > is
> > static i.e. a device driver gets only one chance to enable a
> > specific
> > number of MSI-X vectors, usually during device probe. Also, in many
> > cases, drivers usually reserve more than required number of vectors
> > anticipating their use, which unnecessarily blocks resources that
> > could have been made available to other devices. Lastly, there is
> > no
> > way for drivers to reserve more vectors, if the MSI-x has already
> > been
> > enabled for that device.
> >  
> > Hence, a dynamic MSI-X kernel infrastructure can benefit drivers by
> > deferring MSI-X allocation to post probe phase, where actual demand
> > information is available.
> >  
> > This patchset enables the dynamic allocation/de-allocation of MSI-X
> > vectors by introducing 2 new APIs:
> > pci_alloc_irq_vectors_dyn() and pci_free_irq_vectors_grp():
> > 
> > We have had requests from some of the NIC/RDMA users who have lots
> > of
> > interrupt resources and would like to allocate them on demand,
> > instead of using an all or none approach.
> > 
> > The APIs are fairly well tested (multiple
> > allocations/deallocations),
> > but we have no early adopters yet. Hence, sending this series as an
> > RFC for review and comments.
> > 
> > The patches are based out of Linux 5.2-rc5.
> > 
> > Megha Dey (6):
> >   PCI/MSI: New structures/macros for dynamic MSI-X allocation
> >   PCI/MSI: Dynamic allocation of MSI-X vectors by group
> >   x86: Introduce the dynamic teardown function
> >   PCI/MSI: Introduce new structure to manage MSI-x entries
> s/MSI-x/MSI-X/
> If "entries" here means the same as "vectors" above, please use the
> same word.
> 

Hi Bjorn,

Well, here entries basically mean the msi_desc entries. I thought MSI
vectors are used for each address/data pair, hence used the term
entries. Will update it to vectors to ensure uniformity.

> > 
> >   PCI/MSI: Free MSI-X resources by group
> Is "resources" the same as "vectors"?
> 

Yes, will update this in V2.

> > 
> >   Documentation: PCI/MSI: Document dynamic MSI-X infrastructure
> When you post a v2 after addressing Thomas' comments, please make
> these subject lines imperative sentences beginning with a descriptive
> verb.  You can run "git log --oneline drivers/pci" to see the style.

Sure, I will update the subject lines in V2.

> If you're adding a specific interface or structure, mention it by
> name
> in the subject if it's practical.  The "x86" line needs a little more
> context; I assume it should include "IRQ", "MSI-X", or something.
> 

True, will change this in V2.

> > 
> >  Documentation/PCI/MSI-HOWTO.txt |  38 +++++
> >  arch/x86/include/asm/x86_init.h |   1 +
> >  arch/x86/kernel/x86_init.c      |   6 +
> >  drivers/pci/msi.c               | 363
> > +++++++++++++++++++++++++++++++++++++---
> >  drivers/pci/probe.c             |   9 +
> >  include/linux/device.h          |   3 +
> >  include/linux/msi.h             |  13 ++
> >  include/linux/pci.h             |  61 +++++++
> >  kernel/irq/msi.c                |  34 +++-
> >  9 files changed, 497 insertions(+), 31 deletions(-)
> > 
