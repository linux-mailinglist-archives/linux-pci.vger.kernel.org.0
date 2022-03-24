Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7E4E5C4D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 01:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbiCXA1w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 20:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiCXA1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 20:27:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD067CB0E;
        Wed, 23 Mar 2022 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648081580; x=1679617580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L34B6VEslpB+6f2BVeWKV1uDlr8W1Fk/YMhgeirUVt0=;
  b=BgF5AEaLTguNtGSG+ATHmhdQdq6bQbhglhn+A1ssVfgWEKiGQIBleFBs
   gSpCfn4VVYBFLC1yBU6tkrc3BmxK+EcXux1b9lDT952z1GICO09IoHYQ8
   3JppmQoY6TDX+5S0G9f8Ub9uqxqRhW7jGQfKJbcqyxROwNSAQEe6Ofhn4
   /gyL6nqvSTe4EQ+0RnZXy5rRCIRHIVQe0wX3LuC5TGg7OBOM2urtGRcte
   iiEBT+DU896CMgVBJJqY6/Oq/NFibbtDkfHeYc4gD6If0m8k9oKlje2Ck
   jDyqx6ald2IAt+TvUBD3PxuiDBWxQinp0aTNkYsdg1nreKyPGsqUy0jVl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258209603"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258209603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:26:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="544421046"
Received: from aasanche-mobl.amr.corp.intel.com (HELO localhost) ([10.212.46.175])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:26:19 -0700
Date:   Wed, 23 Mar 2022 17:26:18 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 04/10] PCI/DOE: Introduce pci_doe_create_doe_devices
Message-ID: <Yju6quQsBDSMaNC2@iweiny-desk3>
References: <20220201071952.900068-5-ira.weiny@intel.com>
 <20220203224437.GA120552@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203224437.GA120552@bhelgaas>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 03, 2022 at 04:44:37PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 31, 2022 at 11:19:46PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL and/or PCI devices can define DOE mailboxes.  
> 
> In concrete terms, "DOE mailbox" refers to a DOE Capability, right?

Right.

> PCIe devices are allowed to implement several instances of the DOE
> Capability, of course.  I'm kind of partial to concreteness because it
> makes it easier to map between the code and the spec.

I agree.  I'm just not great at remembering the terminology.  I've fixed it up
in this next go round.

> 
> > Normally the kernel will want to maintain control of all of these
> > mailboxes.  However, under a limited number of use cases users may
> > want to allow user space access to some of these mailboxes while the
> > kernel retains control of the rest.
> 
> Is there something in this patch related to user-space vs kernel
> control of things?  To me this patch looks like "for every DOE
> Capability on a device, create an auxiliary device and try to attach
> an auxiliary device driver to it."

That was the way this series worked yest.

> 
> If part of creating the auxiliary devices is adding things in sysfs, I
> think it would be useful to mention that here.

Nothing was added in sysfs for this series and nothing is planned in the next
series.

That said Dan and I discussed internally and have settled on the PCI layer
being agnostic to the aux bus idea.

The new PCI layer code I have simply provides helpers to create struct
pci_doe_mb (mailbox objects) which control the state machine and accept
pci_doe_tasks as work requests.

The idea of using auxiliary bus devices is now used in the CXL layer as a way
to allow individual mailboxes to be controlled via user space directly by
unlinking that auxiliary device.

I have also added a modified version of Dan's patch from here:

https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/

The new version taints the kernel if a write occurs but allows any read.

I'm curious if allowing reads is really ok though.  Because allowing a read at
just the right time could allow snooping of DOE protocol data.  Could this be a
potential security issue with protocols like IDE?  It would be a difficult
attack for sure but...  :-/

> 
> > An example of this is for CXL Compliance Testing (see CXL 2.0
> > 14.16.4 Compliance Mode DOE) which offers a mechanism to set
> > different test modes for a device.
> 
> Not sure exactly what this contributes here.  I guess you're saying
> you might want user-space access to this, but I don't see anything in
> this patch related to that.

The detail in this patch was that if user space unlinked a specific DOE device
then user space could control that device directly and without interference
from this kernel code.  As I stated above we will use this mechanism for CXL
but other subsystems could decide to do something else and own each DOE MB
capability directly.

> 
> > Rather than re-invent the wheel the architecture creates auxiliary
> > devices for each DOE mailbox which can then be driven by a generic
> > DOE mailbox driver.  If access to an individual mailbox is required
> > by user space the driver for that mailbox can be unloaded and access
> > handed to user space.
> 
> IIUC a device can have several DOE Capabilities, and each Capability
> can support several protocols.  So I would think the granularity might
> be "protocol" rather than "mailbox" (DOE Capability).

