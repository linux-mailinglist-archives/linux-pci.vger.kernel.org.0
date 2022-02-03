Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7E4A90C5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 23:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiBCWol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 17:44:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56016 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBCWok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 17:44:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CDC361824;
        Thu,  3 Feb 2022 22:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F636C340E8;
        Thu,  3 Feb 2022 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643928279;
        bh=iDaAk9mxmUgwTsnlREt5ubizOYlIlAemHZh26ZSwxIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FwH+EsJuPl//li/m3SPToDU+A57WiASVXY7l5utxJH7bagtbR1TG25BTGf2HdJqu3
         BohbcrihzbuJLnnRhP+hPCla/SQp7/roMdzixvw4+z2xWrIzUFvwyoB0wY7uUa0rSR
         jDkcqvevd4nYrzmHIQ142rzAp1YAwchM2zMA7huN4uP0UI4WnxZpSYIo1zSM8ri4mL
         PXfsVbhYHuzvhSBJ4LPVr/8VRODjGdD+YZBGfq6NHbsW+UDamNOS1qE44578U8I+sU
         RavHbJpCUKJ8mfwIMA6Z4BsakBq853d8FCsh4ZqBb64j0ucHxZPz4InA9HFgXU+5wm
         8VdkRjNDkleow==
Date:   Thu, 3 Feb 2022 16:44:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 04/10] PCI/DOE: Introduce pci_doe_create_doe_devices
Message-ID: <20220203224437.GA120552@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201071952.900068-5-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 11:19:46PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL and/or PCI devices can define DOE mailboxes.  

In concrete terms, "DOE mailbox" refers to a DOE Capability, right?
PCIe devices are allowed to implement several instances of the DOE
Capability, of course.  I'm kind of partial to concreteness because it
makes it easier to map between the code and the spec.

> Normally the kernel will want to maintain control of all of these
> mailboxes.  However, under a limited number of use cases users may
> want to allow user space access to some of these mailboxes while the
> kernel retains control of the rest.

Is there something in this patch related to user-space vs kernel
control of things?  To me this patch looks like "for every DOE
Capability on a device, create an auxiliary device and try to attach
an auxiliary device driver to it."

If part of creating the auxiliary devices is adding things in sysfs, I
think it would be useful to mention that here.

> An example of this is for CXL Compliance Testing (see CXL 2.0
> 14.16.4 Compliance Mode DOE) which offers a mechanism to set
> different test modes for a device.

Not sure exactly what this contributes here.  I guess you're saying
you might want user-space access to this, but I don't see anything in
this patch related to that.

> Rather than re-invent the wheel the architecture creates auxiliary
> devices for each DOE mailbox which can then be driven by a generic
> DOE mailbox driver.  If access to an individual mailbox is required
> by user space the driver for that mailbox can be unloaded and access
> handed to user space.

IIUC a device can have several DOE Capabilities, and each Capability
can support several protocols.  So I would think the granularity might
be "protocol" rather than "mailbox" (DOE Capability).

But either way this text seems like it would go with a different patch
since this patch has nothing to specify a particular protocol or even
a particular mailbox/DOE Capability.

> Create the helper pci_doe_create_doe_devices() which iterates each DOE
> mailbox found in the device and creates a DOE auxiliary device on the
> auxiliary bus.  While doing so ensure that the auxiliary DOE driver
> loads to drive that device.

Here's a case where "iterating over DOE mailboxes found in the device"
is slightly abstract.  The code obviously iterates over DOE
*Capabilities* (PCI_EXT_CAP_ID_DOE), and that's something I can easily
find in the spec.

Knowing that this is a PCIe Capability is useful because it puts it in
the context of other capabilities ("optional things that live in
config space") and the mechanisms for synchronization and user-space
access.

> +/**
> + * pci_doe_create_doe_devices - Create auxiliary DOE devices for all DOE
> + *                              mailboxes found
> + * @pci_dev: The PCI device to scan for DOE mailboxes
> + *
> + * There is no coresponding destroy of these devices.  This function associates
> + * the DOE auxiliary devices created with the pci_dev passed in.  That
> + * association is device managed (devm_*) such that the DOE auxiliary device
> + * lifetime is always greater than or equal to the lifetime of the pci_dev.

This seems backwards.  What does it mean if the DOE aux dev lifetime
is *greater* than that of the pci_dev?  Surely you can't access a PCI
DOE Capability if the pci_dev is gone?

> + * RETURNS: 0 on success -ERRNO on failure.
> + */
> +int pci_doe_create_doe_devices(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int irqs, rc;
> +	u16 pos = 0;
> +
> +	/*
> +	 * An implementation may support an unknown number of interrupts.
> +	 * Assume that number is not that large and request them all.

This doesn't really inspire confidence :)  Playing devil's advocate,
since pdev is an arbitrary device, I would assume the number *is*
large.

> +	irqs = pci_msix_vec_count(pdev);
> +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);

pci_msix_vec_count() is apparently sort of discouraged; see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/msi-howto.rst?id=v5.16#n179

A DOE Capability may be implemented by any device, e.g., a NIC or
storage HBA, etc.  I'm a little queasy about IRQ alloc happening both
here and in the driver for the device's primary functionality.  Can
you reassure me that this is actually OK and safe?

Sorry if I've asked this before.  If I have, perhaps a comment would
be useful.

> +	if (rc != irqs) {
> +		/* No interrupt available - carry on */
> +		pci_dbg(pdev, "No interrupts available for DOE\n");
> +	} else {
> +		/*
> +		 * Enabling bus mastering is require for MSI/MSIx.  It could be

s/require/required/
s/MSIx/MSI-X/ to match spec usage.

But I think you only support MSI-X, since you passed "PCI_IRQ_MSIX", not
"PCI_IRQ_MSI | PCI_IRQ_MSIX" above?

> +		 * done later within the DOE initialization, but as it
> +		 * potentially has other impacts keep it here when setting up
> +		 * the IRQ's.

s/IRQ's/IRQs/

"Potentially has other impacts" is too vague, and this doesn't explain
why bus mastering should be enabled here rather than later.  The
device should not issue an MSI-X until DOE Interrupt Enable is set, so
near there seems like a logical place.

> +		 */
> +		pci_set_master(pdev);
> +		rc = devm_add_action_or_reset(dev,
> +					      pci_doe_free_irq_vectors,
> +					      pdev);
> +		if (rc)
> +			return rc;
> +	}

> +++ b/include/linux/pci-doe.h
> @@ -13,6 +13,8 @@
>  #ifndef LINUX_PCI_DOE_H
>  #define LINUX_PCI_DOE_H
>  
> +#define DOE_DEV_NAME "doe"

This is only used once, above.  Why not just use the string there
directly and skip the #define?  If it's needed elsewhere eventually,
we can add a #define then.

Bjorn
