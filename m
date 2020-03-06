Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC32217C77C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 22:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFVBC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 16:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFVBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 16:01:01 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA3B206D7;
        Fri,  6 Mar 2020 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583528460;
        bh=Sy4KFR4r8QdJfg8LfiNBvKO9NlCApQTxg0eOZExhoMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Cskbmn3VUCdxsS2WPiQ0VB7YHHgSdLKHV6ps431PVH9MpLZ/ksdjZnhiLMWMry/en
         e4nP3yV7BhB7Ey5s4E0E1+p98CJTYsZ+o//WJ0z/SobVHqxc2h4NRoMMEryOQWdDPR
         JrY/yBv29tF++YxqrrwzrgFHW59Ye8KvegWqyXlI=
Date:   Fri, 6 Mar 2020 15:00:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v17 11/12] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200306210058.GA210797@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5384cf38-4b33-f95b-4bb9-b82f0dc63a1f@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 05, 2020 at 10:32:33PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 3/5/2020 7:47 PM, Bjorn Helgaas wrote:
> > On Tue, Mar 03, 2020 at 06:36:34PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > > +void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
> > > +{
> > > +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> > > +	acpi_status astatus;
> > > +
> > > +	if (!adev) {
> > > +		pci_dbg(pdev, "No valid ACPI node, so skip EDR init\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Per the Downstream Port Containment Related Enhancements ECN to
> > > +	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-6, EDR support
> > > +	 * can only be enabled if DPC is controlled by firmware.
> > > +	 *
> > > +	 * TODO: Remove dependency on ACPI FIRMWARE_FIRST bit to
> > > +	 * determine ownership of DPC between firmware or OS.
> > > +	 * Per the Downstream Port Containment Related Enhancements
> > > +	 * ECN to the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> > > +	 * OS can use bit 7 of _OSC control field to negotiate control
> > > +	 * over DPC Capability.
> > > +	 */
> > > +	if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native) {
> > > +		pci_dbg(pdev, "OS handles AER/DPC, so skip EDR init\n");
> > > +		return;
> > > +	}
> > > +
> > > +	astatus = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
> > > +					      edr_handle_event, pdev);
> > 
> > I think this is still problematic.  You mentioned Alex's work
> > [1,2].  We do need to revisit those patches, but I don't really
> > want to defer *this* question of the EDR notify handler.
> > Negotiating support of AER/DPC/EDR is already complicated, and I
> > don't want to complicate it even more by merging something we
> > already know is not quite right.
> > 
> > I don't understand your comment that "EDR can only be enabled if
> > DPC is controlled by firmware."  I don't see anything in table 4-6
> > to that effect.  The only mention of EDR there is to say that the
> > OS can access the DPC capability in the EDR processing window,
> > i.e., after the OS receives the EDR notification and before it
> > clears DPC Trigger Status.
> 
> Please check the following spec reference (from table 4-6).
> 
>     If control of this feature was requested and denied, firmware is
>     responsible for initializing Downstream Port Containment
>     Extended Capability Structures per firmware policy. Further, the
>     OS is permitted to read or write DPC Control and Status
>     registers of a port while processing an Error Disconnect Recover
>     notification from firmware on that port.
> 
> It specifies firmware is expected to use EDR notification *only*
> when the control of DPC is requested and denied (which means
> firmware owns the DPC).

No, I don't think it says that.  This section tells us how to use _OSC
to negotiate ownership of DPC.  The first sentence you quoted
basically says that if firmware retains control of DPC, firmware is
responsible for initializing the DPC capability.  That part is pretty
obvious: "firmware owns it, so firmware is responsible for configuring
it."

The second sentence is important because it's an exception to the
general rule of "the OS can't touch things owned by the firmware." The
exception is that even if firmware retains control of DPC, the OS is
allowed to access DPC registers during the EDR notification window.

There is nothing here about when firmware is allowed to use EDR.

> Although it does not explicitly state that we should install EDR
> notification handler only if firmware owns DPC, it mentions that EDR
> notification is only used if firmware owns DPC. So why should we
> install it if it's not going to be used when OS owns DPC.

It does not say anything about "EDR notification only being used if
firmware owns DPC."

We should install an EDR notify handler because we told the firmware
that we support EDR notifications.  I don't think we should make it
any more complicated than that.

> Also check the following reference from section 2 of EDR ECN. It also
> clarifies EDR feature is only used when firmware owns DPC.
> 
>     PCIe Base Specification suggests that Downstream Port Containment
>     may be controlled either by the Firmware or the Operating System. It
>     also suggests that the Firmware retain ownership of Downstream Port
>     Containment if it also owns AER. When the Firmware owns Downstream
>     Port Containment, *it is expected to use the new “Error Disconnect
>     Recover” notification to alert OSPM of a Downstream Port Containment
>     event*.

The text in section 2 will not become part of the spec, so we can't
rely on it to tell us how to implement things.  Even if it did, this
section does not say "OS should only install an EDR notify handler if
firmware owns DPC."  It just means that if firmware owns DPC, the OS
will not learn about DPC events directly via DPC interrupts, so
firmware has to use another mechanism, e.g., EDR, to tell the OS about
them.

If an OS requests DPC control, it must support both DPC and EDR (sec
4.5.2.4).  However, I think an OS may support EDR but not DPC
(although your patches don't support this configuration).  In that
case the OS would set the _OSC "EDR Supported" bit, but it would not
request DPC control.  Then the EDR notify handler would "invalidate
the software state associated with child devices of the port" (table
4-4), but it would not "attempt to recover the child devices of ports
implementing DPC."

> > EDR is a general ACPI feature that is not PCI-specific.  For EDR
> > on PCI devices, OS support is advertised via _OSC *Support* (table
> > 4-4), which says:
> > 
> >    Error Disconnect Recover Supported
> > 
> >    The OS sets this bit to 1 if it supports Error Disconnect
> >    Recover notification on PCI Express Host Bridges, Root Ports
> >    and Switch Downstream Ports. Otherwise, the OS sets this bit to
> >    0.
> > 
> > I think that means that if we set the "Error Disconnect Recover
> > Supported" _OSC bit (OSC_PCI_EDR_SUPPORT), we must install a
> > handler for EDR notifications.  We set OSC_PCI_EDR_SUPPORT
> > whenever CONFIG_PCIE_EDR=y, so I think we should install the
> > notify handler here unconditionally (since this file is compiled
> > only when CONFIG_PCIE_EDR=y).
> 
> Although spec does not provide any restrictions on when to install
> EDR notification, it provides reference that notification is only
> used if firmware owns DPC. So when OS owns DPC, there is no need to
> install them at all.

I disagree that the spec tells us that EDR is only used when firmware
owns DPC.

Even if it did, pcie_aer_get_firmware_first() only looks at HEST
tables.  There *might* be some connection between those and DPC
ownership, but that's internal to firmware and I think it's just
asking for trouble if we rely on that connection.

> Although installing them when OS owns DPC should not affect
> anything, it also opens up a additional way for firmware to mess up
> things. For example, consider a case when firmware gives OS control
> of DPC, but still sends EDR notification to OS. Although it's
> unrealistic, I am just giving an example.

Can you outline the problem that occurs in this scenario?  It seems
like the EDR notify handler could still work.  The OS can access DPC
at any time (not just during the EDR window).

> > I don't think we should even test pcie_ports_dpc_native here.  If we
> > told the platform we can handle EDR notifications, we should be
> > prepared to get them, regardless of whether the user booted with
> > "pcie_ports=dpc-native".
> 
> As per the command line parameter documentation, setting
> pcie_ports=dpc-native means, we will be using native PCIe service
> for DPC.  So if DPC is handled by OS, as per my argument mentioned
> above (EDR is only useful if DPC handled by firmware), there is no
> use in installing EDR notification.
> 
> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt#L3642
> 
> dpc-native - Use native PCIe service for DPC only.

It doesn't hurt anything to install a notify handler that never
receives a notification.  It might be an issue if we tell firmware
we're prepared for notifications but we don't install a handler.

> > It's conceivable that pcie_ports_dpc_native should make us do
> > something different in the notify handler after we *get* a
> > notification, but I doubt we should even worry about that.
> > 
> > IIUC, pcie_ports_dpc_native exists because Linux DPC originally worked
> > even if the OS didn't have control of AER.  eed85ff4c0da7 ("PCI/DPC:
> > Enable DPC only if AER is available") meant that if Linux didn't have
> > control of AER, DPC no longer worked.  "pcie_ports=dpc-native" is
> > basically a way to get that previous behavior of Linux DPC regardless
> > of AER control.
> > 
> > I don't think that issue applies to EDR.  There's no concept of an OS
> > "enabling" or "being granted control of" EDR.  The OS merely
> > advertises that "yes, I'm prepared to handle EDR notifications".
> > AFAICT, the ECR says nothing about EDR support being conditional on OS
> > control of AER or DPC.  The notify *handler* might need to do
> > different things depending on whether we have AER or DPC control, but
> > the handler itself should be registered regardless.
> > 
> > [1] https://lore.kernel.org/linux-pci/20181115231605.24352-1-mr.nuke.me@gmail.com/
> > [2] https://lore.kernel.org/linux-pci/20190326172343.28946-1-mr.nuke.me@gmail.com/
> > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