We debated that and decided that was to fine a granularity.

> 
> But either way this text seems like it would go with a different patch
> since this patch has nothing to specify a particular protocol or even
> a particular mailbox/DOE Capability.

Again, this was just more justification for the aux bus architecture.

> 
> > Create the helper pci_doe_create_doe_devices() which iterates each DOE
> > mailbox found in the device and creates a DOE auxiliary device on the
> > auxiliary bus.  While doing so ensure that the auxiliary DOE driver
> > loads to drive that device.
> 
> Here's a case where "iterating over DOE mailboxes found in the device"
> is slightly abstract.  The code obviously iterates over DOE
> *Capabilities* (PCI_EXT_CAP_ID_DOE), and that's something I can easily
> find in the spec.

I've clarified that thanks.  Also in the new version I've created an iterator
to find the capabilities.

	pci_doe_for_each_off()

> 
> Knowing that this is a PCIe Capability is useful because it puts it in
> the context of other capabilities ("optional things that live in
> config space") and the mechanisms for synchronization and user-space
> access.

Yes thanks.

> 
> > +/**
> > + * pci_doe_create_doe_devices - Create auxiliary DOE devices for all DOE
> > + *                              mailboxes found
> > + * @pci_dev: The PCI device to scan for DOE mailboxes
> > + *
> > + * There is no coresponding destroy of these devices.  This function associates
> > + * the DOE auxiliary devices created with the pci_dev passed in.  That
> > + * association is device managed (devm_*) such that the DOE auxiliary device
> > + * lifetime is always greater than or equal to the lifetime of the pci_dev.
> 
> This seems backwards.  What does it mean if the DOE aux dev lifetime
> is *greater* than that of the pci_dev?  Surely you can't access a PCI
> DOE Capability if the pci_dev is gone?

No you could not.  Thus the idea that the pci_dev's lifetime was greater than
the lifetime of the auxiliary devices.

Regardless this has all changed away from being part of the core and more tied
to the management of particular devices.  Which I think is much more clear.

> 
> > + * RETURNS: 0 on success -ERRNO on failure.
> > + */
> > +int pci_doe_create_doe_devices(struct pci_dev *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	int irqs, rc;
> > +	u16 pos = 0;
> > +
> > +	/*
> > +	 * An implementation may support an unknown number of interrupts.
> > +	 * Assume that number is not that large and request them all.
> 
> This doesn't really inspire confidence :)  Playing devil's advocate,
> since pdev is an arbitrary device, I would assume the number *is*
> large.

I've moved the call to pci_alloc_irq_vectors() to the CXL code which is
managing the pci_dev itself (rather than being buried in this auxiliary device
stuff.)

> 
> > +	irqs = pci_msix_vec_count(pdev);
> > +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
> 
> pci_msix_vec_count() is apparently sort of discouraged; see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/msi-howto.rst?id=v5.16#n179

I've removed pci_msix_vec_count() in favor of counting the DOE capabilities and
allocating the vectors based on that count.

> 
> A DOE Capability may be implemented by any device, e.g., a NIC or
> storage HBA, etc.  I'm a little queasy about IRQ alloc happening both
> here and in the driver for the device's primary functionality.  Can
> you reassure me that this is actually OK and safe?

I think it was perfectly safe for this implementation but it was probably not
a good idea generally.

> 
> Sorry if I've asked this before.  If I have, perhaps a comment would
> be useful.
> 
> > +	if (rc != irqs) {
> > +		/* No interrupt available - carry on */
> > +		pci_dbg(pdev, "No interrupts available for DOE\n");
> > +	} else {
> > +		/*
> > +		 * Enabling bus mastering is require for MSI/MSIx.  It could be
> 
> s/require/required/
> s/MSIx/MSI-X/ to match spec usage.
> 
> But I think you only support MSI-X, since you passed "PCI_IRQ_MSIX", not
> "PCI_IRQ_MSI | PCI_IRQ_MSIX" above?

Done.

> 
> > +		 * done later within the DOE initialization, but as it
> > +		 * potentially has other impacts keep it here when setting up
> > +		 * the IRQ's.
> 
> s/IRQ's/IRQs/
> 
> "Potentially has other impacts" is too vague, and this doesn't explain
> why bus mastering should be enabled here rather than later.  The
> device should not issue an MSI-X until DOE Interrupt Enable is set, so
> near there seems like a logical place.

Is it safe to call pci_set_master() more than once?

The reason I am asking is because I've debated between having the new create
mailbox command [pci_doe_create_mb()] request the irq or not.

The issue is the irq handler is part of the DOE state machine and so
pci_request_irq() needs to pass that handler.  I would rather not make that a
globally visible function.  Nor do I think it is appropriate for the DOE state
machine to trust callers setting the correct handler.

So currently the pci_alloc_irq_vectors() is the responsibility of the consumer
(CXL layer in this series) and pci_{request,free}_irq() is handled in the PCI
layer.

But placing pci_set_master() near the DOE Interrupt Enable would then cause
pci_set_master() to be called for each mailbox create.

For now I have left the pci_set_master() call next to pci_alloc_irq_vectors()
in the CXL layer.  As in Jonathans original code it gets called if the
allocation gets enough vectors for all mailboxes found.  And the use of irq's
is all or nothing for each CXL device.

Here is the code to be more clear...


drivers/cxl/pci.c:

int cxl_pci_create_doe_devices(struct pci_dev *pdev)
{               
        struct device *dev = &pdev->dev;
        bool use_irq = true;
        int irqs = 0;
        u16 off = 0;         
        int rc;
        
        pci_doe_for_each_off(pdev, off)
                irqs++;
        pci_info(pdev, "Found %d DOE mailbox's\n", irqs);
        
        /*                         
         * Allocate enough vectors for the DOE's
         */     
        rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSI |
                                                     PCI_IRQ_MSIX);
        if (rc != irqs) {
                pci_err(pdev, "Not enough interrupts for all the DOEs; use polling\n");
                use_irq = false;
                /* Some got allocated; clean them up */
                if (rc > 0)
                        cxl_pci_free_irq_vectors(pdev); 
        } else {
                /*
                 * Enabling bus mastering is require for MSI/MSIx.  It could be
                 * done later within the DOE initialization, but as it
                 * potentially has other impacts keep it here when setting up
                 * the IRQ's.
                 */
                pci_set_master(pdev);
                rc = devm_add_action_or_reset(dev,
                                              cxl_pci_free_irq_vectors,
                                              pdev);
                if (rc)
                        return rc;
        }

        pci_doe_for_each_off(pdev, off) {
...
		/* Create each auxiliary device which internally calls */
		pci_doe_create_mb(pdev, off, use_irq);
...
	}
...
}


