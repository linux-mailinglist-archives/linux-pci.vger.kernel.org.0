Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D793468B5E
	for <lists+linux-pci@lfdr.de>; Sun,  5 Dec 2021 15:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhLEOUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Dec 2021 09:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhLEOUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Dec 2021 09:20:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1BAC061714;
        Sun,  5 Dec 2021 06:16:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638713800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJTQUIRR77MaSNIdhZpi/LTBTa3zuBS70Kn6pQ3k3x4=;
        b=yD1StGSOHlk6RlSGRR+TrLWg0wckaM608a8e99ggT3Bd6RYNRkapYOOSja0cPA0zSjfnDw
        c06H50JiCJEUhCUVUc8qE1csfa8vr5fz52V+zK3Zk42tVbUqzej5yq3wAQjeWeTV5W/BJf
        twK9J70//mEDrfjm4L7ifeevlIXyaAI39wtiEUoa15a38eReRpDY8ycv+lQ/U7UBvLCGFp
        2veaCrVpAu0IeGZk7yfu8kY7HZHwQRH6y1nhcK/Mt/4i1Rma+LVZSPme2rgoyGe+MWhBlm
        aQ3T7dNZQBc6R/KvCJSKfRa9LzdbrWVzDA4evblraJwmI3pR0+g43jeREh+PCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638713800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJTQUIRR77MaSNIdhZpi/LTBTa3zuBS70Kn6pQ3k3x4=;
        b=qH/RLvwSHUt6Ph9FdFVGnlnQOGRwIJr6RblwaJUaSVzx76f4dRY0bxKeW2TgzpeuIos4hI
        LLHLspi6g3Ee7tDw==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <87v9044fkb.ffs@tglx>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com> <87v9044fkb.ffs@tglx>
Date:   Sun, 05 Dec 2021 15:16:40 +0100
Message-ID: <87o85v3znb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 04 2021 at 15:20, Thomas Gleixner wrote:
> On Fri, Dec 03 2021 at 12:41, Jason Gunthorpe wrote:
> So I need to break that up in a way which caters for both cases, but
> does neither create a special case for PCI nor for the rest of the
> universe, i.e. the 1:1 case has to be a subset of the 1:2 case which
> means all of it is common case. With that solved the storage question
> becomes a nobrainer.
>
> When I looked at it again yesterday while writing mail, I went back to
> my notes and found the loose ends where I left off. Let me go back and
> start over from there.

I found out why I stopped looking at it. I came from a similar point of
view what you were suggesting:

>> If IMS == MSI, then couldn't we conceptually have the dev->irqdomain
>> completely unable to handle IMS/MSI/MSI-X at all, and instead, when
>> the driver asks for PCI MSI access we create a new hierarchical
>> irqdomain and link it to a MSI chip_ops or a MSI-X chip_ops - just as
>> you outlined for IMS?  (again, not saying to do this, but let's ask if
>> that makes more sense than the current configuration)

Which I shot down with:

> That's not really a good idea because dev->irqdomain is a generic
> mechanism and not restricted to the PCI use case. Special casing it for
> PCI is just wrong. Special casing it for all use cases just to please
> PCI is equally wrong. There is a world outside of PCI and x86. 

That argument is actually only partially correct.

After studying my notes and some more code (sigh), it looks feasible
under certain assumptions, constraints and consequences.

Assumptions:

  1) The irqdomain pointer of PCI devices which is set up during device
     discovery is not used by anything else than infrastructure which
     knows how to handle it.

     Of course there is no guarantee, but I'm not that horrified about
     it anymore after chasing the exposure with yet more coccinelle
     scripts.

