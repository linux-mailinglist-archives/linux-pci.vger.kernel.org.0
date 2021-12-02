Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88A2466151
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356888AbhLBKUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 05:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356958AbhLBKUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 05:20:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694DC06174A;
        Thu,  2 Dec 2021 02:16:42 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638440199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RdevRfhjsHKeeCHTf9pHmrkF5+sLZu5HIYbbAd1ahA0=;
        b=CE0G0O5lmKxqkZC6BvlCruxb6hHn9pwsgNHT2CVOhNKska1IejpMxdl7YLMkS31AeiiP2P
        Te9ThMTsDiSJz3lfhgB3+yOnRaqm2z1iFM+gbLYtCcS1ULM58LD9cUw9r6HX8Qjm5+9u94
        /8Ea+50Mo6rWAgRVbrXNFAQMru8nmGk67ms7jqMhvLa0ssFSWJ+r3Xvq8/6l9WRP1oq/q1
        qmYyulR+iammXO7J2ukF1k3h6EC7jAr7afu4r5wKpliQqck8ti7wNpLdlgRJ9pIeewPxs7
        rS+AMHbbyQ2DgPwLknFCXgKQioSjvlDzvffI7rlb9lJkofsI5uUAJPbBQcFyRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638440199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RdevRfhjsHKeeCHTf9pHmrkF5+sLZu5HIYbbAd1ahA0=;
        b=2v0AYZhnbZ5OYxQiErXDK00fVJE5282NMNIpfLbx7OIHuFdbV0rSBUfPA1Gl76ETV2FIh1
        z+CYQVKoJ7EfZiDQ==
To:     "Dey, Megha" <megha.dey@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [patch 09/10] PCI/MSI: Provide pci_msix_expand_vectors[_at]()
In-Reply-To: <7ad200fa-dda3-4932-cd23-ad6e79288ea4@intel.com>
References: <20211126233124.618283684@linutronix.de>
 <20211127000919.004572849@linutronix.de>
 <7ad200fa-dda3-4932-cd23-ad6e79288ea4@intel.com>
Date:   Thu, 02 Dec 2021 11:16:39 +0100
Message-ID: <871r2v71mg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Megha,

On Wed, Dec 01 2021 at 17:08, Megha Dey wrote:
> On 11/26/2021 5:25 PM, Thomas Gleixner wrote:
>>   /**
>> + * pci_msix_expand_vectors_at - Expand MSI-X interrupts for a device
>> + *
>> + * @dev:	PCI device to operate on
>> + * @at:		Allocate at MSI-X index. If @at == PCI_MSI_EXPAND_AUTO
>> + *		the function expands automatically after the last
> Not sure why some of these changes related to PCI_MSIX_EXPAND_AUTO and 
> num_descs did not make it to the 'msi' branch.
> Is this intentional?

Yes, because I'm not happy about that magic.

>
> For instance, say:
> 1. Driver requests for 5 vectors:
> pci_enable_msix_range(dev, NULL, 5, 5)
> =>num_descs = 5

Driver should not use with pci_enable_msix_range() in the first
place. But yes, it got 5 vectors now.

> 2. Driver frees vectors at index 1,2:
> range = {1, 2, 2};
> pci_msi_teardown_msi_irqs(dev, range)

That function is not accessible by drivers for a reason.

> =>num_descs = 3; Current active vectors are at index: 0, 3, 4

> 3. Driver requests for 3 more vectors using the new API:
> pci_msix_expand_vectors(dev, 3)
> =>range.first = 3 => It will try to allocate index 3-5, but we already 
> have 3,4 active?
> Ideally, we would want index 1,2 and 5 to be allocated for this request 
> right?
>
> Could you please let me know what I am missing?

You're missing the real world use case. The above is fiction.

If a driver would release 1 and 2 then it should explicitely reallocate
1 and 2 and not let the core decide to magically allocate something.

If the driver wants three more after freeing 1, 2 then the core could
just allocate 5, 6, 7, and would still fulfil the callers request to
allocate three more, right?

And even if it just allocates one, then the caller still has to know the
index upfront. Why? Because it needs to know it in order to get the
Linux interrupt number via pci_irq_vector().

> Correspondingly, pci_free_msix_irq_vector(pdev, irq) frees all the 
> allocated resources associated with MSI-X interrupt with Linux IRQ 
> number 'irq'.
> I had issues when trying to dynamically allocate more than 1 interrupt 
> because I didn't have a clean way to communicate to the driver what 
> indexes were assigned in the current allocation.

If the driver is able to free a particular vector then it should exactly
know what it it doing and which index it is freeing. If it needs that
particular vector again, then it knows the index, right?

Let's look how MSI-X works in reality:

Each vector is associated to a particular function in the device. How
that association works is device dependent.

Some devices have hardwired associations, some allow the driver to
program the association in the device configuration and there is also a
combination of both.

So if the driver would free the vector for a particular functionality,
or not allocate it in the first place, then it exactly knows what it
freed and what it needs to allocate when it needs that functionality
(again).

What you are trying to create is a solution in search of a problem. You
cannot declare via a random allocation API how devices work. You neither
can fix the VFIO issue in a sensible way.

VFIO starts with vector #0 allocated. The guest then unmasks vector #50.

With your magic interface VFIO has to allocate 49 vectors and then free
48 of them again or just keep 48 around for nothing which defeats the
purpose of on demand allocation completely.

Thanks,

        tglx