drivers/pci/pci-doe.c:

static irqreturn_t pci_doe_irq_handler(int irq, void *data)
{
...
}

static int pci_doe_request_irq(struct pci_doe_mb *doe_mb)
{
        struct pci_dev *pdev = doe_mb->pdev;
        int offset = doe_mb->cap_offset;
        int doe_irq, rc;
        u32 val;

        pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);

        if (!FIELD_GET(PCI_DOE_CAP_INT, val))
                return -ENOTSUPP;

        doe_irq = FIELD_GET(PCI_DOE_CAP_IRQ, val);
        rc = pci_request_irq(pdev, doe_irq, pci_doe_irq_handler,
                             NULL, doe_mb,
                             "DOE[%d:%s]", doe_irq, pci_name(pdev));
        if (rc) 
                return rc;

        doe_mb->irq = doe_irq;
        pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
                               PCI_DOE_CTRL_INT_EN);
        return 0;
}

struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
                                     bool use_irq)
{
...
        if (use_irq) {
                rc = pci_doe_request_irq(doe_mb);
                if (rc) 
                        pci_err(pdev, "DOE request irq failed for mailbox @ %u : %d\n",
                                cap_offset, rc);
        }
...
}


Does this look reasonable?

> 
> > +		 */
> > +		pci_set_master(pdev);
> > +		rc = devm_add_action_or_reset(dev,
> > +					      pci_doe_free_irq_vectors,
> > +					      pdev);
> > +		if (rc)
> > +			return rc;
> > +	}
> 
> > +++ b/include/linux/pci-doe.h
> > @@ -13,6 +13,8 @@
> >  #ifndef LINUX_PCI_DOE_H
> >  #define LINUX_PCI_DOE_H
> >  
> > +#define DOE_DEV_NAME "doe"
> 
> This is only used once, above.  Why not just use the string there
> directly and skip the #define?  If it's needed elsewhere eventually,
> we can add a #define then.

This is now moved elsewhere in the series.

Thanks for the feedback and sorry it's taken so long to respond.
Ira

> 
> Bjorn
