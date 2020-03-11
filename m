Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F5181B9D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 15:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgCKOp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 10:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgCKOp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 10:45:59 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA077206B1;
        Wed, 11 Mar 2020 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583937957;
        bh=8Ta0Ywuou1GN90e0Q2WNKbhuY2sBRMaHPXRr97CbkrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qSVKXeS48mazxKjpMGxpjI1liswrAHQ8MnJ5PIZp0eQBJkJNwKZkwmIIyM5UQX9If
         Z2yhBncP+9wi9eZuwhHtf+7oiMH5KZc9aRtKv0yRd1sNk/4YoFZ99d8A9hM+xlYsNd
         EPdWG0fw9tAU8xz1k8Fnloa9sZXdtdxIe2imwKuk=
Date:   Wed, 11 Mar 2020 09:45:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200311144556.GA208157@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38277b0f6c2e4c5d88e741b7354c72d1@AUSX13MPC107.AMER.DELL.COM>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 10, 2020 at 08:06:21PM +0000, Austin.Bolen@dell.com wrote:
> On 3/10/2020 2:33 PM, Bjorn Helgaas wrote:
> > On Tue, Mar 10, 2020 at 06:14:20PM +0000, Austin.Bolen@dell.com wrote:
> >> On 3/9/2020 11:28 PM, Kuppuswamy, Sathyanarayanan wrote:
> >>> On 3/9/2020 7:40 PM, Bjorn Helgaas wrote:
> >>>> [+cc Austin, tentative Linux patches on this git branch:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/pcie?h=review/edr]
> >>>>
> >>>> On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> >>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>>>>
> >>>>> As per PCI firmware specification r3.2 System Firmware Intermediary
> >>>>> (SFI) _OSC and DPC Updates ECR
> >>>>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
> >>>>> Event Handling Implementation Note", page 10, Error Disconnect Recover
> >>>>> (EDR) support allows OS to handle error recovery and clearing Error
> >>>>> Registers even in FF mode. So create new API pci_aer_raw_clear_status()
> >>>>> which allows clearing AER registers without FF mode checks.

> >> OS clears the DPC Trigger Status bit which will bring port below it out
> >> of containment. Then OS will clear the "port" error status bits (i.e.,
> >> the AER and DPC status bits in the root port or downstream port that
> >> triggered containment). I don't think it would hurt to do this two steps
> >> in reverse order but don't think it is necessary.

> >> Note that error status bits for devices below the port in
> >> containment are cleared later after f/w has a chance to log them.

Thanks for pointing out this wrinkle about devices below the port in
containment.  I think we might have an issue here with the current
series because evaluating _OST is the last thing the EDR notify
handler does.  More below.

> > Maybe I'm misreading the DPC enhancements ECN.  I think it says the OS
> > can read/write DPC registers until it clears the DPC Trigger Status.
> > If the OS clears Trigger Status first, my understanding is that we're
> > now out of the EDR notification processing window and the OS is not
> > permitted to write DPC registers.
> > 
> > If it's OK for the OS to clear Trigger Status before clearing DPC
> > error status, what is the event that determines when the OS may no
> > longer read/write the DPC registers?
> 
> I think there are a few different registers to consider... DPC
> Control, DPC Status, various AER registers, and the RP PIO
> registers. At this point in the flow, the firmware has already had a
> chance to read all of them and so it really doesn't matter the order
> the OS does those two things. The firmware isn't going to get
> notified again until _OST so by then both operation will be done and
> system firmware will have no idea which order the OS did them in,
> nor will it care.  But since the existing normative text specifies
> and order, I would just follow that.

OK, this series clears DPC error status before clearing DPC Trigger
Status, so I think we can keep that as-is.

> > There are no events after the "clear device AER status" box.  That
> > seems to mean the OS can write the AER status registers at any
> > time.  But the whole implementation note assumes firmware
> > maintains control of AER.
> 
> In this model the OS doesn't own DPC or AER but the model allows OS
> to touch both DPC and AER registers at certain times.  I would view
> ownership in this case as who is the primary owner and not who is
> the sole entity allowed to access the registers.

I'm not sure how to translate the idea of primary ownership into code.

> For the normative text describing when OS clears the AER bits
> following the informative flow chart, it could say that OS clears
> AER as soon as possible after OST returns and before OS processes
> _HPX and loading drivers.  Open to other suggestions as well.

I'm not sure what to do with "as soon as possible" either.  That
doesn't seem like something firmware and the OS can agree on.

For the port that triggered DPC containment, I think the easiest thing
to understand and implement would be to allow AER access during the
same EDR processing window where DPC access is allowed.

For child devices of that port, obviously it's impossible to access
AER registers until DPC Trigger Status is cleared, and the flowchart
says the OS shouldn't access them until after _OST.

I'm actually not sure we currently do *anything* with child device AER
info in the EDR path.  pcie_do_recovery() does walk the sub-hierarchy
of child devices, but it only calls error handling callbacks in the
child drivers; it doesn't do anything with the child AER registers
itself.  And of course, this happens before _OST, so it would be too
early in any case.  But maybe I'm missing something here.

BTW, if/when this is updated, I have another question: the _OSC DPC
control bit currently allows the OS to write DPC Control during that
window.  I understand the OS writing the RW1C *Status* bits to clear
them, but it seems like writing the DPC Control register is likely to
cause issues.  The same question would apply to the AER access we're
talking about.

Bjorn
