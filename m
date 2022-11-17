Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A94062E59C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiKQUG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 15:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiKQUG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 15:06:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC77EC9A;
        Thu, 17 Nov 2022 12:06:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668715586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=qcD1k1mFFqDHjccWe0U4zK9haA6bVwSgu2XkXRPpKoQ=;
        b=M5oRc0URtMxDLBMLSjbRIxF7c8BaJIU8/SrQjNqL6s9ALlNNLDVYbLmIQ0J3AQCQFNnQJl
        mUlZqS7tQXrmeu34rvmsAdsPhMO/8QrTjM4WzQ6Cn95NZCsILsojtH+TuY7AXF0mfuN9Bk
        AJKzTBw+O44mC+8mnRpB3NF8PDM7dKneVA+u3xKCjDCxxlTKijifaibKFhJKit5j0kz2GX
        PJ3Xa6l+ZzC7CrXhbf+Ujg3pzrGpcxKbc6WE2TVywVMnlnGhKNVBx+scqDnEIdx0R7ZQzX
        nzKo7++OyrSo7k8Jb8f1yn0aYW0M+yE23n8iS9lP3oZwvjle/VI8iBMHs8ZXpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668715586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=qcD1k1mFFqDHjccWe0U4zK9haA6bVwSgu2XkXRPpKoQ=;
        b=jXKJSs4PiMZtlYfYiedLWbME4yHxTLbmffNpYybx5jEfJRheIeolag/rmmoP/r5ALuPdqc
        ca7JeKIc/0orNqCQ==
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
Subject: Re: [patch 13/33] x86/apic/vector: Provide MSI parent domain
In-Reply-To: <Y3U3dQhVCYF0on6v@nvidia.com>
Date:   Thu, 17 Nov 2022 21:06:25 +0100
Message-ID: <87pmdll51a.ffs@tglx>
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

On Wed, Nov 16 2022 at 15:18, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:58:31PM +0100, Thomas Gleixner wrote:
>> +static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>> +				  struct irq_domain *real_parent, struct msi_domain_info *info)
>> +{
>> +	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
>> +
>> +	/* MSI parent domain specific settings */
>> +	switch (real_parent->bus_token) {
>> +	case DOMAIN_BUS_ANY:
>> +		/* Only the vector domain can have the ANY token */
>> +		if (WARN_ON_ONCE(domain != real_parent))
>> +			return false;
>> +		info->chip->irq_set_affinity = msi_set_affinity;
>> +		/* See msi_set_affinity() for the gory details */
>> +		info->flags |= MSI_FLAG_NOMASK_QUIRK;
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		return false;
>> +	}
>> +
>> +	/* Is the target supported? */
>> +	switch(info->bus_token) {
>> +	case DOMAIN_BUS_PCI_DEVICE_MSI:
>> +	case DOMAIN_BUS_PCI_DEVICE_MSIX:
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		return false;
>
> Why does x86 care how the vector is ultimately programmed into the
> device?

That's not the point.

> The leaking of the MSI programming model into the irq implementations
> seems like there is still a troubled modularity.
>
> I understand that some implementations rely on a hypercall/trap or
> whatever and must know MSI vs MSI-X, but I'm surprised to see this
> here.

Why? It's the 'init a new per device domain' code which can rightfully
have a say whether it is willing to support something or not or to put
constraints on it. Those constraints can very much depend on the device
type or the MSI type. Creating random MSI domains seems to be pretty
envogue today and I really have no interest to deal with the fallout
once the fancy muck is merged in some random subsystem and the developer
moved on. I have no idea why everyone thinks that driver writers should
be granted the ultimate freedom to do what they want and anything which
puts an constraint on something is bad and troubled to begin with.

Since I started to strictly encapsulate and fence of things, the amount
of horrors I had to debug and then mop up has significantly decreased.
It also forces people who want to add some new fancy stuff to talk to
the infrastructure people so that the new functionality can be looked at
in the broader picture and solutions can be found upfront and not after
the fact when the resulting damage is discovered.

Quite some of the issues I discovered during last years discussions,
like the VFIO disable/enable trainwreck, the IRQ_VIRTUAL nonsense and
other random hacks could have neen avoided if people would actually talk
to each other and not just run off and hack something into place which
then gets somehow merged.

On the ARM side there is even a fundamental requirement for this today
due to the way how the existing infrastructure handles PCI/MSI[X] and
platform MSI, unless we go and rewrite half of the underlying code first
or in parallel.

It was also a migration aid to catch issues in the gradual conversion.

Again, we are not starting from a clean slate. I might be overly
cautious, but for very good reasons.

Thanks,

        tglx


