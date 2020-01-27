Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB6114A216
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgA0KiU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 05:38:20 -0500
Received: from foss.arm.com ([217.140.110.172]:42456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgA0KiU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 05:38:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8FA930E;
        Mon, 27 Jan 2020 02:38:19 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3A243F52E;
        Mon, 27 Jan 2020 02:38:18 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:38:13 +0000
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
Message-ID: <20200127103813.GA25595@e121166-lin.cambridge.arm.com>
References: <20191101215302.GA217821@google.com>
 <5c4521d26f45cfe01631d14c3d7edc9a10f99245.camel@intel.com>
 <20191104180700.GB26409@e121166-lin.cambridge.arm.com>
 <20191105101208.GA21113@e121166-lin.cambridge.arm.com>
 <5a87add6071259c45522001648b29c9e597ebd69.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a87add6071259c45522001648b29c9e597ebd69.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 09:32:07PM +0000, Derrick, Jonathan wrote:
> On Tue, 2019-11-05 at 10:12 +0000, Lorenzo Pieralisi wrote:
> > On Mon, Nov 04, 2019 at 06:07:00PM +0000, Lorenzo Pieralisi wrote:
> > > On Fri, Nov 01, 2019 at 10:16:39PM +0000, Derrick, Jonathan wrote:
> > > > Hi Bjorn,
> > > > 
> > > > On Fri, 2019-11-01 at 16:53 -0500, Bjorn Helgaas wrote:
> > > > > [+cc Andrew]
> > > > > 
> > > > > On Wed, Oct 16, 2019 at 11:04:47AM -0600, Jon Derrick wrote:
> > > > > > When some VMDs are enabled and others are not, it's difficult to
> > > > > > determine which IIO stack corresponds to the enabled VMD.
> > > > > > 
> > > > > > To assist userspace with management tasks, VMD BIOS will write the VMD
> > > > > > instance number and socket number into the first enabled root port's IO
> > > > > > Base/Limit registers prior to OS handoff. VMD driver can capture this
> > > > > > information and expose it to userspace.
> > > > > 
> > > > > Hmmm, I'm not sure I understand this, but it sounds possibly fragile.
> > > > > Are these Root Ports visible to the generic PCI core device
> > > > > enumeration?  If so, it will find them and read these I/O window
> > > > > registers.  Maybe today the PCI core doesn't change them, but I'm not
> > > > > sure we should rely on them always being preserved until the vmd
> > > > > driver can claim the device.
> > > > > 
> > > > 
> > > > The Root Ports are on the VMD PCI domain, and this IO BASE/LIMIT
> > > > parsing occurs before this PCI domain is exposed to the generic PCI
> > > > scancode with pci_scan_child_bus(). Until that point the VMD PCI domain
> > > > is invisible to the kernel outside of /dev/mem or resource0.
> > > 
> > > That's because the VMD controller is a PCI device itself and its
> > > BARs values are used to configure the VMD host controller.
> > > 
> > > Interesting.
> > > 
> > > To add to Bjorn's question, this reasoning assumes that whatever
> > > code enumerates the PCI device representing the VMD host controller
> > > does not overwrite its BARs upon bus enumeration otherwise the VMD
> > > controller configuration would be lost. Am I reading the current
> > > code correctly ?
> > 
> > Sorry, I just went through the code again, I think the VMD controller
> > PCI device BARs can and are allowed to be reassigned by the PCI
> > enumeration code - I misread the code, so I raised a non-existent issue
> > here, they are like any other PCI device MEM/IO BARs in this respect.
> > 
> > Lorenzo
> > 
> 
> Yes the VMD endpoint itself exposes the domain containing the Root
> Ports. It's the Root Ports which get enumerated by generic PCI
> scancode, and also the Root Port config space where this domain info is
> supplied. Without a VMD driver, the only aperture to access the Root
> Port config space is MMIO through the VMD endpoint's 'Config' BAR (aka
> MEMBAR0).
> 
> Without this patch, a /dev/mem, resource0, or third-party driver could
> overwrite these values if they don't also restore them on close/unbind.
> I imagine a kexec user would also overwrite these values.
> 
> This is one of the reasons I was also thinking it could live in device
> specific reset code as long as it can call into VMD for the specifics.
> Many kernel vendors already ship with VMD=y, so I am tempted to simply
> make that permanent and export a reset call to a dev specific reset in
> quirks.c.

Hi Jon,

just wanted to ask you what's the plan with this series.

Thanks,
Lorenzo
