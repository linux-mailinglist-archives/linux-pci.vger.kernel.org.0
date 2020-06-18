Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1391FF928
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgFRQXc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 12:23:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:18458 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFRQXb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 12:23:31 -0400
IronPort-SDR: DalMYkUIovDenS3rRjhBnn04QCEfuS7SBEGD9zcnk0jwaae60/mEfSUVKQbmeTnY+HcoYeIH5e
 gynoD7S6JRnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204130591"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="204130591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 09:23:25 -0700
IronPort-SDR: qX7R8j79zmP2NjUAVlcMr1vg/ibC0ww/wL32qvXjjmErmo0tc+v8JyC55vN+zndnXIFsm7IoBV
 vT1ix66ELVOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="262970585"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2020 09:23:22 -0700
Date:   Thu, 18 Jun 2020 09:23:22 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>,
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
Message-ID: <20200618162322.GI34820@otc-nc-03>
References: <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com>
 <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
 <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
 <20200618160212.GB3076467@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618160212.GB3076467@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,


On Thu, Jun 18, 2020 at 06:02:12PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 18, 2020 at 08:03:49AM -0700, Rajat Jain wrote:
> > Hello,
> > 
> > On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > > > > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > > > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > (and likely call it "external" instead of "untrusted".
> > > > >
> > > > > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > > > > chosen by the meaning of it.
> > > > > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > > > > tables, but I can replace it.
> > > >
> > > > Then your ACPI tables should show this, there is an attribute for it,
> > > > right?
> > >
> > > There is a _PLD() method, but it's for the USB devices (or optional
> > > for others, I don't remember by heart). So, most of the ACPI tables,
> > > alas, don't show this.
> > >
> > > > > This is only one example. Or if firmware of some device is altered,
> > > > > and it's internal (whatever it means) is it trusted or not?
> > > >
> > > > That is what people are using policy for today, if you object to this,
> > > > please bring it up to those developers :)
> > >
> > > > > So, please leave it as is (I mean name).
> > > >
> > > > firmware today exports this attribute, why do you not want userspace to
> > > > also know it?
> > 
> > To clarify, the attribute exposed by the firmware today is
> > "ExternalFacingPort" and "external-facing" respectively:
> > 
> > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > 9cb30a71ac45d("PCI: OF: Support "external-facing" property")
> > 
> > The kernel flag was named "untrusted" though, hence the assumption
> > that "external=untrusted" is currently baked into the kernel today.
> > IMHO, using "external" would fix that (The assumption can thus be
> > contained in the IOMMU drivers) and at the same time allow more use of
> > this attribute.
> > 
> > > >
> > > > Trust is different, yes, don't get the two mixed up please.  That should
> > > > be a different sysfs attribute for obvious reasons.
> > >
> > > Yes, as a bottom line that's what I meant as well.
> > 
> > So what is the consensus here? I don't have a strong opinion - but it
> > seemed to me Greg is saying "external" and Andy is saying "untrusted"?
> 
> Those two things are totally separate things when it comes to a device.

Agree that these are two separate attributes, and better not mixed.

> 
> One (external) describes the location of the device in the system.
> 
> The other (untrusted) describes what you want the kernel to do with this
> device (trust or not trust it).
> 
> One you can change (from trust to untrusted or back), the other you can
> not, it is a fixed read-only property that describes the hardware device
> as defined by the firmware.

The genesis is due to lack of a mechanism to establish if the device 
is trusted or not was the due lack of some specs and implementation around
Component Measurement And Authentication (CMA). Treating external as
untrusted was the best first effort. i.e trust internal 
devices and don't trust external devices for enabling ATS.

But that said external is just describing topology, and if Linux wants to
use that in the policy that's different. Some day external device may also
use CMA to estabilish trust. FWIW even internal devices aren't trust
worthy, except maybe RCIEP's. 

> 
> Depending on the policy you wish to define, you can use the location of
> the device to determine if you want to trust the device or not.
> 

Cheers,
Ashok
