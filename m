Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEA182350
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 21:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgCKUda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 16:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKUda (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 16:33:30 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8DC32074A;
        Wed, 11 Mar 2020 20:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583958810;
        bh=ZhsTyoo2Ec0QZ0sq1nqzSyIjpak8+wMtHttt5uCeKZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LfpBlu5znasSN619CKpj8II+4wnZeF4HbG17auC5hHsjH3C+EOMwegtV8kGFr7whg
         ku9umr9ugLdqH7UawNVhVcAvqWn356/0PplynKXNvRNzKSbMSV326H2QB784OQH+kn
         GuxN5yWH3fLPG5TaydzdAO1jl0gOchUIa22/3FRs=
Date:   Wed, 11 Mar 2020 15:33:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200311203326.GA163074@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b8d47f9180e43a7bdb01f9d8754c9f6@AUSX13MPC107.AMER.DELL.COM>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 05:27:35PM +0000, Austin.Bolen@dell.com wrote:
> On 3/11/2020 12:12 PM, Bjorn Helgaas wrote:
> > 
> > [EXTERNAL EMAIL]
> > 
> <SNIP>
> > 
> > I'm probably missing your intent, but that sounds like "the OS can
> > read/write AER bits whenever it wants, regardless of ownership."
> > 
> > That doesn't sound practical to me, and I don't think it's really
> > similar to DPC, where it's pretty clear that the OS can touch DPC bits
> > it doesn't own but only *during the EDR processing window*.
> 
> Yes, by treating AER bits like DPC bits I meant I'd define the specific 
> time windows when OS can touch the AER status bits similar to how it's 
> done for DPC in the current ECN.

Makes sense, thanks.

> >>>> For the normative text describing when OS clears the AER bits
> >>>> following the informative flow chart, it could say that OS clears
> >>>> AER as soon as possible after OST returns and before OS processes
> >>>> _HPX and loading drivers.  Open to other suggestions as well.
> >>>
> >>> I'm not sure what to do with "as soon as possible" either.  That
> >>> doesn't seem like something firmware and the OS can agree on.
> >>
> >> I can just state that it's done after OST returns but before _HPX or
> >> driver is loaded. Any time in that range is fine. I can't get super
> >> specific here because different OSes do different things.  Even for
> >> a given OS they change over time. And I need something generic
> >> enough to support a wide variety of OS implementations.
> > 
> > Yeah.  I don't know how to solve this.
> > 
> > Linux doesn't actually unload and reload drivers for the child devices
> > (Sathy, correct me if I'm wrong here) even though DPC containment
> > takes the link down and effectively unplugs and replugs the device.  I
> > would *like* to handle it like hotplug, but some higher-level software
> > doesn't deal well with things like storage devices disappearing and
> > reappearing.
> > 
> > Since Linux doesn't actually re-enumerate the child devices, it
> > wouldn't evaluate _HPX again.  It would probably be cleaner if it did,
> > but it's all tied up with the whole unplug/replug problem.
> 
> DPC resets everything below it and so to get it back up and running it 
> would mean that all buses and resources need to be assigned, _HPX 
> evaluated, and drivers reloaded. If those things don't happen then the 
> whole hierarchy below the port that triggered DPC will be inaccessible.

Hmm, I think I might be confusing this with another situation.  Sathy,
can you help me understand this?  I don't have a way to actually
exercise this EDR path.  Is there some way the pciehp hotplug driver
gets involved here?

Here's how this seems to work as far as I can tell:

  - Linux does not have DPC or AER control

  - Linux installs EDR notify handler

  - Linux evaluates DPC Enable _DSM

  - DPC containment event occurs

  - Firmware fields DPC interrupt

  - DPC event is not a surprise remove

  - Firmware sends EDR notification

  - Linux EDR notify handler evaluates Locate _DSM

  - Linux reads and logs DPC and AER error information for port in
    containment mode.  [If it was an RP PIO error, Linux clears RP PIO
    error status, which is an asymmetry with the non-RP PIO path.]

  - Linux clears AER error status (pci_aer_raw_clear_status())

  - Linux calls driver .error_detected() methods for all child devices
    of the port in containment mode (pcie_do_recovery()).  These
    devices are inaccessible because the link is down.

  - Linux clears DPC Trigger Status (dpc_reset_link() from
    pcie_do_recovery()).

  - Linux calls driver .mmio_enabled() methods for all child devices.

This is where I get lost.  These child devices are now accessible, but
they've been reset, so I don't know how their config space got
restored.  Did pciehp enumerate them?  Did we do something like
pci_restore_state()?  I don't see where either of these happens.

> For higher level software not handling storage device disappearing due 
> to hot-plug, they will have the same problem with DPC since DPC holds 
> the port in the disabled state (and hence will be inaccessible). And 
> once DPC is released the devices will be unconfigured and so still 
> inaccessible to upper-level software.  A lot of upper-level storage 
> software I've seen can already handle this gracefully.
> 
> >>> For child devices of that port, obviously it's impossible to
> >>> access AER registers until DPC Trigger Status is cleared, and the
> >>> flowchart says the OS shouldn't access them until after _OST.
> >>>
> >>> I'm actually not sure we currently do *anything* with child device
> >>> AER info in the EDR path.  pcie_do_recovery() does walk the
> >>> sub-hierarchy of child devices, but it only calls error handling
> >>> callbacks in the child drivers; it doesn't do anything with the
> >>> child AER registers itself.  And of course, this happens before
> >>> _OST, so it would be too early in any case.  But maybe I'm missing
> >>> something here.
> >>
> >> My understanding is that the OS read/clears AER in the case where OS
> >> has native control of AER.  Feedback from OSVs is they wanted to
> >> continue to do that to keep the native OS controlled AER and FF
> >> mechanism similar.  The other way we could have done it would be to
> >> have the firmware read/clear AER and report them to OS via APEI.
> > 
> > When Linux has native control of AER, it reads/clears AER status.
> > The flowchart is for the case where firmware has AER control, so I
> > guess Linux would not field AER interrupts and wouldn't expect to
> > read/clear AER status.  So I *guess* Linux would assume APEI?  But
> > that doesn't seem to be what the flowchart assumes.
> 
> Correct on the flowchart.  The OSVs we talked with did not want to use 
> APEI.  They wanted to read and clear AER themselves and hence the 
> flowchart is written that way.

So they want to basically do native AER handling even though firmware
owns AER?  My head hurts.

Bjorn
