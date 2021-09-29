Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34641CC21
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbhI2SwM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 14:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346078AbhI2SwM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 14:52:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 885B461502;
        Wed, 29 Sep 2021 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632941430;
        bh=HFsxaMSiLKNo+Dqe9i1EiJyv7r0mW/XFSQEuJWKpmKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bc+rhkx3e9OyCbRc8z8P41i56BEzbbf3Az7/Rv/+leYcYqHLlHavJZ7ByotZsfsak
         yzdN7caUlOIf2RWreenhJyJ5+HmHdyQK9l8UaBYcX4afz2Y3Crjc759sGWGTrLJKdI
         Oa0CfnuR1UpUCKiYJ+zFYQ1ypqH0UXa01EjXquwMzVj2ZovTWvaUrSvHVa1atPuiwu
         M/OK7CKHMSHckRe7VwbVZfzK+Bh2lpPxjXDsDBaYa5eCI2cyQvAIl0OKpUrrnQBMz/
         Z/az74mg9JcG6JAvZCyUTmmoyKFhfzEAG57kRMAxGhjG+SaAD5y1YLF7mXAHBb2nbP
         qXgLADAWCKe5Q==
Date:   Wed, 29 Sep 2021 13:50:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     David Jaundrew <david@jaundrew.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Message-ID: <20210929185029.GA790241@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210929122612.02e54434.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 12:26:12PM -0600, Alex Williamson wrote:
> On Tue, 28 Sep 2021 20:59:02 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > [+cc Alex, Krzysztof, AMD folks]
> > 
> > On Tue, Sep 28, 2021 at 05:16:49PM -0700, David Jaundrew wrote:
> > > This patch fixes another FLR bug for the Starship/Matisse controller:
> > > 
> > > AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
> > > 
> > > This patch allows functions on the same Starship/Matisse device (such as
> > > USB controller,sound card) to properly pass through to a guest OS using
> > > vfio-pc. Without this patch, the virtual machine does not boot and
> > > eventually times out.  
> > 
> > Apparently yet another AMD device that advertises FLR support, but it
> > doesn't work?
> > 
> > I don't have a problem avoiding the FLR, but I *would* like some
> > indication that:
> > 
> >   - This is a known erratum and AMD has some plan to fix this in
> >     future devices so we don't have to trip over them all
> >     individually, and
> > 
> >   - This is not a security issue.  Part of the reason VFIO resets
> >     pass-through devices is to avoid leaking state from one guest to
> >     another.  If reset doesn't work, that makes me wonder, especially
> >     since this is a cryptographic coprocessor that sounds like it
> >     might be full of secrets.  So I *assume* VFIO will use a different
> >     type of reset instead of FLR, but I'm just double-checking.
> 
> It depends on what's available, chances are not good that we have
> another means of function level reset, so this probably means it's
> exposed as-is.  I agree, not great for a device managing something to
> do with cryptography.  It's potentially a better security measure to
> let the device wedge itself.  Thanks,

OK, I think that means I need to ignore this patch until we have some
evidence that it's actually safe to allow VFIO to pass the device
through to another guest.

And I guess we are making the assumption that the audio, USB, and
ethernet controllers [1] are safe to hand off between guests?  I don't
know enough about those controllers to even have an opinion about
that.  Surely there is config space and MMIO space that could leak
data between guests?

Is there anything that tracks whether the device has been reset after
being passed through to a guest?  For example, I assume the following
would be safe if we could tell the reset had been done:

  - Pass through to guest A
  - Guest A exits
  - User resets all devices on bus (including this one)
  - Pass through to guest B

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c?id=v5.14#n5212

> > > Excerpt from lspci -nn showing crypto function on same device as USB and
> > > sound card (which are already listed in quirks.c):
> > > 
> > > 0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD]
> > >   Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
> > > 0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD]
> > >   Matisse USB 3.0 Host Controller [1022:149c]
> > > 0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD]
> > >   Starship/Matisse HD Audio Controller [1022:1487]
> > > 
> > > Fix tested successfully on an Asus ROG STRIX X570-E GAMING motherboard
> > > with AMD Ryzen 9 3900X.
> > > 
> > > Signed-off-by: David Jaundrew <david@jaundrew.com>  
> > 
> > The patch below still doesn't apply.  Looks like maybe it was pasted
> > into the email and the tabs got changed to space?  No worries, I can
> > apply it manually if appropriate.
> > 
> > > ---
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 6d74386eadc2..0d19e7aa219a 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5208,6 +5208,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> > >  /*
> > >   * FLR may cause the following to devices to hang:
> > >   *
> > > + * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
> > >   * AMD Starship/Matisse HD Audio Controller 0x1487
> > >   * AMD Starship USB 3.0 Host Controller 0x148c
> > >   * AMD Matisse USB 3.0 Host Controller 0x149c
> > > @@ -5219,6 +5220,7 @@ static void quirk_no_flr(struct pci_dev *dev)
> > >  {
> > >         dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
> > >  }
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486, quirk_no_flr);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
