Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5FE1FFB47
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgFRSqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 14:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgFRSqa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 14:46:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2B2208DB;
        Thu, 18 Jun 2020 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592505989;
        bh=39kwGWJQnjfPiKs05x4HsotVBIPPsgkmzXLdYD1Ko8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ji8AXAluHvvoAmMwrjxl6TLNm7J2vVNMEj/eNho7vDCFnChfn98b6KVXCtZxL1CFE
         rGdaWGvdez9DKhhUd+a6J00iz0MRvJO/NRn8tTpyPk3hgUM520s8gGhy692qvYxDx6
         1rgnQYgfRwNPX6/IxJPJpm+MD8Z+tVbt6MWvsfsU=
Date:   Thu, 18 Jun 2020 20:46:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200618184621.GA446639@kroah.com>
References: <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com>
 <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
 <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
 <20200618160212.GB3076467@kroah.com>
 <20200618162322.GI34820@otc-nc-03>
 <CACK8Z6EnqmJtSqPPz2ARk0jwFLR_yCTS0vSLQ0v4C9QF-6BQ1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6EnqmJtSqPPz2ARk0jwFLR_yCTS0vSLQ0v4C9QF-6BQ1w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 18, 2020 at 10:23:38AM -0700, Rajat Jain wrote:
> Thanks Greg and Andy for your continued inputs, and thanks Ashok for chiming in.
> 
> On Thu, Jun 18, 2020 at 9:23 AM Raj, Ashok <ashok.raj@intel.com> wrote:
> >
> > Hi Greg,
> >
> >
> > On Thu, Jun 18, 2020 at 06:02:12PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jun 18, 2020 at 08:03:49AM -0700, Rajat Jain wrote:
> > > > Hello,
> > > >
> > > > On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > > > > > > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > > > > > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > (and likely call it "external" instead of "untrusted".
> > > > > > >
> > > > > > > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > > > > > > chosen by the meaning of it.
> > > > > > > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > > > > > > tables, but I can replace it.
> > > > > >
> > > > > > Then your ACPI tables should show this, there is an attribute for it,
> > > > > > right?
> > > > >
> > > > > There is a _PLD() method, but it's for the USB devices (or optional
> > > > > for others, I don't remember by heart). So, most of the ACPI tables,
> > > > > alas, don't show this.
> > > > >
> > > > > > > This is only one example. Or if firmware of some device is altered,
> > > > > > > and it's internal (whatever it means) is it trusted or not?
> > > > > >
> > > > > > That is what people are using policy for today, if you object to this,
> > > > > > please bring it up to those developers :)
> > > > >
> > > > > > > So, please leave it as is (I mean name).
> > > > > >
> > > > > > firmware today exports this attribute, why do you not want userspace to
> > > > > > also know it?
> > > >
> > > > To clarify, the attribute exposed by the firmware today is
> > > > "ExternalFacingPort" and "external-facing" respectively:
> > > >
> > > > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > > > 9cb30a71ac45d("PCI: OF: Support "external-facing" property")
> > > >
> > > > The kernel flag was named "untrusted" though, hence the assumption
> > > > that "external=untrusted" is currently baked into the kernel today.
> > > > IMHO, using "external" would fix that (The assumption can thus be
> > > > contained in the IOMMU drivers) and at the same time allow more use of
> > > > this attribute.
> > > >
> > > > > >
> > > > > > Trust is different, yes, don't get the two mixed up please.  That should
> > > > > > be a different sysfs attribute for obvious reasons.
> > > > >
> > > > > Yes, as a bottom line that's what I meant as well.
> > > >
> > > > So what is the consensus here? I don't have a strong opinion - but it
> > > > seemed to me Greg is saying "external" and Andy is saying "untrusted"?
> > >
> > > Those two things are totally separate things when it comes to a device.
> >
> > Agree that these are two separate attributes, and better not mixed.
> 
> +1.
> 
> >
> > >
> > > One (external) describes the location of the device in the system.
> > >
> > > The other (untrusted) describes what you want the kernel to do with this
> > > device (trust or not trust it).
> > >
> > > One you can change (from trust to untrusted or back), the other you can
> > > not, it is a fixed read-only property that describes the hardware device
> > > as defined by the firmware.
> 
> Correct. I believe what is being described by the firmware is a fixed
> read-only property describing the location of the device ("external")
> - not what to do with it ("untrusted").
> 
> >
> > The genesis is due to lack of a mechanism to establish if the device
> > is trusted or not was the due lack of some specs and implementation around
> > Component Measurement And Authentication (CMA). Treating external as
> > untrusted was the best first effort. i.e trust internal
> > devices and don't trust external devices for enabling ATS.
> >
> > But that said external is just describing topology, and if Linux wants to
> > use that in the policy that's different. Some day external device may also
> > use CMA to estabilish trust. FWIW even internal devices aren't trust
> > worthy, except maybe RCIEP's.
> 
> Correct. Since the firmware is actually describing the unchangeable
> topology (and not the policy), the takeaway I am taking from this
> discussion is that the flag should be called "external".

The attribute should be called something like "location" or something
like that (naming is hard), as you don't always know if something is
external or not (it could be internal, it could be unknown, it could be
internal to an external device that you trust (think PCI drawers for
"super" computers that are hot pluggable but yet really part of the
internal bus).

> Like I said, I don't have any hard opinions on this. So if you feel
> that my conclusion is wrong and consensus was the other way around
> ("untrusted"), let me know and I'll be happy to change this.

"trust" has no direct relation to the location, except in a policy of
what you wish to do with that device, so as long as you keep them
separate that way, I am fine with it.

thanks,

greg k-h
