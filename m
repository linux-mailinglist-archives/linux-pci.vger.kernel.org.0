Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF95180828
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 20:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCJTdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 15:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbgCJTdA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Mar 2020 15:33:00 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276C922B48;
        Tue, 10 Mar 2020 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583868779;
        bh=svHYd0D7j94mbORR4v24c3DginNWgdH5YgabZSqKun8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tnuVIpNlaJzyjGgFnmF+hBNDNWHMEJHntfb7OQmfPaXu2TiPTzCj2Ad5NgM18cvpc
         GKUaave7l6QWqa70n3UfrF40u2hMw+lTBJTgMWRZIJH6udreg2mwdt5oTLTFKBpjJr
         n0EQ0TfAIbT4rdQdiLDavrEqlSh2V3o+QRqXrX14=
Date:   Tue, 10 Mar 2020 14:32:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200310193257.GA170043@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0476c948e73f4c68a9bf221afccfcf7e@AUSX13MPC107.AMER.DELL.COM>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 10, 2020 at 06:14:20PM +0000, Austin.Bolen@dell.com wrote:
> On 3/9/2020 11:28 PM, Kuppuswamy, Sathyanarayanan wrote:
> > On 3/9/2020 7:40 PM, Bjorn Helgaas wrote:
> >> [+cc Austin, tentative Linux patches on this git branch:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/pcie?h=review/edr]
> >>
> >> On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> >>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>>
> >>> As per PCI firmware specification r3.2 System Firmware Intermediary
> >>> (SFI) _OSC and DPC Updates ECR
> >>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
> >>> Event Handling Implementation Note", page 10, Error Disconnect Recover
> >>> (EDR) support allows OS to handle error recovery and clearing Error
> >>> Registers even in FF mode. So create new API pci_aer_raw_clear_status()
> >>> which allows clearing AER registers without FF mode checks.
> >>
> >> I see that this ECR was released as an ECN a few days ago:
> >> https://members.pcisig.com/wg/PCI-SIG/document/14076
> >> Regrettably the title in the PDF still says "ECR" (the rendered title
> >> *page* says "ENGINEERING CHANGE NOTIFICATION", but some metadata
> >> buried in the file says "ECR - SFI _OSC Support and DPC Updates".
> 
> I'll see if PCI-SIG can update the metadata and repost.

If that's possible, it would be nice to update the metadata for the
"Downstream Port Containment related Enhancements" ECN as well.  That
one currently says "ECR - CardBus Header Proposal", which means that's
what's in the window title bar and icons in the panel.

> >> Anyway, I think I see the note you refer to (now on page 12):
> >>
> >>     IMPLEMENTATION NOTE
> >>     DPC Event Handling
> >>
> >>     The flow chart below documents the behavior when firmware maintains
> >>     control of AER and DPC and grants control of PCIe Hot-Plug to the
> >>     operating system.
> >>
> >>     ...
> >>
> >>     Capture and clear device AER status. OS may choose to offline
> >>     devices3, either via SW (not load driver) or HW (power down device,
> >>     disable Link5,6,7). Otherwise process _HPX, complete device
> >>     enumeration, load drivers
> >>
> >> This clearly suggests that the OS should clear device AER status.
> >> However, according to the intro text, firmware has retained control of
> >> AER, so what gives the OS the right to clear AER status?
> >>
> >> The Downstream Port Containment Related Enhancements ECN (sec 4.5.1,
> >> table 4-6) contains an exception that allows the OS to read/write
> >> DPC registers during recovery.  But
> >>
> >>     - that is for *DPC* registers, not for AER registers, and
> >>
> >>     - that exception only applies between OS receipt of the EDR
> >>       notification and OS release of DPC by clearing the DPC Trigger
> >>       Status bit.
> >>
> >> The flowchart in the SFI ECN shows the OS releasing DPC before
> >> clearing AER status:
> >>
> >>     - Receive EDR notification
> >>
> >>     - Cleanup - Notify and unload child drivers below Port
> >>
> >>     - Bring Port out of DPC, clear port error status, assign bus numbers
> >>       to child devices.
> >>
> >>       I assume this box includes clearing DPC error status and clearing
> >>       Trigger Status?  They seem to be out of order in the box.
> 
> OS clears the DPC Trigger Status bit which will bring port below it out 
> of containment. Then OS will clear the "port" error status bits (i.e., 
> the AER and DPC status bits in the root port or downstream port that 
> triggered containment). I don't think it would hurt to do this two steps 
> in reverse order but don't think it is necessary. Note that error status 
> bits for devices below the port in containment are cleared later after 
> f/w has a chance to log them.

Maybe I'm misreading the DPC enhancements ECN.  I think it says the OS
can read/write DPC registers until it clears the DPC Trigger Status.
If the OS clears Trigger Status first, my understanding is that we're
now out of the EDR notification processing window and the OS is not
permitted to write DPC registers.

If it's OK for the OS to clear Trigger Status before clearing DPC
error status, what is the event that determines when the OS may no
longer read/write the DPC registers?

> >>     - Evaluate _OST
> >>
> >>     - Capture and clear device AER status.
> >>
> >>       This seems suspect to me.  Where does it say the OS is
> >>       allowed to write AER status when firmware retains control
> >>       of AER?
> >>
> >> This patch series does things in this order:
> >>
> >>     - Receive EDR notification (edr_handle_event(), edr.c)
> >>
> >>     - Read, log, and clear DPC error regs (dpc_process_error(),
> >>       dpc.c).
> >>
> >>       This also clears AER uncorrectable error status when the
> >>       relevant HEST entries do not have the FIRMWARE_FIRST bit
> >>       set.  I think this is incorrect: the test should be based
> >>       the _OSC negotiation for AER ownership, not on the HEST
> >>       entries.  But this problem pre-dates this patch series.
> >>
> >>     - Clear AER status (pci_aer_raw_clear_status(), aer.c).
> >>
> >>       This is at least inside the EDR recovery window, but again,
> >>       I don't see where it says the OS is allowed to write the
> >>       AER status.
> > 
> > Implementation note is the only reference we have regarding
> > clearing the AER registers.
> > 
> > But since the spec says both DPC and AER needs to be always
> > controlled together by the either OS or firmware, and when
> > firmware relinquishes control over DPC registers in EDR
> > notification window, we can assume that we also have control over
> > AER registers.
> > 
> > But I agree that is not explicitly spelled out any where outside
> > the implementation note.

This is all quite unsatisfying since implementation notes are not
normative.  I would far rather reference actual spec text.

> > Austin,
> > 
> > May be ECN (section 4.5.1, table 4-6) needs to be updated to add
> > this clarification.
> 
> Sure we can update to section 4.5.1, table 4-6 to indicate when OS
> can clear the AER status bits. It will just follow what's done in
> the implementation note so I think it's acceptable to follow
> implementation guidance for now.

There are no events after the "clear device AER status" box.  That
seems to mean the OS can write the AER status registers at any time.
But the whole implementation note assumes firmware maintains control
of AER.

> >>     - Attempt recovery (pcie_do_recovery(), err.c)
> >>
> >>     - Clear DPC Trigger Status (dpc_reset_link(), dpc.c)
> >>
> >>     - Evaluate _OST (acpi_send_edr_status(), edr.c)
> >>
> >> What am I missing?
