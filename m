Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109021F70AD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 01:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFKXD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 19:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgFKXDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 19:03:25 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6CDF2075F;
        Thu, 11 Jun 2020 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591916605;
        bh=yM5pBJUy0BXOdjz4XMcr+tOSmSsPnlkkobonfqdzjSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D+qrXcCqbOyBxciiOWZgechHGVDuhy7PA3H6Zw/VkcKP/QvMh0ftEP2yKGml3S9kd
         09w1IeQULkDKinvROeRZPCVif1IFyJzDcFU8+jAJ4nKByZ1oX5ZQ1L9UVV+FlFvh4O
         kHK8XgBPGMoyp63Owk4z/DP0E1b4PenykufRuFt8=
Date:   Thu, 11 Jun 2020 18:03:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vijay Mohan Pandarathil <vijaymohan.pandarathil@hp.com>,
        Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH][v2] iommu: arm-smmu-v3: Copy SMMU table for kdump kernel
Message-ID: <20200611230323.GA1616315@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2QiJJ58nWe_vpjLWoFuM7s-7f7H-40q-4r-aGqorKPy9EPQw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 07, 2020 at 02:00:35PM +0530, Prabhakar Kushwaha wrote:
> On Thu, Jun 4, 2020 at 5:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jun 03, 2020 at 11:12:48PM +0530, Prabhakar Kushwaha wrote:
> > > On Sat, May 30, 2020 at 1:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, May 29, 2020 at 07:48:10PM +0530, Prabhakar Kushwaha wrote:
<snip>

> > > > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > > > index 117c0a2b2ba4..26b908f55aef 100644
> > > > > --- a/drivers/pci/pcie/err.c
> > > > > +++ b/drivers/pci/pcie/err.c
> > > > > @@ -66,6 +66,20 @@ static int report_error_detected(struct pci_dev *dev,
> > > > >                 if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> > > > >                         vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> > > > >                         pci_info(dev, "can't recover (no
> > > > > error_detected callback)\n");
> > > > > +
> > > > > +                       pci_save_state(dev);
> > > > > +                       pci_cfg_access_lock(dev);
> > > > > +
> > > > > +                       /* Quiesce the device completely */
> > > > > +                       pci_write_config_word(dev, PCI_COMMAND,
> > > > > +                             PCI_COMMAND_INTX_DISABLE);
> > > > > +                       if (!__pci_reset_function_locked(dev)) {
> > > > > +                               vote = PCI_ERS_RESULT_RECOVERED;
> > > > > +                               pci_info(dev, "recovered via pci level
> > > > > reset\n");
> > > > > +                       }
> >
> > So I guess we *do* need to save the state before the reset and restore
> > it (either that or enumerate the device from scratch just like we
> > would if it had been hot-added).  I'm not really thrilled with trying
> > to save the state after the device has already reported an error.  I'd
> > rather do it earlier, maybe during enumeration, like in
> > pci_init_capabilities().  But I don't understand all the subtleties of
> > dev->state_saved, so that requires some legwork.
> 
> I tried moving pci_save_state earlier. All observations are the same
> as mentioned in earlier discussions.

By "legwork", I didn't mean just trying things to see whether they
seem to work.  I meant researching the history to find out *why* it's
designed the way it is so that when we change it, we don't break
things.

For example, these commits are obviously important to understand:

  aa8c6c93747f ("PCI PM: Restore standard config registers of all devices early")
  c82f63e411f1 ("PCI: check saved state before restore")
  4b77b0a2ba27 ("PCI: Clear saved_state after the state has been restored")

I think we need to step back and separate this AER issue from the
whole SMMU table copying thing.  Then do the research and start a
new thread with a patch to fix just the AER issue.

The ARM guys would probably be grateful to be dropped from the AER
thread because it really has nothing to do with ARM.

Bjorn
