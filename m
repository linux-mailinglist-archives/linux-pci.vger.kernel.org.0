Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B830F47B611
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhLTXGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 18:06:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:2833 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhLTXGa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Dec 2021 18:06:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240238460"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="240238460"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 15:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="507859857"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 20 Dec 2021 15:06:25 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 3D273580684;
        Mon, 20 Dec 2021 15:06:25 -0800 (PST)
Message-ID: <e87a297cc74cca02fa1a8f5aa9562489a4db26b3.camel@linux.intel.com>
Subject: Re: [PATCH V4 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     francisco.munoz.ruiz@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Date:   Mon, 20 Dec 2021 15:06:25 -0800
In-Reply-To: <20211220172848.GA1006510@bhelgaas>
References: <20211220172848.GA1006510@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Born,

So you know this patch comes from our platform power management team to address several VMD bugs
affecting power. The VMD driver developers are already cc'd but also adding Francisco from the VMD
team who can maybe help clarify.

On Mon, 2021-12-20 at 11:28 -0600, Bjorn Helgaas wrote:
> On Thu, Dec 16, 2021 at 01:24:00PM -0800, David E. Box wrote:
> > On Thu, 2021-12-16 at 11:26 -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 15, 2021 at 09:56:00PM -0800, David E. Box wrote:
> > > > From: Michael Bottini <michael.a.bottini@linux.intel.com>
> > > > 
> > > > On Tiger Lake and Alder Lake platforms, VMD controllers do not have ASPM
> > > > enabled nor LTR values set by BIOS. This leads high power consumption on
> > > > these platforms when VMD is enabled as reported in bugzilla [1].  Enable
> > > > these features in the VMD driver using pcie_aspm_policy_override() to set
> > > > the ASPM policy for the root ports.
> > > > ...
> 
> > > > To do this, add an additional flag in VMD features to specify
> > > > devices that must have their respective policies overridden.
> > > 
> > > I'm not clear on why you want this to apply to only certain VMDs
> > > and not others.  Do some BIOSes configure ASPM for devices below
> > > some VMDs?
> > 
> > Not currently. But the plan is for future devices to move back to
> > having BIOS do the programming.
> 
> Since this is apparently a BIOS design choice, it seems wrong to base
> the functionality on the Device ID instead of some signal that tells
> us what the BIOS is doing.

I don't know if there is another way to tell what the BIOS is _not_ doing. DID is tied to the SoC so
it's our best method of inferring this. We know the firmware team has said they will not support
programming these values for the mentioned platforms so there's no BIOS update coming to change
this. But to be sure, we can add a check first to confirm that these values have not been programmed
(ASPM is disabled and LTRs are 0).

> 
> > > > + * Override the BIOS ASPM policy and set the LTR value for PCI storage
> > > > + * devices on the VMD bride.
> > > 
> > > I don't think there's any BIOS "policy" here.  At this point BIOS
> > > is no longer involved at all, so all that's left is whatever ASPM
> > > config the BIOS did or did not do.
> > > 
> > > Why only storage?
> > 
> > Only storage devices will be on these root ports.
> 
> How do you know this?  You say below that there's an M.2 slot, so
> surely the slot could contain a non-storage device?  Couldn't somebody
> build a platform with a VMD root port connected to a regular PCIe x4
> slot?

In VMD mode the root ports under the VMD bridge are used specifically to manage storage devices. So
only storage devices should be attached to these ports.

>   Couldn't such a slot support hotplug?

The answer I just learned is yes. It may be possible to have a switch too. So both of those would
need to be addressed though I'm note quite sure how yet.

> 
> It would be very unusual to hard-code topology knowledge like this
> into the kernel, since plug-and-play has always been a major goal of
> PCI.
> 
> > > > +static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
> > > > +{
> > > > +       int features = *(int *)userdata, pos;
> > > > +
> > > > +       if (!(features & VMD_FEAT_QUIRK_OVERRIDE_ASPM) ||
> > > > +           pdev->class != PCI_CLASS_STORAGE_EXPRESS)
> > > > +               return 0;
> 
> > > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, 0x1003);
> > > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, 0x1003);
> > > 
> > > 1) Where did this magic 0x1003 value come from?  Does that depend
> > > on the VMD device?  The endpoint?  The circuit design?  The path
> > > between endpoint and VMD?  What if there are switches in the path?
> > 
> > The number comes from the BIOS team. They are tied to the SoC. I
> > don't believe there can be switches in the path but Nirmal and
> > Jonathan should know for sure. From what I've seen these root ports
> > are wired directly to M.2 slots on boards that are intended for
> > storage devices.
> 
> I guess you're saying that 0x1003 is determined by the SoC.  If so, I
> think this value should be in your .driver_data (which would mean
> converting it from a scalar to a struct, as many other drivers do).
> The current code suggests that 0x1003 is the correct value for *all*
> VMDs and all configurations.

Okay

> 
> I don't understand LTR well enough to be convinced that this static
> value would be the correct value for all possible hierarchies and
> devices that could appear below a VMD root port.  I would love to be
> educated about this.

I am not an LTR expert either, but LTRs are "conglomerated" per spec. Switches subtract their own
latency from the minimum LTR of the downstream ports and report this conglomerated value upstream.
So the value will decrease as needed to account for latency in the hierarchy.

PCI 5.0 Version 1.0, Section 6.18 (pg 611)

Thanks

David

> 
> Bjorn


