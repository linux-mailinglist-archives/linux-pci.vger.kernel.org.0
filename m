Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097EC41DCD2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352087AbhI3PBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 11:01:17 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49929 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1352078AbhI3PBP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 11:01:15 -0400
Received: (qmail 471447 invoked by uid 1000); 30 Sep 2021 10:59:32 -0400
Date:   Thu, 30 Sep 2021 10:59:32 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
Message-ID: <20210930145932.GB464826@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu>
 <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 06:55:12PM -0700, Dan Williams wrote:
> On Wed, Sep 29, 2021 at 6:43 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Sep 29, 2021 at 06:05:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > Currently bus drivers like "USB" or "Thunderbolt" implement a custom
> > > version of device authorization to selectively authorize the driver
> > > probes. Since there is a common requirement, move the "authorized"
> > > attribute support to the driver core in order to allow it to be used
> > > by other subsystems / buses.
> > >
> > > Similar requirements have been discussed in the PCI [1] community for
> > > PCI bus drivers as well.
> > >
> > > No functional changes are intended. It just converts authorized
> > > attribute from int to bool and moves it to the driver core. There
> > > should be no user-visible change in the location or semantics of
> > > attributes for USB devices.
> > >
> > > Regarding thunderbolt driver, although it declares sw->authorized as
> > > "int" and allows 0,1,2 as valid values for sw->authorized attribute,
> > > but within the driver, in all authorized attribute related checks,
> > > it is treated as bool value. So when converting the authorized
> > > attribute from int to bool value, there should be no functional
> > > changes other than value 2 being not visible to the user.
> > >
> > > [1]: https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > >
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >
> > Since you're moving the authorized flag from the USB core to the
> > driver core, the corresponding sysfs attribute functions should be
> > moved as well.
> 
> Unlike when 'removable' moved from USB to the driver core there isn't
> a common definition for how the 'authorized' sysfs-attribute behaves
> across buses. The only common piece is where this flag is stored in
> the data structure, i.e. the 'authorized' sysfs interface is
> purposefully left bus specific.

How about implementing "library" versions of show_authorized() and 
store_authorized() that the bus-specific attribute routines can call?  
These library routines would handle parsing the input values, storing 
the new flag, and displaying the stored flag value.  That way at 
least the common parts of these APIs would be centralized in the 
driver core, and any additional functionality could easily be added 
by the bus-specific attribute routine.

Alan Stern
