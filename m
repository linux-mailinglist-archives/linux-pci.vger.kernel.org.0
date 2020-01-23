Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8F1460DD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 04:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAWDKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 22:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAWDKT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jan 2020 22:10:19 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238432465B;
        Thu, 23 Jan 2020 03:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579749018;
        bh=jE1seowcy+brAksEFaMaECr46SwpPDyV4bwh8QqOans=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uHPTxDB0bJ6oR20gCh8YIOxcGXYKKaQW8tp2F0rNk4je/C9bK59GABeMk96kmk9nb
         wS2xBPd4aMd8PZds33j1I+ZQ8brf0+0vdqkRyoH68lRk6ublsED729ZQnjpuwHOOw0
         QTHNaCrbsyJOhiIJXlLkxtaCxilu6YMqjmwxuCd4=
Date:   Wed, 22 Jan 2020 21:10:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v13 2/8] PCI/DPC: Allow dpc_probe() even if firmware
 first mode is enabled
Message-ID: <20200123031016.GA68788@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88420093-59aa-b713-c2e3-2872b4c5474b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 22, 2020 at 04:42:48PM -0800, Kuppuswamy Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 1/22/20 3:17 PM, Bjorn Helgaas wrote:
> > On Sat, Jan 18, 2020 at 08:00:31PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > As per ACPI specification v6.3, sec 5.6.6, Error Disconnect Recover
> > > (EDR) notification used by firmware to let OS know about the DPC event
> > > and permit OS to perform error recovery when processing the EDR
> > > notification.
> > I want to clear up some of this description because this is a very
> > confusing area and we should follow the spec carefully so we all
> > understand each other.
> > 
> > > Also, as per PCI firmware specification r3.2 Downstream
> > > Port Containment Related Enhancements ECN, sec 4.5.1, table 4-6, if DPC
> > > is controlled by firmware (firmware first mode), it's responsible for
> > > initializing Downstream Port Containment Extended Capability Structures
> > > per firmware policy.
> > The above is actually not what the ECN says.  What it does say is
> > this:
> > 
> >    If control of this feature [DPC configuration] was requested and
> >    denied, firmware is responsible for initializing Downstream Port
> >    Containment Extended Capability Structures per firmware policy.
> > 
> > Neither the PCI Firmware Spec (r3.2) nor the ECN contains any
> > reference to "firmware first".  As far as I can tell, "Firmware First"
> > is defined by the ACPI spec, and the FIRMWARE_FIRST bit in various
> > HEST entries (sec 18.3.2) is what tells us when a device is in
> > firmware-first mode.
> > 
> > That's a really long way of saying that from a spec point of view, DPC
> > being controlled by firmware does NOT imply anything about
> > firmware-first mode.
>
> But current AER and DPC driver uses ACPI FIRMWARE_FIRST bit
> (in pcie_aer_get_firmware_first()) to decide whether AER/DPC is
> controlled by firmware or OS. That's why I used the term
> "firmware first mode" interchangeably with a mode in which
> DPC/AER is controlled by firmware.

Yes.  I think the current use of pcie_aer_get_firmware_first() there
is probably not optimal and we should change that so it corresponds
better with the spec.

