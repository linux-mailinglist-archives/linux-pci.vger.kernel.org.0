Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC029407E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394623AbgJTQ2X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 12:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394622AbgJTQ2X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 12:28:23 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA9D22242;
        Tue, 20 Oct 2020 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603211302;
        bh=yBBa8YoBYTRMM0pUiBsZFvV1xn4j8F7PYigfHmv2+3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CmC80FkOis63e31tD/RZyixoNNJjvUN1+8xWLmvjvzJH1Tv7s7Q1nTnZPK9P0/ooy
         CcXG/CQEe/Rxr9f+foshEJGR+LNx82uXENPPkr1Tc90ufPQi2b76TCT+JlV9ewRB7w
         4Tw0g3DG+HPsVeqdVEPskgOCvO4tFoFGxzyl1NRc=
Date:   Tue, 20 Oct 2020 11:28:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ethan Zhao <xerces.zhao@gmail.com>,
        Sean V Kelley <seanvk.dev@oregontracks.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rafael.j.wysocki@intel.com, Ashok Raj <ashok.raj@intel.com>,
        tony.luck@intel.com, qiuxu.zhuo@intel.com,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sinan Kaya <okaya@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201020162820.GA370938@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201020125920.0000399b@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 20, 2020 at 01:59:20PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Oct 2020 13:50:17 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
> > On 19 Oct 2020, at 11:59, Kuppuswamy, Sathyanarayanan wrote:
> > > On 10/19/20 11:31 AM, Sean V Kelley wrote:  
> > >> On 19 Oct 2020, at 3:49, Ethan Zhao wrote:
> > >>> On Sat, Oct 17, 2020 at 6:29 AM Bjorn Helgaas <helgaas@kernel.org> 
> > >>> wrote:  
> > >>>>
> > >>>> [+cc Christoph, Ethan, Sinan, Keith; sorry should have cc'd you to
> > >>>> begin with since you're looking at this code too. Particularly
> > >>>> interested in your thoughts about whether we should be touching
> > >>>> PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS when we don't own 
> > >>>> AER.]  
> > >>>
> > >>> aer_root_reset() function has a prefix  'aer_', looks like it's a
> > >>> function of aer driver, will
> > >>> only be called by aer driver at runtime. if so it's up to the
> > >>> owner/aer to know if OSPM is
> > >>> granted to init. while actually some of the functions and runtime 
> > >>> service of
> > >>> aer driver is also shared by GHES driver (running time) and DPC 
> > >>> driver
> > >>> (compiling time ?)
> > >>> etc. then it is confused now.
> > >>>
> > >>> Shall we move some of the shared functions and running time service 
> > >>> to
> > >>> pci/err.c ?
> > >>> if so , just like pcie_do_recovery(), it's share by firmware_first  
> > >>> mode GHES
> > >>> ghes_probe()  
> > >>> ->ghes_irq_func  
> > >>>   ->ghes_proc
> > >>>     ->ghes_do_proc()
> > >>>       ->ghes_handle_aer()
> > >>>         ->aer_recover_work_func()
> > >>>           ->pcie_do_recovery()
> > >>>             ->aer_root_reset()
> > >>>
> > >>> and aer driver etc.  if aer wants to do some access might conflict
> > >>> with firmware(or
> > >>> firmware in embedded controller) should check _OSC_ etc first. 
> > >>> blindly issue
> > >>> PCI_ERR_ROOT_COMMAND  or clear PCI_ERR_ROOT_STATUS *likely*
> > >>> cause errors by error handling itself.  
> > >>
> > >> If _OSC negotiation ends up with FW being in control of AER, that 
> > >> means OS is not in charge and should not be messing with AER I guess. 
> > >> That seems appropriate to me then.  
> > >
> > > But APEI based notification is more like a hybrid approach (frimware 
> > > first detects the
> > > error and notifies OS). Since spec does not clarify what OS is allowed 
> > > to do, its bit of a
> > > gray area now. My point is, since firmware allows OS to process the 
> > > error by sending
> > > the notification, I think its OK to clear the status once the error is 
> > > handled.  
> > 
> > I don’t disagree as long as AER is granted to the OS via _OSC. But if 
> > it’s not granted explicitly via _OSC even in the APEI case where 
> > it’s either an SCI or NMI and not an MSI, I’m unsure whether the OS 
> > should be touching those registers.
> 
> My assumption was indeed this.  If AER hasn't been granted to the OS,
> it shouldn't be doing anything involving AER itself.  It should constrain
> itself to dealing with the End Points etc due to the need there for
> driver interaction.
> 
> I fully agree with the comment that the specifications aren't entirely
> clear on these cases.
> 
> It is possible that no one is currently generating the particular
> combination of severity bits in the APEI path to actually hit this.
> It requires the outer record to be marked recoverable, but the inner
> part to be marked fatal.  Kind of an odd mix.
> 
> In the GHES case, you get to this path by having a
> Generic Error Status Block - recoverable (must not be fatal to avoid panic()
> in APEI layer) containing one more more Generic Error Blocks, one of
> which is fatal.
> 
> Response of our firmware team is that this particularly combination is
> probably crazy.

Thanks a lot for researching this and outlining these details.  I
hadn't worked all that out.  It makes me a lot less worried about
breaking something if we tweak this.

> So good to clean up this corner, but it is probably not a problem
> anyone has actually hit so far.

IMO if the OS has not been granted AER control via _OSC, it shouldn't
be touching these registers.  I don't want to speculate based on what
the intent might have been with APEI.  If the intent was that the OS
should write those registers even if it doesn't own the AER
capability, that could easily have been put in the spec.

IIUC APEI enables cases where the device with Root Error Command and
Root Error Status registers (or device-specific equivalents) is not
even visible to the OS.  In those cases the OS *cannot* fiddle with
them.

I assume APEI tells us about an error with an Endpoint.  I do not
think we should be groping around for an an upstream device and poking
things in it.  I'm not even 100% comfortable with the fact that we
find an upstream device and reset all devices below it.  Maybe that's
OK as a "bigger hammer," but I don't know about it being the default
approach.

I was hoping to get this series merged for v5.10, but I don't think
it's really practical to merge it at this stage with four days left in
the merge window.  When we do merge this, I propose tightening up
aer_root_reset() along these lines as preliminary patches, since this
has nothing to do with RCEC/RCiEP, and if they *do* cause any issues,
I don't want these patches to be implicated.

Bjorn
