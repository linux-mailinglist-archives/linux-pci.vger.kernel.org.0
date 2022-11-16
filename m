Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB862CDB8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 23:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbiKPWcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 17:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiKPWcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 17:32:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6FC5B5BC;
        Wed, 16 Nov 2022 14:32:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668637936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V/ssat/flSoi4btttdySdzHQsU/KpJg2vJXKf88LBtU=;
        b=cmmrkbIWfDx5tGxKbfX4KFEorkEWs+jQjoCjFlfGtYTrCjuzLDg74ykOMwPW8p62SlDRS0
        TCNUOnFamduh4j8wg2sRb9TnSuQBKRQDiTo2msS1+G8zYc4h0FHJR6ljmsWjvJNe2GOV2+
        fsq50qTdYQJ9tleznOHGnJp50PRF7mhuLjcStNuYY2kqX+ml/Re7hV4eCcrXxURW/AdZCF
        87HeRLdS98AP4iEl2JQ/LO+T9jBIfzMIH+dsBjx4Mxh1m5N4Y7YFieiPOB7prYOWqJCugw
        F1qI8lBcmojFxucmsfLcwoJj2q2Yc7hZXifLRsc2R6eB4HliF+ZG0Wsy1sQBaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668637936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V/ssat/flSoi4btttdySdzHQsU/KpJg2vJXKf88LBtU=;
        b=U5ePqnOgAXYchH3LcWznbQ9LIgj8qyf5D/gCLEoyngggMje45Xm8vBAqSXe4YqLxMakrq1
        8UabAYscklSCREBQ==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 08/20] genirq/msi: Make MSI descriptor iterators device
 domain aware
In-Reply-To: <Y3UtlTwIka6n0RuT@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.500733944@linutronix.de> <Y3UtlTwIka6n0RuT@nvidia.com>
Date:   Wed, 16 Nov 2022 23:32:15 +0100
Message-ID: <87wn7uo7io.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16 2022 at 14:36, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:56:50PM +0100, Thomas Gleixner wrote:
>> To support multiple MSI interrupt domains per device it is necessary to
>> segment the xarray MSI descriptor storage. Each domain gets up to
>> MSI_MAX_INDEX entries.
>
> This kinds of suggests that the new per-device MSI domains should hold
> this storage instead of per-device xarray?

No, really not. This would create random storage in random driver places
instead of having a central storage place which is managed by the core
code. We've had that back in the days when every architecture had it's
own magic place to store and manage interrupt descriptors. Seen that,
mopped it up and never want to go back.

> I suppose the reason to avoid this is because alot of the driver
> facing API is now built on vector index numbers that index this
> xarray?

That's one aspect, but as I demonstrate later even for the IMS domains
which do not have a real requirement for 'index' you still need to have
a place to store the MSI descriptor and allocate storage space for it.

I really don't want to have random places doing that because then I
can't provide implicit MSI descriptor management, e.g. automatic
alloc/free anymore and everything has to happen at the driver side. The
only reason why I still need to do that for PCI/MSI is to be able to
support the museum architectures which still depend on the arch_....()
interfaces from 20 years ago.

So if a IMS domain, which e.g. stores the MSI message in queue memory,
wants a new interrupt then it allocates it with MSI_ANY_INDEX, which
gives it the next free slot in the XARRAY section of the MSI domain.

This avoids having IDA, bitmap allocators or whatever at the driver side
and having a virtual index number to track things does not affect the
flexibility of the driver side in any way.

All the driver needs at the very end is the interrupt number and the
message itself.

> But on the other hand can we just say drivers using multiple domains
> are "new" and they should use some new style pointer based interface
> so we don't have to have arrays of things?

Then driver writers have to provide storage for the domain pointer and
care about teardown etc. Seriously? NO!

> At least, I'd like to understand a bit better the motivation for using
> a domain ID instead of a pointer.

The main motivation was to avoid device specific storage for the irq
domain pointers. It would have started with PCI/MSI[X]: I'd had to add a
irqdomain pointer to struct pci_dev and then have the PCI core care
about it. So we'd add that to everything and the world which utilizes
per device MSI domains which is quite a few places outside of PCI in the
ARM64 world and growing.

The msi_device_data struct which is allocated on demand for MSI usage is
the obvious point to store _and_ manage these things, i.e. managed
teardown etc.

Giving this up makes any change to the core code hard because you have
to chase all usage sites and mop them up. Just look at the ARM part of
this series which is by now 40+ patches just to mop up the irqchip
core. There are still 25 PCI/MSI global irqdomain left.

> It feels like we are baking in several hard coded limits with this
> choice

Which ones?

The chosen array section size per domain is arbitrary and can be changed
at any given time. Though you have to exhaust 64k vectors per domain
first before we start debating that.

The number of irqdomains is not really hard limited either. It's trivial
enough to extend that number and once we hit 32 we just can stash them
away in the xarray. I pondered to do that right away, but that wastes
too much memory for now.

It really does not matter whether the domain creation results in a
number or in a pointer. Pointers are required for the inner workings of
the domain hierarchy but absolutely uninteresting for endpoint domains.

All you need there is a conveniant way to create the domain and then
allocate/free interrupts as you see fit.

We agreed a year ago that we want to abstract most of these things away
for driver writers and that all they need is simple way to create the
domains and the corresponding interrupt chip is mostly about writing the
MSI message to implementation defined storage and eventually providing a
implementation specific mask/unmask operation.

So what are you concerned about?

Thanks,

        tglx