> > > And, OS is permitted to read or write DPC Control
> > > and Status registers of a port while processing an Error Disconnect
> > > Recover (EDR) notification from firmware on that port.
> > > 
> > > Currently, if firmware controls DPC (firmware first mode), OS will not
> > > create/enumerate DPC PCIe port services. But, if OS supports EDR
> > > feature, then as mentioned in above spec references, it should permit
> > > enumeration of DPC driver and also support handling ACPI EDR
> > > notification. So as first step, allow dpc_probe() to continue even if
> > > firmware first mode is enabled. Also add appropriate checks to ensure
> > > device registers are not modified outside EDR notification window in
> > > firmware first mode. This is a preparatory patch for adding EDR support.
> > > 
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > Acked-by: Keith Busch <keith.busch@intel.com>
> > > ---
> > >   drivers/pci/pcie/dpc.c | 74 ++++++++++++++++++++++++++++++++++--------
> > >   1 file changed, 61 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > > index e06f42f58d3d..c583a90fa90d 100644
> > > --- a/drivers/pci/pcie/dpc.c
> > > +++ b/drivers/pci/pcie/dpc.c
> > > @@ -22,6 +22,7 @@ struct dpc_dev {
> > >   	u16			cap_pos;
> > >   	bool			rp_extensions;
> > >   	u8			rp_log_size;
> > > +	bool			edr_enabled; /* EDR mode is supported */
> > This needs a better name, or perhaps it should be removed completely.
> Any suggestions ? native_mode or firmware_dpc ?
> > EDR is not a mode that can be enabled or disabled.  The _OSC "EDR
> > supported" bit tells the firmware whether the OS supports EDR
> > notification, but there's no corresponding bit that tells the OS
> > whether firmware will actually *send* those notifications.
> I agree that EDR is not a mode. But with EDR support, DPC driver functions
> can be triggered/executed in two contexts.
> 
> 1. DPC is controlled by OS.
> 2. Via EDR notification if DPC is controlled by firmware.
> 
> Since we want to use same code for both scenarios, we need some method
> to detect which context is currently in use.

I haven't gotten as far as looking at the actual EDR support yet, but
I wonder if this could be rearranged so that dpc.c contained two
things: (1) the existing DPC driver that claims DPC capability via
dpc_probe() and (2) a few functions exported for use by the EDR path.
Then maybe the EDR path could live in pci-acpi.c (or maybe a new edr.c
file) and would not depend on dpc_probe() actually *claiming* the
capability.

> > Also, EDR is an ACPI concept, and dpc.c is a generic driver not
> > specific to ACPI, so we should try to avoid polluting it with
> > ACPI-isms.
> > 
> > >   };
> > >   static const char * const rp_pio_error_string[] = {
> > > @@ -69,6 +70,14 @@ void pci_save_dpc_state(struct pci_dev *dev)
> > >   	if (!dpc)
> > >   		return;
> > > +	/*
> > > +	 * If DPC is controlled by firmware then save/restore tasks are also
> > > +	 * controlled by firmware. So skip rest of the function if DPC is
> > > +	 * controlled by firmware.
> > > +	 */
> > > +	if (dpc->edr_enabled)
> > > +		return;
> > I think this should be something like:
> > 
> >    if (!host->native_dpc)
> >      return;
> > 
> > That's what the spec says: if firmware does not grant control of DPC
> > to the OS via _OSC, the OS may not read/write the DPC capability.
> > 
> > The usual situation would be that if firmware doesn't grant the OS
> > permission to use DPC, we wouldn't use the dpc.c driver at all.
> > 
> > But IIUC, the point of this EDR stuff is that we're adding a case
> > where the OS doesn't have permission to use DPC, but we *do* want to
> > use parts of dpc.c in limited cases while handling EDR notifications.
> Yes, your assumption is correct.
> > 
> > I think you should probably take the DPC-related _OSC stuff from the
> > last patch ("PCI/ACPI: Enable EDR support") and move it before this
> > patch, so it *only* negotiates DPC ownership, per the ECN.  That would
> > probably result in dpc.c being used only if _OSC grants DPC ownership
> > to the OS.

> Patch titled ("PCI/ACPI: Enable EDR support") exposes EDR support to
> firmware in _OSC negotiation. So you wanted me to move this patch to
> the end of the series to make sure we don't expose EDR support until
> we have necessary code changes in kernel.

It actually does *two* things: (1) adds OSC_PCI_EXPRESS_DPC_CONTROL
and native_dpc, and (2) adds OSC_PCI_EDR_SUPPORT and related code.  I
think these should be split into two patches, and part 1 is what I
think could be done early before adding EDR support.

> > > +	 * As per PCIe r5.0, sec 6.2.10, implementation note titled
> > > +	 * "Determination of DPC Control", to avoid conflicts over whether
> > > +	 * platform firmware or the operating system have control of DPC,
> > > +	 * it is recommended that platform firmware and operating systems
> > > +	 * always link the control of DPC to the control of Advanced Error
> > > +	 * Reporting.
> > > +	 *
> > > +	 * So use AER FF mode check API pcie_aer_get_firmware_first() to decide
> > > +	 * whether DPC is controlled by software or firmware.

> > AFAICT, this is not what the spec says.  Firmware-first is not what
> > tells us whether DPC is controlled by firmware or the OS.  For ACPI
> > systems, _OSC tells us whether the OS is allowed control of DPC.

> But current DPC/AER driver use FIRMWARE_FIRST bit (in
> pcie_aer_get_firmware_first()) determine firmware/OS ownership.

I think that's a problem and we should fix it.  It's arguably a little
bit of feature creep to do that in this series, but it makes it very
confusing when the specs talk about ownership negotiated via _OSC and
the code talks about "firmware-first" and makes assumptions about
connections between the two.

Those things may very well *be* related in the firmware
implementation, but assuming those connections in Linux makes the code
hard to read and maintain.  This series adds quite a bit of
ACPI-related stuff, and I think we should untangle confusions like
this before we add more.

Bjorn
