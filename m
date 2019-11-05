Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED9F073B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 21:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfKEUt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 15:49:58 -0500
Received: from foss.arm.com ([217.140.110.172]:32792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbfKEUt5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 15:49:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEAE111D4;
        Tue,  5 Nov 2019 12:49:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16CE73FCD9;
        Tue,  5 Nov 2019 02:12:14 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:12:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "Paszkiewicz, Artur" <artur.paszkiewicz@intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "Fugate, David" <david.fugate@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Message-ID: <20191105101208.GA21113@e121166-lin.cambridge.arm.com>
References: <20191101215302.GA217821@google.com>
 <5c4521d26f45cfe01631d14c3d7edc9a10f99245.camel@intel.com>
 <20191104180700.GB26409@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104180700.GB26409@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 04, 2019 at 06:07:00PM +0000, Lorenzo Pieralisi wrote:
> On Fri, Nov 01, 2019 at 10:16:39PM +0000, Derrick, Jonathan wrote:
> > Hi Bjorn,
> > 
> > On Fri, 2019-11-01 at 16:53 -0500, Bjorn Helgaas wrote:
> > > [+cc Andrew]
> > > 
> > > On Wed, Oct 16, 2019 at 11:04:47AM -0600, Jon Derrick wrote:
> > > > When some VMDs are enabled and others are not, it's difficult to
> > > > determine which IIO stack corresponds to the enabled VMD.
> > > > 
> > > > To assist userspace with management tasks, VMD BIOS will write the VMD
> > > > instance number and socket number into the first enabled root port's IO
> > > > Base/Limit registers prior to OS handoff. VMD driver can capture this
> > > > information and expose it to userspace.
> > > 
> > > Hmmm, I'm not sure I understand this, but it sounds possibly fragile.
> > > Are these Root Ports visible to the generic PCI core device
> > > enumeration?  If so, it will find them and read these I/O window
> > > registers.  Maybe today the PCI core doesn't change them, but I'm not
> > > sure we should rely on them always being preserved until the vmd
> > > driver can claim the device.
> > > 
> > 
> > The Root Ports are on the VMD PCI domain, and this IO BASE/LIMIT
> > parsing occurs before this PCI domain is exposed to the generic PCI
> > scancode with pci_scan_child_bus(). Until that point the VMD PCI domain
> > is invisible to the kernel outside of /dev/mem or resource0.
> 
> That's because the VMD controller is a PCI device itself and its
> BARs values are used to configure the VMD host controller.
> 
> Interesting.
> 
> To add to Bjorn's question, this reasoning assumes that whatever
> code enumerates the PCI device representing the VMD host controller
> does not overwrite its BARs upon bus enumeration otherwise the VMD
> controller configuration would be lost. Am I reading the current
> code correctly ?

Sorry, I just went through the code again, I think the VMD controller
PCI device BARs can and are allowed to be reassigned by the PCI
enumeration code - I misread the code, so I raised a non-existent issue
here, they are like any other PCI device MEM/IO BARs in this respect.

Lorenzo

> I assume there is not anything you can do to add firmware bindings to
> the VMD host controller PCI device to describe these properties you are
> exporting, so config space is the only available conduit to report them
> to an OS.
> 
> Lorenzo
> 
> > However, yes, it is somewhat fragile in that a third-party driver could
> > attach to the VMD endpoint prior to the VMD driver and modify the
> > values. A /dev/mem or resource0 user could also do this on an
> > unattached VMD endpoint.
> > 
> > I'm wondering if this would also be better suited for a special reset
> > in quirks.c, but it would need to expose a bit of VMD config accessing
> > in quirks.c to do that.
> > 
> > > But I guess you're using a special config accessor (vmd_cfg_read()),
> > > so these are probably invisible to the generic enumeration?
> > > 
> > 
> > Yes the VMD domain is invisible to generic PCI until the domain is
> > enumerated late in vmd_enable_domain().
> > 
> > > > + * for_each_vmd_root_port - iterate over all enabled VMD Root Ports
> > > > + * @vmd: &struct vmd_dev VMD device descriptor
> > > > + * @rp: int iterator cursor
> > > > + * @temp: u32 temporary value for config read
> > > > + *
> > > > + * VMD Root Ports are located in the VMD PCIe Domain at 00:[0-3].0, and config
> > > > + * space can be determinately accessed through the VMD Config BAR. Because VMD
> > > 
> > > I'm not sure how to parse "determinately accessed".  Maybe this config
> > > space can *only* be accessed via the VMD Config BAR?
> > 
> > Perhaps it should instead say determinately addressed, as each Root
> > Port config space is addressable at some offset of N * 0x8000 from the
> > base of the VMD endpoint config bar. I can see the comment may not be
> > helpful as that detail is abstracted using the vmd_cfg_read() helper.
> > 
> > 
> > > 
> > > > + * Root Ports can be individually disabled, it's important to iterate for the
> > > > + * first enabled Root Port as determined by reading the Vendor/Device register.
> > > > + */
> > > > +#define for_each_vmd_root_port(vmd, rp, temp)				\
> > > > +	for (rp = 0; rp < 4; rp++)					\
> > > > +		if (vmd_cfg_read(vmd, 0, PCI_DEVFN(root_port, 0),	\
> > > > +				 PCI_VENDOR_ID, 4, &temp) ||		\
> > > > +		    temp == 0xffffffff) {} else
