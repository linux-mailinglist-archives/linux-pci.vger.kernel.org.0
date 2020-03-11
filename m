Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE4181ED6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 18:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgCKRMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 13:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCKRMH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 13:12:07 -0400
Received: from localhost (165.sub-174-234-131.myvzw.com [174.234.131.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3289E20734;
        Wed, 11 Mar 2020 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583946726;
        bh=SDlz6mXq+YdNYkyKQd61cklNTIoTHr9DyC26899vQnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P2fZLADUcGo59L7OpnMvgYKe/tfthcyHmnxXJknm3Q/SJgekNqc9oymX/hvvbf0tm
         NQ5OuGfnIIR1Skw2qbfaTG1q+zqU+dBU5Bm6F7wSLgKJlwcMwimuh/jJ9Ea0Gs1WHi
         KK2p1Hb85H2sLmSBuRhlL3MkfrlojXVwYQfDIbxQ=
Date:   Wed, 11 Mar 2020 12:12:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200311171203.GA137848@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0890801daa6c4564bca1690fd8439dab@AUSX13MPC107.AMER.DELL.COM>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 03:19:44PM +0000, Austin.Bolen@dell.com wrote:
> On 3/11/2020 9:46 AM, Bjorn Helgaas wrote:
> > On Tue, Mar 10, 2020 at 08:06:21PM +0000, Austin.Bolen@dell.com wrote:
> >> On 3/10/2020 2:33 PM, Bjorn Helgaas wrote:
> >>> On Tue, Mar 10, 2020 at 06:14:20PM +0000, Austin.Bolen@dell.com wrote:
> >>>> On 3/9/2020 11:28 PM, Kuppuswamy, Sathyanarayanan wrote:
> >>>>> On 3/9/2020 7:40 PM, Bjorn Helgaas wrote:
> >>>>>> [+cc Austin, tentative Linux patches on this git branch:
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/pcie?h=review/edr]
> >>>>>>
> >>>>>> On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> >>>>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>>>>>>
> >>>>>>> As per PCI firmware specification r3.2 System Firmware Intermediary
> >>>>>>> (SFI) _OSC and DPC Updates ECR
> >>>>>>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
> >>>>>>> Event Handling Implementation Note", page 10, Error Disconnect Recover
> >>>>>>> (EDR) support allows OS to handle error recovery and clearing Error
> >>>>>>> Registers even in FF mode. So create new API pci_aer_raw_clear_status()
> >>>>>>> which allows clearing AER registers without FF mode checks.
> > 
> >>>> OS clears the DPC Trigger Status bit which will bring port below it out
> >>>> of containment. Then OS will clear the "port" error status bits (i.e.,
> >>>> the AER and DPC status bits in the root port or downstream port that
> >>>> triggered containment). I don't think it would hurt to do this two steps
> >>>> in reverse order but don't think it is necessary.
> > 
> >>>> Note that error status bits for devices below the port in
> >>>> containment are cleared later after f/w has a chance to log them.
> > 
> > Thanks for pointing out this wrinkle about devices below the port in
> > containment.  I think we might have an issue here with the current
> > series because evaluating _OST is the last thing the EDR notify
> > handler does.  More below.
> > 
> >>> Maybe I'm misreading the DPC enhancements ECN.  I think it says the OS
> >>> can read/write DPC registers until it clears the DPC Trigger Status.
> >>> If the OS clears Trigger Status first, my understanding is that we're
> >>> now out of the EDR notification processing window and the OS is not
> >>> permitted to write DPC registers.
> >>>
> >>> If it's OK for the OS to clear Trigger Status before clearing DPC
> >>> error status, what is the event that determines when the OS may no
> >>> longer read/write the DPC registers?
> >>
> >> I think there are a few different registers to consider... DPC
> >> Control, DPC Status, various AER registers, and the RP PIO
> >> registers. At this point in the flow, the firmware has already had a
> >> chance to read all of them and so it really doesn't matter the order
> >> the OS does those two things. The firmware isn't going to get
> >> notified again until _OST so by then both operation will be done and
> >> system firmware will have no idea which order the OS did them in,
> >> nor will it care.  But since the existing normative text specifies
> >> and order, I would just follow that.
> > 
> > OK, this series clears DPC error status before clearing DPC Trigger
> > Status, so I think we can keep that as-is.
> > 

> >>> There are no events after the "clear device AER status" box.
> >>> That seems to mean the OS can write the AER status registers at
> >>> any time.  But the whole implementation note assumes firmware
> >>> maintains control of AER.
> >>
> >> In this model the OS doesn't own DPC or AER but the model allows
> >> OS to touch both DPC and AER registers at certain times.  I would
> >> view ownership in this case as who is the primary owner and not
> >> who is the sole entity allowed to access the registers.
> > 
> > I'm not sure how to translate the idea of primary ownership into
> > code.
> 
> I would just add text that said when it's ok for OS to touch these
> bits even when they don't own them similar to what's done for the
> DPC bits.

I'm probably missing your intent, but that sounds like "the OS can
read/write AER bits whenever it wants, regardless of ownership."

That doesn't sound practical to me, and I don't think it's really
similar to DPC, where it's pretty clear that the OS can touch DPC bits
it doesn't own but only *during the EDR processing window*.

> >> For the normative text describing when OS clears the AER bits
> >> following the informative flow chart, it could say that OS clears
> >> AER as soon as possible after OST returns and before OS processes
> >> _HPX and loading drivers.  Open to other suggestions as well.
> > 
> > I'm not sure what to do with "as soon as possible" either.  That
> > doesn't seem like something firmware and the OS can agree on.
> 
> I can just state that it's done after OST returns but before _HPX or
> driver is loaded. Any time in that range is fine. I can't get super
> specific here because different OSes do different things.  Even for
> a given OS they change over time. And I need something generic
> enough to support a wide variety of OS implementations.

Yeah.  I don't know how to solve this.

Linux doesn't actually unload and reload drivers for the child devices
(Sathy, correct me if I'm wrong here) even though DPC containment
takes the link down and effectively unplugs and replugs the device.  I
would *like* to handle it like hotplug, but some higher-level software
doesn't deal well with things like storage devices disappearing and
reappearing.

Since Linux doesn't actually re-enumerate the child devices, it
wouldn't evaluate _HPX again.  It would probably be cleaner if it did,
but it's all tied up with the whole unplug/replug problem.

> > For child devices of that port, obviously it's impossible to
> > access AER registers until DPC Trigger Status is cleared, and the
> > flowchart says the OS shouldn't access them until after _OST.
> > 
> > I'm actually not sure we currently do *anything* with child device
> > AER info in the EDR path.  pcie_do_recovery() does walk the
> > sub-hierarchy of child devices, but it only calls error handling
> > callbacks in the child drivers; it doesn't do anything with the
> > child AER registers itself.  And of course, this happens before
> > _OST, so it would be too early in any case.  But maybe I'm missing
> > something here.
> 
> My understanding is that the OS read/clears AER in the case where OS
> has native control of AER.  Feedback from OSVs is they wanted to
> continue to do that to keep the native OS controlled AER and FF
> mechanism similar.  The other way we could have done it would be to
> have the firmware read/clear AER and report them to OS via APEI.

When Linux has native control of AER, it reads/clears AER status.
The flowchart is for the case where firmware has AER control, so I
guess Linux would not field AER interrupts and wouldn't expect to
read/clear AER status.  So I *guess* Linux would assume APEI?  But
that doesn't seem to be what the flowchart assumes.

> > BTW, if/when this is updated, I have another question: the _OSC
> > DPC control bit currently allows the OS to write DPC Control
> > during that window.  I understand the OS writing the RW1C *Status*
> > bits to clear them, but it seems like writing the DPC Control
> > register is likely to cause issues.  The same question would apply
> > to the AER access we're talking about.
> 
> We could specify which particular bits can and can't be touched.
> But it's hard to maintain as new bits are added.  Probably better to
> add some guidance that OS should read/clear error status, DPC
> Trigger Status, etc. but shouldn't change masks/severity/control
> bits/etc.

Yeah.  I didn't mean at the level of individual bits; I was thinking
more of status/log/etc vs control registers.  But maybe even that is
hard, I dunno.
