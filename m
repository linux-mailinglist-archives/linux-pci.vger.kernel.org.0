Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AE17C8C1
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 00:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFXXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 18:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCFXXL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 18:23:11 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69760206D7;
        Fri,  6 Mar 2020 23:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583536990;
        bh=dM7rYOWDWemf2uovWwRMSwQuGWW2TTD+8I7lmYvklyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=whn538AXyE1vNf+1s6k01GdHeMeSk5tWyWjDkQqWq4I8UjX7lc0PVR1Rf3Vwwp+4S
         Tixc32A4eC4oeh8LA2v5YyqrT+YU2kOvaO+qBhF2A7C+5sxwmWg3YHyL7Or6zfkZmg
         T1iVqWdeg8FFtfuyVQw9Zxqw2LFUOtlK/VEnSr2c=
Date:   Fri, 6 Mar 2020 17:23:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v17 11/12] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200306232308.GA254242@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90e97009-29ae-f807-406d-59cefe7e6d3f@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 02:42:14PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 3/6/20 1:00 PM, Bjorn Helgaas wrote:
> > On Thu, Mar 05, 2020 at 10:32:33PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> > > On 3/5/2020 7:47 PM, Bjorn Helgaas wrote:
> > > > On Tue, Mar 03, 2020 at 06:36:34PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > +void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
> > > > > +{
> > > > > +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> > > > > +	acpi_status astatus;
> > > > > +
> > > > > +	if (!adev) {
> > > > > +		pci_dbg(pdev, "No valid ACPI node, so skip EDR init\n");
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Per the Downstream Port Containment Related Enhancements ECN to
> > > > > +	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-6, EDR support
> > > > > +	 * can only be enabled if DPC is controlled by firmware.
> > > > > +	 *
> > > > > +	 * TODO: Remove dependency on ACPI FIRMWARE_FIRST bit to
> > > > > +	 * determine ownership of DPC between firmware or OS.
> > > > > +	 * Per the Downstream Port Containment Related Enhancements
> > > > > +	 * ECN to the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> > > > > +	 * OS can use bit 7 of _OSC control field to negotiate control
> > > > > +	 * over DPC Capability.
> > > > > +	 */
> > > > > +	if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native) {
> > > > > +		pci_dbg(pdev, "OS handles AER/DPC, so skip EDR init\n");
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	astatus = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
> > > > > +					      edr_handle_event, pdev);
> > > > 
> > > > It does not say anything about "EDR notification only being
> > > > used if firmware owns DPC."
> > > > 
> > > > We should install an EDR notify handler because we told the
> > > > firmware that we support EDR notifications.  I don't think we
> > > > should make it any more complicated than that.
>
> I agree with your above statement. Since we told firmware *we
> support* EDR notification, we should make that true by installing
> the notification handler unconditionally.
> 
> But, based on inferences from PCI FW 3.2 ECN-DPC spec, current use
> case of EDR notification is only to handle error recovery for the
> case where DPC is owned by firmware and firmware sends EDR event. if
> you agree with above comment, is it alright if we add the following
> check in EDR notification handler ?
> 
> Although spec does not restrict it, current tested use case of EDR
> is to handle notification for firmware DPC case.
> 
> 218         if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native
> || (host->native_dpc))
> 219                 return;

No, I do not think we should add a check like this.  There's no basis
in the spec for doing this.  pcie_aer_get_firmware_first() looks at
HEST, which isn't mentioned at all in relation to EDR.  Checks like
this make it really hard to understand the code, and I don't believe
in making things fail simply because we haven't tested the scenario.

> > > Also check the following reference from section 2 of EDR ECN. It also
> > > clarifies EDR feature is only used when firmware owns DPC.
> > > 
> > >      PCIe Base Specification suggests that Downstream Port Containment
> > >      may be controlled either by the Firmware or the Operating System. It
> > >      also suggests that the Firmware retain ownership of Downstream Port
> > >      Containment if it also owns AER. When the Firmware owns Downstream
> > >      Port Containment, *it is expected to use the new “Error Disconnect
> > >      Recover” notification to alert OSPM of a Downstream Port Containment
> > >      event*.
> > The text in section 2 will not become part of the spec, so we can't
> > rely on it to tell us how to implement things.  Even if it did, this
> > section does not say "OS should only install an EDR notify handler if
> > firmware owns DPC."  It just means that if firmware owns DPC, the OS
> > will not learn about DPC events directly via DPC interrupts, so
> > firmware has to use another mechanism, e.g., EDR, to tell the OS about
> > them.
> > 
> > If an OS requests DPC control, it must support both DPC and EDR
> > (sec 4.5.2.4).  However, I think an OS may support EDR but not DPC
> > (although your patches don't support this configuration).
>
> Any use cases for above configuration ? Current PCI FW 3.2 ECN-DPC
> spec does not mention any uses cases where EDR can be used outside
> the scope of DPC ?
> 
> If required I can add this support. It should be easy to add it. In
> non DPC case, EDR notification handler would mostly be empty. Please
> let me know if you want me add this part of next patch set.

I don't think there's a need to add support for this.  I just
mentioned it as part of the point that we shouldn't tie EDR to DPC
unnecessarily.

> > > Although installing them when OS owns DPC should not affect
> > > anything, it also opens up a additional way for firmware to mess
> > > up things. For example, consider a case when firmware gives OS
> > > control of DPC, but still sends EDR notification to OS. Although
> > > it's unrealistic, I am just giving an example.
>
> > Can you outline the problem that occurs in this scenario?  It
> > seems like the EDR notify handler could still work.  The OS can
> > access DPC at any time (not just during the EDR window).
>
> When OS owns DPC and firmware sends a EDR event, it could create
> race between DPC interrupt handler and EDR event handler. Although
> from hardware perspective it should not make difference, since both
> code paths does the same thing.

Yes, that's true.  I think we should wait until there is a problem
here before doing anything.

> > > > I don't think we should even test pcie_ports_dpc_native here.  If we
> > > > told the platform we can handle EDR notifications, we should be
> > > > prepared to get them, regardless of whether the user booted with
> > > > "pcie_ports=dpc-native".
> > > As per the command line parameter documentation, setting
> > > pcie_ports=dpc-native means, we will be using native PCIe service
> > > for DPC.  So if DPC is handled by OS, as per my argument mentioned
> > > above (EDR is only useful if DPC handled by firmware), there is no
> > > use in installing EDR notification.
> > > 
> > > https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt#L3642
> > > 
> > > dpc-native - Use native PCIe service for DPC only.
> > It doesn't hurt anything to install a notify handler that never
> > receives a notification.  It might be an issue if we tell firmware
> > we're prepared for notifications but we don't install a handler.
> Agreed. Shall I send another version with this and "static inline" fix ?

No need.  Just take a look at my review/edr branch.  I intend to tweak
some commit logs and (maybe) make the "clear status" functions void
since there are only one or two minor uses of the return values.  But
it's pretty much what I hope to merge.

Bjorn