Constraints:

  1) This is strictly opt-in and depends on hierarchical irqdomains.

     If an architecture/subarchitecture wants to support it then it
     needs to rework their PCI/MSI backend to hierarchical irqdomains or
     make their PCI/MSI irqdomain ready for the task.

     From my inspection of 30+ PCI/MSI irqdomains, most of them should
     be trivial to convert. The hard ones are powerpc, XEN and VMD,
     where XEN is definitely the most convoluted one.

     That means that devices which depend on IMS won't work on anything
     which is not up to date.

  2) Guest support is strictly opt-in

     The underlying architecture/subarchitecture specific irqdomain has
     to detect at setup time (eventually early boot), whether the
     underlying hypervisor supports it.

     The only reasonable way to support that is the availability of
     interrupt remapping via vIOMMU, as we discussed before.

  3) IOMMU/Interrupt remapping dependency

     While IMS just works without interrupt remapping on bare metal the
     fact that there is no reliable way to figure out whether the kernel
     runs on bare metal or not, makes it pretty much mandatory, at least
     on x86.

     That's not a hardcoded constraint. It's a decision made during the
     setup of the underlying architecture/subarchitecture specific
     irqdomain.

  4) The resulting irqdomain hierarchy would ideally look like this:

     VECTOR -> [IOMMU, ROUTING, ...] -> PCI/[MSI/MSI-X/IMS] domains

     That does not work in all cases due to architecture and host
     controller constraints, so we might end up with:

           VECTOR -> IOMMU -> SHIM -> PCI/[MSI/MSI-X/IMS] domains

     The nice thing about the irqdomain hierarchy concept is that this
     does not create any runtime special cases as the base hierarchy is
     established at boot or device detection time. It's just another
     layer of indirection.

  5) The design rules for the device specific IMS irqdomains have to be
     documented and enforced to the extent possible.

     Rules which I have in my notes as of today:

       - The device specific IMS irq chip / irqdomain has to be strictly
         separated from the rest of the driver code and can only
         interact via the irq chip data which is either per interrupt or
         per device.

         I have some ideas how to enforce these things to go into
         drivers/irqchip/ so they are exposed to scrutiny and not
         burried in some "my device is special" driver code and applied
         by subsystem maintainers before anyone can even look at it. 

       - The irqchip callbacks which can be implemented by these top
         level domains are going to be restricted.

       - For the irqchip callbacks which are allowed/required the rules
         vs. following down the hierarchy need to be defined and
         enforced.

       - To achieve that the registration interface will not be based on
         struct irq_chip. This will be a new representation and the core
         will convert that into a proper irq chip which fits into the
         hierarchy. This provides one central place where the hierarchy
         requirements can be handled as they depend on the underlying
         MSI domain (IOMMU, SHIM, etc.). Otherwise any change on that
         would require to chase the IMS irqchips all over the place.

Consequences:

  1) A more radical split between legacy and hierarchical irqdomain
     code in drivers/pci/msi/ into:

       - api
       - legacy
       - irqdomain
       - shared

     That means that we are going to end up with duplicated code for
     some of the mechanisms up to the point where the stuck-in-the-mud
     parts either get converted or deleted.

  2) The device centric storage concept will stay as it does not make
     any sense to push it towards drivers and what's worse it would be a
     major pain vs. the not yet up to the task irqdomains and the legacy
     architecture backends to change that. I really have no interrest to
     make the legacy code 

     It also makes sense because the interrupts are strictly tied to the
     device. They cannot originate from some disconnected layer of thin
     air.

     Sorry Jason, no tables for you. :)

How to get there:

  1) I'm going to post part 1-3 of the series once more with the fallout
     and review comments addressed.

  2) If nobody objects, I'll merge that into tip irq/msi and work on top
     of that.

     The consolidation makes sense on it's own and is required anyway. I
     might need to revisit some of the already touched places, but that
     should be a halfways limited number. I rather do that step for step
     on top than going back to start and mixing the new concepts in from
     the very beginning.

     But I drop part 4 in it's current form because that's going to be
     part of the new infrastructure.

  3) I'll work on that bottom up towards a driver exposable API as that
     is going to be a result of the final requirements of the underlying
     infrastructure.

     The final driver visible interfaces can be bikeshedded on top to
     make them palatable for driver writers.

  4) Convert x86 PCI/MSI[x] to the new scheme

  5) Implement an IMS user.

     The obvious candidate which should be halfways accessible is the
     ath11 PCI driver which falls into that category.

     It uses horrendous hackery to make it "work" by abusing MSI. It's a
     wonder that it works at all, by some definition of "works".

     I'm pretty sure how to make it fall apart without touching a single
     line of code.

     With a small code change I can make it fail hard without blowing up
     any other MSI/MSI-X user except the switchtec NTB.

     That's a prime example for the way how driver writers behave.

     Instead of talking to the people who are responsible for the
     interrupt subsystem, they go off and do their own thing. It does
     not explode on their test machine, but it's not even remotely close
     to the requirements for PCI drivers to work independent of the
     underlying platform.

     Of course the responsible maintainer does not even notice and waves
     it through without questioning it.

Thoughts?

Thanks,

        tglx
